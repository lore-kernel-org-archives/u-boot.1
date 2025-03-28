Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D8CC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D118210F;
	Fri, 28 Mar 2025 14:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IpDS4J7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58EB18205B; Fri, 28 Mar 2025 14:08:28 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426B08214A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b3f92c866so35173439f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167303; x=1743772103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xLo/vKhzhNH4wOn4GjqAuxblzPWz3WWtbJrEdAqd1Dc=;
 b=IpDS4J7ijyGerpeNIyAAi02W3qCShZqF02ig5YPFw/PvsedE3Dg5KHBixvkUKd5OUc
 P2Zw1NN9oSwxT+TqpU83EvD4yZjzVUKhbfCI1XAHIYsRiiBSR5rC5wUvv9TU7AIbJDRx
 f+HTCWnyBtuoKa40cVb8FiO1c5kAVqbS6+oGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167303; x=1743772103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLo/vKhzhNH4wOn4GjqAuxblzPWz3WWtbJrEdAqd1Dc=;
 b=a82+/GqJr69CViJ0wm5OfZHXiyaalQOOi8ci013bgdp6/1/x2jLZIEQGcN07pFdRwz
 MvuXW+G9T7slqAj7rKDaEz6J/kBAdHdGsjwFlw9F4H2CCaFR+LQ3YJVmjak3NGOs7y9H
 h6Gz+wH2GdT9flWzpvotDqr32x1IjLON70Hav6ZxgGMkVnu53cBTNrnekHH4pJsqu9Rd
 xXOP8MpTtdjKl0DmG35njksjIvzLcf5k9+vLkuEa6yQ6OuRhDiUhgimsJ6j/DNMGilXS
 8s7HBVqYrt+oFgFGrc6jSI32OGcR1KTm8rFhd5Qe3nf8OoLJTycZpgxxc7IJ8ByRmNws
 1Uow==
X-Gm-Message-State: AOJu0YxD/lA2HGNgmxlUNeqF4bS7Ft05zxuE6ephVvhGfujyQmsa6V+G
 jwJsHVXjGjuFurnwwHBPQQO9DAm6QzKHagk+oZC5lP+KQU1vZWo94J0anlb33tpulWDu5nQ5oPE
 =
X-Gm-Gg: ASbGncsqDOC57sfPyq6MCHJOPMEiWpc75/jZKRO8TP404gSDQD5Xq+7/c6AUMjJl32g
 VwSKXG66WTmu8WOGJtNrQ/onFoO8yKhY51FnDqrmPotfFRHMjen6HWE8VEUZzOimdg9JtXaSqXn
 JCw3Pq+HQgzii8N5GG3ScULE7VSuCp0cRzNmvYel3Bxm6EEr70U0OAbr2Pm2OmSBJ/awzw6tyA1
 LFIEQSyW3FOzFN64O3sPNC+Hz4VBmV/i7g6TT7k5udzOF4yI00RzCfuwVsohlANA014q9M9zH9V
 evgrHXpUxKjtTruFGXxoWXAF9S75lTs+yDr6KpEDjzs7Wfh0rTDx7tBsmE64j5dHHKxEB2cW3w+
 UYAwHYw==
X-Google-Smtp-Source: AGHT+IG/CRvD7kY9MuNmz775VPyakdDG87dvQqDjNvOyGNZ1Mdt06bKJWiccPmHserBaoTHIF3tGFg==
X-Received: by 2002:a05:6e02:174f:b0:3d3:dfc2:912c with SMTP id
 e9e14a558f8ab-3d5cce24896mr68740335ab.17.1743167303180; 
 Fri, 28 Mar 2025 06:08:23 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 35/56] expo: Create a struct for generic text attributes
Date: Fri, 28 Mar 2025 07:06:22 -0600
Message-ID: <20250328130713.2612648-36-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

In preparation for adding more text types, refactor the common fields
into a new structure. This will allow common code to be used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c          |  2 +-
 boot/scene.c          | 63 ++++++++++++++++++++++++++++---------------
 boot/scene_menu.c     | 12 ++++-----
 boot/scene_textline.c | 10 +++----
 include/expo.h        | 21 ++++++++++-----
 test/boot/bootflow.c  |  2 +-
 test/boot/cedit.c     |  2 +-
 test/boot/expo.c      | 15 ++++++-----
 8 files changed, 78 insertions(+), 49 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index eabbf07a8a0..83e50f98c93 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -268,7 +268,7 @@ static int get_cur_menuitem_text(const struct scene_obj_menu *menu,
 	if (!txt)
 		return log_msg_ret("txt", -ENOENT);
 
-	str = expo_get_str(scn->expo, txt->str_id);
+	str = expo_get_str(scn->expo, txt->gen.str_id);
 	if (!str)
 		return log_msg_ret("str", -ENOENT);
 	*strp = str;
diff --git a/boot/scene.c b/boot/scene.c
index dd48589f378..bf56f4341aa 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -143,6 +143,31 @@ int scene_img(struct scene *scn, const char *name, uint id, char *data,
 	return img->obj.id;
 }
 
+int scene_txt_generic_init(struct expo *exp, struct scene_txt_generic *gen,
+			   const char *name, uint str_id, const char *str)
+{
+	int ret;
+
+	if (str) {
+		ret = expo_str(exp, name, str_id, str);
+		if (ret < 0)
+			return log_msg_ret("str", ret);
+		if (str_id && ret != str_id)
+			return log_msg_ret("id", -EEXIST);
+		str_id = ret;
+	} else {
+		ret = resolve_id(exp, str_id);
+		if (ret < 0)
+			return log_msg_ret("nst", ret);
+		if (str_id && ret != str_id)
+			return log_msg_ret("nid", -EEXIST);
+	}
+
+	gen->str_id = str_id;
+
+	return 0;
+}
+
 int scene_txt(struct scene *scn, const char *name, uint id, uint str_id,
 	      struct scene_obj_txt **txtp)
 {
@@ -155,8 +180,8 @@ int scene_txt(struct scene *scn, const char *name, uint id, uint str_id,
 	if (ret < 0)
 		return log_msg_ret("obj", ret);
 
-	txt->str_id = str_id;
-
+	LOGR("stg", scene_txt_generic_init(scn->expo, &txt->gen, name, str_id,
+					   NULL));
 	if (txtp)
 		*txtp = txt;
 
@@ -169,21 +194,14 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 	struct scene_obj_txt *txt;
 	int ret;
 
-	ret = expo_str(scn->expo, name, str_id, str);
-	if (ret < 0)
-		return log_msg_ret("str", ret);
-	if (str_id && ret != str_id)
-		return log_msg_ret("id", -EEXIST);
-	str_id = ret;
-
 	ret = scene_obj_add(scn, name, id, SCENEOBJT_TEXT,
 			    sizeof(struct scene_obj_txt),
 			    (struct scene_obj **)&txt);
 	if (ret < 0)
 		return log_msg_ret("obj", ret);
 
-	txt->str_id = str_id;
-
+	LOGR("tsg", scene_txt_generic_init(scn->expo, &txt->gen, name, str_id,
+					   str));
 	if (txtp)
 		*txtp = txt;
 
@@ -198,8 +216,8 @@ int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 	txt = scene_obj_find(scn, id, SCENEOBJT_TEXT);
 	if (!txt)
 		return log_msg_ret("find", -ENOENT);
-	txt->font_name = font_name;
-	txt->font_size = font_size;
+	txt->gen.font_name = font_name;
+	txt->gen.font_size = font_size;
 
 	return 0;
 }
@@ -314,13 +332,13 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		return height;
 	}
 	case SCENEOBJT_TEXT: {
-		struct scene_obj_txt *txt = (struct scene_obj_txt *)obj;
+		struct scene_txt_generic *gen = &((struct scene_obj_txt *)obj)->gen;
 		struct expo *exp = scn->expo;
 		struct vidconsole_bbox bbox;
 		const char *str;
 		int len, ret;
 
-		str = expo_get_str(exp, txt->str_id);
+		str = expo_get_str(exp, gen->str_id);
 		if (!str)
 			return log_msg_ret("str", -ENOENT);
 		len = strlen(str);
@@ -332,8 +350,8 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 			return 16;
 		}
 
-		ret = vidconsole_measure(scn->expo->cons, txt->font_name,
-					 txt->font_size, str, -1, &bbox, NULL);
+		ret = vidconsole_measure(scn->expo->cons, gen->font_name,
+					 gen->font_size, str, -1, &bbox, NULL);
 		if (ret)
 			return log_msg_ret("mea", ret);
 		if (widthp)
@@ -425,22 +443,23 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 		break;
 	}
 	case SCENEOBJT_TEXT: {
-		struct scene_obj_txt *txt = (struct scene_obj_txt *)obj;
+		struct scene_txt_generic *gen =
+				&((struct scene_obj_txt *)obj)->gen;
 		const char *str;
 
 		if (!cons)
 			return -ENOTSUPP;
 
-		if (txt->font_name || txt->font_size) {
+		if (gen->font_name || gen->font_size) {
 			ret = vidconsole_select_font(cons,
-						     txt->font_name,
-						     txt->font_size);
+						     gen->font_name,
+						     gen->font_size);
 		} else {
 			ret = vidconsole_select_font(cons, NULL, 0);
 		}
 		if (ret && ret != -ENOSYS)
 			return log_msg_ret("font", ret);
-		str = expo_get_str(exp, txt->str_id);
+		str = expo_get_str(exp, gen->str_id);
 		if (str) {
 			struct video_priv *vid_priv;
 			struct vidconsole_colour old;
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 914f109fa35..b0c241a9ee9 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -352,7 +352,7 @@ static struct scene_menitem *scene_menu_find_key(struct scene *scn,
 
 			txt = scene_obj_find(scn, item->key_id, SCENEOBJT_TEXT);
 			if (txt) {
-				str = expo_get_str(scn->expo, txt->str_id);
+				str = expo_get_str(scn->expo, txt->gen.str_id);
 				if (str && *str == key)
 					return item;
 			}
@@ -552,7 +552,7 @@ int scene_menu_display(struct scene_obj_menu *menu)
 		if (!txt)
 			return log_msg_ret("txt", -EINVAL);
 
-		str = expo_get_str(exp, txt->str_id);
+		str = expo_get_str(exp, txt->gen.str_id);
 		printf("%s\n\n", str);
 	}
 
@@ -560,7 +560,7 @@ int scene_menu_display(struct scene_obj_menu *menu)
 		return 0;
 
 	pointer = scene_obj_find(scn, menu->pointer_id, SCENEOBJT_TEXT);
-	pstr = expo_get_str(scn->expo, pointer->str_id);
+	pstr = expo_get_str(scn->expo, pointer->gen.str_id);
 
 	list_for_each_entry(item, &menu->item_head, sibling) {
 		struct scene_obj_txt *key = NULL, *label = NULL;
@@ -569,15 +569,15 @@ int scene_menu_display(struct scene_obj_menu *menu)
 
 		key = scene_obj_find(scn, item->key_id, SCENEOBJT_TEXT);
 		if (key)
-			kstr = expo_get_str(exp, key->str_id);
+			kstr = expo_get_str(exp, key->gen.str_id);
 
 		label = scene_obj_find(scn, item->label_id, SCENEOBJT_TEXT);
 		if (label)
-			lstr = expo_get_str(exp, label->str_id);
+			lstr = expo_get_str(exp, label->gen.str_id);
 
 		desc = scene_obj_find(scn, item->desc_id, SCENEOBJT_TEXT);
 		if (desc)
-			dstr = expo_get_str(exp, desc->str_id);
+			dstr = expo_get_str(exp, desc->gen.str_id);
 
 		printf("%3s  %3s  %-10s  %s\n",
 		       pointer && menu->cur_item_id == item->id ? pstr : "",
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 0bf54b2108b..fc9e5e426d0 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -72,8 +72,8 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 	if (!txt)
 		return log_msg_ret("dim", -ENOENT);
 
-	ret = vidconsole_nominal(scn->expo->cons, txt->font_name,
-				 txt->font_size, tline->max_chars, &bbox);
+	ret = vidconsole_nominal(scn->expo->cons, txt->gen.font_name,
+				 txt->gen.font_size, tline->max_chars, &bbox);
 	if (ret)
 		return log_msg_ret("nom", ret);
 
@@ -192,10 +192,10 @@ int scene_textline_render_deps(struct scene *scn,
 		if (!txt)
 			return log_msg_ret("cur", -ENOENT);
 
-		if (txt->font_name || txt->font_size) {
+		if (txt->gen.font_name || txt->gen.font_size) {
 			ret = vidconsole_select_font(cons,
-						     txt->font_name,
-						     txt->font_size);
+						     txt->gen.font_name,
+						     txt->gen.font_size);
 		} else {
 			ret = vidconsole_select_font(cons, NULL, 0);
 		}
diff --git a/include/expo.h b/include/expo.h
index 990cb3094ee..32d69f269a7 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -291,22 +291,31 @@ struct scene_obj_img {
 };
 
 /**
- * struct scene_obj_txt - information about a text object in a scene
- *
- * This is a single-line text object
+ * struct scene_txt_generic - Generic information common to text objects
  *
- * @obj: Basic object information
  * @str_id: ID of the text string to display
  * @font_name: Name of font (allocated by caller)
  * @font_size: Nominal size of font in pixels
  */
-struct scene_obj_txt {
-	struct scene_obj obj;
+struct scene_txt_generic {
 	uint str_id;
 	const char *font_name;
 	uint font_size;
 };
 
+/**
+ * struct scene_obj_txt - information about a text object in a scene
+ *
+ * This is a single-line text object
+ *
+ * @obj: Basic object information
+ * @gen: Generic information common to all objects which show text
+ */
+struct scene_obj_txt {
+	struct scene_obj obj;
+	struct scene_txt_generic gen;
+};
+
 /**
  * struct scene_obj_menu - information about a menu object in a scene
  *
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 572851761c5..72fb0644ee8 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -861,7 +861,7 @@ static int check_font(struct unit_test_state *uts, struct scene *scn, uint id,
 	txt = scene_obj_find(scn, id, SCENEOBJT_TEXT);
 	ut_assertnonnull(txt);
 
-	ut_asserteq(font_size, txt->font_size);
+	ut_asserteq(font_size, txt->gen.font_size);
 
 	return 0;
 }
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 0c34d4b3df0..dbf781902fb 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -48,7 +48,7 @@ static int cedit_base(struct unit_test_state *uts)
 
 	txt = scene_obj_find(scn, menu->title_id, SCENEOBJT_NONE);
 	ut_assertnonnull(txt);
-	ut_asserteq_str("AC Power", expo_get_str(exp, txt->str_id));
+	ut_asserteq_str("AC Power", expo_get_str(exp, txt->gen.str_id));
 
 	ut_asserteq(ID_AC_ON, menu->cur_item_id);
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 70db33d48b1..96c5943f394 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -280,8 +280,8 @@ static int expo_object_attr(struct unit_test_state *uts)
 
 	strcpy(name, "font2");
 	ut_assertok(scene_txt_set_font(scn, OBJ_TEXT, name, 42));
-	ut_asserteq_ptr(name, txt->font_name);
-	ut_asserteq(42, txt->font_size);
+	ut_asserteq_ptr(name, txt->gen.font_name);
+	ut_asserteq(42, txt->gen.font_size);
 
 	ut_asserteq(-ENOENT, scene_txt_set_font(scn, OBJ_TEXT2, name, 42));
 
@@ -296,7 +296,7 @@ static int expo_object_attr(struct unit_test_state *uts)
 	node = ofnode_path("/bootstd/theme");
 	ut_assert(ofnode_valid(node));
 	ut_assertok(expo_apply_theme(exp, node));
-	ut_asserteq(30, txt->font_size);
+	ut_asserteq(30, txt->gen.font_size);
 
 	expo_destroy(exp);
 
@@ -727,7 +727,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	ut_assertnonnull(scn);
 	ut_asserteq_str("main", scn->name);
 	ut_asserteq(ID_SCENE1, scn->id);
-	ut_asserteq(ID_DYNAMIC_START + 1, scn->title_id);
+	ut_asserteq(ID_DYNAMIC_START, scn->title_id);
 	ut_asserteq(0, scn->highlight_id);
 
 	/* check the title */
@@ -739,7 +739,8 @@ static int expo_test_build(struct unit_test_state *uts)
 	ut_asserteq(scn->title_id, obj->id);
 	ut_asserteq(SCENEOBJT_TEXT, obj->type);
 	ut_asserteq(0, obj->flags);
-	ut_asserteq_str("Test Configuration", expo_get_str(exp, txt->str_id));
+	ut_asserteq_str("Test Configuration",
+			expo_get_str(exp, txt->gen.str_id));
 
 	/* check the menu */
 	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_NONE);
@@ -751,7 +752,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	ut_asserteq(0, obj->flags);
 
 	txt = scene_obj_find(scn, menu->title_id, SCENEOBJT_NONE);
-	ut_asserteq_str("CPU speed", expo_get_str(exp, txt->str_id));
+	ut_asserteq_str("CPU speed", expo_get_str(exp, txt->gen.str_id));
 
 	ut_asserteq(0, menu->cur_item_id);
 	ut_asserteq(0, menu->pointer_id);
@@ -768,7 +769,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	ut_asserteq(0, item->value);
 
 	txt = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
-	ut_asserteq_str("2 GHz", expo_get_str(exp, txt->str_id));
+	ut_asserteq_str("2 GHz", expo_get_str(exp, txt->gen.str_id));
 
 	count = list_count_nodes(&menu->item_head);
 	ut_asserteq(3, count);
-- 
2.43.0

