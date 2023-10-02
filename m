Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EB1E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6154087196;
	Mon,  2 Oct 2023 03:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="krub1kv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8664C87147; Mon,  2 Oct 2023 03:14:42 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1B4D87121
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3513c435465so5905165ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209255; x=1696814055; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABr0RWPwBagRf6r5aVDLfIDBiJXr4X6EBvuwgoq64eo=;
 b=krub1kv1xa0Sfj1JFM1WwzB1jR8yzpj23Pp6JF+tsrqkJTqbtLIJC+W4ptTi2/JPJp
 g0uu2Q+LOLnGbwc/TZzA4LrLwO0h9qDqb2+AEP551PHlOU9w8R/s50ha8V8tJkC5+Bgz
 vcz+18b4ZYbUSugxMWXhzg/RbTngsfkp2eUfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209255; x=1696814055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABr0RWPwBagRf6r5aVDLfIDBiJXr4X6EBvuwgoq64eo=;
 b=Lgl1BJySDThFupsZlU+BaoTB/aUaHma72BJEVC9k/wss+yyTpGZ2kzpHk2Yg/Wujgl
 s94kz9l/PJhJy9xFa0N3R9mNc/yHhc4HcW4BXQJFTx7zQc7YF6pvlPe4GpXthzBCoj/n
 H+HZkxg39vnFLG4yAhOqVVsfPTgEvZ/rYs8uTJscQCXeyL24K1E3zRIwLJ48QQSu7Ve5
 CC/VNnsneYGXuuxAZ1B35eeAlClhjt/RFtjCCrnf+V+jzU5zPqnBawdJ+tuXM+ARnKoQ
 7PceTJO/9j0afK2j8LVyx0YoxaSNAbpQBYz2CGlSrlQDoawJLqD19HZMEuHYG0/o3rE9
 6IKw==
X-Gm-Message-State: AOJu0Yycm+BeU/kZ6gQRTTZ18n23/YljhiojciKOAYmNwHCP26WF31AS
 BL1sMsR3Og1Si/5WpoyKVyfu5u1hmyOfxaAYLoU=
X-Google-Smtp-Source: AGHT+IGN5GOSe8AYQVrywUpHhiNn/m+ZypsOfYUwwL2E6APbUY69rt73Aa02QUuQdgu847ettl7rrw==
X-Received: by 2002:a05:6e02:184d:b0:348:b086:2c4b with SMTP id
 b13-20020a056e02184d00b00348b0862c4bmr9812129ilv.9.1696209255330; 
 Sun, 01 Oct 2023 18:14:15 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 26/36] expo: Allow rendering the background of any object
Date: Sun,  1 Oct 2023 19:13:30 -0600
Message-ID: <20231002011349.461284-27-sjg@chromium.org>
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

So far only menus have a background. When other object types are
rendered, they may have a background too. Make this code more generic
so it will be usable by new object types.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c          | 40 +++++++++++++++++++++++++++++++++++++++-
 boot/scene_internal.h |  7 -------
 boot/scene_menu.c     | 29 -----------------------------
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index e98676b9387a..314dd7c6e849 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -314,6 +314,44 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 	return 0;
 }
 
+/**
+ * scene_render_background() - Render the background for an object
+ *
+ * @obj: Object to render
+ */
+static void scene_render_background(struct scene_obj *obj)
+{
+	struct expo *exp = obj->scene->expo;
+	const struct expo_theme *theme = &exp->theme;
+	struct vidconsole_bbox bbox, label_bbox;
+	struct udevice *dev = exp->display;
+	struct video_priv *vid_priv;
+	struct udevice *cons = exp->cons;
+	struct vidconsole_colour old;
+	enum colour_idx fore, back;
+	uint inset = theme->menu_inset;
+
+	/* draw a background for the object */
+	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+		fore = VID_BLACK;
+		back = VID_WHITE;
+	} else {
+		fore = VID_LIGHT_GRAY;
+		back = VID_BLACK;
+	}
+
+	/* see if this object wants to render a background */
+	if (scene_obj_calc_bbox(obj, &bbox, &label_bbox))
+		return;
+
+	vidconsole_push_colour(cons, fore, back, &old);
+	vid_priv = dev_get_uclass_priv(dev);
+	video_fill_part(dev, label_bbox.x0 - inset, label_bbox.y0 - inset,
+			label_bbox.x1 + inset, label_bbox.y1 + inset,
+			vid_priv->colour_fg);
+	vidconsole_pop_colour(cons, &old);
+}
+
 /**
  * scene_obj_render() - Render an object
  *
@@ -397,7 +435,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 				return -ENOTSUPP;
 
 			/* draw a background behind the menu items */
-			scene_menu_render(menu);
+			scene_render_background(obj);
 		}
 		/*
 		 * With a vidconsole, the text and item pointer are rendered as
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 326508874e6a..1c2bfeadcd38 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -165,13 +165,6 @@ int scene_render(struct scene *scn);
  */
 int scene_send_key(struct scene *scn, int key, struct expo_action *event);
 
-/**
- * scene_menu_render() - Render the background behind a menu
- *
- * @menu: Menu to render
- */
-void scene_menu_render(struct scene_obj_menu *menu);
-
 /**
  * scene_render_deps() - Render an object and its dependencies
  *
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 95c283af4b08..63994165efba 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -516,35 +516,6 @@ int scene_menu_display(struct scene_obj_menu *menu)
 	return -ENOTSUPP;
 }
 
-void scene_menu_render(struct scene_obj_menu *menu)
-{
-	struct expo *exp = menu->obj.scene->expo;
-	const struct expo_theme *theme = &exp->theme;
-	struct vidconsole_bbox bbox, label_bbox;
-	struct udevice *dev = exp->display;
-	struct video_priv *vid_priv;
-	struct udevice *cons = exp->cons;
-	struct vidconsole_colour old;
-	enum colour_idx fore, back;
-
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
-		fore = VID_BLACK;
-		back = VID_WHITE;
-	} else {
-		fore = VID_LIGHT_GRAY;
-		back = VID_BLACK;
-	}
-
-	scene_menu_calc_bbox(menu, &bbox, &label_bbox);
-	vidconsole_push_colour(cons, fore, back, &old);
-	vid_priv = dev_get_uclass_priv(dev);
-	video_fill_part(dev, label_bbox.x0 - theme->menu_inset,
-			label_bbox.y0 - theme->menu_inset,
-			label_bbox.x1, label_bbox.y1 + theme->menu_inset,
-			vid_priv->colour_fg);
-	vidconsole_pop_colour(cons, &old);
-}
-
 int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu)
 {
 	struct scene_menitem *item;
-- 
2.42.0.582.g8ccd20d70d-goog

