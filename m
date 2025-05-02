Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0484BC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776E982CA4;
	Fri,  2 May 2025 16:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iaxGnLzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24F082CA2; Fri,  2 May 2025 16:49:17 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F26182BDA
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so250874839f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197353; x=1746802153; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiTfeZJ1812Nhn4FP8wmq7xoUHpJx+ZapmCx0llOFwg=;
 b=iaxGnLzOlEnr1ruxvPDhIrKsbAnhYwm/mPvRkEBmfUaQKKS+Gxwi8dhkXSvM/Bb8Lq
 DzG5dyA6FtEY9ay4UclAYZVc5YedlJ5mJGdsDNqHQi2LUz7WW9rx7ykDP1/Im9VoBpyL
 49eDgcq2eKayniJACtQmJOq+YTdBxqCVV9yc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197353; x=1746802153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiTfeZJ1812Nhn4FP8wmq7xoUHpJx+ZapmCx0llOFwg=;
 b=vEhFfRSe1GpX24sbYkOSxmGXq0I42u7Ymb6epr9DcLfPH45q3CQp4up7aC27CA2svA
 zIIG7d3a0DU2bJGwZCdl7N95/I1tvRqNh5lJK98otdVi0CryT0PVj/UmvkjEUkrJWJeq
 kPz8vb2jVdO3rM/gVkArxGoGQefe+J5aS/list0+D7FHwXZyIlo/Ejra1VO5XZP8rNSQ
 SrBcsS964SDHFqqbqDHEGb59gWGgT0wqEfP0MFogg8fZZhJjiZmcQ2wWEhmbR18I9Spq
 px0BMOMd58pWU7gcx3W5Hmc1MICC/lzg2X0+fihFMGCz6P84gs6ilGBWv+MiR9NG5o7F
 G+qg==
X-Gm-Message-State: AOJu0YzpcudUikFgPmVYO15VQ5jydNdRxrgc9BTQ+PGH5yaiDG+eQU+k
 VMzSqGWCV4bSUAlKOUpBai3fr+wZiYcVONKmyq44BYebYBqIgt0FkYMdich+N+6VvJNGZDJiAwE
 =
X-Gm-Gg: ASbGncvBl5M/mXJcRx2fitDwg7ldfELMngF78Zl6F6nVEIclfLeoPbCrS7nN55dl5He
 QKx5FiOu9V1wLR5NjoPVh7DTlfPZdXLzR0hZwLtEGvjVu6pb04WkVGVh//CJuEo0pLfWgEvVk6G
 kItk0SpN+rth5qIg6v54D2UxJLBhF5zO6rj6dx62WEgM1hc+IY+t2B5WVJSsqy+FngcKnPnWzrW
 OF/SwMeMJsFvNNSScXHgEBaRRX00apj2IbLzFrl3xixrJEyz1vRLe5trwu0c96KIPKNjm0oVUZx
 MmzwTYF+5714t2fgedhe8BJPv8A9cI0xOGBwh0eVH9nK+6RA8qqdXf/zeQOlqQzFtsczrOHPkXz
 ovA==
X-Google-Smtp-Source: AGHT+IEFT3ZgdZ2S1nykgKiDqV8OvF7TCnRH0NgMGxYxfOC2KJDxnZ/WxFWqGdWGRo5D1YTaAiov1Q==
X-Received: by 2002:a05:6602:418c:b0:861:6f48:4a68 with SMTP id
 ca18e2360f4ac-8669fb07ed4mr416612739f.3.1746197353340; 
 Fri, 02 May 2025 07:49:13 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 56/60] expo: Improve the visual appearance of the menu
Date: Fri,  2 May 2025 08:46:54 -0600
Message-ID: <20250502144718.313633-57-sjg@chromium.org>
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

The menu is currently quite basic. Make use of some recently added
features in expo, to:

- Show proper prompts
- Highlight the current item
- Centre text
- Use multi-line text instead of two independent lines
- Put a box around the items

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Only check the text objects used by the bootmenu, for now

 boot/bootflow_internal.h | 11 +++++++--
 boot/bootflow_menu.c     | 49 ++++++++++++++++++++++++++++++++++++----
 test/boot/bootflow.c     |  2 +-
 3 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/boot/bootflow_internal.h b/boot/bootflow_internal.h
index 38cf02a55b5..4cdb6966a7b 100644
--- a/boot/bootflow_internal.h
+++ b/boot/bootflow_internal.h
@@ -14,7 +14,10 @@ enum {
 	START,
 
 	/* strings */
-	STR_PROMPT,
+	STR_PROMPT1A,
+	STR_PROMPT1B,
+	STR_PROMPT2,
+	STR_AUTOBOOT,
 	STR_MENU_TITLE,
 	STR_POINTER,
 
@@ -23,10 +26,14 @@ enum {
 
 	/* objects */
 	OBJ_U_BOOT_LOGO,
+	OBJ_BOX,
 	OBJ_MENU,
-	OBJ_PROMPT,
+	OBJ_PROMPT1A,
+	OBJ_PROMPT1B,
+	OBJ_PROMPT2,
 	OBJ_MENU_TITLE,
 	OBJ_POINTER,
+	OBJ_AUTOBOOT,
 
 	/* strings for menu items */
 	STR_LABEL = 100,
diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 6e2d83406f2..fb90e51e920 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -38,6 +38,7 @@ int bootflow_menu_new(struct expo **expp)
 	struct menu_priv *priv;
 	struct scene *scn;
 	struct expo *exp;
+	bool use_font;
 	void *logo;
 	int ret;
 
@@ -53,27 +54,65 @@ int bootflow_menu_new(struct expo **expp)
 	if (ret < 0)
 		return log_msg_ret("scn", ret);
 
-	ret |= scene_txt_str(scn, "prompt", OBJ_PROMPT, STR_PROMPT,
-			     "UP and DOWN to choose, ENTER to select", NULL);
+	ret = scene_box(scn, "box", OBJ_BOX, 2, NULL);
+	if (ret < 0)
+		return log_msg_ret("bmb", ret);
+	ret |= scene_obj_set_bbox(scn, OBJ_BOX, 30, 90, 1366 - 30, 720);
 
 	ret = scene_menu(scn, "main", OBJ_MENU, &menu);
 	ret |= scene_obj_set_pos(scn, OBJ_MENU, MARGIN_LEFT, 100);
 	ret |= scene_txt_str(scn, "title", OBJ_MENU_TITLE, STR_MENU_TITLE,
 			     "U-Boot - Boot Menu", NULL);
-	ret |= scene_menu_set_title(scn, OBJ_MENU, OBJ_PROMPT);
+	ret |= scene_obj_set_bbox(scn, OBJ_MENU_TITLE, 0, 32,
+				  SCENEOB_DISPLAY_MAX, 30);
+	ret |= scene_obj_set_halign(scn, OBJ_MENU_TITLE, SCENEOA_CENTRE);
 
 	logo = video_get_u_boot_logo();
 	if (logo) {
 		ret |= scene_img(scn, "ulogo", OBJ_U_BOOT_LOGO, logo, NULL);
-		ret |= scene_obj_set_pos(scn, OBJ_U_BOOT_LOGO, -4, 4);
+		ret |= scene_obj_set_pos(scn, OBJ_U_BOOT_LOGO, 1165, 100);
 	}
 
+	ret |= scene_txt_str(scn, "prompt1a", OBJ_PROMPT1A, STR_PROMPT1A,
+	     "Use the \x18 and \x19 keys to select which entry is highlighted.",
+	     NULL);
+	ret |= scene_txt_str(scn, "prompt1b", OBJ_PROMPT1B, STR_PROMPT1B,
+	     "Use the UP and DOWN keys to select which entry is highlighted.",
+	     NULL);
+	ret |= scene_txt_str(scn, "prompt2", OBJ_PROMPT2, STR_PROMPT2,
+	     "Press enter to boot the selected OS, 'e' to edit the commands "
+	     "before booting or 'c' for a command-line. ESC to return to "
+	     "previous menu", NULL);
+	ret |= scene_txt_str(scn, "autoboot", OBJ_AUTOBOOT, STR_AUTOBOOT,
+	     "The highlighted entry will be executed automatically in %ds.",
+	     NULL);
+	ret |= scene_obj_set_bbox(scn, OBJ_PROMPT1A, 0, 590,
+				  SCENEOB_DISPLAY_MAX, 30);
+	ret |= scene_obj_set_bbox(scn, OBJ_PROMPT1B, 0, 620,
+				  SCENEOB_DISPLAY_MAX, 30);
+	ret |= scene_obj_set_bbox(scn, OBJ_PROMPT2, 100, 650,
+				  1366 - 100, 700);
+	ret |= scene_obj_set_bbox(scn, OBJ_AUTOBOOT, 0, 720,
+				  SCENEOB_DISPLAY_MAX, 750);
+	ret |= scene_obj_set_halign(scn, OBJ_PROMPT1A, SCENEOA_CENTRE);
+	ret |= scene_obj_set_halign(scn, OBJ_PROMPT1B, SCENEOA_CENTRE);
+	ret |= scene_obj_set_halign(scn, OBJ_PROMPT2, SCENEOA_CENTRE);
+	ret |= scene_obj_set_valign(scn, OBJ_PROMPT2, SCENEOA_CENTRE);
+	ret |= scene_obj_set_halign(scn, OBJ_AUTOBOOT, SCENEOA_CENTRE);
+
+	use_font = IS_ENABLED(CONFIG_CONSOLE_TRUETYPE);
+	scene_obj_set_hide(scn, OBJ_PROMPT1A, use_font);
+	scene_obj_set_hide(scn, OBJ_PROMPT1B, !use_font);
+	scene_obj_set_hide(scn, OBJ_AUTOBOOT, use_font);
+
 	ret |= scene_txt_str(scn, "cur_item", OBJ_POINTER, STR_POINTER, ">",
 			     NULL);
 	ret |= scene_menu_set_pointer(scn, OBJ_MENU, OBJ_POINTER);
 	if (ret < 0)
 		return log_msg_ret("new", -EINVAL);
 
+	exp->show_highlight = true;
+
 	*expp = exp;
 
 	return 0;
@@ -198,7 +237,7 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
 		int i;
 
 		log_debug("font size %d\n", font_size);
-		scene_txt_set_font(scn, OBJ_PROMPT, NULL, font_size);
+		scene_txt_set_font(scn, OBJ_PROMPT1A, NULL, font_size);
 		scene_txt_set_font(scn, OBJ_POINTER, NULL, font_size);
 		for (i = 0; i < priv->num_bootflows; i++) {
 			ret = scene_txt_set_font(scn, ITEM_DESC + i, NULL,
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 72fb0644ee8..06fd2dbb20a 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -895,7 +895,7 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	 *
 	 * Check both menu items, since there are two bootflows
 	 */
-	ut_assertok(check_font(uts, scn, OBJ_PROMPT, font_size));
+	ut_assertok(check_font(uts, scn, OBJ_PROMPT1A, font_size));
 	ut_assertok(check_font(uts, scn, OBJ_POINTER, font_size));
 	for (i = 0; i < 2; i++) {
 		ut_assertok(check_font(uts, scn, ITEM_DESC + i, font_size));
-- 
2.43.0

