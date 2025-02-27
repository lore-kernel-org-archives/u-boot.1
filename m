Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84A6C19F2E
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12F0810ED;
	Thu, 27 Feb 2025 13:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nW8W809B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27ACB80FF4; Thu, 27 Feb 2025 12:55:06 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07028801FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 12:55:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51RBt03p2334369
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 05:55:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740657300;
 bh=N+mNoJVC0eebTCNJJiFInaPM3cZ3w3phAXTDyvVrAQE=;
 h=From:To:CC:Subject:Date;
 b=nW8W809BpReiF9LkZAwJfOl2+gvdpWtMA3Lwqgsz/fRqCH8JsGKS0ulOmw9d4fiol
 dEKdVpcqS9ZS9+Gr+vwoqnLIq/W/d/HMn/GorPtYjo5QuJanruFJz5fa//9JpwiN/L
 E/vJqFRc0LB2AvlCXIiiitxT6agfqJg/LGxCNAbE=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51RBt02J118031
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Feb 2025 05:55:00 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 05:55:00 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 05:55:00 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com [172.24.227.4])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51RBsuRI021530;
 Thu, 27 Feb 2025 05:54:57 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>, <s-k6@ti.com>, <kamlesh@ti.com>, 
 <a-shenai@ti.com>
CC: <u-boot@lists.denx.de>, <s-vadapalli@ti.com>, <h-salunke@ti.com>,
 <danishanwar@ti.com>, <srk@ti.com>
Subject: [PATCH v2] configs: am65x_evm_r5_usbdfu_defconfig: Fix USB DFU boot
Date: Thu, 27 Feb 2025 17:24:56 +0530
Message-ID: <20250227115456.283663-1-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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
This patch is based on following commit in master branch
57bbc4de75f Merge tag 'qcom-fixes-2025.04-rc4' of https://source.denx.de/u-boot/custodians/u-boot-snapdragon

Changes since v1
Instead of directly adding required configs to "am65x_evm_r5_usbdfu_defconfig",
updated it to include "am65x_evm_r5_defconfig".

 configs/am65x_evm_r5_usbdfu_defconfig | 125 +++++++-------------------
 1 file changed, 34 insertions(+), 91 deletions(-)

diff --git a/configs/am65x_evm_r5_usbdfu_defconfig b/configs/am65x_evm_r5_usbdfu_defconfig
index 0b5eaeb363d..b0d333d95c2 100644
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
@@ -13,106 +15,17 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41c7effc
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
-CONFIG_SPL_REMOTEPROC=y
-CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_HUSH_PARSER=y
-CONFIG_CMD_BOOTZ=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_REMOTEPROC=y
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
-CONFIG_REMOTEPROC_TI_K3_ARM64=y
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
@@ -129,4 +42,34 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
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

