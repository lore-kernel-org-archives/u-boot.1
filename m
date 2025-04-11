Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D09C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 22:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCCE684176;
	Sat, 12 Apr 2025 00:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R55ZoR9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D3E82A0D; Sat, 12 Apr 2025 00:57:28 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54DDC84212
 for <u-boot@lists.denx.de>; Sat, 12 Apr 2025 00:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BMvJC82198851
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 17:57:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744412239;
 bh=+gSVlGUxZmgPAczacb5eoy2LrX/h1egT+6gtc6Nx4RU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=R55ZoR9kqhuJJTg+aDJiHNWnOWwIfvgKlMdDNRuI/PEKQM/P9TDNH6qoiwDL/8pFl
 Fo8G4icZnfk3h2oWtt4LoBugY329qhqeY/N/TzENVxyl4vPLDJRhL8D1G7PcpLy5OM
 m5Qyh46HtiKj++HuaNpEq8FIaPNfmYx/4QyW7bEM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BMvJIJ065061
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 17:57:19 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 17:57:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 17:57:18 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BMvIUW092363;
 Fri, 11 Apr 2025 17:57:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 7/9] configs:am67a_beagley_ai*: Drop un-necessary config
 options
Date: Fri, 11 Apr 2025 17:57:15 -0500
Message-ID: <20250411225717.3117370-8-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250411225717.3117370-1-nm@ti.com>
References: <20250411225717.3117370-1-nm@ti.com>
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

Drop SPI, EMMC, GPIO expanders that come with EVM etc.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 configs/am67a_beagley_ai_a53_defconfig |  8 --------
 configs/am67a_beagley_ai_r5_defconfig  | 23 -----------------------
 2 files changed, 31 deletions(-)

diff --git a/configs/am67a_beagley_ai_a53_defconfig b/configs/am67a_beagley_ai_a53_defconfig
index 295ff1740b78..cbf19a03b136 100644
--- a/configs/am67a_beagley_ai_a53_defconfig
+++ b/configs/am67a_beagley_ai_a53_defconfig
@@ -11,7 +11,6 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am67a-beagley-ai"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
@@ -50,7 +49,6 @@ CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
-# CONFIG_CMD_SPI is not set
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
@@ -81,8 +79,6 @@ CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
 CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_DA8XX_GPIO=y
-CONFIG_DM_PCA953X=y
-CONFIG_SPL_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
@@ -90,11 +86,8 @@ CONFIG_K3_SEC_PROXY=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_FS_LOADER=y
-CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
-CONFIG_MMC_HS400_SUPPORT=y
-CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
@@ -118,7 +111,6 @@ CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
 CONFIG_SOC_TI=y
-CONFIG_SPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
diff --git a/configs/am67a_beagley_ai_r5_defconfig b/configs/am67a_beagley_ai_r5_defconfig
index 35c77e57e104..0a7e1c84c4a8 100644
--- a/configs/am67a_beagley_ai_r5_defconfig
+++ b/configs/am67a_beagley_ai_r5_defconfig
@@ -8,10 +8,7 @@ CONFIG_K3_QOS=y
 CONFIG_TARGET_J722S_R5_BEAGLEY_AI=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c4a7f0
-CONFIG_SF_DEFAULT_SPEED=25000000
-CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x20000
-CONFIG_ENV_OFFSET=0x680000
 CONFIG_SPL_DM_SPI=y
 CONFIG_DEFAULT_DEVICE_TREE="k3-am67a-r5-beagley-ai"
 CONFIG_DM_RESET=y
@@ -49,10 +46,6 @@ CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_DM_RESET=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_DEVICE=y
-# CONFIG_SPL_SPI_FLASH_TINY is not set
-CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
@@ -65,10 +58,7 @@ CONFIG_CMD_TIME=y
 CONFIG_CMD_FAT=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_ENV_IS_NOWHERE=y
-CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_NO_NET=y
 CONFIG_SPL_DM=y
 CONFIG_SPL_DM_DEVICE_REMOVE=y
@@ -90,20 +80,10 @@ CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_ESM_K3=y
-CONFIG_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
-CONFIG_MTD=y
-CONFIG_DM_MTD=y
-CONFIG_MTD_SPI_NAND=y
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_SFDP_SUPPORT=y
-CONFIG_SPI_FLASH_SOFT_RESET=y
-CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
-CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
@@ -118,9 +98,6 @@ CONFIG_DM_SERIAL=y
 CONFIG_SOC_DEVICE=y
 CONFIG_SOC_DEVICE_TI_K3=y
 CONFIG_SOC_TI=y
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_CADENCE_QSPI=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
-- 
2.47.0

