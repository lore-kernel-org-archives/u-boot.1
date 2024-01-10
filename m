Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF055C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 07:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FDAD807E4;
	Wed, 10 Jan 2024 08:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KECQZ9uZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5620887A98; Wed, 10 Jan 2024 08:44:09 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74F958788D
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 08:44:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a28bd9ca247so406136466b.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 23:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704872645; x=1705477445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=KECQZ9uZmU0Po6/PPNeJ9fbCndl8ii3+3MgW5oHCvJPrQBbujRn9iTIRPjFT4MO6yd
 nlUoGNMbg4WSgxQscGBjTJJHk36xbVs4YvKhLaG6ElUzD4bI9pcceKa7bbF830O+wDyu
 0VhIQLwpMb12cQO8Wid9Q8jAVrqgoDWfK8Oc9m4E7j+FuJZ2k04LPvh4XAIPd63+1lmO
 0zN3ImVOp8is6mvLqTxhTr7I/re0zchiKFirJnvOZo473WH069EEQN6f55c13D4CCi6m
 Dum1avcGdU4vs9FD8Qwtnj2BNYLWK87oOSO1B0kIJNIsUNBgTbm0SV9NElRCt694V3nk
 MQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704872645; x=1705477445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96znt4d6nDmc3curz0bN/+E4yyTus03y/d1LkCQeNXM=;
 b=tGjHJMPPfclnswgSPYBqAvzVrmoN2ps/XIjcOXce9UJHT7WACGLVUfWrIc57kpNSP6
 1qsHKSZONoht+r0TPAwEBesykYJ59ZjzsXuQnjh5hHZRkWDWcM/di2RFjdNiMtEy1NSy
 dZpuACe7/rw1B5/KDoG0MxxgqynobyPzxvhVbJa+++mqzRcK4VrUMVgHxXS6GlrIKYaZ
 pYAMd0VFfGGIsTSeo1LZRMzhxXVj9NPtTFzYHc3aSTGM+D7F5RBQPAOGl3QwU6XoHTOn
 xq4sUs0hCJlXVpulNzcDo9+abS/5QM+Zlyt3neKPnHAE5wGW0qvjaCTgugQw4TdHtArG
 zpiw==
X-Gm-Message-State: AOJu0YwsSlts5lxr9m9s0IZuI6TEBdZAekc4fQlZttZr+lEeFM/Lsugw
 QOiK1F/EnRww6HqXnHCUOC/9ItkL6n2SoG/R
X-Google-Smtp-Source: AGHT+IFtTMl6ckYu7tYnn2xDNFNkrBmtf2AeAVmgFldplFAozBrsDdMLrBwLC8ruKnfCUcwLMzLutw==
X-Received: by 2002:a17:907:7f22:b0:a28:fb5b:fd3 with SMTP id
 qf34-20020a1709077f2200b00a28fb5b0fd3mr443028ejc.31.1704872644661; 
 Tue, 09 Jan 2024 23:44:04 -0800 (PST)
Received: from xeon.. ([188.163.112.64]) by smtp.gmail.com with ESMTPSA id
 lh13-20020a170906f8cd00b00a2bd425eab2sm312282ejb.2.2024.01.09.23.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 23:44:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Anatolij Gustschin <agust@denx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v3 04/10] video: tegra20: dc: pass DC id to internal devices
Date: Wed, 10 Jan 2024 09:43:36 +0200
Message-Id: <20240110074342.38331-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110074342.38331-1-clamor95@gmail.com>
References: <20240110074342.38331-1-clamor95@gmail.com>
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

