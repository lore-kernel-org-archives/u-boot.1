Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28846C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:03:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F101087225;
	Sat,  4 Nov 2023 09:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aERo8j4f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF10987158; Sat,  4 Nov 2023 09:01:58 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69695870C8
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gVj019475;
 Sat, 4 Nov 2023 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699084902;
 bh=tlwUMYGpob6asbzVRZtP/WM2fwBlAenczWjJ48IVjbM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aERo8j4fwbgC1ErsVvDb/87QlmrQddn5TcG4imo19fHo2lejRkGrC3WXrqiFNq9/7
 dP/fIp+NPeRL7TDHGc8CMyCfsKYkTzLc+5NZTcZ8vcQQpB0QdkC/uehUaZ35NgtcZk
 b18r4DG/c9NPNuvBgiLDsfNF1bxFPmwT/XoyyWTw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A481gGB024507
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:01:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:01:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:01:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gLR100394;
 Sat, 4 Nov 2023 03:01:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <bb@ti.com>, <praneeth@ti.com>
Subject: [PATCH 2/5] configs: Add am62x_beagleplay_*_defconfig
Date: Sat, 4 Nov 2023 03:01:34 -0500
Message-ID: <20231104080137.9628-3-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104080137.9628-1-nm@ti.com>
References: <20231104080137.9628-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add am62x_beagleplay_* defconfig customized for the configuration of
BeaglePlay and drop the config fragments.

This is in preparation for dropping the dependency on ti vendor folder
entirely.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 board/ti/am62x/beagleplay_a53.config   |  55 ------------
 board/ti/am62x/beagleplay_r5.config    |  15 ----
 configs/am62x_beagleplay_a53_defconfig | 119 +++++++++++++++++++++++++
 configs/am62x_beagleplay_r5_defconfig  | 111 +++++++++++++++++++++++
 doc/board/ti/am62x_beagleplay.rst      |   4 +-
 5 files changed, 232 insertions(+), 72 deletions(-)
 delete mode 100644 board/ti/am62x/beagleplay_a53.config
 delete mode 100644 board/ti/am62x/beagleplay_r5.config
 create mode 100644 configs/am62x_beagleplay_a53_defconfig
 create mode 100644 configs/am62x_beagleplay_r5_defconfig

diff --git a/board/ti/am62x/beagleplay_a53.config b/board/ti/am62x/beagleplay_a53.config
deleted file mode 100644
index f0380416cc5e..000000000000
--- a/board/ti/am62x/beagleplay_a53.config
+++ /dev/null
@@ -1,55 +0,0 @@
-# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
-
-CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
-CONFIG_OF_LIST="k3-am625-beagleplay"
-CONFIG_SPL_OF_LIST="k3-am625-beagleplay"
-CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
-CONFIG_EXT4_WRITE=y
-CONFIG_LZO=y
-CONFIG_AUTOBOOT_KEYED=y
-CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
-CONFIG_AUTOBOOT_DELAY_STR="d"
-CONFIG_AUTOBOOT_STOP_STR=" "
-# Use the Beagleplay env file
-CONFIG_ENV_SOURCE_FILE="beagleplay"
-# Do not use emmc boot - we will use FS only
-CONFIG_SUPPORT_EMMC_BOOT=n
-CONFIG_MMC_IO_VOLTAGE=y
-# CONFIG_SPL_MMC_IO_VOLTAGE is not set
-CONFIG_MMC_UHS_SUPPORT=y
-# CONFIG_SPL_MMC_UHS_SUPPORT is not set
-CONFIG_MMC_HS200_SUPPORT=y
-# CONFIG_SPL_MMC_HS200_SUPPORT is not set
-# Enable GPIO control
-CONFIG_DM_GPIO=y
-CONFIG_SPL_GPIO=y
-CONFIG_DA8XX_GPIO=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPIO_READ=y
-# Enable LEDs
-CONFIG_LED=y
-CONFIG_LED_GPIO=y
-CONFIG_SPL_LED=y
-CONFIG_SPL_LED_GPIO=y
-# Enable I2C bus
-CONFIG_SPL_I2C=y
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_OMAP24XX=y
-CONFIG_CMD_I2C=y
-# Regulator
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_DM_REGULATOR_TPS65219=y
-CONFIG_DM_PMIC=y
-CONFIG_PMIC_TPS65219=y
-CONFIG_CMD_PMIC=y
-# Uses Realtek phy rather than TI phy
-CONFIG_PHY_TI_DP83867=n
-CONFIG_PHY_REALTEK=y
-# No SPI flash on Beagleplay
-CONFIG_SPI=n
-CONFIG_SPI_FLASH=n
-CONFIG_SPL_DM_SPI_FLASH=n
-CONFIG_SPL_SPI_FLASH_SUPPORT=n
diff --git a/board/ti/am62x/beagleplay_r5.config b/board/ti/am62x/beagleplay_r5.config
deleted file mode 100644
index 4ee0375a2a1d..000000000000
--- a/board/ti/am62x/beagleplay_r5.config
+++ /dev/null
@@ -1,15 +0,0 @@
-# Defconfig fragment to apply on top of:
-# am62x_evm_r5_defconfig
-#
-CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-beagleplay"
-CONFIG_OF_LIST="k3-am625-r5-beagleplay"
-CONFIG_SPL_OF_LIST="k3-am625-r5-beagleplay"
-# Do spl board init
-CONFIG_SPL_BOARD_INIT=y
-# Do not use emmc boot - we will use FS only
-CONFIG_SUPPORT_EMMC_BOOT=n
-# No SPI flash on Beagleplay
-CONFIG_SPI=n
-CONFIG_SPI_FLASH=n
-CONFIG_SPL_DM_SPI_FLASH=n
-CONFIG_SPL_SPI_FLASH_SUPPORT=n
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
new file mode 100644
index 000000000000..eca94a0a3b9a
--- /dev/null
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -0,0 +1,119 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
+CONFIG_TARGET_AM625_A53_EVM=y
+CONFIG_ENV_SOURCE_FILE="beagleplay"
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
+CONFIG_SPL_TEXT_BASE=0x80080000
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SIZE_LIMIT=0x40000
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+# CONFIG_PSCI_RESET is not set
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
+CONFIG_AUTOBOOT_KEYED=y
+CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
+CONFIG_AUTOBOOT_DELAY_STR="d"
+CONFIG_AUTOBOOT_STOP_STR=" "
+CONFIG_BOOTCOMMAND="run set_led_state_start_load;run findfdt; run envboot; bootflow scan -lb;run set_led_state_fail_load"
+CONFIG_SPL_MAX_SIZE=0x58000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x80c80000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_SYS_BOOTM_LEN=0x800000
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPIO_READ=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_TI_SCI=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_LED=y
+CONFIG_SPL_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SPL_LED_GPIO=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_TI=y
+CONFIG_PHY_FIXED=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65219=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_REGULATOR_TPS65219=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_TI_SCI=y
+CONFIG_EXT4_WRITE=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_LZO=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
new file mode 100644
index 000000000000..44d44428bb37
--- /dev/null
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -0,0 +1,111 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_LEN=0x08000000
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM625=y
+CONFIG_TARGET_AM625_R5_EVM=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
+CONFIG_ENV_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am625-r5-beagleplay"
+CONFIG_SPL_TEXT_BASE=0x43c00000
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x7000
+CONFIG_SPL_SIZE_LIMIT=0x3A7F0
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_MAX_SIZE=0x3B000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x43c3b000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
+CONFIG_SPL_EARLY_BSS=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x400
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_SUPPORT=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_REMOTEPROC=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_REMOTEPROC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIME=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_CLK_K3_PLL=y
+CONFIG_SPL_CLK_K3=y
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SPL_MISC=y
+CONFIG_ESM_K3=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_POWER_DOMAIN=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
index 97ab0a4350ed..11bafaf5e137 100644
--- a/doc/board/ti/am62x_beagleplay.rst
+++ b/doc/board/ti/am62x_beagleplay.rst
@@ -57,8 +57,8 @@ Set the variables corresponding to this platform:
     :end-before: .. k3_rst_include_end_common_env_vars_defn
 .. prompt:: bash $
 
-  export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
-  export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"
+  export UBOOT_CFG_CORTEXR=am62x_beagleplay_r5_defconfig
+  export UBOOT_CFG_CORTEXA=am62x_beagleplay_a53_defconfig
   export TFA_BOARD=lite
   # we dont use any extra TFA parameters
   unset TFA_EXTRA_ARGS
-- 
2.37.2

