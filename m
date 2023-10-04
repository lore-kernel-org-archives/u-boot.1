Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095F7E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:48:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAC3875D8;
	Wed,  4 Oct 2023 18:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="A2yXQB7s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CCFE87605; Wed,  4 Oct 2023 18:43:52 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41157875D7
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-533c4d20b33so184882a12.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437811; x=1697042611;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F9K9LjGrI/UaVuFLtYeutB3YYgPxzyJaSx0JXslnwlo=;
 b=A2yXQB7sbQul3cVpJu3PD75JlaUHs6eDSlV82IeEwTy/ZP3s8Sb1InqtW3sLEjTtKT
 m1RbTpItgyFEeLFTrQkIxDIwSprcrb3bU7AgOawG8Z1ehgFL9845IzTbjq48ED30onAv
 PLAZxBquRC+mxXyxff+2ZpMkY4HORYIptq374=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437811; x=1697042611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F9K9LjGrI/UaVuFLtYeutB3YYgPxzyJaSx0JXslnwlo=;
 b=uGir2/Gvff42SN7H8blQSrU16k9m3iU89MvS2GitQzd/e5MgQG3hWYVAZCHYoAM8wu
 4v+cwIh+Jy4DeIIc1Ou0zAlXphQeizZfyU/35Kv/n8t7bm7RY6VxZw2/EnQo8bcpWHI+
 elJU0R0UYtphQ3aAl5ydpj+6dVQ3b2eCHTjTh45Iqz4eimmdj97uju1dgyTMqkJylJKY
 FJgEUc81v0KqWELE6d1N5oG+phJWHCGozK8YKGMOHfdtSlrvaa67isjT7Z96dfQS8v//
 XalJ5RqqXVoGDKiHImIU4UiNNSMrrehBMnJabr/PS7qMKgOD56izXD4wu0kyfEQ3Hw/f
 YvYg==
X-Gm-Message-State: AOJu0YyONNVnI9RM75qp5vBHoZW26yXVdrtDxyDTEz4ZqRN8fGHFwOz/
 FZIhkQewV/RwWvsaGlrV2P6MJcwJ3xTsE5GsxtA=
X-Google-Smtp-Source: AGHT+IGsSxpx+eHSa2xNFnoUYnAOFTyjUVWjcX+0fZkx4c/cY7PTdTloJGj9LRhLarDqDtElJEq4qg==
X-Received: by 2002:a05:6402:34c9:b0:51e:5bd5:fe7e with SMTP id
 w9-20020a05640234c900b0051e5bd5fe7emr142673edc.17.1696437810880; 
 Wed, 04 Oct 2023 09:43:30 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:30 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 21/24] test: hush: Fix loop tests for hush 2021
Date: Wed,  4 Oct 2023 19:42:17 +0300
Message-Id: <20231004164220.15738-22-francis.laniel@amarulasolutions.com>
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

