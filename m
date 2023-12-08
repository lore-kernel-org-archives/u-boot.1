Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E385DC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07FCB876FF;
	Fri,  8 Dec 2023 23:31:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rIqMZikg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B66E876A4; Fri,  8 Dec 2023 23:31:35 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B55F87525
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40c2308faedso26996535e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074686; x=1702679486;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doWty2U9xWIS6+YzeofXrePWP4HMK9WU0hHwvvDf5u0=;
 b=rIqMZikg3IODOaiEdMUoEXpZaV/SdriqMWnMvWR9IzOHwRt60MxkrowKuZkgptjrcW
 su47g+ptaagVNb5cpwMVZM/DdoUU3xXW3Kzw50h/fwD8QTvCkoq2+fNQgEgcROs7vSb3
 dPNuMesuvNQ3wcA1oUUMyo3pMgPoMXAG4x66k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074686; x=1702679486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doWty2U9xWIS6+YzeofXrePWP4HMK9WU0hHwvvDf5u0=;
 b=oV7bLoNXtahpxXOAFwTEmG8Rf3gEAT+wuFqj4pnQb7moIJ/CN9zHEJobe3VlOzVW9F
 C8kmjenn0eSmLlkFyjvvIEzSf5kcJ+0/eq3a+r3Tyenvjn0KHXozfyTnb74t0NobFcrP
 gvkC+6jBmGuGA7xNOVCTFQKuweiGLSD0ReOugsJ5mhaCrENe8pfGqYu22iMbdXS2tS7k
 Uib/NvgM5fSX1vFyKkJbe74angUSraDFuRrk/90ArVseOYLgndl8DBZ6+qDZYvtvYnZu
 dvsPW54l1IpXZ+McCcmsX9xo+qZvwbXH1pR7R7dlL7Ntuusa8UCBB1h7cBf+fw5/1htf
 t+RA==
X-Gm-Message-State: AOJu0YyN8vRjGS0AX/w+V1Z9M2Rx2vBrOHBfQHaxEFD+/momCKJvcRH6
 bNB1KcYD1wI0lb938J+N0UJF0OGaJdaqZTQebEyzQw==
X-Google-Smtp-Source: AGHT+IE0T2Hs0956TK02Lq5TTRzkzcL4yTE45aKG1NlO1yj7wrEFjrBPwkGZUbiPybf1zHIQ+nkl4Q==
X-Received: by 2002:a05:600c:ac6:b0:40b:5e21:d361 with SMTP id
 c6-20020a05600c0ac600b0040b5e21d361mr366023wmr.106.1702074686003; 
 Fri, 08 Dec 2023 14:31:26 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:25 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 21/24] test: hush: Fix loop tests for modern hush
Date: Fri,  8 Dec 2023 23:30:22 +0100
Message-Id: <20231208223025.55076-22-francis.laniel@amarulasolutions.com>
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

Modifies return code got from while loop as modern hush always returns 0 from
while loop.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/loop.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/test/hush/loop.c b/test/hush/loop.c
index ca777e38fe..80a9071a80 100644
--- a/test/hush/loop.c
+++ b/test/hush/loop.c
@@ -9,6 +9,9 @@
 #include <env_attr.h>
 #include <test/hush.h>
 #include <test/ut.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 static int hush_test_for(struct unit_test_state *uts)
 {
@@ -21,7 +24,12 @@ static int hush_test_for(struct unit_test_state *uts)
 	ut_assert_nextline("quux");
 	ut_assert_console_end();
 
-	puts("Beware: this test set local variable loop_i and it cannot be unset!");
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/* Reset local variable. */
+		ut_assertok(run_command("loop_i=", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		puts("Beware: this test set local variable loop_i and it cannot be unset!");
+	}
 
 	return 0;
 }
@@ -31,12 +39,30 @@ static int hush_test_while(struct unit_test_state *uts)
 {
 	console_record_reset_enable();
 
-	/* Exit status is that of test, so 1 since test is false to quit the loop. */
-	ut_asserteq(1, run_command("while test -z \"$loop_foo\"; do echo bar; loop_foo=quux; done", 0));
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * Hush 2021 always returns 0 from while loop...
+		 * You can see code snippet near this line to have a better
+		 * understanding:
+		 * debug_printf_exec(": while expr is false: breaking (exitcode:EXIT_SUCCESS)\n");
+		 */
+		ut_assertok(run_command("while test -z \"$loop_foo\"; do echo bar; loop_foo=quux; done", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		/*
+		 * Exit status is that of test, so 1 since test is false to quit
+		 * the loop.
+		 */
+		ut_asserteq(1, run_command("while test -z \"$loop_foo\"; do echo bar; loop_foo=quux; done", 0));
+	}
 	ut_assert_nextline("bar");
 	ut_assert_console_end();
 
-	puts("Beware: this test set local variable loop_foo and it cannot be unset!");
+	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/* Reset local variable. */
+		ut_assertok(run_command("loop_foo=", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		puts("Beware: this test set local variable loop_foo and it cannot be unset!");
+	}
 
 	return 0;
 }
-- 
2.34.1

