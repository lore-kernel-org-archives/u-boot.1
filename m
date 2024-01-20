Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7921EC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D114587DF9;
	Sat, 20 Jan 2024 17:56:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P3q1Qj7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32F087E23; Sat, 20 Jan 2024 17:56:26 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A50F87D28
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so22438805e9.3
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769780; x=1706374580; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L3QtXx/T3xUEvvsISTLaN46ZWgZ90SosYKngtbt/btc=;
 b=P3q1Qj7zw8i9UZfXh5s2r7mHpOWFZsKYD4PQ6GN0GKoaM7WEzISTnrVpkOj1IhgSR2
 2jrGGe/DvOLhsmXkJ9QSBUu/gpqNzx6JuOV4vawTcucScgQfNJiqmisCiA1Ik8aD1tLA
 StOuxokBL+/j+ckIiyUP+hat9VN5b5DpAtVlf+luJma2YWNY7JMsA27mZxMWMKCcsJow
 b0DmFGd8gdEOcsbeAaRL2eDWcZuKGmTw1rXMSPgaw0/2L0FqP93e4X69S1atXNkxngPe
 /CgAZQ0pbDnTOnkOgwe7ivsAlvVNvwMtm527LUrpjLhRpK+E3uJUN5AbxasH9/u/W8Cp
 5aYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769780; x=1706374580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L3QtXx/T3xUEvvsISTLaN46ZWgZ90SosYKngtbt/btc=;
 b=vwWj7iTv0EmYODo9wmEUVDh7LxEXYKMtqGj0OA0A4o2CFFMl4u6JqP5rkiCoPaL8+C
 D1DJwwrtRLSf7KsfCO6ugCR8+7T+2K4uIFAMmYSnUdC9e4wa2AD/IPPhQ+bwD1ZULraW
 2rUkyvnAWtSRg47ofVy8KQCl1cnfLyn71BHaQS0SLRdL/AUVaGkv1qz/jrLujyFOU2to
 TTY1KE6LG4007fw+xoI3JX7RxQmGqyM6SB26FA0Iw7ImNzJGKtdBO3xvk2yOSOq+0Jjg
 WakSgIjSfLeleh5tBC5AJeaA5bXJ6Llesvn8FixBAm4VBjoao8WvOYV1GE9m4XAO8VEW
 2B3Q==
X-Gm-Message-State: AOJu0YwrgKRP2yrBn7+o6JqRCez26eXTW2EN2A1gyzK0rIUKaBg9uomf
 KHsBnx0QFhmU6KE2TObPrx6k199cjcpbp2aN6t8hj+au51UCpL5g
X-Google-Smtp-Source: AGHT+IFkJUbeBNAg65AiY9qlo8JhNzMcSDsoOUDcs5KB7sXyD8gFwvcSKb57GEFYt85InaexA9gunw==
X-Received: by 2002:a05:600c:41cc:b0:40e:423a:54e8 with SMTP id
 t12-20020a05600c41cc00b0040e423a54e8mr877915wmh.56.1705769780399; 
 Sat, 20 Jan 2024 08:56:20 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:20 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 08/13] video: tegra20: dc: fix the clock divider
 calculation if PLLD/D2 is used
Date: Sat, 20 Jan 2024 18:55:38 +0200
Message-Id: <20240120165543.10226-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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
index 9a18e38cd8..999651aecb 100644
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
+		if (rate > 400000000)
+			rate /= 2;
+
+#ifndef CONFIG_TEGRA20
+	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY2)
+		if (rate > 400000000)
+			rate /= 2;
+#endif
+
 	/*
 	 * HOST1X is init by default at 150MHz with PLLC as parent
 	 */
-- 
2.40.1

