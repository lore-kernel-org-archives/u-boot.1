Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFFE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB3580269;
	Tue, 17 Dec 2024 09:40:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="tXJMgKi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D73180316; Tue, 17 Dec 2024 09:40:03 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003CA801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 7c688e64bc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=AdB46UzUX5FL/bNMWFASBf2ZNNxhPhSgpDumQzS6OSg=; 
 b=tXJMgKi962Zslekp3qlUokrkBuo0kuXnCHmqp9MdMdfW3J9y/D20FBN7fN9+4Pl2CEiyW/fRPPHbhC7THo2sCH7/d8/giM+K0/Jjm0CD4iTZMWgLdI3yFLxaE5Rfg4GcdTVzg0rKGTD50PdUrCUwko9uBOCozTBTuodxDgh5M2U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:cb874d23-fa0a-4b0e-98b0-6be68f477492, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:e2e1193c-e809-4df3-83cd-88f012b9e9ba,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7c688e64bc5211efbd192953cf12861f-20241217
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1457933333; Tue, 17 Dec 2024 16:39:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:51 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:51 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>, Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Subject: [PATCH 07/10] net: mediatek: add support for 10GBASE-R
Date: Tue, 17 Dec 2024 16:39:50 +0800
Message-ID: <68d3301da026f7c1527d1d340985a07d9a14b94a.1734406968.git.weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1734406967.git.weijie.gao@mediatek.com>
References: <cover.1734406967.git.weijie.gao@mediatek.com>
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

This patch adds support for 10GBASE-R interface mode

Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 83 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 39519fe05fe..5c210fd3e14 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1246,6 +1246,7 @@ static int mtk_phy_start(struct mtk_eth_priv *priv)
 
 	if (!priv->force_mode) {
 		if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+		    priv->phy_interface == PHY_INTERFACE_MODE_10GBASER ||
 		    priv->phy_interface == PHY_INTERFACE_MODE_XGMII)
 			mtk_xphy_link_adjust(priv);
 		else
@@ -1425,6 +1426,71 @@ static void mtk_usxgmii_setup_phya_an_10000(struct mtk_eth_priv *priv)
 	udelay(400);
 }
 
+static void mtk_usxgmii_setup_phya_force_10000(struct mtk_eth_priv *priv)
+{
+	regmap_write(priv->usxgmii_regmap, 0x810, 0x000FFE6C);
+	regmap_write(priv->usxgmii_regmap, 0x818, 0x07B1EC7B);
+	regmap_write(priv->usxgmii_regmap, 0x80C, 0xB0000000);
+	ndelay(1020);
+	regmap_write(priv->usxgmii_regmap, 0x80C, 0x90000000);
+	ndelay(1020);
+
+	regmap_write(priv->xfi_pextp_regmap, 0x9024, 0x00C9071C);
+	regmap_write(priv->xfi_pextp_regmap, 0x2020, 0xAA8585AA);
+	regmap_write(priv->xfi_pextp_regmap, 0x2030, 0x0C020707);
+	regmap_write(priv->xfi_pextp_regmap, 0x2034, 0x0E050F0F);
+	regmap_write(priv->xfi_pextp_regmap, 0x2040, 0x00140032);
+	regmap_write(priv->xfi_pextp_regmap, 0x50F0, 0x00C014AA);
+	regmap_write(priv->xfi_pextp_regmap, 0x50E0, 0x3777C12B);
+	regmap_write(priv->xfi_pextp_regmap, 0x506C, 0x005F9CFF);
+	regmap_write(priv->xfi_pextp_regmap, 0x5070, 0x9D9DFAFA);
+	regmap_write(priv->xfi_pextp_regmap, 0x5074, 0x27273F3F);
+	regmap_write(priv->xfi_pextp_regmap, 0x5078, 0xA7883C68);
+	regmap_write(priv->xfi_pextp_regmap, 0x507C, 0x11661166);
+	regmap_write(priv->xfi_pextp_regmap, 0x5080, 0x0E000AAF);
+	regmap_write(priv->xfi_pextp_regmap, 0x5084, 0x08080D0D);
+	regmap_write(priv->xfi_pextp_regmap, 0x5088, 0x02030909);
+	regmap_write(priv->xfi_pextp_regmap, 0x50E4, 0x0C0C0000);
+	regmap_write(priv->xfi_pextp_regmap, 0x50E8, 0x04040000);
+	regmap_write(priv->xfi_pextp_regmap, 0x50EC, 0x0F0F0C06);
+	regmap_write(priv->xfi_pextp_regmap, 0x50A8, 0x506E8C8C);
+	regmap_write(priv->xfi_pextp_regmap, 0x6004, 0x18190000);
+	regmap_write(priv->xfi_pextp_regmap, 0x00F8, 0x01423342);
+	regmap_write(priv->xfi_pextp_regmap, 0x00F4, 0x80201F20);
+	regmap_write(priv->xfi_pextp_regmap, 0x0030, 0x00050C00);
+	regmap_write(priv->xfi_pextp_regmap, 0x0070, 0x02002800);
+	ndelay(1020);
+	regmap_write(priv->xfi_pextp_regmap, 0x30B0, 0x00000020);
+	regmap_write(priv->xfi_pextp_regmap, 0x3028, 0x00008A01);
+	regmap_write(priv->xfi_pextp_regmap, 0x302C, 0x0000A884);
+	regmap_write(priv->xfi_pextp_regmap, 0x3024, 0x00083002);
+	regmap_write(priv->xfi_pextp_regmap, 0x3010, 0x00022220);
+	regmap_write(priv->xfi_pextp_regmap, 0x5064, 0x0F020A01);
+	regmap_write(priv->xfi_pextp_regmap, 0x50B4, 0x06100600);
+	regmap_write(priv->xfi_pextp_regmap, 0x3048, 0x47684100);
+	regmap_write(priv->xfi_pextp_regmap, 0x3050, 0x00000000);
+	regmap_write(priv->xfi_pextp_regmap, 0x3054, 0x00000000);
+	regmap_write(priv->xfi_pextp_regmap, 0x306C, 0x00000F00);
+	if (priv->gmac_id == 2)
+		regmap_write(priv->xfi_pextp_regmap, 0xA008, 0x0007B400);
+	regmap_write(priv->xfi_pextp_regmap, 0xA060, 0x00040000);
+	regmap_write(priv->xfi_pextp_regmap, 0x90D0, 0x00000001);
+	regmap_write(priv->xfi_pextp_regmap, 0x0070, 0x0200E800);
+	udelay(150);
+	regmap_write(priv->xfi_pextp_regmap, 0x0070, 0x0200C111);
+	ndelay(1020);
+	regmap_write(priv->xfi_pextp_regmap, 0x0070, 0x0200C101);
+	udelay(15);
+	regmap_write(priv->xfi_pextp_regmap, 0x0070, 0x0202C111);
+	ndelay(1020);
+	regmap_write(priv->xfi_pextp_regmap, 0x0070, 0x0202C101);
+	udelay(100);
+	regmap_write(priv->xfi_pextp_regmap, 0x30B0, 0x00000030);
+	regmap_write(priv->xfi_pextp_regmap, 0x00F4, 0x80201F00);
+	regmap_write(priv->xfi_pextp_regmap, 0x3040, 0x30000000);
+	udelay(400);
+}
+
 static void mtk_usxgmii_an_init(struct mtk_eth_priv *priv)
 {
 	mtk_xfi_pll_enable(priv);
@@ -1432,6 +1498,13 @@ static void mtk_usxgmii_an_init(struct mtk_eth_priv *priv)
 	mtk_usxgmii_setup_phya_an_10000(priv);
 }
 
+static void mtk_10gbaser_init(struct mtk_eth_priv *priv)
+{
+	mtk_xfi_pll_enable(priv);
+	mtk_usxgmii_reset(priv);
+	mtk_usxgmii_setup_phya_force_10000(priv);
+}
+
 static void mtk_mac_init(struct mtk_eth_priv *priv)
 {
 	int i, sgmii_sel_mask = 0, ge_mode = 0;
@@ -1532,6 +1605,9 @@ static void mtk_xmac_init(struct mtk_eth_priv *priv)
 	case PHY_INTERFACE_MODE_USXGMII:
 		mtk_usxgmii_an_init(priv);
 		break;
+	case PHY_INTERFACE_MODE_10GBASER:
+		mtk_10gbaser_init(priv);
+		break;
 	default:
 		break;
 	}
@@ -1541,7 +1617,8 @@ static void mtk_xmac_init(struct mtk_eth_priv *priv)
 		       SYSCFG1_GE_MODE_M << SYSCFG1_GE_MODE_S(priv->gmac_id),
 		       0);
 
-	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII &&
+	if ((priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+	     priv->phy_interface == PHY_INTERFACE_MODE_10GBASER) &&
 	    priv->gmac_id == 1) {
 		mtk_infra_rmw(priv, TOPMISC_NETSYS_PCS_MUX,
 			      NETSYS_PCS_MUX_MASK, MUX_G2_USXGMII_SEL);
@@ -1843,6 +1920,7 @@ static int mtk_eth_probe(struct udevice *dev)
 
 	/* Set MAC mode */
 	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+	    priv->phy_interface == PHY_INTERFACE_MODE_10GBASER ||
 	    priv->phy_interface == PHY_INTERFACE_MODE_XGMII)
 		mtk_xmac_init(priv);
 	else
@@ -1977,7 +2055,8 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 		/* Upstream linux use mediatek,pnswap instead of pn_swap */
 		priv->pn_swap = ofnode_read_bool(args.node, "pn_swap") ||
 				ofnode_read_bool(args.node, "mediatek,pnswap");
-	} else if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII) {
+	} else if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+		   priv->phy_interface == PHY_INTERFACE_MODE_10GBASER) {
 		/* get corresponding usxgmii phandle */
 		ret = dev_read_phandle_with_args(dev, "mediatek,usxgmiisys",
 						 NULL, 0, 0, &args);
-- 
2.34.1

