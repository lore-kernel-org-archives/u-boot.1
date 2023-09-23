Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D654ACE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:46:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3782C86B7A;
	Sat, 23 Sep 2023 21:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XR/mkHQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263DE86B4E; Sat, 23 Sep 2023 21:44:44 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D86986B5D
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f96daf565so111206139f.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498279; x=1696103079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hp5Dj1hIe7cB+q8By3huXNkNHJyYNjVF10nh+8Tw+Q=;
 b=XR/mkHQQRY/lqddNAgk35fKwkLTrWcgKH0188JY/jjWLFMBkIM+uIKge1sGQR4MpOd
 RUrw6YVvXGOhBrgmXWTWxXPmsXrSEUHvZIN1SAvt5u8ssqRRO0f7JynLD5YyBF3qON3J
 d9hF7fxiKzBN5eHI6zf2fi9lz+GIOGBhvBq4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498279; x=1696103079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hp5Dj1hIe7cB+q8By3huXNkNHJyYNjVF10nh+8Tw+Q=;
 b=LE+QrtkSZUWreYscIExBE0P8eilj3D3IiEqz4c/23afMWGh5I9bFbtJmSdCclPFEun
 N/Til0Leoo4944DcCufP5m4itNwNiVqHPDy2A1xA6XlotTRKklB5x1exu+KhIFLHtrhQ
 iGa3OOtGdYnii8u85SSrqc4ZHi3ZC0jJJ64clCJp3gM0xgBGPGk0Be1o8kIBzeQVici/
 m4xtWeUSQJxE8OtrQ+Wzs+Vx3kDlWZdiRXwZjuzJ5GFX46f6YRqF3JSvaRN+pdbVbsQg
 fCYLaLaXL3PyfVXXf02fVjiLdguqVseqcjWTr5S9rn/XA1FsrrtEejISqk2w4fuCQLUI
 suAw==
X-Gm-Message-State: AOJu0Yw3yK4kXEtNbl3wbJ/emQa0GN4MIHYh5599aplbEqmySOnttXLn
 Jeu4jqepPXB99znD4kR7BCkTJAD8d7WC4lemtJc=
X-Google-Smtp-Source: AGHT+IEHMXLjjTc4t8kPYw4ldM8U2zocGm54pqdBlCIRTQH8hhO9JZ7LaRIC2hfoYqbM27OIw8QRkg==
X-Received: by 2002:a6b:5b13:0:b0:787:34d:f1ea with SMTP id
 v19-20020a6b5b13000000b00787034df1eamr4249165ioh.8.1695498278865; 
 Sat, 23 Sep 2023 12:44:38 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 10/27] moveconfig: Use f strings where possible
Date: Sat, 23 Sep 2023 13:43:59 -0600
Message-ID: <20230923194424.1739224-11-sjg@chromium.org>
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

Avoid pylint warnings by using 'f' strings where possible.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 689018d46d06..42298dd5d9c8 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -238,7 +238,7 @@ def read_file(fname, as_lines=True, skip_unicode=False):
         except UnicodeDecodeError as e:
             if not skip_unicode:
                 raise
-            print("Failed on file %s': %s" % (fname, e))
+            print(f"Failed on file '{fname}: {e}")
             return None
 
 def try_expand(line):
@@ -254,10 +254,10 @@ def try_expand(line):
         val= val.strip('\"')
         if re.search(r'[*+-/]|<<|SZ_+|\(([^\)]+)\)', val):
             newval = hex(aeval(val))
-            print('\tExpanded expression %s to %s' % (val, newval))
+            print(f'\tExpanded expression {val} to {newval}')
             return cfg+'='+newval
     except:
-        print('\tFailed to expand expression in %s' % line)
+        print(f'\tFailed to expand expression in {line}')
 
     return line
 
@@ -283,7 +283,7 @@ class Progress:
 
     def show(self):
         """Display the progress."""
-        print(' %d defconfigs out of %d\r' % (self.current, self.total), end=' ')
+        print(f' {self.current} defconfigs out of {self.total}\r', end=' ')
         sys.stdout.flush()
 
 
@@ -520,7 +520,7 @@ class Slot:
             toolchain = self.toolchains.Select(arch)
         except ValueError:
             self.log += color_text(self.args.color, COLOR_YELLOW,
-                    "Tool chain for '%s' is missing.  Do nothing.\n" % arch)
+                    f"Tool chain for '{arch}' is missing.  Do nothing.\n")
             self.finish(False)
             return
         env = toolchain.MakeEnvironment(False)
@@ -673,7 +673,7 @@ class Slots:
             boards = '\n'.join(boards) + '\n'
             msg = 'The following boards were not processed due to error:\n'
             msg += boards
-            msg += '(the list has been saved in %s)\n' % output_file
+            msg += f'(the list has been saved in {output_file})\n'
             print(color_text(self.args.color, COLOR_LIGHT_RED,
                                             msg), file=sys.stderr)
 
@@ -693,8 +693,9 @@ class ReferenceSource:
         print('Cloning git repo to a separate work directory...')
         subprocess.check_output(['git', 'clone', os.getcwd(), '.'],
                                 cwd=self.src_dir)
-        print("Checkout '%s' to build the original autoconf.mk." % \
-            subprocess.check_output(['git', 'rev-parse', '--short', commit]).strip())
+        rev = subprocess.check_output(['git', 'rev-parse', '--short',
+                                       commit]).strip()
+        print(f"Checkout '{rev}' to build the original autoconf.mk.")
         subprocess.check_output(['git', 'checkout', commit],
                                 stderr=subprocess.STDOUT, cwd=self.src_dir)
 
@@ -724,8 +725,8 @@ def move_config(toolchains, args, db_queue):
     if args.force_sync:
         print('Syncing defconfigs', end=' ')
     elif args.build_db:
-        print('Building %s database' % CONFIG_DATABASE)
-    print('(jobs: %d)\n' % args.jobs)
+        print(f'Building {CONFIG_DATABASE} database')
+    print(f'(jobs: {args.jobs})\n')
 
     if args.git_ref:
         reference_src = ReferenceSource(args.git_ref)
@@ -800,17 +801,17 @@ def check_imply_rule(kconf, config, imply_config):
         return 'cannot find sym'
     nodes = sym.nodes
     if len(nodes) != 1:
-        return '%d locations' % len(nodes)
+        return f'{len(nodes)} locations'
     node = nodes[0]
     fname, linenum = node.filename, node.linenr
     cwd = os.getcwd()
     if cwd and fname.startswith(cwd):
         fname = fname[len(cwd) + 1:]
-    file_line = ' at %s:%d' % (fname, linenum)
+    file_line = f' at {fname}:{linenum}'
     data = read_file(fname)
-    if data[linenum - 1] != 'config %s' % imply_config:
-        return None, 0, 'bad sym format %s%s' % (data[linenum], file_line)
-    return fname, linenum, 'adding%s' % file_line
+    if data[linenum - 1] != f'config {imply_config}':
+        return None, 0, f'bad sym format {data[linenum]}{file_line})'
+    return fname, linenum, f'adding{file_line}'
 
 def add_imply_rule(config, fname, linenum):
     """Add a new 'imply' option to a Kconfig
@@ -823,15 +824,15 @@ def add_imply_rule(config, fname, linenum):
     Returns:
         Message indicating the result
     """
-    file_line = ' at %s:%d' % (fname, linenum)
+    file_line = f' at {fname}:{linenum}'
     data = read_file(fname)
     linenum -= 1
 
     for offset, line in enumerate(data[linenum:]):
         if line.strip().startswith('help') or not line:
-            data.insert(linenum + offset, '\timply %s' % config)
+            data.insert(linenum + offset, f'\timply {config}')
             write_file(fname, data)
-            return 'added%s' % file_line
+            return f'added{file_line}'
 
     return 'could not insert%s'
 
@@ -946,15 +947,14 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
     for config in config_list:
         defconfigs = defconfig_db.get(config)
         if not defconfigs:
-            print('%s not found in any defconfig' % config)
+            print(f'{config} not found in any defconfig')
             continue
 
         # Get the set of defconfigs without this one (since a config cannot
         # imply itself)
         non_defconfigs = all_defconfigs - defconfigs
         num_defconfigs = len(defconfigs)
-        print('%s found in %d/%d defconfigs' % (config, num_defconfigs,
-                                                len(all_configs)))
+        print(f'{config} found in {num_defconfigs}/{len(all_configs)} defconfigs')
 
         # This will hold the results: key=config, value=defconfigs containing it
         imply_configs = {}
@@ -1035,7 +1035,7 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
                         fname, linenum = nodes[0].filename, nodes[0].linenr
                         if cwd and fname.startswith(cwd):
                             fname = fname[len(cwd) + 1:]
-                        kconfig_info = '%s:%d' % (fname, linenum)
+                        kconfig_info = f'{fname}:{linenum}'
                         if skip_added:
                             show = False
                 else:
@@ -1061,8 +1061,8 @@ def do_imply_config(config_list, add_imply, imply_flags, skip_added,
                             add_list[fname].append(linenum)
 
             if show and kconfig_info != 'skip':
-                print('%5d : %-30s%-25s %s' % (num_common, iconfig.ljust(30),
-                                              kconfig_info, missing_str))
+                print(f'{num_common:5d} : '
+                      f'{iconfig.ljust(30):-30s}{kconfig_info:-25s} {missing_str}')
 
         # Having collected a list of things to add, now we add them. We process
         # each file from the largest line number to the smallest so that
@@ -1556,11 +1556,11 @@ doc/develop/moveconfig.rst for documentation.'''
             for flag in args.imply_flags.split(','):
                 bad = flag not in IMPLY_FLAGS
                 if bad:
-                    print("Invalid flag '%s'" % flag)
+                    print(f"Invalid flag '{flag}'")
                 if flag == 'help' or bad:
                     print("Imply flags: (separate with ',')")
                     for name, info in IMPLY_FLAGS.items():
-                        print(' %-15s: %s' % (name, info[1]))
+                        print(f' {name:-15s}: {info[1]}')
                     parser.print_usage()
                     sys.exit(1)
                 imply_flags |= IMPLY_FLAGS[flag][0]
@@ -1602,9 +1602,9 @@ doc/develop/moveconfig.rst for documentation.'''
     if args.build_db:
         with open(CONFIG_DATABASE, 'w', encoding='utf-8') as fd:
             for defconfig, configs in config_db.items():
-                fd.write('%s\n' % defconfig)
+                fd.write(f'{defconfig}\n')
                 for config in sorted(configs.keys()):
-                    fd.write('   %s=%s\n' % (config, configs[config]))
+                    fd.write(f'   {config}={configs[config]}\n')
                 fd.write('\n')
 
 if __name__ == '__main__':
-- 
2.42.0.515.g380fc7ccd1-goog

