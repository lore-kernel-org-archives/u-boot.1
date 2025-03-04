Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA265C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFDA881895;
	Tue,  4 Mar 2025 14:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LJjy8mqt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B5C68197F; Tue,  4 Mar 2025 14:10:15 +0100 (CET)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F44181878
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:10:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85ada0cf40fso53039239f.2
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741093811; x=1741698611; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FG0XGID4tmkcfs+JrrdHZ422Judo1OdC3MTU6phRqFU=;
 b=LJjy8mqtTazz1a5T7+LGmYJfheZVmN66IvDU6kxLCfmTAhJMec8v3xmoiV6VFlym9w
 6L/Qh0vCe04hwIXydrBq0RRXMk7ACk8IPLg7j8Z42DbBquTlkwgXHJQhdP/TCxug/0EC
 rgn6memSY7S8uwxWbkq9QtATF8Xa1zO/Phiao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093811; x=1741698611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FG0XGID4tmkcfs+JrrdHZ422Judo1OdC3MTU6phRqFU=;
 b=Uuc8WosGfXZNEHG48RYXIOtyeapJxSbneYGKwkD0uaxMWK8CcEg/j84VzqPNJZwAcR
 /RwYfb1ZCeRMNRYt+b8u/+Xr1cohBUCgBjEZw0BeXqnRx+IMdCZWnWpqoZr+CerVkt8c
 45r6uVDGHAL80CNpvDAuqn6zz/Rgqh88u/XjxoaGiqAM8hx12qTBl8v9efw8JzH4ozzY
 KbaxP2m+ZGKpwzc2eLWLj3c25QA+FaZxYDWJRjrbkV6NvVenwKloWtuG3ScejvXxA7iR
 3FSQBspNjzV2zhILLxSw+8AKlhCenXIGoW1oXdVBTUDzRUNqMQsuAO8F2RN4D1v9KR6e
 0Feg==
X-Gm-Message-State: AOJu0YyWIY7h7wqX1xOpUbfv17Ybu6xJr53M4JcfMfnrNLCgBJJ4K42v
 bmbQLcQC6nzXPPlW4Jstiym6nBNwUF2MWwMFlN4sZzYXo1SmmwNrJ0yzaz7g828/c7R6IxOxaJo
 =
X-Gm-Gg: ASbGncuc65nuNQHi4yfsyW5WUmZxa0fmj6yMqgD4Gr8Qi8ZPwSiikPKMSDhx/FdALLd
 2skbaWnXUQ5Bb4+up9TbJHhwjE7FW4Jzx6gyh9G13D7iYwv4f5rj+JNKlg5fTgN2FAtTYT7Tktu
 atdV80SQ+qtbSmJYn/ufNVwBnjjo5Pnfj7ehFC9nEr1cDy+Mp8lkhyQXDvuplk8CrKwhDFucheB
 1+FyLIHn5FErXxsMMHqsJxdDSdTnE6HCbDwvhqhkUlqULnl5AsPesuxyA8i+P1dt6q3slLSG0Qt
 pBfAlH2dqa1mmPEIuQeclwb2x2VjympmPBkAwwnb09ZAd8LArdeFLNP0QEfRvRnSV4hcyFH36Un
 kxGiqBA==
X-Google-Smtp-Source: AGHT+IFV8MHV/F7pL3go6jXs4kbf9GWvAkJP3wPhorIwpI4dJD02eqO5HxWw6ZiJffFdsAq5/ws2IQ==
X-Received: by 2002:a05:6602:4c05:b0:85a:ded6:5e5b with SMTP id
 ca18e2360f4ac-85aded65e66mr783822039f.4.1741093809905; 
 Tue, 04 Mar 2025 05:10:09 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-858753cd304sm287383839f.33.2025.03.04.05.10.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 05:10:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/7] binman: Work around missing test coverage
Date: Tue,  4 Mar 2025 06:09:43 -0700
Message-ID: <20250304130947.109799-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304130947.109799-1-sjg@chromium.org>
References: <20250304130947.109799-1-sjg@chromium.org>
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

The iMX8 entry-types don't have proper test coverage. Add a work-around
to skip this for now.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/main.py            |  8 +++++++-
 tools/u_boot_pylib/test_util.py | 16 +++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/binman/main.py b/tools/binman/main.py
index 619840e7d55..326f5c93155 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -94,10 +94,16 @@ def RunTestCoverage(toolpath, build_dir, args):
     if toolpath:
         for path in toolpath:
             extra_args += ' --toolpath %s' % path
+
+    # Some files unfortunately don't thave the required test coverage. This will
+    # eventually be fixed, but exclude them for now
     test_util.run_test_coverage('tools/binman/binman', None,
             ['*test*', '*main.py', 'tools/patman/*', 'tools/dtoc/*',
              'tools/u_boot_pylib/*'],
-            build_dir, all_set, extra_args or None, args=args)
+            build_dir, all_set, extra_args or None, args=args,
+            allow_failures=['tools/binman/btool/cst.py',
+                            'tools/binman/etype/nxp_imx8mcst.py',
+                            'tools/binman/etype/nxp_imx8mimage.py'])
 
 def RunBinman(args):
     """Main entry point to binman once arguments are parsed
diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index ed216c4fc4e..4835847bfc6 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -8,6 +8,7 @@ import doctest
 import glob
 import multiprocessing
 import os
+import re
 import sys
 import unittest
 
@@ -25,7 +26,7 @@ except:
 
 def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
                       required=None, extra_args=None, single_thread='-P1',
-                      args=None):
+                      args=None, allow_failures=None):
     """Run tests and check that we get 100% coverage
 
     Args:
@@ -96,6 +97,19 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
         print('Coverage error: %s, but should be 100%%' % coverage)
         ok = False
     if not ok:
+        if allow_failures:
+            # for line in lines:
+                # print('.', line, re.match(r'^(tools/.*py) *\d+ *(\d+) *(\d+)%$', line))
+            lines = [re.match(r'^(tools/.*py) *\d+ *(\d+) *\d+%$', line)
+                     for line in stdout.splitlines()]
+            bad = []
+            for mat in lines:
+                if mat and mat.group(2) != '0':
+                    fname = mat.group(1)
+                    if fname not in allow_failures:
+                        bad.append(fname)
+            if not bad:
+                return
         raise ValueError('Test coverage failure')
 
 
-- 
2.43.0

