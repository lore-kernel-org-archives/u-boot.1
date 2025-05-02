Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48571C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BACC282B18;
	Fri,  2 May 2025 16:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MGdKbZA3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 918B482B33; Fri,  2 May 2025 16:48:45 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBAE82B41
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-86192b64d0bso208067739f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197319; x=1746802119; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8Aiq1t95GoM4/3gJfLiY7Q6HrUBwo9O+sAWAzp6vqY=;
 b=MGdKbZA3AX2oaNOI5d9sZ7G3nqT7Ala7DkIu6tkmcCIwBeizUXU+dEJCaOSTAc1Uee
 FE6MXFSnB6Wcfho353J/x89fXZpN/MGuTFk3x7o7NjG+ZZNyWTS5Q8BSrvURvHVXn4uw
 SIjr0Ju42AUSqPeo8BtQ91CnI4Hg9sRJZL/WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197319; x=1746802119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8Aiq1t95GoM4/3gJfLiY7Q6HrUBwo9O+sAWAzp6vqY=;
 b=oSH06S+1bksVnjwAmocakRmenId0ImUJHSWFKpOvZeErIeMcAHHs2ZRDRGA6R/Qfxl
 t6rYhUyjiV1OFVvgDvQj6rMw6G5i7STx4eGf2zbzoKWrrzOw9XpK4WE/dPYqncmJBwaq
 gItmwP+oEWSNVUI1jedUEUc5hfDaH7b0iY5LFxF/naniLDzXCJuBxQXgRg0Zhswe3USO
 9YfIayViHmlyUHdI5QzvnDXwE21yZtyCPllWO/fObb4q7mubnWH7VBGkx9sYhHNAoxSR
 1IcR1rOfpK5w0fjwmkVIxst7aMd2RseA/ovR/wz5iI7WJf5AtFLLjecvBZsWKzafJd+e
 0vcw==
X-Gm-Message-State: AOJu0YydVEXiBiq+Kix0tR3wHs/qVUzOC0kYEuJ0qelfJQxlgnHCrLm3
 mXvITZP8B/BY7SRiEXBjhT7Pz+4KVZ0L/Mjmpz70C/5dpLq1kuCBVEvT167G7QIK+gXins++cuU
 =
X-Gm-Gg: ASbGncs5gY2mVZuUH+v6stxADxiSUlbuYKpmi8X+2omvyJBRmVDnwTwy3uDe3fmmpQj
 fAsqCjjsF8n98r3ja1YDGLLQkqvpEjaWv6mwnnhq4FKLQBBn7jUySTkMzXDvE2m6NI3UrWm9O6w
 p2ThtNbyLPvlth7pYhKMmlgEWuyapSmPQwYATQtZZjQQXn0kYmYxkM6xmp+I/zJHtr92shlP2Jp
 W4gJWDAEpUt8b/GITSpJK8gHvzfuL1UhqPTJPWJFCfwBUVIsbBzd71aV80bYf95QSV6Yvd4b/j1
 77tWkHZbz6ooi1WK+Bhv0v+8u4HigBEq5Wq0ZTGHlUUUNTrUUvJ4Jr9KMDL48c5tnqBP8fALOj9
 RbZTd3QSKmS31
X-Google-Smtp-Source: AGHT+IF6DUnZ2PVr0st326HwYpAthkRnWZBfI/teuR01lfPoxxuqx3LMfxgsqWeqoHScBCX2EFnN7w==
X-Received: by 2002:a05:6602:3f08:b0:864:488e:a581 with SMTP id
 ca18e2360f4ac-866b2d7bd95mr440286939f.4.1746197319328; 
 Fri, 02 May 2025 07:48:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 38/60] expo: Line up all menu objects
Date: Fri,  2 May 2025 08:46:36 -0600
Message-ID: <20250502144718.313633-39-sjg@chromium.org>
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

At present labels are lined up vertically. Do the same with keys and
descriptions, since it looks nicer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene_menu.c | 22 ++++++++++++++--------
 test/boot/expo.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index e99f4426281..96ac726ebcd 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -190,14 +190,20 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 
 	scene_menu_calc_bbox(menu, bbox);
 
-	/* Make all labels the same size */
-	cur = &bbox[SCENEBB_label];
-	if (cur->valid) {
-		list_for_each_entry(item, &menu->item_head, sibling) {
-			scene_obj_set_size(menu->obj.scene, item->label_id,
-					   cur->x1 - cur->x0,
-					   cur->y1 - cur->y0);
-		}
+	/* Make all field types the same width */
+	list_for_each_entry(item, &menu->item_head, sibling) {
+		cur = &bbox[SCENEBB_label];
+		if (cur->valid)
+			scene_obj_set_width(menu->obj.scene, item->label_id,
+					    cur->x1 - cur->x0);
+		cur = &bbox[SCENEBB_key];
+		if (cur->valid)
+			scene_obj_set_width(menu->obj.scene, item->key_id,
+					    cur->x1 - cur->x0);
+		cur = &bbox[SCENEBB_desc];
+		if (cur->valid)
+			scene_obj_set_width(menu->obj.scene, item->desc_id,
+					    cur->x1 - cur->x0);
 	}
 
 	cur = &bbox[SCENEBB_all];
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 2a430d3d482..70db33d48b1 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -576,6 +576,36 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(50 + 29, obj->bbox.x1);
 	ut_asserteq(454 + 18, obj->bbox.y1);
 
+	/* same for the key */
+	obj = scene_obj_find(scn, ITEM1_KEY, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(280, obj->bbox.x0);
+	ut_asserteq(436, obj->bbox.y0);
+	ut_asserteq(280 + 9, obj->bbox.x1);
+	ut_asserteq(436 + 18, obj->bbox.y1);
+
+	obj = scene_obj_find(scn, ITEM2_KEY, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(280, obj->bbox.x0);
+	ut_asserteq(454, obj->bbox.y0);
+	ut_asserteq(280 + 9, obj->bbox.x1);
+	ut_asserteq(454 + 18, obj->bbox.y1);
+
+	/* and the description */
+	obj = scene_obj_find(scn, ITEM1_DESC, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(330, obj->bbox.x0);
+	ut_asserteq(436, obj->bbox.y0);
+	ut_asserteq(330 + 89, obj->bbox.x1);
+	ut_asserteq(436 + 18, obj->bbox.y1);
+
+	obj = scene_obj_find(scn, ITEM2_DESC, SCENEOBJT_NONE);
+	ut_assertnonnull(obj);
+	ut_asserteq(330, obj->bbox.x0);
+	ut_asserteq(454, obj->bbox.y0);
+	ut_asserteq(330 + 89, obj->bbox.x1);
+	ut_asserteq(454 + 18, obj->bbox.y1);
+
 	/* check dimensions of menu */
 	obj = scene_obj_find(scn, OBJ_MENU, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-- 
2.43.0

