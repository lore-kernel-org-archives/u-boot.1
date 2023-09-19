Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A0DCE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:15:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47AFE86BC3;
	Tue, 19 Sep 2023 20:10:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MUjtVXKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9D886C5A; Tue, 19 Sep 2023 20:09:58 +0200 (CEST)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558FC86BE1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-34df008b0cbso20888575ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146995; x=1695751795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7vqtCsTOjEKbUei3mdlbVxeNmrU/tCxYbd/sT2rPEg=;
 b=MUjtVXKV5BuWaM1kIuVPa1yiofomkPH1JFbF1F1os2vwPPiDfC9D2aLgOp8PTfN3QM
 sfnjLz8jUuSn7Q4EAEk/xgx53AJbR+EHThQnrqe4LNAq8yRAQKLzQhkTQlcHwCXtARpc
 GJtxRc0D/DdMTeQARWMjpf9N8ycmqcG8dm6L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146995; x=1695751795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7vqtCsTOjEKbUei3mdlbVxeNmrU/tCxYbd/sT2rPEg=;
 b=UhYY3Ez/Bbu3YAbfupnven9xQyCPDZ4Q+KjcTL4dgBu2iH5+N/LDIwwTNQb/oF8eeA
 MCBhNsIxb+sxuq4eqCICd0cezC2aWIjByHy7lscCLII+UiQdE73gO+oXAILDHJ+BwMxx
 dXmwMjnir0G0Z6oFa9cC28De9bcjeIDpE/IuyKlLpZfsMRYwM6yZYYGwDv6/iGLBi/y4
 McRdmyb670vwtJMvtyIOgnWHeQ7OKoLmr70qJxolHxOZxHKF+9yh+/PKVh+2p5YxDsrQ
 SmVaxZ6FG96CdE0ncrhc3jo+Nmo+TQp49udCfeP53WrS2VByAzm6B2CKLll2dvgbPMYv
 bZ6Q==
X-Gm-Message-State: AOJu0YzAMkGs31WCmvDY4vI43E5Q0f1FXePXv86p+VZBUv4O/0bKqmtc
 6qSg5YMlw1aYgzsDa4pC/hIKfmCF9+68NdBkCQ4=
X-Google-Smtp-Source: AGHT+IGpNVtOYK+jfNohlQX/Rs4uRV8SL9eZMtxT77LRyXqmdX6jHGYXtgkkbVOjv8ibOWiFJRA11g==
X-Received: by 2002:a05:6e02:b26:b0:350:f51b:c333 with SMTP id
 e6-20020a056e020b2600b00350f51bc333mr779577ilu.2.1695146994983; 
 Tue, 19 Sep 2023 11:09:54 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 35/36] expo: Update tests to include textline
Date: Tue, 19 Sep 2023 12:09:05 -0600
Message-ID: <20230919180918.2904313-36-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 arch/sandbox/dts/cedit.dtsi     |  8 ++++++++
 include/test/cedit-test.h       |  5 ++++-
 test/boot/cedit.c               | 30 +++++++++++++++++++++++++++---
 test/boot/expo.c                |  2 +-
 test/boot/files/expo_ids.h      |  3 +++
 test/boot/files/expo_layout.dts |  8 ++++++++
 6 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/arch/sandbox/dts/cedit.dtsi b/arch/sandbox/dts/cedit.dtsi
index a9eb4c2d594..9bd84e62936 100644
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
index 349df75b16d..475ecc9c2dc 100644
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
index ab2b8a1f9ff..aa417190486 100644
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
index 90027409c81..714fdfa415d 100644
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
index 027d44bf38c..a86e0d06f6b 100644
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
index cb2a674d9d5..bed552288f4 100644
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
2.42.0.459.ge4e396fd5e-goog

