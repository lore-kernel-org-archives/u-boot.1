Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9AAE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:34:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC5787455;
	Mon,  2 Oct 2023 03:18:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UIHVfkjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D590E8711F; Mon,  2 Oct 2023 03:18:19 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E298724F
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-79fe87cd74eso265624139f.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209385; x=1696814185; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fu0RN5KSJakvqZw6WdG2vVEajrsGWtzLYlJxUtCmxQ8=;
 b=UIHVfkjCxlQCgAm7GAC9BUyvAalAae/QaOkHBsqDwSDZQlzVgR7ysG5ompUJxShefW
 B1ZX3CwG82ngHjynaNtwPn+vGhBRO79/8DreIqmx5YsgdctO4j+a7ULl1tgu2MQYzNLH
 xMIPjdtfhC6BNGtWWgPVJM+3ei2Ht/VLEwPJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209385; x=1696814185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fu0RN5KSJakvqZw6WdG2vVEajrsGWtzLYlJxUtCmxQ8=;
 b=B6pg4B1EcR06abiuO0KLHKwrt0HuprHiJoCPHw2ZAlRdZQVYAyVx8T4EdAJxiPIyiQ
 CjaWjhP3Tmx87Huz2S5j5CiG2FyxHK0ly7JieTAmh0MIbFmMsjDD2AAYHbSWUfQVpeWG
 2DGAwKup/ol+JpLVKTSQkObsTFgmxI8drzdIxrOjm0sd7WfLFxAMQO7aI1YWPnzaBNXr
 E8ko7lma6w7V/MAztIzdYcyoK3I25cKI+cDZYiZvJCXsKCXbXBWOfLR0PAZyT6DIbB5L
 3b8qrg5UXP5IdFg0lksw6IeJrlnJbKS+FetL2WJYcSA62uQ+Dv1Qr2B8VZWVT6Kytx0o
 2ocw==
X-Gm-Message-State: AOJu0Yx0E/ofkRdn4qT7xwiEKMP87YpJoFdDgLtU9HLmKlzKWKGpR4Nc
 l/T0A46LJKExmSmMF1RmXdWNGjKistiQGTxFjBk=
X-Google-Smtp-Source: AGHT+IEqk2QP0AwPt1IaKAbuVZHY6a5YVciwjVcxZL/QDi/bjrsdsleSnL856i6wcPEilYm4jdgHfg==
X-Received: by 2002:a5d:87c1:0:b0:787:34d:f1ea with SMTP id
 q1-20020a5d87c1000000b00787034df1eamr11773094ios.8.1696209385264; 
 Sun, 01 Oct 2023 18:16:25 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 21/34] expo: Allow menu items to have values
Date: Sun,  1 Oct 2023 19:15:31 -0600
Message-ID: <20231002011553.463514-22-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

At present menu items are stored according to their sequence number in
the menu. In some cases we may want to have holes in that sequence, or
not use a sequence at all.

Add a new 'value' property for menu items. This will be used for
reading and writing, if present. If there is no 'value' property, then
the normal sequence number will be used instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/cedit.dtsi     |  3 +++
 boot/expo_build.c               | 16 ++++++++++++----
 boot/scene_internal.h           | 10 ++++++++++
 boot/scene_menu.c               | 17 +++++++++++++++++
 doc/develop/expo.rst            | 10 ++++++++++
 include/expo.h                  |  2 ++
 test/boot/expo.c                |  1 +
 test/boot/files/expo_layout.dts |  3 +++
 8 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/cedit.dtsi b/arch/sandbox/dts/cedit.dtsi
index 9bd84e629367..facd7a49befc 100644
--- a/arch/sandbox/dts/cedit.dtsi
+++ b/arch/sandbox/dts/cedit.dtsi
@@ -39,6 +39,9 @@
 				/* IDs for the menu items */
 				item-id = <ID_CPU_SPEED_1 ID_CPU_SPEED_2
 					ID_CPU_SPEED_3>;
+
+				/* values for the menu items */
+				item-value = <0 3 6>;
 			};
 
 			power-loss {
diff --git a/boot/expo_build.c b/boot/expo_build.c
index d66d619911df..24ec4fc542a7 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -228,10 +228,10 @@ static void list_strings(struct build_info *info)
 static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 		      uint id, struct scene_obj **objp)
 {
+	const u32 *item_ids, *item_values;
 	struct scene_obj_menu *menu;
+	int ret, size, i, num_items;
 	uint title_id, menu_id;
-	const u32 *item_ids;
-	int ret, size, i;
 	const char *name;
 
 	name = ofnode_get_name(node);
@@ -255,9 +255,15 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 		return log_msg_ret("itm", -EINVAL);
 	if (!size || size % sizeof(u32))
 		return log_msg_ret("isz", -EINVAL);
-	size /= sizeof(u32);
+	num_items = size / sizeof(u32);
 
-	for (i = 0; i < size; i++) {
+	item_values = ofnode_read_prop(node, "item-value", &size);
+	if (item_values) {
+		if (size != num_items * sizeof(u32))
+			return log_msg_ret("vsz", -EINVAL);
+	}
+
+	for (i = 0; i < num_items; i++) {
 		struct scene_menitem *item;
 		uint label, key, desc;
 
@@ -281,6 +287,8 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 				     desc, 0, 0, &item);
 		if (ret < 0)
 			return log_msg_ret("mi", ret);
+		if (item_values)
+			item->value = fdt32_to_cpu(item_values[i]);
 	}
 	*objp = &menu->obj;
 
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index be25f6a8b967..ec9008ea593b 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -281,6 +281,16 @@ struct scene_menitem *scene_menuitem_find(const struct scene_obj_menu *menu,
 struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
 					      uint seq);
 
+/**
+ * scene_menuitem_find_val() - Find the menu item with a given value
+ *
+ * @menu: Menu to check
+ * @find_val: Value to look for
+ * Return: menu item if found, else NULL
+ */
+struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
+					      int val);
+
 /**
  * scene_bbox_union() - update bouding box with the demensions of an object
  *
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index dbf6eacb2983..002821ec1f59 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -62,6 +62,22 @@ struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
 	return NULL;
 }
 
+struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
+					      int val)
+{
+	struct scene_menitem *item;
+	uint i;
+
+	i = 0;
+	list_for_each_entry(item, &menu->item_head, sibling) {
+		if (item->value == val)
+			return item;
+		i++;
+	}
+
+	return NULL;
+}
+
 /**
  * update_pointers() - Update the pointer object and handle highlights
  *
@@ -417,6 +433,7 @@ int scene_menuitem(struct scene *scn, uint menu_id, const char *name, uint id,
 	item->desc_id = desc_id;
 	item->preview_id = preview_id;
 	item->flags = flags;
+	item->value = INT_MAX;
 	list_add_tail(&item->sibling, &menu->item_head);
 
 	if (itemp)
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index d8115c463c1b..cc7c36173dbe 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -361,6 +361,13 @@ item-id
     Specifies the ID for each menu item. These are used for checking which item
     has been selected.
 
+item-value
+    type: u32 list, optional
+
+    Specifies the value for each menu item. These are used for saving and
+    loading. If this is omitted the value is its position in the menu (0..n-1).
+    Valid values are positive and negative integers INT_MIN...(INT_MAX - 1).
+
 item-label / item-label-id
     type: string list / u32 list, required
 
@@ -474,6 +481,9 @@ strings are provided inline in the nodes where they are used.
                     /* IDs for the menu items */
                     item-id = <ID_CPU_SPEED_1 ID_CPU_SPEED_2
                         ID_CPU_SPEED_3>;
+
+                    /* values for the menu items */
+                    item-value = <(-1) 3 6>;
                 };
 
                 power-loss {
diff --git a/include/expo.h b/include/expo.h
index 4198c96adaa6..bb329b9776dd 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -330,6 +330,7 @@ enum scene_menuitem_flags_t {
  * @desc_id: ID of text object to use as the description text
  * @preview_id: ID of the preview object, or 0 if none
  * @flags: Flags for this item
+ * @value: Value for this item, or INT_MAX to use sequence
  * @sibling: Node to link this item to its siblings
  */
 struct scene_menitem {
@@ -340,6 +341,7 @@ struct scene_menitem {
 	uint desc_id;
 	uint preview_id;
 	uint flags;
+	int value;
 	struct list_head sibling;
 };
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 2e8acac07313..75f31fe66907 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -719,6 +719,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	ut_asserteq(0, item->desc_id);
 	ut_asserteq(0, item->preview_id);
 	ut_asserteq(0, item->flags);
+	ut_asserteq(0, item->value);
 
 	txt = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 	ut_asserteq_str("2 GHz", expo_get_str(exp, txt->str_id));
diff --git a/test/boot/files/expo_layout.dts b/test/boot/files/expo_layout.dts
index bed552288f4c..ebe5adb27bbe 100644
--- a/test/boot/files/expo_layout.dts
+++ b/test/boot/files/expo_layout.dts
@@ -39,6 +39,9 @@
 				item-id = <ID_CPU_SPEED_1 ID_CPU_SPEED_2
 					ID_CPU_SPEED_3>;
 
+				/* values for the menu items */
+				item-value = <(-1) 3 6>;
+
 				start-bit = <0x400>;
 				bit-length = <2>;
 			};
-- 
2.42.0.582.g8ccd20d70d-goog

