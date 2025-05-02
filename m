Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D554FC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DECBD82A39;
	Fri,  2 May 2025 16:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SF9sjttl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4AED82A36; Fri,  2 May 2025 16:48:02 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 639AA8212F
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8616b7ad03bso48039639f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197278; x=1746802078; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9yO72i7rk5cmwLDU43oCZ18mKhehgJ2CJSJdW9TLGE=;
 b=SF9sjttlxKYNXXvGuURy+SMRirj7ahWbPnWOXY70SPwDwoatXQJa7aUxE7bhsf39FB
 KJ1FqJ2KxTovfMRp130gwVSU5MMQTBymMSpQS1cHVLMXCrUNhNKtPTTIE+GiIi/4aRkA
 JHXockDjGugr0JSo0xfWNOXhrza2MYpKtjnWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197278; x=1746802078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9yO72i7rk5cmwLDU43oCZ18mKhehgJ2CJSJdW9TLGE=;
 b=OFNccIbbDXt/G78XdSmJLDmE3adDyb3FSHGn4ZvXrCJEoEZiZkWhVvZWr9ih9hjEY4
 WYSxtIaVMvL+ZpJ+DM6MXRXV3hqi6gYuWfAAlCNqQ8Rv432WnX7Ngnw3BJSmYcFc60jO
 Kmz8QS16DWb6Ye3bGnIfpB+UDp6EExrx8rslUAQN1Ntej7uZY4nx/KVY3HaVbHZzsn34
 XJwTvDrfuuJkzqtPMCehtHydKYPEqCTD+cq724R7t5S5YkkNg3Wfl1z8WbxX8ECEOItu
 sIOkS4wVEK0gD3zeqHOdQUNTJ5Iqk70ArRAxJEhSf3OHkcvdwd52H8+YE5+YI++7/yFt
 vwsA==
X-Gm-Message-State: AOJu0YwpypCNDxBNqBMeVix1njMMUGETTaTn1j6xi2VpwzwaJA+gSR7A
 06M69s46Zxk4tffM24W0pAA1nu+e152RvY2ap3fHOJTRkhwRIWZicpLce2kuiTK/0t9dxdy4HLQ
 =
X-Gm-Gg: ASbGncvf6cGvIUHOJi1soUo3Z3pIWWUcIeQTcWT1wC2w7novNGcRaOvhz8MZLbbqC01
 n5Paiv85eunK2BP2FsyAa2+9DQ7RfF+hxTyB8MawN0t1y1dvcX5mT7Kyg2/LG1X9rMvF4iTXjY9
 dBCViXfdMSMRWB41R09xlbhWCCxHdM/BIXwaBYZQnBgVPqdoaMeaQmdG54wnwT8c97hYV0XqHD0
 0hFy79meR5hZz4Kq1NcpkcfBBrUad8/jLlO1O71BzUS1o3ewbLMt2FgvQ5TXLLus0zOTodaEy/l
 xAaj+e+giICtrTmueRqReSkx3sohZpIAF7KOSV2BVD5q7WeHrod6YAQIjJ86kEnILZYabA3brAa
 Nag==
X-Google-Smtp-Source: AGHT+IHn64GtcgxqSzZqe/F7+UvcuNkU35CTJ99LQ0ivrtJrkUZdF57YyirKShM9Sa+jLKfNprO2IQ==
X-Received: by 2002:a05:6602:3e90:b0:85b:435d:2fcd with SMTP id
 ca18e2360f4ac-8669fac56e8mr427412339f.8.1746197278209; 
 Fri, 02 May 2025 07:47:58 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/60] expo: Add a function to poll for input
Date: Fri,  2 May 2025 08:46:16 -0600
Message-ID: <20250502144718.313633-19-sjg@chromium.org>
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
 boot/expo.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 cmd/bootflow.c       |  2 +-
 include/bootflow.h   |  2 +-
 include/expo.h       | 13 +++++++++++++
 6 files changed, 66 insertions(+), 71 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 43125e15832..268c93ae8e3 100644
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
+			return log_msg_ret("bmr", ret);
 		}
 	} while (!done);
 
-	if (ret)
-		return log_msg_ret("end", ret);
-
 	if (sel_id) {
 		struct bootflow *bflow;
 		int i;
diff --git a/boot/cedit.c b/boot/cedit.c
index ed499f11140..b7b9cc510e0 100644
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
+			return log_msg_ret("cep", ret);
 		}
 	} while (!done);
 
diff --git a/boot/expo.c b/boot/expo.c
index 9c042f16fe7..301bbfa5f9a 100644
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
@@ -286,3 +290,43 @@ int expo_iter_scene_objs(struct expo *exp, expo_scene_obj_iterator iter,
 
 	return 0;
 }
+
+int expo_poll(struct expo *exp, struct expo_action *act)
+{
+	int ichar, key, ret;
+
+	ret = expo_render(exp);
+	if (ret)
+		return log_msg_ret("ere", ret);
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
+	ret = expo_send_key(exp, key);
+	if (ret)
+		return log_msg_ret("epk", ret);
+	ret = expo_action_get(exp, act);
+	if (ret)
+		return log_msg_ret("eag", ret);
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

