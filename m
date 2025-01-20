Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58918C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE1D80759;
	Mon, 20 Jan 2025 22:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fj7KNy2u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06B9B807E4; Mon, 20 Jan 2025 22:53:59 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCEB7807B1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-844bff5ba1dso385866039f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410035; x=1738014835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7BExsgQF9qFhsqVD5h4Qd++x8X2pAXaz73ezO5/QHK0=;
 b=Fj7KNy2usUmCvawTzgL7po8GiaeutIScc/57n5uqkd7ZOhb4a7WQnJjWyti4vRBz9L
 5nlH1ccJ1p3juL7o3jmnEYAbXStXcP3c3b9NQW1Mz0DNaLNDDH6ifSO0qtDOh86NTl7B
 sag0fHyUZt+vETwBLJv8lrkAnRiNhq2hl8VCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410035; x=1738014835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7BExsgQF9qFhsqVD5h4Qd++x8X2pAXaz73ezO5/QHK0=;
 b=D4kpnvXcAG2HrEC/8vP9bOyAlcwP/nFut8BABjHdDNFD1Uk0AQJ+UT96RyTH37XYus
 oPUMYIooj0n1+nIEiI9yKv+pP15lqok7CxpF4L4dwygbh1k7k9WemVWxGuSYWZANzAWp
 +N+2GngLUFZlY15UKzw1bsqn/qnRmEgEJHp/pZxKiNOLU12bXlVwUuolZpTLwp8p64tL
 Lkh/k68BzA01bFAC/Bt7srr1FbhtEVrYQziIVuEAJhBP4TN/6N6L5hdW1IppvID6u7bs
 qFGNLvQe786qGhdjNPsvkWKh3t4G979zGWOk2LNjLTJBsNN5zKZK7poeGNXriyrC7ZG1
 rtrQ==
X-Gm-Message-State: AOJu0Yw6K1I/vappqUptTjt/HzG9LXj/76U7Exjdx9G2WBRX0uhXJgmD
 nPay9opt9moRJ7SWtkU/wRQ8wos2whcd+vHX78BnR/aoTJVxBNIy6Yk11MbuxwNMt75kyVIvXUQ
 =
X-Gm-Gg: ASbGncva1unRQhITdE7fZ3EFi+b/M9dX1IRHH3cbMKHWSzBjjTyYN5pb+vgpcmBiYQq
 T/OpNK0XW5b2M5qI1pQ9Eck7LKfmqCQ5WGROdyGfSlr93yN0FN7/X1PI9T/UV1/ve0TLo8PK8dc
 iYHWx0HllapvVsem7G++melM6yPK1Dmo9YF/uhHlPm5BBXpmcH58fkaxxS4zM9V75zXXB3KSWoM
 EdwniPkddGUG/Y5irO33oaYGxEDEtS8oIaSGfnefWvT7gCUsjagOqX4KNk7718Wjw0bA/kDQJ5t
 GCvJ53MKaNbqaZE7M9Px6rKvrt9RgVY=
X-Google-Smtp-Source: AGHT+IHhLfuNMpnbMhR5830/Yc1ZuQ9qVjt2mSfF8+olY19W4rQ/YyVszAHNZ1B6bkKYIyWCgqNBqw==
X-Received: by 2002:a05:6602:4886:b0:84c:e8ce:b531 with SMTP id
 ca18e2360f4ac-851b6546252mr1278753739f.14.1737410035017; 
 Mon, 20 Jan 2025 13:53:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/28] test: Show the average time per test
Date: Mon, 20 Jan 2025 14:53:04 -0700
Message-ID: <20250120215340.617194-5-sjg@chromium.org>
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

Show the average duration of a test, so we can keep track of how it is
trending. Report the suite with the longest average test to encourage
people to improve it.

Add a function to update the stats based on the results from a single
suite and another to show the summary information.

Make this optional, since sandbox's SPL tests do not have a timer driver
and people may want to print results without times.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/test.h |  4 ++++
 test/cmd_ut.c       | 32 ++++++++++++++++++++++++++++++++
 test/test-main.c    | 10 +++++++---
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/include/test/test.h b/include/test/test.h
index 25c7712d160..877fda8d5aa 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -33,6 +33,8 @@ struct ut_stats {
  * @cur: Statistics for the current run
  * @total: Statistics for all test runs
  * @run_count: Number of times ut_run_list() has been called
+ * @worst: Sute which had the first per-text run time
+ * @worst_ms: Time taken by that test
  * @start: Store the starting mallinfo when doing leak test
  * @of_live: true to use livetree if available, false to use flattree
  * @of_root: Record of the livetree root node (used for setting up tests)
@@ -56,6 +58,8 @@ struct unit_test_state {
 	struct ut_stats cur;
 	struct ut_stats total;
 	int run_count;
+	const struct suite *worst;
+	int worst_ms;
 	struct mallinfo start;
 	struct device_node *of_root;
 	bool of_live;
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index cc30c517c51..c96277d89a1 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -192,6 +192,36 @@ static int run_suite(struct unit_test_state *uts, struct suite *ste,
 	return ret;
 }
 
+static void show_stats(struct unit_test_state *uts)
+{
+	if (uts->run_count < 2)
+		return;
+
+	ut_report(&uts->total, uts->run_count);
+	if (CONFIG_IS_ENABLED(UNIT_TEST_DURATION) &&
+	    uts->total.test_count && uts->worst) {
+		ulong avg = uts->total.duration_ms / uts->total.test_count;
+
+		printf("Average test time: %ld ms, worst case '%s' took %d ms\n",
+		       avg, uts->worst->name, uts->worst_ms);
+	}
+}
+
+static void update_stats(struct unit_test_state *uts, const struct suite *ste)
+{
+	if (CONFIG_IS_ENABLED(UNIT_TEST_DURATION) && uts->cur.test_count) {
+		ulong avg;
+
+		avg = uts->cur.duration_ms ?
+			uts->cur.duration_ms /
+			uts->cur.test_count : 0;
+		if (avg > uts->worst_ms) {
+			uts->worst_ms = avg;
+			uts->worst = ste;
+		}
+	}
+}
+
 static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 		     int flag, int argc, char *const argv[])
 {
@@ -208,6 +238,7 @@ static int do_ut_all(struct unit_test_state *uts, struct cmd_tbl *cmdtp,
 			retval = run_suite(uts, ste, cmdtp, flag, 1, argv);
 			if (!any_fail)
 				any_fail = retval;
+			update_stats(uts, ste);
 		}
 	}
 	ut_report(&uts->total, uts->run_count);
@@ -306,6 +337,7 @@ static int do_ut(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 
 		ret = run_suite(&uts, ste, cmdtp, flag, argc, argv);
 	}
+	show_stats(&uts);
 	if (ret)
 		return ret;
 	ut_uninit_state(&uts);
diff --git a/test/test-main.c b/test/test-main.c
index 1d821a3fe72..597afa25f77 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -677,12 +677,16 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 void ut_report(struct ut_stats *stats, int run_count)
 {
 	if (run_count > 1)
-		printf("Suites run: %d, total tests", run_count);
+		printf("Total tests");
 	else
 		printf("Tests");
 	printf(" run: %d, ", stats->test_count);
-	if (stats)
-		printf("%ld ms, ", stats->duration_ms);
+	if (stats && stats->test_count) {
+		ulong dur = stats->duration_ms;
+
+		printf("%ld ms, average: %ld ms, ", dur,
+		       dur ? dur / stats->test_count : 0);
+	}
 	if (stats->skip_count)
 		printf("skipped: %d, ", stats->skip_count);
 	printf("failures: %d\n", stats->fail_count);
-- 
2.43.0

