Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6276CE8379
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B9898905C;
	Mon, 30 Sep 2024 20:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W1Kl7iC6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2AB38904C; Mon, 30 Sep 2024 20:51:49 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C23F889021
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:51:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82ab349320fso197439439f.1
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722306; x=1728327106; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECbWg51i9WXQVdA5QjYH65IvNhmltS3gENq9T+KTr8g=;
 b=W1Kl7iC6BVw7+W1Bb2xvFEd4HDdUlkqa404G02FZsmOv2G4dBU9clfpdz5oCw8lQKS
 4IniYbMQOs5Qlnuh/OGzYcVzPuFWxhFdM/Rpc6x/mY5H1gLdyG4vDfO2vERmQ/Pskehr
 fhjYvfiZD+h6c4XlAnbLoTRK0NB+idzeDOulo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722306; x=1728327106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECbWg51i9WXQVdA5QjYH65IvNhmltS3gENq9T+KTr8g=;
 b=CxCZftgfj49+WD4oPeYzWtq6X61ownCsEp4BWs87tNLotenzHHaQA5OfZmmKeUm0sf
 vBg7egsLos87OsOohO4bTUd8uhhEfd+4DI2jpL9TzBi9u/VnWuZiAex+0HC+/n8FORjH
 UuFXXDyJW4si760Tn0lbYwbTpXzrhzLVl2SZB6VvSb4nPQHRsc7GbsTI6xAlOzxPsRVG
 QjeGepata0nz6zc2jCboMnMXNll6Kf4r2v8YLP2y0f3vbEJSZBjMGHEf1raEEDuTl1Qh
 okQJlQIcpxQ2XHnXFYOFr2lcjJghQBoY2uQlneHO0i6mDL7PQH3G8EMzbBHKs2EfnmDz
 HxRQ==
X-Gm-Message-State: AOJu0Yw2FWxX6c3yyGRgvju2Ia9l0/YwfWEGS3ucP8INQtDLNQO9SLZH
 fA1gbquscmMIuhzUqcU58LdX9JXQ3GOWb+F06T5DjilP0LcwnO9DYVITNyIR8EVc9eUKYq9+5Bj
 5Xg==
X-Google-Smtp-Source: AGHT+IHwmXHhvcCs5xPP41ilncQVarNdYICD0t87QNnOruUis6Cb4bmuuL9qqZKKv8C3oav+x4oBkA==
X-Received: by 2002:a05:6602:2c01:b0:82c:f43f:bafe with SMTP id
 ca18e2360f4ac-834931e59e1mr1364803339f.8.1727722306326; 
 Mon, 30 Sep 2024 11:51:46 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d888849b68sm2239195173.59.2024.09.30.11.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Sep 2024 11:51:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 2/3] binman: Support getting test-coverage on just one test
Date: Mon, 30 Sep 2024 12:51:37 -0600
Message-Id: <20240930185139.2185983-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930185139.2185983-1-sjg@chromium.org>
References: <20240930185139.2185983-1-sjg@chromium.org>
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

Pass the arguments through to test_util so that a single test can be
used.

Update the docs and add some missing backquotes in the same section.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst | 5 ++++-
 tools/binman/main.py    | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index f9a3a42183b..c25914312a8 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -2099,12 +2099,15 @@ Code coverage
 -------------
 
 Binman is a critical tool and is designed to be very testable. Entry
-implementations target 100% test coverage. Run 'binman test -T' to check this.
+implementations target 100% test coverage. Run ``binman test -T`` to check this.
 
 To enable Python test coverage on Debian-type distributions (e.g. Ubuntu)::
 
    $ sudo apt-get install python-coverage python3-coverage python-pytest
 
+You can also check the coverage provided by a single test, e.g.::
+
+   binman test -T testSimple
 
 Exit status
 -----------
diff --git a/tools/binman/main.py b/tools/binman/main.py
index dc817ddcd42..619840e7d55 100755
--- a/tools/binman/main.py
+++ b/tools/binman/main.py
@@ -85,7 +85,7 @@ def RunTests(debug, verbosity, processes, test_preserve_dirs, args, toolpath):
 
     return (0 if result.wasSuccessful() else 1)
 
-def RunTestCoverage(toolpath, build_dir):
+def RunTestCoverage(toolpath, build_dir, args):
     """Run the tests and check that we get 100% coverage"""
     glob_list = control.GetEntryModules(False)
     all_set = set([os.path.splitext(os.path.basename(item))[0]
@@ -97,7 +97,7 @@ def RunTestCoverage(toolpath, build_dir):
     test_util.run_test_coverage('tools/binman/binman', None,
             ['*test*', '*main.py', 'tools/patman/*', 'tools/dtoc/*',
              'tools/u_boot_pylib/*'],
-            build_dir, all_set, extra_args or None)
+            build_dir, all_set, extra_args or None, args=args)
 
 def RunBinman(args):
     """Main entry point to binman once arguments are parsed
@@ -117,7 +117,7 @@ def RunBinman(args):
 
     if args.cmd == 'test':
         if args.test_coverage:
-            RunTestCoverage(args.toolpath, args.build_dir)
+            RunTestCoverage(args.toolpath, args.build_dir, args.tests)
         else:
             ret_code = RunTests(args.debug, args.verbosity, args.processes,
                                 args.test_preserve_dirs, args.tests,
-- 
2.34.1

