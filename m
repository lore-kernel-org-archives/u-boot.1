Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52FC1C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03ACD87FAC;
	Mon,  4 Mar 2024 12:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC33087F9D; Mon,  4 Mar 2024 12:30:44 +0100 (CET)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC8D887F92
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhs47jXz6hD;
 Mon,  4 Mar 2024 12:30:37 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhs0R6yztXG; Mon,  4 Mar 2024 12:30:37 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:30:03 +0100
Subject: [PATCH v3 09/16] rockchip: adc: rockchip-saradc: factor out
 start_channel callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-9-7424e2ed5d3b@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
In-Reply-To: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
X-Mailer: b4 0.13.0
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

SARADC v1 and v2 have a different way of starting a channel, therefore
let's abstract this function so that it can be provided from the
udevice.data pointer.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/rockchip-saradc.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 1cc57beecc2..607d10b5b70 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -38,6 +38,7 @@ struct rockchip_saradc_data {
 	int				num_channels;
 	unsigned long			clk_rate;
 	int (*channel_data)(struct udevice *dev, int channel, unsigned int *data);
+	int (*start_channel)(struct udevice *dev, int channel);
 };
 
 struct rockchip_saradc_priv {
@@ -88,15 +89,10 @@ int rockchip_saradc_channel_data(struct udevice *dev, int channel,
 	return 0;
 }
 
-int rockchip_saradc_start_channel(struct udevice *dev, int channel)
+int rockchip_saradc_start_channel_v1(struct udevice *dev, int channel)
 {
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
 
-	if (channel < 0 || channel >= priv->data->num_channels) {
-		pr_err("Requested channel is invalid!");
-		return -EINVAL;
-	}
-
 	/* 8 clock periods as delay between power up and start cmd */
 	writel(8, &priv->regs.v1->dly_pu_soc);
 
@@ -104,6 +100,25 @@ int rockchip_saradc_start_channel(struct udevice *dev, int channel)
 	writel(SARADC_CTRL_POWER_CTRL | (channel & SARADC_CTRL_CHN_MASK) |
 	       SARADC_CTRL_IRQ_ENABLE, &priv->regs.v1->ctrl);
 
+	return 0;
+}
+
+int rockchip_saradc_start_channel(struct udevice *dev, int channel)
+{
+	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	if (channel < 0 || channel >= priv->data->num_channels) {
+		pr_err("Requested channel is invalid!");
+		return -EINVAL;
+	}
+
+	ret = priv->data->start_channel(dev, channel);
+	if (ret) {
+		pr_err("Error starting channel, %d!", ret);
+		return ret;
+	}
+
 	priv->active_channel = channel;
 
 	return 0;
@@ -193,6 +208,7 @@ static const struct rockchip_saradc_data saradc_data = {
 	.num_channels = 3,
 	.clk_rate = 1000000,
 	.channel_data = rockchip_saradc_channel_data_v1,
+	.start_channel = rockchip_saradc_start_channel_v1,
 };
 
 static const struct rockchip_saradc_data rk3066_tsadc_data = {
@@ -200,6 +216,7 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
 	.num_channels = 2,
 	.clk_rate = 50000,
 	.channel_data = rockchip_saradc_channel_data_v1,
+	.start_channel = rockchip_saradc_start_channel_v1,
 };
 
 static const struct rockchip_saradc_data rk3399_saradc_data = {
@@ -207,6 +224,7 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.num_channels = 6,
 	.clk_rate = 1000000,
 	.channel_data = rockchip_saradc_channel_data_v1,
+	.start_channel = rockchip_saradc_start_channel_v1,
 };
 
 static const struct udevice_id rockchip_saradc_ids[] = {

-- 
2.44.0

