Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8C6D6EC00
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 11:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 724C788F20;
	Fri, 29 Nov 2024 12:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FQw348uo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF07D893C7; Fri, 29 Nov 2024 12:03:45 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AC6C893C7
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATB3gpk078709;
 Fri, 29 Nov 2024 05:03:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732878222;
 bh=sVELZdl+4uxasAIIays2syUQuPxfSJaoINfCuALgb+k=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FQw348uoNjSYR90s7l3Gnhb/7MJPVXAOioMAbcMAx/FAqjv8z679GKPiIUWhNqz6s
 veghLg7StcZs8h7t+cPVfPTGa9RmQwdbcuKNmY3uA3fI7tq570btnC5lnxTbxm1w2w
 QeJPm91O8BSgogQ7wd4FmPjeuMRxb2mrGYTjPpoY=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATB3gru016584
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 05:03:42 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:03:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:03:41 -0600
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.69.37])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATB3Xdi086529;
 Fri, 29 Nov 2024 05:03:39 -0600
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>,
 <j-choudhary@ti.com>, <b-padhi@ti.com>
CC: <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] configs: j7*: Enable TI_COMMON_CMD_OPTIONS
Date: Fri, 29 Nov 2024 16:33:33 +0530
Message-ID: <20241129110333.444270-3-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129110333.444270-1-n-francis@ti.com>
References: <20241129110333.444270-1-n-francis@ti.com>
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

Instead of bloating the defconfig with CONFIG_CMD_*, move J7 devices to
start using TI_COMMON_CMD_OPTIONS.

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 configs/j7200_evm_a72_defconfig  | 8 +-------
 configs/j721e_evm_a72_defconfig  | 8 +-------
 configs/j721s2_evm_a72_defconfig | 8 +-------
 configs/j722s_evm_a53_defconfig  | 8 +-------
 configs/j784s4_evm_a72_defconfig | 8 ++------
 5 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index eb6203f2b4c..6da09c06eab 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -64,21 +64,14 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x300000
 CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0,nor0=47034000.hyperbus"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),128k(ospi.env),128k(ospi.env.backup),1m(ospi.sysfw),-@8m(ospi.rootfs);47034000.hyperbus:512k(hbmc.tiboot3),2m(hbmc.tispl),4m(hbmc.u-boot),256k(hbmc.env),1m(hbmc.sysfw),-@8m(hbmc.rootfs)"
 CONFIG_CMD_UBI=y
@@ -207,3 +200,4 @@ CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_CADENCE_UFS=y
 CONFIG_TI_J721E_UFS=y
+CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index bd556349244..3f768c0af30 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -65,22 +65,15 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0,nor0=47034000.hyperbus"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),256k(ospi.env),1m(ospi.sysfw),256k(ospi.env.backup),57344k@8m(ospi.rootfs),256k(ospi.phypattern);47034000.hyperbus:512k(hbmc.tiboot3),2m(hbmc.tispl),4m(hbmc.u-boot),256k(hbmc.env),1m(hbmc.sysfw),-@8m(hbmc.rootfs)"
 CONFIG_CMD_UBI=y
@@ -213,5 +206,6 @@ CONFIG_UFS=y
 CONFIG_CADENCE_UFS=y
 CONFIG_TI_J721E_UFS=y
 CONFIG_EFI_SET_TIME=y
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 
 #include <configs/k3_efi_capsule.config>
diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
index 2a0ccfb581e..a2c39ae0ab6 100644
--- a/configs/j721s2_evm_a72_defconfig
+++ b/configs/j721s2_evm_a72_defconfig
@@ -62,20 +62,13 @@ CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT4_WRITE=y
 CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0,nor0=47034000.hyperbus"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),256k(ospi.env),256k(ospi.env.backup),57088k@8m(ospi.rootfs),256k(ospi.phypattern);47034000.hyperbus:512k(hbmc.tiboot3),2m(hbmc.tispl),4m(hbmc.u-boot),256k(hbmc.env),-@8m(hbmc.rootfs)"
 CONFIG_CMD_UBI=y
@@ -204,3 +197,4 @@ CONFIG_SPL_DFU=y
 CONFIG_UFS=y
 CONFIG_CADENCE_UFS=y
 CONFIG_TI_J721E_UFS=y
+CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/j722s_evm_a53_defconfig b/configs/j722s_evm_a53_defconfig
index 35329fb336b..81eb934ed6e 100644
--- a/configs/j722s_evm_a53_defconfig
+++ b/configs/j722s_evm_a53_defconfig
@@ -55,16 +55,9 @@ CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_REMOTEPROC=y
-CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_OF_CONTROL=y
@@ -170,3 +163,4 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x0451
 CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
 CONFIG_SPL_DFU=y
 CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+CONFIG_TI_COMMON_CMD_OPTIONS=y
diff --git a/configs/j784s4_evm_a72_defconfig b/configs/j784s4_evm_a72_defconfig
index c7fc6bedda3..49775dc9a5b 100644
--- a/configs/j784s4_evm_a72_defconfig
+++ b/configs/j784s4_evm_a72_defconfig
@@ -61,15 +61,10 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CMD_GPIO=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
@@ -164,5 +159,6 @@ CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
 CONFIG_DM_THERMAL=y
 CONFIG_EFI_SET_TIME=y
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 
 #include <configs/k3_efi_capsule.config>
-- 
2.34.1

