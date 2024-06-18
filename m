Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14173C27C4F
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 11:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DDE8832D;
	Tue, 18 Jun 2024 13:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YLS0pN8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91D4E8834B; Tue, 18 Jun 2024 13:57:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E021882EF
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 13:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6efae34c83so659400566b.0
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 04:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718711853; x=1719316653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HD0AiWvuMCqNKhR6RkpHDC+GZZe39nTDssAFFrcSmCw=;
 b=YLS0pN8oOuEwANUytESk9BZpwdMezVISZCIRBcWdgUw7r7ecSr+JrlR125m3wm8uPg
 3lOm1P0OS01oRHOobKlk/cw9+AlReLTgN8vGdJEcqFbIZg/bJxNPb+zN5Z++cRk10kG4
 AtfSfDubyyvJgqs1pBIrOzqmdPCy/AR7mjN5anjYtwgC9qOfFZyQB2zbTnoQ1eOb7Nwb
 oAbzjosb1vlm1ev7LgesGmNMSnXWHkGEZsWrzx0nYwyqdGDsNPi4VFMc2zBDafUQ9ZCU
 dsjjD2zYNjEBAn65jW1UZ6Wbf5tu5ACcM1xUSkEuWo8CP+aDnHjIhi5eMTSjBC5Umkzs
 /9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711853; x=1719316653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HD0AiWvuMCqNKhR6RkpHDC+GZZe39nTDssAFFrcSmCw=;
 b=c9ymFZVtHr8IXnXnsmAZIW+Ua1WQAbILJFTfuaeHPE+LDBEsFiWZbf5ar4D7tOvTd4
 WaM+hNQqNKH1g0z4/QKzQ6H/VjloBAMMB+GIq+IwNCNsv8juTREEjOCtnMMgnflxlao6
 H/F+spoeaOG0yBytZRvODvPXMCzecYeFx/+YaerpzZvIOmTBIze3hN7gHpAt7Fon2SCE
 Vk7rRLC2Z4ydewcWQwV77UjH/cmNUh9xb1cBhL+ydh4geDHh3pAwRrvrUbzwozWXLfCE
 dqYAKFmnCpjFpZABu+X4jQFm3yirV12dMldtDBVs85dHOa9FxcKWbzHeB5U/UWu+vhYI
 m4JA==
X-Gm-Message-State: AOJu0Ywuc+e5V15kZs1ytN2dZ/2OYUovY7RRCschJ7/o1oex8lW7F6/B
 W1ecyaNVbx7TmQZRPvmhZOStjtQwO/aG+1ecVuf1j2KOrpl4nCP+
X-Google-Smtp-Source: AGHT+IGLV/m5zYquBF0r0inL5H54PyOy8Qax8EF43VfXkkoAcDEkijHOxxkQwcE9abyrRGxnS5e1qA==
X-Received: by 2002:a17:907:3f03:b0:a6f:5fe2:56e9 with SMTP id
 a640c23a62f3a-a6f60d2b9a7mr1022184666b.17.1718711852491; 
 Tue, 18 Jun 2024 04:57:32 -0700 (PDT)
Received: from xeon.. ([188.163.112.69]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db6759sm611451466b.63.2024.06.18.04.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 04:57:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] video: tegra20: dc: use nvidia,
 head property to identify DC controller
Date: Tue, 18 Jun 2024 14:57:21 +0300
Message-ID: <20240618115721.41374-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618115721.41374-1-clamor95@gmail.com>
References: <20240618115721.41374-1-clamor95@gmail.com>
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

Use existing nvidia,head device tree property to get DC controller id.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 6 ++----
 drivers/video/tegra20/tegra-dc.h | 4 +---
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index d073da7d7d..accabbf4db 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -49,7 +49,7 @@ struct tegra_lcd_priv {
 	int dc_clk[2];			/* Contains clk and its parent */
 	ulong scdiv;			/* Clock divider used by disp_clk_ctrl */
 	bool rotation;			/* 180 degree panel turn */
-	bool pipe;			/* DC controller: 0 for A, 1 for B */
+	int pipe;			/* DC controller: 0 for A, 1 for B */
 };
 
 enum {
@@ -461,9 +461,7 @@ static int tegra_lcd_of_to_plat(struct udevice *dev)
 	}
 
 	priv->rotation = dev_read_bool(dev, "nvidia,180-rotation");
-
-	if (!strcmp(dev->name, TEGRA_DC_B))
-		priv->pipe = 1;
+	priv->pipe = dev_read_u32_default(dev, "nvidia,head", 0);
 
 	rgb = fdt_subnode_offset(blob, node, "rgb");
 	if (rgb < 0) {
diff --git a/drivers/video/tegra20/tegra-dc.h b/drivers/video/tegra20/tegra-dc.h
index 05042dab1c..7d0c189ec8 100644
--- a/drivers/video/tegra20/tegra-dc.h
+++ b/drivers/video/tegra20/tegra-dc.h
@@ -14,15 +14,13 @@
 /* arch-tegra/dc exists only because T124 uses it */
 #include <asm/arch-tegra/dc.h>
 
-#define TEGRA_DC_A		"dc@54200000"
-#define TEGRA_DC_B		"dc@54240000"
 #define TEGRA_DSI_A		"dsi@54300000"
 #define TEGRA_DSI_B		"dsi@54400000"
 
 struct tegra_dc_plat {
 	struct udevice *dev;		/* Display controller device */
 	struct dc_ctlr *dc;		/* Display controller regmap */
-	bool pipe;			/* DC number: 0 for A, 1 for B */
+	int pipe;			/* DC number: 0 for A, 1 for B */
 	ulong scdiv;			/* Shift clock divider */
 };
 
-- 
2.43.0

