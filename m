Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9126DC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D646A83260;
	Tue,  8 Apr 2025 00:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="w0eNiyo3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB2F983260; Tue,  8 Apr 2025 00:49:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A92D8327A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066174; bh=xGdR2Kgpp+p+3z2lEgmlu2rH/VHrjyw01uRJlClP7J8=;
 b=w0eNiyo3clqrq2NsAKhd0oKSGbIrZ8c1Jkoq7PYtL2C74EUqf3VGWUSHfE5GpdTT5F4BFYSPd
 1xolVLO26SDKnFl6nv3EzLvX81I25XpaNYcHyL9ya1f5tgD7+CSgf4zoM2uYPz7tmksdi8oJKf1
 48OMrnQ0r9kjQfYB1Ivh7Xvu4F3ykMsAWDH0Zj12TbXRdmHWx708hYeIiWczSh4QkczESEQPhZS
 yplnwAi64TUms9psWx9uQAjWSDJ/NjeqUzXdmBKUxCCOLHcinKfgE6jrNKgdlgfOcEugxLx87ki
 BPZeKRfz+O3oQ68Jfai6xmELcx49lw9C2GquvFeaYqkg==
X-Forward-Email-ID: 67f4567d9fd75b9b965129d6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 28/30] net: dwc_eth_qos_rockchip: Add support for RK3528
Date: Mon,  7 Apr 2025 22:47:01 +0000
Message-ID: <20250407224743.2423921-29-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Rockchip RK3528 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add initial support for the RK3528 GMAC variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/net/dwc_eth_qos.c          |   4 +
 drivers/net/dwc_eth_qos_rockchip.c | 138 +++++++++++++++++++++++++++++
 2 files changed, 142 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index b4ec3614696e..d4561784a6ec 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1611,6 +1611,10 @@ static const struct udevice_id eqos_ids[] = {
 	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
+	{
+		.compatible = "rockchip,rk3528-gmac",
+		.data = (ulong)&eqos_rockchip_config
+	},
 	{
 		.compatible = "rockchip,rk3568-gmac",
 		.data = (ulong)&eqos_rockchip_config
diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index f3a0f63003ea..3a9c46a01ec3 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -50,6 +50,132 @@ struct rockchip_platform_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define RK3528_VO_GRF_GMAC_CON		0x0018
+#define RK3528_VPU_GRF_GMAC_CON5	0x0018
+#define RK3528_VPU_GRF_GMAC_CON6	0x001c
+
+#define RK3528_GMAC_RXCLK_DLY_ENABLE	GRF_BIT(15)
+#define RK3528_GMAC_RXCLK_DLY_DISABLE	GRF_CLR_BIT(15)
+#define RK3528_GMAC_TXCLK_DLY_ENABLE	GRF_BIT(14)
+#define RK3528_GMAC_TXCLK_DLY_DISABLE	GRF_CLR_BIT(14)
+
+#define RK3528_GMAC_CLK_RX_DL_CFG(val)	HIWORD_UPDATE(val, 0xFF, 8)
+#define RK3528_GMAC_CLK_TX_DL_CFG(val)	HIWORD_UPDATE(val, 0xFF, 0)
+
+#define RK3528_GMAC0_PHY_INTF_SEL_RMII	GRF_BIT(1)
+#define RK3528_GMAC1_PHY_INTF_SEL_RGMII	GRF_CLR_BIT(8)
+#define RK3528_GMAC1_PHY_INTF_SEL_RMII	GRF_BIT(8)
+
+#define RK3528_GMAC1_CLK_SELECT_CRU	GRF_CLR_BIT(12)
+#define RK3528_GMAC1_CLK_SELECT_IO	GRF_BIT(12)
+
+#define RK3528_GMAC0_CLK_RMII_DIV2	GRF_BIT(3)
+#define RK3528_GMAC0_CLK_RMII_DIV20	GRF_CLR_BIT(3)
+#define RK3528_GMAC1_CLK_RMII_DIV2	GRF_BIT(10)
+#define RK3528_GMAC1_CLK_RMII_DIV20	GRF_CLR_BIT(10)
+
+#define RK3528_GMAC1_CLK_RGMII_DIV1	(GRF_CLR_BIT(11) | GRF_CLR_BIT(10))
+#define RK3528_GMAC1_CLK_RGMII_DIV5	(GRF_BIT(11) | GRF_BIT(10))
+#define RK3528_GMAC1_CLK_RGMII_DIV50	(GRF_BIT(11) | GRF_CLR_BIT(10))
+
+#define RK3528_GMAC0_CLK_RMII_GATE	GRF_BIT(2)
+#define RK3528_GMAC0_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
+#define RK3528_GMAC1_CLK_RMII_GATE	GRF_BIT(9)
+#define RK3528_GMAC1_CLK_RMII_NOGATE	GRF_CLR_BIT(9)
+
+static int rk3528_set_to_rgmii(struct udevice *dev,
+			       int tx_delay, int rx_delay)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+
+	regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5,
+		     RK3528_GMAC1_PHY_INTF_SEL_RGMII);
+
+	regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5,
+		     DELAY_ENABLE(RK3528, tx_delay, rx_delay));
+
+	regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON6,
+		     RK3528_GMAC_CLK_RX_DL_CFG(rx_delay) |
+		     RK3528_GMAC_CLK_TX_DL_CFG(tx_delay));
+
+	return 0;
+}
+
+static int rk3528_set_to_rmii(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+
+	if (data->id == 1)
+		regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5,
+			     RK3528_GMAC1_PHY_INTF_SEL_RMII);
+	else
+		regmap_write(data->grf, RK3528_VO_GRF_GMAC_CON,
+			     RK3528_GMAC0_PHY_INTF_SEL_RMII |
+			     RK3528_GMAC0_CLK_RMII_DIV2);
+
+	return 0;
+}
+
+static int rk3528_set_gmac_speed(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 val, reg;
+
+	switch (eqos->phy->speed) {
+	case SPEED_10:
+		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
+			val = data->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV20 :
+					      RK3528_GMAC0_CLK_RMII_DIV20;
+		else
+			val = RK3528_GMAC1_CLK_RGMII_DIV50;
+		break;
+	case SPEED_100:
+		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
+			val = data->id == 1 ? RK3528_GMAC1_CLK_RMII_DIV2 :
+					      RK3528_GMAC0_CLK_RMII_DIV2;
+		else
+			val = RK3528_GMAC1_CLK_RGMII_DIV5;
+		break;
+	case SPEED_1000:
+		if (pdata->phy_interface != PHY_INTERFACE_MODE_RMII)
+			val = RK3528_GMAC1_CLK_RGMII_DIV1;
+		else
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = data->id == 1 ? RK3528_VPU_GRF_GMAC_CON5 :
+			      RK3528_VO_GRF_GMAC_CON;
+	regmap_write(data->grf, reg, val);
+
+	return 0;
+}
+
+static void rk3528_set_clock_selection(struct udevice *dev, bool enable)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 val;
+
+	if (data->id == 1) {
+		val = data->clock_input ? RK3528_GMAC1_CLK_SELECT_IO :
+					  RK3528_GMAC1_CLK_SELECT_CRU;
+		val |= enable ? RK3528_GMAC1_CLK_RMII_NOGATE :
+				RK3528_GMAC1_CLK_RMII_GATE;
+		regmap_write(data->grf, RK3528_VPU_GRF_GMAC_CON5, val);
+	} else {
+		val = enable ? RK3528_GMAC0_CLK_RMII_NOGATE :
+			       RK3528_GMAC0_CLK_RMII_GATE;
+		regmap_write(data->grf, RK3528_VO_GRF_GMAC_CON, val);
+	}
+}
+
 #define RK3568_GRF_GMAC0_CON0		0x0380
 #define RK3568_GRF_GMAC0_CON1		0x0384
 #define RK3568_GRF_GMAC1_CON0		0x0388
@@ -269,6 +395,18 @@ static void rk3588_set_clock_selection(struct udevice *dev, bool enable)
 }
 
 static const struct rk_gmac_ops rk_gmac_ops[] = {
+	{
+		.compatible = "rockchip,rk3528-gmac",
+		.set_to_rgmii = rk3528_set_to_rgmii,
+		.set_to_rmii = rk3528_set_to_rmii,
+		.set_gmac_speed = rk3528_set_gmac_speed,
+		.set_clock_selection = rk3528_set_clock_selection,
+		.regs = {
+			0xffbd0000, /* gmac0 */
+			0xffbe0000, /* gmac1 */
+			0x0, /* sentinel */
+		},
+	},
 	{
 		.compatible = "rockchip,rk3568-gmac",
 		.set_to_rgmii = rk3568_set_to_rgmii,
-- 
2.49.0

