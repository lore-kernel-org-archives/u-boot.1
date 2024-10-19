Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EE3D3C92D
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 22:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4678E892A0;
	Sun, 20 Oct 2024 00:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729375429;
	bh=mnZb++x/VKVkxk8/wnfIyx35qsED4IRnv1UpCywXb84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E/uEog20avP2B2Ut6qi2o0RIJPHKR1Fo38rQlaKw5o2jtqGcdAU9XZbgj9NrgjgBI
	 LClzTZjUiC3rXJYRnHXU/PIfnpo+okSA9zgPf8kzHJSJufYDALvr8ADz+PxcLEwTRU
	 vp/dPm0CS5Ij62ZDfk1kEo0V6meVGuT3seVvATMlFodfLrQOXnL98/Cqu1Oi9adnDp
	 zsU26/aB5pAstIvlQ5hnbUVjJtmaXZAbFx+H8La4OeIQB4V3qIsPlrfrE+M/BCKuH0
	 a2d9kCvASb2Y7apbYRCCzbvueLuCt3wrfFWqYFoNiubDB6yisJy6Kkmk5Nk6sLQX7R
	 5aGTDEhVSiJ+A==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3E54389137;
 Sun, 20 Oct 2024 00:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729375426;
 bh=mnZb++x/VKVkxk8/wnfIyx35qsED4IRnv1UpCywXb84=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=vgrLMg8zNrf4z+iNylGQOg/QcZB4la7txAQQpu/8cwDWfl97YaiyY6PXPmfGoKrU5
 Z0HiDd2EK9FvtLwxGheN7F5/aparHDwbqN322NpHR0M37+a7LSBn4ie8neApQ+QCwC
 nutGTu5oPop55PGDlZ+zE7gnor7bU7KAbIZnkFSG4qHJ8p6YlFScBeXdDCqnu3NobX
 wMZOciyDHMlq1SzWQiYkcCu3Ywr94zFqUW++LJ/pXRWDxtF+kDaDvUR5jn+qXlOw/n
 O+p2A09HNgEYJ9K1EnEdOi/a1MwaMz8TjHBJQQIppPFysf4B6V0eI7gpIUzBXgxEv/
 QMiNqy3+5fV2g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 5/5] arm64: imx: Deduplicate DH i.MX6 DHSOM defconfig
Date: Sun, 20 Oct 2024 00:01:45 +0200
Message-ID: <20241019220322.341324-5-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241019220322.341324-1-marex@denx.de>
References: <20241019220322.341324-1-marex@denx.de>
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

Deduplicate defconfigs for all DH i.MX6 DHSOM by including common
configs/imx_dhsom_defconfig . This does introduce changes to the
board configuration, namely it enables commands used on all DHSOM
devices consistenty, the prompt is changed to u-boot=>, support for
booting non-Linux OS which was likely never used is disabled, GPT
partition table support is enabled, generic MTD support is enabled,
LED support is enabled, DM PHY, PMIC and regulator support is also
enabled, KASLR command is enabled.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 configs/dh_imx6_defconfig | 169 +++++++++++++-------------------------
 1 file changed, 58 insertions(+), 111 deletions(-)

diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index 27dab9e2e95..f435ecc8450 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -1,132 +1,79 @@
+#include <configs/imx_dhsom_defconfig>
+
 CONFIG_ARM=y
-CONFIG_SPL_SYS_L2_PL310=y
 CONFIG_ARCH_MX6=y
-CONFIG_TEXT_BASE=0x17800000
-CONFIG_SYS_MALLOC_F_LEN=0x1000
-CONFIG_SPL_GPIO=y
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=25000000
-CONFIG_ENV_SIZE=0x4000
-CONFIG_ENV_OFFSET=0x100000
-CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_MX6QDL=y
-CONFIG_MX6_DDRCAL=y
 CONFIG_TARGET_DHCOMIMX6=y
-CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6q-dhcom-pdk2"
+CONFIG_TEXT_BASE=0x17800000
 CONFIG_SPL_TEXT_BASE=0x00908000
+CONFIG_SPL_SYS_L2_PL310=y
+CONFIG_DEFAULT_DEVICE_TREE="imx6q-dhcom-pdk2"
+CONFIG_MX6_DDRCAL=y
+CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_SYS_MONITOR_LEN=409600
-CONFIG_SPL_MMC=y
-CONFIG_SPL_SERIAL=y
-CONFIG_BOOTCOUNT_BOOTLIMIT=3
-CONFIG_SYS_BOOTCOUNT_ADDR=0x020CC068
-CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
-CONFIG_SPL=y
-CONFIG_SYS_BOOTCOUNT_SINGLEWORD=y
-CONFIG_ENV_OFFSET_REDUND=0x110000
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
-CONFIG_SPL_SPI=y
-CONFIG_AHCI=y
-CONFIG_SYS_MEMTEST_START=0x10000000
-CONFIG_SYS_MEMTEST_END=0x20000000
-CONFIG_LTO=y
-CONFIG_FIT=y
+CONFIG_OF_LIST="imx6q-dhcom-pdk2 imx6dl-dhcom-pdk2 imx6s-dhcom-drc02 imx6dl-dhcom-picoitx"
 CONFIG_FIT_VERBOSE=y
-CONFIG_SPL_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
-CONFIG_BOOTDELAY=3
-CONFIG_SYS_PBSIZE=532
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_LTO=y
+
 CONFIG_SYS_CONSOLE_OVERWRITE_ROUTINE=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
-CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_I2C_MXC=y
+CONFIG_SYS_MALLOC_F_LEN=0x1000
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_MEMTEST=y
-CONFIG_CMD_UNZIP=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
+CONFIG_SYS_MEMTEST_END=0x20000000
+CONFIG_SYS_MEMTEST_START=0x10000000
+CONFIG_SYS_MONITOR_LEN=409600
+CONFIG_SYS_PBSIZE=532
+
+CONFIG_SYS_BOOTCOUNT_ADDR=0x020CC068
+CONFIG_SYS_BOOTCOUNT_BE=y
+CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTDELAY=3
+
+CONFIG_BZIP2=y
 CONFIG_CMD_SATA=y
-# CONFIG_CMD_SCSI is not set
-CONFIG_CMD_USB=y
-CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_UNZIP=y
 CONFIG_CMD_WDT=y
-CONFIG_CMD_DHCP6=y
-CONFIG_CMD_TFTPPUT=y
-CONFIG_CMD_WGET=y
-CONFIG_CMD_BOOTCOUNT=y
-CONFIG_CMD_CACHE=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_BTRFS=y
-CONFIG_CMD_EXT4_WRITE=y
-CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="imx6q-dhcom-pdk2 imx6dl-dhcom-pdk2 imx6s-dhcom-drc02 imx6dl-dhcom-picoitx"
-CONFIG_MULTI_DTB_FIT=y
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_USE_ETHPRIME=y
-CONFIG_ETHPRIME="FEC"
-CONFIG_VERSION_VARIABLE=y
-CONFIG_ARP_TIMEOUT=200
-CONFIG_IP_DEFRAG=y
-CONFIG_TFTP_TSIZE=y
-CONFIG_PROT_TCP_SACK=y
-CONFIG_IPV6=y
+CONFIG_DISTRO_DEFAULTS=y
+
+CONFIG_ENV_OFFSET=0x100000
+CONFIG_ENV_OFFSET_REDUND=0x110000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_ENV_SIZE=0x4000
+
+# CONFIG_CMD_SCSI is not set
+CONFIG_AHCI=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_DWC_AHSATA=y
 CONFIG_LBA48=y
-CONFIG_BOOTCOUNT_LIMIT=y
-CONFIG_SYS_BOOTCOUNT_BE=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
-CONFIG_DM_I2C=y
-CONFIG_SYS_I2C_MXC=y
-CONFIG_MISC=y
-CONFIG_I2C_EEPROM=y
-CONFIG_FSL_USDHC=y
-CONFIG_MTD=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SCSI=y
+
+CONFIG_ARP_TIMEOUT=200
+CONFIG_ETHPRIME="FEC"
+CONFIG_USE_ETHPRIME=y
+CONFIG_PHYLIB=y
+
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_SPI_FLASH_GIGADEVICE=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_WINBOND=y
-CONFIG_SPI_FLASH_MTD=y
-CONFIG_PHYLIB=y
-CONFIG_PHY_MICREL=y
-CONFIG_PHY_MICREL_KSZ90X1=y
-CONFIG_FEC_MXC=y
-CONFIG_MII=y
-CONFIG_PINCTRL=y
+CONFIG_SPI_FLASH_UNLOCK_ALL=y
+
+CONFIG_MISC=y
+
 CONFIG_PINCTRL_IMX6=y
-CONFIG_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SCSI=y
-CONFIG_DM_SERIAL=y
-CONFIG_MXC_UART=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_MXC_SPI=y
-CONFIG_SYSRESET=y
-CONFIG_SYSRESET_WATCHDOG=y
-CONFIG_USB=y
-CONFIG_SPL_USB_HOST=y
-CONFIG_USB_HOST_ETHER=y
-CONFIG_USB_ETHER_ASIX=y
-CONFIG_USB_GADGET=y
+
+CONFIG_SDP_LOADADDR=0x17ffffc0
+CONFIG_SPL_FIT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="dh"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0525
-CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_SPL_USB_HOST=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1000000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x11400
 CONFIG_CI_UDC=y
-CONFIG_SDP_LOADADDR=0x17ffffc0
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_SPL_USB_SDP_SUPPORT=y
-CONFIG_IMX_WATCHDOG=y
-CONFIG_BZIP2=y
+
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
-- 
2.45.2

