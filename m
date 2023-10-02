Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79F04E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3A98719D;
	Mon,  2 Oct 2023 03:15:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N8E0/DPe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D4A870BD; Mon,  2 Oct 2023 03:14:48 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F258711F
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79faf4210b2so458058739f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209254; x=1696814054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYDy6poK1DzXplELVjcZ2pZNZBn7n8EPBTYpzpnWKQY=;
 b=N8E0/DPe8H/eT1pMyc9NIqEMnhG8EqnnwM8nMhxv+jjLqWFJ4+l+CVcz8/77cu3Ui8
 nN1JRkJlBUq12cgFUl0X9RazbLSOjuO41BwwkQF8XPlvrPQJma8j2m/FJ9/W9+g6Awxo
 csTMQsv/MHOW+KHvYfTSCmq8rqCAvN456+Dcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209254; x=1696814054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYDy6poK1DzXplELVjcZ2pZNZBn7n8EPBTYpzpnWKQY=;
 b=tPUq8jAY4x0sJcE14c3sKOSYGGby45IbmUa2143lXLSO21zyO88BA3wTvuq8RZya3p
 NnIIPMoHo/W3LXxWMFVOynQG/qaImlDZb4sanj2WdtEwO3WqOE7Dsx9sKJKMx9BiXEVO
 4dIqNxX4LlKG6IML9Mf4MlP4wsP39bYo1C10tCbTtv/4ljHAVWMqmSkU1aZ+EC23yopB
 NhapE8UuuzVq0NlYIHDpF9VW3sGIsE0qk1KNm0puxoOKKMcyCw9+ggICobuYb08tndnL
 j0qV1AVNW0maQvEFtKt95TvJi64Zfx28qb76pT54I4P9slzCUAZ4w+JXWBTTEMbYvZvF
 qWmg==
X-Gm-Message-State: AOJu0Yx/p0dgsBuIltqeuHcA8MbdL+oYR8Dcq8QM0ihbqbLRgVPcqSGy
 w+l4hX86+BUWhjac1qMqDE1oHmxs5VFD66eKmJY=
X-Google-Smtp-Source: AGHT+IEuoh0sJefwy9FQuKWAvLTwT/GqDURZJg4z+HRbUv8yb1F3+MfL4ywSiSMxrTV13t52IsZpGA==
X-Received: by 2002:a6b:4405:0:b0:792:4cfc:178f with SMTP id
 r5-20020a6b4405000000b007924cfc178fmr12109851ioa.16.1696209254601; 
 Sun, 01 Oct 2023 18:14:14 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 25/36] expo: Make calculation of an object bounding box
 generic
Date: Sun,  1 Oct 2023 19:13:29 -0600
Message-ID: <20231002011349.461284-26-sjg@chromium.org>
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

We want to support this for any object, not just menus. Move the code
around to allow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c          | 45 +++++++++++++++++++++++++++++++++++++++++++
 boot/scene_internal.h | 39 +++++++++++++++++++++++++++++++++++++
 boot/scene_menu.c     | 39 +++----------------------------------
 3 files changed, 87 insertions(+), 36 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 4d7cabd75f4f..e98676b9387a 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -608,6 +608,25 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 	return 0;
 }
 
+int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
+			struct vidconsole_bbox *label_bbox)
+{
+	switch (obj->type) {
+	case SCENEOBJT_NONE:
+	case SCENEOBJT_IMAGE:
+	case SCENEOBJT_TEXT:
+		return -ENOSYS;
+	case SCENEOBJT_MENU: {
+		struct scene_obj_menu *menu = (struct scene_obj_menu *)obj;
+
+		scene_menu_calc_bbox(menu, bbox, label_bbox);
+		break;
+	}
+	}
+
+	return 0;
+}
+
 int scene_calc_dims(struct scene *scn, bool do_menus)
 {
 	struct scene_obj *obj;
@@ -719,3 +738,29 @@ int scene_iter_objs(struct scene *scn, expo_scene_obj_iterator iter,
 
 	return 0;
 }
+
+int scene_bbox_union(struct scene *scn, uint id, int inset,
+		     struct vidconsole_bbox *bbox)
+{
+	struct scene_obj *obj;
+
+	if (!id)
+		return 0;
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("obj", -ENOENT);
+	if (bbox->valid) {
+		bbox->x0 = min(bbox->x0, obj->dim.x - inset);
+		bbox->y0 = min(bbox->y0, obj->dim.y);
+		bbox->x1 = max(bbox->x1, obj->dim.x + obj->dim.w + inset);
+		bbox->y1 = max(bbox->y1, obj->dim.y + obj->dim.h);
+	} else {
+		bbox->x0 = obj->dim.x - inset;
+		bbox->y0 = obj->dim.y;
+		bbox->x1 = obj->dim.x + obj->dim.w + inset;
+		bbox->y1 = obj->dim.y + obj->dim.h;
+		bbox->valid = true;
+	}
+
+	return 0;
+}
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 42efcee092f3..326508874e6a 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -9,6 +9,8 @@
 #ifndef __SCENE_INTERNAL_H
 #define __SCENE_INTERNAL_H
 
+struct vidconsole_bbox;
+
 typedef int (*expo_scene_obj_iterator)(struct scene_obj *obj, void *priv);
 
 /**
@@ -246,4 +248,41 @@ struct scene_menitem *scene_menuitem_find(const struct scene_obj_menu *menu,
 struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
 					      uint seq);
 
+/**
+ * scene_bbox_union() - update bouding box with the demensions of an object
+ *
+ * Updates @bbox so that it encompasses the bounding box of object @id
+ *
+ * @snd: Scene containing object
+ * @id: Object id
+ * @inset: Amount of inset to use for width
+ * @bbox: Bounding box to update
+ * Return: 0 if OK, -ve on error
+ */
+int scene_bbox_union(struct scene *scn, uint id, int inset,
+		     struct vidconsole_bbox *bbox);
+
+/**
+ * scene_menu_calc_bbox() - Calculate bounding boxes for the menu
+ *
+ * @menu: Menu to process
+ * @bbox: Returns bounding box of menu including prompts
+ * @label_bbox: Returns bounding box of labels
+ * Return: 0 if OK, -ve on error
+ */
+void scene_menu_calc_bbox(struct scene_obj_menu *menu,
+			  struct vidconsole_bbox *bbox,
+			  struct vidconsole_bbox *label_bbox);
+
+/**
+ * scene_obj_calc_bbox() - Calculate bounding boxes for an object
+ *
+ * @obj: Object to process
+ * @bbox: Returns bounding box of object including prompts
+ * @label_bbox: Returns bounding box of labels (active area)
+ * Return: 0 if OK, -ve on error
+ */
+int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
+			struct vidconsole_bbox *label_bbox);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index e0dcd0a4e041..95c283af4b08 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -114,42 +114,9 @@ static void menu_point_to_item(struct scene_obj_menu *menu, uint item_id)
 	update_pointers(menu, item_id, true);
 }
 
-static int scene_bbox_union(struct scene *scn, uint id, int inset,
-			    struct vidconsole_bbox *bbox)
-{
-	struct scene_obj *obj;
-
-	if (!id)
-		return 0;
-	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
-	if (!obj)
-		return log_msg_ret("obj", -ENOENT);
-	if (bbox->valid) {
-		bbox->x0 = min(bbox->x0, obj->dim.x - inset);
-		bbox->y0 = min(bbox->y0, obj->dim.y);
-		bbox->x1 = max(bbox->x1, obj->dim.x + obj->dim.w + inset);
-		bbox->y1 = max(bbox->y1, obj->dim.y + obj->dim.h);
-	} else {
-		bbox->x0 = obj->dim.x - inset;
-		bbox->y0 = obj->dim.y;
-		bbox->x1 = obj->dim.x + obj->dim.w + inset;
-		bbox->y1 = obj->dim.y + obj->dim.h;
-		bbox->valid = true;
-	}
-
-	return 0;
-}
-
-/**
- * scene_menu_calc_bbox() - Calculate bounding boxes for the menu
- *
- * @menu: Menu to process
- * @bbox: Returns bounding box of menu including prompts
- * @label_bbox: Returns bounding box of labels
- */
-static void scene_menu_calc_bbox(struct scene_obj_menu *menu,
-				 struct vidconsole_bbox *bbox,
-				 struct vidconsole_bbox *label_bbox)
+void scene_menu_calc_bbox(struct scene_obj_menu *menu,
+			  struct vidconsole_bbox *bbox,
+			  struct vidconsole_bbox *label_bbox)
 {
 	const struct expo_theme *theme = &menu->obj.scene->expo->theme;
 	const struct scene_menitem *item;
-- 
2.42.0.582.g8ccd20d70d-goog

