Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F3C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2096D82093;
	Wed, 19 Mar 2025 15:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W2cIAsTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D26A82093; Wed, 19 Mar 2025 15:55:58 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F4FA81F7B
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso36162835e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396155; x=1743000955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5yTjUOyK2x3A1XrEN5eSWi++ooW4bB7xVRnwmHaB63E=;
 b=W2cIAsTTqVkxcZt3ewPwSiJB+WRitt0ZKEJ6D8Z3/EsOl0WbqDBBJiOoVsQrIgHIza
 JLwZOeSg/F9sGSYtKgmo/oJKNykb6aKU13AaHa0j9ufpv5/eMsYrDkLNrksg3fGFTzkf
 oVtRbgShLKjx5g8HU9JQkJoakEps67zwEbYfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396155; x=1743000955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yTjUOyK2x3A1XrEN5eSWi++ooW4bB7xVRnwmHaB63E=;
 b=UtfDIn7sYGbAxpJ/EODhFhF95Ma62qhXtNQOPKWx7CXhpbIxd5Igv3TwJ67aA9LTZq
 eXo+4hKKdotFMgRnLUwO5k7F64RrKjT1TvayNH97ipkNiEnTklzLTvUSh08Zd0czKV0a
 KXQFe2ho9TGSal2i7riRyKJrVYI7CPCkUf6YsvSHqBtCtiJKIgs7xtTJVTcnr80G4VEo
 7tJuAJze39oY6g8D6/4EWmJfdJObR21D2PLpafL7Db35zq8IABLLIsMoqwh15IWKVGBM
 EM0PsYCypgWNx/f413C2GMlirYtx16l4En3UalhP6Wm02cY/aF0rOPcndESG69ZeK386
 V5Ng==
X-Gm-Message-State: AOJu0YzFKvOIFJ+dKqkss5WjYujo9HlchCOJC6XlNyMbNQWJxxXW36J6
 2CQ3nxtowlEtX3WV2bTylhLa3+nhi1383bOdY86P1+j++OAuRU1RSBbdFoh+VOkgxIK+7JOL8Oo
 =
X-Gm-Gg: ASbGncvGfmuw9LFS/fhyaY4NI8tXGMNws/WB9Y/ysZoJubdEBJh5WWC6zZRdhUBsBfz
 8TqkbAp6hPDToUFuxbh4x5/k2LJ//VnMYhMrTHC0mn8L95+L8HwAE3E5thoPsOjmTB4ru3GvBmL
 B8dLXl510FsLeTW/XCJ7py3lGlaPWCCN+ganqYBSGAalMs/+7kJJGVe18xq9Y8t4h2PKq6hpQ3t
 X5oPVYlLbLflwcH46sza2VCcYRuMZH9ZIQB+R9fUhB+eGlRqkWc88IdXyMf8GmEEi3KQFIlXxJ4
 f4uksOYWMKwCH8DbM31VC6huRobEDsnnVpYIgD5HeQ==
X-Google-Smtp-Source: AGHT+IFSavkDhLtbw+CQMT/qAKeuJ8+/CM48ffmuAuxMJoz4Of/7sdHXeTYJmdzlJ1Fj/9PIgaFFOA==
X-Received: by 2002:a05:600c:b88:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-43d43815fa8mr29212295e9.19.1742396155149; 
 Wed, 19 Mar 2025 07:55:55 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/52] expo: Add a function to poll for input
Date: Wed, 19 Mar 2025 15:54:19 +0100
Message-ID: <20250319145512.2391122-15-sjg@chromium.org>
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

Both bootflow_menu and cedit use similar logic to poll an expo. Move
this into the expo library so the code can be shared.

Update bootflow_menu_run() to return -EPIPE when the user quits without
choosing anything, since -EAGAIN is ambiguous and elsewhere means that
there is no input yet.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 41 ++++-------------------------------------
 boot/cedit.c         | 35 +++--------------------------------
 boot/expo.c          | 38 ++++++++++++++++++++++++++++++++++++++
 include/bootflow.h   |  2 +-
 include/expo.h       | 13 +++++++++++++
 5 files changed, 59 insertions(+), 70 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 43125e15832..e3a27f16daa 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -216,39 +216,8 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 	done = false;
 	do {
 		struct expo_action act;
-		int ichar, key;
 
-		ret = expo_render(exp);
-		if (ret)
-			break;
-
-		ichar = cli_ch_process(&exp->cch, 0);
-		if (!ichar) {
-			while (!ichar && !tstc()) {
-				schedule();
-				mdelay(2);
-				ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
-			}
-			if (!ichar) {
-				ichar = getchar();
-				ichar = cli_ch_process(&exp->cch, ichar);
-			}
-		}
-
-		key = 0;
-		if (ichar) {
-			key = bootmenu_conv_key(ichar);
-			if (key == BKEY_NONE)
-				key = ichar;
-		}
-		if (!key)
-			continue;
-
-		ret = expo_send_key(exp, key);
-		if (ret)
-			break;
-
-		ret = expo_action_get(exp, &act);
+		ret = expo_poll(exp, &act);
 		if (!ret) {
 			switch (act.type) {
 			case EXPOACT_SELECT:
@@ -256,17 +225,15 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
 				done = true;
 				break;
 			case EXPOACT_QUIT:
-				done = true;
-				break;
+				return -EPIPE;
 			default:
 				break;
 			}
+		} else if (ret != -EPIPE && ret != -EAGAIN) {
+			LOGR("bmr", ret);
 		}
 	} while (!done);
 
-	if (ret)
-		return log_msg_ret("end", ret);
-
 	if (sel_id) {
 		struct bootflow *bflow;
 		int i;
diff --git a/boot/cedit.c b/boot/cedit.c
index 50d63c8258d..9baef39a0cd 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -166,39 +166,8 @@ int cedit_run(struct expo *exp)
 	save = false;
 	do {
 		struct expo_action act;
-		int ichar, key;
 
-		ret = expo_render(exp);
-		if (ret)
-			break;
-
-		ichar = cli_ch_process(&exp->cch, 0);
-		if (!ichar) {
-			while (!ichar && !tstc()) {
-				schedule();
-				mdelay(2);
-				ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
-			}
-			if (!ichar) {
-				ichar = getchar();
-				ichar = cli_ch_process(&exp->cch, ichar);
-			}
-		}
-
-		key = 0;
-		if (ichar) {
-			key = bootmenu_conv_key(ichar);
-			if (key == BKEY_NONE || key >= BKEY_FIRST_EXTRA)
-				key = ichar;
-		}
-		if (!key)
-			continue;
-
-		ret = expo_send_key(exp, key);
-		if (ret)
-			break;
-
-		ret = expo_action_get(exp, &act);
+		ret = expo_poll(exp, &act);
 		if (!ret) {
 			switch (act.type) {
 			case EXPOACT_POINT_OBJ:
@@ -233,6 +202,8 @@ int cedit_run(struct expo *exp)
 			default:
 				break;
 			}
+		} else if (ret != -EAGAIN) {
+			LOGR("cep", ret);
 		}
 	} while (!done);
 
diff --git a/boot/expo.c b/boot/expo.c
index 9c042f16fe7..ba052df932c 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -10,8 +10,12 @@
 
 #include <dm.h>
 #include <expo.h>
+#include <log.h>
 #include <malloc.h>
+#include <menu.h>
 #include <video.h>
+#include <watchdog.h>
+#include <linux/delay.h>
 #include "scene_internal.h"
 
 int expo_new(const char *name, void *priv, struct expo **expp)
@@ -286,3 +290,37 @@ int expo_iter_scene_objs(struct expo *exp, expo_scene_obj_iterator iter,
 
 	return 0;
 }
+
+int expo_poll(struct expo *exp, struct expo_action *act)
+{
+	int ichar, key;
+
+	LOGR("ere", expo_render(exp));
+
+	ichar = cli_ch_process(&exp->cch, 0);
+	if (!ichar) {
+		while (!ichar && !tstc()) {
+			schedule();
+			mdelay(2);
+			ichar = cli_ch_process(&exp->cch, -ETIMEDOUT);
+		}
+		if (!ichar) {
+			ichar = getchar();
+			ichar = cli_ch_process(&exp->cch, ichar);
+		}
+	}
+
+	key = 0;
+	if (ichar) {
+		key = bootmenu_conv_key(ichar);
+		if (key == BKEY_NONE || key >= BKEY_FIRST_EXTRA)
+			key = ichar;
+	}
+	if (!key)
+		return -EAGAIN;
+
+	LOGR("epk", expo_send_key(exp, key));
+	LOGR("eag", expo_action_get(exp, act));
+
+	return 0;
+}
diff --git a/include/bootflow.h b/include/bootflow.h
index d988bc9355b..ef1d1a75ded 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -509,7 +509,7 @@ int bootflow_menu_apply_theme(struct expo *exp, ofnode node);
  * @std: Bootstd information
  * @text_mode: Uses a text-based menu suitable for a serial port
  * @bflowp: Returns chosen bootflow (set to NULL if nothing is chosen)
- * @return 0 if an option was chosen, -EAGAIN if nothing was chosen, -ve on
+ * @return 0 if an option was chosen, -EPIPE if nothing was chosen, -ve on
  * error
  */
 int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
diff --git a/include/expo.h b/include/expo.h
index b3b9c0b8872..63452bbdd6a 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -772,4 +772,17 @@ int expo_build(ofnode root, struct expo **expp);
  */
 int cb_expo_build(struct expo **expp);
 
+/**
+ * expo_poll() - render an expo and see if the user takes an action
+ *
+ * Thsi calls expo_render() and then checks for a keypress. If there is one, it
+ * is processed and the resulting action returned, if any
+ *
+ * @exp: Expo to poll
+ * @act: Returns action on success
+ * Return: 0 if an action was obtained, -EAGAIN if not, other error if something
+ *	went wrong
+ */
+int expo_poll(struct expo *exp, struct expo_action *act);
+
 #endif /*__EXPO_H */
-- 
2.43.0

