Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BF7C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 11:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916DB87F86;
	Mon,  4 Mar 2024 12:30:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4D2287FA7; Mon,  4 Mar 2024 12:30:43 +0100 (CET)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB80D87F8F
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 12:30:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TpGhr3xckz9Hl;
 Mon,  4 Mar 2024 12:30:36 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4TpGhq71qgzr6b; Mon,  4 Mar 2024 12:30:35 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 Mar 2024 12:30:01 +0100
Subject: [PATCH v3 07/16] rockchip: adc: rockchip-saradc: use union for
 preparing for v2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-rk3588-saradc-v3-7-7424e2ed5d3b@theobroma-systems.com>
References: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
In-Reply-To: <20240304-rk3588-saradc-v3-0-7424e2ed5d3b@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

The registers are entirely different between SARADC v1 and SARADC v2, so
let's prepare to add another struct for accessing v2 registers by adding
a union.

Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/adc/rockchip-saradc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index 03caca78b5f..4a842556a60 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -23,13 +23,16 @@
 
 #define SARADC_TIMEOUT			(100 * 1000)
 
-struct rockchip_saradc_regs {
+struct rockchip_saradc_regs_v1 {
 	unsigned int data;
 	unsigned int stas;
 	unsigned int ctrl;
 	unsigned int dly_pu_soc;
 };
 
+union rockchip_saradc_regs {
+	struct rockchip_saradc_regs_v1	*v1;
+};
 struct rockchip_saradc_data {
 	int				num_bits;
 	int				num_channels;
@@ -37,7 +40,7 @@ struct rockchip_saradc_data {
 };
 
 struct rockchip_saradc_priv {
-	struct rockchip_saradc_regs		*regs;
+	union rockchip_saradc_regs		regs;
 	int					active_channel;
 	const struct rockchip_saradc_data	*data;
 };
@@ -53,16 +56,16 @@ int rockchip_saradc_channel_data(struct udevice *dev, int channel,
 		return -EINVAL;
 	}
 
-	if ((readl(&priv->regs->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
+	if ((readl(&priv->regs.v1->ctrl) & SARADC_CTRL_IRQ_STATUS) !=
 	    SARADC_CTRL_IRQ_STATUS)
 		return -EBUSY;
 
 	/* Read value */
-	*data = readl(&priv->regs->data);
+	*data = readl(&priv->regs.v1->data);
 	*data &= uc_pdata->data_mask;
 
 	/* Power down adc */
-	writel(0, &priv->regs->ctrl);
+	writel(0, &priv->regs.v1->ctrl);
 
 	return 0;
 }
@@ -77,11 +80,11 @@ int rockchip_saradc_start_channel(struct udevice *dev, int channel)
 	}
 
 	/* 8 clock periods as delay between power up and start cmd */
-	writel(8, &priv->regs->dly_pu_soc);
+	writel(8, &priv->regs.v1->dly_pu_soc);
 
 	/* Select the channel to be used and trigger conversion */
 	writel(SARADC_CTRL_POWER_CTRL | (channel & SARADC_CTRL_CHN_MASK) |
-	       SARADC_CTRL_IRQ_ENABLE, &priv->regs->ctrl);
+	       SARADC_CTRL_IRQ_ENABLE, &priv->regs.v1->ctrl);
 
 	priv->active_channel = channel;
 
@@ -93,7 +96,7 @@ int rockchip_saradc_stop(struct udevice *dev)
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
 
 	/* Power down adc */
-	writel(0, &priv->regs->ctrl);
+	writel(0, &priv->regs.v1->ctrl);
 
 	priv->active_channel = -1;
 
@@ -146,8 +149,8 @@ int rockchip_saradc_of_to_plat(struct udevice *dev)
 	struct rockchip_saradc_data *data;
 
 	data = (struct rockchip_saradc_data *)dev_get_driver_data(dev);
-	priv->regs = dev_read_addr_ptr(dev);
-	if (!priv->regs) {
+	priv->regs.v1 = dev_read_addr_ptr(dev);
+	if (!priv->regs.v1) {
 		pr_err("Dev: %s - can't get address!", dev->name);
 		return -EINVAL;
 	}

-- 
2.44.0

