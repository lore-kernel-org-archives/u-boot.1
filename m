Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84715E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEEE08757E;
	Wed,  4 Oct 2023 18:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JhmMnqRe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A99FD87591; Wed,  4 Oct 2023 18:42:56 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CFE087513
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52fe27898e9so4505026a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437771; x=1697042571;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwEIoBRzDMfib4wpua2a5vZNPxfG7SL92b0tVloomGY=;
 b=JhmMnqReQ0AwU/lTExfZgiFGRvJcFyhGqcsbId73+nnDxxXD00GO3f6Wgh4RDkZuHZ
 qJpXI+7mBYWMS0HYjWpF6ifFFkaJTvIN4Y1GZm77VTriGbAz1Hs7BbWJ0S0lEf1ohJ6O
 74reM2t2QW0J6udm1XDyOs7evpWwQXcHM3U1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437771; x=1697042571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwEIoBRzDMfib4wpua2a5vZNPxfG7SL92b0tVloomGY=;
 b=MVJ6uRqCFWqznuIbhkRV4d3UBrUSb/EJ7sRm7UNTqX6VyPcldr9vMrefvyadBPxiH7
 8BifZm1WMyteSJZTdIkprnpcl0NSGBFLxZpGGikcf/cgcogbbYYBaojJj3YLFnw6rLBE
 L9jzq7rdNXXpMpFIEKz7jwoEU3aCLSFyCJ+LR44a9lb+395It2YNrnzzfeg0clyPS0bF
 tCgFKe9FeeMA4DFtjInX0XjMukzGU+Br7pQxejfJSGpTkIdSak3hSEc1NQfefysYP6FA
 C9XuNsFkTSPFdJvzt3swJ3REY56Luvob2F/h52tCwQwMe045YYyqaswEB3CmMNzR1xT5
 Uc/Q==
X-Gm-Message-State: AOJu0YwmWUyT5LFUEh0l9qsEglURJuMeB3T26JG2ZiLwsTW8ycP6oblV
 /+dMCtffLSHhuWdD+6spDVxeF4Rcbhb8ytWRCf8=
X-Google-Smtp-Source: AGHT+IEkOjDM08OagXDzveDZyepqsANf3S5IPAV7e5cE8XzJHg/cqTwwZX8mBA/MtBSe2yh/shkRAg==
X-Received: by 2002:a05:6402:7d6:b0:523:1fa2:4f40 with SMTP id
 u22-20020a05640207d600b005231fa24f40mr2546652edy.19.1696437771063; 
 Wed, 04 Oct 2023 09:42:51 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:50 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 02/24] test: hush: Test hush if/else
Date: Wed,  4 Oct 2023 19:41:58 +0300
Message-Id: <20231004164220.15738-3-francis.laniel@amarulasolutions.com>
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

As asked in commit 9c6bf1715f6a ("test/py: hush_if_test: Add tests to cover
octal/hex values"), this commit translates test_hush_if_test.py to a C test.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/hush/Makefile |   1 +
 test/hush/if.c     | 316 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 317 insertions(+)
 create mode 100644 test/hush/if.c

diff --git a/test/hush/Makefile b/test/hush/Makefile
index dfa2a92615..a3c9ae5106 100644
--- a/test/hush/Makefile
+++ b/test/hush/Makefile
@@ -4,3 +4,4 @@
 # Francis Laniel, Amarula Solutions, francis.laniel@amarulasolutions.com
 
 obj-y += cmd_ut_hush.o
+obj-y += if.o
diff --git a/test/hush/if.c b/test/hush/if.c
new file mode 100644
index 0000000000..b7200e32ec
--- /dev/null
+++ b/test/hush/if.c
@@ -0,0 +1,316 @@
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
+/*
+ * All tests will execute the following:
+ * if condition_to_test; then
+ *   true
+ * else
+ *   false
+ * fi
+ * If condition is true, command returns 1, 0 otherwise.
+ */
+const char *if_format = "if %s; then true; else false; fi";
+
+static int hush_test_if_base(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "true");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "false");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_base, 0);
+
+static int hush_test_if_basic_operators(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test aaa = aaa");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa = bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa != bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa != aaa");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa < bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test bbb < aaa");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test bbb > aaa");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa > bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -eq 123");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -eq 456");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -ne 456");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -ne 123");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -lt 456");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -lt 123");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 456 -lt 123");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -le 456");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -le 123");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 456 -le 123");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 456 -gt 123");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -gt 123");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -gt 456");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 456 -ge 123");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -ge 123");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 123 -ge 456");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_basic_operators, 0);
+
+static int hush_test_if_octal(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test 010 -eq 010");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 010 -eq 011");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 010 -ne 011");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 010 -ne 010");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_octal, 0);
+
+static int hush_test_if_hexadecimal(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -gt 0x2000001");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -gt 0x2000000");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -gt 0x1ffffff");
+	ut_assertok(run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_hexadecimal, 0);
+
+static int hush_test_if_mixed(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test 010 -eq 10");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 010 -ne 10");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0xa -eq 10");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0xa -eq 012");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 2000000 -gt 0x1ffffff");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -gt 1ffffff");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -lt 1ffffff");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -eq 2000000");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test 0x2000000 -ne 2000000");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test -z \"\"");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test -z \"aaa\"");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test -n \"aaa\"");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test -n \"\"");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_mixed, 0);
+
+static int hush_test_if_inverted(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test ! aaa = aaa");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! aaa = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! ! aaa = aaa");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! ! aaa = bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_inverted, 0);
+
+static int hush_test_if_binary(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test aaa != aaa -o bbb != bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa != aaa -o bbb = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa = aaa -o bbb != bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa = aaa -o bbb = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa != aaa -a bbb != bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa != aaa -a bbb = bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa = aaa -a bbb != bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test aaa = aaa -a bbb = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_binary, 0);
+
+static int hush_test_if_inverted_binary(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	sprintf(if_formatted, if_format, "test ! aaa != aaa -o ! bbb != bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! aaa != aaa -o ! bbb = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! aaa = aaa -o ! bbb != bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! aaa = aaa -o ! bbb = bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format,
+		"test ! ! aaa != aaa -o ! ! bbb != bbb");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format,
+		"test ! ! aaa != aaa -o ! ! bbb = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format,
+		"test ! ! aaa = aaa -o ! ! bbb != bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test ! ! aaa = aaa -o ! ! bbb = bbb");
+	ut_assertok(run_command(if_formatted, 0));
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_inverted_binary, 0);
+
+static int hush_test_if_z_operator(struct unit_test_state *uts)
+{
+	char if_formatted[128];
+
+	/* Deal with environment variable used during test. */
+	env_set("ut_var_nonexistent", NULL);
+	env_set("ut_var_exists", "1");
+	env_set("ut_var_unset", "1");
+
+	sprintf(if_formatted, if_format, "test -z \"$ut_var_nonexistent\"");
+	ut_assertok(run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test -z \"$ut_var_exists\"");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	sprintf(if_formatted, if_format, "test -z \"$ut_var_unset\"");
+	ut_asserteq(1, run_command(if_formatted, 0));
+
+	env_set("ut_var_unset", NULL);
+	sprintf(if_formatted, if_format, "test -z \"$ut_var_unset\"");
+	ut_assertok(run_command(if_formatted, 0));
+
+	/* Clear the set environment variable. */
+	env_set("ut_var_exists", NULL);
+
+	return 0;
+}
+HUSH_TEST(hush_test_if_z_operator, 0);
-- 
2.34.1

