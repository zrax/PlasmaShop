# General Configuration
TEMPLATE = app
DEPENDPATH += .
INCLUDEPATH += .
CONFIG += release
DESTDIR = ../../bin
RC_FILE = res/PrpShop.rc

# Use libPlasma
INCLUDEPATH += ../../../Plasma/core
LIBS += -L../../../Plasma/bin -lPlasma

# PrpShop Sources
HEADERS += Main.h \
           QPlasmaUtils.h \
           QPlasmaTreeItem.h \
           PRP/QCreatable.h \
           PRP/QKeyList.h \
           PRP/QMatrix44.h \
           PRP/QObjLink.h \
           PRP/Object/QCoordinateInterface.h
SOURCES += Main.cpp \
           QPlasmaUtils.cpp \
           QPlasmaTreeItem.cpp \
           PRP/QCreatable.cpp \
           PRP/QKeyList.cpp \
           PRP/QMatrix44.cpp \
           PRP/QObjLink.cpp \
           PRP/Object/QCoordinateInterface.cpp
RESOURCES += images.qrc