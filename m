Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40F2C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3E0187652;
	Fri, 22 Dec 2023 22:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oaatENlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3AC087650; Fri, 22 Dec 2023 22:03:08 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C089871CE
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so12985795e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703278986; x=1703883786;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KyUmsNerrUpwM+6/0p8lN9H6UrPjYCtAcO2iaxFALS4=;
 b=oaatENlYkmmFb/y+dHpwuGXUW3zbZQGzQq0xbr0ryiDcJuGm9kQPGWw2nTrfL0/J0o
 S7MruZMtZKVzHPY/OiKAk/fDiFdXpHXfbAzjebz8LlyQg0a1hQtpLf6VMLOrf40V0FXy
 ZTU4l+ai+jyJvQ2B/n1FDaziLpK0sjSsHw0sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703278986; x=1703883786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KyUmsNerrUpwM+6/0p8lN9H6UrPjYCtAcO2iaxFALS4=;
 b=r3zL+4XILlZ3SziKGRfbtaWfwQK5afwHFZwhWYEJLX1frcvxsj4vZ/vMHIRIxtWmqZ
 2QI8zJMBTfphAstbBEGhUtxlcDc5+9OwftSzMVs7rRfNi5BSi9hs2fLh16px8wSZNjLt
 1gF2gAFUeH5Gk6L7wOu3g5CgoEyOYdjL7YCUf6yjBirMw7axXQSSnjobii2qPyJcS522
 l6bGCIYxbyaLOlcPymvU4NhZ3U+WzPWwSPuXhX5UJpH4SPG1/F9hPXyxTz2NwWAX7zh+
 BJ7YBx+KBQz4ZIOkIFG/VDuQI/MjL0aEVyL7mP/MNETKFB+AR0LpvxfOaL5uCN1ng0PB
 AawA==
X-Gm-Message-State: AOJu0YxlTNHz03E+esM/hFC4GzpxhXgdX4ZYbK2akgn1BireTPfbyapj
 T8nPVUli4gZqcHKTUn1UtasbZdLSr57HM2MZp9R5gAg+PY0=
X-Google-Smtp-Source: AGHT+IGzkr+H3EafV2diU5FdgLgkNizWaV5CGiYVjQkBq6qdcipRaYCA0ScUq6hR6gIXvrRr2EIj+g==
X-Received: by 2002:a05:600c:3c88:b0:40c:2c65:a156 with SMTP id
 bg8-20020a05600c3c8800b0040c2c65a156mr984806wmb.6.1703278986209; 
 Fri, 22 Dec 2023 13:03:06 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:06 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>,
 Eddie James <eajames@linux.ibm.com>, Alexander Gendin <agendin@matrox.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v13 01/24] test: Add framework to test hush behavior
Date: Fri, 22 Dec 2023 22:02:21 +0100
Message-Id: <20231222210244.91830-2-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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
index 49224d8ea2..365d5f20df 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -43,6 +43,7 @@ int do_ut_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_exit(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_fdt(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_font(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
+int do_ut_hush(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_lib(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_log(struct cmd_tbl *cmdtp, int flag, int argc, char * const argv[]);
diff --git a/test/Makefile b/test/Makefile
index 6b8a1506f5..9aeef02f9e 100644
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
index 1b934b2329..0677ce0cd1 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -121,6 +121,9 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_CMD_ADDRMAP
 	U_BOOT_CMD_MKENT(addrmap, CONFIG_SYS_MAXARGS, 1, do_ut_addrmap, "", ""),
 #endif
+#if CONFIG_IS_ENABLED(HUSH_PARSER)
+	U_BOOT_CMD_MKENT(hush, CONFIG_SYS_MAXARGS, 1, do_ut_hush, "", ""),
+#endif
 #ifdef CONFIG_CMD_LOADM
 	U_BOOT_CMD_MKENT(loadm, CONFIG_SYS_MAXARGS, 1, do_ut_loadm, "", ""),
 #endif
@@ -216,6 +219,9 @@ U_BOOT_LONGHELP(ut,
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

