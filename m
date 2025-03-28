Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C06FC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1530E81F74;
	Fri, 28 Mar 2025 14:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OLqZ51sE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DB3D81FFC; Fri, 28 Mar 2025 14:07:49 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1082D81F74
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3d46693a5e9so17918955ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167265; x=1743772065; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE3E4/7Mgy6CIQsUmQY8QBYBTLsa8Bp2MR8YOGXOtE4=;
 b=OLqZ51sEBgH3pOkWvbRrIrwH9HusEqM4XfJnTj4cHUyrBE7hVFUF6SOpIEJMUe3QNC
 z10NczrA6/reh9TEMUW2Ch4ceFgRT8ETMMK0CZgA21g1NGs+CY7BhR//1PXWWoPQOGze
 EBPOk9VdAqVeAOsuvDNdkiGpeK4/cFV/ELOaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167265; x=1743772065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vE3E4/7Mgy6CIQsUmQY8QBYBTLsa8Bp2MR8YOGXOtE4=;
 b=k/tI8YSciJZ+MluGfCf1W6dyWF3e0kWdhi3QriFBvI0xfn/L66XjOb+oxD9ka/ljuA
 QX0srroluQOrpk5f+wtOVewfSCUXlNxCxBJbizJQ1NrmGgnr1LlIh5hgJTwcaKaLnnJy
 VhptHrenhTIw8wXPK18qzYdtEyvziWoHVnX7Gk2RK9Ft7Hm7waOdqnleQk06j4ndfMP7
 ILL1pbFf0Ig3Fgxv+96SSXGmDhtOJUNBzFnv4TYp7xYtOfL5PRNlbXlVdZobuky511A/
 U8nc/nc5Fj9REPQnbbL+EKDUX16eibgEGGEl5+yYI0a2VtbMhBmN2pViHXwXtVauesVi
 yK1g==
X-Gm-Message-State: AOJu0Yy8Lo56qhV3AdLcaRGLWa/Tad6Qu79+WTesvfhYyPWtoWYKWTWT
 mLqbinyudUZ+9EPQJxqy2ZSJbmEVC7BEXonpGByIWg/qS0vcSbdJnyEmH7ItvWjjrzn1yXxDhYA
 =
X-Gm-Gg: ASbGncsi2+IFu1e0LZVlZtppvjhHTcV1TkYaNsOLuKoRwAdEkRJ2vYytbEDZiSz2m+C
 kvdpXDeZq9RaDNI8DUQv9HWaCI/pVzkRj4w47my5aoPJPhKUTrRbhuboSG/yl5wEwO/KS69KjJF
 2qcwwLMo80iUu3vm3t3urcYDhi7U/pWQXimQAVFW4cGRbbFfl+tlhVTQPIBvdPVE0y226WMgSby
 AKBKXDJJ8GAJvJTuXHKMOz7woy4NN17n1/QxWD/sa28zvibBfOisgUHFyQae5eQddzrq06KtQno
 qVDzCNtrpfXb32cOHN3Hq09w8rdKjFOCnLeG8tOjRguXDyU/vThuNKnx15K2GSk42/TqIkvKf17
 vVIyiww==
X-Google-Smtp-Source: AGHT+IF4MwTIcRak7N7ZEtIlAIgFwN7F0THIaQK3YLsU3N5o6ljP2cjush63a+3m2Frhy06bqZbiww==
X-Received: by 2002:a05:6e02:3e05:b0:3d3:d4f0:271d with SMTP id
 e9e14a558f8ab-3d5ccdd7a2amr86597805ab.12.1743167265093; 
 Fri, 28 Mar 2025 06:07:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/56] expo: Add a function to poll for input
Date: Fri, 28 Mar 2025 07:06:01 -0600
Message-ID: <20250328130713.2612648-15-sjg@chromium.org>
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

Both bootflow_menu and cedit use similar logic to poll an expo. Move
this into the expo library so the code can be shared.

Update bootflow_menu_run() to return -EPIPE when the user quits without
choosing anything, since -EAGAIN is ambiguous and elsewhere means that
there is no input yet.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 41 ++++-------------------------------------
 boot/cedit.c         | 35 +++--------------------------------
 boot/expo.c          | 38 ++++++++++++++++++++++++++++++++++++++
 cmd/bootflow.c       |  2 +-
 include/bootflow.h   |  2 +-
 include/expo.h       | 13 +++++++++++++
 6 files changed, 60 insertions(+), 71 deletions(-)

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
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 0163129deba..6189ab7fa40 100644
--- a/cmd/bootflow.c
+++ b/cmd/bootflow.c
@@ -110,7 +110,7 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 
 	ret = bootflow_menu_run(std, text_mode, &bflow);
 	if (ret) {
-		if (ret == -EAGAIN) {
+		if (ret == -EPIPE) {
 			printf("Nothing chosen\n");
 			std->cur_bootflow = NULL;
 		} else {
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

