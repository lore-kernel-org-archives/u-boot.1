Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C9C9C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDAE82845;
	Fri,  2 May 2025 16:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b0N7MRuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D8982845; Fri,  2 May 2025 16:48:22 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5386C82AAE
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85dac9729c3so218457939f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197298; x=1746802098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rzsjWcB6ZeJ1gKOtbcCqYip8rhT+F+CTKYNl3WIvZUA=;
 b=b0N7MRuZMD2NfanD4vEtTZJSg1+iDkrD4BuP0iEuowFjol3Frv8SRu8aBhgw/h+Sk+
 mDRQC5WroFu7GmzaPSR6Yk7UGHf4uhU/xfn8Z9BIJg0JudpOSGEKJg1V8cwZZfVD5Xpi
 cV7fSdZOJ5/qHWrfobk5B0wD5m2QzabGGVFCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197298; x=1746802098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rzsjWcB6ZeJ1gKOtbcCqYip8rhT+F+CTKYNl3WIvZUA=;
 b=PfMrT4PNgWyk/akPiwU0m5RijdFPigyz/4J7vYcBlAZu67iqIeKrR5cINQ3tHpNNyk
 23wzeBtkyAAVJQJ0cMNQ7qTlIm8EGlCSLKOnGRggxseFWgN27vDTgiopcixhtq1nWsfW
 dI3WmRhWy+Gcw1ll9oSeGlCt9I5A0/zs0NKwa181itNJm+Un6XQHyKMpTAeHQA3lApYc
 s2qR3ki3MY2riFe9caux0N9vBC1WELpwU3bIZeLAEBA5KohMd68HDhtGwxcTAoYHGhz3
 +1jjRCDhBBEvulmgsD3s3Ncx1Ul96BrM+4Jhg/Q4S1iDp4flF5ygnkA2Cw9FBYT5j3Hg
 5l6w==
X-Gm-Message-State: AOJu0YyTf5rDha1n/BRFCX//V9e+rDQTZO5w+HIqyZ6Tfclwg9xWNU8v
 fON8g7dk0gbEl2je58VNr5gfc5jUgtlRDSW21/fC4J5logZuBER6r6hgrssfUzeF69gBUMmX+Jw
 =
X-Gm-Gg: ASbGncuyGxW32soADY7bd8GLDlQ5muDh/UXFxu9ByPavAfpht3Vj7i6021n900tu3DJ
 S0QH7ax1HEhdIrCiSTigA7NNmLiKOiRBatsTY2nQeLrhPHvh1Z9VNUCfzO5f69MQ5Jx6wnFGVGD
 n43WhAg+ujDdaEaiu2/ZrxjeVOVeLWDd3/O7rIliZA6EsYmAvXtr8i+E0NJOIjZYzE7EFNoaRpR
 iFGSOrVerYXahkLemiZVD/nCRAtIUqTw4cjh4TOu+Alfv7JFcIslxty/HF+1iU/GLSi9vomvPB0
 n1qeNBl2zcZbcX423LdJ3AO04gCLsjimjJY24nJ2wKxkpViHXAZESehlRD5fT4G2u3kI6TrvBsB
 FIQ==
X-Google-Smtp-Source: AGHT+IEkG/R4g/pbaNseW2+LSD+d80VKTqObQ56JeLLxFiVq31Jy8C7z4KaY4zFAiBBj9KH4cNF1Vw==
X-Received: by 2002:a05:6602:4088:b0:85b:482b:8530 with SMTP id
 ca18e2360f4ac-8669fb09e0dmr392602139f.2.1746197298150; 
 Fri, 02 May 2025 07:48:18 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 29/60] expo: Split bootflow_menu_run() into two pieces
Date: Fri,  2 May 2025 08:46:27 -0600
Message-ID: <20250502144718.313633-30-sjg@chromium.org>
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

Split the starting piece of this function into bootflow_menu_start()
and the polling part into bootflow_menu_poll() so that it is possible
for the caller to be in control of the event loop.

Move the expo_destroy() call into the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 89 ++++++++++++++++++++------------------------
 cmd/bootflow.c       | 36 +++++++++++-------
 include/bootflow.h   | 33 ++++++++++------
 3 files changed, 85 insertions(+), 73 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index f9ebc526200..ed7c0768c7b 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -175,20 +175,13 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node)
 	return 0;
 }
 
-int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
-		      struct bootflow **bflowp)
+int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
+			struct expo **expp)
 {
-	struct bootflow *sel_bflow;
 	struct udevice *dev;
-	struct scene *scn;
 	struct expo *exp;
-	uint sel_id;
-	bool done;
 	int ret;
 
-	sel_bflow = NULL;
-	*bflowp = NULL;
-
 	ret = bootflow_menu_new(&exp);
 	if (ret)
 		return log_msg_ret("exp", ret);
@@ -210,58 +203,58 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 	ret = expo_set_scene_id(exp, MAIN);
 	if (ret)
 		return log_msg_ret("scn", ret);
-	scn = expo_lookup_scene_id(exp, MAIN);
-	if (!scn)
-		return log_msg_ret("scn", -ENOENT);
 
 	if (text_mode)
 		expo_set_text_mode(exp, text_mode);
 
-	done = false;
-	do {
-		struct expo_action act;
-
-		ret = expo_poll(exp, &act);
-		if (!ret) {
-			switch (act.type) {
-			case EXPOACT_SELECT:
-				sel_id = act.select.id;
-				done = true;
-				break;
-			case EXPOACT_POINT_ITEM:
-				ret = scene_menu_select_item(scn,
-						OBJ_MENU, act.select.id);
-				if (ret)
-					return log_msg_ret("bmp", ret);
-				break;
-			case EXPOACT_QUIT:
-				return -EPIPE;
-			default:
-				break;
-			}
-		} else if (ret != -EPIPE && ret != -EAGAIN) {
-			return log_msg_ret("bmr", ret);
-		}
-	} while (!done);
+	*expp = exp;
+
+	return 0;
+}
 
-	if (sel_id) {
+int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp)
+{
+	struct bootflow *sel_bflow;
+	struct expo_action act;
+	int ret;
+
+	sel_bflow = NULL;
+	*bflowp = NULL;
+
+	ret = expo_poll(exp, &act);
+	if (ret)
+		return log_msg_ret("bmp", ret);
+
+	switch (act.type) {
+	case EXPOACT_SELECT: {
 		struct bootflow *bflow;
 		int i;
 
 		for (ret = bootflow_first_glob(&bflow), i = 0; !ret && i < 36;
 		     ret = bootflow_next_glob(&bflow), i++) {
-			if (i == sel_id - ITEM) {
-				sel_bflow = bflow;
-				break;
+			if (i == act.select.id - ITEM) {
+				*bflowp = bflow;
+				// printf("found %p\n", bflow);
+				return 0;
 			}
 		}
+		break;
 	}
+	case EXPOACT_POINT_ITEM: {
+		struct scene *scn = expo_lookup_scene_id(exp, MAIN);
 
-	expo_destroy(exp);
-
-	if (!sel_bflow)
-		return -EAGAIN;
-	*bflowp = sel_bflow;
+		if (!scn)
+			return log_msg_ret("bms", -ENOENT);
+		ret = scene_menu_select_item(scn, OBJ_MENU, act.select.id);
+		if (ret)
+			return log_msg_ret("bmp", ret);
+		break;
+	}
+	case EXPOACT_QUIT:
+		return -EPIPE;
+	default:
+		break;
+	}
 
-	return 0;
+	return -EAGAIN;
 }
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 6189ab7fa40..6b43bd50410 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -13,6 +13,8 @@
 #include <command.h>
 #include <console.h>
 #include <dm.h>
+#include <expo.h>
+#include <log.h>
 #include <mapmem.h>
 
 /**
@@ -105,24 +107,32 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 					       bool text_mode,
 					       struct bootflow **bflowp)
 {
+	struct expo *exp;
 	struct bootflow *bflow;
 	int ret;
 
-	ret = bootflow_menu_run(std, text_mode, &bflow);
-	if (ret) {
-		if (ret == -EPIPE) {
-			printf("Nothing chosen\n");
-			std->cur_bootflow = NULL;
-		} else {
-			printf("Menu failed (err=%d)\n", ret);
-		}
+	ret = bootflow_menu_start(std, text_mode, &exp);
+	if (ret)
+		return log_msg_ret("bhs", ret);
 
-		return ret;
-	}
+	do {
+		ret = bootflow_menu_poll(exp, &bflow);
+	} while (ret == -EAGAIN);
 
-	printf("Selected: %s\n", bflow->os_name ? bflow->os_name : bflow->name);
-	std->cur_bootflow = bflow;
-	*bflowp = bflow;
+	if (ret == -EPIPE) {
+		printf("Nothing chosen\n");
+		std->cur_bootflow = NULL;
+	} else if (ret) {
+		printf("Menu failed (err=%d)\n", ret);
+	} else {
+		printf("Selected: %s\n", bflow->os_name ? bflow->os_name :
+		       bflow->name);
+		std->cur_bootflow = bflow;
+		*bflowp = bflow;
+	}
+	expo_destroy(exp);
+	if (ret)
+		return ret;
 
 	return 0;
 }
diff --git a/include/bootflow.h b/include/bootflow.h
index ef1d1a75ded..72f09304cff 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -503,18 +503,6 @@ int bootflow_menu_new(struct expo **expp);
  */
 int bootflow_menu_apply_theme(struct expo *exp, ofnode node);
 
-/**
- * bootflow_menu_run() - Create and run a menu of available bootflows
- *
- * @std: Bootstd information
- * @text_mode: Uses a text-based menu suitable for a serial port
- * @bflowp: Returns chosen bootflow (set to NULL if nothing is chosen)
- * @return 0 if an option was chosen, -EPIPE if nothing was chosen, -ve on
- * error
- */
-int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
-		      struct bootflow **bflowp);
-
 #define BOOTFLOWCL_EMPTY	((void *)1)
 
 /**
@@ -639,4 +627,25 @@ struct bootflow_img *bootflow_img_add(struct bootflow *bflow, const char *fname,
  */
 int bootflow_get_seq(const struct bootflow *bflow);
 
+/**
+ * bootflow_menu_start() - Start up a menu for bootflows
+ *
+ * @std: bootstd information
+ * @text_mode: true to show the menu in text mode, false to use video display
+ * @expp: Returns the expo created, on success
+ * Return: 0 if OK, -ve on error
+ */
+int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
+			struct expo **expp);
+
+/**
+ * bootflow_menu_poll() - Poll a menu for user action
+ *
+ * @exp: Expo to poll
+ * @bflowp: Returns chosen bootflow (set to NULL if nothing is chosen)
+ * Return 0 if a bootflow was chosen, -EAGAIN if nothing is chosen yet, -EPIPE
+ *	if the user quit
+ */
+int bootflow_menu_poll(struct expo *exp, struct bootflow **bflowp);
+
 #endif
-- 
2.43.0

