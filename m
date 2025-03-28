Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1232C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C229181FFC;
	Fri, 28 Mar 2025 14:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YZgkr5/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB81181ECD; Fri, 28 Mar 2025 14:07:47 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AEC781273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b44094782so64606439f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167263; x=1743772063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LqU5hbw95pghnvH0M9VKLZx9MZnguJPgWokPGUqk8Fk=;
 b=YZgkr5/mlUed+FM1CKbhkU8zKFtDuEx4IEg4ZA4/G73hD5MaNNRIYTw4ZPIpK0AlDu
 qNl//KJ6nrEQRlTTlEaWItlw1P/hAD16qJevvfdNfl8zkfSuP2iZbM0TiToWvoYj5Ldw
 M/1zGGc11WiS3jm/YjL8vTaG6FimLFLIiB4IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167263; x=1743772063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqU5hbw95pghnvH0M9VKLZx9MZnguJPgWokPGUqk8Fk=;
 b=X7OP6lSQeprQ966r9/HWaco+/+kQwHOCm/DKX14P4UYntJxK9GFN/ylLIPvlSPf1gv
 QoiQmtah9DKTeH7sMOSJDLmOrALIBFKfhn19v0doRwiIavRN+qO5IEXCkZyzI4OdJtXT
 9DKN514mZrcIsOgT8trBntuUHP4wwWrfNne8EhkBh8KpqtCxIEqhnFqxA7QVqRcCK1I1
 L5eTbxIFtkdngFhMUmbO+OKxrEVoDjyXFuXoBEuL+4l57ByN/XXFbm6UR3Ew3CHQLCz8
 H+e2N8EHHdlw+A5Ou+rWUObqaKlw3x/8ow6PRwHLxEkNW2SMLqmCWuJh2MVqq2DBk7Ep
 XLgA==
X-Gm-Message-State: AOJu0Yzrs1m+w+t7+IJXqly9sf77QCHK6pyBuPmrQyMbrVoASq+8TxBg
 ZC02qXVUg3oDb7rEOOm/9zqRD84qGOsuwwaM7sUUQn04GjCw2FJTgXtUsaPvvynpKf7YjkEHIfw
 =
X-Gm-Gg: ASbGncsJbZd6QR6exHP1a5D5YDikasFblX5UXpIWQ+i8qu13TABp5RYYKiVavK8rMVT
 qHfiDwre2yukg6S3REszcx1exXthXK+jc1VFUtD23u8XD0jiAqchnEYV+ZraohNKdsa2dJclPPZ
 L0DNq+OJK94qaVWqg3OyOwe9/2X7x9URdu1/5KiRSEbSJrLdBCuGmcvVS99/GHoXEMn2YCHM88H
 Y+K469YjFYV9Lb8VzoMokBWDGVZKWEMxM02Ffw6CuzqSfQaH+KfJq59Vv00z7PSxduH6PTGfOHX
 c5cNezXWPkDoDz/+o4V6ORxrKHcpwilgd7PrwFXlL1IYMmkYdMKyIeLVFkutH56Do3Et24LIqDl
 3ivt8FAHbZT9bMDf7
X-Google-Smtp-Source: AGHT+IH30lASCeIq/qzvnBVCxY3gXYNoa0A9kLG+ev7ZIyaMJt8aTS70edlHSwQwIlpJMF5D1hL+Vw==
X-Received: by 2002:a05:6602:3788:b0:85d:b26e:e194 with SMTP id
 ca18e2360f4ac-85e8208744cmr949086539f.7.1743167263076; 
 Fri, 28 Mar 2025 06:07:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 13/56] expo: Add CLI context to the expo
Date: Fri, 28 Mar 2025 07:06:00 -0600
Message-ID: <20250328130713.2612648-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

An expo generally needs to keep track of the keyboard state while it is
running, so move the context into struct expo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 9 +++------
 boot/cedit.c         | 8 +++-----
 boot/expo.c          | 1 +
 include/expo.h       | 2 ++
 4 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 9d0dc352f97..43125e15832 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -178,7 +178,6 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
 int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 		      struct bootflow **bflowp)
 {
-	struct cli_ch_state s_cch, *cch = &s_cch;
 	struct bootflow *sel_bflow;
 	struct udevice *dev;
 	struct expo *exp;
@@ -186,8 +185,6 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 	bool done;
 	int ret;
 
-	cli_ch_init(cch);
-
 	sel_bflow = NULL;
 	*bflowp = NULL;
 
@@ -225,16 +222,16 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 		if (ret)
 			break;
 
-		ichar = cli_ch_process(cch, 0);
+		ichar = cli_ch_process(&exp->cch, 0);
 		if (!ichar) {
 			while (!ichar && !tstc()) {
 				schedule();
 				mdelay(2);
-				ichar = cli_ch_process(cch, -ETIMEDOUT);
+				ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
 			}
 			if (!ichar) {
 				ichar = getchar();
-				ichar = cli_ch_process(cch, ichar);
+				ichar = cli_ch_process(&exp->cch, ichar);
 			}
 		}
 
diff --git a/boot/cedit.c b/boot/cedit.c
index d69290c172e..50d63c8258d 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -151,14 +151,12 @@ int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 
 int cedit_run(struct expo *exp)
 {
-	struct cli_ch_state s_cch, *cch = &s_cch;
 	struct video_priv *vid_priv;
 	uint scene_id;
 	struct scene *scn;
 	bool done, save;
 	int ret;
 
-	cli_ch_init(cch);
 	ret = cedit_prepare(exp, &vid_priv, &scn);
 	if (ret < 0)
 		return log_msg_ret("prep", ret);
@@ -174,16 +172,16 @@ int cedit_run(struct expo *exp)
 		if (ret)
 			break;
 
-		ichar = cli_ch_process(cch, 0);
+		ichar = cli_ch_process(&exp->cch, 0);
 		if (!ichar) {
 			while (!ichar && !tstc()) {
 				schedule();
 				mdelay(2);
-				ichar = cli_ch_process(cch, -ETIMEDOUT);
+				ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
 			}
 			if (!ichar) {
 				ichar = getchar();
-				ichar = cli_ch_process(cch, ichar);
+				ichar = cli_ch_process(&exp->cch, ichar);
 			}
 		}
 
diff --git a/boot/expo.c b/boot/expo.c
index 8ce645e5a8f..9c042f16fe7 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -30,6 +30,7 @@ int expo_new(const char *name, void *priv, struct expo **expp)
 	INIT_LIST_HEAD(&exp->scene_head);
 	INIT_LIST_HEAD(&exp->str_head);
 	exp->next_id = EXPOID_BASE_ID;
+	cli_ch_init(&exp->cch);
 
 	*expp = exp;
 
diff --git a/include/expo.h b/include/expo.h
index 3c383d2e2ee..b3b9c0b8872 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -108,6 +108,7 @@ struct expo_theme {
  * @theme: Information about fonts styles, etc.
  * @scene_head: List of scenes
  * @str_head: list of strings
+ * @cch: Keyboard context for input
  */
 struct expo {
 	char *name;
@@ -122,6 +123,7 @@ struct expo {
 	struct expo_theme theme;
 	struct list_head scene_head;
 	struct list_head str_head;
+	struct cli_ch_state cch;
 };
 
 /**
-- 
2.43.0

