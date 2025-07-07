Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491C4C8303C
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 15:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA49983264;
	Mon,  7 Jul 2025 17:54:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="BAztC1wX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A1E583121; Mon,  7 Jul 2025 13:44:16 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5EB4830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2768a2b95=Varshini.Rajendran@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1751888653; x=1783424653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d+Z33o5qe4qP2QGCGEnA2fs0BmviHoUznbubUUH7/CU=;
 b=BAztC1wX505uYb9QT/a7gLR7cvtzTUraXl45W3rVPRDoJFSwKD37w1XF
 XFaSZNc9KMmRukEcBH8rT8JvP1iQ0YKRZDygGRjb95W7aqKgH42+qgL4O
 DCvFWwyxDkJPQ/YX1aJPJyG4hRii9xeENw9z4JLiFMMj5kuYGqj63Q7JU
 3FGs2zxcGI/cECkicScg7WFV+Uv1m9ZqtHBTlacCKOU6YkOtP+QXGhojJ
 LzcREmZ5NNiQrhkpbTAiDdMP28NOm+oMNDaqvVr8Bz5+NAMAUjVA2kCWv
 h7xcaTGZ7QaYBoOBZSTME8Acr1DT0km/GF56Pm1emCzfI7HmtjspYOTjB Q==;
X-CSE-ConnectionGUID: FyvGSvafSDmQ2xh2YdENhg==
X-CSE-MsgGUID: 9TDPq4EZSbuZUtLJVP+1PA==
X-IronPort-AV: E=Sophos;i="6.16,294,1744095600"; d="scan'208";a="43164945"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 07 Jul 2025 04:44:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 04:43:50 -0700
Received: from che-dk-mpulab01.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 7 Jul 2025 04:43:48 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <eugen.hristev@linaro.org>, <ryan.wanner@microchip.com>,
 <Romain.Sioen@microchip.com>, <u-boot@lists.denx.de>
CC: <varshini.rajendran@microchip.com>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 6/6] configs: sama7d65_curiosity: Add defconfig for
 sama7d65_curiosity
Date: Mon, 7 Jul 2025 17:07:43 +0530
Message-ID: <20250707113743.4135558-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
References: <20250707112934.4128905-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 07 Jul 2025 17:54:47 +0200
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Add initial mmc defconfig to boot from SDMMC1.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Signed-off-by: Romain Sioen <Romain.Sioen@microchip.com>
---
 board/atmel/sama7d65_curiosity/MAINTAINERS |   1 +
 configs/sama7d65_curiosity_mmc1_defconfig  | 108 +++++++++++++++++++++
 2 files changed, 109 insertions(+)
 create mode 100644 configs/sama7d65_curiosity_mmc1_defconfig

diff --git a/board/atmel/sama7d65_curiosity/MAINTAINERS b/board/atmel/sama7d65_curiosity/MAINTAINERS
index be67d56dc5b..054af3c6541 100644
--- a/board/atmel/sama7d65_curiosity/MAINTAINERS
+++ b/board/atmel/sama7d65_curiosity/MAINTAINERS
@@ -3,3 +3,4 @@ M:     Ryan Wanner <ryan.wanner@microchip.com>
 S:     Maintained
 F:     board/atmel/sama7d65_curiosity.c
 F:     include/configs/sama7d65_curiosity.h
+F:     configs/sama7d65_curiosity_mmc1_defconfig
diff --git a/configs/sama7d65_curiosity_mmc1_defconfig b/configs/sama7d65_curiosity_mmc1_defconfig
new file mode 100644
index 00000000000..e819e51b458
--- /dev/null
+++ b/configs/sama7d65_curiosity_mmc1_defconfig
@@ -0,0 +1,108 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x66f00000
+CONFIG_SYS_MALLOC_F_LEN=0x11000
+CONFIG_TARGET_SAMA7D65_CURIOSITY=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60014ef0
+CONFIG_SYS_MEMTEST_START=0x60000000
+CONFIG_SYS_MEMTEST_END=0x70000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="microchip/at91-sama7d65_curiosity"
+CONFIG_DEBUG_UART_BOARD_INIT=y
+CONFIG_DEBUG_UART_BASE=0xe2020200
+CONFIG_DEBUG_UART_CLOCK=100000000
+CONFIG_DEBUG_UART=y
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_SYS_LOAD_ADDR=0x62000000
+CONFIG_FIT=y
+CONFIG_SD_BOOT=y
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk0p2 rw rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fatload mmc 0:1 0x61000000 at91-sama7d65_curiosity.dtb; fatload mmc 0:1 0x62000000 zImage; bootz 0x62000000 - 0x61000000"
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_CMD_IMI=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_STRINGS=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_WGET=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_DNS=y
+CONFIG_CMD_HASH=y
+CONFIG_HASH_VERIFY=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_ARP_TIMEOUT=200
+CONFIG_NET_RETRY_COUNT=50
+CONFIG_DM=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_UTMI=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_AT91_SAM9X60_PLL=y
+CONFIG_CPU=y
+CONFIG_ATMEL_PIO4=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_DM_MTD=y
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SF_DEFAULT_MODE=0x0
+CONFIG_SF_DEFAULT_SPEED=133000000
+CONFIG_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPI_FLASH_SOFT_RESET=n
+CONFIG_SPI_FLASH_MACRONIX=n
+CONFIG_SPI_FLASH_MX66LM1G45G=n
+CONFIG_SPI_FLASH_SST=n
+CONFIG_SPI_FLASH_MTD=n
+CONFIG_DM_ETH=y
+CONFIG_PHY_SMSC=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_MACB=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_DM_RESET=y
+CONFIG_RESET_AT91=y
+CONFIG_DM_SERIAL=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_ATMEL_USART=y
+CONFIG_SPI=n
+# CONFIG_ATMEL_SPI is not set
+CONFIG_TIMER=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_RESET=y
+CONFIG_SYSRESET_AT91=y
+CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+# CONFIG_EFI_LOADER_HII is not set
+CONFIG_PHANDLE_CHECK_SEQ=y
-- 
2.45.2

