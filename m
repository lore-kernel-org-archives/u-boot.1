Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6558CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3908188EA3;
	Fri, 27 Sep 2024 00:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Nm6FLrtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C6F88EC9; Fri, 27 Sep 2024 00:00:42 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4063F88E9F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c582ca168fso10171076d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388035; x=1727992835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bdGHfvTeLVKwwdq/UiDzUe4Fjcz1UVxnYN6gDvQWEj8=;
 b=Nm6FLrttnIHmETDT5GlLy/zP5kb46G/jO4Go7F7ctQ5B/2HCFDlEQ7jZ/JHCypa5Zy
 p5kCpP2Zq2NQaKVwXRxIka/RPwekbLB2P3qFo+VM2uyi+vvgTPBHeky6UGTaLvavswkQ
 fvcjMIIfRBhI1UqwsGY7fwPEH0amVrdsWEYW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388035; x=1727992835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bdGHfvTeLVKwwdq/UiDzUe4Fjcz1UVxnYN6gDvQWEj8=;
 b=g0ooHJAWVi6K9AbHdG2qPYMVQgbbj2ZH/kxrAXh8abyDOgWulrMS3EUxNCisrg6rcz
 7CRCQTCP+Y12IICraqq/biPGo+6Xq2CPl0Z6OmYpqtpQReK/Ow0RkUNo037vwOVkphpE
 RcgSk+BGDiNrWachTadRC+ppYugZ1mWarQj3/FX+WcCZ/vVGw7sN4bJrqx6ndYnfU23T
 5aHtQBA8jAeVeSfCP50JO6dgXFF5vwSav74lV2Qpzlx4bTLehCORkWbgv35MMUvi5wji
 1EvV4IKDMmbSJHitxso+MdkYzBMkjUKjabrknGmMYnZAePRdnfU2dNxJB3FERxZT2VBh
 F4Ew==
X-Gm-Message-State: AOJu0Yx4/Ygfj2PSEG8Kz3jMBg96lI2J39VYpuP5ulbr9NrFm7XBxyv6
 x8aAA7c6XP1oWndNnayoAxIvFUWPCJfBaOflFjYxRBuYDTBI5pqDuFWe/L0mk2owcYtcM1hN+3V
 voUr3ic4=
X-Google-Smtp-Source: AGHT+IGr145yIf8/bfw3aNpGQony2t6fs3UQafmc8uPGwK0Vn2B/459FT1sV/l/jRXRKcobwhyNRzQ==
X-Received: by 2002:a05:6214:3b86:b0:6c5:5088:e39a with SMTP id
 6a1803df08f44-6cb3b5fae96mr14770506d6.29.1727388035381; 
 Thu, 26 Sep 2024 15:00:35 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:00:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 01/12] efi_loader: Rename and move CMD_BOOTEFI_HELLO_COMPILE
Date: Thu, 26 Sep 2024 23:59:31 +0200
Message-ID: <20240926215950.1265143-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926215950.1265143-1-sjg@chromium.org>
References: <20240926215950.1265143-1-sjg@chromium.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
index 5ef3c8a8748..74afedd5b5a 100644
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
index 94482758573..0760ca91d4f 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -720,7 +720,7 @@ Executing the built in hello world application
 
 A hello world UEFI application can be built with::
 
-    CONFIG_CMD_BOOTEFI_HELLO_COMPILE=y
+    CONFIG_BOOTEFI_HELLO_COMPILE=y
 
 It can be embedded into the U-Boot binary with::
 
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index e58b8825605..6f6fa8d629d 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -552,6 +552,18 @@ config EFI_HTTP_BOOT
 	  directly boot from network.
 endmenu
 
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
 
 source "lib/efi/Kconfig"
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
index 5f3b448a066..707b2c9e795 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -170,7 +170,7 @@ def do_test_efi_helloworld_net(u_boot_console, proto):
     assert expected_text not in output
 
 @pytest.mark.buildconfigspec('of_control')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('bootefi_hello_compile')
 @pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_helloworld_net_tftp(u_boot_console):
     """Run the helloworld.efi binary via TFTP.
-- 
2.43.0

