Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD22CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 08:14:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6EC384874;
	Thu, 11 Jun 2026 10:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Oq8Lns+F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227A68489D; Thu, 11 Jun 2026 10:13:53 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D4B784717
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 10:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 77ac0d5e656d11f1b1788b6acf885367-20260611
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=hFi2dg1v/s51Sx0vTqnTwbqppAKbPaP8CHNU/Gqw0vE=; 
 b=Oq8Lns+Fjm2bh/kRQ40PqJdbve6yINdFSaPPwI4WBTg/nLT/WubRlTB75iVklUGJoT7D3dPWpCrKM0OkWzPdIkxU+FBhvAdkQ+bK6juB3KdO7T+i4CwGmPPLID8vf9kiLdSQLbzgViGjVBXyoyPKQ1cLKfD8G0iak+rrjC92ASU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:b1bb5379-3351-47a4-8b95-25374f036817, IP:0,
 U
 RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-25
X-CID-META: VersionHash:e276073, CLOUDID:9383c1ba-7058-42fe-b85e-0a2fd773e222,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|836|865|888|898,TC:-5,
 Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
 OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 77ac0d5e656d11f1b1788b6acf885367-20260611
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1171919866; Thu, 11 Jun 2026 16:13:45 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 11 Jun 2026 16:13:44 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 11 Jun 2026 16:13:43 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Vignesh R <vigneshr@ti.com>, Takahiro Kuwano
 <takahiro.kuwano@infineon.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Jeffrey Yu <jeyu@issi.com>, Christoph Reiter <christoph.reiter@evk.biz>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Shiji Yang
 <yangshiji66@outlook.com>, Bernhard Messerklinger
 <bernhard.messerklinger@at.abb.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 6/7] mtd: spi-nor-ids: Reorder winbond parts with part
 families
Date: Thu, 11 Jun 2026 16:13:42 +0800
Message-ID: <bac212fe9c44b2395af9c339e632c2df8c80c72d.1781164951.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1781164951.git.weijie.gao@mediatek.com>
References: <cover.1781164951.git.weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
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

This patch reorders winbond parts with families (0xef20xx, 0xef30xx, ...).
Also, parts in the same family are sorted by size.
Some parts are renamed to match their families.

Renamed parts:

1. Removed suffixes due to multiple suffixes matches with the same ID:
w25q80bl -> w25q80
w25q16cl -> w25q16
w25q64cv -> w25q64

2. Add suffix to match their family:
w25q80 -> w25q80bw
w25q01jv -> w25q01jv-q
w25q256jw -> w25q256jw-q
w25q16jv -> w25q16jv-m
w25q32jv -> w25q32jv-m
w25q128jv -> w25q128jv-m
w25q02jv -> w25q02jv-m
w25q128jw -> w25q128jw-m

3. Change to uniform suffix:
w25q01nw-iq -> w25q01nw-q
w25q01jvfim -> w25q01jv-m
w25q01nw-im -> w25q01nw-m
w25q02nw-im -> w25q02nw-m

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
v3-v5: unchanged
v2: new
---
 drivers/mtd/spi/spi-nor-ids.c | 157 +++++++++++-----------------------
 1 file changed, 50 insertions(+), 107 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index a0097060074..7ea91620e3f 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -544,123 +544,66 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("w25x40", 0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
 	{ INFO("w25x16", 0xef3015, 0, 64 * 1024,  32, SECT_4K) },
 	{ INFO("w25x32", 0xef3016, 0, 64 * 1024,  64, SECT_4K) },
-	{ INFO("w25q20cl", 0xef4012, 0, 64 * 1024,  4, SECT_4K) },
-	{ INFO("w25q20bw", 0xef5012, 0, 64 * 1024,  4, SECT_4K) },
-	{ INFO("w25q20ew", 0xef6012, 0, 64 * 1024,  4, SECT_4K) },
-	{
-		INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q16jv", 0xef7015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
-	},
-	{
-		INFO("w25q32jv", 0xef7016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q32jwm", 0xef8016, 0, 64 * 1024,  64,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q256jwm", 0xef8019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
 	{ INFO("w25x64", 0xef3017, 0, 64 * 1024, 128, SECT_4K) },
-	{
-		INFO("w25q64dw", 0xef6017, 0, 64 * 1024, 128,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q64jv", 0xef7017, 0, 64 * 1024, 128,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q128fw", 0xef6018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q128jv", 0xef7018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q128jw", 0xef8018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q256jw", 0xef6019, 0, 64 * 1024, 512,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q512nwq", 0xef6020, 0, 64 * 1024, 1024,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q512nwm", 0xef8020, 0, 64 * 1024, 1024,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q512jvq", 0xef4020, 0, 64 * 1024, 1024,
-		     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-		     SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q01jv", 0xef4021, 0, 64 * 1024, 2048,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q01jvfim", 0xef7021, 0, 64 * 1024, 2048,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{
-		INFO("w25q02jv", 0xef7022, 0, 64 * 1024, 4096,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
-	{ INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K) },
-	{ INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{
-		INFO("w25q16cl", 0xef4015, 0, 64 * 1024,  32,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
+	{ INFO("w25q20cl", 0xef4012, 0, 64 * 1024,  4, SECT_4K) },
+	{ INFO("w25q80", 0xef4014, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q16", 0xef4015, 0, 64 * 1024,  32,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ INFO("w25q32", 0xef4016, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("w25q64cv", 0xef4017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q64", 0xef4017, 0, 64 * 1024,  128, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25q128", 0xef4018, 0, 64 * 1024, 256,
-			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
-			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
-	},
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ INFO("w25q256", 0xef4019, 0, 64 * 1024, 512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q512jv-q", 0xef4020, 0, 64 * 1024, 1024,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q01jv-q", 0xef4021, 0, 64 * 1024, 2048,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q20bw", 0xef5012, 0, 64 * 1024,  4, SECT_4K) },
+	{ INFO("w25q80bw", 0xef5014, 0, 64 * 1024,  16, SECT_4K) },
+	{ INFO("w25q20ew", 0xef6012, 0, 64 * 1024,  4, SECT_4K) },
+	{ INFO("w25q16dw", 0xef6015, 0, 64 * 1024,  32,
+	        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q32dw", 0xef6016, 0, 64 * 1024,  64,
+	        SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q64dw", 0xef6017, 0, 64 * 1024, 128,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q128fw", 0xef6018, 0, 64 * 1024, 256,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q256jw-q", 0xef6019, 0, 64 * 1024, 512,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q512nw-q", 0xef6020, 0, 64 * 1024, 1024,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q01nw-q", 0xef6021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25m512jw", 0xef6119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q16jv-m", 0xef7015, 0, 64 * 1024,  32,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q32jv-m", 0xef7016, 0, 64 * 1024,  64,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q64jv-m", 0xef7017, 0, 64 * 1024, 128,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q128jv-m", 0xef7018, 0, 64 * 1024, 256,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q01jv-m", 0xef7021, 0, 64 * 1024, 2048,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q02jv-m", 0xef7022, 0, 64 * 1024, 4096,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 	{ INFO("w25m512jv", 0xef7119, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q32jw-m", 0xef8016, 0, 64 * 1024,  64,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q128jw-m", 0xef8018, 0, 64 * 1024, 256,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q256jw-m", 0xef8019, 0, 64 * 1024, 512,
+	      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q512nw-m", 0xef8020, 0, 64 * 1024, 1024,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ INFO("w25q01nw-m", 0xef8021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ INFO("w25q02nw-m", 0xef8022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25h02jv", 0xef9022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25h512nw-am", 0xefa020, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25h01nw-am", 0xefa021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ INFO("w25h02nw-am", 0xefa022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("w25q01nw-iq", 0xef6021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("w25q01nw-im", 0xef8021, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("w25q02nw-im", 0xef8022, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
-	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("w77q51nw", 0xef8a1a, 0, 64 * 1024, 1024,
+	       SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 #endif
 #ifdef CONFIG_SPI_FLASH_XMC
 	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-- 
2.45.2

