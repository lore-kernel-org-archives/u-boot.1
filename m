Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6668CE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CA9D802C2;
	Tue, 17 Dec 2024 09:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="tM6YBFpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1672802B4; Tue, 17 Dec 2024 09:39:52 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B19A801CF
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 7763a8f4bc5211ef99858b75a2457dd9-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=w74/gzScE2eBaEU6wDO0Z1W8coyhQIwF62I6KDNuq5Q=; 
 b=tM6YBFpIlCRZMcFjRerM2fSqmVaArJgU+oCKpzJohPzwxVt/R3T042YIXiMixu+I1zZzV5lhqRDivWEmxZ1dkYM0TMXWN2WMpFGz5g3LlfIxSRXQpPk9enUQL66YQa1PpYxAB/EQMHEAIZC2AI4msgqMAA9LBl2qNh3tBVaFneU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:57c7f918-e36e-43f1-a0c2-131e96c12c99, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:1fe1193c-e809-4df3-83cd-88f012b9e9ba,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7763a8f4bc5211ef99858b75a2457dd9-20241217
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 390819514; Tue, 17 Dec 2024 16:39:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:43 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:42 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, "Joe
 Hershberger" <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>,
 "Tom Rini" <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 "Weijie Gao" <weijie.gao@mediatek.com>
Subject: [PATCH 05/10] net: mediatek: fix sgmii selection for mt7622
Date: Tue, 17 Dec 2024 16:39:41 +0800
Message-ID: <5f075c985eb2b2812fe6cc328bbf1d3a32e1e7e2.1734406968.git.weijie.gao@mediatek.com>
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

Unlike other platforms, mt7622 has only one SGMII and it can be
attached to either gmac1 or gmac2. So the register field of the
sgmii selection differs from other platforms as newer platforms can
control each sgmii individually.

This patch adds a new capability for mt7622 to handle this case.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 10 ++++++++--
 drivers/net/mtk_eth.h |  8 ++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index b8cb1f64995..592764df3d1 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1434,7 +1434,7 @@ static void mtk_usxgmii_an_init(struct mtk_eth_priv *priv)
 
 static void mtk_mac_init(struct mtk_eth_priv *priv)
 {
-	int i, ge_mode = 0;
+	int i, sgmii_sel_mask = 0, ge_mode = 0;
 	u32 mcr;
 
 	switch (priv->phy_interface) {
@@ -1450,8 +1450,13 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 		}
 
 		ge_mode = GE_MODE_RGMII;
-		mtk_ethsys_rmw(priv, ETHSYS_SYSCFG1_REG, SYSCFG1_SGMII_SEL_M,
+
+		if (MTK_HAS_CAPS(priv->soc->caps, MTK_ETH_PATH_MT7622_SGMII))
+			sgmii_sel_mask = SYSCFG1_SGMII_SEL_M;
+
+		mtk_ethsys_rmw(priv, ETHSYS_SYSCFG1_REG, sgmii_sel_mask,
 			       SYSCFG1_SGMII_SEL(priv->gmac_id));
+
 		if (priv->phy_interface == PHY_INTERFACE_MODE_SGMII)
 			mtk_sgmii_an_init(priv);
 		else
@@ -2112,6 +2117,7 @@ static const struct mtk_soc_data mt7623_data = {
 };
 
 static const struct mtk_soc_data mt7622_data = {
+	.caps = MT7622_CAPS,
 	.ana_rgc3 = 0x2028,
 	.gdma_count = 2,
 	.pdma_base = PDMA_V1_BASE,
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth.h
index 896dd6636c7..ad079b5263b 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth.h
@@ -23,6 +23,7 @@ enum mkt_eth_capabilities {
 	/* PATH BITS */
 	MTK_ETH_PATH_GMAC1_TRGMII_BIT,
 	MTK_ETH_PATH_GMAC2_SGMII_BIT,
+	MTK_ETH_PATH_MT7622_SGMII_BIT,
 };
 
 #define MTK_TRGMII			BIT(MTK_TRGMII_BIT)
@@ -36,6 +37,7 @@ enum mkt_eth_capabilities {
 #define MTK_ETH_PATH_GMAC1_TRGMII	BIT(MTK_ETH_PATH_GMAC1_TRGMII_BIT)
 
 #define MTK_ETH_PATH_GMAC2_SGMII	BIT(MTK_ETH_PATH_GMAC2_SGMII_BIT)
+#define MTK_ETH_PATH_MT7622_SGMII	BIT(MTK_ETH_PATH_MT7622_SGMII_BIT)
 
 #define MTK_GMAC1_TRGMII	(MTK_ETH_PATH_GMAC1_TRGMII | MTK_TRGMII)
 
@@ -45,6 +47,8 @@ enum mkt_eth_capabilities {
 
 #define MT7621_CAPS  (MTK_GMAC1_TRGMII | MTK_TRGMII_MT7621_CLK)
 
+#define MT7622_CAPS  (MTK_ETH_PATH_MT7622_SGMII)
+
 #define MT7623_CAPS  (MTK_GMAC1_TRGMII)
 
 #define MT7981_CAPS  (MTK_GMAC2_U3_QPHY | MTK_NETSYS_V2)
@@ -68,8 +72,8 @@ enum mkt_eth_capabilities {
 #define ETHSYS_SYSCFG1_REG		0x14
 #define SYSCFG1_GE_MODE_S(n)		(12 + ((n) * 2))
 #define SYSCFG1_GE_MODE_M		0x3
-#define SYSCFG1_SGMII_SEL_M		(0x3 << 8)
-#define SYSCFG1_SGMII_SEL(gmac)		((!(gmac)) ? BIT(9) : BIT(8))
+#define SYSCFG1_SGMII_SEL_M		GENMASK(9, 8)
+#define SYSCFG1_SGMII_SEL(gmac)		BIT(9 - (gmac))
 
 #define ETHSYS_CLKCFG0_REG		0x2c
 #define ETHSYS_TRGMII_CLK_SEL362_5	BIT(11)
-- 
2.34.1

