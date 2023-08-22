Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B221EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8715E86482;
	Tue, 22 Aug 2023 20:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NmaPhxUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDB2864C1; Tue, 22 Aug 2023 20:41:49 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 471D585CB5
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfepR080364;
 Tue, 22 Aug 2023 13:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692729700;
 bh=039kXFJEQdQa6WSgvYkaXHpQo2YXfOoES/YGub6C+HA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=NmaPhxUubm0Unc+0KLbQYyzK5OUQ1+IguJv42QaaFtswSgY65vFJFntuVZrav086J
 nbUU3hJeTZPZAG+V+WTG5IEFOKp2uIA2N6hOItS6/E9Tel4GlYz1f4kqCUWoZwYIyn
 7BxHaJr1I7wgs/iQFqA6cLJC6Sjg3iA7ErTkLs1M=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MIfeai104570
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 13:41:40 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 13:41:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 13:41:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfedo002160;
 Tue, 22 Aug 2023 13:41:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V4 3/8] arm: mach-k3: am625: Add support for UDA FS
Date: Tue, 22 Aug 2023 13:41:30 -0500
Message-ID: <20230822184135.2328409-4-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822184135.2328409-1-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

While boot partition support with EMMC boot is useful, it is
constrained by the size of boot hardware partition itself.

In the case of K3 devices, tispl images can contain OP-TEE images that
can substantially vary in size and the u-boot image itself can vary over
time as we enable various features.

So use the CSD information in the case of EMMC_BOOT configuration being
enabled to pick boot partition or UDA FS mode operation to pick.

If EMMC_BOOT is disabled, then depend on filesystem configuration to
pick data from UDA.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
New patch
 arch/arm/mach-k3/am625_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 0e5d44269ebf..ad61030a56fa 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -228,7 +228,13 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 
 	switch (bootmode) {
 	case BOOT_DEVICE_EMMC:
+#if CONFIG_IS_ENABLED(SUPPORT_EMMC_BOOT)
+		return (spl_mmc_emmc_boot_partition(mmc) ? MMCSD_MODE_EMMCBOOT : MMCSD_MODE_FS);
+#elif defined(CONFIG_SPL_FS_FAT) || defined(CONFIG_SPL_FS_EXT4)
+		return MMCSD_MODE_FS;
+#else
 		return MMCSD_MODE_EMMCBOOT;
+#endif
 	case BOOT_DEVICE_MMC:
 		if (bootmode_cfg & MAIN_DEVSTAT_PRIMARY_MMC_FS_RAW_MASK)
 			return MMCSD_MODE_RAW;
-- 
2.40.0

