Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C49C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 07:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F90879D3;
	Wed, 17 Jan 2024 08:52:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IZs9NTf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D4B86F67; Wed, 17 Jan 2024 08:52:27 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F4B878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 08:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d5cdb4a444so23662155ad.1
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 23:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705477943; x=1706082743;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXU6iiDJXyyB3vKzYIoo45MER8bJNCitUN6n2TomIUI=;
 b=IZs9NTf8LLTGSfp7syjnzCtumUYHx7qmVrfW40vNdm2RFzJ8s1udm38hBseZpxjxRA
 MSEF8XAzwPHIAGHQw7fnIQmLinS4PElALBYP4J4QexKmWFIPsZveOobQScOelovGd1hN
 GPnNpG/V5ttb6Yrn5SAGYAybfytlvRtoxbmro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705477943; x=1706082743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eXU6iiDJXyyB3vKzYIoo45MER8bJNCitUN6n2TomIUI=;
 b=R9GzV0m2U3hYN4lGV+nONPIzuzAbOPRYBfGf13Afk0eofVqSR+4tblgWBQ9dI2dguH
 T4yWAgqG4pYgq82q6O9Y0QsP1zXzJhb4Sqraih4HcEe7AkeRbixhx3kwqkPdm8KpGena
 V3t7GbUchY3DDUVhvcX4ixjSdPgwM8zuEoORrnNg1GmqbxrxO72u8z9EFvGsIZ0QJiS8
 N2HJySXOA03ZP+5l3cXfO5zMdHOoZFU0M0bdTnkt1eZrJpf1fsMlSv41R2d80EuRY5UP
 3D40tOujz3/MVGQvn14NZ+Opa5vZG5ksvsBaMwNnzoEJ5AOUT9qxOEeKdY05zuWVCfXs
 z2mQ==
X-Gm-Message-State: AOJu0YwgxbF01KyZjmBaRsbMHBLgeiBumCdCgMInuj6F4LcRRr1kyX1U
 L52b+e8hqkSl/UIDiDA8dHPhhMR21bUS/g==
X-Google-Smtp-Source: AGHT+IGviGaBtJIG9xsQHRMNaaZGsmagY5vNTa3AepaBQP24mXibJFA2SzugU7JIlr70nH/H18RmVQ==
X-Received: by 2002:a17:902:e5d1:b0:1d5:ad95:f30a with SMTP id
 u17-20020a170902e5d100b001d5ad95f30amr9920706plf.87.1705477943116; 
 Tue, 16 Jan 2024 23:52:23 -0800 (PST)
Received: from localhost.localdomain ([183.82.41.50])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170902784a00b001d5081be740sm10718624pln.62.2024.01.16.23.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 23:52:22 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Anatolij Gustschin <agust@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
Subject: [PATCH v3 02/17] video: dw_hdmi: Add Vendor PHY handling
Date: Wed, 17 Jan 2024 13:21:39 +0530
Message-Id: <20240117075154.58747-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240117075154.58747-1-jagan@amarulasolutions.com>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
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
Changes for v3:
- drop data
- assign ops directly
Changes for v2:
- fix meson cfg

 drivers/video/dw_hdmi.c             | 10 +++++++++-
 drivers/video/meson/meson_dw_hdmi.c |  6 +++++-
 drivers/video/rockchip/rk_hdmi.c    |  1 -
 drivers/video/sunxi/sunxi_dw_hdmi.c |  6 +++++-
 include/dw_hdmi.h                   |  8 +++++++-
 5 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
index c4fbb18294..4914ba6146 100644
--- a/drivers/video/dw_hdmi.c
+++ b/drivers/video/dw_hdmi.c
@@ -988,7 +988,7 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
 
 	hdmi_av_composer(hdmi, edid);
 
-	ret = hdmi->phy_set(hdmi, edid->pixelclock.typ);
+	ret = hdmi->ops->phy_set(hdmi, edid->pixelclock.typ);
 	if (ret)
 		return ret;
 
@@ -1009,10 +1009,18 @@ int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid)
 	return 0;
 }
 
+static const struct dw_hdmi_phy_ops dw_hdmi_synopsys_phy_ops = {
+	.phy_set = dw_hdmi_phy_cfg,
+};
+
 void dw_hdmi_init(struct dw_hdmi *hdmi)
 {
 	uint ih_mute;
 
+	/* hook Synopsys PHYs ops */
+	if (!hdmi->ops)
+		hdmi->ops = &dw_hdmi_synopsys_phy_ops;
+
 	/*
 	 * boot up defaults are:
 	 * hdmi_ih_mute   = 0x03 (disabled)
diff --git a/drivers/video/meson/meson_dw_hdmi.c b/drivers/video/meson/meson_dw_hdmi.c
index 5db01904b5..259af1b457 100644
--- a/drivers/video/meson/meson_dw_hdmi.c
+++ b/drivers/video/meson/meson_dw_hdmi.c
@@ -375,6 +375,10 @@ static int meson_dw_hdmi_wait_hpd(struct dw_hdmi *hdmi)
 	return -ETIMEDOUT;
 }
 
+static const struct dw_hdmi_phy_ops dw_hdmi_meson_phy_ops = {
+	.phy_set = meson_dw_hdmi_phy_init,
+};
+
 static int meson_dw_hdmi_probe(struct udevice *dev)
 {
 	struct meson_dw_hdmi *priv = dev_get_priv(dev);
@@ -397,7 +401,7 @@ static int meson_dw_hdmi_probe(struct udevice *dev)
 
 	priv->hdmi.hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 	priv->hdmi.hdmi_data.enc_in_bus_format = MEDIA_BUS_FMT_YUV8_1X24;
-	priv->hdmi.phy_set = meson_dw_hdmi_phy_init;
+	priv->hdmi.ops = &dw_hdmi_meson_phy_ops;
 	if (meson_hdmi_is_compatible(priv, HDMI_COMPATIBLE_G12A))
 		priv->hdmi.reg_io_width = 1;
 	else {
diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
index b75a174489..d5b5a529d2 100644
--- a/drivers/video/rockchip/rk_hdmi.c
+++ b/drivers/video/rockchip/rk_hdmi.c
@@ -90,7 +90,6 @@ int rk_hdmi_of_to_plat(struct udevice *dev)
 	/* hdmi->i2c_clk_{high,low} are set up by the SoC driver */
 
 	hdmi->reg_io_width = 4;
-	hdmi->phy_set = dw_hdmi_phy_cfg;
 
 	priv->grf = syscon_get_first_range(ROCKCHIP_SYSCON_GRF);
 
diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
index 0324a050d0..986e69d66b 100644
--- a/drivers/video/sunxi/sunxi_dw_hdmi.c
+++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
@@ -369,6 +369,10 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
 	return 0;
 }
 
+static const struct dw_hdmi_phy_ops dw_hdmi_sunxi_phy_ops = {
+	.phy_set = sunxi_dw_hdmi_phy_cfg,
+};
+
 static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
 {
 	struct sunxi_dw_hdmi_priv *priv = dev_get_priv(dev);
@@ -379,7 +383,7 @@ static int sunxi_dw_hdmi_of_to_plat(struct udevice *dev)
 	hdmi->i2c_clk_high = 0xd8;
 	hdmi->i2c_clk_low = 0xfe;
 	hdmi->reg_io_width = 1;
-	hdmi->phy_set = sunxi_dw_hdmi_phy_cfg;
+	hdmi->ops = &dw_hdmi_sunxi_phy_ops;
 
 	ret = reset_get_bulk(dev, &priv->resets);
 	if (ret)
diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
index 8acae3839f..17bdd2dbf9 100644
--- a/include/dw_hdmi.h
+++ b/include/dw_hdmi.h
@@ -534,6 +534,12 @@ struct hdmi_data_info {
 	struct hdmi_vmode video_mode;
 };
 
+struct dw_hdmi;
+
+struct dw_hdmi_phy_ops {
+	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
+};
+
 struct dw_hdmi {
 	ulong ioaddr;
 	const struct hdmi_mpll_config *mpll_cfg;
@@ -543,8 +549,8 @@ struct dw_hdmi {
 	u8 reg_io_width;
 	struct hdmi_data_info hdmi_data;
 	struct udevice *ddc_bus;
+	const struct dw_hdmi_phy_ops *ops;
 
-	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
 	void (*write_reg)(struct dw_hdmi *hdmi, u8 val, int offset);
 	u8 (*read_reg)(struct dw_hdmi *hdmi, int offset);
 };
-- 
2.25.1

