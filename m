Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF29CC27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 17:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B723788602;
	Sun, 23 Jun 2024 19:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XoKfI5bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E0B2885E7; Sun, 23 Jun 2024 19:55:34 +0200 (CEST)
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3EB882E2
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 19:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-7eb6aedcabcso138500639f.0
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719165330; x=1719770130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=js1B3Fhwj3/sKBtfEbSwgo9Es5qzmAY0dew8DHdTdiw=;
 b=XoKfI5bt5Tj9ie+73TWNTu8qRfpxOGuUqHpq0KT/ZrpYAu1pbBaIRbNKyqcK1yMcZW
 XPukAaIPeL9XSpijXtRWMWgl5iMGM5toUEMl31yIRIQENuBSVEuFPoEcxG129GsYY/G/
 WVoXQlYy1aby+wJmOXFhHKyf/A0SdgaR3gefs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719165330; x=1719770130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=js1B3Fhwj3/sKBtfEbSwgo9Es5qzmAY0dew8DHdTdiw=;
 b=Dao490Mx5En7ANBsG4mn3xZq4sh6MpRCsSNYsKeXEZx6Q2Z4G9rL9tU2vCAmPGNoKt
 2UJRcFoVz2gdKjIgzhfwjBGRGENVnoS5PcsxMAwYU+dhoJjP51MySgXRlT3W9N3rBYEM
 e5o4y9k9Wj3iRAnDIe88S7Nf7jTSYqPx5AUCitZU22F6tczIjBeRTutaystd/6BaYvUN
 2JA0vunIhEyC6HZAiZjUd7s9+K+FDpC8VXfIVzoxhk/O7ta4KjsAeK4pZE85EK9IC3Ov
 oifD/hip+lwLb7HZqdvAqM1xy3UvimNkPPNJariG14lraRw3+/zN4FXym0OyFg7Tr/8U
 lrYQ==
X-Gm-Message-State: AOJu0YySKP+cTmM4K12rTy6AysjtpB1r6y1hB1k0hRNwbc/Kjn58cJrK
 M+CRITOq662eF7+tqtnMzPHZ1CkZa0LtdiMmc/873spYA8gTrPoAplp3tR8XI1K7S2by1jUCxEo
 smypf
X-Google-Smtp-Source: AGHT+IE1mZBM8RD5/ww4ta4yM6VMc727hJw9fPasXe3Kfd6EYPxIO4R9RiINHixIo0PZy9MY/F5XRg==
X-Received: by 2002:a05:6602:3f81:b0:7eb:b257:65ec with SMTP id
 ca18e2360f4ac-7f3a75e3622mr221851239f.20.1719165329769; 
 Sun, 23 Jun 2024 10:55:29 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-7f391fc9b12sm134472239f.5.2024.06.23.10.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jun 2024 10:55:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 14/14] buildman: Add a way to limit the number of buildmans
Date: Sun, 23 Jun 2024 11:55:15 -0600
Message-Id: <20240623175515.1466908-15-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240623175515.1466908-1-sjg@chromium.org>
References: <20240623175515.1466908-1-sjg@chromium.org>
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

Buildman uses all available CPUs by default, so running more than one or
two concurrent processes is not normally useful.

However in some CI cases we want to be able to run several jobs at once
to save time. For example, in a lab situation we may want to run a test
on 20 boards at a time, since only the build step actually takes much
CPU.

Add an option which allows such a limit. When buildman starts up, it
waits until the number of running processes goes below the limit, then
claims a spot in the list. The list is maintained with a temporary file.

Note that the temp file is user-specific, since it is hard to create a
locked temporary file which can be accessed by any user. In most cases,
only one user is running jobs on a machine, so this should not matter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Move the binman assume-size feature into this series

 tools/buildman/buildman.rst    |   5 ++
 tools/buildman/cmdline.py      |   2 +
 tools/buildman/control.py      | 140 ++++++++++++++++++++++++++++++++-
 tools/buildman/pyproject.toml  |   6 +-
 tools/buildman/test.py         | 121 ++++++++++++++++++++++++++++
 tools/u_boot_pylib/terminal.py |   7 +-
 6 files changed, 277 insertions(+), 4 deletions(-)

diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
index bd0482af5f7..b8ff3bf1ab2 100644
--- a/tools/buildman/buildman.rst
+++ b/tools/buildman/buildman.rst
@@ -1286,6 +1286,11 @@ then buildman hangs. Failing to handle any eventuality is a bug in buildman and
 should be reported. But you can use -T0 to disable threading and hopefully
 figure out the root cause of the build failure.
 
+For situations where buildman is invoked from multiple running processes, it is
+sometimes useful to have buildman wait until the others have finished. Use the
+--process-limit option for this: --process-limit 1 will allow only one buildman
+to process jobs at a time.
+
 Build summary
 -------------
 
diff --git a/tools/buildman/cmdline.py b/tools/buildman/cmdline.py
index 8dc5a8787b5..544a391a464 100644
--- a/tools/buildman/cmdline.py
+++ b/tools/buildman/cmdline.py
@@ -129,6 +129,8 @@ def add_after_m(parser):
           default=False, help="Use an O= (output) directory per board rather than per thread")
     parser.add_argument('--print-arch', action='store_true',
           default=False, help="Print the architecture for a board (ARCH=)")
+    parser.add_argument('--process-limit', type=int,
+          default=0, help='Limit to number of buildmans running at once')
     parser.add_argument('-r', '--reproducible-builds', action='store_true',
           help='Set SOURCE_DATE_EPOCH=0 to suuport a reproducible build')
     parser.add_argument('-R', '--regen-board-list', type=str,
diff --git a/tools/buildman/control.py b/tools/buildman/control.py
index f2dd87814c3..464835c5be5 100644
--- a/tools/buildman/control.py
+++ b/tools/buildman/control.py
@@ -7,10 +7,13 @@
 This holds the main control logic for buildman, when not running tests.
 """
 
+import getpass
 import multiprocessing
 import os
 import shutil
 import sys
+import tempfile
+import time
 
 from buildman import boards
 from buildman import bsettings
@@ -21,10 +24,23 @@ from patman import gitutil
 from patman import patchstream
 from u_boot_pylib import command
 from u_boot_pylib import terminal
-from u_boot_pylib.terminal import tprint
+from u_boot_pylib import tools
+from u_boot_pylib.terminal import print_clear, tprint
 
 TEST_BUILDER = None
 
+# Space-separated list of buildman process IDs currently running jobs
+RUNNING_FNAME = f'buildmanq.{getpass.getuser()}'
+
+# Lock file for access to RUNNING_FILE
+LOCK_FNAME = f'{RUNNING_FNAME}.lock'
+
+# Wait time for access to lock (seconds)
+LOCK_WAIT_S = 10
+
+# Wait time to start running
+RUN_WAIT_S = 300
+
 def get_plural(count):
     """Returns a plural 's' if count is not 1"""
     return 's' if count != 1 else ''
@@ -578,6 +594,125 @@ def calc_adjust_cfg(adjust_cfg, reproducible_builds):
     return adjust_cfg
 
 
+def read_procs(tmpdir=tempfile.gettempdir()):
+    """Read the list of running buildman processes
+
+    If the list is corrupted, returns an empty list
+
+    Args:
+        tmpdir (str): Temporary directory to use (for testing only)
+    """
+    running_fname = os.path.join(tmpdir, RUNNING_FNAME)
+    procs = []
+    if os.path.exists(running_fname):
+        items = tools.read_file(running_fname, binary=False).split()
+        try:
+            procs = [int(x) for x in items]
+        except ValueError: # Handle invalid format
+            pass
+    return procs
+
+
+def check_pid(pid):
+    """Check for existence of a unix PID
+
+    https://stackoverflow.com/questions/568271/how-to-check-if-there-exists-a-process-with-a-given-pid-in-python
+
+    Args:
+        pid (int): PID to check
+
+    Returns:
+        True if it exists, else False
+    """
+    try:
+        os.kill(pid, 0)
+    except OSError:
+        return False
+    else:
+        return True
+
+
+def write_procs(procs, tmpdir=tempfile.gettempdir()):
+    """Write the list of running buildman processes
+
+    Args:
+        tmpdir (str): Temporary directory to use (for testing only)
+    """
+    running_fname = os.path.join(tmpdir, RUNNING_FNAME)
+    tools.write_file(running_fname, ' '.join([str(p) for p in procs]),
+                     binary=False)
+
+    # Allow another user to access the file
+    os.chmod(running_fname, 0o666)
+
+def wait_for_process_limit(limit, tmpdir=tempfile.gettempdir(),
+                           pid=os.getpid()):
+    """Wait until the number of buildman processes drops to the limit
+
+    This uses FileLock to protect a 'running' file, which contains a list of
+    PIDs of running buildman processes. The number of PIDs in the file indicates
+    the number of running processes.
+
+    When buildman starts up, it calls this function to wait until it is OK to
+    start the build.
+
+    On exit, no attempt is made to remove the PID from the file, since other
+    buildman processes will notice that the PID is no-longer valid, and ignore
+    it.
+
+    Two timeouts are provided:
+        LOCK_WAIT_S: length of time to wait for the lock; if this occurs, the
+            lock is busted / removed before trying again
+        RUN_WAIT_S: length of time to wait to be allowed to run; if this occurs,
+            the build starts, with the PID being added to the file.
+
+    Args:
+        limit (int): Maximum number of buildman processes, including this one;
+            must be > 0
+        tmpdir (str): Temporary directory to use (for testing only)
+        pid (int): Current process ID (for testing only)
+    """
+    from filelock import Timeout, FileLock
+
+    running_fname = os.path.join(tmpdir, RUNNING_FNAME)
+    lock_fname = os.path.join(tmpdir, LOCK_FNAME)
+    lock = FileLock(lock_fname)
+
+    # Allow another user to access the file
+    col = terminal.Color()
+    tprint('Waiting for other buildman processes...', newline=False,
+           colour=col.RED)
+
+    claimed = False
+    deadline = time.time() + RUN_WAIT_S
+    while True:
+        try:
+            with lock.acquire(timeout=LOCK_WAIT_S):
+                os.chmod(lock_fname, 0o666)
+                procs = read_procs(tmpdir)
+
+                # Drop PIDs which are not running
+                procs = list(filter(check_pid, procs))
+
+                # If we haven't hit the limit, add ourself
+                if len(procs) < limit:
+                    tprint('done...', newline=False)
+                    claimed = True
+                if time.time() >= deadline:
+                    tprint('timeout...', newline=False)
+                    claimed = True
+                if claimed:
+                    write_procs(procs + [pid], tmpdir)
+                    break
+
+        except Timeout:
+            tprint('failed to get lock: busting...', newline=False)
+            os.remove(lock_fname)
+
+        time.sleep(1)
+    tprint('starting build', newline=False)
+    print_clear()
+
 def do_buildman(args, toolchains=None, make_func=None, brds=None,
                 clean_dir=False, test_thread_exceptions=False):
     """The main control code for buildman
@@ -677,5 +812,8 @@ def do_buildman(args, toolchains=None, make_func=None, brds=None,
 
     TEST_BUILDER = builder
 
+    if args.process_limit:
+        wait_for_process_limit(args.process_limit)
+
     return run_builder(builder, series.commits if series else None,
                        brds.get_selected_dict(), args)
diff --git a/tools/buildman/pyproject.toml b/tools/buildman/pyproject.toml
index fe0f6421b53..68bfa45c3f4 100644
--- a/tools/buildman/pyproject.toml
+++ b/tools/buildman/pyproject.toml
@@ -8,7 +8,11 @@ version = "0.0.6"
 authors = [
   { name="Simon Glass", email="sjg@chromium.org" },
 ]
-dependencies = ["u_boot_pylib >= 0.0.6", "patch-manager >= 0.0.6"]
+dependencies = [
+    "filelock >= 3.0.12",
+    "u_boot_pylib >= 0.0.6",
+    "patch-manager >= 0.0.6"
+]
 description = "Buildman build tool for U-Boot"
 readme = "README.rst"
 requires-python = ">=3.7"
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index f92add7a7c5..d68395c2164 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -2,12 +2,14 @@
 # Copyright (c) 2012 The Chromium OS Authors.
 #
 
+from filelock import FileLock
 import os
 import shutil
 import sys
 import tempfile
 import time
 import unittest
+from unittest.mock import patch
 
 from buildman import board
 from buildman import boards
@@ -156,6 +158,11 @@ class TestBuild(unittest.TestCase):
         if not os.path.isdir(self.base_dir):
             os.mkdir(self.base_dir)
 
+        self.cur_time = 0
+        self.valid_pids = []
+        self.finish_time = None
+        self.finish_pid = None
+
     def tearDown(self):
         shutil.rmtree(self.base_dir)
 
@@ -747,6 +754,120 @@ class TestBuild(unittest.TestCase):
         self.assertEqual([
             ['MARY="mary"', 'Missing expected line: CONFIG_MARY="mary"']], result)
 
+    def get_procs(self):
+        running_fname = os.path.join(self.base_dir, control.RUNNING_FNAME)
+        items = tools.read_file(running_fname, binary=False).split()
+        return [int(x) for x in items]
+
+    def get_time(self):
+        return self.cur_time
+
+    def inc_time(self, amount):
+        self.cur_time += amount
+
+        # Handle a process exiting
+        if self.finish_time == self.cur_time:
+            self.valid_pids = [pid for pid in self.valid_pids
+                               if pid != self.finish_pid]
+
+    def kill(self, pid, signal):
+        if pid not in self.valid_pids:
+            raise OSError('Invalid PID')
+
+    def test_process_limit(self):
+        """Test wait_for_process_limit() function"""
+        tmpdir = self.base_dir
+
+        with (patch('time.time', side_effect=self.get_time),
+              patch('time.sleep', side_effect=self.inc_time),
+              patch('os.kill', side_effect=self.kill)):
+            # Grab the process. Since there is no other profcess, this should
+            # immediately succeed
+            control.wait_for_process_limit(1, tmpdir=tmpdir, pid=1)
+            lines = terminal.get_print_test_lines()
+            self.assertEqual(0, self.cur_time)
+            self.assertEqual('Waiting for other buildman processes...',
+                             lines[0].text)
+            self.assertEqual(self._col.RED, lines[0].colour)
+            self.assertEqual(False, lines[0].newline)
+            self.assertEqual(True, lines[0].bright)
+
+            self.assertEqual('done...', lines[1].text)
+            self.assertEqual(None, lines[1].colour)
+            self.assertEqual(False, lines[1].newline)
+            self.assertEqual(True, lines[1].bright)
+
+            self.assertEqual('starting build', lines[2].text)
+            self.assertEqual([1], control.read_procs(tmpdir))
+            self.assertEqual(None, lines[2].colour)
+            self.assertEqual(False, lines[2].newline)
+            self.assertEqual(True, lines[2].bright)
+
+            # Try again, with a different PID...this should eventually timeout
+            # and start the build anyway
+            self.cur_time = 0
+            self.valid_pids = [1]
+            control.wait_for_process_limit(1, tmpdir=tmpdir, pid=2)
+            lines = terminal.get_print_test_lines()
+            self.assertEqual('Waiting for other buildman processes...',
+                             lines[0].text)
+            self.assertEqual('timeout...', lines[1].text)
+            self.assertEqual(None, lines[1].colour)
+            self.assertEqual(False, lines[1].newline)
+            self.assertEqual(True, lines[1].bright)
+            self.assertEqual('starting build', lines[2].text)
+            self.assertEqual([1, 2], control.read_procs(tmpdir))
+            self.assertEqual(control.RUN_WAIT_S, self.cur_time)
+
+            # Check lock-busting
+            self.cur_time = 0
+            self.valid_pids = [1, 2]
+            lock_fname = os.path.join(tmpdir, control.LOCK_FNAME)
+            lock = FileLock(lock_fname)
+            lock.acquire(timeout=1)
+            control.wait_for_process_limit(1, tmpdir=tmpdir, pid=3)
+            lines = terminal.get_print_test_lines()
+            self.assertEqual('Waiting for other buildman processes...',
+                             lines[0].text)
+            self.assertEqual('failed to get lock: busting...', lines[1].text)
+            self.assertEqual(None, lines[1].colour)
+            self.assertEqual(False, lines[1].newline)
+            self.assertEqual(True, lines[1].bright)
+            self.assertEqual('timeout...', lines[2].text)
+            self.assertEqual('starting build', lines[3].text)
+            self.assertEqual([1, 2, 3], control.read_procs(tmpdir))
+            self.assertEqual(control.RUN_WAIT_S, self.cur_time)
+            lock.release()
+
+            # Check handling of dead processes. Here we have PID 2 as a running
+            # process, even though the PID file contains 1, 2 and 3. So we can
+            # add one more PID, to make 2 and 4
+            self.cur_time = 0
+            self.valid_pids = [2]
+            control.wait_for_process_limit(2, tmpdir=tmpdir, pid=4)
+            lines = terminal.get_print_test_lines()
+            self.assertEqual('Waiting for other buildman processes...',
+                             lines[0].text)
+            self.assertEqual('done...', lines[1].text)
+            self.assertEqual('starting build', lines[2].text)
+            self.assertEqual([2, 4], control.read_procs(tmpdir))
+            self.assertEqual(0, self.cur_time)
+
+            # Try again, with PID 2 quitting at time 50. This allows the new
+            # build to start
+            self.cur_time = 0
+            self.valid_pids = [2, 4]
+            self.finish_pid = 2
+            self.finish_time = 50
+            control.wait_for_process_limit(2, tmpdir=tmpdir, pid=5)
+            lines = terminal.get_print_test_lines()
+            self.assertEqual('Waiting for other buildman processes...',
+                             lines[0].text)
+            self.assertEqual('done...', lines[1].text)
+            self.assertEqual('starting build', lines[2].text)
+            self.assertEqual([4, 5], control.read_procs(tmpdir))
+            self.assertEqual(self.finish_time, self.cur_time)
+
 
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/u_boot_pylib/terminal.py b/tools/u_boot_pylib/terminal.py
index 40d79f8ac07..2cd5a54ab52 100644
--- a/tools/u_boot_pylib/terminal.py
+++ b/tools/u_boot_pylib/terminal.py
@@ -164,8 +164,11 @@ def print_clear():
     global last_print_len
 
     if last_print_len:
-        print('\r%s\r' % (' '* last_print_len), end='', flush=True)
-        last_print_len = None
+        if print_test_mode:
+            print_test_list.append(PrintLine(None, None, None, None))
+        else:
+            print('\r%s\r' % (' '* last_print_len), end='', flush=True)
+            last_print_len = None
 
 def set_print_test_mode(enable=True):
     """Go into test mode, where all printing is recorded"""
-- 
2.34.1

