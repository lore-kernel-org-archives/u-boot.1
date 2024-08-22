Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DBEC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 14:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F7688BB6;
	Thu, 22 Aug 2024 15:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g6gzN21S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54CF2887BB; Thu, 22 Aug 2024 15:58:35 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B558E88C20
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 15:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39d34be8b6dso3356145ab.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724335109; x=1724939909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7Jv6xQduHJVnPP4VjpT6s6I5lkESgFlWQuCkseAc0w=;
 b=g6gzN21Su1Ylpuj2NVNrH5mbXSoEtkEe+DSKNdU/S9K135I79xPWwGVknU9On7D+dO
 XMFYf2U6y+n1CmSgtEmd/X0gq5zuIrtxfDJvHgyEhl6ZYvMy5nPRhisNLM0G4+LHeXvd
 WJ6GQiwdhqRtEfMJTxYrjznghfXiejm9kWvwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724335109; x=1724939909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W7Jv6xQduHJVnPP4VjpT6s6I5lkESgFlWQuCkseAc0w=;
 b=lBu2dRBncorNTZ/hcvZQ9Hg62cC+xTmsOWuV8rjjx7s3gCOj/GS20IGIXkVP5DmATL
 syoVfpGrD7HyWA/3en12AMvGkTHhC+6UBADCcfbAHLSWRfnVMmjQKqmJy2j1Mx6qhNTb
 v/DErccqh5PLwdOQ7nJ+aIE76Xfas8sJ3T0zexx99v45D3/TbJQkzUhE8tw7l9Vmz5MK
 G5Bu4NqXkH/4rP/ZDKuNY3TC7ZuinCUvLRpP+8j3EF1q8OLymJta/PfhAaxDZcg9wbSl
 TVug3UKg67ysj8cW1LpYOF7Km11b/Yo3SZt3Tl4WJoqODB0oRJe7rrQxWPEAXihedhhf
 rqNQ==
X-Gm-Message-State: AOJu0YwE55kL9yjaxkSEyz21IkOFV2dQ5RyIvX7+ov5Ssm6J3L+xJS1/
 RxP9MeeX+vDn5DZ+fR/qhqda1bINZIBoLv8HNG8YHe4EcjjV2hsgOSKhGbgcq+hZ59svyptrcs0
 =
X-Google-Smtp-Source: AGHT+IE7TfWiQ+TK5YAfr4WClpfwIcDQGKK//GrN1S91ylCKTTEvHYaVFtpVX+wKam1u+fqmA3v1XA==
X-Received: by 2002:a05:6e02:1d95:b0:375:c394:568b with SMTP id
 e9e14a558f8ab-39d6c3b0a06mr50380335ab.21.1724335109122; 
 Thu, 22 Aug 2024 06:58:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d73e747eesm6793275ab.29.2024.08.22.06.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 06:58:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 16/19] test: log: Use UTF_CONSOLE in tests
Date: Thu, 22 Aug 2024 07:58:01 -0600
Message-Id: <20240822135804.2375959-17-sjg@chromium.org>
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
---

(no changes since v1)

 include/test/log.h      |  5 +++--
 test/log/cont_test.c    |  1 -
 test/log/log_filter.c   |  3 ---
 test/log/log_test.c     | 19 -------------------
 test/log/nolog_ndebug.c |  1 -
 test/log/nolog_test.c   |  8 --------
 test/log/pr_cont_test.c |  1 -
 7 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/include/test/log.h b/include/test/log.h
index e9028914500..e3362b85e99 100644
--- a/include/test/log.h
+++ b/include/test/log.h
@@ -13,7 +13,8 @@
 #define LOGF_TEST (BIT(LOGF_FUNC) | BIT(LOGF_MSG))
 
 /* Declare a new logging test */
-#define LOG_TEST(_name) UNIT_TEST(_name, 0, log_test)
-#define LOG_TEST_FLAGS(_name, _flags) UNIT_TEST(_name, _flags, log_test)
+#define LOG_TEST(_name) UNIT_TEST(_name, UTF_CONSOLE, log_test)
+#define LOG_TEST_FLAGS(_name, _flags) \
+		UNIT_TEST(_name, _flags | UTF_CONSOLE, log_test)
 
 #endif /* __TEST_LOG_H__ */
diff --git a/test/log/cont_test.c b/test/log/cont_test.c
index 036d44b9d73..395a6587fa2 100644
--- a/test/log/cont_test.c
+++ b/test/log/cont_test.c
@@ -25,7 +25,6 @@ static int log_test_cont(struct unit_test_state *uts)
 	/* Write two messages, the second continuing the first */
 	gd->log_fmt = (1 << LOGF_CAT) | (1 << LOGF_LEVEL) | (1 << LOGF_MSG);
 	gd->default_log_level = LOGL_INFO;
-	console_record_reset_enable();
 	log(LOGC_ARCH, LOGL_ERR, "ea%d\n", 1);
 	log(LOGC_CONT, LOGL_CONT, "cc%d\n", 2);
 	gd->default_log_level = log_level;
diff --git a/test/log/log_filter.c b/test/log/log_filter.c
index e175f409c9b..d36e9d9714e 100644
--- a/test/log/log_filter.c
+++ b/test/log/log_filter.c
@@ -38,7 +38,6 @@ static int log_test_filter(struct unit_test_state *uts)
 	ulong filt1, filt2;
 
 #define create_filter(args, filter_num) do {\
-	ut_assertok(console_record_reset_enable()); \
 	ut_assertok(run_command("log filter-add -p " args, 0)); \
 	ut_assert_skipline(); \
 	ut_assertok(strict_strtoul(uts->actual_str, 10, &(filter_num))); \
@@ -72,7 +71,6 @@ static int log_test_filter(struct unit_test_state *uts)
 	ut_asserteq(true, filt2_found);
 
 #define remove_filter(filter_num) do { \
-	ut_assertok(console_record_reset_enable()); \
 	snprintf(cmd, sizeof(cmd), "log filter-remove %lu", filter_num); \
 	ut_assertok(run_command(cmd, 0)); \
 	ut_assert_console_end(); \
@@ -95,7 +93,6 @@ static int log_test_filter(struct unit_test_state *uts)
 	create_filter("", filt1);
 	create_filter("", filt2);
 
-	ut_assertok(console_record_reset_enable());
 	ut_assertok(run_command("log filter-remove -a", 0));
 	ut_assert_console_end();
 
diff --git a/test/log/log_test.c b/test/log/log_test.c
index 357a3b57feb..59040c1327c 100644
--- a/test/log/log_test.c
+++ b/test/log/log_test.c
@@ -110,11 +110,9 @@ int log_test_cat_allow(struct unit_test_state *uts)
 	filt = log_add_filter("console", cat_list, LOGL_MAX, NULL);
 	ut_assert(filt >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_cat(UCLASS_MMC);
 	check_log_entries_extra();
 
-	ut_assertok(console_record_reset_enable());
 	log_run_cat(UCLASS_SPI);
 	check_log_entries_extra();
 
@@ -134,7 +132,6 @@ int log_test_cat_deny_implicit(struct unit_test_state *uts)
 	filt = log_add_filter("console", cat_list, LOGL_MAX, NULL);
 	ut_assert(filt >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_cat(UCLASS_SPI);
 	check_log_entries_none();
 
@@ -151,11 +148,9 @@ int log_test_file(struct unit_test_state *uts)
 	filt = log_add_filter("console", NULL, LOGL_MAX, "file");
 	ut_assert(filt >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_file("file");
 	check_log_entries_flags(EXPECT_DIRECT | EXPECT_EXTRA | EXPECT_FORCE);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_file("file2");
 	check_log_entries_none();
 
@@ -172,7 +167,6 @@ int log_test_file_second(struct unit_test_state *uts)
 	filt = log_add_filter("console", NULL, LOGL_MAX, "file,file2");
 	ut_assert(filt >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_file("file2");
 	check_log_entries_flags(EXPECT_DIRECT | EXPECT_EXTRA | EXPECT_FORCE);
 
@@ -190,7 +184,6 @@ int log_test_file_mid(struct unit_test_state *uts)
 			      "file,file2,log/log_test.c");
 	ut_assert(filt >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_file("file2");
 	check_log_entries_extra();
 
@@ -207,7 +200,6 @@ int log_test_level(struct unit_test_state *uts)
 	filt = log_add_filter("console", NULL, LOGL_WARNING, NULL);
 	ut_assert(filt >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run();
 	check_log_entries_flags_levels(EXPECT_LOG | EXPECT_DIRECT | EXPECT_FORCE,
 				       LOGL_FIRST, LOGL_WARNING);
@@ -227,7 +219,6 @@ int log_test_double(struct unit_test_state *uts)
 	filt2 = log_add_filter("console", NULL, LOGL_MAX, NULL);
 	ut_assert(filt2 >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run();
 	check_log_entries_extra();
 
@@ -249,7 +240,6 @@ int log_test_triple(struct unit_test_state *uts)
 	filt3 = log_add_filter("console", NULL, LOGL_MAX, "log/log_test.c");
 	ut_assert(filt3 >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_file("file2");
 	check_log_entries_extra();
 
@@ -264,7 +254,6 @@ int do_log_test_helpers(struct unit_test_state *uts)
 {
 	int i;
 
-	ut_assertok(console_record_reset_enable());
 	log_err("level %d\n", LOGL_EMERG);
 	log_err("level %d\n", LOGL_ALERT);
 	log_err("level %d\n", LOGL_CRIT);
@@ -296,7 +285,6 @@ LOG_TEST_FLAGS(log_test_helpers, UTF_CONSOLE);
 
 int do_log_test_disable(struct unit_test_state *uts)
 {
-	ut_assertok(console_record_reset_enable());
 	log_err("default\n");
 	ut_assert_nextline("%*s() default", CONFIG_LOGF_FUNC_PAD, __func__);
 
@@ -335,7 +323,6 @@ int log_test_cat_deny(struct unit_test_state *uts)
 				     LOGFF_DENY);
 	ut_assert(filt2 >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_cat(UCLASS_SPI);
 	check_log_entries_none();
 
@@ -356,7 +343,6 @@ int log_test_file_deny(struct unit_test_state *uts)
 				     LOGFF_DENY);
 	ut_assert(filt2 >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run_file("file");
 	check_log_entries_none();
 
@@ -377,7 +363,6 @@ int log_test_level_deny(struct unit_test_state *uts)
 				     LOGFF_DENY);
 	ut_assert(filt2 >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run();
 	check_log_entries_flags_levels(EXPECT_LOG | EXPECT_DIRECT | EXPECT_FORCE,
 				       LOGL_WARNING + 1,
@@ -401,7 +386,6 @@ int log_test_min(struct unit_test_state *uts)
 				     LOGFF_DENY | LOGFF_LEVEL_MIN);
 	ut_assert(filt2 >= 0);
 
-	ut_assertok(console_record_reset_enable());
 	log_run();
 	check_log_entries_flags_levels(EXPECT_LOG | EXPECT_DIRECT | EXPECT_FORCE,
 				       LOGL_WARNING, LOGL_INFO - 1);
@@ -419,8 +403,6 @@ int log_test_dropped(struct unit_test_state *uts)
 	gd->flags &= ~(GD_FLG_LOG_READY);
 	gd->log_drop_count = 0;
 
-	ut_assertok(console_record_reset_enable());
-
 	log_run();
 	ut_asserteq(2 * (LOGL_COUNT - LOGL_FIRST) +
 		    _LOG_MAX_LEVEL - LOGL_FIRST + 1,
@@ -446,7 +428,6 @@ int log_test_buffer(struct unit_test_state *uts)
 	for (i = 0; i < 0x11; i++)
 		buf[i] = i * 0x11;
 
-	ut_assertok(console_record_reset_enable());
 	log_buffer(LOGC_BOOT, LOGL_INFO, 0, buf, 1, 0x12, 0);
 
 	/* This one should product no output due to the debug level */
diff --git a/test/log/nolog_ndebug.c b/test/log/nolog_ndebug.c
index b714a16d2e7..d33359d59b7 100644
--- a/test/log/nolog_ndebug.c
+++ b/test/log/nolog_ndebug.c
@@ -21,7 +21,6 @@ static int log_test_log_disabled_ndebug(struct unit_test_state *uts)
 	int i;
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 
 	/* Output a log record at every level */
 	for (i = LOGL_EMERG; i < LOGL_COUNT; i++)
diff --git a/test/log/nolog_test.c b/test/log/nolog_test.c
index c4c0fa6cf81..e9cfea99026 100644
--- a/test/log/nolog_test.c
+++ b/test/log/nolog_test.c
@@ -25,7 +25,6 @@ static int log_test_nolog_err(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	log_err("testing %s\n", "log_err");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_err"));
@@ -39,7 +38,6 @@ static int log_test_nolog_warning(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	log_warning("testing %s\n", "log_warning");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_warning"));
@@ -53,7 +51,6 @@ static int log_test_nolog_notice(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	log_notice("testing %s\n", "log_notice");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_notice"));
@@ -67,7 +64,6 @@ static int log_test_nolog_info(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	log_err("testing %s\n", "log_info");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing log_info"));
@@ -83,7 +79,6 @@ static int nolog_test_nodebug(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	debug("testing %s\n", "debug");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_end(uts));
@@ -96,7 +91,6 @@ static int log_test_nolog_nodebug(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	log_debug("testing %s\n", "log_debug");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assert(!strcmp(buf, ""));
@@ -112,7 +106,6 @@ static int nolog_test_debug(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	debug("testing %s\n", "debug");
 	gd->flags &= ~GD_FLG_RECORD;
 	ut_assertok(ut_check_console_line(uts, "testing debug"));
@@ -126,7 +119,6 @@ static int log_test_nolog_debug(struct unit_test_state *uts)
 	char buf[BUFFSIZE];
 
 	memset(buf, 0, BUFFSIZE);
-	console_record_reset_enable();
 	log_debug("testing %s\n", "log_debug");
 	log(LOGC_NONE, LOGL_DEBUG, "more %s\n", "log_debug");
 	gd->flags &= ~GD_FLG_RECORD;
diff --git a/test/log/pr_cont_test.c b/test/log/pr_cont_test.c
index 30f30d98fe1..467ecf28601 100644
--- a/test/log/pr_cont_test.c
+++ b/test/log/pr_cont_test.c
@@ -28,7 +28,6 @@ static int log_test_pr_cont(struct unit_test_state *uts)
 	/* Write two messages, the second continuing the first */
 	gd->log_fmt = BIT(LOGF_MSG);
 	gd->default_log_level = LOGL_INFO;
-	console_record_reset_enable();
 	pr_err("ea%d ", 1);
 	pr_cont("cc%d\n", 2);
 	gd->default_log_level = log_level;
-- 
2.34.1

