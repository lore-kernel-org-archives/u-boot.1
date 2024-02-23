Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29C8C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 11:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 569AC8772A;
	Fri, 23 Feb 2024 12:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="STvXr6R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA98B87C35; Fri, 23 Feb 2024 06:25:04 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95930800A5
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 06:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41N5OuXY043238;
 Thu, 22 Feb 2024 23:24:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708665896;
 bh=PRYD93T/8Ie5TrFZBJfUH9bkwoIIQbNctD0W4pgE+g8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=STvXr6R+oe8d8kPs3j+DZWJ5xn8gxH7Be4MuQoNLe4a27aXF1X39iiu1f9hu5v94n
 d2S0Qq00Fq1TwI+SIMAEKR/McDngYtEpIm48cgqhMW8hfn5Ohu27U1AX1or4qXqJo1
 O4lqrianaSPPAgaz2htTP+xXrZvBQY6wajUvSwVE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41N5OuKT104317
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 22 Feb 2024 23:24:56 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 Feb 2024 23:24:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 Feb 2024 23:24:56 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41N5OuLa035184;
 Thu, 22 Feb 2024 23:24:56 -0600
From: Jonathan Humphreys <j-humphreys@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH 1/2] configs: am64x_evm_*_defconfig: Enable OSPI support
Date: Thu, 22 Feb 2024 23:24:37 -0600
Message-ID: <20240223052438.2013610-2-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223052438.2013610-1-j-humphreys@ti.com>
References: <20240223052438.2013610-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 12:56:24 +0100
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

Add configs to support OSPI flash.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 configs/am64x_evm_a53_defconfig | 14 ++++++++++++--
 configs/am64x_evm_r5_defconfig  | 14 ++++++++++++--
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index 6711e691ca..27aa78a533 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -12,6 +12,7 @@ CONFIG_K3_ATF_LOAD_ADDR=0x701c0000
 CONFIG_TARGET_AM642_A53_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
@@ -57,8 +58,11 @@ CONFIG_SPL_NET_VCI_STRING="AM64X U-Boot A53 SPL"
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x300000
+CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_CMD_ASKENV=y
@@ -109,8 +113,13 @@ CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_S28HX_T=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
@@ -142,6 +151,7 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
+CONFIG_DM_THERMAL=y
 CONFIG_USB=y
 CONFIG_DM_USB_GADGET=y
 CONFIG_SPL_DM_USB_GADGET=y
diff --git a/configs/am64x_evm_r5_defconfig b/configs/am64x_evm_r5_defconfig
index 56df6a4a19..199c7c9a9d 100644
--- a/configs/am64x_evm_r5_defconfig
+++ b/configs/am64x_evm_r5_defconfig
@@ -10,6 +10,7 @@ CONFIG_SOC_K3_AM642=y
 CONFIG_TARGET_AM642_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x7019b800
+CONFIG_SF_DEFAULT_SPEED=25000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
@@ -63,8 +64,11 @@ CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_RAM_SUPPORT=y
 CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_REMOTEPROC=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
+CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
@@ -117,8 +121,11 @@ CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_SPANSION=y
-CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_TI_AM65_CPSW_NUSS=y
 CONFIG_PHY=y
@@ -142,6 +149,8 @@ CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
 CONFIG_SOC_TI=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
@@ -149,6 +158,7 @@ CONFIG_CADENCE_QSPI=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
+CONFIG_DM_THERMAL=y
 CONFIG_TIMER=y
 CONFIG_SPL_TIMER=y
 CONFIG_OMAP_TIMER=y
-- 
2.34.1

