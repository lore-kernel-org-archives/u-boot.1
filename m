Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD0FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DCC987633;
	Tue,  7 Nov 2023 22:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IbKRvUXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85A2B87622; Tue,  7 Nov 2023 22:42:04 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16635875CC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f70391608so3126709f8f.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393315; x=1699998115;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gv+U5AQk+nMFfM4c+tK26MVDL+uj1qPOHddwPA9pWWs=;
 b=IbKRvUXz17GYj4JdlRW0NjirCXEBQzDDswkwE7thTCq9MZJUjfe9F3H1s37K9WEstA
 iujx0eOTJlMQJtBj0ZLMyIJ7kUQrWXou14fx3mxpPEo1wpnZ28kK3Nm67HMrNZ+fKWhQ
 dt4MATP4s+jiHBBJZf0i6MFbrzvLIjPS751iI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393315; x=1699998115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gv+U5AQk+nMFfM4c+tK26MVDL+uj1qPOHddwPA9pWWs=;
 b=wKx5MPBgfuMvI6uafY9v3ez+x4EUnIgw/aEYhAdtQCBEWrQuNbHQhYp4+e0hOZkiYG
 BoxMOTTcyK6NOn2l/T5ADg9oQPqjrvKqE4pP1i8G0dv73LDc92Hu9WTpye2Gl11UCKk8
 8ncenWvUCSJIIeajX6SbPTjRnBEt6BzuktFpflPFvoNgs9kipfrVN6s6H3zTWWcNv6KO
 qIWJ6krXPF1l7X1L10wP670WlADFmgyq55B6HrWVHEX0nVLPrUHodswms/EWAb4XexPh
 0i/6n+Gn4Wq6VVypYzm9TBdtMfKcEAHlfT1A8ErJWIY8AezUPt9M66/x86SKbnQkz4Fo
 YCBA==
X-Gm-Message-State: AOJu0YzGUEu+sPcArCUiCzNbGkzOpW6GVJJncJqHFPTRSsGWPCpoCcMQ
 NMX8VXwZ9Q6hsavOiIu02zSmSwGhre+bG3Je4hA=
X-Google-Smtp-Source: AGHT+IFE+Xsp+Bbj7NQXELBLRF8ZJ8w7j0lrp3QymLrnL03QNbJyZSZtraDydzikecS4NqXrAW5wHA==
X-Received: by 2002:adf:fac1:0:b0:31a:d4e4:4f63 with SMTP id
 a1-20020adffac1000000b0031ad4e44f63mr9255wrs.18.1699393315513; 
 Tue, 07 Nov 2023 13:41:55 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:41:55 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Marek Vasut <marex@denx.de>, Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v11 01/24] test: Add framework to test hush behavior
Date: Tue,  7 Nov 2023 23:40:58 +0200
Message-Id: <20231107214121.132079-2-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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

Introduce a new subcommand to ut: ut hush.
For the moment, this command does nothing, future commits will add tests which
will be run on command call.

Note that CONFIG_HUSH_PARSER must be defined to compile this new subcommand.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/test/hush.h     | 15 +++++++++++++++
 include/test/suites.h   |  1 +
 test/Makefile           |  3 +++
 test/cmd_ut.c           |  6 ++++++
 test/hush/Makefile      |  6 ++++++
 test/hush/cmd_ut_hush.c | 20 ++++++++++++++++++++
 6 files changed, 51 insertions(+)
 create mode 100644 include/test/hush.h
 create mode 100644 test/hush/Makefile
 create mode 100644 test/hush/cmd_ut_hush.c

diff --git a/include/test/hush.h b/include/test/hush.h
new file mode 100644
index 0000000000..cca66544a0
--- /dev/null
+++ b/include/test/hush.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * (C) Copyright 2021
+ * Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
+ */
+
+#ifndef __TEST_HUSH_H__
+#define __TEST_HUSH_H__
+
+#include <test/test.h>
+
+/* Declare a new environment test */
+#define HUSH_TEST(_name, _flags)	UNIT_TEST(_name, _flags, hush_test)
+
+#endif /* __TEST_HUSH_H__ */
diff --git a/include/test/suites.h b/include/test/suites.h
index ad4fc926f4..fc0f9334c0 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -42,6 +42,7 @@ int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
diff --git a/test/Makefile b/test/Makefile
index 8e1fed2c28..10cf6a7976 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -17,6 +17,9 @@ obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
 obj-$(CONFIG_UNIT_TEST) += lib/
 endif
+ifneq ($(CONFIG_HUSH_PARSER),)
+obj-$(CONFIG_$(SPL_)CMDLINE) += hush/
+endif
 obj-$(CONFIG_$(SPL_)CMDLINE) += print_ut.o
 obj-$(CONFIG_$(SPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 2d5b80f992..2f96dfa934 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -118,6 +118,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_CMD_ADDRMAP
 	U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
 #endif
+#if CONFIG_IS_ENABLED(HUSH_PARSER)
+	U_BOOT_CMD_MKENT(hush, CONFIG_SYS_MAXARGS, 1, do_ut_hush, "", ""),
+#endif
 #ifdef CONFIG_CMD_LOADM
 	U_BOOT_CMD_MKENT(loadm, CONFIG_SYS_MAXARGS, 1, do_ut_loadm, "", ""),
 #endif
@@ -210,6 +213,9 @@ U_BOOT_LONGHELP(ut,
 #ifdef CONFIG_CONSOLE_TRUETYPE
 	"\nfont - font command"
 #endif
+#if CONFIG_IS_ENABLED(HUSH_PARSER)
+	"\nhush - Test hush behavior"
+#endif
 #ifdef CONFIG_CMD_LOADM
 	"\nloadm - loadm command parameters and loading memory blob"
 #endif
diff --git a/test/hush/Makefile b/test/hush/Makefile
new file mode 100644
index 0000000000..dfa2a92615
--- /dev/null
+++ b/test/hush/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2021
+# Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
+
+obj-y += cmd_ut_hush.o
diff --git a/test/hush/cmd_ut_hush.c b/test/hush/cmd_ut_hush.c
new file mode 100644
index 0000000000..48a1adbf28
--- /dev/null
+++ b/test/hush/cmd_ut_hush.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2021
+ * Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
+ */
+
+#include <common.h>
+#include <command.h>
+#include <test/hush.h>
+#include <test/suites.h>
+#include <test/ut.h>
+
+int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
+{
+	struct unit_test *tests = UNIT_TEST_SUITE_START(hush_test);
+	const int n_ents = UNIT_TEST_SUITE_COUNT(hush_test);
+
+	return cmd_ut_category("hush", "hush_test_",
+			       tests, n_ents, argc, argv);
+}
-- 
2.34.1

