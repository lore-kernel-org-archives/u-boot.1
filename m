Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CACC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:45:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4D608769A;
	Tue,  7 Nov 2023 22:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cUunXs78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8B7887660; Tue,  7 Nov 2023 22:42:35 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 130A0875CD
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32da9ef390fso3779227f8f.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393341; x=1699998141;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9K9LjGrI/UaVuFLtYeutB3YYgPxzyJaSx0JXslnwlo=;
 b=cUunXs78nWzAGXQkG5TCjMk8cKHLE/m0WDVjVx7dMCdtKAVePBTMV5DWgf1sGZ24TO
 A/cKXn4zOSQ1UwDxny9Tm0un10LWqD2UEymIZbCrbZ2Oc2B77FuDglDgI6U0+I6VQukP
 vDWhH9DnY33YG5bqXUWNfGsBvoohodfLESYA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393341; x=1699998141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9K9LjGrI/UaVuFLtYeutB3YYgPxzyJaSx0JXslnwlo=;
 b=vYXbe9Q641mllhjBIihCwrTzFn7/N7DGajrONnwGFU8gYCBZjeOBYA5ti8/1ina0U3
 LfqAi3cMO6On2CNGyJmAXiM/2w1AikHEFxy2agheKx7lalXYrTxnmDxCYtRhW2ELNrRq
 F0W8Y7Un/oVv45Y6gw74NU6U244M7fF/bc2TY059Yi11W1HI12daDSwMDaLU51Pgmt0y
 tl8fzBQe0xnrkYVJJYpR/Sm8H8T6QSciZdJqdyg4Qz3JgCHoCF+DfXAG2ikcfWjqEqmP
 A+nOg6Gn4t4cz8/QnHrI3tDRIfXImwhJg40qTGaKC0P+HasS8TYAGH5s7YM/ooXLFzGF
 THUw==
X-Gm-Message-State: AOJu0Yz1nVpyEobB7d1d1zxIwTdYyu0wDw1YQK37Pl7PE8dZopz8SNG5
 9GZrxwM34zBZxuKekhXWwz6UxI++xveN2FxCiyg=
X-Google-Smtp-Source: AGHT+IEaHlYhLZ2AeEK82gjE94Z45hFSVHxUVD8A7J2kJnk+yFVgvXBetn0xkbDIAR2h/cekxVenuw==
X-Received: by 2002:a5d:598b:0:b0:32f:e1a2:525d with SMTP id
 n11-20020a5d598b000000b0032fe1a2525dmr22591wri.57.1699393341606; 
 Tue, 07 Nov 2023 13:42:21 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:21 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 21/24] test: hush: Fix loop tests for hush 2021
Date: Tue,  7 Nov 2023 23:41:18 +0200
Message-Id: <20231107214121.132079-22-francis.laniel@amarulasolutions.com>
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

Modifies return code got from while loop as hush 2021 always returns 0 from
while loop.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/loop.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/test/hush/loop.c b/test/hush/loop.c
index ca777e38fe..add5402a32 100644
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
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
+	if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		/* Reset local variable. */
+		ut_assertok(run_command("loop_foo=", 0));
+	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		puts("Beware: this test set local variable loop_foo and it cannot be unset!");
+	}
 
 	return 0;
 }
-- 
2.34.1

