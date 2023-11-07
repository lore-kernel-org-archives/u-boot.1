Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E85C4167B
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6A228768F;
	Tue,  7 Nov 2023 22:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qhG+FeVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E1E88761D; Tue,  7 Nov 2023 22:42:31 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6913787261
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c72e275d96so18274341fa.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393338; x=1699998138;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5epPPrqyQRNNcDRSQcDJBJ+adnfp21yFSfJ0L+ysfMg=;
 b=qhG+FeVNc4SpEvU6NBkEkbHLtptO6LOeYEi6U0tBXHz7ZQAq/OMkTfZCnw3qWN7WH8
 J2cA+cRgTGFINAJSrESAx8liXgmNqD5h7KwhF6tIu2w95tGvolqpfwsmhl1sUeKXtHIy
 nueLVTtKQ+IfjSqyCGXqC5qB7uRWH4Is6v2rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393338; x=1699998138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5epPPrqyQRNNcDRSQcDJBJ+adnfp21yFSfJ0L+ysfMg=;
 b=UaVobrJEpXqpkqadN2M567yh9Dm8Facu7H727V0F21v5aCX60NzuDq9d8AUL88xj8x
 gRzzLCZw4jrzzXftq/znrZ2SDopCi1VshmRYb/UTsRcMwG5XWjJpP4aQav+TEcQPEd/W
 mxIEz7IzY0kPKQsRxOuROgnIVuFW7XIc4leXhpIPL5NBqCGgJkQAFw0UZ4zaZwvZgPVw
 O1q4AMPwGRFWtRfWO/VAX4aeMACkJZ7eQ8R8m44VZhp5pwOlQx7BXkLdoCVxqGR9rrez
 AjXeEk243CW3qEq/PVbuTpLYYpcs8dElLVLjAIpvTzgboLWbgTFZ20iB8U1TUTs3u+KN
 AdCQ==
X-Gm-Message-State: AOJu0YzHWsKcW3owNGZLITLpjeKGEiGksNpSX4RDfqgtug1TaMePRC02
 kcHgswb3cIIXqnFT49p3YwUKvUYKYaE46riyIGA=
X-Google-Smtp-Source: AGHT+IFViY/Rw/TRjHbUS59IDqvjVCX/V0Awq2NslGJ7lLBZz+GSdXdz+UqvkvcZfT33JJMQgyZ9RQ==
X-Received: by 2002:a2e:8403:0:b0:2c7:1ae6:e6ac with SMTP id
 z3-20020a2e8403000000b002c71ae6e6acmr186351ljg.6.1699393337759; 
 Tue, 07 Nov 2023 13:42:17 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:17 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 17/24] test: hush: Fix variable expansion tests for hush
 2021
Date: Tue,  7 Nov 2023 23:41:14 +0200
Message-Id: <20231107214121.132079-18-francis.laniel@amarulasolutions.com>
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

Modifies the expected result for hush 2021.
Indeed, there were bugs in actual U-Boot hush which were fixed in upstream
Busybox.
As hush 2021 is based on upstream Busybox, these bugs no longer exist.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/dollar.c | 79 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 69 insertions(+), 10 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index defb2c3fd0..f23392c72d 100644
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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

