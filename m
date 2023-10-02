Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED962E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0C2F871C0;
	Mon,  2 Oct 2023 03:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O+deLEml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E3FD870CE; Mon,  2 Oct 2023 03:15:19 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8BA87109
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79f95439795so56193639f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209262; x=1696814062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v85UFG07LnMwtCjHy0UWX+811G6tsaNP2R4pmh6WWm4=;
 b=O+deLEmlVxqF6M2/ONo/aYYJu0RqurqAHxowiX+SISn/L6tBsNzn/WLMiQQ6+waoU0
 GUODa1LsYBY/rgPwXFMkzesFt0BieM/SNw4f70xUfX0Yv7b65UU8m9odob9odidH6yHY
 6P2We5I7yCvySV0ccB1aiLAmD5ne3xjUBYQUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209262; x=1696814062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v85UFG07LnMwtCjHy0UWX+811G6tsaNP2R4pmh6WWm4=;
 b=SeLZV5xIhikoqxeBOn0H87tJVmr9f4W+pFk10mPEhFGiRGn6u7m7Akq9F+bLDMGBTH
 6KVkSLNrbM6lEeApHgRR/HGt9KdwnLRN78EwbsZ8tT5MfD4aKjSccMu5S5wPZiw86lTX
 9vu3Av8DHJk3slK+FOeukFI0g03x0ftVFRJFVRGaLygRYOUfNoOZHXLrhDDdDT3o6KIG
 hJcstLQZdAVR07cMJEhp06LRatiptHfMxezfzDJjA/1HRA79CuhmkxDVuqmOn8l1LH5i
 O7t3u6Fjx0sEWySFimgN1iyPdf7+hGNKtsXyE6NZh0T6xcYymMti9MgZ42/wjxiQxivd
 1s0g==
X-Gm-Message-State: AOJu0YwEK6gbkE/oO42mu+B3lki0ypCFVm6L7E1FqDUyXx0znSubpDYQ
 4XutQxeXnTqJiIgwv+arlx3VxN18PV0jftdG9XA=
X-Google-Smtp-Source: AGHT+IGqye3yHyPcrK4OcMtUEUtY3IXMoeWBZ2/Ku8xeTjIRR8oSTLdsrN1oNzXNPgmtWgqUagR32w==
X-Received: by 2002:a05:6e02:1aa3:b0:34a:95f9:650c with SMTP id
 l3-20020a056e021aa300b0034a95f9650cmr8910374ilv.10.1696209262417; 
 Sun, 01 Oct 2023 18:14:22 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 35/36] expo: Update tests to include textline
Date: Sun,  1 Oct 2023 19:13:39 -0600
Message-ID: <20231002011349.461284-36-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Provide test coverage for the new expo object type, including building
and reading/writing settings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/cedit.dtsi     |  8 ++++++++
 include/test/cedit-test.h       |  5 ++++-
 test/boot/cedit.c               | 30 +++++++++++++++++++++++++++---
 test/boot/expo.c                |  2 +-
 test/boot/files/expo_ids.h      |  3 +++
 test/boot/files/expo_layout.dts |  8 ++++++++
 6 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/dts/cedit.dtsi b/arch/sandbox/dts/cedit.dtsi
index a9eb4c2d594a..9bd84e629367 100644
--- a/arch/sandbox/dts/cedit.dtsi
+++ b/arch/sandbox/dts/cedit.dtsi
@@ -51,6 +51,14 @@
 
 				item-id = <ID_AC_OFF ID_AC_ON ID_AC_MEMORY>;
 			};
+
+			machine-name {
+				id = <ID_MACHINE_NAME>;
+				type = "textline";
+				max-chars = <20>;
+				title = "Machine name";
+				edit-id = <ID_MACHINE_NAME_EDIT>;
+			};
 		};
 	};
 
diff --git a/include/test/cedit-test.h b/include/test/cedit-test.h
index 349df75b16d4..475ecc9c2dc2 100644
--- a/include/test/cedit-test.h
+++ b/include/test/cedit-test.h
@@ -24,6 +24,9 @@
 #define ID_AC_ON		11
 #define ID_AC_MEMORY		12
 
-#define ID_DYNAMIC_START	13
+#define ID_MACHINE_NAME		13
+#define ID_MACHINE_NAME_EDIT	14
+
+#define ID_DYNAMIC_START	15
 
 #endif
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index ab2b8a1f9ffa..aa4171904864 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -58,6 +58,7 @@ BOOTSTD_TEST(cedit_base, 0);
 /* Check the cedit write_fdt and read_fdt commands */
 static int cedit_fdt(struct unit_test_state *uts)
 {
+	struct scene_obj_textline *tline;
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
 	struct scene_obj_menu *menu;
@@ -66,6 +67,7 @@ static int cedit_fdt(struct unit_test_state *uts)
 	struct scene *scn;
 	oftree tree;
 	ofnode node;
+	char *str;
 	void *fdt;
 	int i;
 
@@ -79,6 +81,12 @@ static int cedit_fdt(struct unit_test_state *uts)
 	ut_assertnonnull(menu);
 	menu->cur_item_id = ID_CPU_SPEED_2;
 
+	/* get a textline to fiddle with too */
+	tline = scene_obj_find(scn, ID_MACHINE_NAME, SCENEOBJT_TEXTLINE);
+	ut_assertnonnull(tline);
+	str = abuf_data(&tline->buf);
+	strcpy(str, "my-machine");
+
 	ut_assertok(run_command("cedit write_fdt hostfs - settings.dtb", 0));
 	ut_assertok(run_commandf("load hostfs - %lx settings.dtb", addr));
 	ut_assert_nextlinen("1024 bytes read");
@@ -86,26 +94,29 @@ static int cedit_fdt(struct unit_test_state *uts)
 	fdt = map_sysmem(addr, 1024);
 	tree = oftree_from_fdt(fdt);
 	node = ofnode_find_subnode(oftree_root(tree), CEDIT_NODE_NAME);
+	ut_assert(ofnode_valid(node));
 
 	ut_asserteq(ID_CPU_SPEED_2,
 		    ofnode_read_u32_default(node, "cpu-speed", 0));
 	ut_asserteq_str("2.5 GHz", ofnode_read_string(node, "cpu-speed-str"));
-	ut_assert(ofnode_valid(node));
+	ut_asserteq_str("my-machine", ofnode_read_string(node, "machine-name"));
 
-	/* There should only be 4 properties */
+	/* There should only be 5 properties */
 	for (i = 0, ofnode_first_property(node, &prop); ofprop_valid(&prop);
 	     i++, ofnode_next_property(&prop))
 		;
-	ut_asserteq(4, i);
+	ut_asserteq(5, i);
 
 	ut_assert_console_end();
 
 	/* reset the expo */
 	menu->cur_item_id = ID_CPU_SPEED_1;
+	*str = '\0';
 
 	/* load in the settings and make sure they update */
 	ut_assertok(run_command("cedit read_fdt hostfs - settings.dtb", 0));
 	ut_asserteq(ID_CPU_SPEED_2, menu->cur_item_id);
+	ut_asserteq_str("my-machine", ofnode_read_string(node, "machine-name"));
 
 	ut_assertnonnull(menu);
 	ut_assert_console_end();
@@ -117,10 +128,12 @@ BOOTSTD_TEST(cedit_fdt, 0);
 /* Check the cedit write_env and read_env commands */
 static int cedit_env(struct unit_test_state *uts)
 {
+	struct scene_obj_textline *tline;
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
 	struct scene_obj_menu *menu;
 	struct scene *scn;
+	char *str;
 
 	console_record_reset_enable();
 	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
@@ -132,25 +145,36 @@ static int cedit_env(struct unit_test_state *uts)
 	ut_assertnonnull(menu);
 	menu->cur_item_id = ID_CPU_SPEED_2;
 
+	/* get a textline to fiddle with too */
+	tline = scene_obj_find(scn, ID_MACHINE_NAME, SCENEOBJT_TEXTLINE);
+	ut_assertnonnull(tline);
+	str = abuf_data(&tline->buf);
+	strcpy(str, "my-machine");
+
 	ut_assertok(run_command("cedit write_env -v", 0));
 	ut_assert_nextlinen("c.cpu-speed=7");
 	ut_assert_nextlinen("c.cpu-speed-str=2.5 GHz");
 	ut_assert_nextlinen("c.power-loss=10");
 	ut_assert_nextlinen("c.power-loss-str=Always Off");
+	ut_assert_nextlinen("c.machine-name=my-machine");
 	ut_assert_console_end();
 
 	ut_asserteq(7, env_get_ulong("c.cpu-speed", 10, 0));
 	ut_asserteq_str("2.5 GHz", env_get("c.cpu-speed-str"));
+	ut_asserteq_str("my-machine", env_get("c.machine-name"));
 
 	/* reset the expo */
 	menu->cur_item_id = ID_CPU_SPEED_1;
+	*str = '\0';
 
 	ut_assertok(run_command("cedit read_env -v", 0));
 	ut_assert_nextlinen("c.cpu-speed=7");
 	ut_assert_nextlinen("c.power-loss=10");
+	ut_assert_nextlinen("c.machine-name=my-machine");
 	ut_assert_console_end();
 
 	ut_asserteq(ID_CPU_SPEED_2, menu->cur_item_id);
+	ut_asserteq_str("my-machine", env_get("c.machine-name"));
 
 	return 0;
 }
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 90027409c817..714fdfa415d1 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -654,7 +654,7 @@ static int expo_test_build(struct unit_test_state *uts)
 
 	ut_asserteq_str("name", exp->name);
 	ut_asserteq(0, exp->scene_id);
-	ut_asserteq(ID_DYNAMIC_START + 20, exp->next_id);
+	ut_asserteq(ID_DYNAMIC_START + 24, exp->next_id);
 	ut_asserteq(false, exp->popup);
 
 	/* check the scene */
diff --git a/test/boot/files/expo_ids.h b/test/boot/files/expo_ids.h
index 027d44bf38c5..a86e0d06f6b5 100644
--- a/test/boot/files/expo_ids.h
+++ b/test/boot/files/expo_ids.h
@@ -21,5 +21,8 @@ enum {
 	ID_AC_ON,
 	ID_AC_MEMORY,
 
+	ID_MACHINE_NAME,
+	ID_MACHINE_NAME_EDIT,
+
 	ID_DYNAMIC_START,
 };
diff --git a/test/boot/files/expo_layout.dts b/test/boot/files/expo_layout.dts
index cb2a674d9d56..bed552288f4c 100644
--- a/test/boot/files/expo_layout.dts
+++ b/test/boot/files/expo_layout.dts
@@ -55,6 +55,14 @@
 				start-bit = <0x422>;
 				bit-length = <2>;
 			};
+
+			machine-name {
+				id = <ID_MACHINE_NAME>;
+				type = "textline";
+				max-chars = <20>;
+				title = "Machine name";
+				edit-id = <ID_MACHINE_NAME_EDIT>;
+			};
 		};
 	};
 
-- 
2.42.0.582.g8ccd20d70d-goog

