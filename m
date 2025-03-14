Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68E1C28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 06:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6046817D3;
	Fri, 14 Mar 2025 07:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WH28aEhh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A39B2817D8; Fri, 14 Mar 2025 07:31:23 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1DB581760
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:31:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6VHiW2090298
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 14 Mar 2025 01:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741933877;
 bh=iPwpwspBB4HszT4dnJ+YZ/LE2AEwY7FkoEUrcqES/qQ=;
 h=From:To:CC:Subject:Date;
 b=WH28aEhhdxRqxjEWbrByZ4zPZfPXpD6CHg29rwQsO0zGLvJSMytNsm0a5JMXfrlsH
 FowEAhEDxjuVBCgKyT/o/uaCgAelCB5DoO11iwsiWPkBh3KhzySq+wIe1Pthv1zzE4
 lqqbqBYoY9qdwP0MUqWeCz7udfCnvTE1q293mLpg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E6VHkR022903
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Mar 2025 01:31:17 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Mar 2025 01:31:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Mar 2025 01:31:17 -0500
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E6VDDM069752;
 Fri, 14 Mar 2025 01:31:14 -0500
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <jm@ti.com>, <afd@ti.com>, <a-shenai@ti.com>,
 <kamlesh@ti.com>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>, <h-salunke@ti.com>,
 <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU boot
Date: Fri, 14 Mar 2025 12:01:13 +0530
Message-ID: <20250314063113.1095793-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
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

Increase the size of malloc region allocated before relocation, as
current size is insufficient for DFU boot causing it to overflow and
corrupt the stack.

Fixed regulator configs are required by vtt_supply which is used by
"am654_ddrss" driver. Without it during DFU boot DDRSS initialization
is failing. These configs are enabled in "am65x_evm_r5_defconfig" but
are missing from "am65x_evm_r5_usbdfu_defconfig". Fix that by updating
"am65x_evm_r5_usbdfu_defconfig" to include "am65x_evm_r5_defconfig".

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
This patch is based on following commit in next branch
9805321dfde (origin/next) Kconfig: Introduce CONFIG_WERROR

Changes since v2 : Rebased on top of current next

 configs/am65x_evm_r5_usbdfu_defconfig | 122 +++++++-------------------
 1 file changed, 34 insertions(+), 88 deletions(-)

diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index 227de53795b..b0d333d95c2 100644
--- a/configs/am65x_evm_r5_usbdfu_defconfig
+++ b/configs/am65x_evm_r5_usbdfu_defconfig
@@ -1,7 +1,9 @@
+#include<configs/am65x_evm_r5_defconfig>
+
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
-CONFIG_SYS_MALLOC_F_LEN=0x55000
+CONFIG_SYS_MALLOC_F_LEN=0x57000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -13,103 +15,17 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c7effc
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am654-r5-base-board"
-CONFIG_DM_RESET=y
-CONFIG_SPL_SERIAL=y
-CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
-CONFIG_SPL_TEXT_BASE=0x41c00000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x41c7effc
-CONFIG_SPL_BSS_MAX_SIZE=0xc00
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_SIZE_LIMIT=0x7ec00
-CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x2000
-CONFIG_SPL_LIBDISK_SUPPORT=y
-# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
-CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
-CONFIG_USE_BOOTCOMMAND=y
-# CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
-CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
-CONFIG_SPL_MAX_SIZE=0x58000
-CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
-CONFIG_SPL_SEPARATE_BSS=y
-CONFIG_SPL_SYS_MALLOC=y
-CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
-CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
-CONFIG_SPL_SYS_MALLOC_SIZE=0x1000000
-CONFIG_SPL_EARLY_BSS=y
-CONFIG_SPL_DMA=y
 CONFIG_SPL_ENV_SUPPORT=y
-CONFIG_SPL_I2C=y
-CONFIG_SPL_DM_MAILBOX=y
-CONFIG_SPL_DM_RESET=y
-CONFIG_SPL_POWER_DOMAIN=y
-CONFIG_SPL_RAM_DEVICE=y
-CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-# CONFIG_CMD_SETEXPR is not set
-CONFIG_CMD_TIME=y
-CONFIG_CMD_FAT=y
-CONFIG_OF_CONTROL=y
-CONFIG_SPL_OF_CONTROL=y
-CONFIG_SPL_MULTI_DTB_FIT=y
-CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
-CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SPL_DM=y
-CONFIG_SPL_DM_SEQ_ALIAS=y
-CONFIG_REGMAP=y
-CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
-CONFIG_SPL_OF_TRANSLATE=y
-CONFIG_CLK=y
-CONFIG_SPL_CLK=y
-CONFIG_CLK_TI_SCI=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
-CONFIG_TI_SCI_PROTOCOL=y
-CONFIG_DA8XX_GPIO=y
-CONFIG_DM_I2C=y
-CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
-CONFIG_SYS_I2C_OMAP24XX=y
-CONFIG_DM_MAILBOX=y
-CONFIG_K3_SEC_PROXY=y
 CONFIG_MISC=y
-CONFIG_K3_AVS0=y
-# CONFIG_MMC is not set
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_OMAP_USB2_PHY=y
-CONFIG_PINCTRL=y
-# CONFIG_PINCTRL_GENERIC is not set
-CONFIG_SPL_PINCTRL=y
-# CONFIG_SPL_PINCTRL_GENERIC is not set
-CONFIG_PINCTRL_SINGLE=y
-CONFIG_POWER_DOMAIN=y
-CONFIG_TI_SCI_POWER_DOMAIN=y
-CONFIG_DM_REGULATOR=y
-CONFIG_SPL_DM_REGULATOR=y
-CONFIG_DM_REGULATOR_GPIO=y
-CONFIG_SPL_DM_REGULATOR_GPIO=y
-CONFIG_DM_REGULATOR_TPS62360=y
-CONFIG_RAM=y
-CONFIG_SPL_RAM=y
-CONFIG_K3_SYSTEM_CONTROLLER=y
-CONFIG_RESET_TI_SCI=y
-CONFIG_DM_SERIAL=y
-CONFIG_SYSRESET=y
-CONFIG_SPL_SYSRESET=y
-CONFIG_SYSRESET_TI_SCI=y
-CONFIG_TIMER=y
-CONFIG_SPL_TIMER=y
-CONFIG_OMAP_TIMER=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
@@ -126,4 +42,34 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6162
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_SPL_DFU=y
-CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_MMC=n
+CONFIG_SPL_DM_SPI=n
+CONFIG_SPL_MMC=n
+CONFIG_SPL_FS_FAT=n
+CONFIG_SPL_SPI_FLASH_SUPPORT=n
+CONFIG_SPL_SPI=n
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=n
+CONFIG_SPL_DM_SPI_FLASH=n
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPL_SPI_LOAD=n
+CONFIG_CMD_MMC=n
+CONFIG_ENV_OVERWRITE=n
+CONFIG_ENV_IS_IN_FAT=n
+CONFIG_DMA_CHANNELS=n
+CONFIG_TI_K3_NAVSS_UDMA=n
+CONFIG_SUPPORT_EMMC_BOOT=n
+CONFIG_MMC_HS200_SUPPORT=n
+CONFIG_SPL_MMC_HS200_SUPPORT=n
+CONFIG_MMC_SDHCI=n
+CONFIG_SPL_MMC_SDHCI_ADMA=n
+CONFIG_MMC_SDHCI_AM654=n
+CONFIG_MTD=n
+CONFIG_DM_SPI_FLASH=n
+CONFIG_SPI_FLASH_SFDP_SUPPORT=n
+CONFIG_SPI_FLASH_STMICRO=n
+CONFIG_SOC_DEVICE=n
+CONFIG_SOC_DEVICE_TI_K3=n
+CONFIG_SOC_TI=n
+CONFIG_SPI=n
+CONFIG_DM_SPI=n
+CONFIG_CADENCE_QSPI=n
-- 
2.34.1

