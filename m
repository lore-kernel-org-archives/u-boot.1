Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C90CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2035F86C42;
	Tue, 19 Sep 2023 20:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H69eWf/Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5920686C27; Tue, 19 Sep 2023 20:09:49 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FCFB86BF8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34fdc6209c6so9968005ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146986; x=1695751786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DFBCmKRdGQRxwyVgTpghvQkcMlqyxBgHnr6c0LHrjAs=;
 b=H69eWf/ZpaddavXcT3yAzW7809v4tqxWTgyB2wi/P2OqILwG3R9/RoBXCyk1S0+c8y
 FS0jz56pSeB9JxFOcg6vw27JNQwu7i6f1LihxJvzmYUBYUCgk+I2XLKNUEx1GfJIc002
 78UXvsL6JKo9xqa7ho8YsWEk2XIiKmqTVPuZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146986; x=1695751786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFBCmKRdGQRxwyVgTpghvQkcMlqyxBgHnr6c0LHrjAs=;
 b=lqNMv3l0eClq2fHxutegeAoWeask02rjlMbz/q/BtZqK5y8Mxat8YIh4pma4dvz4Bp
 0dRTd9mO7c04DpVrl3pqeZBxPgLuR/Bqclu3jk2TLnTO4142gqBCOzsWlbTvyhFYUz79
 TUr8bUY9sD1cLe4QzMC6RHi29T+nSezTAAGwDly73UsXMaccdZVWLwgrERc2t9O9LBaP
 /h5tVa5Tj1JESNOvJmrZSQcWwDjIs1EcvGXVIZyHWNNMjfBqTKneKqco2kztSTFHtf2n
 1JvUdcIEYJf7lEs2MT/S7s9Aih9Wv+V4Ne0CUBujOCiOxfHprUEIQsBlnkomHsqiHfuL
 M8Xw==
X-Gm-Message-State: AOJu0YzgaMLu2Lw3E54UGtOedFsmuOgJR0lAbztcPJHpo+8F8s++b8hL
 zajLQSdcn2SLtlcP/gWRGA2Bm3rqLylnw1jG9MI=
X-Google-Smtp-Source: AGHT+IFzEbCyDi3I5LDMaYPY0KTKfBO3oV74uovf4RyqZzBDSkjUKoSsYByOp6MAhOvJyNTJuFEmuQ==
X-Received: by 2002:a92:c24f:0:b0:348:b114:a3d2 with SMTP id
 k15-20020a92c24f000000b00348b114a3d2mr732915ilo.21.1695146985906; 
 Tue, 19 Sep 2023 11:09:45 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 23/36] expo: Allow highlighting other scene-object types
Date: Tue, 19 Sep 2023 12:08:53 -0600
Message-ID: <20230919180918.2904313-24-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 boot/scene.c   | 11 ++++-------
 include/expo.h |  8 ++++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 8e5d3aa7dc0..4d7cabd75f4 100644
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
index 297d892de8e..b192d55665a 100644
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
2.42.0.459.ge4e396fd5e-goog

