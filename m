Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD14C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E2581FFC;
	Wed, 19 Mar 2025 15:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jzFlvb2f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 986BF81DCC; Wed, 19 Mar 2025 15:56:09 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A5682040
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso6045615e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396166; x=1743000966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTEMa1CqXbz3dXj1NloZHbeVZfZ7J8H6aFoka+Bvy4M=;
 b=jzFlvb2fL6doU+DKie4EakMptJUc/mDbCj+0I9mzRfWWNp7nFNt+XjcyHzOjkh2ZHS
 DiisWbEbxXBfRy9u9nIg8gbtuZS2JsZbaeVb//0Rn1SGydWH3yavmUiB+en57D/3Oiye
 8rDKlKONKDUHhiO9XKoPJc/xxUO4JFrXSOo50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396166; x=1743000966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lTEMa1CqXbz3dXj1NloZHbeVZfZ7J8H6aFoka+Bvy4M=;
 b=XHPJWtHGPvlwyfuYLB14Ltf8rAkM4iiLqRSwdDWgiP6MQEUVj81p9xgLNpcFYEAvEL
 3CqhDHBwMTHMzi/2su3e/rHNaLrhVX/DJsuY0jSG/zK1SYK4iCySG64tyczM+REzRMk+
 hJ3Ngd3i08n8nW/K1rBPz+DTVEC5ETJovZzNyVyQSV6Cm6tmqiLaEjnEby2Fc2T0cimB
 GJJgIMGKxvdKQd3fRVgTrvFBCL7Qef05bTAsQ/7gTUPVDNeH7QHPZcE/xjvsvoIjJFn8
 faeJXmW3ojpfLdXzRGTdjfF//Gphq/TRRZYxA2qfCAEhVyHlcool+spX8sB406MixF+8
 MTGg==
X-Gm-Message-State: AOJu0YztcCD4yRT439on/auCnaZTpOpCTPOy/mWn4eyqhFy7CjhnToSe
 b+feau1XABNsSyYAlALh7xeg82Vv+/5R0iisQNs4Gs5jCxIehtwi1z8QJwOyXDCf4aMv1I8nSos
 =
X-Gm-Gg: ASbGnct4Wyn+hK86fLvB0gball0Sy7CPnZ5hBDnOv7Ur3Ihq6MgZx0H+x9MVILFde52
 jB4MoSkPlKvat78ua6Q5O8GkIk3GvzE9kdIGb+I/43bOcvIALdkozMo8NCWMdL0aRFJ6z+CdeHd
 /c6uzoXHX1uktRXk6RmEteCbyeRb/2YDsc4xDEYRmyfh+Un5bC+AxykSWVYKrNAteNXa/cKQ++6
 knEBg6dveHlBKMaeEAM+orZRJpPDXk/R/766e64C2cWlcfxjv9z5g61rze8v1DPAbPxB25TcfM+
 /9KrRNpO6MjXVCnaBSG/mpPKF7fuYTzbDmW7QaNAQw==
X-Google-Smtp-Source: AGHT+IGuZY3+SJkriHCEvK4+7JGCNI7MnnGGDNmmUOiRsZ2wA4VtQ0VSsUrkuBJ/S3FdpWBTP0Mrhw==
X-Received: by 2002:a05:600c:4ed3:b0:43d:1bf6:15e1 with SMTP id
 5b1f17b1804b1-43d42ff6763mr24415485e9.1.1742396165612; 
 Wed, 19 Mar 2025 07:56:05 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 20/52] expo: Adjust how menu items are highlighted
Date: Wed, 19 Mar 2025 15:54:25 +0100
Message-ID: <20250319145512.2391122-21-sjg@chromium.org>
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

At present when the user moves to a new menu item, the menu code
handles this immediately. This means it is not possible to use an expo
action to effect the same change.

Update this so that EXPOACT_POINT_ITEM is handled in cedit_do_action().

Expand the test to cover this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c |  8 ++++++++
 boot/cedit.c         |  5 ++++-
 boot/scene_menu.c    |  2 --
 test/boot/cedit.c    | 22 ++++++++++++++++++++++
 test/boot/expo.c     |  4 ++++
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index e3a27f16daa..d20d0be4734 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -180,6 +180,7 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 {
 	struct bootflow *sel_bflow;
 	struct udevice *dev;
+	struct scene *scn;
 	struct expo *exp;
 	uint sel_id;
 	bool done;
@@ -209,6 +210,9 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 	ret = expo_set_scene_id(exp, MAIN);
 	if (ret)
 		return log_msg_ret("scn", ret);
+	scn = expo_lookup_scene_id(exp, MAIN);
+	if (!scn)
+		return log_msg_ret("scn", -ENOENT);
 
 	if (text_mode)
 		expo_set_text_mode(exp, text_mode);
@@ -224,6 +228,10 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 				sel_id = act.select.id;
 				done = true;
 				break;
+			case EXPOACT_POINT_ITEM:
+				LOGR("bmp", scene_menu_select_item(scn,
+					OBJ_MENU, act.select.id));
+				break;
 			case EXPOACT_QUIT:
 				return -EPIPE;
 			default:
diff --git a/boot/cedit.c b/boot/cedit.c
index bcbbe69fe33..8b4429b4c72 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -154,8 +154,11 @@ int cedit_do_action(struct expo *exp, struct scene *scn,
 {
 	switch (act->type) {
 	case EXPOACT_NONE:
-	case EXPOACT_POINT_ITEM:
 		return -EAGAIN;
+	case EXPOACT_POINT_ITEM:
+		LOGR("cdp", scene_menu_select_item(scn, scn->highlight_id,
+						   act->select.id));
+		break;
 	case EXPOACT_POINT_OBJ:
 		scene_set_highlight_id(scn, act->select.id);
 		cedit_arange(exp, vid_priv, scn->id);
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 48905d3e2b6..df14a6c0409 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -399,8 +399,6 @@ int scene_menu_send_key(struct scene *scn, struct scene_obj_menu *menu, int key,
 		break;
 	}
 
-	menu_point_to_item(menu, item->id);
-
 	return 0;
 }
 
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 9fab8750b40..187cdcbd034 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -226,6 +226,7 @@ BOOTSTD_TEST(cedit_cmos, UTF_CONSOLE);
 /* Check the cedit displays correctely */
 static int cedit_render(struct unit_test_state *uts)
 {
+	struct scene_obj_menu *menu;
 	struct video_priv *vid_priv;
 	extern struct expo *cur_exp;
 	struct expo_action act;
@@ -238,6 +239,11 @@ static int cedit_render(struct unit_test_state *uts)
 	exp = cur_exp;
 	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
 	ut_asserteq(ID_SCENE1, cedit_prepare(exp, &vid_priv, &scn));
+
+	menu = scene_obj_find(scn, ID_POWER_LOSS, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	ut_asserteq(ID_AC_OFF, menu->cur_item_id);
+
 	ut_assertok(expo_render(exp));
 	ut_asserteq(4929, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
@@ -256,6 +262,22 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_assertok(expo_render(exp));
 	ut_asserteq(5393, video_compress_fb(uts, dev, false));
 
+	/* move to the second item */
+	act.type = EXPOACT_POINT_ITEM;
+	act.select.id = ID_AC_ON;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(5365, video_compress_fb(uts, dev, false));
+
+	/* select it */
+	act.type = EXPOACT_SELECT;
+	act.select.id = ID_AC_ON;
+	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(4980, video_compress_fb(uts, dev, false));
+
+	ut_asserteq(ID_AC_ON, menu->cur_item_id);
+
 	expo_destroy(exp);
 	cur_exp = NULL;
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 616071ead48..b32a4596e85 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -588,6 +588,8 @@ static int expo_render_image(struct unit_test_state *uts)
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
 
+	ut_asserteq(0, scn->highlight_id);
+	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
 
 	/* move down */
@@ -599,6 +601,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(ITEM2, act.select.id);
 	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, act.select.id));
 	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
+	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
 
 	/* make sure only the preview for the second item is shown */
@@ -639,6 +642,7 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	ut_asserteq(EXPOACT_POINT_ITEM, act.type);
 	ut_asserteq(ITEM1, act.select.id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, act.select.id));
 
 	ut_assertok(expo_render(exp));
 	ut_assert_nextline("U-Boot    :    Boot Menu");
-- 
2.43.0

