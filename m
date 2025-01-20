Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E50AC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A7CD807DC;
	Mon, 20 Jan 2025 22:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kKV7NHFD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C115807B6; Mon, 20 Jan 2025 22:26:42 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C5D800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-844e06e5d11so132842739f.0
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408398; x=1738013198; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXXIu0wjSaOFRvBFRDB37X5MZS9DQvnuQwSLY5RFFzw=;
 b=kKV7NHFDHqqvTEsolVCKaJJCpFZkaTaOR8r0ytUF/3JAT4zlnM6GXuitpJe5Ugy53d
 S4x1DpvXBPvlHsQiA+swyG1HGOTx072o8KPKLAb/46OYUAgSfnf6FuxctLUMyWp3/nTc
 O+It9g0aQVkG4AeFcck9TciWDQzFjeFNPKSbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408398; x=1738013198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXXIu0wjSaOFRvBFRDB37X5MZS9DQvnuQwSLY5RFFzw=;
 b=CJzZwJzk43YV6EVR5hCid3P0pR3oaPwpnpaNw/qCuh1yGkx9mLAcZRkYz7gEalSUbF
 08vEgFbMbK6FQqM6wi980js+CaMgj4m1ObcR9W2r6WZAoUNaHoAOU25nHgerXnD5MH8X
 m4/bus4CKH/X2XrCp0G75cBdWemZcFteGrNqfL2l6jF0F5thwqoVQyJA77unCwBMS30L
 a/esW+d0AQSQSvwHk2+eEiQdIEUUlScS6eWROp0l6ZFTZVORmyXdwukjqSBN1qdjJQpi
 MoJUHkAX5JqrYT9jDFT/lSl3Ve7zEXR/eptT7QGPD/yWUX9uLTlpQ0s6rm2QqodWbg6K
 ofDQ==
X-Gm-Message-State: AOJu0YygcKivMCYk7u6PgojFQMssATKi0oiG50G5KWG70Ajt9VRdSv+g
 S9Zx7J617U6rtGL9dxf5XBdVhUr48IVQ6QzcPTdaO0ZBL3WO3w99s8mDpnImlnimHpET+0zPDGI
 =
X-Gm-Gg: ASbGncuuWFOoXoejLao614ArV1NU82FeD6qcDOqfLfxC8hzFXs11tMTUTKEmb1W0s+V
 QnjqyXzo0RGDFvBJW6dE4NcMqnoxtGpsIRbAnMWImrbOQ8ISukdgEOVcXI2RWO2GsM3buPOnxSf
 ZbQxqqvdkUvZMjYQIvpSYYYI3GRXixnPovtS9+XjMUq4wZ4LcKBfG19l8Utw2GwhHsXy71FdHnW
 NCHCphXSmw0xmp86LBYQD5EC37/TeJaVUI0bnvq6416qxcQzQAt/5MThZRf2HEZGSnMwThbwE3l
 zLliZfYiR8nXhusMpYa8O/OnvGv1lPk=
X-Google-Smtp-Source: AGHT+IE7BnUpgmTaO9R+sgfEIJt8wpucns8u+/zevkwvW7ZHSOH50+hX4oc2gQSdw+QKiodjbP5NPg==
X-Received: by 2002:a05:6602:15cf:b0:847:51e2:eac with SMTP id
 ca18e2360f4ac-851b61d2096mr1253716639f.7.1737408397824; 
 Mon, 20 Jan 2025 13:26:37 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 06/44] test: Add newlines to hush-test messages
Date: Mon, 20 Jan 2025 14:25:28 -0700
Message-ID: <20250120212613.516664-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120212613.516664-1-sjg@chromium.org>
References: <20250120212613.516664-1-sjg@chromium.org>
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

A few messages lack a newline so the test output shows the next
test-name on the same line. For example:

   Beware: this test sets local variable dollar_bar and dollar_quux
      and they cannot be unset!Test: hush_test_env_dollar: dollar.c

This is confusing, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/hush/dollar.c | 7 ++++---
 test/hush/loop.c   | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index 077dcd62c0e..820110799a2 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -108,7 +108,7 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("dollar_foo=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable dollar_foo and it cannot be unset!");
+		puts("Beware: this test set local variable dollar_foo and it cannot be unset!\n");
 	}
 
 	return 0;
@@ -140,7 +140,7 @@ static int hush_test_env_dollar(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("env_foo=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable env_foo and it cannot be unset!");
+		puts("Beware: this test set local variable env_foo and it cannot be unset!\n");
 	}
 
 	return 0;
@@ -206,7 +206,8 @@ static int hush_test_command_dollar(struct unit_test_state *uts)
 		ut_assertok(run_command("dollar_bar=", 0));
 		ut_assertok(run_command("dollar_quux=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test sets local variable dollar_bar and dollar_quux and they cannot be unset!");
+		puts("Beware: this test sets local variable dollar_bar and "
+		     "dollar_quux and they cannot be unset!\n");
 	}
 
 	return 0;
diff --git a/test/hush/loop.c b/test/hush/loop.c
index a9b6a8edf24..7154b9bc0ae 100644
--- a/test/hush/loop.c
+++ b/test/hush/loop.c
@@ -25,7 +25,7 @@ static int hush_test_for(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("loop_i=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable loop_i and it cannot be unset!");
+		puts("Beware: this test set local variable loop_i and it cannot be unset!\n");
 	}
 
 	return 0;
@@ -56,7 +56,7 @@ static int hush_test_while(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("loop_foo=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable loop_foo and it cannot be unset!");
+		puts("Beware: this test set local variable loop_foo and it cannot be unset!\n");
 	}
 
 	return 0;
-- 
2.43.0

