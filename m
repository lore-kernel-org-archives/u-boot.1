Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E41C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 21:15:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD52E86EE2;
	Fri, 17 Nov 2023 22:15:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ff3A0C6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B17AC87457; Fri, 17 Nov 2023 22:15:15 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78C4786E42
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 22:15:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1f4e17c1edfso1277514fac.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 13:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700255712; x=1700860512; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=Ff3A0C6spBPbifNc2tAmDw/7UvHw1b8lTDP3cmgscR7zjH8qc3kPc5MNfQANYOswA4
 NAjTHmHDT4lNEQZcngEd0jwTOK31EoItjQmG03JPAJrgD/uOGkWh64imU9TF5DltqxQP
 8MUDfSHSLm9mvV1qE2RxDeeLk9j93oHPdEdLyJQuzU10P2a51YTgGxPHBGc0fouhfKLk
 kOr8wmKBTWcZ7jDeUPw/A2V/5duzalcX9WBljYvBAbflE00pAwIO/e6uxoqBvaPHCLf8
 oHhr7u7LJ2AIpY8ixVh10QNbhO5ri8R0cZTlQ8w5aiqyadj5h3ZUti6IbMU/NdQb+1lX
 ATBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700255712; x=1700860512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w/gYMJ6pegZY2reuOvRvPqOctDiX5Us81kSa+j+kj7U=;
 b=CDbKo5jFhueSpN1xie1HUwprn3MfnIABi0CgSbSBb/0MdTs/zIumD5DsTnoWWecnMh
 w4baUVy7x4onKAq1TFMPDIKKuBj2yduUyiju+CUgw9n8piicGCGHobUUwwjPClF8CSho
 hYCE3v40HWt6zBEJ5K2GGdpcoULBaV89tkvK6i8ZHhcsLykfTVDPYFD86URH2Qs6b9KN
 MbT8PSZG/4M+wzKe8D7B5Vblv9MYvRgXr1yCq+x+lXiiIDnsG04Wbbl/JFZIpQ/e4E/I
 j13gTT5qYEmAWYqEd1n0YvRhQurMB0BIxPA10vFRGvLbgflKpWzJ4ptSyZkZa2Xa8kBC
 NUXA==
X-Gm-Message-State: AOJu0YxEnpzqIr8n67MkBf4/chgid6Sg38NtqONQx2UDHEB5nDYSM9od
 pQOtVP3Ss0FmQSLZcxhUpvIsk6ZkxFk=
X-Google-Smtp-Source: AGHT+IHM+v5PN11/A3q3i4dpdnLKcAT8VCZmghIuo2VBOAyp6PKilScx7bAnlnl4jHH2vAW5bJslyA==
X-Received: by 2002:a05:6870:9e90:b0:1e9:cb7f:2287 with SMTP id
 pu16-20020a0568709e9000b001e9cb7f2287mr495694oab.46.1700255711904; 
 Fri, 17 Nov 2023 13:15:11 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 zl3-20020a0568716d8300b001d6e9bb67d2sm415378oab.7.2023.11.17.13.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 13:15:11 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V2 1/4] board: rockchip: Refactor panel auto-detect code
Date: Fri, 17 Nov 2023 15:15:03 -0600
Message-Id: <20231117211506.1396929-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117211506.1396929-1-macroalpha82@gmail.com>
References: <20231117211506.1396929-1-macroalpha82@gmail.com>
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

