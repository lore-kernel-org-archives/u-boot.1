Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075EBC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C656F83595;
	Sat, 24 May 2025 17:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H3v4IJD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A11C835BF; Sat, 24 May 2025 17:41:36 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17B8C82D06
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3dca2473129so2628795ab.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748101292; x=1748706092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boEktH0+KB0zQw9eBgtAFVRFRgKZ0r/WclGw6pRZBXY=;
 b=H3v4IJD4j64a53x0QzNl3/0d1jYf76k704irTu+zD5Ji+cqh0vK/78/U+vG7hJ8X9i
 702ha8BVuZQKwQFqt8dP634pKJ28EMOU5IUUhAbknMRkNn1TPU5PinuO6N93O1r6UxFZ
 vH8eqVaz6KckEApV3o/NS0FSWU3xOoFVfsGjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101292; x=1748706092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=boEktH0+KB0zQw9eBgtAFVRFRgKZ0r/WclGw6pRZBXY=;
 b=LCdK92vCkQqrx6bFDGJqYc56HA+EkbK15Cm5aP0MfYaxjEfIuInAkydWJKBeDh1ON2
 KkDKSVjmYEJikowjqRU1J9cpE2VZIssn2bImgaaXeDkY0AaBFJk9T19Jnujl1EnZA0qs
 RaZ1lWTU74k1hk2loqca010HiniaGwLAM3FIa9zDQu12y1puH08j1EwS4rIF8FSH4ibF
 AneR9ZTYV0FwjCCnYe1HGqVkcSJ4S6yVog17/UuE2ndNVzO/sp2Nzppgnpeqaq6OEGdW
 IDJ8AYtPAYnMICUZFBE0hNRQLbBz6EK7zOlBD2++VbdaQYXztJlHH/PCeQ4jtxnGoyTU
 dWDQ==
X-Gm-Message-State: AOJu0Yzqg4UlMGS1s9hfAO1TQqRF7A/yztwXOlgamzTKiRmarIFpX1m5
 l9N/Li35yz4xbYoE4LmR/2+Ou2R+fFtf2ZApik5n4L9MYia4KjxuxFgKIiZ0E7ZtdJyJB0ioejf
 8Z6pO9g2aFq0=
X-Gm-Gg: ASbGncuE7oAN4HsrPb6T97JZNiRX9sC3TZRc45zJjXXhUMGeLPv/x3GlozWS70oPz+c
 6KMd9mMcUpieNoYdRPv4igiJwgt29uM6I21wX4EKI/OTCtIpVpAKE4JVPXzE3eIKJef2MxBBhnS
 hzhhVjNuJXN93UuvwZ47cVeO79ij6xFGmnsfjVkgM0VWnv0A0L5UHKqly701nuQxXKZM6/xWuTW
 wSLJmsUWWZDUtyJHfAjNa1ZC2Arixcd7RWM6kM3p/cXnx8Fp185skEx3XIMxq4y99U7T+ELyeYI
 2stTWeELqjxM5sq+CMIecYF+H5dJzfi3A7mpFFeCNO9p/Va16gbRIzy/JoRoZfS1HliSnbklU22
 75fbSiQptgY0ijbdw/hH+3IE=
X-Google-Smtp-Source: AGHT+IE7+Z4KbNJRTUvLxiT08c8ZqEeIH7hYWg7a2K/Iy20Lxm08Z4eUGg0HuMRC4ftGFRyh/veN5g==
X-Received: by 2002:a05:6e02:743:b0:3dc:8a5f:7cd1 with SMTP id
 e9e14a558f8ab-3dc9b6a9fbemr27956595ab.3.1748101292225; 
 Sat, 24 May 2025 08:41:32 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc4b1543sm4040779173.121.2025.05.24.08.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:41:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] expo: video: Correct kerning output in
 console_truetype_putc_xy()
Date: Sat, 24 May 2025 09:41:11 -0600
Message-ID: <20250524154117.1217190-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524154117.1217190-1-sjg@chromium.org>
References: <20250524154117.1217190-1-sjg@chromium.org>
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

While the text is measured correctly, taking account of kerning
information, this is not used when actually displaying the text. This
results in a mismatch between the measurement and the output.

Fix this by adding the kerning offset to each character position.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/console_truetype.c | 12 +++++++-----
 test/boot/cedit.c                | 32 ++++++++++++++++----------------
 test/boot/expo.c                 | 20 ++++++++++----------
 test/dm/video.c                  | 16 ++++++++--------
 4 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 6d2c2c2e177..a0458d2a6f5 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -287,19 +287,21 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 	u8 *bits, *data;
 	int advance;
 	void *start, *end, *line;
-	int row;
+	int row, kern;
 
 	/* First get some basic metrics about this character */
 	stbtt_GetCodepointHMetrics(font, cp, &advance, &lsb);
 
 	/*
 	 * First out our current X position in fractional pixels. If we wrote
-	 * a character previously, using kerning to fine-tune the position of
+	 * a character previously, use kerning to fine-tune the position of
 	 * this character */
 	xpos = frac(VID_TO_PIXEL((double)x));
+	kern = 0;
 	if (vc_priv->last_ch) {
-		xpos += met->scale * stbtt_GetCodepointKernAdvance(font,
-							vc_priv->last_ch, cp);
+		kern = stbtt_GetCodepointKernAdvance(font, vc_priv->last_ch,
+						     cp);
+		xpos += met->scale * kern;
 	}
 
 	/*
@@ -310,7 +312,7 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 	 */
 	x_shift = xpos - (double)tt_floor(xpos);
 	xpos += advance * met->scale;
-	width_frac = (int)VID_TO_POS(advance * met->scale);
+	width_frac = (int)VID_TO_POS((kern + advance) * met->scale);
 	if (x + width_frac >= vc_priv->xsize_frac)
 		return -EAGAIN;
 
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index 9d49fbdc306..3426bf13ec3 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -271,7 +271,7 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_asserteq(ID_AC_OFF, menu->cur_item_id);
 
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4888, video_compress_fb(uts, dev, false));
+	ut_asserteq(4926, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* move to the second menu */
@@ -279,54 +279,54 @@ static int cedit_render(struct unit_test_state *uts)
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4967, video_compress_fb(uts, dev, false));
+	ut_asserteq(5000, video_compress_fb(uts, dev, false));
 
 	/* open the menu */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5397, video_compress_fb(uts, dev, false));
+	ut_asserteq(5390, video_compress_fb(uts, dev, false));
 
 	/* close the menu */
 	act.type = EXPOACT_CLOSE;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4967, video_compress_fb(uts, dev, false));
+	ut_asserteq(5000, video_compress_fb(uts, dev, false));
 
 	/* open the menu again to check it looks the same */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5397, video_compress_fb(uts, dev, false));
+	ut_asserteq(5390, video_compress_fb(uts, dev, false));
 
 	/* close the menu */
 	act.type = EXPOACT_CLOSE;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4967, video_compress_fb(uts, dev, false));
+	ut_asserteq(5000, video_compress_fb(uts, dev, false));
 
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5397, video_compress_fb(uts, dev, false));
+	ut_asserteq(5390, video_compress_fb(uts, dev, false));
 
 	act.type = EXPOACT_POINT_ITEM;
 	act.select.id = ID_AC_ON;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5341, video_compress_fb(uts, dev, false));
+	ut_asserteq(5363, video_compress_fb(uts, dev, false));
 
 	/* select it */
 	act.type = EXPOACT_SELECT;
 	act.select.id = ID_AC_ON;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4939, video_compress_fb(uts, dev, false));
+	ut_asserteq(4964, video_compress_fb(uts, dev, false));
 
 	ut_asserteq(ID_AC_ON, menu->cur_item_id);
 
@@ -335,14 +335,14 @@ static int cedit_render(struct unit_test_state *uts)
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4850, video_compress_fb(uts, dev, false));
+	ut_asserteq(4868, video_compress_fb(uts, dev, false));
 
 	/* open it */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4883, video_compress_fb(uts, dev, false));
+	ut_asserteq(4871, video_compress_fb(uts, dev, false));
 
 	/*
 	 * Send some keypresses. Note that the console must be enabled so that
@@ -358,7 +358,7 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_silence_console(uts);
 	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5033, video_compress_fb(uts, dev, false));
+	ut_asserteq(5076, video_compress_fb(uts, dev, false));
 
 	expo_destroy(exp);
 	cur_exp = NULL;
@@ -401,7 +401,7 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 	ut_asserteq(20, tline->pos);
 
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5315, video_compress_fb(uts, dev, false));
+	ut_asserteq(5344, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* move to the line-edit field */
@@ -409,14 +409,14 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5372, video_compress_fb(uts, dev, false));
+	ut_asserteq(5408, video_compress_fb(uts, dev, false));
 
 	/* open it */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5259, video_compress_fb(uts, dev, false));
+	ut_asserteq(5291, video_compress_fb(uts, dev, false));
 
 	/* delete some characters */
 	ut_unsilence_console(uts);
@@ -427,7 +427,7 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 
 	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5126, video_compress_fb(uts, dev, false));
+	ut_asserteq(5209, video_compress_fb(uts, dev, false));
 
 	expo_destroy(exp);
 	cur_exp = NULL;
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 239591ff6cd..17d5c1a9db2 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -684,17 +684,17 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18786, video_compress_fb(uts, dev, false));
+	ut_asserteq(18792, video_compress_fb(uts, dev, false));
 
 	ut_asserteq(0, scn->highlight_id);
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
 	ut_assertok(expo_render(exp));
-	ut_asserteq(20433, video_compress_fb(uts, dev, false));
+	ut_asserteq(20401, video_compress_fb(uts, dev, false));
 
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(20433, video_compress_fb(uts, dev, false));
+	ut_asserteq(20401, video_compress_fb(uts, dev, false));
 
 	scene_set_highlight_id(scn, OBJ_MENU);
 	ut_asserteq(OBJ_MENU, scn->highlight_id);
@@ -706,7 +706,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assert(!(obj->flags & SCENEOF_HIDE));
 
 	ut_assertok(expo_render(exp));
-	ut_asserteq(20433, video_compress_fb(uts, dev, false));
+	ut_asserteq(20401, video_compress_fb(uts, dev, false));
 
 	/* move down */
 	ut_assertok(expo_send_key(exp, BKEY_DOWN));
@@ -719,7 +719,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(19673, video_compress_fb(uts, dev, false));
+	ut_asserteq(19650, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* hide the text editor since the following tets don't need it */
@@ -728,18 +728,18 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* do some alignment checks */
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(16368, video_compress_fb(uts, dev, false));
+	ut_asserteq(16322, video_compress_fb(uts, dev, false));
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_RIGHT));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(16321, video_compress_fb(uts, dev, false));
+	ut_asserteq(16276, video_compress_fb(uts, dev, false));
 
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_LEFT));
 	ut_assertok(scene_obj_set_valign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18763, video_compress_fb(uts, dev, false));
+	ut_asserteq(18753, video_compress_fb(uts, dev, false));
 	ut_assertok(scene_obj_set_valign(scn, OBJ_TEXT3, SCENEOA_BOTTOM));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18714, video_compress_fb(uts, dev, false));
+	ut_asserteq(18696, video_compress_fb(uts, dev, false));
 
 	/* make sure only the preview for the second item is shown */
 	obj = scene_obj_find(scn, ITEM1_PREVIEW, SCENEOBJT_NONE);
@@ -765,7 +765,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	exp->show_highlight = true;
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18844, video_compress_fb(uts, dev, false));
+	ut_asserteq(18805, video_compress_fb(uts, dev, false));
 
 	/* now try in text mode */
 	expo_set_text_mode(exp, true);
diff --git a/test/dm/video.c b/test/dm/video.c
index ecf74605b5c..e48f6b078c7 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -582,7 +582,7 @@ static int dm_test_video_truetype(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_stringn(con, test_string, 30);
-	ut_asserteq(13184, video_compress_fb(uts, dev, false));
+	ut_asserteq(13055, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
@@ -604,7 +604,7 @@ static int dm_test_video_truetype_scroll(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(34287, video_compress_fb(uts, dev, false));
+	ut_asserteq(34248, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
@@ -626,7 +626,7 @@ static int dm_test_video_truetype_bs(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(29471, video_compress_fb(uts, dev, false));
+	ut_asserteq(29223, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
@@ -665,7 +665,7 @@ static int dm_test_video_copy(struct unit_test_state *uts)
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_string(con, test_string);
 
-	ut_asserteq(6678, video_compress_fb(uts, dev, false));
+	ut_asserteq(6884, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/*
@@ -690,8 +690,8 @@ static int dm_test_video_copy(struct unit_test_state *uts)
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_string(con, test_string);
 	video_sync(dev, true);
-	ut_asserteq(7589, video_compress_fb(uts, dev, false));
-	ut_asserteq(7704, video_compress_fb(uts, dev, true));
+	ut_asserteq(7621, video_compress_fb(uts, dev, false));
+	ut_asserteq(7741, video_compress_fb(uts, dev, true));
 
 	return 0;
 }
@@ -746,7 +746,7 @@ static int dm_test_video_damage(struct unit_test_state *uts)
 	ut_asserteq(0, priv->damage.xend);
 	ut_asserteq(0, priv->damage.yend);
 
-	ut_asserteq(7339, video_compress_fb(uts, dev, false));
+	ut_asserteq(7335, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
@@ -896,7 +896,7 @@ static int dm_test_video_silence(struct unit_test_state *uts)
 	printf("final message: console\n");
 	vidconsole_put_string(con, "final message: video\n");
 
-	ut_asserteq(3892, video_compress_fb(uts, dev, false));
+	ut_asserteq(3944, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: expa
