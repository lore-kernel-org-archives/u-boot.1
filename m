Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187CAC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 01:46:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA7D986EF2;
	Mon,  6 Nov 2023 02:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="O+7pLl1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A71586A26; Mon,  6 Nov 2023 02:45:40 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A987486D7E
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 02:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 1ed2b0c47c4611eea33bb35ae8d461a2-20231106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From;
 bh=/caFWhcOlxqPBnALZxOkdVJ0OFgQ/GsPQ+Xnw9EHWA0=; 
 b=O+7pLl1CNRAsob5qXONZFMQtRb1CPJNJ25TVKKV6FLTLgaJPdtsuPI/4cIfEh+SByRWNQ+EWK52HA0eB5QLfEOVLI6GWzzUZQf0PpOUGL1eRKeKUwPZDrBVPT17D1yy8vc7Gj5o6rPUIQkeanYJ+iw7ImRgfCMQpanHse9ZN0HE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33, REQID:d343fc3d-a940-4af9-be28-2e78df7b5e3c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:364b77b, CLOUDID:453b2efc-4a48-46e2-b946-12f04f20af8c,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
 NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 1ed2b0c47c4611eea33bb35ae8d461a2-20231106
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <chunfeng.yun@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1029464406; Mon, 06 Nov 2023 09:45:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Nov 2023 09:45:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Nov 2023 09:45:08 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Marek Vasut <marex@denx.de>
CC: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.denx.de>
Subject: [PATCH 2/2] phy: phy-mtk-tphy: add properties for phy tuning
Date: Mon, 6 Nov 2023 09:45:06 +0800
Message-ID: <20231106014506.15461-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231106014506.15461-1-chunfeng.yun@mediatek.com>
References: <20231106014506.15461-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add properties to improve eye diagram which sometimes need adjust
some parameters of u2phy;
Add a property to tune disconnect threshold;

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/phy/phy-mtk-tphy.c | 58 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/phy-mtk-tphy.c
index 1883f9f83e..ea9edf212c 100644
--- a/drivers/phy/phy-mtk-tphy.c
+++ b/drivers/phy/phy-mtk-tphy.c
@@ -47,6 +47,11 @@
 #define PA0_USB20_PLL_PREDIV		GENMASK(7, 6)
 #define PA0_RG_USB20_INTR_EN		BIT(5)
 
+#define U3P_USBPHYACR1			0x004
+#define PA1_RG_INTR_CAL			GENMASK(23, 19)
+#define PA1_RG_VRT_SEL			GENMASK(14, 12)
+#define PA1_RG_TERM_SEL			GENMASK(10, 8)
+
 #define U3P_USBPHYACR2			0x008
 #define PA2_RG_U2PLL_BW			GENMASK(21, 19)
 
@@ -56,8 +61,10 @@
 #define PA5_RG_U2_HS_100U_U3_EN		BIT(11)
 
 #define U3P_USBPHYACR6			0x018
+#define PA6_RG_U2_PRE_EMP		GENMASK(31, 30)
 #define PA6_RG_U2_BC11_SW_EN		BIT(23)
 #define PA6_RG_U2_OTG_VBUSCMP_EN	BIT(20)
+#define PA6_RG_U2_DISCTH		GENMASK(7, 4)
 #define PA6_RG_U2_SQTH			GENMASK(3, 0)
 
 #define U3P_U2PHYACR4			0x020
@@ -240,7 +247,7 @@ struct u3phy_banks {
 
 struct mtk_phy_instance {
 	void __iomem *port_base;
-	const struct device_node *np;
+	struct device_node *np;
 	union {
 		struct u2phy_banks u2_banks;
 		struct u3phy_banks u3_banks;
@@ -250,6 +257,11 @@ struct mtk_phy_instance {
 	struct clk da_ref_clk;	/* reference clock of analog phy */
 	u32 index;
 	u32 type;
+
+	u32 eye_vrt;
+	u32 eye_term;
+	u32 discth;
+	u32 pre_emphasis;
 };
 
 struct mtk_tphy {
@@ -564,6 +576,47 @@ static void phy_v2_banks_init(struct mtk_tphy *tphy,
 	}
 }
 
+static void phy_parse_property(struct mtk_tphy *tphy,
+			       struct mtk_phy_instance *instance)
+{
+	ofnode node = np_to_ofnode(instance->np);
+
+	if (instance->type != PHY_TYPE_USB2)
+		return;
+
+	ofnode_read_u32(node, "mediatek,eye-vrt", &instance->eye_vrt);
+	ofnode_read_u32(node, "mediatek,eye-term", &instance->eye_term);
+	ofnode_read_u32(node, "mediatek,discth", &instance->discth);
+	ofnode_read_u32(node, "mediatek,pre-emphasis", &instance->pre_emphasis);
+
+	dev_dbg(tphy->dev, "vrt:%d, term:%d, disc:%d, emp:%d\n",
+		instance->eye_vrt, instance->eye_term,
+		instance->discth, instance->pre_emphasis);
+}
+
+static void u2_phy_props_set(struct mtk_tphy *tphy,
+			     struct mtk_phy_instance *instance)
+{
+	struct u2phy_banks *u2_banks = &instance->u2_banks;
+	void __iomem *com = u2_banks->com;
+
+	if (instance->eye_vrt)
+		clrsetbits_le32(com + U3P_USBPHYACR1, PA1_RG_VRT_SEL,
+				FIELD_PREP(PA1_RG_VRT_SEL, instance->eye_vrt));
+
+	if (instance->eye_term)
+		clrsetbits_le32(com + U3P_USBPHYACR1, PA1_RG_TERM_SEL,
+				FIELD_PREP(PA1_RG_TERM_SEL, instance->eye_term));
+
+	if (instance->discth)
+		clrsetbits_le32(com + U3P_USBPHYACR6, PA6_RG_U2_DISCTH,
+				FIELD_PREP(PA6_RG_U2_DISCTH, instance->discth));
+
+	if (instance->pre_emphasis)
+		clrsetbits_le32(com + U3P_USBPHYACR6, PA6_RG_U2_PRE_EMP,
+				FIELD_PREP(PA6_RG_U2_PRE_EMP, instance->pre_emphasis));
+}
+
 static int mtk_phy_init(struct phy *phy)
 {
 	struct mtk_tphy *tphy = dev_get_priv(phy->dev);
@@ -586,6 +639,7 @@ static int mtk_phy_init(struct phy *phy)
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
 		u2_phy_instance_init(tphy, instance);
+		u2_phy_props_set(tphy, instance);
 		break;
 	case PHY_TYPE_USB3:
 		u3_phy_instance_init(tphy, instance);
@@ -692,6 +746,8 @@ static int mtk_phy_xlate(struct phy *phy,
 		return -EINVAL;
 	}
 
+	phy_parse_property(tphy, instance);
+
 	return 0;
 }
 
-- 
2.25.1

