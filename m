Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D530CCD3447
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 11:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F16A84C8D;
	Fri,  8 May 2026 13:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="F2lDExy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A91484C90; Fri,  8 May 2026 13:53:32 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D36E84C81
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 13:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cJuBfii/m/HOcf27WC8FT7zyXciezXTNFF6Fwp3C6i0=; b=F2lDExy/BpW2uy6oRFBm5Hnere
 6IqDXD5hruoHjDsoVtRIz7Goop1sBSLlHTfJA7sPPRc38AelM21++VeDIio/BhFnwWtHS0QMthIgk
 Z4y2RyDDfmxQZdbgji6b0mEQKybAeaTj5uCNVoBm7vGKUrnaqtddURZ5NQJPkwKPedijyWYUjESEU
 CblLcbfUz3Hpli84Csrvka9N6APp6GDshni4aH5/CAu8qs3nJiynC3502pMa8hY8XNeYX875z6ikF
 opkWBEZo+Prb7zcmyvbEwXUrwyOqQKX5DOqreOI7e8/8CQaKqbO7qXcVI40Xue79bLaGPcJsiLOS5
 Buszx9MQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJlo-000DVx-0X; Fri, 08 May 2026 13:53:28 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1wLJln-000PER-2C; Fri, 08 May 2026 13:53:27 +0200
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Max Merchel <max.merchel@ew.tq-group.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>, u-boot@ew.tq-group.com,
 u-boot@lists.denx.de
Subject: [PATCH 5/5] configs: add defconfigs for TQMa6UL[L]x[L] SOM on MBa6ULx
 baseboard
Date: Fri,  8 May 2026 13:53:10 +0200
Message-ID: <20260508115315.252623-6-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
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

work around ERR11115:
The lower part of the OCRAM is unusable on i.MX6UL mask revision 2N52P
with date code before 9/22/2017. Adjust CONFIG_SPL_TEXT_BASE and
CONFIG_SPL_MAX_SIZE accordingly to fix boot on these SoCs.

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/tqma6ul_common.config            | 124 +++++++++++++++++++++++
 configs/tqma6ul_mmc.config               |   3 +
 configs/tqma6ul_spi.config               |   2 +
 configs/tqma6ul_uuu.config               |  20 ++++
 configs/tqma6ullx_mba6ul_mmc_defconfig   |   5 +
 configs/tqma6ullx_mba6ul_qspi_defconfig  |   5 +
 configs/tqma6ullx_mba6ul_uuu_defconfig   |   5 +
 configs/tqma6ullxl_mba6ul_mmc_defconfig  |   6 ++
 configs/tqma6ullxl_mba6ul_qspi_defconfig |   6 ++
 configs/tqma6ullxl_mba6ul_uuu_defconfig  |   6 ++
 configs/tqma6ulx_mba6ul_mmc_defconfig    |   6 ++
 configs/tqma6ulx_mba6ul_qspi_defconfig   |   6 ++
 configs/tqma6ulx_mba6ul_uuu_defconfig    |   6 ++
 configs/tqma6ulxl_mba6ul_mmc_defconfig   |   6 ++
 configs/tqma6ulxl_mba6ul_qspi_defconfig  |   6 ++
 configs/tqma6ulxl_mba6ul_uuu_defconfig   |   6 ++
 16 files changed, 218 insertions(+)
 create mode 100644 configs/tqma6ul_common.config
 create mode 100644 configs/tqma6ul_mmc.config
 create mode 100644 configs/tqma6ul_spi.config
 create mode 100644 configs/tqma6ul_uuu.config
 create mode 100644 configs/tqma6ullx_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ullx_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ullx_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ullxl_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ulx_mba6ul_uuu_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_mmc_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_qspi_defconfig
 create mode 100644 configs/tqma6ulxl_mba6ul_uuu_defconfig

diff --git a/configs/tqma6ul_common.config b/configs/tqma6ul_common.config
new file mode 100644
index 00000000000..bf0ba978263
--- /dev/null
+++ b/configs/tqma6ul_common.config
@@ -0,0 +1,124 @@
+CONFIG_ARM=y
+CONFIG_ARCH_MX6=y
+CONFIG_TEXT_BASE=0x8fc00000
+CONFIG_SYS_MALLOC_LEN=0x1000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SF_DEFAULT_SPEED=33000000
+CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_TARGET_TQMA6UL=y
+CONFIG_SPL_TEXT_BASE=0x909000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0xb000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x88000000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL=y
+CONFIG_IMX_MODULE_FUSE=y
+CONFIG_SYS_MEMTEST_START=0x82000000
+CONFIG_SYS_MEMTEST_END=0x83000000
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_BOOTDELAY=3
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_FDT_FIXUP_PARTITIONS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND="run mmcboot"
+CONFIG_SYS_CONSOLE_IS_IN_ENV=y
+CONFIG_SPL_MAX_SIZE=0xf000
+CONFIG_SPL_RAW_IMAGE_SUPPORT=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_FIT_IMAGE_TINY=y
+CONFIG_SPL_NOR_SUPPORT=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_LICENSE=y
+CONFIG_CMD_BOOTZ=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_EEPROM=y
+CONFIG_CMD_MD5SUM=y
+CONFIG_MD5SUM_VERIFY=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_SYS_ALT_MEMTEST=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_MMC_SPEED_MODE_SET=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_WDT=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_NFS=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_PMIC=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_MTDIDS_DEFAULT="nor0=21e0000.qspi"
+CONFIG_MTDPARTS_DEFAULT="mtdparts=21e0000.qspi:4m@0k(bootstream),64k@4096k(env0),64k@4160k(env1),-@6m(ubi)"
+CONFIG_CMD_UBI=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT_LZO=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ROOTPATH=y
+CONFIG_ROOTPATH="/srv/nfs"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_DM_PCA953X=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_I2C_DEFAULT_BUS_NUMBER=0x3
+CONFIG_SYS_I2C_MXC=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_BOOTDEV_SPI_FLASH=y
+# CONFIG_SPI_FLASH_BAR is not set
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
+CONFIG_FEC_MXC=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_PFUZE100=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_PFUZE100=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_DS1307=y
+CONFIG_FSL_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
+CONFIG_SYSRESET_WATCHDOG_AUTO=y
+CONFIG_DM_THERMAL=y
+CONFIG_IMX_THERMAL=y
+CONFIG_MXC_USB_OTG_HACTIVE=y
+CONFIG_IMX_WATCHDOG=y
diff --git a/configs/tqma6ul_mmc.config b/configs/tqma6ul_mmc.config
new file mode 100644
index 00000000000..430cd9411e1
--- /dev/null
+++ b/configs/tqma6ul_mmc.config
@@ -0,0 +1,3 @@
+CONFIG_SD_BOOT=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_MMC_USE_DT=y
diff --git a/configs/tqma6ul_spi.config b/configs/tqma6ul_spi.config
new file mode 100644
index 00000000000..20eed285f39
--- /dev/null
+++ b/configs/tqma6ul_spi.config
@@ -0,0 +1,2 @@
+CONFIG_QSPI_BOOT=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
diff --git a/configs/tqma6ul_uuu.config b/configs/tqma6ul_uuu.config
new file mode 100644
index 00000000000..93e3ab03ae5
--- /dev/null
+++ b/configs/tqma6ul_uuu.config
@@ -0,0 +1,20 @@
+CONFIG_SYS_MALLOC_F_LEN=0x14000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x12000
+CONFIG_BOOTDELAY=1
+CONFIG_BOOTCOMMAND="run fastbootcmd"
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0x84000000
+CONFIG_FASTBOOT_BUF_SIZE=0x8000000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_UUU_SUPPORT=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_SDP_LOADADDR=0x8fbfffc0
+CONFIG_SPL_USB_SDP_SUPPORT=y
diff --git a/configs/tqma6ullx_mba6ul_mmc_defconfig b/configs/tqma6ullx_mba6ul_mmc_defconfig
new file mode 100644
index 00000000000..e708ac634d4
--- /dev/null
+++ b/configs/tqma6ullx_mba6ul_mmc_defconfig
@@ -0,0 +1,5 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_mmc.config>
+
+CONFIG_MX6ULL=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-tqma6ull2-mba6ulx"
diff --git a/configs/tqma6ullx_mba6ul_qspi_defconfig b/configs/tqma6ullx_mba6ul_qspi_defconfig
new file mode 100644
index 00000000000..8432111928e
--- /dev/null
+++ b/configs/tqma6ullx_mba6ul_qspi_defconfig
@@ -0,0 +1,5 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_spi.config>
+
+CONFIG_MX6ULL=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-tqma6ull2-mba6ulx"
diff --git a/configs/tqma6ullx_mba6ul_uuu_defconfig b/configs/tqma6ullx_mba6ul_uuu_defconfig
new file mode 100644
index 00000000000..20869ccdedc
--- /dev/null
+++ b/configs/tqma6ullx_mba6ul_uuu_defconfig
@@ -0,0 +1,5 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_uuu.config>
+
+CONFIG_MX6ULL=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-tqma6ull2-mba6ulx"
diff --git a/configs/tqma6ullxl_mba6ul_mmc_defconfig b/configs/tqma6ullxl_mba6ul_mmc_defconfig
new file mode 100644
index 00000000000..c529c994e67
--- /dev/null
+++ b/configs/tqma6ullxl_mba6ul_mmc_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_mmc.config>
+
+CONFIG_MX6ULL=y
+CONFIG_TQMA6UL_VARIANT_LGA=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-tqma6ull2l-mba6ulx"
diff --git a/configs/tqma6ullxl_mba6ul_qspi_defconfig b/configs/tqma6ullxl_mba6ul_qspi_defconfig
new file mode 100644
index 00000000000..721038a9c45
--- /dev/null
+++ b/configs/tqma6ullxl_mba6ul_qspi_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_spi.config>
+
+CONFIG_MX6ULL=y
+CONFIG_TQMA6UL_VARIANT_LGA=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-tqma6ull2l-mba6ulx"
diff --git a/configs/tqma6ullxl_mba6ul_uuu_defconfig b/configs/tqma6ullxl_mba6ul_uuu_defconfig
new file mode 100644
index 00000000000..07cde78ccb1
--- /dev/null
+++ b/configs/tqma6ullxl_mba6ul_uuu_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_uuu.config>
+
+CONFIG_MX6ULL=y
+CONFIG_TQMA6UL_VARIANT_LGA=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ull-tqma6ull2l-mba6ulx"
diff --git a/configs/tqma6ulx_mba6ul_mmc_defconfig b/configs/tqma6ulx_mba6ul_mmc_defconfig
new file mode 100644
index 00000000000..3e140da2cc2
--- /dev/null
+++ b/configs/tqma6ulx_mba6ul_mmc_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_mmc.config>
+
+CONFIG_MX6UL=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-tqma6ul1-mba6ulx"
+CONFIG_OF_LIST="nxp/imx/imx6ul-tqma6ul1-mba6ulx nxp/imx/imx6ul-tqma6ul2-mba6ulx"
diff --git a/configs/tqma6ulx_mba6ul_qspi_defconfig b/configs/tqma6ulx_mba6ul_qspi_defconfig
new file mode 100644
index 00000000000..78ae745b8c0
--- /dev/null
+++ b/configs/tqma6ulx_mba6ul_qspi_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_spi.config>
+
+CONFIG_MX6UL=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-tqma6ul1-mba6ulx"
+CONFIG_OF_LIST="nxp/imx/imx6ul-tqma6ul1-mba6ulx nxp/imx/imx6ul-tqma6ul2-mba6ulx"
diff --git a/configs/tqma6ulx_mba6ul_uuu_defconfig b/configs/tqma6ulx_mba6ul_uuu_defconfig
new file mode 100644
index 00000000000..6dc019277f8
--- /dev/null
+++ b/configs/tqma6ulx_mba6ul_uuu_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_uuu.config>
+
+CONFIG_MX6UL=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-tqma6ul1-mba6ulx"
+CONFIG_OF_LIST="nxp/imx/imx6ul-tqma6ul1-mba6ulx nxp/imx/imx6ul-tqma6ul2-mba6ulx"
diff --git a/configs/tqma6ulxl_mba6ul_mmc_defconfig b/configs/tqma6ulxl_mba6ul_mmc_defconfig
new file mode 100644
index 00000000000..a7c3baba0d6
--- /dev/null
+++ b/configs/tqma6ulxl_mba6ul_mmc_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_mmc.config>
+
+CONFIG_MX6UL=y
+CONFIG_TQMA6UL_VARIANT_LGA=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-tqma6ul2l-mba6ulx"
diff --git a/configs/tqma6ulxl_mba6ul_qspi_defconfig b/configs/tqma6ulxl_mba6ul_qspi_defconfig
new file mode 100644
index 00000000000..6934a4f984a
--- /dev/null
+++ b/configs/tqma6ulxl_mba6ul_qspi_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_spi.config>
+
+CONFIG_MX6UL=y
+CONFIG_TQMA6UL_VARIANT_LGA=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-tqma6ul2l-mba6ulx"
diff --git a/configs/tqma6ulxl_mba6ul_uuu_defconfig b/configs/tqma6ulxl_mba6ul_uuu_defconfig
new file mode 100644
index 00000000000..721d9bf32a2
--- /dev/null
+++ b/configs/tqma6ulxl_mba6ul_uuu_defconfig
@@ -0,0 +1,6 @@
+#include <configs/tqma6ul_common.config>
+#include <configs/tqma6ul_uuu.config>
+
+CONFIG_MX6UL=y
+CONFIG_TQMA6UL_VARIANT_LGA=y
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6ul-tqma6ul2l-mba6ulx"
-- 
2.43.0

