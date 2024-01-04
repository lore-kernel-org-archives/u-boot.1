Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B89EC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:15:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 810DF879E0;
	Thu,  4 Jan 2024 16:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pxhzb8A4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEC7D879ED; Thu,  4 Jan 2024 16:12:38 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3051879EE
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7bb97d5ee3aso23183739f.2
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381128; x=1704985928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WL7i8nOizrI1uQPdh3NwdQABRjBriTLuTABRwhAMesw=;
 b=Pxhzb8A4iT82IkdNyVuZQxxOKdVQd62SjnoC1OBWirAWy4Q+rL1ucTL3YW2gYpOx62
 kcfMYLvh74Jv/S4WopDpeW1X+9+P1Qdjy3wd91tGN27rB/AxmestqnAXmi1hpAxLIqvo
 YBn/nhUMCP4wNNyrsumrpL1vXvriq6+nm6gsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381128; x=1704985928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WL7i8nOizrI1uQPdh3NwdQABRjBriTLuTABRwhAMesw=;
 b=AKokVwz9Ky2rK+h+Cf9VeBoqSXvnYhA/bs9K8GR69nNnhdOLdc6sOtYtaOI8G8+IFM
 a59P2E2AbZyIifRDlJFSz79UZWuW8Q5DR87/Lj0JUbNO2lDu5/arxrkCtxqnwHi2i6HU
 evDHBZ6L24638CQr38yfVG3UjtwL+FQxi6lXNlVxXDUVI0Cjsm+pw9Q8grocuzcY3Q2d
 P/xt2mBJS578CyigAnAIbcHCb7f74hHgQb3H5k+viTnapFtET03SS3SMrQ0wJPVZ7zlm
 4EstFGZBm8w7THPTLiqgLkzM+4y+fLKopoPWff4bRUdAb2xW8N3Kie4A9N86yTixQl/a
 lLtg==
X-Gm-Message-State: AOJu0YyB+fc+szMigWxg5AyF/3Jomx6/TjV86EjWHy46DgduK1+Z7+7u
 KhoETPXRpfzvGJQswIbDInjQshJLtuT+iUM3hZ6u4MTPOIWa
X-Google-Smtp-Source: AGHT+IGMs1XKu4QDAUf6eFdhPkNVW6Iqo2NFb9X3QvBz/IGiQoYAf13H542fx9WajPnUTvUKjkfgaA==
X-Received: by 2002:a05:6e02:1707:b0:35f:af8f:de2e with SMTP id
 u7-20020a056e02170700b0035faf8fde2emr811174ill.42.1704381127798; 
 Thu, 04 Jan 2024 07:12:07 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 10/19] expo: Drop scene_title_set()
Date: Thu,  4 Jan 2024 08:11:43 -0700
Message-Id: <20240104151152.697855-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

This function is really just an assignment, so serves no useful
purpose. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo_build.c | 4 ++--
 boot/scene.c      | 7 -------
 include/expo.h    | 9 ---------
 test/boot/expo.c  | 2 +-
 4 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 71aa03f2826..ae0ffd225b3 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -405,7 +405,7 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 	if (ret < 0)
 		return log_msg_ret("tit", ret);
 	title_id = ret;
-	scene_title_set(scn, title_id);
+	scn->title_id = title_id;
 
 	ret = add_txt_str(info, scn_node, scn, "prompt", 0);
 	if (ret < 0)
@@ -421,7 +421,7 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 	return 0;
 }
 
-int build_it(struct build_info *info, ofnode root, struct expo **expp)
+static int build_it(struct build_info *info, ofnode root, struct expo **expp)
 {
 	ofnode scenes, node;
 	struct expo *exp;
diff --git a/boot/scene.c b/boot/scene.c
index 56569e76e9f..1369bcda13b 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -71,13 +71,6 @@ void scene_destroy(struct scene *scn)
 	free(scn);
 }
 
-int scene_title_set(struct scene *scn, uint id)
-{
-	scn->title_id = id;
-
-	return 0;
-}
-
 int scene_obj_count(struct scene *scn)
 {
 	struct scene_obj *obj;
diff --git a/include/expo.h b/include/expo.h
index 658ff003835..8e834b50e4f 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -540,15 +540,6 @@ void scene_set_highlight_id(struct scene *scn, uint id);
  */
 int scene_set_open(struct scene *scn, uint id, bool open);
 
-/**
- * scene_title_set() - set the scene title
- *
- * @scn: Scene to update
- * @title_id: Title ID to set
- * Returns: 0 if OK
- */
-int scene_title_set(struct scene *scn, uint title_id);
-
 /**
  * scene_obj_count() - Count the number of objects in a scene
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 75f31fe6690..c7b8e9ba674 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -152,7 +152,7 @@ static int expo_scene(struct unit_test_state *uts)
 	scn = NULL;
 	id = scene_new(exp, SCENE_NAME2, 0, &scn);
 	ut_assertnonnull(scn);
-	ut_assertok(scene_title_set(scn, title_id));
+	scn->title_id = title_id;
 	ut_asserteq(STR_SCENE_TITLE + 1, id);
 	ut_asserteq(STR_SCENE_TITLE + 2, exp->next_id);
 	ut_asserteq_ptr(exp, scn->expo);
-- 
2.34.1

