Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28B79E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:31:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7FEC8721C;
	Mon,  2 Oct 2023 03:17:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OSCXiSB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E7DF8710D; Mon,  2 Oct 2023 03:17:07 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2DDB87218
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:16:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so569158939f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209365; x=1696814165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQRWKTaaVOcyC320SbnsGQnJs1jpbb/W3zNOBkrkx6I=;
 b=OSCXiSB9B/7c6DK9v7sOGizPNs6ZfOg8R6aU48yyXLfEFA0kcSef6+qHXBlqc24B77
 kpikJlEWY3l6m23RpM3LAPnUCi3kAR/7cU+3GD1tkCMNHzjSRbWSHXGfRhE2wE1Qg4LI
 NHi0CcZb/SmbrZSPpm2wiAmh6zmva74PxT+i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209365; x=1696814165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQRWKTaaVOcyC320SbnsGQnJs1jpbb/W3zNOBkrkx6I=;
 b=e96nj9GlvR6L7fNYtU/dsT/EYY1I+RnpFoSlR6qCGLWqqMrOsTmkDWDWPuwKG705jZ
 2bVv1uYf0alPeBm4jkqycsS98L5dED3JdNUfwTzFL+Gge/E1dcxzTl3gVQSzXKyojynp
 2Vqnzf9WUWQ/WQLpoBEn55XjfhSBGK1tM9wionYc3IZRmdYSszSRas0uKu1sIEGTgW0y
 c8K9TRjcTaXjF28p6eMja7VNsfvqiJyX8PXMA1bGjdaNkM8E3y8o8ZxAD7NW+/dUWnXH
 XllpT/yDR/0KkwV6AzgJGhxc6Il5X0MyJiPt/UeoYGaFN0nArTEm1FYxFRovdLIEAjQo
 7gWw==
X-Gm-Message-State: AOJu0Yw2qtYOP1r9EOCe3Eb6E5QIlgVAA0puoVoYTwnwWyK0qaT+Ae+V
 oU/Evn/MjpsdCPyiH/KJzQ2vMJh/QfycurlxaxM=
X-Google-Smtp-Source: AGHT+IEdfaRJ5s0wgzlAocODMVEa2dHMjqTTwdWho2BQNKRRoMfB4TGZpMfyemnp3WO7tCe2sAdUZg==
X-Received: by 2002:a5e:8712:0:b0:780:ce72:ac55 with SMTP id
 y18-20020a5e8712000000b00780ce72ac55mr13059722ioj.10.1696209365439; 
 Sun, 01 Oct 2023 18:16:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stephen Carlson <stcarlso@linux.microsoft.com>
Subject: [PATCH 02/34] test: Add a new suite for commands
Date: Sun,  1 Oct 2023 19:15:12 -0600
Message-ID: <20231002011553.463514-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Add a new suite for 'cmd' tests, used for testing commands. These are
kept in the test/cmd directory.

For now it is empty, but it will be used for coreboot-command tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/cmd.h    | 15 +++++++++++++++
 include/test/suites.h |  1 +
 test/cmd/Makefile     |  2 ++
 test/cmd/cmd_ut_cmd.c | 21 +++++++++++++++++++++
 test/cmd_ut.c         |  6 ++++++
 5 files changed, 45 insertions(+)
 create mode 100644 include/test/cmd.h
 create mode 100644 test/cmd/cmd_ut_cmd.c

diff --git a/include/test/cmd.h b/include/test/cmd.h
new file mode 100644
index 000000000000..c200570e423d
--- /dev/null
+++ b/include/test/cmd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __TEST_CMD_H__
+#define __TEST_CMD_H__
+
+#include <test/test.h>
+
+/* Declare a new command test */
+#define CMD_TEST(_name, _flags) UNIT_TEST(_name, _flags, cmd_test)
+
+#endif /* __TEST_CMD_H__ */
diff --git a/include/test/suites.h b/include/test/suites.h
index 1c7dc65966a1..2d4897d46b8e 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -34,6 +34,7 @@ int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
 int do_ut_bloblist(struct cmd_tbl *cmdtp, int flag, int argc,
 		   char *const argv[]);
+int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_common(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_compression(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[]);
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8d70ac510a53..0be2cec89018 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -3,6 +3,8 @@
 # Copyright (c) 2013 Google, Inc
 # Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
 
+obj-y += cmd_ut_cmd.o
+
 ifdef CONFIG_HUSH_PARSER
 obj-$(CONFIG_CONSOLE_RECORD) += test_echo.o
 endif
diff --git a/test/cmd/cmd_ut_cmd.c b/test/cmd/cmd_ut_cmd.c
new file mode 100644
index 000000000000..1a5bfdb4a183
--- /dev/null
+++ b/test/cmd/cmd_ut_cmd.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ *
+ * Unit tests for command functions
+ */
+
+#include <common.h>
+#include <command.h>
+#include <test/cmd.h>
+#include <test/suites.h>
+#include <test/ut.h>
+
+int do_ut_cmd(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct unit_test *tests = UNIT_TEST_SUITE_START(cmd_test);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(cmd_test);
+
+	return cmd_ut_category("cmd", "cmd_test_", tests, n_ents, argc, argv);
+}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 0f56409e8031..d3505fe8d97e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -60,6 +60,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_BOOTSTD
 	U_BOOT_CMD_MKENT(bootstd, CONFIG_SYS_MAXARGS, 1, do_ut_bootstd,
 			 "", ""),
+#endif
+#ifdef CONFIG_CMDLINE
+	U_BOOT_CMD_MKENT(cmd, CONFIG_SYS_MAXARGS, 1, do_ut_cmd, "", ""),
 #endif
 	U_BOOT_CMD_MKENT(common, CONFIG_SYS_MAXARGS, 1, do_ut_common, "", ""),
 #if defined(CONFIG_UT_DM)
@@ -188,6 +191,9 @@ static char ut_help_text[] =
 #ifdef CONFIG_BOOTSTD
 	"\nbootstd - standard boot implementation"
 #endif
+#ifdef CONFIG_CMDLINE
+	"\ncmd - test various commands"
+#endif
 #ifdef CONFIG_SANDBOX
 	"\ncompression - compressors and bootm decompression"
 #endif
-- 
2.42.0.582.g8ccd20d70d-goog

