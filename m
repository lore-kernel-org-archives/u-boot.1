Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4182DC369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 17:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB81830B5;
	Tue,  8 Apr 2025 19:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iajPMp8Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB6E830B5; Tue,  8 Apr 2025 19:05:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E1BE82C44
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 19:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538H5S1F1268899
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 12:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744131928;
 bh=17jj8PZuTo3M/gPrCZeD9895gFL5axdDBfztilOWZjA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iajPMp8ZTTssvLtf8R1otoqh7HTjnoNWRfJ8FPg/bK9tRXntbTM0mN14xFZxCX19w
 J8V14rtr4h9jDRfXF1ZCCB9/fuliXjqnSZGv7WoCcI6ZbHU840pkCba5JtU28bQJUb
 gZ6QF66yAGtu1R5mKCHbtsIvwkEZ2X5qK5GXPGHo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538H5SLk112767
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 12:05:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 12:05:27 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 12:05:27 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538H5RjR105590;
 Tue, 8 Apr 2025 12:05:27 -0500
From: Judith Mendez <jm@ti.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 5/5] configs: am62*_evm_a53_defconfig: Add
 TI_COMMON_CMD_OPTIONS
Date: Tue, 8 Apr 2025 12:05:27 -0500
Message-ID: <20250408170527.2832563-6-jm@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408170527.2832563-1-jm@ti.com>
References: <20250408170527.2832563-1-jm@ti.com>
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

Add TI_COMMON_CMD_OPTIONS config options to Sitara K3 boards at
a53 stage since we rely on most of the commands implied for testing
and debugging purposes. Since all commands are now enabled by
default, remove the redundant CMD_* options in the a53 defconfigs.

Also add MMC_REG & MMC_SPEED_MODE_SET useful commands to
TI_COMMON_CMD_OPTIONS.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 board/ti/common/Kconfig          |  2 ++
 configs/am62ax_evm_a53_defconfig |  3 +--
 configs/am62px_evm_a53_defconfig |  9 +--------
 configs/am62x_evm_a53_defconfig  |  3 +--
 configs/am64x_evm_a53_defconfig  | 11 +----------
 configs/am65x_evm_a53_defconfig  |  9 +--------
 6 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
index c03aa3a368f..b5978acdded 100644
--- a/board/ti/common/Kconfig
+++ b/board/ti/common/Kconfig
@@ -41,6 +41,8 @@ config TI_COMMON_CMD_OPTIONS
 	imply CMD_I2C
 	imply CMD_MII
 	imply CMD_MMC
+	imply CMD_MMC_REG
+	imply MMC_SPEED_MODE_SET
 	imply CMD_NFS
 	imply CMD_PART
 	imply CMD_PING
diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index bf6e9639901..de88fd72323 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -39,8 +40,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_MAILBOX=y
 CONFIG_SPL_POWER_DOMAIN=y
 CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_CMD_MMC=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_REMOTEPROC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index 70dbb65d9f8..48bb599d607 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -58,20 +59,12 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
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
 CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 6527200259e..b6e87866649 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -1,6 +1,7 @@
 CONFIG_ARM=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -54,9 +55,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_EFIDEBUG=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index a501f3f567e..f772e53caac 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -3,6 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
@@ -64,18 +65,8 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x300000
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
-CONFIG_CMD_ASKENV=y
 CONFIG_CMD_NVEDIT_EFI=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_CMD_USB=y
 CONFIG_CMD_EFIDEBUG=y
-CONFIG_CMD_TIME=y
-CONFIG_CMD_PMIC=y
-CONFIG_CMD_REGULATOR=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index e9b736714a5..bc94492cefe 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -3,6 +3,7 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_ARCH_K3=y
 CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_SOC_K3_AM654=y
@@ -59,16 +60,8 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
-CONFIG_CMD_ASKENV=y
-CONFIG_CMD_DFU=y
-CONFIG_CMD_GPT=y
-CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
-CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_REMOTEPROC=y
-CONFIG_CMD_USB=y
-CONFIG_CMD_TIME=y
 CONFIG_MTDIDS_DEFAULT="nor0=47040000.spi.0"
 CONFIG_MTDPARTS_DEFAULT="mtdparts=47040000.spi.0:512k(ospi.tiboot3),2m(ospi.tispl),4m(ospi.u-boot),128k(ospi.env),128k(ospi.env.backup),1m(ospi.sysfw),-@8m(ospi.rootfs)"
 CONFIG_CMD_UBI=y
-- 
2.49.0

