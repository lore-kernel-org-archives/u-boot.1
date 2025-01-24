Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79ABEC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 18:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4F1A80ADB;
	Fri, 24 Jan 2025 19:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ebjNbjrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FD1A80ADC; Fri, 24 Jan 2025 19:56:15 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A7080A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 19:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3cfae81ab24so6785345ab.3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737744971; x=1738349771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EwWtb+YHUyHs1sjFW0etIOrjsfyzHSEm8SmYmkLbtPY=;
 b=ebjNbjrds93O4D9sCoiHFkUfbOhiVdPQYvLkfPv5GqcARHpBjvhYrTrCnrZhx3ZW0y
 zAVP0RZzYK0+FD9J0UWLU5D+tG1YldWdLj6C6ntNNnCetnbr2M7bWB+qnPPuEBKH0XT/
 s9KS4VCVLnH61yfi1AsSA38ld1TwVj7BzRkFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737744971; x=1738349771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EwWtb+YHUyHs1sjFW0etIOrjsfyzHSEm8SmYmkLbtPY=;
 b=bVDQm+gzQ6WsuZFD2ZCDGQA0MVhGxgZp+gj5fQvDKasJVEDE7PdUSGjzIeWPItu8OA
 3t4MrYIt/8+MRRLZNx9lALMq9SwuZ0ZwP2FBhY4tk2UcpwhQzPeoei25fNi16ea2gxvF
 vwcCT18u7R8AkPVibBg5jszRBnHm4tpzjdB7L6CLBd43pNvRZDgSaXXh1OlNVCw281d4
 CsXohKnw0q+annMe7l/AZ1nzRPE0Mtd9vFhe+ldsgpX1hfITlomrQDqlxG/5QFSyL657
 EicmqMdzLlQarkc/xBVcWi63LHPUrZc0vJO19J8hfooyTQKCFm6kqcb/lvRJZZaRTA3H
 jOhQ==
X-Gm-Message-State: AOJu0Ywc++zRHBvC5alWrSmqdbi8qDvKHybwG4pTfdwP7Jw3d+B0PKuC
 qZTw0jND+SrvKZ57HUjEKEddY1smMIV2I6/J2KVFxKtzdc16INnQcNit/qJwSUimrVJOervbf/c
 =
X-Gm-Gg: ASbGncsZhyQks1gETZkeEUuhNBpb2YmPXzHP8kcUtjJgC+TjeSu8+uC4qFS1cMYzqsu
 g5b51kr+bKZe8CBzwfiNvTuKnQ732T0t66DN1PwDM0HCld/T24new9jb8F32d0STPGXCZ87nidF
 zzFtOVl1QP9awKvUFXraWnptTgWPTnMMzkbEkRNTOuyht2xSJ5xV9szEC0TLO5jiXz2gcVtN0ik
 466eb1pBxP80Rp0XieprF/EIGqIMamY1mD4bMzLb/rI4xccYZJ32sbM24ANVVFhLmUStaS2+Vz6
 Plcx+uJh40IFes7kDFGq8/4JwckldZlQ0lr13O/6IQ==
X-Google-Smtp-Source: AGHT+IH5SNIfHfIfHgL5LQfFcXcQuvSAlOmap/7VjRvaEUetQUY8qpbOvEMTTvTOfa38OSHaKnXN6w==
X-Received: by 2002:a05:6e02:221d:b0:3ce:78e5:d36d with SMTP id
 e9e14a558f8ab-3cf744199c7mr283696995ab.12.1737744970698; 
 Fri, 24 Jan 2025 10:56:10 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da03a02sm766220173.27.2025.01.24.10.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 10:56:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] test/py: Add a report show test durations
Date: Fri, 24 Jan 2025 11:56:04 -0700
Message-ID: <20250124185605.372347-1-sjg@chromium.org>
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

Execution time varies widely with the existing tests. Provides a summary
of the time taken for each test, along with a histogram.

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

 test/py/conftest.py | 77 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 3bd333bfd24..a245f32dc8a 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -25,6 +25,7 @@ import re
 from _pytest.runner import runtestprotocol
 import subprocess
 import sys
+import time
 from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Globals: The HTML log file, and the connection to the U-Boot console.
@@ -516,6 +517,12 @@ tests_skipped = []
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
 
@@ -531,6 +538,67 @@ def pytest_itemcollected(item):
 
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
+    def show_bar(key, value):
+        """Show a single bar (line) of the histogram
+
+        Args:
+            key (str): Key to write on the left
+            value (int): Value to display, i.e. the relative length of the bar
+        """
+        if value:
+            bar_length = int((value / max_count) * max_bar_length)
+            print(f"{key:>8} : {'#' * bar_length} {value}", file=buf)
+
+    # Create the buckets we will use
+    bucket = {}
+    for power in range(5):
+        for i in [1, 2, 3, 4, 5, 7.5]:
+            bucket[i * 10 ** power] = 0
+    max_dur = max(bucket.keys())
+
+    # Collect counts for each bucket; if outside the range, add to too_long
+    # Also show a sorted list of test timings from longest to shortest
+    too_long = 0
+    with log.section('Timing Report', 'timing_report'):
+        for name, dur in sorted(test_durations.items(), key=lambda kv: kv[1],
+                                reverse=True):
+            log.info(f'{get_time_delta(dur):>8}  {name}')
+            greater = [k for k in bucket.keys() if dur <= k]
+            if greater:
+                bucket[min(greater)] += 1
+            else:
+                too_long += 1
+
+    # Set the maximum length of a histogram bar, in characters
+    max_bar_length = 40
+
+    # Show a a summary with histogram
+    buf = io.StringIO()
+    with log.section('Timing Summary', 'timing_summary'):
+        print('Duration : Number of tests', file=buf)
+        print(f'{"=" * 8} : {"=" * max_bar_length}', file=buf)
+        max_count = max(bucket.values())
+        for dur, count in bucket.items():
+            if count:
+                label = get_time_delta(dur)
+                show_bar(f'<{label}', count)
+        if too_long:
+            show_bar(f'>{get_time_delta(max_dur)}', too_long)
+    log.info(buf.getvalue())
+    print(buf.getvalue(), end='')
+
+
 def cleanup():
     """Clean up all global state.
 
@@ -580,6 +648,7 @@ def cleanup():
                 for test in tests_not_run:
                     anchor = anchors.get(test, None)
                     log.status_fail('... ' + test, anchor)
+        show_timings()
         log.close()
 atexit.register(cleanup)
 
@@ -713,7 +782,9 @@ def pytest_runtest_protocol(item, nextitem):
     log.get_and_reset_warning()
     ihook = item.ihook
     ihook.pytest_runtest_logstart(nodeid=item.nodeid, location=item.location)
+    start = time.monotonic()
     reports = runtestprotocol(item, nextitem=nextitem)
+    duration = round((time.monotonic() - start) * 1000, 1)
     ihook.pytest_runtest_logfinish(nodeid=item.nodeid, location=item.location)
     was_warning = log.get_and_reset_warning()
 
@@ -726,6 +797,7 @@ def pytest_runtest_protocol(item, nextitem):
         start_test_section(item)
 
     failure_cleanup = False
+    record_duration = True
     if not was_warning:
         test_list = tests_passed
         msg = 'OK'
@@ -756,6 +828,11 @@ def pytest_runtest_protocol(item, nextitem):
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

