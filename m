Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872F7C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3142807D6;
	Mon, 20 Jan 2025 22:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qj5XNpqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52508807D6; Mon, 20 Jan 2025 22:53:57 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11E958077F
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-851c4f1fb18so96381439f.2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410033; x=1738014833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ls5qP9HJZvwzIlMTrs/o0ynO/0w49hMobSjQIL5sHO0=;
 b=Qj5XNpqyE7mU7zdoabQzAcNSxMp3Wtl7XSznud6PhFY5rODtgl7caJM3J8nVPC/1lQ
 iUk5DzA3Skv3Qlh+yrfM5zofLP20y5yV0gAMlkC2hHtS1FoY++9N/XnqS0XT7fbBcBeO
 fXwDUAZC3GTIJll77Qg2Nwj/5Z2I/ZEiuqorA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410033; x=1738014833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ls5qP9HJZvwzIlMTrs/o0ynO/0w49hMobSjQIL5sHO0=;
 b=RDkBSFQwdEMf/JpITwaRp51KVumEb8yhXPV5v0OEaadNr0xvUbaOWXrbmPolZnyfts
 5RkCflTnG+SRlVhRldYjSYnm4l/m0+ZrVAlp4B5kRk1kxbFYRH7rd7TmwrBK0yKAalcA
 ZBJGTO07m9iEv2sJoUv+vZ1mPpH0DewNseshiUVZ7Y7FJCvpioI3v1JccWqX9Lj9Ao3V
 7Q6G1FQAJkdVbaTPVtmGJVK0oGjpjaGQZBRFoAkzkjPvH+2NSwAdkmEEyCo0M4/AmZZ9
 rh2/x7c2RQPxxq6/37tX28jq3uAVK/95TPy38EW+yi4OfiU3uJWnk/Xq+36nQTeeFt7p
 bVug==
X-Gm-Message-State: AOJu0YyFuH83mTX7J4kSGgvVjuaGqV2y5jUCDuIROKBymmJ1MD/uOu0q
 MJO7NySSOBxFrPohmL7As487etqg+SfuEvoVoCneiCK0lae0fRfszfMc3bonoBbRq8wT8Fq+xjs
 =
X-Gm-Gg: ASbGncs7par85dDm4oh57bOKvwRM51vg4wPD4i0yOQihG8Yqn9+KL99FXdBbjQCdTvN
 0EL6jNLRYAR0sreLSpv3uRYxiQQFwIVMzgPOYrSZXXMLQ1IXVnsibwy42W3IORKk4kmvG7+QR7K
 FlGtg8+ydcxsJc5PY2iIuL1oDy+r7WpEGwiww19+x3gkZayfxmzQ+Ukz5AYEZTHQTOiS9bh3hhq
 dj8JO7uCF0OCGE85nze5fz7rklbWSJC7gb9EphdxsBTMKrzw6xHUqKGobrLPO8eqbo3lAKKLbrq
 m72mx8A2XBmYhXtFF0kRWwMaqTy7YnA=
X-Google-Smtp-Source: AGHT+IFKrgD0ly7tXsGItLkGOQ9TFxlSg5sIgyy3vx0e1DANtIL4HAJVDlnXqarYv7olMaV8S2Eb8Q==
X-Received: by 2002:a05:6602:2b8a:b0:844:bd90:d45c with SMTP id
 ca18e2360f4ac-851b65227a0mr1151124939f.13.1737410033196; 
 Mon, 20 Jan 2025 13:53:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/28] test: Keep track of suite duration
Date: Mon, 20 Jan 2025 14:53:03 -0700
Message-ID: <20250120215340.617194-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250120215340.617194-1-sjg@chromium.org>
References: <20250120215340.617194-1-sjg@chromium.org>
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

Show the time taken by each test suite with 'ut all' and the total time
for all suites.

Take care to remove any sandbox time-offset from the values.

Fix the comment-format on timer_test_add_offset() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/timer/sandbox_timer.c |  5 +++++
 include/test/test.h           |  4 ++++
 include/time.h                | 15 ++++++++++++++-
 test/Kconfig                  |  9 +++++++++
 test/test-main.c              | 17 ++++++++++++++++-
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/timer/sandbox_timer.c b/drivers/timer/sandbox_timer.c
index e8b54a02965..c1baf3c69ec 100644
--- a/drivers/timer/sandbox_timer.c
+++ b/drivers/timer/sandbox_timer.c
@@ -18,6 +18,11 @@ void timer_test_add_offset(unsigned long offset)
 	sandbox_timer_offset += offset;
 }
 
+ulong timer_test_get_offset(void)
+{
+	return sandbox_timer_offset;
+};
+
 u64 notrace timer_early_get_count(void)
 {
 	return os_get_nsec() / 1000 + sandbox_timer_offset * 1000;
diff --git a/include/test/test.h b/include/test/test.h
index bac43c81d63..25c7712d160 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -16,11 +16,15 @@
  * @skip_count: Number of tests that were skipped
  * @test_count: Number of tests run. If a test is run muiltiple times, only one
  *	is counted
+ * @start: Timer value when test started
+ * @duration_ms: Suite duration in milliseconds
  */
 struct ut_stats {
 	int fail_count;
 	int skip_count;
 	int test_count;
+	ulong start;
+	ulong duration_ms;
 };
 
 /*
diff --git a/include/time.h b/include/time.h
index 3b2ba091247..f5b86bf70fe 100644
--- a/include/time.h
+++ b/include/time.h
@@ -28,7 +28,7 @@ uint64_t get_timer_us(uint64_t base);
  */
 unsigned long get_timer_us_long(unsigned long base);
 
-/*
+/**
  * timer_test_add_offset()
  *
  * Allow tests to add to the time reported through lib/time.c functions
@@ -36,6 +36,19 @@ unsigned long get_timer_us_long(unsigned long base);
  */
 void timer_test_add_offset(unsigned long offset);
 
+#ifdef CONFIG_SANDBOX
+/**
+ * timer_test_get_offset()
+ *
+ * Get the total offset currently being added the time
+ *
+ * Return:: number of milliseconds the system time has been advanced
+ */
+ulong timer_test_get_offset(void);
+#else
+static inline ulong timer_test_get_offset(void) { return 0; }
+#endif
+
 /**
  * usec_to_tick() - convert microseconds to clock ticks
  *
diff --git a/test/Kconfig b/test/Kconfig
index 558a9cd49b4..1c8e3d16300 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -20,6 +20,15 @@ config SPL_UNIT_TEST
 	  of-platdata and SPL handover. To run these tests with the sandbox_spl
 	  board, use the -u (unit test) option.
 
+config UNIT_TEST_DURATION
+	bool "Report unit-test duration"
+	depends on UNIT_TEST
+	default y
+	help
+	  Enable this short the time taken by each test suite. This is reported
+	  after the suite runs, alongside the pass/fail results. In addition,
+	  an overall total is reported if multiple suites are run.
+
 config UT_LIB
 	bool "Unit tests for library functions"
 	depends on UNIT_TEST
diff --git a/test/test-main.c b/test/test-main.c
index 815f54bebd5..1d821a3fe72 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -14,6 +14,7 @@
 #include <net.h>
 #include <of_live.h>
 #include <os.h>
+#include <spl.h>
 #include <usb.h>
 #include <dm/ofnode.h>
 #include <dm/root.h>
@@ -680,6 +681,8 @@ void ut_report(struct ut_stats *stats, int run_count)
 	else
 		printf("Tests");
 	printf(" run: %d, ", stats->test_count);
+	if (stats)
+		printf("%ld ms, ", stats->duration_ms);
 	if (stats->skip_count)
 		printf("skipped: %d, ", stats->skip_count);
 	printf("failures: %d\n", stats->fail_count);
@@ -692,9 +695,15 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 {
 	;
 	bool has_dm_tests = false;
+	ulong start_offset = 0;
+	ulong test_offset = 0;
 	int ret;
 
 	memset(&uts->cur, '\0', sizeof(struct ut_stats));
+	if (CONFIG_IS_ENABLED(UNIT_TEST_DURATION)) {
+		uts->cur.start = get_timer(0);
+		start_offset = timer_test_get_offset();
+	}
 
 	if (!CONFIG_IS_ENABLED(OF_PLATDATA) &&
 	    ut_list_has_dm_tests(tests, count, prefix, select_name)) {
@@ -732,13 +741,19 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	if (has_dm_tests)
 		dm_test_restore(uts->of_root);
 
-	ut_report(&uts->cur, 1);
 	if (ret == -ENOENT)
 		printf("Test '%s' not found\n", select_name);
+	if (CONFIG_IS_ENABLED(UNIT_TEST_DURATION)) {
+		test_offset = timer_test_get_offset() - start_offset;
+
+		uts->cur.duration_ms = get_timer(uts->cur.start) - test_offset;
+	}
+	ut_report(&uts->cur, 1);
 
 	uts->total.skip_count += uts->cur.skip_count;
 	uts->total.fail_count += uts->cur.fail_count;
 	uts->total.test_count += uts->cur.test_count;
+	uts->total.duration_ms += uts->cur.duration_ms;
 	uts->run_count++;
 
 	return ret;
-- 
2.43.0

