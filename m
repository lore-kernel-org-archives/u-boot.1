Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50FBC021BF
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 11:55:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E42FC81100;
	Wed, 26 Feb 2025 12:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fo9ATiZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B13980FEC; Wed, 26 Feb 2025 12:54:20 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3736980F3F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 12:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abbb12bea54so1142439866b.0
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740570858; x=1741175658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKWp0gfwm6hxtDwC3ZFP8MlzzPXZR8sxT7/Wrts8ZVM=;
 b=fo9ATiZM2QK3CCSrNQwuuMyAzqdMnw8utEYx94RIzVXIbWZpNbUWNKadKe0zCOkkmW
 pwbD12Deqdss04Em5aW//V+thLOi22Amddcd3l8Q94ueH45N+VnWO6KtBgutAOIwyYaA
 2+eAwB3otThWmhqwSDtVvGMqJeBE1nzVyWoWV5A8iBH7Zg/cHAxTvcJZbw1svpr05wmj
 jn2dlSTx3j81acRvqes0CeHBoohU1FpcfoQ6YZXFxJjlA47YMK3KpO+qicdL2LGF1mtI
 z7yveCmvAer22ybDQ9Gvttx3L0ub6FTj5UA1uazxFToUPzHErfe9wmGfciN3woyI9xwB
 MIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740570858; x=1741175658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKWp0gfwm6hxtDwC3ZFP8MlzzPXZR8sxT7/Wrts8ZVM=;
 b=gjPsCry3uR8muAYOWa0OmZ8Bd/7QHEcVTQ7Kb3zo45MoIDlJ9IumkO7aklaGkC81Gi
 MlZf69qsxqodd0jQKjJuXXqpEHNHVn1itYKaSvD+rHjMEreDlgtOpWuHGlrNIGezNnZ3
 Q3ns3AZ65XVgEzBT+INZcGg6JlGUVqrR3tU2eJ2BdnaupmuUJlh7cZCE7hEJ6XGNLuwS
 xR1Tk+aijC7qz+7JIgm4+k2e4Rcbbs3MY2NWb2cTSsIIYKqJs71Q6eBoU2Mx2BBSxYbh
 CK6bWxlTjhs5L2ryizDSNa8oFtXt+Gpc0h2AGCWTp4nEZen4omZVqzexdfw9udaqxH2m
 SbUQ==
X-Gm-Message-State: AOJu0Yymvdp3/2c0Xspv1TiUal6E52mNXK4kfx5QD6VHd+YkkaA95Frh
 tji5OtgRzMPe6YmgUGvoM177id4IBa/SQ5itTG7EauCtUBF/3Sel
X-Gm-Gg: ASbGncsqEkGDa8f6BZVzcfThr98WhHol0dOSoV6aIvKBp8X12S6JIHphFobZXTlQ2h3
 aceHro2Ja6SAPL6BRiALLbBSAjWOdCLRGi0BuFXqia4AvsIkvvKcS3pU7Hwy2r+Xa8L+NhjZpoC
 09NvNVKgmGoI8dHYzGFAtGGQKM+lu2+oD534Sm0l+rJME/w1bY8x5IivQjMGOy+V+DX5mP+lqQO
 uLP0OkJeAGIPMSK6ipf+nAC0BE1r7YaznGz0oV8XdkqUU1FRsp/XuAzwVHtTd4ikjojiAwdrquR
 ZMFQ8sBA4uUIMi0NNg==
X-Google-Smtp-Source: AGHT+IG8pTSA/1MK5r8sAVXlCDVUUm4wV5ezBl7SDEFbHdo31ZZv0qeATu3OyvM7IzfA/Hcdo2+aNw==
X-Received: by 2002:a17:906:b80f:b0:abe:fffc:93f1 with SMTP id
 a640c23a62f3a-abefffc948emr44494966b.6.1740570857522; 
 Wed, 26 Feb 2025 03:54:17 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abed2055011sm308673366b.156.2025.02.26.03.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 03:54:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 10/12] video: tegra20: dsi: calculate lanes for ganged mode
Date: Wed, 26 Feb 2025 13:53:36 +0200
Message-ID: <20250226115338.42832-11-clamor95@gmail.com>
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

Use Linux DSI driver approach to calculate lanes for ganged mode.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dsi.c | 35 +++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dsi.c b/drivers/video/tegra20/tegra-dsi.c
index 2beb9ec9f24..b132a23432c 100644
--- a/drivers/video/tegra20/tegra-dsi.c
+++ b/drivers/video/tegra20/tegra-dsi.c
@@ -617,6 +617,28 @@ static void tegra_dsi_set_phy_timing(struct udevice *dev,
 		tegra_dsi_set_phy_timing(priv->slave, period, dphy_timing);
 }
 
+static u32 tegra_dsi_get_lanes(struct udevice *dev)
+{
+	struct tegra_dsi_priv *priv = dev_get_priv(dev);
+	struct mipi_dsi_device *device = &priv->device;
+
+	if (priv->master) {
+		struct tegra_dsi_priv *mpriv = dev_get_priv(priv->master);
+		struct mipi_dsi_device *mdevice = &mpriv->device;
+
+		return mdevice->lanes + device->lanes;
+	}
+
+	if (priv->slave) {
+		struct tegra_dsi_priv *spriv = dev_get_priv(priv->slave);
+		struct mipi_dsi_device *sdevice = &spriv->device;
+
+		return device->lanes + sdevice->lanes;
+	}
+
+	return device->lanes;
+}
+
 static void tegra_dsi_ganged_enable(struct udevice *dev, unsigned int start,
 				    unsigned int size)
 {
@@ -743,7 +765,7 @@ static void tegra_dsi_configure(struct udevice *dev,
 	/* set SOL delay */
 	if (priv->master || priv->slave) {
 		unsigned long delay, bclk, bclk_ganged;
-		unsigned int lanes = device->lanes;
+		unsigned int lanes = tegra_dsi_get_lanes(dev);
 		unsigned long htotal = timing->hactive.typ + timing->hfront_porch.typ +
 				       timing->hback_porch.typ + timing->hsync_len.typ;
 
@@ -798,7 +820,7 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	struct dsi_misc_reg *misc = &priv->dsi->misc;
 	unsigned int mul, div;
 	unsigned long bclk, plld, period;
-	u32 value;
+	u32 value, lanes;
 	int ret;
 
 	/* If for some reasone DSI is enabled then it needs to
@@ -824,7 +846,8 @@ static int tegra_dsi_encoder_enable(struct udevice *dev)
 	tegra_dsi_get_muldiv(device->format, &mul, &div);
 
 	/* compute byte clock */
-	bclk = (timing->pixelclock.typ * mul) / (div * device->lanes);
+	lanes = tegra_dsi_get_lanes(dev);
+	bclk = (timing->pixelclock.typ * mul) / (div * lanes);
 
 	tegra_dsi_set_timeout(dev, bclk, 60);
 
@@ -889,7 +912,7 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 	struct tegra_dsi_priv *priv = dev_get_priv(dev);
 	struct tegra_dc_plat *dc_plat = dev_get_plat(dev);
 	struct mipi_dsi_device *device = &priv->device;
-	unsigned int mul, div;
+	unsigned int mul, div, lanes;
 	unsigned long bclk, plld;
 
 	/* Switch parents of DSI clocks in case of not standard parent */
@@ -916,8 +939,8 @@ static void tegra_dsi_init_clocks(struct udevice *dev)
 
 	tegra_dsi_get_muldiv(device->format, &mul, &div);
 
-	bclk = (priv->timing.pixelclock.typ * mul) /
-					(div * device->lanes);
+	lanes = tegra_dsi_get_lanes(dev);
+	bclk = (priv->timing.pixelclock.typ * mul) / (div * lanes);
 
 	plld = DIV_ROUND_UP(bclk * 8, USEC_PER_SEC);
 
-- 
2.43.0

