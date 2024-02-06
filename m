Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A096EC48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 16:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACE9687CBA;
	Tue,  6 Feb 2024 17:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OPgIYR0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FC78646E; Tue,  6 Feb 2024 17:40:15 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0771787CAA
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 17:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6040d33380cso59828837b3.1
 for <u-boot@lists.denx.de>; Tue, 06 Feb 2024 08:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707237610; x=1707842410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QQsFydkRVEb1AGzJWEAAlFNqPGVYnChwfLk2c3hebW0=;
 b=OPgIYR0l0l6NNO0Zi7G/TMixB6i8PD5UEvapCranl990LmnPdcvJbGL9lIc+gBCj0j
 LCdtI7xHnAF8VCoY3W56VfPrjvy7vjjx+KTm9uMZOcT3Xsn9Ck2fxJtyGHyBLIGpsmMi
 jA9oNK5vnLWLbfhrBsHdAMdr5tleokSquaXfRtQYwkSTB1MDxddgPvpmIiC1SBy7ne3u
 6IeY8tGr7Q/TEur+NonKI5URXJpF3dkIV7r875/63TI6l5W+aU/LsrWAvZvgxSfmVdnH
 A2h1GECtaKi/hn5DUStsJpzfuK7P+1kcbHVApOnjZmzrT52roQJ9bXgYcjwbJIVS8FCq
 6nLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707237610; x=1707842410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQsFydkRVEb1AGzJWEAAlFNqPGVYnChwfLk2c3hebW0=;
 b=WkjXcUlJoUyj0IBvbo3towSd79Yi2XfIHR/4yNOVUpCabdohZzOLbw5s2MvZX3VoJl
 kY7ZmyLZw7c9cRsYfC7CwT8+T57zTddDx4O+NTtcvX9faiVVNggrM0ocHFjhNiOTvFoH
 sNfet6q7nZmlGcabivK50RVYKnMC1ibft9UWz7Ia6tBgbEurPGN0N9+mmZmq1yz+k0G1
 7IVBGFPTD64V54W6P2//qfL0w2mv50o2vcIa80KubaU3OgHFpYh+dMKQ0hCtKavdERdt
 BSs8HwGIhRE2xm7guTjM5bOHKGjXEY81AzLqZhQh/dhn+AfhTNxUGqhPT6NtuTsY3hza
 OSmw==
X-Gm-Message-State: AOJu0YwcSwRv+HnF+ANiHNVVWKc+7MLPhNUv9TnQnIP2vvVelSywrKY2
 qreDxTcDMsrAA2IIv2Fp0Qt42t33Yw0AiCKxNoE/u+Vah5jkQ0Gx7UiSqCs50ME=
X-Google-Smtp-Source: AGHT+IFz8tuWqmBvHkwFHl6TUgZqdzyBrknnhhU3DjWn2e4BJkFLv3aCWcbJ4uIdgRXRK1VARAzkeA==
X-Received: by 2002:a81:6d57:0:b0:5ef:7f8d:bfcb with SMTP id
 i84-20020a816d57000000b005ef7f8dbfcbmr2517097ywc.19.1707237610030; 
 Tue, 06 Feb 2024 08:40:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWjWQzTUlZGCJZWiWlqR+bcogEuP65dr50SUoc4N7pSTSyd5s9TqQ8Fo1pjAaTxr6O/1LWW0CJQPekbEM6i9ErSUDojyhL010rOB9Y57l1P8LSZ1tOi+t2Gv3edNgRYZPhMTC9VgPGrT/82NWN+bmqBEeK/kesZSmxf/NQAMDF+8zwL4X9CxqV4yM4nwEACDdkmJ/lSSvSqR5H9xfetNoc3S0V5xgiihZiaCrxD/+IpBsEX
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 mv7-20020a056214338700b0068cb07d2a80sm918147qvb.37.2024.02.06.08.40.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 08:40:09 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/2] imx: imxrt1050-evk: Add support for SPI flash booting
Date: Tue,  6 Feb 2024 11:40:07 -0500
Message-ID: <20240206164008.1620933-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add support for booting the imxrt1050-evk from spi.
Add imximage config and the ability for SPL to boot from NOR.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Add defconfig to MAINTAINERS
 - Change Copyright of imximage-nor.cfg to myself
 - Fix spelling and grammar
 - Use imperative mood
---
 arch/arm/dts/imxrt1050-evk-u-boot.dtsi        |  31 ++++++
 arch/arm/mach-imx/imxrt/Kconfig               |   1 +
 board/freescale/imxrt1050-evk/MAINTAINERS     |   1 +
 .../freescale/imxrt1050-evk/imximage-nor.cfg  |  42 ++++++++
 board/freescale/imxrt1050-evk/imximage.cfg    |  10 +-
 board/freescale/imxrt1050-evk/imxrt1050-evk.c |   7 +-
 configs/imxrt1050-evk_defconfig               |   8 +-
 configs/imxrt1050-evk_fspi_defconfig          | 100 ++++++++++++++++++
 include/configs/imxrt1050-evk.h               |   6 ++
 9 files changed, 200 insertions(+), 6 deletions(-)
 create mode 100644 board/freescale/imxrt1050-evk/imximage-nor.cfg
 create mode 100644 configs/imxrt1050-evk_fspi_defconfig

diff --git a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
index a9095e736b..3f54411b7b 100644
--- a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
+++ b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
@@ -8,6 +8,10 @@
 #include "imxrt1050-pinfunc.h"
 
 / {
+	binman: binman {
+		multiple-images;
+	};
+
 	aliases {
 		display0 = &lcdif;
 		usbphy0 = &usbphy1;
@@ -113,6 +117,33 @@
 	};
 };
 
+&binman {
+#ifdef CONFIG_FSPI_CONF_HEADER
+	imx-boot {
+		filename = "flash.bin";
+		pad-byte = <0x00>;
+
+		fspi_conf_block {
+			filename = CONFIG_FSPI_CONF_FILE;
+			type = "blob-ext";
+			offset = <0x0>;
+		};
+
+		spl {
+			filename = "SPL";
+			offset = <0x1000>;
+			type = "blob-ext";
+		};
+
+		binman_uboot: uboot {
+			filename = "u-boot.img";
+			offset = <0x10000>;
+			type = "blob-ext";
+		};
+	};
+#endif
+};
+
 &osc {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/mach-imx/imxrt/Kconfig b/arch/arm/mach-imx/imxrt/Kconfig
index c1d6b09e77..ccccf702f6 100644
--- a/arch/arm/mach-imx/imxrt/Kconfig
+++ b/arch/arm/mach-imx/imxrt/Kconfig
@@ -2,6 +2,7 @@ if ARCH_IMXRT
 
 config IMXRT
 	bool
+	select BINMAN
 	select SYS_FSL_ERRATUM_ESDHC135
 
 config IMXRT1020
diff --git a/board/freescale/imxrt1050-evk/MAINTAINERS b/board/freescale/imxrt1050-evk/MAINTAINERS
index a872855452..890825b39a 100644
--- a/board/freescale/imxrt1050-evk/MAINTAINERS
+++ b/board/freescale/imxrt1050-evk/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/freescale/imxrt1050-evk
 F:	include/configs/imxrt1050-evk.h
 F:	configs/imxrt1050-evk_defconfig
+F:	configs/imxrt1050-evk_fspi_defconfig
diff --git a/board/freescale/imxrt1050-evk/imximage-nor.cfg b/board/freescale/imxrt1050-evk/imximage-nor.cfg
new file mode 100644
index 0000000000..3b80e1f178
--- /dev/null
+++ b/board/freescale/imxrt1050-evk/imximage-nor.cfg
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024
+ * Author(s): Jesse Taube <Mr.Bossman075@gmail.com>
+ */
+
+#include <config.h>
+
+/* image version */
+
+IMAGE_VERSION 2
+
+/*
+ * Boot Device : one of
+ * spi/sd/nand/onenand, qspi/nor
+ */
+
+BOOT_FROM	nor
+
+/*
+ * Device Configuration Data (DCD)
+ *
+ * Each entry must have the format:
+ * Addr-type           Address        Value
+ *
+ * where:
+ *	Addr-type register length (1,2 or 4 bytes)
+ *	Address	  absolute address of the register
+ *	value	  value to be stored in the register
+ */
+
+/*
+ * 0x400AC044 is used to configure the flexram.
+ * Unfortunately setting all to OCRAM only works for MMC
+ * and setting all to DTCM only works for FLEXSPI NOR.
+ * This configuration fortunately works for both SPI and MMC.
+*/
+/* Set first two banks FlexRAM as OCRAM(01b) and the rest to DTCM(10b) */
+DATA 4 0x400AC044 0x55aaaaaa
+/* Use FLEXRAM_BANK_CFG to config FlexRAM */
+SET_BIT 4 0x400AC040 0x4
+
diff --git a/board/freescale/imxrt1050-evk/imximage.cfg b/board/freescale/imxrt1050-evk/imximage.cfg
index f1f09fd7eb..b30d852194 100644
--- a/board/freescale/imxrt1050-evk/imximage.cfg
+++ b/board/freescale/imxrt1050-evk/imximage.cfg
@@ -29,7 +29,13 @@ BOOT_FROM	sd
  *	value	  value to be stored in the register
  */
 
-/* Set all FlexRAM as OCRAM(01b) */
-DATA 4 0x400AC044 0x55555555
+/*
+ * 0x400AC044 is used to configure the flexram.
+ * Unfortunately setting all to OCRAM only works for MMC
+ * and setting all to DTCM only works for FLEXSPI NOR.
+ * This configuration fortunately works for both SPI and MMC.
+*/
+/* Set first two banks FlexRAM as OCRAM(01b) and the rest to DTCM(10b) */
+DATA 4 0x400AC044 0x55aaaaaa
 /* Use FLEXRAM_BANK_CFG to config FlexRAM */
 SET_BIT 4 0x400AC040 0x4
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.c b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
index 4b82ee5e9c..4cc3defc88 100644
--- a/board/freescale/imxrt1050-evk/imxrt1050-evk.c
+++ b/board/freescale/imxrt1050-evk/imxrt1050-evk.c
@@ -68,7 +68,12 @@ void spl_board_init(void)
 
 u32 spl_boot_device(void)
 {
-	return BOOT_DEVICE_MMC1;
+	/* There is no way to find the boot device so look if there is a valid IVT in RAM for MMC */
+	u32 nor_ivt = *(u32 *)(CONFIG_SYS_LOAD_ADDR - 0xC00);
+
+	if (nor_ivt == 0x402000d1)
+		return BOOT_DEVICE_MMC1;
+	return BOOT_DEVICE_NOR;
 }
 #endif
 
diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index 8b5ce4e735..086fc47ec2 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -10,21 +10,22 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20280000
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20020000
 CONFIG_ENV_OFFSET=0x80000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imxrt1050-evk"
-CONFIG_SPL_TEXT_BASE=0x20209000
+CONFIG_SPL_TEXT_BASE=0x20002000
 CONFIG_TARGET_IMXRT1050_EVK=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
-CONFIG_SYS_LOAD_ADDR=0x20209000
+CONFIG_SYS_LOAD_ADDR=0x20002000
 CONFIG_HAVE_SYS_UBOOT_START=y
 CONFIG_SYS_UBOOT_START=0x800023FD
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
+CONFIG_SPI_BOOT=y
 # CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
@@ -36,6 +37,7 @@ CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+CONFIG_SPL_NOR_SUPPORT=y
 # CONFIG_BOOTM_NETBSD is not set
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
new file mode 100644
index 0000000000..4b252cfa5d
--- /dev/null
+++ b/configs/imxrt1050-evk_fspi_defconfig
@@ -0,0 +1,100 @@
+CONFIG_ARM=y
+CONFIG_SYS_DCACHE_OFF=y
+# CONFIG_SPL_SYS_DCACHE_OFF is not set
+CONFIG_ARCH_IMXRT=y
+CONFIG_TEXT_BASE=0x80002000
+CONFIG_SYS_MALLOC_LEN=0x40000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20020000
+CONFIG_ENV_OFFSET=0x80000
+CONFIG_IMX_CONFIG="board/freescale/imxrt1050-evk/imximage-nor.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="imxrt1050-evk"
+CONFIG_SPL_TEXT_BASE=0x20002000
+CONFIG_TARGET_IMXRT1050_EVK=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SIZE_LIMIT=0x20000
+CONFIG_SPL=y
+CONFIG_SYS_LOAD_ADDR=0x20002000
+CONFIG_HAVE_SYS_UBOOT_START=y
+CONFIG_SYS_UBOOT_START=0x800023FD
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_SD_BOOT=y
+CONFIG_SPI_BOOT=y
+# CONFIG_USE_BOOTCOMMAND is not set
+CONFIG_SYS_CBSIZE=256
+CONFIG_SYS_PBSIZE=276
+CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_NO_BSS_LIMIT=y
+CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x100
+CONFIG_SPL_NOR_SUPPORT=y
+# CONFIG_BOOTM_NETBSD is not set
+# CONFIG_BOOTM_PLAN9 is not set
+# CONFIG_BOOTM_RTEMS is not set
+# CONFIG_BOOTM_VXWORKS is not set
+CONFIG_CMD_USB=y
+# CONFIG_CMD_MII is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_ISO_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_TFTP_BLOCKSIZE=512
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+# CONFIG_OF_TRANSLATE is not set
+CONFIG_SPL_CLK_IMXRT1050=y
+CONFIG_CLK_IMXRT1050=y
+# CONFIG_SPL_DM_GPIO is not set
+CONFIG_MXC_GPIO=y
+# CONFIG_INPUT is not set
+CONFIG_FSL_USDHC=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMXRT=y
+CONFIG_RAM=y
+CONFIG_SPL_RAM=y
+CONFIG_IMXRT_SDRAM=y
+CONFIG_FSL_LPUART=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_IMX_GPT_TIMER=y
+CONFIG_USB=y
+# CONFIG_SPL_DM_USB is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_VIDEO=y
+CONFIG_VIDEO_LOGO=y
+CONFIG_BACKLIGHT_GPIO=y
+CONFIG_SYS_WHITE_ON_BLACK=y
+CONFIG_VIDEO_MXS=y
+CONFIG_SPLASH_SCREEN=y
+CONFIG_SPLASH_SCREEN_ALIGN=y
+CONFIG_BMP_16BPP=y
+CONFIG_SHA1=y
+CONFIG_SHA256=y
+CONFIG_HEXDUMP=y
+CONFIG_FSPI_CONF_HEADER=y
+CONFIG_FSPI_CONF_FILE="fspi_header.bin"
+CONFIG_READ_CLK_SOURCE=0x03
+CONFIG_DEVICE_TYPE=0x00
+CONFIG_FLASH_PAD_TYPE=0x08
+CONFIG_SERIAL_CLK_FREQUENCY=0x07
+CONFIG_FSPI_COL_ADDR_W=0x03
+CONFIG_FSPI_CONTROLLER_MISC=0x00000059
+CONFIG_FSPI_FLASH_A1_SIZE=0x04000000
+CONFIG_LUT_SEQUENCE="0xa0, 0x87, 0x18, 0x8b, 0x10, 0x8f, 0x06, 0xb3, 0x04, 0xa7"
diff --git a/include/configs/imxrt1050-evk.h b/include/configs/imxrt1050-evk.h
index 2af2dde2ae..b370e25105 100644
--- a/include/configs/imxrt1050-evk.h
+++ b/include/configs/imxrt1050-evk.h
@@ -25,4 +25,10 @@
 		"stderr=serial,vidconsole\0"
 #endif
 
+/*
+ * Address of U-Boot for SPI NOR boot
+ */
+
+#define CFG_SYS_UBOOT_BASE			0x60010000
+
 #endif /* __IMXRT1050_EVK_H */
-- 
2.43.0

