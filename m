Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE75C021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E4B80F12;
	Wed, 26 Feb 2025 12:54:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IQUY3lQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D810680FD1; Wed, 26 Feb 2025 12:54:11 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCFB280F3F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso1019913766b.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570848; x=1741175648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcqNW5qzOgc9MjscPcPq/f35gRoGcz+XOaRbAu2YvZo=;
 b=IQUY3lQ+AVTSO/iOtrwPeOKr3FXuVpx2FJrziDnluQOrMqr30jKsCGqiAyQ4ZAlImr
 93/sfUYhucxxwaXUT95wRXVzU8hk4RXvBloGmQz4zmMkR+HPZey7W74TOlQdPeaWIDuK
 2d/b6SYpHrhMIFjADzwQRXbMJQrx7oh+zcmvn+HlunWAekQMXTQRILk6tm0g79Hl1O0i
 3GJj6wKsZp8VNGdvPI1ZQl887ll7dYjwKM6rijSXOp6ppA0bSIxDUKghdpR5Dx4KW60Q
 TmZRviJnnPGRd/c6HuiHOAt9vOGQPioRq1/msh8PAlQ74iqOsL9OTRck70F7AGwx43Bq
 rcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570848; x=1741175648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcqNW5qzOgc9MjscPcPq/f35gRoGcz+XOaRbAu2YvZo=;
 b=eL5blf1Pz/TUYl0T5rkM7qVEcYqameFhw/fSaBXhLLNHMGtcoOOjRc1UwLFN4NodCl
 ewIbr4ba+U9HeERMuA0eNaEdYPB+UODBC3mQvmWi8QNX99uLcFoet0jHMjTPY/JIsoET
 s+kEOMuRqMjeo8xkojVc70SA0uTZ3nSmCl/qFSGRY4Q2PnNir/N2xNadO4UTgYKIuUEj
 zjQOtPWImI6Y7J0mMx2kGjxNd0HF7TEd46TYZcW6qjDGgO2woE+qbNw6lfj33BsCy9Av
 1iiE8WXioK5j63YLJ5Oe/R4dQOXqAjPw2P1MJioZfv1O6BANODxvXbnGAcMfJDOMDLMo
 SY1A==
X-Gm-Message-State: AOJu0YxWwuto3EzmK2Gckywg+M1zXAPJH4dOoYiO1zXIJkaQ8hTcrWtD
 mjyRSc7htEa5HW+hgRVQEWDnP9RbBoNMV6IEx9FZzWEz7MleB1fw
X-Gm-Gg: ASbGncttRaeCpXJiqkj7RlUuZBGDqKofwu8hXDisLWSzohC9Ho7qELhC6vh6zOFKP3n
 WQmRiYmjQi4T8lJAhTOp9BEq6ds6PlAlXrMAQLNlnEjciHf01IFLjogaEGGg0uMtLEtYCkZatHW
 Xj0Eug2uLTkeP+eXiNULWejv0fstXCE9J58O5KDLRwjhha0HciS2pCbRHWoo9ntKD701N4bgN58
 k0M676JrRt5qe93ggJjE+BXnALRR5Mdn+vg5fpSu1jGs6vr6m4mOz5WnRRCMzBMbFoY1rSgoqdf
 OXxkKwrjk4QvyH/gKA==
X-Google-Smtp-Source: AGHT+IHZH0OxyxcurpvQMIkYOF54oTGoe22D0I8+/aat9eNp+REkPAZeI9+3kgsotu/2vQT0V1zHnw==
X-Received: by 2002:a17:907:1c17:b0:ab7:d06d:b4bf with SMTP id
 a640c23a62f3a-abeeef3630amr326496266b.39.1740570848080; 
 Wed, 26 Feb 2025 03:54:08 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:07 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 01/12] video: tegra20: dc: switch to newer clk API
Date: Wed, 26 Feb 2025 13:53:27 +0200
Message-ID: <20250226115338.42832-2-clamor95@gmail.com>
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
 drivers/video/tegra20/tegra-dc.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index d24aa375b39..bd0d8ca7b8f 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -5,6 +5,7 @@
 
 #include <backlight.h>
 #include <cpu_func.h>
+#include <clk.h>
 #include <dm.h>
 #include <fdtdec.h>
 #include <log.h>
@@ -44,7 +45,8 @@ struct tegra_lcd_priv {
 	const struct tegra_dc_soc_info *soc;
 	fdt_addr_t frame_buffer;	/* Address of frame buffer */
 	unsigned pixel_clock;		/* Pixel clock in Hz */
-	int dc_clk[2];			/* Contains clk and its parent */
+	struct clk *clk;
+	struct clk *clk_parent;
 	ulong scdiv;			/* Clock divider used by disp_clk_ctrl */
 	bool rotation;			/* 180 degree panel turn */
 	int pipe;			/* DC controller: 0 for A, 1 for B */
@@ -301,7 +303,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 			       void *default_lcd_base)
 {
 	struct disp_ctl_win window;
-	unsigned long rate = clock_get_rate(priv->dc_clk[1]);
+	unsigned long rate = clk_get_rate(priv->clk_parent);
 
 	priv->frame_buffer = (u32)default_lcd_base;
 
@@ -309,12 +311,12 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	 * We halve the rate if DISP1 parent is PLLD, since actual parent
 	 * is plld_out0 which is PLLD divided by 2.
 	 */
-	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY)
+	if (priv->clk_parent->id == CLOCK_ID_DISPLAY)
 		rate /= 2;
 
 #ifndef CONFIG_TEGRA20
 	/* PLLD2 obeys same rules as PLLD but it is present only on T30+ */
-	if (priv->dc_clk[1] == CLOCK_ID_DISPLAY2)
+	if (priv->clk_parent->id == CLOCK_ID_DISPLAY2)
 		rate /= 2;
 #endif
 
@@ -334,7 +336,7 @@ static int tegra_display_probe(struct tegra_lcd_priv *priv,
 	 */
 	clock_start_periph_pll(PERIPH_ID_HOST1X, CLOCK_ID_CGENERAL,
 			       150 * 1000000);
-	clock_start_periph_pll(priv->dc_clk[0], priv->dc_clk[1],
+	clock_start_periph_pll(priv->clk->id, priv->clk_parent->id,
 			       rate);
 
 	basic_init(&priv->dc->cmd);
@@ -383,7 +385,7 @@ static int tegra_lcd_probe(struct udevice *dev)
 		}
 
 		ret = tegra_powergate_sequence_power_up(powergate,
-							priv->dc_clk[0]);
+							priv->clk->id);
 		if (ret < 0) {
 			log_err("failed to power up DISP gate: %d", ret);
 			return ret;
@@ -451,11 +453,18 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 
 	priv->soc = (struct tegra_dc_soc_info *)dev_get_driver_data(dev);
 
-	ret = clock_decode_pair(dev, priv->dc_clk);
-	if (ret < 0) {
-		debug("%s: Cannot decode clocks for '%s' (ret = %d)\n",
-		      __func__, dev->name, ret);
-		return -EINVAL;
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		log_debug("%s: Could not get DC clock: %ld\n",
+			  __func__, PTR_ERR(priv->clk));
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->clk_parent = devm_clk_get(dev, "parent");
+	if (IS_ERR(priv->clk_parent)) {
+		log_debug("%s: Could not get DC clock parent: %ld\n",
+			  __func__, PTR_ERR(priv->clk_parent));
+		return PTR_ERR(priv->clk_parent);
 	}
 
 	priv->rotation = dev_read_bool(dev, "nvidia,180-rotation");
-- 
2.43.0

