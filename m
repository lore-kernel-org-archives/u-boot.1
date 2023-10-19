Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB52CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9042B87456;
	Thu, 19 Oct 2023 17:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gxfX4eHr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE4B98743C; Thu, 19 Oct 2023 17:01:15 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F43787024
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59e88a28b98so7909987b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727670; x=1698332470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jz7w//TNvavXWX8aDCeodqapv8f4L9MNIU3pvpvBON4=;
 b=gxfX4eHrk8X59j0hnQmjqd4GQuB6xVtVg2wntnORhDJMhjexfn33yPSqiaA9h98bK6
 LGXH49pmdwkUCFFM/s0zus4rDHchOM71hE8Bo5ywxLVHGtDTlHKl2H/9ZBXquHjySsug
 +qklcAk0EgZ3zqjaQ5flDx6y7bPrclan4IZIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727670; x=1698332470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jz7w//TNvavXWX8aDCeodqapv8f4L9MNIU3pvpvBON4=;
 b=XiqlDH61UHVL+zHmjtMyPZBtryMgnyt/jQCV0AqcP/Vjz2k7MCNYqyabDISiA6YRgh
 VimEkRLR+bp9DF0tMiWRQvHyeNpJ1uTqd7Un0Wk+bfzRjsTer7I9TZjDVH6PE7xVYQ3K
 Fq7Znw6iAus2O9XlmzcrBJo2w453lkW6VEhZEi1LtucbXWFbV7KiHLBMQy9m79BwwjuG
 7IYPyhibHChMUWccwqFWFJW1Ne92qgtJEw9GTxYS2THUQpwvnQQXE+pip+pt8W/OXNrQ
 1oHCte6tK4aC3ABSzUFykluxaJeCmxeUjcuHO5gykLt5/rSb0P/9jPqibcnAAfunu8k4
 laHA==
X-Gm-Message-State: AOJu0YwpR0S59AGJdiqTiNjX4uTMxNXg7LQ4zqa+nszbXPRL9kNHkL7c
 3RpEtKolgH8kGDGhZhxTWMnF3OdmG92NeGUP5yBtyg==
X-Google-Smtp-Source: AGHT+IE2d4AJ17rX1G7KUHb10SAp5EDpO+ZGpMzkWgxV5AJ0VRNPXW7GfgrOYTS/st6awi1BPl4fiA==
X-Received: by 2002:a81:6c92:0:b0:5a7:b545:dcaa with SMTP id
 h140-20020a816c92000000b005a7b545dcaamr1565494ywc.23.1697727669848; 
 Thu, 19 Oct 2023 08:01:09 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.08
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 04/24] version: Separate our version string from the version
 command
Date: Thu, 19 Oct 2023 11:00:45 -0400
Message-Id: <20231019150105.714407-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

In order to be able to disable all commands we need to construct our
version string in a common file, and have the version command reference
that string, like the other users of it do.  Create common/version.c
with just the strings.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 cmd/version.c    |  9 ---------
 common/Makefile  |  1 +
 common/version.c | 16 ++++++++++++++++
 3 files changed, 17 insertions(+), 9 deletions(-)
 create mode 100644 common/version.c

diff --git a/cmd/version.c b/cmd/version.c
index 87e1fa4159c1..d99a44f19fb3 100644
--- a/cmd/version.c
+++ b/cmd/version.c
@@ -7,21 +7,12 @@
 #include <common.h>
 #include <command.h>
 #include <display_options.h>
-#include <timestamp.h>
-#include <version.h>
 #include <version_string.h>
 #include <linux/compiler.h>
 #ifdef CONFIG_SYS_COREBOOT
 #include <asm/cb_sysinfo.h>
 #endif
 
-#define U_BOOT_VERSION_STRING U_BOOT_VERSION " (" U_BOOT_DATE " - " \
-	U_BOOT_TIME " " U_BOOT_TZ ")" CONFIG_IDENT_STRING
-
-const char version_string[] = U_BOOT_VERSION_STRING;
-const unsigned short version_num = U_BOOT_VERSION_NUM;
-const unsigned char version_num_patch = U_BOOT_VERSION_NUM_PATCH;
-
 static int do_version(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
diff --git a/common/Makefile b/common/Makefile
index cdeadf72026c..b711dc29b65e 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -10,6 +10,7 @@ obj-y += main.o
 obj-y += exports.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
+obj-y += version.o
 
 # # boards
 obj-y += board_f.o
diff --git a/common/version.c b/common/version.c
new file mode 100644
index 000000000000..6e27bb80e398
--- /dev/null
+++ b/common/version.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2000-2009
+ * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
+ */
+
+#include <timestamp.h>
+#include <version.h>
+#include <version_string.h>
+
+#define U_BOOT_VERSION_STRING U_BOOT_VERSION " (" U_BOOT_DATE " - " \
+	U_BOOT_TIME " " U_BOOT_TZ ")" CONFIG_IDENT_STRING
+
+const char version_string[] = U_BOOT_VERSION_STRING;
+const unsigned short version_num = U_BOOT_VERSION_NUM;
+const unsigned char version_num_patch = U_BOOT_VERSION_NUM_PATCH;
-- 
2.34.1

