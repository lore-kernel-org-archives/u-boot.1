Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF158C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECA08765E;
	Fri,  8 Dec 2023 23:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nTcviNns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57FB0874B7; Fri,  8 Dec 2023 23:31:02 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496F987634
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40c2db2ee28so22329045e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074660; x=1702679460;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=nTcviNnsgrS9usaq61AjkuqN2gJRvu+VKye63Qv3CI7xldx2b6vpCkv5dvsLLTnHNX
 jRCE7/eaRCZHaGB6uhxuq86TPGrYnoVgLTK9jHWm7xuUzSpuR9vm0D51endsvo0Etqfz
 W69jk7U9gQO7/u4algnokEgCdKt0u08YGqfoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074660; x=1702679460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2n8jxt1ds5q7Q9H17EJfwFItauiA8vIOt8u046pmLRk=;
 b=hj9Su7/NrN0/YZbQzy4rbngvSUbQcn5vKqwzfXDwlZPadgXT50U31tqRCMkCCfr9UL
 gBFqymLbbwFkvhv+KgZ54iOdXdO+9uXNGqt35IJqMCEXlI+iAPMsoRj9nMxqbe/N5G4F
 tBqqT18GNDXCBUY2RLkQsIho3nyy2voc0btqMOwmRZjdse4q1d1AYrWyj3Tj0wgTnouU
 z3N97Ct+A9mjHEIvlUqECHZ2vG63JwhJMgAhvvfo5kNyFmJxDhw2vvd5CgDVP2DFcx9p
 VhNPMEgedWPFWZ69l35Rx6HoA7Euj98qylV9VNmNHFisiZY99lSCZUUr3C5P05rz5BbW
 kZkA==
X-Gm-Message-State: AOJu0Yx4BUxG7IE84XT0PZ68rz+kugSQ7FRFXfkmfcJUn6QHbTD+U9qh
 C2UHzX0g1O4C99gzFGsto8sQAkDcS/v58Dc10NFa/g==
X-Google-Smtp-Source: AGHT+IErO0pXNI4nJvhDvXi0fzDk81TMUNOrsf1taxBXQCxOHCFVwx+dD28LccpuYYQKiWlIHIPGVQ==
X-Received: by 2002:a05:600c:d1:b0:40c:26f4:dda9 with SMTP id
 u17-20020a05600c00d100b0040c26f4dda9mr318016wmm.187.1702074659838; 
 Fri, 08 Dec 2023 14:30:59 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:30:59 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 06/24] test: hush: Test hush loops
Date: Fri,  8 Dec 2023 23:30:07 +0100
Message-Id: <20231208223025.55076-7-francis.laniel@amarulasolutions.com>
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

