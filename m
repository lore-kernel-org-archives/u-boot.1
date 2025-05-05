Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6121C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 067BE82935;
	Mon,  5 May 2025 17:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bP6bZ/6l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 350CA82153; Mon,  5 May 2025 17:44:12 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B899826B2
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5e5e8274a74so6989050a12.1
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459848; x=1747064648; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNSeG4XVUcA867EfyFDk6Ayo8dQTo4PYzNofD0r2ojk=;
 b=bP6bZ/6ll8OR8To2rANGse/eqeSV18JAxP3JMV2te7B+3VE6jYivU3H/IGkn86dcwG
 I4CaXMc+l4Hi4FjAdJ8wriIYBYgBvdJnsE8iki52txPKAkpmfIsLuH99hkdBsfbD1Vq3
 E8aN5SsxvfcJ123kJp5ZIJljv2Ap3/LFjR/bo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459848; x=1747064648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNSeG4XVUcA867EfyFDk6Ayo8dQTo4PYzNofD0r2ojk=;
 b=H0E6b1X9J8cE3DKVE9hNXE2nFsBowR0rNY4hKEYhYhXtGW8JR3sb8eXrZywuZjr/e6
 UZQ0Lgozj0jW5xBxocXtOy5sIF9JtDrqrQ+Oy2MTsAaGlzqOP7IzFcILdnOyRIYJeAL8
 LVRldQ3M09LvCzz0ZHPooVF+2UAOL8qsGyNFuYu8P9jz9209n7++wefJZQNNOTQWX/vT
 Yrez+aWGRUEo3X9i7kbouBZCW/ysf8ugnBbpiw6smOEc0FREc6W2W3wY9VhVpyTbeWOy
 Jdrr/5uhRCjPUpAbJ6ZXhZ774RGxak9A/zmME3q6YRIB/Ex3rqrOgPovugp/cHMd2ef+
 NJBA==
X-Gm-Message-State: AOJu0YylkvilIqdCP1OvGTiETC0J+Y5tU8uL7dx8okEOPbkaEm8LMtjh
 4cc2WeZ8Rn4xnlDbJyruoGnRdjzR6BM6vbroaPxjcxwYhHDW5OiSJeRfKWZ4Q3khUVuo0Fyd+pZ
 9D3ufH/0=
X-Gm-Gg: ASbGnctuJecFoSuyc3xpeYWuTTU9kQj17djN7ELCvDz4nQ2XLx+oiJV9jg+SclUl6mg
 DzXSWCXXYgDl1QZA6bMobJuqSFezdk7HhfVEA1Gk7EpbZiVg4wDm+VWMYpyAqMkAfach52QHpTS
 BO/hwzb0PFRkMCCl+FpGWwp/2KZs/GSMLEXTyU+B2Jkr8+3Y2hJ5OiGsm4T8FS347YrngpBBwEp
 6R0syy3iSJ8rZr8s1yF/o3UJALfEmo4jnGrRFtXHHgGCmGGUOCNYhc8Aot644KFXmB5i9cvIfmE
 KpXysjummDskSW7dAckDkxtSjYv5U++GKmYv
X-Google-Smtp-Source: AGHT+IE4IXE+nj5qWzrzF2CfaBVQuIJRO1BkwvtJ6t935lZoo2jt2+gClQFoEiMNI3Mz6PVgy1wtjQ==
X-Received: by 2002:a05:6402:d0e:b0:5f6:c4ae:d0cd with SMTP id
 4fb4d7f45d1cf-5fab057ea94mr6046150a12.20.1746459847990; 
 Mon, 05 May 2025 08:44:07 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/19] expo: Move menu dims calculations into
 scene_menu_arrange()
Date: Mon,  5 May 2025 17:42:49 +0200
Message-ID: <20250505154308.2911248-12-sjg@chromium.org>
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

A menu's dimensions are currently only used for positioning the
component parts of the menu, i.e. the label, key, description and
preview.

Move the logic for this entirely into the scene_menu file and drop the
logic at the top level.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 12 +-------
 boot/scene_internal.h | 10 -------
 boot/scene_menu.c     | 65 ++++++++++++++++++++++++-------------------
 3 files changed, 38 insertions(+), 49 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 258161f27ce..9c1eae3d52b 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -1043,18 +1043,8 @@ int scene_calc_dims(struct scene *scn)
 				}
 				break;
 			}
-			case SCENEOBJT_MENU: {
-				struct scene_obj_menu *menu;
-
-				if (do_menus) {
-					menu = (struct scene_obj_menu *)obj;
-
-					ret = scene_menu_calc_dims(menu);
-					if (ret)
-						return log_msg_ret("men", ret);
-				}
+			case SCENEOBJT_MENU:
 				break;
-			}
 			case SCENEOBJT_TEXTLINE: {
 				struct scene_obj_textline *tline;
 
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index f9b30caa208..cca7c18e9f5 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -259,16 +259,6 @@ int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu);
 int scene_textline_render_deps(struct scene *scn,
 			       struct scene_obj_textline *tline);
 
-/**
- * scene_menu_calc_dims() - Calculate the dimensions of a menu
- *
- * Updates the width and height of the menu based on its contents
- *
- * @menu: Menu to update
- * Returns 0 if OK, -ENOTSUPP if there is no graphical console
- */
-int scene_menu_calc_dims(struct scene_obj_menu *menu);
-
 /**
  * scene_iter_objs() - Iterate through all scene objects
  *
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 3f988657e00..c2abf1e3926 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -192,45 +192,37 @@ void scene_menu_calc_bbox(struct scene_obj_menu *menu,
 	bbox[SCENEBB_label].y1 -= theme->menuitem_gap_y;
 }
 
-int scene_menu_calc_dims(struct scene_obj_menu *menu)
+static void scene_menu_calc_dims(struct scene *scn, struct scene_obj_menu *menu,
+				 struct scene_obj_dims *dims)
 {
-	struct vidconsole_bbox bbox[SCENEBB_count], *cur;
 	const struct scene_menitem *item;
 
-	scene_menu_calc_bbox(menu, bbox);
-
-	/* Make all field types the same width */
 	list_for_each_entry(item, &menu->item_head, sibling) {
-		cur = &bbox[SCENEBB_label];
-		if (cur->valid)
-			scene_obj_set_width(menu->obj.scene, item->label_id,
-					    cur->x1 - cur->x0);
-		cur = &bbox[SCENEBB_key];
-		if (cur->valid)
-			scene_obj_set_width(menu->obj.scene, item->key_id,
-					    cur->x1 - cur->x0);
-		cur = &bbox[SCENEBB_desc];
-		if (cur->valid)
-			scene_obj_set_width(menu->obj.scene, item->desc_id,
-					    cur->x1 - cur->x0);
-	}
-
-	cur = &bbox[SCENEBB_all];
-	if (cur->valid) {
-		menu->obj.dims.x = cur->x1 - cur->x0;
-		menu->obj.dims.y = cur->y1 - cur->y0;
-
-		menu->obj.bbox.x1 = cur->x1;
-		menu->obj.bbox.y1 = cur->y1;
+		struct scene_obj_dims local;
+
+		local.x = 0;
+		local.y = 0;
+		scene_dims_union(menu->obj.scene, item->label_id, &local);
+		scene_dims_union(menu->obj.scene, item->key_id, &local);
+		scene_dims_union(menu->obj.scene, item->desc_id, &local);
+		scene_dims_union(menu->obj.scene, item->preview_id, &local);
+		scene_dims_join(&local, &dims[SCENEBB_all]);
+
+		/* Get the dimensions all individual fields */
+		scene_dims_union(menu->obj.scene, item->label_id,
+				 &dims[SCENEBB_label]);
+		scene_dims_union(menu->obj.scene, item->key_id,
+				 &dims[SCENEBB_key]);
+		scene_dims_union(menu->obj.scene, item->desc_id,
+				 &dims[SCENEBB_desc]);
 	}
-
-	return 0;
 }
 
 int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 		       struct scene_obj_menu *menu)
 {
 	const bool open = menu->obj.flags & SCENEOF_OPEN;
+	struct scene_obj_dims dims[SCENEBB_count];
 	struct expo *exp = scn->expo;
 	const bool stack = exp->popup;
 	const struct expo_theme *theme = &exp->theme;
@@ -239,6 +231,12 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int x, y;
 	int ret;
 
+	menu->obj.dims.x = 0;
+	menu->obj.dims.y = 0;
+
+	memset(dims, '\0', sizeof(dims));
+	scene_menu_calc_dims(scn, menu, dims);
+
 	x = menu->obj.bbox.x0;
 	y = menu->obj.bbox.y0;
 	if (menu->title_id) {
@@ -327,12 +325,23 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 				return log_msg_ret("hid", ret);
 		}
 
+		menu->obj.dims.x = 160;
 		if (!stack || open)
 			y += height + theme->menuitem_gap_y;
 	}
 
+	list_for_each_entry(item, &menu->item_head, sibling) {
+		scene_obj_set_width(menu->obj.scene, item->label_id,
+				    dims[SCENEBB_label].x + theme->menu_inset);
+		scene_obj_set_width(menu->obj.scene, item->key_id,
+				    dims[SCENEBB_key].x + theme->menu_inset);
+		scene_obj_set_width(menu->obj.scene, item->desc_id,
+				    dims[SCENEBB_desc].x + theme->menu_inset);
+	}
+
 	if (sel_id)
 		menu_point_to_item(menu, sel_id);
+	menu->obj.dims.y = dims[SCENEBB_all].y;
 	menu->obj.bbox.x1 = menu->obj.bbox.x0 + menu->obj.dims.x;
 	menu->obj.bbox.y1 = menu->obj.bbox.y0 + menu->obj.dims.y;
 	menu->obj.flags |= SCENEOF_SIZE_VALID;
-- 
2.43.0

