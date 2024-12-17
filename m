Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAF2E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7F9F8030F;
	Tue, 17 Dec 2024 09:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="oD09YYn1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEE06802D5; Tue, 17 Dec 2024 09:39:35 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD3F80241
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 6eb4805cbc5211ef99858b75a2457dd9-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=WoTGnVz65qX67wWww1GIx6V1Qm1muITJoDm00f4Otmc=; 
 b=oD09YYn1FACSO6qpuJOuNgg2eDSnSHnGYa6s9w5bYBijohLRSGrLADG7nppUjfycsy4xHee3LKbagK9h7q08RK5beosKeEVAnjqeXfEhw7hZbFfVx49RQs+ChB8MuqSt9HcajtSW0ECukgtKPN6k3xl5MGE/zXiaqc3CcTvfS6Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:acdfc90e-c5e9-496f-a8d3-151bfe5193e1, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:51e1a628-d2eb-4de2-b5c9-495d1bc17256,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6eb4805cbc5211ef99858b75a2457dd9-20241217
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1341907026; Tue, 17 Dec 2024 16:39:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:28 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:28 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 04/10] net: mediatek: correct register name of ethsys syscfg1
Date: Tue, 17 Dec 2024 16:39:27 +0800
Message-ID: <78d39578fadd35037d1ecefe7de34fe395b9d90c.1734406968.git.weijie.gao@mediatek.com>
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

The SYSCFG0 should be SYSCFG1 according to the programming guide.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 14 +++++++-------
 drivers/net/mtk_eth.h | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 5af406edad1..b8cb1f64995 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1450,8 +1450,8 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 		}
 
 		ge_mode = GE_MODE_RGMII;
-		mtk_ethsys_rmw(priv, ETHSYS_SYSCFG0_REG, SYSCFG0_SGMII_SEL_M,
-			       SYSCFG0_SGMII_SEL(priv->gmac_id));
+		mtk_ethsys_rmw(priv, ETHSYS_SYSCFG1_REG, SYSCFG1_SGMII_SEL_M,
+			       SYSCFG1_SGMII_SEL(priv->gmac_id));
 		if (priv->phy_interface == PHY_INTERFACE_MODE_SGMII)
 			mtk_sgmii_an_init(priv);
 		else
@@ -1469,9 +1469,9 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 	}
 
 	/* set the gmac to the right mode */
-	mtk_ethsys_rmw(priv, ETHSYS_SYSCFG0_REG,
-		       SYSCFG0_GE_MODE_M << SYSCFG0_GE_MODE_S(priv->gmac_id),
-		       ge_mode << SYSCFG0_GE_MODE_S(priv->gmac_id));
+	mtk_ethsys_rmw(priv, ETHSYS_SYSCFG1_REG,
+		       SYSCFG1_GE_MODE_M << SYSCFG1_GE_MODE_S(priv->gmac_id),
+		       ge_mode << SYSCFG1_GE_MODE_S(priv->gmac_id));
 
 	if (priv->force_mode) {
 		mcr = (IPG_96BIT_WITH_SHORT_IPG << IPG_CFG_S) |
@@ -1527,8 +1527,8 @@ static void mtk_xmac_init(struct mtk_eth_priv *priv)
 	}
 
 	/* Set GMAC to the correct mode */
-	mtk_ethsys_rmw(priv, ETHSYS_SYSCFG0_REG,
-		       SYSCFG0_GE_MODE_M << SYSCFG0_GE_MODE_S(priv->gmac_id),
+	mtk_ethsys_rmw(priv, ETHSYS_SYSCFG1_REG,
+		       SYSCFG1_GE_MODE_M << SYSCFG1_GE_MODE_S(priv->gmac_id),
 		       0);
 
 	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII &&
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth.h
index 4f9ae52f973..896dd6636c7 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth.h
@@ -65,11 +65,11 @@ enum mkt_eth_capabilities {
 
 /* Ethernet subsystem registers */
 
-#define ETHSYS_SYSCFG0_REG		0x14
-#define SYSCFG0_GE_MODE_S(n)		(12 + ((n) * 2))
-#define SYSCFG0_GE_MODE_M		0x3
-#define SYSCFG0_SGMII_SEL_M		(0x3 << 8)
-#define SYSCFG0_SGMII_SEL(gmac)		((!(gmac)) ? BIT(9) : BIT(8))
+#define ETHSYS_SYSCFG1_REG		0x14
+#define SYSCFG1_GE_MODE_S(n)		(12 + ((n) * 2))
+#define SYSCFG1_GE_MODE_M		0x3
+#define SYSCFG1_SGMII_SEL_M		(0x3 << 8)
+#define SYSCFG1_SGMII_SEL(gmac)		((!(gmac)) ? BIT(9) : BIT(8))
 
 #define ETHSYS_CLKCFG0_REG		0x2c
 #define ETHSYS_TRGMII_CLK_SEL362_5	BIT(11)
@@ -84,7 +84,7 @@ enum mkt_eth_capabilities {
 #define QPHY_SEL_MASK			0x3
 #define SGMII_QPHY_SEL			0x2
 
-/* SYSCFG0_GE_MODE: GE Modes */
+/* SYSCFG1_GE_MODE: GE Modes */
 #define GE_MODE_RGMII			0
 #define GE_MODE_MII			1
 #define GE_MODE_MII_PHY			2
-- 
2.34.1

