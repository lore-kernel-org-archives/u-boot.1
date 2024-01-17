Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CB7C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C69EB87B76;
	Wed, 17 Jan 2024 18:17:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fvWDtmz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E923D87B9B; Wed, 17 Jan 2024 18:17:31 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F343A87B9B
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-559dbeba085so1100449a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511847; x=1706116647; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5zWdzOQpIDW/tJHLBKxZ/1C4wJeFzY2y/qV9nEACQw=;
 b=fvWDtmz0YTVm9UbjADxGq6X+RvY6nL0trmUl1On2qdVXqGI3BGBntLU4noyKDTjQQM
 Oh41i4yAe7j6xdFwNLUesW7u76jt/nfR5Ys7260sGVBa+js44+rcfAEt+JH8kZi4iQ6h
 S2wsuZtFdBKonSZDxbUUjPCUjMSO4FkpMBAjiJb+6qkfQr7Vz0ZZ/kvY2XlS25956tJJ
 bsuF39uXDFtbN3Xn4d2cPSFA+M0uL+rgI0fcAfoX21iyXFJKftEBg/2uJmnrPVIYzrbj
 1/ylcM5kq5VOlCWDFySASjWnEm79AbzSc1coAHxeqXS0eTJHwbFEb7Ydj+3rPnxD3NVg
 KfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511847; x=1706116647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N5zWdzOQpIDW/tJHLBKxZ/1C4wJeFzY2y/qV9nEACQw=;
 b=cpjvFP3pFrws5RgBpeg/XhzZUFMhHXxl5XxQPbNH/EJhidVNNDDD2XPCBbXrg6uHYM
 lG3eS0+CwhUYGu10iIs5MJ9v4/3hqjHalOvrCfXzUUo1qIgKVZNy+E+8XNee43uEFoxV
 Jy9bFASXhzfhpoqKdPtM04GKiD1ujE8oxNHGyw9Cr5+3GvcExeB8k5UJC56BeIXC8TvG
 HkdmK4g2eC8Z4zijwGZw2ljcu8d7+JD8ER00w7ZnLmiZPPSzrK4LAZCWuD8ep6sgLMtd
 kFXUqnFcbQnRI97UCDorDM5ytII/5ytu8S+QuCpNEcAhQnMymb3di09Tx1qHuokxVwS+
 5oaA==
X-Gm-Message-State: AOJu0YzRk8A9Fahh5TpgyX4cztM3zrcYwULoBMEYYfULOv0kX9GHZebS
 0LhshSWKGwOK+x+vWDJ1vco=
X-Google-Smtp-Source: AGHT+IFs7akD1LbgWkFFN6AsBFzp2zbXlPrFFyXpYcqikFSmnBK8pARFwVo+iUOWJ9cO3FwaYNExEQ==
X-Received: by 2002:a17:906:13c2:b0:a27:32a0:b838 with SMTP id
 g2-20020a17090613c200b00a2732a0b838mr4690241ejc.112.1705511847362; 
 Wed, 17 Jan 2024 09:17:27 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 08/13] video: tegra20: dc: fix the clock divider
 calculation if PLLD/D2 is used
Date: Wed, 17 Jan 2024 19:16:53 +0200
Message-Id: <20240117171658.22324-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If DISP1 is a PLLD/D2 child, it cannot go over 370MHz. The cause
of this is not quite clear. This can be overcomed by further
halving the DISP1 clock if its parent is PLLD/D2 and the target
rate is > 400MHz.

Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Tested-by: Jonas Schwöbel <jonasschwoebel@yahoo.de> # Microsoft Surface 2
Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 41 ++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 9a18e38cd8..42d91a03b6 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -48,6 +48,7 @@ struct tegra_lcd_priv {
 	fdt_addr_t frame_buffer;	/* Address of frame buffer */
 	unsigned pixel_clock;		/* Pixel clock in Hz */
 	int dc_clk[2];			/* Contains clk and its parent */
+	ulong clk_div;			/* Clock divider used by disp_clk_ctrl */
 	bool rotation;			/* 180 degree panel turn */
 	bool pipe;			/* DC controller: 0 for A, 1 for B */
 };
@@ -126,8 +127,6 @@ static int update_display_mode(struct tegra_lcd_priv *priv)
 	struct dc_disp_reg *disp = &priv->dc->disp;
 	struct display_timing *dt = &priv->timing;
 	unsigned long val;
-	unsigned long rate;
-	unsigned long div;
 
 	writel(0x0, &disp->disp_timing_opt);
 
@@ -150,21 +149,11 @@ static int update_display_mode(struct tegra_lcd_priv *priv)
 		writel(val, &disp->disp_interface_ctrl);
 	}
 
-	/*
-	 * The pixel clock divider is in 7.1 format (where the bottom bit
-	 * represents 0.5). Here we calculate the divider needed to get from
-	 * the display clock (typically 600MHz) to the pixel clock. We round
-	 * up or down as requried.
-	 */
-	rate = clock_get_periph_rate(priv->dc_clk[0], priv->dc_clk[1]);
-	div = ((rate * 2 + priv->pixel_clock / 2) / priv->pixel_clock) - 2;
-	debug("Display clock %lu, divider %lu\n", rate, div);
-
 	if (priv->soc->has_rgb)
 		writel(0x00010001, &disp->shift_clk_opt);
 
 	val = PIXEL_CLK_DIVIDER_PCD1 << PIXEL_CLK_DIVIDER_SHIFT;
-	val |= div << SHIFT_CLK_DIVIDER_SHIFT;
+	val |= priv->clk_div << SHIFT_CLK_DIVIDER_SHIFT;
 	writel(val, &disp->disp_clk_ctrl);
 
 	return 0;
@@ -314,6 +303,32 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 		rate /= 2;
 #endif
 
+	/*
+	 * The pixel clock divider is in 7.1 format (where the bottom bit
+	 * represents 0.5). Here we calculate the divider needed to get from
+	 * the display clock (typically 600MHz) to the pixel clock. We round
+	 * up or down as required.
+	 */
+	priv->clk_div = ((rate * 2 + priv->pixel_clock / 2)
+						/ priv->pixel_clock) - 2;
+	debug("Display clock %lu, divider %lu\n", rate, priv->clk_div);
+
+	/*
+	 * BUG: If DISP1 is a PLLD/D2 child, it cannot go over 370MHz. The
+	 * cause of this is not quite clear. This can be overcomed by
+	 * further halving the DISP1 clock if its parent is PLLD/D2 and
+	 * the target rate is > 400MHz.
+	 */
+	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY)
+		if (rate > 400000)
+			rate /= 2;
+
+#ifndef CONFIG_TEGRA20
+	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY2)
+		if (rate > 400000)
+			rate /= 2;
+#endif
+
 	/*
 	 * HOST1X is init by default at 150MHz with PLLC as parent
 	 */
-- 
2.40.1

