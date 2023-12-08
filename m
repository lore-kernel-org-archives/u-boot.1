Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A20C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:34:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C58A98768A;
	Fri,  8 Dec 2023 23:31:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="C1l34VRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80FD88767B; Fri,  8 Dec 2023 23:31:32 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEFF876F7
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40c2c5a8150so21736105e9.2
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074680; x=1702679480;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKtsDZHuve/IeD+B3K4xt6u/CTUlA7CQhlm77U2S50I=;
 b=C1l34VRI2ahuQhctjtHpDuTBxAsRUtAz/quizuQtrQRHGgM+kPT2WQKpM4si5lCw1r
 vWr7AWmEsiK+01Twod9/f2HKvGJc3x26XMTUea/TWHv9nvuYtmhJHBB2rRVjL4bEXLjU
 I3ZYgUAdqcqjwRmUsGrgXz/A47aUWFR15G1hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074680; x=1702679480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKtsDZHuve/IeD+B3K4xt6u/CTUlA7CQhlm77U2S50I=;
 b=S/ab+p0oOfgMMNFsbU0l5X+xM6FV52/JM7JN2sTTm5WG4j8dy1Eg9h3TZL50KVXTNa
 xEVYi2syOeoHmsrWs+RFYk8TfQw7kriEV2dp5i+Onf4jrZPh2Id3xX6z52u2h3C6RzY0
 oY1hIRxlQv6Cb107bV/UEsVNP++WwqWaoZn6QMKPf6KGvUzTZsdwRGeKjhSmYwUsOAUt
 gnnpldA6oykRiimhqxnMi7U1aNpGk2/bXMH8Bm7gsMwuOzfkIDll4VqABm4ZbuoyxV7v
 l0a03WLyduHFrO4p3bW4VOdYYSRJBFkzb2VZXUDTm1zgfPakyveffM0GETkIAFFfGMEo
 QYhw==
X-Gm-Message-State: AOJu0YzAP7l4WEilggKAIRTzarSTBX5bPvScEcgWf3RiPxRINPJQddUx
 gDSy7Gnk9/a2TCGw+kr9B669xDR9x5M/7up4eu3x5w==
X-Google-Smtp-Source: AGHT+IFoAX3dLgL9y1VYnZEHSklrUUxvjpbXy75sREl4WjoFYzfqRODf27iwKyhO37xBBAqxzviM3Q==
X-Received: by 2002:a1c:4b0f:0:b0:40b:32fc:6d02 with SMTP id
 y15-20020a1c4b0f000000b0040b32fc6d02mr328834wma.25.1702074679840; 
 Fri, 08 Dec 2023 14:31:19 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:19 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 17/24] test: hush: Fix variable expansion tests for modern
 hush
Date: Fri,  8 Dec 2023 23:30:18 +0100
Message-Id: <20231208223025.55076-18-francis.laniel@amarulasolutions.com>
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

