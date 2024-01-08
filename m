Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49ABC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FAD687A65;
	Mon,  8 Jan 2024 11:51:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gHI4g6JK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FA8B87A61; Mon,  8 Jan 2024 11:50:58 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C44987A30
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:50:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a27733ae1dfso174025866b.3
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 02:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704711056; x=1705315856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bQdb19p6Acs8WFsQLAx/VCCh6f0CgVeGO55jE+9/A6w=;
 b=gHI4g6JKha7KY2fVkscdXn1537jd5KhZr/PxMiJ/vKH/tbDa+Vzm7LtSfZZmgVlPZL
 2MmlyiVue9LcSKUKKDVKt5PrxwMIOY1sTZLek0LkiNGIfM6/Dvw/xG4iJZVyPiR2ZFHb
 /+JCMuksOwtddCLfQxC2IVxHAmohzgeGScRLIcIuIb4FiYebiIon60CtMi0A1CNcEyhR
 4TUnxwFFa6D+nS0NR3wK9cQjVbKQ4OjKY59h1PC1s1+FguTe+RQl6E3UADrFljfngbZu
 YA4cV+ovdJoqzVNG7Y8eE7WVOy1Tm4iBxYQTgkViP0E5onTC4AxtTI3t9gCqdigl1IcV
 HZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711056; x=1705315856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQdb19p6Acs8WFsQLAx/VCCh6f0CgVeGO55jE+9/A6w=;
 b=QD/kFGF40rK7o35av9t1QVDQ1ZiWwim0b5AfIGvq7sLuvJ/18kVkOE157lvMCIOsRD
 uTeLTblTgg6Z9mpO4EeFO/UiEjtGgeEXnEHMmtt2qApEVBVqQ+c3WAxHpm5jhqt7Lcdd
 Lrh5yILlBm1SkL9a7H5ieju1CQFesA+WZXzc77POpgYP7/3JiOacuK2Vq1yx78w8c1ZK
 AygUTioJJH8/8N6KMKSgFuWPjeSdrIGwyLaWxk4LLJPBOTLGsD8B2V0GzwPC384SjA6b
 GxHdg/QpcN7ZUD2+mrRLj8L+uuFNv6SBsvMVoQUCzCHr4h11eJQIgMqyZa2cxdKzhMVl
 nLjQ==
X-Gm-Message-State: AOJu0YwGO+AS1vC0CCBUI/3vRi2c8Nf+tLg+ApT/bWACGmoVF7/PpFgq
 kA9S9TS70NmP3sAjEYIwcNc=
X-Google-Smtp-Source: AGHT+IGEuWq2wjHKmrpCP1dqbtO0Xa7CuES9rmHcia7T6OOQ6IApTRLhJHaXN350V/A1YAnEe0e3PA==
X-Received: by 2002:a17:906:a410:b0:a27:aead:5af8 with SMTP id
 l16-20020a170906a41000b00a27aead5af8mr672087ejz.242.1704711055535; 
 Mon, 08 Jan 2024 02:50:55 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 26-20020a170906309a00b00a26ae4fb50asm3821141ejv.89.2024.01.08.02.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 02:50:55 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/9] video: tegra20: dc: pass DC id to internal devices
Date: Mon,  8 Jan 2024 12:49:56 +0200
Message-Id: <20240108105002.243149-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240108105002.243149-1-clamor95@gmail.com>
References: <20240108105002.243149-1-clamor95@gmail.com>
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
index 56733c529a..09917376cc 100644
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

