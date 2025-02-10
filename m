Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DF9C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA5680EAF;
	Mon, 10 Feb 2025 21:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jjw81XV1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E017805E7; Mon, 10 Feb 2025 21:29:54 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EE3980821
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:29:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51AKTjIc3564068
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 10 Feb 2025 14:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739219385;
 bh=d4CZW12XTS5MbCfgeXQbOTMkEGyf4GM2Tb7X+Z8gcH4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jjw81XV1P52crUsgSIlFLcgwdkZz+hW5USIYJFRu+Oc2fVPXxpjGpm1t8OZrHF/XT
 D2Zx+AJDNY3SIDiDQ58WNXM3ZQTqn9PeHViQ0YUIussVFaz6gblBMVnQGCdG/52+ic
 urUn2HDPfB8lqKTuojNl60xl4PiCerEQRxUgaTKQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTjsQ062588;
 Mon, 10 Feb 2025 14:29:45 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Feb 2025 14:29:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Feb 2025 14:29:44 -0600
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51AKTiDK022402;
 Mon, 10 Feb 2025 14:29:45 -0600
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, Judith
 Mendez <jm@ti.com>, Udit Kumar <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 10/10] configs: am6*/j7*: Remove remoteproc configs
Date: Mon, 10 Feb 2025 14:29:44 -0600
Message-ID: <20250210202944.1071931-11-jm@ti.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250210202944.1071931-1-jm@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Now that remoteproc configs are enabled by default in Kconfig
files, remove these configs which are no longer needed to be
defined here in configs/.

Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v4:
- Add patch
---
 configs/am62ax_evm_a53_defconfig           | 4 ----
 configs/am62ax_evm_r5_defconfig            | 3 ---
 configs/am62px_evm_a53_defconfig           | 4 ----
 configs/am62px_evm_r5_defconfig            | 3 ---
 configs/am62x_beagleplay_a53_defconfig     | 1 -
 configs/am62x_beagleplay_r5_defconfig      | 3 ---
 configs/am62x_evm_a53_defconfig            | 1 -
 configs/am62x_evm_r5_defconfig             | 3 ---
 configs/am64x_evm_a53_defconfig            | 3 ---
 configs/am64x_evm_r5_defconfig             | 3 ---
 configs/am65x_evm_a53_defconfig            | 3 ---
 configs/am65x_evm_r5_defconfig             | 3 ---
 configs/am65x_evm_r5_usbdfu_defconfig      | 3 ---
 configs/am65x_evm_r5_usbmsc_defconfig      | 3 ---
 configs/j7200_evm_a72_defconfig            | 2 --
 configs/j7200_evm_r5_defconfig             | 3 ---
 configs/j721e_beagleboneai64_a72_defconfig | 3 ---
 configs/j721e_beagleboneai64_r5_defconfig  | 3 ---
 configs/j721e_evm_a72_defconfig            | 3 ---
 configs/j721e_evm_r5_defconfig             | 3 ---
 configs/j721s2_evm_a72_defconfig           | 3 ---
 configs/j721s2_evm_r5_defconfig            | 3 ---
 configs/j722s_evm_a53_defconfig            | 4 ----
 configs/j722s_evm_r5_defconfig             | 3 ---
 configs/j784s4_evm_a72_defconfig           | 3 ---
 configs/j784s4_evm_r5_defconfig            | 2 --
 26 files changed, 75 deletions(-)

diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index ad448feafeb..85a254a1e82 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -42,7 +42,6 @@ CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
@@ -96,9 +95,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/am62ax_evm_r5_defconfig b/configs/am62ax_evm_r5_defconfig
index 274cd20e1c1..8fe43b84bb5 100644
--- a/configs/am62ax_evm_r5_defconfig
+++ b/configs/am62ax_evm_r5_defconfig
@@ -47,7 +47,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
@@ -55,7 +54,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -96,7 +94,6 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 9635beb1b27..6fdde00faf0 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -64,7 +64,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -147,9 +146,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/am62px_evm_r5_defconfig b/configs/am62px_evm_r5_defconfig
index 9df90e05d36..93cb9d05209 100644
--- a/configs/am62px_evm_r5_defconfig
+++ b/configs/am62px_evm_r5_defconfig
@@ -47,7 +47,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -59,7 +58,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -110,7 +108,6 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index af54f9670a7..f140db27d68 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -111,7 +111,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index d0c09b91b14..2061b1e3e13 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -51,14 +51,12 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -96,7 +94,6 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 54f4ddedcd7..ca9c881302a 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -121,7 +121,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/am62x_evm_r5_defconfig b/configs/am62x_evm_r5_defconfig
index fcc5eb02867..abc283ea842 100644
--- a/configs/am62x_evm_r5_defconfig
+++ b/configs/am62x_evm_r5_defconfig
@@ -54,7 +54,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -65,7 +64,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -111,7 +109,6 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index e6e3e018da6..4029cc56d36 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -149,9 +149,6 @@ CONFIG_PMIC_TPS65219=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
-CONFIG_REMOTEPROC_TI_PRU=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index e8ea4ee3ebd..59055bbad84 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -60,7 +60,6 @@ CONFIG_SPL_NET_VCI_STRING="AM64X U-Boot R5 SPL"
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -72,7 +71,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
@@ -139,7 +137,6 @@ CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index b6df8b428c6..0a3ad937656 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -67,7 +67,6 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_TIME=y
 CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0"
@@ -145,8 +144,6 @@ CONFIG_TI_SCI_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
-CONFIG_REMOTEPROC_TI_PRU=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/am65x_evm_r5_defconfig b/configs/am65x_evm_r5_defconfig
index 083522ce9b4..5eb6030bd5d 100644
--- a/configs/am65x_evm_r5_defconfig
+++ b/configs/am65x_evm_r5_defconfig
@@ -55,7 +55,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -67,7 +66,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -125,7 +123,6 @@ CONFIG_DM_REGULATOR_TPS62360=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index e60e0d6588d..1c28cc06cd8 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -49,7 +49,6 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_BOOTZ=y
@@ -57,7 +56,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -106,7 +104,6 @@ CONFIG_DM_REGULATOR_TPS62360=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYSRESET=y
diff --git a/configs/am65x_evm_r5_usbmsc_defconfig b/configs/am65x_evm_r5_usbmsc_defconfig
index ecd48c45ea1..3f3587b4328 100644
--- a/configs/am65x_evm_r5_usbmsc_defconfig
+++ b/configs/am65x_evm_r5_usbmsc_defconfig
@@ -49,14 +49,12 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -103,7 +101,6 @@ CONFIG_DM_REGULATOR_TPS62360=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SYSRESET=y
diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 6e6105fb216..77d9f71e139 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -68,7 +68,6 @@ CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -170,7 +169,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 02d446a2a6d..75620c73c35 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -57,7 +57,6 @@ CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -68,7 +67,6 @@ CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -141,7 +139,6 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
index a5d95975fb4..fad01c27104 100644
--- a/configs/j721e_beagleboneai64_a72_defconfig
+++ b/configs/j721e_beagleboneai64_a72_defconfig
@@ -67,7 +67,6 @@ CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
@@ -144,8 +143,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/j721e_beagleboneai64_r5_defconfig b/configs/j721e_beagleboneai64_r5_defconfig
index 77e44963fd4..086ad99ff6d 100644
--- a/configs/j721e_beagleboneai64_r5_defconfig
+++ b/configs/j721e_beagleboneai64_r5_defconfig
@@ -52,13 +52,11 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -111,7 +109,6 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index bb031db9e0f..97d07761f89 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -69,7 +69,6 @@ CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -172,8 +171,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 9d767d7cdad..db174483926 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -62,7 +62,6 @@ CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -73,7 +72,6 @@ CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -151,7 +149,6 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index a2c39ae0ab6..da33bce7e05 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -65,7 +65,6 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
@@ -163,8 +162,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SCSI=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index 23ae991e2f6..76e15fd1e7c 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -63,7 +63,6 @@ CONFIG_SPL_NOR_SUPPORT=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -75,7 +74,6 @@ CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -149,7 +147,6 @@ CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 81eb934ed6e..6aaf1dc9098 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -56,7 +56,6 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
@@ -132,9 +131,6 @@ CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
diff --git a/configs/j722s_evm_r5_defconfig b/configs/j722s_evm_r5_defconfig
index 0f7cd4bf37a..457ebb766a3 100644
--- a/configs/j722s_evm_r5_defconfig
+++ b/configs/j722s_evm_r5_defconfig
@@ -48,7 +48,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -60,7 +59,6 @@ CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_REMOTEPROC=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
@@ -113,7 +111,6 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 49775dc9a5b..f64a522fc2c 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -62,7 +62,6 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_OF_CONTROL=y
@@ -141,8 +140,6 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_RAM=y
 CONFIG_SPL_RAM=y
-CONFIG_REMOTEPROC_TI_K3_DSP=y
-CONFIG_REMOTEPROC_TI_K3_R5F=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_EMULATION=y
diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
index 61a44bf079e..d7c10c4c789 100644
--- a/configs/j784s4_evm_r5_defconfig
+++ b/configs/j784s4_evm_r5_defconfig
@@ -55,7 +55,6 @@ CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -124,7 +123,6 @@ CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
-- 
2.48.0

