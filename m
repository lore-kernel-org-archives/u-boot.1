Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F735EEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09ED0869F6;
	Fri, 15 Sep 2023 02:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VvQp53n4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CDBC864C7; Fri, 15 Sep 2023 02:23:00 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A0A864C7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7951f0e02ecso52879239f.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737377; x=1695342177; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iH2IBlAf7yLZHqrzwTJ8hzLX752MB446BTGA2b/Ytko=;
 b=VvQp53n4P+RHNT4TGGfN/J/vfIxGP/WYLPccSyatymQ/QqbdfuAWEsNdcHtrxGAS3g
 JAdbewdLe0NLQKWBzdJwKpDk25uxhQnpFVk1653cC3GdfcqLwEqhpv2A5kh6VeDFxaDC
 OXE1KxGEIO8OtN+ZkVKcqs/yzpUKOrByITylo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737377; x=1695342177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iH2IBlAf7yLZHqrzwTJ8hzLX752MB446BTGA2b/Ytko=;
 b=SbPnPDOt83hwAVvZbB2sh0wcJb7PtzPdGV7azszIR3RGkknCjN4IjNdbDN9UFlH8/A
 OKhYuBAfEdmGKRUPxI6/fQPz4q7Z62ExabbcIEW7buXpV3iP4V8hyb34ml37DRKFNX46
 2UtGVUxrmuzd6k9V29eYLh1fKHCOb/fB8Rb78OWrE3iiB8VWohdxeQwbJ5AIj0aL2Hi0
 guSeA+RBP7DcJRQ8vvk7Io1E6EDwchk36ynLlg67DkqmV1mYvNV+OiRWXQlJjDtJkEFA
 z29/FcJichR4hn1O+zu/Hr+CkYb+Q25mo5ONKXz4AiVz3ZTL4m3r7NEyszpN1KiDgG+W
 2WAg==
X-Gm-Message-State: AOJu0YyGeF1ZLifpLPP5uO6UkTXAcvzccWRxWN25DkU94RD36FO6w9N0
 L/pzk4UejF3hbBhY9yEWv50RGZWf37lTQmvtmDI=
X-Google-Smtp-Source: AGHT+IGCTg8MsbqDGrPhah1UJ8J5OengOxSOhcEUitR3RJuhBk/oZJERExrAt1o+bzZ7y8fm3MLTug==
X-Received: by 2002:a6b:a16:0:b0:791:acd7:233f with SMTP id
 z22-20020a6b0a16000000b00791acd7233fmr32402ioi.15.1694737376899; 
 Thu, 14 Sep 2023 17:22:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 12/27] moveconfig: Correct non-snake variables names
Date: Thu, 14 Sep 2023 18:22:14 -0600
Message-ID: <20230915002236.798760-13-sjg@chromium.org>
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

Correct some variable names that do not conform to snake case, with the
three-character minimum.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 911e272d11a3..2234f28a7724 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -235,10 +235,10 @@ def read_file(fname, as_lines=True, skip_unicode=False):
                 return [line.rstrip('\n') for line in inf.readlines()]
             else:
                 return inf.read()
-        except UnicodeDecodeError as e:
+        except UnicodeDecodeError as exc:
             if not skip_unicode:
                 raise
-            print(f"Failed on file '{fname}: {e}")
+            print(f"Failed on file '{fname}: {exc}")
             return None
 
 def try_expand(line):
@@ -331,13 +331,13 @@ class KconfigParser:
         arch = ''
         cpu = ''
         for line in read_file(self.dotconfig):
-            m = self.re_arch.match(line)
-            if m:
-                arch = m.group(1)
+            m_arch = self.re_arch.match(line)
+            if m_arch:
+                arch = m_arch.group(1)
                 continue
-            m = self.re_cpu.match(line)
-            if m:
-                cpu = m.group(1)
+            m_cpu = self.re_cpu.match(line)
+            if m_cpu:
+                cpu = m_cpu.group(1)
 
         if not arch:
             return None
@@ -422,7 +422,7 @@ class Slot:
         If the subprocess is still running, wait until it finishes.
         """
         if self.state != STATE_IDLE:
-            while self.ps.poll() == None:
+            while self.proc.poll() == None:
                 pass
         shutil.rmtree(self.build_dir)
 
@@ -467,10 +467,10 @@ class Slot:
         if self.state == STATE_IDLE:
             return True
 
-        if self.ps.poll() == None:
+        if self.proc.poll() == None:
             return False
 
-        if self.ps.poll() != 0:
+        if self.proc.poll() != 0:
             self.handle_error()
         elif self.state == STATE_DEFCONFIG:
             if self.reference_src_dir and not self.current_src_dir:
@@ -499,7 +499,7 @@ class Slot:
                                'Failed to process.\n')
         if self.args.verbose:
             self.log += color_text(self.args.color, COLOR_LIGHT_CYAN,
-                                   self.ps.stderr.read().decode())
+                                   self.proc.stderr.read().decode())
         self.finish(False)
 
     def do_defconfig(self):
@@ -507,9 +507,9 @@ class Slot:
 
         cmd = list(self.make_cmd)
         cmd.append(self.defconfig)
-        self.ps = subprocess.Popen(cmd, stdout=self.devnull,
-                                   stderr=subprocess.PIPE,
-                                   cwd=self.current_src_dir)
+        self.proc = subprocess.Popen(cmd, stdout=self.devnull,
+                                     stderr=subprocess.PIPE,
+                                     cwd=self.current_src_dir)
         self.state = STATE_DEFCONFIG
 
     def do_autoconf(self):
@@ -528,9 +528,9 @@ class Slot:
         cmd = list(self.make_cmd)
         cmd.append('KCONFIG_IGNORE_DUPLICATES=1')
         cmd.append(AUTO_CONF_PATH)
-        self.ps = subprocess.Popen(cmd, stdout=self.devnull, env=env,
-                                   stderr=subprocess.PIPE,
-                                   cwd=self.current_src_dir)
+        self.proc = subprocess.Popen(cmd, stdout=self.devnull, env=env,
+                                     stderr=subprocess.PIPE,
+                                     cwd=self.current_src_dir)
         self.state = STATE_AUTOCONF
 
     def do_build_db(self):
@@ -552,8 +552,8 @@ class Slot:
 
         cmd = list(self.make_cmd)
         cmd.append('savedefconfig')
-        self.ps = subprocess.Popen(cmd, stdout=self.devnull,
-                                   stderr=subprocess.PIPE)
+        self.proc = subprocess.Popen(cmd, stdout=self.devnull,
+                                     stderr=subprocess.PIPE)
         self.state = STATE_SAVEDEFCONFIG
 
     def update_defconfig(self):
@@ -1145,13 +1145,13 @@ def prefix_config(cfg):
     >>> prefix_config('A123')
     'CONFIG_A123'
     """
-    op = ''
+    oper = ''
     if cfg[0] == '~':
-        op = cfg[0]
+        oper = cfg[0]
         cfg = cfg[1:]
     if not cfg.startswith('CONFIG_'):
         cfg = 'CONFIG_' + cfg
-    return op + cfg
+    return oper + cfg
 
 
 RE_MK_CONFIGS = re.compile(r'CONFIG_(\$\(SPL_(?:TPL_)?\))?([A-Za-z0-9_]*)')
@@ -1199,12 +1199,12 @@ def scan_makefiles(fnames):
     fname_uses = {}
     for fname, rest in fnames:
         m_iter = RE_MK_CONFIGS.finditer(rest)
-        for m in m_iter:
-            real_opt = m.group(2)
+        for mat in m_iter:
+            real_opt = mat.group(2)
             if real_opt == '':
                 continue
             is_spl = False
-            if m.group(1):
+            if mat.group(1):
                 is_spl = True
             use = ConfigUse(real_opt, is_spl, fname, rest)
             if fname not in fname_uses:
@@ -1244,8 +1244,8 @@ def scan_src_files(fnames):
     rest = None
 
     def add_uses(m_iter, is_spl):
-        for m in m_iter:
-            real_opt = m.group(1)
+        for mat in m_iter:
+            real_opt = mat.group(1)
             if real_opt == '':
                 continue
             use = ConfigUse(real_opt, is_spl, fname, rest)
@@ -1573,9 +1573,9 @@ doc/develop/moveconfig.rst for documentation.'''
     # We are either building the database or forcing a sync of defconfigs
     config_db = {}
     db_queue = queue.Queue()
-    t = DatabaseThread(config_db, db_queue)
-    t.daemon = True
-    t.start()
+    dbt = DatabaseThread(config_db, db_queue)
+    dbt.daemon = True
+    dbt.start()
 
     check_clean_directory()
     bsettings.setup('')
@@ -1598,12 +1598,12 @@ doc/develop/moveconfig.rst for documentation.'''
         subprocess.call(['git', 'commit', '-s', '-m', msg])
 
     if args.build_db:
-        with open(CONFIG_DATABASE, 'w', encoding='utf-8') as fd:
+        with open(CONFIG_DATABASE, 'w', encoding='utf-8') as outf:
             for defconfig, configs in config_db.items():
-                fd.write(f'{defconfig}\n')
+                outf.write(f'{defconfig}\n')
                 for config in sorted(configs.keys()):
-                    fd.write(f'   {config}={configs[config]}\n')
-                fd.write('\n')
+                    outf.write(f'   {config}={configs[config]}\n')
+                outf.write('\n')
 
 if __name__ == '__main__':
     sys.exit(main())
-- 
2.42.0.459.ge4e396fd5e-goog

