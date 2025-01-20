Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFF6C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60C67807B1;
	Mon, 20 Jan 2025 22:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZylgcpoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3605E8032B; Mon, 20 Jan 2025 22:54:01 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94A3807E2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-844e39439abso144692139f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737410037; x=1738014837; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bpg/bl3XsKypIvkMxFzwKHkFMgm5jELls8wmobVJmuw=;
 b=ZylgcpoXS/iR+N97/krlh/iZYpJuJDvbDgDdrJEkUbI8j8UZhENSste9kBOyuahk1c
 uVsuTONZkxRDFfQU54NxeZpXbBuTSL9eiww5CJyXAAvo85/qvTdreY94zhc5jJHLxdmk
 2wHhqhbGV0FlRVtrzwLtsHVuGAzxlzdp2kavA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737410037; x=1738014837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bpg/bl3XsKypIvkMxFzwKHkFMgm5jELls8wmobVJmuw=;
 b=MS5RCvYQtpNuw58dLmeZEzTCNZX7/wvTJh/X4XSWRC74W2nO1fYPwciwM+RaP89ZrP
 vFnFKzWxqKWRfidzhHA9wZwE/Ze9t4U/l5dn2OMW0Y3GUs+zWOpIWfEPCmVyCT3wAVeS
 7CL4MBFpOEOJbfkMwA57Xj56JEkCkL2zzpNmlT46zYARqleEF7CkYg71Cn6NtkwfUPZe
 ylp+eSHTcJKxtI8Ph50700s7qNqSBM3twiyyi+b+ZIr+tc0atdjMz/qlPLmD9FAjDWNr
 WYzMjBHg96veUTkIQzQaoUupZzl4ZbaIhGIKgOpVSr4Qoi9BC3qJAI80AOkAEBcTd1Q1
 lqBw==
X-Gm-Message-State: AOJu0YxjxPQjfkzj4tAgODzSt5nImv7ZDZlGKZWuI/8TX1QTHBuDudN6
 TT2b1AjbnkONCvyUjEulonnH3iwxBr9lv4ZrEpvYuXO4cQ6VNtUN09WQZvECJOdtNSG0ya/GvIw
 =
X-Gm-Gg: ASbGncs+Brlfl//jAy9yW4VYGLHj3KX0PlaoNVUKK14LxOLEB9dCeo4vPArLNa8P+0j
 Z9lpl9ecRlb4vJywRmduH5/pVJ++7iosgMCU1q5PSUQg60qnmzSyd75+7xkHK6DGUZ0YbAGxImL
 PrBMFSWtCi+7HBV5rUxAN8oixLWtMDWQ5xmYyUhEPvds9ROVfmeYfN+tgSVQThdPE9Anuru8OWX
 Yde+7ta9sAS7tJRWe+rNJI+m2Ugt+zJMOLzljJfR27OzCqWXHB+kGCswF43yI3GZtmNrlDxHSB2
 QPseDy/xE1Rj2vO31nc6Bqj2sLZIwU0=
X-Google-Smtp-Source: AGHT+IGWYl8yRLYdnw6JQZcchF2VU9aIsYmgw0B4qbBFTAyocIEOjQkvw0Nqogsjl2LqbCmgm4TXWg==
X-Received: by 2002:a05:6602:36cc:b0:84f:5637:8dff with SMTP id
 ca18e2360f4ac-851b618d2e1mr1366958839f.4.1737410037104; 
 Mon, 20 Jan 2025 13:53:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea7568067csm2809650173.129.2025.01.20.13.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:53:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/28] test: Leave out the prefix when printing test names
Date: Mon, 20 Jan 2025 14:53:05 -0700
Message-ID: <20250120215340.617194-6-sjg@chromium.org>
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

When tests are all in the same suite it is annoying to have to read all
the common text after each name. Skip this to help the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd_ut.c               |  2 +-
 test/py/tests/test_suite.py |  7 ++++---
 test/test-main.c            | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index c96277d89a1..0b923ee7e2e 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -184,7 +184,7 @@ static int run_suite(struct unit_test_state *uts, struct suite *ste,
 		char prefix[30];
 
 		/* use a standard prefix */
-		snprintf(prefix, sizeof(prefix), "%s_test", ste->name);
+		snprintf(prefix, sizeof(prefix), "%s_test_", ste->name);
 		ret = cmd_ut_category(uts, ste->name, prefix, ste->start,
 				      n_ents, argc, argv);
 	}
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 73c185349b4..ae127301fd7 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -66,11 +66,12 @@ def collect_info(cons, output):
             msg = m.group(3)
             if DEBUG_ME:
                 cons.log.info(f"test_name {test_name} msg '{msg}'")
-            if msg == ' (flat tree)' and test_name not in tests:
-                tests.add(test_name)
+            full_name = f'{cur_suite}.{test_name}'
+            if msg == ' (flat tree)' and full_name not in tests:
+                tests.add(full_name)
                 test_count += 1
             if not msg or 'skipped as it is manual' in msg:
-                tests.add(test_name)
+                tests.add(full_name)
                 test_count += 1
         if DEBUG_ME:
             cons.log.info(f'test_count {test_count}')
diff --git a/test/test-main.c b/test/test-main.c
index 597afa25f77..8c0d820032c 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -514,11 +514,12 @@ static int ut_run_test(struct unit_test_state *uts, struct unit_test *test,
  *	the first call to this function. On exit, @uts->cur.fail_count is
  *	incremented by the number of failures (0, one hopes)
  * @test: Test to run
+ * @leaf: Part of the name to show, or NULL to use test->name
  * Return: 0 if all tests passed, -EAGAIN if the test should be skipped, -1 if
  *	any failed
  */
 static int ut_run_test_live_flat(struct unit_test_state *uts,
-				 struct unit_test *test)
+				 struct unit_test *test, const char *leaf)
 {
 	int runs, ret;
 
@@ -530,7 +531,7 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	if (CONFIG_IS_ENABLED(OF_LIVE)) {
 		if (!(test->flags & UTF_FLAT_TREE)) {
 			uts->of_live = true;
-			ret = ut_run_test(uts, test, test->name);
+			ret = ut_run_test(uts, test, leaf ?: test->name);
 			if (ret != -EAGAIN) {
 				ut_assertok(ret);
 				runs++;
@@ -558,7 +559,7 @@ static int ut_run_test_live_flat(struct unit_test_state *uts,
 	    (!runs || ut_test_run_on_flattree(test)) &&
 	    !(gd->flags & GD_FLG_FDT_CHANGED)) {
 		uts->of_live = false;
-		ret = ut_run_test(uts, test, test->name);
+		ret = ut_run_test(uts, test, leaf ?: test->name);
 		if (ret != -EAGAIN) {
 			ut_assertok(ret);
 			runs++;
@@ -594,6 +595,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 			struct unit_test *tests, int count,
 			const char *select_name, const char *test_insert)
 {
+	int prefix_len = prefix ? strlen(prefix) : 0;
 	struct unit_test *test, *one;
 	int found = 0;
 	int pos = 0;
@@ -646,7 +648,7 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 
 		uts->cur.test_count++;
 		if (one && upto == pos) {
-			ret = ut_run_test_live_flat(uts, one);
+			ret = ut_run_test_live_flat(uts, one, NULL);
 			if (uts->cur.fail_count != old_fail_count) {
 				printf("Test '%s' failed %d times (position %d)\n",
 				       one->name,
@@ -656,8 +658,11 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 			return -EBADF;
 		}
 
+		if (prefix_len && !strncmp(test_name, prefix, prefix_len))
+			test_name = test_name + prefix_len;
+
 		for (i = 0; i < uts->runs_per_test; i++)
-			ret = ut_run_test_live_flat(uts, test);
+			ret = ut_run_test_live_flat(uts, test, test_name);
 		if (uts->cur.fail_count != old_fail_count) {
 			printf("Test '%s' failed %d times\n", test_name,
 			       uts->cur.fail_count - old_fail_count);
-- 
2.43.0

