Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD50C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 07:30:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F70832FE;
	Mon, 11 Aug 2025 09:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="sWKHIpBd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E8EB83321; Mon, 11 Aug 2025 09:30:52 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5090830B3
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 09:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=311c96ee0=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1754897450; x=1786433450;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=oZrSbERPhbU6Q2UZmWk4nsPGWbnSKUqU5Tulnwp0abc=;
 b=sWKHIpBdZVLEZycgJS4ZIZk8VVEh1yj/bVRWhZAis00TYHdeOYnzeMnB
 JrFq5S23WTPWowecQAznnqlIfvDqhvEtoU9N6CLbo9XlLmIJ6hfLrlF5F
 5RDTM7TQe+vXUGR4sop3tKlGXFL4p8U7bz+qMBOrdzSWDPd9Xv9paIJXM
 hWbRfdxPbvrcUV5eIgZ5nqcHu9JH4Zq0/fbZQuD7EOg4w4Gx65kQi/Wvp
 N85h7d/GcD/IS0UFyZCAVW9h5MMgGHmjz9GMyTTvxWx8+qg3QZ9XrF+TS
 C5okNAqZDzYn5443nD7xgdgUnFJLcyWyYSco796VokLitaDm+1CDnMQDN A==;
X-CSE-ConnectionGUID: mQhwjvK5QxiNpHTRUPhYNg==
X-CSE-MsgGUID: b3DM0FCPR+Kaa8m3l46VsA==
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="45034030"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 11 Aug 2025 00:30:48 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 11 Aug 2025 00:30:37 -0700
Received: from archlinux.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 11 Aug 2025 00:30:36 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <ryan.wanner@microchip.com>, <trini@konsulko.com>,
 <Romain.Sioen@microchip.com>, <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>
CC: Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH] configs: sama7d65_curiosity: Resync with savedefconfig
Date: Mon, 11 Aug 2025 10:30:33 +0300
Message-ID: <20250811073033.5173-1-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Perform a clean up of the initial defconfig file,
and resync with savedefconfig.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 configs/sama7d65_curiosity_mmc1_defconfig | 43 ++++++++---------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/configs/sama7d65_curiosity_mmc1_defconfig b/configs/sama7d65_curiosity_mmc1_defconfig
index e819e51b458..61adebf1980 100644
--- a/configs/sama7d65_curiosity_mmc1_defconfig
+++ b/configs/sama7d65_curiosity_mmc1_defconfig
@@ -6,17 +6,21 @@ CONFIG_TARGET_SAMA7D65_CURIOSITY=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60014ef0
-CONFIG_SYS_MEMTEST_START=0x60000000
-CONFIG_SYS_MEMTEST_END=0x70000000
 CONFIG_ENV_SIZE=0x4000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="microchip/at91-sama7d65_curiosity"
-CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x62000000
 CONFIG_DEBUG_UART_BASE=0xe2020200
 CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_DEBUG_UART_BOARD_INIT=y
 CONFIG_DEBUG_UART=y
+CONFIG_SYS_MEMTEST_START=0x60000000
+CONFIG_SYS_MEMTEST_END=0x70000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
-CONFIG_SYS_LOAD_ADDR=0x62000000
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_SD_BOOT=y
 CONFIG_USE_BOOTARGS=y
@@ -25,8 +29,6 @@ CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="fatload mmc 0:1 0x61000000 at91-sama7d65_curiosity.dtb; fatload mmc 0:1 0x62000000 zImage; bootz 0x62000000 - 0x61000000"
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_BOOTZ=y
-CONFIG_SYS_BOOTM_LEN=0x2000000
-CONFIG_CMD_IMI=y
 CONFIG_CMD_MD5SUM=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_STRINGS=y
@@ -38,23 +40,21 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND=y
-CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_DHCP=y
-CONFIG_CMD_WGET=y
+CONFIG_CMD_DNS=y
 CONFIG_CMD_MII=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DNS=y
+CONFIG_CMD_WGET=y
 CONFIG_CMD_HASH=y
 CONFIG_HASH_VERIFY=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_FAT=y
+CONFIG_PARTITION_UUIDS=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_NET_RETRY_COUNT=50
-CONFIG_DM=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
@@ -72,37 +72,22 @@ CONFIG_MICROCHIP_FLEXCOM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ATMEL=y
 CONFIG_MTD=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_DM_NAND_ATMEL=y
 CONFIG_SYS_NAND_ONFI_DETECTION=y
-CONFIG_DM_SPI_FLASH=n
-CONFIG_SF_DEFAULT_MODE=0x0
-CONFIG_SF_DEFAULT_SPEED=133000000
-CONFIG_SPI_FLASH_SFDP_SUPPORT=n
-CONFIG_SPI_FLASH_SOFT_RESET=n
-CONFIG_SPI_FLASH_MACRONIX=n
-CONFIG_SPI_FLASH_MX66LM1G45G=n
-CONFIG_SPI_FLASH_SST=n
-CONFIG_SPI_FLASH_MTD=n
-CONFIG_DM_ETH=y
 CONFIG_PHY_SMSC=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_AT91PIO4=y
-CONFIG_DM_RESET=y
 CONFIG_RESET_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
-CONFIG_SPI=n
-# CONFIG_ATMEL_SPI is not set
-CONFIG_TIMER=y
 CONFIG_SYSRESET=y
-CONFIG_SYSRESET_CMD_RESET=y
 CONFIG_SYSRESET_AT91=y
+CONFIG_TIMER=y
 CONFIG_MCHP_PIT64B_TIMER=y
-CONFIG_OF_LIBFDT_OVERLAY=y
-# CONFIG_EFI_LOADER_HII is not set
+CONFIG_FAT_RENAME=y
 CONFIG_PHANDLE_CHECK_SEQ=y
-- 
2.50.1

