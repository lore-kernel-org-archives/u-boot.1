Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B999FFCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FE4484035;
	Tue, 10 Mar 2026 01:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JQFj2AWm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BFB083F75; Tue, 10 Mar 2026 01:55:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 225FA8400F
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:55:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773104124; bh=HeUYj+TJsx9Dkg7gwbnaQKdAsVnR15ShqVrGJahxstk=;
 b=JQFj2AWm8jEjjwKwp+EWMlxrLew83m6zykKVC6WZOkLcn5OPP6hfCxCpiFhbuGOQC5nRlPnUR
 eAtZbEV0AW1b7s+a0PNVsIdOE39kpUK1KBwBZNAiIskhqnelIvL9SEzy/w0/HYSGZC7BzC3xDaG
 9Qq6pWKmOW+NX3jRWJCcudXXL8J2KhslXNP4+P65shOWgYWeppTRFv4/BdEBqkxKzNotYkrfb6N
 eQp05lvWQM945ZHJGkuEtwNh0tzcG/pT9w2BrYMeKq4Kw2JUkA4PoMUK358+cdr+nsx4JvKhP8k
 Yg/Nj6nkuqtb+IREjJo76t0U2x8IQmRRBe356ryfNfZg==
X-Forward-Email-ID: 69af6bfc73a8189bec327857
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 11/12] net: dwc_eth_qos_rockchip: Add support for RK3506
Date: Tue, 10 Mar 2026 00:53:06 +0000
Message-ID: <20260310005326.606079-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005326.606079-1-jonas@kwiboo.se>
References: <20260310005326.606079-1-jonas@kwiboo.se>
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3: Collect r-b tag
v2: No change
---
 drivers/net/dwc_eth_qos.c          |  4 ++
 drivers/net/dwc_eth_qos_rockchip.c | 86 ++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index 8a396d0b29ea..0f31d6468456 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1620,6 +1620,10 @@ static const struct udevice_id eqos_ids[] = {
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
2.53.0

