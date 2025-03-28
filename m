Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70152C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D29382107;
	Fri, 28 Mar 2025 14:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="APZ9XHXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887BC81EC5; Fri, 28 Mar 2025 14:08:10 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB72381E5A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3d442a77a03so6225925ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167285; x=1743772085; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0woDTnboVjANVBOgg2lL8exWKWX1/n1+upT+sr/oqzI=;
 b=APZ9XHXMcuw4GijGntnlu6fa3hhR+ZyQFCLC+R9S1lxhkZL0mnFUv+hf9FobvmBnn5
 kmhEL8emkXgf/9QH2XMC/gLhtdkJGGvpCtwvC/KlplSTXGxfC6+9uRKxomn/kie128TT
 obWBxLG+/DUjn+6K5plq1zeAItr+oxWXDZYqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167285; x=1743772085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0woDTnboVjANVBOgg2lL8exWKWX1/n1+upT+sr/oqzI=;
 b=XVmMSXNj0b+dwV8mOcmqqWyvmR3CDi97I1YAz6Dte61GJKcjKVGnJj4bPy/amgmhs0
 moLCACTUohD8jSah6ef8402dlp8L8TOvGYImUulHDJjDbxBDthoQ7ZJ6Q7pchgGqi/1F
 GcGFLeGPE3D4RF2opuIPTClm6NG8qsyD7WjnZx9LBgva2WFr0Et8XvNxR3zDDGedtY6s
 aJAUOlNrLE5dtJotvQhvgkqn0ezZkVwyk+JrFQSsWl1WIkhBkaZ0x7nJNKfFSXZONdNa
 7Z5wkrwM+NMu2EHDelWtgBVqkkiYbKVuSAAO8Le6/MlK+yNkjth3wQCxjoq/huidjUR2
 fsMw==
X-Gm-Message-State: AOJu0YxourJR8tIQ2tZCZR1Hq/xmQGTJZIkN4n+Vwdi5NFhiYmqbfNtt
 ifwG9UUcbSKFh051YvwGOGuMFadSmeWsDMWzg8TL1EVXqLPDc6RdnJ5KIl5SXd+l6A0ubWc86lg
 =
X-Gm-Gg: ASbGncvGqsYS8rIxhD4kMNgkzphmMSDjuk8WzYWnCCegyglvvtu8c1q0WYR/qsQ8oSr
 FVCSO5/eBoqbkUu5x8gLOrCIKt23fIoU06TuECQ31zAveKJ2RPx/OlN6hDnl+2DB/qS3zbAARVS
 WeGIO2CIO+U5FAMOEKhBeKEVcXzKqRo3hHM4hx1u3RoIEW8AUIbSghOmuZcL8HzEC7f+P4Z3pdQ
 T4FUftJQLotQtqzK5xqwMaJ6WAeMFIfDxMCzrgo+O6rF74qnfxv9iZ7Shw1ueIO/bqS6GRhvP0I
 iLORhT+hSMb5Qh5hx5iGAYpLuK8aL2kpjjkJE7Obc8s5muq+lkHQMdeLXyXtmFROgC4J5mMjRtM
 krNJmXA==
X-Google-Smtp-Source: AGHT+IHzuIe/OnTacjEVege3joblcZf4yItlB7SjCig70F+Jf6phIQmRqIHBSSiRFd6wkc5bQ7iCWA==
X-Received: by 2002:a05:6e02:2192:b0:3d4:3d8c:d5b4 with SMTP id
 e9e14a558f8ab-3d5ccdd7486mr64353315ab.11.1743167284692; 
 Fri, 28 Mar 2025 06:08:04 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 25/56] expo: Split bootflow_menu_run() into two pieces
Date: Fri, 28 Mar 2025 07:06:12 -0600
Message-ID: <20250328130713.2612648-26-sjg@chromium.org>
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

Split the starting piece of this function into bootflow_menu_start()
and the polling part into bootflow_menu_poll() so that it is possible
for the caller to be in control of the event loop.

Move the expo_destroy() call into the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow_menu.c | 86 ++++++++++++++++++++------------------------
 cmd/bootflow.c       | 34 +++++++++++-------
 include/bootflow.h   | 33 ++++++++++-------
 3 files changed, 81 insertions(+), 72 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index d20d0be4734..018910c65b8 100644
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
@@ -210,56 +203,55 @@ int bootflow_menu_run(struct bootstd_priv *std, bool text_mode,
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
-				LOGR("bmp", scene_menu_select_item(scn,
-					OBJ_MENU, act.select.id));
-				break;
-			case EXPOACT_QUIT:
-				return -EPIPE;
-			default:
-				break;
-			}
-		} else if (ret != -EPIPE && ret != -EAGAIN) {
-			LOGR("bmr", ret);
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
+	LOGR("bmp", expo_poll(exp, &act));
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
+	}
+	case EXPOACT_POINT_ITEM: {
+		struct scene *scn = expo_lookup_scene_id(exp, MAIN);
+
+		if (!scn)
+			return log_msg_ret("bms", -ENOENT);
+		LOGR("bmp", scene_menu_select_item(scn, OBJ_MENU,
+						   act.select.id));
+		break;
+	}
+	case EXPOACT_QUIT:
+		return -EPIPE;
+	default:
+		break;
 	}
 
-	expo_destroy(exp);
-
-	if (!sel_bflow)
-		return -EAGAIN;
-	*bflowp = sel_bflow;
-
-	return 0;
+	return -EAGAIN;
 }
diff --git a/cmd/bootflow.c b/cmd/bootflow.c
index 6189ab7fa40..456f51760f1 100644
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
@@ -105,24 +107,30 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
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
+	LOGR("bhs", bootflow_menu_start(std, text_mode, &exp));
 
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

