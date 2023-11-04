Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B16DC4167D
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50FCE871BC;
	Sat,  4 Nov 2023 08:23:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lUvDq+Nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F63B871A3; Sat,  4 Nov 2023 08:22:24 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08128870FC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LseC013154;
 Sat, 4 Nov 2023 02:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082514;
 bh=jWRpCMyUTgDT0GbzNA2uHPF6mNYdqkZqeJScq6df/m0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=lUvDq+NrsHeM8EHgtK/cWnDx0EWMYwiD1ulrh1fhALG1Q/W2GIzomO096PyuH4cWi
 aK7iurEHoFXYDTbYgei6RXpKrh8GCWT0oz4TdFf7qoH0tp1ScxdL14gNDvNk7DSbQw
 yfLYBxoHqomNgTQKJmYJAXmqinn1hEf8Rgn17JgQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LsI1002813
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:54 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47Ls2B103854;
 Sat, 4 Nov 2023 02:21:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 09/12] arm: mach-k3: j721e: Improve support for UDA FS
Date: Sat, 4 Nov 2023 02:21:47 -0500
Message-ID: <20231104072150.3339-10-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104072150.3339-1-nm@ti.com>
References: <20231104072150.3339-1-nm@ti.com>
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

Commit 5019170970ad ("arch: arm: mach-k3: j721e: add support for UDA
FS") introduced basic UDA FS support, however, we can Take approach
similar to commit 0f1c1e8b368b ("arm: mach-k3: am625: Add support for
UDA FS"). While boot partition support with EMMC boot is useful, it is
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
 arch/arm/mach-k3/j721e_init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b1f7e25ed092..bcdfbfc79c4a 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -294,7 +294,14 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
 {
 	switch (boot_device) {
 	case BOOT_DEVICE_MMC1:
-		return (spl_mmc_emmc_boot_partition(mmc) ? MMCSD_MODE_EMMCBOOT : MMCSD_MODE_FS);
+		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT)) {
+			if (spl_mmc_emmc_boot_partition(mmc))
+				return MMCSD_MODE_EMMCBOOT;
+			return MMCSD_MODE_FS;
+		}
+		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
+			return MMCSD_MODE_FS;
+		return MMCSD_MODE_EMMCBOOT;
 	case BOOT_DEVICE_MMC2:
 		return MMCSD_MODE_FS;
 	default:
-- 
2.37.2

