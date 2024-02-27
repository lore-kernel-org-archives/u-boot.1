Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D50F6C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 13:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F28788013;
	Tue, 27 Feb 2024 14:44:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="IBNnvzEL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16DAA8800C; Tue, 27 Feb 2024 14:44:56 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87B658800A
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 14:44:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Mihai.Sain@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1709041494; x=1740577494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZoVxxGgeY3LnwM5dj/L6cW/9omY+WK2BJ5dtgIfpM5g=;
 b=IBNnvzEL7RQSYYcMCQVdNvWdYIWQ9TGW6RuFd8tk45vrp/uJlyHW6DXT
 VWPIvU8QpjEt5b3kfUnvRZIVmE8W7y2a/zYZ5pWFSBxYNNWL2uzoeZ3db
 92NFGsWHPD1bmW0l1wlrOGrTv+P7HLSASE2HQcsB3vFozSovPRjiN7J4z
 q9sgiljYdT37JXBP0oE79ZFYKRO52DXCEsc3SaYDYYqYQJ9dDRti1ACWs
 X5TJ4hf24Iv28c+g+jHTe11ky/jWduaihRsKuKOV1UHoyHFo+NewgNMVf
 65swNHeXAIwbAVhvZSBXzevFsew88YUgWj3MusQOev8LAQZyh79yBM4QG A==;
X-CSE-ConnectionGUID: HJeNXA3BRTuID+cAO3ulFQ==
X-CSE-MsgGUID: hzwdzKpHSLGKNYogIqjyqw==
X-IronPort-AV: E=Sophos;i="6.06,187,1705388400"; d="scan'208";a="247638377"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Feb 2024 06:44:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 06:44:13 -0700
Received: from archlinux.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 06:44:12 -0700
From: Mihai Sain <mihai.sain@microchip.com>
To: <eugen.hristev@collabora.com>, <u-boot@lists.denx.de>
CC: <cristian.birsan@microchip.com>, Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 4/4] configs: at91: sama7g54_curiosity: Add initial default
 configs
Date: Tue, 27 Feb 2024 15:44:03 +0200
Message-ID: <20240227134403.10686-5-mihai.sain@microchip.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227134403.10686-1-mihai.sain@microchip.com>
References: <20240227134403.10686-1-mihai.sain@microchip.com>
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

Add default configuration for nand-flash to boot the linux kernel.
Add default configuration for qspi-flash to boot the linux kernel.
Add default configuration for sd-card to boot the linux kernel.
Configs are synced with savedefconfig.

Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
---
 configs/sama7g54_curiosity_mmc_defconfig      | 123 ++++++++++++++++++
 .../sama7g54_curiosity_nandflash_defconfig    | 122 +++++++++++++++++
 .../sama7g54_curiosity_qspiflash_defconfig    | 122 +++++++++++++++++
 include/configs/sama7g54_curiosity.h          |  17 +++
 4 files changed, 384 insertions(+)
 create mode 100644 configs/sama7g54_curiosity_mmc_defconfig
 create mode 100644 configs/sama7g54_curiosity_nandflash_defconfig
 create mode 100644 configs/sama7g54_curiosity_qspiflash_defconfig
 create mode 100644 include/configs/sama7g54_curiosity.h

diff --git a/configs/sama7g54_curiosity_mmc_defconfig b/configs/sama7g54_curiosity_mmc_defconfig
new file mode 100644
index 0000000000..fa3636828e
--- /dev/null
+++ b/configs/sama7g54_curiosity_mmc_defconfig
@@ -0,0 +1,123 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x66f00000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_TARGET_SAMA7G54_CURIOSITY=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60044000
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="at91-sama7g54_curiosity"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x62000000
+CONFIG_SYS_MEMTEST_START=0x60000000
+CONFIG_SYS_MEMTEST_END=0x68000000
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_FIT=y
+# CONFIG_BOOTSTD is not set
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_NAND_BOOT=y
+CONFIG_QSPI_BOOT=y
+CONFIG_SD_BOOT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk1p2 rw rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="fatload mmc 1:1 0x61000000 at91-sama7g54_curiosity.dtb; fatload mmc 1:1 0x62000000 zImage; bootz 0x62000000 - 0x61000000"
+CONFIG_LOGLEVEL=6
+CONFIG_BOARD_TYPES=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_CPU=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEM_SEARCH=y
+CONFIG_CMD_MX_CYCLIC=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_STRINGS=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_CMD_NAND_TORTURE=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_MTDPARTS_SPREAD=y
+CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand0,nor0=nor0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro,256k(env-nand)ro,512k(dtb-nand)ro,6M(kernel-nand)ro,-(rootfs-nand)ro;nor0:256k(bootstrap-nor)ro,1M(u-boot-nor)ro,256k(env-nor)ro,512k(dtb-nor)ro,6M(kernel-nor)ro"
+CONFIG_OF_CONTROL=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_IS_IN_FAT=y
+CONFIG_ENV_FAT_DEVICE_AND_PART="1:1"
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="SAMA7G54"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_NET is not set
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_UTMI=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_AT91_SAM9X60_PLL=y
+CONFIG_CPU=y
+CONFIG_ATMEL_PIO4=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SST=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_ATMEL_USART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ATMEL_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
+CONFIG_TIMER=y
+CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_FAT_WRITE=y
+CONFIG_CMD_DHRYSTONE=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/sama7g54_curiosity_nandflash_defconfig b/configs/sama7g54_curiosity_nandflash_defconfig
new file mode 100644
index 0000000000..331bb8d0fe
--- /dev/null
+++ b/configs/sama7g54_curiosity_nandflash_defconfig
@@ -0,0 +1,122 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x66f00000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_TARGET_SAMA7G54_CURIOSITY=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60044000
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_ENV_SECT_SIZE=0x1000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="at91-sama7g54_curiosity"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x62000000
+CONFIG_SYS_MEMTEST_START=0x60000000
+CONFIG_SYS_MEMTEST_END=0x68000000
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_FIT=y
+# CONFIG_BOOTSTD is not set
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_NAND_BOOT=y
+CONFIG_QSPI_BOOT=y
+CONFIG_SD_BOOT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk1p2 rw rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="nand read 0x61000000 0x180000 0x80000; nand read 0x62000000 0x200000 0x600000; bootz 0x62000000 - 0x61000000"
+CONFIG_LOGLEVEL=6
+CONFIG_BOARD_TYPES=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_CPU=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEM_SEARCH=y
+CONFIG_CMD_MX_CYCLIC=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_STRINGS=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_CMD_NAND_TORTURE=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_MTDPARTS_SPREAD=y
+CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand0,nor0=nor0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro,256k(env-nand)ro,512k(dtb-nand)ro,6M(kernel-nand)ro,-(rootfs-nand)ro;nor0:256k(bootstrap-nor)ro,1M(u-boot-nor)ro,256k(env-nor)ro,512k(dtb-nor)ro,6M(kernel-nor)ro"
+CONFIG_OF_CONTROL=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_IS_IN_NAND=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="SAMA7G54"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_NET is not set
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_UTMI=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_AT91_SAM9X60_PLL=y
+CONFIG_CPU=y
+CONFIG_ATMEL_PIO4=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SST=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_ATMEL_USART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ATMEL_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
+CONFIG_TIMER=y
+CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_FAT_WRITE=y
+CONFIG_CMD_DHRYSTONE=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/configs/sama7g54_curiosity_qspiflash_defconfig b/configs/sama7g54_curiosity_qspiflash_defconfig
new file mode 100644
index 0000000000..00e5362a1f
--- /dev/null
+++ b/configs/sama7g54_curiosity_qspiflash_defconfig
@@ -0,0 +1,122 @@
+CONFIG_ARM=y
+CONFIG_ARCH_AT91=y
+CONFIG_TEXT_BASE=0x66f00000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_TARGET_SAMA7G54_CURIOSITY=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x60044000
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="at91-sama7g54_curiosity"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SYS_LOAD_ADDR=0x62000000
+CONFIG_SYS_MEMTEST_START=0x60000000
+CONFIG_SYS_MEMTEST_END=0x68000000
+CONFIG_ENV_VARS_UBOOT_CONFIG=y
+CONFIG_FIT=y
+# CONFIG_BOOTSTD is not set
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_NAND_BOOT=y
+CONFIG_QSPI_BOOT=y
+CONFIG_SD_BOOT=y
+CONFIG_BOOTDELAY=3
+CONFIG_USE_BOOTARGS=y
+CONFIG_BOOTARGS="console=ttyS0,115200 root=/dev/mmcblk1p2 rw rootwait"
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="sf probe 0; sf read 0x61000000 0x180000 0x80000; sf read 0x62000000 0x200000 0x600000; bootz 0x62000000 - 0x61000000"
+CONFIG_LOGLEVEL=6
+CONFIG_BOARD_TYPES=y
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_CPU=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEM_SEARCH=y
+CONFIG_CMD_MX_CYCLIC=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_STRINGS=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DM=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+# CONFIG_CMD_LOADB is not set
+# CONFIG_CMD_LOADS is not set
+CONFIG_CMD_LSBLK=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_NAND_LOCK_UNLOCK=y
+CONFIG_CMD_NAND_TORTURE=y
+CONFIG_CMD_SF_TEST=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_MTDPARTS_SPREAD=y
+CONFIG_CMD_MTDPARTS_SHOW_NET_SIZES=y
+CONFIG_MTDIDS_DEFAULT="nand0=nand0,nor0=nor0"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=nand0:256k(bootstrap-nand)ro,1M(u-boot-nand)ro,256k(env-nand)ro,512k(dtb-nand)ro,6M(kernel-nand)ro,-(rootfs-nand)ro;nor0:256k(bootstrap-nor)ro,1M(u-boot-nor)ro,256k(env-nor)ro,512k(dtb-nor)ro,6M(kernel-nor)ro"
+CONFIG_OF_CONTROL=y
+# CONFIG_OF_TAG_MIGRATE is not set
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_USE_HOSTNAME=y
+CONFIG_HOSTNAME="SAMA7G54"
+CONFIG_VERSION_VARIABLE=y
+# CONFIG_NET is not set
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_AT91=y
+CONFIG_AT91_UTMI=y
+CONFIG_AT91_GENERIC_CLK=y
+CONFIG_AT91_SAM9X60_PLL=y
+CONFIG_CPU=y
+CONFIG_ATMEL_PIO4=y
+CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_SYS_I2C_AT91=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MICROCHIP_FLEXCOM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SST=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_AT91PIO4=y
+CONFIG_RESET_AT91=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_EMULATION=y
+CONFIG_DM_SERIAL=y
+CONFIG_ATMEL_USART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_ATMEL_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
+CONFIG_TIMER=y
+CONFIG_MCHP_PIT64B_TIMER=y
+CONFIG_FAT_WRITE=y
+CONFIG_CMD_DHRYSTONE=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_PHANDLE_CHECK_SEQ=y
diff --git a/include/configs/sama7g54_curiosity.h b/include/configs/sama7g54_curiosity.h
new file mode 100644
index 0000000000..fe47236158
--- /dev/null
+++ b/include/configs/sama7g54_curiosity.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration file for the SAMA7G54 CURIOSITY board.
+ *
+ * Copyright (C) 2024 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Mihai Sain <mihai.sain@microchip.com>
+ *
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define CFG_SYS_AT91_SLOW_CLOCK		32768
+#define CFG_SYS_AT91_MAIN_CLOCK		24000000
+
+#endif
-- 
2.44.0

