Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E4B7C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 989AC84A48;
	Tue,  7 Jul 2026 13:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MnqxZjZ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878B084A5F; Tue,  7 Jul 2026 13:36:32 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9500084A48
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-44ce674ed17so2438161fac.0
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 04:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783424188; x=1784028988; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Vr1W2ZucIDDD/n5eLzAB6fACRFMwWdzX+2nHpJzFrU=;
 b=MnqxZjZ7/fpDjLJ4LrcRvYp6/FX4hKN9FR1o7JrukcY6A/SbKmYST2SEdVprWy1Jlq
 uEXXN5nIDs0KtGU5Lf9guueQgy2cOthwcbA2Gya6NXV6uT0AAhu+CuitATw+gHDdD+WM
 Nj64zLaKm/k0Am7TkK8AgYoeGbL02u7Y7ato4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424188; x=1784028988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Vr1W2ZucIDDD/n5eLzAB6fACRFMwWdzX+2nHpJzFrU=;
 b=R2l8Qwok/mcvyx/uJMSawTDfrPWuRLg8mU5JeYaJQWzTjWb2PpsY/eihTgCIdprh3d
 5lv3XcX/cxExocSjDpWaYpx+ycCMbN43wxx86hQn/EOoh527rEM6MrdGkbV34AS8a9HU
 DTJeDYTAyHj9ir5+qqOtcuu6rXq0CMY9OJ57fMzF2MjBgwr3tLk7BvXv4spvRwev3qbM
 BuUIjDGMn543o2onG2tx3ArABtCAyFz3bT8ABKfbflspDORucpfAqZXbHjUk/zPGfjcQ
 PnGjadXAc+Fw9l6Ii9QVCIyxIuceHiVzlsG1Y2Vx3kRAgYDuBxdT4KZxke9LVimDfoxv
 CCSQ==
X-Gm-Message-State: AOJu0YwFfc3wz6LVE4OIhObDcwyfWDMlGM+Xio5xzxbo8gX6LN24iK/k
 YursYRUfzkrMhAqRgOaGUDGfVjqSapfLcP23POQ/AKZiRXvmAJOkcP186vdbDXs63nlT9T6/7Zu
 oxg4Iyg==
X-Gm-Gg: AfdE7ckD6kGf83BmodAEheIHYGFKwsa3Xm7wSIgeFvyMHDJxeVSg8lnMLnk2XeC0SJa
 UgbGg6gMAz+mqCTirZdGsWqcDY9d5n/hHa8CdwJLtfPMZmg4NcP7zN6q6ahCOte4sVI2yzIEsS3
 KY+e6S71lBlgNl9XBsyRPKjnEiT7/oR1pnSbGcxapnIJWAelD0ElyCbP9s7RHiR4Fs8Olyd9R1x
 87DC409Kb6RKEe/MJCALrMYzuVB49mSGchZFL+3e0i8P40RG6SR+EAju75arTNZ/s69yIhknqfX
 Pjzl5M8rNxiazyOmWEsKX2Ia2f/gLHDi5exhGeZk+pqorcVkhqRV532pT+BAzOe1QaS5C9FUQNV
 8Yj4zPSLL4jpZK8JrGrJhsgZ3DMa6hturAccJlmc/RimShrxZOlhRAN2kFFxvHmKlppcFE3OIK6
 yAXRampY4=
X-Received: by 2002:a05:6870:21f5:b0:43d:2ec2:ff3b with SMTP id
 586e51a60fabf-45105d51145mr3400875fac.30.1783424188028; 
 Tue, 07 Jul 2026 04:36:28 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb6691d1sm13440825fac.17.2026.07.07.04.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 04:36:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/13] qconfig: Use kconfiglib for -r (git-ref) sync path
Date: Tue,  7 Jul 2026 05:35:13 -0600
Message-ID: <20260707113538.3382145-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707113538.3382145-1-sjg@chromium.org>
References: <20260707113538.3382145-1-sjg@chromium.org>
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

The -r option still uses the old make-based move_config() path, which
requires cross-compiler toolchains and is much slower.

Handle -r in do_sync_defconfigs() instead: clone the reference commit,
create a kconfiglib.Kconfig instance from that tree, load each defconfig
against it, write a full .config, then load that into the current tree's
Kconfig and write_min_config(). This gives the same result without any
toolchain requirement.

With move_config() now unreachable, remove it along with all the
infrastructure it depended on: KconfigParser, Slot, Slots,
DatabaseThread, get_make_cmd(), check_clean_directory(), the STATE_*
constants and the now-unused queue and threading imports. Much of this
is already dead before this patch, since -b uses do_build_db() and -s
uses do_sync_defconfigs(), leaving move_config() reachable only for
the -s -r combination.

Defconfigs which use #include are left alone in this mode, since
writing a minimal config would flatten them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/qconfig.rst |  24 +-
 tools/qconfig.py        | 575 +++++-----------------------------------
 2 files changed, 77 insertions(+), 522 deletions(-)

diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index 4a85c78cbbb..7fdbad8923d 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -51,25 +51,21 @@ that use ``#include`` directives are handled by computing the delta between
 the full expanded config and the base provided by the included files, so the
 include structure is preserved.
 
-The ``-r`` (git-ref) option still uses the old make-based path, since it
-needs to build against a different source tree.
+The ``-r`` (git-ref) option also uses kconfiglib: it clones the reference
+commit, creates a Kconfig instance from that tree, loads each defconfig
+against it, then normalises the result against the current tree's Kconfig.
+No toolchains are needed.
 
 Toolchains
 ----------
 
-Toolchains are **not** needed for ``-b`` or ``-s``, since both use
-kconfiglib to evaluate Kconfig files directly in Python.  The only
+Toolchains are **not** needed for any qconfig operation. The only
 difference from using a real toolchain is that ``CONFIG_GCC_VERSION``
 reflects the host compiler rather than each board's cross-compiler.
 This does not affect database queries, imply analysis, or defconfig
 sync, since ``CONFIG_GCC_VERSION`` is a build-time value that never
 appears in defconfig files or influences Kconfig defaults.
 
-The ``-r`` (git-ref) option still requires toolchains, as it falls back
-to the make-based path.  Most toolchains are available at the kernel.org
-site. This tool uses the same tools as :doc:`../build/buildman`, so you
-can use ``buildman --fetch-arch`` to fetch them.
-
 
 Examples
 --------
@@ -256,12 +252,12 @@ Available options
    the number of threads is the same as the number of CPU cores.
 
  -r, --git-ref
-   Specify the git ref to clone for building the autoconf.mk. If unspecified
-   use the CWD. This is useful for when changes to the Kconfig affect the
-   default values and you want to capture the state of the defconfig from
+   Specify the git ref to clone for evaluating the Kconfig tree. If
+   unspecified, use the CWD. This is useful when changes to Kconfig affect
+   default values and you want to capture the state of defconfigs from
    before that change was in effect. If in doubt, specify a ref pre-Kconfig
-   changes (use HEAD if Kconfig changes are not committed). Worst case it will
-   take a bit longer to run, but will always do the right thing.
+   changes (use HEAD if Kconfig changes are not committed). Worst case it
+   will take a bit longer to run, but will always do the right thing.
 
  -v, --verbose
    Show any build errors as boards are built
diff --git a/tools/qconfig.py b/tools/qconfig.py
index a19a8e0118d..e0c4ae37021 100755
--- a/tools/qconfig.py
+++ b/tools/qconfig.py
@@ -18,32 +18,21 @@ import fnmatch
 import glob
 import multiprocessing
 import os
-import queue
 import re
 import shutil
 import subprocess
 import sys
 import tempfile
-import threading
 import time
 import unittest
 
-from buildman import bsettings
 from buildman import kconfiglib
-from buildman import toolchain
 from u_boot_pylib import terminal
 from u_boot_pylib.terminal import tprint
 from u_boot_pylib import tools
 
-SHOW_GNU_MAKE = 'scripts/show-gnu-make'
 SLEEP_TIME=0.03
 
-STATE_IDLE = 0
-STATE_DEFCONFIG = 1
-STATE_AUTOCONF = 2
-STATE_SAVEDEFCONFIG = 3
-
-AUTO_CONF_PATH = 'include/config/auto.conf'
 CONFIG_DATABASE = 'qconfig.db'
 FAILED_LIST = 'qconfig.failed'
 
@@ -90,25 +79,6 @@ def check_top_directory():
         if not os.path.exists(fname):
             sys.exit('Please run at the top of source directory.')
 
-def check_clean_directory():
-    """Exit if the source tree is not clean."""
-    for fname in '.config', 'include/config':
-        if os.path.exists(fname):
-            sys.exit("source tree is not clean, please run 'make mrproper'")
-
-def get_make_cmd():
-    """Get the command name of GNU Make.
-
-    U-Boot needs GNU Make for building, but the command name is not
-    necessarily "make". (for example, "gmake" on FreeBSD).
-    Returns the most appropriate command name on your system.
-    """
-    with subprocess.Popen([SHOW_GNU_MAKE], stdout=subprocess.PIPE) as proc:
-        ret = proc.communicate()
-        if proc.returncode:
-            sys.exit('GNU Make not found')
-    return ret[0].rstrip()
-
 def get_matched_defconfig(line):
     """Get the defconfig files that match a pattern
 
@@ -738,12 +708,16 @@ def _sync_include_defconfig(kconf, srcdir, orig, dry_run):
 
 
 def _sync_defconfigs_worker(srcdir, defconfigs, result_queue, error_queue,
-                            dry_run):
+                            dry_run, ref_srcdir=None):
     """Worker process that syncs defconfigs using kconfiglib
 
     For each defconfig, loads it via kconfiglib and writes a minimal config
     (equivalent to 'make savedefconfig'), then compares with the original.
 
+    When ref_srcdir is set (the -r option), loads each defconfig against the
+    reference Kconfig tree first, writes a full .config, then loads that
+    .config into the current tree's Kconfig and writes a minimal config.
+
     Args:
         srcdir (str): Source-tree directory
         defconfigs (list of str): Defconfig filenames to process
@@ -751,24 +725,63 @@ def _sync_defconfigs_worker(srcdir, defconfigs, result_queue, error_queue,
             (defconfig, updated) tuples
         error_queue (multiprocessing.Queue): Output queue for failed defconfigs
         dry_run (bool): If True, do not update defconfig files
+        ref_srcdir (str or None): Reference source tree for -r option
     """
-    os.environ['srctree'] = srcdir
     os.environ['UBOOTVERSION'] = 'dummy'
     os.environ['KCONFIG_OBJDIR'] = ''
     os.environ['CC'] = 'gcc'
+
+    os.environ['srctree'] = srcdir
     kconf = kconfiglib.Kconfig(warn=False)
 
+    if ref_srcdir:
+        os.environ['srctree'] = ref_srcdir
+        ref_kconf = kconfiglib.Kconfig(warn=False)
+        os.environ['srctree'] = srcdir
+
     for defconfig in defconfigs:
         orig = os.path.join(srcdir, 'configs', defconfig)
         try:
-            raw = tools.read_file(orig)
-            has_include = b'#include' in raw
+            if ref_srcdir:
+                # Leave #include defconfigs alone: write_min_config() would
+                # flatten them, destroying the include structure
+                if b'#include' in tools.read_file(orig):
+                    result_queue.put((defconfig, False, None))
+                    continue
 
-            if has_include:
-                updated = _sync_include_defconfig(kconf, srcdir, orig,
-                                                  dry_run)
+                # Load defconfig against the reference Kconfig tree, write
+                # a full .config, then load it into the current tree
+                ref_orig = os.path.join(ref_srcdir, 'configs', defconfig)
+                if not os.path.exists(ref_orig):
+                    ref_orig = orig
+                _load_defconfig(ref_kconf, ref_srcdir, ref_orig)
+                tmp_config = tempfile.NamedTemporaryFile(
+                    prefix='qconfig-cfg-', delete=False)
+                tmp_config.close()
+                ref_kconf.write_config(tmp_config.name)
+                kconf.load_config(tmp_config.name, replace=True)
+                os.unlink(tmp_config.name)
+            else:
+                raw = tools.read_file(orig)
+                if b'#include' in raw:
+                    updated = _sync_include_defconfig(kconf, srcdir, orig,
+                                                      dry_run)
+                    result_queue.put((defconfig, updated, None))
+                    continue
+                _load_defconfig(kconf, srcdir, orig)
+
+            confdir = os.path.dirname(orig)
+            tmp = tempfile.NamedTemporaryFile(
+                mode='w', prefix='qconfig-', suffix='_defconfig',
+                dir=confdir, delete=False)
+            tmp.close()
+            kconf.write_min_config(tmp.name)
+
+            updated = not filecmp.cmp(orig, tmp.name)
+            if updated and not dry_run:
+                shutil.move(tmp.name, orig)
             else:
-                updated = _sync_plain_defconfig(kconf, orig, dry_run)
+                os.unlink(tmp.name)
             result_queue.put((defconfig, updated, None))
         except Exception as exc:
             error_queue.put((defconfig, str(exc)))
@@ -780,15 +793,25 @@ def do_sync_defconfigs(args):
     Evaluates each defconfig through kconfiglib and writes a minimal config
     (equivalent to 'make savedefconfig'), updating the original if it differs.
 
+    When -r (git-ref) is given, loads each defconfig against the Kconfig tree
+    from the reference commit first, then normalises it against the current
+    tree, capturing any Kconfig default changes.
+
     Args:
         args (Namespace): Program arguments (uses jobs, defconfigs,
-            defconfiglist, nocolour, dry_run, force_sync)
+            defconfiglist, nocolour, dry_run, force_sync, git_ref)
 
     Returns:
         Progress: progress indicator
     """
     srcdir = os.getcwd()
 
+    if args.git_ref:
+        reference_src = ReferenceSource(args.git_ref)
+        ref_srcdir = reference_src.get_dir()
+    else:
+        ref_srcdir = None
+
     if args.defconfigs:
         defconfigs = [os.path.basename(d)
                       for d in get_matched_defconfigs(args.defconfigs)]
@@ -813,7 +836,8 @@ def do_sync_defconfigs(args):
             continue
         proc = multiprocessing.Process(
             target=_sync_defconfigs_worker,
-            args=(srcdir, chunk, result_queue, error_queue, args.dry_run))
+            args=(srcdir, chunk, result_queue, error_queue, args.dry_run,
+                  ref_srcdir))
         proc.start()
         processes.append(proc)
 
@@ -859,403 +883,6 @@ def do_sync_defconfigs(args):
     return progress
 
 
-# pylint: disable=R0903
-class KconfigParser:
-    """A parser of .config and include/autoconf.mk."""
-
-    re_arch = re.compile(r'CONFIG_SYS_ARCH="(.*)"')
-    re_cpu = re.compile(r'CONFIG_SYS_CPU="(.*)"')
-
-    def __init__(self, build_dir):
-        """Create a new parser.
-
-        Args:
-          build_dir: Build directory.
-        """
-        self.dotconfig = os.path.join(build_dir, '.config')
-        self.autoconf = os.path.join(build_dir, 'include', 'autoconf.mk')
-        self.spl_autoconf = os.path.join(build_dir, 'spl', 'include',
-                                         'autoconf.mk')
-        self.config_autoconf = os.path.join(build_dir, AUTO_CONF_PATH)
-        self.defconfig = os.path.join(build_dir, 'defconfig')
-
-    def get_arch(self):
-        """Parse .config file and return the architecture.
-
-        Returns:
-          Architecture name (e.g. 'arm').
-        """
-        arch = ''
-        cpu = ''
-        for line in read_file(self.dotconfig):
-            m_arch = self.re_arch.match(line)
-            if m_arch:
-                arch = m_arch.group(1)
-                continue
-            m_cpu = self.re_cpu.match(line)
-            if m_cpu:
-                cpu = m_cpu.group(1)
-
-        if not arch:
-            return None
-
-        # fix-up for aarch64
-        if arch == 'arm' and cpu == 'armv8':
-            arch = 'aarch64'
-
-        return arch
-
-
-class DatabaseThread(threading.Thread):
-    """This thread processes results from Slot threads.
-
-    It collects the data in the master config directary. There is only one
-    result thread, and this helps to serialise the build output.
-    """
-    def __init__(self, config_db, db_queue):
-        """Set up a new result thread
-
-        Args:
-            builder: Builder which will be sent each result
-        """
-        threading.Thread.__init__(self)
-        self.config_db = config_db
-        self.db_queue= db_queue
-
-    def run(self):
-        """Called to start up the result thread.
-
-        We collect the next result job and pass it on to the build.
-        """
-        while True:
-            defconfig, configs = self.db_queue.get()
-            self.config_db[defconfig] = configs
-            self.db_queue.task_done()
-
-
-class Slot:
-
-    """A slot to store a subprocess.
-
-    Each instance of this class handles one subprocess.
-    This class is useful to control multiple threads
-    for faster processing.
-    """
-
-    def __init__(self, toolchains, args, progress, devnull, make_cmd,
-                 reference_src_dir, db_queue):
-        """Create a new process slot.
-
-        Args:
-          toolchains: Toolchains object containing toolchains.
-          args: Program arguments
-          progress: A progress indicator.
-          devnull: A file object of '/dev/null'.
-          make_cmd: command name of GNU Make.
-          reference_src_dir: Determine the true starting config state from this
-                             source tree.
-          db_queue: output queue to write config info for the database
-          col (terminal.Color): Colour object
-        """
-        self.toolchains = toolchains
-        self.args = args
-        self.progress = progress
-        self.build_dir = tempfile.mkdtemp()
-        self.devnull = devnull
-        self.make_cmd = (make_cmd, 'O=' + self.build_dir)
-        self.reference_src_dir = reference_src_dir
-        self.db_queue = db_queue
-        self.col = progress.col
-        self.parser = KconfigParser(self.build_dir)
-        self.state = STATE_IDLE
-        self.failed_boards = set()
-        self.defconfig = None
-        self.log = []
-        self.current_src_dir = None
-        self.proc = None
-
-    def __del__(self):
-        """Delete the working directory
-
-        This function makes sure the temporary directory is cleaned away
-        even if Python suddenly dies due to error.  It should be done in here
-        because it is guaranteed the destructor is always invoked when the
-        instance of the class gets unreferenced.
-
-        If the subprocess is still running, wait until it finishes.
-        """
-        if self.state != STATE_IDLE:
-            while self.proc.poll() is None:
-                pass
-        shutil.rmtree(self.build_dir)
-
-    def add(self, defconfig):
-        """Assign a new subprocess for defconfig and add it to the slot.
-
-        If the slot is vacant, create a new subprocess for processing the
-        given defconfig and add it to the slot.  Just returns False if
-        the slot is occupied (i.e. the current subprocess is still running).
-
-        Args:
-          defconfig (str): defconfig name.
-
-        Returns:
-          Return True on success or False on failure
-        """
-        if self.state != STATE_IDLE:
-            return False
-
-        self.defconfig = defconfig
-        self.log = []
-        self.current_src_dir = self.reference_src_dir
-        self.do_defconfig()
-        return True
-
-    def poll(self):
-        """Check the status of the subprocess and handle it as needed.
-
-        Returns True if the slot is vacant (i.e. in idle state).
-        If the configuration is successfully finished, assign a new
-        subprocess to build include/autoconf.mk.
-        If include/autoconf.mk is generated, invoke the parser to
-        parse the .config and the include/autoconf.mk, moving
-        config options to the .config as needed.
-        If the .config was updated, run "make savedefconfig" to sync
-        it, update the original defconfig, and then set the slot back
-        to the idle state.
-
-        Returns:
-          Return True if the subprocess is terminated, False otherwise
-        """
-        if self.state == STATE_IDLE:
-            return True
-
-        if self.proc.poll() is None:
-            return False
-
-        if self.proc.poll() != 0:
-            self.handle_error()
-        elif self.state == STATE_DEFCONFIG:
-            if self.reference_src_dir and not self.current_src_dir:
-                self.do_savedefconfig()
-            else:
-                self.do_autoconf()
-        elif self.state == STATE_AUTOCONF:
-            if self.current_src_dir:
-                self.current_src_dir = None
-                self.do_defconfig()
-            elif self.args.build_db:
-                self.do_add_to_db()
-            else:
-                self.do_savedefconfig()
-        elif self.state == STATE_SAVEDEFCONFIG:
-            self.update_defconfig()
-        else:
-            sys.exit('Internal Error. This should not happen.')
-
-        return self.state == STATE_IDLE
-
-    def handle_error(self):
-        """Handle error cases."""
-
-        self.log.append(self.col.build(self.col.RED, 'Failed to process',
-                                       bright=True))
-        if self.args.verbose:
-            for line in self.proc.stderr.read().decode().splitlines():
-                self.log.append(self.col.build(self.col.CYAN, line, True))
-        self.finish(False)
-
-    def do_defconfig(self):
-        """Run 'make <board>_defconfig' to create the .config file."""
-
-        cmd = list(self.make_cmd)
-        cmd.append(self.defconfig)
-        # pylint: disable=R1732
-        self.proc = subprocess.Popen(cmd, stdout=self.devnull,
-                                     stderr=subprocess.PIPE,
-                                     cwd=self.current_src_dir)
-        self.state = STATE_DEFCONFIG
-
-    def do_autoconf(self):
-        """Run 'make AUTO_CONF_PATH'."""
-
-        arch = self.parser.get_arch()
-        try:
-            tchain = self.toolchains.Select(arch)
-        except ValueError:
-            self.log.append(self.col.build(
-                self.col.YELLOW,
-                f"Tool chain for '{arch}' is missing: do nothing"))
-            self.finish(False)
-            return
-        env = tchain.MakeEnvironment(False)
-
-        cmd = list(self.make_cmd)
-        cmd.append('KCONFIG_IGNORE_DUPLICATES=1')
-        cmd.append(AUTO_CONF_PATH)
-        # pylint: disable=R1732
-        self.proc = subprocess.Popen(cmd, stdout=self.devnull, env=env,
-                                     stderr=subprocess.PIPE,
-                                     cwd=self.current_src_dir)
-        self.state = STATE_AUTOCONF
-
-    def do_add_to_db(self):
-        """Add the board to the database"""
-        configs = {}
-        for line in read_file(os.path.join(self.build_dir, AUTO_CONF_PATH)):
-            if line.startswith('CONFIG'):
-                config, value = line.split('=', 1)
-                configs[config] = value.rstrip()
-        self.db_queue.put([self.defconfig, configs])
-        self.finish(True)
-
-    def do_savedefconfig(self):
-        """Update the .config and run 'make savedefconfig'."""
-        if not self.args.force_sync:
-            self.finish(True)
-            return
-
-        cmd = list(self.make_cmd)
-        cmd.append('savedefconfig')
-        # pylint: disable=R1732
-        self.proc = subprocess.Popen(cmd, stdout=self.devnull,
-                                     stderr=subprocess.PIPE)
-        self.state = STATE_SAVEDEFCONFIG
-
-    def update_defconfig(self):
-        """Update the input defconfig and go back to the idle state."""
-        orig_defconfig = os.path.join('configs', self.defconfig)
-        new_defconfig = os.path.join(self.build_dir, 'defconfig')
-        updated = not filecmp.cmp(orig_defconfig, new_defconfig)
-        success = True
-
-        if updated:
-            # Files with #include get mangled as savedefconfig doesn't
-            # know how to deal with them. Ignore them
-            success = b'#include' not in tools.read_file(orig_defconfig)
-            if success:
-                self.log.append(
-                    self.col.build(self.col.BLUE, 'defconfig updated',
-                                   bright=True))
-            else:
-                self.log.append(
-                    self.col.build(self.col.RED, 'ignored due to #include',
-                                   bright=True))
-                updated = False
-
-        if not self.args.dry_run and updated:
-            shutil.move(new_defconfig, orig_defconfig)
-        self.finish(success)
-
-    def finish(self, success):
-        """Display log along with progress and go to the idle state.
-
-        Args:
-          success (bool): Should be True when the defconfig was processed
-                   successfully, or False when it fails.
-        """
-        # output at least 30 characters to hide the "* defconfigs out of *".
-        name = self.defconfig[:-len('_defconfig')]
-        if self.log:
-
-            # Put the first log line on the first line
-            log = name.ljust(20) + ' ' + self.log[0]
-
-            if len(self.log) > 1:
-                log += '\n' + '\n'.join(['    ' + s for s in self.log[1:]])
-            # Some threads are running in parallel.
-            # Print log atomically to not mix up logs from different threads.
-            print(log, file=(sys.stdout if success else sys.stderr))
-
-        if not success:
-            if self.args.exit_on_error:
-                sys.exit('Exit on error.')
-            # If --exit-on-error flag is not set, skip this board and continue.
-            # Record the failed board.
-            self.failed_boards.add(name)
-
-        self.progress.inc(success)
-        self.progress.show()
-        self.state = STATE_IDLE
-
-    def get_failed_boards(self):
-        """Returns a set of failed boards (defconfigs) in this slot.
-        """
-        return self.failed_boards
-
-class Slots:
-    """Controller of the array of subprocess slots."""
-
-    def __init__(self, toolchains, args, progress, reference_src_dir, db_queue):
-        """Create a new slots controller.
-
-        Args:
-            toolchains (Toolchains): Toolchains object containing toolchains
-            args (Namespace): Program arguments
-            progress (Progress): A progress indicator.
-            reference_src_dir (str): Determine the true starting config state
-                from this source tree (None for none)
-            db_queue (Queue): output queue to write config info for the database
-        """
-        self.args = args
-        self.slots = []
-        self.progress = progress
-        self.col = progress.col
-        devnull = subprocess.DEVNULL
-        make_cmd = get_make_cmd()
-        for _ in range(args.jobs):
-            self.slots.append(Slot(toolchains, args, progress, devnull,
-                                   make_cmd, reference_src_dir, db_queue))
-
-    def add(self, defconfig):
-        """Add a new subprocess if a vacant slot is found.
-
-        Args:
-          defconfig (str): defconfig name to be put into.
-
-        Returns:
-          Return True on success or False on failure
-        """
-        for slot in self.slots:
-            if slot.add(defconfig):
-                return True
-        return False
-
-    def available(self):
-        """Check if there is a vacant slot.
-
-        Returns:
-          Return True if at lease one vacant slot is found, False otherwise.
-        """
-        for slot in self.slots:
-            if slot.poll():
-                return True
-        return False
-
-    def empty(self):
-        """Check if all slots are vacant.
-
-        Returns:
-          Return True if all the slots are vacant, False otherwise.
-        """
-        ret = True
-        for slot in self.slots:
-            if not slot.poll():
-                ret = False
-        return ret
-
-    def write_failed_boards(self):
-        """Show the results of processing"""
-        boards = set()
-
-        for slot in self.slots:
-            boards |= slot.get_failed_boards()
-
-        if boards:
-            boards = '\n'.join(sorted(boards)) + '\n'
-            write_file(FAILED_LIST, boards)
-
-
 class ReferenceSource:
 
     """Reference source against which original configs should be parsed."""
@@ -1291,71 +918,6 @@ class ReferenceSource:
 
         return self.src_dir
 
-def move_config(args):
-    """Build database or sync config options to defconfig files.
-
-    Args:
-        args (Namespace): Program arguments
-
-    Returns:
-        tuple:
-            config_db (dict of configs for each defconfig):
-                key: defconfig name, e.g. "MPC8548CDS_legacy_defconfig"
-                value: dict:
-                    key: CONFIG option
-                    value: Value of option
-            Progress: Progress indicator
-    """
-    config_db = {}
-    db_queue = queue.Queue()
-    dbt = DatabaseThread(config_db, db_queue)
-    dbt.daemon = True
-    dbt.start()
-
-    check_clean_directory()
-    bsettings.setup('')
-
-    # Get toolchains to use
-    toolchains = toolchain.Toolchains()
-    toolchains.GetSettings()
-    toolchains.Scan(verbose=False)
-
-    if args.git_ref:
-        reference_src = ReferenceSource(args.git_ref)
-        reference_src_dir = reference_src.get_dir()
-    else:
-        reference_src_dir = None
-
-    if args.defconfigs:
-        defconfigs = get_matched_defconfigs(args.defconfigs)
-    elif args.defconfiglist:
-        defconfigs = get_matched_defconfigs(args.defconfiglist)
-    else:
-        defconfigs = get_all_defconfigs()
-
-    col = terminal.Color(terminal.COLOR_NEVER if args.nocolour
-                         else terminal.COLOR_IF_TERMINAL)
-    progress = Progress(col, len(defconfigs))
-    slots = Slots(toolchains, args, progress, reference_src_dir, db_queue)
-
-    # Main loop to process defconfig files:
-    #  Add a new subprocess into a vacant slot.
-    #  Sleep if there is no available slot.
-    for defconfig in defconfigs:
-        while not slots.add(defconfig):
-            while not slots.available():
-                # No available slot: sleep for a while
-                time.sleep(SLEEP_TIME)
-
-    # wait until all the subprocesses finish
-    while not slots.empty():
-        time.sleep(SLEEP_TIME)
-
-    slots.write_failed_boards()
-    db_queue.join()
-    progress.completed()
-    return config_db, progress
-
 def find_kconfig_rules(kconf, config, imply_config):
     """Check whether a config has a 'select' or 'imply' keyword
 
@@ -2522,17 +2084,14 @@ def main():
         config_db, progress = do_build_db(args)
         return write_db(config_db, progress)
 
-    if args.force_sync and not args.git_ref:
+    if args.force_sync:
         progress = do_sync_defconfigs(args)
         if args.commit:
             add_commit(args.configs)
         return move_done(progress)
 
-    config_db, progress = move_config(args)
-
-    if args.commit:
-        add_commit(args.configs)
-    return move_done(progress)
+    parser.print_usage()
+    return 1
 
 
 if __name__ == '__main__':
-- 
2.43.0

