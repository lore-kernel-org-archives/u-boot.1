Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911B9C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 19:11:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17F798717E;
	Mon, 18 Dec 2023 20:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JYB6fATs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915E9874F3; Mon, 18 Dec 2023 20:11:37 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350BD87505
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 20:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5ca0b968d8dso1564762a12.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 11:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702926693; x=1703531493;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0sfhePj46PDKfyhn5ldBKZr5vIgZkIdepfeBeFZKD8=;
 b=JYB6fATsJ2KY4nafLMuRySBEQNt5WR49AXLIFLko1DYwYOZdQfdhbf2v3mc7vWqSUw
 Gv81OhAP1gU/ET4DxKfaFzFhdWfZFks7VdhgyS2ZX4Hm9MF2FfeRGqiOZ5oJF0vYErbm
 1yH8OZvDskp0knygEFgUyWUL+FwfIjv80AtfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702926693; x=1703531493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m0sfhePj46PDKfyhn5ldBKZr5vIgZkIdepfeBeFZKD8=;
 b=tRpYjdfFU6kNC7zfqM5as/9KaJjz4Fhg3jS/yKubXomvzWBujClOwV2byPeTxigZs4
 FaYpisolsqbLHral9q9FooIGxQ4idDbRFpAm+RDnzHzzkEpDj4SFYQT6HrzD+EG61dWv
 S4hjvIXy3tQvNYAMd3OY/zD1z/pzt6a0xFUCKR5mOxaUwnYCUIvDTLj9ixglKPXNf+/o
 yDD8Xd8oP6u2pnIYsZdLtXRZ1fV1SDxZ4BNkO27gYSwBAsE3mML4LZ/Vk97jXJMT2t0e
 jzeG4JskGZo/j+nuzzc9bb31EfcH23VzC8U711JviK1yYTJKQ639U3pZvl9L/5pP93M0
 9O5Q==
X-Gm-Message-State: AOJu0Yy/8citA12ALpKnHZDUZ9J2FFhD9RDuvptXUaeYxdtRzrPH7WDK
 HC9p2yh9bKJ+RaUnOf+1p7l8mA==
X-Google-Smtp-Source: AGHT+IGxpdUsBKcODeKtLVTP+KvO1FHawUtMP0YRLNeyqdw7LspO/Ds7bmps3RkaTWnHY2YhjrIWvA==
X-Received: by 2002:a05:6a21:a5a8:b0:194:71d5:1b65 with SMTP id
 gd40-20020a056a21a5a800b0019471d51b65mr1033558pzc.40.1702926693460; 
 Mon, 18 Dec 2023 11:11:33 -0800 (PST)
Received: from localhost.localdomain ([49.205.242.204])
 by smtp.gmail.com with ESMTPSA id
 pt10-20020a17090b3d0a00b0028afd8b1e0bsm2873941pjb.57.2023.12.18.11.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 11:11:33 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>, u-boot@lists.denx.de,
 Da Xue <da.xue@libretech.co>, Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v2 02/17] video: dw_hdmi: Add Vendor PHY handling
Date: Tue, 19 Dec 2023 00:40:59 +0530
Message-Id: <20231218191114.129329-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218191114.129329-1-jagan@amarulasolutions.com>
References: <20231218191114.129329-1-jagan@amarulasolutions.com>
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

From: Jagan Teki <jagan@edgeble.ai>

DW HDMI support Vendor PHY like Rockchip RK3328 Inno HDMI PHY.

Extend the vendor phy handling by adding platform phy hooks.

Signed-off-by: Jagan Teki <jagan@edgeble.ai>
---
Changes for v2:
- fix meson cfg

 drivers/video/dw_hdmi.c              | 29 +++++++++++++++++++++++++++-
 drivers/video/meson/meson_dw_hdmi.c  | 11 ++++++++++-
 drivers/video/rockchip/rk3399_hdmi.c |  8 +++++++-
 drivers/video/rockchip/rk_hdmi.c     |  2 +-
 drivers/video/sunxi/sunxi_dw_hdmi.c  | 11 ++++++++++-
 include/dw_hdmi.h                    | 14 +++++++++++++-
 6 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index c4fbb18294..ea12a09407 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
 
 	hdmi_av_composer(hdmi, edid);
 
-	ret = hdmi->phy_set(hdmi, edid->pixelclock.typ);
+	ret = hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
 	if (ret)
 		return ret;
 
@@ -1009,10 +1009,37 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
 	return 0;
 }
 
+static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
+	.phy_set = dw_hdmi_phy_cfg,
+};
+
+static void dw_hdmi_detect_phy(struct dw_hdmi *hdmi)
+{
+	if (!hdmi->data)
+		return;
+
+	/* hook Synopsys PHYs ops */
+	if (!hdmi->data->phy_force_vendor) {
+		hdmi->ops = &dw_hdmi_synopsys_phy_ops;
+		return;
+	}
+
+	/* Vendor HDMI PHYs must assign phy_ops in plat_data */
+	if (!hdmi->data->phy_ops) {
+		printf("Unsupported Vendor HDMI phy_ops\n");
+		return;
+	}
+
+	/* hook Vendor HDMI PHYs ops */
+	hdmi->ops = hdmi->data->phy_ops;
+}
+
 void dw_hdmi_init(struct dw_hdmi *hdmi)
 {
 	uint ih_mute;
 
+	dw_hdmi_detect_phy(hdmi);
+
 	/*
 	 * boot up defaults are:
 	 * hdmi_ih_mute   = 0x03 (disabled)
diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 5db01904b5..d0d878b6af 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -375,6 +375,15 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *hdmi)
 	return -ETIMEDOUT;
 }
 
+static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops = {
+	.phy_set = meson_dw_hdmi_phy_init,
+};
+
+static const struct dw_hdmi_plat_data dw_hdmi_meson_plat_data = {
+	.phy_force_vendor = true,
+	.phy_ops = &dw_hdmi_meson_phy_ops,
+};
+
 static int meson_dw_hdmi_probe(struct udevice *dev)
 {
 	struct meson_dw_hdmi *priv = dev_get_priv(dev);
@@ -397,7 +406,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 
 	priv->hdmi.hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 	priv->hdmi.hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
-	priv->hdmi.phy_set = meson_dw_hdmi_phy_init;
+	priv->hdmi.data = &dw_hdmi_meson_plat_data;
 	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
 		priv->hdmi.reg_io_width = 1;
 	else {
diff --git a/drivers/video/rockchip/rk3399_hdmi.c b/drivers/video/rockchip/rk3399_hdmi.c
index 3041360c6e..b32139a8a6 100644
--- a/drivers/video/rockchip/rk3399_hdmi.c
+++ b/drivers/video/rockchip/rk3399_hdmi.c
@@ -64,8 +64,14 @@ static const struct dm_display_ops rk3399_hdmi_ops = {
 	.enable = rk3399_hdmi_enable,
 };
 
+static const struct dw_hdmi_plat_data rk3399_hdmi_drv_data = {
+};
+
 static const struct udevice_id rk3399_hdmi_ids[] = {
-	{ .compatible = "rockchip,rk3399-dw-hdmi" },
+	{
+		.compatible = "rockchip,rk3399-dw-hdmi",
+		.data = (ulong)&rk3399_hdmi_drv_data
+	},
 	{ }
 };
 
diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
index b75a174489..e34f532cd6 100644
--- a/drivers/video/rockchip/rk_hdmi.c
+++ b/drivers/video/rockchip/rk_hdmi.c
@@ -83,6 +83,7 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
 	struct rk_hdmi_priv *priv = dev_get_priv(dev);
 	struct dw_hdmi *hdmi = &priv->hdmi;
 
+	hdmi->data = (const struct dw_hdmi_plat_data *)dev_get_driver_data(dev);
 	hdmi->ioaddr = (ulong)dev_read_addr(dev);
 	hdmi->mpll_cfg = rockchip_mpll_cfg;
 	hdmi->phy_cfg = rockchip_phy_config;
@@ -90,7 +91,6 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
 	/* hdmi->i2c_clk_{high,low} are set up by the SoC driver */
 
 	hdmi->reg_io_width = 4;
-	hdmi->phy_set = dw_hdmi_phy_cfg;
 
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 
diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
index 0324a050d0..4b67a1614e 100644
--- a/drivers/video/sunxi/sunxi_dw_hdmi.c
+++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
@@ -369,6 +369,15 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
 	return 0;
 }
 
+static const struct dw_hdmi_phy_ops dw_hdmi_sunxi_phy_ops = {
+	.phy_set = sunxi_dw_hdmi_phy_cfg,
+};
+
+static const struct dw_hdmi_plat_data dw_hdmi_sunxi_plat_data = {
+	.phy_force_vendor = true,
+	.phy_ops = &dw_hdmi_sunxi_phy_ops,
+};
+
 static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
 {
 	struct sunxi_dw_hdmi_priv *priv = dev_get_priv(dev);
@@ -379,7 +388,7 @@ static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
 	hdmi->i2c_clk_high = 0xd8;
 	hdmi->i2c_clk_low = 0xfe;
 	hdmi->reg_io_width = 1;
-	hdmi->phy_set = sunxi_dw_hdmi_phy_cfg;
+	hdmi->data = &dw_hdmi_sunxi_plat_data;
 
 	ret = reset_get_bulk(dev, &priv->resets);
 	if (ret)
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index 8acae3839f..4ad8b39f84 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -534,6 +534,17 @@ struct hdmi_data_info {
 	struct hdmi_vmode video_mode;
 };
 
+struct dw_hdmi;
+
+struct dw_hdmi_phy_ops {
+	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
+};
+
+struct dw_hdmi_plat_data {
+	bool phy_force_vendor;
+	const struct dw_hdmi_phy_ops *phy_ops;
+};
+
 struct dw_hdmi {
 	ulong ioaddr;
 	const struct hdmi_mpll_config *mpll_cfg;
@@ -543,8 +554,9 @@ struct dw_hdmi {
 	u8 reg_io_width;
 	struct hdmi_data_info hdmi_data;
 	struct udevice *ddc_bus;
+	const struct dw_hdmi_phy_ops *ops;
+	const struct dw_hdmi_plat_data *data;
 
-	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
 	void (*write_reg)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read_reg)(struct dw_hdmi *hdmi, int offset);
 };
-- 
2.25.1

