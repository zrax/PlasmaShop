set(PlasmaShop_MOC_Headers
    Main.h
    OptionsDialog.h
    GameBrowser.h
    GameScanner.h
    NewFile.h
    QPlasmaDocument.h
    QPlasmaTextDoc.h
    QPlasmaSumFile.h
    QPlasmaPakFile.h
)

set(PlasmaShop_Sources
    Main.cpp
    OptionsDialog.cpp
    GameBrowser.cpp
    GameScanner.cpp
    NewFile.cpp
    QPlasmaDocument.cpp
    QPlasmaTextDoc.cpp
    QPlasmaSumFile.cpp
    QPlasmaPakFile.cpp
)

# include pycdc sources
set(pycdc_SOURCE_DIR ${PROJECT_SOURCE_DIR}/pycdc)
set(pycdc_Sources
    ${pycdc_SOURCE_DIR}/ASTNode.cpp
    ${pycdc_SOURCE_DIR}/ASTree.cpp
    ${pycdc_SOURCE_DIR}/bytecode.cpp
    ${pycdc_SOURCE_DIR}/data.cpp
    ${pycdc_SOURCE_DIR}/pyc_code.cpp
    ${pycdc_SOURCE_DIR}/pyc_module.cpp
    ${pycdc_SOURCE_DIR}/pyc_numeric.cpp
    ${pycdc_SOURCE_DIR}/pyc_object.cpp
    ${pycdc_SOURCE_DIR}/pyc_sequence.cpp
    ${pycdc_SOURCE_DIR}/pyc_string.cpp
)
set(pycdc_Maps
    ${pycdc_SOURCE_DIR}/bytes/python_10.map
    ${pycdc_SOURCE_DIR}/bytes/python_11.map
    ${pycdc_SOURCE_DIR}/bytes/python_13.map
    ${pycdc_SOURCE_DIR}/bytes/python_14.map
    ${pycdc_SOURCE_DIR}/bytes/python_15.map
    ${pycdc_SOURCE_DIR}/bytes/python_16.map
    ${pycdc_SOURCE_DIR}/bytes/python_20.map
    ${pycdc_SOURCE_DIR}/bytes/python_21.map
    ${pycdc_SOURCE_DIR}/bytes/python_22.map
    ${pycdc_SOURCE_DIR}/bytes/python_23.map
    ${pycdc_SOURCE_DIR}/bytes/python_24.map
    ${pycdc_SOURCE_DIR}/bytes/python_25.map
    ${pycdc_SOURCE_DIR}/bytes/python_26.map
    ${pycdc_SOURCE_DIR}/bytes/python_27.map
    ${pycdc_SOURCE_DIR}/bytes/python_30.map
    ${pycdc_SOURCE_DIR}/bytes/python_31.map
    ${pycdc_SOURCE_DIR}/bytes/python_32.map
    ${pycdc_SOURCE_DIR}/bytes/python_33.map
)
set(pycdc_GeneratedSources
    ${pycdc_SOURCE_DIR}/bytes/python_10.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_11.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_13.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_14.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_15.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_16.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_20.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_21.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_22.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_23.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_24.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_25.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_26.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_27.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_30.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_31.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_32.cpp
    ${pycdc_SOURCE_DIR}/bytes/python_33.cpp
)
# run "make" in the pycdc folder to generate the source code
add_custom_command(OUTPUT ${pycdc_GeneratedSources}
                   COMMAND ./comp_map.py
                   DEPENDS ${pycdc_Maps} ${pycdc_SOURCE_DIR}/bytes/comp_map.py
                   WORKING_DIRECTORY ${pycdc_SOURCE_DIR}/bytes)

if(NOT WIN32 AND NOT APPLE)
    set(PlasmaShop_Sources "${PlasmaShop_Sources}"
        ../3rdParty/qticonloader.cpp
    )
endif()

if(WIN32)
    set(PlasmaShop_Sources ${PlasmaShop_Sources} res/PlasmaShop.rc)
endif()

find_package(Qt4 REQUIRED COMPONENTS QtCore QtGui QtMain)
include(${QT_USE_FILE})
# generate rules for building source files from the resources
qt4_add_resources(PlasmaShop_RCC images.qrc)
# generate rules for building source files that moc generates
qt4_wrap_cpp(PlasmaShop_MOC ${PlasmaShop_MOC_Headers})

include_directories("${PROJECT_SOURCE_DIR}/src/3rdParty")
include_directories("${PROJECT_SOURCE_DIR}/QScintilla/Qt4")
include_directories("${pycdc_SOURCE_DIR}")
include_directories("${HSPlasma_INCLUDE_DIRS}")

add_executable(PlasmaShop WIN32 MACOSX_BUNDLE
               ${PlasmaShop_Sources} ${pycdc_Sources} ${pycdc_GeneratedSources}
               ${PlasmaShop_MOC} ${PlasmaShop_RCC})
target_link_libraries(PlasmaShop qscintilla2-ps3 ${QT_LIBRARIES} HSPlasma)

if(WIN32)
    target_link_libraries(PlasmaShop shell32)
endif()

if(APPLE)
    set(MACOSX_BUNDLE true)
    set(MACOSX_BUNDLE_NAME PlasmaShop)
    set(MACOSX_BUNDLE_INFO_STRING "PlasmaShop 3.0 BETA")
    set(MACOSX_BUNDLE_LONG_VERSION_STRING "2.90")
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING "2.90")
    set(MACOSX_BUNDLE_COPYRIGHT "Copyright (C) 2011 Michael Hansen")
    #set(MACOSX_BUNDLE_ICON_FILE "PlamsaShop.icns")

    install(TARGETS PlasmaShop
            BUNDLE DESTINATION .
    )
elseif(WIN32)
    install(TARGETS PlasmaShop
            DESTINATION .
    )
else()
    install(TARGETS PlasmaShop
            DESTINATION bin
    )
endif()
