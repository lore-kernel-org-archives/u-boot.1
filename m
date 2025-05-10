Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB74C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E81C82AAF;
	Sat, 10 May 2025 13:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fCjWqBad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CDCF82AE1; Sat, 10 May 2025 13:06:17 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860BC8070C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad241baf856so18325366b.0
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875173; x=1747479973; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpPvWGmM5MRnoCE1+yX1FLrS8B6RMwcjmEkCGrZP96U=;
 b=fCjWqBad6RxIKOFDlPROi4ztTZKKlnKM46r9jIE/omJFU8B1smiTYHnAQGX5T+DI2e
 ARNQwWWUfCv6udqhN/Nr5ox87cITDdheddG9l1Go6J/bmHJ6TgYSRQ2AYuGJ1YCwWkYJ
 4wVcIdVUdNS3vntLwRrcepVvwYnFAO0bmppHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875173; x=1747479973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PpPvWGmM5MRnoCE1+yX1FLrS8B6RMwcjmEkCGrZP96U=;
 b=JuFueoUsxGvr7r3Ncxg9Z358oF912DBIRDnpaZUnampEPM7TpErG/HzChSVfRDpYa1
 0aUwhjDMMAjkY2Bq5GYz8vJwjyznQbNAAmwQY2GNz0tMRzVUINWWL4kH5mc7VwNOIRvV
 0F/ImFAyuUHPlDsnN41FF+5cMwSePmcWQuA4OgrdQ5Xktc/EBCOLfQuGwHYtn3tjor29
 BdPsrFVFDmj4DNaZa93KhtNKJCpwrCqcHfbTuMf/QKwBu/KVfNMF/JNPCx9uLH95EhBr
 zppbYSuc1kxczGLeh7fHjG7ys1h0XqR7kx8d5+bFd19B9PkO9bHQhiV66gAjM6yUikW/
 2dTA==
X-Gm-Message-State: AOJu0YwQOk5Seb0ONQfGCp40TRjk+0iKmbmj6oe3MzedUo2zfNTD7vEA
 67vG5SorZ6rlcESLC0u0E3HK5F9d7qJzPvgHlUaY0yY5Wdj6sMgdiHxR4fob5wba91iX8C1rD92
 EzahMpXGjvQ==
X-Gm-Gg: ASbGncujEwb84KGXKhAd8VyuX3AGey1hRKhGWjc4yftkpN1WIHQ1HiWk10tRRN0iOFf
 NzyPce3/y4rmfW3+nzvdq07FLaGOAGdhZiD0d/k564ffdcuchPmWzdJ4KBeR0YJPBklAwKKl1RH
 kur+0lxw139va0CGFayZT9YHJkgGU+mfm/t4q+L2lr1yFBMGnr1TNmUkrn+VilbXvMdeKSVGJm2
 T1+Y6UftDzGPeySAmM9K6A9tawg2Re2j1dz7q/hhXc3YLAD5WNVHnpm7C/SbhnsHay4k1EOXYnt
 fBKCz1M6zHU/cNWLzF5bm+IdEfzhhB1Lqzo5M4l9lTZRFyM=
X-Google-Smtp-Source: AGHT+IEwy8ZBY1HZ3p/qtW0z1QsoLHrI3DhEDodJU7cMY2gc7+ru+nM4gjHLlrhLYblJRAj3ULZZJQ==
X-Received: by 2002:a17:907:1c84:b0:acb:b9ab:6d75 with SMTP id
 a640c23a62f3a-ad21b4272fdmr598300866b.23.1746875173472; 
 Sat, 10 May 2025 04:06:13 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/25] patman: Enhance implementation of file-based defaults
Date: Sat, 10 May 2025 13:05:07 +0200
Message-ID: <20250510110535.1453745-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510110535.1453745-1-sjg@chromium.org>
References: <20250510110535.1453745-1-sjg@chromium.org>
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

Patman allows defaults for its command-line flags to be read from a
file. The implementation of this does not fully work with subcommands,
since we don't want a default for those.

Also, it relies on being able to parse any sort of cmdline in order to
figure out the options that are available. But in some cases, the
cmdline may not parse, e.g. if there are required options, or
conflicting options.

Add a class which can be safely used to parse any cmdline, since it
allows execution to continue even when errors are obtained. Use this to
determine the defaults, being careful to skip sub/commands.

Another way to handle all of this would be to maintain the defaults
separately and insert them into the parser manually. For now, I'm not
sure which is best.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py  | 21 ++++++++++++++++-
 tools/patman/settings.py | 50 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 6 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 108fa52d820..8e10c7bb14f 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -21,6 +21,25 @@ PATMAN_DIR = pathlib.Path(__file__).parent
 HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
 
 
+class ErrorCatchingArgumentParser(argparse.ArgumentParser):
+    def __init__(self, **kwargs):
+        self.exit_state = None
+        self.catch_error = False
+        super().__init__(**kwargs)
+
+    def error(self, message):
+        if self.catch_error:
+            self.message = message
+        else:
+            super().error(message)
+
+    def exit(self, status=0, message=None):
+        if self.catch_error:
+            self.exit_state = True
+        else:
+            super().exit(status, message)
+
+
 def add_send_args(par):
     """Add arguments for the 'send' command
 
@@ -150,7 +169,7 @@ def setup_parser():
         them as specified by tags you place in the commits. Use -n to do a dry
         run first.'''
 
-    parser = argparse.ArgumentParser(epilog=epilog)
+    parser = ErrorCatchingArgumentParser(epilog=epilog)
     parser.add_argument(
         '-D', '--debug', action='store_true',
         help='Enabling debugging (provides a full traceback on error)')
diff --git a/tools/patman/settings.py b/tools/patman/settings.py
index def932db43a..17229e0d823 100644
--- a/tools/patman/settings.py
+++ b/tools/patman/settings.py
@@ -9,8 +9,10 @@ except Exception:
     import ConfigParser
 
 import argparse
+from io import StringIO
 import os
 import re
+import sys
 
 from u_boot_pylib import gitutil
 
@@ -254,10 +256,44 @@ def _UpdateDefaults(main_parser, config, argv):
     defaults = {}
     parser_defaults = []
     argv = list(argv)
+    orig_argv = argv
+
+    bad = False
+    full_parser_list = []
     for parser in parsers:
-        pdefs = parser.parse_known_args()[0]
-        parser_defaults.append(pdefs)
-        defaults.update(vars(pdefs))
+        argv_list = [orig_argv]
+        special_cases = []
+        if hasattr(parser, 'defaults_cmds'):
+           special_cases = parser.defaults_cmds
+        for action in parser._actions:
+            if action.choices:
+                argv_list = []
+                for choice in action.choices:
+                    argv = None
+                    for case in special_cases:
+                        if case[0] == choice:
+                            argv = case
+                    argv_list.append(argv or [choice])
+
+        for argv in argv_list:
+            parser.message = None
+            old_val = parser.catch_error
+            try:
+                parser.catch_error = True
+                pdefs = parser.parse_known_args(argv)[0]
+            finally:
+                parser.catch_error = old_val
+
+            # if parser.message:
+                # print('bad', argv, parser.message)
+                # bad = True
+
+            parser_defaults.append(pdefs)
+            defaults.update(vars(pdefs))
+            full_parser_list.append(parser)
+    if bad:
+        print('Internal parsing error')
+        sys.exit(1)
 
     # Go through the settings and collect defaults
     for name, val in config.items('settings'):
@@ -272,11 +308,15 @@ def _UpdateDefaults(main_parser, config, argv):
             defaults[name] = val
         else:
             print("WARNING: Unknown setting %s" % name)
+    if 'cmd' in defaults:
+        del defaults['cmd']
+    if 'subcmd' in defaults:
+        del defaults['subcmd']
 
     # Set all the defaults and manually propagate them to subparsers
     main_parser.set_defaults(**defaults)
-    assert len(parsers) == len(parser_defaults)
-    for parser, pdefs in zip(parsers, parser_defaults):
+    assert len(full_parser_list) == len(parser_defaults)
+    for parser, pdefs in zip(full_parser_list, parser_defaults):
         parser.set_defaults(**{k: v for k, v in defaults.items()
                                if k in pdefs})
     return defaults
-- 
2.43.0

