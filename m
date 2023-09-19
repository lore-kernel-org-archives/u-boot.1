Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953ABCE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DC386C4D;
	Tue, 19 Sep 2023 20:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kXZSNoAk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ED986BE1; Tue, 19 Sep 2023 20:09:50 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B400D86C1D
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-34fd889f69aso10540065ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146987; x=1695751787; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ri+BOr4JMCe/auO3+XTGjYBBtQFgclXoD0AWv5ulxCA=;
 b=kXZSNoAkjKYd4VM1PPHdQqasDMLnaQEKWsFG+k2763J2Wa2aLRUaVlcykJ3YZZLgqF
 keGimSsjfmk28o6J1p9QKxqeHjeCYNDB6hk9kjdx/4U0igsJA3jsrvALN6ytyuxsD7X3
 bIOMb9/YEnUkQR+YcMNtb7XzJwH2VB5HJtQk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146987; x=1695751787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ri+BOr4JMCe/auO3+XTGjYBBtQFgclXoD0AWv5ulxCA=;
 b=vS1mpHVQFD9ICsRVbE/XlvD2O2iV8kMll3lZ0obqvHvXPbUKRSnCWWuSelxRhaPrrt
 in5XqMXu7v61T4GLExRQOUey37oGbawjPxsnGNF9qTI26625qGDhVq8Gzmhm3dB3t5K2
 5DaSPLXz4sDnf4ZXMw5gTfqiaRlIS+WReCU709J4OfIS0AdIlpRZWN0Oq1g/7fHZa9SY
 MCXDWbWqZzgy1dNv8MkAoGdThEpwLwm44RMWZs5xu8AqAVJKjvXugNjgxrxCxF4fHViX
 RI0RyEZ/X8QwbQMQ9LvS0xrWxVWQ+Uz5Ie3fIMO4Sb15EY75alD7rPH1kcGo/AGRMfNf
 MWpw==
X-Gm-Message-State: AOJu0YwgipBs0H+JYt7PR+YqHX/ZmkqDTINKzuvlVdaU7Jsa58Yp478O
 Rj82SYJLz5iNdkja1HTGlgvIqhiQyQgqKH3NWoc=
X-Google-Smtp-Source: AGHT+IE2h4s1XgdGnpK74yRoJXqw6NAnW7je0HEAFv9/pJXVVsoGvJUa4qemqLLB/fIg9sTwsU9tHw==
X-Received: by 2002:a05:6e02:1ca4:b0:34f:4632:4e09 with SMTP id
 x4-20020a056e021ca400b0034f46324e09mr729406ill.23.1695146987385; 
 Tue, 19 Sep 2023 11:09:47 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 25/36] expo: Make calculation of an object bounding box generic
Date: Tue, 19 Sep 2023 12:08:55 -0600
Message-ID: <20230919180918.2904313-26-sjg@chromium.org>
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

We want to support this for any object, not just menus. Move the code
around to allow this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 45 +++++++++++++++++++++++++++++++++++++++++++
 boot/scene_internal.h | 39 +++++++++++++++++++++++++++++++++++++
 boot/scene_menu.c     | 39 +++----------------------------------
 3 files changed, 87 insertions(+), 36 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 4d7cabd75f4..e98676b9387 100644
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
index 42efcee092f..326508874e6 100644
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
index e0dcd0a4e04..95c283af4b0 100644
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
2.42.0.459.ge4e396fd5e-goog

