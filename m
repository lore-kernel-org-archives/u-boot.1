Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F3CD18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C8E989285;
	Tue, 15 Oct 2024 00:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZvIJXtx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4076589235; Tue, 15 Oct 2024 00:32:28 +0200 (CEST)
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com
 [IPv6:2607:f8b0:4864:20::d43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1868922C
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd43.google.com with SMTP id
 ca18e2360f4ac-8354851fcabso196684639f.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945143; x=1729549943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+dDkCRanyP1MT1+/9Uck799Jqf/n5Mr5ow7egTo2mQ=;
 b=ZvIJXtx2L/9aaAWOLzHxsSDYTZRM2Zd60WpauFr8DcYgPI6AO//z85/te6ThlGWe66
 nrdgEzRZOq2xIyfJH5R9lHwKCv4XIfYUTo0SoiefgklLNzPcNBWMWPID9liJ4yhah76z
 HhEeaN3amiu2rahiyna3Nqs19+akJXWbH5bvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945143; x=1729549943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a+dDkCRanyP1MT1+/9Uck799Jqf/n5Mr5ow7egTo2mQ=;
 b=eWdlMxT/WBjKwfcCagtWYV/ulXrzeb+Rfnle7EGZPONeDtG/amxCREqT7MMoMZbNQH
 wHhKrrTYzDldAMBv2//9HbkoLehlRevoBso/MLmyic1B4k8aYyYsG2W5EHkWGq5M5GiU
 ue1LrZHJdgHLi/K6wSHhj65/lpHfZqdRcTSM9SZDksp066J0MmAtWujPt8eJ0wVNvBxd
 35C0kS6+Ea5FKCDE+qh99YouwBB03s8DWzLfeNrSmWb5ba5DrA84+xJoOO01vuclg0EO
 TjOHeLk4WAG7MT7a7S9diZo6RBMx005QeN6hLqhr4XaBjAEd1LLw9V/oAA73i8Z21tqO
 f8tg==
X-Gm-Message-State: AOJu0Yx8kzotimk5dS2mzogFWZ6ThBAGln9wQJcbQjTDc7q4goEyGXcT
 qt73YuT0LZzTlXRukeKSV5pCofu9af4R1qXEcfdO596XP7O5/25Y4BFwy+VQi/x7kb66L6/7i+K
 PdpQh
X-Google-Smtp-Source: AGHT+IEz1quTEVNJJe6qi4ShgiFddgu+0CY9ZlkynnlSKWlR8J+QX4N4/TxbS0B8yx5ckjKKodykLA==
X-Received: by 2002:a05:6e02:1c4c:b0:3a0:933a:2a0a with SMTP id
 e9e14a558f8ab-3a3b5f44f8amr117218665ab.7.1728945143394; 
 Mon, 14 Oct 2024 15:32:23 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 08/20] expo: Support menu-item values in cedit
Date: Mon, 14 Oct 2024 16:32:00 -0600
Message-Id: <20241014223212.2212442-9-sjg@chromium.org>
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

Update the cedit read/write functions to support menu items with
values.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c                    | 148 +++++++++++++++++++++-----------
 boot/scene_menu.c               |   2 +-
 doc/usage/cmd/cedit.rst         |  15 +++-
 test/boot/cedit.c               |   8 +-
 test/boot/files/expo_layout.dts |   4 +-
 5 files changed, 117 insertions(+), 60 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 9d48d3ed50b..d12892fbc4a 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -293,11 +293,49 @@ static int get_cur_menuitem_text(const struct scene_obj_menu *menu,
 	return 0;
 }
 
+/**
+ * get_cur_menuitem_val() - Get the value of a menu's current item
+ *
+ * Obtains the value of the current item in the menu. If no value, then
+ * enumerates the items of a menu (0, 1, 2) and returns the sequence number of
+ * the currently selected item. If the first item is selected, this returns 0;
+ * if the second, 1; etc.
+ *
+ * @menu: Menu to check
+ * @valp: Returns current-item value / sequence number
+ * Return: 0 on success, else -ve error value
+ */
+static int get_cur_menuitem_val(const struct scene_obj_menu *menu, int *valp)
+{
+	const struct scene_menitem *mi;
+	int seq;
+
+	seq = 0;
+	list_for_each_entry(mi, &menu->item_head, sibling) {
+		if (mi->id == menu->cur_item_id) {
+			*valp = mi->value == INT_MAX ? seq : mi->value;
+			return 0;
+		}
+		seq++;
+	}
+
+	return log_msg_ret("nf", -ENOENT);
+}
+
+/**
+ * write_dt_string() - Write a string to the devicetree, expanding if needed
+ *
+ * If this fails, it tries again after expanding the devicetree a little
+ *
+ * @buf: Buffer containing the devicetree
+ * @name: Property name to use
+ * @str: String value
+ * Return: 0 if OK, -EFAULT if something went horribly wrong
+ */
 static int write_dt_string(struct abuf *buf, const char *name, const char *str)
 {
 	int ret, i;
 
-	/* write the text of the current item */
 	ret = -EAGAIN;
 	for (i = 0; ret && i < 2; i++) {
 		ret = fdt_property_string(abuf_data(buf), name, str);
@@ -315,6 +353,38 @@ static int write_dt_string(struct abuf *buf, const char *name, const char *str)
 	return 0;
 }
 
+/**
+ * write_dt_u32() - Write an int to the devicetree, expanding if needed
+ *
+ * If this fails, it tries again after expanding the devicetree a little
+ *
+ * @buf: Buffer containing the devicetree
+ * @name: Property name to use
+ * @lva: Integer value
+ * Return: 0 if OK, -EFAULT if something went horribly wrong
+ */
+static int write_dt_u32(struct abuf *buf, const char *name, uint val)
+{
+	int ret, i;
+
+	/* write the text of the current item */
+	ret = -EAGAIN;
+	for (i = 0; ret && i < 2; i++) {
+		ret = fdt_property_u32(abuf_data(buf), name, val);
+		if (!i) {
+			ret = check_space(ret, buf);
+			if (ret)
+				return log_msg_ret("rs2", -ENOMEM);
+		}
+	}
+
+	/* this should not happen */
+	if (ret)
+		return log_msg_ret("str", -EFAULT);
+
+	return 0;
+}
+
 static int h_write_settings(struct scene_obj *obj, void *vpriv)
 {
 	struct cedit_iter_priv *priv = vpriv;
@@ -339,23 +409,21 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 		const struct scene_obj_menu *menu;
 		const char *str;
 		char name[80];
-		int i;
+		int val;
 
 		/* write the ID of the current item */
 		menu = (struct scene_obj_menu *)obj;
-		ret = -EAGAIN;
-		for (i = 0; ret && i < 2; i++) {
-			ret = fdt_property_u32(abuf_data(buf), obj->name,
-					       menu->cur_item_id);
-			if (!i) {
-				ret = check_space(ret, buf);
-				if (ret)
-					return log_msg_ret("res", -ENOMEM);
-			}
-		}
-		/* this should not happen */
+		ret = write_dt_u32(buf, obj->name, menu->cur_item_id);
 		if (ret)
-			return log_msg_ret("wrt", -EFAULT);
+			return log_msg_ret("wrt", ret);
+
+		snprintf(name, sizeof(name), "%s-value", obj->name);
+		ret = get_cur_menuitem_val(menu, &val);
+		if (ret < 0)
+			return log_msg_ret("cur", ret);
+		ret = write_dt_u32(buf, name, val);
+		if (ret)
+			return log_msg_ret("wr2", ret);
 
 		ret = get_cur_menuitem_text(menu, &str);
 		if (ret)
@@ -521,6 +589,14 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 		ret = env_set(name, str);
 		if (ret)
 			return log_msg_ret("st2", ret);
+
+		ret = get_cur_menuitem_val(menu, &val);
+		if (ret < 0)
+			return log_msg_ret("cur", ret);
+		snprintf(name, sizeof(name), "c.%s-value", obj->name);
+		if (priv->verbose)
+			printf("%s=%d\n", name, val);
+
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -624,43 +700,12 @@ int cedit_read_settings_env(struct expo *exp, bool verbose)
 	return 0;
 }
 
-/**
- * get_cur_menuitem_seq() - Get the sequence number of a menu's current item
- *
- * Enumerates the items of a menu (0, 1, 2) and returns the sequence number of
- * the currently selected item. If the first item is selected, this returns 0;
- * if the second, 1; etc.
- *
- * @menu: Menu to check
- * Return: Sequence number on success, else -ve error value
- */
-static int get_cur_menuitem_seq(const struct scene_obj_menu *menu)
-{
-	const struct scene_menitem *mi;
-	int seq, found;
-
-	seq = 0;
-	found = -1;
-	list_for_each_entry(mi, &menu->item_head, sibling) {
-		if (mi->id == menu->cur_item_id) {
-			found = seq;
-			break;
-		}
-		seq++;
-	}
-
-	if (found == -1)
-		return log_msg_ret("nf", -ENOENT);
-
-	return found;
-}
-
 static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
 {
 	const struct scene_obj_menu *menu;
 	struct cedit_iter_priv *priv = vpriv;
 	int val, ret;
-	uint i, seq;
+	uint i;
 
 	if (obj->type != SCENEOBJT_MENU || obj->id < EXPOID_BASE_ID)
 		return 0;
@@ -668,11 +713,10 @@ static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
 	menu = (struct scene_obj_menu *)obj;
 	val = menu->cur_item_id;
 
-	ret = get_cur_menuitem_seq(menu);
+	ret = get_cur_menuitem_val(menu, &val);
 	if (ret < 0)
 		return log_msg_ret("cur", ret);
-	seq = ret;
-	log_debug("%s: seq=%d\n", menu->obj.name, seq);
+	log_debug("%s: val=%d\n", menu->obj.name, val);
 
 	/* figure out where to place this item */
 	if (!obj->bit_length)
@@ -680,11 +724,11 @@ static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
 	if (obj->start_bit + obj->bit_length > CMOS_MAX_BITS)
 		return log_msg_ret("bit", -E2BIG);
 
-	for (i = 0; i < obj->bit_length; i++, seq >>= 1) {
+	for (i = 0; i < obj->bit_length; i++, val >>= 1) {
 		uint bitnum = obj->start_bit + i;
 
 		priv->mask[CMOS_BYTE(bitnum)] |= 1 << CMOS_BIT(bitnum);
-		if (seq & 1)
+		if (val & 1)
 			priv->value[CMOS_BYTE(bitnum)] |= BIT(CMOS_BIT(bitnum));
 		log_debug("bit %x %x %x\n", bitnum,
 			  priv->mask[CMOS_BYTE(bitnum)],
@@ -787,7 +831,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 
 	/* update the current item */
 	log_debug("look for menuitem value %d in menu %d\n", val, menu->obj.id);
-	mi = scene_menuitem_find_seq(menu, val);
+	mi = scene_menuitem_find_val(menu, val);
 	if (!mi)
 		return log_msg_ret("seq", -ENOENT);
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 04ff1590bc1..17150af145d 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -69,7 +69,7 @@ struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
 
 	i = 0;
 	list_for_each_entry(item, &menu->item_head, sibling) {
-		if (item->value == val)
+		if (item->value == INT_MAX ? val == i : item->value == val)
 			return item;
 		i++;
 	}
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index 5670805a00e..f29f1b3f388 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -107,8 +107,10 @@ That results in::
     / {
         cedit-values {
             cpu-speed = <0x00000006>;
+            cpu-speed-value = <0x00000003>;
             cpu-speed-str = "2 GHz";
             power-loss = <0x0000000a>;
+            power-loss-value = <0x00000000>;
             power-loss-str = "Always Off";
         };
     }
@@ -118,16 +120,23 @@ That results in::
 This shows settings being stored in the environment::
 
     => cedit write_env -v
-    c.cpu-speed=7
+    c.cpu-speed=11
     c.cpu-speed-str=2.5 GHz
-    c.power-loss=12
-    c.power-loss-str=Memory
+    c.cpu-speed-value=3
+    c.power-loss=14
+    c.power-loss-str=Always Off
+    c.power-loss-value=0
+    c.machine-name=my-machine
+    c.cpu-speed=11
+    c.power-loss=14
+    c.machine-name=my-machine
     => print
     ...
     c.cpu-speed=6
     c.cpu-speed-str=2 GHz
     c.power-loss=10
     c.power-loss-str=Always Off
+    c.machine-name=my-machine
     ...
 
     => cedit read_env -v
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 0f2c2e73dd3..4d1b99bc2ea 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -96,14 +96,16 @@ static int cedit_fdt(struct unit_test_state *uts)
 
 	ut_asserteq(ID_CPU_SPEED_2,
 		    ofnode_read_u32_default(node, "cpu-speed", 0));
+	ut_asserteq(3,
+		    ofnode_read_u32_default(node, "cpu-speed-value", 0));
 	ut_asserteq_str("2.5 GHz", ofnode_read_string(node, "cpu-speed-str"));
 	ut_asserteq_str("my-machine", ofnode_read_string(node, "machine-name"));
 
-	/* There should only be 5 properties */
+	/* There should only be 7 properties */
 	for (i = 0, ofnode_first_property(node, &prop); ofprop_valid(&prop);
 	     i++, ofnode_next_property(&prop))
 		;
-	ut_asserteq(5, i);
+	ut_asserteq(7, i);
 
 	ut_assert_console_end();
 
@@ -151,8 +153,10 @@ static int cedit_env(struct unit_test_state *uts)
 	ut_assertok(run_command("cedit write_env -v", 0));
 	ut_assert_nextlinen("c.cpu-speed=11");
 	ut_assert_nextlinen("c.cpu-speed-str=2.5 GHz");
+	ut_assert_nextlinen("c.cpu-speed-value=3");
 	ut_assert_nextlinen("c.power-loss=14");
 	ut_assert_nextlinen("c.power-loss-str=Always Off");
+	ut_assert_nextlinen("c.power-loss-value=0");
 	ut_assert_nextlinen("c.machine-name=my-machine");
 	ut_assert_console_end();
 
diff --git a/test/boot/files/expo_layout.dts b/test/boot/files/expo_layout.dts
index ebe5adb27bb..9bc1e4950b9 100644
--- a/test/boot/files/expo_layout.dts
+++ b/test/boot/files/expo_layout.dts
@@ -40,10 +40,10 @@
 					ID_CPU_SPEED_3>;
 
 				/* values for the menu items */
-				item-value = <(-1) 3 6>;
+				item-value = <0 3 6>;
 
 				start-bit = <0x400>;
-				bit-length = <2>;
+				bit-length = <3>;
 			};
 
 			power-loss {
-- 
2.34.1

