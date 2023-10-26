Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CD1C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B227687B59;
	Thu, 26 Oct 2023 20:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KCNLuSwK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713BF87640; Thu, 26 Oct 2023 20:31:49 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A739287640
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-778940531dbso92859985a.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345104; x=1698949904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jz7w//TNvavXWX8aDCeodqapv8f4L9MNIU3pvpvBON4=;
 b=KCNLuSwKfVdmRGiWl5vf6cy02ChpoicSO1qge8eFukhk4Gn24qPZgZT4g7A0pAym0n
 rJxCuLVtOqpGDFspQhBPI5jenvgK0NBHrA4Pe4ne3cVSoeSwbCuLPxurmxI66gBH363m
 JcxYm9A9m15mYWuM6mFXNj+O3o2afGMKqTRm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345104; x=1698949904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jz7w//TNvavXWX8aDCeodqapv8f4L9MNIU3pvpvBON4=;
 b=Qc7PiYK9j/hbsY0VssfmU6nFHfNPbKJdTEH/5v392b2+g3QmKwcM5GlBhAcayhDslS
 qeogvaAXErPvPeii3AwHyL/2hB/W+Q593Kpozuk7EV/WG1CSfDkvizXo+8KGpKMXWMHw
 deYFZPn4DcuTWthXa+SjzZXj6ymAQhwFnz/iyRB61Ro5QH5eW3Zcz65F469wuBbLaDxL
 wwfVx6esDB9H2SvgCLAp0mHdHVlaKUgmgEm4OWMH3t1ca5Gmd4esZ+oBNlN1oJIY3ib2
 FjCKu69dOlhARLHVs7Gl3RF7IV370btGfkKOh8RaMzq365nNp2/kKtoKQVmlJ5Fxi6dT
 0TbA==
X-Gm-Message-State: AOJu0YxuAztFllJNG7QiNRZcpT7TPmQrXg/183b5CHNODzjKgrjugxAG
 IFTEOX+ZY+Un5vAB6WlxlA1hG711Il9iy47S2KCm7g==
X-Google-Smtp-Source: AGHT+IG/7SYjeW33R1IHEuARRP4JwFhzO7/HXcSmXA9Ly8q+ioDYGkxesJ878Cz8uvZQGa7JQtnAVw==
X-Received: by 2002:a05:620a:2681:b0:778:b72d:651e with SMTP id
 c1-20020a05620a268100b00778b72d651emr140791qkp.28.1698345103794; 
 Thu, 26 Oct 2023 11:31:43 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.43
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:43 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 05/30] version: Separate our version string from the version
 command
Date: Thu, 26 Oct 2023 14:31:13 -0400
Message-Id: <20231026183138.636948-5-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

