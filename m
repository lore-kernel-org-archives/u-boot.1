Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0CCC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 08:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC245807FE;
	Fri, 24 Jan 2025 09:04:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Zj6YRUjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E7580817; Fri, 24 Jan 2025 09:04:55 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E727807E4
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 09:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: dc5f0a88da2911ef99858b75a2457dd9-20250124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From;
 bh=zek40wPFaXV3INx8s7S/Bjda5FyURi7x8SigQICuYEw=; 
 b=Zj6YRUjy0Yyd49b+Mq453jAbTT4OVV4eqx4TteQCe0OWFSS/YV1Idov+0l9A/ujKvrREdntVM0WEtvndwWaYomc4SQ9svZEZprzxa/ILZ9Ez728Il3pQE6aIBxz/rIAWzqiTqHyHwZYH6WJQ2TWWpTEDT/BTOZMOMYDfSqm6qlw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:46c673b4-398a-409a-8785-ff7252b55908, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:640fa23d-da39-4471-8a46-23da908abe46,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dc5f0a88da2911ef99858b75a2457dd9-20250124
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1569148291; Fri, 24 Jan 2025 16:04:39 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 24 Jan 2025 16:04:38 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 24 Jan 2025 16:04:37 +0800
From: Weijie Gao <weijie.gao@mediatek.com>
To: <u-boot@lists.denx.de>
CC: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini
 <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH] net: mediatek: fix coding style of AN8855 switch driver
Date: Fri, 24 Jan 2025 16:04:28 +0800
Message-ID: <20250124080428.195597-1-weijie.gao@mediatek.com>
X-Mailer: git-send-email 2.17.0
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

This patch fixed the following coding style suggested by checkpatch.pl:
1. Use tab instead of space
2. Use BIT() instead of <<
3. Use mdelay for long time delay
4. Remove useless parenthesises

Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
---
 drivers/net/mtk_eth/an8855.c | 89 ++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 45 deletions(-)

diff --git a/drivers/net/mtk_eth/an8855.c b/drivers/net/mtk_eth/an8855.c
index 4bd7506a58b..25a98e0f935 100644
--- a/drivers/net/mtk_eth/an8855.c
+++ b/drivers/net/mtk_eth/an8855.c
@@ -22,7 +22,7 @@
 #define AN8855_FORCE_MODE_LNK			BIT(31)
 #define AN8855_FORCE_MODE			0xb31593f0
 
-#define AN8855_PORT_CTRL_BASE			(0x10208000)
+#define AN8855_PORT_CTRL_BASE			0x10208000
 #define AN8855_PORT_CTRL_REG(p, r)		(AN8855_PORT_CTRL_BASE + (p) * 0x200 + (r))
 
 #define AN8855_PORTMATRIX_REG(p)		AN8855_PORT_CTRL_REG(p, 0x44)
@@ -46,7 +46,7 @@
 
 #define AN8855_CKGCR				0x10213e1c
 
-#define AN8855_SCU_BASE 			0x10000000
+#define AN8855_SCU_BASE				0x10000000
 #define AN8855_RG_RGMII_TXCK_C			(AN8855_SCU_BASE + 0x1d0)
 #define AN8855_RG_GPIO_LED_MODE			(AN8855_SCU_BASE + 0x0054)
 #define AN8855_RG_GPIO_LED_SEL(i)		(AN8855_SCU_BASE + (0x0058 + ((i) * 4)))
@@ -66,23 +66,23 @@
 #define AN8855_RG_HSGMII_PCS_CTROL_1		(AN8855_HSGMII_CSR_PCS_BASE + 0xa00)
 #define AN8855_RG_AN_SGMII_MODE_FORCE		(AN8855_HSGMII_CSR_PCS_BASE + 0xa24)
 
-#define AN8855_MULTI_SGMII_CSR_BASE 		0x10224000
-#define AN8855_SGMII_STS_CTRL_0 		(AN8855_MULTI_SGMII_CSR_BASE + 0x018)
+#define AN8855_MULTI_SGMII_CSR_BASE		0x10224000
+#define AN8855_SGMII_STS_CTRL_0			(AN8855_MULTI_SGMII_CSR_BASE + 0x018)
 #define AN8855_MSG_RX_CTRL_0			(AN8855_MULTI_SGMII_CSR_BASE + 0x100)
-#define AN8855_MSG_RX_LIK_STS_0 		(AN8855_MULTI_SGMII_CSR_BASE + 0x514)
-#define AN8855_MSG_RX_LIK_STS_2 		(AN8855_MULTI_SGMII_CSR_BASE + 0x51c)
+#define AN8855_MSG_RX_LIK_STS_0			(AN8855_MULTI_SGMII_CSR_BASE + 0x514)
+#define AN8855_MSG_RX_LIK_STS_2			(AN8855_MULTI_SGMII_CSR_BASE + 0x51c)
 #define AN8855_PHY_RX_FORCE_CTRL_0		(AN8855_MULTI_SGMII_CSR_BASE + 0x520)
 
-#define AN8855_XFI_CSR_PCS_BASE 		0x10225000
+#define AN8855_XFI_CSR_PCS_BASE			0x10225000
 #define AN8855_RG_USXGMII_AN_CONTROL_0		(AN8855_XFI_CSR_PCS_BASE + 0xbf8)
 
 #define AN8855_MULTI_PHY_RA_CSR_BASE		0x10226000
-#define AN8855_RG_RATE_ADAPT_CTRL_0 		(AN8855_MULTI_PHY_RA_CSR_BASE + 0x000)
+#define AN8855_RG_RATE_ADAPT_CTRL_0		(AN8855_MULTI_PHY_RA_CSR_BASE + 0x000)
 #define AN8855_RATE_ADP_P0_CTRL_0		(AN8855_MULTI_PHY_RA_CSR_BASE + 0x100)
-#define AN8855_MII_RA_AN_ENABLE 		(AN8855_MULTI_PHY_RA_CSR_BASE + 0x300)
+#define AN8855_MII_RA_AN_ENABLE			(AN8855_MULTI_PHY_RA_CSR_BASE + 0x300)
 
 #define AN8855_QP_DIG_CSR_BASE			0x1022a000
-#define AN8855_QP_CK_RST_CTRL_4 		(AN8855_QP_DIG_CSR_BASE + 0x310)
+#define AN8855_QP_CK_RST_CTRL_4			(AN8855_QP_DIG_CSR_BASE + 0x310)
 #define AN8855_QP_DIG_MODE_CTRL_0		(AN8855_QP_DIG_CSR_BASE + 0x324)
 #define AN8855_QP_DIG_MODE_CTRL_1		(AN8855_QP_DIG_CSR_BASE + 0x330)
 
@@ -90,7 +90,7 @@
 #define AN8855_PON_RXFEDIG_CTRL_0		(AN8855_QP_PMA_TOP_BASE + 0x100)
 #define AN8855_PON_RXFEDIG_CTRL_9		(AN8855_QP_PMA_TOP_BASE + 0x124)
 
-#define AN8855_SS_LCPLL_PWCTL_SETTING_2 	(AN8855_QP_PMA_TOP_BASE + 0x208)
+#define AN8855_SS_LCPLL_PWCTL_SETTING_2		(AN8855_QP_PMA_TOP_BASE + 0x208)
 #define AN8855_SS_LCPLL_TDC_FLT_2		(AN8855_QP_PMA_TOP_BASE + 0x230)
 #define AN8855_SS_LCPLL_TDC_FLT_5		(AN8855_QP_PMA_TOP_BASE + 0x23c)
 #define AN8855_SS_LCPLL_TDC_PCW_1		(AN8855_QP_PMA_TOP_BASE + 0x248)
@@ -101,7 +101,7 @@
 #define AN8855_PLL_CTRL_3			(AN8855_QP_PMA_TOP_BASE + 0x40c)
 #define AN8855_PLL_CTRL_4			(AN8855_QP_PMA_TOP_BASE + 0x410)
 #define AN8855_PLL_CK_CTRL_0			(AN8855_QP_PMA_TOP_BASE + 0x414)
-#define AN8855_RX_DLY_0 			(AN8855_QP_PMA_TOP_BASE + 0x614)
+#define AN8855_RX_DLY_0				(AN8855_QP_PMA_TOP_BASE + 0x614)
 #define AN8855_RX_CTRL_2			(AN8855_QP_PMA_TOP_BASE + 0x630)
 #define AN8855_RX_CTRL_5			(AN8855_QP_PMA_TOP_BASE + 0x63c)
 #define AN8855_RX_CTRL_6			(AN8855_QP_PMA_TOP_BASE + 0x640)
@@ -118,7 +118,7 @@
 #define AN8855_RG_QP_CDR_PR_CKREF_DIV1		(AN8855_QP_ANA_CSR_BASE + 0x18)
 #define AN8855_RG_QP_CDR_PR_KBAND_DIV_PCIE	(AN8855_QP_ANA_CSR_BASE + 0x1c)
 #define AN8855_RG_QP_CDR_FORCE_IBANDLPF_R_OFF	(AN8855_QP_ANA_CSR_BASE + 0x20)
-#define AN8855_RG_QP_TX_MODE_16B_EN 		(AN8855_QP_ANA_CSR_BASE + 0x28)
+#define AN8855_RG_QP_TX_MODE_16B_EN		(AN8855_QP_ANA_CSR_BASE + 0x28)
 #define AN8855_RG_QP_PLL_IPLL_DIG_PWR_SEL	(AN8855_QP_ANA_CSR_BASE + 0x3c)
 #define AN8855_RG_QP_PLL_SDM_ORD		(AN8855_QP_ANA_CSR_BASE + 0x40)
 
@@ -135,49 +135,49 @@
 #define PHY_SINGLE_LED_ON_DUR(i)		(0x3e9 + ((i) * 2))
 #define PHY_SINGLE_LED_BLK_DUR(i)		(0x3ea + ((i) * 2))
 
-#define PHY_PMA_CTRL				(0x340)
+#define PHY_PMA_CTRL				0x340
 
 #define PHY_DEV1F				0x1f
 
 #define PHY_LED_ON_CTRL(i)			(0x24 + ((i) * 2))
-#define LED_ON_EN				(1 << 15)
-#define LED_ON_POL				(1 << 14)
-#define LED_ON_EVT_MASK				(0x7f)
+#define LED_ON_EN				BIT(15)
+#define LED_ON_POL				BIT(14)
+#define LED_ON_EVT_MASK				0x7f
 
 /* LED ON Event */
-#define LED_ON_EVT_FORCE			(1 << 6)
-#define LED_ON_EVT_LINK_HD			(1 << 5)
-#define LED_ON_EVT_LINK_FD			(1 << 4)
-#define LED_ON_EVT_LINK_DOWN			(1 << 3)
-#define LED_ON_EVT_LINK_10M			(1 << 2)
-#define LED_ON_EVT_LINK_100M			(1 << 1)
-#define LED_ON_EVT_LINK_1000M			(1 << 0)
+#define LED_ON_EVT_FORCE			BIT(6)
+#define LED_ON_EVT_LINK_HD			BIT(5)
+#define LED_ON_EVT_LINK_FD			BIT(4)
+#define LED_ON_EVT_LINK_DOWN			BIT(3)
+#define LED_ON_EVT_LINK_10M			BIT(2)
+#define LED_ON_EVT_LINK_100M			BIT(1)
+#define LED_ON_EVT_LINK_1000M			BIT(0)
 
 #define PHY_LED_BLK_CTRL(i)			(0x25 + ((i) * 2))
-#define LED_BLK_EVT_MASK			(0x3ff)
+#define LED_BLK_EVT_MASK			0x3ff
 /* LED Blinking Event */
-#define LED_BLK_EVT_FORCE			(1 << 9)
-#define LED_BLK_EVT_10M_RX_ACT			(1 << 5)
-#define LED_BLK_EVT_10M_TX_ACT			(1 << 4)
-#define LED_BLK_EVT_100M_RX_ACT			(1 << 3)
-#define LED_BLK_EVT_100M_TX_ACT			(1 << 2)
-#define LED_BLK_EVT_1000M_RX_ACT		(1 << 1)
-#define LED_BLK_EVT_1000M_TX_ACT		(1 << 0)
+#define LED_BLK_EVT_FORCE			BIT(9)
+#define LED_BLK_EVT_10M_RX_ACT			BIT(5)
+#define LED_BLK_EVT_10M_TX_ACT			BIT(4)
+#define LED_BLK_EVT_100M_RX_ACT			BIT(3)
+#define LED_BLK_EVT_100M_TX_ACT			BIT(2)
+#define LED_BLK_EVT_1000M_RX_ACT		BIT(1)
+#define LED_BLK_EVT_1000M_TX_ACT		BIT(0)
 
 #define PHY_LED_BCR				(0x21)
-#define LED_BCR_EXT_CTRL			(1 << 15)
-#define LED_BCR_CLK_EN				(1 << 3)
-#define LED_BCR_TIME_TEST			(1 << 2)
-#define LED_BCR_MODE_MASK			(3)
-#define LED_BCR_MODE_DISABLE			(0)
+#define LED_BCR_EXT_CTRL			BIT(15)
+#define LED_BCR_CLK_EN				BIT(3)
+#define LED_BCR_TIME_TEST			BIT(2)
+#define LED_BCR_MODE_MASK			3
+#define LED_BCR_MODE_DISABLE			0
 
-#define PHY_LED_ON_DUR				(0x22)
-#define LED_ON_DUR_MASK				(0xffff)
+#define PHY_LED_ON_DUR				0x22
+#define LED_ON_DUR_MASK				0xffff
 
-#define PHY_LED_BLK_DUR				(0x23)
-#define LED_BLK_DUR_MASK			(0xffff)
+#define PHY_LED_BLK_DUR				0x23
+#define LED_BLK_DUR_MASK			0xffff
 
-#define PHY_LED_BLINK_DUR_CTRL			(0x720)
+#define PHY_LED_BLINK_DUR_CTRL			0x720
 
 /* Definition of LED */
 #define LED_ON_EVENT	(LED_ON_EVT_LINK_1000M | \
@@ -993,7 +993,7 @@ static int an8855_setup(struct mtk_eth_switch_priv *swpriv)
 
 	/* Switch soft reset */
 	an8855_reg_write(priv, AN8855_SYS_CTRL_REG, AN8855_SW_SYS_RST);
-	udelay(100000);
+	mdelay(100);
 
 	an8855_reg_read(priv, AN8855_PKG_SEL, &val);
 	if ((val & 0x7) == PAG_SEL_AN8855H) {
@@ -1003,8 +1003,7 @@ static int an8855_setup(struct mtk_eth_switch_priv *swpriv)
 		/* Invert for LED activity change */
 		an8855_reg_read(priv, AN8855_RG_GPIO_L_INV, &val);
 		for (id = 0; id < ARRAY_SIZE(led_cfg); id++) {
-			if ((led_cfg[id].pol == LED_HIGH) &&
-			    (led_cfg[id].en == 1))
+			if (led_cfg[id].pol == LED_HIGH && led_cfg[id].en == 1)
 				val |= 0x1 << id;
 		}
 		an8855_reg_write(priv, AN8855_RG_GPIO_L_INV, (val | 0x1));
-- 
2.34.1

