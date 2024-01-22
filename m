Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A86C47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 02:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A72A87954;
	Mon, 22 Jan 2024 03:08:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="AnnTBJ1c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807258785F; Mon, 22 Jan 2024 03:08:29 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84946878FA
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 03:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 1cfee850b8cb11ee9e680517dc993faa-20240122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=oY4KNO75pKv7DBdccGUiMasnZzlwVWYjabXQX0a/Mts=; 
 b=AnnTBJ1cm1SdOSsHH+CBu5t1OtxCJE4uf4MQJFPFVYobOEX34qV795KrjPbsJFLWYJtv50OJ07rO5Q/5jRhLWuwGUumzwh/UjZp7jn27JLRy4nL6B3/7jyC8ZW3YH08IdHgY4M+6I4jIhwDwE7R0pHUyCEdzaSo/jLZL/cknSXs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36, REQID:aa4d94b6-e775-4db3-b777-fc9ed9121bef, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6e16cf4, CLOUDID:05bc7f8e-e2c0-40b0-a8fe-7c7e47299109,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1cfee850b8cb11ee9e680517dc993faa-20240122
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 202044717; Mon, 22 Jan 2024 10:08:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Jan 2024 10:08:18 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Jan 2024 10:08:17 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Daniel Golle
 <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>,
 Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Subject: [PATCH 03/60] net: mediatek: add support for XGMII interface
Date: Mon, 22 Jan 2024 10:08:16 +0800
Message-ID: <20240122020816.143402-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.817100-8.000000
X-TMASE-MatchedRID: 6pbNFWS8cDvRpd8KAFU/vR+WEMjoO9WWTJDl9FKHbrkKogmGusPLbwfo
 RwTLQ8VIQx8Td33i8d2N/3dDbj3CNTNBg7c5UYh83fn7n/ZHGqZ9LQinZ4QefPcjNeVeWlqY+gt
 Hj7OwNO22utO5qEfOUbLvcsRbiXPIv1CxsDAJ2IQXEwMGZQWJdrxI9pu8BD/2yfzG03q29Ft25/
 6oul14mvomEzDK7sbdck3k3R9L50QZYOgZ5btsuEma3zYT97IFAYfQIAUhBayZvmCbKVb49sZL6
 x5U/HriPpCuffGH9zI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.817100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 16AF0A38997682C652F01FB50B9A8B5B8D655420EB5B3C0BA45B2A147793AB3C2000:8
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

This patch add XGMII support for connecting 2.5G PHY.

Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 22 ++++++++++++++--------
 drivers/net/mtk_eth.h |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 726aedad3f..75e7bcf83b 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1246,7 +1246,8 @@ static int mtk_phy_start(struct mtk_eth_priv *priv)
 	}
 
 	if (!priv->force_mode) {
-		if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII)
+		if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+		    priv->phy_interface == PHY_INTERFACE_MODE_XGMII)
 			mtk_xphy_link_adjust(priv);
 		else
 			mtk_phy_link_adjust(priv);
@@ -1516,7 +1517,7 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 
 static void mtk_xmac_init(struct mtk_eth_priv *priv)
 {
-	u32 sts;
+	u32 force_link = 0;
 
 	switch (priv->phy_interface) {
 	case PHY_INTERFACE_MODE_USXGMII:
@@ -1531,15 +1532,19 @@ static void mtk_xmac_init(struct mtk_eth_priv *priv)
 		       SYSCFG0_GE_MODE_M << SYSCFG0_GE_MODE_S(priv->gmac_id),
 		       0);
 
-	if (priv->gmac_id == 1) {
+	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII &&
+	    priv->gmac_id == 1) {
 		mtk_infra_rmw(priv, TOPMISC_NETSYS_PCS_MUX,
 			      NETSYS_PCS_MUX_MASK, MUX_G2_USXGMII_SEL);
-	} else if (priv->gmac_id == 2) {
-		sts = mtk_gmac_read(priv, XGMAC_STS(priv->gmac_id));
-		sts |= XGMAC_FORCE_LINK;
-		mtk_gmac_write(priv, XGMAC_STS(priv->gmac_id), sts);
 	}
 
+	if (priv->phy_interface == PHY_INTERFACE_MODE_XGMII ||
+	    priv->gmac_id == 2)
+		force_link = XGMAC_FORCE_LINK(priv->gmac_id);
+
+	mtk_gmac_rmw(priv, XGMAC_STS(priv->gmac_id),
+		     XGMAC_FORCE_LINK(priv->gmac_id), force_link);
+
 	/* Force GMAC link down */
 	mtk_gmac_write(priv, GMAC_PORT_MCR(priv->gmac_id), FORCE_MODE);
 }
@@ -1828,7 +1833,8 @@ static int mtk_eth_probe(struct udevice *dev)
 	mtk_eth_mdc_init(priv);
 
 	/* Set MAC mode */
-	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII)
+	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII ||
+	    priv->phy_interface == PHY_INTERFACE_MODE_XGMII)
 		mtk_xmac_init(priv);
 	else
 		mtk_mac_init(priv);
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth.h
index 45229c0f9a..fd31c782c7 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth.h
@@ -268,7 +268,7 @@ enum mkt_eth_capabilities {
 
 /* XGMAC Status Registers */
 #define XGMAC_STS(x)			(((x) == 2) ? 0x001C : 0x000C)
-#define XGMAC_FORCE_LINK		BIT(15)
+#define XGMAC_FORCE_LINK(x)		(((x) == 1) ? BIT(31) : BIT(15))
 
 /* XGMAC Registers */
 #define XGMAC_PORT_MCR(x)		(0x2000 + (((x) - 1) * 0x1000))
-- 
2.34.1

