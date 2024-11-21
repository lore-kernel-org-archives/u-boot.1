Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857FCD7876B
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 14:31:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E55D89672;
	Thu, 21 Nov 2024 15:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="asbt5uFu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD22D89766; Thu, 21 Nov 2024 15:30:58 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D607088D90
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 15:30:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4qG5zQRlMP908tJN6aPMEMSEj3Tot7KSOJS3qWjHao0=; b=asbt5uFuSfcy1qAnjiS1Fbhs7Y
 C0xxFy/pV1la/8MeciSFKX3FjcWzhuFXnOSU7AU6fIR604LW/Q3tw4GOKgqeqL6oUhvU1dZMfzs4c
 jIsI7ZFdFz4budCq+1WsVXWc/oSKqjMFvNHhErCdOMkwRe1lgLR2YJvNV1QbBL61GqnV7LRq4az7l
 mpzK8Of/V9lAKDyznh/Z2P6H69xFqlzDSdvJlOerIqm2QfGjetl3BCirnuLF3vo8gfl0Oj9/ERprZ
 Dm37+187HkIp/xCt7YkP0zG1MN8HtONoSrAFVozjsEAa/y2pMcl2dU8Uzv/KeZAdtERuogcunzPKv
 vjv47hXg==;
Received: from [185.156.123.69] (helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1tE8A7-0007f9-Dg; Thu, 21 Nov 2024 15:28:03 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH 19/20] net: dwc_eth_qos_rockchip: Add support for RK3576
Date: Thu, 21 Nov 2024 15:27:30 +0100
Message-ID: <20241121142731.1202209-20-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241121142731.1202209-1-heiko@sntech.de>
References: <20241121142731.1202209-1-heiko@sntech.de>
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

Add rk_gmac_ops and other special handling that is needed for GMAC to
work on RK3576.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/net/dwc_eth_qos.c          |   4 +
 drivers/net/dwc_eth_qos_rockchip.c | 141 ++++++++++++++++++++++++++++-
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 2279481d935..1a05d285576 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1615,6 +1615,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "rockchip,rk3568-gmac",
 		.data = (ulong)&eqos_rockchip_config
 	},
+	{
+		.compatible = "rockchip,rk3576-gmac",
+		.data = (ulong)&eqos_rockchip_config
+	},
 	{
 		.compatible = "rockchip,rk3588-gmac",
 		.data = (ulong)&eqos_rockchip_config
diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index 9fc8c686b88..7115fe49bd5 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -131,6 +131,132 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
 	return 0;
 }
 
+#define RK3576_SDGMAC_GRF_GMAC0_CON		0x020
+#define RK3576_SDGMAC_GRF_GMAC1_CON		0x024
+
+#define RK3576_GMAC_CLK_RMII_MODE		GRF_BIT(3)
+#define RK3576_GMAC_CLK_RGMII_MODE		GRF_CLR_BIT(3)
+
+#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
+#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
+#define RK3576_GMAC_CLK_RGMII_DIV1		(GRF_CLR_BIT(5) | GRF_CLR_BIT(6))
+#define RK3576_GMAC_CLK_RGMII_DIV5		(GRF_BIT(5) | GRF_BIT(6))
+#define RK3576_GMAC_CLK_RGMII_DIV50		(GRF_CLR_BIT(5) | GRF_BIT(6))
+
+/* FIXME-check: in TRM swapped compared to rk3588 */
+#define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
+#define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
+
+#define RK3576_GMAC_CLK_GATE			GRF_BIT(0)
+#define RK3576_GMAC_CLK_NOGATE			GRF_CLR_BIT(0)
+
+#define RK3576_IOC_GRF_MISC_CON2		0x6408
+#define RK3576_IOC_GRF_MISC_CON3		0x640c
+#define RK3576_IOC_GRF_MISC_CON4		0x6410
+#define RK3576_IOC_GRF_MISC_CON5		0x6414
+
+#define RK3576_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(15)
+#define RK3576_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(15)
+#define RK3576_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7f, 8)
+#define RK3576_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(7)
+#define RK3576_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(7)
+#define RK3576_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7f, 0)
+
+static int rk3576_set_to_rgmii(struct udevice *dev,
+			       int tx_delay, int rx_delay)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 delay_con_m0, delay_con_m1, con, val;
+
+	con = (data->id == 1) ? RK3576_SDGMAC_GRF_GMAC1_CON :
+				RK3576_SDGMAC_GRF_GMAC0_CON;
+	regmap_write(data->grf, con, RK3576_GMAC_CLK_RGMII_MODE);
+
+	delay_con_m0 = data->id ? RK3576_IOC_GRF_MISC_CON4 :
+				      RK3576_IOC_GRF_MISC_CON2;
+	delay_con_m1 = data->id ? RK3576_IOC_GRF_MISC_CON5 :
+				      RK3576_IOC_GRF_MISC_CON3;
+
+	val = RK3576_GMAC_RXCLK_DLY_ENABLE | RK3576_GMAC_TXCLK_DLY_ENABLE;
+	val |= RK3576_GMAC_CLK_RX_DL_CFG(rx_delay);
+	val |= RK3576_GMAC_CLK_TX_DL_CFG(tx_delay);
+
+	regmap_write(data->php_grf, delay_con_m0, val);
+	regmap_write(data->php_grf, delay_con_m1, val);
+
+	return 0;
+}
+
+static int rk3576_set_to_rmii(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 con;
+
+	con = (data->id == 1) ? RK3576_SDGMAC_GRF_GMAC1_CON :
+				RK3576_SDGMAC_GRF_GMAC0_CON;
+	regmap_write(data->grf, con, RK3576_GMAC_CLK_RMII_MODE);
+
+	return 0;
+}
+
+static int rk3576_set_gmac_speed(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 con, val;
+
+	con = (data->id == 1) ? RK3576_SDGMAC_GRF_GMAC1_CON :
+				RK3576_SDGMAC_GRF_GMAC0_CON;
+
+	switch (eqos->phy->speed) {
+	case SPEED_10:
+		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
+			val = RK3576_GMAC_CLK_RMII_DIV20;
+		else
+			val = RK3576_GMAC_CLK_RGMII_DIV50;
+		break;
+	case SPEED_100:
+		if (pdata->phy_interface == PHY_INTERFACE_MODE_RMII)
+			val = RK3576_GMAC_CLK_RMII_DIV2;
+		else
+			val = RK3576_GMAC_CLK_RGMII_DIV5;
+		break;
+	case SPEED_1000:
+		if (pdata->phy_interface != PHY_INTERFACE_MODE_RMII)
+			val = RK3576_GMAC_CLK_RGMII_DIV1;
+		else
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_write(data->grf, con, val);
+
+	return 0;
+}
+
+static void rk3576_set_clock_selection(struct udevice *dev, bool enable)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 con, val;
+
+	con = (data->id == 1) ? RK3576_SDGMAC_GRF_GMAC1_CON :
+				RK3576_SDGMAC_GRF_GMAC0_CON;
+
+	val = data->clock_input ? RK3576_GMAC_CLK_SELECT_IO :
+				  RK3576_GMAC_CLK_SELECT_CRU;
+
+	val |= enable ? RK3576_GMAC_CLK_NOGATE :
+			RK3576_GMAC_CLK_GATE;
+
+	regmap_write(data->grf, con, val);
+}
+
 /* sys_grf */
 #define RK3588_GRF_GMAC_CON7			0x031c
 #define RK3588_GRF_GMAC_CON8			0x0320
@@ -274,6 +400,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] = {
 			0x0, /* sentinel */
 		},
 	},
+	{
+		.compatible = "rockchip,rk3576-gmac",
+		.set_to_rgmii = rk3576_set_to_rgmii,
+		.set_to_rmii = rk3576_set_to_rmii,
+		.set_gmac_speed = rk3576_set_gmac_speed,
+		.set_clock_selection = rk3576_set_clock_selection,
+		.regs = {
+			0x2a220000, /* gmac0 */
+			0x2a230000, /* gmac1 */
+			0x0, /* sentinel */
+		},
+	},
 	{
 		.compatible = "rockchip,rk3588-gmac",
 		.set_to_rgmii = rk3588_set_to_rgmii,
@@ -351,7 +489,8 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 		goto err_free;
 	}
 
-	if (device_is_compatible(dev, "rockchip,rk3588-gmac")) {
+	if (device_is_compatible(dev, "rockchip,rk3588-gmac") ||
+	    device_is_compatible(dev, "rockchip,rk3576-gmac")) {
 		data->php_grf =
 			syscon_regmap_lookup_by_phandle(dev, "rockchip,php-grf");
 		if (IS_ERR(data->php_grf)) {
-- 
2.45.2

