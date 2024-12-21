Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CADE77188
	for <u-boot@archiver.kernel.org>; Sat, 21 Dec 2024 02:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4955380423;
	Sat, 21 Dec 2024 03:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lxcJ4sRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199FC803CB; Sat, 21 Dec 2024 03:53:12 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CFA80562
 for <u-boot@lists.denx.de>; Sat, 21 Dec 2024 03:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BL2qoLd250365
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Dec 2024 20:52:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734749570;
 bh=sh0j29jttSLCo4j8WjWI5jr1Hb+5B94SyC5RmirNToM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lxcJ4sRiR7WYUMuBJCHQurrd/OUTY8BqrIlgx+j15cAG04PNKdsN0lOZm8Y7/rgaN
 ItpkcO29xW3hNh+63Nc+vnLNjGaTo/5WtqIr0LRjz2ZI57xTZlLz/KnW2XUqMU3LcF
 fRCC67nD40aKFECA3vk4ZIDlNvFqX+NZYcMuIsCw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BL2qom7040387
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Dec 2024 20:52:50 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Dec 2024 20:52:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Dec 2024 20:52:50 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BL2qTBv084516;
 Fri, 20 Dec 2024 20:52:45 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <vigneshr@ti.com>, <bb@ti.com>, <trini@konsulko.com>, <lukma@denx.de>,
 <n-francis@ti.com>, <mkorpershoek@baylibre.com>, <afd@ti.com>,
 <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v3 3/3] configs: am62px_evm_a53_defconfig: enable USB DFU
 support
Date: Sat, 21 Dec 2024 08:22:23 +0530
Message-ID: <20241221025229.361625-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241221025229.361625-1-s-vadapalli@ti.com>
References: <20241221025229.361625-1-s-vadapalli@ti.com>
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

The config fragment "am62x_a53_usbdfu.config" which adds USB DFU support
for AM62x SoC is applicable to the AM62Px SoC as well. Hence, include it
in "am62px_evm_a53_defconfig" in order to enable support for USB DFU
flash and boot. Remove those configs from "am62px_evm_a53_defconfig" which
are present in the "am62x_a53_usbdfu.config" config fragment that is being
included.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
v2:
https://patchwork.ozlabs.org/project/uboot/patch/20241218124542.3519447-4-s-vadapalli@ti.com/
Changes since v2:
- Collected Reviwed-by tags.

This patch was first introduced in the v2 series itself and hence it
doesn't have a v1.

 configs/am62px_evm_a53_defconfig | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 9635beb1b27..9862b1f9a16 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -41,14 +41,11 @@ CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
 CONFIG_SPL_DMA=y
-CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_POWER_DOMAIN=y
-CONFIG_SPL_RAM_SUPPORT=y
-CONFIG_SPL_RAM_DEVICE=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
@@ -58,14 +55,12 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_CLK=y
-CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_REMOTEPROC=y
-CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_TIME=y
@@ -85,17 +80,12 @@ CONFIG_SPL_DM_DEVICE_REMOVE=y
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
-CONFIG_SPL_SYSCON=y
 CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_CLK=y
 CONFIG_SPL_CLK=y
 CONFIG_CLK_TI_SCI=y
-CONFIG_DFU_MMC=y
 CONFIG_DFU_MTD=y
-CONFIG_DFU_RAM=y
 CONFIG_DFU_SF=y
-CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
-CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
@@ -164,22 +154,10 @@ CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
-CONFIG_USB=y
-CONFIG_DM_USB_GADGET=y
-CONFIG_SPL_DM_USB_GADGET=y
 CONFIG_SPL_USB_HOST=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_DWC3=y
-CONFIG_USB_DWC3_GENERIC=y
-CONFIG_SPL_USB_DWC3_GENERIC=y
 CONFIG_SPL_USB_STORAGE=y
-CONFIG_USB_GADGET=y
-CONFIG_SPL_USB_GADGET=y
-CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
-CONFIG_USB_GADGET_VENDOR_NUM=0x0451
-CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
-CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_EFI_SET_TIME=y
 
 #include <configs/k3_efi_capsule.config>
+#include <configs/am62x_a53_usbdfu.config>
-- 
2.43.0

