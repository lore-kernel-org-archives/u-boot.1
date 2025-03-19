Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D51C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24CA482102;
	Wed, 19 Mar 2025 15:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BmgV/5UH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB5F81F7B; Wed, 19 Mar 2025 15:56:07 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1124382064
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43948021a45so47348395e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396164; x=1743000964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzXo5Doq7u+Iu76yuR0jc1AMoJSKDybyk+1a9BJ8LNk=;
 b=BmgV/5UHIkfY4Voy9AClwremOAoSwQBXbDZe/d0TqqkEsf3UwWAQhL3TbOFyJAzO8E
 M561ZwWDsvWRfDyWsZePIQcbKwO5xBfS5XHIhb67i9IudJ9n4EypCPUgc+ugRJyLKZ23
 GJ6ZDBlsguelbRrbAIcQtduiOveFByp7/2DOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396164; x=1743000964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzXo5Doq7u+Iu76yuR0jc1AMoJSKDybyk+1a9BJ8LNk=;
 b=k1N1ABEeeKJ4LhYVCynoxQvllH8mYVeJNrozXEypcattUoxr86yrQD667NatoJtbe/
 t8x/VKBiifYlRyq+bwoFGAw0QTIHKhDfBCgWlCutrjbK07fL8gc5t+l5ZePyp9OfB/jR
 9+OFIeqsRP16Jzr65rZcaxgqDkwfZJrL28eu5utFwvpWC6yRhozbaoObJr+joA7PpLSV
 WTfy7fTPcA8tdJMh9Q/HJiQMANMDTjLVv+9xvIMUhiBorGxd+e7Zz9uknAF6eUrZoaPI
 0oAssmCnxABKE0XAkgFriniC5kmLvgS2jZCKLr0tD2fU2Tab3kAKyslQiZPPhjoRcKYZ
 Ndkw==
X-Gm-Message-State: AOJu0YxRlufqMSE8OPcr0OwmFfjPFQTyMv4gH0Ea4atdXPLHhcR5DUDe
 SmNk2WsMfqFMpVi37AvrWCOTfwhYcYSyQs66P6YB6V9VQsEs74RiYggO0Yc85MmdtLrcBeIszic
 =
X-Gm-Gg: ASbGncuQrRmiILQACifZR8LvnhCL3Wd6er0Z7+t2LsnGYC4OuF7PiHu7V92zmAQQ56Y
 jRIWl0I3uVa1bvGKCVBqlF3L2N5nFMkzMd331/xbTrtOioog1/xYTvOD5Eje93eYHPH9Vc5cS6j
 f3nGRksdr/spLzcvUtCqT9pLFILlveZ5oRYDF2/VdoFMcVJzoOk0MzXh2m5ZisEoAKYRUj6FVdW
 wvnepiOxhhEGrfhXKAmfTn62YsYT0uLey/oyz98dWlTJktEiUkEDSOmIb0UjVbyis9TSa8tja5l
 GkyN2ugVqxZ5clXavONFAWioX2Hteb7Xqlf/sKN22g==
X-Google-Smtp-Source: AGHT+IFFOzQB6AJZEo0DNm10frLastSQzKfNvHyBAP9B6evQBo95rTAHywJ2PWTJKAdOMriXincQ0Q==
X-Received: by 2002:a05:600c:1e14:b0:43c:e70d:450c with SMTP id
 5b1f17b1804b1-43d437feccfmr30201025e9.22.1742396163901; 
 Wed, 19 Mar 2025 07:56:03 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/52] expo: Provide access to the current menu item
Date: Wed, 19 Mar 2025 15:54:24 +0100
Message-ID: <20250319145512.2391122-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Add functions to allow a caller to find out the current menu item and to
select a different one.

Update the event handling so that an attempt to change the current item
(e.g. by pressing the up-arrow key) is reported to the caller, since
this may be used to cancel an autoboot timeout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c | 32 +++++++++++++++++++++++++++++---
 include/expo.h    | 20 ++++++++++++++++++++
 test/boot/expo.c  |  4 ++++
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 17150af145d..48905d3e2b6 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -121,12 +121,14 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
  *
  * Sets the currently pointed-to / highlighted menu item
  */
-static void menu_point_to_item(struct scene_obj_menu *menu, uint item_id)
+static int menu_point_to_item(struct scene_obj_menu *menu, uint item_id)
 {
 	if (menu->cur_item_id)
-		update_pointers(menu, menu->cur_item_id, false);
+		LOGR("mpi", update_pointers(menu, menu->cur_item_id, false));
 	menu->cur_item_id = item_id;
-	update_pointers(menu, item_id, true);
+	LOGR("mpu", update_pointers(menu, item_id, true));
+
+	return 0;
 }
 
 void scene_menu_calc_bbox(struct scene_obj_menu *menu,
@@ -483,6 +485,30 @@ int scene_menu_set_pointer(struct scene *scn, uint id, uint pointer_id)
 	return 0;
 }
 
+int scene_menu_select_item(struct scene *scn, uint id, uint cur_item_id)
+{
+	struct scene_obj_menu *menu;
+
+	menu = scene_obj_find(scn, id, SCENEOBJT_MENU);
+	if (!menu)
+		return log_msg_ret("menu", -ENOENT);
+
+	LOGR("msi", menu_point_to_item(menu, cur_item_id));
+
+	return 0;
+}
+
+int scene_menu_get_cur_item(struct scene *scn, uint id)
+{
+	struct scene_obj_menu *menu;
+
+	menu = scene_obj_find(scn, id, SCENEOBJT_MENU);
+	if (!menu)
+		return log_msg_ret("menu", -ENOENT);
+
+	return menu->cur_item_id;
+}
+
 int scene_menu_display(struct scene_obj_menu *menu)
 {
 	struct scene *scn = menu->obj.scene;
diff --git a/include/expo.h b/include/expo.h
index f8d44c0ea20..a2b093c521d 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -689,6 +689,26 @@ int scene_menu_set_title(struct scene *scn, uint id, uint title_id);
  */
 int scene_menu_set_pointer(struct scene *scn, uint id, uint cur_item_id);
 
+/**
+ * scene_menu_select_item() - move the pointer/highlight to an item
+ *
+ * @scn: Scene to update
+ * @id: ID of menu object to update
+ * @sel_id: ID of the menuitem to select
+ * Return 0 on success, -ENOENT if there was no such item
+ */
+int scene_menu_select_item(struct scene *scn, uint id, uint sel_id);
+
+/**
+ * scene_menu_get_cur_item() - get the currently pointed-to item
+ *
+ * @scn: Scene to update
+ * @id: ID of menu object to update
+ * Return ID of the current item the menu is pointing to, -ENOENT if @id is not
+ * valid, 0 if no item is pointed to
+ */
+int scene_menu_get_cur_item(struct scene *scn, uint id);
+
 /**
  * scene_obj_get_hw() - Get width and height of an object in a scene
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 1d283a2ac95..616071ead48 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -588,6 +588,8 @@ static int expo_render_image(struct unit_test_state *uts)
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
 
+	ut_asserteq(0, scn->highlight_id);
+
 	/* move down */
 	ut_assertok(expo_send_key(exp, BKEY_DOWN));
 
@@ -595,6 +597,8 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	ut_asserteq(EXPOACT_POINT_ITEM, act.type);
 	ut_asserteq(ITEM2, act.select.id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, act.select.id));
+	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
 	ut_assertok(expo_render(exp));
 
 	/* make sure only the preview for the second item is shown */
-- 
2.43.0

