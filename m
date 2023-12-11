Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88486C4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:22:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE469877E5;
	Tue, 12 Dec 2023 00:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fRyGMAbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69C41877A9; Tue, 12 Dec 2023 00:21:54 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B068777C
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b9dd6886e2so1978651b6e.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336892; x=1702941692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=fRyGMAbH+rj6cRzadkNyWtWzPiBnpHoykfLxZpBoV4YrVItAavKynC2LPxhuTWHvty
 jfaiunyNYvhzYEHizyu4JJvsKusH9zv6vrqlhFVY/TLZDltaa8qVDSE0tDB9jO5WVtK9
 jkQz7gSSRbB2QV3475stRlhb/k1FiyXLqnbZLbuE8r5QBo54eMGIAmZF14tKh7Aphb9m
 asruA+9QH6X0aV/IY0wwrZ9ar4AlUk2udMjIng6mGDFWIaWXfqayoj7Nn99qMLCL14oo
 NG4JQROCjqc7ti1jA01hRpyL9f6o7trdPl7dcmCW7MjW2Rnl9RR9XpH9dqlg0khQJfHp
 gvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336892; x=1702941692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=cSaG/2Bdi4KY6RNyRo2mHfSgizCx9yhe22hRmZ8ZWb5hMBWMAHxnTz18uMvMVQ9aA6
 637/UPQ051WT/Ob5bmMp7f9W+X2+ymIvvfMBMpiYlDEOsomK/vrVasLf6UzxC4NShAvq
 UBQRaU+B6p7FKjffP+xjZrgj1BjduJYuE3wd/zqEqYTA9ljydukwEUqXxVCPtU2WVtJg
 oM/SahaUzTBIcbMFKFc41OesJGPp5mMwlBvugPByhGGlKN6HCvUV6oiqPa5CfbynSBiz
 MxW/0he2p/dh8BqHYfMIxXn3uzLbGlWssXwMqebSeH+1J+hXYxbl8u/3z+rTLjHVrpHq
 dPbw==
X-Gm-Message-State: AOJu0Yycd1l3C4IfhjftwY6xYdu3K0oHDmlCNN7j1pQgd2dLpkrpp6ov
 cHFPPQIOdR5zRQRiqQKLzFn6SUBvvfc=
X-Google-Smtp-Source: AGHT+IEhQyFkunJvD8gtQbBrverpzauEDYzCIS/UkssCS0Gg/gyPM2SDrKrbp7XGRyB3nq6bPkUhQg==
X-Received: by 2002:a05:6808:1146:b0:3b8:b063:8938 with SMTP id
 u6-20020a056808114600b003b8b0638938mr3895807oiu.70.1702336892475; 
 Mon, 11 Dec 2023 15:21:32 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:32 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 1/7] board: rockchip: Refactor panel auto-detect code
Date: Mon, 11 Dec 2023 17:21:19 -0600
Message-Id: <20231211232125.171438-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211232125.171438-1-macroalpha82@gmail.com>
References: <20231211232125.171438-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Make the inability to detect a panel using the auto detection code not
fail the entire boot process. This means that if the panel ID cannot
be read we don't set an environment variable for the panel, and if an
environment variable for the panel is not set we don't attempt to
update the compatible string. Changes to the code also ensure that
when there are multiple compatible strings required for the panel
we use them both, which solves some issues that will pop up soon
for the Linux driver.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c | 115 +++++++++++++--------
 1 file changed, 74 insertions(+), 41 deletions(-)

diff --git a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
index 3f1a42d184..3d0c614623 100644
--- a/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
+++ b/board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c
@@ -40,6 +40,7 @@ struct rg3xx_model {
 	const char *board;
 	const char *board_name;
 	const char *fdtfile;
+	const bool detect_panel;
 };
 
 enum rgxx3_device_id {
@@ -54,52 +55,67 @@ enum rgxx3_device_id {
 
 static const struct rg3xx_model rg3xx_model_details[] = {
 	[RG353M] = {
-		517, /* Observed average from device */
-		"rk3566-anbernic-rg353m",
-		"RG353M",
-		DTB_DIR "rk3566-anbernic-rg353p.dtb", /* Identical devices */
+		.adc_value = 517, /* Observed average from device */
+		.board = "rk3566-anbernic-rg353m",
+		.board_name = "RG353M",
+		/* Device is identical to RG353P. */
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
+		.detect_panel = 1,
 	},
 	[RG353P] = {
-		860, /* Documented value of 860 */
-		"rk3566-anbernic-rg353p",
-		"RG353P",
-		DTB_DIR "rk3566-anbernic-rg353p.dtb",
+		.adc_value = 860, /* Documented value of 860 */
+		.board = "rk3566-anbernic-rg353p",
+		.board_name = "RG353P",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg353p.dtb",
+		.detect_panel = 1,
 	},
 	[RG353V] = {
-		695, /* Observed average from device */
-		"rk3566-anbernic-rg353v",
-		"RG353V",
-		DTB_DIR "rk3566-anbernic-rg353v.dtb",
+		.adc_value = 695, /* Observed average from device */
+		.board = "rk3566-anbernic-rg353v",
+		.board_name = "RG353V",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg353v.dtb",
+		.detect_panel = 1,
 	},
 	[RG503] = {
-		1023, /* Observed average from device */
-		"rk3566-anbernic-rg503",
-		"RG503",
-		DTB_DIR "rk3566-anbernic-rg503.dtb",
+		.adc_value = 1023, /* Observed average from device */
+		.board = "rk3566-anbernic-rg503",
+		.board_name = "RG503",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg503.dtb",
+		.detect_panel = 0,
 	},
 	/* Devices with duplicate ADC value */
 	[RG353PS] = {
-		860, /* Observed average from device */
-		"rk3566-anbernic-rg353ps",
-		"RG353PS",
-		DTB_DIR "rk3566-anbernic-rg353ps.dtb",
+		.adc_value = 860, /* Observed average from device */
+		.board = "rk3566-anbernic-rg353ps",
+		.board_name = "RG353PS",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg353ps.dtb",
+		.detect_panel = 1,
 	},
 	[RG353VS] = {
-		695, /* Gathered from second hand information */
-		"rk3566-anbernic-rg353vs",
-		"RG353VS",
-		DTB_DIR "rk3566-anbernic-rg353vs.dtb",
+		.adc_value = 695, /* Gathered from second hand information */
+		.board = "rk3566-anbernic-rg353vs",
+		.board_name = "RG353VS",
+		.fdtfile = DTB_DIR "rk3566-anbernic-rg353vs.dtb",
+		.detect_panel = 1,
 	},
 };
 
 struct rg353_panel {
 	const u16 id;
-	const char *panel_compat;
+	const char *panel_compat[2];
 };
 
 static const struct rg353_panel rg353_panel_details[] = {
-	{ .id = 0x3052, .panel_compat = "newvision,nv3051d"},
-	{ .id = 0x3821, .panel_compat = "anbernic,rg353v-panel-v2"},
+	{
+		.id = 0x3052,
+		.panel_compat[0] = "anbernic,rg353p-panel",
+		.panel_compat[1] = "newvision,nv3051d",
+	},
+	{
+		.id = 0x3821,
+		.panel_compat[0] = "anbernic,rg353v-panel-v2",
+		.panel_compat[1] = NULL,
+	},
 };
 
 /*
@@ -298,11 +314,10 @@ int rgxx3_detect_display(void)
 	if (!panel) {
 		printf("Unable to identify panel_id %x\n",
 		       (panel_id[0] << 8) | panel_id[1]);
-		env_set("panel", "unknown");
 		return -EINVAL;
 	}
 
-	env_set("panel", panel->panel_compat);
+	env_set("panel", panel->panel_compat[0]);
 
 	return 0;
 }
@@ -367,13 +382,14 @@ int rgxx3_detect_device(void)
 		rg3xx_model_details[board_id].board_name);
 	env_set("fdtfile", rg3xx_model_details[board_id].fdtfile);
 
-	/* Detect the panel type for any device that isn't a 503. */
-	if (board_id == RG503)
+	/* Skip panel detection for when it is not needed. */
+	if (!rg3xx_model_details[board_id].detect_panel)
 		return 0;
 
+	/* Warn but don't fail for errors in auto-detection of the panel. */
 	ret = rgxx3_detect_display();
 	if (ret)
-		return ret;
+		printf("Failed to detect panel type\n");
 
 	return 0;
 }
@@ -400,7 +416,8 @@ int rk_board_late_init(void)
 
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
-	int node, ret;
+	const struct rg353_panel *panel = NULL;
+	int node, ret, i;
 	char *env;
 
 	/* No fixups necessary for the RG503 */
@@ -414,6 +431,12 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 			    rg3xx_model_details[RG353M].board_name,
 			    sizeof(rg3xx_model_details[RG353M].board_name));
 
+	env = env_get("panel");
+	if (!env) {
+		printf("Can't get panel env\n");
+		return 0;
+	}
+
 	/*
 	 * Check if the environment variable doesn't equal the panel.
 	 * If it doesn't, update the devicetree to the correct panel.
@@ -424,12 +447,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 		return -ENODEV;
 	}
 
-	env = env_get("panel");
-	if (!env) {
-		printf("Can't get panel env\n");
-		return -ENODEV;
-	}
-
 	ret = fdt_node_check_compatible(blob, node, env);
 	if (ret < 0)
 		return -ENODEV;
@@ -438,8 +455,24 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	if (!ret)
 		return 0;
 
-	do_fixup_by_path_string(blob, "/dsi@fe060000/panel@0",
-				"compatible", env);
+	/* Panels don't match, search by first compatible value. */
+	for (i = 0; i < ARRAY_SIZE(rg353_panel_details); i++) {
+		if (!strcmp(env, rg353_panel_details[i].panel_compat[0])) {
+			panel = &rg353_panel_details[i];
+			break;
+		}
+	}
+
+	if (!panel) {
+		printf("Unable to identify panel by compat string\n");
+		return -ENODEV;
+	}
+
+	/* Set the compatible with the auto-detected values */
+	fdt_setprop_string(blob, node, "compatible", panel->panel_compat[0]);
+	if (panel->panel_compat[1])
+		fdt_appendprop_string(blob, node, "compatible",
+				      panel->panel_compat[1]);
 
 	return 0;
 }
-- 
2.34.1

