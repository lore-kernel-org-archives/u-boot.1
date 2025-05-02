Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA12C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD95582AAA;
	Fri,  2 May 2025 16:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BCcFQOOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B7D82A8B; Fri,  2 May 2025 16:48:17 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1875F82A81
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso71304239f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197292; x=1746802092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23rkJaAuwwsgVx56wSMSoD7SKR/wI4Sz6Ahiz2NdU6E=;
 b=BCcFQOOlSQPCn7q2lUurYbXI6ljCe+aU3jp/6F3LksDZOY478heW+w4W0PVgz1qX+p
 egY2prK0KzqTTmTO1gaP+StitX21e90AU9NmIY/IkWMkiIVWGIAYdy+QEMNi1wWsSLLF
 0VJSO93JNLxc5fmLh4pd+Ijb/IzTwmI+an4b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197292; x=1746802092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23rkJaAuwwsgVx56wSMSoD7SKR/wI4Sz6Ahiz2NdU6E=;
 b=nsHDLowcQ80pCgKg+6D7QH8MyY4O9PEtznkkW8L5V1JxkIVbfiuL9d4YBjKw8agHT6
 FBela+dlKT8ZMnmGts9laGT4FkhHYe1dEC6wRhzR30vPZWHxymHvubZ7tJYgKTODw3aW
 qhr72ywDv8pWwFJUdO4ZK5vD8K0fjiw3qA57Qdx2t8cTMa/dtv8y5isNIjKEhQAp6tlu
 7mtLFD+ZHutSJigw9jNbX1Z/vAHQtm3jkmcW43Ibv8JCeSnhraPQkeCvcBPt/NuGroz3
 XXs12V10+oJIdQnQ9Mku8pcvA9NMFyszHi+Dg3cxW5dS3g5Y/hzccaf9VKTdPmof/hxi
 2fkQ==
X-Gm-Message-State: AOJu0YyvXf6ySMAOelPIYlyhpgWGcMvqGjR6dfp8tjbb1D9Wq4VE4JbJ
 fPHSoL0pAubMiRilcYEcHItwIAi1+6uY0VRb2sL3MgUf/fg341D180SZocyrfAtPpB7iIOX0D+g
 =
X-Gm-Gg: ASbGncv9w80fY7O2ySwU7QjxM0uYeSHmBz7pMB+3sFi8+vfFwapVg8EpGR5xKBib3qa
 yHBbrs93dvhG4ASk35PsU6hGeXfzQM3u0wUFcs8nrM7JqDtCUho/PKLOckSVBH9/EhW2QEs+Omd
 I17BmFzk/nexqa2Ayq3PCrrQSoDg4kWQ7zEvkozHKvuZDmM2/rtNIX1AhUkrnk7cSjCkU+PDlkA
 EEkUudKOmUPO1oo6h1AVuouOz2xNGJTUZ6bkn9U4eXLkXrIEnIQBHdwGKPbjQ90zDkgE9LMB+Yn
 Cc0ziztDHY8h7kVtkEFzgbfqfICxfVf/mXzN3O0YkWY3WLsUPZ2KKOiEkVbQQLV4Y8FJvCK0w0i
 x5w==
X-Google-Smtp-Source: AGHT+IESSHCAIq6FgNEhqHcgUGb3lqIH61SC2W1fwjTwAhNeJVU3f/ZgjrCY4usZLr1yfiY4ocYYlQ==
X-Received: by 2002:a05:6602:750a:b0:85d:a235:e90e with SMTP id
 ca18e2360f4ac-866b43fb92dmr378980439f.13.1746197292315; 
 Fri, 02 May 2025 07:48:12 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 26/60] expo: Provide access to the current menu item
Date: Fri,  2 May 2025 08:46:24 -0600
Message-ID: <20250502144718.313633-27-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

 boot/scene_menu.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 include/expo.h    | 20 ++++++++++++++++++++
 test/boot/expo.c  |  4 ++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 17150af145d..06d7e9fc913 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -121,12 +121,21 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
  *
  * Sets the currently pointed-to / highlighted menu item
  */
-static void menu_point_to_item(struct scene_obj_menu *menu, uint item_id)
+static int menu_point_to_item(struct scene_obj_menu *menu, uint item_id)
 {
-	if (menu->cur_item_id)
-		update_pointers(menu, menu->cur_item_id, false);
+	int ret;
+
+	if (menu->cur_item_id) {
+		ret = update_pointers(menu, menu->cur_item_id, false);
+		if (ret)
+			return log_msg_ret("mpi", ret);
+	}
 	menu->cur_item_id = item_id;
-	update_pointers(menu, item_id, true);
+	ret = update_pointers(menu, item_id, true);
+	if (ret)
+		return log_msg_ret("mpu", ret);
+
+	return 0;
 }
 
 void scene_menu_calc_bbox(struct scene_obj_menu *menu,
@@ -483,6 +492,33 @@ int scene_menu_set_pointer(struct scene *scn, uint id, uint pointer_id)
 	return 0;
 }
 
+int scene_menu_select_item(struct scene *scn, uint id, uint cur_item_id)
+{
+	struct scene_obj_menu *menu;
+	int ret;
+
+	menu = scene_obj_find(scn, id, SCENEOBJT_MENU);
+	if (!menu)
+		return log_msg_ret("menu", -ENOENT);
+
+	ret = menu_point_to_item(menu, cur_item_id);
+	if (ret)
+		return log_msg_ret("msi", ret);
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

