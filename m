Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C0ECEDD86
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED83983DD8;
	Tue, 18 Nov 2025 14:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V599j/zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56E1383CE8; Tue, 18 Nov 2025 11:42:33 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51D4A83C96
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b739b3fc2a0so299167366b.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763462551; x=1764067351;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S8AZHeSWar4oKjlZqNs9ebHBtSXFgXXV4Roe3Ai5TtM=;
 b=V599j/zjPPOYzbSYEw/Rmhu5Txw74NKrg3iERyGjg0yP/1vOYF2S1gdzXdxsYsXyGS
 wLtQ7lm6h/dNJ0spHUnIRk/c+j7G5PUHliIzWM25oFuY+HlT0hBGfPLPRh36I9B5jsb1
 6ryDhMob0dly7HiF4GoqSOnbRlQrn8t6YzzyNUqx+jpPcmB0MSN+ZUyUPMpb+Op3ftKT
 2E9F2Wvpk5AFhpk6GhwNJ5x8YntTYq7iJ72kAxsghng5dme5XvosCq2NtywvTko///Dg
 8KpV3C4a0P2ti8QuaEeTvo3KIfaJjLPjUO/+LPZlUb0eCnoFvgscAH7Fy2yKHrkeAs0I
 n9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763462551; x=1764067351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S8AZHeSWar4oKjlZqNs9ebHBtSXFgXXV4Roe3Ai5TtM=;
 b=GGiZVxbWHgBGdNalRh8stwjHkrQuCYpgqx3CXpuQuCalSU6JhjY41p31XEG6ji8ISO
 ZA0TfrCym6pn8N2pcDCQp0pUf6z2wTf9GS/CIkuHqikURb++sS16dYUNGLOzNVMq2gdf
 odOV7nsf/hFEHDSag1P6M4KmAoUjqyZVi/G563DAr82K17kgolR1O+fhxeOV79p+3ATL
 wvMqqx4DmUsOuSQhuUO6fHLfiIauJZC1miPpmpqwo3AlqlHziJBeDr2L1jQhB0kGT5Z4
 0PG8mtrvInh3c4b44jEWps551A1RuiT3k1lNUzVmes9le351YgbLGzf2rfDPE2rXb/Ei
 rTsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgKJvVc4HSRuefiLMtUQ3JupyetOoL9boKtH2lVS/hgPrqlfgW5wHqxMJeHGiDu1mGXxOGLjI=@lists.denx.de
X-Gm-Message-State: AOJu0YxlTq2ip5IVpqcO3VA3Bgs3eg2lVrwiNMoAVfxf40eyzDwdoRDb
 hcK2Je54l0mQXZ10a1Xg4Rp9Jxl1uWMwdEBVUhjGahiHlgtambjH8/PhG4PXWT+ZHIM=
X-Gm-Gg: ASbGnct89DNI2liSsY8NY6nkCtpDnjeDCzNpkuDIqvc4HHdlbrXqpFc2wwn6Fwij4hv
 ogY9KTA4mljmByzXQCXRD7qJGpKw66+OiqRTnlhykB3n/3c7RQHXdXO4qLwWgTwOxXWWTq9U7nb
 5Zzomxy2PKZNFXBSvgyAwh9164eGTCvV1vYuaQaKgChrdci4ly4yaCMX2q9v8y1S5sGf8mpkUfz
 Ilu/wl92DSTIBalFzPCx4ZPnR8WJENbCNW0aEE8EXIT4k7FZqFwgtqSZjwVQaCf+OC4EJGII7H1
 tjKgwmAsT5FypXMUIMA4irbxKkEFzLSTtOeW1YT+AP7kQ3UTJZdLAc0yod6rHJ87RXGQwPFU0/k
 Ocnhcl3A1BIrsnyUGB9qeRysOK89KkdngeyPtH4rP3ns2cJCK4LKdU1zWNygqYHgoJdsNwF1K
X-Google-Smtp-Source: AGHT+IGLDK1MHgW2a99S190BLqAwVWvt6yCocibBgplcvTlB2RycbPCHQ69VefG7X5wvENyfNsPnig==
X-Received: by 2002:a17:907:9694:b0:b76:27cc:5146 with SMTP id
 a640c23a62f3a-b7627cc52d7mr176316066b.28.1763462550704; 
 Tue, 18 Nov 2025 02:42:30 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b734fed9e9fsm1313289466b.69.2025.11.18.02.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:42:30 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Tue, 18 Nov 2025 11:40:33 +0100
Subject: [PATCH 13/15] video: simple_panel: Add tfc_s9700rtwv43tr_01b
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-topic-am33-evm-oftree-v2026-01-v1-13-91ce13c661e2@baylibre.com>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Kory Maincent <kory.maincent@bootlin.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Liya Huang <1425075683@qq.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Romain Gantois <romain.gantois@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Sukrut Bellary <sbellary@baylibre.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3996; i=msp@baylibre.com;
 h=from:subject:message-id; bh=4Y5tX8oB6Nt+P0cr1scbzQA5GO/dorf2bXFNVCykO+g=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwZ36K0/jX/+wNU31ezcem9Cn82T4D51PkYtjXcj/e7x
 6kGTxLrKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgImc2szI8KVishuX0W3NhK6A
 +p1sYgnrZm9ZpLXm3yQjH/cTblmrljMy7NH6bBbtckTWa3rAYQfW6B7O5ZMlT/F8OjBB9Ofsk9e
 a2QA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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
index b6c5b058b2e967bbbd47ab3c3ce5ca52c7804409..418a2764b5328a9c40161b4bedb8636509e93c6d 100644
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
 	{ .compatible = "auo,b133xtn01" },
@@ -199,7 +233,9 @@ static const struct udevice_id simple_panel_ids[] = {
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

