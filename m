Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3819CC79F8D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 13:04:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AA8083DDD;
	Mon,  5 Jan 2026 14:03:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SuQdrwEV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 518F783D07; Mon,  5 Jan 2026 10:37:07 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F32C83CEA
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 10:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so11017226f8f.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 01:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767605823; x=1768210623;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v53cM8zFVt5V6Qdi43ddMsmQjWIq9V/G0NJ5fMcTUtg=;
 b=SuQdrwEV6R/Jh3x0mIt5jOSii9qLcdws6nwGegZ28UkN/mTx+kyLAW8go5l8IQOOoy
 Eo8Gyk0qdpzXwyoGf9JDxQgEjD/zJ8iAJPXLUbaDpECtIBjy8fGiD2IB6f+QsqTulO16
 LhThpSJmLIAyjOJeeCFnNFQpSfZ8tDXVHquvGmxmHDNBs4DlTeHSodTT/e51Q6SPBNpQ
 W2YJ/RR+tS1wmMfScCTYi4+UwtNXUKCDwvRdJg/GSS+rcf+T2AKT5z1hKCCPg9r3dSJl
 M7V/bFMgpnSRHtFi9UX6K91c/WkmQ7U7JXpCOM9/Y/KzOxyy23aejr2+Xe2RIENQoAoZ
 fiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767605823; x=1768210623;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v53cM8zFVt5V6Qdi43ddMsmQjWIq9V/G0NJ5fMcTUtg=;
 b=NQD4L8A+3g07trqoIaw24K0oQ30/SBkpXbGW/xxHuls2uxr0liwkBcYQHz0b3RawXP
 LhPXN4hRFUYUcwFguASSyZA+0Zg3QiU2bE2fwAujDUsZtpLVdHvRskEh1Ky7aHqacOPK
 6JsOxlTP6NWqj9yIzou+aCzQ9wMAg7UQD+KiGctolzn7/Plg8VOH+uKo3YjLoMNk45BK
 h/mK+lLDeA4g3mWfZjbTdR7FUqaRATLLbdWZqKQhnQ7zuQUbx2LlrfyyARaWAt0CrxEt
 ZXNdg1F7ZaaVzPPAkeASAJPHPpAipmvOBCnzpO4TGcE1Ko8oTQ2+mkZASeNR4Va4RBPr
 PJow==
X-Gm-Message-State: AOJu0YxrySsA4Gl3PHRWyTuZQoZskk5DtKELV1SL/VJGFbi7s8gbpMqa
 YUfFS58p1FqMI6yMjvkM0AUvfZd8lxLP307+vKG360e1/LTb366tGVjG5Qt2urhq6Hg=
X-Gm-Gg: AY/fxX5lyi6UUP6QR2qneTTMeLcU0EiKSYejlESB0glSxy1O7eN3MFzTBgfGl1CiYuP
 aVyr7USjJEdpKYnQ2Rncwda/14oHysYfgp2PKkMQ3cKKpAv7tUEJ2G/GoDxySUkwHFknbsSRdIs
 lSa49sYw+aVzShFiqlbVsE6kW9BuWT7YKFI3QARGMq+60FsNOwDigppp6aTWmvfKBQTw71N70jj
 ZF4MNetQKL+cw8lPzthj2/PKYBdsdhgj6R7y0KK7KrkRm5wTzcQL9pvhnaIGuAm2lFwMNbeaWmX
 0MJtPc2pcUai/9X/EP8pLiRPu/efkmDJL88wz80eX40bxx5oE1Bz25UKRXBT5UlnoISkSqubSzY
 uj/FCzCuUy1ctzcUB0I7Uor3XhdTriGXxwf1+cHWAgOkoo1ZSGcpxsi0YjqMGPC9eql1VjpmIXe
 /F7dnkEXoo
X-Google-Smtp-Source: AGHT+IHFLdD7r4AnbdqsEaUxCCRbe9qDWB5gaR/qtz1sWNXniH6kErflYasi1rXNUKKvuKwM+UKwpA==
X-Received: by 2002:a05:6000:248a:b0:430:f454:84ae with SMTP id
 ffacd0b85a97d-4324e7093d4mr58420990f8f.63.1767605823496; 
 Mon, 05 Jan 2026 01:37:03 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa4749sm101095549f8f.37.2026.01.05.01.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 01:37:03 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 10:36:28 +0100
Subject: [PATCH v4 3/4] video: simple_panel: Add tfc_s9700rtwv43tr_01b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am33-evm-lcd-v2026-01-v4-3-7617591b8159@baylibre.com>
References: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
In-Reply-To: <20260105-topic-am33-evm-lcd-v2026-01-v4-0-7617591b8159@baylibre.com>
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Yannick Fertre <yannick.fertre@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, Fabio Estevam <festevam@gmail.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4711; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kAfdJGsp8B/N8X+OdMCoaA6BQt6MZCftz01ntkJnWSk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszoNgOJnjTdhb2ms0LXFluYPwroVHn+Pn7vP/28gELDV
 KdDFsIdpSwMYlwMsmKKLJ2JoWn/5XceS160bDPMHFYmkCEMXJwCMJHIX4wMjxUmN3pX/5hhsirZ
 7pfRxwyJZ5XJ+75funisQKJm454tZYwMm5Z9KFHlVg/++vLfU9umF/XvkjetOn3U2PxNluSTC6K
 b2AE=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 14:03:25 +0100
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
index 0f23df701bc3c40ea49380bbfa3743ee592d8bd3..8fa7ea4e87c4c0b6bec4ae6e0f0b4d4a27cf8dd1 100644
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
+	if (data && data->mipi_dsi)
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

