Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C3DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 09:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCE0C87FE7;
	Thu, 14 Mar 2024 10:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF7087FDC; Thu, 14 Mar 2024 10:36:36 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 512F58781D
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 10:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TwMhd6yGMzMq521;
 Thu, 14 Mar 2024 10:36:33 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TwMhd1yFczxZc; Thu, 14 Mar 2024 10:36:33 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Thu, 14 Mar 2024 10:36:23 +0100
Subject: [PATCH v4 10/16] rockchip: adc: rockchip-saradc: factor out stop
 callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-rk3588-saradc-v4-10-31cb41ff7362@theobroma-systems.com>
References: <20240314-rk3588-saradc-v4-0-31cb41ff7362@theobroma-systems.com>
In-Reply-To: <20240314-rk3588-saradc-v4-0-31cb41ff7362@theobroma-systems.com>
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

SARADC v2 doesn't have a stop mechanism once in single mode. In series
conversion, the logic is different anyway. Therefore, let's abstract
this function so that it can be provided from the udevice.data pointer.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/rockchip-saradc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 607d10b5b70..b5df58fe3eb 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -39,6 +39,7 @@ struct rockchip_saradc_data {
 	unsigned long			clk_rate;
 	int (*channel_data)(struct udevice *dev, int channel, unsigned int *data);
 	int (*start_channel)(struct udevice *dev, int channel);
+	int (*stop)(struct udevice *dev);
 };
 
 struct rockchip_saradc_priv {
@@ -124,13 +125,29 @@ int rockchip_saradc_start_channel(struct udevice *dev, int channel)
 	return 0;
 }
 
-int rockchip_saradc_stop(struct udevice *dev)
+int rockchip_saradc_stop_v1(struct udevice *dev)
 {
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
 
 	/* Power down adc */
 	writel(0, &priv->regs.v1->ctrl);
 
+	return 0;
+}
+
+int rockchip_saradc_stop(struct udevice *dev)
+{
+	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
+
+	if (priv->data->stop) {
+		int ret = priv->data->stop(dev);
+
+		if (ret) {
+			pr_err("Error stopping channel, %d!", ret);
+			return ret;
+		}
+	}
+
 	priv->active_channel = -1;
 
 	return 0;
@@ -209,6 +226,7 @@ static const struct rockchip_saradc_data saradc_data = {
 	.clk_rate = 1000000,
 	.channel_data = rockchip_saradc_channel_data_v1,
 	.start_channel = rockchip_saradc_start_channel_v1,
+	.stop = rockchip_saradc_stop_v1,
 };
 
 static const struct rockchip_saradc_data rk3066_tsadc_data = {
@@ -217,6 +235,7 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
 	.clk_rate = 50000,
 	.channel_data = rockchip_saradc_channel_data_v1,
 	.start_channel = rockchip_saradc_start_channel_v1,
+	.stop = rockchip_saradc_stop_v1,
 };
 
 static const struct rockchip_saradc_data rk3399_saradc_data = {
@@ -225,6 +244,7 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.clk_rate = 1000000,
 	.channel_data = rockchip_saradc_channel_data_v1,
 	.start_channel = rockchip_saradc_start_channel_v1,
+	.stop = rockchip_saradc_stop_v1,
 };
 
 static const struct udevice_id rockchip_saradc_ids[] = {

-- 
2.44.0

