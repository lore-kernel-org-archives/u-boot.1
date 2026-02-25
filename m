Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C00EFD45FA
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 22:52:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8819B83E61;
	Wed, 25 Feb 2026 23:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DxJ10lFf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDA1483EC6; Wed, 25 Feb 2026 23:51:31 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD18982A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 23:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8cb7edbcde6so13787485a.3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772059888; x=1772664688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af5c0Evlq0NDLYgfmXBbtUpAa6gQOSDS1q7ztTqxqM0=;
 b=DxJ10lFfwItqS0qFaOhWZybAnWbcqU6JaxoGqiS6NjqR0D8Oj3JXp4s8YGTsHWfGgA
 3pWhkKbjkgIGQWpC3nkPNQJ4OgoVCjXtTPugxb77crfZ2h5EclC8Pj88+zCfUApKaHjb
 7yx7LpV+TFY6iW154XRxGbYzK0bj+N1wdmf7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772059888; x=1772664688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=af5c0Evlq0NDLYgfmXBbtUpAa6gQOSDS1q7ztTqxqM0=;
 b=pZ27TFxGO5PZ2qmk3PeXWLo7aoxRw6nq2K5QLD5KmZBaln/lh8fbHLAEDNkDg90Orm
 wUTQnV7h3IipLR1cEKFQ84kSw5ljbWdAtGsRAAiaX2pVyPmTn1H3QKw8sNV/ZICQHppN
 zJXCuB06nUm/6TBQb7vB1JYWtPlH8elwUwpsawA6vfdE6k5Gv/m1c1lWg2pZTSjI1BsG
 KLff7oxdJPQ6BEycp4pZB+flgBUZULB/dNkQvfpqvGIt6zZzAwje7PYcvvl41np2oaaD
 zO59EC5pNS7MRum8PR1cNk7mqC/Fn2bB70OjrOh3KUgOLE+m72iKRTQi0XUjNwDlz/br
 YH1g==
X-Gm-Message-State: AOJu0YxVXejh8EEiZ0Io3/VDHJICnkyRUBA1S5dn7rrBfky9oXtpLM4X
 A+KJnrZ3EJ+PRufgFQzrrRCIYvPL5rwfrBTMvHLQZJJiKtipgEUR59UUJo+3++M5WP+13inORRC
 UsWY=
X-Gm-Gg: ATEYQzzdpj810IV8g52CQ2Xta2X7HdiZtS81BYzjeIBCG5X33GIqTbnt5JbgPZcUmnS
 qkB0oIAF4dWlBwswm7DpcxmPYlTvvU+yyc9CEx8QVwr2BmeF07s11Un3Sh5U6++Li2wOZ9T9ZqU
 q6tY5Ll/rDnBSozNQyLj87rjKpSFsW5jvOL7reezrShBFVcDQBgg1pxGYqXsQuI7fj5vGlW2Kv2
 PIsu0f+eq11bHQUKkksaxlp8iKL65LXMbykEgXoRIMnhXmgSQumwEcbVTdPKD1k17a61FdtjtKp
 U95rAaqoLVQKxtyrTA/MrIBnFOe/6oHwz+QqtA1vGW83s5/rYwKfb4/8BuhMUHFXITs50UbL4JO
 iXw/ZggNYtAc6aWnY3AWrtLpUO2dQFKfzWWcgdh0ej6ucS3VXG0zGTRrNcBTRAo/smAUHlFM1r3
 6MbUIIGwXgx/Akfs/2NBe9cesRcsvi
X-Received: by 2002:a05:620a:4892:b0:8c6:a72f:fd56 with SMTP id
 af79cd13be357-8cbc112ba1dmr2716085a.29.1772059887904; 
 Wed, 25 Feb 2026 14:51:27 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf72e21bsm43730985a.44.2026.02.25.14.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 14:51:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <simon.glass@canonical.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] binman: Drop the allow_failures parameter from
 run_test_coverage()
Date: Wed, 25 Feb 2026 15:50:35 -0700
Message-ID: <20260225225040.2568118-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225225040.2568118-1-sjg@chromium.org>
References: <20260225225040.2568118-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The allow_failures parameter in run_test_coverage() is no longer used
by any caller.

Drop it.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 tools/u_boot_pylib/test_util.py | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index d258a1935c9..364596d7a0c 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -24,7 +24,7 @@ except:
 
 def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
                       required=None, extra_args=None, single_thread='-P1',
-                      args=None, allow_failures=None):
+                      args=None):
     """Run tests and check that we get 100% coverage
 
     Args:
@@ -95,19 +95,6 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
         print('Coverage error: %s, but should be 100%%' % coverage)
         ok = False
     if not ok:
-        if allow_failures:
-            # for line in lines:
-                # print('.', line, re.match(r'^(tools/.*py) *\d+ *(\d+) *(\d+)%$', line))
-            lines = [re.match(r'^(tools/.*py) *\d+ *(\d+) *\d+%$', line)
-                     for line in stdout.splitlines()]
-            bad = []
-            for mat in lines:
-                if mat and mat.group(2) != '0':
-                    fname = mat.group(1)
-                    if fname not in allow_failures:
-                        bad.append(fname)
-            if not bad:
-                return
         raise ValueError('Test coverage failure')
 
 
-- 
2.43.0

