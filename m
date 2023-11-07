Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7098FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0BFD8763A;
	Tue,  7 Nov 2023 22:42:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WLRILSJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F38A287630; Tue,  7 Nov 2023 22:42:03 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2050F8761F
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:41:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4083ac51d8aso46884195e9.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393316; x=1699998116;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pwEIoBRzDMfib4wpua2a5vZNPxfG7SL92b0tVloomGY=;
 b=WLRILSJmZLi5z9HlovP+B7BKUMMBlKW1Nmj0ULd6Ww5QBvcvYqrvKFB0hRBoZYTbtb
 X27Dauh9BYdI/xOtiNXo9nOB+xpwNAV/tc/LyulTFxOCxemlOQRjgdRiVCgANaCCLiD/
 OWZd527oSmjKz82vjhll9Tg8lPORpE1mtp3Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393316; x=1699998116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwEIoBRzDMfib4wpua2a5vZNPxfG7SL92b0tVloomGY=;
 b=M1k+ckN8Mtk2QvfRa8tRXOYg6Uwe55NZpwc9mq3XvHezCqyF3k0jaKM0M7C+5iccCm
 dQ60+XtoNiKdUKuA58p9zEPtXslgXlp/sjNDqJAQSCZBOYcDEHXx6pgi2K9dd5CdCmSl
 VwgtTi3isqIXHyTSJgokeJrGsadeMUiURTOypzMQL4osmoNt3oH/0KH9LVngGOoMLiza
 I4BCDbsbhIZzMMgUgDPAn3R+jyoBzdRXiVl0rlUQomtlwOl7fcvCiZ/EPMZExF34qAg/
 gRYjp3CkyTGKD0errZ54UMokkFqrFGpu4CQiuZzIkfSIgZm+wUYx36SABe1kBN+SkIT0
 mkpQ==
X-Gm-Message-State: AOJu0YyD7SLrruJmAlMaqp68V7QntoSAhM5B2CE99oYguWis9OvoqatA
 eS+vVcXIOCP2aWZDbzoHmSGrBsXrPSA94NEkavQ=
X-Google-Smtp-Source: AGHT+IF9iMl2uWMnVgSp0I2mRzH8YBGuUvxz/yW/Nt7gYYNn6QrPXmGrGrIeOjW77PwhU+HpS+0WcQ==
X-Received: by 2002:a05:6000:ac6:b0:32d:9718:b32a with SMTP id
 di6-20020a0560000ac600b0032d9718b32amr56601wrb.0.1699393316627; 
 Tue, 07 Nov 2023 13:41:56 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:41:56 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 02/24] test: hush: Test hush if/else
Date: Tue,  7 Nov 2023 23:40:59 +0200
Message-Id: <20231107214121.132079-3-francis.laniel@amarulasolutions.com>
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

