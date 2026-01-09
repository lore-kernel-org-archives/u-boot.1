Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CDBD232C7
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 00:51:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21CAD841FF;
	Fri,  9 Jan 2026 01:50:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CrV7bF3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0863584353; Fri,  9 Jan 2026 01:50:50 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D18484144
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 01:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1767919846; bh=56BdUfv8vOyyAyenl39d9RfhPDkZMtx2wtIQXvBCzxo=;
 b=CrV7bF3UVbmbOSLaA9rdgYXQEW0VnV8c2BL/OCIvV3ofJUuUQsfHyPwJO/H5LlqCmyTSqc5RR
 c+VKV5075Ioy4/m97vF9/5hskKEe5Xkxg9dB3p2PATzGoPQl9t5GT5xHEdAFz0KJ48EMFKUX+tL
 FJclmsKpVrI1t2b2ZsrFaV0VwYOFsppKZQ89nm1yW3TqYJbFHqlvif92YYF1xAOgFjn1U4qQskz
 +7b8zU/yEfIHd4yQnB3/m+LUuQ4vZmPgplKmUDdTIs6n/N3yK+dl4BqW+izv8Mp1xcUllc5pLtF
 xj04wRWqoEkAOQwKli0rji5mwOmX5a8ZV/nYDhjhgooA==
X-Forward-Email-ID: 696050e1abab7b035309fbca
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Jerome Forissier <jerome@forissier.org>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 09/10] net: dwc_eth_qos_rockchip: Add support for RK3506
Date: Fri,  9 Jan 2026 00:49:50 +0000
Message-ID: <20260109005008.101506-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109005008.101506-1-jonas@kwiboo.se>
References: <20260109005008.101506-1-jonas@kwiboo.se>
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

Rockchip RK3506 has two Ethernet controllers based on Synopsys DWC
Ethernet QoS IP.

Add initial support for the RK3506 GMAC variant.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/dwc_eth_qos.c          |  4 ++
 drivers/net/dwc_eth_qos_rockchip.c | 86 ++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 551ee0ea6a02..d320646b57f5 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1615,6 +1615,10 @@ static const struct udevice_id eqos_ids[] = {
 	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_ROCKCHIP)
+	{
+		.compatible = "rockchip,rk3506-gmac",
+		.data = (ulong)&eqos_rockchip_config
+	},
 	{
 		.compatible = "rockchip,rk3528-gmac",
 		.data = (ulong)&eqos_rockchip_config
diff --git a/drivers/net/dwc_eth_qos_rockchip.c b/drivers/net/dwc_eth_qos_rockchip.c
index d646d3ebac87..4ccefda0ef5e 100644
--- a/drivers/net/dwc_eth_qos_rockchip.c
+++ b/drivers/net/dwc_eth_qos_rockchip.c
@@ -50,6 +50,80 @@ struct rockchip_platform_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define RK3506_GRF_SOC_CON8		0x0020
+#define RK3506_GRF_SOC_CON11		0x002c
+
+#define RK3506_GMAC_RMII_MODE		GRF_BIT(1)
+
+#define RK3506_GMAC_CLK_RMII_DIV2	GRF_BIT(3)
+#define RK3506_GMAC_CLK_RMII_DIV20	GRF_CLR_BIT(3)
+
+#define RK3506_GMAC_CLK_SELECT_CRU	GRF_CLR_BIT(5)
+#define RK3506_GMAC_CLK_SELECT_IO	GRF_BIT(5)
+
+#define RK3506_GMAC_CLK_RMII_GATE	GRF_BIT(2)
+#define RK3506_GMAC_CLK_RMII_NOGATE	GRF_CLR_BIT(2)
+
+static int rk3506_set_to_rgmii(struct udevice *dev,
+			       int tx_delay, int rx_delay)
+{
+	return -EINVAL;
+}
+
+static int rk3506_set_to_rmii(struct udevice *dev)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 reg;
+
+	reg = data->id == 1 ? RK3506_GRF_SOC_CON11 :
+			      RK3506_GRF_SOC_CON8;
+	regmap_write(data->grf, reg, RK3506_GMAC_RMII_MODE);
+
+	return 0;
+}
+
+static int rk3506_set_gmac_speed(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 val, reg;
+
+	switch (eqos->phy->speed) {
+	case SPEED_10:
+		val = RK3506_GMAC_CLK_RMII_DIV20;
+		break;
+	case SPEED_100:
+		val = RK3506_GMAC_CLK_RMII_DIV2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	reg = data->id == 1 ? RK3506_GRF_SOC_CON11 :
+			      RK3506_GRF_SOC_CON8;
+	regmap_write(data->grf, reg, val);
+
+	return 0;
+}
+
+static void rk3506_set_clock_selection(struct udevice *dev, bool enable)
+{
+	struct eth_pdata *pdata = dev_get_plat(dev);
+	struct rockchip_platform_data *data = pdata->priv_pdata;
+	u32 val, reg;
+
+	val = data->clock_input ? RK3506_GMAC_CLK_SELECT_IO :
+				  RK3506_GMAC_CLK_SELECT_CRU;
+	val |= enable ? RK3506_GMAC_CLK_RMII_NOGATE :
+			RK3506_GMAC_CLK_RMII_GATE;
+
+	reg = data->id == 1 ? RK3506_GRF_SOC_CON11 :
+			      RK3506_GRF_SOC_CON8;
+	regmap_write(data->grf, reg, val);
+}
+
 #define RK3528_VO_GRF_GMAC_CON		0x0018
 #define RK3528_VPU_GRF_GMAC_CON5	0x0018
 #define RK3528_VPU_GRF_GMAC_CON6	0x001c
@@ -534,6 +608,18 @@ static void rk3588_set_clock_selection(struct udevice *dev, bool enable)
 }
 
 static const struct rk_gmac_ops rk_gmac_ops[] = {
+	{
+		.compatible = "rockchip,rk3506-gmac",
+		.set_to_rgmii = rk3506_set_to_rgmii,
+		.set_to_rmii = rk3506_set_to_rmii,
+		.set_gmac_speed = rk3506_set_gmac_speed,
+		.set_clock_selection = rk3506_set_clock_selection,
+		.regs = {
+			0xff4c8000, /* gmac0 */
+			0xff4d0000, /* gmac1 */
+			0x0, /* sentinel */
+		},
+	},
 	{
 		.compatible = "rockchip,rk3528-gmac",
 		.set_to_rgmii = rk3528_set_to_rgmii,
-- 
2.52.0

