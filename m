Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE72FC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6042388AF2;
	Thu, 15 Aug 2024 22:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LRgtXDR0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE3C88AE8; Thu, 15 Aug 2024 22:24:44 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F38C88A99
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39d21fdc11bso3113555ab.2
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753470; x=1724358270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSSSzP7pSha7DhHwYCjGiPmq8bJJdBPmV1a/EEFeISM=;
 b=LRgtXDR0sg+1N2/rC1k29CrrsNLyHF9R/k0uSRt1odiCeiydMZhCjaGNBSw6/5pmLx
 TCgBaYYcjYUZoWuOZSZ5NT/v1jDMViQ3Iz5bsv4CRbJpu1Nir3TJN06STa6uCC2FI3hA
 lxre4dz6WygMvqatU3TmmG0xnc1x5e9PQ1ypA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753470; x=1724358270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSSSzP7pSha7DhHwYCjGiPmq8bJJdBPmV1a/EEFeISM=;
 b=ewE6TrSq3t752f7jwx5BxjXPmBKlV8Soe0AKLeE+NT9TUul2G2rtRFV/WmyhHEN3xH
 hyg4W4/vKNnd0G/XWPCXVyVInoSVd5msV+ubYU2PEW9tqSh3DW45pw489AxNSc9QH0Sv
 8qWCpre42uTe9FQX+f8Nmt5zf54jpje2AfzZrlVRI2PTFZ9gOrwQ6ZhJ2TLtkEGi6c8j
 3/FrQ+pVJzbzR/SpBHumzX52A93JidL8M6xlOMJsHJLMZ1Eq/2dBwloXiFTUfoQRAFwS
 qAgcaES3fz+Dm749qq9uMF1+zyo5n2wWLfjpFQ+NBAw4AvjrhwhHyTIyprSgSVtUNhCL
 daEg==
X-Gm-Message-State: AOJu0YyfAlcP0QIqR8uKhochnMrWs1LORRuYnoFKgbmtwnuRG0Z48f3q
 Ui9Ry4aNg6Y/3bwKgG36ZHFENQsRksaUtojTVcmwinGEjVUQd3QNJ+qlinlwMLxpXN1HlzZLfY9
 AMA==
X-Google-Smtp-Source: AGHT+IGUznsY4TAGRg8vmXrBoxtnLgszs73JjjAlw7j0HK/j+kouT0ZeUd+msl1Nt8FzC0ES/bDxCg==
X-Received: by 2002:a05:6e02:b2c:b0:39d:2100:ec87 with SMTP id
 e9e14a558f8ab-39d26d6446bmr12910175ab.18.1723753470281; 
 Thu, 15 Aug 2024 13:24:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 03/14] efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
Date: Thu, 15 Aug 2024 14:24:13 -0600
Message-Id: <20240815202424.766778-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

The link rule (for $(obj)/%_efi.so) in scripts/Makefile.lib handles
pulling in efi_crt0.o and efi_reloc.o so drop the 'extra' rules.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Drop the extra- rules since scripts/Makefile.lib takes care of it

 arch/arm/lib/Makefile            |  1 -
 arch/riscv/lib/Makefile          |  1 -
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
 13 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 67275fba616..4e54c577cc3 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -130,7 +130,6 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
 
-extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
 # TODO: As of v2019.01 the relocation code for the EFI application cannot
 # be built on ARMv7-M.
 ifndef CONFIG_CPU_V7M
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 65dc49f6fa5..4f6272aab6e 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -36,7 +36,6 @@ CFLAGS_REMOVE_$(EFI_CRT0) := $(CFLAGS_NON_EFI)
 CFLAGS_$(EFI_RELOC) := $(CFLAGS_EFI)
 CFLAGS_REMOVE_$(EFI_RELOC) := $(CFLAGS_NON_EFI)
 
-extra-$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE) += $(EFI_CRT0) $(EFI_RELOC)
 extra-$(CONFIG_CMD_BOOTEFI_SELFTEST) += $(EFI_CRT0) $(EFI_RELOC)
 extra-$(CONFIG_EFI) += $(EFI_CRT0) $(EFI_RELOC)
 
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 8fc35e1b51e..8bc8d92172b 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -97,7 +97,7 @@ endif
 else
 
 ifndef CONFIG_SPL_BUILD
-ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST)$(CONFIG_CMD_BOOTEFI_HELLO_COMPILE),)
+ifneq ($(CONFIG_CMD_BOOTEFI_SELFTEST),)
 extra-y += $(EFI_CRT0) $(EFI_RELOC)
 endif
 endif
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 8af136d2bd4..f8a7e03400a 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -438,21 +438,9 @@ config CMD_BOOTEFI_BOOTMGR
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

