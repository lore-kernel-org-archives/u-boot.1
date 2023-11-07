Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A41EC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F337A87670;
	Tue,  7 Nov 2023 22:42:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QNMUjW7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E2A8764C; Tue,  7 Nov 2023 22:42:10 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21F587633
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so52804135e9.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393321; x=1699998121;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=QNMUjW7nnk7hIKXGh6kC6gZdbF1m1c8SpVSc1KFLGp/FAEcRwqfG9WfBKOBIyv3/eh
 /FND03UOsb3ha2HLg0EfCbkda6qdqnD80tt+u6UpjJpDtpJ4RN0iOwCixFQhUGJWlrRO
 CwRiOg5ZHZRvKI0A+ltrD3M2MY07i1szOD5Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393321; x=1699998121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=fz7NWdPfVk+oKimfJUc8GU0jax71MueaM51o0j51cX9Ez2VIOGdemrVsw4VGOPdoNz
 WIsTXNJ68z6+qyPNYVSX4SHcdbclncJrwP9slKnSbj4jXjz6Gal2fVSPnCwKTJBhhPrU
 +satAUMzOQealcmlM8WoMxB+OkmOEa7ixCdPYLF063od6KbB+YJ3CQHa0dbqT7mz5NKZ
 Sve62G7/LJNe9OWe2gHsGRRg/TKRTx+dEsHoCoW9OubdW31fhox0CCZ78fmTqfHXwsoS
 8Cgr89osPufS8DZ0BxZPAkOeIfs5AJz/6nlerG7osRLImr4THsi/oTcIyjr7rfkc50IR
 X8TA==
X-Gm-Message-State: AOJu0YzdeTJw2WQUUE5UnwdUtxSZ0vc86aHBehTi9b5TDy2ny//SrVrI
 uJVi47O8Xm+wZWfg3SI9QMXhT+I/bhLX5dMGm/M=
X-Google-Smtp-Source: AGHT+IHjqvjyyxw0NfLNUK97Zq+xKQmpqC1ehA42uyK14U8wtQ3ES6fz7ZQ38dIlq3bS9KtmsrdFXw==
X-Received: by 2002:adf:f20d:0:b0:32f:889a:2b9f with SMTP id
 p13-20020adff20d000000b0032f889a2b9fmr12293wro.15.1699393321111; 
 Tue, 07 Nov 2023 13:42:01 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:00 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 06/24] test: hush: Test hush loops
Date: Tue,  7 Nov 2023 23:41:03 +0200
Message-Id: <20231107214121.132079-7-francis.laniel@amarulasolutions.com>
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

