Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1C1D1F9DA
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:53:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7675A84071;
	Thu,  4 Dec 2025 13:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kXa09q7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A897F83F5D; Thu,  4 Dec 2025 09:31:54 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9052483F24
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 09:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-647a3bca834so848929a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 00:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764837107; x=1765441907;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uKYK3x9gxMTJ/N7PdfrFlB/NPyK7Bg4mapUd3otkYzQ=;
 b=kXa09q7o6MqYL7quxzI7PfoSq2k70AB7Nw47/0UMVvZjVMy+/rAxsHkmi95p8tT/1U
 g7lpb9eomI64fCf9h7FrHyZBAxg2Xs9rL1Di/fZjavNLH86qYGYpW/9GBPhTacjplc/u
 mcdEApx3C59E9OrBBCzy5xa56KMS7kh+NMtxuyCfublLdGf7V4XaE5jiD1XuD3O/FQw6
 jKHBVFv86g+1JJSmdP/2aQ9U3/PUP3FHavlgwCo7BqeHA662GyW5s6+Yww3Z6vkiDufB
 msx7vzCXUV5KeP3NoKOJTLCu7v/5DHWrgByOSwIZtwa6PEDmr3KTZsk/zl8P7W+jl+sz
 Tdvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764837107; x=1765441907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uKYK3x9gxMTJ/N7PdfrFlB/NPyK7Bg4mapUd3otkYzQ=;
 b=gflAVWcO30CyYTGuD0jVhAfoFsPWlU9BEy4OL4NJFO50OXCTF7HX2h3ikN8XOUbMVQ
 LDIGw9cDDskiyYCj23OhA2qu2OBqX5tk/b2vjsTLEwtA6STTUY/QjlTt/FdWFvUDBgsm
 mfqf1iUbP5qE3ouE0LYCswg9/tCdvnvKA7T9qESPMfVJ11a/rkx4PND9eV9wq92yWOoI
 cEagQCfdtctb7ufaFuCgUjO1oTQNnvuXh4b9EdygeBIRrrJU4RHUMKP9zzvvMKURTNdo
 w3FGrrfTUKsTtmh8fb8ztARJnryntGfp+xYx0kIgAWBquut2gm6ze5zQugQvWr5wKeCq
 ca/A==
X-Gm-Message-State: AOJu0Yx/qnh41OWIgBkivoL+2XwFmkCe3hut4ZnyjplHdA7EVKT1GBUO
 nrWFt7CvPpmGrGBenUqaIsVMfHmVrG31J/5mXzKfwxQH1Hgfy+/aWyXE/CHeN1h6LV0=
X-Gm-Gg: ASbGncsb4FOrYQ2y9AqCHnmaLy3lr7hIRYN+DMV8xZJdRpf0WfOVFAJLpwphCe2WMlv
 s3gzdADwrfMq/2e2bAhEHqEAEWkW2/XARueA8e49Ab94G8Gr/3no4o9h8FGtwpKJmfT6Wt3jzAz
 HGzw+7GQNHjk397Wz8OkGQeKO918UUw1b3OLu2tudrd2coFI+n8tiOUdSMXiDaAqNcXLEQMC2zE
 cbBxWd9WT+zA9gLuVKxsJy3l3afoN3QLU5Gmp13Ouh9B0UhjotvWoeSRtugjxKeuY/zt8dtmvkB
 fOGkw/MBPISgyGXEDWzImmzaFD+rmDsokWOzBZLcuhas5JkU/2p6YpsrCDMertYSxa5CpF7STBl
 QIsm1C1aLhIvyiyFanjS2zXQfGm2d3ADeZAoBOkREDKQmdtskYN+IFu8Si94V4Yl/ar8wdivFXl
 jx34Iwa14=
X-Google-Smtp-Source: AGHT+IG5Oq0pkxGzMQOxvlPRhU+KXn5lGjtURDSeFbJ7mUxa/ritNjo3zfnRzH7V/gojAb+hWF47Ng==
X-Received: by 2002:a05:6402:34c8:b0:640:c69b:8ecd with SMTP id
 4fb4d7f45d1cf-6479c517aa2mr4428052a12.25.1764837106971; 
 Thu, 04 Dec 2025 00:31:46 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b3599050sm692560a12.17.2025.12.04.00.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 00:31:46 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 04 Dec 2025 09:31:16 +0100
Subject: [PATCH v3 3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251204-topic-am33-evm-lcd-v2026-01-v3-3-ca74853bd5f0@baylibre.com>
References: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
In-Reply-To: <20251204-topic-am33-evm-lcd-v2026-01-v3-0-ca74853bd5f0@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4703; i=msp@baylibre.com;
 h=from:subject:message-id; bh=+ellPsSQ6R5ksuQq+clEm/HEkh6JVUo7y4sPoNyTPXI=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxDtydf+uuULm7mifl6pO+H8O913jJxxVG3/y5LX3Uyz
 79fka2ho5SFQYyLQVZMkaUzMTTtv/zOY8mLlm2GmcPKBDKEgYtTACYSepbhf05byRtl5wXvLZIf
 vHVmuil/I1tIYEZxQO9T1muq3w+e1Wb4X+XTsrbV4+XqVQfEvrOmcb8+OVPvrHh3mOfzlQwq5vu
 eMQIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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

Add timing data for tfc_s9700rtwv43tr_01b from Linux to the simple-panel
driver. To support hardcoded timing data as Linux does, add a new struct
simple_panel_drv_data which holds a struct display_timing pointer as
well. The hardcoded timing data is preferred over DT parsing.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/video/simple_panel.c | 62 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 0f23df701bc3c40ea49380bbfa3743ee592d8bd3..987ad29995c9b0e30ec59fd56e52590b516fae52 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -22,6 +22,12 @@ struct simple_panel_priv {
 	struct gpio_desc enable;
 };
 
+struct simple_panel_drv_data {
+	const struct drm_display_mode *modes;
+	unsigned int num_modes;
+	const struct mipi_dsi_panel_plat *mipi_dsi;
+};
+
 static int simple_panel_enable_backlight(struct udevice *dev)
 {
 	struct simple_panel_priv *priv = dev_get_priv(dev);
@@ -104,13 +110,32 @@ static int simple_panel_get_edid_timing(struct udevice *dev,
 }
 #endif
 
+static int simple_panel_get_modes(struct udevice *dev,
+				  const struct drm_display_mode **modes)
+{
+	const struct simple_panel_drv_data *data =
+		(const struct simple_panel_drv_data *)dev_get_driver_data(dev);
+
+	if (!data || !data->modes || data->num_modes == 0)
+		return -ENODEV;
+
+	*modes = data->modes;
+	return data->num_modes;
+}
+
 static int simple_panel_get_display_timing(struct udevice *dev,
 					   struct display_timing *timings)
 {
+	const struct simple_panel_drv_data *data =
+		(const struct simple_panel_drv_data *)dev_get_driver_data(dev);
 	const void *blob = gd->fdt_blob;
 	int ret;
 
-	/* Check for timing subnode if panel node first */
+	/* Prefer the use of drm_display_mode if available */
+	if (data && data->modes && data->num_modes > 0)
+		return -ENODEV;
+
+	/* Check for timing subnode in panel node */
 	ret = fdtdec_decode_display_timing(blob, dev_of_offset(dev),
 					   0, timings);
 	if (!ret)
@@ -158,9 +183,9 @@ static int simple_panel_of_to_plat(struct udevice *dev)
 static int simple_panel_probe(struct udevice *dev)
 {
 	struct simple_panel_priv *priv = dev_get_priv(dev);
+	const struct simple_panel_drv_data *data =
+		(const struct simple_panel_drv_data *)dev_get_driver_data(dev);
 	struct mipi_dsi_panel_plat *plat = dev_get_plat(dev);
-	struct mipi_dsi_panel_plat *dsi_data =
-		(struct mipi_dsi_panel_plat *)dev_get_driver_data(dev);
 	int ret;
 
 	ret = regulator_set_enable_if_allowed(priv->reg, true);
@@ -170,8 +195,8 @@ static int simple_panel_probe(struct udevice *dev)
 		return ret;
 	}
 
-	if (dsi_data)
-		memcpy(plat, dsi_data, sizeof(struct mipi_dsi_panel_plat));
+	if (data->mipi_dsi)
+		memcpy(plat, data->mipi_dsi, sizeof(struct mipi_dsi_panel_plat));
 
 	return 0;
 }
@@ -180,6 +205,7 @@ static const struct panel_ops simple_panel_ops = {
 	.enable_backlight	= simple_panel_enable_backlight,
 	.set_backlight		= simple_panel_set_backlight,
 	.get_display_timing	= simple_panel_get_display_timing,
+	.get_modes		= simple_panel_get_modes,
 };
 
 static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
@@ -189,6 +215,28 @@ static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
 	.lanes = 4,
 };
 
+static const struct simple_panel_drv_data panasonic_vvx10f004b00_data = {
+	.mipi_dsi = &panasonic_vvx10f004b00,
+};
+
+static const struct drm_display_mode tfc_s9700rtwv43tr_01b_mode = {
+	.clock = 30000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 39,
+	.hsync_end = 800 + 39 + 47,
+	.htotal = 800 + 39 + 47 + 39,
+	.vdisplay = 480,
+	.vsync_start = 480 + 13,
+	.vsync_end = 480 + 13 + 2,
+	.vtotal = 480 + 13 + 2 + 29,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct simple_panel_drv_data tfc_s9700rtwv43tr_01b_data = {
+	.modes = &tfc_s9700rtwv43tr_01b_mode,
+	.num_modes = 1,
+};
+
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
 	{ .compatible = "panel-lvds" },
@@ -200,7 +248,9 @@ static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "sharp,lq123p1jx31" },
 	{ .compatible = "boe,nv101wxmn51" },
 	{ .compatible = "panasonic,vvx10f004b00",
-	  .data = (ulong)&panasonic_vvx10f004b00 },
+	  .data = (ulong)&panasonic_vvx10f004b00_data },
+	{ .compatible = "tfc,s9700rtwv43tr-01b",
+	  .data = (ulong)&tfc_s9700rtwv43tr_01b_data },
 	{ }
 };
 

-- 
2.51.0

