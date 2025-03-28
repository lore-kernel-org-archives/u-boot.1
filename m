Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CFDC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CBF8820F0;
	Fri, 28 Mar 2025 14:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RyZeNOlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D0958206E; Fri, 28 Mar 2025 14:08:10 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8125981DCC
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d43c972616so6035775ab.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167280; x=1743772080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jz1xiXmDXijsdCtXF5rZwUtZngDAkRLBvEyr/lLkj3U=;
 b=RyZeNOlZxGqrPH0veqKc26D8Zm6blBLePDk2CrGCDtMfN3dmFLbTS5BswLTuUxnXOK
 iHnMxinOg6tiNIu6KGys4dJgZ/quLVql/Fj0QmZSCvZC2sw1u0w9AByYnDCQeuVRl9WD
 ssc/x2dXxgPUc8xt5/lT4twyh/LUC6IPgfd80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167280; x=1743772080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz1xiXmDXijsdCtXF5rZwUtZngDAkRLBvEyr/lLkj3U=;
 b=je65xajEDQXnFfppMsVQEnSOHTu/MK9lj1HCwE0c71k0KMugNY933Y6s0hR3uq09Rp
 yWrl/WGNimOzxUQ/Knvb469pF2JbdewDVc+TPjHIvDJ3wwTnbwLL+6SNQjif1kk/VJ97
 8HNYRU9pKl8eXTrJ9eY6MysrmIkZJHprgcBK9Pagx82K1A2aHkZPEctYDgfkJKHJ7OHr
 Y490TTm3b9/70O2otGdflSCg8jDuSZaFhTnpJuOI5m+0iRH1Xozqd2/3aoQHhQeoKF+g
 TqART3qbtZ9HNY3ZqUhpu55ZFeGF8tPaFzNeZkEkInOxjZb/izh8XSthTbUS05H1k2ya
 mBHw==
X-Gm-Message-State: AOJu0YxAaXuiMjLgt1pLg6TEeMY023p78fsTlH0Qj0gvy3I0mSQLy7wL
 jlAg01XJwFIoV43xt/mH62X2z1Y5Vmtysz2w5FH2KkDoGJF084F0ZDwkI+TnpBe89ORapezDgnk
 =
X-Gm-Gg: ASbGncvMHZTmKNhycAUvCPCQkB0sl8F7hikT0YMHScuUCp+eSEMs4i4rr6tubzq9cDh
 uvbii2Q09Kp0XPS9/SQauJVJxlwMulOD+3+EJxCUcOW9j9mNMDw51IPp/8Gm006mcPhQqmagbp4
 5bO+C4iKDKvni7NZzrfSMJxnNMlkEk0/5fbKQooBE4ADgDXVN9pQeoDtcEgIRq6hHc+5kT/Six2
 q+It/ONhTF6v+cIuVXjcxEBC6tIGb6OYO6B1Dmvu98m733p8EzR1EDLwYoHemUtmurrMWDil2W0
 UFFCL85gXeob0JC5EMDeVISb9bcr3Kw72e3V7omEW2Dz4m4tVfSjUkxiYqyFdmFx0vQrakLbogF
 A5SDgtw==
X-Google-Smtp-Source: AGHT+IEJDsXZ8fDFicYQCcGilTRj6I5A3tO9FBiUMeYJqMF/pBxib0DKCn1ekbFja8yVnfTDh0+qBQ==
X-Received: by 2002:a05:6e02:4401:10b0:3d1:4a69:e58f with SMTP id
 e9e14a558f8ab-3d5d6c3863bmr19306425ab.2.1743167279526; 
 Fri, 28 Mar 2025 06:07:59 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 22/56] expo: Provide access to the current menu item
Date: Fri, 28 Mar 2025 07:06:09 -0600
Message-ID: <20250328130713.2612648-23-sjg@chromium.org>
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

Add functions to allow a caller to find out the current menu item and to
select a different one.

Update the event handling so that an attempt to change the current item
(e.g. by pressing the up-arrow key) is reported to the caller, since
this may be used to cancel an autoboot timeout.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

