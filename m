Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B94E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E874A871AB;
	Mon,  2 Oct 2023 03:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LNnDY3DC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3727870FF; Mon,  2 Oct 2023 03:14:59 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D732187124
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3513fa06bafso39323585ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209258; x=1696814058; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+H1F+VvjYK6GHbXPvFmYpqGXQkJRO8qv6qZlaICxpgM=;
 b=LNnDY3DCE6wbUBRwmv4ATk8wCy9jdbXFVgeOQB+We+BLE3E1IA/bGl2OJMuxA5melq
 a3kWPo6Qfj7hQhjoF/TM89WW4FIJkFLJITAn7ER8v53yhPXWEjouvOhodS8JSwZVByB/
 4RBztwhd7iZozZVFJ7XnYE8A3tVly07SebQpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209258; x=1696814058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+H1F+VvjYK6GHbXPvFmYpqGXQkJRO8qv6qZlaICxpgM=;
 b=tSylh4P2PaU9hbBI0X9oh/gKOAnk7iB63C8PdHGHF4V1B0veD9zYQndGexYyaBj7Su
 DaSWicTfwOw/aOP/A4nbV17l2k9k8hrIBwEvwn1uSOx4+i5YRZs1HhN0otwPrnORd6tk
 R2sEmN1Pd5lbx6+y46S8Hvd0msbhry/uQYQpzfAKHE7HobBEtZ85q1Rv4xZZDFmiaV2z
 9Nl03iVOKM9w0wNkeAaIt295bWwV2lQuQyQYsA9m1bG2tWuLuTN51GNqrlJCAYdvsZ9A
 HmQk46kt0+10vGoGtf5/5vXO+JRz687+GnJXfAZ5ZBAdpo4VsFoun3SvNTtHGy8opReH
 cSzw==
X-Gm-Message-State: AOJu0Yxxcww/kd5U3LJchfbhgDHu9miwuB8zQXyoNQhYOcXGxCIPT66T
 FXS3ICDfnqALzWI3K9s9FR59nBEBdPfh9nuWcjI=
X-Google-Smtp-Source: AGHT+IEz2UCNV2oVMUCq33qII5rsiExuPXX47OFOhDnE6u1dJcwefbH/g/zirTTbMFUhMBqb8kJ0TQ==
X-Received: by 2002:a05:6e02:12e3:b0:351:4bf9:5b02 with SMTP id
 l3-20020a056e0212e300b003514bf95b02mr13445100iln.7.1696209258425; 
 Sun, 01 Oct 2023 18:14:18 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 30/36] expo: Plumb in textlines to a scene
Date: Sun,  1 Oct 2023 19:13:34 -0600
Message-ID: <20231002011349.461284-31-sjg@chromium.org>
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

Provide an implementation for textlines in the scene code, so that they
are displayed correctly. Provide a way to have a border around the
textline, with the internal part being the same colour as the
background. This looks more natural.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c          | 56 +++++++++++++++++++++++++++++++++++++++--
 boot/scene_internal.h | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 6c7c926f7c93..d4dfb49ada15 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -280,6 +280,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_MENU:
+	case SCENEOBJT_TEXTLINE:
 		break;
 	case SCENEOBJT_IMAGE: {
 		struct scene_obj_img *img = (struct scene_obj_img *)obj;
@@ -328,8 +329,10 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
  * scene_render_background() - Render the background for an object
  *
  * @obj: Object to render
+ * @box_only: true to show a box around the object, but keep the normal
+ * background colour inside
  */
-static void scene_render_background(struct scene_obj *obj)
+static void scene_render_background(struct scene_obj *obj, bool box_only)
 {
 	struct expo *exp = obj->scene->expo;
 	const struct expo_theme *theme = &exp->theme;
@@ -360,6 +363,11 @@ static void scene_render_background(struct scene_obj *obj)
 			label_bbox.x1 + inset, label_bbox.y1 + inset,
 			vid_priv->colour_fg);
 	vidconsole_pop_colour(cons, &old);
+	if (box_only) {
+		video_fill_part(dev, label_bbox.x0, label_bbox.y0,
+				label_bbox.x1, label_bbox.y1,
+				vid_priv->colour_bg);
+	}
 }
 
 /**
@@ -445,7 +453,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 				return -ENOTSUPP;
 
 			/* draw a background behind the menu items */
-			scene_render_background(obj);
+			scene_render_background(obj, false);
 		}
 		/*
 		 * With a vidconsole, the text and item pointer are rendered as
@@ -461,6 +469,10 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 
 		break;
 	}
+	case SCENEOBJT_TEXTLINE:
+		if (obj->flags & SCENEOF_OPEN)
+			scene_render_background(obj, true);
+		break;
 	}
 
 	return 0;
@@ -486,6 +498,15 @@ int scene_arrange(struct scene *scn)
 				return log_msg_ret("arr", ret);
 			break;
 		}
+		case SCENEOBJT_TEXTLINE: {
+			struct scene_obj_textline *tline;
+
+			tline = (struct scene_obj_textline *)obj,
+			ret = scene_textline_arrange(scn, tline);
+			if (ret)
+				return log_msg_ret("arr", ret);
+			break;
+		}
 		}
 	}
 
@@ -517,6 +538,10 @@ int scene_render_deps(struct scene *scn, uint id)
 			scene_menu_render_deps(scn,
 					       (struct scene_obj_menu *)obj);
 			break;
+		case SCENEOBJT_TEXTLINE:
+			scene_textline_render_deps(scn,
+					(struct scene_obj_textline *)obj);
+			break;
 		}
 	}
 
@@ -637,6 +662,15 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 				return log_msg_ret("key", ret);
 			break;
 		}
+		case SCENEOBJT_TEXTLINE: {
+			struct scene_obj_textline *tline;
+
+			tline = (struct scene_obj_textline *)obj,
+			ret = scene_textline_send_key(scn, tline, key, event);
+			if (ret)
+				return log_msg_ret("key", ret);
+			break;
+		}
 		}
 		return 0;
 	}
@@ -670,6 +704,13 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
 		scene_menu_calc_bbox(menu, bbox, label_bbox);
 		break;
 	}
+	case SCENEOBJT_TEXTLINE: {
+		struct scene_obj_textline *tline;
+
+		tline = (struct scene_obj_textline *)obj;
+		scene_textline_calc_bbox(tline, bbox, label_bbox);
+		break;
+	}
 	}
 
 	return 0;
@@ -708,6 +749,16 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 			}
 			break;
 		}
+		case SCENEOBJT_TEXTLINE: {
+			struct scene_obj_textline *tline;
+
+			tline = (struct scene_obj_textline *)obj;
+			ret = scene_textline_calc_dims(tline);
+			if (ret)
+				return log_msg_ret("men", ret);
+
+			break;
+		}
 		}
 	}
 
@@ -727,6 +778,7 @@ int scene_apply_theme(struct scene *scn, struct expo_theme *theme)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_MENU:
+		case SCENEOBJT_TEXTLINE:
 			break;
 		case SCENEOBJT_TEXT:
 			scene_txt_set_font(scn, obj->id, NULL,
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 7a84977646a0..e72202c98213 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -101,6 +101,18 @@ int scene_calc_dims(struct scene *scn, bool do_menus);
  */
 int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu);
 
+/**
+ * scene_textline_arrange() - Set the position of things in a textline
+ *
+ * This updates any items associated with a textline to make sure they are
+ * positioned correctly relative to the textline.
+ *
+ * @scn: Scene to update
+ * @tline: textline to process
+ * Returns: 0 if OK, -ve on error
+ */
+int scene_textline_arrange(struct scene *scn, struct scene_obj_textline *tline);
+
 /**
  * scene_apply_theme() - Apply a theme to a scene
  *
@@ -123,6 +135,18 @@ int scene_apply_theme(struct scene *scn, struct expo_theme *theme);
 int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 			struct expo_action *event);
 
+/**
+ * scene_textline_send_key() - Send a key to a textline for processing
+ *
+ * @scn: Scene to use
+ * @tline: textline to use
+ * @key: Key code to send (KEY_...)
+ * @event: Place to put any event which is generated by the key
+ * Returns: 0 if OK (always)
+ */
+int scene_textline_send_key(struct scene *scn, struct scene_obj_textline *tline,
+			    int key, struct expo_action *event);
+
 /**
  * scene_menu_destroy() - Destroy a menu in a scene
  *
@@ -185,6 +209,18 @@ int scene_render_deps(struct scene *scn, uint id);
  */
 int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu);
 
+/**
+ * scene_textline_render_deps() - Render a textline and its dependencies
+ *
+ * Renders the textline and all of its attached objects
+ *
+ * @scn: Scene to render
+ * @tline: textline to render
+ * Returns: 0 if OK, -ve on error
+ */
+int scene_textline_render_deps(struct scene *scn,
+			       struct scene_obj_textline *tline);
+
 /**
  * scene_menu_calc_dims() - Calculate the dimensions of a menu
  *
@@ -255,6 +291,16 @@ struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
 int scene_bbox_union(struct scene *scn, uint id, int inset,
 		     struct vidconsole_bbox *bbox);
 
+/**
+ * scene_textline_calc_dims() - Calculate the dimensions of a textline
+ *
+ * Updates the width and height of the textline based on its contents
+ *
+ * @tline: Textline to update
+ * Returns 0 if OK, -ENOTSUPP if there is no graphical console
+ */
+int scene_textline_calc_dims(struct scene_obj_textline *tline);
+
 /**
  * scene_menu_calc_bbox() - Calculate bounding boxes for the menu
  *
@@ -267,6 +313,18 @@ void scene_menu_calc_bbox(struct scene_obj_menu *menu,
 			  struct vidconsole_bbox *bbox,
 			  struct vidconsole_bbox *label_bbox);
 
+/**
+ * scene_textline_calc_bbox() - Calculate bounding box for the textline
+ *
+ * @textline: Menu to process
+ * @bbox: Returns bounding box of textline including prompt
+ * @edit_bbox: Returns bounding box of editable part
+ * Return: 0 if OK, -ve on error
+ */
+void scene_textline_calc_bbox(struct scene_obj_textline *menu,
+			      struct vidconsole_bbox *bbox,
+			      struct vidconsole_bbox *label_bbox);
+
 /**
  * scene_obj_calc_bbox() - Calculate bounding boxes for an object
  *
-- 
2.42.0.582.g8ccd20d70d-goog

