Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BABE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:26:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C35987192;
	Mon,  2 Oct 2023 03:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e6an7/Qs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A772870FC; Mon,  2 Oct 2023 03:14:40 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33D968711D
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f82b26abfso561298239f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209253; x=1696814053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q2OBx2OSwEdJbf3MR/TWBn0qHnRFNZZ27HRHVjU9VHs=;
 b=e6an7/Qs2DV/U5HHM86YccPFkenPQewoa0th+CCfn+5AiLiHPs6ZdsNLt98POTdhl6
 uhBFN6jCZEKV/vLJ2Wv/cNK+33FAFwh7rIqc3qobpKALYng7uUCe15XzpdbLTb0Q8hN9
 9uCmSOqL8a2KeLc60Zc5hPiFDvB/0I6Jw7W1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209253; x=1696814053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2OBx2OSwEdJbf3MR/TWBn0qHnRFNZZ27HRHVjU9VHs=;
 b=MmOtZdvRp0Dywl905eIcNyTopms2Z7dqWOzSbopI6d2e61Lty/nI1HPEFUvH/sjkaG
 vdlB4WST9eW+it34hNTV7T+nxE6jAo/Bqc2UnCl4jtiu3shVCyGKvKv3jIeGQLMtfsDp
 c/FqvMXGIiK9fm0NtqWIFEYJdYLWeasBPOeMx5EBfn6i4ZZlIsg1d4FVRJUmO94iTu39
 jHvx+u9Zj14kbPTur9HwRZV1DD90uvK7GRkH8Yveu0qrEWeX3kR8IdvwlX9gNfoG/EyP
 hqqjEXYH8XCu6J/NYQYAmDIo1KpA7XifeXu9U2hCuMjssIZaTjMe5huZFJXee2lT/r4c
 A3oQ==
X-Gm-Message-State: AOJu0YwBepkh8Rssx7b7Wd14RCpfBJ46UnkNFDNfwIcFC3yxiDeFWmFs
 CTM34+4YpYzGObwjQIMBO1VMzOHrox9KIOxdxeI=
X-Google-Smtp-Source: AGHT+IEwr5nP1aN/hQnYUzxCO1YsfyOC2ir4fM639ns1dpIKPWwe3CFvFsQ4TCdgcwAz7GXDRMPPJg==
X-Received: by 2002:a92:cd4e:0:b0:34f:1f1f:f3ca with SMTP id
 v14-20020a92cd4e000000b0034f1f1ff3camr10668141ilq.23.1696209252835; 
 Sun, 01 Oct 2023 18:14:12 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 23/36] expo: Allow highlighting other scene-object types
Date: Sun,  1 Oct 2023 19:13:27 -0600
Message-ID: <20231002011349.461284-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

So far only menus can be highlighted. With the coming addition of
text lines we need to be able to highlight other objects. Add a function
to determine whether an object can be highlighted.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c   | 11 ++++-------
 include/expo.h |  8 ++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 8e5d3aa7dc05..4d7cabd75f4f 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -516,7 +516,7 @@ static void send_key_obj(struct scene *scn, struct scene_obj *obj, int key,
 					       sibling)) {
 			obj = list_entry(obj->sibling.prev,
 					 struct scene_obj, sibling);
-			if (obj->type == SCENEOBJT_MENU) {
+			if (scene_obj_can_highlight(obj)) {
 				event->type = EXPOACT_POINT_OBJ;
 				event->select.id = obj->id;
 				log_debug("up to obj %d\n", event->select.id);
@@ -528,7 +528,7 @@ static void send_key_obj(struct scene *scn, struct scene_obj *obj, int key,
 		while (!list_is_last(&obj->sibling, &scn->obj_head)) {
 			obj = list_entry(obj->sibling.next, struct scene_obj,
 					 sibling);
-			if (obj->type == SCENEOBJT_MENU) {
+			if (scene_obj_can_highlight(obj)) {
 				event->type = EXPOACT_POINT_OBJ;
 				event->select.id = obj->id;
 				log_debug("down to obj %d\n", event->select.id);
@@ -537,7 +537,7 @@ static void send_key_obj(struct scene *scn, struct scene_obj *obj, int key,
 		}
 		break;
 	case BKEY_SELECT:
-		if (obj->type == SCENEOBJT_MENU) {
+		if (scene_obj_can_highlight(obj)) {
 			event->type = EXPOACT_OPEN;
 			event->select.id = obj->id;
 			log_debug("open obj %d\n", event->select.id);
@@ -685,12 +685,9 @@ void scene_highlight_first(struct scene *scn)
 	struct scene_obj *obj;
 
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
-		switch (obj->type) {
-		case SCENEOBJT_MENU:
+		if (scene_obj_can_highlight(obj)) {
 			scene_set_highlight_id(scn, obj->id);
 			return;
-		default:
-			break;
 		}
 	}
 }
diff --git a/include/expo.h b/include/expo.h
index 297d892de8e7..b192d55665ab 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -146,6 +146,8 @@ enum scene_obj_t {
 	SCENEOBJT_NONE		= 0,
 	SCENEOBJT_IMAGE,
 	SCENEOBJT_TEXT,
+
+	/* types from here on can be highlighted */
 	SCENEOBJT_MENU,
 };
 
@@ -203,6 +205,12 @@ struct scene_obj {
 	struct list_head sibling;
 };
 
+/* object can be highlighted when moving around expo */
+static inline bool scene_obj_can_highlight(const struct scene_obj *obj)
+{
+	return obj->type >= SCENEOBJT_MENU;
+}
+
 /**
  * struct scene_obj_img - information about an image object in a scene
  *
-- 
2.42.0.582.g8ccd20d70d-goog

