Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AABAC49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 13:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E836B88AF8;
	Tue,  6 Aug 2024 14:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dhheTIsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DB6A88A7B; Tue,  6 Aug 2024 14:59:50 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1099888A81
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-39b3e12754eso2219365ab.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 05:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722949182; x=1723553982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0K+TOY19s2dSEk9UB9cP8M2k4PElv8j3qwaYT3lC7X0=;
 b=dhheTIsUv1EAc+m9Pb7YeFuBBg24ZvTbGbJ7bx3J41XiA+uFoecXuw4a1+poOFFfXQ
 fZBCAV3E+hUfxMyIvinDZ7tDGQilXJWBwMe2YuO3im+VV+NEQ7A+Gtj7pkzcrP0ULrVL
 ZS/vBaNauIgAiQANWUhJoyAQrrCYKUWjR9xcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722949182; x=1723553982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K+TOY19s2dSEk9UB9cP8M2k4PElv8j3qwaYT3lC7X0=;
 b=GLYBoNrcSgVWzDWjt9StDq65yWsfiLhBXvyPhv9LfpVBSUZehSYIz+jGzeZUUk4bfR
 mVZSv2NWLMATqwrpsaOwsWKxPXYizu+E8TaWnWJ2PXvbZo2LHs1WPyvgLwHyOiQIIiG/
 t3qFcpaVMCUJaOHaxdnknPrpOG1d/5+Fm9p87YkbK9nuz8XYu3La/MIoaj91ibQz6Fn7
 RRk9tyV4cnLJ82SFjYrUAXsP8AtHaOmcwRKlJcnDaHb5INpu5JtaeupMLPtRM6D2UMfn
 TiZD3cuWGoBtZsx5mxkL3kNhoSGvLOyiGzlTPrbyjkb46lVXNHJF9vT1eIpc7/mp5rpV
 rImg==
X-Gm-Message-State: AOJu0YzdqAPwBKvB8vZQHUqeV1HP+a/9eRv8bLZ565+J3cZG0tmIN71S
 POi9nmiNmtnG34PlYiuWOmJ5UJ/N0NMxdNOKYUMqmJJx86/0kn0V16HYOA6gX70iq6EmGPnBwAI
 =
X-Google-Smtp-Source: AGHT+IFtt47vzDCAIvn0xTK95pNI7OPEgqI75OdxMv2FGIeFq5DS4gFM6XsyK3FFpypE4STrHmVB/w==
X-Received: by 2002:a92:c211:0:b0:39b:32f2:c34c with SMTP id
 e9e14a558f8ab-39b32f2c3bbmr90185965ab.8.1722949182397; 
 Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39b20ab5ccdsm36871565ab.40.2024.08.06.05.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Aug 2024 05:59:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Aaron Williams <awilliams@marvell.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Leo <ycliang@andestech.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Rick Chen <rick@andestech.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>
Subject: [PATCH v2 27/39] efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
Date: Tue,  6 Aug 2024 06:58:38 -0600
Message-Id: <20240806125850.2316956-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806125850.2316956-1-sjg@chromium.org>
References: <20240806125850.2316956-1-sjg@chromium.org>
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

This is not actually a command so the name is confusing. Use
BOOTEFI_HELLO_COMPILE instead. Put it in the efi_loader directory
with the other such config options.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/lib/Makefile            |  2 +-
 arch/riscv/lib/Makefile          |  2 +-
 arch/x86/lib/Makefile            |  2 +-
 cmd/Kconfig                      | 14 +-------------
 configs/octeontx2_95xx_defconfig |  2 +-
 configs/octeontx2_96xx_defconfig |  2 +-
 configs/octeontx_81xx_defconfig  |  2 +-
 configs/octeontx_83xx_defconfig  |  2 +-
 doc/develop/uefi/uefi.rst        |  2 +-
 lib/efi_loader/Kconfig           | 12 ++++++++++++
 lib/efi_loader/Makefile          |  2 +-
 test/py/tests/test_efi_fit.py    |  2 +-
 test/py/tests/test_efi_loader.py |  2 +-
 13 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 67275fba616..406797f998c 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -130,7 +130,7 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
 
-extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
+extra-$(CONFIG_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
 # TODO: As of v2019.01 the relocation code for the EFI application cannot
 # be built on ARMv7-M.
 ifndef CONFIG_CPU_V7M
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 65dc49f6fa5..3bd90c7a354 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -36,7 +36,7 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
 
-extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
+extra-$(CONFIG_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
 extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
 extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8fc35e1b51e..70dccd7f983 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -97,7 +97,7 @@ endif
 else
 
 ifndef CONFIG_SPL_BUILD
-ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
+ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_BOOTEFI_HELLO_COMPILE),)
 extra-y += $(EFI_CRT0) $(EFI_RELOC)
 endif
 endif
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..fcf6bb73f88 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -431,21 +431,9 @@ config CMD_BOOTEFI_BOOTMGR
 	  This subcommand will allow you to select the UEFI binary to be booted
 	  via UEFI variables Boot####, BootOrder, and BootNext.
 
-config CMD_BOOTEFI_HELLO_COMPILE
-	bool "Compile a standard EFI hello world binary for testing"
-	default y
-	help
-	  This compiles a standard EFI hello world application with U-Boot so
-	  that it can be used with the test/py testing framework. This is useful
-	  for testing that EFI is working at a basic level, and for bringing
-	  up EFI support on a new architecture.
-
-	  No additional space will be required in the resulting U-Boot binary
-	  when this option is enabled.
-
 config CMD_BOOTEFI_HELLO
 	bool "Allow booting a standard EFI hello world for testing"
-	depends on CMD_BOOTEFI_BINARY && CMD_BOOTEFI_HELLO_COMPILE
+	depends on CMD_BOOTEFI_BINARY && BOOTEFI_HELLO_COMPILE
 	default y if CMD_BOOTEFI_SELFTEST
 	help
 	  This adds a standard EFI hello world application to U-Boot so that
diff --git a/configs/octeontx2_95xx_defconfig b/configs/octeontx2_95xx_defconfig
index c5dc4f4dfa6..23c313375ac 100644
--- a/configs/octeontx2_95xx_defconfig
+++ b/configs/octeontx2_95xx_defconfig
@@ -38,7 +38,7 @@ CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Marvell> "
-# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
+# CONFIG_BOOTEFI_HELLO_COMPILE is not set
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
 CONFIG_CMD_MX_CYCLIC=y
diff --git a/configs/octeontx2_96xx_defconfig b/configs/octeontx2_96xx_defconfig
index ad61b80300f..197e72acd1f 100644
--- a/configs/octeontx2_96xx_defconfig
+++ b/configs/octeontx2_96xx_defconfig
@@ -38,7 +38,7 @@ CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Marvell> "
-# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
+# CONFIG_BOOTEFI_HELLO_COMPILE is not set
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
 CONFIG_CMD_MX_CYCLIC=y
diff --git a/configs/octeontx_81xx_defconfig b/configs/octeontx_81xx_defconfig
index 1d39bce6abd..b501d653c27 100644
--- a/configs/octeontx_81xx_defconfig
+++ b/configs/octeontx_81xx_defconfig
@@ -39,7 +39,7 @@ CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Marvell> "
-# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
+# CONFIG_BOOTEFI_HELLO_COMPILE is not set
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
 CONFIG_CMD_MX_CYCLIC=y
diff --git a/configs/octeontx_83xx_defconfig b/configs/octeontx_83xx_defconfig
index ba9fc5f9553..4a537f5cbbe 100644
--- a/configs/octeontx_83xx_defconfig
+++ b/configs/octeontx_83xx_defconfig
@@ -37,7 +37,7 @@ CONFIG_SYS_PBSIZE=1050
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Marvell> "
-# CONFIG_CMD_BOOTEFI_HELLO_COMPILE is not set
+# CONFIG_BOOTEFI_HELLO_COMPILE is not set
 CONFIG_CMD_MD5SUM=y
 CONFIG_MD5SUM_VERIFY=y
 CONFIG_CMD_MX_CYCLIC=y
diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index d450b12bf80..9aeee23a32e 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -693,7 +693,7 @@ Executing the built in hello world application
 
 A hello world UEFI application can be built with::
 
-    CONFIG_CMD_BOOTEFI_HELLO_COMPILE=y
+    CONFIG_BOOTEFI_HELLO_COMPILE=y
 
 It can be embedded into the U-Boot binary with::
 
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 1179c31bb13..ab2c1c44364 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -516,4 +516,16 @@ config EFI_HTTP_BOOT
 	  Enabling this option adds EFI HTTP Boot support. It allows to
 	  directly boot from network.
 
+config BOOTEFI_HELLO_COMPILE
+	bool "Compile a standard EFI hello world binary for testing"
+	default y
+	help
+	  This compiles a standard EFI hello world application with U-Boot so
+	  that it can be used with the test/py testing framework. This is useful
+	  for testing that EFI is working at a basic level, and for bringing
+	  up EFI support on a new architecture.
+
+	  No additional space will be required in the resulting U-Boot binary
+	  when this option is enabled.
+
 endif
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index 2af6f2066b5..27dbd9e760d 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -27,7 +27,7 @@ always += boothart.efi
 targets += boothart.o
 endif
 
-ifneq ($(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
+ifneq ($(CONFIG_BOOTEFI_HELLO_COMPILE),)
 always += helloworld.efi
 targets += helloworld.o
 endif
diff --git a/test/py/tests/test_efi_fit.py b/test/py/tests/test_efi_fit.py
index 0ad483500f8..550058a30fd 100644
--- a/test/py/tests/test_efi_fit.py
+++ b/test/py/tests/test_efi_fit.py
@@ -119,7 +119,7 @@ FDT_DATA = '''
 '''
 
 @pytest.mark.buildconfigspec('bootm_efi')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
 @pytest.mark.buildconfigspec('fit')
 @pytest.mark.notbuildconfigspec('generate_acpi_table')
 @pytest.mark.requiredtool('dtc')
diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049b..ef1f1f1afb3 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -148,7 +148,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
     return addr
 
 @pytest.mark.buildconfigspec('of_control')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('BOOTEFI_HELLO_COMPILE')
 def test_efi_helloworld_net(u_boot_console):
     """Run the helloworld.efi binary via TFTP.
 
-- 
2.34.1

