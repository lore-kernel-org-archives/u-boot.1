Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90142CD37A9
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 17:10:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC37A88C1D;
	Tue,  3 Sep 2024 19:10:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Q2tTcWeY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84DEB88BCB; Tue,  3 Sep 2024 19:10:11 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A18D889BD
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 19:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-428e0d18666so47718645e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1725383408; x=1725988208;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxgq/cdA9IEbHce1dGdHmFQvCKMmi+4wYCaakGOAfn4=;
 b=Q2tTcWeY4rUkYInYvhHrm2zCeJyG+krq1vvrFzIGOXLWXCS+plaQiVN9pjFKLuZjkz
 YYAfjdphyN/JIyY5fb8Frr07oOhwzuNaL9BCPkVurv7k3jTO90RpAOw3d+jDnfswf2eA
 wLKGDXycbjG1FHDvSnqXf48ymSR+g5DC26grU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725383408; x=1725988208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxgq/cdA9IEbHce1dGdHmFQvCKMmi+4wYCaakGOAfn4=;
 b=anclc/2a+7Ma6AwFJpXwZKj/raPVqrzU4Fz/liwnMLt+LYcmK1jV4lc6F89WxwAHze
 76ZnQnuoUAshv/4jEkKf9MrRZCo4qjM6qqHtMF2TpwHYMHVpl1nNmccH2d0oaxEcvJ/x
 vn/miPQUnLUN9fGSSxdwyadNWv63ZPNi9ZibsKZFaKzRzzubj1F83OQ17MNGwzfFPnPR
 F91QoCrmmrBKHBr7s8PiJkQ36RnhlTun7ZF+FxBIyjOzyX+wS2gowWoZuw6FVdcmpt5R
 tal7EK1WclG4qjfFfnknWpohjmh9gsimEApu9PMk2Fh45z+521RvnYR1PJ3o3mtbi7bg
 ow2w==
X-Gm-Message-State: AOJu0Yy9rRuR8/hfJC3efJu2p/KTjqep++xZL9nNJFL5IQcVY604c0H5
 biYXpHbfPVZs18rP9TMQ8rkBpHufKrhemyDbrLpbZQsmiz/w3uY1309cx9Js3x90x9Ool/hrQ5l
 B
X-Google-Smtp-Source: AGHT+IFiBPSubjkTayDsBWYDN32pjlBlfkzcGOB4mF4yar3fWcWtMk/qsUabU8oQKIatGT/8XEg+ZQ==
X-Received: by 2002:a05:600c:1d1d:b0:426:5269:1a50 with SMTP id
 5b1f17b1804b1-42bbb205a6bmr102361835e9.11.1725383408463; 
 Tue, 03 Sep 2024 10:10:08 -0700 (PDT)
Received: from pwmachine.numericable.fr
 (2a02-8429-e2c2-8d01-f9a2-0489-9dd5-0071.rev.sfr.net.
 [2a02:8429:e2c2:8d01:f9a2:489:9dd5:71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbd1eee1bsm146364975e9.9.2024.09.03.10.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 10:10:08 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] test: hush: dollar: fix bugous behavior
Date: Tue,  3 Sep 2024 19:09:42 +0200
Message-Id: <20240903170944.98747-2-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
References: <20240903170944.98747-1-francis.laniel@amarulasolutions.com>
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

From: Ion Agorria <ion@agorria.com>

The dollar test was merged with bugous console behavior, and
instead of fixing it, this behavior was just workarounded.
This was done to keep compatibility with the existing behavior.

It seems like without the fix the ut_assert_skipline(); didn't clear
console and running ut_assert_skipline(); many times would give always
OK. With e58bafc35fe3 ("lib: membuff: fix readline not returning line in case of overflow")
the line is cleared correctly and next assert fails because now there
is nothing to clean which is correct if we look the this a bit above
the failing assert:

    if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
         /*
          * For some strange reasons, the console is not empty after
          * running above command.
          * So, we reset it to not have side effects for other tests.
          */
         console_record_reset_enable();
    } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
         ut_assert_console_end();
    }

Which further confirms that tests workaround the old problem and now
that problem is fixed we can remove the whole if blocks and simply
place ut_assert_console_end() right after ut_assert_skipline() without
any conditional and will pass green.

So this part of code goes from:
    ut_assert_skipline();
    ut_assert_skipline();

    if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
        /* See above comments. */
        console_record_reset_enable();
    } else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
        ut_assert_console_end();
    }

to become:
    ut_assert_skipline();
    if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
        ut_assert_skipline();
    }
    ut_assert_console_end();

The if block mentioned above that calls console_record_reset_enable() is
completely removed as fixed by e58bafc35fe3.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Link: https://lore.kernel.org/r/20240105072212.6615-8-clamor95@gmail.com
[mkorpershoek: reworded commit title]
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
[flaniel: remove console_record_reset_enable() if]
[flaniel: adapt second if]
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 test/hush/dollar.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index 4caa07c192a..cfcb1bd3e1d 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -53,29 +53,22 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
 	ut_asserteq(1, run_command("dollar_foo='bar quux", 0));
 	/* Next line contains error message */
 	ut_assert_skipline();
-
-	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
-		/*
-		 * For some strange reasons, the console is not empty after
-		 * running above command.
-		 * So, we reset it to not have side effects for other tests.
-		 */
-		console_record_reset_enable();
-	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		ut_assert_console_end();
-	}
+	ut_assert_console_end();

 	ut_asserteq(1, run_command("dollar_foo=bar quux\"", 0));
-	/* Two next lines contain error message */
-	ut_assert_skipline();
+	/* Next line contains error message */
 	ut_assert_skipline();
-
-	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
-		/* See above comments. */
-		console_record_reset_enable();
-	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		ut_assert_console_end();
+	/*
+	 * Old parser prints the error message on two lines:
+	 * Unknown command 'quux
+	 * ' - try 'help'
+	 * While the new only prints it on one:
+	 * syntax error: unterminated \"
+	 */
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		ut_assert_skipline();
 	}
+	ut_assert_console_end();

 	ut_assertok(run_command("dollar_foo='bar \"quux'", 0));

--
2.34.1

