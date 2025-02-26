Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE1ACC021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A913780FEC;
	Wed, 26 Feb 2025 12:54:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LDwgD0m2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E068D80FD1; Wed, 26 Feb 2025 12:54:17 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FA880FFC
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-abb79af88afso166198166b.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570853; x=1741175653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u98pIYLNYHkdAP01dP3kxGGUfWCb4WqBkZ5h0725ugY=;
 b=LDwgD0m2SosjB4y4KQp6dvLOvyw1bdIL3sywIeHf0WeBWzOFE8IjYeVCb2uQkZjYM7
 H7u8ddKFA/A3s28lXL3FDl9YZx0bu+EyX9g4icMrdcaszHwka7Z1zQtzXWoxlxmRddTx
 gCbjdCM8RYTOsGGw09xFtXw1H4FOdPhIRI8Uum3TJFehUktJLIC0oE+jIJ31LlT0Pu62
 iLLrFZjfj6c9W8JWz9t0km5y8QHgS+PYMDiaH5219isRt2DIBixSTkTEHirYyJFwlfnC
 6+ZeIqsI7upREgkPnnVBw8yvQPeNNrV/hZzltIysPWW3F4W7hvUsJ3dlnkozglpZnB8M
 kmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570853; x=1741175653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u98pIYLNYHkdAP01dP3kxGGUfWCb4WqBkZ5h0725ugY=;
 b=TkTRdfnoK3m74aLPmlmsKmvYzSVKzsS5zsYFinyI6JuP5kJ7dtEgvmLl+5HgMAEHNP
 ZSNZmxbN+UncGIG29li6nEvheIBgjeQLjBFH0ExA4Unesw6nDAD1lGWDlA1q9fC+/g+2
 HlYKE4i9AzBanKXao9PSB5dQcJBLHZp3DPaITcsPEA9IBV+wxw0ddhQouSlHqa+Ya6Co
 m/xJNtQraXWNiCwKbF6UtccI/cFSX5QXRw6QJChWN7aX21O8cb73b2YHhgVVoHLnTNe/
 CpjNKGERwvGsSQ8qhmtEPE76bMhXilGRwAK0bBfO9f3JgeFKN5OYdaNmUd+hsXPhAT/I
 4jfg==
X-Gm-Message-State: AOJu0YyiMN1pVZZSkO1/GWZ7zMpXAL8IdyrYrrkJ/s814QylDcEmu3Jw
 INw5IPidnrToInacCVAzB6mRwWUHr20VzgGLgZjyckOa2g7bsDTj
X-Gm-Gg: ASbGnct/aMvdmoV/l7bj70asQWv+YgF8smvULgZb/ZgGhpsdXFee+aykvOFRSnc0VXK
 UJA8v0e0sMYHA4oBQIcz/79W31zkfUAivTzYUIWU99JOB8mciGfmQEC8WGYxDuaEJRb6cOSSXc/
 1DI9heIuU4qop5EzLBxq2D/XYCLY5ipKfbro4hoIGPqcwW09+uhvCNoY7MQu7rmYPIa9bHUl8nt
 xZECvLudHXuO2eo3rvOxOx/Qhqw3XzK0CqYNJ0RLeWiVXsB/6AhiXcinprIIfBrElEeVfSAABlj
 M4sGqdsygSK+Ie3dBg==
X-Google-Smtp-Source: AGHT+IFNN72HtQz6kVjAEW0OyRQsM1IglTxgVjsB1AcI+Zpx9AA+HCYJQsiD9THjRiilNRd5g0JQTw==
X-Received: by 2002:a17:906:b818:b0:abc:29e3:f453 with SMTP id
 a640c23a62f3a-abc29e3f7cdmr1695500166b.33.1740570853363; 
 Wed, 26 Feb 2025 03:54:13 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:13 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 06/12] video: tegra20: dsi: switch to newer clk API
Date: Wed, 26 Feb 2025 13:53:32 +0200
Message-ID: <20250226115338.42832-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226115338.42832-1-clamor95@gmail.com>
References: <20250226115338.42832-1-clamor95@gmail.com>
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

Switch to struct clk instead of working with plain clock id.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 49 ++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 53db5a25d40..97a30402902 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -5,6 +5,7 @@
  */
 
 #include <dm.h>
+#include <clk.h>
 #include <log.h>
 #include <misc.h>
 #include <mipi_display.h>
@@ -46,7 +47,9 @@ struct tegra_dsi_priv {
 
 	enum tegra_dsi_format format;
 
-	int dsi_clk;
+	struct clk *clk;
+	struct clk *clk_parent;
+
 	int video_fifo_depth;
 	int host_fifo_depth;
 
@@ -862,12 +865,26 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 	unsigned int mul, div;
 	unsigned long bclk, plld;
 
-	if (!priv->slave) {
+	/* Switch parents of DSI clocks in case of not standard parent */
+	if (priv->clk->id == PERIPH_ID_DSI &&
+	    priv->clk_parent->id == CLOCK_ID_DISPLAY2) {
+		/* Change DSIA clock parent to PLLD2 */
+		struct clk_rst_ctlr *clkrst =
+			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
+
+		/* DSIA_CLK_SRC */
+		setbits_le32(&clkrst->crc_pll[CLOCK_ID_DISPLAY].pll_base,
+			     BIT(25));
+	}
+
+	if (priv->clk->id == PERIPH_ID_DSIB &&
+	    priv->clk_parent->id == CLOCK_ID_DISPLAY) {
 		/* Change DSIB clock parent to match DSIA */
 		struct clk_rst_ctlr *clkrst =
 			(struct clk_rst_ctlr *)NV_PA_CLK_RST_BASE;
 
-		clrbits_le32(&clkrst->plld2.pll_base, BIT(25)); /* DSIB_CLK_SRC */
+		/* DSIB_CLK_SRC */
+		clrbits_le32(&clkrst->plld2.pll_base, BIT(25));
 	}
 
 	tegra_dsi_get_muldiv(device->format, &mul, &div);
@@ -893,16 +910,16 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 	switch (clock_get_osc_freq()) {
 	case CLOCK_OSC_FREQ_12_0: /* OSC is 12Mhz */
 	case CLOCK_OSC_FREQ_48_0: /* OSC is 48Mhz */
-		clock_set_rate(CLOCK_ID_DISPLAY, plld, 12, 0, 8);
+		clock_set_rate(priv->clk_parent->id, plld, 12, 0, 8);
 		break;
 
 	case CLOCK_OSC_FREQ_26_0: /* OSC is 26Mhz */
-		clock_set_rate(CLOCK_ID_DISPLAY, plld, 26, 0, 8);
+		clock_set_rate(priv->clk_parent->id, plld, 26, 0, 8);
 		break;
 
 	case CLOCK_OSC_FREQ_13_0: /* OSC is 13Mhz */
 	case CLOCK_OSC_FREQ_16_8: /* OSC is 16.8Mhz */
-		clock_set_rate(CLOCK_ID_DISPLAY, plld, 13, 0, 8);
+		clock_set_rate(priv->clk_parent->id, plld, 13, 0, 8);
 		break;
 
 	case CLOCK_OSC_FREQ_19_2:
@@ -914,11 +931,7 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 		break;
 	}
 
-	priv->dsi_clk = clock_decode_periph_id(dev);
-
-	clock_enable(priv->dsi_clk);
-	udelay(2);
-	reset_set_enable(priv->dsi_clk, 0);
+	clk_enable(priv->clk);
 }
 
 static int tegra_dsi_ganged_probe(struct udevice *dev)
@@ -955,6 +968,20 @@ static int tegra_dsi_bridge_probe(struct udevice *dev)
 		return -EINVAL;
 	}
 
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_debug("%s: Could not get DSI clock: %ld\n",
+			  __func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->clk_parent = devm_clk_get(dev, "parent");
+	if (IS_ERR(priv->clk_parent)) {
+		log_debug("%s: Could not get DSI clock parent: %ld\n",
+			  __func__, PTR_ERR(priv->clk_parent));
+		return PTR_ERR(priv->clk_parent);
+	}
+
 	priv->video_fifo_depth = 1920;
 	priv->host_fifo_depth = 64;
 
-- 
2.43.0

