Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E96C04FFE
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 22:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB0638857D;
	Sat, 18 May 2024 00:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="CBMpy1m0";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="XfedN0to";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05D3D87DEA; Sat, 18 May 2024 00:09:35 +0200 (CEST)
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com
 [103.168.172.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A69F987E9B
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 00:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailfout.nyi.internal (Postfix) with ESMTP id BED0A138006B;
 Fri, 17 May 2024 18:09:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 17 May 2024 18:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715983771;
 x=1716070171; bh=4YJ3AZ6ryMEndiQEyVK2gZCzZw64TU+PEaTotcB/Agc=; b=
 CBMpy1m0WKnFUhFdYGAIk3lE4VrQexskm/BGmrt6j5VyqEdfoQJQu409zyRVFrHk
 SHC7tvR4F97BShyxD+6iwSoA3Men6lHSllsIP9TeElWrLc+0DQpAU6rdhelu2Mj4
 I2PWGGwto7+s70a76MNlvfo/mJlHw/QBn63FUze1wdMc2c08qEmfCk3LgW1h0wq/
 xQUpyjH0Fp9zrGDYG7kEV4laTUs1xgAOFY1IXcDs0lalMAI811qu8s2S/kr7Dze7
 F1RaDzo3Bvif9nFQOJlnUGLXSk/shD30gs5mVlDh3TugtFdsEh66WKMe9v31EYSc
 wUdASvLs1101d5/V3wP8uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715983771; x=
 1716070171; bh=4YJ3AZ6ryMEndiQEyVK2gZCzZw64TU+PEaTotcB/Agc=; b=X
 fedN0to1gjuVXirWsOLpbN4UitwohdsjN0AqFct936UZ3PnL5HNrDyppUxCduCJw
 csfO78CCN1nuhFhcJqFxbBP8KHaLKZk5UOBSTPBmIEy0nELk3jcr8GNUuC5i8BOY
 6q2wWTvbbDvUaH22e3Y5+0rw3zj/lUQ9yrzI1H5nka64gdsI9Yu5eI6HGFZxp0N6
 tX0a8hqf4OraMm9vWdkGb9Dyh9b2gEJJyp+SNmlCZtpkbqCdvWMl3PUJXpA06bLS
 L2V9cff82o/VjeQ+E/RHWJ9LqG//FXrTBPzqV9ATm1OJci8uM+LIwdvfLFkBuF09
 d8mJEqPdah9mkAzLcLiKg==
X-ME-Sender: <xms:m9VHZpB9tMAhVRUiP4qK4wG49kUkDre8zPpsnMhYogL7NeFA-_miRg>
 <xme:m9VHZnjyXh4z2dvCaY_eV0Mg1cbKRUsfWXx_EsLEnJ9rLj5YvDbdjyeZU4YPosYta
 s-5sLpWdo_SuV0u1XM>
X-ME-Received: <xmr:m9VHZkllRcqLjF9mh3TJ_4sQiGVfb3irA9sN5tmQKLtXWRw0SV362mo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehhedgtdeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhephfdufefhkeeuhffhleehudellefhkedvffduteehgfduieef
 gfeltdegueekleevnecuffhomhgrihhnpegtrhhttdgpshgrnhgusghogigpvghfihdrsh
 gsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhi
 rgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:m9VHZjwiu2oXWVDVL2yWfZ6wOfCqGrCP3xZwM2gczBJoFAVv64QxaA>
 <xmx:m9VHZuQ_A2Y1g6gZYl8zYOgTR59MUtTeeDmt_zDWVsc_EeY_oUXQ2g>
 <xmx:m9VHZmao33lfm__ouqvtrvvbAepEHia0ksJG64EIHbwH1C8KH4_w0Q>
 <xmx:m9VHZvToK_pYdDFb9gLu5mQ3m2DW_2AjsLzdRwt3kUiZ76YPJxZjtw>
 <xmx:m9VHZtFmfOeQdDljm92YFI0MiwP_Y6kCFhZjTGn22j1y41U8Qi7m1L_->
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 18:09:30 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 17 May 2024 23:09:27 +0100
Subject: [PATCH 1/3] sandbox: Move HOST_ARCH detection to Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240517-sandbox-hostarch-kconfig-v1-1-716c146635c9@flygoat.com>
References: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
In-Reply-To: <20240517-sandbox-hostarch-kconfig-v1-0-716c146635c9@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10629;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=MgF3M1iQLnuEMpuL47mnLqTwJ35Mgxzxhldo75aX+EY=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjT3q7M68ngX6WQImQiWrd2/7xT/696pH+95JP7xkRNYe
 KM9MeloRykLgxgHg6yYIkuIgFLfhsaLC64/yPoDM4eVCWQIAxenAEykOJDhnwbfv/M5kwoe8yZ1
 XPjtF8P/SGfOpKmHfp3jkC96vGBfVTwjwyPrFY2JAUZ3jlq8zbJbtG+pqe3GTdPLipWW/C8yPvN
 2CS8A
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Move host arch detection to Kconfig so we can make some
options depend on HOST_ARCH.

Also now we are using compiler macros to detect target
arch, which is more robust than looking at uname -a.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 Makefile                                          | 24 ---------------------
 arch/sandbox/Kconfig                              | 23 ++++++++++++++++++++
 arch/sandbox/config.mk                            | 12 +++++------
 arch/sandbox/lib/crt0_sandbox_efi.S               | 14 ++++++------
 arch/sandbox/lib/reloc_sandbox_efi.c              | 14 ++++++------
 include/efi_default_filename.h                    | 14 ++++++------
 include/host_arch.h                               | 26 -----------------------
 lib/efi_selftest/efi_selftest_miniapp_exception.c |  6 +++---
 8 files changed, 53 insertions(+), 80 deletions(-)

diff --git a/Makefile b/Makefile
index 44deb339af19..596f6458e6b2 100644
--- a/Makefile
+++ b/Makefile
@@ -16,29 +16,6 @@ NAME =
 # (this increases performance and avoids hard-to-debug behaviour)
 MAKEFLAGS += -rR
 
-# Determine target architecture for the sandbox
-include include/host_arch.h
-ifeq ("", "$(CROSS_COMPILE)")
-  MK_ARCH="${shell uname -m}"
-else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
-endif
-unexport HOST_ARCH
-ifeq ("x86_64", $(MK_ARCH))
-  export HOST_ARCH=$(HOST_ARCH_X86_64)
-else ifneq (,$(findstring $(MK_ARCH), "i386" "i486" "i586" "i686"))
-  export HOST_ARCH=$(HOST_ARCH_X86)
-else ifneq (,$(findstring $(MK_ARCH), "aarch64" "armv8l"))
-  export HOST_ARCH=$(HOST_ARCH_AARCH64)
-else ifneq (,$(findstring $(MK_ARCH), "arm" "armv7" "armv7a" "armv7l"))
-  export HOST_ARCH=$(HOST_ARCH_ARM)
-else ifeq ("riscv32", $(MK_ARCH))
-  export HOST_ARCH=$(HOST_ARCH_RISCV32)
-else ifeq ("riscv64", $(MK_ARCH))
-  export HOST_ARCH=$(HOST_ARCH_RISCV64)
-endif
-undefine MK_ARCH
-
 # Avoid funny character set dependencies
 unexport LC_ALL
 LC_COLLATE=C
@@ -1963,7 +1940,6 @@ define filechk_version.h
 	echo \#define U_BOOT_VERSION_NUM $(VERSION); \
 	echo \#define U_BOOT_VERSION_NUM_PATCH $$(echo $(PATCHLEVEL) | \
 		sed -e "s/^0*//"); \
-	echo \#define HOST_ARCH $(HOST_ARCH); \
 	echo \#define CC_VERSION_STRING \"$$(LC_ALL=C $(CC) --version | head -n 1)\"; \
 	echo \#define LD_VERSION_STRING \"$$(LC_ALL=C $(LD) --version | head -n 1)\"; )
 endef
diff --git a/arch/sandbox/Kconfig b/arch/sandbox/Kconfig
index 1c8353d6156d..c3954e33aceb 100644
--- a/arch/sandbox/Kconfig
+++ b/arch/sandbox/Kconfig
@@ -47,6 +47,29 @@ config HOST_32BIT
 config HOST_64BIT
 	def_bool $(cc-define,_LP64)
 
+config HOST_ARCH_X86
+	def_bool $(cc-define,__i386__)
+
+config HOST_ARCH_X86_64
+	def_bool $(cc-define,__x86_64__)
+
+config HOST_ARCH_ARM
+	def_bool $(cc-define,__arm__)
+
+config HOST_ARCH_AARCH64
+	def_bool $(cc-define,__aarch64__)
+
+config HOST_ARCH_RISCV32
+	def_bool $(cc-define,__riscv_xlen 32)
+
+config HOST_ARCH_RISCV64
+	def_bool $(cc-define,__riscv_xlen 64)
+
+config HOST_ARCH_UNKNOWN
+	def_bool !HOST_ARCH_X86 && !HOST_ARCH_X86_64 && \
+		 !HOST_ARCH_ARM && !HOST_ARCH_AARCH64 && \
+		 !HOST_ARCH_RISCV32 && !HOST_ARCH_RISCV64
+
 config HOST_HAS_SDL
 	def_bool $(success,sdl2-config --version)
 
diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index 405843800e9e..6b1da993ba4e 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -44,27 +44,27 @@ cmd_u-boot-spl = (cd $(obj) && $(CC) -o $(SPL_BIN) -Wl,-T u-boot-spl.lds \
 	-Wl,--no-whole-archive \
 	$(PLATFORM_LIBS) -Wl,-Map -Wl,u-boot-spl.map -Wl,--gc-sections)
 
-ifeq ($(HOST_ARCH),$(HOST_ARCH_X86_64))
+ifeq ($(CONFIG_HOST_ARCH_X86_64),y)
 EFI_LDS := ${SRCDIR}/../../../arch/x86/lib/elf_x86_64_efi.lds
 EFI_TARGET := --target=efi-app-x86_64
-else ifeq ($(HOST_ARCH),$(HOST_ARCH_X86))
+else ifeq ($(CONFIG_HOST_ARCH_X86),y)
 EFI_LDS := ${SRCDIR}/../../../arch/x86/lib/elf_ia32_efi.lds
 EFI_TARGET := --target=efi-app-ia32
-else ifeq ($(HOST_ARCH),$(HOST_ARCH_AARCH64))
+else ifeq ($(CONFIG_HOST_ARCH_AARCH64),y)
 EFI_LDS := ${SRCDIR}/../../../arch/arm/lib/elf_aarch64_efi.lds
 OBJCOPYFLAGS += -j .text -j .secure_text -j .secure_data -j .rodata -j .data \
 		-j __u_boot_list -j .rela.dyn -j .got -j .got.plt \
 		-j .binman_sym_table -j .text_rest \
 		-j .efi_runtime -j .efi_runtime_rel
-else ifeq ($(HOST_ARCH),$(HOST_ARCH_ARM))
+else ifeq ($(CONFIG_HOST_ARCH_ARM),y)
 EFI_LDS := ${SRCDIR}/../../../arch/arm/lib/elf_arm_efi.lds
 OBJCOPYFLAGS += -j .text -j .secure_text -j .secure_data -j .rodata -j .hash \
 		-j .data -j .got -j .got.plt -j __u_boot_list -j .rel.dyn \
 		-j .binman_sym_table -j .text_rest \
 		-j .efi_runtime -j .efi_runtime_rel
-else ifeq ($(HOST_ARCH),$(HOST_ARCH_RISCV32))
+else ifeq ($(CONFIG_HOST_ARCH_RISCV32),y)
 EFI_LDS := ${SRCDIR}/../../../arch/riscv/lib/elf_riscv32_efi.lds
-else ifeq ($(HOST_ARCH),$(HOST_ARCH_RISCV64))
+else ifeq ($(CONFIG_HOST_ARCH_RISCV64),y)
 EFI_LDS := ${SRCDIR}/../../../arch/riscv/lib/elf_riscv64_efi.lds
 endif
 EFI_CRT0 := crt0_sandbox_efi.o
diff --git a/arch/sandbox/lib/crt0_sandbox_efi.S b/arch/sandbox/lib/crt0_sandbox_efi.S
index 88537345ddb3..ffac3520f7df 100644
--- a/arch/sandbox/lib/crt0_sandbox_efi.S
+++ b/arch/sandbox/lib/crt0_sandbox_efi.S
@@ -5,28 +5,28 @@
  * Copyright (c) 2019 Heinrich Schuchardt
  */
 
-#include <host_arch.h>
+#include <config.h>
 
-#if HOST_ARCH == HOST_ARCH_X86_64
+#if CONFIG_IS_ENABLED(HOST_ARCH_X86_64)
 #include "../../../arch/x86/lib/crt0_x86_64_efi.S"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_X86
+#if CONFIG_IS_ENABLED(HOST_ARCH_X86)
 #include "../../../arch/x86/lib/crt0_ia32_efi.S"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_AARCH64
+#if CONFIG_IS_ENABLED(HOST_ARCH_AARCH64)
 #include "../../../arch/arm/lib/crt0_aarch64_efi.S"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_ARM
+#if CONFIG_IS_ENABLED(HOST_ARCH_ARM)
 #include "../../../arch/arm/lib/crt0_arm_efi.S"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_RISCV32
+#if CONFIG_IS_ENABLED(HOST_ARCH_RISCV32)
 #include "../../../arch/riscv/lib/crt0_riscv_efi.S"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_RISCV64
+#if CONFIG_IS_ENABLED(HOST_ARCH_RISCV64)
 #include "../../../arch/riscv/lib/crt0_riscv_efi.S"
 #endif
diff --git a/arch/sandbox/lib/reloc_sandbox_efi.c b/arch/sandbox/lib/reloc_sandbox_efi.c
index a21e6757c551..b88c427b5f74 100644
--- a/arch/sandbox/lib/reloc_sandbox_efi.c
+++ b/arch/sandbox/lib/reloc_sandbox_efi.c
@@ -5,28 +5,28 @@
  * Copyright (c) 2019 Heinrich Schuchardt
  */
 
-#include <host_arch.h>
+#include <config.h>
 
-#if HOST_ARCH == HOST_ARCH_X86_64
+#if CONFIG_IS_ENABLED(HOST_ARCH_X86_64)
 #include "../../../arch/x86/lib/reloc_x86_64_efi.c"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_X86
+#if CONFIG_IS_ENABLED(HOST_ARCH_X86)
 #include "../../../arch/x86/lib/reloc_ia32_efi.c"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_AARCH64
+#if CONFIG_IS_ENABLED(HOST_ARCH_AARCH64)
 #include "../../../arch/arm/lib/reloc_aarch64_efi.c"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_ARM
+#if CONFIG_IS_ENABLED(HOST_ARCH_ARM)
 #include "../../../arch/arm/lib/reloc_arm_efi.c"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_RISCV32
+#if CONFIG_IS_ENABLED(HOST_ARCH_RISCV32)
 #include "../../../arch/riscv/lib/reloc_riscv_efi.c"
 #endif
 
-#if HOST_ARCH == HOST_ARCH_RISCV64
+#if CONFIG_IS_ENABLED(HOST_ARCH_RISCV64)
 #include "../../../arch/riscv/lib/reloc_riscv_efi.c"
 #endif
diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
index 77932984b557..480fa694b6a9 100644
--- a/include/efi_default_filename.h
+++ b/include/efi_default_filename.h
@@ -11,23 +11,23 @@
 #ifndef _EFI_DEFAULT_FILENAME_H
 #define _EFI_DEFAULT_FILENAME_H
 
-#include <host_arch.h>
+#include <config.h>
 
 #undef BOOTEFI_NAME
 
 #ifdef CONFIG_SANDBOX
 
-#if HOST_ARCH == HOST_ARCH_X86_64
+#if CONFIG_IS_ENABLED(HOST_ARCH_X86_64)
 #define BOOTEFI_NAME "BOOTX64.EFI"
-#elif HOST_ARCH == HOST_ARCH_X86
+#elif CONFIG_IS_ENABLED(HOST_ARCH_X86)
 #define BOOTEFI_NAME "BOOTIA32.EFI"
-#elif HOST_ARCH == HOST_ARCH_AARCH64
+#elif CONFIG_IS_ENABLED(HOST_ARCH_AARCH64)
 #define BOOTEFI_NAME "BOOTAA64.EFI"
-#elif HOST_ARCH == HOST_ARCH_ARM
+#elif CONFIG_IS_ENABLED(HOST_ARCH_ARM)
 #define BOOTEFI_NAME "BOOTARM.EFI"
-#elif HOST_ARCH == HOST_ARCH_RISCV32
+#elif CONFIG_IS_ENABLED(HOST_ARCH_RISCV32)
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#elif HOST_ARCH == HOST_ARCH_RISCV64
+#elif CONFIG_IS_ENABLED(HOST_ARCH_RISCV64)
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
 #else
 #error Unsupported UEFI architecture
diff --git a/include/host_arch.h b/include/host_arch.h
deleted file mode 100644
index 261194bd7c6e..000000000000
--- a/include/host_arch.h
+++ /dev/null
@@ -1,26 +0,0 @@
-#if 0
-# SPDX SPDX-License-Identifier: GPL-2.0+
-#
-# Constants defining the host architecture in assembler, C, and make files.
-# The values are arbitrary.
-#
-# Copyright 2019 Heinrich Schuchardt <xypron.glpk@gmx.de>
-#endif
-
-#if 0
-export HOST_ARCH_AARCH64=0xaa64
-export HOST_ARCH_ARM=0x00a7
-export HOST_ARCH_RISCV32=0x5032
-export HOST_ARCH_RISCV64=0x5064
-export HOST_ARCH_X86=0x0386
-export HOST_ARCH_X86_64=0x8664
-#endif
-
-#include <version.h>
-
-#define HOST_ARCH_AARCH64 0xaa64
-#define HOST_ARCH_ARM 0x00a7
-#define HOST_ARCH_RISCV32 0x5032
-#define HOST_ARCH_RISCV64 0x5064
-#define HOST_ARCH_X86 0x0386
-#define HOST_ARCH_X86_64 0x8664
diff --git a/lib/efi_selftest/efi_selftest_miniapp_exception.c b/lib/efi_selftest/efi_selftest_miniapp_exception.c
index f668cdac4ab2..2dfbb7c74075 100644
--- a/lib/efi_selftest/efi_selftest_miniapp_exception.c
+++ b/lib/efi_selftest/efi_selftest_miniapp_exception.c
@@ -36,11 +36,11 @@ efi_status_t EFIAPI efi_main(efi_handle_t handle,
 #elif defined(CONFIG_X86)
 	asm volatile (".word 0xffff\n");
 #elif defined(CONFIG_SANDBOX)
-#if (HOST_ARCH == HOST_ARCH_ARM || HOST_ARCH == HOST_ARCH_AARCH64)
+#if (CONFIG_IS_ENABLED(HOST_ARCH_ARM) || CONFIG_IS_ENABLED(HOST_ARCH_AARCH64))
 	asm volatile (".word 0xe7f7defb\n");
-#elif (HOST_ARCH == HOST_ARCH_RISCV32 || HOST_ARCH == HOST_ARCH_RISCV64)
+#elif (CONFIG_IS_ENABLED(HOST_ARCH_RISCV32) || CONFIG_IS_ENABLED(HOST_ARCH_RISCV64))
 	asm volatile (".word 0xffffffff\n");
-#elif (HOST_ARCH == HOST_ARCH_X86 || HOST_ARCH == HOST_ARCH_X86_64)
+#elif (CONFIG_IS_ENABLED(HOST_ARCH_X86) || CONFIG_IS_ENABLED(HOST_ARCH_X86_64))
 	asm volatile (".word 0xffff\n");
 #endif
 #endif

-- 
2.34.1

