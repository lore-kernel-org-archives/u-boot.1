Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE3EC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B301282114;
	Fri, 28 Mar 2025 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QOH09iN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07808205B; Fri, 28 Mar 2025 14:08:27 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 587EE82120
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d439f01698so10832995ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167301; x=1743772101; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RakQ9T5QedgtGBCoRxnTXH7T9hxPm3z0THgasGVrOA=;
 b=QOH09iN1TkWPwZFPnOKnyjFUxY26S25WmYVjbNUbGBTWrjSJMiKCvXrFiOUYSmZDMR
 74vMq+5nOh7pejModmfoMw6eLs639/ZK7S1d2th6rwE6GrsdmOyNvI4Iit3bJTfJH34e
 NiGrYexlY6UCeQUsDr5Ip97QO8EkINiE4/AC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167301; x=1743772101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4RakQ9T5QedgtGBCoRxnTXH7T9hxPm3z0THgasGVrOA=;
 b=KGqUEk2rrPJV+k4SrdM2ICbvJDCVX61X9n/L9P6Mfrg0blMp1iYOUDpme2dM24jrMn
 XLCOsQelA3O24P4XKN7FaJWWynpaFNruHbGc+SfrbYVM5LaCIzO4Sf9/uKQCPpX8Llk9
 d8nlOC7ZL9GR37Dwsb5Ovfgc4NAsSG6AtOHSc348YjQ9ybIIqHu0K6fw+1fo5o4GQ3aW
 kcTpvlzug5PKCO/rVhZvKAJlR0RNTsFI371W50tc567jjn1tigm8nRVkG9f6Og1uPtin
 QXgNe9l7DYxhGl9+zKT5kByzNxAcavWUZG1mCBmgE+baxUUQ4QR4M1ai/AtvKbLXE+EC
 hXlQ==
X-Gm-Message-State: AOJu0YxdQBVBP07hB58gnny+pcLRcyta37eKZu/pQwjYMqpAt6uNP9bT
 u+I9tqEWdYvGiR9SmwTdso9m0tjRsSDGPu+hq93bFkOY336o9aHV2MIDHGZknYCn3GD8FTprjc8
 =
X-Gm-Gg: ASbGncsIgcuphPlT3ESrOU1fWpoA/q8D/A74cmGTnGd/QVXNejCP20rWqgZw8NXwohG
 vtfm/7DOIBhUvkRsJswaHFmWoeGKL3AsFJD3QDrwhI4ikTPx3tpVCY3072tv9byXt0Xi9nH+gpD
 alFKwlWl2zH4BTlDh7V5ocCw+nCvjDnXykVtQBic3YU4zVrYYl7Ebuo/mNiXfuLIBOJC/LTNv+B
 pOy7RXo/RzcSTCU5XIY5Q3BcrIYGhGHmw9ES012wNJPONsB35xbMMsAcxY5DnwW29GpE1mnYZtP
 bhYbY1XSTpoJPZ5Jg1yWBxXgtfe0i65/oOmjDAH31nmhYr6qbuotgMsmIJyw+gmABDtXRODO9Oy
 zcourFg==
X-Google-Smtp-Source: AGHT+IFQYCw0auSdxlIyV+na+EJm98/6nvcXDESgpgOJIMaihKdy7BJ7M4CXTZnMq/C+Gtgz38nCVA==
X-Received: by 2002:a05:6e02:1448:b0:3d0:26a5:b2c with SMTP id
 e9e14a558f8ab-3d5d6f95e67mr21305085ab.8.1743167301035; 
 Fri, 28 Mar 2025 06:08:21 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 34/56] expo: Line up all menu objects
Date: Fri, 28 Mar 2025 07:06:21 -0600
Message-ID: <20250328130713.2612648-35-sjg@chromium.org>
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

At present labels are lined up vertically. Do the same with keys and
descriptions, since it looks nicer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene_menu.c | 22 ++++++++++++++--------
 test/boot/expo.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 3df3c6ed1d8..914f109fa35 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -183,14 +183,20 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 
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

