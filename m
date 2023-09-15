Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B3EEEAA7A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:24:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5227869A3;
	Fri, 15 Sep 2023 02:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lD7VHgSD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAAE186900; Fri, 15 Sep 2023 02:22:59 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B619B86852
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7926a450a0aso59807939f.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737376; x=1695342176; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oUTDj1PFePlkpC0R79rh22XZtzbNewxCUokez5FOH+Q=;
 b=lD7VHgSD0yYG1kkiWlgG+C4t3+59FSODYgwNQDZqTfxYwswOB4xXUHeVUuAbMQp6qT
 Ou1nwH/8sXIPtR77bVdRNKoB8CmO6nl60DNcNdn7IvQdLfzQFYYazv663zwt+hgtLVY8
 UAnw6bv/74dAXNaABJ4D/RksF0MUnhn/sRNIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737376; x=1695342176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oUTDj1PFePlkpC0R79rh22XZtzbNewxCUokez5FOH+Q=;
 b=VGUa/HiwewWrF2SdQ/a8ZqDdArx8N+mlPVS0754FFFbyPsOx566/JBOR0kuhPa/WG8
 uk7U+9Z0wkApskhOuQvjiIJ6//Sn8QAn1lT9Bx41/knNvDo+FVvHy5FgFogp/TZXC5KJ
 cScH0pQTu4KCD4na4CKu0VAcV0lG1B941XCRgPcFOn3YirITRW05Z6E8pZCw99a9h8mu
 qESLK3wOvdkTpHWpBxq/H+AplBNIqosWqw6tY3z3fffMbAkGOg3y5siU9DDYoWFncpkW
 +kSxAsXMOhkr0Rlfp9xSQqcu0Kb9SvikihpzXVxiQYlV6ALEqVAfGB5M/dNnsYcOs7wU
 ADyA==
X-Gm-Message-State: AOJu0YyfGZC18b67PgZFwCiRzPLXde4UAU3v8Mls3Dx12RgMf2s1BRap
 0T4io5QbMfv0b8hjyI3wa8EDePNohwmU1JDMve4=
X-Google-Smtp-Source: AGHT+IEFrMVIrLJ//ALfChv7l2wry+VbEWvO8DUGVb1cTbmnu3xq0J5Fl7G5qvwnu7DYApYjM0KF4w==
X-Received: by 2002:a5d:9a87:0:b0:783:4bc6:636e with SMTP id
 c7-20020a5d9a87000000b007834bc6636emr21048iom.21.1694737376175; 
 Thu, 14 Sep 2023 17:22:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/27] moveconfig: Correct unused variables
Date: Thu, 14 Sep 2023 18:22:13 -0600
Message-ID: <20230915002236.798760-12-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230915002236.798760-1-sjg@chromium.org>
References: <20230915002236.798760-1-sjg@chromium.org>
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
2.42.0.459.ge4e396fd5e-goog

