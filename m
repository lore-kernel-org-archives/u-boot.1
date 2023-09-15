Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE4AEEAA7D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 00:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48407869DD;
	Fri, 15 Sep 2023 02:23:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HFz1d3zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA4A86900; Fri, 15 Sep 2023 02:22:59 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D828486915
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 02:22:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so42536539f.1
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 17:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694737375; x=1695342175; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDw8RV82RauXl1Zvg2ktvLLg7NdOauIPsJ0K9YH3BxE=;
 b=HFz1d3zObhm+tYs/mjOHnuHGqLrLAqTAKxuPNtFftQCwjIajr0YCDmGcy41tH5DNeg
 0psNrDvpFhCT5q0sycZLsK3aKSlHWS4ogNEv8/5Ulvpb70q8mx7k3B495CIJ8G1LbH0V
 KU8ILxTeuNRf4SFbAMvblTHoPm9wmQP4oA1Ws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694737375; x=1695342175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDw8RV82RauXl1Zvg2ktvLLg7NdOauIPsJ0K9YH3BxE=;
 b=KNfFcdAtDHEfctb20y7TEWNIeeXAzFFEsPhuEv1SHMiuZ6Re8N0HDgCXSGTRRVgWdj
 xVoTPJ3HVuoHPtRVbsIxr++gwI9nBiErXqINKdIG9FNOEahX9kdxa3LRgql2+PJzS8SR
 +iaUpEkrTAB/IW/hC5gxAhfWwWWrGBZX/PK2KCl79+XddY2YJu1kGD5trypbX3a9pv4P
 elQK8+IDarG+Znc9B+fFZ7+P/vqdn69pFIYyxtGxw9d4SnWISfJPbgiAgdimQL02+NDD
 2c7wZKiy2g4oKsuzXOnlekO6avjA9+c4i9w5jxyxF06Kek772roUzlV9pmkZAayEybbj
 mq6g==
X-Gm-Message-State: AOJu0Yz4yVfGdOwnC+CJoJyNdsRu1xrMcwMZ++fxfQ2hP1PC1o+ChSWh
 7HEvjEtxIGttplSOpso+LARr+WIaVvmsFo1Tn/k=
X-Google-Smtp-Source: AGHT+IFzqMJA6G6y456ZMHSHUBaSSVtmLkqpYMLIyhfZaK4z7FIpFUACW4USBa20zdW+m7ANgW+M9g==
X-Received: by 2002:a5e:d716:0:b0:787:8cf:fe82 with SMTP id
 v22-20020a5ed716000000b0078708cffe82mr173117iom.8.1694737375441; 
 Thu, 14 Sep 2023 17:22:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 i23-20020a5e8517000000b007836e9ff198sm744796ioj.55.2023.09.14.17.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 17:22:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 10/27] moveconfig: Use f strings where possible
Date: Thu, 14 Sep 2023 18:22:12 -0600
Message-ID: <20230915002236.798760-11-sjg@chromium.org>
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
2.42.0.459.ge4e396fd5e-goog

