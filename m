Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D418C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:16:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7A2828BC;
	Fri, 28 Mar 2025 14:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EHhbxnKi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A59782824; Fri, 28 Mar 2025 14:09:02 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B46D182169
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85e46f5c50fso183939739f.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167338; x=1743772138; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTriIyuH1ndeE0z4YrjI20yERQqsbpc82g5Nf62vGzo=;
 b=EHhbxnKicyZn0+p0RlkRSHj2n8alsmr3B2LwyWp2sJvmnhDfHrUyMDFafAg8XxJm7c
 gDS64j6ricABq4QJJP61ft0PdFhX6f7+sfXoqUTUVD+S6INGA+OESFWfoF6O8S2bt/TI
 49CHcU5hDaF3D4R3PT9k/H1NA/s4p/FNSA6LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167338; x=1743772138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTriIyuH1ndeE0z4YrjI20yERQqsbpc82g5Nf62vGzo=;
 b=djyM+CEO50c0mVK07qT+TaChCn2FJdDSMdOVZQibUWIQy7T92aclxErn53MknNBQUl
 Qrm4/e4QxXIvBfub1oQ7xPh+VvgO6B9nWANqbcykdOzlBDvXfxd9Cd+YlerVnKiOuqzY
 KNt1eY8UjsZ9jaDjj5SL9wAn+WpuVTx8qsLd8kMJ8T3xzOxoQ9w8Wj8K6NBNYAwIfAcY
 ExPbyVgP2GzGV7Mzgz2NqagBvNCOHHQbaNbbAUV/rZqF5HO3ZJoeSTFyKZnNcsGog0qJ
 yo/ioYfJLhXUALeX9dieavNTzVozi8Nn8oKmPQlH46lugwusqvFs3QQhNH8bo/gqWRE1
 5qaQ==
X-Gm-Message-State: AOJu0Yzw5j27ksH1kUNRHwtESne4+uh2J/WflbGCbrnxQJrA2VX1zOX+
 CefBok3MbwuOrfTBuYTQNY+C1M4p3PgiPHZyxgflVy2o5CW0XplVpPpREpAyn9VtmAsmnvoil2g
 =
X-Gm-Gg: ASbGncv9EwjzCXtgQvQsLxCru0wJ66Lz0SFb8lFiDPwSrCQ0V8QhiJBHvXtlU9YifAc
 ZLR91Izy59tl3cbuBKpG3YfLlSa458nKrCdIqHKn1UNOxZdm4Gp/E2qkpo7SFt+8Tt6zVvXAhIk
 Xjp+5kCTrrZ1gr5+kuIBTFuxndBTR8i15jsLG2fY+yj411LgkVQJdHeEG/eAieLf0GYCOqZujWj
 CyUB8dqH5qojFqpUGWbru3UlJ3Rw/8RaTwJFIZeX6b9g+QpLt09ciEkjVZdEGlbTMiSqejwzpn9
 oMZIPazEGVKnG3pdQ5CCWGduy6rc6ajSaYNrxk6xnLUbDrlf9Zh8Uny8t4FhFhfScDBUVWafEd7
 0rjXThAGWvB/W8R0B
X-Google-Smtp-Source: AGHT+IED080XgRPEwdJK1ETs0mOASp2J//90QHH9m+Yt6j7ZP+NC+CSUVFw/HBM2ye1C7p4FnNd6Rg==
X-Received: by 2002:a05:6602:3718:b0:85e:2eac:4cf1 with SMTP id
 ca18e2360f4ac-85e81eb7087mr962827239f.0.1743167337809; 
 Fri, 28 Mar 2025 06:08:57 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 53/56] expo: Update bootflow_menu_poll() to return a
 sequence ID
Date: Fri, 28 Mar 2025 07:06:40 -0600
Message-ID: <20250328130713.2612648-54-sjg@chromium.org>
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

Rather than returning a bootflow, return the index of the bootflow. This
will allow callers to do their own translation to bootflows or some
other data structure.

Also return a special code when the user tries to move the pointer, so
that the caller can cancel the boot-menu timeout, if this is in use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 32 +++++++++++++-------------------
 cmd/bootflow.c       | 11 +++++++----
 include/bootflow.h   |  8 ++++----
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index a44c340167c..7e131de3f6d 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -290,32 +290,26 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	return 0;
 }
 
-int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
+int bootflow_menu_poll(struct expo *exp, int *seqp)
 {
 	struct bootflow *sel_bflow;
 	struct expo_action act;
-	int ret;
+	struct scene *scn;
+	int item;
 
 	sel_bflow = NULL;
-	*bflowp = NULL;
+
+	scn = expo_lookup_scene_id(exp, exp->scene_id);
+
+	item = scene_menu_get_cur_item(scn, OBJ_MENU);
+	*seqp = item > 0 ? item - ITEM : -1;
 
 	LOGR("bmp", expo_poll(exp, &act));
 
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
 
@@ -323,13 +317,13 @@ int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
 			return log_msg_ret("bms", -ENOENT);
 		LOGR("bmp", scene_menu_select_item(scn, OBJ_MENU,
 						   act.select.id));
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
index 1ccd473b267..3c367a10c8a 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -109,14 +109,16 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 {
 	struct expo *exp;
 	struct bootflow *bflow;
-	int ret;
+	int ret, seq;
 
 	LOGR("bhs", bootflow_menu_start(std, text_mode, &exp));
 
+	ret = -ERESTART;
 	do {
-		LOGR("bhr", expo_render(exp));
-		ret = bootflow_menu_poll(exp, &bflow);
-	} while (ret == -EAGAIN);
+		if (ret == -ERESTART)
+			LOGR("bhr", expo_render(exp));
+		ret = bootflow_menu_poll(exp, &seq);
+	} while (ret == -EAGAIN || ret == -ERESTART);
 
 	if (ret == -EPIPE) {
 		printf("Nothing chosen\n");
@@ -124,6 +126,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
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

