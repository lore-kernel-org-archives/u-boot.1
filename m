Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46424CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 18:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3760586F12;
	Tue, 17 Oct 2023 20:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNTWW2qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD90D86F21; Tue, 17 Oct 2023 20:24:25 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA4B86CB1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2e22a4004so352166b6e.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 11:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697567061; x=1698171861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=eNTWW2qe/CUBApFynmyomS6823tmZ3zObdn5yhcPlXbYrbwrGTfM7fkYyvC43O1XAy
 F6vWHkVKXCD/nAaoQ4whFN4hGiI8KhOKT/FEMdWf76qhxOgLIG4ikKQWVL4NWirsps/X
 3DSERM/czqpNI6yO8G4vkXPPcHd4dx0hWHsar59OW8xR3Y6T0lMqoqfnQyCfazG8uFQX
 5R7bprK+ngthrWXr4ofJxmYHNBlP1NoVWzkJ19OtyjWjwgFQKXYeYc0Nup6+TgGKA/5u
 WHMgdFxjsVq0GVzeYon3tjHQeHGVgk4Fbd9PiySbeD8sBv+KUB3LDXjcSnf8JkjPPaWb
 mXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697567061; x=1698171861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=gfP3eFX7RPUbMp9H+ck8xAdLBEQwndKi+EVnvaSgtHw/kf7347Y+xTc59XPyo9llAl
 omuazWb4lFJ5vsQdyslCvd67YpF5TCUXmyX9LP4KY+XsLDg5YuyrZDpF1FJCbL3PynKI
 hF2XfKnTJ07pgtonbvg5F73Fwefls53fZ+pff6nNDB0tFshNZ88oh8ZbdP6qw/ZBMRtJ
 fkE5c1zZGqAN0gh8pgIY20i9XEgNXMDGKiEIg4LqkhSP9q49rA2O/0EMf9/pdbQLRmhV
 n8QH8znuLH5jmxc2n3H7XN73La68RmTDxK0c/x4G+eeQUj+WUmmw4CXKl1iTmqKuP3vG
 kfFg==
X-Gm-Message-State: AOJu0YxuwkgavAedonX+Ve+FBrbDVjt/LdCkc7A2fg2wFeMGYH8Z+tSj
 LCyq8u6mS3iV83MojuX4X1QAQGczY+M=
X-Google-Smtp-Source: AGHT+IHZG7sYAFBLUH8cQwqoAgXnoM1tEXTTFhgbPhpMrVLZprhT/uQWvRqDwyKi0hgggUeXIgJXdw==
X-Received: by 2002:a05:6808:1a22:b0:3ab:84f0:b49d with SMTP id
 bk34-20020a0568081a2200b003ab84f0b49dmr3801155oib.3.1697567061159; 
 Tue, 17 Oct 2023 11:24:21 -0700 (PDT)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 6-20020aca0b06000000b003a3860b375esm340312oil.34.2023.10.17.11.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 11:24:20 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3] board: rockchip: Refactor panel auto-detect code
Date: Tue, 17 Oct 2023 13:24:12 -0500
Message-Id: <20231017182414.321411-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017182414.321411-1-macroalpha82@gmail.com>
References: <20231017182414.321411-1-macroalpha82@gmail.com>
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

