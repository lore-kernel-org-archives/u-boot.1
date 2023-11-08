Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C5DC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 15:10:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BD9871C1;
	Wed,  8 Nov 2023 16:10:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=siemens.com header.i=enrico.leto@siemens.com header.b="TeGVQ5Tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D5838722B; Wed,  8 Nov 2023 15:53:30 +0100 (CET)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC46A871C3
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 15:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=enrico.leto@siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 20231108145326e5fa67761e1cefbd68 for <u-boot@lists.denx.de>;
 Wed, 08 Nov 2023 15:53:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=enrico.leto@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=11YZJ0zQm7YzP9s6xRue7d/03LLi0CAZsIoX1Lq0We8=;
 b=TeGVQ5TxTjf9KM3hQqf244t/09HjWqmI4zTfB3U5FC9a+kxJF0y6nSsQT15IREglzqi4nq
 IaG+CEFgRX2tjQkmTHNoPqsyhr8aIgT/q16rlCtodPXLITRWrOavVwCTv2f80aHBxUZG/xGn
 Vgtp59vquCKR7RxNJ7QUExtwyq+SU=;
From: Enrico Leto <enrico.leto@siemens.com>
To: u-boot@lists.denx.de
Cc: Enrico Leto <enrico.leto@siemens.com>
Subject: [PATCH 3/6] configs: thuban, rastaban: remove emmc
Date: Wed,  8 Nov 2023 15:53:19 +0100
Message-Id: <20231108145322.302927-4-enrico.leto@siemens.com>
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

These targets use NAND FLASH only. Maybe some MMC definitions were added by
trying MMC for the etamin target evaluation and were not removed.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
---
 configs/draco-rastaban_defconfig | 6 ++----
 configs/draco-thuban_defconfig   | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 994d0c81827..218177b6d97 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -14,7 +14,6 @@ CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
 CONFIG_SYS_MPUCLK=300
 CONFIG_TARGET_RASTABAN=y
-CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_SPL=y
@@ -39,6 +38,7 @@ CONFIG_SPL_BSS_START_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
+# CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
@@ -55,7 +55,6 @@ CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
@@ -90,8 +89,7 @@ CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_I2C_LEGACY=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
-# CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_OMAP_HS=y
+# CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 4fd5865115d..80841135229 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -14,7 +14,6 @@ CONFIG_DEFAULT_DEVICE_TREE="am335x-draco"
 CONFIG_AM33XX=y
 CONFIG_SYS_MPUCLK=300
 CONFIG_TARGET_THUBAN=y
-CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_BOOTCOUNT_BOOTLIMIT=3
 CONFIG_SPL=y
@@ -39,6 +38,7 @@ CONFIG_SPL_BSS_START_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80208000
+# CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_NAND_DRIVERS=y
 CONFIG_SPL_NAND_ECC=y
@@ -55,7 +55,6 @@ CONFIG_CMD_DFU=y
 # CONFIG_CMD_FLASH is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
-CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
@@ -90,8 +89,7 @@ CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_SYS_I2C_LEGACY=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
-# CONFIG_SPL_DM_MMC is not set
-CONFIG_MMC_OMAP_HS=y
+# CONFIG_MMC is not set
 CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_NAND_BLOCK_SIZE=0x20000
-- 
2.30.2

