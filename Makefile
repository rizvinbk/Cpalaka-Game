COMPILER=G++

# todo: object files into output path, processing c / c++ files in the same time (?), nested directories for source files (?)
C = cpp
OUTPUT_PATH = out/production/Game3/ #Not Used. Executable at root folder itself
SOURCE_PATH = src/
EXE = Game3

ifeq ($(COMPILER), G++)
  ifeq ($(OS),Windows_NT)
    OBJ = obj
  else
    OBJ = o
  endif
  COPT = -O2
  CCMD = g++
  OBJFLAG = -o
  EXEFLAG = -o
# INCLUDES = -I../.includes
  INCLUDES = -Isrc/header
# LIBS = -lgc
  LIBS = -lBox2D -lsfml-graphics -lsfml-window -lsfml-system
# LIBPATH = -L../gc/.libs
  LIBPATH = -Lsrc/lib
  CPPFLAGS = $(COPT) -g -w -std=c++11 $(INCLUDES)
  LDFLAGS = $(LIBPATH) -g $(LIBS)
  DEP = dep
else
  OBJ = obj
  COPT = /O2
  CCMD = cl
  OBJFLAG = /Fo
  EXEFLAG = /Fe
# INCLUDES = /I..\\.includes
  INCLUDES =
# LIBS = ..\\.libs\\libgc.lib
  LIBS =
  CPPFLAGS = $(COPT) /DEBUG $(INCLUDES)
  LDFLAGS = /DEBUG
endif

OBJS := $(patsubst %.$(C),%.$(OBJ),$(wildcard $(SOURCE_PATH)*.$(C)))

%.$(OBJ):%.$(C)
	@echo Compiling $(basename $<)...
	$(CCMD) -c $(CPPFLAGS) $(CXXFLAGS) $< $(OBJFLAG)$@

all: $(OBJS)
	@echo Linking...
	$(CCMD) $(LDFLAGS) $^ $(LIBS) $(EXEFLAG) $(EXE)

clean:
	rm -rf $(SOURCE_PATH)*.$(OBJ) $(EXE)

rebuild: clean all
#rebuild is not entirely correct
