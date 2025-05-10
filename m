Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72826C3ABC3
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D1798294C;
	Sat, 10 May 2025 13:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WVTwat3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3958F82998; Sat, 10 May 2025 13:06:02 +0200 (CEST)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BB082A39
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x643.google.com with SMTP id
 a640c23a62f3a-ad212f4030aso331171066b.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746875159; x=1747479959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVQqAEndigDIGeDWR8qU50H6pNgidpOViIu20C/uSGg=;
 b=WVTwat3TURiUAQdQSuG6tu1iTHl6dDeWLwWS93oyx6gZQeXY4b9KN26HL8J+UPrmE8
 aOYNB1znQAf9zUqBmHJMrixqM2YWuPrWDYkuTlFNktYF1uf6PdKwrigG5gFQxfNDvTxb
 jLn+Dr0kRIGhkCUwhyhOUeJiKFg8sTGXm44/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746875159; x=1747479959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVQqAEndigDIGeDWR8qU50H6pNgidpOViIu20C/uSGg=;
 b=qnyHCuu4k1qDxKeS9zz1uHYivuMTa883sxdKjrvGoGkJDhd90YrJLcBY+AIYlig0/G
 eXTM7HdNUNrMfURnZqufUZ4q5c0AafcgfUEXB2UnciEe73ipUmPBafS3AH+jgrN6M4IV
 A468TZMwlk4S1S6v1WRN1iHZ8EVyTxh3MK+yhGh6zGNKoRgu2EMKyoBzoijlFts6KCyw
 WTbj9yLjcU6FINCzhGyFRH8iOJpBgnEc/WBQlKTQBSrktSStbwCRb2/6im6z0QqTGrrP
 C+F27mmsKy9tXdCrIu8yuypzDjam7vIpef/99w0PKNAvibDgTp1kBDKfTeV7VsgSVi3d
 znjQ==
X-Gm-Message-State: AOJu0YzBNeM4r6lno1QZrdvdo4h3HGXK1lhYzTbumdNql4X4vUKVOpap
 psbO4B+hUv+ntnv2aIZWiqoVsjBYzhmfdmOGCLd4sRaoQcKstzmn9Fsx4Uas6z/xHWNMtxnNsXz
 sDSGlKtkpOKTL
X-Gm-Gg: ASbGnct6PT0eV1nxnI4J4aF7/tIQGMPDRmeHplzd95EuZrWYYmvMvL3gLHDxapfJg5e
 9FTw10BXGRYh2jK8KJU2Gf6P83NwcVilxRsAXo4MvzfL/QKZT/9ls7Z3BEDQ2S/E9567/Frw277
 YBJ+AvbHJ84bN88EUuNfcjMm60XEz7stxESPRR3fmtW/656WDu4x2DZIu7mXZS7CVq1VCPoimdh
 3patz+tyS/JIVThC1qtNDYSD/fUcYpx43St/vsaxzH4xQWTnmpfJckMxOj3E1MHFiYhaqLln+ll
 FYdqHTTNVUYuV3Ov39qckYldtMpwv5xysTdW/P/I8JRRzpo=
X-Google-Smtp-Source: AGHT+IEqpScytFgGT4tChNUGj+xGQnVlZoI8CKV6ZHOK8QsdF631STIGqFSt5VCjzSEhjB422aUPyg==
X-Received: by 2002:a17:907:1b1a:b0:acb:6edd:b255 with SMTP id
 a640c23a62f3a-ad21928f9famr700910466b.56.1746875158622; 
 Sat, 10 May 2025 04:05:58 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad2192c8b8asm300148866b.5.2025.05.10.04.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 04:05:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/25] patman: Move common test code into a new module
Date: Sat, 10 May 2025 13:04:59 +0200
Message-ID: <20250510110535.1453745-7-sjg@chromium.org>
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

The func_test file is quite large. In order to allow new tests to be
added to a separate file, move the common test code into a separate
class, to be inherited by other classes.

Drop unnecessary imports in func_test

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py    |   2 +-
 tools/patman/control.py     |   3 -
 tools/patman/func_test.py   | 213 ++++------------------------------
 tools/patman/test_common.py | 222 ++++++++++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+), 192 deletions(-)
 create mode 100644 tools/patman/test_common.py

diff --git a/tools/patman/__init__.py b/tools/patman/__init__.py
index 14451e35f36..0faef0cfa75 100644
--- a/tools/patman/__init__.py
+++ b/tools/patman/__init__.py
@@ -4,5 +4,5 @@ __all__ = [
     'checkpatch', 'cmdline', 'commit', 'control', 'func_test',
     'get_maintainer', '__main__', 'patchstream', 'patchwork', 'project',
     'send', 'series', 'settings', 'setup', 'status', 'test_checkpatch',
-    'test_settings'
+    'test_common', 'test_settings'
 ]
diff --git a/tools/patman/control.py b/tools/patman/control.py
index 902b5092e9c..7bf0e7ff61a 100644
--- a/tools/patman/control.py
+++ b/tools/patman/control.py
@@ -8,9 +8,7 @@ This module provides various functions called by the main program to implement
 the features of patman.
 """
 
-import os
 import re
-import sys
 import traceback
 
 try:
@@ -22,7 +20,6 @@ except ImportError:
 from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
-from patman import checkpatch
 from patman import patchstream
 from patman import patchwork
 from patman import send
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 55abf52bdb5..2faff8019f6 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -13,7 +13,6 @@ import pathlib
 import re
 import shutil
 import sys
-import tempfile
 import unittest
 
 import pygit2
@@ -31,6 +30,7 @@ from patman import patchwork
 from patman import send
 from patman.series import Series
 from patman import status
+from patman.test_common import TestCommon
 
 PATMAN_DIR = pathlib.Path(__file__).parent
 TEST_DATA_DIR = PATMAN_DIR / 'test/'
@@ -47,52 +47,22 @@ def directory_excursion(directory):
         os.chdir(current)
 
 
-class TestFunctional(unittest.TestCase):
+class TestFunctional(unittest.TestCase, TestCommon):
     """Functional tests for checking that patman behaves correctly"""
-    leb = (b'Lord Edmund Blackadd\xc3\xabr <weasel@blackadder.org>'.
-           decode('utf-8'))
     fred = 'Fred Bloggs <f.bloggs@napier.net>'
     joe = 'Joe Bloggs <joe@napierwallies.co.nz>'
     mary = 'Mary Bloggs <mary@napierwallies.co.nz>'
     commits = None
     patches = None
-    verbosity = False
-    preserve_outdirs = False
-
-    # Fake patchwork info for testing
-    SERIES_ID_SECOND_V1 = 456
-    TITLE_SECOND = 'Series for my board'
-
-    @classmethod
-    def setup_test_args(cls, preserve_indir=False, preserve_outdirs=False,
-                        toolpath=None, verbosity=None, no_capture=False):
-        """Accept arguments controlling test execution
-
-        Args:
-            preserve_indir: not used
-            preserve_outdir: Preserve the output directories used by tests.
-                Each test has its own, so this is normally only useful when
-                running a single test.
-            toolpath: not used
-        """
-        cls.preserve_outdirs = preserve_outdirs
-        cls.toolpath = toolpath
-        cls.verbosity = verbosity
-        cls.no_capture = no_capture
 
     def setUp(self):
-        self.tmpdir = tempfile.mkdtemp(prefix='patman.')
-        self.gitdir = os.path.join(self.tmpdir, '.git')
+        TestCommon.setUp(self)
         self.repo = None
         self._patman_pathname = sys.argv[0]
         self._patman_dir = os.path.dirname(os.path.realpath(sys.argv[0]))
 
     def tearDown(self):
-        if self.preserve_outdirs:
-            print(f'Output dir: {self.tmpdir}')
-        else:
-            shutil.rmtree(self.tmpdir)
-        terminal.set_print_test_mode(False)
+        TestCommon.tearDown(self)
 
     @staticmethod
     def _get_path(fname):
@@ -264,7 +234,7 @@ class TestFunctional(unittest.TestCase):
                 series, cover_fname, args, dry_run, not ignore_bad_tags,
                 cc_file, alias, in_reply_to=in_reply_to, thread=None)
             series.ShowActions(args, cmd, process_tags, alias)
-        cc_lines = open(cc_file, encoding='utf-8').read().splitlines()
+        cc_lines = tools.read_file(cc_file, binary=False).splitlines()
         os.remove(cc_file)
 
         itr = iter(out[0].getvalue().splitlines())
@@ -344,14 +314,14 @@ Simon Glass (2):
 base-commit: 1a44532
 branch: mybranch
 '''
-        lines = open(cover_fname, encoding='utf-8').read().splitlines()
+        lines = tools.read_file(cover_fname, binary=False).splitlines()
         self.assertEqual(
             'Subject: [RFC PATCH some-branch v3 0/2] test: A test patch series',
             lines[3])
         self.assertEqual(expected.splitlines(), lines[7:])
 
         for i, fname in enumerate(args):
-            lines = open(fname, encoding='utf-8').read().splitlines()
+            lines = tools.read_file(fname, binary=False).splitlines()
             subject = [line for line in lines if line.startswith('Subject')]
             self.assertEqual('Subject: [RFC %d/%d]' % (i + 1, count),
                              subject[0][:18])
@@ -414,152 +384,6 @@ Changes in v2:
         self.assertEqual('base-commit: 1a44532', lines[pos + 3])
         self.assertEqual('branch: mybranch', lines[pos + 4])
 
-    def make_commit_with_file(self, subject, body, fname, text):
-        """Create a file and add it to the git repo with a new commit
-
-        Args:
-            subject (str): Subject for the commit
-            body (str): Body text of the commit
-            fname (str): Filename of file to create
-            text (str): Text to put into the file
-        """
-        path = os.path.join(self.tmpdir, fname)
-        tools.write_file(path, text, binary=False)
-        index = self.repo.index
-        index.add(fname)
-        # pylint doesn't seem to find this
-        # pylint: disable=E1101
-        author = pygit2.Signature('Test user', 'test@email.com')
-        committer = author
-        tree = index.write_tree()
-        message = subject + '\n' + body
-        self.repo.create_commit('HEAD', author, committer, message, tree,
-                                [self.repo.head.target])
-
-    def make_git_tree(self):
-        """Make a simple git tree suitable for testing
-
-        It has three branches:
-            'base' has two commits: PCI, main
-            'first' has base as upstream and two more commits: I2C, SPI
-            'second' has base as upstream and three more: video, serial, bootm
-
-        Returns:
-            pygit2.Repository: repository
-        """
-        repo = pygit2.init_repository(self.gitdir)
-        self.repo = repo
-        new_tree = repo.TreeBuilder().write()
-
-        common = ['git', f'--git-dir={self.gitdir}', 'config']
-        tools.run(*(common + ['user.name', 'Dummy']), cwd=self.gitdir)
-        tools.run(*(common + ['user.email', 'dumdum@dummy.com']),
-                  cwd=self.gitdir)
-
-        # pylint doesn't seem to find this
-        # pylint: disable=E1101
-        author = pygit2.Signature('Test user', 'test@email.com')
-        committer = author
-        _ = repo.create_commit('HEAD', author, committer, 'Created master',
-                               new_tree, [])
-
-        self.make_commit_with_file('Initial commit', '''
-Add a README
-
-''', 'README', '''This is the README file
-describing this project
-in very little detail''')
-
-        self.make_commit_with_file('pci: PCI implementation', '''
-Here is a basic PCI implementation
-
-''', 'pci.c', '''This is a file
-it has some contents
-and some more things''')
-        self.make_commit_with_file('main: Main program', '''
-Hello here is the second commit.
-''', 'main.c', '''This is the main file
-there is very little here
-but we can always add more later
-if we want to
-
-Series-to: u-boot
-Series-cc: Barry Crump <bcrump@whataroa.nz>
-''')
-        base_target = repo.revparse_single('HEAD')
-        self.make_commit_with_file('i2c: I2C things', '''
-This has some stuff to do with I2C
-''', 'i2c.c', '''And this is the file contents
-with some I2C-related things in it''')
-        self.make_commit_with_file('spi: SPI fixes', '''
-SPI needs some fixes
-and here they are
-
-Signed-off-by: %s
-
-Series-to: u-boot
-Commit-notes:
-title of the series
-This is the cover letter for the series
-with various details
-END
-''' % self.leb, 'spi.c', '''Some fixes for SPI in this
-file to make SPI work
-better than before''')
-        first_target = repo.revparse_single('HEAD')
-
-        target = repo.revparse_single('HEAD~2')
-        # pylint doesn't seem to find this
-        # pylint: disable=E1101
-        repo.reset(target.oid, pygit2.enums.ResetMode.HARD)
-        self.make_commit_with_file('video: Some video improvements', '''
-Fix up the video so that
-it looks more purple. Purple is
-a very nice colour.
-''', 'video.c', '''More purple here
-Purple and purple
-Even more purple
-Could not be any more purple''')
-        self.make_commit_with_file('serial: Add a serial driver', f'''
-Here is the serial driver
-for my chip.
-
-Cover-letter:
-{self.TITLE_SECOND}
-This series implements support
-for my glorious board.
-END
-Series-to: u-boot
-Series-links: {self.SERIES_ID_SECOND_V1}
-''', 'serial.c', '''The code for the
-serial driver is here''')
-        self.make_commit_with_file('bootm: Make it boot', '''
-This makes my board boot
-with a fix to the bootm
-command
-''', 'bootm.c', '''Fix up the bootm
-command to make the code as
-complicated as possible''')
-        second_target = repo.revparse_single('HEAD')
-
-        repo.branches.local.create('first', first_target)
-        repo.config.set_multivar('branch.first.remote', '', '.')
-        repo.config.set_multivar('branch.first.merge', '', 'refs/heads/base')
-
-        repo.branches.local.create('second', second_target)
-        repo.config.set_multivar('branch.second.remote', '', '.')
-        repo.config.set_multivar('branch.second.merge', '', 'refs/heads/base')
-
-        repo.branches.local.create('base', base_target)
-
-        target = repo.lookup_reference('refs/heads/first')
-        repo.checkout(target, strategy=pygit2.GIT_CHECKOUT_FORCE)
-        target = repo.revparse_single('HEAD')
-        repo.reset(target.oid, pygit2.enums.ResetMode.HARD)
-
-        self.assertFalse(gitutil.check_dirty(self.gitdir, self.tmpdir))
-        return repo
-
     def test_branch(self):
         """Test creating patches from a branch"""
         repo = self.make_git_tree()
@@ -787,13 +611,25 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         finally:
             os.chdir(orig_dir)
 
-    def _RunPatman(self, *args):
+    def run_patman(self, *args):
+        """Run patman using the provided arguments
+
+        This runs the patman executable from scratch, as opposed to calling
+        the control.do_patman() function.
+
+        Args:
+            args (list of str): Arguments to pass (excluding argv[0])
+
+        Return:
+            CommandResult: Result of execution
+        """
         all_args = [self._patman_pathname] + list(args)
         return command.run_one(*all_args, capture=True, capture_stderr=True)
 
-    def testFullHelp(self):
+    def test_full_help(self):
+        """Test getting full help"""
         command.TEST_RESULT = None
-        result = self._RunPatman('-H')
+        result = self.run_patman('-H')
         help_file = os.path.join(self._patman_dir, 'README.rst')
         # Remove possible extraneous strings
         extra = '::::::::::::::\n' + help_file + '\n::::::::::::::\n'
@@ -802,9 +638,10 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         self.assertEqual(0, len(result.stderr))
         self.assertEqual(0, result.return_code)
 
-    def testHelp(self):
+    def test_help(self):
+        """Test getting help with commands and arguments"""
         command.TEST_RESULT = None
-        result = self._RunPatman('-h')
+        result = self.run_patman('-h')
         self.assertTrue(len(result.stdout) > 1000)
         self.assertEqual(0, len(result.stderr))
         self.assertEqual(0, result.return_code)
diff --git a/tools/patman/test_common.py b/tools/patman/test_common.py
new file mode 100644
index 00000000000..fda62472320
--- /dev/null
+++ b/tools/patman/test_common.py
@@ -0,0 +1,222 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 Simon Glass <sjg@chromium.org>
+#
+"""Functional tests for checking that patman behaves correctly"""
+
+import os
+import shutil
+import tempfile
+
+import pygit2
+
+from u_boot_pylib import gitutil
+from u_boot_pylib import terminal
+from u_boot_pylib import tools
+from u_boot_pylib import tout
+
+
+class TestCommon:
+    """Contains common test functions"""
+    leb = (b'Lord Edmund Blackadd\xc3\xabr <weasel@blackadder.org>'.
+           decode('utf-8'))
+
+    # Fake patchwork project ID for U-Boot
+    PROJ_ID = 6
+    PROJ_LINK_NAME = 'uboot'
+    SERIES_ID_FIRST_V3 = 31
+    SERIES_ID_SECOND_V1 = 456
+    SERIES_ID_SECOND_V2 = 457
+    TITLE_SECOND = 'Series for my board'
+
+    verbosity = False
+    preserve_outdirs = False
+
+    @classmethod
+    def setup_test_args(cls, preserve_indir=False, preserve_outdirs=False,
+                        toolpath=None, verbosity=None, no_capture=False):
+        """Accept arguments controlling test execution
+
+        Args:
+            preserve_indir (bool): not used by patman
+            preserve_outdirs (bool): Preserve the output directories used by
+                tests. Each test has its own, so this is normally only useful
+                when running a single test.
+            toolpath (str): not used by patman
+            verbosity (int): verbosity to use (0 means tout.INIT, 1 means means
+                tout.DEBUG)
+            no_capture (bool): True to output all captured text after capturing
+                completes
+        """
+        del preserve_indir
+        cls.preserve_outdirs = preserve_outdirs
+        cls.toolpath = toolpath
+        cls.verbosity = verbosity
+        cls.no_capture = no_capture
+
+    def __init__(self):
+        super().__init__()
+        self.repo = None
+        self.tmpdir = None
+        self.gitdir = None
+
+    def setUp(self):
+        """Set up the test temporary dir and git dir"""
+        self.tmpdir = tempfile.mkdtemp(prefix='patman.')
+        self.gitdir = os.path.join(self.tmpdir, '.git')
+        tout.init(tout.DEBUG if self.verbosity else tout.INFO,
+                  allow_colour=False)
+
+    def tearDown(self):
+        """Delete the temporary dir"""
+        if self.preserve_outdirs:
+            print(f'Output dir: {self.tmpdir}')
+        else:
+            shutil.rmtree(self.tmpdir)
+        terminal.set_print_test_mode(False)
+
+    def make_commit_with_file(self, subject, body, fname, text):
+        """Create a file and add it to the git repo with a new commit
+
+        Args:
+            subject (str): Subject for the commit
+            body (str): Body text of the commit
+            fname (str): Filename of file to create
+            text (str): Text to put into the file
+        """
+        path = os.path.join(self.tmpdir, fname)
+        tools.write_file(path, text, binary=False)
+        index = self.repo.index
+        index.add(fname)
+        # pylint doesn't seem to find this
+        # pylint: disable=E1101
+        author = pygit2.Signature('Test user', 'test@email.com')
+        committer = author
+        tree = index.write_tree()
+        message = subject + '\n' + body
+        self.repo.create_commit('HEAD', author, committer, message, tree,
+                                [self.repo.head.target])
+
+    def make_git_tree(self):
+        """Make a simple git tree suitable for testing
+
+        It has three branches:
+            'base' has two commits: PCI, main
+            'first' has base as upstream and two more commits: I2C, SPI
+            'second' has base as upstream and three more: video, serial, bootm
+
+        Returns:
+            pygit2.Repository: repository
+        """
+        repo = pygit2.init_repository(self.gitdir)
+        self.repo = repo
+        new_tree = repo.TreeBuilder().write()
+
+        common = ['git', f'--git-dir={self.gitdir}', 'config']
+        tools.run(*(common + ['user.name', 'Dummy']), cwd=self.gitdir)
+        tools.run(*(common + ['user.email', 'dumdum@dummy.com']),
+                  cwd=self.gitdir)
+
+        # pylint doesn't seem to find this
+        # pylint: disable=E1101
+        author = pygit2.Signature('Test user', 'test@email.com')
+        committer = author
+        _ = repo.create_commit('HEAD', author, committer, 'Created master',
+                               new_tree, [])
+
+        self.make_commit_with_file('Initial commit', '''
+Add a README
+
+''', 'README', '''This is the README file
+describing this project
+in very little detail''')
+
+        self.make_commit_with_file('pci: PCI implementation', '''
+Here is a basic PCI implementation
+
+''', 'pci.c', '''This is a file
+it has some contents
+and some more things''')
+        self.make_commit_with_file('main: Main program', '''
+Hello here is the second commit.
+''', 'main.c', '''This is the main file
+there is very little here
+but we can always add more later
+if we want to
+
+Series-to: u-boot
+Series-cc: Barry Crump <bcrump@whataroa.nz>
+''')
+        base_target = repo.revparse_single('HEAD')
+        self.make_commit_with_file('i2c: I2C things', '''
+This has some stuff to do with I2C
+''', 'i2c.c', '''And this is the file contents
+with some I2C-related things in it''')
+        self.make_commit_with_file('spi: SPI fixes', f'''
+SPI needs some fixes
+and here they are
+
+Signed-off-by: {self.leb}
+
+Series-to: u-boot
+Commit-notes:
+title of the series
+This is the cover letter for the series
+with various details
+END
+''', 'spi.c', '''Some fixes for SPI in this
+file to make SPI work
+better than before''')
+        first_target = repo.revparse_single('HEAD')
+
+        target = repo.revparse_single('HEAD~2')
+        # pylint doesn't seem to find this
+        # pylint: disable=E1101
+        repo.reset(target.oid, pygit2.enums.ResetMode.HARD)
+        self.make_commit_with_file('video: Some video improvements', '''
+Fix up the video so that
+it looks more purple. Purple is
+a very nice colour.
+''', 'video.c', '''More purple here
+Purple and purple
+Even more purple
+Could not be any more purple''')
+        self.make_commit_with_file('serial: Add a serial driver', f'''
+Here is the serial driver
+for my chip.
+
+Cover-letter:
+{self.TITLE_SECOND}
+This series implements support
+for my glorious board.
+END
+Series-to: u-boot
+Series-links: {self.SERIES_ID_SECOND_V1}
+''', 'serial.c', '''The code for the
+serial driver is here''')
+        self.make_commit_with_file('bootm: Make it boot', '''
+This makes my board boot
+with a fix to the bootm
+command
+''', 'bootm.c', '''Fix up the bootm
+command to make the code as
+complicated as possible''')
+        second_target = repo.revparse_single('HEAD')
+
+        repo.branches.local.create('first', first_target)
+        repo.config.set_multivar('branch.first.remote', '', '.')
+        repo.config.set_multivar('branch.first.merge', '', 'refs/heads/base')
+
+        repo.branches.local.create('second', second_target)
+        repo.config.set_multivar('branch.second.remote', '', '.')
+        repo.config.set_multivar('branch.second.merge', '', 'refs/heads/base')
+
+        repo.branches.local.create('base', base_target)
+
+        target = repo.lookup_reference('refs/heads/first')
+        repo.checkout(target, strategy=pygit2.GIT_CHECKOUT_FORCE)
+        target = repo.revparse_single('HEAD')
+        repo.reset(target.oid, pygit2.enums.ResetMode.HARD)
+
+        self.assertFalse(gitutil.check_dirty(self.gitdir, self.tmpdir))
+        return repo
-- 
2.43.0

