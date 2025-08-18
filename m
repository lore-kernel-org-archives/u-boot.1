Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D720CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 17:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067C5801BE;
	Mon, 18 Aug 2025 19:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NBCMJIWZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB4DE801DD; Mon, 18 Aug 2025 19:40:20 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09DA080107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 19:40:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57IHeF992709610;
 Mon, 18 Aug 2025 12:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755538815;
 bh=S1my8GElPuIT2zKPLIZwcAzhRUJjKCws8GGEHr7Syjk=;
 h=From:To:CC:Subject:Date;
 b=NBCMJIWZW2Yeh6KufdECcpk2j7h05zjngKmNVyLbRxBVfzE0ehBiMf9SPOwdD8DgK
 R2wnBk28pyre6r3aJgkxPWmJ0xuPjha65XBdfSq4Fa8nDHrjTVgEP1TjlayP072pOK
 DJULDJ0mbl7Zr4MSUg56oSadv5CfXigxlijn5ABI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57IHeF9d455332
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 18 Aug 2025 12:40:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 18
 Aug 2025 12:40:15 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 18 Aug 2025 12:40:15 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57IHeFYx1402841;
 Mon, 18 Aug 2025 12:40:15 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] mach-k3: am62*: Fix backup from eMMC boot mode
Date: Mon, 18 Aug 2025 12:40:15 -0500
Message-ID: <20250818174015.2879675-1-jm@ti.com>
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

Currently logic in spl_mmc_boot_mode only lookes at main devstat
to determine the bootmode to return. Thus, when using: 'eMMC boot'
as primary boot mode and 'MMCSD boot from eMMC UDA' as backup
boot mode, 'eMMC boot' is always selected. Add check for bootindex
to determine if ROM boot via backup boot mode and return MMCSD_MODE_FS
which is the only supported backup bootmode with eMMC device.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_init.c | 22 +++++++++++++---------
 arch/arm/mach-k3/am62px/am62p5_init.c | 24 ++++++++++++++----------
 arch/arm/mach-k3/am62x/am625_init.c   | 22 +++++++++++++---------
 3 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 00173e6836b..fa3570d07ec 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -218,17 +218,21 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
 			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
 
-	switch (bootmode) {
-	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+	if (bootindex == K3_PRIMARY_BOOTMODE) {
+		switch (bootmode) {
+		case BOOT_DEVICE_EMMC:
+			if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+				return MMCSD_MODE_EMMCBOOT;
+			if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+				return MMCSD_MODE_FS;
 			return MMCSD_MODE_EMMCBOOT;
-		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+		case BOOT_DEVICE_MMC:
+			if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+				return MMCSD_MODE_RAW;
+		default:
 			return MMCSD_MODE_FS;
-		return MMCSD_MODE_EMMCBOOT;
-	case BOOT_DEVICE_MMC:
-		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
-			return MMCSD_MODE_RAW;
-	default:
+		}
+	} else {
 		return MMCSD_MODE_FS;
 	}
 }
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 44a2d445d24..cb34938788f 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -264,18 +264,22 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
 			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
 
-	switch (bootmode) {
-	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+	if (bootindex == K3_PRIMARY_BOOTMODE) {
+		switch (bootmode) {
+		case BOOT_DEVICE_EMMC:
+			if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+				return MMCSD_MODE_EMMCBOOT;
+			if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+				return MMCSD_MODE_FS;
 			return MMCSD_MODE_EMMCBOOT;
-		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+		case BOOT_DEVICE_MMC:
+			if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+				return MMCSD_MODE_RAW;
+			fallthrough;
+		default:
 			return MMCSD_MODE_FS;
-		return MMCSD_MODE_EMMCBOOT;
-	case BOOT_DEVICE_MMC:
-		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
-			return MMCSD_MODE_RAW;
-		fallthrough;
-	default:
+		}
+	} else {
 		return MMCSD_MODE_FS;
 	}
 }
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index a422919fab1..312f81a1457 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -314,17 +314,21 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
 			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
 
-	switch (bootmode) {
-	case BOOT_DEVICE_EMMC:
-		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+	if (bootindex == K3_PRIMARY_BOOTMODE) {
+		switch (bootmode) {
+		case BOOT_DEVICE_EMMC:
+			if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
+				return MMCSD_MODE_EMMCBOOT;
+			if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+				return MMCSD_MODE_FS;
 			return MMCSD_MODE_EMMCBOOT;
-		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+		case BOOT_DEVICE_MMC:
+			if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
+				return MMCSD_MODE_RAW;
+		default:
 			return MMCSD_MODE_FS;
-		return MMCSD_MODE_EMMCBOOT;
-	case BOOT_DEVICE_MMC:
-		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
-			return MMCSD_MODE_RAW;
-	default:
+		}
+	} else {
 		return MMCSD_MODE_FS;
 	}
 }
-- 
2.49.0

