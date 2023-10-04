Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F0DE7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D21D875C5;
	Wed,  4 Oct 2023 18:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jwwZrX52";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95E4A87594; Wed,  4 Oct 2023 18:43:44 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47865875CB
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53808d5b774so3932817a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437801; x=1697042601;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mn9irTLZeIp1ybS5hwFfjYiPVkcNPqEC5RGf5JtixrI=;
 b=jwwZrX52+18xXTY5ihMvEExpIF1Vch1ffrmgQzYgYHvJZYNyi2tanfWjkj/sHg2c3Y
 TEi7513hpvLJohrH23FbOlrCZvpTh9LjpRRVsOvAA2mB+LELC9Ou3rg2fa+sROUk2qqm
 GyhA5mnSZFXdLsQAptPaMMksX7iW5SM2uV68c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437801; x=1697042601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mn9irTLZeIp1ybS5hwFfjYiPVkcNPqEC5RGf5JtixrI=;
 b=LqDREevcJQwpNvBWfwsW84tUSlD+0QmsyY5+gNCy2UPTBH08y3Oigyp/JV6uijB94X
 O3uEsSoGC6XRgfSSU5KQaY/5jYo7iayzjj7R4uEAojG0bsHKptGO9o1aUt6lBIHgE8e0
 y8PA7qSJchYibTF9r+0hvT7zDrDqJoTtfqUiDh4OXjzmkxFxABt5PDY0zYhmeSJR1gNs
 rF0qdq6udO2/PERm3GcIwX80nWn1X2qTkjzzehkv/kKYWkj+58pghqTbdN4irO/KLF9+
 +HiqzyVKQBqq7sYYnJYi29OUYuCJpDjBP1Hb5dtd+JHPg+v4/n1S8Cv73U5OUML9T4QF
 bH8Q==
X-Gm-Message-State: AOJu0YwhTaIuEdjEpcyfnt6bUL8uOJXj4ihcBvcGZ0yfSTAeKd+bdJCl
 LRTrgxr6lxpd+hvp9oQYW05cSzeVnmtL82kL7Os=
X-Google-Smtp-Source: AGHT+IEP8cnC/kwgK8/+XK5goR6lEX08dQ6fFKpKcFS+0FIFu0KZFX644KJOalnqd7VL/IDFOx43ZQ==
X-Received: by 2002:a05:6402:1604:b0:523:5012:63d5 with SMTP id
 f4-20020a056402160400b00523501263d5mr2396947edv.16.1696437801646; 
 Wed, 04 Oct 2023 09:43:21 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:21 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [RFC PATCH v10 16/24] test: hush: Fix instructions list tests for
 hush 2021
Date: Wed,  4 Oct 2023 19:42:12 +0300
Message-Id: <20231004164220.15738-17-francis.laniel@amarulasolutions.com>
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
 test/hush/list.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/test/hush/list.c b/test/hush/list.c
index 052cf2783c..6f8f10f15e 100644
--- a/test/hush/list.c
+++ b/test/hush/list.c
@@ -9,6 +9,7 @@
 #include <env_attr.h>
 #include <test/hush.h>
 #include <test/ut.h>
+#include <asm/global_data.h>
 
 static int hush_test_semicolon(struct unit_test_state *uts)
 {
@@ -46,12 +47,43 @@ static int hush_test_or(struct unit_test_state *uts)
 }
 HUSH_TEST(hush_test_or, 0);
 
+DECLARE_GLOBAL_DATA_PTR;
+
 static int hush_test_and_or(struct unit_test_state *uts)
 {
 	/* A && B || C truth table. */
 	ut_asserteq(1, run_command("false && false || false", 0));
-	ut_asserteq(1, run_command("false && false || true", 0));
-	ut_asserteq(1, run_command("false && true || true", 0));
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_asserteq(1, run_command("false && false || true", 0));
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (false && false) || true
+		 * So, (false && false) returns 1, the second false is not
+		 * executed, and true is executed because of ||.
+		 */
+		ut_assertok(run_command("false && false || true", 0));
+	}
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_asserteq(1, run_command("false && true || true", 0));
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (false && true) || true
+		 * So, (false && true) returns 1, the true is not executed, and
+		 * true is executed because of ||.
+		 */
+		ut_assertok(run_command("false && true || true", 0));
+	}
+
 	ut_asserteq(1, run_command("false && true || false", 0));
 	ut_assertok(run_command("true && true || false", 0));
 	ut_asserteq(1, run_command("true && false || false", 0));
@@ -69,8 +101,37 @@ static int hush_test_or_and(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("false || false && true", 0));
 	ut_assertok(run_command("false || true && true", 0));
 	ut_asserteq(1, run_command("false || true && false", 0));
-	ut_assertok(run_command("true || true && false", 0));
-	ut_assertok(run_command("true || false && false", 0));
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assertok(run_command("true || true && false", 0));
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (true || true) && false
+		 * So, (true || true) returns 0, the second true is not
+		 * executed, and then false is executed because of &&.
+		 */
+		ut_asserteq(1, run_command("true || true && false", 0));
+	}
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assertok(run_command("true || false && false", 0));
+	} else if (gd->flags & GD_FLG_HUSH_2021_PARSER) {
+		/*
+		 * This difference seems to come from a bug solved in Busybox
+		 * hush.
+		 *
+		 * Indeed, the following expression can be seen like this:
+		 * (true || false) && false
+		 * So, (true || false) returns 0, the false is not executed, and
+		 * then false is executed because of &&.
+		 */
+		ut_asserteq(1, run_command("true || false && false", 0));
+	}
+
 	ut_assertok(run_command("true || false && true", 0));
 	ut_assertok(run_command("true || true && true", 0));
 
-- 
2.34.1

