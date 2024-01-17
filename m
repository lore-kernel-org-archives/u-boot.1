Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76694C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 22:12:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C44768795B;
	Wed, 17 Jan 2024 23:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Uxl01exS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C97E38798C; Wed, 17 Jan 2024 23:12:41 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 962C3876FC
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 23:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6818b86ec67so576616d6.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 14:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705529558; x=1706134358; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FyKvBfB/TmOQJzQ+IIixaZL3h+y46z2a5w7Ute1CT6Q=;
 b=Uxl01exSYns/joAw+tTJtHVidRzoaCJo0paiPn7pxm6nwYlO70IOWCHcd67scIEAEI
 sNNZ4YTF53qgFEr0p8p3YZqYOXYuVY3+8fvPnNmnl94No1mCGJS1ra4H8z8j887sh/v+
 HvAy3o/OCGWdl2KYHyoJN392tX/VpqU1tFttc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705529558; x=1706134358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FyKvBfB/TmOQJzQ+IIixaZL3h+y46z2a5w7Ute1CT6Q=;
 b=Nu9QM9IqS71qxai6rTogIZp46BKFChuSxf/ZDzT8GuDZOi+gKGCVjE14XM+BvzVwBc
 MN+4VWdzV5LBJJJqbN7WyF90XvhDDCC4Gx+Amb8tz9U89JeyfYa+Gd2BcNeTEncZehUd
 6DnGvaTssAbiemq/BIoEuGmUOndI6TVnzVKnlR9KFBHPpGjUMkaH42TDrqea/ulN2441
 R/9oGKr2T0F2ky4Yz24K46LJj+pVvIlWTqwzvbsg4jHuUIQKcUOYjTwzS/LVXSaDA2P4
 NIYHLtg+nt7i1Wq1668PQHahgXOjZOfT+5rGN0gE+mDk+zifdFTxqig0K3iwZdYCLIwA
 IKbg==
X-Gm-Message-State: AOJu0YyMlWcez8nx+DgbV9eJ6Tz01XfS2qjtUmZzJjwv9Vu2r5lENOrf
 oWN1wSx4PZhymHAQo1ev5D2cS/oCUwsszUAHgAniXXv9/OI=
X-Google-Smtp-Source: AGHT+IEpobAXvfkE7aLdq1aFq377CqYYN57zfvYaqTgOD2ASm3+PUVDlW94j7afBj62gX66t6smEcQ==
X-Received: by 2002:a05:6214:29e2:b0:681:78d4:6be8 with SMTP id
 jv2-20020a05621429e200b0068178d46be8mr1800353qvb.43.1705529558019; 
 Wed, 17 Jan 2024 14:12:38 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 cn17-20020ad44a71000000b006817cee3877sm801648qvb.43.2024.01.17.14.12.37
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 14:12:37 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test: test_trace.py: Have trace-cmd report always use -l
Date: Wed, 17 Jan 2024 17:12:36 -0500
Message-Id: <20240117221236.2234826-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117214357.2197351-1-trini@konsulko.com>
References: <20240117214357.2197351-1-trini@konsulko.com>
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

With newer versions of trace-cmd the report subcommand will have
different output from before if we do or do not pass -l. However, with
the -l flag passed our put is consistent here. This updates our regular
expressions and comments for this as well now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Changes in v2:
- Use the -l flag to have consistent output for either version
---
 test/py/tests/test_trace.py | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 28a6e72f525f..7c5696ce747f 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -12,7 +12,7 @@ import u_boot_utils as util
 TMPDIR = '/tmp/test_trace'
 
 # Decode a function-graph line
-RE_LINE = re.compile(r'.*\[000\]\s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
+RE_LINE = re.compile(r'.*0\.\.\.\.\. \s*([0-9.]*): func.*[|](\s*)(\S.*)?([{};])$')
 
 
 def collect_trace(cons):
@@ -113,15 +113,15 @@ def check_function(cons, fname, proftool, map_fname, trace_dat):
     assert val > 50000  # Should be at least 50KB of symbols
 
     # Check that the trace has something useful
-    cmd = f"trace-cmd report {trace_dat} |grep -E '(initf_|initr_)'"
+    cmd = f"trace-cmd report -l {trace_dat} |grep -E '(initf_|initr_)'"
     out = util.run_and_log(cons, ['sh', '-c', cmd])
 
     # Format:
-    # unknown option 14
-    #      u-boot-1     [000]    60.805596: function:             initf_malloc
-    #      u-boot-1     [000]    60.805597: function:             initf_malloc
-    #      u-boot-1     [000]    60.805601: function:             initf_bootstage
-    #      u-boot-1     [000]    60.805607: function:             initf_bootstage
+    #      u-boot-1     0.....    60.805596: function:             initf_malloc
+    #      u-boot-1     0.....    60.805597: function:             initf_malloc
+    #      u-boot-1     0.....    60.805601: function:             initf_bootstage
+    #      u-boot-1     0.....    60.805607: function:             initf_bootstage
+
     lines = [line.replace(':', '').split() for line in out.splitlines()]
     vals = {items[4]: float(items[2]) for items in lines if len(items) == 5}
     base = None
@@ -161,21 +161,21 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
                'dump-ftrace', '-f', 'funcgraph'])
 
     # Check that the trace has what we expect
-    cmd = f'trace-cmd report {trace_dat} |head -n 70'
+    cmd = f'trace-cmd report -l {trace_dat} |head -n 70'
     out = util.run_and_log(cons, ['sh', '-c', cmd])
 
     # First look for this:
-    #  u-boot-1     [000]   282.101360: funcgraph_entry:        0.004 us   |    initf_malloc();
+    #  u-boot-1     0.....   282.101360: funcgraph_entry:        0.004 us   |    initf_malloc();
     # ...
-    #  u-boot-1     [000]   282.101369: funcgraph_entry:                   |    initf_bootstage() {
-    #  u-boot-1     [000]   282.101369: funcgraph_entry:                   |      bootstage_init() {
-    #  u-boot-1     [000]   282.101369: funcgraph_entry:                   |        dlmalloc() {
+    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |    initf_bootstage() {
+    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |      bootstage_init() {
+    #  u-boot-1     0.....   282.101369: funcgraph_entry:                   |        dlmalloc() {
     # ...
-    #  u-boot-1     [000]   282.101375: funcgraph_exit:         0.001 us   |        }
+    #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.001 us   |        }
     # Then look for this:
-    #  u-boot-1     [000]   282.101375: funcgraph_exit:         0.006 us   |      }
+    #  u-boot-1     0.....   282.101375: funcgraph_exit:         0.006 us   |      }
     # Then check for this:
-    #  u-boot-1     [000]   282.101375: funcgraph_entry:        0.000 us   |    initcall_is_event();
+    #  u-boot-1     0.....   282.101375: funcgraph_entry:        0.000 us   |    initcall_is_event();
 
     expected_indent = None
     found_start = False
@@ -203,7 +203,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
 
     # Now look for initf_dm() and dm_timer_init() so we can check the bootstage
     # time
-    cmd = f"trace-cmd report {trace_dat} |grep -E '(initf_dm|dm_timer_init)'"
+    cmd = f"trace-cmd report -l {trace_dat} |grep -E '(initf_dm|dm_timer_init)'"
     out = util.run_and_log(cons, ['sh', '-c', cmd])
 
     start_timestamp = None
-- 
2.34.1

