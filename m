Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E88E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E536887581;
	Wed,  4 Oct 2023 18:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p8UtlO3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1039487597; Wed,  4 Oct 2023 18:42:54 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C148757E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-534659061afso4023662a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437769; x=1697042569;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lvGl5zb98VwIugyj4+Y2I/03Yvp0yU2qe//gmYgvzRk=;
 b=p8UtlO3NCamfWNUSLL4nvmDDlo+CHT/0U7oFhn5P5ArYWI69l6iHPvVvjLU2/+J/gF
 0wayE/wP8elz94nxFfMPSAMN2DU7OE/1bcs+Ce/wJJC9PzgI+Cf0UXrvSE+LFfSrM/qD
 qMcGCkJGI2qPKrW5ibH2MQi+0INrL7a32+bVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437769; x=1697042569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lvGl5zb98VwIugyj4+Y2I/03Yvp0yU2qe//gmYgvzRk=;
 b=m3kM8ZHwUJarPMzVOScNiqUuGspn8nKj/yYP1vPsy9sPdF4RAOpnYbyMB9HShXEFFT
 N7QYyw3k84msQpujxJCSNEUSXG8o5pb/MnVG1TRAK0lRIiAricHIywY4dep3wyQrZmKs
 Puw8+5R0Ibf/ex9jUpbCXo0DrcYe0QEMBBHZhjSEFIbu7Ev54/tkKWZPL2O136dlTnDX
 9OKc+e6MEAr7sQakV0cXavcXjWH0ECP3dyLZgiNrrYgLBDQqq1o1NohEW8IhYRrBL8Zo
 s9Jn5xzb1ywjpfNxJBCWa+M1B94Fpo7T2w+FPCQRyzFvBY8dDHf4wteH/OCoI3KzBQzc
 kF2Q==
X-Gm-Message-State: AOJu0YxZIfrNiYGgUg3M4XQnn6B6lxuoqjRySb45NiVDIN4kWnyCCFrM
 uOQ5Rs6CFYHyHwS+8sYp5Uo95wUf1w2CfDJEn1U=
X-Google-Smtp-Source: AGHT+IHV6QQoiauVMQ3CwcnpWxureTlQStmqyrW3uWheawdrAslkUGkOd0IgS+TdGj3f4bOColSd+A==
X-Received: by 2002:a05:6402:217:b0:533:4c15:c337 with SMTP id
 t23-20020a056402021700b005334c15c337mr2356525edv.16.1696437768779; 
 Wed, 04 Oct 2023 09:42:48 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:48 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v10 01/24] test: Add framework to test hush behavior
Date: Wed,  4 Oct 2023 19:41:57 +0300
Message-Id: <20231004164220.15738-2-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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
index 1c7dc65966..340a2b041f 100644
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
index 178773647a..d6ca3e221d 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -20,6 +20,9 @@ obj-$(CONFIG_FUZZ) += fuzz/
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
index 0cb514490b..aae0c460ad 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -110,6 +110,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_CMD_ADDRMAP
 	U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
 #endif
+#if CONFIG_IS_ENABLED(HUSH_PARSER)
+	U_BOOT_CMD_MKENT(hush, CONFIG_SYS_MAXARGS, 1, do_ut_hush, "", ""),
+#endif
 #ifdef CONFIG_CMD_LOADM
 	U_BOOT_CMD_MKENT(loadm, CONFIG_SYS_MAXARGS, 1, do_ut_loadm, "", ""),
 #endif
@@ -203,6 +206,9 @@ static char ut_help_text[] =
 #ifdef CONFIG_CONSOLE_TRUETYPE
 	"\nut font - font command"
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

