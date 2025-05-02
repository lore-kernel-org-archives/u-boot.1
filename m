Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1DFC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BA182B66;
	Fri,  2 May 2025 16:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HYGq6suJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4639F82B5F; Fri,  2 May 2025 16:48:41 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1094982B20
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8616b7ad03bso48076139f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197317; x=1746802117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SplXjVPOvmHNIJ+tlfk2yQo4uXsFMErMrxjnCPxhSLY=;
 b=HYGq6suJ1XsSwoaiaLYbzKXZPY1LIMLFN0RCVLQe2K2NIzpUVUGOovXxsGw6LcDDqD
 DoSRBadBP5en+fO9AGRBlATK58fhj5dxot+mTmZYJ9LECiBbUqNTqoxBTsjk6yt9xOgo
 dD7vA0iFQ8PQoy/X+9Ygp9EMKikYlisCfV8Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197317; x=1746802117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SplXjVPOvmHNIJ+tlfk2yQo4uXsFMErMrxjnCPxhSLY=;
 b=mmYRGgKPGhiGIAD1IRJECw2WTVSJQNJzYF6h3K/58IyJMO2XfmYuLm/ywQMndlaxkb
 RBuFitZjXbPSupMNha7ZKJY0r3gXBdislp/eY+7L43ruhgaN/145AJlLGMoDd453Jhaw
 48uQjeZ/+wj1/0qmh7iN0us9nrNUhchVExFE/NIhNON0hC8VpDYALV6+AE9xWgbWUNYw
 RlhvDVO5lE003FyRzvpYiMic2zYYiGaoNwAYFVYpsEkmJI/iI7cm8BWzAjZDLraiF05P
 Nz/rEXgKiKl5vzcI/LbyxwntP/Kl/SOXZIVF1mKGsT+dqZMB4P9OEiOm6veIlcSo4Dfa
 sjaA==
X-Gm-Message-State: AOJu0Yx1bvouKpiGGt6Z2bnHWImcGCKuKiJpqpZ2GP+w7T5FWgWZLRW3
 HXYnnboklFUfInd+wENmUWw7s678oJ3fBhGRczbo9WZCsbB0Emu6mTeOYPX1fh6zZbvCIAptmAY
 =
X-Gm-Gg: ASbGncunb0NP5vGUV1lLNNQ9AQtICMUain0ZumXBwrdUWqrvfSTITbrCGL3mqqc1Wmz
 Np2Jyn381TRdm+JbQAwwIR5DsXbrSg2MHX31bqhdeGLmwWpMZ/Sew+t5q5gyOZbj4sJBCRfmUyI
 sAtxNB7aAGCeqnNg7IrVLEIEysJYlE/IslHmj5jOEXpgMrTIhE12HN6/KdRRmmTVJ5NwVxz+Ri5
 c1fP86rvgSgNcZ5MV+vCM8w+NmRYdHNOKjhoiy2f9hHakje30Xd8mjE2xmjwPhGrJLn+8MYLjwM
 Zd/9tb4uFYga6JSqN2/f9Tz+ImIQkoLVVXFOOumpi0YLhkudrog2ea558y3xxBxablBuU5rbYVp
 Pew==
X-Google-Smtp-Source: AGHT+IFitV78rfBvORc+Gj41DfolIIhjpRQmsgCL7NBgtixVknp7eEYBWTax4dMvTRudoNvAPZF3gA==
X-Received: by 2002:a05:6602:401b:b0:864:68b0:60b3 with SMTP id
 ca18e2360f4ac-866b42504e4mr441403239f.12.1746197316771; 
 Fri, 02 May 2025 07:48:36 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 37/60] expo: Support setting the size and bounds of an
 object
Date: Fri,  2 May 2025 08:46:35 -0600
Message-ID: <20250502144718.313633-38-sjg@chromium.org>
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
index f1dc2d81922..ea329252d28 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -235,6 +235,35 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
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

