Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35A5C02182
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 21:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18643807D6;
	Mon, 20 Jan 2025 22:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cm9K4amv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9F84807B9; Mon, 20 Jan 2025 22:26:47 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF23807E5
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 22:26:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-844ce213af6so160487639f.1
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 13:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737408404; x=1738013204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3NbCiPsnGQd3QBrTTGBKlT06mPBTFuFtT0Db9nuAJ3Q=;
 b=Cm9K4amvdK41/NvZmHtCzNVE4HjcCvguq8cV7WWgt7GGtQufPMC6If2CbheKAKAojP
 ouw6Ql1qGrv1YNb/wywQa9bX033Ewt4V68uHuJscdlbFXwRGbgN21umfLYhjYNacs/ys
 kbETOJvA39Ud9PzxPHpCVOnd0nTGrbikYt0xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737408404; x=1738013204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3NbCiPsnGQd3QBrTTGBKlT06mPBTFuFtT0Db9nuAJ3Q=;
 b=Tk7EwVsbpv/yS6BWUk5XadVDkatF33WO0uKfvGG8G8H5mGrp7iS3kyAu6xBxhji0fZ
 Xax/YWuWtN7pfkhW9VjxMcZX8YiSxBy+Igsgi3pZWM6wGM5+ZgsLZ6CAMu9vgDAYjtSP
 coY+FNpwRR5VGXdyeHuHG1qF6YZbu594pxRwvgOapYcIioJ5Qeo+QqfpRlHuTFvf/rRD
 xUsYVtec0UKh8PLn9E9cQ2zI2+ZcvZRMdKGn2PLzFLEt6vfEDmPlRAtOKKjNbHqEcR5d
 UbuarUzvjpZ970NZDMajz0t8i/yzh+3O0d90ct0vV6zizuXppOnAWsUSgvQtY3JcbMSs
 J6PA==
X-Gm-Message-State: AOJu0Ywh1waqth2O8PIJs/5antttfH3EvROrTEI6djsmiGj7ypMuio9Y
 G0tZ+u13ijVAel4+fT+DkbSa+5HodlNXztITBwL1TREl4ZrGGNjrgBXH+2APtibYWOJn+Dyc4SE
 =
X-Gm-Gg: ASbGncsZC+C9r00UCXJk6gTK8JqvWdkvjO/mp351n/HMWob0OPElz576bTk8lprdfjj
 ucy+InCGDimJfq4FNu/FLYXrlEq7tSgWhlzjD5yWDcWQ88tssX5MQBKLW9DpiMk1HP8lGIuN4nH
 TLSl5OXXi7sFHOGYkGWgT67+axmb4B/VL6KHQYBUhJzOaq1TUknwiL8JjERpC19pjsv/PnD7Qui
 7AlMV+hrfsWOm7CXcY2i8eXavYTHszV1uq5Er9nhrJEjFsOj22+GRntxgQd2sMoSY1KsZETf2++
 e8z5ZcD4H5DEwmTI3XEWOkcGaR4CRbk=
X-Google-Smtp-Source: AGHT+IGLqk7bQkC1SWXtExhmIiZBfReITtuIltPC/7yIo8BoOjpgGWvJDN7b4b3YDJQMyAjzhm2kNQ==
X-Received: by 2002:a05:6602:6402:b0:832:480d:6fe1 with SMTP id
 ca18e2360f4ac-851b6034ec7mr1111816239f.0.1737408403680; 
 Mon, 20 Jan 2025 13:26:43 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea75440a24sm2847693173.33.2025.01.20.13.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 13:26:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/44] test/py: Add a test which runs all unit tests
Date: Mon, 20 Jan 2025 14:25:31 -0700
Message-ID: <20250120212613.516664-10-sjg@chromium.org>
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

Add a Python test which runs 'ut all' and then checks that the expected
suites are present and all tests in each suite are run.

This can help to check that nothing is missing.

Update 'ut info' to ignore the 'all' suite when counting the number of
suites, since that is really just a combination of all the other suites.

Adjust the message for skipped tests so that appears even if no
particular test was selected. This helps the new 'test_suite' test see
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add a little more debugging
- Strip lines before processing
- Correct the comment on collect_info()
- Show a better assertion message with missing/extra suites

 test/cmd_ut.c               |   2 +-
 test/py/tests/test_suite.py | 183 ++++++++++++++++++++++++++++++++++++
 test/test-main.c            |   6 +-
 3 files changed, 186 insertions(+), 5 deletions(-)
 create mode 100644 test/py/tests/test_suite.py

diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 3e78d072b3d..978974e6687 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -155,7 +155,7 @@ static int do_ut_info(struct cmd_tbl *cmdtp, int flag, int argc,
 {
 	const char *flags;
 
-	printf("Test suites: %d\n", (int)ARRAY_SIZE(cmd_ut_sub));
+	printf("Test suites: %d\n", (int)ARRAY_SIZE(cmd_ut_sub) - 1);
 	printf("Total tests: %d\n", (int)UNIT_TEST_ALL_COUNT());
 
 	flags = cmd_arg1(argc, argv);
diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
new file mode 100644
index 00000000000..706c9d9673f
--- /dev/null
+++ b/test/py/tests/test_suite.py
@@ -0,0 +1,183 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2024 Google LLC
+
+import pytest
+import re
+
+# List of test suites we expect to find with 'ut info' and 'ut all'
+EXPECTED_SUITES = [
+    'addrmap', 'bdinfo', 'bloblist', 'bootm', 'bootstd',
+    'cmd', 'common', 'dm', 'env', 'exit',
+    'fdt', 'font', 'hush', 'info', 'lib',
+    'loadm', 'log', 'mbr', 'measurement', 'mem',
+    'overlay', 'pci_mps', 'setexpr', 'upl',
+    ]
+
+
+# Set this to True to aid debugging of tests
+DEBUG_ME = False
+
+
+def collect_info(cons, output):
+    """Process the output from 'ut all'
+
+    Args:
+        cons: U-Boot console object
+        output: Output from running 'ut all'
+
+    Returns:
+        tuple:
+            set: suite names that were found in output
+            set: test names that were found in output
+            dict: test count for each suite:
+                key: suite name
+                value: number of tests for the suite found in output
+            set: missing suites (compared to EXPECTED_SUITES)
+            set: extra suites (compared to EXPECTED_SUITES)
+    """
+    suites = set()
+    tests = set()
+    cur_suite = None
+    test_count = None
+    exp_test_count = {}
+
+    # Collect suites{}
+    for line in output.splitlines():
+        line = line.rstrip()
+        if DEBUG_ME:
+            cons.log.info(f'line: {line}')
+        m = re.search('----Running ([^ ]*) tests----', line)
+        if m:
+            if DEBUG_ME and cur_suite and cur_suite != 'info':
+                cons.log.info(f'suite: {cur_suite} expected {exp_test_count[cur_suite]} found {test_count}')
+
+            cur_suite = m.group(1)
+            if DEBUG_ME:
+                cons.log.info(f'cur_suite: {cur_suite}')
+            suites.add(cur_suite)
+
+            test_count = 0
+        m = re.match(rf'Running (\d+) {cur_suite} tests', line)
+        if m:
+            exp_test_count[cur_suite] = int(m.group(1))
+        m = re.search(r'Test: (\w*): ([-a-z0-9_]*\.c)?( .*)?', line)
+        if m:
+            test_name = m.group(1)
+            msg = m.group(3)
+            if DEBUG_ME:
+                cons.log.info(f"test_name {test_name} msg '{msg}'")
+            if msg == ' (flat tree)' and test_name not in tests:
+                tests.add(test_name)
+                test_count += 1
+            if not msg or 'skipped as it is manual' in msg:
+                tests.add(test_name)
+                test_count += 1
+        if DEBUG_ME:
+            cons.log.info(f'test_count {test_count}')
+    if DEBUG_ME:
+        cons.log.info(f'suite: {cur_suite} expected {exp_test_count[cur_suite]} found {test_count}')
+        cons.log.info(f"Tests: {' '.join(sorted(list(tests)))}")
+
+    # Figure out what is missing, or extra
+    missing = set()
+    extra = set(suites)
+    for suite in EXPECTED_SUITES:
+        if suite in extra:
+            extra.remove(suite)
+        else:
+            missing.add(suite)
+
+    return suites, tests, exp_test_count, missing, extra
+
+
+def process_ut_info(cons, output):
+    """Process the output of the 'ut info' command
+
+    Args:
+        cons: U-Boot console object
+        output: Output from running 'ut all'
+
+    Returns:
+        tuple:
+            int: Number of suites reported
+            int: Number of tests reported
+            dict: test count for each suite:
+                key: suite name
+                value: number of tests reported for the suite
+
+    """
+    suite_count = None
+    total_test_count = None
+    test_count = {}
+    for line in output.splitlines():
+        line = line.rstrip()
+        if DEBUG_ME:
+            cons.log.info(f'line: {line}')
+        m = re.match(r'Test suites: (.*)', line)
+        if m:
+            suite_count = int(m.group(1))
+        m = re.match(r'Total tests: (.*)', line)
+        if m:
+            total_test_count = int(m.group(1))
+        m = re.match(r'  *([0-9?]*)  (\w*)', line)
+        if m:
+            test_count[m.group(2)] = m.group(1)
+    return suite_count, total_test_count, test_count
+
+
+@pytest.mark.buildconfigspec('sandbox')
+@pytest.mark.notbuildconfigspec('sandbox_spl')
+@pytest.mark.notbuildconfigspec('sandbox64')
+def test_suite(u_boot_console):
+    """Perform various checks on the unit tests, including:
+
+       - The number of suites matches that reported by the 'ut info'
+       - Where available, the number of tests is each suite matches that
+         reported by 'ut info -s'
+       - The total number of tests adds up to the total that are actually run
+         with 'ut all'
+       - All suites are run with 'ut all'
+       - The expected set of suites is run (the list is hard-coded in this test)
+
+    """
+    cons = u_boot_console
+    with cons.log.section('Run all unit tests'):
+        # ut hush hush_test_simple_dollar prints "Unknown command" on purpose.
+        with u_boot_console.disable_check('unknown_command'):
+            output = cons.run_command('ut all')
+
+    # Process the output from the run
+    with cons.log.section('Check output'):
+        suites, all_tests, exp_test_count, missing, extra = collect_info(cons,
+                                                                         output)
+    cons.log.info(f'missing {missing}')
+    cons.log.info(f'extra {extra}')
+
+    # Make sure we got a test count for each suite (ignore 'info' since it isn't
+    # a real suite
+    assert suites - exp_test_count.keys() == {'info'}
+
+    # Run 'ut info' and compare with the log results
+    with cons.log.section('Check suite test-counts'):
+        output = cons.run_command('ut info -s')
+
+        suite_count, total_test_count, test_count = process_ut_info(cons,
+                                                                    output)
+
+        if missing or extra:
+            cons.log.info(f"suites: {' '.join(sorted(list(suites)))}")
+            cons.log.error(f'missing: {sorted(list(missing))}')
+            cons.log.error(f'extra: {sorted(list(extra))}')
+
+        assert not missing, f'Missing suites {missing}'
+        assert not extra, f'Extra suites {extra}'
+
+        cons.log.info(str(exp_test_count))
+        for suite in EXPECTED_SUITES:
+            # 'info' is not really a suite, just a subcommand of 'ut'
+            if suite != 'info':
+                assert test_count[suite] in ['?', str(exp_test_count[suite])],\
+                    f'suite {suite} expected {exp_test_count[suite]}'
+
+        assert suite_count == len(EXPECTED_SUITES)
+        assert total_test_count == len(all_tests)
diff --git a/test/test-main.c b/test/test-main.c
index e12c5a95e45..391d4e7bb0e 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -636,10 +636,8 @@ static int ut_run_tests(struct unit_test_state *uts, const char *prefix,
 				return -EBADF;
 			}
 			if (!uts->force_run) {
-				if (select_name) {
-					printf("Test '%s' skipped as it is manual (use -f to run it)\n",
-					       test_name);
-				}
+				printf("Test: %s: skipped as it is manual (use -f to run it)\n",
+				       test_name);
 				continue;
 			}
 		}
-- 
2.43.0

