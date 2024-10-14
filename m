Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36A9D18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4708789253;
	Tue, 15 Oct 2024 00:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DtsWGS5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1889F8922B; Tue, 15 Oct 2024 00:32:24 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3ECD89220
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-8354845c5dcso204369239f.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945139; x=1729549939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NUi38tGBqreCxf4mTrq9+emHy68lYmQ8BebZcFwooqg=;
 b=DtsWGS5N/aGtjMQCKzYOVvlX9FgYzo5T4VGxn7fr83aGBMOLqi4q7lYUkO+GwKg3iC
 SP3Jg6ixvoPTQwdkR9DgbAw//qs7V6r1nuc9JVRqhQZD+LJtJ5RhPNiLk7RoBNPYLPQJ
 5op9lsHn/GeAYU6+qs5epwt/ddBhf2vjFmdX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945139; x=1729549939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NUi38tGBqreCxf4mTrq9+emHy68lYmQ8BebZcFwooqg=;
 b=gdH1VrD3Q60HuOlDEVgX4biBqUarjkdogYx3vvjW4q58oo4rYcJlrWkbR6xBI/gacp
 FD5F3UNQlx7664xb8anMce0hQ53Dd9GJz9Z7exQJsaYg2Kgkz93zmX+5BeSq45J4FijW
 NzeqEx5l9PO1l7FaVRpKPDf1KSUhh9V5TWHzSqdOqDpGISb4DwxGGq2UHmOzqgOU4aCj
 Ug3lF/0ZllVmevPeqHUwop5g4Q/29itMdztMihuCAQS4jhi6lzzLuVblBA6sQLQvsEya
 SPZe+Px8g509wOK2Gl/K8kNGL4hetz8SvzFC6O7oGIlFuxHjIotI/iuFzmE2x96Dogz+
 WcNg==
X-Gm-Message-State: AOJu0YymcbDCRAJG8vLtryUvglE+xm81yCrhtuf4IRb1cTDg1QACfkyX
 1/GfnelwSDMjlVYVTTkEM3VvtAXT7VOI4LvyzfCo6gjuU3rEgburMgpTKPi9DcGkQVI99gCwyQO
 VSQ==
X-Google-Smtp-Source: AGHT+IE8eeq45BQIzp7/MgZh7ttRYeosEZqOJ9c+BuOmj6s8xwKn9KM5j2RNMJ327PERbWSfjFe/Fg==
X-Received: by 2002:a05:6e02:13a8:b0:3a0:a385:911d with SMTP id
 e9e14a558f8ab-3a3b5c71f26mr118440865ab.0.1728945139619; 
 Mon, 14 Oct 2024 15:32:19 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 04/20] expo: Set the initial next_id to 1
Date: Mon, 14 Oct 2024 16:31:56 -0600
Message-Id: <20241014223212.2212442-5-sjg@chromium.org>
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

If expo_set_dynamic_start() is never called, the first scene created
will have an ID of 0, which is invalid. Correct this by setting a
default value.

Add a test to check this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c      |  1 +
 test/boot/expo.c | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index c7ce19e834b..700786ec0cc 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -29,6 +29,7 @@ int expo_new(const char *name, void *priv, struct expo **expp)
 	exp->priv = priv;
 	INIT_LIST_HEAD(&exp->scene_head);
 	INIT_LIST_HEAD(&exp->str_head);
+	exp->next_id = 1;
 
 	*expp = exp;
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 9b4aa803eb1..f6a6b4fd2cb 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -91,7 +91,7 @@ static int expo_base(struct unit_test_state *uts)
 	*name = '\0';
 	ut_assertnonnull(exp);
 	ut_asserteq(0, exp->scene_id);
-	ut_asserteq(0, exp->next_id);
+	ut_asserteq(1, exp->next_id);
 
 	/* Make sure the name was allocated */
 	ut_assertnonnull(exp->name);
@@ -130,7 +130,7 @@ static int expo_scene(struct unit_test_state *uts)
 	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
 
 	scn = NULL;
-	ut_asserteq(0, exp->next_id);
+	ut_asserteq(1, exp->next_id);
 	strcpy(name, SCENE_NAME1);
 	id = scene_new(exp, name, SCENE1, &scn);
 	*name = '\0';
@@ -167,6 +167,25 @@ static int expo_scene(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(expo_scene, UTF_DM | UTF_SCAN_FDT);
 
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
+BOOTSTD_TEST(expo_scene_no_id, UTF_DM | UTF_SCAN_FDT);
+
 /* Check creating a scene with objects */
 static int expo_object(struct unit_test_state *uts)
 {
-- 
2.34.1

