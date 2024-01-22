Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A6CC47DD9
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 02:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D5A8786B;
	Mon, 22 Jan 2024 03:08:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Q61j6mrS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BE4487867; Mon, 22 Jan 2024 03:08:23 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8618F8786B
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 03:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 19831ff2b8cb11eea2298b7352fd921d-20240122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=cJ2OswlD1Oq09hoGWa82uBzeoipX11lw/8/RQuMFoaI=; 
 b=Q61j6mrSOcRiULqvJFGjSBXnUvTfgEK04NC+zMRMSge9A9J8xOwjXoT20TA8Pe+jv6qtwTpNPM9kSZjIOKk2xb5P0IU8kzAPYFQHVeXf1RiaqM4sBM5IHIXzHT7ysZjjHQhZrtqqcpXvXPcK9K2UXiAnIdx+e2TOv1alSOn53wM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36, REQID:5360429a-bb55-444a-b22e-e6edf84a46f2, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:6e16cf4, CLOUDID:6b9c1883-8d4f-477b-89d2-1e3bdbef96d1,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 19831ff2b8cb11eea2298b7352fd921d-20240122
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1274231021; Mon, 22 Jan 2024 10:08:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 22 Jan 2024 10:08:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 22 Jan 2024 10:08:11 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Daniel Golle
 <daniel@makrotopia.org>, Frank Wunderlich <linux@fw-web.de>,
 Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Subject: [PATCH 02/60] net: mediatek: add support for adjusting MDIO clock
Date: Mon, 22 Jan 2024 10:08:11 +0800
Message-ID: <20240122020811.143358-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.484500-8.000000
X-TMASE-MatchedRID: XR7mIL8ZhIoJnHuXjHwi9wPZZctd3P4BWjWsWQUWzVrgr/zYTDOZCJj2
 3DP9jL7jprhPLBzR/tFCKM8UL7o4C4QHE7x6AHFuDB+ErBr0bAPbKTxp3+WtINEsTITobgNE/Ge
 vfoH427p8p1FS+daYYNJHai6GfGFVHxPMjOKY7A8LbigRnpKlKTpcQTtiHDgWc8yolV7AhwQyYr
 b2qf+8i1QW0friuNMz5Q5RhxvPkUOVkPAbEE+6Gw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.484500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 44D5B5DDBE4B331BF0F6115BC8F553C92DA71F2343B10B328D96D01BCBB280102000:8
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

User can assign a specific MDC speed to the eth node as follow:

&eth {
	...
	phy-mode = "usxgmii";
	phy-handle = <&phy8>;

	mdio {
		clock-frequency = <10500000>;
	};

	phy8: eth-phy@8 {
	      compatible = "ethernet-phy-id31c3.1c12";
	...
};

Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/net/mtk_eth.h |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/net/mtk_eth.c b/drivers/net/mtk_eth.c
index 3cfce05845..726aedad3f 100644
--- a/drivers/net/mtk_eth.c
+++ b/drivers/net/mtk_eth.c
@@ -137,6 +137,7 @@ struct mtk_eth_priv {
 	int force_mode;
 	int speed;
 	int duplex;
+	int mdc;
 	bool pn_swap;
 
 	struct phy_device *phydev;
@@ -1607,6 +1608,26 @@ static void mtk_eth_fifo_init(struct mtk_eth_priv *priv)
 	mtk_pdma_write(priv, PDMA_RST_IDX_REG, RST_DTX_IDX0 | RST_DRX_IDX0);
 }
 
+static void mtk_eth_mdc_init(struct mtk_eth_priv *priv)
+{
+	u32 divider;
+
+	if (priv->mdc == 0)
+		return;
+
+	divider = min_t(u32, DIV_ROUND_UP(MDC_MAX_FREQ, priv->mdc), MDC_MAX_DIVIDER);
+
+	/* Configure MDC turbo mode */
+	if (MTK_HAS_CAPS(priv->soc->caps, MTK_NETSYS_V3))
+		mtk_gmac_rmw(priv, GMAC_MAC_MISC_REG, 0, MISC_MDC_TURBO);
+	else
+		mtk_gmac_rmw(priv, GMAC_PPSC_REG, 0, MISC_MDC_TURBO);
+
+	/* Configure MDC divider */
+	mtk_gmac_rmw(priv, GMAC_PPSC_REG, PHY_MDC_CFG,
+		     FIELD_PREP(PHY_MDC_CFG, divider));
+}
+
 static int mtk_eth_start(struct udevice *dev)
 {
 	struct mtk_eth_priv *priv = dev_get_priv(dev);
@@ -1803,6 +1824,9 @@ static int mtk_eth_probe(struct udevice *dev)
 		noncached_alloc(priv->soc->rxd_size * NUM_RX_DESC,
 				ARCH_DMA_MINALIGN);
 
+	/* Set MDC divider */
+	mtk_eth_mdc_init(priv);
+
 	/* Set MAC mode */
 	if (priv->phy_interface == PHY_INTERFACE_MODE_USXGMII)
 		mtk_xmac_init(priv);
@@ -1881,6 +1905,17 @@ static int mtk_eth_of_to_plat(struct udevice *dev)
 
 	priv->gmac_id = dev_read_u32_default(dev, "mediatek,gmac-id", 0);
 
+	priv->mdc = 0;
+	subnode = ofnode_find_subnode(dev_ofnode(dev), "mdio");
+	if (ofnode_valid(subnode)) {
+		priv->mdc = ofnode_read_u32_default(subnode, "clock-frequency", 2500000);
+		if (priv->mdc > MDC_MAX_FREQ ||
+		    priv->mdc < MDC_MAX_FREQ / MDC_MAX_DIVIDER) {
+			printf("error: MDIO clock frequency out of range\n");
+			return -EINVAL;
+		}
+	}
+
 	/* Interface mode is required */
 	pdata->phy_interface = dev_read_phy_mode(dev);
 	priv->phy_interface = pdata->phy_interface;
diff --git a/drivers/net/mtk_eth.h b/drivers/net/mtk_eth.h
index 491cac56a8..45229c0f9a 100644
--- a/drivers/net/mtk_eth.h
+++ b/drivers/net/mtk_eth.h
@@ -180,6 +180,12 @@ enum mkt_eth_capabilities {
 
 /* GMAC Registers */
 
+#define GMAC_PPSC_REG			0x0000
+#define PHY_MDC_CFG			GENMASK(29, 24)
+#define MDC_TURBO			BIT(20)
+#define MDC_MAX_FREQ			25000000
+#define MDC_MAX_DIVIDER			63
+
 #define GMAC_PIAC_REG			0x0004
 #define PHY_ACS_ST			BIT(31)
 #define MDIO_REG_ADDR_S			25
@@ -197,6 +203,7 @@ enum mkt_eth_capabilities {
 #define P1_XGMAC_FORCE_LINK		BIT(15)
 
 #define GMAC_MAC_MISC_REG		0x0010
+#define MISC_MDC_TURBO			BIT(4)
 
 #define GMAC_GSW_CFG_REG		0x0080
 #define GSWTX_IPG_M			0xF0000
-- 
2.34.1

