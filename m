Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200C6CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1CE86F42;
	Tue, 17 Oct 2023 00:33:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mlcRr3zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15BC486EE2; Tue, 17 Oct 2023 00:30:56 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F3E803AE
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66cfd874520so33457596d6.2
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495425; x=1698100225; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cSxeBGEPHRZ1lN1Ua2XybbI/zemxbmGcpSvuJqNYZtA=;
 b=mlcRr3zkLYtHXionxYx8HIwdEQELoToniwkcErYlDZ/wXdXFsTXHiLDPm7u9uSQSOH
 DUdTQrjtpQl9aWiGW4whBku6ey65S66qgm4tvi7nVu/O8H+KBuEo4M0ABtnw7q0OjBWx
 O9cSWk6zfNYI9zA3u2t2nNIu+CsLi4YerKnBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495425; x=1698100225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cSxeBGEPHRZ1lN1Ua2XybbI/zemxbmGcpSvuJqNYZtA=;
 b=vmat9hsL8KIZaxplaADuW2NsgxgR558UWku8uTqEyM/Ge+khlNxzAlD6uwJSP5oRbb
 zJNUe5ferIPfRuPTFkM+ky2P3qRFEbQEpQiIq2Zs+DqGJS6EpOFuVbPvLNe6zl0CRqt9
 CbVZ/svWb20Vgl0DXm/3n0udBEg21b7f6jYBP7rIibDOdkadoDj2OvV8claujcoMMgMr
 PINncdLbap4Sk65KUVY6d+TK67fki63zfIACtIS0lpOZvJYEl1eUHxi+WyY0i6PCr1+1
 cIK23bpm5zLBvJnhEjuJBFJDZ9dvOWyTWCBHSVrgcjB+UmzK5vPXkifmiRFwwGPf/eJY
 99+w==
X-Gm-Message-State: AOJu0Yzj2q/GckI1051JHp7jr09/4GGWm279vzCS/WWn1uNyVgnRu7cS
 rienc4Ot/uys/BIgNPZ+abmDH0f2tcxGgOkKcT9+zQ==
X-Google-Smtp-Source: AGHT+IF3N+r+QswqSTffFUuwF0kjhHqKxfx2W12hshP8PKn4UrcQbnUFMkdejkLrSHu9LxWKGbFbjA==
X-Received: by 2002:a05:6214:260d:b0:66d:2813:fd18 with SMTP id
 gu13-20020a056214260d00b0066d2813fd18mr663887qvb.52.1697495424851; 
 Mon, 16 Oct 2023 15:30:24 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 10/32] Move bootmenu_conv_key() into its own file
Date: Mon, 16 Oct 2023 16:28:01 -0600
Message-ID: <20231016222835.596572-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

(no changes since v1)

 common/Makefile    |  2 +-
 common/cli_getch.c |  1 +
 common/menu.c      | 40 -------------------------------------
 common/menu_key.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 41 deletions(-)
 create mode 100644 common/menu_key.c

diff --git a/common/Makefile b/common/Makefile
index b21916f15340..637066ae6682 100644
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
2.42.0.655.g421f12c284-goog

