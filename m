Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FB9C71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 15:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E51B386915;
	Mon,  4 Sep 2023 17:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jLs2crOg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3A5786960; Mon,  4 Sep 2023 17:55:09 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3E7D864A7
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 17:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34f0fd5f871so4081315ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693842905; x=1694447705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s8D1LzX5QtQ4fVaes115LJ+nWAlm0Reu/CDvtuNSULI=;
 b=jLs2crOghs53BUgz/d1D3YqcTDz2TWfi+oKubL5mNuPfb1bjp3FzVwG1d4XRTZyM4g
 zAEb+vYJXKzb/tEyrP8kvm9a3a4QeBFp532iBOhYmeMzU84deNZeW4y5Z0hxTyck+nOK
 ZvwOecXiT4rmwOlcKV7OT64J+/UJj2XCx3Cs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693842905; x=1694447705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s8D1LzX5QtQ4fVaes115LJ+nWAlm0Reu/CDvtuNSULI=;
 b=QL1rqR5Ul5ARDw1zbtkUmwIx+CZOJUQ0hd4opL27k4wGm7xF5BXBn8VzGuh2LmHbAl
 2gdux+hAwQjyz8/aZxiNvVsi9RVBDCDBWp6v/ygc766qZzFWdZYvdABRdfQ7MCieE7lF
 btVDRan4lJssQHKKbOiuVqDx084JoxWwEtcwEmadU1vvSY/a8a91eV49uPq0oqSv4u84
 AyXXP3c7dtmDjWlnl5pUTc27CSSm/rchhkE4W3GHa408oZq9Z6GX7fXvzDxnOriANiA4
 OyIkPKex+kQ5hWkY0gHETC5/OQmkD/5H7/D9Ch252TFzs8reX7oetbEIaXDANgeS1vnF
 Z8kw==
X-Gm-Message-State: AOJu0YzW6bgK8CMGV+AcvFGilkRruknH9HtbUmpOLBdVlo93s0GIyFZL
 QWZfTFRStEdV69bjx4iXbckK9poVQrDgzj2aWlg=
X-Google-Smtp-Source: AGHT+IGk93jqxbZeHXKw+aS24la11HqcJZzEPljZAMmVTZj6P8opqu1XBFa1rpapKn95HPML0pW77Q==
X-Received: by 2002:a05:6e02:f45:b0:34d:f0b4:787a with SMTP id
 y5-20020a056e020f4500b0034df0b4787amr10190286ilj.15.1693842905269; 
 Mon, 04 Sep 2023 08:55:05 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 cz17-20020a0566384a1100b0042acf389ac8sm3296709jab.130.2023.09.04.08.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:55:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH] buildman: Fix full help for Python 3.8
Date: Mon,  4 Sep 2023 09:54:59 -0600
Message-ID: <20230904155501.2715470-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
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

With Python versions older than 3.9 Buildman produces an error on
start-up. Fix this with a workaround for importlib.

There is already a workaround for v3.6 but I am not sure if that is still
functioning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/main.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/buildman/main.py b/tools/buildman/main.py
index 5f42a58ddbb3..3cf877e5e688 100755
--- a/tools/buildman/main.py
+++ b/tools/buildman/main.py
@@ -7,7 +7,7 @@
 """See README for more information"""
 
 try:
-    from importlib.resources import files
+    import importlib.resources
 except ImportError:
     # for Python 3.6
     import importlib_resources
@@ -83,7 +83,13 @@ def run_buildman():
         run_test_coverage()
 
     elif args.full_help:
-        tools.print_full_help(str(files('buildman').joinpath('README.rst')))
+        if hasattr(importlib.resources, 'files'):
+            dirpath = importlib.resources.files('buildman')
+            tools.print_full_help(str(dirpath.joinpath('README.rst')))
+        else:
+            with importlib.resources.path('buildman', 'README.rst') as readme:
+                tools.print_full_help(str(readme))
+
 
     # Build selected commits for selected boards
     else:
-- 
2.42.0.283.g2d96d420d3-goog

