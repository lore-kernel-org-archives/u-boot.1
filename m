Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395CBC0018C
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9C7871A4;
	Wed,  8 Nov 2023 16:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="UJ05r0P5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AED4874C9; Wed,  8 Nov 2023 15:53:29 +0100 (CET)
Received: from mta-65-227.siemens.flowmailer.net
 (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75144871C1
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id
 202311081453256c4cc36d4548f0f417 for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RSpnWHA1kuDm5fXfwh5pzwdfonbOnRww4zmgyzuPvn0=;
 b=UJ05r0P5D4Ax09tW0c6G0+pCmoXYsELP91kG7qoWvNAQmQROQ4WMoxWQcp5/Qo3o1ymWTG
 HO5Rahcur7Z8xy5kgRVDFfYRiNmhmKufrKmbqJYONsYoJzFDxuSb+xv43QlrvtFw1/A4WPlQ
 S4uAQxanb0Y6TBJjd35vO+UjReG+E=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 1/6] siemens,am335x: clean-up draco targets
Date: Wed,  8 Nov 2023 15:53:17 +0100
Message-Id: <20231108145322.302927-2-enrico.leto@siemens.com>
In-Reply-To: <20231108145322.302927-1-enrico.leto@siemens.com>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 08 Nov 2023 16:10:16 +0100
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

Draco is a family of 3 boards: thuban, rastaban & etamin. Rename all
targets of the family adding the draco- prefix to increase readibility
and simplify future commits about concerning all boards of the family.

The name draco was initially used for the first target. It's deprecated
since a 2nd target was introduced. Unfortunately the draco target was
copied to the thuban target instead to be renamed. Remove it to save
unnecessary maintenance effort.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 arch/arm/mach-omap2/am33xx/Kconfig            |   9 --
 board/siemens/draco/Kconfig                   |  22 +--
 board/siemens/draco/MAINTAINERS               |  15 +--
 ...tamin_defconfig => draco-etamin_defconfig} |   0
 ...ban_defconfig => draco-rastaban_defconfig} |   0
 ...huban_defconfig => draco-thuban_defconfig} |   0
 configs/draco_defconfig                       | 127 ------------------
 include/configs/{etamin.h => draco-etamin.h}  |   0
 .../configs/{rastaban.h => draco-rastaban.h}  |   0
 include/configs/{thuban.h => draco-thuban.h}  |   0
 include/configs/draco.h                       |  41 ------
 11 files changed, 10 insertions(+), 204 deletions(-)
 rename configs/{etamin_defconfig => draco-etamin_defconfig} (100%)
 rename configs/{rastaban_defconfig => draco-rastaban_defconfig} (100%)
 rename configs/{thuban_defconfig => draco-thuban_defconfig} (100%)
 delete mode 100644 configs/draco_defconfig
 rename include/configs/{etamin.h => draco-etamin.h} (100%)
 rename include/configs/{rastaban.h => draco-rastaban.h} (100%)
 rename include/configs/{thuban.h => draco-thuban.h} (100%)
 delete mode 100644 include/configs/draco.h

diff --git a/arch/arm/mach-omap2/am33xx/Kconfig b/arch/arm/mach-omap2/am33xx/Kconfig
index 8cb0c57163b..bd5129b04e0 100644
--- a/arch/arm/mach-omap2/am33xx/Kconfig
+++ b/arch/arm/mach-omap2/am33xx/Kconfig
@@ -105,15 +105,6 @@ config TARGET_CHILIBOARD
 	select DM_SERIAL
 	imply CMD_DM
 
-config TARGET_DRACO
-	bool "Support draco"
-	select BOARD_LATE_INIT
-	select DM
-	select DM_GPIO
-	select DM_SERIAL
-	select FACTORYSET
-	imply CMD_DM
-
 config TARGET_ETAMIN
 	bool "Support etamin"
 	select BOARD_LATE_INIT
diff --git a/board/siemens/draco/Kconfig b/board/siemens/draco/Kconfig
index 1eb8a4886f4..0cdf5bc9812 100644
--- a/board/siemens/draco/Kconfig
+++ b/board/siemens/draco/Kconfig
@@ -1,19 +1,3 @@
-if TARGET_DRACO
-
-config SYS_BOARD
-	default "draco"
-
-config SYS_VENDOR
-	default "siemens"
-
-config SYS_SOC
-	default "am33xx"
-
-config SYS_CONFIG_NAME
-	default "draco"
-
-endif
-
 if TARGET_THUBAN
 
 config SYS_BOARD
@@ -26,7 +10,7 @@ config SYS_SOC
 	default "am33xx"
 
 config SYS_CONFIG_NAME
-	default "thuban"
+	default "draco-thuban"
 
 endif
 
@@ -42,7 +26,7 @@ config SYS_SOC
 	default "am33xx"
 
 config SYS_CONFIG_NAME
-	default "rastaban"
+	default "draco-rastaban"
 
 endif
 
@@ -58,7 +42,7 @@ config SYS_SOC
         default "am33xx"
 
 config SYS_CONFIG_NAME
-        default "etamin"
+        default "draco-etamin"
 
 config NAND_CS_INIT
 	def_bool y
diff --git a/board/siemens/draco/MAINTAINERS b/board/siemens/draco/MAINTAINERS
index c73f18c002f..82e01eb62ed 100644
--- a/board/siemens/draco/MAINTAINERS
+++ b/board/siemens/draco/MAINTAINERS
@@ -1,11 +1,10 @@
 DRACO BOARD
-M:	Samuel Egli <samuel.egli@siemens.com>
+M:	Enrico Leto <enrico.leto@siemens.com>
 S:	Maintained
 F:	board/siemens/draco/
-F:	include/configs/draco.h
-F:	configs/draco_defconfig
-F:	configs/etamin_defconfig
-F:	include/configs/thuban.h
-F:	configs/thuban_defconfig
-F:	include/configs/rastaban.h
-F:	configs/rastaban_defconfig
+F:	configs/draco-etamin_defconfig
+F:	configs/draco-rastaban_defconfig
+F:	configs/draco-thuban_defconfig
+F:	include/configs/draco-etamin.h
+F:	include/configs/draco-rastaban.h
+F:	include/configs/draco-thuban.h
diff --git a/configs/etamin_defconfig b/configs/draco-etamin_defconfig
similarity index 100%
rename from configs/etamin_defconfig
rename to configs/draco-etamin_defconfig
diff --git a/configs/rastaban_defconfig b/configs/draco-rastaban_defconfig
similarity index 100%
rename from configs/rastaban_defconfig
rename to configs/draco-rastaban_defconfig
diff --git a/configs/thuban_defconfig b/configs/draco-thuban_defconfig
similarity index 100%
rename from configs/thuban_defconfig
rename to configs/draco-thuban_defconfig
diff --git a/configs/draco_defconfig b/configs/draco_defconfig
deleted file mode 100644
index ee19920a703..00000000000
--- a/configs/draco_defconfig
+++ /dev/null
@@ -1,127 +0,0 @@
-CONFIG_ARM=y
-CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_TEXT_BASE=0x80100000
-CONFIG_SYS_MALLOC_LEN=0x1000000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4030ff00
-CONFIG_ENV_SIZE=0x2000
-CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
-CONFIG_AM33XX=y
-CONFIG_SYS_MPUCLK=300
-CONFIG_TARGET_DRACO=y
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_BOOTCOUNT_BOOTLIMIT=3
-CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x2E0000
-CONFIG_SPL_FS_FAT=y
-CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_SYS_LOAD_ADDR=0x81000000
-CONFIG_ENV_VARS_UBOOT_CONFIG=y
-CONFIG_BOOTDELAY=3
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Autobooting in %d seconds, press \"<Esc><Esc>\" to stop\n"
-CONFIG_AUTOBOOT_STOP_STR="\x1b\x1b"
-CONFIG_BOOT_RETRY=y
-CONFIG_BOOT_RETRY_TIME=60
-CONFIG_RESET_TO_RETRY=y
-CONFIG_USE_PREBOOT=y
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
-# CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_ARCH_MISC_INIT=y
-CONFIG_SPL_BSS_START_ADDR=0x80000000
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
-CONFIG_SPL_I2C=y
-CONFIG_SPL_NAND_DRIVERS=y
-CONFIG_SPL_NAND_ECC=y
-CONFIG_SPL_NAND_BASE=y
-CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
-CONFIG_SPL_WATCHDOG=y
-CONFIG_SPL_YMODEM_SUPPORT=y
-# CONFIG_SPL_AM33XX_ENABLE_RTC32K_OSC is not set
-CONFIG_HUSH_PARSER=y
-CONFIG_SYS_PROMPT="U-Boot# "
-CONFIG_SYS_MAXARGS=32
-CONFIG_SYS_PBSIZE=1049
-CONFIG_CMD_ASKENV=y
-CONFIG_CMD_DFU=y
-# CONFIG_CMD_FLASH is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_NAND=y
-CONFIG_CMD_USB=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_DHCP=y
-CONFIG_BOOTP_DNS2=y
-CONFIG_CMD_MII=y
-CONFIG_CMD_PING=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT2=y
-CONFIG_CMD_MTDPARTS=y
-CONFIG_MTDIDS_DEFAULT="nand0=omap2-nand.0"
-CONFIG_MTDPARTS_DEFAULT="mtdparts=omap2-nand.0:128k(spl),128k(spl.backup1),128k(spl.backup2),128k(spl.backup3),1920k(u-boot),512k(u-boot.env0),512k(u-boot.env1),512k(mtdoops),-(rootfs)"
-CONFIG_CMD_UBI=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_EMBED=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_NAND=y
-CONFIG_ENV_RANGE=0x80000
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RETRY_COUNT=10
-CONFIG_BOOTP_SEND_HOSTNAME=y
-CONFIG_USE_ROOTPATH=y
-CONFIG_ROOTPATH="/opt/eldk"
-CONFIG_SPL_DM=y
-# CONFIG_SPL_BLK is not set
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_BOOTCOUNT_ENV=y
-CONFIG_DFU_NAND=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
-CONFIG_SYS_I2C_LEGACY=y
-CONFIG_SPL_SYS_I2C_LEGACY=y
-# CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_OMAP_HS=y
-CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
-CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_SYS_NAND_PAGE_COUNT=0x40
-CONFIG_SYS_NAND_PAGE_SIZE=0x800
-CONFIG_SYS_NAND_OOBSIZE=0x40
-CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
-CONFIG_SYS_NAND_U_BOOT_OFFS=0x80000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_MTD_UBI_FASTMAP=y
-CONFIG_MTD_UBI_FASTMAP_AUTOCONVERT=1
-CONFIG_PHY_SMSC=y
-CONFIG_DRIVER_TI_CPSW=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
-CONFIG_USB=y
-# CONFIG_SPL_DM_USB is not set
-CONFIG_USB_MUSB_HOST=y
-CONFIG_USB_MUSB_GADGET=y
-CONFIG_USB_MUSB_DSPS=y
-CONFIG_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Siemens AG"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0908
-CONFIG_USB_GADGET_PRODUCT_NUM=0x02d2
-CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_USB_ETHER=y
diff --git a/include/configs/etamin.h b/include/configs/draco-etamin.h
similarity index 100%
rename from include/configs/etamin.h
rename to include/configs/draco-etamin.h
diff --git a/include/configs/rastaban.h b/include/configs/draco-rastaban.h
similarity index 100%
rename from include/configs/rastaban.h
rename to include/configs/draco-rastaban.h
diff --git a/include/configs/thuban.h b/include/configs/draco-thuban.h
similarity index 100%
rename from include/configs/thuban.h
rename to include/configs/draco-thuban.h
diff --git a/include/configs/draco.h b/include/configs/draco.h
deleted file mode 100644
index 4c67174572f..00000000000
--- a/include/configs/draco.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * (C) Copyright 2013 Siemens Schweiz AG
- * (C) Heiko Schocher, DENX Software Engineering, hs@denx.de.
- *
- * Based on:
- * U-Boot file:/include/configs/am335x_evm.h
- *
- * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
- */
-
-#ifndef __CONFIG_DRACO_H
-#define __CONFIG_DRACO_H
-
-#include "siemens-am33x-common.h"
-
-#define DDR_PLL_FREQ	303
-
-#define BOARD_DFU_BUTTON_GPIO	27	/* Use as default */
-#define GPIO_LAN9303_NRST	88	/* GPIO2_24 = gpio88 */
-
-#define CFG_ENV_SETTINGS_BUTTONS_AND_LEDS \
-	"button_dfu0=27\0" \
-	"led0=103,1,0\0" \
-	"led1=64,0,1\0"
-
- /* Physical Memory Map */
-#define CFG_MAX_RAM_BANK_SIZE	(1024 << 20)	/* 1GB */
-
-/* Default env settings */
-#define CFG_EXTRA_ENV_SETTINGS \
-	"hostname=draco\0" \
-	"ubi_off=2048\0"\
-	"nand_img_size=0x400000\0" \
-	"optargs=\0" \
-	"preboot=draco_led 0\0" \
-	CFG_ENV_SETTINGS_BUTTONS_AND_LEDS \
-	CFG_ENV_SETTINGS_V2 \
-	CFG_ENV_SETTINGS_NAND_V2
-
-#endif	/* ! __CONFIG_DRACO_H */
-- 
2.30.2

