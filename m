Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C86C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF35387D33;
	Tue, 23 Jan 2024 18:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNyS5Fi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8032087D4B; Tue, 23 Jan 2024 18:17:22 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02AFB87D6B
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a309c0a5593so160557766b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030232; x=1706635032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mw8MlDEi4PUQoh2XT7hXXtH4HTnzVaV0XqCBnmzXZJI=;
 b=XNyS5Fi3USQb5AxHg4uTs22xaRUpF/8fCjE9Gfbov35qplO/W1syy33tKJeqmZnM1y
 OuxsZwmJFFMP6+u79A6viBGXzzc2oCJ1K5x3EoMAuQAg0u3BOReYZC6L6YSkZC6P4GUJ
 KtEzBUgj8ZzA+UbtNt1BtQQ0Ir5+PFZ2+Hy0PPPpH5TLwro6R6MwTnRWQAt9zX0gYOW2
 UVKPcCUesHiYE8PeaMPw/1FEaVbhGdhqMSj6PYmmy4WvC+5SMPiFSlrYYdEhL2llIS7V
 OCcRlLKkw8WS/0kkH9H5OgZuU0/S8lbZEhCr5oWpEvYbwKg3Bo8UJLcduGcKxpC4EOMQ
 OBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030232; x=1706635032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mw8MlDEi4PUQoh2XT7hXXtH4HTnzVaV0XqCBnmzXZJI=;
 b=JifyijgWyCozd70eyibAh22RoNjnsg6KC101LJ6S1OEH2aEl00zh+G++jx6UYL71ca
 W/0gVW1iCVmLp9sNTNfusn0GodVeBQrf+yC/FFAgsepimw47uLhoYd89EFtIWrcVD5eb
 kxNMg/zNosvTG8LpiviIVrLywsufr5C/qcTdbEXT1sq7uekTfJrNYOw0E6LNTv7WRtzP
 G6uAtTERc8af1iKyYz2NYWTIkM7lY2MpBRkd0RMedXFz1hytscaTwiPXbL9dt3+02EAJ
 xQAoMU5khyvbpiCAaBPp60JsNfV2ZbjxrB31Bw0uJfM0S5mwjW6HOePM7HHQ4Z+qx6Ak
 l7Tw==
X-Gm-Message-State: AOJu0YzRIAlOgs95+OMFUtWvs8heNa08s1whSAwliYQtDDC3ZR0XkE7r
 75KsRWjOuR5uAYs1iNli+GWMqbj008sCkJMFTosCj5VWT7L3rgfA
X-Google-Smtp-Source: AGHT+IFn09Fiz3fcwDtt2aTIS4cJsqDliTcDkUmwkHrNGPZxnDz8h7/fMFDfhc9VN3dB3jH1c6FJdw==
X-Received: by 2002:a17:907:b001:b0:a30:33bd:78b6 with SMTP id
 fu1-20020a170907b00100b00a3033bd78b6mr65992ejc.180.1706030232222; 
 Tue, 23 Jan 2024 09:17:12 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 12/18] video: tegra20: dc: parameterize V- and H-sync
 polarities
Date: Tue, 23 Jan 2024 19:16:27 +0200
Message-Id: <20240123171633.246057-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240123171633.246057-1-clamor95@gmail.com>
References: <20240123171633.246057-1-clamor95@gmail.com>
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

Based on Thierry Reding's Linux commit:

'commit 1716b1891e1de05e2c20ccafa9f58550f3539717
("drm/tegra: rgb: Parameterize V- and H-sync polarities")'

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/dc.h |  5 +++++
 drivers/video/tegra20/tegra-dc.c     | 22 ++++++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/dc.h b/arch/arm/include/asm/arch-tegra/dc.h
index 6444af2993..ca3718411a 100644
--- a/arch/arm/include/asm/arch-tegra/dc.h
+++ b/arch/arm/include/asm/arch-tegra/dc.h
@@ -443,6 +443,11 @@ enum win_color_depth_id {
 #define	WINDOW_D_SELECT		BIT(7)
 #define	WINDOW_H_SELECT		BIT(8)
 
+/* DC_COM_PIN_OUTPUT_POLARITY1 0x307 */
+#define LHS_OUTPUT_POLARITY_LOW		BIT(30)
+#define LVS_OUTPUT_POLARITY_LOW		BIT(28)
+#define LSC0_OUTPUT_POLARITY_LOW	BIT(24)
+
 /* DC_DISP_DISP_WIN_OPTIONS 0x402 */
 #define	CURSOR_ENABLE		BIT(16)
 #define	SOR_ENABLE		BIT(25)
diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index caeec94468..ffa81eeac3 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -220,8 +220,11 @@ static const u32 rgb_sel_tab[PIN_OUTPUT_SEL_COUNT] = {
 	0x00020000,
 };
 
-static void rgb_enable(struct dc_com_reg *com)
+static void rgb_enable(struct tegra_lcd_priv *priv)
 {
+	struct dc_com_reg *com = &priv->dc->com;
+	struct display_timing *dt = &priv->timing;
+	u32 value;
 	int i;
 
 	for (i = 0; i < PIN_REG_COUNT; i++) {
@@ -230,6 +233,21 @@ static void rgb_enable(struct dc_com_reg *com)
 		writel(rgb_data_tab[i], &com->pin_output_data[i]);
 	}
 
+	/* configure H- and V-sync signal polarities */
+	value = readl(&com->pin_output_polarity[1]);
+
+	if (dt->flags & DISPLAY_FLAGS_HSYNC_LOW)
+		value |= LHS_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LHS_OUTPUT_POLARITY_LOW;
+
+	if (dt->flags & DISPLAY_FLAGS_VSYNC_LOW)
+		value |= LVS_OUTPUT_POLARITY_LOW;
+	else
+		value &= ~LVS_OUTPUT_POLARITY_LOW;
+
+	writel(value, &com->pin_output_polarity[1]);
+
 	for (i = 0; i < PIN_OUTPUT_SEL_COUNT; i++)
 		writel(rgb_sel_tab[i], &com->pin_output_sel[i]);
 }
@@ -329,7 +347,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 		basic_init_timer(&priv->dc->disp);
 
 	if (priv->soc->has_rgb)
-		rgb_enable(&priv->dc->com);
+		rgb_enable(priv);
 
 	if (priv->pixel_clock)
 		update_display_mode(priv);
-- 
2.40.1

