Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8E1CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 667F586C6B;
	Tue, 19 Sep 2023 20:09:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YL8fJqLH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6A2E86C21; Tue, 19 Sep 2023 20:09:54 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A675A86C4A
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34fe5d0f0ffso8346915ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146991; x=1695751791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEfyZ+7n8FUY221HPWIO+NiUhNbzOOzn67F4uCCwLCg=;
 b=YL8fJqLHx3E4v0ZGaS48iKdsfQZtepAFClv5H8hIXwndgDfCDDtCy+KY2Ajycr9Rb5
 WDP41ujj2+4Zca7rR59gEAVvDChjd8Shqza0ATEAqSPWceT61fUzCmSKXFRn8Yf/ztd5
 pQx/X5gX32QH4Wy7LkhejxH1+Ve7K7tjEXQNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146991; x=1695751791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rEfyZ+7n8FUY221HPWIO+NiUhNbzOOzn67F4uCCwLCg=;
 b=ASsOwdzQ+sBBllilkaReDqgRZxEdu/Cq3w/4787kDHK9rngZVs1AfRTn7vOgPnePyx
 dMVu2gUJ6FAIgkqBo7QIKdEwV/XUG4H0VfIdzG79sZq8ZNT/wuJjdv8bgeO5G/jdHsVc
 2mX3N/+Uk4L09DePqeP3CGk/k7j02EUBXusgYbiasY5qqOQsI1WkXxBMbQZIdiwEFWwq
 nQ83sJdiR68Y1NYzpG+oc8GIshg1fqiPNVaVmpXF5Iwwx0NxloHkPZdHht1FYFkEKyWo
 Nxaw8OsMZ5nVx+YTFs0HZh93jay3B650Lm3PdYnTZm1IYxTc5eoPezwsIr22EUlhsZHy
 5eOA==
X-Gm-Message-State: AOJu0YzXhTTrhnJ687y6X/JqwvcYNgNtk8oyIo12Q37LrzPKzovDKFt/
 edXVmZ6iKeUtAgKe58NN5vHnvKdnDveDT0j6peU=
X-Google-Smtp-Source: AGHT+IHmUv9zM7HKrrwl5wfhL3kYzFF3yuXxEsOXHjrqL/7Gp1cxWFFSwBjRNVeOiwAi9Bdfsdvs+w==
X-Received: by 2002:a05:6e02:b22:b0:34f:9f86:dd45 with SMTP id
 e2-20020a056e020b2200b0034f9f86dd45mr729187ilu.3.1695146991292; 
 Tue, 19 Sep 2023 11:09:51 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 30/36] expo: Plumb in textlines to a scene
Date: Tue, 19 Sep 2023 12:09:00 -0600
Message-ID: <20230919180918.2904313-31-sjg@chromium.org>
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

Provide an implementation for textlines in the scene code, so that they
are displayed correctly. Provide a way to have a border around the
textline, with the internal part being the same colour as the
background. This looks more natural.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 56 +++++++++++++++++++++++++++++++++++++++--
 boot/scene_internal.h | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 6c7c926f7c9..d4dfb49ada1 100644
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
index 7a84977646a..e72202c9821 100644
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
2.42.0.459.ge4e396fd5e-goog

