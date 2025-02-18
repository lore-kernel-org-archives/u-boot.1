Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB40C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:50:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2048480F42;
	Tue, 18 Feb 2025 10:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QcsqyxDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D17A80F32; Tue, 18 Feb 2025 10:50:09 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EEC80C98
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I9o4Al1521383
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Feb 2025 03:50:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739872204;
 bh=Zcr9G6YWzLbQpzoMRqA4rENOggG8vdcdE2KP6SarZiQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=QcsqyxDMbDcLXHHyjEZLp4E2rVEZ8Zoa6KUIVKkXI0ucnrFON0XPYHc/A4owBQtOo
 kiCHg5mjV1YQaQk3H78ksRcYbecvZkfE+KDSMaGYlsTzOHp9uVWOMM0TbJERChh+4M
 D5DZ8zGZrs2lSvW29sCkpkILZJnsT9pM2vuC+OIU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I9o4GI121483;
 Tue, 18 Feb 2025 03:50:04 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 03:50:03 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 03:50:04 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I9no5b064686; 
 Tue, 18 Feb 2025 03:49:59 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <j-choudhary@ti.com>,
 <n-francis@ti.com>, <m-chawdhry@ti.com>, <jm@ti.com>,
 <j-humphreys@ti.com>, <u-kumar1@ti.com>, <seanga2@gmail.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/2] configs: j784s4_evm_a72_defconfig: enable USB DFU boot,
 DFU flash and UMS
Date: Tue, 18 Feb 2025 15:19:45 +0530
Message-ID: <20250218094950.2542006-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218094950.2542006-1-s-vadapalli@ti.com>
References: <20250218094950.2542006-1-s-vadapalli@ti.com>
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

Enable support for USB DFU boot via USB0 instance of USB on J784S4 SoC
which is a Cadence USB Controller. Additionally, enable support for USB
DFU flash and USB Mass Storage (UMS) command. While at it, sync with
savedefconfig.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j784s4_evm_a72_defconfig | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index 1ac2430d7d..1ba2bfed2c 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -14,13 +15,13 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-j784s4-evm"
-CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x80a00000
 CONFIG_SPL_BSS_MAX_SIZE=0x80000
@@ -29,6 +30,7 @@ CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
+CONFIG_EFI_SET_TIME=y
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
 CONFIG_BOOTSTD_FULL=y
@@ -38,10 +40,8 @@ CONFIG_SPL_MAX_SIZE=0xc0000
 CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
-CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
-CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
@@ -49,7 +49,6 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
-CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
@@ -58,10 +57,9 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MTD=y
-CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
@@ -72,6 +70,7 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
@@ -81,6 +80,8 @@ CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
 CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
@@ -154,7 +155,20 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
-CONFIG_EFI_SET_TIME=y
-CONFIG_TI_COMMON_CMD_OPTIONS=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_CDNS3=y
+CONFIG_USB_CDNS3_GADGET=y
+CONFIG_USB_CDNS3_HOST=y
+CONFIG_SPL_USB_CDNS3_GADGET=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6168
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_SPL_DFU=y
 
 #include <configs/k3_efi_capsule.config>
-- 
2.43.0

