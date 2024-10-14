Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70341D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3345189294;
	Tue, 15 Oct 2024 00:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IHupdONV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3735E8925E; Tue, 15 Oct 2024 00:32:32 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9147489256
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-83542d9d7c1so206953839f.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945145; x=1729549945; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbMdb8Gao9Swi5XTfv6LFdV8qPuVGjgZfIFKj/x4dck=;
 b=IHupdONVTYbU11QDYkCvQBytxeV5PSAI0ODAihwM3/iXetYm1JGY0Yq5pVidZyY/+W
 ihPM5TZjW/bQMcKbCpKZ+Oi90xZDRLh/SVp86ILE2/fPmpbO4KTNeSv3v79fqxI6iPNn
 KihynnodVJa9m9eYk83PcIJkGgH0/YcEdWBi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945145; x=1729549945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hbMdb8Gao9Swi5XTfv6LFdV8qPuVGjgZfIFKj/x4dck=;
 b=NPFk2H8mp0dJZMHbzK/+RYkY+S0cgaXnxXtYLH0GJlxkQ9Oh6UXxLSKA7Dt5AGp59S
 IeSqnv27hc74IMTvgrSmhxnKvAyQ4F+H/XQe1M63ARBadqI7H8w0rqgk3EYYcsMSF22f
 SDpJU1j794y5PNBHeqCJxd4awzwZ7P5Cg/QlFKmHa9/QIR1ySobE5oQ7H1TzfyTEntDs
 49BoUtTrAl8CiLnzMqBuUP41CoJLaeW33q4pgfMn7O2zKAujCR30o+VomwZ9i+8z8R5Y
 oh4n2kDHZ2zlXEOSB9Wmo8dwQApGvvncC+WLHQgmekpFGfepzct+XvC+nXc8xYCLc1dY
 nAww==
X-Gm-Message-State: AOJu0YydvWIpBMnA0HKRwkQ4X9wfAfbXVad5R8hG5w/PgYAoFOftiETn
 Y8C0NCruZOPXC5z4WOtzvg1XRZ7mIpRILyNzKEhOS554zBoXX+TPI9HG8tSTeTBlxQ1UFhEHXSG
 K9Q==
X-Google-Smtp-Source: AGHT+IFXd5zvziF22tEW4VLwEHh2YY7HYjJNVB1EF1rXijsgsY3G+5DGTXfawyLphuKSp7G677G1eQ==
X-Received: by 2002:a05:6e02:1d8d:b0:3a0:533e:3c0a with SMTP id
 e9e14a558f8ab-3a3b5f31b3bmr119359495ab.7.1728945145170; 
 Mon, 14 Oct 2024 15:32:25 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 10/20] expo: Drop scene_title_set()
Date: Mon, 14 Oct 2024 16:32:02 -0600
Message-Id: <20241014223212.2212442-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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
index 930cc40ec07..d97347e1725 100644
--- a/boot/expo_build.c
+++ b/boot/expo_build.c
@@ -404,7 +404,7 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 	if (ret < 0)
 		return log_msg_ret("tit", ret);
 	title_id = ret;
-	scene_title_set(scn, title_id);
+	scn->title_id = title_id;
 
 	ret = add_txt_str(info, scn_node, scn, "prompt", 0);
 	if (ret < 0)
@@ -420,7 +420,7 @@ static int scene_build(struct build_info *info, ofnode scn_node,
 	return 0;
 }
 
-int build_it(struct build_info *info, ofnode root, struct expo **expp)
+static int build_it(struct build_info *info, ofnode root, struct expo **expp)
 {
 	ofnode scenes, node;
 	struct expo *exp;
diff --git a/boot/scene.c b/boot/scene.c
index a4836000b28..3290a40222a 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -70,13 +70,6 @@ void scene_destroy(struct scene *scn)
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
 	return list_count_nodes(&scn->obj_head);
diff --git a/include/expo.h b/include/expo.h
index acff98ea65b..8cb37260db5 100644
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
index 1c2e746decc..db14ff86f8b 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -151,7 +151,7 @@ static int expo_scene(struct unit_test_state *uts)
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

