Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA373E95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:26:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A3D86F23;
	Sun,  8 Oct 2023 01:16:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rhp6a1XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D3786F07; Sun,  8 Oct 2023 01:14:29 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF5F786EE6
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so140247539f.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720393; x=1697325193; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol7IlMM6QfxaFgBkWoDX7zMirKd6YdBPxM8e+t7twfM=;
 b=Rhp6a1XGFIy27yqWrhLVs8F32Q/CShGtACdo66zq7BTWOOQN4DS8HphGSsGNt5l8ua
 KrjJRBRT11hhpq/ClPGEI5RErE6nArp9fTt8WtNBY/HW0MCxniqBZwdmZxr9yx5YfTN/
 +ENUyQFq7sTIETkpN4E0VBdhnYvct3wXe5s28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720393; x=1697325193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ol7IlMM6QfxaFgBkWoDX7zMirKd6YdBPxM8e+t7twfM=;
 b=ovAqCh3a3neN5YxgyGJ5oqEg87UdmQgchsLEgF3ITnfuIEiOoaMKogPMeYy1YaS6jk
 EZK03DIvWEhJIWZ5JA4Ys6dlriYGcXHY9XMBB0d0boUICj9uBKudopgup7sejBveIYCu
 jZm3+bS0tXgV/2jA/OXrcy72JZOZajPHaVANb/JKkp7xjVd0hvSkxyreeUhUuIoR9h+f
 b/pu/7Xx1SHjwf8rv1My9onuwlFnDEDxwjTUFLrMZ1mQGpxLY37QZIL8cLwT+pY7e2Zl
 edS70o2lE/IIk3+fJjXAbbeUORXbCJjDhfZLD9ElCuEm5h57hMHlOu9rntZh8M+/X+zT
 fDyQ==
X-Gm-Message-State: AOJu0Yy/6v3s29wmLFH1niebh/6w1x/L6QXJ7ZmQSoS66rPCsgG0MY4k
 g2IYomtPRy1SKGlg/7LYLM4DSnvTg+EOW0Sbmhg=
X-Google-Smtp-Source: AGHT+IEiPmSmsoPsSImrY6GxMbkccOwfFstdax3py8xQ+/tolhabL3UThYy6HoxeFJ2nkohJT1gG8A==
X-Received: by 2002:a92:c90d:0:b0:353:a2d8:463a with SMTP id
 t13-20020a92c90d000000b00353a2d8463amr6666363ilp.16.1696720393589; 
 Sat, 07 Oct 2023 16:13:13 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/27] Move bootmenu_conv_key() into its own file
Date: Sat,  7 Oct 2023 17:12:31 -0600
Message-ID: <20231007231255.277623-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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
2.42.0.609.gbb76f46606-goog

