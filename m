Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5123E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A91E08745E;
	Mon,  2 Oct 2023 03:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JgK81Br+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F26A28711F; Mon,  2 Oct 2023 03:18:22 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A210A87255
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-79fc3d32a2fso415782539f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209387; x=1696814187; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRPjUX38KMeoB/DAbeiNIBfOxYQzqsEfgyIsLdYBo/Q=;
 b=JgK81Br+eBFaZkfyPJ358yiaM3dQIj+puNk9V0Pzt9Gi17R6SbPCjLlK41U9aaRx2g
 SBizEIWY2YJbrKTUr/cNaAxc3gEoxr7TM/nfsC1PcN8lpRpdCJAlpKnRrhsqVreBtZHZ
 gdiAV4xhFO6F/yft3OfqEm3Lva3WAPGZ6KtVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209387; x=1696814187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRPjUX38KMeoB/DAbeiNIBfOxYQzqsEfgyIsLdYBo/Q=;
 b=IVF35Bnrx8gpxJ9CUdBREd4gGtiReZZwF7BcaKoAshkUlaRRcE4tilW4HY7WE3RcMo
 tM47oJfscIqJ02BBYAkRKChvVmEnjFsfOvU/z5R4u9/DxGWt1/DxwMyjA9GUgl+H1uUl
 wYaNvHcp4+I/Bbg1dpgOqS8vY0xIsQiaMPKA7c8VMB7lzLye7pI2dfw6eayhlSAox3y1
 tkPRkFTigaTQL4PzegHBvq0bh8e1cFmmKPBZetA34THOMkgKJvPcmvkUvuWRf1kKpxPP
 f1NLePgw8uqQP+Dtz5E4OPYP3g1Cr3TH5KRHnRt8u8TMlEa3Fh8MDqN/QsxK8Ky25EPK
 A7HA==
X-Gm-Message-State: AOJu0Yx3vsjeYB7p/jbkNwSmVAIoxBE8spxPq2F7l1SwXjNL5jfShQvp
 nbqlEfb/bPMA3OL89zhA8ZksMRA+7tEG6f0feg0=
X-Google-Smtp-Source: AGHT+IE4dRBrGzZGjC4uNQNVYqNApwEv8JmYatNWl/ues3oWTq4nK77wg3GPoLxi7+Yhu9FH+2Q30Q==
X-Received: by 2002:a6b:d602:0:b0:79f:9b45:3365 with SMTP id
 w2-20020a6bd602000000b0079f9b453365mr10834570ioa.17.1696209386676; 
 Sun, 01 Oct 2023 18:16:26 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 23/34] expo: Support menu-item values in cedit
Date: Sun,  1 Oct 2023 19:15:33 -0600
Message-ID: <20231002011553.463514-24-sjg@chromium.org>
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

Update the cedit read/write functions to support menu items with
values.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c                    | 148 +++++++++++++++++++++-----------
 boot/scene_menu.c               |   2 +-
 doc/usage/cmd/cedit.rst         |  15 +++-
 test/boot/cedit.c               |   8 +-
 test/boot/files/expo_layout.dts |   4 +-
 5 files changed, 117 insertions(+), 60 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index cc1d5b763577..7fc800940fbe 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -294,11 +294,49 @@ static int get_cur_menuitem_text(const struct scene_obj_menu *menu,
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
@@ -316,6 +354,38 @@ static int write_dt_string(struct abuf *buf, const char *name, const char *str)
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
@@ -340,23 +410,21 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
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
@@ -522,6 +590,14 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
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
@@ -625,43 +701,12 @@ int cedit_read_settings_env(struct expo *exp, bool verbose)
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
@@ -669,11 +714,10 @@ static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
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
@@ -681,11 +725,11 @@ static int h_write_settings_cmos(struct scene_obj *obj, void *vpriv)
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
@@ -788,7 +832,7 @@ static int h_read_settings_cmos(struct scene_obj *obj, void *vpriv)
 
 	/* update the current item */
 	log_debug("look for menuitem value %d in menu %d\n", val, menu->obj.id);
-	mi = scene_menuitem_find_seq(menu, val);
+	mi = scene_menuitem_find_val(menu, val);
 	if (!mi)
 		return log_msg_ret("seq", -ENOENT);
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 002821ec1f59..86f5fd88804e 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -70,7 +70,7 @@ struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
 
 	i = 0;
 	list_for_each_entry(item, &menu->item_head, sibling) {
-		if (item->value == val)
+		if (item->value == INT_MAX ? val == i : item->value == val)
 			return item;
 		i++;
 	}
diff --git a/doc/usage/cmd/cedit.rst b/doc/usage/cmd/cedit.rst
index f415b48699ea..0f0cc26e74ba 100644
--- a/doc/usage/cmd/cedit.rst
+++ b/doc/usage/cmd/cedit.rst
@@ -104,8 +104,10 @@ That results in::
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
@@ -115,16 +117,23 @@ That results in::
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
index 37807f9a9818..876503befe0b 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -100,14 +100,16 @@ static int cedit_fdt(struct unit_test_state *uts)
 
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
 
@@ -156,8 +158,10 @@ static int cedit_env(struct unit_test_state *uts)
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
index ebe5adb27bbe..9bc1e4950b96 100644
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
2.42.0.582.g8ccd20d70d-goog

