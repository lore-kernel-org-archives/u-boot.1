Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C43CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE82846A7;
	Mon,  4 May 2026 15:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="WpFyHc5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93333846A7; Mon,  4 May 2026 15:20:54 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F3A284659
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj00qS9zh7G;
 Mon,  4 May 2026 15:20:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900851;
 bh=NrRvZ9PnlArZxSJYFKzGcHiXYjXaAym8d5jDxmSvzOw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WpFyHc5YIfRsH4fal086qKen/XEIbgmx07voMb0Dc2CYdJNtccqkKJbmaHR81VYB8
 MnwaVP5v/mZ53q9gH3wiopWN6pqOZ1lqQDNJLKiGzbNK+OyW1e3KfMLzXBLaRGtJDM
 cxPQmCpCWMa0uvgXU/5ksV57Wd/c7SbLYXVDEZR3pbPdFFKR33WyQ2ohlHqHHafUDu
 q0S5PtF7kYBeuBtirTskRbcOaVaG4fusJGt3kN26iiIok3AwZEfGUBP67FxiFx9Exz
 Vj0ORYKFVLLiVcs5VFBQeFHpdlqkTQ46cPQfE5u2Nma0TjRG9To4n0e64Zf7pGoFXV
 NlIp3DG09unxw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhy6QR1zCcj; Mon,  4 May 2026 15:20:50 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:35 +0200
Subject: [PATCH RFC next 08/18] scripts/Makefile.extrawarn: sync with 6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-8-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

Sync scripts/Makefile.extrawarn with Linux kernel 6.1's.

Since it adds a new option for KBUILD_EXTRA_WARN with e, document it as
done in kernel commit c77d06e70d59 ("kbuild: support W=e to make build
abort in case of warning").

s/gcc/build/ in Makefile as done in kernel commit e27128db6283 ("kbuild:
rename KBUILD_ENABLE_EXTRA_GCC_CHECKS to KBUILD_EXTRA_WARN"), part of
v5.4. The rest of this commit was backported with commit bd3f9ee679b4
("kbuild: Bump the build system to 6.1").

Our scripts/Makefile.extrawarn before this commit is Linux kernel's from
v5.1 with the following diff:

 # diff --git a/proc/self/fd/11 b/proc/self/fd/13
 # --- a/proc/self/fd/11
 # +++ b/proc/self/fd/13
 # @@ -13,17 +13,8 @@
 #
 #  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 #
 # -# backward compatibility
 # -KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
 # -
 #  ifeq ("$(origin W)", "command line")
 # -  KBUILD_EXTRA_WARN := $(W)
 # -endif
 # -
 # -export KBUILD_EXTRA_WARN
 # -
 # -ifeq ("$(origin W)", "command line")
 # -  KBUILD_EXTRA_WARN := $(W)
 # +  export KBUILD_ENABLE_EXTRA_GCC_CHECKS := $(W)
 #  endif
 #
 #  ifdef KBUILD_ENABLE_EXTRA_GCC_CHECKS

The KBUILD_EXTRA_WARN changes were made as part of commit bd3f9ee679b4
("kbuild: Bump the build system to 6.1") and they are available in v5.4
via kernel commit e27128db6283 ("kbuild: rename
KBUILD_ENABLE_EXTRA_GCC_CHECKS to KBUILD_EXTRA_WARN") so they are pulled
in this sync. Additional changes made in other files are either ignored
because the files or modified code parts don't exist. The change made to
the Makefile is included in this commit here.

scripts/Makefile.extrawarn is now directly copied from Linux kernel at
v6.1, no changes made.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile                   |   3 +-
 scripts/Makefile.extrawarn | 152 +++++++++++++++++++++++++++------------------
 2 files changed, 94 insertions(+), 61 deletions(-)

diff --git a/Makefile b/Makefile
index bfd4976a0d4..aed54cee4a4 100644
--- a/Makefile
+++ b/Makefile
@@ -2741,10 +2741,11 @@ help:
 	@echo  '  make C=1   [targets] Check all c source with $$CHECK (sparse by default)'
 	@echo  '  make C=2   [targets] Force check of all c source with $$CHECK'
 	@echo  '  make RECORDMCOUNT_WARN=1 [targets] Warn about ignored mcount sections'
-	@echo  '  make W=n   [targets] Enable extra gcc checks, n=1,2,3 where'
+	@echo  '  make W=n   [targets] Enable extra build checks, n=1,2,3 where'
 	@echo  '		1: warnings which may be relevant and do not occur too often'
 	@echo  '		2: warnings which occur quite often but may still be relevant'
 	@echo  '		3: more obscure warnings, can most likely be ignored'
+	@echo  '		e: warnings are being treated as errors'
 	@echo  '		Multiple levels can be combined with W=12 or W=123'
 	@echo  ''
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 7dfc374a19d..6bbba36c596 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -1,14 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # ==========================================================================
-#
 # make W=... settings
 #
-# W=1 - warnings that may be relevant and does not occur too often
-# W=2 - warnings that occur quite often but may still be relevant
-# W=3 - the more obscure warnings, can most likely be ignored
-#
-# $(call cc-option, -W...) handles gcc -W.. options which
-# are not supported by all versions of the compiler
+# There are four warning groups enabled by W=1, W=2, W=3, and W=e
+# They are independent, and can be combined like W=12 or W=123e.
 # ==========================================================================
 
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
@@ -22,64 +17,101 @@ endif
 
 export KBUILD_EXTRA_WARN
 
-ifeq ("$(origin W)", "command line")
-  KBUILD_EXTRA_WARN := $(W)
-endif
+#
+# W=1 - warnings which may be relevant and do not occur too often
+#
+ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
 
-ifdef KBUILD_ENABLE_EXTRA_GCC_CHECKS
-warning-  := $(empty)
+KBUILD_CFLAGS += -Wextra -Wunused -Wno-unused-parameter
+KBUILD_CFLAGS += -Wmissing-declarations
+KBUILD_CFLAGS += -Wmissing-format-attribute
+KBUILD_CFLAGS += -Wmissing-prototypes
+KBUILD_CFLAGS += -Wold-style-definition
+KBUILD_CFLAGS += -Wmissing-include-dirs
+KBUILD_CFLAGS += $(call cc-option, -Wunused-but-set-variable)
+KBUILD_CFLAGS += $(call cc-option, -Wunused-const-variable)
+KBUILD_CFLAGS += $(call cc-option, -Wpacked-not-aligned)
+KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
+# The following turn off the warnings enabled by -Wextra
+KBUILD_CFLAGS += -Wno-missing-field-initializers
+KBUILD_CFLAGS += -Wno-sign-compare
+KBUILD_CFLAGS += -Wno-type-limits
+KBUILD_CFLAGS += -Wno-shift-negative-value
 
-warning-1 := -Wextra -Wunused -Wno-unused-parameter
-warning-1 += -Wmissing-declarations
-warning-1 += -Wmissing-format-attribute
-warning-1 += $(call cc-option, -Wmissing-prototypes)
-warning-1 += -Wold-style-definition
-warning-1 += $(call cc-option, -Wmissing-include-dirs)
-warning-1 += $(call cc-option, -Wunused-but-set-variable)
-warning-1 += $(call cc-option, -Wunused-const-variable)
-warning-1 += $(call cc-option, -Wpacked-not-aligned)
-warning-1 += $(call cc-option, -Wstringop-truncation)
-warning-1 += $(call cc-disable-warning, missing-field-initializers)
-warning-1 += $(call cc-disable-warning, sign-compare)
+KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
 
-warning-2 := -Waggregate-return
-warning-2 += -Wcast-align
-warning-2 += -Wdisabled-optimization
-warning-2 += -Wnested-externs
-warning-2 += -Wshadow
-warning-2 += $(call cc-option, -Wlogical-op)
-warning-2 += $(call cc-option, -Wmissing-field-initializers)
-warning-2 += $(call cc-option, -Wsign-compare)
-warning-2 += $(call cc-option, -Wmaybe-uninitialized)
-warning-2 += $(call cc-option, -Wunused-macros)
-
-warning-3 := -Wbad-function-cast
-warning-3 += -Wcast-qual
-warning-3 += -Wconversion
-warning-3 += -Wpacked
-warning-3 += -Wpadded
-warning-3 += -Wpointer-arith
-warning-3 += -Wredundant-decls
-warning-3 += -Wswitch-default
-warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
-
-warning := $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
-warning += $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
-warning += $(warning-$(findstring 3, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
-
-ifeq ("$(strip $(warning))","")
-        $(error W=$(KBUILD_ENABLE_EXTRA_GCC_CHECKS) is unknown)
-endif
-
-KBUILD_CFLAGS += $(warning)
 else
 
+# Some diagnostics enabled by default are noisy.
+# Suppress them by using -Wno... except for W=1.
+
 ifdef CONFIG_CC_IS_CLANG
-KBUILD_CFLAGS += $(call cc-disable-warning, initializer-overrides)
-KBUILD_CFLAGS += $(call cc-disable-warning, unused-value)
-KBUILD_CFLAGS += $(call cc-disable-warning, format)
-KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
-KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
-KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
+KBUILD_CFLAGS += -Wno-initializer-overrides
+# Clang before clang-16 would warn on default argument promotions.
+ifneq ($(call clang-min-version, 160000),y)
+# Disable -Wformat
+KBUILD_CFLAGS += -Wno-format
+# Then re-enable flags that were part of the -Wformat group that aren't
+# problematic.
+KBUILD_CFLAGS += -Wformat-extra-args -Wformat-invalid-specifier
+KBUILD_CFLAGS += -Wformat-zero-length -Wnonnull
+# Requires clang-12+.
+ifeq ($(call clang-min-version, 120000),y)
+KBUILD_CFLAGS += -Wformat-insufficient-args
 endif
 endif
+KBUILD_CFLAGS += -Wno-sign-compare
+KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
+KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
+KBUILD_CFLAGS += $(call cc-disable-warning, unaligned-access)
+KBUILD_CFLAGS += $(call cc-disable-warning, cast-function-type-strict)
+endif
+
+endif
+
+#
+# W=2 - warnings which occur quite often but may still be relevant
+#
+ifneq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
+
+KBUILD_CFLAGS += -Wdisabled-optimization
+KBUILD_CFLAGS += -Wshadow
+KBUILD_CFLAGS += $(call cc-option, -Wlogical-op)
+KBUILD_CFLAGS += -Wmissing-field-initializers
+KBUILD_CFLAGS += -Wtype-limits
+KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
+KBUILD_CFLAGS += $(call cc-option, -Wunused-macros)
+
+KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN2
+
+endif
+
+#
+# W=3 - more obscure warnings, can most likely be ignored
+#
+ifneq ($(findstring 3, $(KBUILD_EXTRA_WARN)),)
+
+KBUILD_CFLAGS += -Wbad-function-cast
+KBUILD_CFLAGS += -Wcast-align
+KBUILD_CFLAGS += -Wcast-qual
+KBUILD_CFLAGS += -Wconversion
+KBUILD_CFLAGS += -Wpacked
+KBUILD_CFLAGS += -Wpadded
+KBUILD_CFLAGS += -Wpointer-arith
+KBUILD_CFLAGS += -Wredundant-decls
+KBUILD_CFLAGS += -Wsign-compare
+KBUILD_CFLAGS += -Wswitch-default
+KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
+
+KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
+
+endif
+
+#
+# W=e - error out on warnings
+#
+ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
+
+KBUILD_CFLAGS += -Werror
+
+endif

-- 
2.54.0

