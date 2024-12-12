Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF03E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F65802D5;
	Thu, 12 Dec 2024 11:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LfuTLhHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E4D8027E; Thu, 12 Dec 2024 11:21:36 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FE3180141
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d34030ebb2so732458a12.1
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733998894; x=1734603694; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u98pIYLNYHkdAP01dP3kxGGUfWCb4WqBkZ5h0725ugY=;
 b=LfuTLhHsFeYDuRFwY12MyUPEW0HWpu9t+Pa3e/IQ37DlteyJ7FqqpxeBYE6BiveubB
 D4lL/Gl+WQvIy/Z1IXOgEqez7ljwWdRr0astx+Z23j5dt/clDA1XsG6kwa1HRf4BU1dl
 /kUsGheM5mTPOFDgmJ2iIi6mDXBqZtRFVQm2CE4EygDazCa+kIgGvFuXUir8935+pXwt
 brJQp10PpkNuiZDP72GqjJnU5Y4mlHHFO6oXhKxC9QTGvIModbnTOxbmjDFzol6xr+Ky
 qjtoEB7nLCELhYhZ6hJFdfpGDPeGKo1LuIYpT6S+nJLNxnDS6GWgAe4Rlx0WTXvXwnME
 138w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998894; x=1734603694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u98pIYLNYHkdAP01dP3kxGGUfWCb4WqBkZ5h0725ugY=;
 b=jOeFV0HLCRlQjiHSkt8yeVKKPQB8rQ9tjlelS3PL0h/g7H5zraQMMS3vJ97pX3Pm21
 jlxu5OuE7/SbWc01RsjWrlHbb7jYBLmWRqIeYJg1itKLvXxRNC04x5EjTr2QF0eMZw/T
 LPTZ4mrgxZir5obWLkF9ieWKq9IFbyriXDsqujbN6xjSEsxjB/vMjaBbcDMoKvOQT963
 tVUTWfkaI7ELGsVr7GYFXtL2VhYJn6TFVcqlKHVb81MAMZ9FzWw3qfIlyfDdG0EO4N5D
 LMmaWWMcIYAcvId6cZ1fddbjBp9Ex+FtxTKMwmafqmLLeAspIrf1A6idun+HH44HvOlg
 B4PA==
X-Gm-Message-State: AOJu0YzmkR0hm189sFQLAbTCyAZ5Cq8UpX/t3K+RwNv4wYY3jdaPjZb/
 NYnHccCTcQjobX+Je+PN7rK80YlnzYUACaWjoed3qfCYW+3LK3Xa
X-Gm-Gg: ASbGncufdYkol2Ch7H//nZ+tBpSNXEdGoCoARPNQbXe5CqksFyS1wladuXl1Q4r98/h
 S8UycxE1slS6lC9vC9LUURJl9MlOhJXVfr1KWozkpWESIlWxBp5NeTgCxffhafU3ke4EWkP6z3U
 FKsRiEQBPyXc8SAtXet6FmCbSwFLxUiacWlqtd076CDsRql8x2Wm9T/qM0s8LlyAoKp41HmIxWs
 GdThALyo2bt9SIEY8FALizcsFb98viN35W+DApbxDbrHbzw
X-Google-Smtp-Source: AGHT+IGYukN51t2k2qhfpwdtZmQ9o6EYeCHQ2uIWqfPBP8d8jFDnSPV4Xr6S2An9jNA7g/M9ikGVaQ==
X-Received: by 2002:a17:906:9c1:b0:aa6:84c3:70e2 with SMTP id
 a640c23a62f3a-aa6b1180572mr606280666b.20.1733998893558; 
 Thu, 12 Dec 2024 02:21:33 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa67d6fcd3dsm646818066b.80.2024.12.12.02.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:21:33 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 06/12] video: tegra20: dsi: switch to newer clk API
Date: Thu, 12 Dec 2024 12:21:13 +0200
Message-ID: <20241212102119.6466-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212102119.6466-1-clamor95@gmail.com>
References: <20241212102119.6466-1-clamor95@gmail.com>
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

