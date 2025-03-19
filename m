Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2EBC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:00:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3354F81F7B;
	Wed, 19 Mar 2025 15:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IC6W8MFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E6082120; Wed, 19 Mar 2025 15:56:24 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A64538212F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3997205e43eso1127164f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396181; x=1743000981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04a6OcFdzaRyBEcMoCZJVEGxEMdrvl2PcjrMY1JBzSU=;
 b=IC6W8MFgaBDqnwD90yiWV0amwu1rXO/R/HDdHUPTuxYcCFI9wUpOZcbcwNZ9xcTUAP
 ZKX5M83YgCQb84O+bpXMMyxrhy7Vm/5LjYAfrdE2C4vjtrmLteCs8ABR1CVQSCPLAWXw
 6ykqo1Y2JZrNKoyQu37uElpBfdUFIJzcliTvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396181; x=1743000981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04a6OcFdzaRyBEcMoCZJVEGxEMdrvl2PcjrMY1JBzSU=;
 b=NUGf/7krOGnD7jESban04Sbs8rJhYfk64DZvNA6MGkrfRJMYlHWe/EE/xL9alGgIa1
 tajL/IJ9lPljJxGypyzV0+mlrU8vFbVsyz00Qqe15C2DwEdd0T+t5mL3rta/y3YLTpYR
 n+NbfJHDyGf75UzFGl//exM+51wHOru7PYR8IMDqv+R7R44zgFe946TwaJZivRumkknP
 5S5lN2/KaXjesc8S4pEfxLogVllEJlq5g7VYRLYGD+7nFReqGUbN7mOu2cpLxG3w4E/p
 v6sXGGuWUddPgzQICabNEPlPPZadvs1FSrmw4LFb2X5l260hsP4O0F5caSq6biukILD/
 ZChg==
X-Gm-Message-State: AOJu0YylnWt6DrAov3o4mMXHaPV4rkSnslp39xrLQSe/MzfaQcMEJ6C2
 d2UE1GWfqogsfBN9iNeu5MuE82hwb9vc9oRz2TLxe9Ou2sT4sxQ0q7FgtqLg5+QnOEsJPfdIRaQ
 =
X-Gm-Gg: ASbGncvQ3JSIVdAwENoy195NO4NE113xF7JjHUEMImOkMObiMpI0xy1vhcw3U+YSKsu
 1gRR6JqNzUrqWxyCfelZ57QedsbexcLRXNLd0UYrGv/NwAEE7fAoMVIF+pSsBYGZ+uJXwlB1DNw
 +obfCtmrP71scpfopEbtNp0S55DM11ixtc3G6GVlX4of/rQaQqYL5BAKT3WIWiyGHGbnfFvsxJD
 Jw+g4/tkYNhJTgS4xHAnXY0ZdUivVIZPcawacVnidZGUqFI6p/qW1Y3DrlCbfNTpkrPhgJCuPfJ
 alSb5nwlQpBAaH+h7J0BDT7lkc+5kCKQ29+ExiWI+A==
X-Google-Smtp-Source: AGHT+IHM/tDjWUWzWqTMXiTNjMQoOeQdCujdjgNew2qTPV8dtADOcUVx/Vl1D06VZIQopUQT47tdCw==
X-Received: by 2002:a05:6000:1787:b0:390:de33:b0ef with SMTP id
 ffacd0b85a97d-399739d3dbcmr2267382f8f.30.1742396181508; 
 Wed, 19 Mar 2025 07:56:21 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 29/52] expo: Support setting the size and bounds of an object
Date: Wed, 19 Mar 2025 15:54:34 +0100
Message-ID: <20250319145512.2391122-30-sjg@chromium.org>
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

Add a function to allow the size of an object to be set independently
of its position.

Also add a function to permit the object's bounding box to be set
independently of its dimensions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c     | 29 +++++++++++++++++++++++++++++
 include/expo.h   | 24 ++++++++++++++++++++++++
 test/boot/expo.c | 11 +++++++++++
 3 files changed, 64 insertions(+)

diff --git a/boot/scene.c b/boot/scene.c
index 6142d2b736d..dd48589f378 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -236,6 +236,35 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
 	return 0;
 }
 
+int scene_obj_set_width(struct scene *scn, uint id, int w)
+{
+	struct scene_obj *obj;
+
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("find", -ENOENT);
+	obj->bbox.x1 = obj->bbox.x0 + w;
+
+	return 0;
+}
+
+int scene_obj_set_bbox(struct scene *scn, uint id, int x0, int y0, int x1,
+		       int y1)
+{
+	struct scene_obj *obj;
+
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("find", -ENOENT);
+	obj->bbox.x0 = x0;
+	obj->bbox.y0 = y0;
+	obj->bbox.x1 = x1;
+	obj->bbox.y1 = y1;
+	obj->flags |= SCENEOF_SIZE_VALID;
+
+	return 0;
+}
+
 int scene_obj_set_hide(struct scene *scn, uint id, bool hide)
 {
 	int ret;
diff --git a/include/expo.h b/include/expo.h
index 6f0547a4b38..990cb3094ee 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -673,6 +673,30 @@ int scene_obj_set_pos(struct scene *scn, uint id, int x, int y);
  */
 int scene_obj_set_size(struct scene *scn, uint id, int w, int h);
 
+/**
+ * scene_obj_set_width() - Set the width of an object
+ *
+ * @scn: Scene to update
+ * @id: ID of object to update
+ * @w: width in pixels
+ * Returns: 0 if OK, -ENOENT if @id is invalid
+ */
+int scene_obj_set_width(struct scene *scn, uint id, int w);
+
+/**
+ * scene_obj_set_bbox() - Set the bounding box of an object
+ *
+ * @scn: Scene to update
+ * @id: ID of object to update
+ * @x0: x position, in pixels from left side
+ * @y0: y position, in pixels from top
+ * @x1: ending x position (right side)
+ * @y1: ending y position (botton side)
+ * Returns: 0 if OK, -ENOENT if @id is invalid
+ */
+int scene_obj_set_bbox(struct scene *scn, uint id, int x0, int y0, int x1,
+		       int y1);
+
 /**
  * scene_obj_set_hide() - Set whether an object is hidden
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 94c13e9b71f..2a430d3d482 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -584,6 +584,17 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(50 + 160, obj->bbox.x1);
 	ut_asserteq(400 + 160, obj->bbox.y1);
 
+	scene_obj_set_width(scn, OBJ_MENU, 170);
+	ut_asserteq(50 + 170, obj->bbox.x1);
+	scene_obj_set_bbox(scn, OBJ_MENU, 60, 410, 50 + 160, 400 + 160);
+	ut_asserteq(60, obj->bbox.x0);
+	ut_asserteq(410, obj->bbox.y0);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(400 + 160, obj->bbox.y1);
+
+	/* reset back to normal */
+	scene_obj_set_bbox(scn, OBJ_MENU, 50, 400, 50 + 160, 400 + 160);
+
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
 	ut_assertok(expo_render(exp));
-- 
2.43.0

