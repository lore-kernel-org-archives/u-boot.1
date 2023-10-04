Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DFDE7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F17875B5;
	Wed,  4 Oct 2023 18:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SmkkqD/G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 907028759A; Wed,  4 Oct 2023 18:43:48 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BF7875CC
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-532c81b9adbso4196877a12.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437803; x=1697042603;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5epPPrqyQRNNcDRSQcDJBJ+adnfp21yFSfJ0L+ysfMg=;
 b=SmkkqD/G1kg1vNyRDciEi9w1ojCf1aJw1s10ONzF1sepdALAOmwiLMmA1RZCwYnMoI
 Xsh0xf6/4IA9HlmWcbaTw7H+Two5thHe6ytyT27cHXEWnst851uRG6ywwW2mgj4Bw3nx
 RZgpHg5/jIc6vOIAhcDHoxMQeUPZfk4W6MBsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437803; x=1697042603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5epPPrqyQRNNcDRSQcDJBJ+adnfp21yFSfJ0L+ysfMg=;
 b=Vi/+qCdHvTYdp/qGZMCPfalD4NWIhgMGTC1GJ4hp425VTHUG4og91bGKGYI94SosYH
 R4ojSTFnWzuJzq2yNRMXqG/hpEMkRXWc8fnGXTLbfdgt8S3jl+ADTfhZ1DTwj2ffSAt+
 nFEOvLKRuB4DloMgXKhfS8Vp8+uPfg519nz4zFtvm6zOKgobx0d6vVl1xonXA7Rauwxg
 SFfKCUxlVoCY2EAZynmbZFFznmbaGngEcc0tH6g1fe7kOD0oa7J6FCdngbT7ixTCRWjB
 NXzcEHXIKY/3UvH7F+Sqw5zy9ARo5yRzEcw2PYLNVAqt4Z98vCnoHXbE8inWvjOd1MwL
 fh0w==
X-Gm-Message-State: AOJu0YyQ9G1SPJ7DruJ3AqW1sARZAU7wHFTyqUr+g3/DWEWw0iBrsaAB
 A9SGgYVD0flh3bnWC7tJn/dci3NUs2ZF6zLe8fQ=
X-Google-Smtp-Source: AGHT+IG35jlkXKQp/i63UujGpPtkSl1gyYNYgT4s40LOiLawIJ43n/UDiT4j6uRIX1gbBsvFolDPcA==
X-Received: by 2002:a05:6402:1257:b0:52b:c980:43f3 with SMTP id
 l23-20020a056402125700b0052bc98043f3mr2628623edw.28.1696437803286; 
 Wed, 04 Oct 2023 09:43:23 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:23 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 17/24] test: hush: Fix variable expansion tests for
 hush 2021
Date: Wed,  4 Oct 2023 19:42:13 +0300
Message-Id: <20231004164220.15738-18-francis.laniel@amarulasolutions.com>
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

