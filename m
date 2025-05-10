Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8640DC3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAD3782ABA;
	Sat, 10 May 2025 13:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CvBbT4zA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76CD182B37; Sat, 10 May 2025 13:06:30 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45D1782ABA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5fbc736f0c7so4334837a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875187; x=1747479987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksGNRaZk49m65/mjJG9hKDK89Jsnq85eio8iTdifZQ4=;
 b=CvBbT4zAcKIFiyWv99Tf4eFeQIzdeHuHsuzoyVqyjBhYP4KLZQI1bBOQRUtQ6bZoHt
 GCzOeow17Pi6xSOvK9iIIh7j8dlTHx19AcUvw8kLNXxQ7id2K5no4rCUkf9vO+NhBJul
 ZyQdfUvUGDXH5fDsGUtWYxl4E8LQ0LoOKmEGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875187; x=1747479987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksGNRaZk49m65/mjJG9hKDK89Jsnq85eio8iTdifZQ4=;
 b=EeDbzwxE40Jiq+q1dRryr5Q1Vs9WtXHCM+W8qj/qdbXhvKKECIUst1C99g0jkRqQi6
 CLXgCP/qownhj+F/ekfhQ22AUuAlYrYJZeLm3UBmzn1w2eODee0wqE0r5BLAm64A+XSt
 C3AKdNwxp2mYbbtujogrLFZGnUcyhwXozCIWj0ByJS7AQhjpKjYu4H943poEvF5cdFt+
 vIdwKsaihihbtUXn0AvzVT01i/YtTWmxMAjxaOLYPB+co94f2f7342UJsVEc1Ux4KFq2
 Ck309gMrp6vWLU+/bCrcHxBWrY79TVERUGuVrRLloTaAQlcMtRrgqrD9xPuI4FVvzJcF
 FkCA==
X-Gm-Message-State: AOJu0Yw9bgZ4vabgNjvCsDmXqruAYqTIJcO/nTt05UFIW38e4jH6cv9K
 OB1aHwtlE1qtDjKapR2vHXaMtUW2LqAIFqAIDEVAwY5gNtKgbqYFaBLXtErFus/cJRqOszStrrl
 Fmufvroij7w==
X-Gm-Gg: ASbGncvb9cDYRZ4W1D3tU8i9Mic3ljm4a9FhRdgLY1L0SZU7JVMNPDepbnPzpnprga7
 ik/jjGcLmsMl2z7LuknXCleKcFM8jPvUnfW+AnHxkg0ZnVpxRPLzscIWwoyJzPJXX/Rb7Hgui+Q
 siqBHu7ulH38tkyGPhuO0xOXE8nHEVwFNG2awwjxRITUsXt2Yls6ZwLYkRoxW+aSN1SzUoLTxOF
 5Uau+iBWJ1AEzysqevaB674EqVWtM08dGiOywmR/f47JsHkVLjV8oxT1FYFMuuYYbHvOZRIkG9I
 Ij+L8QTc/FTCIuxLDRgc2CtcMgTjnD/uC+KRBFleB+XRNj8=
X-Google-Smtp-Source: AGHT+IFI+GkKQa88O+f2PIVGPxZknWR5lreDFgntQ+kgof9UBZzn5N8XTJHQAXeFDNuwWJijhw891Q==
X-Received: by 2002:a17:907:1819:b0:ac7:edfb:5210 with SMTP id
 a640c23a62f3a-ad218f5280dmr724469866b.20.1746875187135; 
 Sat, 10 May 2025 04:06:27 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:06:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 22/25] patman: Implement the series subcommand
Date: Sat, 10 May 2025 13:05:15 +0200
Message-ID: <20250510110535.1453745-23-sjg@chromium.org>
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

Add a command to support management of series. These are local branches
which may have been sent to the mailing list, so may appear on the
patchwork server.

The new functionality uses a database, stored in a local file.

Various operations are supported:
   - add a new series
   - send a series and automatically link it with patchwork
   - 'increment' the version, to prepare to send an updated series
   - gather review/test tags from patchwork
   - check on progress, i.e. patches which are received new tags or
     comments
   - show comments on patches and cover letters

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 183 ++++++++++++++++++++++++++++++++++++++++
 tools/patman/control.py | 107 +++++++++++++++++++++++
 2 files changed, 290 insertions(+)

diff --git a/tools/patman/cmdline.py b/tools/patman/cmdline.py
index 18434af4cb7..10ed1b17d21 100644
--- a/tools/patman/cmdline.py
+++ b/tools/patman/cmdline.py
@@ -22,10 +22,21 @@ HAS_TESTS = os.path.exists(PATMAN_DIR / "func_test.py")
 
 # Aliases for subcommands
 ALIASES = {
+    'series': ['s', 'ser'],
     'status': ['st'],
     'patchwork': ['pw'],
+
+    # Series aliases
+    'archive': ['ar'],
+    'autolink': ['au'],
+    'gather': ['g'],
+    'open': ['o'],
+    'progress': ['p', 'pr', 'prog'],
+    'rm-version': ['rmv'],
+    'unarchive': ['unar'],
     }
 
+
 class ErrorCatchingArgumentParser(argparse.ArgumentParser):
     def __init__(self, **kwargs):
         self.exit_state = None
@@ -121,6 +132,11 @@ def _add_show_comments(parser):
                         help='Show comments from each patch')
 
 
+def _add_show_cover_comments(parser):
+    parser.add_argument('-C', '--show-cover-comments', action='store_true',
+                        help='Show comments from the cover letter')
+
+
 def add_patchwork_subparser(subparsers):
     """Add the 'patchwork' subparser
 
@@ -144,6 +160,171 @@ def add_patchwork_subparser(subparsers):
     return patchwork
 
 
+def add_series_subparser(subparsers):
+    """Add the 'series' subparser
+
+    Args:
+        subparsers (argparse action): Subparser parent
+
+    Return:
+        ArgumentParser: series subparser
+    """
+    def _add_allow_unmarked(parser):
+        parser.add_argument('-M', '--allow-unmarked', action='store_true',
+                            default=False,
+                            help="Don't require commits to be marked")
+
+    def _add_mark(parser):
+        parser.add_argument(
+            '-m', '--mark', action='store_true',
+            help='Mark unmarked commits with a Change-Id field')
+
+    def _add_update(parser):
+        parser.add_argument('-u', '--update', action='store_true',
+                            help='Update the branch commit')
+
+    def _add_wait(parser, default_s):
+        """Add a -w option to a parser
+
+        Args:
+            parser (ArgumentParser): Parser to adjust
+            default_s (int): Default value to use, in seconds
+        """
+        parser.add_argument(
+            '-w', '--autolink-wait', type=int, default=default_s,
+            help='Seconds to wait for patchwork to get a sent series')
+
+    def _upstream_add(parser):
+        parser.add_argument('-U', '--upstream', help='Commit to end before')
+
+    def _add_gather(parser):
+        parser.add_argument(
+            '-G', '--no-gather-tags', dest='gather_tags', default=True,
+            action='store_false',
+            help="Don't gather review/test tags / update local series")
+
+    series = subparsers.add_parser('series', aliases=ALIASES['series'],
+                                   help='Manage series of patches')
+    series.defaults_cmds = [
+        ['set-link', 'fred'],
+    ]
+    series.add_argument(
+        '-n', '--dry-run', action='store_true', dest='dry_run', default=False,
+        help="Do a dry run (create but don't email patches)")
+    series.add_argument('-s', '--series', help='Name of series')
+    series.add_argument('-V', '--version', type=int,
+                        help='Version number to link')
+    series_subparsers = series.add_subparsers(dest='subcmd')
+
+    # This causes problem at present, perhaps due to the 'defaults' handling in
+    # settings
+    # series_subparsers.required = True
+
+    add = series_subparsers.add_parser('add')
+    add.add_argument('-D', '--desc',
+                     help='Series description / cover-letter title')
+    add.add_argument(
+        '-f', '--force-version', action='store_true',
+        help='Change the Series-version on a series to match its branch')
+    _add_mark(add)
+    _add_allow_unmarked(add)
+    _upstream_add(add)
+
+    series_subparsers.add_parser('archive', aliases=ALIASES['archive'])
+
+    auto = series_subparsers.add_parser('autolink',
+                                        aliases=ALIASES['autolink'])
+    _add_update(auto)
+    _add_wait(auto, 0)
+
+    aall = series_subparsers.add_parser('autolink-all')
+    aall.add_argument('-a', '--link-all-versions', action='store_true',
+                      help='Link all series versions, not just the latest')
+    aall.add_argument('-r', '--replace-existing', action='store_true',
+                      help='Replace existing links')
+    _add_update(aall)
+
+    series_subparsers.add_parser('dec')
+
+    gat = series_subparsers.add_parser('gather', aliases=ALIASES['gather'])
+    _add_gather(gat)
+    _add_show_comments(gat)
+    _add_show_cover_comments(gat)
+
+    sall = series_subparsers.add_parser('gather-all')
+    sall.add_argument(
+        '-a', '--gather-all-versions', action='store_true',
+        help='Gather tags from all series versions, not just the latest')
+    _add_gather(sall)
+    _add_show_comments(sall)
+    _add_show_cover_comments(sall)
+
+    series_subparsers.add_parser('get-link')
+    series_subparsers.add_parser('inc')
+    series_subparsers.add_parser('ls')
+
+    mar = series_subparsers.add_parser('mark')
+    mar.add_argument('-m', '--allow-marked', action='store_true',
+                     default=False,
+                     help="Don't require commits to be unmarked")
+
+    series_subparsers.add_parser('open', aliases=ALIASES['open'])
+    pat = series_subparsers.add_parser(
+        'patches', epilog='Show a list of patches and optional details')
+    pat.add_argument('-t', '--commit', action='store_true',
+                     help='Show the commit and diffstat')
+    pat.add_argument('-p', '--patch', action='store_true',
+                     help='Show the patch body')
+
+    prog = series_subparsers.add_parser('progress',
+                                        aliases=ALIASES['progress'])
+    prog.add_argument('-a', '--show-all-versions', action='store_true',
+                      help='Show all series versions, not just the latest')
+    prog.add_argument('-l', '--list-patches', action='store_true',
+                      help='List patch subject and status')
+
+    ren = series_subparsers.add_parser('rename')
+    ren.add_argument('-N', '--new-name', help='New name for the series')
+
+    series_subparsers.add_parser('rm')
+    series_subparsers.add_parser('rm-version', aliases=ALIASES['rm-version'])
+
+    scan = series_subparsers.add_parser('scan')
+    _add_mark(scan)
+    _add_allow_unmarked(scan)
+    _upstream_add(scan)
+
+    ssend = series_subparsers.add_parser('send')
+    add_send_args(ssend)
+    ssend.add_argument(
+        '--no-autolink', action='store_false', default=True, dest='autolink',
+        help='Monitor patchwork after sending so the series can be autolinked')
+    _add_wait(ssend, 120)
+
+    setl = series_subparsers.add_parser('set-link')
+    _add_update(setl)
+
+    setl.add_argument(
+        'link', help='Link to use, i.e. patchwork series number (e.g. 452329)')
+    stat = series_subparsers.add_parser('status', aliases=ALIASES['status'])
+    _add_show_comments(stat)
+    _add_show_cover_comments(stat)
+
+    series_subparsers.add_parser('summary')
+
+    series_subparsers.add_parser('unarchive', aliases=ALIASES['unarchive'])
+
+    unm = series_subparsers.add_parser('unmark')
+    _add_allow_unmarked(unm)
+
+    ver = series_subparsers.add_parser(
+        'version-change', help='Change a version to a different version')
+    ver.add_argument('--new-version', type=int,
+                     help='New version number to change this one too')
+
+    return series
+
+
 def add_send_subparser(subparsers):
     """Add the 'send' subparser
 
@@ -230,6 +411,7 @@ def setup_parser():
     subparsers = parser.add_subparsers(dest='cmd')
     add_send_subparser(subparsers)
     patchwork = add_patchwork_subparser(subparsers)
+    series = add_series_subparser(subparsers)
     add_status_subparser(subparsers)
 
     # Only add the 'test' action if the test data files are available.
@@ -240,6 +422,7 @@ def setup_parser():
 
     parsers = {
         'main': parser,
+        'series': series,
         'patchwork': patchwork,
         }
     return parsers
diff --git a/tools/patman/control.py b/tools/patman/control.py
index a7d381c3008..7467506dcbc 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -113,6 +113,111 @@ def patchwork_status(branch, count, start, end, dest_branch, force,
                                  show_comments, False, pwork)
 
 
+def do_series(args, test_db=None, pwork=None, cser=None):
+    """Process a series subcommand
+
+    Args:
+        args (Namespace): Arguments to process
+        test_db (str or None): Directory containing the test database, None to
+            use the normal one
+        pwork (Patchwork): Patchwork object to use, None to create one if
+            needed
+        cser (Cseries): Cseries object to use, None to create one
+    """
+    if not cser:
+        cser = cseries.Cseries(test_db)
+    needs_patchwork = [
+        'autolink', 'autolink-all', 'open', 'send', 'status', 'gather',
+        'gather-all'
+        ]
+    try:
+        cser.open_database()
+        if args.subcmd in needs_patchwork:
+            if not pwork:
+                pwork = Patchwork(args.patchwork_url)
+                proj = cser.project_get()
+                if not proj:
+                    raise ValueError(
+                        "Please set project ID with 'patman patchwork set-project'")
+                _, proj_id, link_name = cser.project_get()
+                pwork.project_set(proj_id, link_name)
+        elif pwork and pwork is not True:
+            raise ValueError(
+                f"Internal error: command '{args.subcmd}' should not have patchwork")
+        if args.subcmd == 'add':
+            cser.add(args.series, args.desc, mark=args.mark,
+                     allow_unmarked=args.allow_unmarked, end=args.upstream,
+                     dry_run=args.dry_run)
+        elif args.subcmd == 'archive':
+            cser.archive(args.series)
+        elif args.subcmd == 'autolink':
+            cser.link_auto(pwork, args.series, args.version, args.update,
+                           args.autolink_wait)
+        elif args.subcmd == 'autolink-all':
+            cser.link_auto_all(pwork, update_commit=args.update,
+                               link_all_versions=args.link_all_versions,
+                               replace_existing=args.replace_existing,
+                               dry_run=args.dry_run, show_summary=True)
+        elif args.subcmd == 'dec':
+            cser.decrement(args.series, args.dry_run)
+        elif args.subcmd == 'gather':
+            cser.gather(pwork, args.series, args.version, args.show_comments,
+                        args.show_cover_comments, args.gather_tags,
+                        dry_run=args.dry_run)
+        elif args.subcmd == 'gather-all':
+            cser.gather_all(
+                pwork, args.show_comments, args.show_cover_comments,
+                args.gather_all_versions, args.gather_tags, args.dry_run)
+        elif args.subcmd == 'get-link':
+            link = cser.link_get(args.series, args.version)
+            print(link)
+        elif args.subcmd == 'inc':
+            cser.increment(args.series, args.dry_run)
+        elif args.subcmd == 'ls':
+            cser.series_list()
+        elif args.subcmd == 'open':
+            cser.open(pwork, args.series, args.version)
+        elif args.subcmd == 'mark':
+            cser.mark(args.series, args.allow_marked, dry_run=args.dry_run)
+        elif args.subcmd == 'patches':
+            cser.list_patches(args.series, args.version, args.commit,
+                              args.patch)
+        elif args.subcmd == 'progress':
+            cser.progress(args.series, args.show_all_versions,
+                          args.list_patches)
+        elif args.subcmd == 'rm':
+            cser.remove(args.series, dry_run=args.dry_run)
+        elif args.subcmd == 'rm-version':
+            cser.version_remove(args.series, args.version, dry_run=args.dry_run)
+        elif args.subcmd == 'rename':
+            cser.rename(args.series, args.new_name, dry_run=args.dry_run)
+        elif args.subcmd == 'scan':
+            cser.scan(args.series, mark=args.mark,
+                      allow_unmarked=args.allow_unmarked, end=args.upstream,
+                      dry_run=args.dry_run)
+        elif args.subcmd == 'send':
+            cser.send(pwork, args.series, args.autolink, args.autolink_wait,
+                      args)
+        elif args.subcmd == 'set-link':
+            cser.link_set(args.series, args.version, args.link, args.update)
+        elif args.subcmd == 'status':
+            cser.status(pwork, args.series, args.version, args.show_comments,
+                        args.show_cover_comments)
+        elif args.subcmd == 'summary':
+            cser.summary(args.series)
+        elif args.subcmd == 'unarchive':
+            cser.unarchive(args.series)
+        elif args.subcmd == 'unmark':
+            cser.unmark(args.series, args.allow_unmarked, dry_run=args.dry_run)
+        elif args.subcmd == 'version-change':
+            cser.version_change(args.series, args.version, args.new_version,
+                                dry_run=args.dry_run)
+        else:
+            raise ValueError(f"Unknown series subcommand '{args.subcmd}'")
+    finally:
+        cser.close_database()
+
+
 def patchwork(args, test_db=None, pwork=None):
     """Process a 'patchwork' subcommand
     Args:
@@ -181,6 +286,8 @@ def do_patman(args, test_db=None, pwork=None, cser=None):
             patchwork_status(args.branch, args.count, args.start, args.end,
                              args.dest_branch, args.force, args.show_comments,
                              args.patchwork_url)
+        elif args.cmd == 'series':
+            do_series(args, test_db, pwork, cser)
         elif args.cmd == 'patchwork':
             patchwork(args, test_db, pwork)
     except Exception as exc:
-- 
2.43.0

