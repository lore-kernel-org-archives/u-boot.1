Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22528E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 08:40:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65F9180214;
	Tue, 17 Dec 2024 09:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="OmjoC7OW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FFC80214; Tue, 17 Dec 2024 09:39:57 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016748022F
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 09:39:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 799e89aebc5211efbd192953cf12861f-20241217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=bCsoLqrsP9HAMblgPWKyfSZlJ6JZI2h1j8qcaefi6yY=; 
 b=OmjoC7OWM66l7AHq2wiASfmEURT2639/u/X7v+NTplxYB8b79D6204kTIkEWlRJ6y4Afhib9qnjgsGHBc+nrh4rRwKeLJk5mGG8Jqj9J/kXvfBlv2+87TVMexrunxkX7Rg8sd+ScyrrUO5XSYzHGxxIazqSoCNF9kumQ/yXr3kY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45, REQID:3c603d5d-c6c0-49d0-b480-697de4fb8f77, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6493067, CLOUDID:5de1193c-e809-4df3-83cd-88f012b9e9ba,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
 :nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
 LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 799e89aebc5211efbd192953cf12861f-20241217
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 960696480; Tue, 17 Dec 2024 16:39:48 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 17 Dec 2024 16:39:48 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 17 Dec 2024 16:39:47 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe
 Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Tom
 Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, Weijie
 Gao <weijie.gao@mediatek.com>
Subject: [PATCH 06/10] net: mediatek: fix gmac2 usability for mt7629
Date: Tue, 17 Dec 2024 16:39:46 +0800
Message-ID: <13143001486cca288db73769d0be06e8d212b264.1734406968.git.weijie.gao@mediatek.com>
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

MT7629 need extra setting for gmac2 to work. So additional
capability is added for mt7629 to handle this case.

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 6 ++++++
 drivers/net/mtk_eth.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 592764df3d1..39519fe05fe 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -1437,6 +1437,11 @@ static void mtk_mac_init(struct mtk_eth_priv *priv)
 	int i, sgmii_sel_mask = 0, ge_mode = 0;
 	u32 mcr;
 
+	if (MTK_HAS_CAPS(priv->soc->caps, MTK_ETH_PATH_MT7629_GMAC2)) {
+		mtk_infra_rmw(priv, MT7629_INFRA_MISC2_REG,
+			      INFRA_MISC2_BONDING_OPTION, priv->gmac_id);
+	}
+
 	switch (priv->phy_interface) {
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII:
@@ -2101,6 +2106,7 @@ static const struct mtk_soc_data mt7981_data = {
 };
 
 static const struct mtk_soc_data mt7629_data = {
+	.caps = MT7629_CAPS,
 	.ana_rgc3 = 0x128,
 	.gdma_count = 2,
 	.pdma_base = PDMA_V1_BASE,
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth.h
index ad079b5263b..1aa037907c5 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth.h
@@ -24,6 +24,7 @@ enum mkt_eth_capabilities {
 	MTK_ETH_PATH_GMAC1_TRGMII_BIT,
 	MTK_ETH_PATH_GMAC2_SGMII_BIT,
 	MTK_ETH_PATH_MT7622_SGMII_BIT,
+	MTK_ETH_PATH_MT7629_GMAC2_BIT,
 };
 
 #define MTK_TRGMII			BIT(MTK_TRGMII_BIT)
@@ -38,6 +39,7 @@ enum mkt_eth_capabilities {
 
 #define MTK_ETH_PATH_GMAC2_SGMII	BIT(MTK_ETH_PATH_GMAC2_SGMII_BIT)
 #define MTK_ETH_PATH_MT7622_SGMII	BIT(MTK_ETH_PATH_MT7622_SGMII_BIT)
+#define MTK_ETH_PATH_MT7629_GMAC2	BIT(MTK_ETH_PATH_MT7629_GMAC2_BIT)
 
 #define MTK_GMAC1_TRGMII	(MTK_ETH_PATH_GMAC1_TRGMII | MTK_TRGMII)
 
@@ -51,6 +53,8 @@ enum mkt_eth_capabilities {
 
 #define MT7623_CAPS  (MTK_GMAC1_TRGMII)
 
+#define MT7629_CAPS  (MTK_ETH_PATH_MT7629_GMAC2 | MTK_INFRA)
+
 #define MT7981_CAPS  (MTK_GMAC2_U3_QPHY | MTK_NETSYS_V2)
 
 #define MT7986_CAPS  (MTK_NETSYS_V2)
@@ -88,6 +92,9 @@ enum mkt_eth_capabilities {
 #define QPHY_SEL_MASK			0x3
 #define SGMII_QPHY_SEL			0x2
 
+#define MT7629_INFRA_MISC2_REG		0x70c
+#define INFRA_MISC2_BONDING_OPTION	GENMASK(15, 0)
+
 /* SYSCFG1_GE_MODE: GE Modes */
 #define GE_MODE_RGMII			0
 #define GE_MODE_MII			1
-- 
2.34.1

