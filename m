Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C308C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A453180BB0;
	Mon, 20 Jan 2025 22:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N8UarJBj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A1CD80BB0; Mon, 20 Jan 2025 22:27:42 +0100 (CET)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A89180B9E
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-844ee15d6f4so399097339f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408458; x=1738013258; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y+czy/1vKHRWDd15qDGkJGk6ZPV79WiceX63MgJD9to=;
 b=N8UarJBjTYQNY3jp3+CWPS/2UG1GirqDwKw1DelYNzlBzfF6ZpIOztPtFKIczOjao2
 3LCGwbzfHlIwLnO7gVqrmnyAOQ5z4bdHhOV5cy9dZd3bVrDXUUgO7tivvhhSEdjfiC9F
 Dvs7mVC1UJJo64k5+8xrhu4KYqJFcpOQsOSn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408458; x=1738013258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y+czy/1vKHRWDd15qDGkJGk6ZPV79WiceX63MgJD9to=;
 b=D/8sZaYMkpT5meSgxXY7ybOuAb+rYEpx5nYrCv5rZy0/5f7Iz0sZcT4vQdx3bMSqzX
 zoMD20Zusiv0Kktp/TV6ptzAvtboPjj36ArLscdzMJI34UAlGgcu1lv+VS+n4wuCjleI
 iIphl71KU6pz5dPFJvuKxlS52qMtZTR9nL/5zDEqmm9HjL2A/kQ7Cvx1P78D2Eg+WRQt
 syJrBv422UUruWLr71h6eCSoRCnlNe62Qcz7inoYiMc319M64s1rWLqtnbxoIZxUG5FI
 yQNk/re2iP52kqm3yUNEEORXxyxvTWokywEvdXS4o5zP1zmKLmhMQSRnfe6532Wsgju0
 Zjvg==
X-Gm-Message-State: AOJu0YwlWG2vnh0CtybEn/EIjpkC9nLpDSvX/aG2oOlmwD53bqjKiPMV
 MEC5DkP1CsxQ+e1t38YyEcj1oB6F8JG9KYvVoPzTuMok5LsHxQvp/T1QcPcO/af4njQvswEpuqY
 =
X-Gm-Gg: ASbGncuSB5BQHJdBeDX67Xoo4kYQIBy5bIuaYUU0DZnBn7+Nl2Xf/r4FuvRWMKwYA8q
 vi0rhQS/1rwzqt97lvQJwNUxh+dVAEFjlsWEo5h+YWlJ/+osgVvZsLi/Kr25a8FhhcipJeuL+4h
 lsnUbWKmE5UPTm5E63sw5gdyitS0ycNeA2el573g79M6Hd6XrUg2VUHQanInb63Aqspe++9T+aQ
 V6NIfJyf4+7mi/WkGWxMvKUFCPYe8sixkugTgt/zy9xaoGMpYyclFxYJ3yiORt1prrgeZheXwXk
 Pcloyg1dZvuQpfIXbuPc7IRAVe8OdmI=
X-Google-Smtp-Source: AGHT+IHLoDk6aF4lgow7ExrXA6SRQTOACBYNaX/Mwj2b03As7xIn0/zZOSdw3QzZJ/yDBvP4j5Rn4Q==
X-Received: by 2002:a05:6602:36cc:b0:849:c82e:c084 with SMTP id
 ca18e2360f4ac-851b6192ea6mr1237016939f.6.1737408458339; 
 Mon, 20 Jan 2025 13:27:38 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:27:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Richard Weinberger <richard@nod.at>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 39/44] test: Move stat-printing into its own function
Date: Mon, 20 Jan 2025 14:26:01 -0700
Message-ID: <20250120212613.516664-40-sjg@chromium.org>
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

Add a function to show the stats, so we can decide when to print it.

This slightly adjusts the output, so that any 'test not found' message
appears on its own line after all other output.

The 'failures' message now appears in lower case so update pytest
accordingly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Adjust ut_report() to take a run-count

 arch/sandbox/cpu/spl.c    |  1 +
 include/test/ut.h         |  8 ++++++++
 test/py/tests/test_spl.py |  2 +-
 test/py/tests/test_upl.py |  2 +-
 test/py/tests/test_ut.py  |  2 +-
 test/py/tests/test_vbe.py |  2 +-
 test/py/tests/test_vpl.py |  2 +-
 test/test-main.c          | 18 +++++++++++++-----
 8 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/arch/sandbox/cpu/spl.c b/arch/sandbox/cpu/spl.c
index 0ad23e4ba95..ecc03785463 100644
--- a/arch/sandbox/cpu/spl.c
+++ b/arch/sandbox/cpu/spl.c
@@ -153,6 +153,7 @@ void spl_board_init(void)
 		ut_init_state(&uts);
 		ret = ut_run_list(&uts, "spl", NULL, tests, count,
 				  state->select_unittests, 1, false, NULL);
+		ut_report(&uts.cur, 1);
 		ut_uninit_state(&uts);
 		/* continue execution into U-Boot */
 	}
diff --git a/include/test/ut.h b/include/test/ut.h
index a51defc3b90..be5502e03a1 100644
--- a/include/test/ut.h
+++ b/include/test/ut.h
@@ -530,4 +530,12 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 		const char *select_name, int runs_per_test, bool force_run,
 		const char *test_insert);
 
+/**
+ * ut_report() - Report stats on a test run
+ *
+ * @stats: Stats to show
+ * @run_count: Number of suites that were run
+ */
+void ut_report(struct ut_stats *stats, int run_count);
+
 #endif
diff --git a/test/py/tests/test_spl.py b/test/py/tests/test_spl.py
index 42e4c4342b2..474f430a344 100644
--- a/test/py/tests/test_spl.py
+++ b/test/py/tests/test_spl.py
@@ -36,7 +36,7 @@ def test_spl(u_boot_console, ut_spl_subtest):
         cons = u_boot_console
         cons.restart_uboot_with_flags(['-u', '-k', ut_spl_subtest.split()[1]])
         output = cons.get_spawn_output().replace('\r', '')
-        assert 'Failures: 0' in output
+        assert 'failures: 0' in output
     finally:
         # Restart afterward in case a non-SPL test is run next. This should not
         # happen since SPL tests are run in their own invocation of test.py, but
diff --git a/test/py/tests/test_upl.py b/test/py/tests/test_upl.py
index 3164bda6b71..d94359d8b9b 100644
--- a/test/py/tests/test_upl.py
+++ b/test/py/tests/test_upl.py
@@ -35,4 +35,4 @@ def test_upl_handoff(u_boot_console):
 
     # Check the FIT offsets look correct
     output = cons.run_command('ut upl -f upl_test_info_norun')
-    assert 'Failures: 0' in output
+    assert 'failures: 0' in output
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index cacf11f7c0a..d2d8ce10755 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -607,4 +607,4 @@ def test_ut(u_boot_console, ut_subtest):
         assert 'Unknown command \'quux\' - try \'help\'' in output
     else:
         output = u_boot_console.run_command('ut ' + ut_subtest)
-    assert output.endswith('Failures: 0')
+    assert output.endswith('failures: 0')
diff --git a/test/py/tests/test_vbe.py b/test/py/tests/test_vbe.py
index 50b6c1cd911..861df3f8266 100644
--- a/test/py/tests/test_vbe.py
+++ b/test/py/tests/test_vbe.py
@@ -117,4 +117,4 @@ def test_vbe(u_boot_console):
     with cons.log.section('Kernel load'):
         output = cons.run_command_list(cmd.splitlines())
 
-    assert 'Failures: 0' in output[-1]
+    assert 'failures: 0' in output[-1]
diff --git a/test/py/tests/test_vpl.py b/test/py/tests/test_vpl.py
index 4af578b9173..8c472ca7a92 100644
--- a/test/py/tests/test_vpl.py
+++ b/test/py/tests/test_vpl.py
@@ -26,7 +26,7 @@ def test_vpl(u_boot_console, ut_vpl_subtest):
         cons = u_boot_console
         cons.restart_uboot_with_flags(['-u', '-k', ut_vpl_subtest.split()[1]])
         output = cons.get_spawn_output().replace('\r', '')
-        assert 'Failures: 0' in output
+        assert 'failures: 0' in output
     finally:
         # Restart afterward in case a non-VPL test is run next. This should not
         # happen since VPL tests are run in their own invocation of test.py, but
diff --git a/test/test-main.c b/test/test-main.c
index e36bc37d29e..d02ab791b5a 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -673,6 +673,18 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 	return uts->cur.fail_count ? -EBADF : 0;
 }
 
+void ut_report(struct ut_stats *stats, int run_count)
+{
+	if (run_count > 1)
+		printf("Suites run: %d, total tests", run_count);
+	else
+		printf("Tests");
+	printf(" run: %d, ", stats->test_count);
+	if (stats->skip_count)
+		printf("skipped: %d, ", stats->skip_count);
+	printf("failures: %d\n", stats->fail_count);
+}
+
 int ut_run_list(struct unit_test_state *uts, const char *category,
 		const char *prefix, struct unit_test *tests, int count,
 		const char *select_name, int runs_per_test, bool force_run,
@@ -718,13 +730,9 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
 	if (has_dm_tests)
 		dm_test_restore(uts->of_root);
 
-	printf("Tests run: %d, ", uts->cur.test_count);
-	if (uts->cur.skip_count)
-		printf("Skipped: %d, ", uts->cur.skip_count);
+	ut_report(&uts->cur, 1);
 	if (ret == -ENOENT)
 		printf("Test '%s' not found\n", select_name);
-	else
-		printf("Failures: %d\n", uts->cur.fail_count);
 
 	return ret;
 }
-- 
2.43.0

