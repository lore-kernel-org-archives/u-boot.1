Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2264DC77B7F
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 18:57:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC1B181D5D;
	Fri, 27 Jun 2025 20:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nehVaRJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F2B82DA1; Fri, 27 Jun 2025 20:57:44 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81B0980C83
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 20:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ae0d758c3a2so377731066b.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751050655; x=1751655455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=00kMkm3zW7ULn6mwGUAWLdQ33dkSxnR9i/0T4lFMmv0=;
 b=nehVaRJyZ3lrMewVuLuZr7Qy2fR345XgtTIOzPhMiQ7BNLU0Ln3p7MnTE0imYu8pmt
 qUQ4q1ONYeiHNc+VnSjFVYXgXvBvBSagL3P7x3l02DyVcyh2NwjSDMDPf51j87H02RO0
 JAzElzTrk3vP6e1B19P1K/pDPoFxEA7jUz8Fkqec5nGOc5MYUb6EWZMZ+TMYuZv7XbLB
 zq1vP3w6IJkLLhubdgWEyIOGxosNHpZDyNWfcnXJyrq1PybIEz9rnLc5n9bW8qxOdc1T
 Wvm215eEx6/hCmTDwG9263i5ZWkr2Rk2JhpmZa4JEbNLf77Ey8O7TlJ8W57lVFllEZMz
 YF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751050655; x=1751655455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00kMkm3zW7ULn6mwGUAWLdQ33dkSxnR9i/0T4lFMmv0=;
 b=QNg2/DaJDlM8MtrzK6iHS01gpw07phX1HyQSpwUAMRh0WYSH0BSAr2WNZCI1vHAGba
 vb6b/N9vosP7hw/PK/fx+VNAcU3MeQLLaKohFI6ChzzKahs+fucZgt56Z8DSnRkyb/fG
 Lt58Dl6QPDD7MuBNvGR7eYfDpR8TmWHBv1pDb6ONxcHWwP/nSee/ukEGW5Jf3hPzuWuz
 a8WBMBoxdhSBZVK6+Hn7DhZ3bWbxVGeOwRt6iaPQM/LFsYDa0ikCUFvPioAghCskYTSN
 DlCUEMAn/gklA0H5jepYLxGHC0P7XwyvbjOYWvI1WXLbOGvfvzFu/deSLnyvCsRnqTL6
 K1YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa4AXvfFEfaJnNYnB+CcU0q68ThP+XAhqjGxf97/O1b+KNN9EcN7UaWCGe71o2XzkBKqWzSgU=@lists.denx.de
X-Gm-Message-State: AOJu0YziB3O41Fm+u4TQoPDo7ktNPleLXe2f2Ce3RqPDz6izOSQFLEzY
 1n9aJplWcT6A11inn0VDjLf2E3z0pPZNXOFS61opK4aj+wKne5Hk4cW2F9qM+qKQvMc=
X-Gm-Gg: ASbGnctKPCega+v/ldzcawp7cLQ5O4yOZUzVLqNZvB+OHSKxUGtHwPdtIZQ4YaBfcsV
 K3C8/xGxD8pLLeBAEGElNGv2ZQvy2+IQjH/JaGf+7FoXDyC323/sWuXd+Fno9VrSlr2d15W6aj+
 sHA4Vv0SANstO/qwE3n38ywcm5Pd36sLx7h5RcPhejj6jwdVFAgY3IkKgNudvR2jJfqRXEDW21d
 6/xfevtueG0L3mFa6Mmn9OC+5hbNJH6IjTCu09C60511wN88yHVsiA4KWFDBgyhbuxQ9zlb5erg
 nR9GJnOoDZ8W77bVtFhvb6UAIgCQC/PwUYzGtLJvJyQ50FNbk5mY34LZ/xeF5cMkQZh0mGz5DrP
 ivMu8oG5ieAVVQsiUajbse+zw1K+uCNI=
X-Google-Smtp-Source: AGHT+IHJ7kTKAWusUtGL1oJ3OmqMeK0Ztm3QNH2tUIjExZMwolNUn1ZFX92g17pPaS2sjFKtNofaIw==
X-Received: by 2002:a17:907:1c28:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae3500f2795mr436453166b.29.1751050654243; 
 Fri, 27 Jun 2025 11:57:34 -0700 (PDT)
Received: from hera.. (ppp089210105145.access.hol.gr. [89.210.105.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae353c6beb8sm173694766b.132.2025.06.27.11.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 11:57:33 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: sughosh.ganu@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Marek Vasut <marex@denx.de>,
 Olaf Mandel <o.mandel@menlosystems.com>,
 Minkyu Kang <mk7.kang@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michal Simek <michal.simek@amd.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] kbuild: Bump the build system to 5.1
Date: Fri, 27 Jun 2025 21:57:16 +0300
Message-ID: <20250627185723.342553-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
References: <20250627185723.342553-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Our last sync with the kernel was 5.1. Even that was a partial one
as some patches from 4.x kernels were already missing making the
transition to a modern kbuild infeasible.

We are so out of sync now, that tracking the patches and backporting
them one by one makes little sense and it's going to take ages.

This is an attempt to sync up Makefile[.lib/.kbuild].
Unfortunately due to sheer amount of patches this is not easy to review,
but that's what we decided during a community call.

One of the biggest changes is get rid of partial linking entirely and
build .a archives isntead of .o.
We diaviate from the kernel on that. Instead of calling a custom script
to create the archive symbol table, we call ar with rcTP (isntead of
rcSTP) since we want a resulting archive that's sauble with the linker.

The only affected platforms are PPC ones. Unfortunately I don't have any
of them around to test, but the objdump of the resulting files --
arch/powerpc/lib/built-in.[oa] looks identical.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

Changes since v1:
- Bring back -std=gnu11 which was accidentally dropped
- Don't simplify our 'silent' rules since they mame macOS builds always silent
 Makefile                        | 858 ++++++++++++++++++++------------
 board/congatec/common/Makefile  |   4 +-
 board/cssi/cmpc885/u-boot.lds   |   4 +-
 board/cssi/mcr3000/u-boot.lds   |   4 +-
 board/freescale/common/Makefile |   4 +-
 board/menlo/mx8menlo/Makefile   |   4 +-
 board/phytec/common/Makefile    |   4 +-
 board/samsung/origen/Makefile   |   4 +-
 board/samsung/smdkv310/Makefile |   4 +-
 board/toradex/common/Makefile   |   4 +-
 doc/api/linker_lists.rst        |   8 +-
 doc/develop/crash_dumps.rst     |   8 +-
 scripts/Makefile.build          | 284 ++++++++---
 scripts/Makefile.gcc-plugins    |  59 +++
 scripts/Makefile.kcov           |   9 +
 scripts/Makefile.lib            | 114 +++--
 scripts/Makefile.xpl            |   2 +-
 tools/buildman/builderthread.py |   2 +-
 18 files changed, 913 insertions(+), 467 deletions(-)
 create mode 100644 scripts/Makefile.gcc-plugins
 create mode 100644 scripts/Makefile.kcov

diff --git a/Makefile b/Makefile
index e60bbb01a004..db8d89587290 100644
--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,10 @@ NAME =
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.

+# That's our default target when none is given on the command line
+PHONY := _all
+_all:
+
 # Determine target architecture for the sandbox
 include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
@@ -41,7 +45,7 @@ undefine MK_ARCH
 # Most importantly: sub-Makefiles should only ever modify files in
 # their own directory. If in some directory we have a dependency on
 # a file in another dir (which doesn't happen often, but it's often
-# unavoidable when linking the built-in.o targets which finally
+# unavoidable when linking the built-in.a targets which finally
 # turn into vmlinux), we will call a sub make in that other dir, and
 # after that we are sure that everything which is in that other dir
 # is now up to date.
@@ -109,7 +113,6 @@ endif

 # If the user is running make -s (silent mode), suppress echoing of
 # commands
-
 ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
 ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
   quiet=silent_
@@ -137,8 +140,8 @@ export quiet Q KBUILD_VERBOSE
 # The O= assignment takes precedence over the KBUILD_OUTPUT environment
 # variable.

-# KBUILD_SRC is set on invocation of make in OBJ directory
-# KBUILD_SRC is not intended to be used by the regular user (for now)
+# KBUILD_SRC is not intended to be used by the regular user (for now),
+# it is set on invocation of make with KBUILD_OUTPUT or O= specified.

 # OK, Make called in directory where kernel src resides
 # Do we want to locate output files in a separate directory?
@@ -146,19 +149,15 @@ ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif

-# That's our default target when none is given on the command line
-PHONY := _all
-_all:
-
-# Cancel implicit rules on top Makefile
-$(CURDIR)/Makefile Makefile: ;
+ifneq ($(words $(subst :, ,$(CURDIR))), 1)
+  $(error main directory cannot contain spaces nor colons)
+endif

 ifneq ($(KBUILD_OUTPUT),)
-# Invoke a second make in the output directory, passing relevant variables
 # check that the output directory actually exists
 saved-output := $(KBUILD_OUTPUT)
 KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
-								&& /bin/pwd)
+								&& pwd)
 $(if $(KBUILD_OUTPUT),, \
      $(error failed to create output directory "$(saved-output)"))

@@ -169,6 +168,7 @@ $(if $(KBUILD_OUTPUT),, \
 # 'sub-make' below.
 MAKEFLAGS += --include-dir=$(CURDIR)

+need-sub-make := 1
 else

 # Do not print "Entering directory ..." at all for in-tree build.
@@ -176,19 +176,34 @@ MAKEFLAGS += --no-print-directory

 endif # ifneq ($(KBUILD_OUTPUT),)

+ifneq ($(filter 3.%,$(MAKE_VERSION)),)
+# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
+# We need to invoke sub-make to avoid implicit rules in the top Makefile.
+need-sub-make := 1
+# Cancel implicit rules for this Makefile.
+$(lastword $(MAKEFILE_LIST)): ;
+endif
+
 export sub_make_done := 1
+
+ifeq ($(need-sub-make),1)
+
 PHONY += $(MAKECMDGOALS) sub-make

 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 	@:

-sub-make: FORCE
+# Invoke a second make in the output directory, passing relevant variables
+sub-make:
 	$(Q)$(MAKE) \
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))

-else # sub_make_done
+endif # need-sub-make
+endif # sub_make_done
+
 # We process the rest of the Makefile if this is the final invocation of make
+ifeq ($(need-sub-make),)

 # Do not print "Entering directory ...",
 # but we want to display it when entering to the output directory
@@ -202,8 +217,8 @@ MAKEFLAGS += --no-print-directory
 # Use 'make C=2' to enable checking of *all* source files, regardless
 # of whether they are re-compiled or not.
 #
-# See the file "doc/sparse.txt" for more details, including
-# where to get the "sparse" utility.
+# See the file "Documentation/dev-tools/sparse.rst" for more details,
+# including where to get the "sparse" utility.

 ifeq ("$(origin C)", "command line")
   KBUILD_CHECKSRC = $(C)
@@ -216,6 +231,10 @@ endif
 # Old syntax make ... SUBDIRS=$PWD is still supported
 # Setting the environment variable KBUILD_EXTMOD take precedence
 ifdef SUBDIRS
+  $(warning ================= WARNING ================)
+  $(warning 'SUBDIRS' will be removed after Linux 5.3)
+  $(warning Please use 'M=' or 'KBUILD_EXTMOD' instead)
+  $(warning ==========================================)
   KBUILD_EXTMOD ?= $(SUBDIRS)
 endif

@@ -223,18 +242,6 @@ ifeq ("$(origin M)", "command line")
   KBUILD_EXTMOD := $(M)
 endif

-# If building an external module we do not care about the all: rule
-# but instead _all depend on modules
-PHONY += all
-ifeq ($(KBUILD_EXTMOD),)
-_all: all
-else
-_all: modules
-PHONY += prepare
-prepare:
-	$(cmd_crmodverdir)
-endif
-
 ifeq ($(KBUILD_SRC),)
         # building in the source tree
         srctree := .
@@ -246,132 +253,177 @@ else
                 srctree := $(KBUILD_SRC)
         endif
 endif
+
+export KBUILD_CHECKSRC KBUILD_EXTMOD KBUILD_SRC
+
 objtree		:= .
 src		:= $(srctree)
 obj		:= $(objtree)

-VPATH		:= $(srctree)$(if $(KBUILD_EXTMOD),:$(KBUILD_EXTMOD))
+VPATH		:= $(srctree)

 export srctree objtree VPATH

-# Make sure CDPATH settings don't interfere
-unexport CDPATH
+# To make sure we do not include .config for any of the *config targets
+# catch them early, and hand them over to scripts/kconfig/Makefile
+# It is allowed to specify more targets when calling make, including
+# mixing *config targets and build targets.
+# For example 'make oldconfig all'.
+# Detect when mixed targets is specified, and make a second invocation
+# of make so .config is not included in this case either (for *config).

-#########################################################################
+version_h := include/generated/version_autogenerated.h
+timestamp_h := include/generated/timestamp_autogenerated.h
+defaultenv_h := include/generated/defaultenv_autogenerated.h
+dt_h := include/generated/dt.h
+env_h := include/generated/environment.h

-HOSTARCH := $(shell uname -m | \
-	sed -e s/i.86/x86/ \
-	    -e s/sun4u/sparc64/ \
-	    -e s/arm.*/arm/ \
-	    -e s/sa110/arm/ \
-	    -e s/ppc64/powerpc/ \
-	    -e s/ppc/powerpc/ \
-	    -e s/macppc/powerpc/\
-	    -e s/sh.*/sh/)
+clean-targets := %clean mrproper cleandocs
+no-dot-config-targets := $(clean-targets) \
+			 clobber distclean \
+			 help %docs check% coccicheck \
+			 ubootversion backup tests check pcheck qcheck tcheck \
+			 pylint pylint_err _pip pip pip_test pip_release
+no-sync-config-targets := $(no-dot-config-targets) install %install \
+			   kernelrelease

-HOSTOS := $(shell uname -s | tr '[:upper:]' '[:lower:]' | \
-	    sed -e 's/\(cygwin\).*/cygwin/')
+config-targets  := 0
+mixed-targets   := 0
+dot-config      := 1
+may-sync-config := 1

-export	HOSTARCH HOSTOS
+ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
+	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
+		dot-config := 0
+	endif
+endif

-#########################################################################
+ifneq ($(filter $(no-sync-config-targets), $(MAKECMDGOALS)),)
+	ifeq ($(filter-out $(no-sync-config-targets), $(MAKECMDGOALS)),)
+		may-sync-config := 0
+	endif
+endif

-# set default to nothing for native builds
-ifeq ($(HOSTARCH),$(ARCH))
-CROSS_COMPILE ?=
+ifneq ($(KBUILD_EXTMOD),)
+	may-sync-config := 0
 endif

-KCONFIG_CONFIG	?= .config
-export KCONFIG_CONFIG
+ifeq ($(KBUILD_EXTMOD),)
+        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
+                config-targets := 1
+                ifneq ($(words $(MAKECMDGOALS)),1)
+                        mixed-targets := 1
+                endif
+        endif
+endif

-# SHELL used by kbuild
-CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
-	  else if [ -x /bin/bash ]; then echo /bin/bash; \
-	  else echo sh; fi ; fi)
+# For "make -j clean all", "make -j mrproper defconfig all", etc.
+ifneq ($(filter $(clean-targets),$(MAKECMDGOALS)),)
+        ifneq ($(filter-out $(clean-targets),$(MAKECMDGOALS)),)
+                mixed-targets := 1
+        endif
+endif

-HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS 2>/dev/null)
-HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
-HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
+# install and modules_install need also be processed one by one
+ifneq ($(filter install,$(MAKECMDGOALS)),)
+        ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
+	        mixed-targets := 1
+        endif
+endif

-HOSTCC       = cc
-HOSTCXX      = c++
-KBUILD_HOSTCFLAGS   := -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer \
-		$(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
-KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
-KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
-KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
+ifeq ($(mixed-targets),1)
+# ===========================================================================
+# We're called with mixed targets (*config and build targets).
+# Handle them one by one.

-# With the move to GCC 6, we have implicitly upgraded our language
-# standard to GNU11 (see https://gcc.gnu.org/gcc-5/porting_to.html).
-# Some Linux distributions (including RHEL7, SLES13, Debian 8) still
-# have older compilers as their default, so we make it explicit for
-# these that our host tools are GNU11 (i.e. C11 w/ GNU extensions).
-CSTD_FLAG := -std=gnu11
-KBUILD_HOSTCFLAGS += $(CSTD_FLAG)
+PHONY += $(MAKECMDGOALS) __build_one_by_one

-ifeq ($(HOSTOS),cygwin)
-KBUILD_HOSTCFLAGS	+= -ansi
-endif
+$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
+	@:

-# Mac OS X / Darwin's C preprocessor is Apple specific.  It
-# generates numerous errors and warnings.  We want to bypass it
-# and use GNU C's cpp.	To do this we pass the -traditional-cpp
-# option to the compiler.  Note that the -traditional-cpp flag
-# DOES NOT have the same semantics as GNU C's flag, all it does
-# is invoke the GNU preprocessor in stock ANSI/ISO C fashion.
-#
-# Apple's linker is similar, thanks to the new 2 stage linking
-# multiple symbol definitions are treated as errors, hence the
-# -multiply_defined suppress option to turn off this error.
-#
-ifeq ($(HOSTOS),darwin)
-# get major and minor product version (e.g. '10' and '6' for Snow Leopard)
-DARWIN_MAJOR_VERSION	:= $(shell sw_vers -productVersion | cut -f 1 -d '.')
-DARWIN_MINOR_VERSION	:= $(shell sw_vers -productVersion | cut -f 2 -d '.')
+__build_one_by_one:
+	$(Q)set -e; \
+	for i in $(MAKECMDGOALS); do \
+		$(MAKE) -f $(srctree)/Makefile $$i; \
+	done

-os_x_before	= $(shell if [ $(DARWIN_MAJOR_VERSION) -le $(1) -a \
-	$(DARWIN_MINOR_VERSION) -le $(2) ] ; then echo "$(3)"; else echo "$(4)"; fi ;)
+else

-os_x_after = $(shell if [ $(DARWIN_MAJOR_VERSION) -ge $(1) -a \
-	$(DARWIN_MINOR_VERSION) -ge $(2) ] ; then echo "$(3)"; else echo "$(4)"; fi ;)
+include scripts/Kbuild.include

-# Snow Leopards build environment has no longer restrictions as described above
-HOSTCC       = $(call os_x_before, 10, 5, "cc", "gcc")
-KBUILD_HOSTCFLAGS  += $(call os_x_before, 10, 4, "-traditional-cpp")
-KBUILD_HOSTLDFLAGS += $(call os_x_before, 10, 5, "-multiply_defined suppress")
+# Read UBOOTRELEASE from include/config/uboot.release (if it exists)
+UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
+UBOOTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
+export VERSION PATCHLEVEL SUBLEVEL UBOOTRELEASE UBOOTVERSION

-# macOS Mojave (10.14.X)
-# Undefined symbols for architecture x86_64: "_PyArg_ParseTuple"
-KBUILD_HOSTLDFLAGS += $(call os_x_after, 10, 14, "-lpython -dynamclib", "")
-endif
+# Modified for U-Boot
+-include scripts/subarch.include

-# Decide whether to build built-in, modular, or both.
-# Normally, just do built-in.
+# Cross compiling and selecting different set of gcc/bin-utils
+# ---------------------------------------------------------------------------
+#
+# When performing cross compilation for other architectures ARCH shall be set
+# to the target architecture. (See arch/* for the possibilities).
+# ARCH can be set during invocation of make:
+# make ARCH=ia64
+# Another way is to have ARCH set in the environment.
+# The default ARCH is the host where make is executed.

-KBUILD_MODULES :=
-KBUILD_BUILTIN := 1
+# CROSS_COMPILE specify the prefix used for all executables used
+# during compilation. Only gcc and related bin-utils executables
+# are prefixed with $(CROSS_COMPILE).
+# CROSS_COMPILE can be set on the command line
+# make CROSS_COMPILE=ia64-linux-
+# Alternatively CROSS_COMPILE can be set in the environment.
+# Default value for CROSS_COMPILE is not to prefix executables
+# Note: Some architectures assign CROSS_COMPILE in their arch/*/Makefile
+ARCH		?= $(SUBARCH)

-# If we have only "make modules", don't compile built-in objects.
-# When we're building modules with modversions, we need to consider
-# the built-in objects during the descend as well, in order to
-# make sure the checksums are up to date before we record them.
+# Architecture as present in compile.h
+UTS_MACHINE 	:= $(ARCH)
+SRCARCH 	:= $(ARCH)

-ifeq ($(MAKECMDGOALS),modules)
-  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
+# Additional ARCH settings for x86
+ifeq ($(ARCH),i386)
+        SRCARCH := x86
+endif
+ifeq ($(ARCH),x86_64)
+        SRCARCH := x86
 endif

-# If we have "make <whatever> modules", compile modules
-# in addition to whatever we do anyway.
-# Just "make" or "make all" shall build modules as well
+# Additional ARCH settings for sparc
+ifeq ($(ARCH),sparc32)
+       SRCARCH := sparc
+endif
+ifeq ($(ARCH),sparc64)
+       SRCARCH := sparc
+endif

-# U-Boot does not need modules
-#ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
-#  KBUILD_MODULES := 1
-#endif
+# Additional ARCH settings for sh
+ifeq ($(ARCH),sh64)
+       SRCARCH := sh
+endif

-#ifeq ($(MAKECMDGOALS),)
-#  KBUILD_MODULES := 1
-#endif
+KCONFIG_CONFIG	?= .config
+export KCONFIG_CONFIG
+
+# SHELL used by kbuild
+CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
+	  else if [ -x /bin/bash ]; then echo /bin/bash; \
+	  else echo sh; fi ; fi)
+
+HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS 2>/dev/null)
+HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
+HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
+
+HOSTCC       = gcc
+HOSTCXX      = g++
+KBUILD_HOSTCFLAGS   := -Wall -Wstrict-prototypes -O2 \
+		-fomit-frame-pointer -std=gnu11 $(HOST_LFS_CFLAGS) \
+		$(HOSTCFLAGS) #-Wmissing-prototypes Enable it and fix warnings
+KBUILD_HOSTCXXFLAGS := -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
+KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
+KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)

 # Check ths size of a binary:
 # Args:
@@ -393,19 +445,9 @@ export size_check
 export KBUILD_MODULES KBUILD_BUILTIN
 export KBUILD_CHECKSRC KBUILD_SRC KBUILD_EXTMOD

-# We need some generic definitions (do not try to remake the file).
-scripts/Kbuild.include: ;
-include scripts/Kbuild.include
-
 # Make variables (CC, etc...)
-
 AS		= $(CROSS_COMPILE)as
-# Always use GNU ld
-ifneq ($(shell $(CROSS_COMPILE)ld.bfd -v 2> /dev/null),)
-LD		= $(CROSS_COMPILE)ld.bfd
-else
 LD		= $(CROSS_COMPILE)ld
-endif
 CC		= $(CROSS_COMPILE)gcc
 CPP		= $(CC) -E
 AR		= $(CROSS_COMPILE)ar
@@ -418,10 +460,12 @@ READELF		= $(CROSS_COMPILE)readelf
 LEX		= flex
 YACC		= bison
 AWK		= awk
+INSTALLKERNEL  := installkernel
+DEPMOD		= /sbin/depmod
 PERL		= perl
-PYTHON		?= python
+PYTHON		= python
 PYTHON2		= python2
-PYTHON3		?= python3
+PYTHON3		= python3

 # The devicetree compiler and pylibfdt are automatically built unless DTC is
 # provided. If DTC is provided, it is assumed the pylibfdt is available too.
@@ -432,51 +476,79 @@ DTC_MIN_VERSION	:= 010406
 CHECK		= sparse

 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-		  -Wbitwise -Wno-return-void -Wno-unknown-attribute \
-		  -D__CHECK_ENDIAN__ $(CF)
+		  -Wbitwise -Wno-return-void -Wno-unknown-attribute -D__CHECK_ENDIAN__ $(CF)
+NOSTDINC_FLAGS :=
+CFLAGS_MODULE   =
+AFLAGS_MODULE   =
+LDFLAGS_MODULE  =
+CFLAGS_KERNEL	=
+AFLAGS_KERNEL	=
+LDFLAGS_vmlinux =
+
+# Use USERINCLUDE when you must reference the UAPI directories only.
+USERINCLUDE    := \
+		-I$(srctree)/arch/$(SRCARCH)/include/uapi \
+		-I$(objtree)/arch/$(SRCARCH)/include/generated/uapi \
+		-I$(srctree)/include/uapi \
+		-I$(objtree)/include/generated/uapi \
+                -include $(srctree)/include/linux/kconfig.h

-KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
-
-KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
-		   -Wno-format-security \
-		   -fno-builtin -ffreestanding $(CSTD_FLAG) \
-		   -fno-PIE \
-		   -Werror=implicit-function-declaration -Werror=implicit-int
-KBUILD_CFLAGS	+= -fshort-wchar -fno-strict-aliasing
-KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_LDFLAGS  :=
-
-ifeq ($(cc-name),clang)
-ifneq ($(CROSS_COMPILE),)
-CLANG_TARGET	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-LDPPFLAGS	+= $(CLANG_TARGET)
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
-CLANG_PREFIX	:= --prefix=$(GCC_TOOLCHAIN_DIR)
-GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
-endif
-ifneq ($(GCC_TOOLCHAIN),)
-CLANG_GCC_TC	:= --gcc-toolchain=$(GCC_TOOLCHAIN)
-endif
-KBUILD_CFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_AFLAGS += $(CLANG_TARGET) $(CLANG_GCC_TC) $(CLANG_PREFIX)
-KBUILD_CFLAGS += $(call cc-option, -no-integrated-as)
-KBUILD_AFLAGS += $(call cc-option, -no-integrated-as)
-endif
-
-# Read UBOOTRELEASE from include/config/uboot.release (if it exists)
-UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
-UBOOTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SUBLEVEL)))$(EXTRAVERSION)
+# Use UBOOTINCLUDE when you must reference the include/ directory.
+# Needed to be compatible with the O= option
+UBOOTINCLUDE    := \
+	-Iinclude \
+	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(CONFIG_$(XPL_)MBEDTLS_LIB), \
+		"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+		-I$(srctree)/lib/mbedtls \
+		-I$(srctree)/lib/mbedtls/port \
+		-I$(srctree)/lib/mbedtls/external/mbedtls \
+		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
+	$(if $(CONFIG_$(PHASE_)SYS_THUMB_BUILD), \
+		$(if $(CONFIG_HAS_THUMB2), \
+			$(if $(CONFIG_CPU_V7M), \
+				-I$(srctree)/arch/arm/thumb1/include), \
+			-I$(srctree)/arch/arm/thumb1/include)) \
+	-I$(srctree)/arch/$(ARCH)/include \
+	-include $(srctree)/include/linux/kconfig.h \
+	-I$(srctree)/dts/upstream/include \
+	$(if $(CONFIG_NET_LWIP), -I$(srctree)/lib/lwip/lwip/src/include \
+		-I$(srctree)/lib/lwip/u-boot)

-export VERSION PATCHLEVEL SUBLEVEL UBOOTRELEASE UBOOTVERSION
-export ARCH CPU BOARD VENDOR SOC CPUDIR BOARDDIR
-export CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
-export CPP AR NM LDR STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
-export MAKE LEX YACC AWK PERL PYTHON PYTHON2 PYTHON3
-export HOSTCXX KBUILD_HOSTCXXFLAGS CHECK CHECKFLAGS DTC DTC_FLAGS

-export KBUILD_CPPFLAGS NOSTDINC_FLAGS UBOOTINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
-export KBUILD_CFLAGS KBUILD_AFLAGS
+KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
+KBUILD_CFLAGS   := -Wall -Werror=strict-prototypes -Wno-trigraphs \
+		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
+		   -Werror=implicit-function-declaration -Werror=implicit-int \
+		   -Wno-format-security -std=gnu11 #-Wundef Enable it and fix warnings
+UBOOT_CFLAGS	:= -ffreestanding -fno-builtin
+KBUILD_CFLAGS	+= $(UBOOT_CFLAGS)

+KBUILD_CPPFLAGS := -D__KERNEL__ -D__UBOOT__
+KBUILD_AFLAGS_KERNEL :=
+KBUILD_CFLAGS_KERNEL :=
+KBUILD_AFLAGS_MODULE  := -DMODULE
+KBUILD_CFLAGS_MODULE  := -DMODULE
+KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
+KBUILD_LDFLAGS :=
+GCC_PLUGINS_CFLAGS :=
+
+export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
+export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
+export MAKE LEX YACC AWK INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
+export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS
+
+export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
+export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
+export CFLAGS_KASAN CFLAGS_KASAN_NOSANITIZE CFLAGS_UBSAN
+export KBUILD_AFLAGS AFLAGS_KERNEL AFLAGS_MODULE
+export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
+export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
+export KBUILD_ARFLAGS
+
+export LDR
+export CPU BOARD VENDOR SOC CPUDIR BOARDDIR
+export UBOOTINCLUDE
 export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)

 # When compiling out-of-tree modules, put MODVERDIR in the module
@@ -504,15 +576,12 @@ endif
 # ===========================================================================
 # Rules shared between *config targets and build targets

-# Basic helpers built in scripts/
+# Basic helpers built in scripts/basic/
 PHONY += scripts_basic
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
 	$(Q)rm -f .tmp_quiet_recordmcount

-# To avoid any implicit rule to kick in, define an empty command.
-scripts/basic/%: scripts_basic ;
-
 PHONY += outputmakefile
 # outputmakefile generates a Makefile in the output directory, if using a
 # separate output directory. This allows convenient use of make in the
@@ -524,71 +593,51 @@ ifneq ($(KBUILD_SRC),)
 	$(Q)ln -fsn $(srctree) source
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
 	$(Q)test -e .gitignore || \
-       	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
+	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif

-# To make sure we do not include .config for any of the *config targets
-# catch them early, and hand them over to scripts/kconfig/Makefile
-# It is allowed to specify more targets when calling make, including
-# mixing *config targets and build targets.
-# For example 'make oldconfig all'.
-# Detect when mixed targets is specified, and make a second invocation
-# of make so .config is not included in this case either (for *config).
-
-version_h := include/generated/version_autogenerated.h
-timestamp_h := include/generated/timestamp_autogenerated.h
-defaultenv_h := include/generated/defaultenv_autogenerated.h
-dt_h := include/generated/dt.h
-env_h := include/generated/environment.h
-
-no-dot-config-targets := clean clobber mrproper distclean \
-			 help %docs check% coccicheck \
-			 ubootversion backup tests check pcheck qcheck tcheck \
-			 pylint pylint_err _pip pip pip_test pip_release
-
-config-targets := 0
-mixed-targets  := 0
-dot-config     := 1
-
-ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
-	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
-		dot-config := 0
-	endif
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
+ifneq ($(CROSS_COMPILE),)
+CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
+GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-
-ifeq ($(KBUILD_EXTMOD),)
-        ifneq ($(filter config %config,$(MAKECMDGOALS)),)
-                config-targets := 1
-                ifneq ($(words $(MAKECMDGOALS)),1)
-                        mixed-targets := 1
-                endif
-        endif
+ifneq ($(GCC_TOOLCHAIN),)
+CLANG_FLAGS	+= --gcc-toolchain=$(GCC_TOOLCHAIN)
+endif
+CLANG_FLAGS	+= -no-integrated-as
+KBUILD_CFLAGS	+= $(CLANG_FLAGS)
+KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+export CLANG_FLAGS
 endif

-ifeq ($(mixed-targets),1)
-# ===========================================================================
-# We're called with mixed targets (*config and build targets).
-# Handle them one by one.
-
-PHONY += $(MAKECMDGOALS) __build_one_by_one
-
-$(filter-out __build_one_by_one, $(MAKECMDGOALS)): __build_one_by_one
-	@:
+RETPOLINE_CFLAGS_GCC := -mindirect-branch=thunk-extern -mindirect-branch-register
+RETPOLINE_VDSO_CFLAGS_GCC := -mindirect-branch=thunk-inline -mindirect-branch-register
+RETPOLINE_CFLAGS_CLANG := -mretpoline-external-thunk
+RETPOLINE_VDSO_CFLAGS_CLANG := -mretpoline
+RETPOLINE_CFLAGS := $(call cc-option,$(RETPOLINE_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_CFLAGS_CLANG)))
+RETPOLINE_VDSO_CFLAGS := $(call cc-option,$(RETPOLINE_VDSO_CFLAGS_GCC),$(call cc-option,$(RETPOLINE_VDSO_CFLAGS_CLANG)))
+export RETPOLINE_CFLAGS
+export RETPOLINE_VDSO_CFLAGS

-__build_one_by_one:
-	$(Q)set -e; \
-	for i in $(MAKECMDGOALS); do \
-		$(MAKE) -f $(srctree)/Makefile $$i; \
-	done
+# The expansion should be delayed until arch/$(SRCARCH)/Makefile is included.
+# Some architectures define CROSS_COMPILE in arch/$(SRCARCH)/Makefile.
+# CC_VERSION_TEXT is referenced from Kconfig (so it needs export),
+# and from include/config/auto.conf.cmd to detect the compiler upgrade.
+CC_VERSION_TEXT = $(shell $(CC) --version | head -n 1)

-else
 ifeq ($(config-targets),1)
 # ===========================================================================
 # *config targets only - make sure prerequisites are updated, and descend
 # in scripts/kconfig to make the *config target

-KBUILD_DEFCONFIG := sandbox_defconfig
-export KBUILD_DEFCONFIG KBUILD_KCONFIG
+# Read arch specific Makefile to set KBUILD_DEFCONFIG as needed.
+# KBUILD_DEFCONFIG may point out an alternative default configuration
+# used for 'make defconfig'
+# Modified for U-Boot
+-include arch/$(SRCARCH)/Makefile
+export KBUILD_DEFCONFIG KBUILD_KCONFIG CC_VERSION_TEXT

 config: scripts_basic outputmakefile FORCE
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
@@ -601,29 +650,104 @@ else
 # Build targets only - this includes vmlinux, arch specific targets, clean
 # targets and others. In general all targets except *config targets.

-# Additional helpers built in scripts/
-# Carefully list dependencies so we do not try to build scripts twice
-# in parallel
-PHONY += scripts
-scripts: scripts_basic scripts_dtc include/config/auto.conf
-	$(Q)$(MAKE) $(build)=$(@)
+# If building an external module we do not care about the all: rule
+# but instead _all depend on modules
+PHONY += all
+ifeq ($(KBUILD_EXTMOD),)
+_all: all
+else
+_all: modules
+endif
+
+# Decide whether to build built-in, modular, or both.
+# Normally, just do built-in.
+
+KBUILD_MODULES :=
+KBUILD_BUILTIN := 1
+
+# If we have only "make modules", don't compile built-in objects.
+# When we're building modules with modversions, we need to consider
+# the built-in objects during the descend as well, in order to
+# make sure the checksums are up to date before we record them.
+
+ifeq ($(MAKECMDGOALS),modules)
+  KBUILD_BUILTIN := $(if $(CONFIG_MODVERSIONS),1)
+endif
+
+# If we have "make <whatever> modules", compile modules
+# in addition to whatever we do anyway.
+# Just "make" or "make all" shall build modules as well
+
+ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
+  KBUILD_MODULES := 1
+endif
+
+ifeq ($(MAKECMDGOALS),)
+  KBUILD_MODULES := 1
+endif
+
+export KBUILD_MODULES KBUILD_BUILTIN
+
+ifeq ($(KBUILD_EXTMOD),)
+# Objects we will link into vmlinux / subdirs we need to visit
+init-y		:= init/
+drivers-y	:= drivers/ sound/
+net-y		:= net/
+libs-y		:= lib/
+core-y		:= usr/
+virt-y		:= virt/
+endif # KBUILD_EXTMOD

 ifeq ($(dot-config),1)
-# Read in config
+# Modified for U-Boot
 -include include/config/auto.conf
+endif
+
+# The all: target is the default when no target is given on the
+# command line.
+# This allow a user to issue only 'make' to build a kernel including modules
+# Defaults to vmlinux, but the arch makefile usually adds further targets
+all: u-boot

-# Read in dependencies to all Kconfig* files, make sure to run
-# oldconfig if changes are detected.
+CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage \
+	$(call cc-option,-fno-tree-loop-im) \
+	$(call cc-disable-warning,maybe-uninitialized,)
+export CFLAGS_GCOV
+
+# The arch Makefiles can override CC_FLAGS_FTRACE. We may also append it later.
+ifdef CONFIG_FUNCTION_TRACER
+  CC_FLAGS_FTRACE := -pg
+endif
+
+# The arch Makefile can set ARCH_{CPP,A,C}FLAGS to override the default
+# values of the respective KBUILD_* variables
+ARCH_CPPFLAGS :=
+ARCH_AFLAGS :=
+ARCH_CFLAGS :=
+# Modified for U-Boot
+-include arch/$(SRCARCH)/Makefile
+
+ifeq ($(dot-config),1)
+ifeq ($(may-sync-config),1)
+# Read in dependencies to all Kconfig* files, make sure to run syncconfig if
+# changes are detected. This should be included after arch/$(SRCARCH)/Makefile
+# because some architectures define CROSS_COMPILE there.
 -include include/config/auto.conf.cmd

-# To avoid any implicit rule to kick in, define an empty command
-$(KCONFIG_CONFIG) include/config/auto.conf.cmd: ;
+$(KCONFIG_CONFIG):
+	@echo >&2 '***'
+	@echo >&2 '*** Configuration file "$@" not found!'
+	@echo >&2 '***'
+	@echo >&2 '*** Please run some configurator (e.g. "make oldconfig" or'
+	@echo >&2 '*** "make menuconfig" or "make xconfig").'
+	@echo >&2 '***'
+	@/bin/false

 # If .config is newer than include/config/auto.conf, someone tinkered
 # with it and forgot to run make oldconfig.
 # if auto.conf.cmd is missing then we are probably in a cleaned tree so
 # we execute the config step to be sure to catch updated Kconfig files
-include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
+include/config/%.conf: $(KCONFIG_CONFIG) #include/config/auto.conf.cmd
 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
 	@# If the following part fails, include/config/auto.conf should be
 	@# deleted so "make silentoldconfig" will be re-run on the next build.
@@ -698,10 +822,30 @@ ifndef LDSCRIPT
 endif

 else
-# Dummy target needed, because used as prerequisite
-include/config/auto.conf: ;
+# External modules and some install targets need include/generated/autoconf.h
+# and include/config/auto.conf but do not care if they are up-to-date.
+# Use auto.conf to trigger the test
+PHONY += include/config/auto.conf
+
+include/config/auto.conf:
+	$(Q)test -e include/generated/autoconf.h -a -e $@ || (		\
+	echo >&2;							\
+	echo >&2 "  ERROR: Kernel configuration is invalid.";		\
+	echo >&2 "         include/generated/autoconf.h or $@ are missing.";\
+	echo >&2 "         Run 'make oldconfig && make prepare' on kernel src to fix it.";	\
+	echo >&2 ;							\
+	/bin/false)
+
+endif # may-sync-config
 endif # $(dot-config)

+KBUILD_CFLAGS	+= $(call cc-option,-fno-delete-null-pointer-checks,)
+KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, address-of-packed-member)
+
 ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
 KBUILD_HOSTCFLAGS   := -Wall -Wstrict-prototypes -Og -g -fomit-frame-pointer \
 		$(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
@@ -721,19 +865,19 @@ endif

 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= -Os
+else
+KBUILD_CFLAGS   += -O2
 endif

-ifdef CONFIG_CC_OPTIMIZE_FOR_SPEED
-KBUILD_CFLAGS	+= -O2
+ifdef CONFIG_CC_DISABLE_WARN_MAYBE_UNINITIALIZED
+KBUILD_CFLAGS   += -Wno-maybe-uninitialized
 endif

-ifdef CONFIG_CC_OPTIMIZE_FOR_DEBUG
-KBUILD_CFLAGS	+= -Og
-# Avoid false positives -Wmaybe-uninitialized
-# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=78394
-KBUILD_CFLAGS	+= -Wno-maybe-uninitialized
-endif
+# Tell gcc to never replace conditional load with a non-conditional one
+KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)

+include scripts/Makefile.kcov
+include scripts/Makefile.gcc-plugins
 LTO_CFLAGS :=
 LTO_FINAL_LDFLAGS :=
 export LTO_CFLAGS LTO_FINAL_LDFLAGS
@@ -768,12 +912,6 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 endif
 KBUILD_CFLAGS += $(call cc-option,-fno-delete-null-pointer-checks)

-# disable pointer signed / unsigned warnings in gcc 4.0
-KBUILD_CFLAGS += -Wno-pointer-sign
-
-# disable stringop warnings in gcc 8+
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
-
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
@@ -813,6 +951,11 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
 KBUILD_CFLAGS += $(call cc-option, -fcatch-undefined-behavior)
 KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
+else
+
+# These warnings generated too much noise in a regular build.
+# Use make W=1 to enable them (see scripts/Makefile.extrawarn)
+KBUILD_CFLAGS += -Wno-unused-but-set-variable
 endif

 # These warnings generated too much noise in a regular build.
@@ -864,6 +1007,7 @@ cpp_flags := $(KBUILD_CPPFLAGS) $(PLATFORM_CPPFLAGS) $(UBOOTINCLUDE) \
 							$(NOSTDINC_FLAGS)
 c_flags := $(KBUILD_CFLAGS) $(cpp_flags)

+
 #########################################################################
 # U-Boot objects....order is important (i.e. start must be first)

@@ -912,7 +1056,15 @@ u-boot-dirs	:= $(patsubst %/,%,$(filter %/, $(libs-y))) tools examples

 u-boot-alldirs	:= $(sort $(u-boot-dirs) $(patsubst %/,%,$(filter %/, $(libs-))))

-libs-y		:= $(patsubst %/, %/built-in.o, $(libs-y))
+libs-y		:= $(patsubst %/, %/built-in.a, $(libs-y))
+# Not needed in U-Boot
+#init-y		:= $(patsubst %/, %/built-in.a, $(init-y))
+#core-y		:= $(patsubst %/, %/built-in.a, $(core-y))
+drivers-y	:= $(patsubst %/, %/built-in.a, $(drivers-y))
+#net-y		:= $(patsubst %/, %/built-in.a, $(net-y))
+libs-y1	:= $(patsubst %/, %/lib.a, $(libs-y))
+libs-y2	:= $(patsubst %/, %/built-in.a, $(filter-out %.a, $(libs-y)))
+#virt-y		:= $(patsubst %/, %/built-in.a, $(virt-y))

 u-boot-init := $(head-y)
 u-boot-main := $(libs-y)
@@ -1031,6 +1183,37 @@ INPUTS-$(CONFIG_ARCH_MEDIATEK) += u-boot-mtk.bin
 endif
 endif

+ifdef CONFIG_FUNCTION_TRACER
+ifdef CONFIG_FTRACE_MCOUNT_RECORD
+  # gcc 5 supports generating the mcount tables directly
+  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
+    CC_FLAGS_FTRACE	+= -mrecord-mcount
+    export CC_USING_RECORD_MCOUNT := 1
+  endif
+  ifdef CONFIG_HAVE_NOP_MCOUNT
+    ifeq ($(call cc-option-yn, -mnop-mcount),y)
+      CC_FLAGS_FTRACE	+= -mnop-mcount
+      CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+    endif
+  endif
+endif
+ifdef CONFIG_HAVE_FENTRY
+  ifeq ($(call cc-option-yn, -mfentry),y)
+    CC_FLAGS_FTRACE	+= -mfentry
+    CC_FLAGS_USING	+= -DCC_USING_FENTRY
+  endif
+endif
+export CC_FLAGS_FTRACE
+KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
+KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
+ifdef CONFIG_DYNAMIC_FTRACE
+	ifdef CONFIG_HAVE_C_RECORDMCOUNT
+		BUILD_C_RECORDMCOUNT := y
+		export BUILD_C_RECORDMCOUNT
+	endif
+endif
+endif
+
 # Add optional build target if defined in board/cpu/soc headers
 ifneq ($(CONFIG_BUILD_TARGET),)
 INPUTS-y += $(CONFIG_BUILD_TARGET:"%"=%)
@@ -1076,6 +1259,15 @@ quiet_cmd_objcopy = OBJCOPY $@
 cmd_objcopy = $(OBJCOPY) --gap-fill=0xff $(OBJCOPYFLAGS) \
 	$(OBJCOPYFLAGS_$(@F)) $< $@

+# disable pointer signed / unsigned warnings in gcc 4.0
+KBUILD_CFLAGS += -Wno-pointer-sign
+
+# disable stringop warnings in gcc 8+
+KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
+
+# disable invalid "can't wrap" optimizations for signed / pointers
+KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
+
 # Provide a version which does not do this, for use by EFI and hex/srec
 quiet_cmd_zobjcopy = OBJCOPY $@
 cmd_zobjcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
@@ -1927,7 +2119,7 @@ $(sort $(u-boot-init) $(u-boot-main)): $(u-boot-dirs) ;

 PHONY += $(u-boot-dirs)
 $(u-boot-dirs): prepare
-	$(Q)$(MAKE) $(build)=$@
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1

 tools: prepare
 # The "tools" are needed early
@@ -1946,7 +2138,12 @@ endef
 # Store (new) UBOOTRELEASE string in include/config/uboot.release
 include/config/uboot.release: include/config/auto.conf FORCE
 	$(call filechk,uboot.release)
-
+# Additional helpers built in scripts/
+# Carefully list dependencies so we do not try to build scripts twice
+# in parallel
+PHONY += scripts
+scripts: scripts_basic scripts_dtc
+	$(Q)$(MAKE) $(build)=$(@)

 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare".
@@ -1954,7 +2151,6 @@ include/config/uboot.release: include/config/auto.conf FORCE
 # archprepare is used in arch Makefiles and when processed asm symlink,
 # version.h and scripts_basic is processed / created.

-# Listed in dependency order
 PHONY += prepare archprepare prepare1 prepare3

 # prepare3 is used to check if we are building in a separate output directory,
@@ -1982,14 +2178,35 @@ prepare1: $(defaultenv_h)

 envtools: $(defaultenv_h)
 endif
-
 archprepare: prepare1 scripts

-prepare0: archprepare FORCE
+prepare0: archprepare
 	$(Q)$(MAKE) $(build)=.

 # All the preparing..
-prepare: prepare0
+prepare: prepare0 prepare-objtool
+
+# Support for using generic headers in asm-generic
+asm-generic := -f $(srctree)/scripts/Makefile.asm-generic obj
+
+PHONY += asm-generic uapi-asm-generic
+asm-generic: uapi-asm-generic
+	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/asm \
+	generic=include/asm-generic
+uapi-asm-generic:
+	$(Q)$(MAKE) $(asm-generic)=arch/$(SRCARCH)/include/generated/uapi/asm \
+	generic=include/uapi/asm-generic
+
+PHONY += prepare-objtool
+prepare-objtool: $(objtool_target)
+ifeq ($(SKIP_STACK_VALIDATION),1)
+ifdef CONFIG_UNWINDER_ORC
+	@echo "error: Cannot generate ORC metadata for CONFIG_UNWINDER_ORC=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+	@false
+else
+	@echo "warning: Cannot use CONFIG_STACK_VALIDATION=y, please install libelf-dev, libelf-devel or elfutils-libelf-devel" >&2
+endif
+endif

 # Generate some files
 # ---------------------------------------------------------------------------
@@ -2072,13 +2289,20 @@ ifneq ($(dtstree),)
 %.dtb: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree) $(dtstree)/$@

-PHONY += dtbs dtbs_install
-dtbs: prepare3 scripts_dtc
+PHONY += dtbs dtbs_install dt_binding_check
+dtbs dtbs_check: prepare3 scripts_dtc
 	$(Q)$(MAKE) $(build)=$(dtstree)

+dtbs_check: export CHECK_DTBS=1
+dtbs_check: dt_binding_check
+
 dtbs_install:
 	$(Q)$(MAKE) $(dtbinst)=$(dtstree)

+ifdef CONFIG_OF_EARLY_FLATTREE
+all: dtbs
+endif
+
 endif

 # Check dtc and pylibfdt, if DTC is provided, else build them
@@ -2180,8 +2404,6 @@ SYSTEM_MAP = \
 System.map:	u-boot
 		@$(call SYSTEM_MAP,$<) > $@

-#########################################################################
-
 # ARM relocations should all be R_ARM_RELATIVE (32-bit) or
 # R_AARCH64_RELATIVE (64-bit).
 checkarmreloc: u-boot
@@ -2255,9 +2477,7 @@ MRPROPER_FILES += .config .config.old include/autoconf.mk* include/config.h \
 #
 clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
-
 clean-dirs	:= $(foreach f,$(u-boot-alldirs),$(if $(wildcard $(srctree)/$f/Makefile),$f))
-
 clean-dirs      := $(addprefix _clean_, $(clean-dirs))

 PHONY += $(clean-dirs) clean archclean
@@ -2465,11 +2685,25 @@ checkstack:
 	$(OBJDUMP) -d u-boot $$(find . -name u-boot-spl) | \
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)

+ubootversion:
+	@echo $(UBOOTVERSION)
+
 ubootrelease:
 	@$(filechk_uboot.release)

-ubootversion:
-	@echo $(UBOOTVERSION)
+# Clear a bunch of variables before executing the submake
+
+ifeq ($(quiet),silent_)
+tools_silent=s
+endif
+
+tools/: FORCE
+	$(Q)mkdir -p $(objtree)/tools
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/
+
+tools/%: FORCE
+	$(Q)mkdir -p $(objtree)/tools
+	$(Q)$(MAKE) LDFLAGS= MAKEFLAGS="$(tools_silent) $(filter --j% -j,$(MAKEFLAGS))" O=$(abspath $(objtree)) subdir=tools -C $(src)/tools/ $*

 # Single targets
 # ---------------------------------------------------------------------------
@@ -2481,41 +2715,32 @@ ubootversion:
 #  target-dir => where to store outputfile
 #  build-dir  => directory in kernel source tree to use

-ifeq ($(KBUILD_EXTMOD),)
-        build-dir  = $(patsubst %/,%,$(dir $@))
-        target-dir = $(dir $@)
-else
-        zap-slash=$(filter-out .,$(patsubst %/,%,$(dir $@)))
-        build-dir  = $(KBUILD_EXTMOD)$(if $(zap-slash),/$(zap-slash))
-        target-dir = $(if $(KBUILD_EXTMOD),$(dir $<),$(dir $@))
-endif
-
-%.s: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.i: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.lst: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.s: %.S prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.o: %.S prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
-%.symtypes: %.c prepare FORCE
-	$(Q)$(MAKE) $(build)=$(build-dir) $(target-dir)$(notdir $@)
+build-target = $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD)/)$@
+build-dir = $(patsubst %/,%,$(dir $(build-target)))
+
+%.i: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.ll: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.lst: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.o: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.s: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.symtypes: prepare FORCE
+	$(Q)$(MAKE) $(build)=$(build-dir) $(build-target)
+%.ko: %.o
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost

 # Modules
-/: prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(build-dir)
+PHONY += /
+/: ./
+
+# Make sure the latest headers are built for Documentation
+Documentation/ samples/: headers_install
 %/: prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1) \
-	$(build)=$(build-dir)
-%.ko: prepare FORCE
-	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
-	$(build)=$(build-dir) $(@:.ko=.o)
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
+	$(Q)$(MAKE) KBUILD_MODULES=1 $(build)=$(build-dir)

 quiet_cmd_genenv = GENENV  $@
 cmd_genenv = \
@@ -2544,15 +2769,24 @@ quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
 quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
       cmd_rmfiles = rm -f $(rm-files)

+# Run depmod only if we have System.map and depmod is executable
+quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
+      cmd_depmod = $(CONFIG_SHELL) $(srctree)/scripts/depmod.sh $(DEPMOD) \
+                   $(KERNELRELEASE)
+
+# Create temporary dir for module support files
+# clean it up only when building all modules
+cmd_crmodverdir = $(Q)mkdir -p $(MODVERDIR) \
+                  $(if $(KBUILD_MODULES),; rm -f $(MODVERDIR)/*)
+
 # read saved command lines for existing targets
 existing-targets := $(wildcard $(sort $(targets)))
-cmd_files := $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
-$(cmd_files): ;        # Do not try to update included dependency files
--include $(cmd_files)

-endif    #ifeq ($(config-targets),1)
-endif    #ifeq ($(mixed-targets),1)
-endif	 # sub_make_done
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+
+endif   # ifeq ($(config-targets),1)
+endif   # ifeq ($(mixed-targets),1)
+endif   # need-sub-make

 PHONY += FORCE
 FORCE:
diff --git a/board/congatec/common/Makefile b/board/congatec/common/Makefile
index f8170d9c6535..7f1c8994d278 100644
--- a/board/congatec/common/Makefile
+++ b/board/congatec/common/Makefile
@@ -16,8 +16,8 @@ endif
 endif

 ifdef MINIMAL
-# necessary to create built-in.o
-obj- := __dummy__.o
+# necessary to create built-in.a
+obj- := __dummy__.a
 else

 obj-y				+= mmc.o
diff --git a/board/cssi/cmpc885/u-boot.lds b/board/cssi/cmpc885/u-boot.lds
index 53f616fcfe12..167606357e00 100644
--- a/board/cssi/cmpc885/u-boot.lds
+++ b/board/cssi/cmpc885/u-boot.lds
@@ -18,8 +18,8 @@ SECTIONS
 	{
 		arch/powerpc/cpu/mpc8xx/start.o	(.text)
 		arch/powerpc/cpu/mpc8xx/traps.o	(.text*)
-		arch/powerpc/lib/built-in.o		(.text*)
-		drivers/net/built-in.o		(.text*)
+		arch/powerpc/lib/built-in.a		(.text*)
+		drivers/net/built-in.a		(.text*)

 		. = DEFINED(env_offset) ? env_offset : .;
 		env/embedded.o			(.text.environment)
diff --git a/board/cssi/mcr3000/u-boot.lds b/board/cssi/mcr3000/u-boot.lds
index 24b535e724aa..66afdebc0f77 100644
--- a/board/cssi/mcr3000/u-boot.lds
+++ b/board/cssi/mcr3000/u-boot.lds
@@ -18,8 +18,8 @@ SECTIONS
 	{
 		arch/powerpc/cpu/mpc8xx/start.o	(.text)
 		arch/powerpc/cpu/mpc8xx/traps.o	(.text*)
-		arch/powerpc/lib/built-in.o		(.text*)
-		drivers/net/built-in.o		(.text*)
+		arch/powerpc/lib/built-in.a		(.text*)
+		drivers/net/built-in.a		(.text*)

 		. = DEFINED(env_offset) ? env_offset : .;
 		env/embedded.o			(.text.environment)
diff --git a/board/freescale/common/Makefile b/board/freescale/common/Makefile
index b04e19e94282..ed102ae7bf73 100644
--- a/board/freescale/common/Makefile
+++ b/board/freescale/common/Makefile
@@ -14,8 +14,8 @@ endif
 endif

 ifdef MINIMAL
-# necessary to create built-in.o
-obj- := __dummy__.o
+# necessary to create built-in.a
+obj- := __dummy__.a
 else
 # include i2c_common.o once if either VID or FSL_USE_PCA9547_MUX
 I2C_COMMON=
diff --git a/board/menlo/mx8menlo/Makefile b/board/menlo/mx8menlo/Makefile
index 62939395ba12..c71fa9edfd96 100644
--- a/board/menlo/mx8menlo/Makefile
+++ b/board/menlo/mx8menlo/Makefile
@@ -16,8 +16,8 @@ endif

 # Common for all Toradex modules
 ifeq ($(CONFIG_XPL_BUILD),y)
-# Necessary to create built-in.o
-obj- := __dummy__.o
+# Necessary to create built-in.a
+obj- := __dummy__.a
 else
 obj-$(CONFIG_TDX_CFG_BLOCK) += ../../toradex/common/tdx-cfg-block.o
 obj-y += ../../toradex/common/tdx-common.o
diff --git a/board/phytec/common/Makefile b/board/phytec/common/Makefile
index 8126f7356e13..948f9dab626e 100644
--- a/board/phytec/common/Makefile
+++ b/board/phytec/common/Makefile
@@ -3,8 +3,8 @@
 # Author: Teresa Remmet <t.remmet@phytec.de>

 ifdef CONFIG_XPL_BUILD
-# necessary to create built-in.o
-obj- := __dummy__.o
+# necessary to create built-in.a
+obj- := __dummy__.a
 endif

 obj-y += phytec_som_detection.o phytec_som_detection_blocks.o
diff --git a/board/samsung/origen/Makefile b/board/samsung/origen/Makefile
index 940f689a601a..30c637e322a3 100644
--- a/board/samsung/origen/Makefile
+++ b/board/samsung/origen/Makefile
@@ -3,8 +3,8 @@
 # Copyright (C) 2011 Samsung Electronics

 ifdef CONFIG_XPL_BUILD
-# necessary to create built-in.o
-obj- := __dummy__.o
+# necessary to create built-in.a
+obj- := __dummy__.a

 hostprogs-y := tools/mkorigenspl
 always := $(hostprogs-y)
diff --git a/board/samsung/smdkv310/Makefile b/board/samsung/smdkv310/Makefile
index b7f9d5a254c4..360300a78510 100644
--- a/board/samsung/smdkv310/Makefile
+++ b/board/samsung/smdkv310/Makefile
@@ -3,8 +3,8 @@
 # Copyright (C) 2011 Samsung Electronics

 ifdef CONFIG_XPL_BUILD
-# necessary to create built-in.o
-obj- := __dummy__.o
+# necessary to create built-in.a
+obj- := __dummy__.a

 hostprogs-y := tools/mksmdkv310spl
 always := $(hostprogs-y)
diff --git a/board/toradex/common/Makefile b/board/toradex/common/Makefile
index 7e3905445a5c..24496a7c9977 100644
--- a/board/toradex/common/Makefile
+++ b/board/toradex/common/Makefile
@@ -3,8 +3,8 @@

 # Common for all Toradex modules
 ifeq ($(CONFIG_XPL_BUILD),y)
-# Necessary to create built-in.o
-obj- := __dummy__.o
+# Necessary to create built-in.a
+obj- := __dummy__.a
 else
 obj-$(CONFIG_TDX_CFG_BLOCK) += tdx-cfg-block.o
 obj-y += tdx-common.o
diff --git a/doc/api/linker_lists.rst b/doc/api/linker_lists.rst
index 3cd447f187df..9e6849d5e750 100644
--- a/doc/api/linker_lists.rst
+++ b/doc/api/linker_lists.rst
@@ -130,17 +130,17 @@ the compiler cannot update the alignment of the linker_list item.
 In the first case, an 8-byte 'fill' region is added::

    __u_boot_list_2_driver_2_testbus_drv
-               0x0000000000270018       0x80 test/built-in.o
+               0x0000000000270018       0x80 test/built-in.a
                0x0000000000270018                _u_boot_list_2_driver_2_testbus_drv
    __u_boot_list_2_driver_2_testfdt1_drv
-               0x0000000000270098       0x80 test/built-in.o
+               0x0000000000270098       0x80 test/built-in.a
                0x0000000000270098                _u_boot_list_2_driver_2_testfdt1_drv
    *fill*         0x0000000000270118        0x8
    __u_boot_list_2_driver_2_testfdt_drv
-               0x0000000000270120       0x80 test/built-in.o
+               0x0000000000270120       0x80 test/built-in.a
                0x0000000000270120                _u_boot_list_2_driver_2_testfdt_drv
    __u_boot_list_2_driver_2_testprobe_drv
-               0x00000000002701a0       0x80 test/built-in.o
+               0x00000000002701a0       0x80 test/built-in.a
                0x00000000002701a0                _u_boot_list_2_driver_2_testprobe_drv

 With this, the linker_list no-longer works since items after testfdt1_drv
diff --git a/doc/develop/crash_dumps.rst b/doc/develop/crash_dumps.rst
index 4237b073bc9a..c84b85b3364d 100644
--- a/doc/develop/crash_dumps.rst
+++ b/doc/develop/crash_dumps.rst
@@ -89,15 +89,15 @@ File u-boot.map contains the memory layout of the U-Boot binary. Here we find
 these lines::

    .text.do_undefined
-                  0x00000000000101fc        0xc cmd/built-in.o
+                  0x00000000000101fc        0xc cmd/built-in.a
    .text.exception_complete
-                  0x0000000000010208       0x90 cmd/built-in.o
+                  0x0000000000010208       0x90 cmd/built-in.a
    ...
    .text.cmd_process
-                  0x00000000000213b8      0x164 common/built-in.o
+                  0x00000000000213b8      0x164 common/built-in.a
                   0x00000000000213b8                cmd_process
    .text.cmd_process_error
-                  0x000000000002151c       0x40 common/built-in.o
+                  0x000000000002151c       0x40 common/built-in.a
                   0x000000000002151c                cmd_process_error

 So the error occurred at the start of function do\_undefined() and this
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index aa48d2494332..998679f00a0d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -76,10 +76,12 @@ endif

 ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
 lib-target := $(obj)/lib.a
+# Modified for U-Boot
+# real-obj-y += $(obj)/lib-ksyms.o
 endif

-ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
-builtin-target := $(obj)/built-in.o
+ifneq ($(strip $(real-obj-y) $(need-builtin)),)
+builtin-target := $(obj)/built-in.a
 endif

 ifdef CONFIG_MODULES
@@ -102,7 +104,11 @@ else ifeq ($(KBUILD_CHECKSRC),2)
         cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif

-# Do section mismatch analysis for each module/built-in.o
+ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
+  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
+endif
+
+# Do section mismatch analysis for each module/built-in.a
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
   cmd_secanalysis = ; scripts/mod/modpost $@
 endif
@@ -111,101 +117,94 @@ endif
 # ---------------------------------------------------------------------------

 # Default is built-in, unless we know otherwise
+$(foreach x, i ll lst o s symtypes, $(patsubst %.o,%.$(x),$(real-obj-m))): \
+	part-of-module := y
+
 modkern_cflags =                                          \
 	$(if $(part-of-module),                           \
 		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
 		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
 quiet_modtag = $(if $(part-of-module),[M],   )

-$(real-objs-m)        : part-of-module := y
-$(real-objs-m:.o=.i)  : part-of-module := y
-$(real-objs-m:.o=.s)  : part-of-module := y
-$(real-objs-m:.o=.lst): part-of-module := y
-
-# Default for not multi-part modules
-modname = $(basetarget)
-
-$(multi-objs-m)         : modname = $(modname-multi)
-$(multi-objs-m:.o=.i)   : modname = $(modname-multi)
-$(multi-objs-m:.o=.s)   : modname = $(modname-multi)
-$(multi-objs-m:.o=.lst) : modname = $(modname-multi)
-$(multi-objs-y)         : modname = $(modname-multi)
-$(multi-objs-y:.o=.i)   : modname = $(modname-multi)
-$(multi-objs-y:.o=.s)   : modname = $(modname-multi)
-$(multi-objs-y:.o=.lst) : modname = $(modname-multi)
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-cmd_cc_s_c       = $(CC) $(c_flags) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<

 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)

-quiet_cmd_cc_i_c = CPP $(quiet_modtag) $@
-cmd_cc_i_c       = $(CPP) $(c_flags)   -o $@ $<
+quiet_cmd_cpp_i_c = CPP $(quiet_modtag) $@
+cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<

 $(obj)/%.i: $(src)/%.c FORCE
-	$(call if_changed_dep,cc_i_c)
+	$(call if_changed_dep,cpp_i_c)

-cmd_gensymtypes =                                                           \
+# These mirror gensymtypes_S and co below, keep them in synch.
+cmd_gensymtypes_c =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
-    scripts/genksyms/genksyms $(if $(1), -T $(2))			    \
+    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
+     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
      $(if $(KBUILD_PRESERVE),-p)                                            \
      -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))

 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_c =                                                         \
-    $(call cmd_gensymtypes,true,$@) >/dev/null;                             \
+    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
     test -s $@ || rm -f $@

 $(obj)/%.symtypes : $(src)/%.c FORCE
 	$(call cmd,cc_symtypes_c)

+# LLVM assembly
+# Generate .ll files from .c
+quiet_cmd_cc_ll_c = CC $(quiet_modtag)  $@
+      cmd_cc_ll_c = $(CC) $(c_flags) -emit-llvm -S -o $@ $<
+
+$(obj)/%.ll: $(src)/%.c FORCE
+	$(call if_changed_dep,cc_ll_c)
+
 # C (.c) files
 # The C file is compiled and updated dependency information is generated.
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)

 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<

 ifdef CONFIG_MODVERSIONS
 # When module versioning is enabled the following steps are executed:
 # o compile a <file>.o from <file>.c
 # o if <file>.o doesn't contain a __ksymtab version, i.e. does
-#   not export symbols, it's done
+#   not export symbols, it's done.
 # o otherwise, we calculate symbol versions using the good old
 #   genksyms on the preprocessed source and postprocess them in a way
 #   that they are usable as a linker script
 # o generate .tmp_<file>.o from <file>.o using the linker to
 #   replace the unresolved symbols __crc_exported_symbol with
 #   the actual value of the checksum generated by genksyms
-
 # o remove .tmp_<file>.o to <file>.o
-cmd_modversions =								\
+
+cmd_modversions_c =								\
 	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
-		$(call cmd_gensymtypes,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
+		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
 		    > $(@D)/.tmp_$(@F:.o=.ver);					\
 										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@		\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
 			-T $(@D)/.tmp_$(@F:.o=.ver);				\
 		mv -f $(@D)/.tmp_$(@F) $@;					\
 		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
-	fi;
+	fi
 endif

 ifdef CONFIG_FTRACE_MCOUNT_RECORD
-# gcc 5 supports generating the mcount tables directly
-ifneq ($(call cc-option,-mrecord-mcount,y),y)
-KBUILD_CFLAGS += -mrecord-mcount
-else
-# else do it all manually
+ifndef CC_USING_RECORD_MCOUNT
+# compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
   RECORDMCOUNT_FLAGS = -w
 endif
 # Due to recursion, we must skip empty.o.
 # The empty.o file is created in the make process in order to determine
-#  the target endianness and word size. It is made before all other C
-#  files, including recordmcount.
+# the target endianness and word size. It is made before all other C
+# files, including recordmcount.
 sub_cmd_record_mcount =					\
 	if [ $(@) != "scripts/mod/empty.o" ]; then	\
 		$(objtree)/scripts/recordmcount $(RECORDMCOUNT_FLAGS) "$(@)";	\
@@ -213,17 +212,59 @@ sub_cmd_record_mcount =					\
 recordmcount_source := $(srctree)/scripts/recordmcount.c \
 		    $(srctree)/scripts/recordmcount.h
 else
-sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)"	\
+sub_cmd_record_mcount = perl $(srctree)/scripts/recordmcount.pl "$(ARCH)" \
 	"$(if $(CONFIG_SYS_BIG_ENDIAN),big,little)" \
 	"$(if $(CONFIG_64BIT),64,32)" \
 	"$(OBJDUMP)" "$(OBJCOPY)" "$(CC) $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS)" \
 	"$(LD) $(KBUILD_LDFLAGS)" "$(NM)" "$(RM)" "$(MV)" \
 	"$(if $(part-of-module),1,0)" "$(@)";
 recordmcount_source := $(srctree)/scripts/recordmcount.pl
+endif # BUILD_C_RECORDMCOUNT
+cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
+	$(sub_cmd_record_mcount))
+endif # CC_USING_RECORD_MCOUNT
+endif # CONFIG_FTRACE_MCOUNT_RECORD
+
+ifdef CONFIG_STACK_VALIDATION
+ifneq ($(SKIP_STACK_VALIDATION),1)
+
+__objtool_obj := $(objtree)/tools/objtool/objtool
+
+objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
+
+objtool_args += $(if $(part-of-module), --module,)
+
+ifndef CONFIG_FRAME_POINTER
+objtool_args += --no-fp
 endif
-cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),        \
-       $(sub_cmd_record_mcount))
-endif # -record-mcount
+ifdef CONFIG_GCOV_KERNEL
+objtool_args += --no-unreachable
+endif
+ifdef CONFIG_RETPOLINE
+  objtool_args += --retpoline
+endif
+
+# 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
+# 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
+# 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
+cmd_objtool = $(if $(patsubst y%,, \
+	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
+	$(__objtool_obj) $(objtool_args) $@)
+objtool_obj = $(if $(patsubst y%,, \
+	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
+	$(__objtool_obj))
+
+endif # SKIP_STACK_VALIDATION
+endif # CONFIG_STACK_VALIDATION
+
+# Rebuild all objects when objtool changes, or is enabled/disabled.
+objtool_dep = $(objtool_obj)					\
+	      $(wildcard include/config/orc/unwinder.h		\
+			 include/config/stack/validation.h)
+
+ifdef CONFIG_TRIM_UNUSED_KSYMS
+cmd_gen_ksymdeps = \
+	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
 endif

 define rule_cc_o_c
@@ -243,17 +284,25 @@ define rule_as_o_S
 	$(call cmd,modversions_S)
 endef

+# List module undefined symbols (or empty line if not enabled)
+ifdef CONFIG_TRIM_UNUSED_KSYMS
+cmd_undef_syms = $(NM) $@ | sed -n 's/^  *U //p' | xargs echo
+else
+cmd_undef_syms = echo
+endif
+
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
+$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)

 # Single-part modules are special since we need to mark them in $(MODVERDIR)

-$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
+$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
 	$(call cmd,force_checksrc)
 	$(call if_changed_rule,cc_o_c)
-	@{ echo $(@:.o=.ko); echo $@; } > $(MODVERDIR)/$(@F:.o=.mod)
+	@{ echo $(@:.o=.ko); echo $@; \
+	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)

 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -268,29 +317,83 @@ $(obj)/%.lst: $(src)/%.c FORCE

 modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)

-$(real-objs-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
-$(real-objs-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
+$(real-obj-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
+$(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
+
+# .S file exports must have their C prototypes defined in asm/asm-prototypes.h
+# or a file that it includes, in order to get versioned symbols. We build a
+# dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
+# the .S file (with trailing ';'), and run genksyms on that, to extract vers.
+#
+# This is convoluted. The .S file must first be preprocessed to run guards and
+# expand names, then the resulting exports must be constructed into plain
+# EXPORT_SYMBOL(symbol); to build our dummy C file, and that gets preprocessed
+# to make the genksyms input.
+#
+# These mirror gensymtypes_c and co above, keep them in synch.
+cmd_gensymtypes_S =                                                         \
+   { echo "\#include <linux/kernel.h>" ;                                    \
+     echo "\#include <asm/asm-prototypes.h>" ;                              \
+    $(CPP) $(a_flags) $< |                                                  \
+     grep "\<___EXPORT_SYMBOL\>" |                                          \
+     sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
+    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
+    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
+     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
+     $(if $(KBUILD_PRESERVE),-p)                                            \
+     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
+
+quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
+cmd_cc_symtypes_S =                                                         \
+    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
+    test -s $@ || rm -f $@

-quiet_cmd_as_s_S = CPP $(quiet_modtag) $@
-cmd_as_s_S       = $(CPP) $(a_flags)   -o $@ $<
+$(obj)/%.symtypes : $(src)/%.S FORCE
+	$(call cmd,cc_symtypes_S)
+
+
+quiet_cmd_cpp_s_S = CPP $(quiet_modtag) $@
+cmd_cpp_s_S       = $(CPP) $(a_flags) -o $@ $<

 $(obj)/%.s: $(src)/%.S FORCE
-	$(call if_changed_dep,as_s_S)
+	$(call if_changed_dep,cpp_s_S)

 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-cmd_as_o_S       = $(CC) $(a_flags) -c -o $@ $<
+      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
+
+ifdef CONFIG_MODVERSIONS
+
+ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)

-$(obj)/%.o: $(src)/%.S FORCE
-	$(call if_changed_dep,as_o_S)
+ifneq ($(ASM_PROTOTYPES),)

-targets += $(real-objs-y) $(real-objs-m) $(lib-y)
+# versioning matches the C process described above, with difference that
+# we parse asm-prototypes.h C header to get function definitions.
+
+cmd_modversions_S =								\
+	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
+		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
+		    > $(@D)/.tmp_$(@F:.o=.ver);					\
+										\
+		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
+			-T $(@D)/.tmp_$(@F:.o=.ver);				\
+		mv -f $(@D)/.tmp_$(@F) $@;					\
+		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
+	fi
+endif
+endif
+
+$(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
+	$(call if_changed_rule,as_o_S)
+
+targets += $(filter-out $(subdir-obj-y), $(real-obj-y)) $(real-obj-m) $(lib-y)
 targets += $(extra-y) $(MAKECMDGOALS) $(always)
 targets += $(real-dtb-y) $(lib-y) $(always-y)

 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
 quiet_cmd_cpp_lds_S = LDS     $@
-      cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -C -U$(ARCH) \
+      cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -U$(ARCH) \
 	                     -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<

 $(obj)/%.lds: $(src)/%.lds.S FORCE
@@ -312,17 +415,17 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/tools/asn1_compiler
 $(sort $(subdir-obj-y)): $(subdir-ym) ;

 #
-# Rule to compile a set of .o files into one .o file
+# Rule to compile a set of .o files into one .a file (without symbol table)
 #
 ifdef builtin-target
-quiet_cmd_link_o_target = AR      $@
-# If the list of objects to link is empty, just create an empty built-in.o
-cmd_link_o_target = $(if $(strip $(obj-y)),\
-		      rm -f $@; $(AR) cDPrsT $@ $(filter $(obj-y), $^), \
-		      rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@)

-$(builtin-target): $(obj-y) FORCE
-	$(call if_changed,link_o_target)
+quiet_cmd_ar_builtin = AR      $@
+# Modified for U-Boot, we create thin archives directly, instead of using the kernel script
+# Check f49821ee32b76 and 6358d6e8b98 in kernel
+      cmd_ar_builtin = rm -f $@; $(AR) rcTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+
+$(builtin-target): $(real-obj-y) FORCE
+	$(call if_changed,ar_builtin)

 targets += $(builtin-target)
 endif # builtin-target
@@ -341,7 +444,7 @@ $(modorder-target): $(subdir-ym) FORCE
 	$(Q)(cat /dev/null; $(modorder-cmds)) > $@

 #
-# Rule to compile a set of .o files into one .a file
+# Rule to compile a set of .o files into one .a file (with symbol table)
 #
 ifdef lib-target

@@ -349,25 +452,40 @@ $(lib-target): $(lib-y) FORCE
 	$(call if_changed,ar)

 targets += $(lib-target)
-endif

-quiet_cmd_link_multi-y = AR      $@
-cmd_link_multi-y = rm -f $@; $(AR) cDPrsT$(KBUILD_ARFLAGS) $@ $(filter %.o,$^)
+dummy-object = $(obj)/.lib_exports.o
+ksyms-lds = $(dot-target).lds
+
+quiet_cmd_export_list = EXPORTS $@
+cmd_export_list = $(OBJDUMP) -h $< | \
+	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/EXTERN(\1)/p' >$(ksyms-lds);\
+	rm -f $(dummy-object);\
+	echo | $(CC) $(a_flags) -c -o $(dummy-object) -x assembler -;\
+	$(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
+	rm $(dummy-object) $(ksyms-lds)
+
+$(obj)/lib-ksyms.o: $(lib-target) FORCE
+	$(call if_changed,export_list)

-quiet_cmd_link_multi-m = AR [M]  $@
-cmd_link_multi-m = $(cmd_link_multi-y)
+targets += $(obj)/lib-ksyms.o

-$(multi-used-y): FORCE
-	$(call if_changed,link_multi-y)
-$(call multi_depend, $(multi-used-y), .o, -objs -y)
+endif
+
+# NOTE:
+# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
+# module is turned into a multi object module, $^ will contain header file
+# dependencies recorded in the .*.cmd file.
+quiet_cmd_link_multi-m = LD [M]  $@
+cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)

 $(multi-used-m): FORCE
 	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); } > $(MODVERDIR)/$(@F:.o=.mod)
-$(call multi_depend, $(multi-used-m), .o, -objs -y)
-
-targets += $(multi-used-y) $(multi-used-m)
+	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
+	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
+$(call multi_depend, $(multi-used-m), .o, -objs -y -m)

+targets += $(multi-used-m)
+targets := $(filter-out $(PHONY), $(targets))

 # Add intermediate targets:
 # When building objects with specific suffix patterns, add intermediate
@@ -375,9 +493,13 @@ targets += $(multi-used-y) $(multi-used-m)
 intermediate_targets = $(foreach sfx, $(2), \
 				$(patsubst %$(strip $(1)),%$(sfx), \
 					$(filter %$(strip $(1)), $(targets))))
+# %.asn1.o <- %.asn1.[ch] <- %.asn1
+# %.dtb.o <- %.dtb.S <- %.dtb <- %.dts
 # %.lex.o <- %.lex.c <- %.l
 # %.tab.o <- %.tab.[ch] <- %.y
-targets += $(call intermediate_targets, .lex.o, .lex.c) \
+targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
+	   $(call intermediate_targets, .dtb.o, .dtb.S .dtb) \
+	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)

 # Descending
@@ -385,7 +507,7 @@ targets += $(call intermediate_targets, .lex.o, .lex.c) \

 PHONY += $(subdir-ym)
 $(subdir-ym):
-	$(Q)$(MAKE) $(build)=$@
+	$(Q)$(MAKE) $(build)=$@ need-builtin=$(if $(findstring $@,$(subdir-obj-y)),1)

 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
new file mode 100644
index 000000000000..5f7df50cfe7a
--- /dev/null
+++ b/scripts/Makefile.gcc-plugins
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_CYC_COMPLEXITY)	+= cyc_complexity_plugin.so
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)	+= latent_entropy_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_LATENT_ENTROPY)		\
+		+= -DLATENT_ENTROPY_PLUGIN
+ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
+    DISABLE_LATENT_ENTROPY_PLUGIN += -fplugin-arg-latent_entropy_plugin-disable
+endif
+export DISABLE_LATENT_ENTROPY_PLUGIN
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_SANCOV)		+= sancov_plugin.so
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)	+= structleak_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE)	\
+		+= -fplugin-arg-structleak_plugin-verbose
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF)		\
+		+= -fplugin-arg-structleak_plugin-byref
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL)	\
+		+= -fplugin-arg-structleak_plugin-byref-all
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
+		+= -DSTRUCTLEAK_PLUGIN
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\
+		+= -DRANDSTRUCT_PLUGIN
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE)	\
+		+= -fplugin-arg-randomize_layout_plugin-performance-mode
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
+		+= -DSTACKLEAK_PLUGIN
+gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
+		+= -fplugin-arg-stackleak_plugin-track-min-size=$(CONFIG_STACKLEAK_TRACK_MIN_SIZE)
+ifdef CONFIG_GCC_PLUGIN_STACKLEAK
+    DISABLE_STACKLEAK_PLUGIN += -fplugin-arg-stackleak_plugin-disable
+endif
+export DISABLE_STACKLEAK_PLUGIN
+
+gcc-plugin-$(CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK) += arm_ssp_per_task_plugin.so
+ifdef CONFIG_GCC_PLUGIN_ARM_SSP_PER_TASK
+    DISABLE_ARM_SSP_PER_TASK_PLUGIN += -fplugin-arg-arm_ssp_per_task_plugin-disable
+endif
+export DISABLE_ARM_SSP_PER_TASK_PLUGIN
+
+# All the plugin CFLAGS are collected here in case a build target needs to
+# filter them out of the KBUILD_CFLAGS.
+GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
+# The sancov_plugin.so is included via CFLAGS_KCOV, so it is removed here.
+GCC_PLUGINS_CFLAGS := $(filter-out %/sancov_plugin.so, $(GCC_PLUGINS_CFLAGS))
+export GCC_PLUGINS_CFLAGS
+
+# Add the flags to the build!
+KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
+
+# All enabled GCC plugins are collected here for building below.
+GCC_PLUGIN := $(gcc-plugin-y)
+export GCC_PLUGIN
diff --git a/scripts/Makefile.kcov b/scripts/Makefile.kcov
new file mode 100644
index 000000000000..3d61c4bfcbee
--- /dev/null
+++ b/scripts/Makefile.kcov
@@ -0,0 +1,9 @@
+ifdef CONFIG_KCOV
+
+kcov-flags-$(CONFIG_CC_HAS_SANCOV_TRACE_PC)	+= -fsanitize-coverage=trace-pc
+kcov-flags-$(CONFIG_KCOV_ENABLE_COMPARISONS)	+= -fsanitize-coverage=trace-cmp
+kcov-flags-$(CONFIG_GCC_PLUGIN_SANCOV)		+= -fplugin=$(objtree)/scripts/gcc-plugins/sancov_plugin.so
+
+export CFLAGS_KCOV := $(kcov-flags-y)
+
+endif
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 19a5be574956..5db2fbc418a1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -5,46 +5,40 @@ ccflags-y  += $(EXTRA_CFLAGS)
 cppflags-y += $(EXTRA_CPPFLAGS)
 ldflags-y  += $(EXTRA_LDFLAGS)

-#
-# flags that take effect in sub directories
-export KBUILD_SUBDIR_ASFLAGS := $(KBUILD_SUBDIR_ASFLAGS) $(subdir-asflags-y)
-export KBUILD_SUBDIR_CCFLAGS := $(KBUILD_SUBDIR_CCFLAGS) $(subdir-ccflags-y)
+# flags that take effect in current and sub directories
+KBUILD_AFLAGS += $(subdir-asflags-y)
+KBUILD_CFLAGS += $(subdir-ccflags-y)

 # Figure out what we need to build from the various variables
 # ===========================================================================

 # When an object is listed to be built compiled-in and modular,
 # only build the compiled-in version
-
 obj-m := $(filter-out $(obj-y),$(obj-m))

 # Libraries are always collected in one lib file.
 # Filter out objects already built-in
-
 lib-y := $(filter-out $(obj-y), $(sort $(lib-y) $(lib-m)))

+# Determine modorder.
+# Unfortunately, we don't have information about ordering between -y
+# and -m subdirs.  Just put -y's first.
+modorder	:= $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m:.o=.ko))

 # Handle objects in subdirs
 # ---------------------------------------------------------------------------
-# o if we encounter foo/ in $(obj-y), replace it by foo/built-in.o
+# o if we encounter foo/ in $(obj-y), replace it by foo/built-in.a
 #   and add the directory to the list of dirs to descend into: $(subdir-y)
 # o if we encounter foo/ in $(obj-m), remove it from $(obj-m)
 #   and add the directory to the list of dirs to descend into: $(subdir-m)
-
-# Determine modorder.
-# Unfortunately, we don't have information about ordering between -y
-# and -m subdirs.  Just put -y's first.
-modorder	:= $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m:.o=.ko))
-
 __subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
 subdir-y	+= $(__subdir-y)
 __subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
 subdir-m	+= $(__subdir-m)
-obj-y		:= $(patsubst %/, %/built-in.o, $(obj-y))
+obj-y		:= $(patsubst %/, %/built-in.a, $(obj-y))
 obj-m		:= $(filter-out %/, $(obj-m))

 # Subdirectories we need to descend into
-
 subdir-ym	:= $(sort $(subdir-y) $(subdir-m))

 # Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
@@ -54,9 +48,9 @@ multi-search = $(sort $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -),
 # List primitive targets that are compiled from source files
 real-search = $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $(call suffix-search, $m, $2, $3), $m))

-# if $(foo-objs) exists, foo.o is a composite object
+# if $(foo-objs), $(foo-y), or $(foo-m) exists, foo.o is a composite object
 multi-used-y := $(sort $(foreach m,$(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
-multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
+multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))), $(m))))
 multi-used   := $(multi-used-y) $(multi-used-m)
 single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))

@@ -74,11 +68,22 @@ base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m,

 # $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
 # tell kbuild to descend
-subdir-obj-y := $(filter %/built-in.o, $(obj-y))
+subdir-obj-y := $(filter %/built-in.a, $(obj-y))

-# Replace multi-part objects by their individual parts, look at local dir only
-real-objs-y := $(foreach m, $(filter-out $(subdir-obj-y), $(obj-y)), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m))) $(extra-y)
-real-objs-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
+# Replace multi-part objects by their individual parts,
+# including built-in.a from subdirectories
+real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
+real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
+
+# DTB
+# If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
+extra-y				+= $(dtb-y)
+extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)
+
+ifneq ($(CHECK_DTBS),)
+extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
+extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
+endif

 # Add subdir path

@@ -91,8 +96,8 @@ obj-y		:= $(addprefix $(obj)/,$(obj-y))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
 subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
-real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
-real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
+real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
+real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
 single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
 multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
 multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
@@ -102,22 +107,25 @@ multi-dtb-y	:= $(addprefix $(obj)/,$(multi-dtb-y))
 real-dtb-y      := $(addprefix $(obj)/,$(real-dtb-y))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))

+# Finds the multi-part object the current object will be linked into.
+# If the object belongs to two or more multi-part objects, all of them are
+# concatenated with a colon separator.
+modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
+		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$(m:.o=)))))
+
+modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
+
 # These flags are needed for modversions and compiling, so we define them here
-# already
-# $(modname_flags) #defines KBUILD_MODNAME as the name of the module it will
+# $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
-# Note: Files that end up in two or more modules are compiled without the
-#       KBUILD_MODNAME definition. The reason is that any made-up name would
-#       differ in different configs.
 name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
-modname_flags  = $(if $(filter 1,$(words $(modname))),\
-                 -DKBUILD_MODNAME=$(call name-fix,$(modname)))
+modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))

-orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(KBUILD_SUBDIR_CCFLAGS) \
+orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
                  $(ccflags-y) $(CFLAGS_$(basetarget).o)
 _c_flags       = $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(orig_c_flags))
-orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(KBUILD_SUBDIR_ASFLAGS) \
+orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) \
                  $(asflags-y) $(AFLAGS_$(basetarget).o)
 _a_flags       = $(filter-out $(AFLAGS_REMOVE_$(basetarget).o), $(orig_a_flags))
 _cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
@@ -140,7 +148,19 @@ endif
 ifeq ($(CONFIG_KASAN),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
-		$(CFLAGS_KASAN))
+		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
+endif
+
+ifeq ($(CONFIG_UBSAN),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(UBSAN_SANITIZE_$(basetarget).o)$(UBSAN_SANITIZE)$(CONFIG_UBSAN_SANITIZE_ALL)), \
+		$(CFLAGS_UBSAN))
+endif
+
+ifeq ($(CONFIG_KCOV),y)
+_c_flags += $(if $(patsubst n%,, \
+	$(KCOV_INSTRUMENT_$(basetarget).o)$(KCOV_INSTRUMENT)$(CONFIG_KCOV_INSTRUMENT_ALL)), \
+	$(CFLAGS_KCOV))
 endif

 __c_flags	= $(_c_flags)
@@ -161,7 +181,6 @@ __a_flags	= $(call flags,_a_flags)
 __cpp_flags     = $(call flags,_cpp_flags)
 endif
 endif
-
 # Modified for U-Boot: LINUXINCLUDE -> UBOOTINCLUDE
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
 		 $(__c_flags) $(modkern_cflags)                           \
@@ -222,7 +241,6 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 # Finds the multi-part object the current object will be linked into
 modname-multi = $(sort $(foreach m,$(multi-used),\
 		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
-
 # Useful for describing the dependency of composite objects
 # Usage:
 #   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
@@ -278,12 +296,13 @@ $(obj)/%: $(src)/%_shipped
 # ---------------------------------------------------------------------------

 quiet_cmd_ld = LD      $@
-cmd_ld = $(LD) $(ld_flags) $(filter-out FORCE,$^) -o $@
+      cmd_ld = $(LD) $(ld_flags) $(real-prereqs) -o $@

 # Archive
 # ---------------------------------------------------------------------------
+
 quiet_cmd_ar = AR      $@
-cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)

 # Objcopy
 # ---------------------------------------------------------------------------
@@ -295,10 +314,11 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------

 quiet_cmd_gzip = GZIP    $@
-cmd_gzip = cat $(filter-out FORCE,$^) | gzip -n -f -9 > $@
+      cmd_gzip = cat $(real-prereqs) | gzip -n -f -9 > $@

 # DTC
 # ---------------------------------------------------------------------------
+DTC ?= $(objtree)/scripts/dtc/dtc

 # Disable noisy checks by default
 ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
@@ -309,7 +329,6 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-graph_child_address \
 	-Wno-simple_bus_reg \
 	-Wno-unique_unit_address \
-	-Wno-simple_bus_reg \
 	-Wno-pci_device_reg

 # U-Boot specific disables
@@ -567,20 +586,20 @@ printf "%08x\n" $$dec_size |						\
 )

 quiet_cmd_bzip2 = BZIP2   $@
-cmd_bzip2 = { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@
+      cmd_bzip2 = { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@

 # Lzma
 # ---------------------------------------------------------------------------

 quiet_cmd_lzma = LZMA    $@
-cmd_lzma = { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@
+      cmd_lzma = { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@

 quiet_cmd_lzo = LZO     $@
-cmd_lzo = { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@
+      cmd_lzo = { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@

 quiet_cmd_lz4 = LZ4     $@
-cmd_lz4 = { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
-	$(size_append); } > $@
+      cmd_lz4 = { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
+                  $(size_append); } > $@

 # U-Boot mkimage
 # ---------------------------------------------------------------------------
@@ -702,12 +721,15 @@ quiet_cmd_fdt_rm_props = FDTGREP $@
 # ---------------------------------------------------------------------------

 # Default sed regexp - multiline due to syntax constraints
+#
+# Use [:space:] because LLVM's integrated assembler inserts <tab> around
+# the .ascii directive whereas GCC keeps the <space> as-is.
 define sed-offsets
-	"s:[[:space:]]*\.ascii[[:space:]]*\"\(.*\)\":\1:; \
+	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
 	/^->/{s:->#\(.*\):/* \1 */:; \
 	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
-	s:->::; p;}"
+	s:->::; p;}'
 endef

 # Use filechk to avoid rebuilds when a header changes, but the resulting file
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 43f27874f9fe..03a2f151d916 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -135,7 +135,7 @@ head-y		:= $(addprefix $(obj)/,$(head-y))
 libs-y		:= $(addprefix $(obj)/,$(libs-y))
 u-boot-spl-dirs	:= $(patsubst %/,%,$(filter %/, $(libs-y)))

-libs-y := $(patsubst %/, %/built-in.o, $(libs-y))
+libs-y := $(patsubst %/, %/built-in.a, $(libs-y))

 # Add GCC lib
 ifeq ($(CONFIG_USE_PRIVATE_LIBGCC),y)
diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
index b4cb66397bb7..d1f73964d822 100644
--- a/tools/buildman/builderthread.py
+++ b/tools/buildman/builderthread.py
@@ -627,7 +627,7 @@ class BuilderThread(threading.Thread):
             # Extract the environment from U-Boot and dump it out
             cmd = [f'{self.toolchain.cross}objcopy', '-O', 'binary',
                    '-j', '.rodata.default_environment',
-                   'env/built-in.o', 'uboot.env']
+                   'env/built-in.a', 'uboot.env']
             command.run_one(*cmd, capture=True, capture_stderr=True,
                             cwd=result.out_dir, raise_on_error=False, env=env)
             if not work_in_output:
--
2.49.0

