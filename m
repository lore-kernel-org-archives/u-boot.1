Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5070CC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FD6879BC;
	Thu,  4 Jan 2024 16:12:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IkDx9EgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124CA879F4; Thu,  4 Jan 2024 16:12:25 +0100 (CET)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D8BC8796B
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-35feb61c91fso2393775ab.3
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381123; x=1704985923; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=spH9iveDREsMKje0GEKZRzDOXP6EqQf1zFe2feZYzKM=;
 b=IkDx9EgIiLPjQtSPuMiR0P0r2XSCZK2M8Rk5mdg8x+OLYZSEKIRh6f5vLwiYF9dy0i
 BCumyV2X3RsJLtDI06H9cIlFgKqKMNc2l4UC2O9SBkI1BVfrAndNJuTebpHY/Mmy0nVd
 D2gJLynMWnQB/dC4clLiJBLoKUaOn+MxU9aAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381123; x=1704985923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spH9iveDREsMKje0GEKZRzDOXP6EqQf1zFe2feZYzKM=;
 b=WVJEsJCh2h1wE6Vfi8Lr2yg6z1c+z2yv2I27F1S8Y4JvZSyDgFbjybYPqc6+YpHaXz
 7M0Hi1RVbcjzEX1iiVOq7iYSgOsHya8HRfeTMf7snPeYWypfQHPHxMh39aO6ir7QPBF/
 LuhXEfTizISW1Vqb/EPyKupoLzXRtsAcufu7CNd3Jps4I9R+tQ9pUdpRcgxjYixC+NBY
 gSLnG/KsIxjXiPQH5lNqC+KrawCtJyev9NVO7BYDC0uk0R7EPDPej4BAGSnsKdQVFFGu
 dmWbbJRXDfheWUkgey8ghKgoEj7lS4IJry5vNEQsCgykQAxYQUhhTlt7dUmPII4RpbCs
 zJpg==
X-Gm-Message-State: AOJu0Yyg8HcNzpcU5Wr4txJW1Ijf4U/ocrsR+zdgbvEmzWWVLgSuK9md
 4kfFQyRa10Jm4Mde/H4WibzCyUfv4MrB3MH9k28c4nZDP4ly
X-Google-Smtp-Source: AGHT+IEPDhI0DSFn3XHgsaFyTZsSnIeRTGM7X7YaO881WkHwsTWCaVfKKhMv/Cmwi90ihszpH4IGxg==
X-Received: by 2002:a05:6e02:221a:b0:35f:c01a:3c3c with SMTP id
 j26-20020a056e02221a00b0035fc01a3c3cmr747711ilf.98.1704381123086; 
 Thu, 04 Jan 2024 07:12:03 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:12:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 04/19] expo: Set the initial next_id to 1
Date: Thu,  4 Jan 2024 08:11:37 -0700
Message-Id: <20240104151152.697855-5-sjg@chromium.org>
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
index d030820e77c..20ca0b9bfa0 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -30,6 +30,7 @@ int expo_new(const char *name, void *priv, struct expo **expp)
 	exp->priv = priv;
 	INIT_LIST_HEAD(&exp->scene_head);
 	INIT_LIST_HEAD(&exp->str_head);
+	exp->next_id = 1;
 
 	*expp = exp;
 
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 714fdfa415d..8a84cbc7103 100644
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
2.34.1

