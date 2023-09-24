Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12462CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5793C86BB9;
	Sun, 24 Sep 2023 22:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NrfJ+wNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CB05833F5; Sun, 24 Sep 2023 22:40:33 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4892286ACF
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-77acb04309dso196163639f.2
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588030; x=1696192830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahnPGBn9x7TTjfMwUlpjAfju+zJugPG9uhouE7Z4FOk=;
 b=NrfJ+wNnNqOayQHNBRa0UveoY7wUXJgAdsmYU3qaT6B8CQAjK4ZbT7pThra4idqUpR
 vBaBFWEqLJoCShPlyE+/70fSCBcb9W1B4WoA1KIFp4kuyRUceJKjGH/xgEXTBP56WYPU
 1C3TTwBl85ySfbbAoygRNVZ0f/FgVcd5onS28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588030; x=1696192830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahnPGBn9x7TTjfMwUlpjAfju+zJugPG9uhouE7Z4FOk=;
 b=cYgtQvRhLlft9NSI+vvqoDiK7/hi9LvfUZz5OizcMKNLYQ878bUlnTawTb1+38frcN
 nmPA0EtXdWTx865I5i447d6QkJdnnHXoX+HfK/73SL7HCjusdWKt3NwdA96hD65W+rBh
 HsMKJWZko9y5tIXwL5hx8LF7mkAIxctk78BsvB/kvcDfqqRw9hH0HXtfuD75F7/2HTaX
 Og060/WBIxAWl50AW2ABBA4tAvJnXszt/0S4TuIiEWRYtUqFEWGVeufq4bgxnvWCVQNN
 r1Q9ZJ2+sFkhNtapDD8cXf2NocZQrjW3aDCj4t3LrbYWzCs0fxPr/ByEooYRuEFqJZMx
 xn3Q==
X-Gm-Message-State: AOJu0Yy6mytC5mNrs3Mx1Ju9efg5Mnxj7I1GD1eInO4p6vO/Glht0uT4
 CSTIFXJgjITDpMw7LgmcYDINgLvHAYsxhnsiy60=
X-Google-Smtp-Source: AGHT+IH3u9Idp2aAtsX4BWdao9u7cX+y6XAGlljaqkrXoApViEztteVz0qcptftUCZhTFD4QbIwByw==
X-Received: by 2002:a05:6602:164f:b0:79f:d04d:ce59 with SMTP id
 y15-20020a056602164f00b0079fd04dce59mr468552iow.6.1695588029956; 
 Sun, 24 Sep 2023 13:40:29 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: [PATCH 11/25] Move bootmenu_conv_key() into its own file
Date: Sun, 24 Sep 2023 14:39:29 -0600
Message-ID: <20230924203953.1829820-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

This conversion function is used by expo which does not require CMDLINE.
The menu feature does require CMDLINE.

Move the function into a separate file so that it can be used even when
CMDLINE is not enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/Makefile    |  2 +-
 common/cli_getch.c |  1 +
 common/menu.c      | 40 -------------------------------------
 common/menu_key.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 41 deletions(-)
 create mode 100644 common/menu_key.c

diff --git a/common/Makefile b/common/Makefile
index 15ae46f596d0..29a4c818a700 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,7 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
-obj-y += cli_getch.o
+obj-y += cli_getch.o menu_key.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 
diff --git a/common/cli_getch.c b/common/cli_getch.c
index 61d4cb261b81..c3332dc27fae 100644
--- a/common/cli_getch.c
+++ b/common/cli_getch.c
@@ -8,6 +8,7 @@
 
 #include <common.h>
 #include <cli.h>
+#include <menu.h>
 
 /**
  * enum cli_esc_state_t - indicates what to do with an escape character
diff --git a/common/menu.c b/common/menu.c
index b55cf7b99967..844d0ec52af3 100644
--- a/common/menu.c
+++ b/common/menu.c
@@ -483,46 +483,6 @@ enum bootmenu_key bootmenu_autoboot_loop(struct bootmenu_data *menu,
 	return key;
 }
 
-enum bootmenu_key bootmenu_conv_key(int ichar)
-{
-	enum bootmenu_key key;
-
-	switch (ichar) {
-	case '\n':
-		/* enter key was pressed */
-		key = BKEY_SELECT;
-		break;
-	case CTL_CH('c'):
-	case '\e':
-		/* ^C was pressed */
-		key = BKEY_QUIT;
-		break;
-	case CTL_CH('p'):
-		key = BKEY_UP;
-		break;
-	case CTL_CH('n'):
-		key = BKEY_DOWN;
-		break;
-	case CTL_CH('s'):
-		key = BKEY_SAVE;
-		break;
-	case '+':
-		key = BKEY_PLUS;
-		break;
-	case '-':
-		key = BKEY_MINUS;
-		break;
-	case ' ':
-		key = BKEY_SPACE;
-		break;
-	default:
-		key = BKEY_NONE;
-		break;
-	}
-
-	return key;
-}
-
 enum bootmenu_key bootmenu_loop(struct bootmenu_data *menu,
 				struct cli_ch_state *cch)
 {
diff --git a/common/menu_key.c b/common/menu_key.c
new file mode 100644
index 000000000000..4e9c3b426b0c
--- /dev/null
+++ b/common/menu_key.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2010-2011 Calxeda, Inc.
+ * Copyright (c) 2019, NVIDIA CORPORATION. All rights reserved.
+ */
+
+#include <common.h>
+#include <cli.h>
+#include <menu.h>
+
+enum bootmenu_key bootmenu_conv_key(int ichar)
+{
+	enum bootmenu_key key;
+
+	switch (ichar) {
+	case '\n':
+		/* enter key was pressed */
+		key = BKEY_SELECT;
+		break;
+	case CTL_CH('c'):
+	case '\e':
+		/* ^C was pressed */
+		key = BKEY_QUIT;
+		break;
+	case CTL_CH('p'):
+		key = BKEY_UP;
+		break;
+	case CTL_CH('n'):
+		key = BKEY_DOWN;
+		break;
+	case CTL_CH('s'):
+		key = BKEY_SAVE;
+		break;
+	case '+':
+		key = BKEY_PLUS;
+		break;
+	case '-':
+		key = BKEY_MINUS;
+		break;
+	case ' ':
+		key = BKEY_SPACE;
+		break;
+	default:
+		key = BKEY_NONE;
+		break;
+	}
+
+	return key;
+}
-- 
2.42.0.515.g380fc7ccd1-goog

