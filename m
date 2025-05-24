Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C43C54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 256DA82D06;
	Sat, 24 May 2025 17:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SspNdl2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6A782CD2; Sat, 24 May 2025 17:41:38 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2034183631
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3dca2473129so2628955ab.2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748101294; x=1748706094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bjEk47P07jtOe2xk1RWlEMKK8yUSz5OAs0+qsvAa4vs=;
 b=SspNdl2tKljyiQUZggr9X91JDV+Ecpe1ymSVpEuvg4Q6f96szVhCY14Lg/1FlvrK3d
 0sRyVoLEwnlYuocOC0aD7o73Pd8QeabGIC+JcjKPUqeHS0zzC4xQ9STC/1zbpLtS7gNa
 PghR8jb46dn6NSJ9Cdh9WND22Cpps6GByU1+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748101294; x=1748706094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjEk47P07jtOe2xk1RWlEMKK8yUSz5OAs0+qsvAa4vs=;
 b=fpEImSQ/xA5CSwmpHtgHwAnBcRP9s+Tt19TPHH/lxICoYWMBbUsmL0JjkJ/h/Jx8Ci
 QdFlW1HyxapdAWfKvj1QwAF6ilzM5O3IpDRMxa8/6h4iHXNEeubBjwpCeSeceIf0ka61
 GxJktTwyKTQ3f6xyLOLDbxTsqfwXtH/6a320hTYLwYgk2/XMMVszlCAIgRupLPPiI5qJ
 p506dMTEvbHlPL+8DN21liPAhJTtPf2dQyTHGV106ZaY7wUDPhF1GNLJK2xXv3j6wuAh
 IWZLRHJpK37mXOKTovCIUu3yLHPYUT21Hczgd3gUTl7jo/epyj7JOrRIouFBUZAt71R2
 Oy+w==
X-Gm-Message-State: AOJu0Yw+EG0z+hXsioD92hOmO63OreJweMUiqggKYfEgStcdZYuMitPQ
 0QI7BiWid4kWr7PsVm1BPSXCRkZd1Xk9ftuOmYBSqk+bHmvhezsbx67qz9C3v/Q+vN2bODkeutN
 wsg9fm6Yk
X-Gm-Gg: ASbGnct3fnQkdpw/BKICIruIzXv6hQjyxF1hiqYsVPQ9Ue+mKXTdS/Mb+x/LHfEPCND
 c3L7i3YIIAH/+m5XCCfdNlUOBGFZe7k9z/53XTZHTw+ys9nPdxmr2g/6c/HuQGRVNLlV3LJRMR5
 QeuHqd8VVVE2SoQpSQHqJhqa6YEHOWJyzVz0bKefALvJOh2ArYhht0bgbg+cacgRDHv5U/fqJ0o
 gbrW3T09j5fCTlSoWVSHe9fTwCQkjbphICbabDgTaDkRmyAZLYBVg4act1x3pmsU4M1CeNS6yAQ
 7Ik2qM9qJuPFyiCtji4+pzZklG0nJN4JwVtQgyX4oozVPwgYNxjYlNIhgNHpQeCPCDU36gzOZ+C
 88nele4Xku6wiOXGtPkvUFCU=
X-Google-Smtp-Source: AGHT+IGKj/ydhBRigwn3XHVFReVmNPm5VYMcsPr+y9RXjSEbKwSYeB2RDHjuDoJbw/zyzFty/rLBwA==
X-Received: by 2002:a05:6e02:2193:b0:3dc:8b57:b750 with SMTP id
 e9e14a558f8ab-3dc9b74ee97mr25802625ab.17.1748101294286; 
 Sat, 24 May 2025 08:41:34 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fbcc4b1543sm4040779173.121.2025.05.24.08.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 08:41:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] expo: Reduce menu margin
Date: Sat, 24 May 2025 09:41:12 -0600
Message-ID: <20250524154117.1217190-6-sjg@chromium.org>
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

The current margin between the menu label and the following objects is
much larger than is needed. Reduce it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene_menu.c |  2 +-
 test/boot/expo.c  | 42 +++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index fe44bd42133..55dde6d2ec2 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -302,7 +302,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 			return log_msg_ret("nam", ret);
 		scene_obj_set_hide(scn, item->label_id,
 				   stack && !open && !selected);
-		x += 200;
+		x += dims[SCENEBB_label].x + 50 + 18;
 
 		/* space for the pointer */
 		if (pointer_dims.x) {
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 17d5c1a9db2..9c3eb984f97 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -427,13 +427,13 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(menu->obj.bbox.x0, name1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, name1->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x0 + 200, ptr->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.x0 + 100, ptr->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, ptr->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x0 + 229, key1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.x0 + 129, key1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, key1->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x0 + 279, desc1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.x0 + 179, desc1->obj.bbox.x0);
 	ut_asserteq(menu->obj.bbox.y0 + 32, desc1->obj.bbox.y0);
 
 	ut_asserteq(-4, prev1->obj.bbox.x0);
@@ -630,31 +630,31 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* same for the key */
 	obj = scene_obj_find(scn, ITEM1_KEY, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(280, obj->bbox.x0);
+	ut_asserteq(177, obj->bbox.x0);
 	ut_asserteq(436, obj->bbox.y0);
-	ut_asserteq(280 + 9, obj->bbox.x1);
+	ut_asserteq(177 + 9, obj->bbox.x1);
 	ut_asserteq(436 + 18, obj->bbox.y1);
 
 	obj = scene_obj_find(scn, ITEM2_KEY, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(280, obj->bbox.x0);
+	ut_asserteq(177, obj->bbox.x0);
 	ut_asserteq(454, obj->bbox.y0);
-	ut_asserteq(280 + 9, obj->bbox.x1);
+	ut_asserteq(177 + 9, obj->bbox.x1);
 	ut_asserteq(454 + 18, obj->bbox.y1);
 
 	/* and the description */
 	obj = scene_obj_find(scn, ITEM1_DESC, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(330, obj->bbox.x0);
+	ut_asserteq(227, obj->bbox.x0);
 	ut_asserteq(436, obj->bbox.y0);
-	ut_asserteq(330 + 89, obj->bbox.x1);
+	ut_asserteq(227 + 89, obj->bbox.x1);
 	ut_asserteq(436 + 18, obj->bbox.y1);
 
 	obj = scene_obj_find(scn, ITEM2_DESC, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(330, obj->bbox.x0);
+	ut_asserteq(227, obj->bbox.x0);
 	ut_asserteq(454, obj->bbox.y0);
-	ut_asserteq(330 + 89, obj->bbox.x1);
+	ut_asserteq(227 + 89, obj->bbox.x1);
 	ut_asserteq(454 + 18, obj->bbox.y1);
 
 	/* check dimensions of menu */
@@ -684,17 +684,17 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18792, video_compress_fb(uts, dev, false));
+	ut_asserteq(18782, video_compress_fb(uts, dev, false));
 
 	ut_asserteq(0, scn->highlight_id);
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
 	ut_assertok(expo_render(exp));
-	ut_asserteq(20401, video_compress_fb(uts, dev, false));
+	ut_asserteq(20366, video_compress_fb(uts, dev, false));
 
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(20401, video_compress_fb(uts, dev, false));
+	ut_asserteq(20366, video_compress_fb(uts, dev, false));
 
 	scene_set_highlight_id(scn, OBJ_MENU);
 	ut_asserteq(OBJ_MENU, scn->highlight_id);
@@ -706,7 +706,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assert(!(obj->flags & SCENEOF_HIDE));
 
 	ut_assertok(expo_render(exp));
-	ut_asserteq(20401, video_compress_fb(uts, dev, false));
+	ut_asserteq(20366, video_compress_fb(uts, dev, false));
 
 	/* move down */
 	ut_assertok(expo_send_key(exp, BKEY_DOWN));
@@ -719,7 +719,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(19650, video_compress_fb(uts, dev, false));
+	ut_asserteq(19636, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* hide the text editor since the following tets don't need it */
@@ -728,18 +728,18 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* do some alignment checks */
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(16322, video_compress_fb(uts, dev, false));
+	ut_asserteq(16308, video_compress_fb(uts, dev, false));
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_RIGHT));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(16276, video_compress_fb(uts, dev, false));
+	ut_asserteq(16242, video_compress_fb(uts, dev, false));
 
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_LEFT));
 	ut_assertok(scene_obj_set_valign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18753, video_compress_fb(uts, dev, false));
+	ut_asserteq(18742, video_compress_fb(uts, dev, false));
 	ut_assertok(scene_obj_set_valign(scn, OBJ_TEXT3, SCENEOA_BOTTOM));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18696, video_compress_fb(uts, dev, false));
+	ut_asserteq(18663, video_compress_fb(uts, dev, false));
 
 	/* make sure only the preview for the second item is shown */
 	obj = scene_obj_find(scn, ITEM1_PREVIEW, SCENEOBJT_NONE);
@@ -765,7 +765,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	exp->show_highlight = true;
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(18805, video_compress_fb(uts, dev, false));
+	ut_asserteq(18842, video_compress_fb(uts, dev, false));
 
 	/* now try in text mode */
 	expo_set_text_mode(exp, true);
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: expa
