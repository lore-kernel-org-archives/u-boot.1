Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2101ECE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DE7F86B81;
	Sat, 23 Sep 2023 21:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YRio0N5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E827D8477A; Sat, 23 Sep 2023 21:44:44 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1004869F6
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34fc7f51441so12931945ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498280; x=1696103080; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OelIlvZe1Rzxa1miGM7KqqHdo5TgBdsKSovfQqIVmY=;
 b=YRio0N5NZZFheRSYOsLITpDVJPb37jQTGiw2XdnIaHBg2pfvQ8ADa26KWtqj7dhlF4
 zF+5OW2I9HapuCTwizrkmKLevrjRawsoG+Hlsu52kARwwkXCRjfA6q/p7tq4GISXxpIx
 jQS0bGOboc9uFJQum3Wl2CykBxB2HZ0DKNekk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498280; x=1696103080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OelIlvZe1Rzxa1miGM7KqqHdo5TgBdsKSovfQqIVmY=;
 b=Ua2NTUMb0sIUMwmQhRzvgTR3esLuNlANdU3K6GAs6kYcHtMCAu/f7qMIj+6eCa76wF
 7YWMmINp9K2k/0QRJ9DGWEJLd3Iq6mLZDfQLAiCNPc1AyRdRKiTFnF3dqZrtISVZgk0P
 5vKq6RiUPkfkGN8G0mnE7RTpqoaMlRPvjwa+j7qz0AKmkek0p1bM6CNq5XDipHgt4Ep/
 tcM7OHhUrDYStmqf6q5irq3MUyJv6MkYgULT+muo8VhNh3+OmHtVtGFHDILbMJzbQzZw
 2B+guc5OqWDRBRLIHwsR9j5mPmopo/mwmrZhEqnYv0sK/dBLFDIuGcZ8+85vT5UPIuq/
 ObLQ==
X-Gm-Message-State: AOJu0Yx7jpOoIwsS8cb4/jFG3JNl+BSKRkyeGt6A1Cs1qfoffYn4x8OF
 SBIacqsfF1IW7veQRXCy0WwY+xY5WzRY7tx0qwQ=
X-Google-Smtp-Source: AGHT+IE692XirfyzdJ/mn4W4r3ELtCnnSuCMI2ToS+O89khBi0/r/68+0gjw3KKfsuMyv61/oPgpPw==
X-Received: by 2002:a05:6e02:12e5:b0:34f:fe3c:fd8 with SMTP id
 l5-20020a056e0212e500b0034ffe3c0fd8mr4194401iln.15.1695498280460; 
 Sat, 23 Sep 2023 12:44:40 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 12/27] moveconfig: Correct non-snake variables names
Date: Sat, 23 Sep 2023 13:44:01 -0600
Message-ID: <20230923194424.1739224-13-sjg@chromium.org>
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
2.42.0.515.g380fc7ccd1-goog

