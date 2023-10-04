Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB221E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:44:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE1B28759F;
	Wed,  4 Oct 2023 18:43:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="NeCUDBLy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E207287599; Wed,  4 Oct 2023 18:42:58 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B80787599
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-533cbbd0153so4289095a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437774; x=1697042574;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nWjHa7yoipEPzYrK8tKY1dFhe+rhO+X+mWMbZ73X2w=;
 b=NeCUDBLyZ0GGWpNge1LAtz6CVrffRPJrcTaDcnYpjzyysNszL0sQZACsXdQo34A6RM
 oIOxo37qMe9PAmKJA/gIHjAI3tiVpJPjpFHkUa/Zyzp2xozcbOFLREc+0N5pHKX/FXSV
 OYz8iyA9/mgpV+uqILU6kNRsNm620vbRFvEzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437774; x=1697042574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2nWjHa7yoipEPzYrK8tKY1dFhe+rhO+X+mWMbZ73X2w=;
 b=CrCbUT8oDgoLcyEKkkjFZ4rn7cn98t0O5gm5R89hJrsxfscL3hE8coCkPAR/MEbSbB
 QI91b41nHUNOfWf9sMsTtohT0OH37nlJJ/C2vF3Z3whz+KaZy28m9u63uOFDm6vSrOOl
 8uwQYUGGhzOSs3+GkkESkCzSXTISGzcBZd7czqekHFnANpAn2IVGcVBG9yYvIBhMxdcJ
 uIZmg/JibIK1i209H/bh7MQr9sh+/62OevhqYTJgIlZcbFLN8koXpHCX9Ul+pXdB7cU/
 1xGxqiyr6adrVc/GQtbfMCynyxhxTrx7Km92WP2DZJXii3PiUTHQm4E3rk2HFXEP898J
 lvUQ==
X-Gm-Message-State: AOJu0Ywq2BwSFPgTCHhs1izTt5DOkGKUY9XwzPdsEw6fdKtgfzKdDT2C
 prTHS/yUX4Iw6MYUGL3zQJO6JaEXDdZUV7IkmVo=
X-Google-Smtp-Source: AGHT+IEWQQB5Hvt+BGTOlsKAw89NNXfehzn0L02aX3bLdzViHZnCuLN13Z54eo8A06bDz1UMkaEUXw==
X-Received: by 2002:aa7:d889:0:b0:530:a5d6:583d with SMTP id
 u9-20020aa7d889000000b00530a5d6583dmr2626375edq.11.1696437774424; 
 Wed, 04 Oct 2023 09:42:54 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:54 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 04/24] test: hush: Test hush variable expansion
Date: Wed,  4 Oct 2023 19:42:00 +0300
Message-Id: <20231004164220.15738-5-francis.laniel@amarulasolutions.com>
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

Verifies shell variables are replaced by their values.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/Makefile       |   1 +
 test/hush/dollar.c       | 167 +++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py |   8 +-
 3 files changed, 175 insertions(+), 1 deletion(-)
 create mode 100644 test/hush/dollar.c

diff --git a/test/hush/Makefile b/test/hush/Makefile
index a3c9ae5106..feb4f71956 100644
--- a/test/hush/Makefile
+++ b/test/hush/Makefile
@@ -5,3 +5,4 @@
 
 obj-y += cmd_ut_hush.o
 obj-y += if.o
+obj-y += dollar.o
diff --git a/test/hush/dollar.c b/test/hush/dollar.c
new file mode 100644
index 0000000000..defb2c3fd0
--- /dev/null
+++ b/test/hush/dollar.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) Copyright 2021
+ * Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
+ */
+
+#include <common.h>
+#include <command.h>
+#include <env_attr.h>
+#include <test/hush.h>
+#include <test/ut.h>
+
+static int hush_test_simple_dollar(struct unit_test_state *uts)
+{
+	console_record_reset_enable();
+	ut_assertok(run_command("echo $dollar_foo", 0));
+	ut_assert_nextline_empty();
+	ut_assert_console_end();
+
+	ut_assertok(run_command("echo ${dollar_foo}", 0));
+	ut_assert_nextline_empty();
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_foo=bar", 0));
+
+	ut_assertok(run_command("echo $dollar_foo", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("echo ${dollar_foo}", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_foo=\\$bar", 0));
+
+	ut_assertok(run_command("echo $dollar_foo", 0));
+	ut_assert_nextline("$bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_foo='$bar'", 0));
+
+	ut_assertok(run_command("echo $dollar_foo", 0));
+	ut_assert_nextline("$bar");
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("dollar_foo=bar quux", 0));
+	/* Next line contains error message */
+	ut_assert_skipline();
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("dollar_foo='bar quux", 0));
+	/* Next line contains error message */
+	ut_assert_skipline();
+	ut_assert_console_end();
+
+	ut_asserteq(1, run_command("dollar_foo=bar quux\"", 0));
+	/* Two next lines contain error message */
+	ut_assert_skipline();
+	ut_assert_skipline();
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_foo='bar \"quux'", 0));
+
+	ut_assertok(run_command("echo $dollar_foo", 0));
+	/*
+	 * This one is buggy.
+	 * ut_assert_nextline("bar \"quux");
+	 * ut_assert_console_end();
+	 *
+	 * So, let's reset output:
+	 */
+	console_record_reset_enable();
+
+	ut_asserteq(1, run_command("dollar_foo=\"bar 'quux\"", 0));
+	/* Next line contains error message */
+	ut_assert_skipline();
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_foo='bar quux'", 0));
+	ut_assertok(run_command("echo $dollar_foo", 0));
+	ut_assert_nextline("bar quux");
+	ut_assert_console_end();
+
+	puts("Beware: this test set local variable dollar_foo and it cannot be unset!");
+
+	return 0;
+}
+HUSH_TEST(hush_test_simple_dollar, 0);
+
+static int hush_test_env_dollar(struct unit_test_state *uts)
+{
+	env_set("env_foo", "bar");
+	console_record_reset_enable();
+
+	ut_assertok(run_command("echo $env_foo", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("echo ${env_foo}", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	/* Environment variables have priority over local variable */
+	ut_assertok(run_command("env_foo=quux", 0));
+	ut_assertok(run_command("echo ${env_foo}", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	/* Clean up setting the variable */
+	env_set("env_foo", NULL);
+
+	puts("Beware: this test set local variable env_foo and it cannot be unset!");
+
+	return 0;
+}
+HUSH_TEST(hush_test_env_dollar, 0);
+
+static int hush_test_command_dollar(struct unit_test_state *uts)
+{
+	console_record_reset_enable();
+
+	ut_assertok(run_command("dollar_bar=\"echo bar\"", 0));
+
+	ut_assertok(run_command("$dollar_bar", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("${dollar_bar}", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_bar=\"echo\nbar\"", 0));
+
+	ut_assertok(run_command("$dollar_bar", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_bar='echo bar\n'", 0));
+
+	ut_assertok(run_command("$dollar_bar", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_bar='echo bar\\n'", 0));
+
+	ut_assertok(run_command("$dollar_bar", 0));
+	ut_assert_nextline("barn");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_bar='echo $bar'", 0));
+
+	ut_assertok(run_command("$dollar_bar", 0));
+	ut_assert_nextline("$bar");
+	ut_assert_console_end();
+
+	ut_assertok(run_command("dollar_quux=quux", 0));
+	ut_assertok(run_command("dollar_bar=\"echo $dollar_quux\"", 0));
+
+	ut_assertok(run_command("$dollar_bar", 0));
+	ut_assert_nextline("quux");
+	ut_assert_console_end();
+
+	puts("Beware: this test sets local variable dollar_bar and dollar_quux and they cannot be unset!");
+
+	return 0;
+}
+HUSH_TEST(hush_test_command_dollar, 0);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index aa1d477cd5..b6b593c13e 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -352,5 +352,11 @@ def test_ut(u_boot_console, ut_subtest):
             execute command 'ut foo bar'
     """
 
-    output = u_boot_console.run_command('ut ' + ut_subtest)
+    if ut_subtest == 'hush hush_test_simple_dollar':
+        # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
+        with u_boot_console.disable_check('unknown_command'):
+            output = u_boot_console.run_command('ut ' + ut_subtest)
+        assert('Unknown command \'quux\' - try \'help\'' in output)
+    else:
+        output = u_boot_console.run_command('ut ' + ut_subtest)
     assert output.endswith('Failures: 0')
-- 
2.34.1

