Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFECE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F2D787213;
	Mon,  2 Oct 2023 03:18:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Pe3W3q+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3FB8725E; Mon,  2 Oct 2023 03:18:29 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E6E087260
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-79fb64b5265so463113939f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209388; x=1696814188; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w5i4GDWU+8KfUVfdN2pN5i2Uhz3iH/pttz7Vw6HUaYM=;
 b=Pe3W3q+Mk0Zgbz1sJHqfA0b8r74yVKMeStCaSBCAbcRJRJRSXZUk8ORiDF3OoLNURT
 f4QdbocVR6PSJcvbN8yqNLK5XdDoyRtjRUCuAZniBq4s0ZqzNQ3C6U5vD24WN/jkel7b
 flfhvSxDnMFdSWE+1KVIw3OK/vsCqRzpstCyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209388; x=1696814188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5i4GDWU+8KfUVfdN2pN5i2Uhz3iH/pttz7Vw6HUaYM=;
 b=nXNuS86MqLGFr9Clalrr57+f2SPailfoYoC/1eI5KKZ1WYL1YJEbwMU62VC9mTwSjW
 f7762t56BS2sE6Le6E1XD/Vs+cEFbAWyYuNaaIIxOweLcgqvGCPknM0t5GdZuxdvcPJu
 jUFkA0aaCIgg6lbnCOlmWNNIywSFuh9frXwnerMauHdY9IDUZMHaIJ1Ovf9IVYjwv/xk
 UMeLTpxlFp39EnLGYoyJQkHWNin+K9n9R4u5p0BrvsRXtsMXd9UECzqWEkxIXYx0sJkS
 J4r59Y7oKRk6s7D8+7lrVGzKgm8naL7HfpzXY3upKBV4n4t5v1MyczPr3l6Q4caugEJ2
 J1kA==
X-Gm-Message-State: AOJu0YzlfaYZFuEI/w3LIAaMefnGKzhBK6cZgkRSJ1dJOKZlzAAaaYD5
 NPLeRwkNkz7BJ82r7ZNuIpYBI6JKi1Ha3gyJm8Q=
X-Google-Smtp-Source: AGHT+IGiakEVwrSEqKkaxUBxsvydoRTO3mI6kFjwjwIWNcNa3Z/iE2MNm6dRZAw6eLVugx7fVsG0ew==
X-Received: by 2002:a6b:fe07:0:b0:790:f866:d717 with SMTP id
 x7-20020a6bfe07000000b00790f866d717mr11020378ioh.10.1696209388162; 
 Sun, 01 Oct 2023 18:16:28 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 25/34] expo: Drop scene_title_set()
Date: Sun,  1 Oct 2023 19:15:35 -0600
Message-ID: <20231002011553.463514-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

 boot/expo_build.c | 4 ++--
 boot/scene.c      | 7 -------
 include/expo.h    | 9 ---------
 test/boot/expo.c  | 2 +-
 4 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/boot/expo_build.c b/boot/expo_build.c
index 88b6f2ea7eb4..b2a651a314b6 100644
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
index 56569e76e9f2..1369bcda13b8 100644
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
index bb329b9776dd..74b45606efe6 100644
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
index 75f31fe66907..c7b8e9ba6749 100644
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
2.42.0.582.g8ccd20d70d-goog

