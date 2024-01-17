Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43594C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 17:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D76A087BB7;
	Wed, 17 Jan 2024 18:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CzAGHlaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 334AB87BA7; Wed, 17 Jan 2024 18:17:28 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28218879F3
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 18:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55969c01168so4964158a12.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705511844; x=1706116644; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=CzAGHlaTVa2dJb/rioWnGqLQ8IxT6CPvmyqN+GZHomTtDm8wekZV1h5iQcXk00RoJX
 ebl6jGm25qToh+a0VJkbXni2pbq7HgKrKLowy3nQqrZZqSDc2KoST49A3vKV/JL57pi7
 vQxr7Ej42t/3yUvWJVylqMAiV4z2d9l0h4Wu1lq6E6v+yqiCrlRln3rGjGdXsd0+upDa
 LyYJXB/qY67LOsIv/yKgZigc+RDUYOAG6ouAPOWF3jS8JG5ohMN+DK2gmm5+hsUDcPaS
 +ypFhyBJPV/0vZsUqz6V0sdGde1zuqAwIAkv3t+vyfsoP2UUBygjdATBxVlhEfep69XQ
 2Tiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705511844; x=1706116644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=dD7Xrf92/3vAJjJayDMCDLmPirqK0ynwgETfdLDLfQGI02ecYDJ75mZYHyTdUNYzHg
 MC1ODwxKBbuTsGtD54ZgMj2PqcCnu5zdgja3G5qRT4EQL04ZVN+LZFzf+sV0oFDYmFtp
 hsmlhEeWuHgW6R0+9xGMSVbLG6N9IEHOloBYQw0iiFIR4640jht3BoALikNy/VKTrukF
 v7fQUhnWxyRJ3s0dHVLzHEVVAHIjYx9AuqG6112ESUCazb7IzZdUqTvTpceYRUKEXDuB
 31hwbsqoqZikduB5xWV//XX917T4OLCrro6Vnu4Ufd5QqPOuAro9iX4VgXT9xllogLgv
 H28A==
X-Gm-Message-State: AOJu0Ywd7qYo5ugu5OP0tJFuCD0uqw3x9+ZH1sWaCiCsw4/jkn/cqboJ
 Jfo4z4hD24JCylxl+1InKUz8Qpyf7saTMVYriHcCgRKc7LXiAdeeE4VISCGWEtoRoA==
X-Google-Smtp-Source: AGHT+IHERluGYy20M3kG20DzYQ2RSrD4ZJunzRk7Cvipt/d+v/G6klm3LU/9lKHV10KExKQwWydFjA==
X-Received: by 2002:a17:906:b845:b0:a2e:c034:36eb with SMTP id
 ga5-20020a170906b84500b00a2ec03436ebmr1054211ejb.37.1705511844561; 
 Wed, 17 Jan 2024 09:17:24 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 vs5-20020a170907a58500b00a2cbbebedc1sm6904976ejc.53.2024.01.17.09.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 09:17:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 04/13] video: tegra20: dc: pass DC id to internal devices
Date: Wed, 17 Jan 2024 19:16:49 +0200
Message-Id: <20240117171658.22324-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240117171658.22324-1-clamor95@gmail.com>
References: <20240117171658.22324-1-clamor95@gmail.com>
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

