Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E23C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:38:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1302280BA5;
	Wed, 15 Jan 2025 14:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bKr4g98B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740F080C77; Wed, 15 Jan 2025 14:32:27 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D7A80C8A
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a7d7c1b190so20746445ab.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947943; x=1737552743; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1U4AGjPuFfI7Dl6UNuDQDQBTgQtsmM1aI/mfNKL+4U=;
 b=bKr4g98BC5u7mnxS71JKC19f43LDbIqL8QFTkzziPEiC2YM7fgI78Z/hZQBgHP0CaB
 RhdwRV8fFbaFKPkQGbg2FQdi3RgTQmppjlHC2iEGo89GbwGCwvcaaYPaOPi/zwOk7GLQ
 NdJLNyjqNQbfYXAgBLlr8EQUK97XP0/fWLfkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947943; x=1737552743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1U4AGjPuFfI7Dl6UNuDQDQBTgQtsmM1aI/mfNKL+4U=;
 b=xQHgUzTPyq66lkhwPb6axfVyXLcFGVuEgeRUcUiAWDAJeSSHVwIxHmRBkWo3yH8qkO
 TibGWg/gdaaHdR+YZrjZqJlUcPVdtIAthpFf3Y2MisD6U39lrhQfjMBnkkE+BIsTkZPX
 HTkTP6ZDunQ1PjMUzG1EN0/IKZ6ye1k7OwceCNxhbtcqP+Ticu9Oz44dqxuUM+tGlUfh
 8nOcYqIu4KweznuKmAivCdm/6ejltXUxkp/hph9gnVXC7aDNvYKUY0JBkdt70kwYbIva
 CicOmGF0bBRF4IBzDTW6IwFgrhZnKGblVgNCPB31dkjGxMI+sCHtfivQ49dxvD/tZCjA
 9noQ==
X-Gm-Message-State: AOJu0Yz4rd21WzMsAy484MqOq50YyFtG+gpEX0T70h+pavyL5iGOHA5b
 QR3842dXysRfuzX2UUoIi1iYaUuGZCEX6ZKUjqoV5QTJSt6LoLBkRlsMqnJUH2xPqrpF672n5c0
 =
X-Gm-Gg: ASbGncshryZwxWMhtK0VPV6gRdUYDPBwBHOebXYawTfzkPPHBrEvQ59ecU+pt19u7Q9
 82YaOF+jmsgUJTSxJJiV1tsVcVF1otsgr9IHp867DkX8pyqz6Xs/SvVYELH3GGZNgsLdEFReLKp
 DGw8Rgs27iUeb237JMKlYNJSQpQOII2BighypdGm8JGC1uykiXldXhclYB55X3zGpaRBWKsAZ5J
 Ci2FjYARhGCMrrCjzrThyvIXhoNj996epSc+wUejI6WgD9Iy5tEuPuolLKh2dU1gCxcOo0/U/ft
 vOjCZ6GeN/f5WIBYHA==
X-Google-Smtp-Source: AGHT+IGSSgVzI33dgM7PLD9OTrekioWHsiFu/EUMu+7zgUu0Ep8fG9CuE06PT55IJhqBmqSAXxgUtg==
X-Received: by 2002:a05:6e02:1c87:b0:3a7:a69c:9692 with SMTP id
 e9e14a558f8ab-3ce3aa74970mr259012235ab.21.1736947942740; 
 Wed, 15 Jan 2025 05:32:22 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 37/43] test: Move stats into a struct
Date: Wed, 15 Jan 2025 06:31:07 -0700
Message-Id: <20250115133114.590375-38-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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
2.34.1

