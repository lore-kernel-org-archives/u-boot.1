Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BE2C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74A7B8288B;
	Wed, 19 Mar 2025 15:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zmm7LZtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A313F8283E; Wed, 19 Mar 2025 15:56:55 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864A882107
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3793145f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396212; x=1743001012; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJ+2clbUbaqa5wie662PDH1cFV5MX8o5lbokm5hlUtI=;
 b=Zmm7LZtEjwdyRs7dHfg5BuYJ43n2GG5HAR2TranzPZz1Or581Zbola4cjoo1xrLv2w
 AvPK6f59vTvbRk8Y5jF9zD4gRmAeYrwAJbfiaUp/HzrrYv3qnhlVWhuRN2uPfutys89W
 V5T4jaNBn9aK6eifZCWD9McKAMIg7BEwWsiUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396212; x=1743001012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJ+2clbUbaqa5wie662PDH1cFV5MX8o5lbokm5hlUtI=;
 b=F5Gdm5VLpVKUOEC38lwgfV31wKKRZKW271kEjgdf1J7XxwD3ULgs9VXOpt4Fn2Yojf
 ZbIAUNdvntlfFYtFehlaDB+zM8bBq4mKxtCf5JdrZ4WwHxL5HlKZgygqoxSBH+FNTJvK
 EEU802EudVlI2r1o5wvba/QlRNyvPa8UCLEIlB62MAwmW8my5eQLV4zOuyCGlQethckP
 ZNuBczFKeCmJYoQwC48k9YrQJn6f81vi2ijjGnP2U7luVuez4af2XNuxP05bRj/8swYp
 LZw7BvrxPB2tLzyHYeo3ExQ1sVgd9kj9mlk7a1Nj8DQr7xiCrsEP3B4YnYth7EHoEokv
 A8jg==
X-Gm-Message-State: AOJu0YxXUjNoF8kn+RjgvPUTx3NiCLlWCBMBNewPfDnCBxYBqHHdmZCF
 TbNJKVB1HVs+P+jIb5ygYuiX8F/VkQEhqUxIZQ40spOPqM0z2Smvm7E21rMxplRGBcEjdqARo/Q
 =
X-Gm-Gg: ASbGncue3Qq8XEFQRdFmy003Lc40KJoZQWGq5AnTuiSRsQOn9eCuVzzTfD0Mme9uZOr
 8yQWOYPAaenqlhnTDLYk/2e82SRmlv359KeVM5VbWvd+oKYot8dq8jeG+2rlwJzgHVp2VAKfbf3
 mWSXBJSxqtenuKDLpk+GvFJuLHxghgqVAO+i/9yO+21SA3r3unebO6OCDyOsBoDFg8qbLkYFYxy
 /YVW1rlHy7OqGVq0PsU6qodhd2QnnX6FvSDsUFD+Wxso1sncQXxS+YyhooqlUEVvFvOEv6RqFh3
 x7AcwvMnGw47vDJ2Xq4XSJ7ksC5UY73cqzTowitJIhn10nzEUisc
X-Google-Smtp-Source: AGHT+IEhJ3d2JDp7mlUqpUolS8b4xZy62UE8uUPtmPTjyOhzJptas+0oBk2a36MCRi4oorjvIQr6YQ==
X-Received: by 2002:a05:6000:178d:b0:391:30f0:1704 with SMTP id
 ffacd0b85a97d-399739b45e9mr2243240f8f.4.1742396212424; 
 Wed, 19 Mar 2025 07:56:52 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 46/52] expo: Drop the render from expo_poll()
Date: Wed, 19 Mar 2025 15:54:51 +0100
Message-ID: <20250319145512.2391122-47-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Within tests it is useful to be able to control rendering of the expo.
Drop the automatic call to expo_render() within expo_poll() and adjust
its callers to handle this instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c   | 1 +
 boot/expo.c    | 2 --
 cmd/bootflow.c | 1 +
 include/expo.h | 9 ++++++---
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 46a48d69347..e9fdd355b7e 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -213,6 +213,7 @@ int cedit_run(struct expo *exp)
 	do {
 		struct expo_action act;
 
+		LOGR("cer", expo_render(exp));
 		ret = expo_poll(exp, &act);
 		if (!ret) {
 			cedit_do_action(exp, scn, vid_priv, &act);
diff --git a/boot/expo.c b/boot/expo.c
index bf2f1dfc68a..4f96b5ee973 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -320,8 +320,6 @@ int expo_poll(struct expo *exp, struct expo_action *act)
 {
 	int ichar, key;
 
-	LOGR("ere", expo_render(exp));
-
 	ichar = cli_ch_process(&exp->cch, 0);
 	if (!ichar) {
 		int i;
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 2871d91dd29..b8f61f966fb 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -114,6 +114,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 	LOGR("bhs", bootflow_menu_start(std, text_mode, &exp));
 
 	do {
+		LOGR("bhr", expo_render(exp));
 		ret = bootflow_menu_poll(exp, &bflow);
 	} while (ret == -EAGAIN);
 	// printf("ret %d bflow %p\n", ret, bflow);
diff --git a/include/expo.h b/include/expo.h
index dfecd6ed239..2addddd5012 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -1006,10 +1006,13 @@ int expo_build(ofnode root, struct expo **expp);
 int cb_expo_build(struct expo **expp);
 
 /**
- * expo_poll() - render an expo and see if the user takes an action
+ * expo_poll() - see if the user takes an action
  *
- * Thsi calls expo_render() and then checks for a keypress. If there is one, it
- * is processed and the resulting action returned, if any
+ * This checks for a keypress. If there is one, it is processed and the
+ * resulting action returned, if any.
+ *
+ * Note that expo_render() should normally be called immediately before this
+ * function so that the user can see the latest state.
  *
  * @exp: Expo to poll
  * @act: Returns action on success
-- 
2.43.0

