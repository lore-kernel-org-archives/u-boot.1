Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 753DAC0218D
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 00:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B450C80F98;
	Mon, 27 Jan 2025 01:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XfZPGy5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1CFA80F98; Mon, 27 Jan 2025 01:39:43 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D597805DA
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 01:39:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84ceaf2667aso280841139f.3
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737938379; x=1738543179; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AUY4MEUdpfT/oS3PFYwwCeKhWDTNszOvfOJIyN1OZho=;
 b=XfZPGy5tciIEoj+2tFBVZ216QS5VtiFgEIT+uL3xswoPYBgmLN9r5t896nW9PqV4eX
 26Ex3I5TOpvKJuuxX1JxFPWv3zdPTaZCUw5cLAzF2ui8t+6GkdI82v2OFOeCAs0BBzEa
 qWYDaQlqZ2MEkH+fypoGpV61fIFEn7AObQaM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737938379; x=1738543179;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AUY4MEUdpfT/oS3PFYwwCeKhWDTNszOvfOJIyN1OZho=;
 b=F8AiX6D/kcw7xndcyvAkJ2jtCIack0JmmAlbC8BQywh7VZS3MTiGDBpvBgqfDc0C2N
 srGA4wMgBxfgQOvbPehyMhlQzPh6P9xEvEqDJ6oEw7chLHomoXqreAPMgdpnDvcs+oP4
 iVnp9rWd2+gVERZPVyzJt75fUK7j/17Rp4iieQ9LfybL86UWc2XP3yJ4e7U3z2h8C1mx
 JhM3MBYPqPp+ao9/eC7fpRG7T0TQZEYuPZvvNRAe10NCy4KKNIxndgKYsJeYXBflonOc
 CXWUgVzOcOwMJkRyw57QSUOsi+q2P1CKKYx+t9QLYAguL6g5U2FD4e5PYPivBNAbzI4i
 bNvQ==
X-Gm-Message-State: AOJu0Yxvv3V2b5lN/u2H9ok6f++FbFB9rbKBl/RHthpUNUtETHSkSQ6t
 jx4qPHua3owcUDPuHYk4/t541EugCr5VxdYf8g+MaRtJd/AZincTcm9sWxtbnNFw2aKHOgvdmZY
 =
X-Gm-Gg: ASbGncuw4pxmPuelmZfguA2kIRFjkYkVuXxCQPmdy9Bu+pQv/tu2Vljn0NPK1kzF30i
 dXJmwjU9FhWSQmBQ3o9kPYfWrnk/2vGrQIyJQFE4G5fMVJYtOZf6FjgZEve1bCsgKX5BSYI6SsU
 7KYsUliXZt02G9VLKO2v7lEG88XZa3ktTOfDxS6u/eo+mUNBp045/5KIwKrxic34iD1zK4q5Nh/
 DJc0U2y384I4dqypneFiaEsD7dJHLx/CncDwXSqjVtaSmYa274/0+41yLkUihgoRFRqZPKcllEm
 Rosl7yEA5LxNJVZ0qaZYnTNcU6RUgT4L3jUWdo+wKg==
X-Google-Smtp-Source: AGHT+IGPcR2ZdDxU3yzvWWmGHuRpjFBrd/pjZVy+VscbjToVGCNnBs4nzFdVii0PemXibsvsAlAe4g==
X-Received: by 2002:a05:6602:7287:b0:843:e8d0:a728 with SMTP id
 ca18e2360f4ac-851b618dc7bmr3805464539f.4.1737938379250; 
 Sun, 26 Jan 2025 16:39:39 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8521e01abb7sm248163339f.36.2025.01.26.16.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 16:39:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH v2] test/py: Add a report show test durations
Date: Sun, 26 Jan 2025 17:39:22 -0700
Message-ID: <20250127003934.594726-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Execution time varies widely with the existing tests. Provides a way to
produce a summary of the time taken for each test, along with a
histogram.

This is enabled with the --timing flag.

Enable it for sandbox in CI.

Example:

   Duration : Number of tests
   ======== : ========================================
       <1ms :  1
       <8ms :  1
      <20ms : # 20
      <30ms : ######## 127
      <50ms : ######################################## 582
      <75ms : ####### 102
     <100ms : ## 39
     <200ms : ##### 86
     <300ms : # 29
     <500ms : ## 42
     <750ms : # 16
      <1.0s : # 15
      <2.0s : # 23
      <3.0s :  13
      <5.0s :  9
      <7.5s :  1
     <10.0s :  6
     <20.0s :  12

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Only show the report if the --timing flag is provided
- Use --timing flag to show the report in CI for just the sandbox tests

 .azure-pipelines.yml       |  3 +-
 .gitlab-ci.yml             |  3 +-
 doc/develop/py_testing.rst | 33 +++++++++++++++
 test/py/conftest.py        | 87 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index df3f82074af..1a5d15a8cdc 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -295,7 +295,7 @@ stages:
           export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:\${PATH}
           export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci
           # "\${var:+"-k \$var"}" expands to "" if \$var is empty, "-k \$var" if not
-          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
+          ./test/py/test.py -ra -o cache_dir="\$UBOOT_TRAVIS_BUILD_DIR"/.pytest_cache --bd \${TEST_PY_BD} \${TEST_PY_ID} \${TEST_TIMING} \${TEST_PY_TEST_SPEC:+"-k \${TEST_PY_TEST_SPEC}"} --build-dir "\$UBOOT_TRAVIS_BUILD_DIR" --report-dir "\$UBOOT_TRAVIS_BUILD_DIR" --junitxml=\$(System.DefaultWorkingDirectory)/results.xml
           # the below corresponds to .gitlab-ci.yml "after_script"
           rm -rf /tmp/uboot-test-hooks /tmp/venv
           EOF
@@ -318,6 +318,7 @@ stages:
       matrix:
         sandbox:
           TEST_PY_BD: "sandbox"
+          TEST_TIMING: "--timing"
         sandbox_asan:
           TEST_PY_BD: "sandbox"
           OVERRIDE: "-a ASAN"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 88a078c83dc..a25c037b7d3 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -89,7 +89,7 @@ stages:
     # "${var:+"-k $var"}" expands to "" if $var is empty, "-k $var" if not
     - export PATH=/opt/qemu/bin:/tmp/uboot-test-hooks/bin:${PATH};
       export PYTHONPATH=/tmp/uboot-test-hooks/py/travis-ci;
-      ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID}
+      ./test/py/test.py -ra --bd ${TEST_PY_BD} ${TEST_PY_ID} ${TEST_TIMING}
         ${TEST_PY_TEST_SPEC:+"-k ${TEST_PY_TEST_SPEC}"}
         --build-dir "$UBOOT_TRAVIS_BUILD_DIR"
         --junitxml=/tmp/${TEST_PY_BD}/results.xml
@@ -273,6 +273,7 @@ Check packing of Python tools:
 sandbox test.py:
   variables:
     TEST_PY_BD: "sandbox"
+    TEST_TIMING: "--timing"
   <<: *buildman_and_testpy_dfn
 
 sandbox with clang test.py:
diff --git a/doc/develop/py_testing.rst b/doc/develop/py_testing.rst
index 6ff78103409..b50473039be 100644
--- a/doc/develop/py_testing.rst
+++ b/doc/develop/py_testing.rst
@@ -246,6 +246,39 @@ Command-line options
   sets the directory used to store persistent test data. This is test data that
   may be re-used across test runs, such as file-system images.
 
+--timing
+  shows a histogram of test duration, at the end of the run. The columns are:
+
+  Duration
+      the duration-bucket that this test was in
+
+  Total
+      total time of all tests in this bucket
+
+  Number of tests
+      graph showing the number of tests in this bucket, with the actual number
+      shown at the end
+
+  Example::
+
+    Duration :   Total  | Number of tests
+    ======== : =======  |========================================
+       <20ms :   418ms  |## 23
+       <30ms :    9.1s  |######################################## 347
+       <40ms :   10.0s  |################################# 294
+       <50ms :    3.1s  |####### 69
+       <75ms :    2.6s  |#### 43
+      <100ms :    1.7s  |## 19
+      <200ms :    3.0s  |## 22
+      <300ms :    1.7s  | 7
+      <400ms :   675ms  | 2
+      <500ms :    2.2s  | 5
+      <750ms :    8.3s  |# 13
+       <1.0s :    1.6s  | 2
+       <2.0s :    9.4s  | 7
+       <3.0s :    2.4s  | 1
+       <7.5s :    6.1s  | 1
+
 `pytest` also implements a number of its own command-line options. Commonly used
 options are mentioned below. Please see `pytest` documentation for complete
 details. Execute `py.test --version` for a brief summary. Note that U-Boot's
diff --git a/test/py/conftest.py b/test/py/conftest.py
index 3bd333bfd24..31043a697e2 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -25,6 +25,7 @@ import re
 from _pytest.runner import runtestprotocol
 import subprocess
 import sys
+import time
 from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Globals: The HTML log file, and the connection to the U-Boot console.
@@ -91,6 +92,9 @@ def pytest_addoption(parser):
     parser.addoption('--role', help='U-Boot board role (for Labgrid-sjg)')
     parser.addoption('--use-running-system', default=False, action='store_true',
         help="Assume that U-Boot is ready and don't wait for a prompt")
+    parser.addoption('--timing', default=False, action='store_true',
+                     help='Show info on test timing')
+
 
 def run_build(config, source_dir, build_dir, board_type, log):
     """run_build: Build U-Boot
@@ -322,6 +326,7 @@ def pytest_configure(config):
     ubconfig.use_running_system = config.getoption('use_running_system')
     ubconfig.dtb = build_dir + '/arch/sandbox/dts/test.dtb'
     ubconfig.connection_ok = True
+    ubconfig.timing = config.getoption('timing')
 
     env_vars = (
         'board_type',
@@ -516,6 +521,12 @@ tests_skipped = []
 tests_warning = []
 tests_passed = []
 
+# Duration of each test:
+#    key (string): test name
+#    value (float): duration in ms
+test_durations = {}
+
+
 def pytest_itemcollected(item):
     """pytest hook: Called once for each test found during collection.
 
@@ -531,6 +542,73 @@ def pytest_itemcollected(item):
 
     tests_not_run.append(item.name)
 
+
+def show_timings():
+    """Write timings for each test, along with a histogram"""
+
+    def get_time_delta(msecs):
+        """Convert milliseconds into a user-friendly string"""
+        if msecs >= 1000:
+            return f'{msecs / 1000:.1f}s'
+        else:
+            return f'{msecs:.0f}ms'
+
+    def show_bar(key, msecs, value):
+        """Show a single bar (line) of the histogram
+
+        Args:
+            key (str): Key to write on the left
+            value (int): Value to display, i.e. the relative length of the bar
+        """
+        if value:
+            bar_length = int((value / max_count) * max_bar_length)
+            print(f"{key:>8} : {get_time_delta(msecs):>7}  |{'#' * bar_length} {value}", file=buf)
+
+    # Create the buckets we will use, each has a count and a total time
+    bucket = {}
+    for power in range(5):
+        for i in [1, 2, 3, 4, 5, 7.5]:
+            bucket[i * 10 ** power] = {'count': 0, 'msecs': 0.0}
+    max_dur = max(bucket.keys())
+
+    # Collect counts for each bucket; if outside the range, add to too_long
+    # Also show a sorted list of test timings from longest to shortest
+    too_long = 0
+    too_long_msecs = 0.0
+    max_count = 0
+    with log.section('Timing Report', 'timing_report'):
+        for name, dur in sorted(test_durations.items(), key=lambda kv: kv[1],
+                                reverse=True):
+            log.info(f'{get_time_delta(dur):>8}  {name}')
+            greater = [k for k in bucket.keys() if dur <= k]
+            if greater:
+                buck = bucket[min(greater)]
+                buck['count'] += 1
+                max_count = max(max_count, buck['count'])
+                buck['msecs'] += dur
+            else:
+                too_long += 1
+                too_long_msecs += dur
+
+    # Set the maximum length of a histogram bar, in characters
+    max_bar_length = 40
+
+    # Show a a summary with histogram
+    buf = io.StringIO()
+    with log.section('Timing Summary', 'timing_summary'):
+        print('Duration :   Total  | Number of tests', file=buf)
+        print(f'{"=" * 8} : {"=" * 7}  |{"=" * max_bar_length}', file=buf)
+        for dur, buck in bucket.items():
+            if buck['count']:
+                label = get_time_delta(dur)
+                show_bar(f'<{label}', buck['msecs'], buck['count'])
+        if too_long:
+            show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
+        log.info(buf.getvalue())
+    if ubconfig.timing:
+        print(buf.getvalue(), end='')
+
+
 def cleanup():
     """Clean up all global state.
 
@@ -580,6 +658,7 @@ def cleanup():
                 for test in tests_not_run:
                     anchor = anchors.get(test, None)
                     log.status_fail('... ' + test, anchor)
+        show_timings()
         log.close()
 atexit.register(cleanup)
 
@@ -713,7 +792,9 @@ def pytest_runtest_protocol(item, nextitem):
     log.get_and_reset_warning()
     ihook = item.ihook
     ihook.pytest_runtest_logstart(nodeid=item.nodeid, location=item.location)
+    start = time.monotonic()
     reports = runtestprotocol(item, nextitem=nextitem)
+    duration = round((time.monotonic() - start) * 1000, 1)
     ihook.pytest_runtest_logfinish(nodeid=item.nodeid, location=item.location)
     was_warning = log.get_and_reset_warning()
 
@@ -726,6 +807,7 @@ def pytest_runtest_protocol(item, nextitem):
         start_test_section(item)
 
     failure_cleanup = False
+    record_duration = True
     if not was_warning:
         test_list = tests_passed
         msg = 'OK'
@@ -756,6 +838,11 @@ def pytest_runtest_protocol(item, nextitem):
             test_list = tests_skipped
             msg = 'SKIPPED:\n' + str(report.longrepr)
             msg_log = log.status_skipped
+            record_duration = False
+
+    msg += f' {duration} ms'
+    if record_duration:
+        test_durations[item.name] = duration
 
     if failure_cleanup:
         console.drain_console()
-- 
2.43.0

