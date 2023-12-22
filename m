Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC9DC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:04:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 385928777D;
	Fri, 22 Dec 2023 22:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mpRalrb4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428D8874E0; Fri, 22 Dec 2023 22:03:17 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40709871CE
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d2376db79so17311185e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703278994; x=1703883794;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=mpRalrb4mCDetxbkj8fz+QIEYuISmEK2fS3cpVUh3o1Po3IFDkPqwQktOWyAVtJfWY
 qeIrbIgb3Fg6tPP6P7jcE/Qwm+O7g/NvdCbG5gECqEgdVEPrxVxs1pirekZ/VZF3Pthz
 82xDSKm2MqWLMbIUtV5LkFeDQC5SvXKjMyUzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703278994; x=1703883794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=mCofBAGK1PA+1hAhYuROTaK66oRshh+WrYFfHvsA8pwHjcZCBdoX7Vj6cnJJqQ4Xbw
 UUsaA6mDUK4haz7k1UlYh956EwOYaGy+eLp4VT9ozTjCMH8XF4KNK3+5cQ2kqVPwSNmW
 UPln8JlI791w7w8QfzboIWyn7W8kogcIbS2q6XNpU2d0jWwH8hrnPDnGT50GfVHN2dFi
 osCF5dL2LipB084tzl+ELoCtreP8+a9RYEo5sRPN0DtDybfPrqlMTLCDL0aJbkWmV4Wk
 7cnw5J5V3RpQ/5lvbReeD9+8tJ7NeYDJJGSkm/aZqOy51mMquRLj7LYIwXeoHi0frPfu
 BLYw==
X-Gm-Message-State: AOJu0Yy4y7qaWgsnaSUp7aJLn+JNWb0UmTDQCFPry2AkdwEsG1a+nyeL
 UoFoyAJUncD75daAh9Cc6oxkEcmGDZ+GYZGnPIVXR42NMBk=
X-Google-Smtp-Source: AGHT+IEdyrugGViIIFMTu6xSR4PfScsE8hQY9Eyyzyh8eyBa1V2isJ7qS69Bzze6rgBtgvC8lICqnA==
X-Received: by 2002:a05:600c:3152:b0:40c:4ca8:6aca with SMTP id
 h18-20020a05600c315200b0040c4ca86acamr1216512wmo.109.1703278993852; 
 Fri, 22 Dec 2023 13:03:13 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:13 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 06/24] test: hush: Test hush loops
Date: Fri, 22 Dec 2023 22:02:26 +0100
Message-Id: <20231222210244.91830-7-francis.laniel@amarulasolutions.com>
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

