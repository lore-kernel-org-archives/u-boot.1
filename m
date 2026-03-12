Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E99106703B
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 14:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7752C842DF;
	Thu, 12 Mar 2026 15:31:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="eu7KQg9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91781842CE; Thu, 12 Mar 2026 15:31:40 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A248426E
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 15:31:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/YEcyM3zuj4w2LYjJmGnDr4HSObSysEBRVaZocGMv4k=; b=eu7KQg9BFlkYJFpOCBs/cUb2Yj
 Mq7HolDdYBA65lNsAYdMG155SDI7mob+YAIQsKmfYq1ORaa1j3RQLEiGWkuw4jC17+8DizlEHMK1e
 PEZl747WHLMEda7MBZ1WrAWHaV+HBhqSoy/VmRnbfu1/u1Dj21ixTuA1xIT2PFvIEQeTa1rDX7ZK2
 sKwTF3Q7Hp+g0dSssTJUMwxruDz8gY1lnIDhA+CJexSubLwy/oB3JJsCqe2miPHcrP0bdbZobaicG
 kpirlZ9Yi+geQ0fZ2cEiJrbXNbYZ71KQ2G8nMCbmMn2bxm1vM8hkRUFyL/oSJ1HX+IrHA8aMcQYsa
 CqWvmB/w==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w0h4V-000FLn-3C; Thu, 12 Mar 2026 15:31:32 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w0h4V-0003V8-1u; Thu, 12 Mar 2026 15:31:31 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 7/8] configs: tqma7: add defconfigs
Date: Thu, 12 Mar 2026 15:31:17 +0100
Message-Id: <20260312143118.1677859-8-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
References: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Adds general shared configurations for different
boot media and variants for every ram configuration.

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 configs/tqma7_common.config       | 119 ++++++++++++++++++++++++++++++
 configs/tqma7_mba7_mmc_defconfig  |   2 +
 configs/tqma7_mba7_qspi_defconfig |   2 +
 configs/tqma7_mba7_uuu_defconfig  |   2 +
 configs/tqma7_mmc.config          |   4 +
 configs/tqma7_qspi.config         |   7 ++
 configs/tqma7_uuu.config          |  22 ++++++
 7 files changed, 158 insertions(+)
 create mode 100644 configs/tqma7_common.config
 create mode 100644 configs/tqma7_mba7_mmc_defconfig
 create mode 100644 configs/tqma7_mba7_qspi_defconfig
 create mode 100644 configs/tqma7_mba7_uuu_defconfig
 create mode 100644 configs/tqma7_mmc.config
 create mode 100644 configs/tqma7_qspi.config
 create mode 100644 configs/tqma7_uuu.config

diff --git a/configs/tqma7_common.config b/configs/tqma7_common.config
new file mode 100644
index 00000000000..7e5e31a14ab
--- /dev/null
+++ b/configs/tqma7_common.config
@@ -0,0 +1,119 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX7=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx7d-mba7"
+CONFIG_TARGET_TQMA7=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_MAX_SIZE=0x100000
+CONFIG_SF_DEFAULT_BUS=4
+CONFIG_SPL=y
+CONFIG_ARMV7_BOOT_SEC_DEFAULT=y
+CONFIG_IMX_RDC=y
+CONFIG_SYS_MEMTEST_START=0x80000000
+CONFIG_SYS_MEMTEST_END=0x98000000
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+# CONFIG_BOARD_EARLY_INIT_F is not set
+CONFIG_SPL_MAX_SIZE=0xf000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_CMD_LICENSE=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+# CONFIG_SYS_ALT_MEMTEST_BITFLIP is not set
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_TEMPERATURE=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_NFS=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=30bb0000.qspi"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=30bb0000.qspi:4m@0k(bootstream),64k@4096k(env0),64k@4160k(env1),-@6m(ubi)"
+CONFIG_CMD_UBI=y
+CONFIG_OF_CONTROL=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="nxp/imx/imx7d-mba7 nxp/imx/imx7s-mba7"
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ROOTPATH=y
+CONFIG_ROOTPATH="/srv/nfs"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_GPIO_HOG=y
+CONFIG_DM_PCA953X=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_I2C_DEFAULT_BUS_NUMBER=0x3
+CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_BOOTDEV_SPI_FLASH=y
+CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_ISSI=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY_GIGE=y
+CONFIG_FEC_MXC=y
+CONFIG_RGMII=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX7=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PFUZE100=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PFUZE100=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1307=y
+CONFIG_CONS_INDEX=5
+CONFIG_SPI=y
+CONFIG_FSL_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_IMX_THERMAL=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_IMX_WATCHDOG=y
+CONFIG_CC_OPTIMIZE_LIBS_FOR_SPEED=y
diff --git a/configs/tqma7_mba7_mmc_defconfig b/configs/tqma7_mba7_mmc_defconfig
new file mode 100644
index 00000000000..9d4a37c5b81
--- /dev/null
+++ b/configs/tqma7_mba7_mmc_defconfig
@@ -0,0 +1,2 @@
+#include <configs/tqma7_common.config>
+#include <configs/tqma7_mmc.config>
diff --git a/configs/tqma7_mba7_qspi_defconfig b/configs/tqma7_mba7_qspi_defconfig
new file mode 100644
index 00000000000..041339597b4
--- /dev/null
+++ b/configs/tqma7_mba7_qspi_defconfig
@@ -0,0 +1,2 @@
+#include <configs/tqma7_common.config>
+#include <configs/tqma7_qspi.config>
diff --git a/configs/tqma7_mba7_uuu_defconfig b/configs/tqma7_mba7_uuu_defconfig
new file mode 100644
index 00000000000..18404b02ed8
--- /dev/null
+++ b/configs/tqma7_mba7_uuu_defconfig
@@ -0,0 +1,2 @@
+#include <configs/tqma7_common.config>
+#include <configs/tqma7_uuu.config>
diff --git a/configs/tqma7_mmc.config b/configs/tqma7_mmc.config
new file mode 100644
index 00000000000..8c081314002
--- /dev/null
+++ b/configs/tqma7_mmc.config
@@ -0,0 +1,4 @@
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_BOOTCOMMAND="run mmcboot; run nfsboot; run panicboot"
+CONFIG_ENV_MMC_USE_DT=y
diff --git a/configs/tqma7_qspi.config b/configs/tqma7_qspi.config
new file mode 100644
index 00000000000..652abb8d14b
--- /dev/null
+++ b/configs/tqma7_qspi.config
@@ -0,0 +1,7 @@
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_QSPI_BOOT=y
+CONFIG_BOOTCOMMAND="run ubiboot; run nfsboot; run panicboot"
+# CONFIG_ENV_IS_IN_MMC is not set
+CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/tqma7_uuu.config b/configs/tqma7_uuu.config
new file mode 100644
index 00000000000..6131aa5b4b4
--- /dev/null
+++ b/configs/tqma7_uuu.config
@@ -0,0 +1,22 @@
+CONFIG_SYS_MALLOC_LEN=0x2000000
+# CONFIG_ANDROID_BOOT_IMAGE is not set
+CONFIG_BOOTDELAY=1
+CONFIG_BOOTCOMMAND="run fastbootcmd"
+# CONFIG_ENV_IS_IN_MMC is not set
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x84000000
+CONFIG_FASTBOOT_BUF_SIZE=0x8000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x80800000
+CONFIG_SPL_USB_SDP_SUPPORT=y
-- 
2.34.1

