Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564DAE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:39:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E1B380224;
	Tue, 17 Dec 2024 09:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="P3aRE+xU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B47780269; Tue, 17 Dec 2024 09:39:35 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA808022F
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 6c8c0facbc5211ef99858b75a2457dd9-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=Y8diannEENDDAPH1U3NqMHf/IVZHVfURqdIh3P+oCTo=; 
 b=P3aRE+xUugPfK91Pe8QsEzkkT2E7J3YXTBo/hfS2hrAy4idntpQZFT0BMJezzYB6Li6byPPjh9HbRWrFoYHYPS6lydMm0xI7I2pCCUCk+vS+wYiNBE1QD0gkkjM4dQNvq+xs1IWnzqnVJw61yVE4MO8bUMXpPwz7sbyy/CqrrPg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:e2d5672d-da9a-40fd-aa18-8ecf1f36dc51, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:f1df193c-e809-4df3-83cd-88f012b9e9ba,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6c8c0facbc5211ef99858b75a2457dd9-20241217
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 612899096; Tue, 17 Dec 2024 16:39:26 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:24 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 03/10] net: mediatek: use correct register field for SGMII
 speed selection
Date: Tue, 17 Dec 2024 16:39:23 +0800
Message-ID: <ccf3809e321b5be397781c342b7d7085055c2783.1734406968.git.weijie.gao@mediatek.com>
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

The register field for SGMII speed selection is a 2-bit field with
value 0 for 1Gbps and 1 for 2.5Gbps (2/3 are reserved).
So it's necessary to set both bits instead of just setting/clearing
only the lower bit.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 12 ++++++------
 drivers/net/mtk_eth.h |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 5098afef8a8..5af406edad1 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -835,8 +835,8 @@ static int mt7531_port_sgmii_init(struct mtk_eth_priv *priv,
 	}
 
 	/* Set SGMII GEN2 speed(2.5G) */
-	mt753x_reg_rmw(priv, MT7531_PHYA_CTRL_SIGNAL3(port),
-		       SGMSYS_SPEED_2500, SGMSYS_SPEED_2500);
+	mt753x_reg_rmw(priv, MT7531_PHYA_CTRL_SIGNAL3(port), SGMSYS_SPEED_MASK,
+		       FIELD_PREP(SGMSYS_SPEED_MASK, SGMSYS_SPEED_2500));
 
 	/* Disable SGMII AN */
 	mt753x_reg_rmw(priv, MT7531_PCS_CONTROL_1(port),
@@ -1281,8 +1281,7 @@ static int mtk_phy_probe(struct udevice *dev)
 static void mtk_sgmii_an_init(struct mtk_eth_priv *priv)
 {
 	/* Set SGMII GEN1 speed(1G) */
-	clrsetbits_le32(priv->sgmii_base + priv->soc->ana_rgc3,
-			SGMSYS_SPEED_2500, 0);
+	clrbits_le32(priv->sgmii_base + priv->soc->ana_rgc3, SGMSYS_SPEED_MASK);
 
 	/* Enable SGMII AN */
 	setbits_le32(priv->sgmii_base + SGMSYS_PCS_CONTROL_1,
@@ -1305,8 +1304,9 @@ static void mtk_sgmii_an_init(struct mtk_eth_priv *priv)
 static void mtk_sgmii_force_init(struct mtk_eth_priv *priv)
 {
 	/* Set SGMII GEN2 speed(2.5G) */
-	setbits_le32(priv->sgmii_base + priv->soc->ana_rgc3,
-		     SGMSYS_SPEED_2500);
+	clrsetbits_le32(priv->sgmii_base + priv->soc->ana_rgc3,
+			SGMSYS_SPEED_MASK,
+			FIELD_PREP(SGMSYS_SPEED_MASK, SGMSYS_SPEED_2500));
 
 	/* Disable SGMII AN */
 	clrsetbits_le32(priv->sgmii_base + SGMSYS_PCS_CONTROL_1,
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth.h
index fd31c782c7f..4f9ae52f973 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth.h
@@ -108,7 +108,8 @@ enum mkt_eth_capabilities {
 
 #define SGMSYS_GEN2_SPEED		0x2028
 #define SGMSYS_GEN2_SPEED_V2		0x128
-#define SGMSYS_SPEED_2500		BIT(2)
+#define SGMSYS_SPEED_MASK		GENMASK(3, 2)
+#define SGMSYS_SPEED_2500		1
 
 /* USXGMII subsystem config registers */
 /* Register to control USXGMII XFI PLL digital */
-- 
2.34.1

