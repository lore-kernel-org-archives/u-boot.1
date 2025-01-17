Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54ECC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 00:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D88A80762;
	Fri, 17 Jan 2025 01:10:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eD+fb4Ec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7359180717; Fri, 17 Jan 2025 01:10:22 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCB580312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 01:10:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 279C43F2B2
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1737072620;
 bh=nQKXjl5Yy0gV3/JLMrNbzDE5mavlTclFYeJZXwOwheM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eD+fb4EcQJNDP48hjM7ZH+aIK730b2KN5b+y7LIN8dQj3zqagP6IX/7HEYkoW1u6m
 /0BkAbf/7s/M/yFQC3X0jZlfYptFEw2xjHjnh9sAbCz7BTN9CVGRDtSi7OTvpxe60X
 /QUMgojDpDyhg4RUp1pzS4CZpnDHV50Bq64XbaDfBQ8MTKMtTsjIwsN/PQUQcFP7L9
 WaSA3Wn+qAyHyUujF0yUKTWG5rP56071nATmpJ1Np1VDnoFJPqaqQJNL5QEtdvlPfc
 YuBVxLGFm6RmpUsaQsR/SKm6kmL6cC262548k4alq3Ps9qUEvAb4VZNfNh65Nrm9Yq
 O0LxxzMehUM8w==
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa63b02c69cso304714166b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 16:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737072619; x=1737677419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQKXjl5Yy0gV3/JLMrNbzDE5mavlTclFYeJZXwOwheM=;
 b=ZOTtrfCIDXsFHrtDDugb/0Pfail37M4ksYbSydPkAXW682GdE14BjZmTk7FiwJ7J8r
 HzVwKQbo9WOX3/BsoqW5odzmRjxA5sXFlMkFazs1FNQpPJH+45he6X+SUYp30QMimJkr
 qO4NLfZqH9ExLX59iXvChefscoOoPhpDs+mMAmo68KoGHdm6xrONKe3V4hcH+GBnfR8v
 yDwDTZSz+hu9ZL+dckJrzYASxusVJJzkDyMWyGY4PPlsTKjR5RBvMRJ/M5X82V5LrVIh
 zG+uSX22UnaqdPtq6yasvpcs379Z30Y3JLpz5y5r2n7Bcr3STGyGfwbWeNvdH8Kcnsvb
 RACg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNSVai+KHsW+sIzXZ7kY/oHxIm/Z3KH9LiVFcXk06m1LZDaaKOT1tSDuRB5jvHIZvhBvLhbUM=@lists.denx.de
X-Gm-Message-State: AOJu0YxO+w26RxmDxKieGis8oTEuijUbYjlZlZxU6yRi8xJ2CBCsTuEI
 yykHICKM/7+GR/7KYN7OXUalFoXQP7oXAVIwolF7E6GX3sU079LdyVWjLc3hGulmtvbsgx/EhZ/
 u7wY7drZBP+Mi6/tLpSmBmeFaFJRSLqFfgLS8BcB3IfPV02F7NCgppGQ612jqOTP3T3Q=
X-Gm-Gg: ASbGncvqdflGVLHk+lhEies1i440QY6zi5FVuzeXTf/sRoTLkIYNnMjY8OCoL9zhuxg
 eYFJxNacTtK6Jh2Yv3X2Qtigjrio7KhGNKEwKJ9AWaDoMLE884rqCvDrTYN3yvdRW9TQPPXHT1U
 iqKteKR/rr1KZMrFbv/3yGwvWsrnCWdQQh5GtQA7c1P8DJM+tZc4YrsVbxQxb0KnR0S4qyms4L4
 aZtB59W1crxL2RVai4XdTkBZPRW7mCIs8Jjsf5wiG1yt3PS8bjTKzXhg8LWOCyniOC8SHrq/msQ
 znPQ3/ykrIeGVQ==
X-Received: by 2002:a17:907:97ce:b0:ab2:f255:59f5 with SMTP id
 a640c23a62f3a-ab38cc9056cmr39930566b.16.1737072619633; 
 Thu, 16 Jan 2025 16:10:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEK5X5MSLhKjIsj9C7yeytTrRAoRJZBaZn/I646VnAqPkl7lZa399/4qxYHMCrzcixhgfoogQ==
X-Received: by 2002:a17:907:97ce:b0:ab2:f255:59f5 with SMTP id
 a640c23a62f3a-ab38cc9056cmr39928166b.16.1737072619186; 
 Thu, 16 Jan 2025 16:10:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:3035:6e0:18b7:2225:e8f4:a4b5:e79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384d27117sm71986466b.75.2025.01.16.16.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 16:10:17 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/3] test/log: test function filters
Date: Fri, 17 Jan 2025 01:09:54 +0100
Message-ID: <20250117000954.531785-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
References: <20250117000954.531785-1-heinrich.schuchardt@canonical.com>
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

Add unit tests for function filters.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/log/log_test.c | 68 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/test/log/log_test.c b/test/log/log_test.c
index 8686b1cbef3..00b442252f0 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -15,7 +15,8 @@
 DECLARE_GLOBAL_DATA_PTR;
 
 /* emit some sample log records in different ways, for testing */
-static int do_log_run(struct unit_test_state *uts, int cat, const char *file)
+static int do_log_run(struct unit_test_state *uts, int cat, const char *file,
+		      const char *func)
 {
 	int i;
 	int ret, expected_ret;
@@ -30,13 +31,13 @@ static int do_log_run(struct unit_test_state *uts, int cat, const char *file)
 	for (i = LOGL_FIRST; i < LOGL_COUNT; i++) {
 		log(cat, i, "log %d\n", i);
 		ret = _log(log_uc_cat(cat), i, file, 100 + i,
-			   "func", "_log %d\n", i);
+			   func, "_log %d\n", i);
 		ut_asserteq(ret, expected_ret);
 	}
 	/* test with LOGL_COUNT flag */
 	for (i = LOGL_FIRST; i < LOGL_COUNT; i++) {
 		ret = _log(log_uc_cat(cat), i | LOGL_FORCE_DEBUG, file, 100 + i,
-			   "func", "_log force %d\n", i);
+			   func, "_log force %d\n", i);
 		ut_asserteq(ret, expected_ret);
 	}
 
@@ -44,9 +45,10 @@ static int do_log_run(struct unit_test_state *uts, int cat, const char *file)
 	return 0;
 }
 
-#define log_run_cat(cat) do_log_run(uts, cat, "file")
-#define log_run_file(file) do_log_run(uts, UCLASS_SPI, file)
-#define log_run() do_log_run(uts, UCLASS_SPI, "file")
+#define log_run_cat(cat) do_log_run(uts, cat, "file", "func")
+#define log_run_file(file) do_log_run(uts, UCLASS_SPI, file, "func")
+#define log_run_func(func) do_log_run(uts, UCLASS_SPI, "file", func)
+#define log_run() do_log_run(uts, UCLASS_SPI, "file", "func")
 
 #define EXPECT_LOG BIT(0)
 #define EXPECT_DIRECT BIT(1)
@@ -55,7 +57,7 @@ static int do_log_run(struct unit_test_state *uts, int cat, const char *file)
 #define EXPECT_DEBUG BIT(4)
 
 static int do_check_log_entries(struct unit_test_state *uts, int flags, int min,
-				int max)
+				int max, const char *func)
 {
 	int i;
 
@@ -63,7 +65,8 @@ static int do_check_log_entries(struct unit_test_state *uts, int flags, int min,
 		if (flags & EXPECT_LOG)
 			ut_assert_nextline("          do_log_run() log %d", i);
 		if (flags & EXPECT_DIRECT)
-			ut_assert_nextline("                func() _log %d", i);
+			ut_assert_nextline("                %s() _log %d", func,
+					   i);
 		if (flags & EXPECT_DEBUG) {
 			ut_assert_nextline("log %d", i);
 			ut_assert_nextline("_log %d", i);
@@ -71,12 +74,13 @@ static int do_check_log_entries(struct unit_test_state *uts, int flags, int min,
 	}
 	if (flags & EXPECT_EXTRA)
 		for (; i <= LOGL_MAX ; i++)
-			ut_assert_nextline("                func() _log %d", i);
+			ut_assert_nextline("                %s() _log %d", func,
+					   i);
 
 	for (i = LOGL_FIRST; i < LOGL_COUNT; i++) {
 		if (flags & EXPECT_FORCE)
-			ut_assert_nextline("                func() _log force %d",
-					   i);
+			ut_assert_nextline("                %s() _log force %d",
+					   func, i);
 		if (flags & EXPECT_DEBUG)
 			ut_assert_nextline("_log force %d", i);
 	}
@@ -86,7 +90,7 @@ static int do_check_log_entries(struct unit_test_state *uts, int flags, int min,
 }
 
 #define check_log_entries_flags_levels(flags, min, max) do {\
-	int ret = do_check_log_entries(uts, flags, min, max); \
+	int ret = do_check_log_entries(uts, flags, min, max, "func"); \
 	if (ret) \
 		return ret; \
 } while (0)
@@ -192,6 +196,46 @@ int log_test_file_mid(struct unit_test_state *uts)
 }
 LOG_TEST_FLAGS(log_test_file_mid, UTF_CONSOLE);
 
+/* Check passing and failing function filters */
+int log_test_func(struct unit_test_state *uts)
+{
+	int filt;
+
+	filt = log_add_filter_flags("console", NULL, LOGL_MAX, "file", "func",
+				    0);
+	ut_assert(filt >= 0);
+
+	log_run_func("func");
+	check_log_entries_flags(EXPECT_DIRECT | EXPECT_EXTRA | EXPECT_FORCE);
+
+	log_run_func("fnc2");
+	do_check_log_entries(uts, EXPECT_FORCE, LOGL_FIRST, _LOG_MAX_LEVEL,
+			     "fnc2");
+
+	ut_assertok(log_remove_filter("console", filt));
+
+	return 0;
+}
+LOG_TEST_FLAGS(log_test_func, UTF_CONSOLE);
+
+/* Check a passing function filter (middle of list) */
+int log_test_func_mid(struct unit_test_state *uts)
+{
+	int filt;
+
+	filt = log_add_filter_flags("console", NULL, LOGL_MAX, "file",
+				    "bad1,func,bad2", 0);
+	ut_assert(filt >= 0);
+
+	log_run_func("func");
+	check_log_entries_flags(EXPECT_DIRECT | EXPECT_EXTRA | EXPECT_FORCE);
+
+	ut_assertok(log_remove_filter("console", filt));
+
+	return 0;
+}
+LOG_TEST_FLAGS(log_test_func_mid, UTF_CONSOLE);
+
 /* Check a log level filter */
 int log_test_level(struct unit_test_state *uts)
 {
-- 
2.47.1

