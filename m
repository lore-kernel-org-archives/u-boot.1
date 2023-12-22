Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEB3C4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59FE9877DE;
	Fri, 22 Dec 2023 22:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="mq91OBkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C52C87768; Fri, 22 Dec 2023 22:03:46 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F78875FA
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d490a1936so7356555e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279021; x=1703883821;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=doWty2U9xWIS6+YzeofXrePWP4HMK9WU0hHwvvDf5u0=;
 b=mq91OBkLHSOeKizDR0K8K2KR8w4eeoOf3RbvlLW6wIYGJhmaiHxADSmSQC6BfCjeKv
 eL06JJC/4wlEevv/Gihan7PkLwhbR88XBKshGywNDxnULgb3jDQs1r+Ss8QPvUsDLXdi
 DKEU50rlbA4AyXZd6VbfBUSZH7Q/RbXuTwToc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279021; x=1703883821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=doWty2U9xWIS6+YzeofXrePWP4HMK9WU0hHwvvDf5u0=;
 b=jRwXLttCL6JOIoSnzTYVQ6IZXo1+4O5jWsjPZNNMwPSg3xB6b/lu1gaM9k3w1cqm5O
 n22O/JFb1peGLs3pxZ3NBK4cIRfR5GgDFS26HOHlFNwVPLAVe18NDnFROlsQf7JvxEw5
 mPSn99cXLJNChkiXjvCHE3FNGkT0FeDdMrXJWTve9YnuEMM+1IlX2bYcHILIrWRr0dOZ
 pkdbUmS7L132PhcsGE6JmUftlCJ2KyvzaTtHuNx3atD+I+kijEFNGX+4BWZ0hAVW59R+
 huvP3W+ME+bTrR7A5MmlDCn+6s1ONZoSy8bFnJ59AI/dcpWpwZrk0nPped8DRlE9Vdbf
 /Yvw==
X-Gm-Message-State: AOJu0YyCJK7Nd0pnfOg3ygUoAVTqrcGVWf/jB9wcXVtlL0QtR9+0WC5d
 6OJSlLwZHdNRlU4xs6oanm9Tl8mvBiBKMES+OQ/yDHCvpBg=
X-Google-Smtp-Source: AGHT+IF82uzvkPDVgm+DeyI6IrkNozTD1k8xqVGd3GFM4EsCsHM5WV+ispNdA+j0Hpeojjauj5MkXw==
X-Received: by 2002:a05:600c:45ce:b0:40d:18da:452e with SMTP id
 s14-20020a05600c45ce00b0040d18da452emr597394wmo.158.1703279021144; 
 Fri, 22 Dec 2023 13:03:41 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:40 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 21/24] test: hush: Fix loop tests for modern hush
Date: Fri, 22 Dec 2023 22:02:41 +0100
Message-Id: <20231222210244.91830-22-francis.laniel@amarulasolutions.com>
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

