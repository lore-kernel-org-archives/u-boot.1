Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720B1C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C08829C7;
	Fri,  2 May 2025 16:48:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hf/CSejp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392EA82A5E; Fri,  2 May 2025 16:48:01 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DE3982A4D
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-86135ae2a29so210839939f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197276; x=1746802076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bG9PWWqpyhQacAzZtnDnRaMMSR0uXhg140TZZOZls2A=;
 b=Hf/CSejpkcywyqvx5U7p1QSiwZSVXPT70+Q1u4s/1NE2dbniaPC9mAJBr+Z+2lnKtb
 qCH4hZTF0bYIYVrsp8VmE2x5/I7dbtdJic+67ia7Ofl7JeOsTlme6o2Dpy6aSwpcljsF
 OLSwft2yGwv3klYWRokH+DUyo1+pse7FnxpTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197276; x=1746802076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bG9PWWqpyhQacAzZtnDnRaMMSR0uXhg140TZZOZls2A=;
 b=Ll8ibxuFkN4i7VNs20bkT4sPvKuWnL7UfmUf5vVWQncKl5AqqOPKK5AMXIWNIP/i9F
 mMunTvIPJ4P6+XV/ZiIYcBGtgDAnNWcQNwboWO9rcmz27kyBz8C1H9P+Y8teNwyj521b
 IF6GdRT/j0ZOTFUJM9ZSBufgzr7P0L3Z4n0RFs5+0as4pz+FQ48mfv9TM5OhT72T5I0M
 KGWXhGjfcnQfouc6KjLk67dqD+MTNryctgV2m3m5TO9yQihz5E9FmlHVq2lOX55fyocg
 bjHvyaMqbL5p4YXEl7oYgaocQxq6Rwa9epK/5LEE9JT9ietWYYjF1a6ZPtcK3AuVp9EB
 bHGg==
X-Gm-Message-State: AOJu0YwjJmjl8s+nUvVb01pJn+Lz3to4uQfu1Blh6rQSxr0smlA5V/fV
 O7uaL8Y6stsO6aK/6702+9DMbBrdiPPGwLr3Sq5ST4vFjHa/L48m3hxuimJI+jNR0jgbg5zv6Ww
 =
X-Gm-Gg: ASbGncuMEUOFKWbZHWDZZbXj1C0BWB05zk9HieD0NkCFasIAY9Y5XpbA6rblkeBb4RU
 MQ+DE0Ji/0i3gKKy7+sF0b5XdNZkfUpx6feQ4lymS/bzjgs4o8gPOOI2vGLlniNTbKy5LhUmbY1
 aNltMMNfYuE6+qga64wM8dOX6GVUnIypy++L0h+nIAok4boLbUldLWBvW9/Ds+PdlVrlgI7Jc7T
 HQkQgktIN1CxVbHOtLIRvP45ZglcvSDxoxC50NG1e+QLzIuL5hBjWS5LTFfafwPeQBa95t040Db
 34rZm23I4kk7bgcgR/CKXNa3DkwgbtVNRcpTBsBfGRoKB9R0azYJQwYAvoIgbrybcLcmRa9YraI
 1Rg==
X-Google-Smtp-Source: AGHT+IFxDXbi4w+YwV4R0jAUkfl0fdxNFkyxpz0fc/wm9sqtpkxmxZ0A+Mo/fINJecEfSqNk13ytaw==
X-Received: by 2002:a05:6602:3990:b0:862:ec81:ad2e with SMTP id
 ca18e2360f4ac-8669f988db3mr470595739f.3.1746197276237; 
 Fri, 02 May 2025 07:47:56 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 17/60] expo: Add CLI context to the expo
Date: Fri,  2 May 2025 08:46:15 -0600
Message-ID: <20250502144718.313633-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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
index 4e80875828b..ed499f11140 100644
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

