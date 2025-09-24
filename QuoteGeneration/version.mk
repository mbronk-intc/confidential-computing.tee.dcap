#
# Copyright(c) 2025 Intel Corporation
# SPDX-License-Identifier: BSD-3-Clause
#

# -----------------------------------------------------------------------------
# Function : parent-dir
# Arguments: 1: path
# Returns  : Parent dir or path of $1, with final separator removed.
# -----------------------------------------------------------------------------
parent-dir = $(patsubst %/,%,$(dir $(1:%/=%)))

# -----------------------------------------------------------------------------
# Macro    : my-dir
# Returns  : the directory of the current Makefile
# Usage    : $(my-dir)
# -----------------------------------------------------------------------------
my-dir = $(call parent-dir,$(lastword $(MAKEFILE_LIST)))


ROOT_DIR              := $(call my-dir)
COMMON_DIR            := $(ROOT_DIR)/common

#--------------------------------------------------------------------------------------
# Function: get_full_version
# Arguments: 1: the version name of library
# Returns: Return the full version.
#---------------------------------------------------------------------------------------
get_full_version = $(shell awk '$$2 ~ /$1/ { print substr($$3, 2, length($$3) - 2); }' $(COMMON_DIR)/inc/internal/se_version.h)

#--------------------------------------------------------------------------------------
# Function: get_major_version
# Arguments: 1: the version name of library
# Returns: Return the major version.
#---------------------------------------------------------------------------------------
get_major_version = $(word 1,$(subst ., ,$(call get_full_version,$1)))

SGX_VER:= $(call get_full_version,STRFILEVER)
# Alias for SGX_VER - SGX_VER to be removed once all usages are migrated
DCAP_VER:= $(SGX_VER)
SGX_MAJOR_VER:= $(call get_major_version,STRFILEVER)
# Alias for SGX_MAJOR_VER - SGX_MAJOR_VER to be removed once all usages are migrated
DCAP_MAJOR_VER:= $(SGX_MAJOR_VER)