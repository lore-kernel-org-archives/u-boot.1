Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C3CCE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B47F86BF9;
	Tue, 19 Sep 2023 20:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ezFpUxK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 386C386BF9; Tue, 19 Sep 2023 20:09:47 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11ED886BF8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34fe2814b0dso7937745ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146983; x=1695751783; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcQKmqPHWTOBvnV4DA0AxnYY/+/UiZ3CpTwH+PrqaJo=;
 b=ezFpUxK8goMN9JiVCyDvZFjyv5rIwroKklaDKvMSg6OVf81WxAOyciBd1dxgITSLR/
 /gkbW7bC5NW1Q5YeMwONrAewssHoaHms+gIfb330hu5Qhw+MArRrdlBndCu9Nw/3rh/w
 a+ZH93GMcSQ/G0rIW+IYRMXjJtYAXg8ygyE2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146983; x=1695751783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcQKmqPHWTOBvnV4DA0AxnYY/+/UiZ3CpTwH+PrqaJo=;
 b=tR6FZob6j9L+fneIqYdCCJsu45bCrui5WvmUlUSlMlnR7TYpjVJTE0qOiEfJahnczE
 CaheVhLRG3VVI+ky3+cp7KIyHKQWZQZts4BZfWIio8qeDrckgwNn5MYDyZ/OAxiJNxHX
 /OEAVsw3cSDmKTm3MXmv1cT1cvOf0EvwK5fHjqat6sp3cKGrA9MoWZJhWjB7EUNFVM13
 kLfb7UxxzADG6LVhNZisBpfSHdK6htm4kJM4m1KrNjaojXmww9/VuboKswztz86iuACK
 wmjG0IyCGPuMNhSqqCkETlP0MPmuLS/sXbGWpixISB2hh4FeHyvwo3ebZrrEIEzgwI75
 EhPw==
X-Gm-Message-State: AOJu0YwOm1kg2lwIJXaqIPdgDtAHBsgI3q76gmydpzLo4uyOVyJc0r69
 9kOrJIlD2sHrfWfX+MNa8tfEqy5r5cGra0824T4=
X-Google-Smtp-Source: AGHT+IGzjsIqXcmD/UqIQyrIur6zf5EWedBNe0KMVJ6p9CwkM8c3Zc4QRVqbxP+HtNb8r1M4YR6Qig==
X-Received: by 2002:a05:6e02:3201:b0:34f:1e9c:45d5 with SMTP id
 cd1-20020a056e02320100b0034f1e9c45d5mr555493ilb.32.1695146983686; 
 Tue, 19 Sep 2023 11:09:43 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 20/36] expo: Use switch statements more for object types
Date: Tue, 19 Sep 2023 12:08:50 -0600
Message-ID: <20230919180918.2904313-21-sjg@chromium.org>
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

In a lot of cases menus are the only objects which are have their own
behaviour in the cedit, e.g. to move between menus. With expo expanding
to support text, this is no-longer true.

Use a switch() statement so that we can simply insert a new 'case' for
the new object types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c | 88 +++++++++++++++++++++++++++++++---------------------
 boot/scene.c | 38 ++++++++++++++++++-----
 2 files changed, 83 insertions(+), 43 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 1324a861998..b7329c3245e 100644
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
index 6c52948eb69..08ed85e9188 100644
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
2.42.0.459.ge4e396fd5e-goog

