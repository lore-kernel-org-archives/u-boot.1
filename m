Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FB7C5478B
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 17:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B591D8808F;
	Wed, 21 Feb 2024 18:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E88B8805F; Wed, 21 Feb 2024 18:08:41 +0100 (CET)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEAD88035
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 18:08:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tg2m129dszMpyqv;
 Wed, 21 Feb 2024 18:08:17 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Tg2m03y0PzXhs; Wed, 21 Feb 2024 18:08:16 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 21 Feb 2024 18:07:40 +0100
Subject: [PATCH 11/16] rockchip: adc: rockchip-saradc: add support for RK3588
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-rk3588-saradc-v1-11-c39a5601d1cc@theobroma-systems.com>
References: <20240221-rk3588-saradc-v1-0-c39a5601d1cc@theobroma-systems.com>
In-Reply-To: <20240221-rk3588-saradc-v1-0-c39a5601d1cc@theobroma-systems.com>
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

This adds support for the SARADCv2 found on RK3588.

There is no stop callback as it is currently configured in single
conversion mode, where the ADC is powered down after a single conversion
has been made.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/rockchip-saradc.c | 76 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index b5df58fe3eb..05c93cedcf1 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -10,7 +10,8 @@
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
-#include <asm/io.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/printk.h>
@@ -30,8 +31,37 @@ struct rockchip_saradc_regs_v1 {
 	unsigned int dly_pu_soc;
 };
 
+struct rockchip_saradc_regs_v2 {
+	unsigned int conv_con;
+#define SARADC2_SINGLE_MODE	BIT(5)
+#define SARADC2_START		BIT(4)
+#define SARADC2_CONV_CHANNELS	GENMASK(3, 0)
+	unsigned int t_pd_soc;
+	unsigned int t_as_soc;
+	unsigned int t_das_soc;
+	unsigned int t_sel_soc;
+	unsigned int high_comp[16];
+	unsigned int low_comp[16];
+	unsigned int debounce;
+	unsigned int ht_int_en;
+	unsigned int lt_int_en;
+	unsigned int reserved[24];
+	unsigned int mt_int_en;
+	unsigned int end_int_en;
+#define SARADC2_EN_END_INT	BIT(0)
+	unsigned int st_con;
+	unsigned int status;
+	unsigned int end_int_st;
+	unsigned int ht_int_st;
+	unsigned int lt_int_st;
+	unsigned int mt_int_st;
+	unsigned int data[16];
+	unsigned int auto_ch_en;
+};
+
 union rockchip_saradc_regs {
 	struct rockchip_saradc_regs_v1	*v1;
+	struct rockchip_saradc_regs_v2	*v2;
 };
 struct rockchip_saradc_data {
 	int				num_bits;
@@ -66,6 +96,22 @@ int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
 	return 0;
 }
 
+int rockchip_saradc_channel_data_v2(struct udevice *dev, int channel,
+				    unsigned int *data)
+{
+	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
+
+	if (!(readl(&priv->regs.v2->end_int_st) & SARADC2_EN_END_INT))
+		return -EBUSY;
+
+	/* Read value */
+	*data = readl(&priv->regs.v2->data[channel]);
+
+	/* Acknowledge the interrupt */
+	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
+
+	return 0;
+}
 int rockchip_saradc_channel_data(struct udevice *dev, int channel,
 				 unsigned int *data)
 {
@@ -104,6 +150,24 @@ int rockchip_saradc_start_channel_v1(struct udevice *dev, int channel)
 	return 0;
 }
 
+int rockchip_saradc_start_channel_v2(struct udevice *dev, int channel)
+{
+	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
+
+	writel(0xc, &priv->regs.v2->t_das_soc);
+	writel(0x20, &priv->regs.v2->t_pd_soc);
+
+	/* Acknowledge any previous interrupt */
+	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
+
+	rk_setreg(&priv->regs.v2->conv_con,
+		  FIELD_PREP(SARADC2_CONV_CHANNELS, channel) |
+		  FIELD_PREP(SARADC2_START, 1) |
+		  FIELD_PREP(SARADC2_SINGLE_MODE, 1));
+
+	return 0;
+}
+
 int rockchip_saradc_start_channel(struct udevice *dev, int channel)
 {
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
@@ -247,6 +311,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
 	.stop = rockchip_saradc_stop_v1,
 };
 
+static const struct rockchip_saradc_data rk3588_saradc_data = {
+	.num_bits = 12,
+	.num_channels = 8,
+	.clk_rate = 1000000,
+	.channel_data = rockchip_saradc_channel_data_v2,
+	.start_channel = rockchip_saradc_start_channel_v2,
+};
+
 static const struct udevice_id rockchip_saradc_ids[] = {
 	{ .compatible = "rockchip,saradc",
 	  .data = (ulong)&saradc_data },
@@ -254,6 +326,8 @@ static const struct udevice_id rockchip_saradc_ids[] = {
 	  .data = (ulong)&rk3066_tsadc_data },
 	{ .compatible = "rockchip,rk3399-saradc",
 	  .data = (ulong)&rk3399_saradc_data },
+	{ .compatible = "rockchip,rk3588-saradc",
+	  .data = (ulong)&rk3588_saradc_data },
 	{ }
 };
 

-- 
2.43.2

