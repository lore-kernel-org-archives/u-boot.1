Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E506C83F17
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 17:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B24B83653;
	Thu, 10 Jul 2025 19:11:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Op9W5SG2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46B083666; Thu, 10 Jul 2025 19:11:40 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71FDE8362C
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 19:11:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56AHBZEb1564473;
 Thu, 10 Jul 2025 12:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752167495;
 bh=BAq837PabSCtuCfSMAEuMI9hM/IlRLnKBFsk+BfVgyg=;
 h=From:To:CC:Subject:Date;
 b=Op9W5SG2DeBpGxtf91+pFaj6TOEZ6hjJ2AcOk7JnJZ1Z/LZZkgYoYZZoiUdFRjGSJ
 UYHXPhrjG1u5XJpsfEa9+56bPkhk8GV0VQ2ap+pjFW+BLwYnMPBRFbw7t1cqwFDKCq
 SPniGcvylCjSkv5cIyIrb0dFD5EtSHGjhzjyCVGU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56AHBZ9T362433
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 10 Jul 2025 12:11:35 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 10
 Jul 2025 12:11:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 10 Jul 2025 12:11:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56AHBZbN1724734;
 Thu, 10 Jul 2025 12:11:35 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>, Andrew Davis
 <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, <u-boot@lists.denx.de>
Subject: [PATCH] mach-k3: am62*: am62*_init: Prohibit boot from UDA w/ eMMC
 boot
Date: Thu, 10 Jul 2025 12:11:34 -0500
Message-ID: <20250710171135.669838-1-jm@ti.com>
X-Mailer: git-send-email 2.49.0
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

This removes support from booting from UDA when in eMMC boot.

When user selects eMMC boot [0], that is, boot from eMMC boot0 or
boot1 HW partitions, we should not boot from eMMC UDA. The current
logic confuses the end user and mixes two different boot modes.

The logic was added for AM62A/AM62P with commit: 3b7893145e36, but
this is not a clean solution and fix will come later for falcon boot.

Logic was also added for AM62X with commit: 664593464634, but this
logic is incorrect according to TRM [0] under Primary Boot Mode Selection
for 'eMMC Boot'.

Fixes: 3b7893145e36 ("mach-k3: add eMMC FS boot support for am62[ap]")
Fixes: 664593464634 ("arm: mach-k3: am625: Relax emmc boot condition")
Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 4 ----
 arch/arm/mach-k3/am62px/am62p5_init.c | 4 ----
 arch/arm/mach-k3/am62x/am625_init.c   | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index edd43a1d78d..1d8644bd073 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -217,10 +217,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
-			return MMCSD_MODE_EMMCBOOT;
-		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
-			return MMCSD_MODE_FS;
 		return MMCSD_MODE_EMMCBOOT;
 	case BOOT_DEVICE_MMC:
 		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 6e3c66e5107..01e47deca94 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -262,10 +262,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
-			return MMCSD_MODE_EMMCBOOT;
-		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
-			return MMCSD_MODE_FS;
 		return MMCSD_MODE_EMMCBOOT;
 	case BOOT_DEVICE_MMC:
 		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index a422919fab1..eb7e245843c 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -316,10 +316,6 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
-			return MMCSD_MODE_EMMCBOOT;
-		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
-			return MMCSD_MODE_FS;
 		return MMCSD_MODE_EMMCBOOT;
 	case BOOT_DEVICE_MMC:
 		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
-- 
2.49.0

