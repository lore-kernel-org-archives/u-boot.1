Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02EFC02196
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A1A48083C;
	Fri,  7 Feb 2025 19:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Gt2N3MaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D6C280836; Fri,  7 Feb 2025 19:31:40 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DFE80821
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-844e10ef3cfso179776139f.2
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953096; x=1739557896; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gmlZ/Ppj/F7c3WBa97ffRmXIvdytJscQr1DqA6bRANk=;
 b=Gt2N3MaXFei8xi7uuc9T20tGFRRMy/QFtPBJ7ZD1/KnoBjzgmLMlKCKAgt3BQofYtl
 NXwZ5YJwYJo0JcHYnsBcfStrazoneUgtwyHqKsD//1xMsTGmfGOUPmz+fl1eslN5m9ii
 8BkY7dOxM9owhrSLEQ5eiZVKDFAo5Vct2ZJtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953096; x=1739557896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmlZ/Ppj/F7c3WBa97ffRmXIvdytJscQr1DqA6bRANk=;
 b=tXaAgVHpQSJtfCWhRvsEq2pUYGY5dfhxxunH7nCAYSGkY+ZRkWtiy/8em8hVwDota5
 +BXrlxa2vx4IhxL9jft35RXgvUrsaiLmVrO2rBMddVol6FK7/+gyRAyJONcUWS/0dhZT
 4qT85rwAM/X0VDVs0XyDpMJzLzcX4UwahFus3EcdCtNGojW9DNo3Wij9SajQN8lIJp2a
 lVPwEIUKMZ37tmG+qXh7wg9Wz/X19u6ynGepzHeGpzwkj3ZyPGHDI/u4JyFxJrT0HYWm
 JBRQceYatqoa+Of9HMH8c/iNHb29UsKyniEhyKXN6mt6dXFt0SM9WWqj1edhc2lXwIg2
 VKGA==
X-Gm-Message-State: AOJu0YwkI7IXNUA1AiJnASWTKfa5eg/UlJ9b7m2O1t22F5LyzBVSdQ6E
 d/W5pLmILeoveQCN4MsD0rc0yldVkRb3At7J8bW/nGDCBwh7JGlnDWH/1qJEUQtSx7wpZ3R1SS4
 =
X-Gm-Gg: ASbGncupcPigJAUcBTjbvRjCREMxJbup4D28ZM5brRR9y/I7AMaHP2yG6sKHHl7SF0w
 TGnAWVJFfQAGsiwKW9VhGtswONAQrUswo2aVpktLtUvsVUECxcteKXKCpHmNEAwd4il4gM0JjVf
 02uYlVMu1glFSWm31WfZsA3fSJidQ/m24B928IgjPv5wrL+7npu7luCe9NNHEJImPNTUWQMgIgS
 aYR35SyAdTicmviEQlpcdGB7seQ4k3Iq/cUpXpE+I0G4AcpDNwJ1KcDlpx6pFJTYZXmc+F+2Ltr
 sR0WDTSsjJRU8fjg17IUZVZavXxHxfWRcfqwczJoVjyIBQiMOvz8
X-Google-Smtp-Source: AGHT+IH3hDxVnGs17YXxTh4ffrkx9VvbtJtn4khmXhuC99t5PKnhGVZ7i11vm0tkoN6pmdz6gQHFag==
X-Received: by 2002:a05:6602:4887:b0:847:51e2:eb0 with SMTP id
 ca18e2360f4ac-854fd90c631mr456918639f.12.1738953095873; 
 Fri, 07 Feb 2025 10:31:35 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/29] test: Keep track of suite duration
Date: Fri,  7 Feb 2025 11:30:35 -0700
Message-ID: <20250207183121.117663-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207183121.117663-1-sjg@chromium.org>
References: <20250207183121.117663-1-sjg@chromium.org>
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

(no changes since v1)

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

