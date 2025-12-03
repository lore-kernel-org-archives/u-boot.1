Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F571D12D6D
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAA5883FCF;
	Wed,  3 Dec 2025 15:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HgmSnKcE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7150780077; Wed,  3 Dec 2025 11:19:57 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74ED383B63
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 11:19:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b737502f77bso950973966b.2
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 02:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764757192; x=1765361992;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mxwaHRLIc8EyCUi9o0c7fRL92bgffgLrN19+1C6WhCk=;
 b=HgmSnKcE91eRyGouMIz8QnmcS0jEfKU6KpWOlNZQ6s9oKIdyCneCCcer/K6Ealhbp3
 sknBnoiudNgCl23xnXlm0X59e26MyNQ0Z6T9j4uHxXurwpWmPuJjl6W3HAUC/uO+scQ4
 BdY+E16Zx6NTut6jaTZC01FLzOgwg/8UEu6vRZCvZZzLDJ6vqNucYXrs+Apl284J57jH
 /vAy793NkeBqEKmvr8x4ZPsO0yk3P5LGw/ArA04cp0zkmDCIrkLh03jCtgAzbTUg+qXo
 Fx0/0KDRn8x0s1S5w3FVWp/rBLgyeJtBSPqAJzY2DswK6irOJODRpDALkUSmd9+P5cdn
 QucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764757192; x=1765361992;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mxwaHRLIc8EyCUi9o0c7fRL92bgffgLrN19+1C6WhCk=;
 b=ON6Ok6i9PmDtVIL/TW9rChmUdBI2uFsDKb6XhGrUIi46Y0c6j9xnUlifl3DNaFkCRU
 c8qOyXYcgG6397TnJVgwJmI2HslEMb9kuArIzKaA9zsnsjRMZdmLIIyRi1gZwSt1oD5N
 PZgKlkai+RMoEPl1AeZXuA8/6oFiKhYNlV1D3pJKKSyDIr7tuLNV56W6fLuHAqqeJq3w
 Q4yhIHJU22Ctcn95Tmeu1qT02miBqoLVD3MZGYMY7GsLnqL2mubBdf9XNG1dcaqFhPpI
 zVlXrT0xXg/+NvmX3lMNrvbfcioPC+fDFnNt4QHe0mmys1zUmWV3yMpys02ib1LsFzXG
 HwKQ==
X-Gm-Message-State: AOJu0YzAJKh7C0w//pAxWKQnPRt0rq9cF6d2EMdI1hiJJhvv5YNNIanu
 +hbMUHq7eFnuA6CKOpD/RadIexfz91bVqFVJvj31pnyMSZ9IO8EMqXlY9zUHlcNd5AI=
X-Gm-Gg: ASbGncsc9NbDcSngX+eYUnpEo1oc5SF6DZt1mZ/aO2CmNvcl/1x88O3E0BtJxYzpCnq
 Blb2Q1s7z68EHv+5p+1FS0y1ja1QtN7MzxehzrbjWotf3j/20acdLMZKpqNT0SPebBynGve7aX0
 bTbCExxRjxciYemVJ+jK2qu8XUGLqAfRM072Lo36fHWLmoZpasiMSDGV6qI8bTO68pjGgLFdhfU
 TkPb3qb+a+TXwSnm61H9XTShMH3q6T6RFYCoM/dZT4LZzYc3JK2T3oBqmUOlAIbAldeizLTHqJN
 FVKCdSLZAJXwJ3DQ0f9NOyKeOP/N/2/Ss5rjheXDrqHhhFYyo4B19XX4m7XLngYsUhOymKFDdon
 IbflSjxYnQZXUcXdZjb8RQ+rs1QPmarh0hnQ2UzmpAFHW0V94xUTb9eTuqAkeccWmBXXamVJ3Xd
 /j1Wcdkok=
X-Google-Smtp-Source: AGHT+IEfqFOW8RHbA9z0OPOxslaYSQF+pY5d8gECvkJdfayaFj+Ge1ojnbxwiFG4xf+9eHTwYaYvbQ==
X-Received: by 2002:a17:907:3f11:b0:b73:2a77:3128 with SMTP id
 a640c23a62f3a-b79dc4ecb94mr178354166b.27.1764757191877; 
 Wed, 03 Dec 2025 02:19:51 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59eb3f6sm1719977066b.55.2025.12.03.02.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 02:19:51 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 03 Dec 2025 11:19:12 +0100
Subject: [PATCH v2 3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-topic-am33-evm-lcd-v2026-01-v2-3-262cf4f34eb5@baylibre.com>
References: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
In-Reply-To: <20251203-topic-am33-evm-lcd-v2026-01-v2-0-262cf4f34eb5@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4654; i=msp@baylibre.com;
 h=from:subject:message-id; bh=5TnGvTb1lmQfl/dLa9fPycaMU82M+2AiFcw5su+sXoQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwDvp03kn/6uyZKlJmuNq9N3iW5Pnmjbv+b+9FzXzjq7
 zJu56vvKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIlsZ2X4p1bD5950Xa7yzhFB
 hisxXS/TTkbyiu5atVLIuj6yxqXqPSPDGdv9SjfOhQv+M/0dP21NV3Be7qHob4rebw82t2qXfDj
 GDwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 03 Dec 2025 15:46:17 +0100
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

