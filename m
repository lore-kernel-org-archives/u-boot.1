Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0B2CE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:46:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0963886B5E;
	Sat, 23 Sep 2023 21:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fVl6B6aT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C42386B0D; Sat, 23 Sep 2023 21:44:40 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EF868684C
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-34fc7f51441so12931605ab.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498275; x=1696103075; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3wZYv343RY85g6H8hf1MGduStbk/Nkz43y1K+nNTHU=;
 b=fVl6B6aT4Xp6CmYKnt0yBjMTFfLauh6wHzq4yuEr5lrm/e9Sn0r7rASid2Cvu70TYX
 edeHagsZLbEeET1g3Cmz5VBszPiYnqqm3PlE6J47W6SOT3uVu9mSyfJ9uxBwKXS43+QS
 1ip5NxneUZQ1ztzVha047s7OyP3XPRWPKr4VM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498275; x=1696103075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w3wZYv343RY85g6H8hf1MGduStbk/Nkz43y1K+nNTHU=;
 b=Pc5Xnkm53d1DKqWyl0zC0Nll1vOVxR0WFdKnw73EPIrRLh1mW8tNx96Aext/xloP8C
 5ISpVtOlmvUNcfsVirsk8wcYe0H1pCNiY0SDOR1YxSboIS9loTSvITwfvWB282MoPKxc
 794WOTJPdX1P5tyLJ7XgqIiooywoi7vIGuOiEy/HqM4e1fNx6U/q9sfbuyhmpjoPFY42
 iUlSDYnCAx0YUVe8YoR7LwH7EBA2UAzwVaf1QznTWn9BFw0s6qD6UZ0JcXbphUiPhvM9
 JwUipz24kp9/15rRRPwv0if1c7Itj6zGaaJyB9Dw1vIUa6BEfK4i8qbGOhFWHR0roPHo
 PHdA==
X-Gm-Message-State: AOJu0Yw9mqe/YA+1kvyTqkHSQQ8y4YuD85BNul1ietumWxCtV8zSCPBu
 dafrfuki0bWZ4YpAFyTIGkpAoVhFyN161oHDgZo=
X-Google-Smtp-Source: AGHT+IEquDrCF9x85k4bPmosyiCT0Zfj0eOjQgP1Rwr6y2DBhGXhwpiXmi8opv71qJwFALFzwakpDQ==
X-Received: by 2002:a05:6e02:d05:b0:34f:e7a8:7449 with SMTP id
 g5-20020a056e020d0500b0034fe7a87449mr2863872ilj.24.1695498274593; 
 Sat, 23 Sep 2023 12:44:34 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 el9-20020a0566384d8900b00439d4db47b6sm1697786jab.39.2023.09.23.12.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 12:44:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 05/27] moveconfig: Drop CONFIG-moving code
Date: Sat, 23 Sep 2023 13:43:54 -0600
Message-ID: <20230923194424.1739224-6-sjg@chromium.org>
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

As a step towards cleaning out old code, drop most of the code that moves
CONFIG options to Kconfig. This includes parse_one_config().

Drop the ACTION_... values as well, since they are no-longer used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 163 ++++++--------------------------------------
 1 file changed, 19 insertions(+), 144 deletions(-)

diff --git a/tools/moveconfig.py b/tools/moveconfig.py
index 476603ce1472..a4e160005178 100755
--- a/tools/moveconfig.py
+++ b/tools/moveconfig.py
@@ -42,11 +42,6 @@ STATE_DEFCONFIG = 1
 STATE_AUTOCONF = 2
 STATE_SAVEDEFCONFIG = 3
 
-ACTION_MOVE = 0
-ACTION_NO_ENTRY = 1
-ACTION_NO_ENTRY_WARN = 2
-ACTION_NO_CHANGE = 3
-
 COLOR_BLACK        = '0;30'
 COLOR_RED          = '0;31'
 COLOR_GREEN        = '0;32'
@@ -312,15 +307,13 @@ class KconfigParser:
     re_arch = re.compile(r'CONFIG_SYS_ARCH="(.*)"')
     re_cpu = re.compile(r'CONFIG_SYS_CPU="(.*)"')
 
-    def __init__(self, configs, args, build_dir):
+    def __init__(self, args, build_dir):
         """Create a new parser.
 
         Args:
-          configs: A list of CONFIGs to move.
           args (Namespace): program arguments
           build_dir: Build directory.
         """
-        self.configs = configs
         self.args = args
         self.dotconfig = os.path.join(build_dir, '.config')
         self.autoconf = os.path.join(build_dir, 'include', 'autoconf.mk')
@@ -355,56 +348,6 @@ class KconfigParser:
 
         return arch
 
-    def parse_one_config(self, config, dotconfig_lines, autoconf_lines):
-        """Parse .config, defconfig, include/autoconf.mk for one config.
-
-        This function looks for the config options in the lines from
-        defconfig, .config, and include/autoconf.mk in order to decide
-        which action should be taken for this defconfig.
-
-        Args:
-          config: CONFIG name to parse.
-          dotconfig_lines: lines from the .config file.
-          autoconf_lines: lines from the include/autoconf.mk file.
-
-        Returns:
-          A tupple of the action for this defconfig and the line
-          matched for the config.
-        """
-        not_set = '# %s is not set' % config
-
-        for line in autoconf_lines:
-            line = line.rstrip()
-            if line.startswith(config + '='):
-                new_val = line
-                break
-        else:
-            new_val = not_set
-
-        new_val = try_expand(new_val)
-
-        for line in dotconfig_lines:
-            line = line.rstrip()
-            if line.startswith(config + '=') or line == not_set:
-                old_val = line
-                break
-        else:
-            if new_val == not_set:
-                return (ACTION_NO_ENTRY, config)
-            else:
-                return (ACTION_NO_ENTRY_WARN, config)
-
-        # If this CONFIG is neither bool nor trisate
-        if old_val[-2:] != '=y' and old_val[-2:] != '=m' and old_val != not_set:
-            # tools/scripts/define2mk.sed changes '1' to 'y'.
-            # This is a problem if the CONFIG is int type.
-            # Check the type in Kconfig and handle it correctly.
-            if new_val[-2:] == '=y':
-                new_val = new_val[:-1] + '1'
-
-        return (ACTION_NO_CHANGE if old_val == new_val else ACTION_MOVE,
-                new_val)
-
     def update_dotconfig(self):
         """Parse files for the config options and update the .config.
 
@@ -420,66 +363,17 @@ class KconfigParser:
           The "updated flag" is True if the .config was updated, False
           otherwise.  The "log string" shows what happend to the .config.
         """
-
-        results = []
         updated = False
         suspicious = False
-        rm_files = [self.config_autoconf, self.autoconf]
 
-        if self.args.spl:
-            if os.path.exists(self.spl_autoconf):
-                autoconf_path = self.spl_autoconf
-                rm_files.append(self.spl_autoconf)
-            else:
-                for f in rm_files:
-                    os.remove(f)
-                return (updated, suspicious,
-                        color_text(self.args.color, COLOR_BROWN,
-                                   "SPL is not enabled.  Skipped.") + '\n')
-        else:
-            autoconf_path = self.autoconf
+        autoconf_path = self.autoconf
 
         dotconfig_lines = read_file(self.dotconfig)
 
         autoconf_lines = read_file(autoconf_path)
 
-        for config in self.configs:
-            result = self.parse_one_config(config, dotconfig_lines,
-                                           autoconf_lines)
-            results.append(result)
-
         log = ''
 
-        for (action, value) in results:
-            if action == ACTION_MOVE:
-                actlog = "Move '%s'" % value
-                log_color = COLOR_LIGHT_GREEN
-            elif action == ACTION_NO_ENTRY:
-                actlog = '%s is not defined in Kconfig.  Do nothing.' % value
-                log_color = COLOR_LIGHT_BLUE
-            elif action == ACTION_NO_ENTRY_WARN:
-                actlog = '%s is not defined in Kconfig (suspicious).  Do nothing.' % value
-                log_color = COLOR_YELLOW
-                suspicious = True
-            elif action == ACTION_NO_CHANGE:
-                actlog = "'%s' is the same as the define in Kconfig.  Do nothing." \
-                         % value
-                log_color = COLOR_LIGHT_PURPLE
-            else:
-                sys.exit('Internal Error. This should not happen.')
-
-            log += color_text(self.args.color, log_color, actlog) + '\n'
-
-        with open(self.dotconfig, 'a', encoding='utf-8') as out:
-            for (action, value) in results:
-                if action == ACTION_MOVE:
-                    out.write(value + '\n')
-                    updated = True
-
-        self.results = results
-        for f in rm_files:
-            os.remove(f)
-
         return (updated, suspicious, log)
 
     def check_defconfig(self):
@@ -494,14 +388,6 @@ class KconfigParser:
 
         defconfig_lines = read_file(self.defconfig)
 
-        for (action, value) in self.results:
-            if action != ACTION_MOVE:
-                continue
-            if not value in defconfig_lines:
-                log += color_text(self.args.color, COLOR_YELLOW,
-                                  "'%s' was removed by savedefconfig.\n" %
-                                  value)
-
         return log
 
 
@@ -541,13 +427,12 @@ class Slot:
     for faster processing.
     """
 
-    def __init__(self, toolchains, configs, args, progress, devnull,
+    def __init__(self, toolchains, args, progress, devnull,
 		 make_cmd, reference_src_dir, db_queue):
         """Create a new process slot.
 
         Args:
           toolchains: Toolchains object containing toolchains.
-          configs: A list of CONFIGs to move.
           args: Program arguments
           progress: A progress indicator.
           devnull: A file object of '/dev/null'.
@@ -564,7 +449,7 @@ class Slot:
         self.make_cmd = (make_cmd, 'O=' + self.build_dir)
         self.reference_src_dir = reference_src_dir
         self.db_queue = db_queue
-        self.parser = KconfigParser(configs, args, self.build_dir)
+        self.parser = KconfigParser(args, self.build_dir)
         self.state = STATE_IDLE
         self.failed_boards = set()
         self.suspicious_boards = set()
@@ -783,13 +668,11 @@ class Slots:
 
     """Controller of the array of subprocess slots."""
 
-    def __init__(self, toolchains, configs, args, progress,
-		 reference_src_dir, db_queue):
+    def __init__(self, toolchains, args, progress, reference_src_dir, db_queue):
         """Create a new slots controller.
 
         Args:
           toolchains: Toolchains object containing toolchains.
-          configs: A list of CONFIGs to move.
           args: Program arguments
           progress: A progress indicator.
           reference_src_dir: Determine the true starting config state from this
@@ -801,9 +684,8 @@ class Slots:
         devnull = subprocess.DEVNULL
         make_cmd = get_make_cmd()
         for i in range(args.jobs):
-            self.slots.append(Slot(toolchains, configs, args, progress,
-				   devnull, make_cmd, reference_src_dir,
-				   db_queue))
+            self.slots.append(Slot(toolchains, args, progress, devnull,
+                                   make_cmd, reference_src_dir, db_queue))
 
     def add(self, defconfig):
         """Add a new subprocess if a vacant slot is found.
@@ -913,22 +795,18 @@ class ReferenceSource:
 
         return self.src_dir
 
-def move_config(toolchains, configs, args, db_queue):
-    """Move config options to defconfig files.
+def move_config(toolchains, args, db_queue):
+    """Build database or sync config options to defconfig files.
 
     Args:
-      configs: A list of CONFIGs to move.
+      toolchains: Toolchains to use
       args: Program arguments
+      db_queue: Queue for database updates
     """
-    if len(configs) == 0:
-        if args.force_sync:
-            print('No CONFIG is specified. You are probably syncing defconfigs.', end=' ')
-        elif args.build_db:
-            print('Building %s database' % CONFIG_DATABASE)
-        else:
-            print('Neither CONFIG nor --force-sync is specified. Nothing will happen.', end=' ')
-    else:
-        print('Move ' + ', '.join(configs), end=' ')
+    if args.force_sync:
+        print('Syncing defconfigs', end=' ')
+    elif args.build_db:
+        print('Building %s database' % CONFIG_DATABASE)
     print('(jobs: %d)\n' % args.jobs)
 
     if args.git_ref:
@@ -943,8 +821,7 @@ def move_config(toolchains, configs, args, db_queue):
         defconfigs = get_all_defconfigs()
 
     progress = Progress(len(defconfigs))
-    slots = Slots(toolchains, configs, args, progress, reference_src_dir,
-                  db_queue)
+    slots = Slots(toolchains, args, progress, reference_src_dir, db_queue)
 
     # Main loop to process defconfig files:
     #  Add a new subprocess into a vacant slot.
@@ -1731,7 +1608,6 @@ doc/develop/moveconfig.rst for documentation.'''
     parser.add_argument('configs', nargs='*')
 
     args = parser.parse_args()
-    configs = args.configs
 
     if args.test:
         sys.argv = [sys.argv[0]]
@@ -1744,13 +1620,12 @@ doc/develop/moveconfig.rst for documentation.'''
         do_scan_source(os.getcwd(), args.update)
         return
 
-    if not any((len(configs), args.force_sync, args.build_db, args.imply,
-                args.find)):
+    if not any((args.force_sync, args.build_db, args.imply, args.find)):
         parser.print_usage()
         sys.exit(1)
 
     # prefix the option name with CONFIG_ if missing
-    configs = [prefix_config(cfg) for cfg in configs]
+    configs = [prefix_config(cfg) for cfg in args.configs]
 
     check_top_directory()
 
@@ -1791,7 +1666,7 @@ doc/develop/moveconfig.rst for documentation.'''
     toolchains = toolchain.Toolchains()
     toolchains.GetSettings()
     toolchains.Scan(verbose=False)
-    move_config(toolchains, [], args, db_queue)
+    move_config(toolchains, args, db_queue)
     db_queue.join()
 
     if args.commit:
-- 
2.42.0.515.g380fc7ccd1-goog

