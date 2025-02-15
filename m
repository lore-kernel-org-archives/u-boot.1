Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F59C02198
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66E280F10;
	Sat, 15 Feb 2025 04:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MsS9FfUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44A9080FA4; Sat, 15 Feb 2025 04:24:36 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65B4880ECC
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so8707225ab.2
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589870; x=1740194670; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cc7XddgZcmK5pVKWb9AI/VuRzUKhR6Ogkkmp8E96VUw=;
 b=MsS9FfUMe4jbp0U0GdgB9toTSNpYkd8oAi16pTsL/K4xn30hcx3Fi9iAloxDbhulmJ
 izhrruYB79yVgpAuCGMIqLnRlGBk8mkCHPm/kJ/TzoNQFBrElQbQRvb9XXpE8EyB1Pzv
 X8ZhA489XVNVZTkTjIWILJBV4N5kLmoq7fCWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589870; x=1740194670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cc7XddgZcmK5pVKWb9AI/VuRzUKhR6Ogkkmp8E96VUw=;
 b=s2gq8YI9ccpw+Lc+m8yoXxh3seGMHW13hxTWzFuR50El7hYwJxguNBthd1jcXD/tSR
 W/4YiQW/YZSz/gL6+4DCKv38IuUG8+VlEHYEYsG2XAAhLxDlrtVuIkXJ/PeUMU5c+zCa
 ro2Z0c88+ydVIhdnV6F6X19ekU0kGcXPxa5qONOlH02RxbV8qx7p0Vs23KXZKjuo0Lg5
 9Tgb8Mx3PSLmU+zizKY6DmKGdImUxl+90Q4BcCy7pQkiThWgo6ZhlrAGyudqA5JmBr0b
 sqvOp9JxGGOVB5RhJfFRDWVwnpNV9RUhHEKRmxf3WuZxoQ5YVtlvx73Li68KrFEuOn0D
 O4BA==
X-Gm-Message-State: AOJu0YybJEfTdPjdHLjvncWCVJjuSUU2v61e1wjqHG76S7d/XrwESi0p
 TEOnptyCfYNiL9fG0zQetdtzND+6KFG8iZmjZgNVqfGrlzRH51dh3AJLHWnj8zLpHul9ebx0hZI
 =
X-Gm-Gg: ASbGnct5V4BbOloS77adUP8xVQtqKqj6mdoxF4o21c7d9z4g7CS0l0DIG0NP8Pme1Hv
 EmiVnfdshM3VQhSXtSdGJqjmFd6V7MadpuKD/0iWvC+MfuCx5YRjU9C8K3MN0N2pMa9G5YRJawQ
 aSR3wW36sngMLgnDNtrjHmeIVP9sJeBeYCnniQAWV7+TH9ED4HEFPxmKB41JR5je/DGWeFgqZ4C
 JzDysXI9/YmO0mQd1gySt2RKJl7Gp8IuCdgyQabr45tg1VORo0mdqqb12nilAKJeEdDSyQDNH5a
 s8q/pTznnTYMwefKfRbPz5ofYBL/qLYEOpVUUfwDkjT1qBXFUTZp
X-Google-Smtp-Source: AGHT+IGM3F2Ccn5QshuSAsnaMdw5U6PUV0L4t4IPUjH9qSza3fQrG+CU7eJ1nFDNL+bpn56sSizHQA==
X-Received: by 2002:a05:6e02:3182:b0:3d0:1ee6:731b with SMTP id
 e9e14a558f8ab-3d28092be7cmr14908615ab.15.1739589870374; 
 Fri, 14 Feb 2025 19:24:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:24:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH v4 29/29] efi: arm: Add an EFI app for arm64
Date: Fri, 14 Feb 2025 20:22:50 -0700
Message-ID: <20250215032254.4121030-30-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

Introduce an EFI app for arm64 and update the documentation.

Provide a value for LOAD_ADDR to avoid a link error.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Use ARCH_EFI instead of VENDOR_EFI
- Merge the linker-script rules into Kconfig in this patch
- Drop patch 'Select the EFI linker script for the app'

 Kconfig                               |  1 +
 MAINTAINERS                           |  4 ++-
 arch/arm/dts/efi-arm_app.dts          | 31 ++++++++++++++++
 board/efi/Kconfig                     | 23 ++++++++++++
 board/efi/efi-arm_app/Kconfig         | 19 ++++++++++
 board/efi/efi-arm_app/MAINTAINERS     | 13 +++++++
 board/efi/efi-arm_app/Makefile        |  5 +++
 board/efi/efi-arm_app/board.c         | 18 ++++++++++
 board/efi/efi-arm_app/efi-arm_app.env | 11 ++++++
 configs/efi-arm_app64_defconfig       | 51 +++++++++++++++++++++++++++
 doc/develop/uefi/u-boot_on_efi.rst    | 17 ++++-----
 lib/efi/Kconfig                       |  2 +-
 12 files changed, 185 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/dts/efi-arm_app.dts
 create mode 100644 board/efi/efi-arm_app/Kconfig
 create mode 100644 board/efi/efi-arm_app/MAINTAINERS
 create mode 100644 board/efi/efi-arm_app/Makefile
 create mode 100644 board/efi/efi-arm_app/board.c
 create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
 create mode 100644 configs/efi-arm_app64_defconfig

diff --git a/Kconfig b/Kconfig
index 2e63896c477..5ffdc481827 100644
--- a/Kconfig
+++ b/Kconfig
@@ -551,6 +551,7 @@ config SYS_LOAD_ADDR
 	default 0x12000000 if ARCH_MX6 && !(MX6SL || MX6SLL  || MX6SX || MX6UL || MX6ULL)
 	default 0x80800000 if ARCH_MX7
 	default 0x90000000 if FSL_LSCH2 || FSL_LSCH3
+	default 0x02000000 if ARCH_EFI
 	default 0x0 if ARCH_SC5XX
 	help
 	  Address in memory to use as the default safe load address.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8132ab3987d..494d4424ce2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1066,12 +1066,14 @@ M:	Simon Glass <sjg@chromium.org>
 M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
 S:	Maintained
 W:	https://docs.u-boot.org/en/latest/develop/uefi/u-boot_on_efi.html
+F:	board/efi/efi-arm_app
 F:	board/efi/efi-x86_app
+F:	configs/efi-arm_app*
 F:	configs/efi-x86_app*
 F:	doc/develop/uefi/u-boot_on_efi.rst
 F:	drivers/block/efi-media-uclass.c
 F:	drivers/block/sb_efi_media.c
-F:	lib/efi/efi_app.c
+F:	lib/efi/
 F:	scripts/build-efi.py
 F:	test/dm/efi_media.c
 
diff --git a/arch/arm/dts/efi-arm_app.dts b/arch/arm/dts/efi-arm_app.dts
new file mode 100644
index 00000000000..38cab04e510
--- /dev/null
+++ b/arch/arm/dts/efi-arm_app.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2015 Google, Inc
+ */
+
+/dts-v1/;
+
+/include/ "skeleton.dtsi"
+
+/ {
+	model = "EFI ARM Application";
+	compatible = "efi,arm-app";
+
+	chosen {
+		stdout-path = &serial;
+	};
+
+	serial: serial {
+		compatible = "efi,uart";
+	};
+
+	reset {
+		compatible = "efi,reset";
+		bootph-all;
+	};
+	efi-fb {
+		compatible = "efi-fb";
+		bootph-some-ram;
+	};
+
+};
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 4c68d85a076..174e6ecd6f4 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -45,4 +45,27 @@ source "board/efi/efi-x86_payload/Kconfig"
 
 endif  # X86
 
+if ARM
+
+choice
+	prompt "Mainboard model"
+	optional
+
+config TARGET_EFI_ARM_APP64
+	bool "64-bit efi application"
+	select EFI_APP
+	select SYS_CUSTOM_LDSCRIPT
+	select ARM64
+	help
+	  This target is used for running U-Boot on top of EFI in 64-bit mode.
+	  In this case EFI does the early initialisation, and U-Boot
+	  takes over once the RAM, video and CPU are fully running.
+	  U-Boot is loaded as an application from EFI.
+
+endchoice
+
+source "board/efi/efi-arm_app/Kconfig"
+
+endif  # ARM
+
 endif  # ARCH_EFI
diff --git a/board/efi/efi-arm_app/Kconfig b/board/efi/efi-arm_app/Kconfig
new file mode 100644
index 00000000000..6e64bc8a721
--- /dev/null
+++ b/board/efi/efi-arm_app/Kconfig
@@ -0,0 +1,19 @@
+if EFI_APP
+
+config SYS_BOARD
+	default "efi-arm_app"
+
+config SYS_VENDOR
+	default "efi"
+
+config SYS_SOC
+	default "efi"
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	imply VIDEO_EFI
+
+config SYS_LDSCRIPT
+	default "arch/arm/lib/elf_aarch64_efi.lds"
+
+endif
diff --git a/board/efi/efi-arm_app/MAINTAINERS b/board/efi/efi-arm_app/MAINTAINERS
new file mode 100644
index 00000000000..3114db69a35
--- /dev/null
+++ b/board/efi/efi-arm_app/MAINTAINERS
@@ -0,0 +1,13 @@
+EFI-ARM_APP32 BOARD
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	board/efi/Kconfig
+F:	board/efi/efi-arm_app/
+F:	configs/efi-arm_app32_defconfig
+
+EFI-ARM_APP64 BOARD
+M:	Simon Glass <sjg@chromium.org>
+S:	Maintained
+F:	board/efi/Kconfig
+F:	board/efi/efi-arm_app/
+F:	configs/efi-arm_app64_defconfig
diff --git a/board/efi/efi-arm_app/Makefile b/board/efi/efi-arm_app/Makefile
new file mode 100644
index 00000000000..fc6ef159473
--- /dev/null
+++ b/board/efi/efi-arm_app/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2018, Bin Meng <bmeng.cn@gmail.com>
+
+obj-y	+= board.o
diff --git a/board/efi/efi-arm_app/board.c b/board/efi/efi-arm_app/board.c
new file mode 100644
index 00000000000..239e1fbaba4
--- /dev/null
+++ b/board/efi/efi-arm_app/board.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2015 Google, Inc
+ */
+
+#include <init.h>
+
+struct mm_region *mem_map;
+
+int print_cpuinfo(void)
+{
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
diff --git a/board/efi/efi-arm_app/efi-arm_app.env b/board/efi/efi-arm_app/efi-arm_app.env
new file mode 100644
index 00000000000..b28c15556de
--- /dev/null
+++ b/board/efi/efi-arm_app/efi-arm_app.env
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Environment file for ARM EFI app
+ *
+ * Copyright 2025, Simon Glass <simon.glass@canonical.com>
+ */
+
+/* common console settings */
+stdin=serial
+stdout=serial,vidconsole
+stderr=serial,vidconsole
diff --git a/configs/efi-arm_app64_defconfig b/configs/efi-arm_app64_defconfig
new file mode 100644
index 00000000000..0199fb16467
--- /dev/null
+++ b/configs/efi-arm_app64_defconfig
@@ -0,0 +1,51 @@
+CONFIG_ARM=y
+# CONFIG_ARM64_CRC32 is not set
+CONFIG_ARCH_EFI_ARM=y
+CONFIG_NR_DRAM_BANKS=8
+CONFIG_ENV_SIZE=0x1000
+CONFIG_DEFAULT_DEVICE_TREE="efi-arm_app"
+CONFIG_DEBUG_UART_BASE=0x0
+CONFIG_DEBUG_UART_CLOCK=0
+CONFIG_DEBUG_UART=y
+CONFIG_TARGET_EFI_ARM_APP64=y
+CONFIG_EFI=y
+CONFIG_EFI_APP_64BIT=y
+CONFIG_FIT=y
+# CONFIG_BOOTSTD is not set
+CONFIG_SHOW_BOOT_PROGRESS=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_SYS_PBSIZE=532
+CONFIG_SYS_CONSOLE_INFO_QUIET=y
+CONFIG_LOG=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_MAC_PARTITION=y
+CONFIG_ISO_PARTITION=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_BOOTFILE=y
+CONFIG_BOOTFILE="bzImage"
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_EFI_NET=y
+CONFIG_DM_RNG=y
+CONFIG_SYSRESET=y
+CONFIG_VIDEO=y
+CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_CMD_DHRYSTONE=y
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 9d441cdc2c5..b1d5faa3463 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -27,16 +27,17 @@ Running U-Boot on EFI is useful in several situations:
 
 Status
 ------
-Only x86 is supported at present. If you are using EFI on another architecture
-you may want to reconsider. However, much of the code is generic so could be
-ported.
+Only x86 and ARM64 are supported at present. If you are using EFI on another
+architecture you may want to reconsider. However, much of the code is generic so
+could be ported.
 
-U-Boot supports running as an EFI application for both 32- and 64-bit EFI.
+U-Boot supports running as an EFI application for both 32- and 64-bit EFI on
+x86, and for 64-bit on ARM.
 
-U-Boot supports building itself as a payload for either 32-bit or 64-bit EFI.
-U-Boot is packaged up and loaded in its entirety by EFI. Once started, U-Boot
-changes to 32-bit mode (currently) and takes over the machine. You can use
-devices, boot a kernel, etc.
+On x86, U-Boot supports building itself as a payload for either 32-bit or 64-bit
+EFI. U-Boot is packaged up and loaded in its entirety by EFI. Once started,
+U-Boot changes to 32-bit mode (currently) and takes over the machine. You can
+use devices, boot a kernel, etc.
 
 
 Build Instructions
diff --git a/lib/efi/Kconfig b/lib/efi/Kconfig
index 18f69bdcfbe..18b73965469 100644
--- a/lib/efi/Kconfig
+++ b/lib/efi/Kconfig
@@ -17,7 +17,7 @@ choice
 
 config EFI_APP
 	bool "Support running as an EFI application"
-	depends on !ARM
+	depends on X86 || ARM
 	select CHARSET
 	help
 	  Build U-Boot as an application which can be started from EFI. This
-- 
2.43.0

