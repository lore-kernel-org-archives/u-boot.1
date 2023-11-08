Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3049CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE99F8749D;
	Wed,  8 Nov 2023 16:10:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="mBRg/2LL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3395871C3; Wed,  8 Nov 2023 15:53:30 +0100 (CET)
Received: from mta-65-228.siemens.flowmailer.net
 (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6C12871C7
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id
 20231108145326d891a6972b8a726539 for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=UhI2kJyNnGTgY1r7RQjoyDcZQxcHPHLOrKI+WDgeKGU=;
 b=mBRg/2LLC4RrX47XwUPmcuJpynewwN5x3tpDbTtd+bXefrY/Slr25kmlfk71FIUAAvrqnq
 nL+zKBN0aL8fL34Ie/XFGf9BczmMWFxgRu+g34L+AgXzb+LFieqI1SF6q2f6B2WtZmfGKqg4
 IN+FWXbBI1Emxfk5sz8kH60F9LrJw=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 2/6] configs: draco: remove spi flash support
Date: Wed,  8 Nov 2023 15:53:18 +0100
Message-Id: <20231108145322.302927-3-enrico.leto@siemens.com>
In-Reply-To: <20231108145322.302927-1-enrico.leto@siemens.com>
References: <20231108145322.302927-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320603:519-21489:flowmailer
X-Mailman-Approved-At: Wed, 08 Nov 2023 16:10:16 +0100
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

The SPI FLASH was set in the early development phase for evaluations.
Any target use it anymore.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 configs/draco-etamin_defconfig   | 6 ------
 configs/draco-rastaban_defconfig | 6 ------
 configs/draco-thuban_defconfig   | 6 ------
 3 files changed, 18 deletions(-)

diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index c0ce7a33569..3f9e91810ed 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -22,7 +22,6 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0xB80000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
@@ -45,9 +44,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
-CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 # CONFIG_SPL_AM33XX_ENABLE_RTC32K_OSC is not set
@@ -109,8 +105,6 @@ CONFIG_SYS_NAND_PAGE_SIZE=0x1000
 CONFIG_SYS_NAND_OOBSIZE=0xe0
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x200000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_FASTMAP_AUTOCONVERT=1
 CONFIG_PHY_SMSC=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 9f538a2f83d..994d0c81827 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -21,7 +21,6 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x2E0000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
@@ -44,9 +43,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
-CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 # CONFIG_SPL_AM33XX_ENABLE_RTC32K_OSC is not set
@@ -105,8 +101,6 @@ CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x80000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_FASTMAP_AUTOCONVERT=1
 CONFIG_PHY_SMSC=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 116700e0df0..4fd5865115d 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -21,7 +21,6 @@ CONFIG_SPL=y
 CONFIG_ENV_OFFSET_REDUND=0x2E0000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
-CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_SYS_LOAD_ADDR=0x81000000
 CONFIG_ENV_VARS_UBOOT_CONFIG=y
@@ -44,9 +43,6 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
 CONFIG_SPL_NAND_BASE=y
-CONFIG_SPL_DM_SPI_FLASH=y
-CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_SPL_WATCHDOG=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 # CONFIG_SPL_AM33XX_ENABLE_RTC32K_OSC is not set
@@ -105,8 +101,6 @@ CONFIG_SYS_NAND_PAGE_SIZE=0x800
 CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_U_BOOT_LOCATIONS=y
 CONFIG_SYS_NAND_U_BOOT_OFFS=0x80000
-CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_FASTMAP_AUTOCONVERT=1
 CONFIG_PHY_SMSC=y
-- 
2.30.2

