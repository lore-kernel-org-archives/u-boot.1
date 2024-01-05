Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1960BC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 07:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA8E87966;
	Fri,  5 Jan 2024 08:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dc8fcoSh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7EFD876C4; Fri,  5 Jan 2024 08:22:47 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A745487966
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so14947861fa.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 23:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704439364; x=1705044164; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5I6wPl6LZdlaVaYD4hlFndBWWrgKvmRQMq0rpiGAoPE=;
 b=Dc8fcoSh6qWl+043VmUBxNvssY41nY5Qd9nEoTWv0ZCujDhYGQ5vVkifGkiSXp5kfr
 jYwCELL/y6iihDfwYUUuAHEjZ2nbc50/2V5Z0zdkN2E+3t3cJjGRYJ9V8qxnbCVJCL6e
 RZAA+1UxSnkKnshdCOa98qmlflfErDOaolaSE+u0A5H7vygA2Y+GaHqr/mnVtu2Lt5Xk
 pjRW+hMMF6A8hjMJYYZCiJX0rfGC2KnRCypri5/+1ivPkCGAU7CH/vegNUYi+Q5C88XO
 MVnZef1Tt7paGSMUGtTXGrxUSF6xC7iE08cU4ST2+BdnxlplrVN4el6wwIbmIh16cREg
 7vRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704439364; x=1705044164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5I6wPl6LZdlaVaYD4hlFndBWWrgKvmRQMq0rpiGAoPE=;
 b=neUvboM7Zfxt9LgyRve9h7nBmPVVNmcN386LNERh/c82GEf8Y+OwoBEB5VEVg/9Fnd
 wh+4qxNcermI1N9R0gXegVGXZCz/qogUKjDtfkNI73HAPQdeFOkBzHlaclGM7vCiD4wQ
 mAiTRGjGHeKfKbITRhYBR6KdtEtzS2vdhRYHjZDA0vdjvRqFTmyOSprW9cVUlWYST5Go
 LqD+a2BdoOMLf9ZMUXbo2uFvTQp10vPYMSbgEFzF4Z7wQHqz0eWQ9hZn5v+EQsYp2EN9
 /l/27QlErbg3riikm2mpVvfyC6IXO7qcO5Ea/M0dmiEUc8gEZKeaGF/3jdsnU55rqRwa
 MCBQ==
X-Gm-Message-State: AOJu0YzEwZ3EzjMw6c8GXt7v0cb4R/FMC5ZnVdBd1OcUjrVuiCoD9etG
 4XT+3CLWNuvgdlU4L1glgTU=
X-Google-Smtp-Source: AGHT+IE4LupVTJ3e42G0xujcGdKEFkjBpMcsqa2JCjdDdGo7+RkdVuEtFNy2y1aG4uZECXK2ZEZYmg==
X-Received: by 2002:a2e:87da:0:b0:2cc:bfdb:f089 with SMTP id
 v26-20020a2e87da000000b002ccbfdbf089mr778372ljj.61.1704439363764; 
 Thu, 04 Jan 2024 23:22:43 -0800 (PST)
Received: from xeon.. ([188.163.112.49]) by smtp.gmail.com with ESMTPSA id
 dd5-20020a056402312500b0055627eeb8b9sm636471edb.32.2024.01.04.23.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 23:22:43 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Bin Meng <bmeng@tinylab.org>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Sean Anderson <sean.anderson@seco.com>, Heiko Schocher <hs@denx.de>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v7 7/7] test: hush: dollar: fix bagous behavior
Date: Fri,  5 Jan 2024 09:22:12 +0200
Message-Id: <20240105072212.6615-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240105072212.6615-1-clamor95@gmail.com>
References: <20240105072212.6615-1-clamor95@gmail.com>
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

The dollar test was merged with bagous console behavior, and
instead of fixing it, this behavior was just workarounded.

It seems like without the fix the ut_assert_skipline(); didn't clear
console and running ut_assert_skipline(); many times would give always
OK. With

lib: membuff: fix readline not returning line in case of overflow

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
    ut_assert_console_end();

Same thing should be done with the if block mentioned above that calls
console_record_reset_enable().

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 test/hush/dollar.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index 4caa07c192..68d0874d90 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -53,29 +53,12 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
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
-	}
+	ut_assert_console_end();
 
 	ut_assertok(run_command("dollar_foo='bar \"quux'", 0));
 
-- 
2.40.1

