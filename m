Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1381BC3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C4888C26;
	Sun, 11 Aug 2024 16:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BUxK+pvU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3651488B9B; Sun, 11 Aug 2024 16:52:55 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2A3E88AC0
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-39b27935379so13823875ab.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387971; x=1723992771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KBkjhxsqksQnxYqtk5cezP+tRjhShWLlVARiDbfwuI=;
 b=BUxK+pvUbf/opUPpY3qiYXPwFsetwuVRF/d3iae6finLC3vReT6DA2dSP54cJcUuEA
 c2JdcJpIgCuGRtL1mPeyhjUV4J22i5RV03sMkHlvhMtY2BSCPVVcPxWYgTa83VJ7ETJ2
 NqLNJlttfdJWp+YNcNPiM7bv8dG9PXnwIo/0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387971; x=1723992771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KBkjhxsqksQnxYqtk5cezP+tRjhShWLlVARiDbfwuI=;
 b=YK0fyVy/ihxZ3CUdxwAaHtcTwvJghv2KGbfPzIY+6/Srahs9L9dXBTIHiBsqkqlVIV
 Aby9szMHxw0eLDxGcHNyQh4g/pxPgkxrKd1efIWaKcrnFXeIpprq5Ac4RuhyvO1SacoT
 38YlWZ0CtfCQawTGjTQGblnNtcc7s6CXg6wCpKH6s8OTZjhvl5/G3zLOWLoQG9vCZnAg
 w51n56Bbzq4sXVeCx3XrGmq5qd4w450DcER+DzoRkyxUXXoY3f+5yEtrG4okupD1fnWF
 +J5orvPF9yPSXCEqwbzBkqvucRFzjM1cYMf2O6mYnAnNgRT51LsxX+St/+lC8yqLO9mE
 LjFA==
X-Gm-Message-State: AOJu0Yx8wpmBWwhJXfbsYHuKQNfSkotzWq3w7nSMi0K1k/i+3l4Bal2/
 F0A39jP8/2m48SHg62CoSAj/q4ZHajoDiJoA/62K0sEWbUNJ/68QXE8z9zAm4daxacEAAl/yQ7g
 =
X-Google-Smtp-Source: AGHT+IHOWys2ofUsbXpIeq1Cg0nLAWcpKE+1vIdZiRwy6gCQivHWBv7q5PAzhyb44a8S1n0AFu2DkA==
X-Received: by 2002:a05:6e02:1a4e:b0:397:2918:6f52 with SMTP id
 e9e14a558f8ab-39b86f73f8bmr89967295ab.25.1723387971586; 
 Sun, 11 Aug 2024 07:52:51 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 27/40] efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
Date: Sun, 11 Aug 2024 08:51:56 -0600
Message-Id: <20240811145209.4191404-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

