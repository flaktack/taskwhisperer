#!/usr/bin/make -f

# Copyright (C) 2018 Florijan Hamzic <fh[at]infinicode.de>
# This file is distributed under the same license as the stocks-extension package.

.PHONY: clean

EXTENSION_NAME := taskwhisperer-extension
UUID := $(EXTENSION_NAME)@infinicode.de
AUTHOR_MAIL := fh@infinicode.de

SRC_DIR := $(UUID)
ARTIFACT := $(UUID).shell-extension.zip
FILE_GLOBS := $(SRC_DIR)/*.js $(SRC_DIR)/*.ui $(SRC_DIR)/*.css $(SRC_DIR)/icons/*.svg $(SRC_DIR)/extra/*.sh

FILES := $(foreach file,$(wildcard $(FILE_GLOBS)),$(subst $(SRC_DIR)/,,$(file))) README.md

default: build

clean:
	test ! -e $(ARTIFACT) || rm $(ARTIFACT)

build: clean
	gnome-extensions pack                               \
	    $(foreach file,$(FILES),--extra-source=$(file)) \
	    $(SRC_DIR)

install: build
	gnome-extensions install $(ARTIFACT)

uninstall:
	gnome-extensions uninstall $(UUID)
