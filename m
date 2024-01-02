Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1750BC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 15:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 206F6878F9;
	Tue,  2 Jan 2024 16:47:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UQEZamaR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7BF878EB; Tue,  2 Jan 2024 16:47:06 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1310878EB
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 16:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5955764ea9bso175259eaf.1
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 07:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704210422; x=1704815222; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=UQEZamaRVQIHoY0WDJzFv/FQGOtlZqjFGX9PAGB4JRPCpo+RxMrFLoajBf45JQDxsx
 4zd4Y/OSV4GsITJ+KY2Ef2MgVUHWG7OcVjsWtvBk99t2gFSVjmWzqYAR/27iK3cRBVKG
 xc8EWZRK/fw494ylrT020BRDOEL8sskk5S8Kb5FAk/73M56Cw1B2WRTbJlYf2KmHFLpO
 vxVFIBb8ecIPTh2UwxfXTODCnbJ7+/iXn4onPg51e4qAMD/S7f4LfzJizB+epZjBSmIL
 +X36jCaVIT5nDkpfdAoTosIcMmGROlyc11ew7cnfLNye7dHe8P+x2DEil7PPvDmgya6h
 f8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704210422; x=1704815222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=OFhsF48Wz54H/jKAqyxTg8YcYd1NClKLsfMwdOB+eAkfDDjMjndkbDXVJu+V9D2LgL
 CHDSHPRVi7o/X6bue3Ht0JDrSISXAv7EOjERZuFuhr/O49IISVM5f8Wui/FATPcHOoSy
 qLa72xDYVQmTM7+HcB9VaihoxJ6he+XVRwsiUsmOxNSuPK1Pls/heLHJ2EOdMz3NDnng
 lh0ZHSNe4qp/Yxj8hzNdh1b+KZCG9HjctIewiFwOCHd4szyGTEU8n2QN6Db+bdzIV4sq
 tYwyN4YSpr8dP3qriHGIwGpxzGlCUfonGb9XApD/E1ZUze/cGgc5PRNg0ZbQMg3C44dH
 vAFg==
X-Gm-Message-State: AOJu0YxG4yYUXGfUuuFbnBuUF0QGMiVUE9GFw/EyqaHiMU7L8ZDSES/J
 e5c+HFX2gPmMExYNwdvZcNEFRJ/N3q+uKg==
X-Google-Smtp-Source: AGHT+IETVtgJi9gzl5o1qypWPsEbiDxW62v6SrpWaRXUgdhExmuA9p2rKHEt7wGz/8rb80kn8T2L6A==
X-Received: by 2002:a4a:988e:0:b0:595:c337:6f with SMTP id
 a14-20020a4a988e000000b00595c337006fmr645024ooj.12.1704210422105; 
 Tue, 02 Jan 2024 07:47:02 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 127-20020a4a0d85000000b005958af24e84sm843197oob.42.2024.01.02.07.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 07:47:01 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, jagan@edgeble.ai,
 jonas@kwiboo.se, Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 1/7] board: rockchip: Refactor panel auto-detect code
Date: Tue,  2 Jan 2024 09:46:48 -0600
Message-Id: <20240102154654.191055-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102154654.191055-1-macroalpha82@gmail.com>
References: <20240102154654.191055-1-macroalpha82@gmail.com>
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

