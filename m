Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72102CCFA16
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:51:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D40884D2;
	Mon, 30 Sep 2024 20:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cMCKdAS7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31B99874AC; Mon, 30 Sep 2024 20:51:47 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5831D884D2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:51:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-3a344f92143so21797115ab.2
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722303; x=1728327103; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vOrTARVdJcTf8saMhhpSrDDm9EIjjH22Xwy4kD06JQ4=;
 b=cMCKdAS7Lweq3rVbeQzxc3Hk/P4Sa0xEm1YolvD2dWOZsBTlNF0bDaP89vSHzaXZx1
 fgx88i31w55klWOZ1cZxGFBWj7qJK9ADerFj2tBHv1wtPEj2exPs/5EVfyGByRydGD6N
 Yu4INX6btLqar3T7AOy2vN+jaB6BLCZMQ0e9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722303; x=1728327103;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOrTARVdJcTf8saMhhpSrDDm9EIjjH22Xwy4kD06JQ4=;
 b=bol29GpAhtG0gDUgnt+T09gzW46joie4P4PU9IGiPpVd5m+HfbYrcIhxMJMS6kpyuo
 FkhPIOau0y0k6/heMiReKF1jLsvhohs5nIGzJnKBCrgIxTNVQjMnSVw8Tjy5q7XNxjNJ
 EzKZp5PA2dlHumviMethtRPdwCIktfk2IH9p1uTFAHzsWpJs4pU3vi354dZl+kg3FuW1
 C3A6nKONRlPOS5HjgIACyrwnWS8x6r0F0aerlYWsAioOb3f9NpLoAOppAGkiQvCjN6TI
 qLIEQ0rsBqz++CiH9/HCbh7+Ww7XFZ7pv4WwxgNS2hKnSjZeGrCZnf0pq0yGTBS9hNi8
 7StQ==
X-Gm-Message-State: AOJu0YwqzmA8W4qjffJ+olQ2nffrXILa1Ro6Kz5Zr0jrQMwU7TEUl1YI
 AR1nxrxBGhnOZCrBSr+30EcyV71oOgNBR55VaLcZtS/2nyuPAOhgJYVpTYNb8WX868vQWikpHkB
 0XA==
X-Google-Smtp-Source: AGHT+IHmlnOGO/qGZiW6ZrZYL4yu3imn/EaK6sAqEFg74jnWYMjV8AvFvHT4csmAkF28itJr3sthUw==
X-Received: by 2002:a05:6e02:1569:b0:39d:4c8a:370d with SMTP id
 e9e14a558f8ab-3a3451b6941mr118501015ab.18.1727722302836; 
 Mon, 30 Sep 2024 11:51:42 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888849b68sm2239195173.59.2024.09.30.11.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 11:51:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/3] u_boot_pylib: Support running coverage on selected
 functions
Date: Mon, 30 Sep 2024 12:51:36 -0600
Message-Id: <20240930185139.2185983-1-sjg@chromium.org>
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

At present run_test_coverage() assumes you want code coverage for the
entire code base. This is the normal situation, but sometimes it is
useful to see the coverage provided by just a single test. Add support
for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/test_util.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index 857ce58c98c..dd671965263 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -23,8 +23,9 @@ except:
     use_concurrent = False
 
 
-def run_test_coverage(prog, filter_fname, exclude_list, build_dir, required=None,
-                    extra_args=None, single_thread='-P1'):
+def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
+                      required=None, extra_args=None, single_thread='-P1',
+                      args=None):
     """Run tests and check that we get 100% coverage
 
     Args:
@@ -42,6 +43,7 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir, required=None
         single_thread (str): Argument string to make the tests run
             single-threaded. This is necessary to get proper coverage results.
             The default is '-P0'
+        args (list of str): List of tests to run, or None to run all
 
     Raises:
         ValueError if the code coverage is not 100%
@@ -66,9 +68,10 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir, required=None
                'coverage')
 
     cmd = ('%s%s run '
-           '--omit "%s" %s %s %s %s' % (prefix, covtool, ','.join(glob_list),
-                                        prog, extra_args or '', test_cmd,
-                                        single_thread or '-P1'))
+           '--omit "%s" %s %s %s %s %s' % (prefix, covtool, ','.join(glob_list),
+                                           prog, extra_args or '', test_cmd,
+                                           single_thread or '-P1',
+                                           ' '.join(args) if args else ''))
     os.system(cmd)
     stdout = command.output(covtool, 'report')
     lines = stdout.splitlines()
-- 
2.34.1

