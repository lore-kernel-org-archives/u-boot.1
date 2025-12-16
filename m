Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A01D5CCBF
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 10:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC7E83971;
	Tue, 16 Dec 2025 11:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SacogCmM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F7C83710; Tue, 16 Dec 2025 10:16:52 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5528334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 10:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42e2e3c0dccso2352528f8f.2
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 01:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765876606; x=1766481406; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b2vw9ENxCpoMmTMTzTc1Rlqj2yjtKVNzYfpdZUisePQ=;
 b=SacogCmMbSysJc7GfAQSluxgyIANiam7fuIgUSXqUyYHgg8nIUOQe+g5cnbB5pLyBU
 lLEjCkdmKWPZ3RwPnsWuKzhZ+33RjWj/fKv70gPuh95xNlqv5Bwce+1f7kVpWUbDrM12
 s07XPk52gQee/uE293XZh7Pt1fofJHAhtcZr8lNFTWlpCsALAj3y6L7EOn6wO6p6rL7J
 u7qO+/+Ay5664L4mpypPludiHVGmWUnLRDZnb3C8dziSU4+JIi+M9KSa2GjmfS5Y06NY
 XRLUWw+kp97OX21TN86KOf91oowlcHTac4Q3VWM4IY+PzR2hAWi+pcDUptuntO0EXM1g
 /ytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765876606; x=1766481406;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2vw9ENxCpoMmTMTzTc1Rlqj2yjtKVNzYfpdZUisePQ=;
 b=eF3c1D/3azSngz45sPtZRjL7xpO36in5Ng/xyx/d+X7jlOfcwU2Vwl7wkZ786s5Zai
 wR2aTquNQDryGXh96Z/c2Azo+22747tw92hdaHRXvLchp7gHj71aDapwK9ZNuuPGXn2i
 nSaUoR7rIqO0zRKHExmfm6xYzFbSrnLb6nD0ttKIfw6sRnFycvOLWC+nI+70SZvJWqc3
 eBl0krlLKYgOYy1Usbly7fXyo8DLbki703tbwstNaKML5RMHaOwBGgktZD9L582seXbc
 m6XIMFsXVkPgfHnVV8m0/MVsA3EwAruTYf3wzhhdVS19xxyq7k5GGXJFhGQTSYuTvE7C
 GCEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL0NTcewSZO7kAU/+pHDyLyHQjjHIMsAf7lUqpVPDhrMdohnCMY9AHSktlQEQi9QvFwV4wGwA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3G58rsA2btrub3Gq8f2fFRDNEnyDb0XYpJ63ZpuG2JBIUCJO+
 ToULQhI2T/ejzO0NMhV0gN62d54Z4k3g7727X5EVPwJqaJ0ZOHgGuPlAsg4C8Edgvdo=
X-Gm-Gg: AY/fxX44LMEr/g/0JpRKClQxv0a4vKQyklT2N+nUU+F1NN/XIm6O/PYm+6bP8ZwPvIZ
 i0SOTLRnhNnoH6QYvMDPuvuPZXEay7h5LRgN5cDhgTkuz9kaPubDtBN/XxJSFRND7FzL2byT2VC
 mwLIXy34HlqGJhx95k/+VuQehgqvd+nL5rlQgRYiJ+mhN8LobZ69u6pd6/XGYpJ6XA6QJU3iJ5T
 LYxewclECSzbnuRhUf2eij1jd6LNP5sUndpUK1rZ5wty1B+JohWvu5PKCR6xVYxlwQjGRh4Jrar
 R3Ef74thyLgDOQu9tCwz+u/hxxN7aLFEXzuo++6j0Hq1XiqVEQdek8iM+Pb9X1SC+qK/4Vg2e6f
 goQnbIIQ90U84S6G3KtiB3o9NXTGn8abqFHUX/1g6CnunwjDNyQrkUQ4c6Zu7FIOHpbat2bB/wX
 h3FLjnTQMIDytU1afjhcUENKFgNAWmo/2uzSrzCm5iWJbDHZe3+rsdUpk1HbVYATFSkplwIun6B
 xJymJWRgrzyh9DIxGXT9JW60TuLyXcCzNyJ2K3TL1DnPjkiepDDQV1EwHHCQCNDrfsE+7ESnvSD
 2pw2Y6oJFAdHZqaYzq8KSFmwH/yh4euJ3IoJOfYVbLwZqZ7R5S98WdCybsX7wKy2fMMpj8mqBI0
 +/decDvoADzPoWAfntSxc8WdKOfxS8xfumUcwi007PAqGdLzIeBRWDZ+vuFWOo561PM73On8N95
 YwVK5jNrfNIjJmHO4nlV9S3X/L4MVe8LuOyv8zvZw55Rs3pxUL
X-Google-Smtp-Source: AGHT+IHOR+57JGR8+8X7O6EhveajqBaMpFJVBY0Kf22H4IGGSos6joip+a1mXcsOldxUpfabzT2/sA==
X-Received: by 2002:a05:6000:438a:b0:430:fa52:9ea9 with SMTP id
 ffacd0b85a97d-430fa52a0f6mr8769465f8f.62.1765876605293; 
 Tue, 16 Dec 2025 01:16:45 -0800 (PST)
Received: from hera ([95.164.180.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f6a42c8csm16971227f8f.16.2025.12.16.01.16.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 01:16:44 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, "Andrew F. Davis" <afd@ti.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Michal Simek <michal.simek@amd.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, Simon Glass <sjg@chromium.org>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 Varshini Rajendran <varshini.rajendran@microchip.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Bernhard Messerklinger <bernhard.messerklinger@at.abb.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 E Shattow <e@freeshell.de>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sam Edwards <cfsworks@gmail.com>, Peter Robinson <pbrobinson@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Greg Malysa <malysagreg@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>,
 Daniel Golle <daniel@makrotopia.org>, u-boot@lists.denx.de
Subject: [PATCH] kbuild: Bump the build system to 6.1
Date: Tue, 16 Dec 2025 11:16:24 +0200
Message-ID: <20251216091632.512635-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Dec 2025 11:32:27 +0100
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

From: Sughosh Ganu <sughosh.ganu@linaro.org>

Our last sync with the kernel was 5.1.

We are so out of sync now, that tracking the patches and backporting
them one by one makes little sense and it's going to take ages.

This is an attempt to sync up Makefiles to 6.1.
Unfortunately due to sheer amount of patches this is not easy to review,
but that's what we decided during a community call for the bump to 5.1,
so we are following the same guidelines here.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>a #rebased on -next

---
 Kbuild                                  |  10 +-
 Makefile                                | 383 +++++++++++++----------
 arch/arm/cpu/arm926ejs/mxs/Makefile     |  10 +-
 arch/arm/cpu/armv7/vf610/Makefile       |   2 +-
 arch/arm/mach-at91/arm926ejs/Makefile   |   2 +-
 arch/arm/mach-omap2/config_secure.mk    |   2 +-
 arch/mips/Makefile.postlink             |   2 +-
 board/BuR/brppt1/config.mk              |   4 +-
 board/BuR/brppt2/config.mk              |   4 +-
 board/BuR/brsmarc1/config.mk            |   4 +-
 board/BuR/zynq/Makefile                 |   2 +-
 board/Marvell/db-xc3-24g4xg/Makefile    |   2 +-
 board/intel/edison/config.mk            |   4 +-
 board/mikrotik/crs3xx-98dx3236/Makefile |   2 +-
 board/samsung/origen/Makefile           |   3 +-
 board/samsung/smdkv310/Makefile         |   3 +-
 board/xilinx/zynq/Makefile              |   4 +-
 board/xilinx/zynqmp/Makefile            |   6 +-
 doc/develop/makefiles.rst               |   3 -
 drivers/ram/k3-ddrss/Makefile           |   8 +-
 dts/Makefile                            |   2 +-
 lib/efi_loader/Makefile                 |   2 +-
 scripts/Kbuild.include                  | 234 ++++----------
 scripts/Kbuild.uboot                    |  47 +++
 scripts/Makefile                        |   4 +-
 scripts/Makefile.autoconf               |  12 +-
 scripts/Makefile.build                  | 391 ++++++++++++------------
 scripts/Makefile.clean                  |  57 ++--
 scripts/Makefile.compiler               |  74 +++++
 scripts/Makefile.extrawarn              |  11 +-
 scripts/Makefile.host                   | 123 +++-----
 scripts/Makefile.lib                    | 357 +++++++++++++---------
 scripts/Makefile.xpl                    |  20 +-
 scripts/basic/Makefile                  |   6 +-
 scripts/check-local-export              |  71 +++++
 scripts/dtc/Makefile                    |   5 +-
 scripts/dtc/pylibfdt/Makefile           |   4 +-
 scripts/kconfig/Makefile                |  12 +-
 tools/Makefile                          |  94 +++---
 tools/env/Makefile                      |   5 +-
 tools/gdb/Makefile                      |   4 +-
 41 files changed, 1052 insertions(+), 943 deletions(-)
 create mode 100644 scripts/Kbuild.uboot
 create mode 100644 scripts/Makefile.compiler
 create mode 100755 scripts/check-local-export

diff --git a/Kbuild b/Kbuild
index bf52e540518e..4a7f7f2d92a9 100644
--- a/Kbuild
+++ b/Kbuild
@@ -7,10 +7,11 @@

 generic-offsets-file := include/generated/generic-asm-offsets.h

-always  := $(generic-offsets-file)
+always-y  := $(generic-offsets-file)
 targets := lib/asm-offsets.s

-CFLAGS_REMOVE_asm-offsets.o := $(LTO_CFLAGS)
+CFLAGS_REMOVE_lib/asm-offsets.o := $(LTO_CFLAGS)
+CFLAGS_REMOVE_arch/$(ARCH)/lib/asm-offsets.o := $(LTO_CFLAGS)

 $(obj)/$(generic-offsets-file): $(obj)/lib/asm-offsets.s FORCE
 	$(call filechk,offsets,__GENERIC_ASM_OFFSETS_H__)
@@ -22,10 +23,11 @@ ifneq ($(wildcard $(srctree)/arch/$(ARCH)/lib/asm-offsets.c),)
 offsets-file := include/generated/asm-offsets.h
 endif

-always  += $(offsets-file)
+always-y  += $(offsets-file)
 targets += arch/$(ARCH)/lib/asm-offsets.s

-CFLAGS_asm-offsets.o := -DDO_DEPS_ONLY
+CFLAGS_lib/asm-offsets.o := -DDO_DEPS_ONLY
+CFLAGS_arch/$(ARCH)/lib/asm-offsets.o := -DDO_DEPS_ONLY

 $(obj)/$(offsets-file): $(obj)/arch/$(ARCH)/lib/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
diff --git a/Makefile b/Makefile
index 571c07e0e9c6..6b4608ebf07e 100644
--- a/Makefile
+++ b/Makefile
@@ -12,32 +12,12 @@ NAME =
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.

-# That's our default target when none is given on the command line
-PHONY := _all
-_all:
+$(if $(filter __%, $(MAKECMDGOALS)), \
+	$(error targets prefixed with '__' are only for internal use))

-# Determine target architecture for the sandbox
-include include/host_arch.h
-ifeq ("", "$(CROSS_COMPILE)")
-  MK_ARCH="${shell uname -m}"
-else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(.*ccache\)\{0,1\}[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
-endif
-unexport HOST_ARCH
-ifeq ("x86_64", $(MK_ARCH))
-  export HOST_ARCH=$(HOST_ARCH_X86_64)
-else ifneq (,$(findstring $(MK_ARCH), "i386" "i486" "i586" "i686"))
-  export HOST_ARCH=$(HOST_ARCH_X86)
-else ifneq (,$(findstring $(MK_ARCH), "aarch64" "armv8l"))
-  export HOST_ARCH=$(HOST_ARCH_AARCH64)
-else ifneq (,$(findstring $(MK_ARCH), "arm" "armv5tel" "armv6l" "armv7" "armv7a" "armv7l"))
-  export HOST_ARCH=$(HOST_ARCH_ARM)
-else ifeq ("riscv32", $(MK_ARCH))
-  export HOST_ARCH=$(HOST_ARCH_RISCV32)
-else ifeq ("riscv64", $(MK_ARCH))
-  export HOST_ARCH=$(HOST_ARCH_RISCV64)
-endif
-undefine MK_ARCH
+# That's our default target when none is given on the command line
+PHONY := __all
+__all:

 # We are using a recursive build, so we need to do a little thinking
 # to get the ordering right.
@@ -125,79 +105,88 @@ endif

 export quiet Q KBUILD_VERBOSE

-# kbuild supports saving output files in a separate directory.
-# To locate output files in a separate directory two syntaxes are supported.
-# In both cases the working directory must be the root of the kernel src.
+# Kbuild will save output files in the current working directory.
+# This does not need to match to the root of the kernel source tree.
+#
+# For example, you can do this:
+#
+#  cd /dir/to/store/output/files; make -f /dir/to/kernel/source/Makefile
+#
+# If you want to save output files in a different location, there are
+# two syntaxes to specify it.
+#
 # 1) O=
 # Use "make O=dir/to/store/output/files/"
 #
 # 2) Set KBUILD_OUTPUT
-# Set the environment variable KBUILD_OUTPUT to point to the directory
-# where the output files shall be placed.
-# export KBUILD_OUTPUT=dir/to/store/output/files/
-# make
+# Set the environment variable KBUILD_OUTPUT to point to the output directory.
+# export KBUILD_OUTPUT=dir/to/store/output/files/; make
 #
 # The O= assignment takes precedence over the KBUILD_OUTPUT environment
 # variable.

-# KBUILD_SRC is not intended to be used by the regular user (for now),
-# it is set on invocation of make with KBUILD_OUTPUT or O= specified.
-
-# OK, Make called in directory where kernel src resides
-# Do we want to locate output files in a separate directory?
+# Do we want to change the working directory?
 ifeq ("$(origin O)", "command line")
   KBUILD_OUTPUT := $(O)
 endif

-ifneq ($(words $(subst :, ,$(CURDIR))), 1)
-  $(error main directory cannot contain spaces nor colons)
-endif

 ifneq ($(KBUILD_OUTPUT),)
-# check that the output directory actually exists
-saved-output := $(KBUILD_OUTPUT)
-KBUILD_OUTPUT := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) \
-								&& pwd)
-$(if $(KBUILD_OUTPUT),, \
-     $(error failed to create output directory "$(saved-output)"))
-
-# Look for make include files relative to root of kernel src
-#
-# This does not become effective immediately because MAKEFLAGS is re-parsed
-# once after the Makefile is read.  It is OK since we are going to invoke
-# 'sub-make' below.
-MAKEFLAGS += --include-dir=$(CURDIR)
-
-need-sub-make := 1
+# Make's built-in functions such as $(abspath ...), $(realpath ...) cannot
+# expand a shell special character '~'. We use a somewhat tedious way here.
+abs_objtree := $(shell mkdir -p $(KBUILD_OUTPUT) && cd $(KBUILD_OUTPUT) && pwd)
+$(if $(abs_objtree),, \
+     $(error failed to create output directory "$(KBUILD_OUTPUT)"))
+
+# $(realpath ...) resolves symlinks
+abs_objtree := $(realpath $(abs_objtree))
 else
+abs_objtree := $(CURDIR)
+endif # ifneq ($(KBUILD_OUTPUT),)

-# Do not print "Entering directory ..." at all for in-tree build.
+ifeq ($(abs_objtree),$(CURDIR))
+# Suppress "Entering directory ..." unless we are changing the work directory.
 MAKEFLAGS += --no-print-directory
+else
+need-sub-make := 1
+endif

-endif # ifneq ($(KBUILD_OUTPUT),)
+this-makefile := $(lastword $(MAKEFILE_LIST))
+abs_srctree := $(realpath $(dir $(this-makefile)))
+
+ifneq ($(words $(subst :, ,$(abs_srctree))), 1)
+$(error source directory cannot contain spaces or colons)
+endif
+
+ifneq ($(abs_srctree),$(abs_objtree))
+# Look for make include files relative to root of kernel src
+#
+# --included-dir is added for backward compatibility, but you should not rely on
+# it. Please add $(srctree)/ prefix to include Makefiles in the source tree.
+MAKEFLAGS += --include-dir=$(abs_srctree)
+endif

 ifneq ($(filter 3.%,$(MAKE_VERSION)),)
 # 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
 # We need to invoke sub-make to avoid implicit rules in the top Makefile.
 need-sub-make := 1
 # Cancel implicit rules for this Makefile.
-$(lastword $(MAKEFILE_LIST)): ;
+$(this-makefile): ;
 endif

+export abs_srctree abs_objtree
 export sub_make_done := 1

 ifeq ($(need-sub-make),1)

-PHONY += $(MAKECMDGOALS) sub-make
+PHONY += $(MAKECMDGOALS) __sub-make

-$(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
+$(filter-out $(this-makefile), $(MAKECMDGOALS)) __all: __sub-make
 	@:

 # Invoke a second make in the output directory, passing relevant variables
-sub-make:
-	$(Q)$(MAKE) \
-	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
-	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
+__sub-make:
+	$(Q)$(MAKE) -C $(abs_objtree) -f $(abs_srctree)/Makefile $(MAKECMDGOALS)

 endif # need-sub-make
 endif # sub_make_done
@@ -210,6 +199,53 @@ ifeq ($(need-sub-make),)
 # so that IDEs/editors are able to understand relative filenames.
 MAKEFLAGS += --no-print-directory

+ifeq ($(abs_srctree),$(abs_objtree))
+        # building in the source tree
+        srctree := .
+	building_out_of_srctree :=
+else
+        ifeq ($(abs_srctree)/,$(dir $(abs_objtree)))
+                # building in a subdirectory of the source tree
+                srctree := ..
+        else
+                srctree := $(abs_srctree)
+        endif
+	building_out_of_srctree := 1
+endif
+
+ifneq ($(KBUILD_ABS_SRCTREE),)
+srctree := $(abs_srctree)
+endif
+
+objtree		:= .
+obj		:= $(objtree)
+VPATH		:= $(srctree)
+
+export building_out_of_srctree srctree objtree VPATH
+
+# Determine target architecture for the sandbox
+include $(srctree)/include/host_arch.h
+ifeq ("", "$(CROSS_COMPILE)")
+  MK_ARCH="${shell uname -m}"
+else
+  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^\(.*ccache\)\{0,1\}[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\3/p'}"
+endif
+unexport HOST_ARCH
+ifeq ("x86_64", $(MK_ARCH))
+  export HOST_ARCH=$(HOST_ARCH_X86_64)
+else ifneq (,$(findstring $(MK_ARCH), "i386" "i486" "i586" "i686"))
+  export HOST_ARCH=$(HOST_ARCH_X86)
+else ifneq (,$(findstring $(MK_ARCH), "aarch64" "armv8l"))
+  export HOST_ARCH=$(HOST_ARCH_AARCH64)
+else ifneq (,$(findstring $(MK_ARCH), "arm" "armv5tel" "armv6l" "armv7" "armv7a" "armv7l"))
+  export HOST_ARCH=$(HOST_ARCH_ARM)
+else ifeq ("riscv32", $(MK_ARCH))
+  export HOST_ARCH=$(HOST_ARCH_RISCV32)
+else ifeq ("riscv64", $(MK_ARCH))
+  export HOST_ARCH=$(HOST_ARCH_RISCV64)
+endif
+undefine MK_ARCH
+
 # Call a source code checker (by default, "sparse") as part of the
 # C compilation.
 #
@@ -242,27 +278,7 @@ ifeq ("$(origin M)", "command line")
   KBUILD_EXTMOD := $(M)
 endif

-ifeq ($(KBUILD_SRC),)
-        # building in the source tree
-        srctree := .
-else
-        ifeq ($(KBUILD_SRC)/,$(dir $(CURDIR)))
-                # building in a subdirectory of the source tree
-                srctree := ..
-        else
-                srctree := $(KBUILD_SRC)
-        endif
-endif
-
-export KBUILD_CHECKSRC KBUILD_EXTMOD KBUILD_SRC
-
-objtree		:= .
-src		:= $(srctree)
-obj		:= $(objtree)
-
-VPATH		:= $(srctree)
-
-export srctree objtree VPATH
+export KBUILD_CHECKSRC KBUILD_EXTMOD

 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -291,6 +307,7 @@ config-targets  := 0
 mixed-targets   := 0
 dot-config      := 1
 may-sync-config := 1
+single-build	:= 0

 ifneq ($(filter $(no-dot-config-targets), $(MAKECMDGOALS)),)
 	ifeq ($(filter-out $(no-dot-config-targets), $(MAKECMDGOALS)),)
@@ -349,7 +366,9 @@ __build_one_by_one:

 else

-include scripts/Kbuild.include
+include $(srctree)/scripts/Kbuild.uboot
+
+include $(srctree)/scripts/Makefile.compiler

 # Read UBOOTRELEASE from include/config/uboot.release (if it exists)
 UBOOTRELEASE = $(shell cat include/config/uboot.release 2> /dev/null)
@@ -357,7 +376,7 @@ UBOOTVERSION = $(VERSION)$(if $(PATCHLEVEL),.$(PATCHLEVEL)$(if $(SUBLEVEL),.$(SU
 export VERSION PATCHLEVEL SUBLEVEL UBOOTRELEASE UBOOTVERSION

 # Modified for U-Boot
--include scripts/subarch.include
+-include $(srctree)/scripts/subarch.include

 # Cross compiling and selecting different set of gcc/bin-utils
 # ---------------------------------------------------------------------------
@@ -408,9 +427,7 @@ KCONFIG_CONFIG	?= .config
 export KCONFIG_CONFIG

 # SHELL used by kbuild
-CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
-	  else if [ -x /bin/bash ]; then echo /bin/bash; \
-	  else echo sh; fi ; fi)
+CONFIG_SHELL := sh

 HOST_LFS_CFLAGS := $(shell getconf LFS_CFLAGS 2>/dev/null)
 HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
@@ -443,7 +460,7 @@ endef
 export size_check

 export KBUILD_MODULES KBUILD_BUILTIN
-export KBUILD_CHECKSRC KBUILD_SRC KBUILD_EXTMOD
+export KBUILD_CHECKSRC KBUILD_EXTMOD

 # Make variables (CC, etc...)
 AS		= $(CROSS_COMPILE)as
@@ -460,12 +477,20 @@ READELF		= $(CROSS_COMPILE)readelf
 LEX		= flex
 YACC		= bison
 AWK		= awk
+BASH		= bash
 INSTALLKERNEL  := installkernel
 DEPMOD		= /sbin/depmod
+KBZIP2		= bzip2
+KGZIP		= gzip
+KLZOP		= lzop
+LZMA		= lzma
+LZ4		= lz4c
 PERL		= perl
 PYTHON		= python
 PYTHON2		= python2
 PYTHON3		= python3
+XZ		= xz
+ZSTD		= zstd

 # The devicetree compiler and pylibfdt are automatically built unless DTC is
 # provided. If DTC is provided, it is assumed the pylibfdt is available too.
@@ -497,7 +522,7 @@ USERINCLUDE    := \
 # Needed to be compatible with the O= option
 UBOOTINCLUDE    := \
 	-Iinclude \
-	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(building_out_of_srctree), -I$(srctree)/include) \
 	$(if $(CONFIG_$(XPL_)MBEDTLS_LIB), \
 		"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
 		-I$(srctree)/lib/mbedtls \
@@ -533,9 +558,10 @@ KBUILD_LDFLAGS_MODULE := -T $(srctree)/scripts/module-common.lds
 KBUILD_LDFLAGS :=
 GCC_PLUGINS_CFLAGS :=

-export ARCH SRCARCH CONFIG_SHELL HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
+export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE AS LD CC
 export CPP AR NM STRIP OBJCOPY OBJDUMP KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS
 export MAKE LEX YACC AWK INSTALLKERNEL PERL PYTHON PYTHON2 PYTHON3 UTS_MACHINE
+export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
 export HOSTCXX KBUILD_HOSTCXXFLAGS LDFLAGS_MODULE CHECK CHECKFLAGS

 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
@@ -573,6 +599,14 @@ ifeq ($(NO_PYTHON),)
 PYTHON_ENABLE=y
 endif

+# Files to ignore in find ... statements
+
+export RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o    \
+			  -name CVS -o -name .pc -o -name .hg -o -name .git \) \
+			  -prune -o
+export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn \
+			 --exclude CVS --exclude .pc --exclude .hg --exclude .git
+
 # ===========================================================================
 # Rules shared between *config targets and build targets

@@ -580,18 +614,34 @@ endif
 PHONY += scripts_basic
 scripts_basic:
 	$(Q)$(MAKE) $(build)=scripts/basic
-	$(Q)rm -f .tmp_quiet_recordmcount

 PHONY += outputmakefile
+ifdef building_out_of_srctree
+# Before starting out-of-tree build, make sure the source tree is clean.
 # outputmakefile generates a Makefile in the output directory, if using a
 # separate output directory. This allows convenient use of make in the
 # output directory.
 # At the same time when output Makefile generated, generate .gitignore to
 # ignore whole output directory
+
+quiet_cmd_makefile = GEN     Makefile
+      cmd_makefile = { \
+	echo "\# Automatically generated by $(srctree)/Makefile: don't edit"; \
+	echo "include $(srctree)/Makefile"; \
+	} > Makefile
+
 outputmakefile:
-ifneq ($(KBUILD_SRC),)
+	$(Q)if [ -f $(srctree)/.config -o \
+		 -d $(srctree)/include/config -o \
+		 -d $(srctree)/arch/$(SRCARCH)/include/generated ]; then \
+		echo >&2 "***"; \
+		echo >&2 "*** The source tree is not clean, please run 'make$(if $(findstring command line, $(origin ARCH)), ARCH=$(ARCH)) mrproper'"; \
+		echo >&2 "*** in $(abs_srctree)";\
+		echo >&2 "***"; \
+		false; \
+	fi
 	$(Q)ln -fsn $(srctree) source
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile $(srctree)
+	$(call cmd,makefile)
 	$(Q)test -e .gitignore || \
 	{ echo "# this is build directory, ignore it"; echo "*"; } > .gitignore
 endif
@@ -656,9 +706,9 @@ else
 # but instead _all depend on modules
 PHONY += all
 ifeq ($(KBUILD_EXTMOD),)
-_all: all
+__all: all
 else
-_all: modules
+__all: modules
 endif

 # Decide whether to build built-in, modular, or both.
@@ -778,8 +828,8 @@ ifneq ($(wildcard include/config/auto.conf),)
 autoconf_is_old := $(shell find . -path ./$(KCONFIG_CONFIG) -newer \
 						include/config/auto.conf)
 ifeq ($(autoconf_is_old),)
-include config.mk
-include arch/$(ARCH)/Makefile
+include $(srctree)/config.mk
+include $(srctree)/arch/$(ARCH)/Makefile
 endif
 endif
 endif
@@ -880,8 +930,8 @@ endif
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)

-include scripts/Makefile.kcov
-include scripts/Makefile.gcc-plugins
+include $(srctree)/scripts/Makefile.kcov
+include $(srctree)/scripts/Makefile.gcc-plugins
 LTO_CFLAGS :=
 LTO_FINAL_LDFLAGS :=
 export LTO_CFLAGS LTO_FINAL_LDFLAGS
@@ -969,7 +1019,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 # Prohibit date/time macros, which would make the build non-deterministic
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)

-include scripts/Makefile.extrawarn
+include $(srctree)/scripts/Makefile.extrawarn

 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 KBUILD_CPPFLAGS += $(KCPPFLAGS)
@@ -986,7 +1036,7 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 # Needed to be compatible with the O= option
 UBOOTINCLUDE    := \
 	-Iinclude \
-	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(building_out_of_srctree), -I$(srctree)/include) \
 	$(if $(CONFIG_$(XPL_)MBEDTLS_LIB), \
 		"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
 		-I$(srctree)/lib/mbedtls \
@@ -1187,12 +1237,8 @@ endif
 endif

 ifdef CONFIG_FUNCTION_TRACER
-ifdef CONFIG_FTRACE_MCOUNT_RECORD
-  # gcc 5 supports generating the mcount tables directly
-  ifeq ($(call cc-option-yn,-mrecord-mcount),y)
-    CC_FLAGS_FTRACE	+= -mrecord-mcount
-    export CC_USING_RECORD_MCOUNT := 1
-  endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_CC
+  CC_FLAGS_FTRACE	+= -mrecord-mcount
   ifdef CONFIG_HAVE_NOP_MCOUNT
     ifeq ($(call cc-option-yn, -mnop-mcount),y)
       CC_FLAGS_FTRACE	+= -mnop-mcount
@@ -1200,7 +1246,17 @@ ifdef CONFIG_FTRACE_MCOUNT_RECORD
     endif
   endif
 endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_OBJTOOL
+  CC_FLAGS_USING	+= -DCC_USING_NOP_MCOUNT
+endif
+ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
+  ifdef CONFIG_HAVE_C_RECORDMCOUNT
+    BUILD_C_RECORDMCOUNT := y
+    export BUILD_C_RECORDMCOUNT
+  endif
+endif
 ifdef CONFIG_HAVE_FENTRY
+  # s390-linux-gnu-gcc did not support -mfentry until gcc-9.
   ifeq ($(call cc-option-yn, -mfentry),y)
     CC_FLAGS_FTRACE	+= -mfentry
     CC_FLAGS_USING	+= -DCC_USING_FENTRY
@@ -1209,12 +1265,6 @@ endif
 export CC_FLAGS_FTRACE
 KBUILD_CFLAGS	+= $(CC_FLAGS_FTRACE) $(CC_FLAGS_USING)
 KBUILD_AFLAGS	+= $(CC_FLAGS_USING)
-ifdef CONFIG_DYNAMIC_FTRACE
-	ifdef CONFIG_HAVE_C_RECORDMCOUNT
-		BUILD_C_RECORDMCOUNT := y
-		export BUILD_C_RECORDMCOUNT
-	endif
-endif
 endif

 # Add optional build target if defined in board/cpu/soc headers
@@ -1430,10 +1480,10 @@ MKIMAGEFLAGS_fit-dtb.blob = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 MKIMAGEFLAGS_fit-dtb.blob += -B 0x8

 ifneq ($(EXT_DTB),)
-u-boot-fit-dtb.bin: u-boot-nodtb.bin $(EXT_DTB)
+u-boot-fit-dtb.bin: u-boot-nodtb.bin $(EXT_DTB) FORCE
 		$(call if_changed,cat)
 else
-u-boot-fit-dtb.bin: u-boot-nodtb.bin $(FINAL_DTB_CONTAINER)
+u-boot-fit-dtb.bin: u-boot-nodtb.bin $(FINAL_DTB_CONTAINER) FORCE
 	$(call if_changed,cat)
 endif

@@ -1939,7 +1989,7 @@ quiet_cmd_u-boot-elf ?= LD      $@
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
 	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_TEXT_BASE) \
 	-Ttext=$(CONFIG_TEXT_BASE)
-u-boot.elf: u-boot.bin u-boot-elf.lds
+u-boot.elf: u-boot.bin u-boot-elf.lds FORCE
 	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< u-boot-elf.o
 	$(call if_changed,u-boot-elf)

@@ -1956,7 +2006,7 @@ PHONY += prepare0
 ifeq ($(CONFIG_SPL),y)
 spl/u-boot-spl-mtk.bin: spl/u-boot-spl

-u-boot-mtk.bin: u-boot-with-spl.bin
+u-boot-mtk.bin: u-boot-with-spl.bin FORCE
 	$(call if_changed,copy)
 else
 MKIMAGEFLAGS_u-boot-mtk.bin = -T mtk_image \
@@ -1989,9 +2039,9 @@ quiet_cmd_keep_syms_lto_cc = KSLCC   $@
       cmd_keep_syms_lto_cc = \
 	$(CC) $(filter-out $(LTO_CFLAGS),$(c_flags)) -c -o $@ $<

-$(u-boot-keep-syms-lto_c): $(u-boot-main)
+$(u-boot-keep-syms-lto_c): $(u-boot-main) FORCE
 	$(call if_changed,keep_syms_lto)
-$(u-boot-keep-syms-lto): $(u-boot-keep-syms-lto_c)
+$(u-boot-keep-syms-lto): $(u-boot-keep-syms-lto_c) FORCE
 	$(call if_changed,keep_syms_lto_cc)
 else
 u-boot-keep-syms-lto :=
@@ -2173,7 +2223,7 @@ PHONY += prepare archprepare prepare1 prepare3
 # and if so do:
 # 1) Check that make has not been executed in the kernel src $(srctree)
 prepare3: include/config/uboot.release
-ifneq ($(KBUILD_SRC),)
+ifdef building_out_of_srctree
 	@$(kecho) '  Using $(srctree) as source for U-Boot'
 	$(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then \
 		echo >&2 "  $(srctree) is not clean, please run 'make mrproper'"; \
@@ -2267,10 +2317,10 @@ define filechk_timestamp.h
 endef

 define filechk_defaultenv.h
-	( { grep -v '^#' | grep -v '^$$' || true ; echo '' ; } | \
+	( ( { grep -v '^#' | grep -v '^$$' || true ; echo '' ; } | \
 	 tr '\n' '\0' | \
 	 sed -e 's/\\\x0\s*//g' | \
-	 xxd -i ; )
+	 xxd -i ; ) < $<; )
 endef

 define filechk_dt.h
@@ -2313,7 +2363,7 @@ dtbs_check: export CHECK_DTBS=1
 dtbs_check: dt_binding_check

 dtbs_install:
-	$(Q)$(MAKE) $(dtbinst)=$(dtstree)
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.dtbinst obj=$(dtstree)

 ifdef CONFIG_OF_EARLY_FLATTREE
 all: dtbs
@@ -2431,7 +2481,7 @@ checkarmreloc: u-boot
 		false; \
 	fi

-tools/version.h: include/version.h
+tools/version.h: include/version.h FORCE
 	$(Q)mkdir -p $(dir $@)
 	$(call if_changed,copy)

@@ -2463,7 +2513,7 @@ CHANGELOG:
 # make distclean Remove editor backup files, patch leftover files and the like

 # Directories & files removed with 'make clean'
-CLEAN_DIRS  += $(MODVERDIR) \
+CLEAN_FILES  += $(MODVERDIR) \
 	       $(foreach d, spl tpl vpl, $(patsubst %,$d/%, \
 			$(filter-out include, $(shell ls -1 $d 2>/dev/null))))

@@ -2482,7 +2532,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       imx9image* m33-oei-ddrfw* tifalcon.bin

 # Directories & files removed with 'make mrproper'
-MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
+MRPROPER_FILES  += include/config include/generated spl tpl vpl \
 		  .tmp_objdiff doc/output include/asm

 # Remove include/asm symlink created by U-Boot before v2014.01
@@ -2492,37 +2542,14 @@ MRPROPER_FILES += .config .config.old include/autoconf.mk* include/config.h \

 # clean - Delete most, but leave enough to build external modules
 #
-clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
-clean-dirs	:= $(foreach f,$(u-boot-alldirs),$(if $(wildcard $(srctree)/$f/Makefile),$f))
-clean-dirs      := $(addprefix _clean_, $(clean-dirs))

-PHONY += $(clean-dirs) clean archclean
-$(clean-dirs):
-	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
+PHONY += archclean

-clean: $(clean-dirs)
-	$(call cmd,rmdirs)
-	$(call cmd,rmfiles)
-	@find $(if $(KBUILD_EXTMOD), $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
-		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
-		-o -name '*.ko.*' -o -name '*.su' -o -name '*.pyc' \
-		-o -name '*.dtb' -o -name '*.dtbo' \
-		-o -name '*.dtb.S' -o -name '*.dtbo.S' \
-		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
-		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
-		-o -name '*.asn1.[ch]' \
-		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name modules.builtin -o -name '.tmp_*.o.*' \
-		-o -name 'dsdt_generated.aml' -o -name 'dsdt_generated.asl.tmp' \
-		-o -name 'dsdt_generated.c' \
-		-o -name 'generated_defconfig' \
-		-o -name '*.efi' -o -name '*.gcno' -o -name '*.so' \) \
-		-type f -print | xargs rm -f
+clean: archclean

 # mrproper - Delete all generated files, including .config
 #
-mrproper: rm-dirs  := $(wildcard $(MRPROPER_DIRS))
 mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
 mrproper-dirs      := $(addprefix _mrproper_,scripts)

@@ -2531,22 +2558,49 @@ $(mrproper-dirs):
 	$(Q)$(MAKE) $(clean)=$(patsubst _mrproper_%,%,$@)

 mrproper: clean $(mrproper-dirs)
-	$(call cmd,rmdirs)
 	$(call cmd,rmfiles)
-	@rm -f arch/*/include/asm/arch

 # distclean
 #
 PHONY += distclean

 distclean: mrproper
-	@find $(srctree) $(RCS_FIND_IGNORE) \
+	@find . $(RCS_FIND_IGNORE) \
 		\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
-		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
-		-o -name '.*.rej' -o -name '*%' -o -name 'core' \
-		-o -name '*.pyc' \) \
+		-o -name '*.bak' -o -name '#*#' -o -name '*%' \
+		-o -name 'core' -o -name tags -o -name TAGS -o -name 'cscope*' \
+		-o -name GPATH -o -name GRTAGS -o -name GSYMS -o -name GTAGS \) \
 		-type f -print | xargs rm -f
-	@rm -f boards.cfg CHANGELOG .binman_stamp
+
+# Modified for U-Boot, the kernel figures this out through it's own variable
+clean-dirs	:= $(foreach f,$(u-boot-alldirs),$(if $(wildcard $(srctree)/$f/Makefile),$f))
+clean-dirs := $(addprefix _clean_, $(clean-dirs))
+PHONY += $(clean-dirs) clean
+$(clean-dirs):
+	$(Q)$(MAKE) $(clean)=$(patsubst _clean_%,%,$@)
+
+clean: $(clean-dirs)
+	$(call cmd,rmfiles)
+	@find $(or $(KBUILD_EXTMOD), .) $(RCS_FIND_IGNORE) \
+		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
+		-o -name '*.ko.*' -o -name '*.su' -o -name '*.pyc' \
+		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
+		-o -name '*.dwo' -o -name '*.lst' \
+		-o -name '*.su' -o -name '*.mod' -o -name '*.usyms' \
+		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
+		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
+		-o -name '*.asn1.[ch]' \
+		-o -name '*.symtypes' -o -name 'modules.order' \
+		-o -name '.tmp_*' \
+		-o -name '*.c.[012]*.*' \
+		-o -name '*.ll' \
+		-o -name 'dsdt_generated.aml' -o -name 'dsdt_generated.asl.tmp' \
+		-o -name 'dsdt_generated.c' \
+		-o -name 'generated_defconfig' \
+		-o -name '*.gcno' \
+		-o -name '*.efi' -o -name '*.gcno' -o -name '*.so' \
+		-o -name '*.*.symversions' \) -type f -print | xargs rm -f
+

 # See doc/develop/python_cq.rst
 PHONY += pylint pylint_err
@@ -2779,16 +2833,13 @@ u-boot-initial-env: scripts_basic $(version_h) $(env_h) include/config.h FORCE
 PHONY += coccicheck

 coccicheck:
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
+	$(Q)$(BASH) $(srctree)/scripts/$@

 # FIXME Should go into a make.lib or something
 # ===========================================================================

-quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
-      cmd_rmdirs = rm -rf $(rm-dirs)
-
 quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
-      cmd_rmfiles = rm -f $(rm-files)
+      cmd_rmfiles = rm -rf $(rm-files)

 # Run depmod only if we have System.map and depmod is executable
 quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
diff --git a/arch/arm/cpu/arm926ejs/mxs/Makefile b/arch/arm/cpu/arm926ejs/mxs/Makefile
index f633e54ba621..0df501e91db7 100644
--- a/arch/arm/cpu/arm926ejs/mxs/Makefile
+++ b/arch/arm/cpu/arm926ejs/mxs/Makefile
@@ -53,23 +53,23 @@ quiet_cmd_mkcst_mxs = MXSCST  $@
 cmd_mkcst_mxs = cst -o $@ < $^						\
 	$(if $(KBUILD_VERBOSE:1=), >/dev/null)

-spl/u-boot-spl.ivt: spl/u-boot-spl.bin
+spl/u-boot-spl.ivt: spl/u-boot-spl.bin FORCE
 	$(call if_changed,mkalign_mxs)
 	$(call if_changed,mkivt_mxs,$(CONFIG_SPL_TEXT_BASE),\
 		0x00008000,0x00008040)

-u-boot.ivt: u-boot.bin
+u-boot.ivt: u-boot.bin FORCE
 	$(call if_changed,mkalign_mxs)
 	$(call if_changed,mkivt_mxs,$(CONFIG_TEXT_BASE),\
 		0x40001000,0x40001040)

-spl/u-boot-spl.csf: spl/u-boot-spl.ivt spl/u-boot-spl.bin board/$(VENDOR)/$(BOARD)/sign/u-boot-spl.csf
+spl/u-boot-spl.csf: spl/u-boot-spl.ivt spl/u-boot-spl.bin board/$(VENDOR)/$(BOARD)/sign/u-boot-spl.csf FORCE
 	$(call if_changed,mkcsfreq_mxs,$(CONFIG_SPL_TEXT_BASE),0x8000)

-u-boot.csf: u-boot.ivt u-boot.bin board/$(VENDOR)/$(BOARD)/sign/u-boot.csf
+u-boot.csf: u-boot.ivt u-boot.bin board/$(VENDOR)/$(BOARD)/sign/u-boot.csf FORCE
 	$(call if_changed,mkcsfreq_mxs,$(CONFIG_TEXT_BASE),0x40001000)

-%.sig: %.csf
+%.sig: %.csf FORCE
 	$(call if_changed,mkcst_mxs)

 MKIMAGEFLAGS_u-boot.sb = -n $< -T mxsimage
diff --git a/arch/arm/cpu/armv7/vf610/Makefile b/arch/arm/cpu/armv7/vf610/Makefile
index b5b479b49637..91d4d3cf1455 100644
--- a/arch/arm/cpu/armv7/vf610/Makefile
+++ b/arch/arm/cpu/armv7/vf610/Makefile
@@ -7,5 +7,5 @@ obj-y	+= timer.o

 MKIMAGEFLAGS_u-boot.vyb = -T vybridimage

-u-boot.vyb: u-boot.imx
+u-boot.vyb: u-boot.imx FORCE
 	$(call if_changed,mkimage)
diff --git a/arch/arm/mach-at91/arm926ejs/Makefile b/arch/arm/mach-at91/arm926ejs/Makefile
index 8a9464cdfba6..ed601e5bfd7b 100644
--- a/arch/arm/mach-at91/arm926ejs/Makefile
+++ b/arch/arm/mach-at91/arm926ejs/Makefile
@@ -36,7 +36,7 @@ endif
 ifdef CONFIG_$(PHASE_)SYS_THUMB_BUILD
 ifndef CONFIG_HAS_THUMB2

-CFLAGS_cache.o := -marm
+CFLAGS_arch/arm/cpu/arm926ejs/cache.o := -marm

 endif
 endif
diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2/config_secure.mk
index 62ac27dfa900..c83ba7706695 100644
--- a/arch/arm/mach-omap2/config_secure.mk
+++ b/arch/arm/mach-omap2/config_secure.mk
@@ -84,7 +84,7 @@ u-boot-spl_HS_SPI_X-LOADER: $(obj)/u-boot-spl.bin FORCE
 # file, not an SPL. This will work for all boot devices, other than SPI
 # flash. On Keystone devices when booting from an SD card FAT partition this
 # file must be called "MLO"
-u-boot_HS_MLO: $(obj)/u-boot.bin
+u-boot_HS_MLO: $(obj)/u-boot.bin FORCE
 	$(call if_changed,mkomapsecimg)
 	@if [ -f $@ ]; then \
 		cp -f $@ MLO; \
diff --git a/arch/mips/Makefile.postlink b/arch/mips/Makefile.postlink
index 9ad7d4e453ae..2c9bb6611b08 100644
--- a/arch/mips/Makefile.postlink
+++ b/arch/mips/Makefile.postlink
@@ -6,7 +6,7 @@ PHONY := __archpost
 __archpost:

 -include include/config/auto.conf
-include scripts/Kbuild.include
+include scripts/Kbuild.uboot

 CMD_RELOCS = tools/mips-relocs
 quiet_cmd_relocs = RELOCS  $@
diff --git a/board/BuR/brppt1/config.mk b/board/BuR/brppt1/config.mk
index 6853135f838c..56e6f2c622dd 100644
--- a/board/BuR/brppt1/config.mk
+++ b/board/BuR/brppt1/config.mk
@@ -29,8 +29,8 @@ INPUTS-y += $(hw-platform-y)_prog.bin
 INPUTS-y += $(hw-platform-y)_prod.zip
 endif

-$(hw-platform-y)_prog.bin: u-boot-dtb.img spl/u-boot-spl.bin
+$(hw-platform-y)_prog.bin: u-boot-dtb.img spl/u-boot-spl.bin FORCE
 	$(call if_changed,prodbin)

-$(hw-platform-y)_prod.zip: $(hw-platform-y)_prog.bin
+$(hw-platform-y)_prod.zip: $(hw-platform-y)_prog.bin FORCE
 	$(call if_changed,prodzip)
diff --git a/board/BuR/brppt2/config.mk b/board/BuR/brppt2/config.mk
index f2362d16dc47..16d5008bc051 100644
--- a/board/BuR/brppt2/config.mk
+++ b/board/BuR/brppt2/config.mk
@@ -29,8 +29,8 @@ INPUTS-y += $(hw-platform-y)_prod.zip
 endif
 endif

-$(hw-platform-y)_prog.bin: u-boot-dtb.img spl SPL
+$(hw-platform-y)_prog.bin: u-boot-dtb.img spl SPL FORCE
 	$(call if_changed,prodbin)

-$(hw-platform-y)_prod.zip: $(hw-platform-y)_prog.bin
+$(hw-platform-y)_prod.zip: $(hw-platform-y)_prog.bin FORCE
 	$(call if_changed,prodzip)
diff --git a/board/BuR/brsmarc1/config.mk b/board/BuR/brsmarc1/config.mk
index 1de971876c32..173bb6d6ee18 100644
--- a/board/BuR/brsmarc1/config.mk
+++ b/board/BuR/brsmarc1/config.mk
@@ -26,8 +26,8 @@ cmd_prodzip =					\
 INPUTS-y += $(hw-platform-y)_prog.bin
 INPUTS-y += $(hw-platform-y)_prod.zip

-$(hw-platform-y)_prog.bin: u-boot-dtb.img spl/u-boot-spl.bin
+$(hw-platform-y)_prog.bin: u-boot-dtb.img spl/u-boot-spl.bin FORCE
 	$(call if_changed,prodbin)

-$(hw-platform-y)_prod.zip: $(hw-platform-y)_prog.bin
+$(hw-platform-y)_prod.zip: $(hw-platform-y)_prog.bin FORCE
 	$(call if_changed,prodzip)
diff --git a/board/BuR/zynq/Makefile b/board/BuR/zynq/Makefile
index fed40b0a069a..8a7c809dcb15 100644
--- a/board/BuR/zynq/Makefile
+++ b/board/BuR/zynq/Makefile
@@ -12,4 +12,4 @@ obj-y += $(hw-platform-y)/board.o
 obj-$(CONFIG_SPL_BUILD) += $(hw-platform-y)/ps7_init_gpl.o

 # Suppress "warning: function declaration isn't a prototype"
-CFLAGS_REMOVE_ps7_init_gpl.o := -Wstrict-prototypes
+CFLAGS_REMOVE_$(hw-platform-y)/ps7_init_gpl.o := -Wstrict-prototypes
diff --git a/board/Marvell/db-xc3-24g4xg/Makefile b/board/Marvell/db-xc3-24g4xg/Makefile
index 24e82000075c..070f31b2d01e 100644
--- a/board/Marvell/db-xc3-24g4xg/Makefile
+++ b/board/Marvell/db-xc3-24g4xg/Makefile
@@ -10,5 +10,5 @@ quiet_cmd_sed = SED     $@

 SEDFLAGS_kwbimage.cfg =-e "s|^BINARY.*|BINARY $(srctree)/$(@D)/binary.0 0000005b 00000068|"
 $(obj)/kwbimage.cfg: $(src)/kwbimage.cfg.in include/autoconf.mk \
-		include/config/auto.conf
+		include/config/auto.conf FORCE
 	  $(call if_changed,sed)
diff --git a/board/intel/edison/config.mk b/board/intel/edison/config.mk
index 8c6087e2908b..3afebf0f0b1e 100644
--- a/board/intel/edison/config.mk
+++ b/board/intel/edison/config.mk
@@ -11,7 +11,7 @@ cmd_mkalign_eds =							\
 	mv $@ $^

 INPUTS-y += u-boot-align.bin
-u-boot-align.bin: u-boot.bin
+u-boot-align.bin: u-boot.bin FORCE
 	$(call if_changed,mkalign_eds)

-HOSTCFLAGS_autoconf.mk.dep = -Wno-variadic-macros
+HOSTCFLAGS_include/autoconf.mk.dep = -Wno-variadic-macros
diff --git a/board/mikrotik/crs3xx-98dx3236/Makefile b/board/mikrotik/crs3xx-98dx3236/Makefile
index 0b2930d3e2cc..d72e04737037 100644
--- a/board/mikrotik/crs3xx-98dx3236/Makefile
+++ b/board/mikrotik/crs3xx-98dx3236/Makefile
@@ -10,5 +10,5 @@ quiet_cmd_sed = SED     $@

 SEDFLAGS_kwbimage.cfg =-e "s|^BINARY.*|BINARY $(srctree)/$(@D)/binary.0 0000005b 00000068|"
 $(obj)/kwbimage.cfg: $(src)/kwbimage.cfg.in include/autoconf.mk \
-		include/config/auto.conf
+		include/config/auto.conf FORCE
 	  $(call if_changed,sed)
diff --git a/board/samsung/origen/Makefile b/board/samsung/origen/Makefile
index 30c637e322a3..8f149873360c 100644
--- a/board/samsung/origen/Makefile
+++ b/board/samsung/origen/Makefile
@@ -6,8 +6,7 @@ ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.a
 obj- := __dummy__.a

-hostprogs-y := tools/mkorigenspl
-always := $(hostprogs-y)
+hostprogs-always-y += tools/mkorigenspl

 # omit -O2 option to suppress
 #   warning: dereferencing type-punned pointer will break strict-aliasing rules
diff --git a/board/samsung/smdkv310/Makefile b/board/samsung/smdkv310/Makefile
index 360300a78510..f35f2af1cda5 100644
--- a/board/samsung/smdkv310/Makefile
+++ b/board/samsung/smdkv310/Makefile
@@ -6,8 +6,7 @@ ifdef CONFIG_XPL_BUILD
 # necessary to create built-in.a
 obj- := __dummy__.a

-hostprogs-y := tools/mksmdkv310spl
-always := $(hostprogs-y)
+hostprogs-always-y += tools/mksmdkv310spl
 else
 obj-y	+= smdkv310.o
 endif
diff --git a/board/xilinx/zynq/Makefile b/board/xilinx/zynq/Makefile
index f40fe382f570..8feaae39de9b 100644
--- a/board/xilinx/zynq/Makefile
+++ b/board/xilinx/zynq/Makefile
@@ -39,7 +39,7 @@ endif
 obj-$(CONFIG_XPL_BUILD) += $(init-objs)

 # Suppress "warning: function declaration isn't a prototype"
-CFLAGS_REMOVE_ps7_init_gpl.o := -Wstrict-prototypes
+CFLAGS_REMOVE_$(hw-platform-y)/ps7_init_gpl.o := -Wstrict-prototypes

 # To include xil_io.h
-CFLAGS_ps7_init_gpl.o := -I$(srctree)/$(src)
+CFLAGS_$(hw-platform-y)/ps7_init_gpl.o := -I$(srctree)/$(src)
diff --git a/board/xilinx/zynqmp/Makefile b/board/xilinx/zynqmp/Makefile
index 5b2b6e1f33ca..417167898001 100644
--- a/board/xilinx/zynqmp/Makefile
+++ b/board/xilinx/zynqmp/Makefile
@@ -41,10 +41,10 @@ endif
 endif

 # Suppress "warning: function declaration isn't a prototype"
-CFLAGS_REMOVE_psu_init_gpl.o := -Wstrict-prototypes
+CFLAGS_REMOVE_$(hw-platform-y)/psu_init_gpl.o := -Wstrict-prototypes

 # To include xil_io.h
-CFLAGS_psu_init_gpl.o := -I$(srctree)/$(src)
+CFLAGS_$(hw-platform-y)/psu_init_gpl.o := -I$(srctree)/$(src)

 # To suppress "warning: cast to pointer from integer of different size"
-CFLAGS_psu_init_gpl.o += -Wno-int-to-pointer-cast
+CFLAGS_$(hw-platform-y)/psu_init_gpl.o += -Wno-int-to-pointer-cast
diff --git a/doc/develop/makefiles.rst b/doc/develop/makefiles.rst
index 593556f4dd5d..f124abbf5369 100644
--- a/doc/develop/makefiles.rst
+++ b/doc/develop/makefiles.rst
@@ -395,9 +395,6 @@ more details, with real examples.
 	These three flags apply only to the kbuild makefile in which they
 	are assigned. They are used for all the normal cc, as and ld
 	invocations happening during a recursive build.
-	Note: Flags with the same behaviour were previously named:
-	EXTRA_CFLAGS, EXTRA_AFLAGS and EXTRA_LDFLAGS.
-	They are still supported but their usage is deprecated.

 	ccflags-y specifies options for compiling with $(CC).

diff --git a/drivers/ram/k3-ddrss/Makefile b/drivers/ram/k3-ddrss/Makefile
index 823d18871781..bb7dc05e3d99 100644
--- a/drivers/ram/k3-ddrss/Makefile
+++ b/drivers/ram/k3-ddrss/Makefile
@@ -6,16 +6,16 @@
 obj-$(CONFIG_K3_DDRSS) += k3-ddrss.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4_obj_if.o
 obj-$(CONFIG_K3_DDRSS) += lpddr4.o
-ccflags-$(CONFIG_K3_DDRSS) += -Idrivers/ram/k3-ddrss/
+ccflags-$(CONFIG_K3_DDRSS) += -I$(srctree)/drivers/ram/k3-ddrss/

 obj-$(CONFIG_K3_AM62A_DDRSS) += lpddr4_am6x.o
 obj-$(CONFIG_K3_AM62A_DDRSS) += lpddr4_am62a_ctl_regs_rw_masks.o
-ccflags-$(CONFIG_K3_AM62A_DDRSS) += -Idrivers/ram/k3-ddrss/am62a/
+ccflags-$(CONFIG_K3_AM62A_DDRSS) += -I$(srctree)/drivers/ram/k3-ddrss/am62a/

 obj-$(CONFIG_K3_AM64_DDRSS) += lpddr4_am6x.o
 obj-$(CONFIG_K3_AM64_DDRSS) += lpddr4_am64_ctl_regs_rw_masks.o
-ccflags-$(CONFIG_K3_AM64_DDRSS) += -Idrivers/ram/k3-ddrss/am64/
+ccflags-$(CONFIG_K3_AM64_DDRSS) += -I$(srctree)/drivers/ram/k3-ddrss/am64/

 obj-$(CONFIG_K3_J721E_DDRSS) += lpddr4_j721e.o
 obj-$(CONFIG_K3_J721E_DDRSS) += lpddr4_j721e_ctl_regs_rw_masks.o
-ccflags-$(CONFIG_K3_J721E_DDRSS) += -Idrivers/ram/k3-ddrss/j721e/
+ccflags-$(CONFIG_K3_J721E_DDRSS) += -I$(srctree)/drivers/ram/k3-ddrss/j721e/
diff --git a/dts/Makefile b/dts/Makefile
index fd4ae31a533b..bec6c49da2c9 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -41,7 +41,7 @@ $(obj)/dt.dtb: $(DTB) $(objtree)/tools/fdtgrep FORCE
 	$(call if_changed,fdt_rm_props)
 else
 $(obj)/dt.dtb: $(DTB) FORCE
-	$(call if_changed,shipped)
+	$(call if_changed,copy)
 endif

 targets += dt.dtb
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index bfa607c88274..f490081f6542 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -98,5 +98,5 @@ $(foreach f,$(apps-y),\
 	$(eval CFLAGS_$(f).o := $(CFLAGS_EFI) -Os -ffreestanding)\
 	$(eval CFLAGS_REMOVE_$(f).o := $(CFLAGS_NON_EFI)))

-always += $(foreach f,$(apps-y),$(f).efi)
+always-y += $(foreach f,$(apps-y),$(f).efi)
 targets += $(foreach f,$(apps-y),$(f).o)
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index fd7a744478fc..ece44b735061 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 ####
 # kbuild: Generic definitions

@@ -15,7 +16,11 @@ pound := \#
 dot-target = $(dir $@).$(notdir $@)

 ###
-# The temporary file to save gcc -MD generated dependencies must not
+# Name of target with a '.tmp_' as filename prefix. foo/bar.o => foo/.tmp_bar.o
+tmp-target = $(dir $@).tmp_$(notdir $@)
+
+###
+# The temporary file to save gcc -MMD generated dependencies must not
 # contain a comma
 depfile = $(subst $(comma),_,$(dot-target).d)

@@ -23,10 +28,6 @@ depfile = $(subst $(comma),_,$(dot-target).d)
 # filename of target with directory and extension stripped
 basetarget = $(basename $(notdir $@))

-###
-# filename of first prerequisite with directory and extension stripped
-baseprereq = $(basename $(notdir $<))
-
 ###
 # real prerequisites without phony targets
 real-prereqs = $(filter-out $(PHONY), $^)
@@ -36,8 +37,8 @@ real-prereqs = $(filter-out $(PHONY), $^)
 escsq = $(subst $(squote),'\$(squote)',$1)

 ###
-# real prerequisites without phony targets
-real-prereqs = $(filter-out $(PHONY), $^)
+# Quote a string to pass it to C files. foo => '"foo"'
+stringify = $(squote)$(quote)$1$(quote)$(squote)

 ###
 # Easy method for doing a status message
@@ -49,6 +50,7 @@ kecho := $($(quiet)kecho)
 ###
 # filechk is used to check if the content of a generated file is updated.
 # Sample usage:
+#
 # filechk_sample = echo $(KERNELRELEASE)
 # version.h: FORCE
 #	$(call filechk,sample)
@@ -58,141 +60,24 @@ kecho := $($(quiet)kecho)
 # - If no file exist it is created
 # - If the content differ the new file is used
 # - If they are equal no change, and no timestamp update
-# - stdin is piped in from the first prerequisite ($<) so one has
-#   to specify a valid file as first prerequisite (often the kbuild file)
 define filechk
-	$(Q)set -e;				\
-	mkdir -p $(dir $@);			\
-	$(filechk_$(1)) < $< > $@.tmp;		\
-	if [ -r $@ ] && cmp -s $@ $@.tmp; then	\
-		rm -f $@.tmp;			\
-	else					\
-		$(kecho) '  UPD     $@';	\
-		mv -f $@.tmp $@;		\
+	$(check-FORCE)
+	$(Q)set -e;						\
+	mkdir -p $(dir $@);					\
+	trap "rm -f $(dot-target).tmp" EXIT;			\
+	{ $(filechk_$(1)); } > $(dot-target).tmp;		\
+	if [ ! -r $@ ] || ! cmp -s $@ $(dot-target).tmp; then	\
+		$(kecho) '  UPD     $@';			\
+		mv -f $(dot-target).tmp $@;			\
 	fi
 endef

-######
-# gcc support functions
-# See documentation in Documentation/kbuild/makefiles.txt
-
-# cc-cross-prefix
-# Usage: CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
-# Return first prefix where a prefix$(CC) is found in PATH.
-# If no $(CC) found in PATH with listed prefixes return nothing
-cc-cross-prefix =  \
-	$(word 1, $(foreach c,$(1),                                   \
-		$(shell set -e;                                       \
-		if (which $(strip $(c))$(CC)) > /dev/null 2>&1 ; then \
-			echo $(c);                                    \
-		fi)))
-
-# output directory for tests below
-TMPOUT := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/)
-
-# try-run
-# Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
-# Exit code chooses option. "$$TMP" is can be used as temporary file and
-# is automatically cleaned up.
-# modifed for U-Boot: prevent cc-option from leaving .*.su files
-try-run = $(shell set -e;		\
-	TMP="$(TMPOUT).$$$$.tmp";	\
-	TMPO="$(TMPOUT).$$$$.o";	\
-	TMPSU="$(TMPOUT).$$$$.su";	\
-	if ($(1)) >/dev/null 2>&1;	\
-	then echo "$(2)";		\
-	else echo "$(3)";		\
-	fi;				\
-	rm -f "$$TMP" "$$TMPO" "$$TMPSU")
-
-# as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
-
-as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
-
-# as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
-
-as-instr = $(call try-run,\
-	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
-
-# __cc-option
-# Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
-__cc-option = $(call try-run,\
-	$(1) -Werror $(2) $(3) -c -x c /dev/null -o "$$TMP",$(3),$(4))
-
-# cc-option
-# Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
-cc-option = $(call __cc-option, $(CC),\
-	$(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS),$(1),$(2))
-
-# hostcc-option
-# Usage: cflags-y += $(call hostcc-option,-march=winchip-c6,-march=i586)
-hostcc-option = $(call __cc-option, $(HOSTCC),\
-	$(HOSTCFLAGS) $(HOST_EXTRACFLAGS),$(1),$(2))
-
-# cc-option-yn
-# Usage: flag := $(call cc-option-yn,-march=winchip-c6)
-cc-option-yn = $(call try-run,\
-	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
-
-# cc-disable-warning
-# Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
-cc-disable-warning = $(call try-run,\
-	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
-
-# cc-name
-# Expands to either gcc or clang
-cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
-
-# cc-version
-cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
-
-# cc-ifversion
-# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
-cc-ifversion = $(shell [ $(cc-version) $(1) $(2) ] && echo $(3) || echo $(4))
-
-# added for U-Boot
-binutils-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/binutils-version.sh $(AS))
-dtc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/dtc-version.sh $(DTC))
-
-# cc-ldoption
-# Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
-cc-ldoption = $(call try-run,\
-	$(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
-
-# ld-option
-# Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
-ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
-
-# ar-option
-# Usage: KBUILD_ARFLAGS := $(call ar-option,D)
-# Important: no spaces around options
-ar-option = $(call try-run, $(AR) rc$(1) "$$TMP",$(1),$(2))
-
-# ld-version
-# Note this is mainly for HJ Lu's 3 number binutil versions
-ld-version = $(shell $(LD) --version | $(srctree)/scripts/ld-version.sh)
-
-# ld-ifversion
-# Usage:  $(call ld-ifversion, -ge, 22252, y)
-ld-ifversion = $(shell [ $(ld-version) $(1) $(2) ] && echo $(3) || echo $(4))
-
-######
-
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
 # Usage:
 # $(Q)$(MAKE) $(build)=dir
 build := -f $(srctree)/scripts/Makefile.build obj

-###
-# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.modbuiltin obj=
-# Usage:
-# $(Q)$(MAKE) $(modbuiltin)=dir
-modbuiltin := -f $(srctree)/scripts/Makefile.modbuiltin obj
-
 ###
 # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.dtbinst obj=
 # Usage:
@@ -205,30 +90,18 @@ dtbinst := -f $(srctree)/scripts/Makefile.dtbinst obj
 # $(Q)$(MAKE) $(clean)=dir
 clean := -f $(srctree)/scripts/Makefile.clean obj

-###
-# Shorthand for $(Q)$(MAKE) -f scripts/Makefile.headersinst obj=
-# Usage:
-# $(Q)$(MAKE) $(hdr-inst)=dir
-hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
-
-# Prefix -I with $(srctree) if it is not an absolute path.
-# skip if -I has no parameter
-addtree = $(if $(patsubst -I%,%,$(1)), \
-$(if $(filter-out -I/% -I./% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)),$(1)),$(1))
-
-# Find all -I options and call addtree
-flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
-
 # echo command.
 # Short version is used, if $(quiet) equals `quiet_', otherwise full one.
 echo-cmd = $(if $($(quiet)cmd_$(1)),\
 	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(echo-why)';)

-# printing commands
-cmd = @set -e; $(echo-cmd) $(cmd_$(1))
+# sink stdout for 'make -s'
+       redirect :=
+ quiet_redirect :=
+silent_redirect := exec >/dev/null;

-# Add $(obj)/ for paths that are not absolute
-objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
+# printing commands
+cmd = @set -e; $(echo-cmd) $($(quiet)redirect) $(cmd_$(1))

 ###
 # if_changed      - execute command if any prerequisite is newer than
@@ -236,15 +109,15 @@ objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
 # if_changed_dep  - as if_changed, but uses fixdep to reveal dependencies
 #                   including used config symbols
 # if_changed_rule - as if_changed but execute rule instead
-# See doc/develop/makefiles.rst for more info
+# See Documentation/kbuild/makefiles.rst for more info

 ifneq ($(KBUILD_NOCMDDEP),1)
-# Check if both arguments are the same including their order. Result is empty
+# Check if both commands are the same including their order. Result is empty
 # string if equal. User may override this check using make KBUILD_NOCMDDEP=1
-arg-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
+cmd-check = $(filter-out $(subst $(space),$(space_escape),$(strip $(cmd_$@))), \
                          $(subst $(space),$(space_escape),$(strip $(cmd_$1))))
 else
-arg-check = $(if $(strip $(cmd_$@)),,1)
+cmd-check = $(if $(strip $(cmd_$@)),,1)
 endif

 # Replace >$< with >$$< to preserve $ when reloading the .cmd file
@@ -255,32 +128,41 @@ endif
 # (needed for the shell)
 make-cmd = $(call escsq,$(subst $(pound),$$(pound),$(subst $$,$$$$,$(cmd_$(1)))))

-# Find any prerequisites that is newer than target or that does not exist.
+# Find any prerequisites that are newer than target or that do not exist.
+# (This is not true for now; $? should contain any non-existent prerequisites,
+# but it does not work as expected when .SECONDARY is present. This seems a bug
+# of GNU Make.)
 # PHONY targets skipped in both cases.
-any-prereq = $(filter-out $(PHONY),$?) $(filter-out $(PHONY) $(wildcard $^),$^)
+newer-prereqs = $(filter-out $(PHONY),$?)
+
+# It is a typical mistake to forget the FORCE prerequisite. Check it here so
+# no more breakage will slip in.
+check-FORCE = $(if $(filter FORCE, $^),,$(warning FORCE prerequisite is missing))
+
+if-changed-cond = $(newer-prereqs)$(cmd-check)$(check-FORCE)

 # Execute command if command has changed or prerequisite(s) are updated.
-#
-if_changed = $(if $(strip $(any-prereq) $(arg-check)),                       \
-	@set -e;                                                             \
-	$(echo-cmd) $(cmd_$(1));                                             \
-	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
+if_changed = $(if $(if-changed-cond),$(cmd_and_savecmd),@:)
+
+cmd_and_savecmd =                                                            \
+	$(cmd);                                                              \
+	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd

 # Execute the command and also postprocess generated .d dependencies file.
-if_changed_dep = $(if $(strip $(any-prereq) $(arg-check)),$(cmd_and_fixdep),@:)
+if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)

-cmd_and_fixdep =						             \
-	$(cmd);							             \
+cmd_and_fixdep =                                                             \
+	$(cmd);                                                              \
 	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
 	rm -f $(depfile)

 # Usage: $(call if_changed_rule,foo)
 # Will check if $(cmd_foo) or any of the prerequisites changed,
 # and if so will execute $(rule_foo).
-if_changed_rule = $(if $(strip $(any-prereq) $(arg-check)),$(rule_$(1)),@:)
+if_changed_rule = $(if $(if-changed-cond),$(rule_$(1)),@:)

 ###
-# why - tell why a a target got build
+# why - tell why a target got built
 #       enabled by make V=2
 #       Output (listed in the order they are checked):
 #          (1) - due to target is PHONY
@@ -302,8 +184,8 @@ ifeq ($(KBUILD_VERBOSE),2)
 why =                                                                        \
     $(if $(filter $@, $(PHONY)),- due to target is PHONY,                    \
         $(if $(wildcard $@),                                                 \
-            $(if $(strip $(any-prereq)),- due to: $(any-prereq),             \
-                $(if $(arg-check),                                           \
+            $(if $(newer-prereqs),- due to: $(newer-prereqs),                \
+                $(if $(cmd-check),                                           \
                     $(if $(cmd_$@),- due to command line change,             \
                         $(if $(filter $@, $(targets)),                       \
                             - due to missing .cmd file,                      \
@@ -319,22 +201,10 @@ why =                                                                        \
 echo-why = $(call escsq, $(strip $(why)))
 endif

+###############################################################################
+
 # delete partially updated (i.e. corrupted) files on error
 .DELETE_ON_ERROR:

 # do not delete intermediate files automatically
 .SECONDARY:
-
-ifeq ($(CONFIG_SPL_BUILD),y)
-PHASE_ := SPL_
-else
-ifeq ($(CONFIG_VPL_BUILD),y)
-PHASE_ := VPL_
-else
-ifeq ($(CONFIG_TPL_BUILD),y)
-PHASE_ := TPL_
-else
-PHASE_ :=
-endif
-endif
-endif
diff --git a/scripts/Kbuild.uboot b/scripts/Kbuild.uboot
new file mode 100644
index 000000000000..398062970ab7
--- /dev/null
+++ b/scripts/Kbuild.uboot
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+####
+# kbuild.uboot: U-Boot specific kbuild definitions
+
+include $(srctree)/scripts/Kbuild.include
+
+# Prefix -I with $(srctree) if it is not an absolute path.
+# skip if -I has no parameter
+addtree = $(if $(patsubst -I%,%,$(1)), \
+$(if $(filter-out -I/% -I./% -I../%,$(1)),$(patsubst -I%,-I$(srctree)/%,$(1)),$(1)),$(1))
+
+# Find all -I options and call addtree
+flags = $(foreach o,$($(1)),$(if $(filter -I%,$(o)),$(call addtree,$(o)),$(o)))
+
+# Add $(obj)/ for paths that are not absolute
+objectify = $(foreach o,$(1),$(if $(filter /%,$(o)),$(o),$(obj)/$(o)))
+
+# echo command.
+# Short version is used, if $(quiet) equals `quiet_', otherwise full one.
+echo-cmd = $(if $($(quiet)cmd_$(1)),\
+	echo '  $(call escsq,$($(quiet)cmd_$(1)))$(why)';)
+
+# added for U-Boot
+
+# cc-name
+# Expands to either gcc or clang
+cc-name = $(shell $(CC) -v 2>&1 | grep -q "clang version" && echo clang || echo gcc)
+
+# cc-version
+cc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-version.sh $(CC))
+
+binutils-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/binutils-version.sh $(AS))
+dtc-version = $(shell $(CONFIG_SHELL) $(srctree)/scripts/dtc-version.sh $(DTC))
+
+ifeq ($(CONFIG_SPL_BUILD),y)
+PHASE_ := SPL_
+else
+ifeq ($(CONFIG_VPL_BUILD),y)
+PHASE_ := VPL_
+else
+ifeq ($(CONFIG_TPL_BUILD),y)
+PHASE_ := TPL_
+else
+PHASE_ :=
+endif
+endif
+endif
diff --git a/scripts/Makefile b/scripts/Makefile
index 8731e6cecd78..709b8e5622a9 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -4,9 +4,7 @@
 # the kernel for the build process.
 # ---------------------------------------------------------------------------

-hostprogs-$(CONFIG_BUILD_BIN2C)		+= bin2c
-
-always		:= $(hostprogs-y)
+hostprogs-always-$(CONFIG_BUILD_BIN2C)		+= bin2c

 # Let clean descend into subdirs
 subdir-	+= basic kconfig dtc
diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
index c1eab2f3a1dd..e3c88badb529 100644
--- a/scripts/Makefile.autoconf
+++ b/scripts/Makefile.autoconf
@@ -24,7 +24,9 @@ endif

 include include/config/auto.conf

-include scripts/Kbuild.include
+# include scripts/Kbuild.include
+include scripts/Kbuild.uboot
+include scripts/Makefile.compiler

 # Need to define CC and CPP again here in case the top Makefile did not
 # include config.mk.  Some architectures expect CROSS_COMPILE to be defined
@@ -36,7 +38,7 @@ include config.mk

 UBOOTINCLUDE    := \
 		-Iinclude \
-		$(if $(KBUILD_SRC), -I$(srctree)/include) \
+		$(if $(building_out_of_srctree), -I$(srctree)/include) \
 		-I$(srctree)/arch/$(ARCH)/include \
 		-include $(srctree)/include/linux/kconfig.h

@@ -129,14 +131,14 @@ include/config.h: scripts/Makefile.autoconf create_symlink FORCE
 PHONY += create_symlink
 create_symlink:
 ifdef CONFIG_CREATE_ARCH_SYMLINK
-ifneq ($(KBUILD_SRC),)
+ifdef building_out_of_srctree
 	$(Q)mkdir -p include/asm
-	$(Q)if [ -d $(KBUILD_SRC)/arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
+	$(Q)if [ -d $(srctree)/arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
 		dest=arch/$(ARCH)/mach-$(SOC)/include/mach;			\
 	else									\
 		dest=arch/$(ARCH)/include/asm/arch-$(if $(SOC),$(SOC),$(CPU));	\
 	fi;									\
-	ln -fsn $(KBUILD_SRC)/$$dest include/asm/arch
+	ln -fsn $(srctree)/$$dest include/asm/arch
 else
 	$(Q)if [ -d arch/$(ARCH)/mach-$(SOC)/include/mach ]; then	\
 		dest=../../mach-$(SOC)/include/mach;			\
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 998679f00a0d..8da9851d4308 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -28,7 +28,8 @@ obj-y :=
 obj-m :=
 lib-y :=
 lib-m :=
-always :=
+always-y :=
+always-m :=
 targets :=
 subdir-y :=
 subdir-m :=
@@ -38,6 +39,7 @@ EXTRA_CPPFLAGS :=
 EXTRA_LDFLAGS  :=
 asflags-y  :=
 ccflags-y  :=
+rustflags-y :=
 cppflags-y :=
 ldflags-y  :=

@@ -49,51 +51,70 @@ subdir-ccflags-y :=
 -include include/config/auto.conf
 -include $(prefix)/include/autoconf.mk

-include scripts/Kbuild.include
+# include scripts/Kbuild.include
+include scripts/Kbuild.uboot
+include scripts/Makefile.compiler

 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-kbuild-file := $(if $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Kbuild,$(kbuild-dir)/Makefile)
-include $(kbuild-file)
+include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)

 # Added for U-Boot
 asflags-y  += $(PLATFORM_CPPFLAGS)
 ccflags-y  += $(PLATFORM_CPPFLAGS)
 cppflags-y += $(PLATFORM_CPPFLAGS)

-include scripts/Makefile.lib
+include $(srctree)/scripts/Makefile.lib

-# Do not include host rules unless needed
-ifneq ($(hostprogs-y)$(hostprogs-m)$(hostlibs-y)$(hostlibs-m)$(hostcxxlibs-y)$(hostcxxlibs-m),)
-include scripts/Makefile.host
+# Do not include hostprogs rules unless needed.
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
+hostprogs := $(sort $(hostprogs))
+ifneq ($(hostprogs),)
+include $(srctree)/scripts/Makefile.host
+endif
+
+# Do not include userprogs rules unless needed.
+# $(sort ...) is used here to remove duplicated words and excessive spaces.
+userprogs := $(sort $(userprogs))
+ifneq ($(userprogs),)
+include $(srctree)/scripts/Makefile.userprogs
 endif

 ifndef obj
 $(warning kbuild: Makefile.build is included improperly)
 endif

+ifeq ($(need-modorder),)
+ifneq ($(obj-m),)
+$(warning $(patsubst %.o,'%.ko',$(obj-m)) will not be built even though obj-m is specified.)
+$(warning You cannot use subdir-y/m to visit a module Makefile. Use obj-y/m instead.)
+endif
+endif
+
 # ===========================================================================

+# subdir-builtin and subdir-modorder may contain duplications. Use $(sort ...)
+subdir-builtin := $(sort $(filter %/built-in.a, $(real-obj-y)))
+subdir-modorder := $(sort $(filter %/modules.order, $(obj-m)))
+
+targets-for-builtin := $(extra-y)
+
 ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
-lib-target := $(obj)/lib.a
-# Modified for U-Boot
-# real-obj-y += $(obj)/lib-ksyms.o
+targets-for-builtin += $(obj)/lib.a
 endif

-ifneq ($(strip $(real-obj-y) $(need-builtin)),)
-builtin-target := $(obj)/built-in.a
+ifdef need-builtin
+targets-for-builtin += $(obj)/built-in.a
 endif

-ifdef CONFIG_MODULES
-modorder-target := $(obj)/modules.order
-endif
+targets-for-modules := $(foreach x, o mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
+				$(patsubst %.o, %.$x, $(filter %.o, $(obj-m))))

-# We keep a list of all modules in $(MODVERDIR)
+ifdef need-modorder
+targets-for-modules += $(obj)/modules.order
+endif

-__build: $(if $(KBUILD_BUILTIN),$(builtin-target) $(lib-target) $(extra-y)) \
-	 $(if $(KBUILD_MODULES),$(obj-m) $(modorder-target)) \
-	 $(subdir-ym) $(always)
-	@:
+targets += $(targets-for-builtin) $(targets-for-modules)

 # Linus' kernel sanity checking tool
 ifeq ($(KBUILD_CHECKSRC),1)
@@ -104,30 +125,15 @@ else ifeq ($(KBUILD_CHECKSRC),2)
         cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $<
 endif

-ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
+ifneq ($(KBUILD_EXTRA_WARN),)
   cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
 endif

-# Do section mismatch analysis for each module/built-in.a
-ifdef CONFIG_DEBUG_SECTION_MISMATCH
-  cmd_secanalysis = ; scripts/mod/modpost $@
-endif
-
 # Compile C sources (.c)
 # ---------------------------------------------------------------------------

-# Default is built-in, unless we know otherwise
-$(foreach x, i ll lst o s symtypes, $(patsubst %.o,%.$(x),$(real-obj-m))): \
-	part-of-module := y
-
-modkern_cflags =                                          \
-	$(if $(part-of-module),                           \
-		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
-		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL))
-quiet_modtag = $(if $(part-of-module),[M],   )
-
 quiet_cmd_cc_s_c = CC $(quiet_modtag)  $@
-      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS), $(c_flags)) $(DISABLE_LTO) -fverbose-asm -S -o $@ $<
+      cmd_cc_s_c = $(CC) $(filter-out $(DEBUG_CFLAGS) $(CC_FLAGS_LTO), $(c_flags)) -fverbose-asm -S -o $@ $<

 $(obj)/%.s: $(src)/%.c FORCE
 	$(call if_changed_dep,cc_s_c)
@@ -138,18 +144,16 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(src)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)

+genksyms = scripts/genksyms/genksyms		\
+	$(if $(1), -T $(2))			\
+	$(if $(KBUILD_PRESERVE), -p)		\
+	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
+
 # These mirror gensymtypes_S and co below, keep them in synch.
-cmd_gensymtypes_c =                                                         \
-    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
-    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
-     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
-     $(if $(KBUILD_PRESERVE),-p)                                            \
-     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
+cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)

 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_c =                                                         \
-    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
+      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@) >/dev/null

 $(obj)/%.symtypes : $(src)/%.c FORCE
 	$(call cmd,cc_symtypes_c)
@@ -166,8 +170,18 @@ $(obj)/%.ll: $(src)/%.c FORCE
 # The C file is compiled and updated dependency information is generated.
 # (See cmd_cc_o_c + relevant part of rule_cc_o_c)

+is-single-obj-m = $(and $(part-of-module),$(filter $@, $(obj-m)),y)
+
+# When a module consists of a single object, there is no reason to keep LLVM IR.
+# Make $(LD) covert LLVM IR to ELF here.
+ifdef CONFIG_LTO_CLANG
+cmd_ld_single_m = $(if $(is-single-obj-m), ; $(LD) $(ld_flags) -r -o $(tmp-target) $@; mv $(tmp-target) $@)
+endif
+
 quiet_cmd_cc_o_c = CC $(quiet_modtag)  $@
-      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
+      cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $< \
+		$(cmd_ld_single_m) \
+		$(cmd_objtool)

 ifdef CONFIG_MODVERSIONS
 # When module versioning is enabled the following steps are executed:
@@ -175,27 +189,21 @@ ifdef CONFIG_MODVERSIONS
 # o if <file>.o doesn't contain a __ksymtab version, i.e. does
 #   not export symbols, it's done.
 # o otherwise, we calculate symbol versions using the good old
-#   genksyms on the preprocessed source and postprocess them in a way
-#   that they are usable as a linker script
-# o generate .tmp_<file>.o from <file>.o using the linker to
-#   replace the unresolved symbols __crc_exported_symbol with
-#   the actual value of the checksum generated by genksyms
-# o remove .tmp_<file>.o to <file>.o
-
-cmd_modversions_c =								\
-	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
-		$(call cmd_gensymtypes_c,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
-		    > $(@D)/.tmp_$(@F:.o=.ver);					\
-										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
-			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		mv -f $(@D)/.tmp_$(@F) $@;					\
-		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
+#   genksyms on the preprocessed source and dump them into the .cmd file.
+# o modpost will extract versions from that file and create *.c files that will
+#   be compiled and linked to the kernel and/or modules.
+
+gen_symversions =								\
+	if $(NM) $@ 2>/dev/null | grep -q __ksymtab; then			\
+		$(call cmd_gensymtypes_$(1),$(KBUILD_SYMTYPES),$(@:.o=.symtypes)) \
+			>> $(dot-target).cmd;					\
 	fi
+
+cmd_gen_symversions_c =	$(call gen_symversions,c)
+
 endif

-ifdef CONFIG_FTRACE_MCOUNT_RECORD
-ifndef CC_USING_RECORD_MCOUNT
+ifdef CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT
 # compiler will not generate __mcount_loc use recordmcount or recordmcount.pl
 ifdef BUILD_C_RECORDMCOUNT
 ifeq ("$(origin RECORDMCOUNT_WARN)", "command line")
@@ -222,87 +230,60 @@ recordmcount_source := $(srctree)/scripts/recordmcount.pl
 endif # BUILD_C_RECORDMCOUNT
 cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),	\
 	$(sub_cmd_record_mcount))
-endif # CC_USING_RECORD_MCOUNT
-endif # CONFIG_FTRACE_MCOUNT_RECORD
-
-ifdef CONFIG_STACK_VALIDATION
-ifneq ($(SKIP_STACK_VALIDATION),1)
-
-__objtool_obj := $(objtree)/tools/objtool/objtool
-
-objtool_args = $(if $(CONFIG_UNWINDER_ORC),orc generate,check)
-
-objtool_args += $(if $(part-of-module), --module,)
-
-ifndef CONFIG_FRAME_POINTER
-objtool_args += --no-fp
-endif
-ifdef CONFIG_GCOV_KERNEL
-objtool_args += --no-unreachable
-endif
-ifdef CONFIG_RETPOLINE
-  objtool_args += --retpoline
-endif
+endif # CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT

 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
 # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
-cmd_objtool = $(if $(patsubst y%,, \
-	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
-	$(__objtool_obj) $(objtool_args) $@)
-objtool_obj = $(if $(patsubst y%,, \
-	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n), \
-	$(__objtool_obj))

-endif # SKIP_STACK_VALIDATION
-endif # CONFIG_STACK_VALIDATION
+is-standard-object = $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)

-# Rebuild all objects when objtool changes, or is enabled/disabled.
-objtool_dep = $(objtool_obj)					\
-	      $(wildcard include/config/orc/unwinder.h		\
-			 include/config/stack/validation.h)
+$(obj)/%.o: objtool-enabled = $(if $(is-standard-object),$(if $(delay-objtool),$(is-single-obj-m),y))

 ifdef CONFIG_TRIM_UNUSED_KSYMS
 cmd_gen_ksymdeps = \
 	$(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-target).cmd
 endif

+cmd_check_local_export = $(srctree)/scripts/check-local-export $@
+
 define rule_cc_o_c
-	$(call cmd,checksrc)
 	$(call cmd_and_fixdep,cc_o_c)
 	$(call cmd,gen_ksymdeps)
+	$(call cmd,check_local_export)
+	$(call cmd,checksrc)
 	$(call cmd,checkdoc)
-	$(call cmd,objtool)
-	$(call cmd,modversions_c)
+	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_symversions_c)
 	$(call cmd,record_mcount)
 endef

 define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
-	$(call cmd,objtool)
-	$(call cmd,modversions_S)
+	$(call cmd,check_local_export)
+	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_symversions_S)
 endef

-# List module undefined symbols (or empty line if not enabled)
-ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $@ | sed -n 's/^  *U //p' | xargs echo
-else
-cmd_undef_syms = echo
-endif
-
 # Built-in and composite module parts
-$(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
-	$(call cmd,force_checksrc)
+$(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)

-# Single-part modules are special since we need to mark them in $(MODVERDIR)
+# To make this rule robust against "Argument list too long" error,
+# ensure to add $(obj)/ prefix by a shell command.
+cmd_mod = printf '%s\n' $(call real-search, $*.o, .o, -objs -y -m) | \
+	$(AWK) '!x[$$0]++ { print("$(obj)/"$$0) }' > $@

-$(single-used-m): $(obj)/%.o: $(src)/%.c $(recordmcount_source) $(objtool_dep) FORCE
-	$(call cmd,force_checksrc)
-	$(call if_changed_rule,cc_o_c)
-	@{ echo $(@:.o=.ko); echo $@; \
-	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
+$(obj)/%.mod: FORCE
+	$(call if_changed,mod)
+
+# List module undefined symbols
+cmd_undefined_syms = $(NM) $< | sed -n 's/^  *U //p' > $@
+
+$(obj)/%.usyms: $(obj)/%.o FORCE
+	$(call if_changed,undefined_syms)

 quiet_cmd_cc_lst_c = MKLST   $@
       cmd_cc_lst_c = $(CC) $(c_flags) -g -c -o $*.o $< && \
@@ -315,11 +296,6 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile assembler sources (.S)
 # ---------------------------------------------------------------------------

-modkern_aflags := $(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL)
-
-$(real-obj-m)      : modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
-$(real-obj-m:.o=.s): modkern_aflags := $(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE)
-
 # .S file exports must have their C prototypes defined in asm/asm-prototypes.h
 # or a file that it includes, in order to get versioned symbols. We build a
 # dummy C file that includes asm-prototypes and the EXPORT_SYMBOL lines from
@@ -337,16 +313,10 @@ cmd_gensymtypes_S =                                                         \
     $(CPP) $(a_flags) $< |                                                  \
      grep "\<___EXPORT_SYMBOL\>" |                                          \
      sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
-    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
-    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
-     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
-     $(if $(KBUILD_PRESERVE),-p)                                            \
-     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
+    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)

 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_S =                                                         \
-    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
+      cmd_cc_symtypes_S = $(call cmd_gensymtypes_S,true,$@) >/dev/null

 $(obj)/%.symtypes : $(src)/%.S FORCE
 	$(call cmd,cc_symtypes_S)
@@ -359,36 +329,23 @@ $(obj)/%.s: $(src)/%.S FORCE
 	$(call if_changed_dep,cpp_s_S)

 quiet_cmd_as_o_S = AS $(quiet_modtag)  $@
-      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $<
-
-ifdef CONFIG_MODVERSIONS
-
-ASM_PROTOTYPES := $(wildcard $(srctree)/arch/$(SRCARCH)/include/asm/asm-prototypes.h)
+      cmd_as_o_S = $(CC) $(a_flags) -c -o $@ $< $(cmd_objtool)

-ifneq ($(ASM_PROTOTYPES),)
+ifdef CONFIG_ASM_MODVERSIONS

 # versioning matches the C process described above, with difference that
 # we parse asm-prototypes.h C header to get function definitions.

-cmd_modversions_S =								\
-	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
-		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
-		    > $(@D)/.tmp_$(@F:.o=.ver);					\
-										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
-			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		mv -f $(@D)/.tmp_$(@F) $@;					\
-		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
-	fi
-endif
+cmd_gen_symversions_S = $(call gen_symversions,S)
+
 endif

-$(obj)/%.o: $(src)/%.S $(objtool_dep) FORCE
+$(obj)/%.o: $(src)/%.S FORCE
 	$(call if_changed_rule,as_o_S)

-targets += $(filter-out $(subdir-obj-y), $(real-obj-y)) $(real-obj-m) $(lib-y)
-targets += $(extra-y) $(MAKECMDGOALS) $(always)
-targets += $(real-dtb-y) $(lib-y) $(always-y)
+targets += $(filter-out $(subdir-builtin), $(real-obj-y))
+targets += $(filter-out $(subdir-modorder), $(real-obj-m))
+targets += $(real-dtb-y) $(lib-y) $(always-y) $(MAKECMDGOALS)

 # Linker scripts preprocessor (.lds.S -> .lds)
 # ---------------------------------------------------------------------------
@@ -401,9 +358,9 @@ $(obj)/%.lds: $(src)/%.lds.S FORCE

 # ASN.1 grammar
 # ---------------------------------------------------------------------------
-quiet_cmd_asn1_compiler = ASN.1   $@
+quiet_cmd_asn1_compiler = ASN.1   $(basename $@).[ch]
       cmd_asn1_compiler = $(objtree)/tools/asn1_compiler $< \
-				$(subst .h,.c,$@) $(subst .c,.h,$@)
+				$(basename $@).c $(basename $@).h

 $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/tools/asn1_compiler
 	$(call cmd,asn1_compiler)
@@ -412,79 +369,59 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/tools/asn1_compiler
 # ---------------------------------------------------------------------------

 # To build objects in subdirs, we need to descend into the directories
-$(sort $(subdir-obj-y)): $(subdir-ym) ;
+$(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
+$(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;

 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
 #
-ifdef builtin-target
+# To make this rule robust against "Argument list too long" error,
+# remove $(obj)/ prefix, and restore it by a shell command.

 quiet_cmd_ar_builtin = AR      $@
 # Modified for U-Boot, we create thin archives directly, instead of using the kernel script
 # Check f49821ee32b76 and 6358d6e8b98 in kernel
-      cmd_ar_builtin = rm -f $@; $(AR) rcTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+      cmd_ar_builtin = rm -f $@; $(AR) rcTP $@ $(real-prereqs)

-$(builtin-target): $(real-obj-y) FORCE
+$(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)

-targets += $(builtin-target)
-endif # builtin-target
-
 #
 # Rule to create modules.order file
 #
 # Create commands to either record .ko file or cat modules.order from
 # a subdirectory
-modorder-cmds =						\
-	$(foreach m, $(modorder),			\
-		$(if $(filter %/modules.order, $m),	\
-			cat $m;, echo kernel/$m;))
+# Add $(obj-m) as the prerequisite to avoid updating the timestamp of
+# modules.order unless contained modules are updated.
+
+cmd_modules_order = { $(foreach m, $(real-prereqs), \
+	$(if $(filter %/modules.order, $m), cat $m, echo $(patsubst %.o,%.ko,$m));) :; } \
+	| $(AWK) '!x[$$0]++' - > $@

-$(modorder-target): $(subdir-ym) FORCE
-	$(Q)(cat /dev/null; $(modorder-cmds)) > $@
+$(obj)/modules.order: $(obj-m) FORCE
+	$(call if_changed,modules_order)

 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
 #
-ifdef lib-target

-$(lib-target): $(lib-y) FORCE
+$(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar)

-targets += $(lib-target)
-
-dummy-object = $(obj)/.lib_exports.o
-ksyms-lds = $(dot-target).lds
-
-quiet_cmd_export_list = EXPORTS $@
-cmd_export_list = $(OBJDUMP) -h $< | \
-	sed -ne '/___ksymtab/s/.*+\([^ ]*\).*/EXTERN(\1)/p' >$(ksyms-lds);\
-	rm -f $(dummy-object);\
-	echo | $(CC) $(a_flags) -c -o $(dummy-object) -x assembler -;\
-	$(LD) $(ld_flags) -r -o $@ -T $(ksyms-lds) $(dummy-object);\
-	rm $(dummy-object) $(ksyms-lds)
-
-$(obj)/lib-ksyms.o: $(lib-target) FORCE
-	$(call if_changed,export_list)
+quiet_cmd_ld_multi_m = LD [M]  $@
+      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)

-targets += $(obj)/lib-ksyms.o
-
-endif
-
-# NOTE:
-# Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
-# module is turned into a multi object module, $^ will contain header file
-# dependencies recorded in the .*.cmd file.
-quiet_cmd_link_multi-m = LD [M]  $@
-cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ $(filter %.o,$^) $(cmd_secanalysis)
+define rule_ld_multi_m
+	$(call cmd_and_savecmd,ld_multi_m)
+	$(call cmd,gen_objtooldep)
+endef

-$(multi-used-m): FORCE
-	$(call if_changed,link_multi-m)
-	@{ echo $(@:.o=.ko); echo $(filter %.o,$^); \
-	   $(cmd_undef_syms); } > $(MODVERDIR)/$(@F:.o=.mod)
-$(call multi_depend, $(multi-used-m), .o, -objs -y -m)
+$(multi-obj-m): objtool-enabled := $(delay-objtool)
+$(multi-obj-m): part-of-module := y
+$(multi-obj-m): %.o: %.mod FORCE
+	$(call if_changed_rule,ld_multi_m)
+$(call multi_depend, $(multi-obj-m), .o, -objs -y -m)

-targets += $(multi-used-m)
 targets := $(filter-out $(PHONY), $(targets))

 # Add intermediate targets:
@@ -502,12 +439,60 @@ targets += $(call intermediate_targets, .asn1.o, .asn1.c .asn1.h) \
 	   $(call intermediate_targets, .lex.o, .lex.c) \
 	   $(call intermediate_targets, .tab.o, .tab.c .tab.h)

+# Build
+# ---------------------------------------------------------------------------
+
+ifdef single-build
+
+KBUILD_SINGLE_TARGETS := $(filter $(obj)/%, $(KBUILD_SINGLE_TARGETS))
+
+curdir-single := $(sort $(foreach x, $(KBUILD_SINGLE_TARGETS), \
+			$(if $(filter $(x) $(basename $(x)).o, $(targets)), $(x))))
+
+# Handle single targets without any rule: show "Nothing to be done for ..." or
+# "No rule to make target ..." depending on whether the target exists.
+unknown-single := $(filter-out $(addsuffix /%, $(subdir-ym)), \
+			$(filter-out $(curdir-single), $(KBUILD_SINGLE_TARGETS)))
+
+single-subdirs := $(foreach d, $(subdir-ym), \
+			$(if $(filter $(d)/%, $(KBUILD_SINGLE_TARGETS)), $(d)))
+
+__build: $(curdir-single) $(single-subdirs)
+ifneq ($(unknown-single),)
+	$(Q)$(MAKE) -f /dev/null $(unknown-single)
+endif
+	@:
+
+ifeq ($(curdir-single),)
+# Nothing to do in this directory. Do not include any .*.cmd file for speed-up
+targets :=
+else
+targets += $(curdir-single)
+endif
+
+else
+
+__build: $(if $(KBUILD_BUILTIN), $(targets-for-builtin)) \
+	 $(if $(KBUILD_MODULES), $(targets-for-modules)) \
+	 $(subdir-ym) $(always-y)
+	@:
+#	@echo "My hostprogs => $(hostprogs)"
+#	@echo "My obj=$(obj)"
+#	@echo "My src=$(src)"
+#	@echo "My target-stem=$(target-stem)"
+#	@echo "My need-builtin=$(need-builtin)"
+
+endif
+
 # Descending
 # ---------------------------------------------------------------------------

 PHONY += $(subdir-ym)
 $(subdir-ym):
-	$(Q)$(MAKE) $(build)=$@ need-builtin=$(if $(findstring $@,$(subdir-obj-y)),1)
+	$(Q)$(MAKE) $(build)=$@ \
+	$(if $(filter $@/, $(KBUILD_SINGLE_TARGETS)),single-build=) \
+	need-builtin=$(if $(filter $@/built-in.a, $(subdir-builtin)),1) \
+	need-modorder=$(if $(filter $@/modules.order, $(subdir-modorder)),1)

 # Add FORCE to the prequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
@@ -526,7 +511,7 @@ existing-targets := $(wildcard $(sort $(targets)))
 -include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)

 # Create directories for object files if they do not exist
-obj-dirs := $(sort $(obj) $(patsubst %/,%, $(dir $(targets))))
+obj-dirs := $(sort $(patsubst %/,%, $(dir $(targets))))
 # If targets exist, their directories apparently exist. Skip mkdir.
 existing-dirs := $(sort $(patsubst %/,%, $(dir $(existing-targets))))
 obj-dirs := $(strip $(filter-out $(existing-dirs), $(obj-dirs)))
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index d5922e915def..1abbdc239463 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -8,26 +8,20 @@ src := $(obj)
 PHONY := __clean
 __clean:

-include scripts/Kbuild.include
+# include scripts/Kbuild.include
+include scripts/Kbuild.uboot
+include scripts/Makefile.compiler

 # The filename Kbuild has precedence over Makefile
 kbuild-dir := $(if $(filter /%,$(src)),$(src),$(srctree)/$(src))
-include $(if $(wildcard $(kbuild-dir)/Kbuild), $(kbuild-dir)/Kbuild, $(kbuild-dir)/Makefile)
+include $(or $(wildcard $(kbuild-dir)/Kbuild),$(kbuild-dir)/Makefile)
+

 # Figure out what we need to build from the various variables
 # ==========================================================================

-__subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
-subdir-y	+= $(__subdir-y)
-__subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
-subdir-m	+= $(__subdir-m)
-__subdir-	:= $(patsubst %/,%,$(filter %/, $(obj-)))
-subdir-		+= $(__subdir-)
-
-# Subdirectories we need to descend into
-
-subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
-subdir-ymn      := $(sort $(subdir-ym) $(subdir-))
+subdir-ymn := $(sort $(subdir-y) $(subdir-m) $(subdir-) \
+		$(patsubst %/,%, $(filter %/, $(obj-y) $(obj-m) $(obj-))))

 # Add subdir path

@@ -41,42 +35,25 @@ subdir-ymn	:= $(foreach f, $(subdir-ymn), \
 # build a list of files to remove, usually relative to the current
 # directory

-__clean-files	:= $(extra-y) $(extra-m) $(extra-)       \
-		   $(always) $(targets) $(clean-files)   \
-		   $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
-		   $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
-		   $(hostcxxlibs-y) $(hostcxxlibs-m)
+__clean-files	:= \
+	$(clean-files) $(targets) $(hostprogs) $(userprogs) \
+	$(extra-y) $(extra-m) $(extra-) \
+	$(always-y) $(always-m) $(always-) \
+	$(hostprogs-always-y) $(hostprogs-always-m) $(hostprogs-always-) \
+	$(userprogs-always-y) $(userprogs-always-m) $(userprogs-always-)

 __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))

-# clean-files is given relative to the current directory, unless it
-# starts with $(objtree)/ (which means "./", so do not add "./" unless
-# you want to delete a file from the toplevel object directory).
-
-__clean-files   := $(wildcard                                               \
-		   $(addprefix $(obj)/, $(filter-out $(objtree)/%, $(__clean-files))) \
-		   $(filter $(objtree)/%, $(__clean-files)))
-
-# same as clean-files
-
-__clean-dirs    := $(wildcard                                               \
-		   $(addprefix $(obj)/, $(filter-out $(objtree)/%, $(clean-dirs)))    \
-		   $(filter $(objtree)/%, $(clean-dirs)))
+__clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))

 # ==========================================================================

-quiet_cmd_clean    = CLEAN   $(obj)
-      cmd_clean    = rm -f $(__clean-files)
-quiet_cmd_cleandir = CLEAN   $(__clean-dirs)
-      cmd_cleandir = rm -rf $(__clean-dirs)
-
+quiet_cmd_clean = CLEAN   $(obj)
+      cmd_clean = rm -rf $(__clean-files)

 __clean: $(subdir-ymn)
 ifneq ($(strip $(__clean-files)),)
-	+$(call cmd,clean)
-endif
-ifneq ($(strip $(__clean-dirs)),)
-	+$(call cmd,cleandir)
+	$(call cmd,clean)
 endif
 	@:

diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
new file mode 100644
index 000000000000..94d0d40cddb3
--- /dev/null
+++ b/scripts/Makefile.compiler
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# cc-cross-prefix
+# Usage: CROSS_COMPILE := $(call cc-cross-prefix, m68k-linux-gnu- m68k-linux-)
+# Return first <prefix> where a <prefix>gcc is found in PATH.
+# If no gcc found in PATH with listed prefixes return nothing
+#
+# Note: '2>/dev/null' is here to force Make to invoke a shell. Otherwise, it
+# would try to directly execute the shell builtin 'command'. This workaround
+# should be kept for a long time since this issue was fixed only after the
+# GNU Make 4.2.1 release.
+cc-cross-prefix = $(firstword $(foreach c, $(1), \
+			$(if $(shell command -v -- $(c)gcc 2>/dev/null), $(c))))
+
+# output directory for tests below
+TMPOUT = $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_$$$$
+
+# try-run
+# Usage: option = $(call try-run, $(CC)...-o "$$TMP",option-ok,otherwise)
+# Exit code chooses option. "$$TMP" serves as a temporary file and is
+# automatically cleaned up.
+try-run = $(shell set -e;		\
+	TMP=$(TMPOUT)/tmp;		\
+	trap "rm -rf $(TMPOUT)" EXIT;	\
+	mkdir -p $(TMPOUT);		\
+	if ($(1)) >/dev/null 2>&1;	\
+	then echo "$(2)";		\
+	else echo "$(3)";		\
+	fi)
+
+# as-option
+# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+
+as-option = $(call try-run,\
+	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+
+# as-instr
+# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+
+as-instr = $(call try-run,\
+	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
+
+# __cc-option
+# Usage: MY_CFLAGS += $(call __cc-option,$(CC),$(MY_CFLAGS),-march=winchip-c6,-march=i586)
+__cc-option = $(call try-run,\
+	$(1) -Werror $(2) $(3) -c -x c /dev/null -o "$$TMP",$(3),$(4))
+
+# cc-option
+# Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
+
+cc-option = $(call __cc-option, $(CC),\
+	$(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS),$(1),$(2))
+
+# cc-option-yn
+# Usage: flag := $(call cc-option-yn,-march=winchip-c6)
+cc-option-yn = $(call try-run,\
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(1) -c -x c /dev/null -o "$$TMP",y,n)
+
+# cc-disable-warning
+# Usage: cflags-y += $(call cc-disable-warning,unused-but-set-variable)
+cc-disable-warning = $(call try-run,\
+	$(CC) -Werror $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
+
+# cc-ifversion
+# Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
+cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
+
+# ld-option
+# Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
+ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
+
+# ld-ifversion
+# Usage:  $(call ld-ifversion, -ge, 22252, y)
+ld-ifversion = $(shell [ $(CONFIG_LD_VERSION)0 $(1) $(2)0 ] && echo $(3) || echo $(4))
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 7df62263bc42..4e1714c9484b 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -13,11 +13,20 @@

 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)

+# backward compatibility
+KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
+
+ifeq ("$(origin W)", "command line")
+  KBUILD_EXTRA_WARN := $(W)
+endif
+
+export KBUILD_EXTRA_WARN
+
 KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
 KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)

 ifeq ("$(origin W)", "command line")
-  export KBUILD_ENABLE_EXTRA_GCC_CHECKS := $(W)
+  KBUILD_EXTRA_WARN := $(W)
 endif

 ifdef KBUILD_ENABLE_EXTRA_GCC_CHECKS
diff --git a/scripts/Makefile.host b/scripts/Makefile.host
index bd5ed4c63b7f..bb6d69ca37c8 100644
--- a/scripts/Makefile.host
+++ b/scripts/Makefile.host
@@ -1,5 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
-# ==========================================================================
+
+# LEX
+# ---------------------------------------------------------------------------
+quiet_cmd_flex = LEX     $@
+      cmd_flex = $(LEX) -o$@ -L $<
+
+$(obj)/%.lex.c: $(src)/%.l FORCE
+	$(call if_changed,flex)
+
+# YACC
+# ---------------------------------------------------------------------------
+quiet_cmd_bison = YACC    $(basename $@).[ch]
+      cmd_bison = $(YACC) -o $(basename $@).c --defines=$(basename $@).h -t -l $<
+
+$(obj)/%.tab.c $(obj)/%.tab.h: $(src)/%.y FORCE
+	$(call if_changed,bison)
+
+
 # Building binaries on the host system
 # Binaries are used during the compilation of the kernel, for example
 # to preprocess a data file.
@@ -7,83 +24,65 @@
 # Both C and C++ are supported, but preferred language is C for such utilities.
 #
 # Sample syntax (see Documentation/kbuild/makefiles.txt for reference)
-# hostprogs-y := bin2hex
+# hostprogs := bin2hex
 # Will compile bin2hex.c and create an executable named bin2hex
 #
-# hostprogs-y    := lxdialog
+# hostprogs    := lxdialog
 # lxdialog-objs := checklist.o lxdialog.o
 # Will compile lxdialog.c and checklist.c, and then link the executable
 # lxdialog, based on checklist.o and lxdialog.o
 #
-# hostprogs-y      := qconf
+# hostprogs      := qconf
 # qconf-cxxobjs   := qconf.o
 # qconf-objs      := menu.o
 # Will compile qconf as a C++ program, and menu as a C program.
 # They are linked as C++ code to the executable qconf

-__hostprogs := $(sort $(hostprogs-y) $(hostprogs-m))
-host-cshlib := $(sort $(hostlibs-y) $(hostlibs-m))
-host-cxxshlib := $(sort $(hostcxxlibs-y) $(hostcxxlibs-m))
-
 # C code
 # Executables compiled from a single .c file
-host-csingle	:= $(foreach m,$(__hostprogs), \
-			$(if $($(m)-objs)$($(m)-cxxobjs)$($(m)-sharedobjs),,$(m)))
+host-csingle	:= $(foreach m,$(hostprogs), \
+			$(if $($(m)-objs)$($(m)-cxxobjs),,$(m)))

 # C executables linked based on several .o files
-host-cmulti	:= $(foreach m,$(__hostprogs),\
+host-cmulti	:= $(foreach m,$(hostprogs),\
 		   $(if $($(m)-cxxobjs),,$(if $($(m)-objs),$(m))))

-# Shared object libraries
-host-shared	:= $(foreach m,$(__hostprogs),\
-		   $(if $($(m)-sharedobjs),$(m))))
-
 # Object (.o) files compiled from .c files
-host-cobjs	:= $(sort $(foreach m,$(__hostprogs),$($(m)-objs)))
+host-cobjs	:= $(sort $(foreach m,$(hostprogs),$($(m)-objs)))

 # C++ code
 # C++ executables compiled from at least one .cc file
 # and zero or more .c files
-host-cxxmulti	:= $(foreach m,$(__hostprogs),$(if $($(m)-cxxobjs),$(m)))
+host-cxxmulti	:= $(foreach m,$(hostprogs),$(if $($(m)-cxxobjs),$(m)))

 # C++ Object (.o) files compiled from .cc files
 host-cxxobjs	:= $(sort $(foreach m,$(host-cxxmulti),$($(m)-cxxobjs)))

-# Object (.o) files used by the shared libaries
-host-cshobjs	:= $(sort $(foreach m,$(host-cshlib),$($(m:.so=-objs))))
-host-cxxshobjs	:= $(sort $(foreach m,$(host-cxxshlib),$($(m:.so=-objs))))
-
 host-csingle	:= $(addprefix $(obj)/,$(host-csingle))
 host-cmulti	:= $(addprefix $(obj)/,$(host-cmulti))
 host-cobjs	:= $(addprefix $(obj)/,$(host-cobjs))
 host-cxxmulti	:= $(addprefix $(obj)/,$(host-cxxmulti))
 host-cxxobjs	:= $(addprefix $(obj)/,$(host-cxxobjs))
-host-cshlib	:= $(addprefix $(obj)/,$(host-cshlib))
-host-cxxshlib	:= $(addprefix $(obj)/,$(host-cxxshlib))
-host-cshobjs	:= $(addprefix $(obj)/,$(host-cshobjs))
-host-cxxshobjs	:= $(addprefix $(obj)/,$(host-cxxshobjs))
-host-shared	:= $(addprefix $(obj)/,$(host-shared))

 #####
 # Handle options to gcc. Support building with separate output directory

 _hostc_flags   = $(KBUILD_HOSTCFLAGS)   $(HOST_EXTRACFLAGS)   \
-                 $(HOSTCFLAGS_$(basetarget).o)
+                 $(HOSTCFLAGS_$(target-stem).o)
 _hostcxx_flags = $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
-                 $(HOSTCXXFLAGS_$(basetarget).o)
-
-__hostc_flags	= $(_hostc_flags)
-__hostcxx_flags	= $(_hostcxx_flags)
+                 $(HOSTCXXFLAGS_$(target-stem).o)

+# $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
-ifneq ($(KBUILD_SRC),)
-__hostc_flags	= -I$(obj) $(call flags,_hostc_flags)
-__hostcxx_flags	= -I$(obj) $(call flags,_hostcxx_flags)
+ifdef building_out_of_srctree
+# $(error objtree=$(objtree), obj=$(obj))
+_hostc_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
+_hostcxx_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
 endif
 endif

-hostc_flags    = -Wp,-MD,$(depfile) $(__hostc_flags)
-hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
+hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
+hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)

 #####
 # Compile programs on the host
@@ -92,7 +91,7 @@ hostcxx_flags  = -Wp,-MD,$(depfile) $(__hostcxx_flags)
 # host-csingle -> Executable
 quiet_cmd_host-csingle 	= HOSTCC  $@
       cmd_host-csingle	= $(HOSTCC) $(hostc_flags) $(KBUILD_HOSTLDFLAGS) -o $@ $< \
-	  	$(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
+		$(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(target-stem))
 $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 	$(call if_changed_dep,host-csingle)

@@ -100,8 +99,8 @@ $(host-csingle): $(obj)/%: $(src)/%.c FORCE
 # host-cmulti -> executable
 quiet_cmd_host-cmulti	= HOSTLD  $@
       cmd_host-cmulti	= $(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ \
-			  $(addprefix $(obj)/,$($(@F)-objs)) \
-			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
+			  $(addprefix $(obj)/, $($(target-stem)-objs)) \
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(target-stem))
 $(host-cmulti): FORCE
 	$(call if_changed,host-cmulti)
 $(call multi_depend, $(host-cmulti), , -objs)
@@ -118,8 +117,8 @@ $(host-cobjs): $(obj)/%.o: $(src)/%.c FORCE
 quiet_cmd_host-cxxmulti	= HOSTLD  $@
       cmd_host-cxxmulti	= $(HOSTCXX) $(KBUILD_HOSTLDFLAGS) -o $@ \
 			  $(foreach o,objs cxxobjs,\
-			  $(addprefix $(obj)/,$($(@F)-$(o)))) \
-			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(@F))
+			  $(addprefix $(obj)/, $($(target-stem)-$(o)))) \
+			  $(KBUILD_HOSTLDLIBS) $(HOSTLDLIBS_$(target-stem))
 $(host-cxxmulti): FORCE
 	$(call if_changed,host-cxxmulti)
 $(call multi_depend, $(host-cxxmulti), , -objs -cxxobjs)
@@ -130,43 +129,5 @@ quiet_cmd_host-cxxobjs	= HOSTCXX $@
 $(host-cxxobjs): $(obj)/%.o: $(src)/%.cc FORCE
 	$(call if_changed_dep,host-cxxobjs)

-# Compile .c file, create position independent .o file
-# host-cshobjs -> .o
-quiet_cmd_host-cshobjs	= HOSTCC  -fPIC $@
-      cmd_host-cshobjs	= $(HOSTCC) $(hostc_flags) -fPIC -c -o $@ $<
-$(host-cshobjs): $(obj)/%.o: $(src)/%.c FORCE
-	$(call if_changed_dep,host-cshobjs)
-
-# Compile .c file, create position independent .o file
-# Note that plugin capable gcc versions can be either C or C++ based
-# therefore plugin source files have to be compilable in both C and C++ mode.
-# This is why a C++ compiler is invoked on a .c file.
-# host-cxxshobjs -> .o
-quiet_cmd_host-cxxshobjs	= HOSTCXX -fPIC $@
-      cmd_host-cxxshobjs	= $(HOSTCXX) $(hostcxx_flags) -fPIC -c -o $@ $<
-$(host-cxxshobjs): $(obj)/%.o: $(src)/%.c FORCE
-	$(call if_changed_dep,host-cxxshobjs)
-
-# Link a shared library, based on position independent .o files
-# *.o -> .so shared library (host-cshlib)
-quiet_cmd_host-cshlib	= HOSTLLD -shared $@
-      cmd_host-cshlib	= $(HOSTCC) $(HOSTLDFLAGS) -shared -o $@ \
-			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLDLIBS_$(@F))
-$(host-cshlib): FORCE
-	$(call if_changed,host-cshlib)
-$(call multi_depend, $(host-cshlib), .so, -objs)
-
-# Link a shared library, based on position independent .o files
-# *.o -> .so shared library (host-cxxshlib)
-quiet_cmd_host-cxxshlib	= HOSTLLD -shared $@
-      cmd_host-cxxshlib	= $(HOSTCXX) $(HOSTLDFLAGS) -shared -o $@ \
-			  $(addprefix $(obj)/,$($(@F:.so=-objs))) \
-			  $(HOST_LOADLIBES) $(HOSTLDLIBS_$(@F))
-$(host-cxxshlib): FORCE
-	$(call if_changed,host-cxxshlib)
-$(call multi_depend, $(host-cxxshlib), .so, -objs)
-
-targets += $(host-csingle)  $(host-cmulti) $(host-cobjs)\
-	   $(host-cxxmulti) $(host-cxxobjs) $(host-shared) \
-	   $(host-cshlib) $(host-cshobjs) $(host-cxxshlib) $(host-cxxshobjs)
+targets += $(host-csingle) $(host-cmulti) $(host-cobjs) \
+	   $(host-cxxmulti) $(host-cxxobjs)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 791eb1cb3276..9126d9e43582 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -20,26 +20,29 @@ obj-m := $(filter-out $(obj-y),$(obj-m))
 # Filter out objects already built-in
 lib-y := $(filter-out $(obj-y), $(sort $(lib-y) $(lib-m)))

-# Determine modorder.
-# Unfortunately, we don't have information about ordering between -y
-# and -m subdirs.  Just put -y's first.
-modorder	:= $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m:.o=.ko))
+# Subdirectories we need to descend into
+subdir-ym := $(sort $(subdir-y) $(subdir-m) \
+			$(patsubst %/,%, $(filter %/, $(obj-y) $(obj-m))))

-# Handle objects in subdirs
-# ---------------------------------------------------------------------------
-# o if we encounter foo/ in $(obj-y), replace it by foo/built-in.a
-#   and add the directory to the list of dirs to descend into: $(subdir-y)
-# o if we encounter foo/ in $(obj-m), remove it from $(obj-m)
-#   and add the directory to the list of dirs to descend into: $(subdir-m)
-__subdir-y	:= $(patsubst %/,%,$(filter %/, $(obj-y)))
-subdir-y	+= $(__subdir-y)
-__subdir-m	:= $(patsubst %/,%,$(filter %/, $(obj-m)))
-subdir-m	+= $(__subdir-m)
-obj-y		:= $(patsubst %/, %/built-in.a, $(obj-y))
-obj-m		:= $(filter-out %/, $(obj-m))
+# Handle objects in subdirs:
+# - If we encounter foo/ in $(obj-y), replace it by foo/built-in.a and
+#   foo/modules.order
+# - If we encounter foo/ in $(obj-m), replace it by foo/modules.order
+#
+# Generate modules.order to determine modorder. Unfortunately, we don't have
+# information about ordering between -y and -m subdirs. Just put -y's first.

-# Subdirectories we need to descend into
-subdir-ym	:= $(sort $(subdir-y) $(subdir-m))
+ifdef need-modorder
+obj-m := $(patsubst %/,%/modules.order, $(filter %/, $(obj-y)) $(obj-m))
+else
+obj-m := $(filter-out %/, $(obj-m))
+endif
+
+ifdef need-builtin
+obj-y		:= $(patsubst %/, %/built-in.a, $(obj-y))
+else
+obj-y		:= $(filter-out %/, $(obj-y))
+endif

 # Expand $(foo-objs) $(foo-y) etc. by replacing their individuals
 suffix-search = $(strip $(foreach s, $3, $($(1:%$(strip $2)=%$s))))
@@ -48,16 +51,28 @@ multi-search = $(sort $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -),
 # List primitive targets that are compiled from source files
 real-search = $(foreach m, $1, $(if $(call suffix-search, $m, $2, $3 -), $(call suffix-search, $m, $2, $3), $m))

-# if $(foo-objs), $(foo-y), or $(foo-m) exists, foo.o is a composite object
-multi-used-y := $(sort $(foreach m,$(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))), $(m))))
-multi-used-m := $(sort $(foreach m,$(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))), $(m))))
-multi-used   := $(multi-used-y) $(multi-used-m)
-single-used-m := $(sort $(filter-out $(multi-used-m),$(obj-m)))
+# If $(foo-objs), $(foo-y), $(foo-m), or $(foo-) exists, foo.o is a composite object
+multi-obj-y := $(call multi-search, $(obj-y), .o, -objs -y)
+multi-obj-m := $(call multi-search, $(obj-m), .o, -objs -y -m)
+multi-obj-ym := $(multi-obj-y) $(multi-obj-m)
+
+# Replace multi-part objects by their individual parts,
+# including built-in.a from subdirectories
+real-obj-y := $(call real-search, $(obj-y), .o, -objs -y)
+real-obj-m := $(call real-search, $(obj-m), .o, -objs -y -m)
+
+always-y += $(always-m)
+
+# hostprogs-always-y += foo
+# ... is a shorthand for
+# hostprogs += foo
+# always-y  += foo
+hostprogs += $(hostprogs-always-y) $(hostprogs-always-m)
+always-y += $(hostprogs-always-y) $(hostprogs-always-m)

-# Build list of the parts of our composite objects, our composite
-# objects depend on those (obviously)
-multi-objs-y := $(foreach m, $(multi-used-y), $($(m:.o=-objs)) $($(m:.o=-y)))
-multi-objs-m := $(foreach m, $(multi-used-m), $($(m:.o=-objs)) $($(m:.o=-y)))
+# userprogs-always-y is likewise.
+userprogs += $(userprogs-always-y) $(userprogs-always-m)
+always-y += $(userprogs-always-y) $(userprogs-always-m)

 # Composite DTB (i.e. DTB constructed by overlay)
 multi-dtb-y := $(call multi-search, $(dtb-y), .dtb, -dtbs)
@@ -66,20 +81,12 @@ real-dtb-y := $(call real-search, $(dtb-y), .dtb, -dtbs)
 # Base DTB that overlay is applied onto (each first word of $(*-dtbs) expansion)
 base-dtb-y := $(foreach m, $(multi-dtb-y), $(firstword $(call suffix-search, $m, .dtb, -dtbs)))

-# $(subdir-obj-y) is the list of objects in $(obj-y) which uses dir/ to
-# tell kbuild to descend
-subdir-obj-y := $(filter %/built-in.a, $(obj-y))
-
-# Replace multi-part objects by their individual parts,
-# including built-in.a from subdirectories
-real-obj-y := $(foreach m, $(obj-y), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y))),$($(m:.o=-objs)) $($(m:.o=-y)),$(m)))
-real-obj-m := $(foreach m, $(obj-m), $(if $(strip $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m)),$(m)))
-
 # DTB
 # If CONFIG_OF_ALL_DTBS is enabled, all DT blobs are built
 extra-y				+= $(dtb-y)
 extra-$(CONFIG_OF_ALL_DTBS)	+= $(dtb-)

+# U-Boot specific
 ifneq ($(CHECK_DTBS),)
 extra-y += $(patsubst %.dtb,%.dt.yaml, $(dtb-y))
 extra-$(CONFIG_OF_ALL_DTBS) += $(patsubst %.dtb,%.dt.yaml, $(dtb-))
@@ -88,47 +95,49 @@ endif
 # Add subdir path

 extra-y		:= $(addprefix $(obj)/,$(extra-y))
-always-y        := $(addprefix $(obj)/,$(always-y))
-always		:= $(addprefix $(obj)/,$(always))
+always-y	:= $(addprefix $(obj)/,$(always-y))
 targets		:= $(addprefix $(obj)/,$(targets))
-modorder	:= $(addprefix $(obj)/,$(modorder))
-obj-y		:= $(addprefix $(obj)/,$(obj-y))
 obj-m		:= $(addprefix $(obj)/,$(obj-m))
 lib-y		:= $(addprefix $(obj)/,$(lib-y))
-subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
 real-obj-y	:= $(addprefix $(obj)/,$(real-obj-y))
 real-obj-m	:= $(addprefix $(obj)/,$(real-obj-m))
-single-used-m	:= $(addprefix $(obj)/,$(single-used-m))
-multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
-multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
-multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
-multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
-multi-dtb-y	:= $(addprefix $(obj)/,$(multi-dtb-y))
-real-dtb-y      := $(addprefix $(obj)/,$(real-dtb-y))
+multi-obj-m	:= $(addprefix $(obj)/, $(multi-obj-m))
+multi-dtb-y	:= $(addprefix $(obj)/, $(multi-dtb-y))
+real-dtb-y	:= $(addprefix $(obj)/, $(real-dtb-y))
 subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))

 # Finds the multi-part object the current object will be linked into.
-# If the object belongs to two or more multi-part objects, all of them are
-# concatenated with a colon separator.
-modname-multi = $(subst $(space),:,$(sort $(foreach m,$(multi-used),\
-		$(if $(filter $*.o, $($(m:.o=-objs)) $($(m:.o=-y)) $($(m:.o=-m))),$(m:.o=)))))
+# If the object belongs to two or more multi-part objects, list them all.
+modname-multi = $(sort $(foreach m,$(multi-obj-ym),\
+		$(if $(filter $*.o, $(call suffix-search, $m, .o, -objs -y -m)),$(m:.o=))))

-modname = $(if $(modname-multi),$(modname-multi),$(basetarget))
+__modname = $(or $(modname-multi),$(basetarget))
+
+modname = $(subst $(space),:,$(__modname))
+modfile = $(addprefix $(obj)/,$(__modname))
+
+# target with $(obj)/ and its suffix stripped
+target-stem = $(basename $(patsubst $(obj)/%,%,$@))

 # These flags are needed for modversions and compiling, so we define them here
 # $(modname_flags) defines KBUILD_MODNAME as the name of the module it will
 # end up in (or would, if it gets compiled in)
-name-fix = $(squote)$(quote)$(subst $(comma),_,$(subst -,_,$1))$(quote)$(squote)
+name-fix-token = $(subst $(comma),_,$(subst -,_,$1))
+name-fix = $(call stringify,$(call name-fix-token,$1))
 basename_flags = -DKBUILD_BASENAME=$(call name-fix,$(basetarget))
-modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname))
-
-orig_c_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) \
-                 $(ccflags-y) $(CFLAGS_$(basetarget).o)
-_c_flags       = $(filter-out $(CFLAGS_REMOVE_$(basetarget).o), $(orig_c_flags))
-orig_a_flags   = $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) \
-                 $(asflags-y) $(AFLAGS_$(basetarget).o)
-_a_flags       = $(filter-out $(AFLAGS_REMOVE_$(basetarget).o), $(orig_a_flags))
-_cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(@F))
+modname_flags  = -DKBUILD_MODNAME=$(call name-fix,$(modname)) \
+		 -D__KBUILD_MODNAME=kmod_$(call name-fix-token,$(modname))
+modfile_flags  = -DKBUILD_MODFILE=$(call stringify,$(modfile))
+
+_c_flags       = $(filter-out $(CFLAGS_REMOVE_$(target-stem).o), \
+                     $(filter-out $(ccflags-remove-y), \
+                         $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS) $(ccflags-y)) \
+                     $(CFLAGS_$(target-stem).o))
+_a_flags       = $(filter-out $(AFLAGS_REMOVE_$(target-stem).o), \
+                     $(filter-out $(asflags-remove-y), \
+                         $(KBUILD_CPPFLAGS) $(KBUILD_AFLAGS) $(asflags-y)) \
+                     $(AFLAGS_$(target-stem).o))
+_cpp_flags     = $(KBUILD_CPPFLAGS) $(cppflags-y) $(CPPFLAGS_$(target-stem).lds)

 #
 # Enable gcov profiling flags for a file, directory or for all files depending
@@ -146,10 +155,12 @@ endif
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
 #
 ifeq ($(CONFIG_KASAN),y)
+ifneq ($(CONFIG_KASAN_HW_TAGS),y)
 _c_flags += $(if $(patsubst n%,, \
 		$(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
 		$(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
 endif
+endif

 ifeq ($(CONFIG_UBSAN),y)
 _c_flags += $(if $(patsubst n%,, \
@@ -163,34 +174,55 @@ _c_flags += $(if $(patsubst n%,, \
 	$(CFLAGS_KCOV))
 endif

-__c_flags	= $(_c_flags)
-__a_flags	= $(_a_flags)
-__cpp_flags     = $(_cpp_flags)
+#
+# Enable KCSAN flags except some files or directories we don't want to check
+# (depends on variables KCSAN_SANITIZE_obj.o, KCSAN_SANITIZE)
+#
+ifeq ($(CONFIG_KCSAN),y)
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_SANITIZE_$(basetarget).o)$(KCSAN_SANITIZE)y), \
+	$(CFLAGS_KCSAN))
+# Some uninstrumented files provide implied barriers required to avoid false
+# positives: set KCSAN_INSTRUMENT_BARRIERS for barrier instrumentation only.
+_c_flags += $(if $(patsubst n%,, \
+	$(KCSAN_INSTRUMENT_BARRIERS_$(basetarget).o)$(KCSAN_INSTRUMENT_BARRIERS)n), \
+	-D__KCSAN_INSTRUMENT_BARRIERS__)
+endif

-# If building the kernel in a separate objtree expand all occurrences
-# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
+# $(srctree)/$(src) for including checkin headers from generated source files
+# $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
-ifneq ($(KBUILD_SRC),)
-# -I$(obj) locates generated .h files
-# $(call addtree,-I$(obj)) locates .h files in srctree, from generated .c files
-#   and locates generated .h files
-# FIXME: Replace both with specific CFLAGS* statements in the makefiles
-__c_flags	= $(if $(obj),$(call addtree,-I$(src)) -I$(obj)) \
-		  $(call flags,_c_flags)
-__a_flags	= $(call flags,_a_flags)
-__cpp_flags     = $(call flags,_cpp_flags)
+ifdef building_out_of_srctree
+_c_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
+_a_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
+_cpp_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
 endif
 endif
+
+part-of-module = $(if $(filter $(basename $@).o, $(real-obj-m)),y)
+quiet_modtag = $(if $(part-of-module),[M],   )
+
+modkern_cflags =                                          \
+	$(if $(part-of-module),                           \
+		$(KBUILD_CFLAGS_MODULE) $(CFLAGS_MODULE), \
+		$(KBUILD_CFLAGS_KERNEL) $(CFLAGS_KERNEL) $(modfile_flags))
+
+modkern_aflags = $(if $(part-of-module),				\
+			$(KBUILD_AFLAGS_MODULE) $(AFLAGS_MODULE),	\
+			$(KBUILD_AFLAGS_KERNEL) $(AFLAGS_KERNEL))
+
+
 # Modified for U-Boot: LINUXINCLUDE -> UBOOTINCLUDE
-c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
-		 $(__c_flags) $(modkern_cflags)                           \
+# removed the inclusion of compiler_types.h for sandbox build
+c_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)    \
+		 $(_c_flags) $(modkern_cflags)                           \
 		 $(basename_flags) $(modname_flags)

-a_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
-		 $(__a_flags) $(modkern_aflags)
+a_flags        = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
+		 $(_a_flags) $(modkern_aflags)

-cpp_flags      = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
-		 $(__cpp_flags)
+cpp_flags      = -Wp,-MMD,$(depfile) $(NOSTDINC_FLAGS) $(UBOOTINCLUDE)     \
+		 $(_cpp_flags)

 ld_flags       = $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))

@@ -238,48 +270,52 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -D__ASSEMBLY__                                          \
 		 -undef -D__DTS__

-# Finds the multi-part object the current object will be linked into
-modname-multi = $(sort $(foreach m,$(multi-used),\
-		$(if $(filter $(subst $(obj)/,,$*.o), $($(m:.o=-objs)) $($(m:.o=-y))),$(m:.o=))))
-# Useful for describing the dependency of composite objects
-# Usage:
-#   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
-define multi_depend
-$(foreach m, $(notdir $1), \
-	$(eval $(obj)/$m: \
-	$(addprefix $(obj)/, $(foreach s, $3, $($(m:%$(strip $2)=%$(s)))))))
-endef
+ifdef CONFIG_OBJTOOL

-# LEX
-# ---------------------------------------------------------------------------
-quiet_cmd_flex = LEX     $@
-      cmd_flex = $(LEX) -o$@ -L $<
+objtool := $(objtree)/tools/objtool/objtool

-$(obj)/%.lex.c: $(src)/%.l FORCE
-	$(call if_changed,flex)
+objtool_args =								\
+	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
+	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
+	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
+	$(if $(CONFIG_RETPOLINE), --retpoline)				\
+	$(if $(CONFIG_RETHUNK), --rethunk)				\
+	$(if $(CONFIG_SLS), --sls)					\
+	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
+	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
+	$(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)		\
+	$(if $(delay-objtool), --link)					\
+	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)

-# YACC
-# ---------------------------------------------------------------------------
-quiet_cmd_bison = YACC    $@
-      cmd_bison = $(YACC) -o$@ -t -l $<
+delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))

-$(obj)/%.tab.c: $(src)/%.y FORCE
-	$(call if_changed,bison)
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
+cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)

-quiet_cmd_bison_h = YACC    $@
-      cmd_bison_h = $(YACC) -o/dev/null --defines=$@ -t -l $<
+endif # CONFIG_OBJTOOL

-$(obj)/%.tab.h: $(src)/%.y FORCE
-	$(call if_changed,bison_h)
+# Useful for describing the dependency of composite objects
+# Usage:
+#   $(call multi_depend, multi_used_targets, suffix_to_remove, suffix_to_add)
+define multi_depend
+$(foreach m, $1, \
+	$(eval $m: \
+	$(addprefix $(obj)/, $(call suffix-search, $(patsubst $(obj)/%,%,$m), $2, $3))))
+endef

-# Shipped files
+# Copy a file
 # ===========================================================================
-
-quiet_cmd_shipped = SHIPPED $@
-cmd_shipped = cat $< > $@
+# 'cp' preserves permissions. If you use it to copy a file in read-only srctree,
+# the copy would be read-only as well, leading to an error when executing the
+# rule next time. Use 'cat' instead in order to generate a writable file.
+quiet_cmd_copy = COPY    $@
+      cmd_copy = cat $< > $@

 $(obj)/%: $(src)/%_shipped
-	$(call cmd,shipped)
+	$(call cmd,copy)

 # Commands useful for building a boot image
 # ===========================================================================
@@ -289,7 +325,7 @@ $(obj)/%: $(src)/%_shipped
 #	target: source(s) FORCE
 #		$(if_changed,ld/objcopy/gzip)
 #
-#	and add target to extra-y so that we know we have to
+#	and add target to 'targets' so that we know we have to
 #	read in the saved command line

 # Linking
@@ -302,7 +338,7 @@ quiet_cmd_ld = LD      $@
 # ---------------------------------------------------------------------------

 quiet_cmd_ar = AR      $@
-      cmd_ar = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(real-prereqs)
+      cmd_ar = rm -f $@; $(AR) cDPrsT $@ $(real-prereqs)

 # Objcopy
 # ---------------------------------------------------------------------------
@@ -314,14 +350,14 @@ cmd_objcopy = $(OBJCOPY) $(OBJCOPYFLAGS) $(OBJCOPYFLAGS_$(@F)) $< $@
 # ---------------------------------------------------------------------------

 quiet_cmd_gzip = GZIP    $@
-      cmd_gzip = cat $(real-prereqs) | gzip -n -f -9 > $@
+      cmd_gzip = cat $(real-prereqs) | $(KGZIP) -n -f -9 > $@

 # DTC
 # ---------------------------------------------------------------------------
 DTC ?= $(objtree)/scripts/dtc/dtc

 # Disable noisy checks by default
-ifeq ($(findstring 1,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
+ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-unit_address_format \
 	-Wno-avoid_unnecessary_addr_size \
@@ -336,7 +372,7 @@ DTC_FLAGS += -Wno-pci_bridge \
         -Wno-pci_device_bus_num
 endif

-ifneq ($(findstring 2,$(KBUILD_ENABLE_EXTRA_GCC_CHECKS)),)
+ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
 DTC_FLAGS += -Wnode_name_chars_strict \
 	-Wproperty_name_chars_strict
 endif
@@ -361,8 +397,8 @@ cmd_dt_S_dtb=						\
 	echo '.balign 16';				\
 } > $@

-$(obj)/%.dtb.S: $(obj)/%.dtb
-	$(call cmd,dt_S_dtb)
+$(obj)/%.dtb.S: $(obj)/%.dtb FORCE
+	$(call if_changed,dt_S_dtb)

 # Generate an assembly file to wrap the output of the device tree compiler
 quiet_cmd_dt_S_dtbo= DTBOS   $@
@@ -572,8 +608,8 @@ $(obj)/dsdt_generated.c:    $(src)/dsdt.asl
 # append the size as a 32-bit littleendian number as gzip does.
 size_append = printf $(shell						\
 dec_size=0;								\
-for F in $(real-prereqs); do
-	fsize=$$(stat -c "%s" $$F);					\
+for F in $(real-prereqs); do					\
+	fsize=$$($(CONFIG_SHELL) $(srctree)/scripts/file-size.sh $$F);	\
 	dec_size=$$(expr $$dec_size + $$fsize);				\
 done;									\
 printf "%08x\n" $$dec_size |						\
@@ -585,20 +621,35 @@ printf "%08x\n" $$dec_size |						\
 	}								\
 )

+quiet_cmd_file_size = GEN     $@
+      cmd_file_size = $(size_append) > $@
+
 quiet_cmd_bzip2 = BZIP2   $@
-      cmd_bzip2 = { cat $(real-prereqs) | bzip2 -9 && $(size_append); } > $@
+      cmd_bzip2 = cat $(real-prereqs) | $(KBZIP2) -9 > $@
+
+quiet_cmd_bzip2_with_size = BZIP2   $@
+      cmd_bzip2_with_size = { cat $(real-prereqs) | $(KBZIP2) -9; $(size_append); } > $@

 # Lzma
 # ---------------------------------------------------------------------------

 quiet_cmd_lzma = LZMA    $@
-      cmd_lzma = { cat $(real-prereqs) | lzma -9 && $(size_append); } > $@
+      cmd_lzma = cat $(real-prereqs) | $(LZMA) -9 > $@
+
+quiet_cmd_lzma_with_size = LZMA    $@
+      cmd_lzma_with_size = { cat $(real-prereqs) | $(LZMA) -9; $(size_append); } > $@

 quiet_cmd_lzo = LZO     $@
-      cmd_lzo = { cat $(real-prereqs) | lzop -9 && $(size_append); } > $@
+      cmd_lzo = cat $(real-prereqs) | $(KLZOP) -9 > $@
+
+quiet_cmd_lzo_with_size = LZO     $@
+      cmd_lzo_with_size = { cat $(real-prereqs) | $(KLZOP) -9; $(size_append); } > $@

 quiet_cmd_lz4 = LZ4     $@
-      cmd_lz4 = { cat $(real-prereqs) | lz4c -l -c1 stdin stdout && \
+      cmd_lz4 = cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout > $@
+
+quiet_cmd_lz4_with_size = LZ4     $@
+      cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
                   $(size_append); } > $@

 # U-Boot mkimage
@@ -609,21 +660,19 @@ MKIMAGE := $(srctree)/scripts/mkuboot.sh
 # SRCARCH just happens to match slightly more than ARCH (on sparc), so reduces
 # the number of overrides in arch makefiles
 UIMAGE_ARCH ?= $(SRCARCH)
-UIMAGE_COMPRESSION ?= $(if $(2),$(2),none)
+UIMAGE_COMPRESSION ?= $(or $(2),none)
 UIMAGE_OPTS-y ?=
 UIMAGE_TYPE ?= kernel
 UIMAGE_LOADADDR ?= arch_must_set_this
 UIMAGE_ENTRYADDR ?= $(UIMAGE_LOADADDR)
 UIMAGE_NAME ?= 'Linux-$(KERNELRELEASE)'
-UIMAGE_IN ?= $<
-UIMAGE_OUT ?= $@

-quiet_cmd_uimage = UIMAGE  $(UIMAGE_OUT)
-      cmd_uimage = $(CONFIG_SHELL) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
+quiet_cmd_uimage = UIMAGE  $@
+      cmd_uimage = $(BASH) $(MKIMAGE) -A $(UIMAGE_ARCH) -O linux \
 			-C $(UIMAGE_COMPRESSION) $(UIMAGE_OPTS-y) \
 			-T $(UIMAGE_TYPE) \
 			-a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
-			-n $(UIMAGE_NAME) -d $(UIMAGE_IN) $(UIMAGE_OUT)
+			-n $(UIMAGE_NAME) -d $< $@

 # XZ
 # ---------------------------------------------------------------------------
@@ -643,11 +692,39 @@ quiet_cmd_uimage = UIMAGE  $(UIMAGE_OUT)
 # big dictionary would increase the memory usage too much in the multi-call
 # decompression mode. A BCJ filter isn't used either.
 quiet_cmd_xzkern = XZKERN  $@
-cmd_xzkern = { cat $(filter-out FORCE,$^) | \
-	sh $(srctree)/scripts/xz_wrap.sh && $(size_append); } > $@
+      cmd_xzkern = cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh > $@
+
+quiet_cmd_xzkern_with_size = XZKERN  $@
+      cmd_xzkern_with_size = { cat $(real-prereqs) | sh $(srctree)/scripts/xz_wrap.sh; \
+                     $(size_append); } > $@

 quiet_cmd_xzmisc = XZMISC  $@
-cmd_xzmisc = cat $(real-prereqs) | xz --check=crc32 --lzma2=dict=1MiB > $@
+      cmd_xzmisc = cat $(real-prereqs) | $(XZ) --check=crc32 --lzma2=dict=1MiB > $@
+
+# ZSTD
+# ---------------------------------------------------------------------------
+# Appends the uncompressed size of the data using size_append. The .zst
+# format has the size information available at the beginning of the file too,
+# but it's in a more complex format and it's good to avoid changing the part
+# of the boot code that reads the uncompressed size.
+#
+# Note that the bytes added by size_append will make the zstd tool think that
+# the file is corrupt. This is expected.
+#
+# zstd uses a maximum window size of 8 MB. zstd22 uses a maximum window size of
+# 128 MB. zstd22 is used for kernel compression because it is decompressed in a
+# single pass, so zstd doesn't need to allocate a window buffer. When streaming
+# decompression is used, like initramfs decompression, zstd22 should likely not
+# be used because it would require zstd to allocate a 128 MB buffer.
+
+quiet_cmd_zstd = ZSTD    $@
+      cmd_zstd = cat $(real-prereqs) | $(ZSTD) -19 > $@
+
+quiet_cmd_zstd22 = ZSTD22  $@
+      cmd_zstd22 = cat $(real-prereqs) | $(ZSTD) -22 --ultra > $@
+
+quiet_cmd_zstd22_with_size = ZSTD22  $@
+      cmd_zstd22_with_size = { cat $(real-prereqs) | $(ZSTD) -22 --ultra; $(size_append); } > $@

 # Additional commands for U-Boot
 #
@@ -718,7 +795,6 @@ quiet_cmd_fdt_rm_props = FDTGREP $@
 define sed-offsets
 	's:^[[:space:]]*\.ascii[[:space:]]*"\(.*\)".*:\1:; \
 	/^->/{s:->#\(.*\):/* \1 */:; \
-	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
 	s:->::; p;}'
 endef
@@ -726,7 +802,6 @@ endef
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
-	( \
 	 echo "#ifndef $2"; \
 	 echo "#define $2"; \
 	 echo "/*"; \
@@ -735,7 +810,7 @@ define filechk_offsets
 	 echo " * This file was generated by Kbuild"; \
 	 echo " */"; \
 	 echo ""; \
-	 sed -ne $(sed-offsets); \
+	 sed -ne $(sed-offsets) < $<; \
 	 echo ""; \
-	 echo "#endif" )
+	 echo "#endif"
 endef
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index 52f014ad3324..5e65d7b24984 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -17,7 +17,9 @@ src := $(obj)
 # Create output directory if not already present
 _dummy := $(shell [ -d $(obj) ] || mkdir -p $(obj))

-include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Kbuild.uboot
+
+include scripts/Makefile.compiler

 -include include/config/auto.conf

@@ -363,7 +365,7 @@ cmd_dtoc = $(DTOC_ARGS) -c $(obj)/dts -C include/generated all
 quiet_cmd_plat = PLAT    $@
 cmd_plat = $(CC) $(c_flags) -c $< -o $(filter-out $(PHONY),$@)

-$(obj)/dts/dt-%.o: $(obj)/dts/dt-%.c $(platdata-hdr)
+$(obj)/dts/dt-%.o: $(obj)/dts/dt-%.c $(platdata-hdr) FORCE
 	$(call if_changed,plat)

 # Don't use dts_dir here, since it forces running this expensive rule every time
@@ -461,7 +463,7 @@ cmd_sunxi_spl_image_builder = $(objtree)/tools/sunxi-spl-image-builder \
 				-u $(CONFIG_NAND_SUNXI_SPL_USABLE_PAGE_SIZE) \
 				-e $(CONFIG_SYS_NAND_BLOCK_SIZE) \
 				-s -b $< $@
-$(obj)/sunxi-spl-with-ecc.bin: $(obj)/sunxi-spl.bin
+$(obj)/sunxi-spl-with-ecc.bin: $(obj)/sunxi-spl.bin FORCE
 	$(call if_changed,sunxi_spl_image_builder)


@@ -493,9 +495,9 @@ quiet_cmd_keep_syms_lto_cc = KSLCC   $@
       cmd_keep_syms_lto_cc = \
 	$(CC) $(filter-out $(LTO_CFLAGS),$(c_flags)) -c -o $@ $<

-$(u-boot-spl-keep-syms-lto_c): $(u-boot-spl-main) $(u-boot-spl-platdata)
+$(u-boot-spl-keep-syms-lto_c): $(u-boot-spl-main) $(u-boot-spl-platdata) FORCE
 	$(call if_changed,keep_syms_lto)
-$(u-boot-spl-keep-syms-lto): $(u-boot-spl-keep-syms-lto_c)
+$(u-boot-spl-keep-syms-lto): $(u-boot-spl-keep-syms-lto_c) FORCE
 	$(call if_changed,keep_syms_lto_cc)
 else
 u-boot-spl-keep-syms-lto :=
@@ -545,11 +547,11 @@ $(sort $(u-boot-spl-init) $(u-boot-spl-main)): $(u-boot-spl-dirs) ;

 PHONY += $(u-boot-spl-dirs)
 $(u-boot-spl-dirs): $(u-boot-spl-platdata) prepare
-	$(Q)$(MAKE) $(build)=$@
+	$(Q)$(MAKE) $(build)=$@ need-builtin=1

 PHONY += prepare
 prepare:
-	$(Q)$(MAKE) $(build)=$(obj)/.
+	$(Q)$(MAKE) $(build)=$(obj)/. need-builtin=1

 quiet_cmd_cpp_lds = LDS     $@
 cmd_cpp_lds = $(CPP) -Wp,-MD,$(depfile) $(cpp_flags) $(LDPPFLAGS) -ansi \
@@ -572,7 +574,7 @@ PHONY += FORCE
 FORCE:

 $(obj)/dts/dt-$(SPL_NAME).dtb: dts/dt.dtb
-	$(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs
+	$(Q)$(MAKE) $(build)=$(obj)/dts spl_dtbs need-builtin=1

 ifeq ($(CONFIG_OF_UPSTREAM),y)
 ifeq ($(CONFIG_ARM64),y)
@@ -594,7 +596,7 @@ $(sort $(dir $(SHRUNK_ARCH_DTB))):
 	$(shell [ -d $@ ] || mkdir -p $@)

 .SECONDEXPANSION:
-$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB))
+$(SHRUNK_ARCH_DTB): $$(patsubst $(obj)/dts/%, $(dt_dir)/%, $$@) $(dir $(SHRUNK_ARCH_DTB)) FORCE
 	$(call if_changed,fdtgrep)

 targets += $(SPL_OF_LIST_TARGETS)
diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
index 848f16d3c4da..958a95a66461 100644
--- a/scripts/basic/Makefile
+++ b/scripts/basic/Makefile
@@ -9,8 +9,4 @@
 # ---------------------------------------------------------------------------
 # fixdep:	 Used to generate dependency information during build process

-hostprogs-y	:= fixdep
-always		:= $(hostprogs-y)
-
-# fixdep is needed to compile other host programs
-$(addprefix $(obj)/,$(filter-out fixdep,$(always))): $(obj)/fixdep
+hostprogs-always-y	+= fixdep
diff --git a/scripts/check-local-export b/scripts/check-local-export
new file mode 100755
index 000000000000..6ccc2f467416
--- /dev/null
+++ b/scripts/check-local-export
@@ -0,0 +1,71 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Copyright (C) 2022 Masahiro Yamada <masahiroy@kernel.org>
+#
+# Exit with error if a local exported symbol is found.
+# EXPORT_SYMBOL should be used for global symbols.
+
+set -e
+
+# catch errors from ${NM}
+set -o pipefail
+
+# Run the last element of a pipeline in the current shell.
+# Without this, the while-loop would be executed in a subshell, and
+# the changes made to 'symbol_types' and 'export_symbols' would be lost.
+shopt -s lastpipe
+
+declare -A symbol_types
+declare -a export_symbols
+
+exit_code=0
+
+# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm) shows
+# 'no symbols' diagnostic (but exits with 0). It is harmless and hidden by
+# '2>/dev/null'. However, it suppresses real error messages as well. Add a
+# hand-crafted error message here.
+#
+# TODO:
+# Use --quiet instead of 2>/dev/null when we upgrade the minimum version of
+# binutils to 2.37, llvm to 13.0.0.
+# Then, the following line will be really simple:
+#   ${NM} --quiet ${1} |
+
+{ ${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; false; } } |
+while read value type name
+do
+	# Skip the line if the number of fields is less than 3.
+	#
+	# case 1)
+	#   For undefined symbols, the first field (value) is empty.
+	#   The outout looks like this:
+	#     "                 U _printk"
+	#   It is unneeded to record undefined symbols.
+	#
+	# case 2)
+	#   For Clang LTO, llvm-nm outputs a line with type 't' but empty name:
+	#     "---------------- t"
+	if [[ -z ${name} ]]; then
+		continue
+	fi
+
+	# save (name, type) in the associative array
+	symbol_types[${name}]=${type}
+
+	# append the exported symbol to the array
+	if [[ ${name} == __ksymtab_* ]]; then
+		export_symbols+=(${name#__ksymtab_})
+	fi
+done
+
+for name in "${export_symbols[@]}"
+do
+	# nm(3) says "If lowercase, the symbol is usually local"
+	if [[ ${symbol_types[$name]} =~ [a-z] ]]; then
+		echo "$@: error: local symbol '${name}' was exported" >&2
+		exit_code=1
+	fi
+done
+
+exit ${exit_code}
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index faa72d95e28e..a714c68365e8 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -1,15 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 # scripts/dtc makefile

-hostprogs-y	:= dtc
-always		:= $(hostprogs-y)
+hostprogs-always-y	+= dtc

 dtc-objs	:= dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
 		   srcpos.o checks.o util.o
 dtc-objs	+= dtc-lexer.lex.o dtc-parser.tab.o

 # Source files need to get at the userspace version of libfdt_env.h to compile
-HOST_EXTRACFLAGS := -I$(src)/libfdt
+HOST_EXTRACFLAGS := -I$(srctree)/$(src)/libfdt

 # Generated files need one more search path to include headers in source tree
 HOSTCFLAGS_dtc-lexer.lex.o := -I$(src)
diff --git a/scripts/dtc/pylibfdt/Makefile b/scripts/dtc/pylibfdt/Makefile
index e442d5c24201..ce9c2d093b80 100644
--- a/scripts/dtc/pylibfdt/Makefile
+++ b/scripts/dtc/pylibfdt/Makefile
@@ -26,7 +26,7 @@ quiet_cmd_pymod = PYMOD   $@
 		SWIG_OPTS="-I$(LIBFDT_srcdir) -I$(LIBFDT_srcdir)/.." \
 		$(PYTHON3) $< --quiet build_ext --inplace

-rebuild: $(src)/setup.py $(PYLIBFDT_srcs)
+rebuild: $(src)/setup.py $(PYLIBFDT_srcs) FORCE
 	@# Remove the library since otherwise Python doesn't seem to regenerate
 	@# the libfdt.py file if it is missing.
 	@rm -f $(obj)/_libfdt*.so
@@ -39,6 +39,6 @@ rebuild: $(src)/setup.py $(PYLIBFDT_srcs)
 $(obj)/_libfdt.so $(obj)/libfdt.py &: rebuild
 	@:

-always += _libfdt.so libfdt.py
+always-y += _libfdt.so libfdt.py

 clean-files += libfdt.i _libfdt.so libfdt.py libfdt_wrap.c
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index f0f93c56bdb5..abc34f60d159 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -128,7 +128,7 @@ testconfig: $(obj)/conf
 	$(PYTHON3) -B -m pytest $(srctree)/$(src)/tests \
 	-o cache_dir=$(abspath $(obj)/tests/.cache) \
 	$(if $(findstring 1,$(KBUILD_VERBOSE)),--capture=no)
-clean-dirs += tests/.cache
+clean-files += tests/.cache

 # Help text used by make help
 help:
@@ -162,7 +162,7 @@ help:

 conf-objs	:= conf.o  zconf.tab.o

-hostprogs-y := conf
+hostprogs += conf

 targets		+= zconf.lex.c

@@ -171,7 +171,7 @@ HOSTCFLAGS_zconf.lex.o	:= -I$(src)
 HOSTCFLAGS_zconf.tab.o	:= -I$(src)

 # nconf: Used for the nconfig target based on ncurses
-hostprogs-y	+= nconf
+hostprogs	+= nconf
 nconf-objs	:= nconf.o zconf.tab.o nconf.gui.o

 HOSTLDLIBS_nconf	= $(shell . $(obj)/.nconf-cfg && echo $$libs)
@@ -181,7 +181,7 @@ HOSTCFLAGS_nconf.gui.o	= $(shell . $(obj)/.nconf-cfg && echo $$cflags)
 $(obj)/nconf.o $(obj)/nconf.gui.o: $(obj)/.nconf-cfg

 # mconf: Used for the menuconfig target based on lxdialog
-hostprogs-y	+= mconf
+hostprogs	+= mconf
 lxdialog	:= checklist.o inputbox.o menubox.o textbox.o util.o yesno.o
 mconf-objs	:= mconf.o zconf.tab.o $(addprefix lxdialog/, $(lxdialog))

@@ -193,7 +193,7 @@ $(obj)/mconf.o: $(obj)/.mconf-cfg
 $(addprefix $(obj)/lxdialog/, $(lxdialog)): $(obj)/.mconf-cfg

 # qconf: Used for the xconfig target based on Qt
-hostprogs-y	+= qconf
+hostprogs	+= qconf
 qconf-cxxobjs	:= qconf.o
 qconf-objs	:= zconf.tab.o

@@ -209,7 +209,7 @@ $(obj)/%.moc: $(src)/%.h $(obj)/.qconf-cfg
 	$(call cmd,moc)

 # gconf: Used for the gconfig target based on GTK+
-hostprogs-y	+= gconf
+hostprogs	+= gconf
 gconf-objs	:= gconf.o zconf.tab.o

 HOSTLDLIBS_gconf = $(shell . $(obj)/.gconf-cfg && echo $$libs)
diff --git a/tools/Makefile b/tools/Makefile
index ae6a30526466..b84fb8079c88 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -42,34 +42,34 @@ ENVCRC-$(CONFIG_ENV_IS_IN_NVRAM) = y
 ENVCRC-$(CONFIG_ENV_IS_IN_SPI_FLASH) = y
 BUILD_ENVCRC ?= $(ENVCRC-y)

-hostprogs-$(CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER) += atmel_pmecc_params
+hostprogs-always-$(CONFIG_SPL_GENERATE_ATMEL_PMECC_HEADER) += atmel_pmecc_params

-hostprogs-$(CONFIG_VIDEO_LOGO) += bmp_logo
+hostprogs-always-$(CONFIG_VIDEO_LOGO) += bmp_logo
 HOSTCFLAGS_bmp_logo.o := -pedantic

-hostprogs-$(BUILD_ENVCRC) += envcrc
+hostprogs-always-$(BUILD_ENVCRC) += envcrc
 envcrc-objs := envcrc.o generated/lib/crc32.o generated/env/embedded.o generated/lib/sha1.o

-hostprogs-$(CONFIG_CMD_NET) += gen_eth_addr
+hostprogs-always-$(CONFIG_CMD_NET) += gen_eth_addr
 HOSTCFLAGS_gen_eth_addr.o := -pedantic

-hostprogs-$(CONFIG_CMD_NET) += gen_ethaddr_crc
+hostprogs-always-$(CONFIG_CMD_NET) += gen_ethaddr_crc
 gen_ethaddr_crc-objs := gen_ethaddr_crc.o generated/lib/crc8.o
 HOSTCFLAGS_gen_ethaddr_crc.o := -pedantic

-hostprogs-$(CONFIG_CMD_LOADS) += img2srec
+hostprogs-always-$(CONFIG_CMD_LOADS) += img2srec
 HOSTCFLAGS_img2srec.o := -pedantic

-hostprogs-y += mkenvimage
+hostprogs-always-y += mkenvimage
 mkenvimage-objs := mkenvimage.o os_support.o generated/lib/crc32.o

-hostprogs-y += dumpimage mkimage fit_info
-hostprogs-$(CONFIG_FIT_SIGNATURE) += fit_check_sign
-hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += fdt_add_pubkey
-hostprogs-$(CONFIG_TOOLS_LIBCRYPTO) += preload_check_sign
+hostprogs-always-y += dumpimage mkimage fit_info
+hostprogs-always-$(CONFIG_FIT_SIGNATURE) += fit_check_sign
+hostprogs-always-$(CONFIG_TOOLS_LIBCRYPTO) += fdt_add_pubkey
+hostprogs-always-$(CONFIG_TOOLS_LIBCRYPTO) += preload_check_sign

 ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_FWU_MDATA_GPT_BLK),)
-hostprogs-y += file2include
+hostprogs-always-y += file2include
 endif

 FIT_OBJS-y := fit_common.o fit_image.o image-host.o generated/boot/image-fit.o
@@ -87,11 +87,11 @@ LIBFDT_OBJS := $(addprefix libfdt/, fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o \
 RSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/rsa/, \
 					rsa-sign.o rsa-verify.o \
 					rsa-mod-exp.o)
-HOSTCFLAGS_rsa-sign.o += \
+HOSTCFLAGS_generated/lib/rsa/rsa-sign.o += \
 	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")

 ECDSA_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/ecdsa/, ecdsa-libcrypto.o)
-HOSTCFLAGS_ecdsa-libcrypto.o += \
+HOSTCFLAGS_generated/lib/ecdsa/ecdsa-libcrypto.o += \
 	$(shell pkg-config --cflags libssl libcrypto 2> /dev/null || echo "")

 AES_OBJS-$(CONFIG_TOOLS_LIBCRYPTO) := $(addprefix generated/lib/aes/, \
@@ -198,7 +198,7 @@ HOSTLDLIBS_mkimage += \
 ifeq ($(HOSTOS),darwin)
 HOSTCFLAGS_mxsimage.o += -Wno-deprecated-declarations
 HOSTCFLAGS_image-sig.o += -Wno-deprecated-declarations
-HOSTCFLAGS_rsa-sign.o += -Wno-deprecated-declarations
+HOSTCFLAGS_generated/lib/rsa/rsa-sign.o += -Wno-deprecated-declarations
 endif
 endif

@@ -212,8 +212,8 @@ HOSTLDLIBS_preload_check_sign := $(HOSTLDLIBS_mkimage)
 HOSTLDLIBS_preload_check_sign += \
 	$(shell pkg-config --libs libssl libcrypto 2> /dev/null || echo "-lssl -lcrypto")

-hostprogs-$(CONFIG_EXYNOS5250) += mkexynosspl
-hostprogs-$(CONFIG_EXYNOS5420) += mkexynosspl
+hostprogs-always-$(CONFIG_EXYNOS5250) += mkexynosspl
+hostprogs-always-$(CONFIG_EXYNOS5420) += mkexynosspl
 HOSTCFLAGS_mkexynosspl.o := -pedantic

 HOSTCFLAGS_kwboot.o += -pthread
@@ -222,43 +222,43 @@ HOSTLDLIBS_kwboot += \
 	$(shell pkg-config --libs tinfo 2> /dev/null || echo "-ltinfo")

 ifdtool-objs := $(LIBFDT_OBJS) ifdtool.o
-hostprogs-$(CONFIG_X86) += ifdtool
+hostprogs-always-$(CONFIG_X86) += ifdtool

 ifwitool-objs := ifwitool.o
-hostprogs-$(CONFIG_X86)$(CONFIG_SANDBOX) += ifwitool
+hostprogs-always-$(CONFIG_X86)$(CONFIG_SANDBOX) += ifwitool

-hostprogs-$(CONFIG_MX23) += mxsboot
-hostprogs-$(CONFIG_MX28) += mxsboot
+hostprogs-always-$(CONFIG_MX23) += mxsboot
+hostprogs-always-$(CONFIG_MX28) += mxsboot
 HOSTCFLAGS_mxsboot.o := -pedantic

-hostprogs-$(CONFIG_ARCH_SUNXI) += mksunxiboot
-hostprogs-$(CONFIG_ARCH_SUNXI) += sunxi-spl-image-builder
+hostprogs-always-$(CONFIG_ARCH_SUNXI) += mksunxiboot
+hostprogs-always-$(CONFIG_ARCH_SUNXI) += sunxi-spl-image-builder
 sunxi-spl-image-builder-objs := sunxi-spl-image-builder.o generated/lib/bch.o

-hostprogs-$(CONFIG_NETCONSOLE) += ncb
+hostprogs-always-$(CONFIG_NETCONSOLE) += ncb

-hostprogs-$(CONFIG_ARCH_KIRKWOOD) += kwboot
-hostprogs-$(CONFIG_ARCH_MVEBU) += kwboot
+hostprogs-always-$(CONFIG_ARCH_KIRKWOOD) += kwboot
+hostprogs-always-$(CONFIG_ARCH_MVEBU) += kwboot

-hostprogs-y += proftool
+hostprogs-always-y += proftool
 proftool-objs = proftool.o generated/lib/abuf.o

-hostprogs-$(CONFIG_STATIC_RELA) += relocate-rela
-hostprogs-$(CONFIG_RISCV) += prelink-riscv
+hostprogs-always-$(CONFIG_STATIC_RELA) += relocate-rela
+hostprogs-always-$(CONFIG_RISCV) += prelink-riscv

-hostprogs-$(CONFIG_ARCH_OCTEON) += update_octeon_header
+hostprogs-always-$(CONFIG_ARCH_OCTEON) += update_octeon_header
 update_octeon_header-objs := update_octeon_header.o generated/lib/crc32.o

-hostprogs-y += fdtgrep
+hostprogs-always-y += fdtgrep
 fdtgrep-objs += $(LIBFDT_OBJS) generated/boot/fdt_region.o fdtgrep.o

 ifneq ($(TOOLS_ONLY),y)
-hostprogs-y += spl_size_limit
+hostprogs-always-y += spl_size_limit
 endif

-hostprogs-$(CONFIG_MIPS) += mips-relocs
+hostprogs-always-$(CONFIG_MIPS) += mips-relocs

-hostprogs-$(CONFIG_ASN1_COMPILER)	+= asn1_compiler
+hostprogs-always-$(CONFIG_ASN1_COMPILER)	+= asn1_compiler
 HOSTCFLAGS_asn1_compiler.o = -idirafter $(srctree)/include

 HOSTCFLAGS_mkeficapsule.o += \
@@ -269,21 +269,21 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	generated/lib/sha1.o \
 	$(LIBFDT_OBJS) \
 	mkeficapsule.o
-hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule

 mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
 HOSTLDLIBS_mkfwumdata += -luuid
-hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
+hostprogs-always-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata

 # We build some files with extra pedantic flags to try to minimize things
 # that won't build on some weird host compiler -- though there are lots of
 # exceptions for files that aren't complaint.
-HOSTCFLAGS_crc32.o := -pedantic
-HOSTCFLAGS_crc8.o := -pedantic
-HOSTCFLAGS_md5.o := -pedantic
-HOSTCFLAGS_sha1.o := -pedantic
-HOSTCFLAGS_sha256.o := -pedantic
-HOSTCFLAGS_sha512.o := -pedantic -DCONFIG_SHA512 -DCONFIG_SHA384
+HOSTCFLAGS_generated/lib/crc32.o := -pedantic
+HOSTCFLAGS_generated/lib/crc8.o := -pedantic
+HOSTCFLAGS_generated/lib/md5.o := -pedantic
+HOSTCFLAGS_generated/lib/sha1.o := -pedantic
+HOSTCFLAGS_generated/lib/sha256.o := -pedantic
+HOSTCFLAGS_generated/lib/sha512.o := -pedantic -DCONFIG_SHA512 -DCONFIG_SHA384

 quiet_cmd_wrap = WRAP    $@
 cmd_wrap = echo "\#include <../$(patsubst $(obj)/generated/%,%,$@)>" >$@
@@ -291,13 +291,11 @@ cmd_wrap = echo "\#include <../$(patsubst $(obj)/generated/%,%,$@)>" >$@
 $(obj)/generated/%.c:
 	$(call cmd,wrap)

-clean-dirs := generated
-
-always := $(hostprogs-y)
+clean-files := generated

 # Host tool to dump the currently configured default environment,
 # build it on demand, i.e. not add it to 'always'.
-hostprogs-y += printinitialenv
+hostprogs += printinitialenv

 # Generated LCD/video logo
 LOGO_H = $(objtree)/include/bmp_logo.h
@@ -357,9 +355,9 @@ override HOSTCFLAGS = $(CFLAGS)

 quiet_cmd_crosstools_strip = STRIP   $^
       cmd_crosstools_strip = $(STRIP) $^; touch $@
-$(obj)/.strip: $(call objectify,$(filter $(always),$(hostprogs-y)))
+$(obj)/.strip: $(call objectify,$(filter $(hostprogs-always-y)))
 	$(call cmd,crosstools_strip)

-always += .strip
+always-y += .strip
 endif
 clean-files += .strip
diff --git a/tools/env/Makefile b/tools/env/Makefile
index b627796e949e..b33bdb1409c7 100644
--- a/tools/env/Makefile
+++ b/tools/env/Makefile
@@ -19,8 +19,7 @@ ifeq ($(MTD_VERSION),old)
 HOST_EXTRACFLAGS += -DMTD_OLD
 endif

-always := fw_printenv
-hostprogs-y := fw_printenv
+hostprogs-always-y += fw_printenv

 lib-y += fw_env.o \
 	crc32.o ctype.o linux_string.o \
@@ -34,4 +33,4 @@ quiet_cmd_crosstools_strip = STRIP   $^
 $(obj)/.strip: $(obj)/fw_printenv
 	$(call cmd,crosstools_strip)

-always += .strip
+always-y += .strip
diff --git a/tools/gdb/Makefile b/tools/gdb/Makefile
index 24152dcc3c52..258190687fa2 100644
--- a/tools/gdb/Makefile
+++ b/tools/gdb/Makefile
@@ -34,11 +34,9 @@ endif
 #
 HOST_EXTRACFLAGS := -I$(BFD_ROOT_DIR)/include -pedantic

-hostprogs-y := gdbsend gdbcont
+hostprogs-always-y += gdbsend gdbcont

 gdbsend-objs := gdbsend.o error.o remote.o serial.o
 gdbcont-objs := gdbcont.o error.o remote.o serial.o

-always := $(hostprogs-y)
-
 endif	# cygwin
--
2.51.0

