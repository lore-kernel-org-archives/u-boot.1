Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255FBC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 18:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 504408082A;
	Fri,  7 Feb 2025 19:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iv0v2424";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A43F80819; Fri,  7 Feb 2025 19:31:47 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A856680A0A
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 19:31:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e1020253so64998239f.3
 for <u-boot@lists.denx.de>; Fri, 07 Feb 2025 10:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738953100; x=1739557900; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a2wbxudzei54ZH3+lWn5BSoqDFsRYYRTkVKLkIdMxdU=;
 b=iv0v2424KIrYucNMXR1RMb2R6HGECA7E0NY3HcVwurQvKp0dGdtX+mySPA/fbeO3tb
 /XygiZ7nXIFGcb2rsotawwQNd1r7YQgzpk4FRc+N4dLLP8zHnwExPs+gax2Mn52l7iXQ
 lFD3dhVfQOnvq+BctVsfk5juMMko4/h2Fumck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738953100; x=1739557900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a2wbxudzei54ZH3+lWn5BSoqDFsRYYRTkVKLkIdMxdU=;
 b=mCe23FIr1gXQI7dKLZBuETWrXbJQxKUtznMP3htGpTH6rMGvtxtSEuzYfEdTWN77ll
 t35Hd4+WH+AR07m3lFo/h1KfxZ3DD9r/47ByURBb4EcbgZLIPsMyv/eFVA2RkBIuISIF
 3Ht6tKvTxpIAGzRAOpYSednvCL3V0JexaNdZtfJHXU4BW2NquepGzblhgEkjkVZaq+14
 qTnz9rfKJt5zhWx4mch7LbZtwtrzVCURTWRtvL5DJ42/HnLJyimEGiXJL1mlwCOK2Kcr
 zmATd/j2KeaO+jQzcgV+ryHE+rdmFf6ppFAKUaAgWEJS3U9OZrNXYvkvEpTBnGHzDt5v
 kQsg==
X-Gm-Message-State: AOJu0YxVHnhFp/qutJwTXKgK1bqJAcZumPxXGKXyV1Bwm2/wNvLwPexX
 D7xn1g/ck/haEtOgdIhix7xsjSQErS2MS8CTr13GerEVAttoW3TZUYDpOFNaF4kQhy7uWldG6cs
 =
X-Gm-Gg: ASbGncu3dGfzUGCyOLs1za7GorCrCOAGLXYkCBsvvFBCV1KEYUSDcjIhhDJDaQEELfo
 VM0/gaK1Jj4r7ET06FAgG7hXxihZrOveKyjv6bCv2wVl3tLZfG7IGDz9uvikNn6lSQj9ZexqFwd
 itdve5BI18sdnWlWhZK20dAlEdWCzfs8q07Jh451Y6gRns6XbVoSiS23wa2DW/SCNTobY3j1FFf
 7CwMJmnfrZdip4cqbIkxvpwlUdm8MHljePdbMrhACMZv83KVOLd3vW16R3kmjDrqucMAxs7vdYl
 ASinttUQidzYsF3wx8XBeJxnprxO4Ny+wbIbr8x6yuEyt8ly2LEU
X-Google-Smtp-Source: AGHT+IHhNWis/8yoiEx2NNybK3xrMpNN+HYH+qS7oqOEg6vRuwtKgbcXLKW4lwZStvTOmVdAHTmpDg==
X-Received: by 2002:a05:6602:4895:b0:84a:5201:570b with SMTP id
 ca18e2360f4ac-854fd79521cmr428377439f.0.1738953100284; 
 Fri, 07 Feb 2025 10:31:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-854f67bc3ecsm74850439f.47.2025.02.07.10.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 10:31:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 06/29] test: Leave out the prefix when printing test names
Date: Fri,  7 Feb 2025 11:30:37 -0700
Message-ID: <20250207183121.117663-7-sjg@chromium.org>
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

When tests are all in the same suite it is annoying to have to read all
the common text after each name. Skip this to help the user.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

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

