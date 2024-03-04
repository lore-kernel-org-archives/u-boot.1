Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B8FC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:32:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8FC87FC2;
	Mon,  4 Mar 2024 12:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E48D87FB9; Mon,  4 Mar 2024 12:30:44 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [45.157.188.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63CB387F91
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhs0YWSzMw0pt;
 Mon,  4 Mar 2024 12:30:37 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhr3qrqzr4P; Mon,  4 Mar 2024 12:30:36 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:30:02 +0100
Subject: [PATCH v3 08/16] rockchip: adc: rockchip-saradc: factor out
 channel_data callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-8-7424e2ed5d3b@theobroma-systems.com>
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

SARADC v1 and v2 have a different way of reading data, therefore let's
abstract this function so that it can be provided from the udevice.data
pointer.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/rockchip-saradc.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 4a842556a60..1cc57beecc2 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -37,6 +37,7 @@ struct rockchip_saradc_data {
 	int				num_bits;
 	int				num_channels;
 	unsigned long			clk_rate;
+	int (*channel_data)(struct udevice *dev, int channel, unsigned int *data);
 };
 
 struct rockchip_saradc_priv {
@@ -45,28 +46,45 @@ struct rockchip_saradc_priv {
 	const struct rockchip_saradc_data	*data;
 };
 
+int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
+				    unsigned int *data)
+{
+	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
+
+	if ((readl(&priv->regs.v1->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
+	    SARADC_CTRL_IRQ_STATUS)
+		return -EBUSY;
+
+	/* Read value */
+	*data = readl(&priv->regs.v1->data);
+
+	/* Power down adc */
+	writel(0, &priv->regs.v1->ctrl);
+
+	return 0;
+}
+
 int rockchip_saradc_channel_data(struct udevice *dev, int channel,
 				 unsigned int *data)
 {
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
 	struct adc_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
+	int ret;
 
 	if (channel != priv->active_channel) {
 		pr_err("Requested channel is not active!");
 		return -EINVAL;
 	}
 
-	if ((readl(&priv->regs.v1->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
-	    SARADC_CTRL_IRQ_STATUS)
-		return -EBUSY;
+	ret = priv->data->channel_data(dev, channel, data);
+	if (ret) {
+		if (ret != -EBUSY)
+			pr_err("Error reading channel data, %d!", ret);
+		return ret;
+	}
 
-	/* Read value */
-	*data = readl(&priv->regs.v1->data);
 	*data &= uc_pdata->data_mask;
 
-	/* Power down adc */
-	writel(0, &priv->regs.v1->ctrl);
-
 	return 0;
 }
 
@@ -174,18 +192,21 @@ static const struct rockchip_saradc_data saradc_data = {
 	.num_bits = 10,
 	.num_channels = 3,
 	.clk_rate = 1000000,
+	.channel_data = rockchip_saradc_channel_data_v1,
 };
 
 static const struct rockchip_saradc_data rk3066_tsadc_data = {
 	.num_bits = 12,
 	.num_channels = 2,
 	.clk_rate = 50000,
+	.channel_data = rockchip_saradc_channel_data_v1,
 };
 
 static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.num_bits = 10,
 	.num_channels = 6,
 	.clk_rate = 1000000,
+	.channel_data = rockchip_saradc_channel_data_v1,
 };
 
 static const struct udevice_id rockchip_saradc_ids[] = {

-- 
2.44.0

