Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17ACCE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8DC87269;
	Mon,  2 Oct 2023 03:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K83X2xud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9986D870EA; Mon,  2 Oct 2023 03:18:02 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7054B87243
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fa2125e19so506084139f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209383; x=1696814183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMZt3NAo41qXyBI7M75GvdM9AhkhHzy9jzVE4YbMLmU=;
 b=K83X2xud1vV+tY+8ePINOoBq0yKi67CXesaHP7HykWwFaXZjw7CWsK+nMQZGC6eRzG
 4P3dkO77ehiaPtgvijMMLKxI+lstVaM9NFoaB6h7nJV6WxiYEktzpYzMzGlF/TyAIPvh
 /6hYdydGLfrvSXqjLd+5+tswI5KinRNjaetGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209383; x=1696814183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MMZt3NAo41qXyBI7M75GvdM9AhkhHzy9jzVE4YbMLmU=;
 b=KkJ2GDh6XqtG3lwJv2tZudIYqUXsT1qqmyV+zgDCLRdXztXdkD/0aLs2B8+YYXeAQ9
 5hkK3HwsQ9C1tfwepXAhuPG+Up6lFE2zptLBHpBa2OH1vfnTnUWQ6KyIgw8wUa8pY5Q2
 THNum7zMKOLdk2UPkDqv1uPAyJ/LlNT6vIn8hA6Rk7cOWyh34321HHxaE5zXF5sFlOGH
 TadzTZr8mMGc+DZTEAHb8F6G35dxxhIWdu6Cz6eC9KJR5LlmInIIUwl7U7SXRivumb9M
 1KY19g89geCvnmnxwMgnIX042I1ttEpO1Tyi3XbjjsdNGqLUazn5TcXXC1AZ3LLCtU6q
 AWZg==
X-Gm-Message-State: AOJu0YxnAYRmYh1tapSKs7fqGaQjGLXXMbV9mJNqCEq87spITH5swfMJ
 0r3xvayHwG+ktMBQFbCXIahCryyPzowMQp2ElKE=
X-Google-Smtp-Source: AGHT+IGTM8hz+9pJrIKDmFkL6IjoQIFd+8iQQ4yIlmI6VS99bTBTrQn4PHbpoUvqoloSHv1aTmvZSA==
X-Received: by 2002:a05:6e02:1112:b0:351:80c:bc29 with SMTP id
 u18-20020a056e02111200b00351080cbc29mr10109521ilk.17.1696209383347; 
 Sun, 01 Oct 2023 18:16:23 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 19/34] expo: Set the initial next_id to 1
Date: Sun,  1 Oct 2023 19:15:29 -0600
Message-ID: <20231002011553.463514-20-sjg@chromium.org>
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

If expo_set_dynamic_start() is never called, the first scene created
will have an ID of 0, which is invalid. Correct this by setting a
default value.

Add a test to check this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/expo.c      |  1 +
 test/boot/expo.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index d030820e77ca..20ca0b9bfa0a 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -30,6 +30,7 @@ int expo_new(const char *name, void *priv, struct expo **expp)
 	exp->priv = priv;
 	INIT_LIST_HEAD(&exp->scene_head);
 	INIT_LIST_HEAD(&exp->str_head);
+	exp->next_id = 1;
 
 	*expp = exp;
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 714fdfa415d1..8a84cbc71032 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -92,7 +92,7 @@ static int expo_base(struct unit_test_state *uts)
 	*name = '\0';
 	ut_assertnonnull(exp);
 	ut_asserteq(0, exp->scene_id);
-	ut_asserteq(0, exp->next_id);
+	ut_asserteq(1, exp->next_id);
 
 	/* Make sure the name was allocated */
 	ut_assertnonnull(exp->name);
@@ -131,7 +131,7 @@ static int expo_scene(struct unit_test_state *uts)
 	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
 
 	scn = NULL;
-	ut_asserteq(0, exp->next_id);
+	ut_asserteq(1, exp->next_id);
 	strcpy(name, SCENE_NAME1);
 	id = scene_new(exp, name, SCENE1, &scn);
 	*name = '\0';
@@ -168,6 +168,25 @@ static int expo_scene(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(expo_scene, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
 
+/* Check creating a scene with no ID */
+static int expo_scene_no_id(struct unit_test_state *uts)
+{
+	struct scene *scn;
+	struct expo *exp;
+	char name[100];
+	int id;
+
+	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
+	ut_asserteq(1, exp->next_id);
+
+	strcpy(name, SCENE_NAME1);
+	id = scene_new(exp, SCENE_NAME1, 0, &scn);
+	ut_asserteq(1, scn->id);
+
+	return 0;
+}
+BOOTSTD_TEST(expo_scene_no_id, UT_TESTF_DM | UT_TESTF_SCAN_FDT);
+
 /* Check creating a scene with objects */
 static int expo_object(struct unit_test_state *uts)
 {
-- 
2.42.0.582.g8ccd20d70d-goog

