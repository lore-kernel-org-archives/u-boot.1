Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13867CA0EDC
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 21:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95E0C81E13;
	Wed, 20 Aug 2025 23:56:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y52405n0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C03E082B07; Wed, 20 Aug 2025 23:56:39 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BFCE801DD
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 23:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57KLuZ2R3225741;
 Wed, 20 Aug 2025 16:56:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755726995;
 bh=Nno8naDF9+R7QMQtVtV32IY73MlD9J1zwkKUYcfvyIg=;
 h=From:To:CC:Subject:Date;
 b=y52405n0cOHgl9IBeEaQEn+R5VBopOlwS/0KNRWZQQr0C9PfCulW5XV6lHV4a9B0p
 lWAfFSpNzrDopSrQNNKvtUZUm7B4B1DNygkNAXmazuWOaRsGSaJwowjP6MGB6BsSlM
 anOZOwgzf+7kE/7Zs0oCw5goqJnENSfgSNogIEo8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57KLuZZG1493809
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 20 Aug 2025 16:56:35 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 16:56:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 16:56:34 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57KLuYFF867529;
 Wed, 20 Aug 2025 16:56:34 -0500
From: Judith Mendez <jm@ti.com>
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH v2] mach-k3: am62*: Fix backup from eMMC boot mode
Date: Wed, 20 Aug 2025 16:56:34 -0500
Message-ID: <20250820215634.52880-1-jm@ti.com>
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
 arch/arm/mach-k3/am62ax/am62a7_init.c | 5 +++++
 arch/arm/mach-k3/am62px/am62p5_init.c | 5 +++++
 arch/arm/mach-k3/am62x/am625_init.c   | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
index 00173e6836b..48d578e7d6f 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_init.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
@@ -218,6 +218,11 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
 			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
 
+	if (bootindex != K3_PRIMARY_BOOTMODE) {
+		pr_alert("Fallback to backup bootmode MMCSD_MODE_FS\n");
+		return MMCSD_MODE_FS;
+	}
+
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
 		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
index 44a2d445d24..aebd5200b0d 100644
--- a/arch/arm/mach-k3/am62px/am62p5_init.c
+++ b/arch/arm/mach-k3/am62px/am62p5_init.c
@@ -264,6 +264,11 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
 			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
 
+	if (bootindex != K3_PRIMARY_BOOTMODE) {
+		pr_alert("Fallback to backup bootmode MMCSD_MODE_FS\n");
+		return MMCSD_MODE_FS;
+	}
+
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
 		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
index 8f4ddf59753..14f93ac998f 100644
--- a/arch/arm/mach-k3/am62x/am625_init.c
+++ b/arch/arm/mach-k3/am62x/am625_init.c
@@ -305,6 +305,11 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
 			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
 
+	if (bootindex != K3_PRIMARY_BOOTMODE) {
+		pr_alert("Fallback to backup bootmode MMCSD_MODE_FS\n");
+		return MMCSD_MODE_FS;
+	}
+
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
 		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
-- 
2.49.0

