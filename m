Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06E1C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:55:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54FE82C65;
	Fri,  2 May 2025 16:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Muq9z8tm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AEE82BAB; Fri,  2 May 2025 16:49:21 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8869682BAB
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso209647839f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197358; x=1746802158; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T6v6fToY/SIFscjMOTNH+2aEDNyOADZCVTlt2VNeP3I=;
 b=Muq9z8tmPMT3p6mdYsm+a/iQsYBKBzkgGugUiuAXsvDAIc2Uhqg7TmfhlvykP039Le
 OSwMiKOJNKoXk881Zht8V7rBKza9Gk63JeiYBCZs7f5oJWKLa5H4Z5WzrQHEBodbya8Z
 3zsbCAK4DZVeAYlFfQNiiBbSr2Rik6D9LpHD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197358; x=1746802158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T6v6fToY/SIFscjMOTNH+2aEDNyOADZCVTlt2VNeP3I=;
 b=kVspOHXClsV8aOIjmjs27dSEDHEH9FDYwCTCbH8eX68t8UBKpISeWVMwSpio7Nq+UU
 R9DY8/MgrymBt5wour3vMbYywg94TkxzhPORbQDiN3+/zqouzS7zmx4a34TeemzJfKRq
 zTiKhR6eScXWA/0gBeMnaVQtUoUEnmPOfvyR04clT+Te4sLUix88MUade8n2nvJFJovK
 Ulsz+SuZXax3lmms/Cpo+vtVednnLjQYbaGbxgTYbggSS6Hk0pJL7LBSRSPb6YllgseK
 H7wEd/TckUFS8rzIwGtX4l7FOyyS6FOl1CXGXar2q686/RUtWOhPsmcoe4vIHdA2I660
 PKLA==
X-Gm-Message-State: AOJu0Yyo39TZ7hrg3VvhV/FmfObrwdqXZtNPufjQRWA8o/opdFdnp6CT
 Iq+lXVPtM8FSREu1vgHLH6UIRF6icp2mlcJjtNRLZvx6UteP2C6zPiMR3WuvO06wRPUaPrgYuZc
 =
X-Gm-Gg: ASbGncv2LhbLUkOmUjyd0xbQ3/7Ms8WS/5IvbqyMJYRX05CVV/jsuxpjivTkiU76fMI
 ZeCOsze3WLYH2ZAqc/hRXyGntrXCXxF1raq5a0gzTa+ruPniJny03bmZq2I443xSFBYklXQxGz7
 iZ2ombAq5hKVl0s7GMZrwrHdTXuQ/kh7j0juQTS1lyTqpzN2WTP1oWNdZoVtSBFq9BymZU5ZZ6P
 gdl68xvOCUYfaKO1lswgjhYqDctm55cH7ErY2XiNCOo6WjUKqRhWnOfBof+OdVVhq5ptBJw3LeD
 7osqgv/PunRjS6oUfapHiXxbBwxcmjbryK4Us5CSdM7cZOU0ytMqWUye9+bScBLZj5RDzEb9KCF
 sRdfWLL6+zl9i
X-Google-Smtp-Source: AGHT+IH+RPHkv3vfbXk45FNjHWFcUGHXOdYStZQ+cfyXiaeyTgvROs5LIODOAMc6j/ZZFkaEyju24g==
X-Received: by 2002:a05:6602:6cc1:b0:85b:3c49:8811 with SMTP id
 ca18e2360f4ac-8669f9bb649mr523734639f.4.1746197357765; 
 Fri, 02 May 2025 07:49:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 57/60] expo: Update bootflow_menu_poll() to return a
 sequence ID
Date: Fri,  2 May 2025 08:46:55 -0600
Message-ID: <20250502144718.313633-58-sjg@chromium.org>
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

Rather than returning a bootflow, return the index of the bootflow. This
will allow callers to do their own translation to bootflows or some
other data structure.

Also return a special code when the user tries to move the pointer, so
that the caller can cancel the boot-menu timeout, if this is in use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 32 +++++++++++++-------------------
 cmd/bootflow.c       | 16 ++++++++++------
 include/bootflow.h   |  8 ++++----
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index fb90e51e920..6bca17142ad 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -301,34 +301,28 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	return 0;
 }
 
-int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
+int bootflow_menu_poll(struct expo *exp, int *seqp)
 {
 	struct bootflow *sel_bflow;
 	struct expo_action act;
-	int ret;
+	struct scene *scn;
+	int item, ret;
 
 	sel_bflow = NULL;
-	*bflowp = NULL;
+
+	scn = expo_lookup_scene_id(exp, exp->scene_id);
+
+	item = scene_menu_get_cur_item(scn, OBJ_MENU);
+	*seqp = item > 0 ? item - ITEM : -1;
 
 	ret = expo_poll(exp, &act);
 	if (ret)
 		return log_msg_ret("bmp", ret);
 
 	switch (act.type) {
-	case EXPOACT_SELECT: {
-		struct bootflow *bflow;
-		int i;
-
-		for (ret = bootflow_first_glob(&bflow), i = 0; !ret && i < 36;
-		     ret = bootflow_next_glob(&bflow), i++) {
-			if (i == act.select.id - ITEM) {
-				*bflowp = bflow;
-				// printf("found %p\n", bflow);
-				return 0;
-			}
-		}
+	case EXPOACT_SELECT:
+		*seqp = act.select.id - ITEM;
 		break;
-	}
 	case EXPOACT_POINT_ITEM: {
 		struct scene *scn = expo_lookup_scene_id(exp, MAIN);
 
@@ -337,13 +331,13 @@ int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
 		ret = scene_menu_select_item(scn, OBJ_MENU, act.select.id);
 		if (ret)
 			return log_msg_ret("bmp", ret);
-		break;
+		return -ERESTART;
 	}
 	case EXPOACT_QUIT:
 		return -EPIPE;
 	default:
-		break;
+		return -EAGAIN;
 	}
 
-	return -EAGAIN;
+	return 0;
 }
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index dda5742db73..6ffb1bd33e1 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -109,18 +109,21 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 {
 	struct expo *exp;
 	struct bootflow *bflow;
-	int ret;
+	int ret, seq;
 
 	ret = bootflow_menu_start(std, text_mode, &exp);
 	if (ret)
 		return log_msg_ret("bhs", ret);
 
+	ret = -ERESTART;
 	do {
-		ret = expo_render(exp);
-		if (ret)
-			return log_msg_ret("bhr", ret);
-		ret = bootflow_menu_poll(exp, &bflow);
-	} while (ret == -EAGAIN);
+		if (ret == -ERESTART) {
+			ret = expo_render(exp);
+			if (ret)
+				return log_msg_ret("bhr", ret);
+		}
+		ret = bootflow_menu_poll(exp, &seq);
+	} while (ret == -EAGAIN || ret == -ERESTART);
 
 	if (ret == -EPIPE) {
 		printf("Nothing chosen\n");
@@ -128,6 +131,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 	} else if (ret) {
 		printf("Menu failed (err=%d)\n", ret);
 	} else {
+		bflow = alist_getw(&std->bootflows, seq, struct bootflow);
 		printf("Selected: %s\n", bflow->os_name ? bflow->os_name :
 		       bflow->name);
 		std->cur_bootflow = bflow;
diff --git a/include/bootflow.h b/include/bootflow.h
index aa46cec4979..8362cbe2e69 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -671,10 +671,10 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
  * bootflow_menu_poll() - Poll a menu for user action
  *
  * @exp: Expo to poll
- * @bflowp: Returns chosen bootflow (set to NULL if nothing is chosen)
- * Return 0 if a bootflow was chosen, -EAGAIN if nothing is chosen yet, -EPIPE
- *	if the user quit
+ * @seqp: Returns the bootflow chosen or currently pointed to (numbered from 0)
+ * Return: 0 if a bootflow was chosen, -EAGAIN if nothing is chosen yet, -EPIPE
+ *	if the user quit, -ERESTART if the expo needs refreshing
  */
-int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp);
+int bootflow_menu_poll(struct expo *exp, int *seqp);
 
 #endif
-- 
2.43.0

