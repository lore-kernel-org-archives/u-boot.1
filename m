Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC23FC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3E882063;
	Wed, 19 Mar 2025 15:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mT65qlJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4182C82047; Wed, 19 Mar 2025 15:55:56 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C4AD81FE8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso34798085e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396153; x=1743000953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uopyYxNhOsnFv98/IuAPe66vU338qw3jB8CjKxIadEs=;
 b=mT65qlJBz1dU7SKvNUDLSEQ1L4Ig+jpid9fKzueZlgO00KT8gxjJkf5nmkHcfFe3MN
 f+vdzfIKcSkh0qtIKFG9qSPlT3v9t4XpTqiK1ah0yD3nyyU0MI91JMIXWiKXOhh0gTG8
 S0FZJi2QrnmSi62GXAeZPk2ZL+62rmHdXj00M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396153; x=1743000953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uopyYxNhOsnFv98/IuAPe66vU338qw3jB8CjKxIadEs=;
 b=Y8TveA+cm6K+GcgnoatlY74v5K8I7AwQquQq7GUGokNWSYul0q4QotvFUX0Lfqi9+7
 aQSOc1CFWxnAa4fiiLAEbAXjxq3n/HHzgyzw7OGgJoeN1hvkeka2h6VuR9za2m1mT/Q1
 l98D1fqaNA9CRA8p0COhmOfe8Vr5QByLe4Ph6fH1rGzc17bOPYbrDq3Gn3UabVdqhTW8
 A+oPMQpQx1E3BMUMb6n7YDm/NRDfIYhlhcbKd0c/wvoCnA0VnOJG2as88ku80JCR2zoE
 p53ajHKn4EvzVrep/tHJOyQgC1f6ffKvbU4CVNfCvllkzbD8S/k2rrdJE/xApXvGC4IA
 ttAA==
X-Gm-Message-State: AOJu0YzKdDTIUGNNFCSqVjGPtL4sH4fJx9UopiTk/WJg87cgBdvUVb7F
 7Ooi5W7RMwFzqvRmBjmzGPrCPOUMHU/7RFR2XOuwF92HWqk7qqHVk/388HU/Yye1MuvmXiHbDaE
 =
X-Gm-Gg: ASbGnct6EwsXfa3bEXEnokSVV0/n9zYzkq+kbkSIGs2O0+N/DsaEo1G4YOJLYkXqZg+
 v61wIgCI6DtepXrOZDLq5JDKvHYnDzHcYiWEWQzgkZ7NU4V9eRIdGV1kBt7VvL0skwsAiRO5NYW
 F26Ztz6Mh/UdBA6pT7qtp4g8pFX/9sFq8Wf7m1dJXKYpNt+Oq6GhHEeqdEcMaRRSQtTq7izTtvE
 /R+eZjvSlb63hXfQjY2/7oLBCCAifzjIGpIbFax4GsC3dYbvNDmMx6s1eaFPqh3u9SlQkYeSD5H
 aBI2ucK7TbgHMswp8M80kpNwMa8UT4hL8DsLCDSHfA==
X-Google-Smtp-Source: AGHT+IHJVq/PSteorimb0Ojq6YpKGfKUbCRBebg2b4zBrfKYovKWHIhrY5rKuPFWvaXJqfVV0FdENg==
X-Received: by 2002:a05:600c:198e:b0:43c:fffc:786c with SMTP id
 5b1f17b1804b1-43d437fe6e5mr28814665e9.19.1742396153077; 
 Wed, 19 Mar 2025 07:55:53 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/52] expo: Add CLI context to the expo
Date: Wed, 19 Mar 2025 15:54:18 +0100
Message-ID: <20250319145512.2391122-14-sjg@chromium.org>
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

An expo generally needs to keep track of the keyboard state while it is
running, so move the context into struct expo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

