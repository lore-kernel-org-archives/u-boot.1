Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C24CC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5803E8770F;
	Fri, 22 Dec 2023 22:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rNZ1epTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 840C387895; Fri, 22 Dec 2023 22:03:42 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E9C186C67
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c2bb872e2so22564365e9.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279014; x=1703883814;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKtsDZHuve/IeD+B3K4xt6u/CTUlA7CQhlm77U2S50I=;
 b=rNZ1epTFNbvE5YMmGWcsCHPBvzhbw8y6vNHZvMDtbrSMdFWpE5t700l5rlzHaTRS2X
 MF/ye9H4H+qjqqGORhmGPzTQaZN7lb2gx8gBNGHdNQ5lN19xxHh3ygRT31O89l8Xv/Ku
 K5qm9oZsrsjXSEHM0ILrs6SYpGnofrXsUBWB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279014; x=1703883814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKtsDZHuve/IeD+B3K4xt6u/CTUlA7CQhlm77U2S50I=;
 b=nGIW4yrEBa+xBV0hCer55/SjJPyXFvmUaLfmJTw/H4vnBMds2ZGSkoSCftkYhR34FG
 PmZzQrk+M+oCXrxogktoNex1naqtlbAaNNeiEcV7hwwjHVS2txJ37kb6FSA6yjec7Xcl
 qhvVa17y66wCVnwyCImk+QRqgp/ebszyrGB0YeKkYpQhLJgdR8bCynOG04f0gdHLF2f1
 MFjATSCWxxjN7Y1Hf2d6KZvweu7vwBqK9xHzC3e035czqyWjkpNHDlbWF2i2uPjGbtZE
 a3pSQw45/fzrT7SJYb/HzGZDox3lPg9Z6JByZnyRDeuK1WFi+IGZNWVHCzFzmN/YYrqw
 NJbw==
X-Gm-Message-State: AOJu0YzYwnSDDb4HMqm9VXQCkMPEMmWAiD7G3iJRdOyY1sF5ErdRpdKE
 WFLkKwowS5E5EjrLE2o33wYyt3117WxQS0yXiH2t1xeJQGc=
X-Google-Smtp-Source: AGHT+IGTR4P1bf3SVlsfu+h4zKXdLhX3XqJQHhFGsUup56cNOc6pm97H60YBnLAyIbh7HjWyqmbkMQ==
X-Received: by 2002:a05:600c:4f54:b0:40d:4a78:1227 with SMTP id
 m20-20020a05600c4f5400b0040d4a781227mr287326wmq.33.1703279014605; 
 Fri, 22 Dec 2023 13:03:34 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:34 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 17/24] test: hush: Fix variable expansion tests for modern
 hush
Date: Fri, 22 Dec 2023 22:02:37 +0100
Message-Id: <20231222210244.91830-18-francis.laniel@amarulasolutions.com>
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

Modifies the expected result for modern hush.
Indeed, there were bugs in actual U-Boot hush which were fixed in upstream
Busybox.
As modern hush is based on upstream Busybox, these bugs no longer exist.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/dollar.c | 79 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index defb2c3fd0..7ab7ea7084 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -9,6 +9,9 @@
 #include <env_attr.h>
 #include <test/hush.h>
 #include <test/ut.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 static int hush_test_simple_dollar(struct unit_test_state *uts)
 {
@@ -51,13 +54,29 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("dollar_foo='bar quux", 0));
 	/* Next line contains error message */
 	ut_assert_skipline();
-	ut_assert_console_end();
+
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * For some strange reasons, the console is not empty after
+		 * running above command.
+		 * So, we reset it to not have side effects for other tests.
+		 */
+		console_record_reset_enable();
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assert_console_end();
+	}
 
 	ut_asserteq(1, run_command("dollar_foo=bar quux\"", 0));
 	/* Two next lines contain error message */
 	ut_assert_skipline();
 	ut_assert_skipline();
-	ut_assert_console_end();
+
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/* See above comments. */
+		console_record_reset_enable();
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assert_console_end();
+	}
 
 	ut_assertok(run_command("dollar_foo='bar \"quux'", 0));
 
@@ -71,17 +90,35 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
 	 */
 	console_record_reset_enable();
 
-	ut_asserteq(1, run_command("dollar_foo=\"bar 'quux\"", 0));
-	/* Next line contains error message */
-	ut_assert_skipline();
-	ut_assert_console_end();
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * Old parser returns an error because it waits for closing
+		 * '\'', but this behavior is wrong as the '\'' is surrounded by
+		 * '"', so no need to wait for a closing one.
+		 */
+		ut_assertok(run_command("dollar_foo=\"bar 'quux\"", 0));
+
+		ut_assertok(run_command("echo $dollar_foo", 0));
+		ut_assert_nextline("bar 'quux");
+		ut_assert_console_end();
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_asserteq(1, run_command("dollar_foo=\"bar 'quux\"", 0));
+		/* Next line contains error message */
+		ut_assert_skipline();
+		ut_assert_console_end();
+	}
 
 	ut_assertok(run_command("dollar_foo='bar quux'", 0));
 	ut_assertok(run_command("echo $dollar_foo", 0));
 	ut_assert_nextline("bar quux");
 	ut_assert_console_end();
 
-	puts("Beware: this test set local variable dollar_foo and it cannot be unset!");
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/* Reset local variable. */
+		ut_assertok(run_command("dollar_foo=", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		puts("Beware: this test set local variable dollar_foo and it cannot be unset!");
+	}
 
 	return 0;
 }
@@ -109,7 +146,12 @@ static int hush_test_env_dollar(struct unit_test_state *uts)
 	/* Clean up setting the variable */
 	env_set("env_foo", NULL);
 
-	puts("Beware: this test set local variable env_foo and it cannot be unset!");
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/* Reset local variable. */
+		ut_assertok(run_command("env_foo=", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		puts("Beware: this test set local variable env_foo and it cannot be unset!");
+	}
 
 	return 0;
 }
@@ -144,7 +186,18 @@ static int hush_test_command_dollar(struct unit_test_state *uts)
 	ut_assertok(run_command("dollar_bar='echo bar\\n'", 0));
 
 	ut_assertok(run_command("$dollar_bar", 0));
-	ut_assert_nextline("barn");
+
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 * Behavior of hush 2021 is coherent with bash and other shells.
+		 */
+		ut_assert_nextline("bar\\n");
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assert_nextline("barn");
+	}
+
 	ut_assert_console_end();
 
 	ut_assertok(run_command("dollar_bar='echo $bar'", 0));
@@ -160,7 +213,13 @@ static int hush_test_command_dollar(struct unit_test_state *uts)
 	ut_assert_nextline("quux");
 	ut_assert_console_end();
 
-	puts("Beware: this test sets local variable dollar_bar and dollar_quux and they cannot be unset!");
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/* Reset local variables. */
+		ut_assertok(run_command("dollar_bar=", 0));
+		ut_assertok(run_command("dollar_quux=", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		puts("Beware: this test sets local variable dollar_bar and dollar_quux and they cannot be unset!");
+	}
 
 	return 0;
 }
-- 
2.34.1

