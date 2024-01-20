Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71546C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 16:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56E9A87EFB;
	Sat, 20 Jan 2024 17:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xy7hY4SG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F6C287E4F; Sat, 20 Jan 2024 17:56:21 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22E7887E74
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 17:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2cea0563cbso271065866b.3
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 08:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705769777; x=1706374577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=Xy7hY4SGREB5x4jrsbTXNH7BacO4bYokMdnSdLJYEDxbMmJN1SHA64yWDByeIPzIBf
 IeZh1gKIQsWI3e1zWVbjKjiPulIunTpBJQwNJM1t7MW1iRfgJVwWOHYZ9STa7WT+BbZi
 w1+xl07FNUnxhbPTjMn+MTKn8OuHSDTTQPmp8Ie/uJmR4DVLUN6ZQYt6IZpHSthWpkm3
 ERiDOTbD35XglIDCcdS1XeFuiqcakfKQD5YAyK425nkU2ilSqq+Z99HqoSwwzUnsRVAh
 9MvaOGxs4mix7o2prXfPe4eufFqlWNkpLNOZQuCY6GYyQnAR+0grQA/Jqm+evjNEV3Y5
 rt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705769777; x=1706374577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=h+a2Y4rSRIbEwDQhQrkfCzqW9c8B+uxzgma+UeKtOZnRi2GSZMw1xRg51HlcsPj4ke
 X7sqIqVh+KSILeP6+HI18HP5EKTrXvLRaaxOzt6NV+C+hwlw0D7lzGO+ALO21LEgQWKC
 550f0vMvByZRed0G/9Ji4Ub2SOYto3JfJAxYZdsM5dCuh0O9p8b96dDtSgeAG/HY/Qby
 /rMckOdfZYYaf6acFBlPLPaLeDCVqO1fqEsL30KtWPh8qFHe6P3RPH9jhcHUQlpRgGVZ
 n6QrHt/AQDpkWODBefXJDsc0Ko6zfP7DTasHZBD8z9QpydYP5HM8c5WUf9A1JIaO8HRE
 F5Xw==
X-Gm-Message-State: AOJu0YzbV65p6S2vOU+7PuivbjfNeuoPzhZMLoMhNuGUOzqr+PpbIoFE
 CsABsHF8Fe8qQJzqsA5rSCGUi8sk76kGsmybpadFN7KKf/FHWlVA
X-Google-Smtp-Source: AGHT+IElXBqSl25VvK5KJEEKtq3ZpKJj4y2kWqYhNLDVeZtiQltl4QKQ7jsCBqs4JGgF3jNi1MbUow==
X-Received: by 2002:a17:906:36cd:b0:a28:dac4:b68e with SMTP id
 b13-20020a17090636cd00b00a28dac4b68emr733444ejc.43.1705769777581; 
 Sat, 20 Jan 2024 08:56:17 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 ca13-20020a170906a3cd00b00a2c869be22dsm11311548ejb.143.2024.01.20.08.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 08:56:17 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v5 04/13] video: tegra20: dc: pass DC id to internal devices
Date: Sat, 20 Jan 2024 18:55:34 +0200
Message-Id: <20240120165543.10226-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240120165543.10226-1-clamor95@gmail.com>
References: <20240120165543.10226-1-clamor95@gmail.com>
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

Tegra SoC has 2 independent display controllers called DC_A and
DC_B, they are handled differently by internal video devices like
DSI and HDMI controllers so it is important for last to know
which display controller is used to properly set up registers.
To achieve this, a pipe field was added to pdata to pass display
controller id to internal Tegra SoC devices.

Tested-by: Agneli <poczt@protonmail.ch> # Toshiba AC100 T20
Tested-by: Robert Eckelmann <longnoserob@gmail.com> # ASUS TF101
Tested-by: Andreas Westman Dorcsak <hedmoo@yahoo.com> # ASUS Grouper E1565
Tested-by: Ion Agorria <ion@agorria.com> # HTC One X
Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # Nvidia Tegratab T114
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 6 ++++++
 drivers/video/tegra20/tegra-dc.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 5d8874f323..0e94e665ef 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -45,6 +45,7 @@ struct tegra_lcd_priv {
 	unsigned pixel_clock;		/* Pixel clock in Hz */
 	int dc_clk[2];			/* Contains clk and its parent */
 	bool rotation;			/* 180 degree panel turn */
+	bool pipe;			/* DC controller: 0 for A, 1 for B */
 };
 
 enum {
@@ -406,6 +407,9 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 
 	priv->rotation = dev_read_bool(dev, "nvidia,180-rotation");
 
+	if (!strcmp(dev->name, TEGRA_DC_B))
+		priv->pipe = 1;
+
 	rgb = fdt_subnode_offset(blob, node, "rgb");
 	if (rgb < 0) {
 		debug("%s: Cannot find rgb subnode for '%s' (ret=%d)\n",
@@ -431,12 +435,14 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 		return ret;
 	}
 
+	/* Fill the platform data for internal devices */
 	if (!strcmp(priv->panel->name, TEGRA_DSI_A) ||
 	    !strcmp(priv->panel->name, TEGRA_DSI_B)) {
 		struct tegra_dc_plat *dc_plat = dev_get_plat(priv->panel);
 
 		dc_plat->dev = dev;
 		dc_plat->dc = priv->dc;
+		dc_plat->pipe = priv->pipe;
 	}
 
 	ret = panel_get_display_timing(priv->panel, &priv->timing);
diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra20/tegra-dc.h
index 5c05221038..75fc0fa4de 100644
--- a/drivers/video/tegra20/tegra-dc.h
+++ b/drivers/video/tegra20/tegra-dc.h
@@ -14,12 +14,15 @@
 /* arch-tegra/dc exists only because T124 uses it */
 #include <asm/arch-tegra/dc.h>
 
+#define TEGRA_DC_A		"dc@54200000"
+#define TEGRA_DC_B		"dc@54240000"
 #define TEGRA_DSI_A		"dsi@54300000"
 #define TEGRA_DSI_B		"dsi@54400000"
 
 struct tegra_dc_plat {
 	struct udevice *dev;		/* Display controller device */
 	struct dc_ctlr *dc;		/* Display controller regmap */
+	bool pipe;			/* DC number: 0 for A, 1 for B */
 };
 
 /* This holds information about a window which can be displayed */
-- 
2.40.1

