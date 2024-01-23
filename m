Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7335BC47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 17:17:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FD487DEC;
	Tue, 23 Jan 2024 18:17:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ix5jOgwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA05387DA1; Tue, 23 Jan 2024 18:17:12 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93CD887D63
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 18:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so473522266b.1
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 09:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706030227; x=1706635027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=ix5jOgwns2V6yFYQQxRLH+8v6css78hMWdSf3Fnj/ygwxMlpDlQekqJupkW96FQwhL
 DwEg1Yn96zJq9qwZrEmVgKBS5ZmAovQ0IQdRk2pYMneAqGHMpwAZ6/DmSzTnHxitPTj5
 mZw+wgr72z5f2utQwuiIRuO6RRzh3QKEHDidnNxkKWVnOFf/8ctVV5zreYqZgvmgU55o
 8nBxvYK/yz2TSQ85gTskz80OJCToLWXwngDlBhxCmDnExEwWg1WhtZ/eWTQ9+lTmDbCj
 TkmnofMQh8OZIT/KqcMkBT4q3xFZSC26MbHU4BLe89B3W1xouzjiRzjSdKRZeoKs9e+c
 nT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706030227; x=1706635027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=Epif4TjWxZIQ9guTEWPYd5Ek5F1XAwRY7zwzsIOjPzCLns7Xgn7HxeumsbIIgSau2r
 93GvniISbdsnMtvdXqId0moZ18BmrI/1ZpP5fuQlhOx+D1tDDATL8hkbOvs3XmAFEsZ1
 JemPPRnsLTXfK8eRV8d99z1J/XqNjx/BYdwGIdJIcMYlHGNJMFmgY1MzTVa3XRAK40mI
 rJx5D5T6O6g86OVY9Ogo1kWzZH4Od3rlxanJzH3fBV+xU4UO8TS7NM+cHA85pK74SAH1
 kw/zLRCexOCHfuJdiCpBOVr7/VU48srk2L84QNU+QifNsFPic6U4otLOWjvpNwazVefD
 LqwA==
X-Gm-Message-State: AOJu0Yy6KuoI90zGAp5h9mKvEw60ewbXOMNxbg8oEOAe7lig31TZXufb
 OZwy+5e3IoZp88Fq5s0w5wby2UNSZz6cfWvu8JMbbyeSyt34mdtE
X-Google-Smtp-Source: AGHT+IEKicT0Ytq5sHpMx+iXEcI+9L+AGmWTgtKPvRhqyJEBExlEbR4nerA96VuEodNTMeIPKYl/vQ==
X-Received: by 2002:a17:906:3bd5:b0:a30:6987:6375 with SMTP id
 v21-20020a1709063bd500b00a3069876375mr39262ejf.141.1706030227099; 
 Tue, 23 Jan 2024 09:17:07 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 m27-20020a1709060d9b00b00a2c7d34157asm14269068eji.180.2024.01.23.09.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 09:17:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v6 04/18] video: tegra20: dc: pass DC id to internal devices
Date: Tue, 23 Jan 2024 19:16:19 +0200
Message-Id: <20240123171633.246057-5-clamor95@gmail.com>
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

