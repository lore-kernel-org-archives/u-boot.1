Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8972BD18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4278921F;
	Tue, 15 Oct 2024 00:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XFbt3UTm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 212AB89248; Tue, 15 Oct 2024 00:32:26 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 172B189231
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-8354845c5dcso204370439f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945141; x=1729549941; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XqAl579Sb/B5OROKNKli/gMiX2fZ4RdkqUkbYq8D8Ok=;
 b=XFbt3UTmmrxwDqHna5qUJ2J5QT1nc6V4OsBf8mTAzgDNWN72PXgvRrAZUwr55d4aAr
 tkhWCySZqBlGRR9W7Te2OItFRnDdiiYV+7E42tamFAo9dFP9mKmjhyYQtt18w13EfUDK
 FXgiWbeYd6s8hzTpuFeGV25UEydBFQSe+zOP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945141; x=1729549941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XqAl579Sb/B5OROKNKli/gMiX2fZ4RdkqUkbYq8D8Ok=;
 b=VK1be4ZujCxAmcO1IVqrrJlScZO2x3+J2Q4mX6afJdsabCssnD195NfH6qWNRCluwY
 oDw4qMShRK8Lb0Vi+hdAhquRlsLmCrYQveRfqpEhfe0YucWfOLqb1VDNhetFuDRshOdn
 s096VS8yl8m5ztDmHN6lP3bVpjpAYW+rILRRWMCcm/1S80dRXzQwkeCaBSrf3tWfzuiN
 r2FKmUB6xmbYv4y6UPDqX4OiWMsJbTAQ3EYWr1PHblM3U5qUDVEh5z31nNhpLNL1R9cS
 r1qrrfSmUFPGYQ4nEgnWDkNuGifi7B8uzcw49qQYEkTpjUy0dWBe9Cug28BLRZaxlPKA
 0rrA==
X-Gm-Message-State: AOJu0YwFlKVJYAwiTRSjxu4w1YSHnPZuzXfS6yrmM0Pee+ZW4IiwIeN7
 QI5uKmkpsnfchN/+2qqhM2XFNEGYoB0GU9/iPwjCWknSVh78w4RUOc9Gih5UY/HRLdMaQ+FCOts
 8OQ==
X-Google-Smtp-Source: AGHT+IGaAX4WUHR8wIxl80P/7HRnRZPc3LO3Z9zhlYCOmR33wxhOt8aa1vD7sQYoFXoPUXSSBw3Crw==
X-Received: by 2002:a05:6e02:13a8:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a3b5c71f26mr118441415ab.0.1728945141565; 
 Mon, 14 Oct 2024 15:32:21 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 06/20] expo: Allow menu items to have values
Date: Mon, 14 Oct 2024 16:31:58 -0600
Message-Id: <20241014223212.2212442-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

(no changes since v1)

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
index 9bd84e62936..facd7a49bef 100644
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
index a4df798adeb..fece3ea67f9 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -227,10 +227,10 @@ static void list_strings(struct build_info *info)
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
@@ -254,9 +254,15 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
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
 
@@ -280,6 +286,8 @@ static int menu_build(struct build_info *info, ofnode node, struct scene *scn,
 				     desc, 0, 0, &item);
 		if (ret < 0)
 			return log_msg_ret("mi", ret);
+		if (item_values)
+			item->value = fdt32_to_cpu(item_values[i]);
 	}
 	*objp = &menu->obj;
 
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index be25f6a8b96..ec9008ea593 100644
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
index c331f6670cc..04ff1590bc1 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -61,6 +61,22 @@ struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
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
@@ -416,6 +432,7 @@ int scene_menuitem(struct scene *scn, uint menu_id, const char *name, uint id,
 	item->desc_id = desc_id;
 	item->preview_id = preview_id;
 	item->flags = flags;
+	item->value = INT_MAX;
 	list_add_tail(&item->sibling, &menu->item_head);
 
 	if (itemp)
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index d8115c463c1..cc7c36173db 100644
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
index d6e2ccee41b..acff98ea65b 100644
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
index b0bf2988bf0..1c2e746decc 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -717,6 +717,7 @@ static int expo_test_build(struct unit_test_state *uts)
 	ut_asserteq(0, item->desc_id);
 	ut_asserteq(0, item->preview_id);
 	ut_asserteq(0, item->flags);
+	ut_asserteq(0, item->value);
 
 	txt = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 	ut_asserteq_str("2 GHz", expo_get_str(exp, txt->str_id));
diff --git a/test/boot/files/expo_layout.dts b/test/boot/files/expo_layout.dts
index bed552288f4..ebe5adb27bb 100644
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
2.34.1

