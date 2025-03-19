Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E136C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1892D8214D;
	Wed, 19 Mar 2025 15:57:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gEmvagQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 079BF828C2; Wed, 19 Mar 2025 15:56:59 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90B68213D
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso44645775e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396216; x=1743001016; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBF0dGeceCmdC09zUVE6UWLlfMOdRq0BTxNYLm+4Rv8=;
 b=gEmvagQwpwGSdYTurNGISh4jAxby7yqYE50inefuFhnHhyBHObz1mGwgRVKWoDyJUj
 CpQpPWpM9xR8qNauJHWHdkMP7pDziET+QWc3KFwa11r2Gb7bEJn8lm09bfl/h5hLfd/7
 cx37RsScACGCLBPto9W31zYbKmDDGpV4WuQe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396216; x=1743001016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBF0dGeceCmdC09zUVE6UWLlfMOdRq0BTxNYLm+4Rv8=;
 b=GnpINnLgvU55nF4tHh2YPpuwuSzaJaTewQ4jqhtdfGOvzlNytbwWLkKJUsHzbIAeFT
 3hhLNu0Bs1TnsDZwAdmDj/jpAsF7edfKEwAJyl38+Cn2CvqUVI+k4jrBy+DjT0txu4wj
 fBGscaWlQPmU1V5GGJq5cF9Yjf33cB5W2qcFvj7MGlJDggYO5QgRAuxLiwcY0REzZC3o
 a8v1OofZB+oP+iHpkyARbOWx1777YJRRMZz0qPNzx72JjEWcoxYyC+L8qgP46kCffA+g
 UfwVTRZvv0tDt2F1ssIRb6cCjaz37cBuRxorMM1Z4gyl2uNvryjciKv9TduEAHFHTT0Z
 AXAw==
X-Gm-Message-State: AOJu0YyfQGySsOkUmzeXXk+yiHakchWZ2NrRs3+2J4pZD02SFMhQ41GJ
 BCvWnzOirlZ40ohbOmijLA5noKS3+ucbQ5874zqO0ex35jM8B28EbVhse0lI6zWIuZRkxCYfJ2w
 =
X-Gm-Gg: ASbGncsaHNOvwpGeV1UyofgNhKQm0cjpye1zl5txaufAltO7FWBo6dTxuaLU0n+I8O6
 3K/RC6MgBUcJcpjHrUWpJNLAZNCLXYC/sUK4IwC0u2bEU04IheV7ShGbVUvorvC/S8aZbCWvYyA
 vxCc3iNaWOXtjYHylhKipj1B4DlUMYfonqTY4SzHkmlZf2sjx47etMjCQAzS+jYgIxZ7btAEqdq
 vqzk7Z1+ucK9tnwIOQlvF+WthSuysQT+UtVPPNmD+ccSjOxevF4rsmHQGF3NyByBawV01gaFCs0
 W3QMCNz71JnkDfUpHlvCRUKLzdHsrQkVFYpyjLhi1Q==
X-Google-Smtp-Source: AGHT+IGQOzI2bNLB+/Wb12DTn8P/iJqqZLbnEQ+ZekL+I2Z6Z3RJzr5FRv59mxk4iXYOSVnpyFrt9Q==
X-Received: by 2002:a05:600c:4f86:b0:43c:f1cd:3d78 with SMTP id
 5b1f17b1804b1-43d4379750cmr27504585e9.12.1742396215763; 
 Wed, 19 Mar 2025 07:56:55 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 48/52] expo: Improve the visual appearance of the menu
Date: Wed, 19 Mar 2025 15:54:53 +0100
Message-ID: <20250319145512.2391122-49-sjg@chromium.org>
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

The menu is currently quite basic. Make use of some recently added
features in expo, to:

- Show proper prompts
- Highlight the current item
- Centre text
- Use multi-line text instead of two independent lines
- Put a box around the items

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_internal.h | 11 ++++++++--
 boot/bootflow_menu.c     | 47 +++++++++++++++++++++++++++++++++++-----
 test/boot/bootflow.c     |  4 ++--
 3 files changed, 53 insertions(+), 9 deletions(-)

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
index ace89545fa9..a44c340167c 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -38,6 +38,7 @@ int bootflow_menu_new(struct expo **expp)
 	struct menu_priv *priv;
 	struct scene *scn;
 	struct expo *exp;
+	bool use_font;
 	void *logo;
 	int ret;
 
@@ -53,27 +54,63 @@ int bootflow_menu_new(struct expo **expp)
 	if (ret < 0)
 		return log_msg_ret("scn", ret);
 
-	ret |= scene_txt_str(scn, "prompt", OBJ_PROMPT, STR_PROMPT,
-			     "UP and DOWN to choose, ENTER to select", NULL);
+	LOGR("bmb", scene_box(scn, "box", OBJ_BOX, 2, NULL));
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
@@ -195,7 +232,7 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
 		int i;
 
 		log_debug("font size %d\n", font_size);
-		scene_txt_set_font(scn, OBJ_PROMPT, NULL, font_size);
+		scene_txt_set_font(scn, OBJ_PROMPT1A, NULL, font_size);
 		scene_txt_set_font(scn, OBJ_POINTER, NULL, font_size);
 		for (i = 0; i < priv->num_bootflows; i++) {
 			ret = scene_txt_set_font(scn, ITEM_DESC + i, NULL,
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 72fb0644ee8..c477c1c1e09 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -895,8 +895,8 @@ static int bootflow_menu_theme(struct unit_test_state *uts)
 	 *
 	 * Check both menu items, since there are two bootflows
 	 */
-	ut_assertok(check_font(uts, scn, OBJ_PROMPT, font_size));
-	ut_assertok(check_font(uts, scn, OBJ_POINTER, font_size));
+	for (i = OBJ_PROMPT1A; i <= OBJ_POINTER; i++)
+		ut_assertok(check_font(uts, scn, i, font_size));
 	for (i = 0; i < 2; i++) {
 		ut_assertok(check_font(uts, scn, ITEM_DESC + i, font_size));
 		ut_assertok(check_font(uts, scn, ITEM_KEY + i, font_size));
-- 
2.43.0

