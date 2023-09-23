Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8248FCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35E586B8B;
	Sat, 23 Sep 2023 21:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dQXZBFPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9ABD7868D8; Sat, 23 Sep 2023 21:44:44 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06AE28477A
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3510b309932so11208165ab.2
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498279; x=1696103079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PF+YViUibPRW7YbhskizfNLWrV9YD67omGiS1dcQMRM=;
 b=dQXZBFPbMjFdMz0In0nvIwoD+F1pQ7VWHZF5txQjI+/HA0dsl8I1tBB9MfH9CH6DJv
 t3vT+PwNcJA7BHhK2E9PZcoQMDT7C2Tqd+QAGi9Q9ASNZcjCcEYcF9Q54mw2eGXNC9G5
 +LPTe3DhlEAg5zT0fFGGDwWigALQsO9UUz5b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498279; x=1696103079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PF+YViUibPRW7YbhskizfNLWrV9YD67omGiS1dcQMRM=;
 b=uBZgB9tKApm3nY98kMr05ePheQqavV5pYwrP4lYTAQT3e1cRYzZNpC7UUDUWhd2bCv
 wdpgELNnbTUcFsa+vrciqw+1iC0X8NPeTmUZUwN6KDN4g/G6GzKBV2FtrX+llDetW4V7
 DwUz8VKRtv5B9swEsKxHDrz12uUdVNpzR6UIwhkSzcY++x0DTXmYUkskDOx6o7nsShFM
 nmojHMkWUG+/fnol4jVgv0Zkqu8T3gu/9bPyAeHk2cFo+r6rKAbNhgJb25vNr0laxscH
 u9VhfsxDdd9DyaYAeMczZaa+XJ/gVrXpDPEVMVA36RfVpoe9JMjFmeMLbmcy6ENmb5tt
 4ilw==
X-Gm-Message-State: AOJu0YwvHALcYrIdwvbMCuZVMqqmGQHgUZCR5lc+zNGf/PGplu+U0kX3
 N4RNPhmRerKifv4mhKX/bTY5hcHJDVkwdCLogUk=
X-Google-Smtp-Source: AGHT+IHS2yBCy/HWQX65xTrDR/hZOPGq4uJaH+8aAO7/435de4KRD2zohYhFidcePQlWh+P7jMhn0Q==
X-Received: by 2002:a05:6e02:1c2c:b0:351:e70:2cec with SMTP id
 m12-20020a056e021c2c00b003510e702cecmr3559806ilh.20.1695498279583; 
 Sat, 23 Sep 2023 12:44:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 11/27] moveconfig: Correct unused variables
Date: Sat, 23 Sep 2023 13:44:00 -0600
Message-ID: <20230923194424.1739224-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230923194424.1739224-1-sjg@chromium.org>
References: <20230923194424.1739224-1-sjg@chromium.org>
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

Fix pylint warnings about unused variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 42298dd5d9c8..911e272d11a3 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -620,7 +620,7 @@ class Slots:
         self.slots = []
         devnull = subprocess.DEVNULL
         make_cmd = get_make_cmd()
-        for i in range(args.jobs):
+        for _ in range(args.jobs):
             self.slots.append(Slot(toolchains, args, progress, devnull,
                                    make_cmd, reference_src_dir, db_queue))
 
@@ -772,7 +772,7 @@ def find_kconfig_rules(kconf, config, imply_config):
     """
     sym = kconf.syms.get(imply_config)
     if sym:
-        for sel, cond in (sym.selects + sym.implies):
+        for sel, _ in (sym.selects + sym.implies):
             if sel.name == config:
                 return sym
     return None
@@ -941,7 +941,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
     if add_imply and add_imply != 'all':
         add_imply = add_imply.split(',')
 
-    all_configs, all_defconfigs, config_db, defconfig_db = read_database()
+    all_configs, all_defconfigs, _, defconfig_db = read_database()
 
     # Work through each target config option in turn, independently
     for config in config_list:
@@ -1101,7 +1101,7 @@ def do_find_config(config_list):
             is preceded by a tilde (~) then it must be false, otherwise it must
             be true)
     """
-    all_configs, all_defconfigs, config_db, defconfig_db = read_database()
+    _, all_defconfigs, config_db, _ = read_database()
 
     # Start with all defconfigs
     out = all_defconfigs
@@ -1199,9 +1199,7 @@ def scan_makefiles(fnames):
     fname_uses = {}
     for fname, rest in fnames:
         m_iter = RE_MK_CONFIGS.finditer(rest)
-        found = False
         for m in m_iter:
-            found = True
             real_opt = m.group(2)
             if real_opt == '':
                 continue
@@ -1242,9 +1240,11 @@ def scan_src_files(fnames):
     >>> RE_CONFIG_IS.search('#if CONFIG_IS_ENABLED(OF_PLATDATA)').groups()
     ('OF_PLATDATA',)
     """
+    fname = None
+    rest = None
+
     def add_uses(m_iter, is_spl):
         for m in m_iter:
-            found = True
             real_opt = m.group(1)
             if real_opt == '':
                 continue
@@ -1302,7 +1302,7 @@ def do_scan_source(path, do_update):
         """
         # Make sure we know about all the options
         not_found = collections.defaultdict(list)
-        for use, rest in all_uses.items():
+        for use, _ in all_uses.items():
             name = use.cfg
             if name in IGNORE_SYMS:
                 continue
@@ -1314,7 +1314,6 @@ def do_scan_source(path, do_update):
                 # If it is an SPL symbol, try prepending all SPL_ prefixes to
                 # find at least one SPL symbol
                 if use.is_spl:
-                    add_to_dict = False
                     for prefix in SPL_PREFIXES:
                         try_name = prefix + name
                         sym = kconf.syms.get(try_name)
@@ -1332,7 +1331,6 @@ def do_scan_source(path, do_update):
                 elif not use.is_spl:
                     check = False
             else: # MODE_NORMAL
-                debug = False
                 sym = kconf.syms.get(name)
                 if not sym:
                     proper_name = is_not_proper(name)
@@ -1373,7 +1371,7 @@ def do_scan_source(path, do_update):
     print(f'Scanning source in {path}')
     args = ['git', 'grep', '-E', r'IS_ENABLED|\bCONFIG']
     with subprocess.Popen(args, stdout=subprocess.PIPE) as proc:
-        out, err = proc.communicate()
+        out, _ = proc.communicate()
     lines = out.splitlines()
     re_fname = re.compile('^([^:]*):(.*)')
     src_list = []
@@ -1407,7 +1405,7 @@ def do_scan_source(path, do_update):
             print(f'Not sure how to handle file {fname}')
 
     # Scan the Makefiles
-    all_uses, fname_uses = scan_makefiles(mk_list)
+    all_uses, _ = scan_makefiles(mk_list)
 
     spl_not_found = set()
     proper_not_found = set()
@@ -1428,7 +1426,7 @@ def do_scan_source(path, do_update):
     proper_not_found |= set([key for key in not_found.keys()])
 
     # Scan the source code
-    all_uses, fname_uses = scan_src_files(src_list)
+    all_uses, _ = scan_src_files(src_list)
 
     # Make sure we know about all the options
     print('\nCONFIG options present in source but not Kconfig:')
@@ -1529,7 +1527,7 @@ doc/develop/moveconfig.rst for documentation.'''
 
     if args.test:
         sys.argv = [sys.argv[0]]
-        fail, count = doctest.testmod()
+        fail, _ = doctest.testmod()
         if fail:
             return 1
         unittest.main()
-- 
2.42.0.515.g380fc7ccd1-goog

