Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023B3C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA3258210C;
	Wed, 19 Mar 2025 15:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nJRQML5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3CF81F7B; Wed, 19 Mar 2025 15:56:10 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6605D82107
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso42239325e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396167; x=1743000967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DclsTJScp063OoQGhry4K3gARhAOeJPQKZFa5lr/kvM=;
 b=nJRQML5C2k++Ywn8ijNet1/MKvckd6fo3vn78DTJ2O5fsw0HFlfBZf1F+7ko+AFt6D
 YE2YMqAV8Wr/fUlyyVo3OC5nRCYxAUee5RGZNUYG/C1T82XgsF08IOmpPpy+t5cm11uW
 vvLTcP+X08CdcrjKv79Fk50qos9NsjcslPCNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396167; x=1743000967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DclsTJScp063OoQGhry4K3gARhAOeJPQKZFa5lr/kvM=;
 b=QRWMf1CRn1j2E2wX4E/wFyVOYuYcErbleXmdSMDYgsD6qlZsSKn3MsRaMvgIXXJY4E
 kTEHu77ci0NgxarUtlYK8BY6WJlQa7PpPku2eBTdQxyNVQzlk4uF6Tzki+8VaMerJhHM
 H6tc1PfiB5FGoQS11swpC7IAYI7scvN8RyJNnD7bwayvJVMLrSnzuRhppu8gVXMPkXhG
 I/XSxYY6omnxncT3VE4FTOqGO9s2O6fiBhW5aUs69SeV9yIdgEx0oKYT637n9GGsdnHK
 v07tKTFaYehLNSCzjiIsMfV+7ocLK0d0hjjwWU99GltCenn2zXEvRs2hjgpJd8oius3Q
 OGTQ==
X-Gm-Message-State: AOJu0YwmbeUh+DIqQ04bWkcNs03Fhema4IY/KDka4797JxtpQUHgpPoD
 GUGGYYexWADmJKsqBocLO9dOsZ4XvR/PN04niKOADEsX7RPAwim3/zbGbfFeNBf1aBdHil1mx0w
 =
X-Gm-Gg: ASbGncvZRoW4AEas4ikGXYgwD8VXsacFuKnyQAk8cWteBIxfzSUUbIhdqRWJW64Xbe1
 P8jbNRXKfY+5RlPf7+tCuT6+3EA0Rm9m4rDDg5BJJno7CM8O7f109pe+Ya2cLGaVKFZ/bGUeLPp
 ewXQMVhSq16xJRq7joEPiBY2K4+ob7lzeyo23n5nJ8hX7qcgONS2UyWPEzMORLTxUUamtsUYFH+
 6m5PpfDssRqoOm4T/rqJjEn6atd0G6shdVpThS9EfE5Z+G4M0dB0i71FdNwCz3OYavgyH/TbWu9
 xwi7h8NROpgr9V/3iEYm9LS3SCSXjykkdVETYrF5Hg==
X-Google-Smtp-Source: AGHT+IHK9k+gnNEwzbvmvoX23rYBRVUtNhXZm6ZJqTkt0lN1NSHExO8e8HNM9HA4xQDXWAJlTE0kyA==
X-Received: by 2002:a05:600c:46c3:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-43d437c32c7mr24551925e9.14.1742396167247; 
 Wed, 19 Mar 2025 07:56:07 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:06 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 21/52] expo: Split bootflow_menu_run() into two pieces
Date: Wed, 19 Mar 2025 15:54:26 +0100
Message-ID: <20250319145512.2391122-22-sjg@chromium.org>
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

Split the starting piece of this function into bootflow_menu_start()
and the polling part into bootflow_menu_poll() so that it is possible
for the caller to be in control of the event loop.

Move the expo_destroy() call into the caller.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 86 ++++++++++++++++++++------------------------
 cmd/bootflow.c       | 35 +++++++++++-------
 include/bootflow.h   | 33 ++++++++++-------
 3 files changed, 82 insertions(+), 72 deletions(-)

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
index 0163129deba..2871d91dd29 100644
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
@@ -105,24 +107,31 @@ __maybe_unused static int bootflow_handle_menu(struct bootstd_priv *std,
 					       bool text_mode,
 					       struct bootflow **bflowp)
 {
+	struct expo *exp;
 	struct bootflow *bflow;
 	int ret;
 
-	ret = bootflow_menu_run(std, text_mode, &bflow);
-	if (ret) {
-		if (ret == -EAGAIN) {
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
+	// printf("ret %d bflow %p\n", ret, bflow);
 
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

