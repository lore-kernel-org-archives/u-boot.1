Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0E0CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407D6845DF;
	Fri, 28 Nov 2025 15:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PFnBKrQv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A495283B8C; Fri, 28 Nov 2025 11:34:38 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1C783B81
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 11:34:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c82bf86bso1094187f8f.1
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 02:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764326076; x=1764930876;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zI2wMkbMBKUt2W98yHRekosrCFj34jOyeHq0ejrCQes=;
 b=PFnBKrQv+6Tj0ID7HfaQ0sKwSl9Av2BcyRhxNXnRzcDifCeyB+djWk05Wew3ATYzab
 S5f/jXnAW4lT0pzydpzvPeConZ0QvBszuD6Cys1mwprrzW1FaZif52etItHFUHnC+Dvi
 6LzFZrF4bUUJyUMl7i+A1nDN9LykEbb3YksElG08v8tJ2QHn2JNJYaJYymq4SNwHehzO
 JpEmRUe2OrEucnTyrx3q3hLJdQ5qMt+kACcsb5jP4mgVxZnWNRKPLJJu6mtYabD6S2ub
 D7a6CdYAgyAI15M92MGrDSldQSAgAKKe8RPtelkRTbJAC4yuoBeHLS3OkHoWg1jro2/Z
 ryEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764326076; x=1764930876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zI2wMkbMBKUt2W98yHRekosrCFj34jOyeHq0ejrCQes=;
 b=MI2kAskPB87rZ0YtB1/Hl3Rbs1Z6ppdIMzIxDh4EkHvRJkirIAmSKLJrcbCPG/jYLA
 nQhbnram0Eck5lqhNT9RfWIc+z3pZcO+RKASrsX0ddMNgvbEm5O12Z77jv2Czo5Rh6gu
 Ru9qpTpKRmybZcmb+Jc5ahgtdVOPrryN+WEnXoqBtnIJv+ilzxWi04WSeFg8IfIv+0T8
 Y96aaz5TZxTm4tdXhHKhc+Gh++qDlGGKWP0luP0+p6f/I1PegqhXVkO9aRUVtUyjfEhE
 /mnWzbI5LXNJLqtmbMXYVIT1Lc+40vYTKBqXrFx7BB6HnKbmVmbp/gToXek1zvC1lTrE
 QyJw==
X-Gm-Message-State: AOJu0YzQq0l5lPlEO7yIvJYsE2/1GUCtMglcesN38VPHz4f0XI8iUwp3
 S4BSv/cOn696w2WyokJ9vNzWvv/rUy4nYqfEaYZfysPbvLpx3Srbd5Mbo/R0hyC8d0M=
X-Gm-Gg: ASbGncuB4/Tkzf/uNH6sfKRLxiK0AenmYAi8rfaR6kekRu5sASsZMaYHniBHOR//gOj
 GJfHRKxViCsWM/U+VmxPsWM5D//23hmFhWbK8mikGA3ULke+41E3iEODy9hsg6fpZnmJmmXpJVV
 bOtPqXFqPD0iIk6DuVXZltl7znLgeIzecO7RxdYxyW+dFRKkcAfUUWHVmoJBhQye+EPdSWqVXoJ
 lG6HI1AAorsILuSpyoGlUtKnhItZUNhDX84MUfoGkzQjgq1/D7pjNDzby+NDRZDn6J0KlyVT2Hb
 rCCNb8lDG0g+X3xeen5ROEeRm7yHktETyWRa8AB0wryIupmxjtKFB/FE0xbz+SDKfJU6LJq9q4K
 BYknjL/VoO7sszVJ7bY1BWUfXmqY8qSbHAoT4IWAuWDFLMBknwPwc6LSvej27kC8Zxem/pwTCRp
 ZpRXa+uNA=
X-Google-Smtp-Source: AGHT+IFzyYPSXDuV0akcny6oDt90PMOdrLYARUEV2h5tFi+kMPrUvjtu6Bq8yAAVO1c+E2C6orvqTw==
X-Received: by 2002:a05:6000:4305:b0:42b:5592:ebe6 with SMTP id
 ffacd0b85a97d-42cc19f327cmr29838593f8f.0.1764326076071; 
 Fri, 28 Nov 2025 02:34:36 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42e1c5c302esm8826337f8f.5.2025.11.28.02.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 02:34:35 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Fri, 28 Nov 2025 11:34:18 +0100
Subject: [PATCH 1/2] video: simple_panel: Add tfc_s9700rtwv43tr_01b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-topic-am33-evm-lcd-v2026-01-v1-1-ef75d4330d3d@baylibre.com>
References: <20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com>
In-Reply-To: <20251128-topic-am33-evm-lcd-v2026-01-v1-0-ef75d4330d3d@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3993; i=msp@baylibre.com;
 h=from:subject:message-id; bh=H1EMRdmyHyCN3xAFldIuf9WNJKa8UZG4TJS5NCgdZWM=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzNqo2K19Y/XK597v6jR23WEvfVNzsJt9bKpuy32cYtz
 LV5b9DsjlIWBjEuBlkxRZbOxNC0//I7jyUvWrYZZg4rE8gQBi5OAZjIF02G32yCeh8OnrH4tjtW
 t/PIpWkeU2Vt+o9cv2vHq6uitqem5Rojw++jEYfNV+m3151Zqxj/SlBLtHLNUo6pHtpX5tcfLqj
 M4AYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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
 drivers/video/simple_panel.c | 48 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/video/simple_panel.c b/drivers/video/simple_panel.c
index 0f23df701bc3c40ea49380bbfa3743ee592d8bd3..0a399acab3b3470f0af710f69176b48166ede2d1 100644
--- a/drivers/video/simple_panel.c
+++ b/drivers/video/simple_panel.c
@@ -22,6 +22,11 @@ struct simple_panel_priv {
 	struct gpio_desc enable;
 };
 
+struct simple_panel_drv_data {
+	const struct mipi_dsi_panel_plat *mipi_dsi;
+	const struct display_timing *timing;
+};
+
 static int simple_panel_enable_backlight(struct udevice *dev)
 {
 	struct simple_panel_priv *priv = dev_get_priv(dev);
@@ -107,10 +112,17 @@ static int simple_panel_get_edid_timing(struct udevice *dev,
 static int simple_panel_get_display_timing(struct udevice *dev,
 					   struct display_timing *timings)
 {
+	const struct simple_panel_drv_data *data =
+		(const struct simple_panel_drv_data *)dev_get_driver_data(dev);
 	const void *blob = gd->fdt_blob;
 	int ret;
 
-	/* Check for timing subnode if panel node first */
+	if (data->timing) {
+		memcpy(timings, data->timing, sizeof(*timings));
+		return 0;
+	}
+
+	/* Check for timing subnode in panel node */
 	ret = fdtdec_decode_display_timing(blob, dev_of_offset(dev),
 					   0, timings);
 	if (!ret)
@@ -158,9 +170,9 @@ static int simple_panel_of_to_plat(struct udevice *dev)
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
@@ -170,8 +182,8 @@ static int simple_panel_probe(struct udevice *dev)
 		return ret;
 	}
 
-	if (dsi_data)
-		memcpy(plat, dsi_data, sizeof(struct mipi_dsi_panel_plat));
+	if (data->mipi_dsi)
+		memcpy(plat, data->mipi_dsi, sizeof(struct mipi_dsi_panel_plat));
 
 	return 0;
 }
@@ -189,6 +201,28 @@ static const struct mipi_dsi_panel_plat panasonic_vvx10f004b00 = {
 	.lanes = 4,
 };
 
+static const struct simple_panel_drv_data panasonic_vvx10f004b00_data = {
+	.mipi_dsi = &panasonic_vvx10f004b00,
+};
+
+static const struct display_timing tfc_s9700rtwv43tr_01b_timing = {
+	.pixelclock = { 30000000, 30000000, 30000000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 39, 39, 39 },
+	.hback_porch = { 39, 39, 39 },
+	.hsync_len = { 47, 47, 47 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 13, 13, 13 },
+	.vback_porch = { 29, 29, 29 },
+	.vsync_len = { 2, 2, 2 },
+	.flags = DISPLAY_FLAGS_HSYNC_HIGH | DISPLAY_FLAGS_VSYNC_HIGH |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+};
+
+static const struct simple_panel_drv_data tfc_s9700rtwv43tr_01b_data = {
+	.timing = &tfc_s9700rtwv43tr_01b_timing,
+};
+
 static const struct udevice_id simple_panel_ids[] = {
 	{ .compatible = "simple-panel" },
 	{ .compatible = "panel-lvds" },
@@ -200,7 +234,9 @@ static const struct udevice_id simple_panel_ids[] = {
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

