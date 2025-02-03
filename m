Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A263C02196
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:47:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F10780819;
	Mon,  3 Feb 2025 18:44:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LWhGiziu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BEFC8070F; Mon,  3 Feb 2025 18:44:49 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40BDD80AE1
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:44:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3eb790888c6so1287610b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604683; x=1739209483; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7eS6MSjjvlFHi5glA2+lIWYR5hhUPnyvQxsBM5gByUE=;
 b=LWhGiziulDjYeWan29tAzb7L0e+z198NF8nIL1VN2yyySGcwZNHYLPMKR8Y8KPlX6s
 QEtW9ADE1HNP77kaA15MRMo+0bX12EZYF+aFIJzbLuu2SoyiYvj2gGgQme5jM8e/5dbl
 utRuVcNBALoJVYHuyn4Xn3dT1z+z+q7iEiYb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604683; x=1739209483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7eS6MSjjvlFHi5glA2+lIWYR5hhUPnyvQxsBM5gByUE=;
 b=SVKIa3pJy7Ahk03o/mUSJiUpk2BIvKi9018wUdklrKhV17Ur5uX1DqCs0Ei8n3zpJS
 l1lpvo22n8o5wP95aEpQhtUlnAOZkrmDOMLqsU65Jbbd2uiVphiioLSCaoWW8KgUdG42
 ld4+yOMe5KIz1kiCxxJnQ/mcWRIncmbjOKEx0VRKNWuO3urrwQYHYNx5ULrxOlQ4e62G
 JO0rEyK1HFBOXc6ag43d2eAt46c2iuIhEtp5V/qsxqeAfHKFk2oJllJtpaX004vNZlLA
 buObclwddXLcRH0hVAU0cXls29DOCqQLUlFYrSiu2RurOHwKPT17wLOKbdEwN1MlpqT9
 NZJA==
X-Gm-Message-State: AOJu0Yx2m7hWUPA5yF7LOkD4qgDskHz/RRa7b7FjV7hl8yXQ0xNjDnvp
 Ipy2en29N0TWVUJGRNb6qRcf+R/D09Q59Bbk6vPFCxn83Dd5lQ9zwRxXBqRdT81SRyTlztrwp2Q
 =
X-Gm-Gg: ASbGncu+q7aV0IcFfFCn9jCc85U+5+7hMa7rHo1GwD4oEH+KfZg7vaoRSGprQl2nurK
 49EA7cxPPIKudKxM8zZk66+ekr0LJPTVFQZBMa8THU8TCWzQat0njHIQfduPy9L10vMdrzNiZXM
 Sryq19P6QV5+UOBDBqSXVac0Q0VnvcFYEOnm0vDSwxyLjmEeDFusUV1CeoEzncb9aXUVON3TK4+
 Ws/ekrPMkrMqUJCdDucR73Dg3ZiNmx9N1hiByCNJo46HbSsVwui/nFqb59vpjeknOx9TrumIj+A
 RHYDXDa7c8Vs61PZUWNd/ppkBL4JHj7GqFcOzJYojb9zR9/KwtlE
X-Google-Smtp-Source: AGHT+IHOKrFYVOYgJZikWLNSI/BLdpKBwHsCOtBE4FWqoT84jS+dPLR1DUFIKfHj07TpvEJxS4jtuQ==
X-Received: by 2002:a05:6808:144e:b0:3eb:428b:fa5a with SMTP id
 5614622812f47-3f323baf4f2mr14473971b6e.37.1738604683387; 
 Mon, 03 Feb 2025 09:44:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:44:42 -0800 (PST)
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
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 32/32] efi: arm: Add an EFI app for arm64
Date: Mon,  3 Feb 2025 10:42:25 -0700
Message-ID: <20250203174245.1331464-33-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

 Kconfig                               |  1 +
 MAINTAINERS                           |  4 ++-
 arch/arm/dts/efi-arm_app.dts          | 31 ++++++++++++++++
 board/efi/Kconfig                     | 22 ++++++++++++
 board/efi/efi-arm_app/Kconfig         | 16 +++++++++
 board/efi/efi-arm_app/MAINTAINERS     | 13 +++++++
 board/efi/efi-arm_app/Makefile        |  5 +++
 board/efi/efi-arm_app/board.c         | 18 ++++++++++
 board/efi/efi-arm_app/efi-arm_app.env | 11 ++++++
 configs/efi-arm_app64_defconfig       | 51 +++++++++++++++++++++++++++
 doc/develop/uefi/u-boot_on_efi.rst    | 17 ++++-----
 lib/efi/Kconfig                       |  2 +-
 12 files changed, 181 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/dts/efi-arm_app.dts
 create mode 100644 board/efi/efi-arm_app/Kconfig
 create mode 100644 board/efi/efi-arm_app/MAINTAINERS
 create mode 100644 board/efi/efi-arm_app/Makefile
 create mode 100644 board/efi/efi-arm_app/board.c
 create mode 100644 board/efi/efi-arm_app/efi-arm_app.env
 create mode 100644 configs/efi-arm_app64_defconfig

diff --git a/Kconfig b/Kconfig
index 2e63896c477..e3c1b97c134 100644
--- a/Kconfig
+++ b/Kconfig
@@ -551,6 +551,7 @@ config SYS_LOAD_ADDR
 	default 0x12000000 if ARCH_MX6 && !(MX6SL || MX6SLL  || MX6SX || MX6UL || MX6ULL)
 	default 0x80800000 if ARCH_MX7
 	default 0x90000000 if FSL_LSCH2 || FSL_LSCH3
+	default 0x02000000 if VENDOR_EFI
 	default 0x0 if ARCH_SC5XX
 	help
 	  Address in memory to use as the default safe load address.
diff --git a/MAINTAINERS b/MAINTAINERS
index a8e81577090..04a1f50619f 100644
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
index 33bc364861a..75d272d2418 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -45,4 +45,26 @@ source "board/efi/efi-x86_payload/Kconfig"
 
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
 endif  # VENDOR_EFI
diff --git a/board/efi/efi-arm_app/Kconfig b/board/efi/efi-arm_app/Kconfig
new file mode 100644
index 00000000000..dc0b7df7829
--- /dev/null
+++ b/board/efi/efi-arm_app/Kconfig
@@ -0,0 +1,16 @@
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
index 00000000000..7b81d413086
--- /dev/null
+++ b/configs/efi-arm_app64_defconfig
@@ -0,0 +1,51 @@
+CONFIG_ARM=y
+# CONFIG_ARM64_CRC32 is not set
+CONFIG_VENDOR_EFI_ARM=y
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

