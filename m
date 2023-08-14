Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695F1C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:41:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 311E0869B4;
	Tue, 15 Aug 2023 00:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WewvZ17I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE872869B4; Tue, 15 Aug 2023 00:41:21 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE1D8869A4
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:41:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34986ae4fa3so15716285ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692052878; x=1692657678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtsN71J6DwafpRKuByg0xC2el5es6TBOcgH/SIns8v4=;
 b=WewvZ17I7G235XcpDI2as9bVRmHzKhHU0X2LzG4pzhaYOQTo48cA9FU0lVy0ejte5a
 bWuWPXp3dksvH159y9zMCOuFnrhS0KR/29lJnqe/em+qY2j1f5XP6ajPIwZEDJa2x96b
 hhtSQEZnww7IXpfb+UdIXc0f42706WFSDBTPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692052878; x=1692657678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mtsN71J6DwafpRKuByg0xC2el5es6TBOcgH/SIns8v4=;
 b=TAhqLSp/JudBqvQa/TlrRu25TZ8QVkHZ+iAmTSdi2E51U4YiLB6sxQQ771zFLvKdpc
 kaeUj7wxGEMFLCLCRI8tcDG0sVqUEGKTfllHvdmuUGwsMTK1y55ukwX54C69ai5VRjuf
 WOlDs+GAl96BjWt00XaVBdVxA9CPRhxD/alphLe/s2MDnB+vKJiWalLnY7ib5Ai84/cx
 Z8DJC5ltYzRxYRxH1M4qKWX9D7LprqxUwdaiN2bhwTdCUp74L6E1+yBcMRnWV3F4dCyf
 RzJYouTMNoJ+bNriXTtvuc1h66rPO4NBlgB44+t2gFW1/U3U7Jo8fTmMuZrxd3zXSSsj
 yEsQ==
X-Gm-Message-State: AOJu0YyCocx6OOJIOtn9OdEuz3MFTQ3A+jvJjVv4lr2UGB/QfRiHZnqS
 fSZ1IzLgJA3Bnd+IpyZTqnkMQCtqRGXCnanMhv8=
X-Google-Smtp-Source: AGHT+IHr7xEb7EL72qm9OxJZjQaIVtz62uwpLawmxoPCXe0gD5guuHNz/a28NFKA5qJrBeZ1s0XkuA==
X-Received: by 2002:a05:6e02:1543:b0:348:8b42:8b43 with SMTP id
 j3-20020a056e02154300b003488b428b43mr14393260ilu.28.1692052878268; 
 Mon, 14 Aug 2023 15:41:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a056e02080300b0034886587bdcsm3485091ilm.18.2023.08.14.15.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:41:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 03/19] expo: Provide a way to iterate through all scene objects
Date: Mon, 14 Aug 2023 16:40:23 -0600
Message-ID: <20230814224047.535491-4-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230814224047.535491-1-sjg@chromium.org>
References: <20230814224047.535491-1-sjg@chromium.org>
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

For some operations it is necessary to process all objects in an expo.
Provide an iterator to handle this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c           | 15 +++++++++++++++
 boot/scene.c          | 16 +++++++++++++++
 boot/scene_internal.h | 24 +++++++++++++++++++++++
 test/boot/expo.c      | 45 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+)

diff --git a/boot/expo.c b/boot/expo.c
index db837f7b4924..139d684f8e6e 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -266,3 +266,18 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 
 	return 0;
 }
+
+int expo_iter_scene_objs(struct expo *exp, expo_scene_obj_iterator iter,
+			 void *priv)
+{
+	struct scene *scn;
+	int ret;
+
+	list_for_each_entry(scn, &exp->scene_head, sibling) {
+		ret = scene_iter_objs(scn, iter, priv);
+		if (ret)
+			return log_msg_ret("wr", ret);
+	}
+
+	return 0;
+}
diff --git a/boot/scene.c b/boot/scene.c
index b4c36c41702f..6c52948eb69c 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -681,3 +681,19 @@ int scene_set_open(struct scene *scn, uint id, bool open)
 
 	return 0;
 }
+
+int scene_iter_objs(struct scene *scn, expo_scene_obj_iterator iter,
+		    void *priv)
+{
+	struct scene_obj *obj;
+
+	list_for_each_entry(obj, &scn->obj_head, sibling) {
+		int ret;
+
+		ret = iter(obj, priv);
+		if (ret)
+			return log_msg_ret("itr", ret);
+	}
+
+	return 0;
+}
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index 1620d10a7778..60b143440785 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -9,6 +9,8 @@
 #ifndef __SCENE_INTERNAL_H
 #define __SCENE_INTERNAL_H
 
+typedef int (*expo_scene_obj_iterator)(struct scene_obj *obj, void *priv);
+
 /**
  * expo_lookup_scene_id() - Look up a scene ID
  *
@@ -198,4 +200,26 @@ int scene_menu_render_deps(struct scene *scn, struct scene_obj_menu *menu);
  */
 int scene_menu_calc_dims(struct scene_obj_menu *menu);
 
+/**
+ * scene_iter_objs() - Iterate through all scene objects
+ *
+ * @scn: Scene to process
+ * @iter: Iterator to call on each object
+ * @priv: Private data to pass to the iterator, in addition to the object
+ * Return: 0 if OK, -ve on error
+ */
+int scene_iter_objs(struct scene *scn, expo_scene_obj_iterator iter,
+		    void *priv);
+
+/**
+ * expo_iter_scene_objects() - Iterate through all scene objects
+ *
+ * @exp: Expo to process
+ * @iter: Iterator to call on each object
+ * @priv: Private data to pass to the iterator, in addition to the object
+ * Return: 0 if OK, -ve on error
+ */
+int expo_iter_scene_objs(struct expo *exp, expo_scene_obj_iterator iter,
+			 void *priv);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 3898f853a751..458e332440c3 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -289,6 +289,33 @@ static int expo_object_attr(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(expo_object_attr, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 
+/**
+ * struct test_iter_priv - private data for expo-iterator test
+ *
+ * @count: number of scene objects
+ * @menu_count: number of menus
+ * @fail_at: item ID at which to return an error
+ */
+struct test_iter_priv {
+	int count;
+	int menu_count;
+	int fail_at;
+};
+
+int h_test_iter(struct scene_obj *obj, void *vpriv)
+{
+	struct test_iter_priv *priv = vpriv;
+
+	if (priv->fail_at == obj->id)
+		return -EINVAL;
+
+	priv->count++;
+	if (obj->type == SCENEOBJT_MENU)
+		priv->menu_count++;
+
+	return 0;
+}
+
 /* Check creating a scene with a menu */
 static int expo_object_menu(struct unit_test_state *uts)
 {
@@ -296,6 +323,7 @@ static int expo_object_menu(struct unit_test_state *uts)
 	struct scene_menitem *item;
 	int id, label_id, desc_id, key_id, pointer_id, preview_id;
 	struct scene_obj_txt *ptr, *name1, *desc1, *key1, *tit, *prev1;
+	struct test_iter_priv priv;
 	struct scene *scn;
 	struct expo *exp;
 	ulong start_mem;
@@ -382,6 +410,23 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(menu->obj.dim.y + 32, prev1->obj.dim.y);
 	ut_asserteq(true, prev1->obj.flags & SCENEOF_HIDE);
 
+	/* check iterating through scene items */
+	memset(&priv, '\0', sizeof(priv));
+	ut_assertok(expo_iter_scene_objs(exp, h_test_iter, &priv));
+	ut_asserteq(7, priv.count);
+	ut_asserteq(1, priv.menu_count);
+
+	/* check the iterator failing part way through iteration */
+	memset(&priv, '\0', sizeof(priv));
+	priv.fail_at = key_id;
+	ut_asserteq(-EINVAL, expo_iter_scene_objs(exp, h_test_iter, &priv));
+
+	/* 2 items (preview_id and the menuitem) are after key_id, 7 - 2 = 5 */
+	ut_asserteq(5, priv.count);
+
+	/* menu is first, so is still processed */
+	ut_asserteq(1, priv.menu_count);
+
 	expo_destroy(exp);
 
 	ut_assertok(ut_check_delta(start_mem));
-- 
2.41.0.694.ge786442a9b-goog

