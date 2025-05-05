Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C523C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1C282A1C;
	Mon,  5 May 2025 17:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/fJk1Ml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A9F982977; Mon,  5 May 2025 17:44:05 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558D482153
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5f4ca707e31so7249751a12.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459840; x=1747064640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GAf0qWGQtxjNbhIzY+98VrRxIJBJ/YwOs+GKRRWApbc=;
 b=I/fJk1MlqRKtODKpTRdOfHTEhocTgQjptHHGq4SjbaD+0GC8w8tVhsaaDyJCxHn7DH
 Mplf/XHUdwEx8X6pT+J3678R9HhAb47FL0lrBvc0i8hdMBho5ApGGn2IzhKdxh3nczbs
 OlhZr9Z7Gw9h0vemliUAUrVTIgFxH42vrgbNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459840; x=1747064640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GAf0qWGQtxjNbhIzY+98VrRxIJBJ/YwOs+GKRRWApbc=;
 b=NOTC1duDhAa29OuXt4BmRLB5kgb9hUUbNKW6xG5TH9nd4uPkmhbbgM4u2T8JdD11f1
 u67xXHSP2ftTo+FeNvuacv23Q1NKpj+Po7mHAWeOUgxv6q9rlma39TuApMGFTqBJMLYz
 f6CBq6BBYGF7MN5iJUSZdgs5WLGJJyjlfQyYkwcmBsK3ODPjmo9xlQBFcJI8Bvbr/xWl
 9/8KjSuE131fRbWjw8AUmLBdkA/RmIcQCz0B7q2gSP9yVxeVZyDJEAnqnFFuiHxXfJeh
 +ER8Zt+5jzT3AImPL2+6UFrPueSbQULCR9Or7F9MuJjK1OaoASROusNsIgy6riPobjHP
 W8ow==
X-Gm-Message-State: AOJu0YzNdGd1y2RNkujazSdmEmKWYDJIHJadZ9gX5/nlJ6WeVxi+R8nS
 JUilQ1szaMbK/YCgyblumQt8HZPCj0kHlTuONFVnp08njTmi/pgsy8PthY5Ld26TI5+efK0WW65
 cI5Sy2Fs=
X-Gm-Gg: ASbGnculKW/r2IknzMv/PWnCH/orwNKDQ29idPFGMm8XodCFsktR7VyvNcxsZ2FD2OW
 hf5uEwapIQZS3hn6wAAPFW0qgNP7pX+EG7fbFHGHa4aFXDT537Ekx9vOoCWCwbO24ztkwCLknZU
 KVibSVmMIRrzbhpu10FYi0pHanSYicAgnjZzSzl7u/hknd6c6rav1lplvn3K9wjHuZlwghJdzEH
 G2r2RQ1DVBxZjsRbbSWzDH6uoaDqGYWlKLpVDrHG4t8SdMg6Q0eLULukLQa+BYlEnTw9G91Xdo/
 cKv1iExSQau7L1Kro0dLpOX8TizIkiENgJkT
X-Google-Smtp-Source: AGHT+IFAQDZyuShqywPtkcRWUFp4Pbhlu0HyCHEv2RZHcnx0ghizpinvaJME4rANODPe8TCzq/GyTg==
X-Received: by 2002:a05:6402:40c2:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5fab05ce7dcmr6382070a12.23.1746459840262; 
 Mon, 05 May 2025 08:44:00 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:43:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/19] expo: Separate out reading the theme from applying it
Date: Mon,  5 May 2025 17:42:44 +0200
Message-ID: <20250505154308.2911248-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

Rename the existing expo_apply_theme() to expo_setup_theme() and adjust
the former so that it applies a theme which has already been read into
the struct. This will make it easier for tests to check theme
adjustments, since they won't have to put them in a node.

Add the white-on-black property into the theme struct while we are.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c |  2 +-
 boot/expo.c          | 33 +++++++++++++++++++++++----------
 cmd/cedit.c          |  2 +-
 include/expo.h       | 18 ++++++++++++++++--
 test/boot/bootflow.c |  2 +-
 test/boot/expo.c     |  2 +-
 6 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 934165d2855..a0437177364 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -261,7 +261,7 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 		return log_msg_ret("bma", ret);
 
 	if (ofnode_valid(std->theme)) {
-		ret = expo_apply_theme(exp, std->theme);
+		ret = expo_setup_theme(exp, std->theme);
 		if (ret)
 			return log_msg_ret("thm", ret);
 	}
diff --git a/boot/expo.c b/boot/expo.c
index 64d3febacdb..a218ea0e4e9 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -281,11 +281,28 @@ int expo_action_get(struct expo *exp, struct expo_action *act)
 	return act->type == EXPOACT_NONE ? -EAGAIN : 0;
 }
 
-int expo_apply_theme(struct expo *exp, ofnode node)
+int expo_apply_theme(struct expo *exp)
 {
+	struct expo_theme *theme = &exp->theme;
 	struct scene *scn;
+
+	if (exp->display)
+		video_set_white_on_black(exp->display, theme->white_on_black);
+
+	list_for_each_entry(scn, &exp->scene_head, sibling) {
+		int ret;
+
+		ret = scene_apply_theme(scn, theme);
+		if (ret)
+			return log_msg_ret("asn", ret);
+	}
+
+	return 0;
+}
+
+int expo_setup_theme(struct expo *exp, ofnode node)
+{
 	struct expo_theme *theme = &exp->theme;
-	bool white_on_black;
 	int ret;
 
 	log_debug("Applying theme %s\n", ofnode_get_name(node));
@@ -296,15 +313,11 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
 	ofnode_read_u32(node, "menu-title-margin-x",
 			&theme->menu_title_margin_x);
-	white_on_black = ofnode_read_bool(node, "white-on-black");
-	if (exp->display)
-		video_set_white_on_black(exp->display, white_on_black);
+	theme->white_on_black = ofnode_read_bool(node, "white-on-black");
 
-	list_for_each_entry(scn, &exp->scene_head, sibling) {
-		ret = scene_apply_theme(scn, theme);
-		if (ret)
-			return log_msg_ret("app", ret);
-	}
+	ret = expo_apply_theme(exp);
+	if (ret)
+		return log_msg_ret("asn", ret);
 
 	return 0;
 }
diff --git a/cmd/cedit.c b/cmd/cedit.c
index 2e15b063462..9c492d45171 100644
--- a/cmd/cedit.c
+++ b/cmd/cedit.c
@@ -274,7 +274,7 @@ static int do_cedit_run(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	node = ofnode_path("/bootstd/cedit-theme");
 	if (ofnode_valid(node)) {
-		ret = expo_apply_theme(cur_exp, node);
+		ret = expo_setup_theme(cur_exp, node);
 		if (ret)
 			return CMD_RET_FAILURE;
 	} else {
diff --git a/include/expo.h b/include/expo.h
index 75ff1df3cfc..0b25a9d8b41 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -83,12 +83,15 @@ struct expo_action {
  * @menuitem_gap_y: Gap between menu items in pixels
  * @menu_title_margin_x: Gap between right side of menu title and left size of
  *	menu label
+ * @white_on_black: True to use white-on-black for the expo, false for
+ *	black-on-white
  */
 struct expo_theme {
 	u32 font_size;
 	u32 menu_inset;
 	u32 menuitem_gap_y;
 	u32 menu_title_margin_x;
+	bool white_on_black;
 };
 
 /**
@@ -994,12 +997,23 @@ int expo_send_key(struct expo *exp, int key);
 int expo_action_get(struct expo *exp, struct expo_action *act);
 
 /**
- * expo_apply_theme() - Apply a theme to an expo
+ * expo_setup_theme() - Read a theme from a node and apply it to an expo
  *
  * @exp: Expo to update
  * @node: Node containing the theme
+ * Returns: 0 if OK, -ve on error
+ */
+int expo_setup_theme(struct expo *exp, ofnode node);
+
+/**
+ * expo_apply_theme() - Apply an expo's theme
+ *
+ * The theme to be applied must be set up exp->theme
+ *
+ * @exp: Expo to update
+ * Returns: 0 if OK, -ve on error
  */
-int expo_apply_theme(struct expo *exp, ofnode node);
+int expo_apply_theme(struct expo *exp);
 
 /**
  * expo_build() - Build an expo from an FDT description
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 670e73c265b..0dd8fa71261 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -884,7 +884,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	ut_assertok(bootflow_menu_add_all(exp));
 	node = ofnode_path("/bootstd/theme");
 	ut_assert(ofnode_valid(node));
-	ut_assertok(expo_apply_theme(exp, node));
+	ut_assertok(expo_setup_theme(exp, node));
 
 	scn = expo_lookup_scene_id(exp, MAIN);
 	ut_assertnonnull(scn);
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 64b6c154b15..824ef023c1c 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -302,7 +302,7 @@ static int expo_object_attr(struct unit_test_state *uts)
 
 	node = ofnode_path("/bootstd/theme");
 	ut_assert(ofnode_valid(node));
-	ut_assertok(expo_apply_theme(exp, node));
+	ut_assertok(expo_setup_theme(exp, node));
 	ut_asserteq(30, txt->gen.font_size);
 
 	expo_destroy(exp);
-- 
2.43.0

