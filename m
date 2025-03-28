Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B329C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63D07820E8;
	Fri, 28 Mar 2025 14:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gd86otlQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A493B81273; Fri, 28 Mar 2025 14:08:25 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588418210F
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so7348965ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167299; x=1743772099; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XRLTlB3USHeP2IXSybRpHW/CLYYBXw5yJWuGHdQihA=;
 b=gd86otlQcm62KmnSC2/xlw9Mq/2FgDrbGndjv7DG25k+9mtMFa07vhAOg5D7Ded88m
 hUoXUa6rFWWkUYZY7BsrD6SsgqzFPbfpHArUjAEZaAydREt+CP8W58uD1fW4TH041ZgX
 TDUvats0HdNKUT0/6HQpKOykjx8vy9JzEgvJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167299; x=1743772099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XRLTlB3USHeP2IXSybRpHW/CLYYBXw5yJWuGHdQihA=;
 b=sjfvkvMgwtbGTrqoE+X5BAsd6rXvCdM8F29ExYt52FoQpIcxyrviY34PXe77rBzrks
 fnboB8FDbznIYScYR8bqeS53iUav7nkhGs3yPpOaqsE0mLhSBL/L3rycIzxRTE1Wr0Jg
 exsu0Fwd27QQMwO/MuAzk3KiK5l14Y1hEbkqJrZewMVtDODnNyXjxjKGBZDXRkDSA3Te
 yUGbv7zCODIybSyu9N5rhTWOD+GNLv9guFfCi+sDjGU3zX2dBBjvnpOUZ8s9ZQyk7d/N
 CwMVkNrcF3KIJ7hSArPVtUb5+Ja/xVdizTepSXn1XnW5Lsri2J8uM24ho17xvD4RFlpG
 y4gQ==
X-Gm-Message-State: AOJu0Yy0MHzgMPF1zdLUveISmN3M/sF84zq2c/lHrJxDpT6b9jR9c7lf
 UOheYnkoDVQuIwKzOnU/QMJ/n/yGqSEFF3oFPNEeN99095nZokf95OOkKvO/7DDBOadUk1SOIwo
 =
X-Gm-Gg: ASbGncuLG2hEfKyenMgeRWQ4hlcEy/qtJZXgN5bE2TcS0NKyGo1Q3LEtqm9XoGXbZOC
 47zBLa7PduamzE08ZjbcUIMWapf/IV3jdV0Cy89+bXiw9uarVcob46kSWLOLOITJmucxEZVLT8l
 0i+UgBGLYwVRy9X0YJQJHzVvh2OX+xyxDIiINJAz40JxBO3ygC+xY/5pkis4Y80a8TptaOHplFB
 Dpwap91rsT0lzy29bhBiqgQvjSispX5WXsxk+kJB3wm1rA2gHAfZhgMCAt50tQ6ldBIvZJPUjcl
 SbIK2Mx2fuqfihjWtMOVBTsrtZkgEqDXnEsCVtuzKaRFmwYmsj3jGZzQQsYpRa023xe6qwcJF/d
 ZCHd0dg==
X-Google-Smtp-Source: AGHT+IG6Iycyxz2uJvD/JL0PNJsr28KccPdQlGmQYvRKAnm4ykASJxEyw3VRFUPkO8tsXc2UqEg8CA==
X-Received: by 2002:a05:6e02:188d:b0:3d2:aa73:7b7a with SMTP id
 e9e14a558f8ab-3d5ccdd53b3mr85691745ab.12.1743167299269; 
 Fri, 28 Mar 2025 06:08:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 33/56] expo: Support setting the size and bounds of an
 object
Date: Fri, 28 Mar 2025 07:06:20 -0600
Message-ID: <20250328130713.2612648-34-sjg@chromium.org>
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

Add a function to allow the size of an object to be set independently
of its position.

Also add a function to permit the object's bounding box to be set
independently of its dimensions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

