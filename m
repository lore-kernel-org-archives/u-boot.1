Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485D1C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64F7087FC5;
	Mon,  4 Mar 2024 12:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE0D87F9D; Mon,  4 Mar 2024 12:30:44 +0100 (CET)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6596887F96
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [10.7.10.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhv0LzdzMpsfy;
 Mon,  4 Mar 2024 12:30:39 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGht3654zsjP; Mon,  4 Mar 2024 12:30:38 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:30:05 +0100
Subject: [PATCH v3 11/16] rockchip: adc: rockchip-saradc: add support for
 RK3588
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-11-7424e2ed5d3b@theobroma-systems.com>
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

This adds support for the SARADCv2 found on RK3588.

There is no stop callback as it is currently configured in single
conversion mode, where the ADC is powered down after a single conversion
has been made.

Due to what seems to be a silicon bug, a controller reset needs to be
issued before starting a channel conversion otherwise Rockchip says that
channel 1 will error whatever that means. This is aligned with upstream
and downstream Linux kernel as well as downstream U-Boot.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/rockchip-saradc.c | 102 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index b5df58fe3eb..10ded1b088f 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -10,12 +10,17 @@
 #include <clk.h>
 #include <dm.h>
 #include <errno.h>
-#include <asm/io.h>
+#include <reset.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/printk.h>
 #include <power/regulator.h>
 
+#define usleep_range(a, b) udelay((b))
+
 #define SARADC_CTRL_CHN_MASK		GENMASK(2, 0)
 #define SARADC_CTRL_POWER_CTRL		BIT(3)
 #define SARADC_CTRL_IRQ_ENABLE		BIT(5)
@@ -30,8 +35,37 @@ struct rockchip_saradc_regs_v1 {
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
@@ -46,6 +80,7 @@ struct rockchip_saradc_priv {
 	union rockchip_saradc_regs		regs;
 	int					active_channel;
 	const struct rockchip_saradc_data	*data;
+	struct reset_ctl			*reset;
 };
 
 int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
@@ -66,6 +101,22 @@ int rockchip_saradc_channel_data_v1(struct udevice *dev, int channel,
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
@@ -104,6 +155,40 @@ int rockchip_saradc_start_channel_v1(struct udevice *dev, int channel)
 	return 0;
 }
 
+static void rockchip_saradc_reset_controller(struct reset_ctl *reset)
+{
+	reset_assert(reset);
+	usleep_range(10, 20);
+	reset_deassert(reset);
+}
+
+int rockchip_saradc_start_channel_v2(struct udevice *dev, int channel)
+{
+	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
+
+	/*
+	 * Downstream says
+	 * """If read other chn at anytime, then chn1 will error, assert
+	 * controller as a workaround."""
+	 */
+	if (priv->reset)
+		rockchip_saradc_reset_controller(priv->reset);
+
+	writel(0xc, &priv->regs.v2->t_das_soc);
+	writel(0x20, &priv->regs.v2->t_pd_soc);
+
+	/* Acknowledge any previous interrupt */
+	writel(SARADC2_EN_END_INT, &priv->regs.v2->end_int_st);
+
+	rk_clrsetreg(&priv->regs.v2->conv_con,
+		     SARADC2_CONV_CHANNELS | SARADC2_START | SARADC2_SINGLE_MODE,
+		     FIELD_PREP(SARADC2_CONV_CHANNELS, channel) |
+		     FIELD_PREP(SARADC2_START, 1) |
+		     FIELD_PREP(SARADC2_SINGLE_MODE, 1));
+
+	return 0;
+}
+
 int rockchip_saradc_start_channel(struct udevice *dev, int channel)
 {
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
@@ -162,6 +247,8 @@ int rockchip_saradc_probe(struct udevice *dev)
 	int vref_uv;
 	int ret;
 
+	priv->reset = devm_reset_control_get_optional(dev, "saradc-apb");
+
 	ret = clk_get_by_index(dev, 0, &clk);
 	if (ret)
 		return ret;
@@ -178,6 +265,9 @@ int rockchip_saradc_probe(struct udevice *dev)
 		return ret;
 	}
 
+	if (priv->reset)
+		rockchip_saradc_reset_controller(priv->reset);
+
 	vref_uv = regulator_get_value(vref);
 	if (vref_uv < 0) {
 		printf("can't get vref-supply value: %d\n", vref_uv);
@@ -247,6 +337,14 @@ static const struct rockchip_saradc_data rk3399_saradc_data = {
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
@@ -254,6 +352,8 @@ static const struct udevice_id rockchip_saradc_ids[] = {
 	  .data = (ulong)&rk3066_tsadc_data },
 	{ .compatible = "rockchip,rk3399-saradc",
 	  .data = (ulong)&rk3399_saradc_data },
+	{ .compatible = "rockchip,rk3588-saradc",
+	  .data = (ulong)&rk3588_saradc_data },
 	{ }
 };
 

-- 
2.44.0

