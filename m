Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13194C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2EC88C8B;
	Thu, 22 Aug 2024 15:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GLP9ZcCo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 167B388BB6; Thu, 22 Aug 2024 15:58:33 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65F388B64
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-39d21fdc11bso3121105ab.2
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335108; x=1724939908; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sbu3ZTCIBkto1qmWwGlpUMUEMf1fOBUWyoRrQxUxcBU=;
 b=GLP9ZcCoMqFnZRgigAnHLhzpQz8eJwYBmZV1UKbZvc9OgnBIzvU+AuaOGALR5z5Z85
 hXO90Dbj0kPTEWtI7iNzo8NHN2jeqOkPuI5ou1xJve4r+p5SP3TB2mme5lG6TG8U13q3
 rWMoB8QwWkzUDAyAwIyc90C/PYxoZa2Qp/d+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335108; x=1724939908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sbu3ZTCIBkto1qmWwGlpUMUEMf1fOBUWyoRrQxUxcBU=;
 b=cH6z9yO1TjAGxGpLZMxA+RxL2j6vZbhMSfYUzKfPn12hg5uFDAiwQ/CCQM3x2qN4WO
 2WT8BRAAZxI5RuclD+u2exUC8LG5CjnFp7KzSIyvU6FWKGqTdI5LYiu7t3X4Ibg4An7r
 TRjF7WWLrzTsrI5NEH6+n+J23/PL3g0261ip1d/KhldftiFmj3LdPHPt+1fIc3CL8Sa8
 ifY9lTnzA6I1UBEJp3X3IyGmNNn8SX3jaLKIH8o0HOhjdyZnwBXlXUXks86Rql3FbSAl
 ZlUVfqa4RYSdUErjEq2tbKfmkQj1eummHu84znMPsLfEhHY0bgEKCFpmHTdxwfkNYNvR
 T5NA==
X-Gm-Message-State: AOJu0Ywbk2QQa8T0ZezrBTqmyYbkZymeeXcDh7VdQPIM6bWo9waExPjU
 pfkNoDMZwP9+t6c6amEpvDYQfafCWpcILONJw3/GgZY2VGuD771S/zrA17XQ5HFWdBY48p7usk0
 =
X-Google-Smtp-Source: AGHT+IElbl/vDarctAfdmNEpJDs9ZbEJy0T7yDDOHswh3mPyJic7YkcjdxIlMJHCPe1wNNPwhHhUNQ==
X-Received: by 2002:a05:6e02:168c:b0:397:e9bf:2dec with SMTP id
 e9e14a558f8ab-39d74b52b6fmr24960715ab.1.1724335108141; 
 Thu, 22 Aug 2024 06:58:28 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 15/19] test: hush: Use UTF_CONSOLE in tests
Date: Thu, 22 Aug 2024 07:58:00 -0600
Message-Id: <20240822135804.2375959-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822135804.2375959-1-sjg@chromium.org>
References: <20240822135804.2375959-1-sjg@chromium.org>
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

Set this flag rather than doing things manually in the test.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

(no changes since v1)

 test/hush/dollar.c | 10 +++-------
 test/hush/loop.c   | 11 +++--------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index 4caa07c192a..91b097017c2 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -14,7 +14,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static int hush_test_simple_dollar(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	ut_assertok(run_command("echo $dollar_foo", 0));
 	ut_assert_nextline_empty();
 	ut_assert_console_end();
@@ -121,12 +120,11 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
 
 	return 0;
 }
-HUSH_TEST(hush_test_simple_dollar, 0);
+HUSH_TEST(hush_test_simple_dollar, UTF_CONSOLE);
 
 static int hush_test_env_dollar(struct unit_test_state *uts)
 {
 	env_set("env_foo", "bar");
-	console_record_reset_enable();
 
 	ut_assertok(run_command("echo $env_foo", 0));
 	ut_assert_nextline("bar");
@@ -154,12 +152,10 @@ static int hush_test_env_dollar(struct unit_test_state *uts)
 
 	return 0;
 }
-HUSH_TEST(hush_test_env_dollar, 0);
+HUSH_TEST(hush_test_env_dollar, UTF_CONSOLE);
 
 static int hush_test_command_dollar(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
-
 	ut_assertok(run_command("dollar_bar=\"echo bar\"", 0));
 
 	ut_assertok(run_command("$dollar_bar", 0));
@@ -222,4 +218,4 @@ static int hush_test_command_dollar(struct unit_test_state *uts)
 
 	return 0;
 }
-HUSH_TEST(hush_test_command_dollar, 0);
+HUSH_TEST(hush_test_command_dollar, UTF_CONSOLE);
diff --git a/test/hush/loop.c b/test/hush/loop.c
index d734abf136d..a9b6a8edf24 100644
--- a/test/hush/loop.c
+++ b/test/hush/loop.c
@@ -14,8 +14,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 static int hush_test_for(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
-
 	ut_assertok(run_command("for loop_i in foo bar quux quux; do echo $loop_i; done", 0));
 	ut_assert_nextline("foo");
 	ut_assert_nextline("bar");
@@ -32,12 +30,10 @@ static int hush_test_for(struct unit_test_state *uts)
 
 	return 0;
 }
-HUSH_TEST(hush_test_for, 0);
+HUSH_TEST(hush_test_for, UTF_CONSOLE);
 
 static int hush_test_while(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
-
 	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
 		/*
 		 * Hush 2021 always returns 0 from while loop...
@@ -65,11 +61,10 @@ static int hush_test_while(struct unit_test_state *uts)
 
 	return 0;
 }
-HUSH_TEST(hush_test_while, 0);
+HUSH_TEST(hush_test_while, UTF_CONSOLE);
 
 static int hush_test_until(struct unit_test_state *uts)
 {
-	console_record_reset_enable();
 	env_set("loop_bar", "bar");
 
 	/*
@@ -87,4 +82,4 @@ static int hush_test_until(struct unit_test_state *uts)
 	env_set("loop_bar", NULL);
 	return 0;
 }
-HUSH_TEST(hush_test_until, 0);
+HUSH_TEST(hush_test_until, UTF_CONSOLE);
-- 
2.34.1

