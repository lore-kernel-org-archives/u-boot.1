Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDACC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 20:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EC68896C;
	Sat, 10 Aug 2024 22:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fPHlX/+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9520F888BF; Sat, 10 Aug 2024 22:52:42 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC211888F6
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 22:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-81f94ce2272so121552139f.2
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 13:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723323155; x=1723927955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQZYJSS791ZDVxAD0/XLbE5qlGSjJhCIlmaEFnqV+c4=;
 b=fPHlX/+rDLzLE/qWp1z9UNwoaBo/pkZ5YNvUNTmBpROg3xirBo3cqiEUgIlf/PX8rf
 h+3rcegI56MkwF+crJuN54/KCrkijQWMIdNpt8PjY0zHuQLNFMrh5XFXpKBjzxxJXmYu
 iiH+XQrVAdINJoaeLURubW9+HkImOd+m2Fs5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723323155; x=1723927955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UQZYJSS791ZDVxAD0/XLbE5qlGSjJhCIlmaEFnqV+c4=;
 b=e/e407C1jyBBrd7DeaAyvhrqa/zGYAF6dAlOTrFA1UICIyLZuxjyYDcVei0B+91LDM
 ORq/io34J5iNSLne8c5upK9aIQdMDYNWYZJF57VCBsRvs7jgdhPjSSVsjhwMdIkb1SD8
 QkbYsqGuj6sYUWBksFBSKe/E8oqhI7sgmEzOK5UfjK3pUNKRWU0KR5v+WBRGqfghMGEa
 zJ7F0YGYGuBKdQZ5kXuaiRaHIZEAJNx9ebfQYpSDgitWkZmvArmmFga1qphCLxSfqi2/
 WSJnY9n9yhBfGSW660LU4jwcWLJlAW9IScDgJ+mDhc+dkKOlhP7lP3qVyqejoQPm0tAG
 bEMw==
X-Gm-Message-State: AOJu0YxNLORzCuMpTCRD2i448iQQ4z8vBwMNptJVUeibrUrRcKAmmAbj
 +ajUbqwZuwA0QkRPGu0Eg9UkjtoFUumqgYtmCIBlJnLSGhO5wJzqlxgT2Y7d6EkM/fJqoiBz5bw
 =
X-Google-Smtp-Source: AGHT+IENJBCOvma3Llx9vD9+Q53K187PgWXaifPJm8zHuqPQH2uFSwgVbqQ9BbAJUUJHsXVI9Hl/Iw==
X-Received: by 2002:a05:6602:6b89:b0:805:e2bf:f303 with SMTP id
 ca18e2360f4ac-8225ee77227mr593123739f.8.1723323155320; 
 Sat, 10 Aug 2024 13:52:35 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82266f56333sm82893139f.0.2024.08.10.13.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Aug 2024 13:52:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 17/21] test: hush: Use UTF_CONSOLE in tests
Date: Sat, 10 Aug 2024 14:52:01 -0600
Message-Id: <20240810205205.3403177-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240810205205.3403177-1-sjg@chromium.org>
References: <20240810205205.3403177-1-sjg@chromium.org>
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
---

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

