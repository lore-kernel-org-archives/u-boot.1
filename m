Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3814BCE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B165586BC4;
	Sat, 23 Sep 2023 21:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VXdPnU9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D46E886B74; Sat, 23 Sep 2023 21:44:55 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA1186B70
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-79f96f83270so113290439f.1
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498289; x=1696103089; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYze1gdtJ9Lf1ng8/E/FlK7qXGkmO8QgNZmCc6Liv6E=;
 b=VXdPnU9yvY8vUuDYbZnfTsT6AP5oQX1rW2a5x/Z1m9G9v+P0d9v8bK1nOFHLmaQW2l
 9V62E5EINZaQgZuPfGfqmJTs54Q2RDzmoIyqiL3IpgkaCSou2FRcpk1mSMRQ1U6EtYBE
 Zsn9WzWLfD9Gpa2W6YGfTDQfJmWUOqNR6jU9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498289; x=1696103089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PYze1gdtJ9Lf1ng8/E/FlK7qXGkmO8QgNZmCc6Liv6E=;
 b=lrkmwGMPpwPZA3VGw1JW9+XuzBJjvpzjqQtRnu1S3JU3H4bP9t16EHycFvIZO7jBdL
 Mn2dbzl19Dope+t4BtvfzVzw8F9G+coPZglwQ8IGw6F5zQIUBulQu0oC0Pj6v8I91wkh
 D548xL915fgY8B/QpkuTZn6HtXyMVdwGR4q6IVRevHGOdCVNSOFA36KZTNvE4cDm3Umq
 l65hN91ssiiN2WHqqDWz85dHyK55GEqW5z988ZUWYiH6iJ7X4p0RV+ouiYN2A09JtbrY
 6+1zvxGjFWtHuKM2kg945E3cnHChWXThaVwGNUTSLJXDkxHZCs4NTtvQpNE6ENjGVzBf
 VvWg==
X-Gm-Message-State: AOJu0YzUz+JNvI1lc0Wspj50GsqsIOcA9GjbK3YGFgyazDPSDS6Ydy88
 XCjvTJwj6HLBurEst/23a95QsjdDGeG145cIw2Q=
X-Google-Smtp-Source: AGHT+IHC+0UfIkjlu4/Dip2c8KfmTDTZ1crh9uUmGsGJlZAEO55RxygJekR3ZH9sZ0h5Dba9a3VjAg==
X-Received: by 2002:a5d:9144:0:b0:792:9406:a453 with SMTP id
 y4-20020a5d9144000000b007929406a453mr2820013ioq.14.1695498289387; 
 Sat, 23 Sep 2023 12:44:49 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 20/27] moveconfig: Use u_boot_pylib for terminal colour
Date: Sat, 23 Sep 2023 13:44:09 -0600
Message-ID: <20230923194424.1739224-21-sjg@chromium.org>
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

Use the existing terminal code to handle ANSI colours. Enable colour by
default if the output is going to a terminal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 92 +++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 0131034a3787..9e9cb672a967 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -33,6 +33,7 @@ import asteval
 from buildman import bsettings
 from buildman import kconfiglib
 from buildman import toolchain
+from u_boot_pylib import terminal
 
 SHOW_GNU_MAKE = 'scripts/show-gnu-make'
 SLEEP_TIME=0.03
@@ -42,23 +43,6 @@ STATE_DEFCONFIG = 1
 STATE_AUTOCONF = 2
 STATE_SAVEDEFCONFIG = 3
 
-COLOR_BLACK        = '0;30'
-COLOR_RED          = '0;31'
-COLOR_GREEN        = '0;32'
-COLOR_BROWN        = '0;33'
-COLOR_BLUE         = '0;34'
-COLOR_PURPLE       = '0;35'
-COLOR_CYAN         = '0;36'
-COLOR_LIGHT_GRAY   = '0;37'
-COLOR_DARK_GRAY    = '1;30'
-COLOR_LIGHT_RED    = '1;31'
-COLOR_LIGHT_GREEN  = '1;32'
-COLOR_YELLOW       = '1;33'
-COLOR_LIGHT_BLUE   = '1;34'
-COLOR_LIGHT_PURPLE = '1;35'
-COLOR_LIGHT_CYAN   = '1;36'
-COLOR_WHITE        = '1;37'
-
 AUTO_CONF_PATH = 'include/config/auto.conf'
 CONFIG_DATABASE = 'moveconfig.db'
 
@@ -189,15 +173,6 @@ def get_all_defconfigs():
 
     return defconfigs
 
-def color_text(color_enabled, color, string):
-    """Return colored string."""
-    if color_enabled:
-        # LF should not be surrounded by the escape sequence.
-        # Otherwise, additional whitespace or line-feed might be printed.
-        return '\n'.join([ '\033[' + color + 'm' + s + '\033[0m' if s else ''
-                           for s in string.split('\n') ])
-    return string
-
 def write_file(fname, data):
     """Write data to a file
 
@@ -385,8 +360,8 @@ class Slot:
     for faster processing.
     """
 
-    def __init__(self, toolchains, args, progress, devnull,
-		 make_cmd, reference_src_dir, db_queue):
+    def __init__(self, toolchains, args, progress, devnull, make_cmd,
+                 reference_src_dir, db_queue, col):
         """Create a new process slot.
 
         Args:
@@ -398,6 +373,7 @@ class Slot:
           reference_src_dir: Determine the true starting config state from this
                              source tree.
           db_queue: output queue to write config info for the database
+          col (terminal.Color): Colour object
         """
         self.toolchains = toolchains
         self.args = args
@@ -407,6 +383,7 @@ class Slot:
         self.make_cmd = (make_cmd, 'O=' + self.build_dir)
         self.reference_src_dir = reference_src_dir
         self.db_queue = db_queue
+        self.col = col
         self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
@@ -499,12 +476,11 @@ class Slot:
     def handle_error(self):
         """Handle error cases."""
 
-        self.log.append(color_text(self.args.color, COLOR_LIGHT_RED,
-                                   'Failed to process'))
+        self.log.append(self.col.build(self.col.RED, 'Failed to process',
+                                       bright=True))
         if self.args.verbose:
             for line in self.proc.stderr.read().decode().splitlines():
-                self.log.append(color_text(self.args.color, COLOR_LIGHT_CYAN,
-                                           line))
+                self.log.append(self.col.build(self.col.CYAN, line, True))
         self.finish(False)
 
     def do_defconfig(self):
@@ -524,8 +500,9 @@ class Slot:
         try:
             tchain = self.toolchains.Select(arch)
         except ValueError:
-            self.log.append(color_text(self.args.color, COLOR_YELLOW,
-                    f"Tool chain for '{arch}' is missing: do nothing"))
+            self.log.append(self.col.build(
+                self.col.YELLOW,
+                f"Tool chain for '{arch}' is missing: do nothing"))
             self.finish(False)
             return
         env = tchain.MakeEnvironment(False)
@@ -567,8 +544,8 @@ class Slot:
         updated = not filecmp.cmp(orig_defconfig, new_defconfig)
 
         if updated:
-            self.log.append(color_text(self.args.color, COLOR_LIGHT_BLUE,
-                                       'defconfig updated'))
+            self.log.append(
+                self.col.build(self.col.BLUE, 'defconfig updated', bright=True))
 
         if not self.args.dry_run and updated:
             shutil.move(new_defconfig, orig_defconfig)
@@ -614,24 +591,27 @@ class Slots:
 
     """Controller of the array of subprocess slots."""
 
-    def __init__(self, toolchains, args, progress, reference_src_dir, db_queue):
+    def __init__(self, toolchains, args, progress, reference_src_dir, db_queue,
+                 col):
         """Create a new slots controller.
 
         Args:
-          toolchains: Toolchains object containing toolchains.
-          args: Program arguments
-          progress: A progress indicator.
-          reference_src_dir: Determine the true starting config state from this
-                             source tree.
-          db_queue: output queue to write config info for the database
+            toolchains (Toolchains): Toolchains object containing toolchains
+            args (Namespace): Program arguments
+            progress (Progress): A progress indicator.
+            reference_src_dir (str): Determine the true starting config state
+                from this source tree (None for none)
+            db_queue (Queue): output queue to write config info for the database
+            col (terminal.Color): Colour object
         """
         self.args = args
         self.slots = []
+        self.col = col
         devnull = subprocess.DEVNULL
         make_cmd = get_make_cmd()
         for _ in range(args.jobs):
             self.slots.append(Slot(toolchains, args, progress, devnull,
-                                   make_cmd, reference_src_dir, db_queue))
+                                   make_cmd, reference_src_dir, db_queue, col))
 
     def add(self, defconfig):
         """Add a new subprocess if a vacant slot is found.
@@ -683,8 +663,8 @@ class Slots:
             msg = 'The following boards were not processed due to error:\n'
             msg += boards
             msg += f'(the list has been saved in {output_file})\n'
-            print(color_text(self.args.color, COLOR_LIGHT_RED,
-                                            msg), file=sys.stderr)
+            print(self.col.build(self.col.RED, msg, bright=True),
+                  file=sys.stderr)
 
             write_file(output_file, boards)
 
@@ -723,13 +703,14 @@ class ReferenceSource:
 
         return self.src_dir
 
-def move_config(toolchains, args, db_queue):
+def move_config(toolchains, args, db_queue, col):
     """Build database or sync config options to defconfig files.
 
     Args:
-      toolchains (Toolchains): Toolchains to use
-      args (Namespace): Program arguments
-      db_queue (Queue): Queue for database updates
+        toolchains (Toolchains): Toolchains to use
+        args (Namespace): Program arguments
+        db_queue (Queue): Queue for database updates
+        col (terminal.Color): Colour object
     """
     if args.force_sync:
         print('Syncing defconfigs', end=' ')
@@ -749,7 +730,7 @@ def move_config(toolchains, args, db_queue):
         defconfigs = get_all_defconfigs()
 
     progress = Progress(len(defconfigs))
-    slots = Slots(toolchains, args, progress, reference_src_dir, db_queue)
+    slots = Slots(toolchains, args, progress, reference_src_dir, db_queue, col)
 
     # Main loop to process defconfig files:
     #  Add a new subprocess into a vacant slot.
@@ -1495,10 +1476,10 @@ doc/develop/moveconfig.rst for documentation.'''
                       'implying others')
     parser.add_argument('-b', '--build-db', action='store_true', default=False,
                       help='build a CONFIG database')
-    parser.add_argument('-c', '--color', action='store_true', default=False,
-                      help='display the log in color')
     parser.add_argument('-C', '--commit', action='store_true', default=False,
                       help='Create a git commit for the operation')
+    parser.add_argument('--nocolour', action='store_true', default=False,
+                      help="don't display the log in colour")
     parser.add_argument('-d', '--defconfigs', type=str,
                       help='a file containing a list of defconfigs to move, '
                       "one per line (for example 'snow_defconfig') "
@@ -1543,6 +1524,9 @@ doc/develop/moveconfig.rst for documentation.'''
             return 1
         unittest.main()
 
+    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
+                         else terminal.COLOR_IF_TERMINAL)
+
     if args.scan_source:
         do_scan_source(os.getcwd(), args.update)
         return 0
@@ -1593,7 +1577,7 @@ doc/develop/moveconfig.rst for documentation.'''
     toolchains = toolchain.Toolchains()
     toolchains.GetSettings()
     toolchains.Scan(verbose=False)
-    move_config(toolchains, args, db_queue)
+    move_config(toolchains, args, db_queue, col)
     db_queue.join()
 
     if args.commit:
-- 
2.42.0.515.g380fc7ccd1-goog

