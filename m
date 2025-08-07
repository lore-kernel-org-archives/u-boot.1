Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED90FC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 13:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B3984547;
	Thu,  7 Aug 2025 15:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=norik.com header.i=@norik.com header.b="oDwg87nU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507DB84517; Thu,  7 Aug 2025 15:13:59 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD0184541
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 15:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com; 
 s=default;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=abAMSrLY8HkkP3N8S6vfX119ZOZDmUFE0tdKIkFEUuc=; b=oDwg87nU0Xf6CVm7nSx9Kd6Tv5
 2Co2ntGFV9ZLbAkZ2JeSNlFvQ2zGTAPCvQZMWCkPD/EUz3Pt5OkBdn/hvhE+03HNHrtM4K7ntfyos
 i9IGZYGDJOjGKUN5VbgdMB6Z4Y1d7n4XKgvuXiEmJdiEOOJKLWhv/BLmbPwhUvDqKV3HQb4qCsZHo
 y6lLaRa0UIffT8WnjimyVxfkOWxEGoliSkErnHhEncin2TJFVxeM391ffX+30sssJJGbEqvHKbWsE
 kb/vslTuFJNwnPJdft7GwUtgBG+a5tnZu3hw0SmZOmF2EKX5Dhjv5x3b1AZ85FWsHRcOoT+a3yHPa
 D9sH4aCw==;
Received: from [89.212.21.243] (port=44244 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1uk0RO-00DGtF-2J;
 Thu, 07 Aug 2025 15:13:54 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Tom Rini <trini@konsulko.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] imx9: soc: Reuse and export low_drive_freq_update()
Date: Thu,  7 Aug 2025 15:13:53 +0200
Message-Id: <20250807131354.1531908-1-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Reuse and export low_drive_freq_update() function. This way global imx9
board_fix_fdt() doesn't duplicate code. While low_drive_freq_update()
can be reused on boards such as phyCORE-i.MX93 (TARGET_PHYCORE_IMX93)
which is not using the global imx9 board_fix_fdt() implementation.

While at it, make printout logic less verbose by only outputting on the
error condition and not on each successful clock fixup. Also drop now
invalid comment (low_drive_freq_update() now does fixup for internal and
kernel device-tree).

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 arch/arm/include/asm/arch-imx9/sys_proto.h |  1 +
 arch/arm/mach-imx/imx9/soc.c               | 29 +++++-----------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/sys_proto.h b/arch/arm/include/asm/arch-imx9/sys_proto.h
index df2148a53c7e..455aa95339e9 100644
--- a/arch/arm/include/asm/arch-imx9/sys_proto.h
+++ b/arch/arm/include/asm/arch-imx9/sys_proto.h
@@ -18,6 +18,7 @@ enum imx9_soc_voltage_mode {
 void soc_power_init(void);
 bool m33_is_rom_kicked(void);
 int m33_prepare(void);
+int low_drive_freq_update(void *blob);
 
 enum imx9_soc_voltage_mode soc_target_voltage_mode(void);
 
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index bb13ca742e3a..7e7a39d46c35 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -641,12 +641,10 @@ static int low_drive_fdt_fix_clock(void *fdt, int node_off, u32 clk_index, u32 n
 	return -ENOENT;
 }
 
-static int low_drive_freq_update(void *blob)
+int low_drive_freq_update(void *blob)
 {
-	int nodeoff, ret;
-	int i;
+	int nodeoff, ret, i;
 
-	/* Update kernel dtb clocks for low drive mode */
 	struct low_drive_freq_entry table[] = {
 		{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
 		{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
@@ -658,8 +656,8 @@ static int low_drive_freq_update(void *blob)
 		if (nodeoff >= 0) {
 			ret = low_drive_fdt_fix_clock(blob, nodeoff, table[i].clk,
 						      table[i].new_rate);
-			if (!ret)
-				printf("%s freq updated\n", table[i].node_path);
+			if (ret)
+				printf("freq update failed for %s\n", table[i].node_path);
 		}
 	}
 
@@ -671,23 +669,8 @@ static int low_drive_freq_update(void *blob)
 int board_fix_fdt(void *fdt)
 {
 	/* Update dtb clocks for low drive mode */
-	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
-		int nodeoff;
-		int i;
-
-		struct low_drive_freq_entry table[] = {
-			{"/soc@0/bus@42800000/mmc@42850000", 0, 266666667},
-			{"/soc@0/bus@42800000/mmc@42860000", 0, 266666667},
-			{"/soc@0/bus@42800000/mmc@428b0000", 0, 266666667},
-		};
-
-		for (i = 0; i < ARRAY_SIZE(table); i++) {
-			nodeoff = fdt_path_offset(fdt, table[i].node_path);
-			if (nodeoff >= 0)
-				low_drive_fdt_fix_clock(fdt, nodeoff, table[i].clk,
-							table[i].new_rate);
-		}
-	}
+	if (is_voltage_mode(VOLT_LOW_DRIVE))
+		low_drive_freq_update(fdt);
 
 	return 0;
 }
-- 
2.34.1

