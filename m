Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68836E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:44:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABED4875E2;
	Wed,  4 Oct 2023 18:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LwffOuIk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC14875BD; Wed,  4 Oct 2023 18:43:16 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00B3B8759B
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so4053234a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437778; x=1697042578;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=LwffOuIkLpw6lj0Jl4XGnuiHg9AebNpPI7Fwx/3R5/b41wFxSnNbmWUH65WL4XkByd
 TGsaLCLkfOipWD+msATWLRlo8eO7UBYpPbc0rQ53yO/DCiTH9C62/5Kjk2e1OIi9+vi4
 bcH+ppztuNhnbM9H7zsIfirQCd2l9JapawcsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437778; x=1697042578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=d33zdgzxRtJlgs8jt8ko+26x4WaPqG4v+rmkZI8KmQ2ZG24l+6eqNIHkxlJJjbauc0
 amwfH/Xh9AMNxdmSWIYSrHmyrYnIIpcVOE8MJTdAYXFxc5YZxsGitOhw697/uweit/ls
 ad8gB7yZLguP3nICGv9HVyfv+fM4T8gIYyMs2dWfd0A2LEuIlxKrTLox800+ldLdxnT8
 H0ly8fv5yNTxeZAEbRDFZau9XEFp+tjwXv7fjoK/CZmgqfiBiHfLj/o4SQMkXnpj7bAD
 9tvcu5OHksgjMzWsCqpEHHdfVem6acO541dJ2xjlCK5LCxOsQahqGFE1F6eKVsWSuC1d
 GoGQ==
X-Gm-Message-State: AOJu0Yzvi4ynkPLivrFByS1HysZxmxPiZVTwwQxxw6gGRUkB0OH5hXxa
 9GwpSvNHTpcdW9Zee/qBiO7ADpEbr/6EE/OmQF8=
X-Google-Smtp-Source: AGHT+IFJ1nc96Vw+cbg7uC5Lbm8TBKcBBKFkW2IqtkGa7o72uOqduo12T9uWNWqDBdgVm2caPTn7lg==
X-Received: by 2002:a05:6402:353:b0:526:5c70:7318 with SMTP id
 r19-20020a056402035300b005265c707318mr2565631edw.6.1696437778126; 
 Wed, 04 Oct 2023 09:42:58 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:57 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 06/24] test: hush: Test hush loops
Date: Wed,  4 Oct 2023 19:42:02 +0300
Message-Id: <20231004164220.15738-7-francis.laniel@amarulasolutions.com>
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

The added tests verifies correct behavior of for, while and until loops.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/hush/Makefile |  1 +
 test/hush/loop.c   | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 test/hush/loop.c

diff --git a/test/hush/Makefile b/test/hush/Makefile
index ff4fe7700b..a2d98815e5 100644
--- a/test/hush/Makefile
+++ b/test/hush/Makefile
@@ -7,3 +7,4 @@ obj-y += cmd_ut_hush.o
 obj-y += if.o
 obj-y += dollar.o
 obj-y += list.o
+obj-y += loop.o
diff --git a/test/hush/loop.c b/test/hush/loop.c
new file mode 100644
index 0000000000..ca777e38fe
--- /dev/null
+++ b/test/hush/loop.c
@@ -0,0 +1,65 @@
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
+static int hush_test_for(struct unit_test_state *uts)
+{
+	console_record_reset_enable();
+
+	ut_assertok(run_command("for loop_i in foo bar quux quux; do echo $loop_i; done", 0));
+	ut_assert_nextline("foo");
+	ut_assert_nextline("bar");
+	ut_assert_nextline("quux");
+	ut_assert_nextline("quux");
+	ut_assert_console_end();
+
+	puts("Beware: this test set local variable loop_i and it cannot be unset!");
+
+	return 0;
+}
+HUSH_TEST(hush_test_for, 0);
+
+static int hush_test_while(struct unit_test_state *uts)
+{
+	console_record_reset_enable();
+
+	/* Exit status is that of test, so 1 since test is false to quit the loop. */
+	ut_asserteq(1, run_command("while test -z \"$loop_foo\"; do echo bar; loop_foo=quux; done", 0));
+	ut_assert_nextline("bar");
+	ut_assert_console_end();
+
+	puts("Beware: this test set local variable loop_foo and it cannot be unset!");
+
+	return 0;
+}
+HUSH_TEST(hush_test_while, 0);
+
+static int hush_test_until(struct unit_test_state *uts)
+{
+	console_record_reset_enable();
+	env_set("loop_bar", "bar");
+
+	/*
+	 * WARNING We have to use environment variable because it is not possible
+	 * resetting local variable.
+	 */
+	ut_assertok(run_command("until test -z \"$loop_bar\"; do echo quux; setenv loop_bar; done", 0));
+	ut_assert_nextline("quux");
+	ut_assert_console_end();
+
+	/*
+	 * Loop normally resets foo environment variable, but we reset it here in
+	 * case the test failed.
+	 */
+	env_set("loop_bar", NULL);
+	return 0;
+}
+HUSH_TEST(hush_test_until, 0);
-- 
2.34.1

