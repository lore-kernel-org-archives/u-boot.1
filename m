Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280A6C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 21:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BBA48798F;
	Wed, 17 Jan 2024 22:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bhQY0mhp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489E087994; Wed, 17 Jan 2024 22:44:02 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18BD48798C
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 22:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-68185ec3b7cso3708866d6.2
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705527838; x=1706132638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=XsA1dAinVPucj8h5ak2LRsOUcacwxL6oKGMYocwwHb4=;
 b=bhQY0mhpGhZXwkWmiCZEP+4kz8YCS5g963I0VkzKd6wazZ/TBJPSK+INm0Mk+s2E1d
 ZtPFURwYFcrEx/wbkhQlo+0hU4C3CZFdsrGNjQJLSzszjU4bZ6OL+xu6F/TFw97LIsHU
 BjIPOTjqIm7qXHxpVRjdKVQWD8vpscWCofFV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705527838; x=1706132638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XsA1dAinVPucj8h5ak2LRsOUcacwxL6oKGMYocwwHb4=;
 b=JX2TSdKURKfQTEvbLjGSXHTwzy510fFvrRKvZcqJSmxzJjH6oPhRP2H4QqUogpdqzd
 Gfh+Eudn6D9X9W0K21ligL0WDjPH9piD/KiNtckOv/gcERDinDLvNG5Rd5U73/aVHRmV
 FWO2pH2x5pU0vlrpnVAeQHGLQhSPT6HaZLptLqt6iTD9gZQvm4ASMR9182Bn5YWQb/Kf
 9BVyfiXLI2aVPOxk/E5prk/+BCMSdtqLaEY22EhnqjYs6orc7oZr/n4aQRw7u2ECy8QQ
 SJwFtQUnae4LngBKBv9F7hkMWSTmWzrGfArh/3oEvJbNomgN70TROhkeHdf6sVpsXfWu
 qmCA==
X-Gm-Message-State: AOJu0Yw76BFEF60gkwBRraOnGqBssqaY5TwJKzZRkDb34KidngAwpXUP
 DDqHt773VLLWTkg+Dh7XLsXOoef0WCtzWE+NBnAPrrmfce4=
X-Google-Smtp-Source: AGHT+IEErIXsvCoXJ2lGi2c7om0Ufy9HLkces+8vQ90Ej/GaPg75yFNA9SwD3xeOjaZLgRe4k1UGRg==
X-Received: by 2002:a05:6214:e4b:b0:681:781f:67c5 with SMTP id
 o11-20020a0562140e4b00b00681781f67c5mr2810595qvc.5.1705527838641; 
 Wed, 17 Jan 2024 13:43:58 -0800 (PST)
Received: from bill-the-cat..
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 o9-20020a0ce409000000b0067f812c4a58sm628386qvl.60.2024.01.17.13.43.58
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 13:43:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test: test_trace.py: Handle newer trace-cmd report formats
Date: Wed, 17 Jan 2024 16:43:57 -0500
Message-Id: <20240117214357.2197351-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

With newer versions of trace-cmd we have another column in the report
that we need to handle. We don't care about it, so just use a regex to
remove it from the output that we then parse.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_trace.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index 28a6e72f525f..9cb5aa939c55 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -117,12 +117,17 @@ def check_function(cons, fname, proftool, map_fname, trace_dat):
     out = util.run_and_log(cons, ['sh', '-c', cmd])
 
     # Format:
-    # unknown option 14
     #      u-boot-1     [000]    60.805596: function:             initf_malloc
     #      u-boot-1     [000]    60.805597: function:             initf_malloc
     #      u-boot-1     [000]    60.805601: function:             initf_bootstage
     #      u-boot-1     [000]    60.805607: function:             initf_bootstage
-    lines = [line.replace(':', '').split() for line in out.splitlines()]
+    # OR:
+    #      u-boot-1     [000] .....    60.805596: function:             initf_malloc
+    #      u-boot-1     [000] .....    60.805597: function:             initf_malloc
+    #      u-boot-1     [000] .....    60.805601: function:             initf_bootstage
+    #      u-boot-1     [000] .....    60.805607: function:             initf_bootstage
+
+    lines = [re.sub(r'(:|\.\.\.\.\.)', '', line).split() for line in out.splitlines()]
     vals = {items[4]: float(items[2]) for items in lines if len(items) == 5}
     base = None
     max_delta = 0
@@ -176,6 +181,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     #  u-boot-1     [000]   282.101375: funcgraph_exit:         0.006 us   |      }
     # Then check for this:
     #  u-boot-1     [000]   282.101375: funcgraph_entry:        0.000 us   |    initcall_is_event();
+    # And this all may be '[000] .....    282.' instead.
 
     expected_indent = None
     found_start = False
@@ -185,7 +191,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     # Look for initf_bootstage() entry and make sure we see the exit
     # Collect the time for initf_dm()
     for line in out.splitlines():
-        m = RE_LINE.match(line)
+        m = RE_LINE.match(re.sub(r'\.\.\.\.\.', '', line))
         if m:
             timestamp, indent, func, brace = m.groups()
             if found_end:
@@ -209,7 +215,7 @@ def check_funcgraph(cons, fname, proftool, map_fname, trace_dat):
     start_timestamp = None
     end_timestamp = None
     for line in out.splitlines():
-        m = RE_LINE.match(line)
+        m = RE_LINE.match(re.sub(r'\.\.\.\.\.', '', line))
         if m:
             timestamp, indent, func, brace = m.groups()
             if func == 'initf_dm() ':
-- 
2.34.1

