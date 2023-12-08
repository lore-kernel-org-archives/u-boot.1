Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC15C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA73687655;
	Fri,  8 Dec 2023 23:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VPgbz4/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B3A187651; Fri,  8 Dec 2023 23:30:59 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C1E087650
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:30:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c09d0b045so29724095e9.0
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074656; x=1702679456;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7obYxoGZq272gGjO1ne2rBZ52yC/PtW7SFUCnW0X4qs=;
 b=VPgbz4/qS0CPG26RtChb1Lpt5GO+mhiemsI8h81wk8hhymvjJo06NIeQv43yrFKzm4
 yLfWNIE0eMQjfNKP28CGZSmcsfBmAWk0Otwau5ymlQwL/RtwYVs4wf8IuKMEL6zzDIyA
 oOeiPUjUIdQOZvt8qGowcwMci4xRERAe7Vmqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074656; x=1702679456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7obYxoGZq272gGjO1ne2rBZ52yC/PtW7SFUCnW0X4qs=;
 b=BP7MwwgXB6qU9l38xxhawQGD8hVfQVMd4nbEqPbV7pu1EYLmuNOAGez2ANSLmHvwss
 uR8uz52JfX8vwDJbrBkcYNcQLbejhDCqNhd1sXPdBK882YkiYA8/O9z/13OzOVBXoZbJ
 a7g4wRTWSGUY43CzoROvgYA/3zsiMBiqTvjEMpAQo7vpBBZK5LUrkYCfq1LSqgxGw6Qr
 jL2+5aptH3ewepdQJg1x3PMobt5KcgM6BkrLZ0F5RrK6PKMvd7DEzc1CMNgbNeQ+nUXs
 5LnL4odkGGeN0uWGCZrfcsodY1KK9URDgHebjWIB/lxKli/FZkS1I9n2ommd3H+r/msW
 MIuw==
X-Gm-Message-State: AOJu0YwSeFH3iqqGWCfxe1saLe/fBEDTFNLeGHxcNrabHztjzIwe5vPn
 J1U/d8wYvYQpug37Cc8/g9PWa1g8hjU8CD2b9jh7eA==
X-Google-Smtp-Source: AGHT+IFOPyLhD58U+PPc5JIv/xcn2hkRHSGYMT27aTofYCEDNxF4yCw8cMbg3cfo8WX4fkd7YZ8AVw==
X-Received: by 2002:a05:600c:511f:b0:40b:5e1a:db8b with SMTP id
 o31-20020a05600c511f00b0040b5e1adb8bmr216936wms.44.1702074656618; 
 Fri, 08 Dec 2023 14:30:56 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:30:56 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v12 04/24] test: hush: Test hush variable expansion
Date: Fri,  8 Dec 2023 23:30:05 +0100
Message-Id: <20231208223025.55076-5-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

