Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD4DC02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:32:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B1D80763;
	Mon, 20 Jan 2025 22:27:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G9t2ais6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA44980B9A; Mon, 20 Jan 2025 22:27:38 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D4F980ADC
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3cf880d90bdso6571655ab.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408455; x=1738013255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vp6rPzd2EmOjK7SnDkK4DAOvWzfCwbVk7tE/GSNjAR0=;
 b=G9t2ais6mvDTvo71VSKwc8fx8AGhXezfy4SjHtsKpoO88ME62tIV7lxq1i7hwG0rY0
 LlEzpSHtbFyA9GnwPOAlED2XiyKqsMgD6OhSGYmok3mDoudGnuA8M0ysJBFwt4BL1gXT
 92mzwPuZwXN+GHoxepSgSJT/PYJgOerb+X6yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408455; x=1738013255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vp6rPzd2EmOjK7SnDkK4DAOvWzfCwbVk7tE/GSNjAR0=;
 b=SfNEx1jGQfvKPl8EVX6wR/TW1NwQo+7tov0eqhdcOs6rDveXjWlxH4A+FS4KtQcF8M
 TJYZPw9qB+lwJMLAiLPwWYWMYRupMOr0CtueHNaSJPvXouQuvgEwbL7coieeHB6wXgmm
 AlkNnbcEg0pwIyCjXfs6IyeAYufQgLRhjn9YNtU5PjyQZuNcT+0v3Q279DMjKLM6Sho0
 Omus3GWKUmA/mrrIcVKle2wuYnGqgoH598pT4435ML5+dLqtKpHtvkR6tR/uXYnfP7jD
 4UjLIVSEwSSRlEA8yXHTtFF+l94gH2WT9RnHmuRvWhKXLxTaY4gT3T+bN0I0FF3I8MkY
 JkWw==
X-Gm-Message-State: AOJu0Yyy09ZGX374yoOmlH3Us75zjK9WSWdpTDD3Hqyk8iMOUpfs9DGy
 m4vyyEJCST7LGizPT10L1H85KJR5RHaQhZUojv9ucbp7UP9aUVjOJZVdGb75bxF0acCUGv+kWYA
 =
X-Gm-Gg: ASbGncuzf8DrMzrt9f5em7lvhuml8J2VDSyWGzB5XMlldGBRmYQ+5kWbdX7X59y5p2U
 hFf0rOtuhwtKUrcywn9ERDL3hTWeagDGQ9jqp1cDNNtuewCB7ev2Fupfq7Z8kRdmFMHjngYqvd5
 HHnrtSW8eorp9DRZDdDOVGoVa7Hq8q/OyFHi8sJLHvIvxIE3PGJzKGjGfb1nVXIaocASRMmnSEE
 uEd+kDWH8zsSdHw53w9yvvZqheNY40UZftxvhYO1D48OdHZIU0Hj/4zlXQJugMKlD0Bt6JSYxWJ
 Nhe12isLwPp8qVKehLQAGwtkvKMaFIE=
X-Google-Smtp-Source: AGHT+IEdowJOKkYBKnkd8PgSRyh2kERMHZEa4mJPHjmNF1HATrQT135lXbx6yz/PMoUmWzXjcl361w==
X-Received: by 2002:a05:6e02:160d:b0:3ce:6b10:1805 with SMTP id
 e9e14a558f8ab-3cf744947c2mr123654595ab.21.1737408454663; 
 Mon, 20 Jan 2025 13:27:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 37/44] test: Move stats into a struct
Date: Mon, 20 Jan 2025 14:25:59 -0700
Message-ID: <20250120212613.516664-38-sjg@chromium.org>
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

Use a struct to hold the stats, since we also want to have the same
stats for all runs as we have for each suite.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/test/test.h | 17 +++++++++++++----
 test/test-main.c    | 29 +++++++++++++++--------------
 test/ut.c           |  4 ++--
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/include/test/test.h b/include/test/test.h
index 21c0478befe..bc8f0bbe501 100644
--- a/include/test/test.h
+++ b/include/test/test.h
@@ -9,11 +9,21 @@
 #include <malloc.h>
 #include <linux/bitops.h>
 
-/*
- * struct unit_test_state - Entire state of test system
+/**
+ * struct ut_stats - Statistics about tests run
  *
  * @fail_count: Number of tests that failed
  * @skip_count: Number of tests that were skipped
+ */
+struct ut_stats {
+	int fail_count;
+	int skip_count;
+};
+
+/*
+ * struct unit_test_state - Entire state of test system
+ *
+ * @cur: Statistics for the current run
  * @start: Store the starting mallinfo when doing leak test
  * @of_live: true to use livetree if available, false to use flattree
  * @of_root: Record of the livetree root node (used for setting up tests)
@@ -34,8 +44,7 @@
  * @actual_str: Temporary string used to hold actual string value
  */
 struct unit_test_state {
-	int fail_count;
-	int skip_count;
+	struct ut_stats cur;
 	struct mallinfo start;
 	struct device_node *of_root;
 	bool of_live;
diff --git a/test/test-main.c b/test/test-main.c
index 391d4e7bb0e..e8aecd267c7 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -448,7 +448,7 @@ static int test_post_run(struct unit_test_state *uts, struct unit_test *test)
  */
 static int skip_test(struct unit_test_state *uts)
 {
-	uts->skip_count++;
+	uts->cur.skip_count++;
 
 	return -EAGAIN;
 }
@@ -460,7 +460,7 @@ static int skip_test(struct unit_test_state *uts)
  * the name of each test before running it.
  *
  * @uts: Test state to update. The caller should ensure that this is zeroed for
- *	the first call to this function. On exit, @uts->fail_count is
+ *	the first call to this function. On exit, @uts->cur.fail_count is
  *	incremented by the number of failures (0, one hopes)
  * @test_name: Test to run
  * @name: Name of test, possibly skipping a prefix that should not be displayed
@@ -510,7 +510,7 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
  * SPL.
  *
  * @uts: Test state to update. The caller should ensure that this is zeroed for
- *	the first call to this function. On exit, @uts->fail_count is
+ *	the first call to this function. On exit, @uts->cur.fail_count is
  *	incremented by the number of failures (0, one hopes)
  * @test: Test to run
  * Return: 0 if all tests passed, -EAGAIN if the test should be skipped, -1 if
@@ -574,7 +574,7 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
  * the name of each test before running it.
  *
  * @uts: Test state to update. The caller should ensure that this is zeroed for
- *	the first call to this function. On exit, @uts->fail_count is
+ *	the first call to this function. On exit, @uts->cur.fail_count is
  *	incremented by the number of failures (0, one hopes)
  * @prefix: String prefix for the tests. Any tests that have this prefix will be
  *	printed without the prefix, so that it is easier to see the unique part
@@ -632,7 +632,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 			if (len < 6 || strcmp(test_name + len - 6, "_norun")) {
 				printf("Test '%s' is manual so must have a name ending in _norun\n",
 				       test_name);
-				uts->fail_count++;
+				uts->cur.fail_count++;
 				return -EBADF;
 			}
 			if (!uts->force_run) {
@@ -641,23 +641,24 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 				continue;
 			}
 		}
-		old_fail_count = uts->fail_count;
+		old_fail_count = uts->cur.fail_count;
 
 		if (one && upto == pos) {
 			ret = ut_run_test_live_flat(uts, one);
-			if (uts->fail_count != old_fail_count) {
+			if (uts->cur.fail_count != old_fail_count) {
 				printf("Test '%s' failed %d times (position %d)\n",
 				       one->name,
-				       uts->fail_count - old_fail_count, pos);
+				       uts->cur.fail_count - old_fail_count,
+				       pos);
 			}
 			return -EBADF;
 		}
 
 		for (i = 0; i < uts->runs_per_test; i++)
 			ret = ut_run_test_live_flat(uts, test);
-		if (uts->fail_count != old_fail_count) {
+		if (uts->cur.fail_count != old_fail_count) {
 			printf("Test '%s' failed %d times\n", test_name,
-			       uts->fail_count - old_fail_count);
+			       uts->cur.fail_count - old_fail_count);
 		}
 		found++;
 		if (ret == -EAGAIN)
@@ -668,7 +669,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 	if (select_name && !found)
 		return -ENOENT;
 
-	return uts->fail_count ? -EBADF : 0;
+	return uts->cur.fail_count ? -EBADF : 0;
 }
 
 int ut_run_list(struct unit_test_state *uts, const char *category,
@@ -716,12 +717,12 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	if (has_dm_tests)
 		dm_test_restore(uts->of_root);
 
-	if (uts->skip_count)
-		printf("Skipped: %d, ", uts->skip_count);
+	if (uts->cur.skip_count)
+		printf("Skipped: %d, ", uts->cur.skip_count);
 	if (ret == -ENOENT)
 		printf("Test '%s' not found\n", select_name);
 	else
-		printf("Failures: %d\n", uts->fail_count);
+		printf("Failures: %d\n", uts->cur.fail_count);
 
 	return ret;
 }
diff --git a/test/ut.c b/test/ut.c
index 7454da3e001..a16fdfb3a93 100644
--- a/test/ut.c
+++ b/test/ut.c
@@ -21,7 +21,7 @@ void ut_fail(struct unit_test_state *uts, const char *fname, int line,
 {
 	gd->flags &= ~(GD_FLG_SILENT | GD_FLG_RECORD);
 	printf("%s:%d, %s(): %s\n", fname, line, func, cond);
-	uts->fail_count++;
+	uts->cur.fail_count++;
 }
 
 void ut_failf(struct unit_test_state *uts, const char *fname, int line,
@@ -35,7 +35,7 @@ void ut_failf(struct unit_test_state *uts, const char *fname, int line,
 	vprintf(fmt, args);
 	va_end(args);
 	putc('\n');
-	uts->fail_count++;
+	uts->cur.fail_count++;
 }
 
 ulong ut_check_free(void)
-- 
2.43.0

