Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BD5C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9258766A;
	Tue,  7 Nov 2023 22:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ik78IC/Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AAC98764C; Tue,  7 Nov 2023 22:42:10 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AA688760D
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:41:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso38727045e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393319; x=1699998119;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7obYxoGZq272gGjO1ne2rBZ52yC/PtW7SFUCnW0X4qs=;
 b=ik78IC/YFB6+xU/9sJhG9Tu1Xmuyfi40DBbur3c6316fvlCp+zJFlpqZQI3G8VTs6A
 xFSAnt//6U+xLK1bg+KVS0oF+0dEHEw8mMnck6oVSw+ACEZpm32PHMf6QfxXzq7rc8+K
 S+ED23KxRFlVfPvBm0y1H2vww6VhVvZxWHUlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393319; x=1699998119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7obYxoGZq272gGjO1ne2rBZ52yC/PtW7SFUCnW0X4qs=;
 b=irRUEJQq916E7xK1PUfNxD31Kxw2lHzJTY0v23oijNIVpnt/+2NG+3nJ5PbHQu71Bu
 OPwQJbS5P+Iq0aK9FHlf9P4h9hTQDmyI7pYvhL2yvM9MGG7ou5KTRsPN/+8VQMlHGhVg
 iTo29JFJlHO2cQ0+EkrSnxRULRNO2UQmqpmlMOteYTFuW6SUkzO7pZawv6rJzrTmJxxe
 6kSrzJzs1kt82sUfI71qZLFaTmi/dObXQfE334Vu52aB+3DSa12zVlBKpfx3L7rskCPi
 02NkPOCz08UQh+VpBJilQLRJsF3QNPCsnLW/oj/BxS2wOJoLJd9z4Xq6IN3vnmhVMoxp
 Gx1g==
X-Gm-Message-State: AOJu0Yw3X6cFp2eI37FLxIwvUJRwYLt4Y7k+LvKD44IPutRrTiFUSuX8
 hyDG/8iYyqIaciQD+jy91yR7/0DbrdzPf+bYR98=
X-Google-Smtp-Source: AGHT+IGAcyFFvN0ZY/NpFbk/yObGdEYHsx5gwMDxLW/C39HjPC+RrGw9QHVS654CK3kEYxRqtIXk3Q==
X-Received: by 2002:adf:fc85:0:b0:32f:7ff9:b753 with SMTP id
 g5-20020adffc85000000b0032f7ff9b753mr19614wrr.62.1699393318799; 
 Tue, 07 Nov 2023 13:41:58 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:41:58 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 04/24] test: hush: Test hush variable expansion
Date: Tue,  7 Nov 2023 23:41:01 +0200
Message-Id: <20231107214121.132079-5-francis.laniel@amarulasolutions.com>
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
index 1d9149a3f6..faef5fe874 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -499,5 +499,11 @@ def test_ut(u_boot_console, ut_subtest):
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

