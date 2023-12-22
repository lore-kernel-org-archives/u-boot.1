Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B20C47073
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:03:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384FE87519;
	Fri, 22 Dec 2023 22:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KiUSzuz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A0AA877AC; Fri, 22 Dec 2023 22:03:14 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59CA487640
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d3352b525so21739315e9.1
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703278991; x=1703883791;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hH2RuCYIMJgE0d+2m6lVN3AKbaGXIDBX7YxKp2x1SGU=;
 b=KiUSzuz/HQcJTXilLzYeHumMHGOmFvs0R90R4KzOT5SPJn9Dy1JZtKkE2ZKzGTHtlR
 +m3vmi5mhG12wXYq0vqrzlEA0Lpltv80PS6zLF/6HEvxY2vtrhXaWVfDnYcwCU7FkPat
 7lt63Ml8utvPmtccSmp6K4VnzXQa1shN5SDlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703278991; x=1703883791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hH2RuCYIMJgE0d+2m6lVN3AKbaGXIDBX7YxKp2x1SGU=;
 b=tkjpucniYkAB7WN0GtlEzoicjJ/jSlWBVfcToHh6F/Hgfg/AINTVwU8VfcyXmGJbvM
 9+/J18i3Yab6RUn52pOvRNSRt9kpbl9/MmLvcxvKd8tngIyfY3ajIphoSvakBYnylhHd
 3x2UXNHuSevpXPWaxZ8G1T0e8uKLSLyeugZfGvm7X5xIp/nVk3s4Q7Qwe6CqtQuKeF/v
 5abyZ5Ji8rLRZgiX8pGbEnog0thv03pAA2YJ76BXRXq/X9f0kxwi0tXLd4czR2uLmHE5
 VVPSnZDIEgyePu/kJI85nt7RzEuYwVfcU98VUr8hfnya0P0RuBy8hOvgL7DqzcCnopsG
 DlkQ==
X-Gm-Message-State: AOJu0Yw3QQeIHwCJ3pkHsIVLcdt5tv61tTXAN8MC7WVNQq+9WA/71It9
 S5YVPEeFpHuXZV2zB1/f8k9abjDlTLlDApFSBioqy0v4MFc=
X-Google-Smtp-Source: AGHT+IGNMweOeCrvKjjKnHMX/ZQ6aZ6pMm7lgzqvoa6ngpFdC3N7CxUUn2YZtKYMHEw1dQfqhvQWrQ==
X-Received: by 2002:a05:600c:1c22:b0:40d:2dbe:b124 with SMTP id
 j34-20020a05600c1c2200b0040d2dbeb124mr1055169wms.87.1703278990766; 
 Fri, 22 Dec 2023 13:03:10 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:10 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Alexander Gendin <agendin@matrox.com>
Subject: [PATCH v13 04/24] test: hush: Test hush variable expansion
Date: Fri, 22 Dec 2023 22:02:24 +0100
Message-Id: <20231222210244.91830-5-francis.laniel@amarulasolutions.com>
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
index 0e3a48e73f..c169c835e3 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -500,5 +500,11 @@ def test_ut(u_boot_console, ut_subtest):
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

