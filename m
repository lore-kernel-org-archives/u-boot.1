Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03905E7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:40:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D9B48022E;
	Tue, 17 Dec 2024 09:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ONM6VK9S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4FAD8031F; Tue, 17 Dec 2024 09:40:05 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA80B8022E
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 7ef810dcbc5211ef99858b75a2457dd9-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=4XPZyZNf+7ZUXDKlq9bnAxIlZ9U+527o6dfYbAe9dis=; 
 b=ONM6VK9SBGqVaIKwWgQF7PB8WuYX9GuSLcaa2gjBoLrVtgEQYQ/7aAjT9/c6rNFxT2V027BXkwPhfMUPd7eFdNHcTulzFwmRH4VhxUR/gA9CXZBuIUcljGD2w5NNCZDVR0kUyFLmpf0svgqphqpgAU/KtevTH7AEa2dvnNY6CU8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:7f784bd3-b82b-4ff0-a71e-3d5e644bea56, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:2ce3a628-d2eb-4de2-b5c9-495d1bc17256,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7ef810dcbc5211ef99858b75a2457dd9-20241217
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 701909501; Tue, 17 Dec 2024 16:39:57 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:55 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 08/10] net: mediatek: make sgmii/usxgmii optional
Date: Tue, 17 Dec 2024 16:39:55 +0800
Message-ID: <24c076a5bbe69f2378db529bc3ab9a5c23a00124.1734406968.git.weijie.gao@mediatek.com>
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

Not all platforms supports sgmii and/or usxgmii. So we add Kconfig
options for these features and enable them only for supported
platforms.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/Kconfig   | 12 ++++++++++++
 drivers/net/mtk_eth.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 576cd2d50ad..5a57d05d977 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -975,6 +975,18 @@ config MEDIATEK_ETH
 	  This Driver support MediaTek Ethernet GMAC
 	  Say Y to enable support for the MediaTek Ethernet GMAC.
 
+if MEDIATEK_ETH
+
+config MTK_ETH_SGMII
+	bool
+	default y if ARCH_MEDIATEK && !TARGET_MT7623
+
+config MTK_ETH_XGMII
+	bool
+	default y if TARGET_MT7987 || TARGET_MT7988
+
+endif # MEDIATEK_ETH
+
 config HIFEMAC_ETH
 	bool "HiSilicon Fast Ethernet Controller"
 	select DM_CLK
diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 5c210fd3e14..d3f29e4a0d0 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1505,7 +1505,7 @@ static void mtk_10gbaser_init(struct mtk_eth_priv *priv)
 	mtk_usxgmii_setup_phya_force_10000(priv);
 }
 
-static void mtk_mac_init(struct mtk_eth_priv *priv)
+static int mtk_mac_init(struct mtk_eth_priv *priv)
 {
 	int i, sgmii_sel_mask = 0, ge_mode = 0;
 	u32 mcr;
@@ -1522,13 +1522,16 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 		break;
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_2500BASEX:
+		if (!IS_ENABLED(CONFIG_MTK_ETH_SGMII)) {
+			printf("Error: SGMII is not supported on this platform\n");
+			return -ENOTSUPP;
+		}
+
 		if (MTK_HAS_CAPS(priv->soc->caps, MTK_GMAC2_U3_QPHY)) {
 			mtk_infra_rmw(priv, USB_PHY_SWITCH_REG, QPHY_SEL_MASK,
 				      SGMII_QPHY_SEL);
 		}
 
-		ge_mode = GE_MODE_RGMII;
-
 		if (MTK_HAS_CAPS(priv->soc->caps, MTK_ETH_PATH_MT7622_SGMII))
 			sgmii_sel_mask = SYSCFG1_SGMII_SEL_M;
 
@@ -1539,6 +1542,8 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 			mtk_sgmii_an_init(priv);
 		else
 			mtk_sgmii_force_init(priv);
+
+		ge_mode = GE_MODE_RGMII;
 		break;
 	case PHY_INTERFACE_MODE_MII:
 	case PHY_INTERFACE_MODE_GMII:
@@ -1595,12 +1600,19 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 			     RX_RST | RXC_DQSISEL);
 		mtk_gmac_rmw(priv, GMAC_TRGMII_RCK_CTRL, RX_RST, 0);
 	}
+
+	return 0;
 }
 
-static void mtk_xmac_init(struct mtk_eth_priv *priv)
+static int mtk_xmac_init(struct mtk_eth_priv *priv)
 {
 	u32 force_link = 0;
 
+	if (!IS_ENABLED(CONFIG_MTK_ETH_XGMII)) {
+		printf("Error: 10Gb interface is not supported on this platform\n");
+		return -ENOTSUPP;
+	}
+
 	switch (priv->phy_interface) {
 	case PHY_INTERFACE_MODE_USXGMII:
 		mtk_usxgmii_an_init(priv);
@@ -1633,6 +1645,8 @@ static void mtk_xmac_init(struct mtk_eth_priv *priv)
 
 	/* Force GMAC link down */
 	mtk_gmac_write(priv, GMAC_PORT_MCR(priv->gmac_id), FORCE_MODE);
+
+	return 0;
 }
 
 static void mtk_eth_fifo_init(struct mtk_eth_priv *priv)
@@ -1922,9 +1936,12 @@ static int mtk_eth_probe(struct udevice *dev)
 	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
 	    priv->phy_interface == PHY_INTERFACE_MODE_10GBASER ||
 	    priv->phy_interface == PHY_INTERFACE_MODE_XGMII)
-		mtk_xmac_init(priv);
+		ret = mtk_xmac_init(priv);
 	else
-		mtk_mac_init(priv);
+		ret = mtk_mac_init(priv);
+
+	if (ret)
+		return ret;
 
 	/* Probe phy if switch is not specified */
 	if (priv->sw == SW_NONE)
@@ -2032,8 +2049,9 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 		}
 	}
 
-	if (priv->phy_interface == PHY_INTERFACE_MODE_SGMII ||
-	    priv->phy_interface == PHY_INTERFACE_MODE_2500BASEX) {
+	if ((priv->phy_interface == PHY_INTERFACE_MODE_SGMII ||
+	     priv->phy_interface == PHY_INTERFACE_MODE_2500BASEX) &&
+	    IS_ENABLED(CONFIG_MTK_ETH_SGMII)) {
 		/* get corresponding sgmii phandle */
 		ret = dev_read_phandle_with_args(dev, "mediatek,sgmiisys",
 						 NULL, 0, 0, &args);
@@ -2055,8 +2073,9 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 		/* Upstream linux use mediatek,pnswap instead of pn_swap */
 		priv->pn_swap = ofnode_read_bool(args.node, "pn_swap") ||
 				ofnode_read_bool(args.node, "mediatek,pnswap");
-	} else if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
-		   priv->phy_interface == PHY_INTERFACE_MODE_10GBASER) {
+	} else if ((priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+		    priv->phy_interface == PHY_INTERFACE_MODE_10GBASER) &&
+		   IS_ENABLED(CONFIG_MTK_ETH_XGMII)) {
 		/* get corresponding usxgmii phandle */
 		ret = dev_read_phandle_with_args(dev, "mediatek,usxgmiisys",
 						 NULL, 0, 0, &args);
-- 
2.34.1

