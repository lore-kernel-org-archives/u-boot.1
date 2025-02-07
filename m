Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE04FC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 046ED80944;
	Fri,  7 Feb 2025 19:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H9bhk8cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C39580819; Fri,  7 Feb 2025 19:31:42 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4715780819
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso68238539f.1
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953098; x=1739557898; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86z6kEc8omANDefoKkv/mdq5Xj3+mWqTh+7LH6nGPP4=;
 b=H9bhk8cfMDJksOSnfjUthETLmYaB9CyQph80I8TgEFPFCoS9dLYHJUvjARmO/s5Z+r
 rBlj4dprCDYVbP7fz+Rf5CNLOL2vxqYXx18W5a/wRlzeD5Ojsa7a58HwJZVp9zLsNxLH
 b/d9V/iljCcNB/NKqJhfr+/MQZmfx6Av2oVLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953098; x=1739557898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86z6kEc8omANDefoKkv/mdq5Xj3+mWqTh+7LH6nGPP4=;
 b=FGkZBHzCK0E3ioLsLVSYH3Nmhp0jm9WBD+gjLcZDT4ZlvXHp2h073ndFJW/J1FRoVI
 PNixsH20RxrIYggCFBOhHZm4vALbiGRiP7zvRT7Dc65Baiamoldq0RGITKVLMbzP1ycl
 IVbySTjJjg7MiaSnxELwszfOSKWa47qbkG25q97EclX2aH15pflDr/UvMRsWnz9jxSiO
 +G9876tQUMFjMiOjYd+s8LUwxYghE2iHCubRoJuZJ71ThLrTwgO3/UarsFNaKoskstUH
 N3M3O7lQWm3Q2eS0r7ncl5Pjt5/qH47aPvv/yLIkc9HCXiTl6xY9wR+mWbVJ7mJWWVsT
 t11w==
X-Gm-Message-State: AOJu0YxAyq+BNP6FY0HsSyRIRT5yXfpGdyuUzHpj5ctkfagMbiiFbiIQ
 BuEQviub2kKvy3ke0vDuRwhUN/16/N/1Qv5rRTf4wN6ZK4Z28MSdkHilGQnzfXf/wCo6N5zoD6Q
 =
X-Gm-Gg: ASbGnctxtn+cPLbiBHs3QeP6bbeobXoKj91rLvbaaD0bvZZHFkFf0r7RGQgfWUqKsPi
 VWMyzCL1FjjCL8a862L+jWVI+QvGiWoONtZRYj4ZBZpPWkeLk2ClrKXTD+f8xT9AGOIvc9U1+VU
 M186ceu1yWtmDMvOxDAJXiZPUE5Ex74W/2J1aMvn57Hj6gFHeKud4U/1cZZojkB8ul+YxM5t2Y8
 6CR+c+N9PIWiRD5jJnmwf7bWs20JMun06lAAl5mGaXBk2cw4kgZIQdBtuiH3bHeepCnXY/xP9zm
 3r12vH9BQ5xlXMN4nz3oam6Zs+5HsMiu6W8aho08/Tjs3udgT+z4
X-Google-Smtp-Source: AGHT+IFa4iQDLOCUIiTe3mlg25iexFwjrUCFr+1cZqzviz7vNx6gygjeqi5odrQMX5DM1pF8AkGGMw==
X-Received: by 2002:a05:6602:6a47:b0:84a:51e2:6599 with SMTP id
 ca18e2360f4ac-854fd887242mr476872639f.1.1738953098427; 
 Fri, 07 Feb 2025 10:31:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/29] test: Show the average time per test
Date: Fri,  7 Feb 2025 11:30:36 -0700
Message-ID: <20250207183121.117663-6-sjg@chromium.org>
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

Show the average duration of a test, so we can keep track of how it is
trending. Report the suite with the longest average test to encourage
people to improve it.

Add a function to update the stats based on the results from a single
suite and another to show the summary information.

Make this optional, since sandbox's SPL tests do not have a timer driver
and people may want to print results without times.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

