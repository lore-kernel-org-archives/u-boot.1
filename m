Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B26C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 22:22:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81BF582C7F;
	Wed, 16 Apr 2025 00:22:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="r+T3/l4i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3546682B44; Wed, 16 Apr 2025 00:22:24 +0200 (CEST)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2998482C8D
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 00:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=/eJ4Q4DZCUg9hvPWdopy9lP4TgSRsN+mHLUT9xo3EzU=; b=r+T3/l4iCAxeAsSy3aCmsQ/j0d
 PWUenE80413ZON25mXqkGmZOpZog5vyLhqL4kxquDQiVRymPA31H321qQtT+lT/yR2UjKoGNHw1Q2
 Tye4RO58HRAwGO7/eL6VlryaH0ycnhiRRcqwLNoADYATtLmOLN3bx27EC3vLyxK9qbxVKCfS3ejUn
 94TgBy4sV3JhxwUOtCLLRLSbb/1dAlFM5U/AFIePy302bfunM1OxiDIHtHjDhMyJ5JWUEh1aDRKIw
 q7lWlpgF21BksEpcqLE/H5j2xJPo4mP47xASdGrOR7Mw0EOzTTGKbWGrRlTXV5JxuT4fr10QusslY
 GQW3Q7Cw==;
Received: from i53875b95.versanet.de ([83.135.91.149]
 helo=localhost.localdomain)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1u4oCJ-0007Uo-N2; Tue, 15 Apr 2025 23:52:03 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de, lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, quentin.schulz@cherry.de, detlev.casanova@collabora.com,
 u-boot@lists.denx.de, sebastian.reichel@collabora.com
Subject: [PATCH v3 11/15] net: dwc_eth_qos_rockchip: Add support for RK3576
Date: Tue, 15 Apr 2025 23:51:24 +0200
Message-ID: <20250415215128.1475593-12-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250415215128.1475593-1-heiko@sntech.de>
References: <20250415215128.1475593-1-heiko@sntech.de>
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
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos.c          |   4 +
 drivers/net/dwc_eth_qos_rockchip.c | 154 ++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index d4561784a6e..b1bc422f791 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1619,6 +1619,10 @@ static const struct udevice_id eqos_ids[] = {
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
index 3a9c46a01ec..d646d3ebac8 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -260,6 +260,145 @@ static int rk3568_set_gmac_speed(struct udevice *dev)
 	return 0;
 }
 
+/* VCCIO0_1_3_IOC */
+#define RK3576_VCCIO0_1_3_IOC_CON2		0x6408
+#define RK3576_VCCIO0_1_3_IOC_CON3		0x640c
+#define RK3576_VCCIO0_1_3_IOC_CON4		0x6410
+#define RK3576_VCCIO0_1_3_IOC_CON5		0x6414
+
+#define RK3576_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(15)
+#define RK3576_GMAC_RXCLK_DLY_DISABLE		GRF_CLR_BIT(15)
+#define RK3576_GMAC_TXCLK_DLY_ENABLE		GRF_BIT(7)
+#define RK3576_GMAC_TXCLK_DLY_DISABLE		GRF_CLR_BIT(7)
+
+#define RK3576_GMAC_CLK_RX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 8)
+#define RK3576_GMAC_CLK_TX_DL_CFG(val)		HIWORD_UPDATE(val, 0x7F, 0)
+
+/* SDGMAC_GRF */
+#define RK3576_GRF_GMAC_CON0			0x0020
+#define RK3576_GRF_GMAC_CON1			0x0024
+
+#define RK3576_GMAC_RMII_MODE			GRF_BIT(3)
+#define RK3576_GMAC_RGMII_MODE			GRF_CLR_BIT(3)
+
+#define RK3576_GMAC_CLK_SELECT_IO		GRF_BIT(7)
+#define RK3576_GMAC_CLK_SELECT_CRU		GRF_CLR_BIT(7)
+
+#define RK3576_GMAC_CLK_RMII_DIV2		GRF_BIT(5)
+#define RK3576_GMAC_CLK_RMII_DIV20		GRF_CLR_BIT(5)
+
+#define RK3576_GMAC_CLK_RGMII_DIV1		\
+			(GRF_CLR_BIT(6) | GRF_CLR_BIT(5))
+#define RK3576_GMAC_CLK_RGMII_DIV5		\
+			(GRF_BIT(6) | GRF_BIT(5))
+#define RK3576_GMAC_CLK_RGMII_DIV50		\
+			(GRF_BIT(6) | GRF_CLR_BIT(5))
+
+#define RK3576_GMAC_CLK_RMII_GATE		GRF_BIT(4)
+#define RK3576_GMAC_CLK_RMII_NOGATE		GRF_CLR_BIT(4)
+
+static int rk3576_set_to_rgmii(struct udevice *dev,
+			       int tx_delay, int rx_delay)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 offset_con;
+
+	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
+				     RK3576_GRF_GMAC_CON0;
+
+	regmap_write(data->grf, offset_con, RK3576_GMAC_RGMII_MODE);
+
+	offset_con = data->id == 1 ? RK3576_VCCIO0_1_3_IOC_CON4 :
+				     RK3576_VCCIO0_1_3_IOC_CON2;
+
+	/* m0 && m1 delay enabled */
+	regmap_write(data->php_grf, offset_con,
+		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
+	regmap_write(data->php_grf, offset_con + 0x4,
+		     DELAY_ENABLE(RK3576, tx_delay, rx_delay));
+
+	/* m0 && m1 delay value */
+	regmap_write(data->php_grf, offset_con,
+		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
+		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
+	regmap_write(data->php_grf, offset_con + 0x4,
+		     RK3576_GMAC_CLK_TX_DL_CFG(tx_delay) |
+		     RK3576_GMAC_CLK_RX_DL_CFG(rx_delay));
+
+	return 0;
+}
+
+static int rk3576_set_to_rmii(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 offset_con;
+
+	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
+				     RK3576_GRF_GMAC_CON0;
+
+	regmap_write(data->grf, offset_con, RK3576_GMAC_RMII_MODE);
+
+	return 0;
+}
+
+static int rk3576_set_gmac_speed(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 val = 0, offset_con;
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
+	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
+				     RK3576_GRF_GMAC_CON0;
+
+	regmap_write(data->grf, offset_con, val);
+
+	return 0;
+}
+
+static void rk3576_set_clock_selection(struct udevice *dev, bool enable)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+
+	u32 val = data->clock_input ? RK3576_GMAC_CLK_SELECT_IO :
+				      RK3576_GMAC_CLK_SELECT_CRU;
+	u32 offset_con;
+
+	val |= enable ? RK3576_GMAC_CLK_RMII_NOGATE :
+			RK3576_GMAC_CLK_RMII_GATE;
+
+	offset_con = data->id == 1 ? RK3576_GRF_GMAC_CON1 :
+				     RK3576_GRF_GMAC_CON0;
+
+	regmap_write(data->grf, offset_con, val);
+}
+
 #define RK3588_DELAY_ENABLE(id, tx, rx) \
 	(((tx) ? RK3588_GMAC_TXCLK_DLY_ENABLE(id) : RK3588_GMAC_TXCLK_DLY_DISABLE(id)) | \
 	 ((rx) ? RK3588_GMAC_RXCLK_DLY_ENABLE(id) : RK3588_GMAC_RXCLK_DLY_DISABLE(id)))
@@ -418,6 +557,18 @@ static const struct rk_gmac_ops rk_gmac_ops[] = {
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
@@ -495,7 +646,8 @@ static int eqos_probe_resources_rk(struct udevice *dev)
 		goto err_free;
 	}
 
-	if (device_is_compatible(dev, "rockchip,rk3588-gmac")) {
+	if (device_is_compatible(dev, "rockchip,rk3588-gmac") ||
+	    device_is_compatible(dev, "rockchip,rk3576-gmac")) {
 		data->php_grf =
 			syscon_regmap_lookup_by_phandle(dev, "rockchip,php-grf");
 		if (IS_ERR(data->php_grf)) {
-- 
2.47.2

