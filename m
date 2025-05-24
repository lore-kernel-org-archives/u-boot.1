Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408BEC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:07:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155F983631;
	Sat, 24 May 2025 19:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PELJ3pYF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D31E83600; Sat, 24 May 2025 19:07:25 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CEB82E76
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-3da831c17faso3020965ab.3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748106439; x=1748711239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kxgnxpl7x2s7cB+p7DqCJCIZbj9bhsdlRTyiiD6TJ0c=;
 b=PELJ3pYFvY0RUpaF8cejxycJySSjNPOvYZqFKO6NZC4yllXJgJvA8RKRKAMXBC2gJX
 DE6PUfnZl0HYmwIjsCgbCU1orrmqfr5i3gXEkU7PEBrMj3X4TBmkmUH9kW8TOBsWlAVK
 BjxB0Svf3GP6koGIJOCwtec24jmt4eLFLsaKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748106439; x=1748711239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kxgnxpl7x2s7cB+p7DqCJCIZbj9bhsdlRTyiiD6TJ0c=;
 b=VedHCPvFD8VIGqAhcYsegaERScLIrDvadZB19h84/yxbLWdMpPFlPumQocpOGeZIrj
 6xbt6MzYC62T1fJpX50l785W43xjvxugOyx3BaFNDF2Fq969wwe44P3bnsAJkAzLvXs0
 avYhMDL1zJP9Pfcd4KW8fzyAnl30fWU+tUsKXdHZBKcgscdw3jMmX79s6dFi+fmzBHIB
 noT1qc2Bv89RyS4NbvE/97YHNw5i0XArUWpCCucUm4RbU4HB+rTP4c1hlKpRETclvFBP
 fmfhFcVcShQJHSJDS0ciDLPCrrQzmQTSM1ox2p2Q8vG15v9T505QYm0stWRT4lne8A8V
 s5ew==
X-Gm-Message-State: AOJu0YzlvYDgqn+SZ0IRQIDbmwjYENrjj6ZMlic/gSMDHjfz72P6THAv
 u+cqjaMI3u0EXBFrKbtOr5F6S5JLnXWXEGqBFBdJKuR51zlQdbUCOzP47C+qBHCDDqSJQ96dAxO
 nCQZgZrNTK84=
X-Gm-Gg: ASbGncvEb4mmAHbbnuxg+6tcp1JMf2FXfgAuT56KlxB9IpvvfFPeBB/0xaG0Ek/Q6gC
 KftCuoq41lvV9Tjw+eHXpqWE8y9e5ajfd6UgmtAdi6hC1VFxnZ1mBvXOkoqR4iyKK7tS9/mU1LV
 c6wjC0OfjndSCvbgHnefO90exCrqQJvD7BmN0CVErE8hskL4Td5rm5z5oBJyyFpGJ/uN9Eh0+k9
 JLvXea7it6NaTfFId6yXZqkfUS72bmr8lKg88SnwFAbahXE2wt4RPcVgPuBSl63Ei7DOA1kWuGy
 d1ZAvmpTXT+XOnCmXX+nPjPB25svcQi+KaXKgO31KoT4sP80W4dGuiXUqc2Yo9ySPv98RruIIqk
 QnfnxgBGk9oGT
X-Google-Smtp-Source: AGHT+IHCJ2WSdQijUhN7T/tCpevyC0UQOwr8HkgpVxkhf6eLc9pajyxl1N+VRs2grFgzv/FnI/T7Uw==
X-Received: by 2002:a05:6e02:3081:b0:3dc:8bd3:3cdd with SMTP id
 e9e14a558f8ab-3dc9b6800f6mr26401445ab.1.1748106439012; 
 Sat, 24 May 2025 10:07:19 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc9e7d18c9sm3940355ab.53.2025.05.24.10.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:07:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/7] patman: Allow showing progress on archived series
Date: Sat, 24 May 2025 11:06:52 -0600
Message-ID: <20250524170701.1238642-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524170701.1238642-1-sjg@chromium.org>
References: <20250524170701.1238642-1-sjg@chromium.org>
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

Sometimes it is useful to include archived series in the progress report
so you can see all the work completed. Add a flag for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py      |  1 +
 tools/patman/control.py      |  2 +-
 tools/patman/cser_helper.py  | 18 +++++++++++------
 tools/patman/cseries.py      |  9 ++++++---
 tools/patman/test_cseries.py | 38 +++++++++++++++++++++++++++++++++---
 5 files changed, 55 insertions(+), 13 deletions(-)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 18bcece211f..3095b67e009 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -289,6 +289,7 @@ def add_series_subparser(subparsers):
                       help='Show all series versions, not just the latest')
     prog.add_argument('-l', '--list-patches', action='store_true',
                       help='List patch subject and status')
+    _add_archived(prog)
 
     ren = series_subparsers.add_parser('rename')
     ren.add_argument('-N', '--new-name', help='New name for the series')
diff --git a/tools/patman/control.py b/tools/patman/control.py
index d898a4482af..57d2dbe8edd 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -184,7 +184,7 @@ def do_series(args, test_db=None, pwork=None, cser=None):
                               args.patch)
         elif args.subcmd == 'progress':
             cser.progress(args.series, args.show_all_versions,
-                          args.list_patches)
+                          args.list_patches, args.include_archived)
         elif args.subcmd == 'rm':
             cser.remove(args.series, dry_run=args.dry_run)
         elif args.subcmd == 'rm-version':
diff --git a/tools/patman/cser_helper.py b/tools/patman/cser_helper.py
index 39f291cb3ec..dd2cfc5cbf0 100644
--- a/tools/patman/cser_helper.py
+++ b/tools/patman/cser_helper.py
@@ -1156,6 +1156,7 @@ class CseriesHelper:
         states = defaultdict(int)
         count = len(pwc)
         ok = True
+        cmt = None
         for seq, item in enumerate(pwc.values()):
             if series:
                 cmt = series.commits[seq]
@@ -1178,7 +1179,8 @@ class CseriesHelper:
                 subject = item.subject
 
             line = (f'{seq:3} {col_state}{pad} {comments.rjust(3)} '
-                    f'{patch_id:7} {oid(cmt.hash)} {subject}')
+                    f"{patch_id:7} {oid(cmt.hash) if cmt else ' ' * HASH_LEN} "
+                    f'{subject}')
             lines.append(line)
             states[item.state] += 1
         out = ''
@@ -1187,7 +1189,7 @@ class CseriesHelper:
             state_totals[state] += freq
         name = ''
         if not list_patches:
-            name = desc or series.desc
+            name = desc or (series.desc if series else '')
             name = self.col.build(self.col.YELLOW, name[:41].ljust(41))
             if not ok:
                 out = '*' + out[1:]
@@ -1402,7 +1404,7 @@ class CseriesHelper:
             return await self._sync_all(client, pwork, to_fetch)
 
     def _progress_one(self, ser, show_all_versions, list_patches,
-                      state_totals):
+                      state_totals, use_metadata=True):
         """Show progress information for all versions in a series
 
         Args:
@@ -1414,6 +1416,8 @@ class CseriesHelper:
             state_totals (dict): Holds totals for each state across all patches
                 key (str): state name
                 value (int): Number of patches in that state
+            use_metadata (bool): True to read the series metadata from the
+                branch
 
         Return: tuple
             int: Number of series shown
@@ -1441,10 +1445,12 @@ class CseriesHelper:
             _, pwc = self._series_get_version_stats(ser.idnum, ver)
             count = len(pwc)
             branch = self._join_name_version(ser.name, ver)
-            series = patchstream.get_metadata(branch, 0, count,
-                                              git_dir=self.gitdir)
+            series = None
+            if use_metadata:
+                series = patchstream.get_metadata(branch, 0, count,
+                                                  git_dir=self.gitdir)
+                self._copy_db_fields_to(series, ser)
             svinfo = self.get_ser_ver(ser.idnum, ver)
-            self._copy_db_fields_to(series, ser)
 
             ok = self._list_patches(
                 branch, pwc, series, svinfo.name, svinfo.cover_id,
diff --git a/tools/patman/cseries.py b/tools/patman/cseries.py
index 717a2504962..7064c33b6ee 100644
--- a/tools/patman/cseries.py
+++ b/tools/patman/cseries.py
@@ -556,7 +556,8 @@ class Cseries(cser_helper.CseriesHelper):
         # environment.
         cros_subprocess.Popen(['xdg-open', url])
 
-    def progress(self, series, show_all_versions, list_patches):
+    def progress(self, series, show_all_versions, list_patches,
+                 include_archived):
         """Show progress information for all versions in a series
 
         Args:
@@ -566,6 +567,7 @@ class Cseries(cser_helper.CseriesHelper):
                 False to show only the final version
             list_patches (bool): True to list all patches for each series,
                 False to just show the series summary on a single line
+            include_archived (bool): True to include archived series also
         """
         with terminal.pager():
             state_totals = defaultdict(int)
@@ -581,7 +583,7 @@ class Cseries(cser_helper.CseriesHelper):
 
             total_patches = 0
             total_series = 0
-            sdict = self.db.series_get_dict()
+            sdict = self.db.series_get_dict(include_archived)
             border = None
             total_need_scan = 0
             if not list_patches:
@@ -593,7 +595,8 @@ class Cseries(cser_helper.CseriesHelper):
             for name in sorted(sdict):
                 ser = sdict[name]
                 num_series, num_patches, need_scan = self._progress_one(
-                    ser, show_all_versions, list_patches, state_totals)
+                    ser, show_all_versions, list_patches, state_totals,
+                    not include_archived)
                 total_need_scan += need_scan
                 if list_patches:
                     print()
diff --git a/tools/patman/test_cseries.py b/tools/patman/test_cseries.py
index d6cd042e990..ab59ae7c9a3 100644
--- a/tools/patman/test_cseries.py
+++ b/tools/patman/test_cseries.py
@@ -720,7 +720,7 @@ Tested-by: Mary Smith <msmith@wibble.com>   # yak
         self.setup_second()
 
         self.db_close()
-        args = Namespace(subcmd='ls')
+        args = Namespace(subcmd='ls', include_archived=False)
         with terminal.capture() as (out, _):
             control.do_series(args, test_db=self.tmpdir, pwork=True)
         lines = out.getvalue().splitlines()
@@ -780,6 +780,7 @@ Tested-by: Mary Smith <msmith@wibble.com>   # yak
 
         self.db_close()
         args.subcmd = 'ls'
+        args.include_archived = False
         with terminal.capture() as (out, _):
             control.do_series(args, test_db=self.tmpdir, pwork=True)
         lines = out.getvalue().splitlines()
@@ -2996,7 +2997,8 @@ Date:   .*
 
         with self.stage('latest versions'):
             args = Namespace(subcmd='progress', series='second',
-                             show_all_versions=False, list_patches=True)
+                             show_all_versions=False, list_patches=True,
+                             include_archived=False)
             with terminal.capture() as (out, _):
                 control.do_series(args, test_db=self.tmpdir, pwork=True)
             lines = iter(out.getvalue().splitlines())
@@ -3033,7 +3035,8 @@ Date:   .*
 
         with self.stage('progress with patches'):
             args = Namespace(subcmd='progress', series=None,
-                             show_all_versions=False, list_patches=True)
+                             show_all_versions=False, list_patches=True,
+                             include_archived=False)
             with terminal.capture() as (out, _):
                 control.do_series(args, test_db=self.tmpdir, pwork=True)
             lines = iter(out.getvalue().splitlines())
@@ -3048,6 +3051,35 @@ Date:   .*
             self._check_first(lines)
             self._check_second(lines, True)
 
+    def test_series_progress_all_archived(self):
+        """Test showing progress for all cseries including archived ones"""
+        self.setup_second()
+        self.cser.archive('first')
+
+        with self.stage('progress without archived'):
+            with terminal.capture() as (out, _):
+                self.run_args('series', 'progress', pwork=True)
+            itr = iter(out.getvalue().splitlines())
+            self.assertEqual(
+                'Name             Description                               Count  Status',
+                next(itr))
+            self.assertTrue(next(itr).startswith('--'))
+            self.assertEqual(
+                'second2          The name of the cover letter              '
+                '    3  1:accepted 1:changes 1:rejected', next(itr))
+
+        with self.stage('progress with archived'):
+            with terminal.capture() as (out, _):
+                self.run_args('series', 'progress', '--include-archived',
+                              pwork=True)
+            lines = out.getvalue().splitlines()
+            self.assertEqual(
+                'first                                                      '
+                '    2  2:unknown', lines[2])
+            self.assertEqual(
+                'second2          The name of the cover letter              '
+                '    3  1:accepted 1:changes 1:rejected', lines[3])
+
     def test_series_progress_no_patches(self):
         """Test showing progress for all cseries without patches"""
         self.setup_second()
-- 
2.43.0

base-commit: e3ced530e543c9f24cbc66430abc6109ce8df015
branch: pate
