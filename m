Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD6BE6748D
	for <u-boot@archiver.kernel.org>; Sun, 21 Dec 2025 02:00:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9619A8398D;
	Sun, 21 Dec 2025 02:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sbDITdBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C57883979; Sun, 21 Dec 2025 02:59:18 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBC4F8388D
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 02:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-001-171.46.114.pool.telefonica.de
 [46.114.1.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id C84A2409D9; 
 Sun, 21 Dec 2025 01:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766282355;
 bh=BEHZikxDvGT9hUgBSWfXziIqKD9+DpDJ8RzWsdOiSNQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sbDITdBKa+/I5cNfEQiiixpmefy66VvSdO3D7GQJPiwGBn1QASciv3Zi4Y2EP14ek
 BIKL9YvjbmgvVdRCkPNVr5uQVP0JaOY/6N/TYcCsJKDhmQlwaelMdIY4C0WgmtbOx9
 jXQlP1cFomFprOavYd0J1qTPSl60iPCAaDe6st/uuCNhc70CPk1szryPvfSVs7RyBq
 vtWDVsz90w5SIKqJjP1xmNuRKy6oEmfKFEqEpaHBsrjoPIPMsoFXe/RU77zBIcnoN7
 ULcYvkYJ5hqzbgBq3qimwahQdVRs+yIXoloReLn4ncN0gL9ssw0MmO9viG2YRWRVPb
 iOO5XJ1TpnvAsL3BxoG6Z3yJai+zZAxDeond5/TuWo5nDNLinwqTvHChZPGzPDvHwO
 NCCyCHnnu75PjFsnFvPyWP/v/JvxubzRDw4DqLtHeTlD4wf4YT3xALX0yGb5C5o9aw
 s4u3zJEbpurLJ3IhiG9dfChEfQesfJZLjOGfMnnR2b6Fk9uY6GTsRaPVgj8aKHDyKl
 LtPqaLx4J8BzSsxZnydOSSoVXs9kaCm2WV6CVBspCrUG4yjmjwpuj2KEPXcDtmLtSw
 i1+Eh+UeQNvPCSy5J+bPsu9WJnWvA+QXG9Kb4+QsBu++S/nKBIdD7y1GBmh4LpZeFQ
 Nw+H3kh4EX/loJVez6dNceo8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Yao Zi <me@ziyao.cc>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 8/8] test: clean up test_trace.py code
Date: Sun, 21 Dec 2025 02:58:59 +0100
Message-ID: <20251221015859.738112-9-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
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

* Add module doc string
* Correct sequence of imports
* Correct long exceeding 100 characters
* Remove unused variables
* Remove module level invocation of check_flamegraph
* Add encoding to open() calls

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/py/tests/test_trace.py | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index bbe6dd7de41..fc881a1b7a1 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -2,9 +2,11 @@
 # Copyright 2022 Google LLC
 # Written by Simon Glass <sjg@chromium.org>
 
+"""Tests for the function trace facility"""
+
 import os
-import pytest
 import re
+import pytest
 
 import utils
 
@@ -183,26 +185,25 @@ def check_funcgraph(ubman, fname, proftool, map_fname, trace_dat):
     """
 
     # Generate the funcgraph format
-    out = utils.run_and_log(
-        ubman, [proftool, '-t', fname, '-o', trace_dat, '-m', map_fname,
-               'dump-ftrace', '-f', 'funcgraph'])
+    utils.run_and_log(ubman, [proftool, '-t', fname, '-o', trace_dat, '-m',
+                      map_fname, 'dump-ftrace', '-f', 'funcgraph'])
 
     # Check that the trace has what we expect
     cmd = f'trace-cmd report -l {trace_dat} |head -n 70'
     out = utils.run_and_log(ubman, ['sh', '-c', cmd])
 
     # First look for this:
-    #  u-boot-1     0.....   282.101360: funcgraph_entry:        0.004 us   |    initf_malloc();
+    #  u-boot-1     0.....   282.101360: funcgraph_entry:   0.004 us   |    initf_malloc();
     # ...
-    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |    initf_bootstage() {
-    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |      bootstage_init() {
-    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |        dlmalloc() {
+    #  u-boot-1     0.....   282.101369: funcgraph_entry:              |    initf_bootstage() {
+    #  u-boot-1     0.....   282.101369: funcgraph_entry:              |      bootstage_init() {
+    #  u-boot-1     0.....   282.101369: funcgraph_entry:              |        dlmalloc() {
     # ...
-    #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.001 us   |        }
+    #  u-boot-1     0.....   282.101375: funcgraph_exit:    0.001 us   |        }
     # Then look for this:
-    #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
+    #  u-boot-1     0.....   282.101375: funcgraph_exit:    0.006 us   |      }
     # Then check for this:
-    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    event_init();
+    #  u-boot-1     0.....   282.101375: funcgraph_entry:   0.000 us   |    event_init();
 
     expected_indent = None
     found_start = False
@@ -218,7 +219,7 @@ def check_funcgraph(ubman, fname, proftool, map_fname, trace_dat):
             if found_end:
                 upto = func
                 break
-            elif func == 'initf_bootstage() ':
+            if func == 'initf_bootstage() ':
                 found_start = True
                 expected_indent = indent + '  '
             elif found_start and indent == expected_indent and brace == '}':
@@ -268,9 +269,8 @@ def check_flamegraph(ubman, fname, proftool, map_fname, trace_fg):
     """
 
     # Generate the flamegraph format
-    out = utils.run_and_log(
-        ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
-               'dump-flamegraph'])
+    utils.run_and_log(ubman, [proftool, '-t', fname, '-o', trace_fg, '-m', map_fname,
+                      'dump-flamegraph'])
 
     # Generate the timing graph
     utils.run_and_log(
@@ -279,16 +279,15 @@ def check_flamegraph(ubman, fname, proftool, map_fname, trace_fg):
 
     # Add up all the time spend in initf_dm() and its children
     total = 0
-    with open(trace_fg, 'r') as fd:
+    with open(trace_fg, 'r', encoding='utf-8') as fd:
         for line in fd:
             line = line.strip()
             if line.startswith('initf_dm'):
-                func, val = line.split()
+                _, val = line.split()
                 count = int(val)
                 total += count
     return total
 
-check_flamegraph
 @pytest.mark.slow
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('trace')
-- 
2.51.0

