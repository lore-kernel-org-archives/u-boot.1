Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DF3E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:26:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D3FE8718D;
	Mon,  2 Oct 2023 03:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C+aF66zm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A5D2870FA; Mon,  2 Oct 2023 03:14:37 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04B6870B6
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3514cddf90bso34759385ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209250; x=1696814050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+x+5HhFspo42Ap6aYiuiGC2JKUbsz898+hmCIKC6xB8=;
 b=C+aF66zm4Gg4I8Uwfusq5U3gL4tYhGXvZslJz1Wht/RgAqlXKs9jzpMapv843iYP8r
 hR9qNXg1ouSuU0s0os9RLLNLafrwGu/o44SAbN7JAPIIYyPAA6EcNhj8MLb7iOB0Bvlo
 O2SPtgYl0RNTGBXGlOrjXPvmCvoWRCrttC6BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209250; x=1696814050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+x+5HhFspo42Ap6aYiuiGC2JKUbsz898+hmCIKC6xB8=;
 b=HjVJ5HeM3fp0uz58iiFgMxZhiAsrCzdiq04JoyF0r2r1R07/E0vKtinXn9Jk1e0k+P
 L3s9pYbmOet9qUWHhqX2awT15Sk+/lzoG5EjsmakaShvDCLfxDWdjrxghWFnPsf+Gdkt
 PSTPOuxr10db4L/fKRPijtWV+sznICMFD7QBKwh4xtVy5BAC5xK3p2UCdcfJDYyOjs3o
 xJ/UMrFFELpijCV14lVzk9Qcp8TKRujVCMtB+Xzm7syek84Ss5pzMBPOi8ps2hodRTUD
 3R88F1QuaXu1rK3bw9sruegqOAPIzy3u8Ger6k86/wHhusJFkrrrYxbVKP62ckgvwMFN
 5AHQ==
X-Gm-Message-State: AOJu0YxsiUq6/tf95dmTkIC1xZhk4Jzq9EFB6QSK5R1YqJithBoS/E5f
 qzgoi4ELr7WKvPeseo83uQ+MOUE3ksg8EK2ag4E=
X-Google-Smtp-Source: AGHT+IGtuiXwG5/rqcViTGMfxWBwADSGjLYZY0olbYeoDt3Gh10prgA4TyisdLNV70DHyRGmoWecgg==
X-Received: by 2002:a05:6e02:1a68:b0:351:5b43:5ed1 with SMTP id
 w8-20020a056e021a6800b003515b435ed1mr12428287ilv.13.1696209250368; 
 Sun, 01 Oct 2023 18:14:10 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 20/36] expo: Use switch statements more for object types
Date: Sun,  1 Oct 2023 19:13:24 -0600
Message-ID: <20231002011349.461284-21-sjg@chromium.org>
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

In a lot of cases menus are the only objects which are have their own
behaviour in the cedit, e.g. to move between menus. With expo expanding
to support text, this is no-longer true.

Use a switch() statement so that we can simply insert a new 'case' for
the new object types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c | 88 +++++++++++++++++++++++++++++++---------------------
 boot/scene.c | 38 ++++++++++++++++++-----
 2 files changed, 83 insertions(+), 43 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 1324a8619981..b7329c3245ee 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -71,10 +71,16 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 
 	y = 100;
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
-		if (obj->type == SCENEOBJT_MENU) {
+		switch (obj->type) {
+		case SCENEOBJT_NONE:
+		case SCENEOBJT_IMAGE:
+		case SCENEOBJT_TEXT:
+			break;
+		case SCENEOBJT_MENU:
 			scene_obj_set_pos(scn, obj->id, 50, y);
 			scene_menu_arrange(scn, (struct scene_obj_menu *)obj);
 			y += 50;
+			break;
 		}
 	}
 
@@ -422,31 +428,37 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 	const char *str;
 	int val, ret;
 
-	if (obj->type != SCENEOBJT_MENU)
-		return 0;
-
-	menu = (struct scene_obj_menu *)obj;
-	val = menu->cur_item_id;
 	snprintf(var, sizeof(var), "c.%s", obj->name);
 
-	if (priv->verbose)
-		printf("%s=%d\n", var, val);
+	switch (obj->type) {
+	case SCENEOBJT_NONE:
+	case SCENEOBJT_IMAGE:
+	case SCENEOBJT_TEXT:
+		break;
+	case SCENEOBJT_MENU:
+		menu = (struct scene_obj_menu *)obj;
+		val = menu->cur_item_id;
 
-	ret = env_set_ulong(var, val);
-	if (ret)
-		return log_msg_ret("set", ret);
+		if (priv->verbose)
+			printf("%s=%d\n", var, val);
 
-	ret = get_cur_menuitem_text(menu, &str);
-	if (ret)
-		return log_msg_ret("mis", ret);
+		ret = env_set_ulong(var, val);
+		if (ret)
+			return log_msg_ret("set", ret);
 
-	snprintf(name, sizeof(name), "c.%s-str", obj->name);
-	if (priv->verbose)
-		printf("%s=%s\n", name, str);
+		ret = get_cur_menuitem_text(menu, &str);
+		if (ret)
+			return log_msg_ret("mis", ret);
 
-	ret = env_set(name, str);
-	if (ret)
-		return log_msg_ret("st2", ret);
+		snprintf(name, sizeof(name), "c.%s-str", obj->name);
+		if (priv->verbose)
+			printf("%s=%s\n", name, str);
+
+		ret = env_set(name, str);
+		if (ret)
+			return log_msg_ret("st2", ret);
+		break;
+	}
 
 	return 0;
 }
@@ -474,24 +486,28 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	char var[60];
 	int val;
 
-	if (obj->type != SCENEOBJT_MENU)
-		return 0;
-
-	menu = (struct scene_obj_menu *)obj;
-	val = menu->cur_item_id;
 	snprintf(var, sizeof(var), "c.%s", obj->name);
 
-	val = env_get_ulong(var, 10, 0);
-	if (priv->verbose)
-		printf("%s=%d\n", var, val);
-	if (!val)
-		return log_msg_ret("get", -ENOENT);
-
-	/*
-	 * note that no validation is done here, to make sure the ID is valid
-	 * and actually points to a menu item
-	 */
-	menu->cur_item_id = val;
+	switch (obj->type) {
+	case SCENEOBJT_NONE:
+	case SCENEOBJT_IMAGE:
+	case SCENEOBJT_TEXT:
+		break;
+	case SCENEOBJT_MENU:
+		menu = (struct scene_obj_menu *)obj;
+		val = env_get_ulong(var, 10, 0);
+		if (priv->verbose)
+			printf("%s=%d\n", var, val);
+		if (!val)
+			return log_msg_ret("get", -ENOENT);
+
+		/*
+		 * note that no validation is done here, to make sure the ID is
+		 * valid * and actually points to a menu item
+		 */
+		menu->cur_item_id = val;
+		break;
+	}
 
 	return 0;
 }
diff --git a/boot/scene.c b/boot/scene.c
index 6c52948eb69c..08ed85e9188c 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -423,13 +423,20 @@ int scene_arrange(struct scene *scn)
 	int ret;
 
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
-		if (obj->type == SCENEOBJT_MENU) {
+		switch (obj->type) {
+		case SCENEOBJT_NONE:
+		case SCENEOBJT_IMAGE:
+		case SCENEOBJT_TEXT:
+			break;
+		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
 
 			menu = (struct scene_obj_menu *)obj,
 			ret = scene_menu_arrange(scn, menu);
 			if (ret)
 				return log_msg_ret("arr", ret);
+			break;
+		}
 		}
 	}
 
@@ -452,9 +459,16 @@ int scene_render_deps(struct scene *scn, uint id)
 		if (ret && ret != -ENOTSUPP)
 			return log_msg_ret("ren", ret);
 
-		if (obj->type == SCENEOBJT_MENU)
+		switch (obj->type) {
+		case SCENEOBJT_NONE:
+		case SCENEOBJT_IMAGE:
+		case SCENEOBJT_TEXT:
+			break;
+		case SCENEOBJT_MENU:
 			scene_menu_render_deps(scn,
 					       (struct scene_obj_menu *)obj);
+			break;
+		}
 	}
 
 	return 0;
@@ -537,7 +551,6 @@ static void send_key_obj(struct scene *scn, struct scene_obj *obj, int key,
 
 int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 {
-	struct scene_obj_menu *menu;
 	struct scene_obj *obj;
 	int ret;
 
@@ -561,10 +574,21 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 			return 0;
 		}
 
-		menu = (struct scene_obj_menu *)obj,
-		ret = scene_menu_send_key(scn, menu, key, event);
-		if (ret)
-			return log_msg_ret("key", ret);
+		switch (obj->type) {
+		case SCENEOBJT_NONE:
+		case SCENEOBJT_IMAGE:
+		case SCENEOBJT_TEXT:
+			break;
+		case SCENEOBJT_MENU: {
+			struct scene_obj_menu *menu;
+
+			menu = (struct scene_obj_menu *)obj,
+			ret = scene_menu_send_key(scn, menu, key, event);
+			if (ret)
+				return log_msg_ret("key", ret);
+			break;
+		}
+		}
 		return 0;
 	}
 
-- 
2.42.0.582.g8ccd20d70d-goog

