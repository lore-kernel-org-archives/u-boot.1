Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAEAC48BF6
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 21:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1617A87ED0;
	Sun, 18 Feb 2024 22:20:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UVYFzhYc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA038765B; Sun, 18 Feb 2024 22:20:11 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2D687ED2
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 22:20:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78725b62cf2so175425185a.1
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 13:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708291201; x=1708896001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+MUfwf/T7KAwYR5+vGylSG9PzbkIrNLzOz8xLU5+kI=;
 b=UVYFzhYcaqV6SReHYOSU5fj5seIsDewnnnpdgVJQsrIX4M+VH2S0nToyyO+9hRHrBr
 Gsc8Dr91LytzagNPvt/n7W9Xrwda08pnB+/VT3WJaiBC/ff4ZhgG76DLi58A2/lGid3o
 gesGHZgM6nznfK8CXY6hUWfGF8SJKZzOsDijL6kD/cyl6UAMuil3ctvzgnkMhS864kXn
 sUsh6shqkluA2u8i4nNMQkr496uerjz8/n9SjlfTY5KPrA3Y2dDO5OoeFxNBlsbevvR0
 97D08csGBLPiHfgXrYjKDZIda634kDCPKrsJsr/Ml5R5gO0pj3T2YH0p6iNoMyDxXHwG
 ylAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708291201; x=1708896001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0+MUfwf/T7KAwYR5+vGylSG9PzbkIrNLzOz8xLU5+kI=;
 b=wesTxXJpXwtGTYu3pq8sI25foA8p8WXhsURGNiBChjzDvp/zFc3546Ckzhdsh5Yo3w
 kKg97lTNWRdLJhwkvbL6lZ2/1rkT22+PmdI/4SaIlQ5rhrc0KMVU+nqvInmPfXPqJVGF
 VHBPw1teh1GjtmRl0H+Y1tVjk07R1Raj+EmaW6RFXPz1cHx1KkIYf8zNxUgxSnfrHY3B
 TF/LOdUTzHSx4agQZUEx024wipfag1KNWEEv25fyFIic9GwUAyae5wf6/V7/HvZl/pda
 P00P4bF1IsUOP5jdg42DNZd4g9c6h9Y73C358XF+jCC0MBPS7v9dVAQVPsdLd/pz0acG
 ya4Q==
X-Gm-Message-State: AOJu0Yzeh3q9dpEmjE8UIOkzWQ/zxLCWmtAiJB03r4S/cFaOE41Dqz0i
 UKNXojBFmRk6DUL0sdXmNt1g104ZlAiHguf99Dc9pFVVeNi8/60j+pD+omJSREg=
X-Google-Smtp-Source: AGHT+IE48ygP+mtbAq8GjANx52DbTB+94ycUz5yR9cCRkKdbmdgm50g7wH/5+ViOFOVh/wHWXXOHBw==
X-Received: by 2002:a05:620a:2112:b0:787:24e5:ead5 with SMTP id
 l18-20020a05620a211200b0078724e5ead5mr8623851qkl.33.1708291201054; 
 Sun, 18 Feb 2024 13:20:01 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab
 (pool-108-26-179-17.bstnma.fios.verizon.net. [108.26.179.17])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05620a110f00b00785b02c5784sm1863219qkk.86.2024.02.18.13.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 13:20:00 -0800 (PST)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Jesse Taube <Mr.Bossman075@gmail.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/3] imx: imxrt1050-evk: Add support for SPI flash booting
Date: Sun, 18 Feb 2024 16:19:57 -0500
Message-ID: <20240218211958.2849847-2-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
References: <20240218211958.2849847-1-Mr.Bossman075@gmail.com>
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
V2 -> V3:
 - Move enabling of binman to another commit
---
 arch/arm/dts/imxrt1050-evk-u-boot.dtsi        |  27 +++++
 board/freescale/imxrt1050-evk/MAINTAINERS     |   1 +
 .../freescale/imxrt1050-evk/imximage-nor.cfg  |  42 ++++++++
 board/freescale/imxrt1050-evk/imximage.cfg    |  10 +-
 board/freescale/imxrt1050-evk/imxrt1050-evk.c |   7 +-
 configs/imxrt1050-evk_defconfig               |   8 +-
 configs/imxrt1050-evk_fspi_defconfig          | 100 ++++++++++++++++++
 include/configs/imxrt1050-evk.h               |   6 ++
 8 files changed, 195 insertions(+), 6 deletions(-)
 create mode 100644 board/freescale/imxrt1050-evk/imximage-nor.cfg
 create mode 100644 configs/imxrt1050-evk_fspi_defconfig

diff --git a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
index 8a9f6119b1..3f54411b7b 100644
--- a/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
+++ b/arch/arm/dts/imxrt1050-evk-u-boot.dtsi
@@ -117,6 +117,33 @@
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

