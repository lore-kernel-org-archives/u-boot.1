Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7D1C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A371826B2;
	Tue, 29 Apr 2025 15:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZNnODjoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 389458283E; Tue, 29 Apr 2025 15:23:44 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA155826B2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c13802133so1458212a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1745933017; x=1746537817; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYsKVAGQAxjOS1Vul2NfEKJF21DstbN2WOVeTbPr23Q=;
 b=ZNnODjoepeyMcjWjiFwnjEO/A3I7XdWgRQr6s76Tb7li5J8lfI26ruSKKQB96fcpJR
 FEv6YJB0+nRl4oUm+xNGw7y3lQkSnoIMVReYFPZUv6HtW9mfXtwuE5emOfD6yPn3TgO9
 rRSY2/et969SXinlgM7GWeu48cNvneSiCthkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933017; x=1746537817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYsKVAGQAxjOS1Vul2NfEKJF21DstbN2WOVeTbPr23Q=;
 b=I6Knf+DMMkJYJv6htr72Nn02qNza1Gh1g0k7mHe/woIKUAePRMPvNPDf7C362xlgGN
 1cXLNp5B9y+XsgvH24Zq8ZyyZpeFKfWKXdYaF+KMJsLKKk9DnNhL1Igl6DjHkOw1+z3O
 9nkJMM56rIBUDDYjO0qRRPFjHaMhMD0xrt+JHKHMuDngUsP3bRXfBotT9aanpJ5XuSCH
 8XVJJ+QEcwA55BLyviR+yZ55Q5awTFHDFU2DfYFVGxOwCMND2TVmZh3ECxdt5F6gWCos
 vbnDzoN1zS4gehkt0k1dUH6jQQ0cuEgg5m+YdY1I5HMenQGDgdAmyvma5LDygtgHtJsB
 MQSw==
X-Gm-Message-State: AOJu0YzQwcPMZaxNO78HrxxrBCwC4sOZF5ZqThSteaHN7iYS0ArsPZKU
 sOozCfjBVJ8oJgr8Uj5kU1WI4QvJ9k+9/CNBt3BUyM3cfYhk4A/1o4L2HO8n23FX8DxgP/bt2AA
 =
X-Gm-Gg: ASbGnctu+x4G7A3c/wollLVs6av00ixu84FkUX7fyUIrXFfo3DX28Sp/qCGkkSp/ZKI
 K/LD+Od9XYGxZuuTQHROP3G8J2+XHaDMFDkMuwEjq8fHw+UTVkYEcnoE5lvDJYfEBF2C3SR3UIL
 fdwNrauySMJ2IdKT7nZ61F6rkGdce7ch53uucl4NR1xVXei+CBcfhug3roKpZW8CJtdnSn6vFFX
 2zkY+eWo/Q3xhJrqE8E3eqF8btfr+l2Vx7Q0D8hO/oW0E522Jp2nbo76Mo0Vnvf7V1T82p3LjxL
 ZSAYBxFIGK/4I4kmJyNNKrBT856TdvB46siI3wLtz6NafY+ND5JRsVLIVzGONNWVI+FSxdgBJxR
 +LA==
X-Google-Smtp-Source: AGHT+IHjNeOQ/xSENlA1aDEcrdl60difti0Ed/pYBstc4m1idzpIeH3iQwh8tdQBSwvWdZxM0z3u8w==
X-Received: by 2002:a05:6830:641b:b0:72c:3289:d5bf with SMTP id
 46e09a7af769-7306522dfd2mr9342948a34.22.1745933017170; 
 Tue, 29 Apr 2025 06:23:37 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b117371sm277320a34.16.2025.04.29.06.23.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:23:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leonard Anderweit <l.anderweit@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/30] patman: Move capture_sys_output() into terminal and
 rename
Date: Tue, 29 Apr 2025 07:21:59 -0600
Message-ID: <20250429132239.251756-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429132239.251756-1-sjg@chromium.org>
References: <20250429132239.251756-1-sjg@chromium.org>
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

This function is sometimes useful outside tests. Also it can affect how
terminal output is done, e.g. whether ANSI characters should be emitted
or not.

Move it out of the test_util package and into terminal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/binman_tests.rst    |   6 +-
 tools/binman/bintool_test.py    |  20 +++----
 tools/binman/cbfs_util_test.py  |  15 ++---
 tools/binman/elf_test.py        |   3 +-
 tools/binman/fip_util_test.py   |  11 ++--
 tools/binman/ftest.py           | 101 ++++++++++++++++----------------
 tools/binman/image_test.py      |   4 +-
 tools/buildman/func_test.py     |  10 ++--
 tools/buildman/test.py          |   6 +-
 tools/dtoc/test_dtoc.py         |  11 ++--
 tools/dtoc/test_src_scan.py     |  25 ++++----
 tools/patman/func_test.py       |  15 +++--
 tools/u_boot_pylib/terminal.py  |  16 +++++
 tools/u_boot_pylib/test_util.py |  17 ------
 14 files changed, 132 insertions(+), 128 deletions(-)

diff --git a/doc/develop/binman_tests.rst b/doc/develop/binman_tests.rst
index a632694a6fe..5e44686b8ad 100644
--- a/doc/develop/binman_tests.rst
+++ b/doc/develop/binman_tests.rst
@@ -431,11 +431,11 @@ error message produced by Binman. Sometimes you need to add several tests, each
 with their own broken image description, in order to check all the error cases.
 
 Sometimes you need to capture the console output of Binman, to check it is
-correct. You can to this with ``test_util.capture_sys_output()``, for example:
+correct. You can to this with ``terminal.capture()``, for example:
 
 .. code-block:: python
 
-    with test_util.capture_sys_output() as (_, stderr):
+    with terminal.capture() as (_, stderr):
         self._DoTestFile('071_gbb.dts', force_missing_bintools='futility',
                          entry_args=entry_args)
     err = stderr.getvalue()
@@ -572,7 +572,7 @@ In the above example, here are some possible steps:
 
        def testNxpImx8ImageMkimageMissing(self):
            """Test that binman can produce an iMX8 image"""
-           with test_util.capture_sys_output() as (_, stderr):
+           with terminal.capture() as (_, stderr):
                self._DoTestFile('339_nxp_imx8.dts',
                                 force_missing_bintools='mkimage')
            err = stderr.getvalue()
diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
index 949d6f4c8a9..7e8dafea94e 100644
--- a/tools/binman/bintool_test.py
+++ b/tools/binman/bintool_test.py
@@ -55,14 +55,14 @@ class TestBintool(unittest.TestCase):
     def test_version(self):
         """Check handling of a tool being present or absent"""
         btest = Bintool.create('_testing')
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             btest.show()
         self.assertFalse(btest.is_present())
         self.assertIn('-', stdout.getvalue())
         btest.present = True
         self.assertTrue(btest.is_present())
         self.assertEqual('123', btest.version())
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             btest.show()
         self.assertIn('123', stdout.getvalue())
 
@@ -90,7 +90,7 @@ class TestBintool(unittest.TestCase):
         col = terminal.Color()
         with unittest.mock.patch.object(tools, 'download',
                                         side_effect=fake_download):
-            with test_util.capture_sys_output() as (stdout, _):
+            with terminal.capture() as (stdout, _):
                 btest.fetch_tool(method, col, False)
         return stdout.getvalue()
 
@@ -144,7 +144,7 @@ class TestBintool(unittest.TestCase):
         with unittest.mock.patch.object(bintool.Bintool, 'tooldir', destdir):
             with unittest.mock.patch.object(tools, 'download',
                                             side_effect=handle_download):
-                with test_util.capture_sys_output() as (stdout, _):
+                with terminal.capture() as (stdout, _):
                     Bintool.fetch_tools(bintool.FETCH_ANY, ['_testing'] * 2)
         self.assertTrue(os.path.exists(dest_fname))
         data = tools.read_file(dest_fname)
@@ -177,7 +177,7 @@ class TestBintool(unittest.TestCase):
         self.count = collections.defaultdict(int)
         with unittest.mock.patch.object(bintool.Bintool, 'fetch_tool',
                                         side_effect=fake_fetch):
-            with test_util.capture_sys_output() as (stdout, _):
+            with terminal.capture() as (stdout, _):
                 Bintool.fetch_tools(method, ['all'])
         lines = stdout.getvalue().splitlines()
         self.assertIn(f'{self.count[bintool.FETCHED]}: ', lines[-2])
@@ -220,7 +220,7 @@ class TestBintool(unittest.TestCase):
                                             side_effect=[all_tools]):
                 with unittest.mock.patch.object(bintool.Bintool, 'create',
                                                 side_effect=self.btools.values()):
-                    with test_util.capture_sys_output() as (stdout, _):
+                    with terminal.capture() as (stdout, _):
                         Bintool.fetch_tools(bintool.FETCH_ANY, ['missing'])
         lines = stdout.getvalue().splitlines()
         num_tools = len(self.btools)
@@ -255,7 +255,7 @@ class TestBintool(unittest.TestCase):
         with unittest.mock.patch.object(bintool.Bintool, 'tooldir',
                                         self._indir):
             with unittest.mock.patch.object(tools, 'run', side_effect=fake_run):
-                with test_util.capture_sys_output() as (stdout, _):
+                with terminal.capture() as (stdout, _):
                     btest.fetch_tool(bintool.FETCH_BUILD, col, False)
         fname = os.path.join(self._indir, '_testing')
         return fname if write_file else self.fname, stdout.getvalue()
@@ -278,7 +278,7 @@ class TestBintool(unittest.TestCase):
         btest.install = True
         col = terminal.Color()
         with unittest.mock.patch.object(tools, 'run', return_value=None):
-            with test_util.capture_sys_output() as _:
+            with terminal.capture() as _:
                 result = btest.fetch_tool(bintool.FETCH_BIN, col, False)
         self.assertEqual(bintool.FETCHED, result)
 
@@ -287,7 +287,7 @@ class TestBintool(unittest.TestCase):
         btest = Bintool.create('_testing')
         btest.disable = True
         col = terminal.Color()
-        with test_util.capture_sys_output() as _:
+        with terminal.capture() as _:
             result = btest.fetch_tool(bintool.FETCH_BIN, col, False)
         self.assertEqual(bintool.FAIL, result)
 
@@ -314,7 +314,7 @@ class TestBintool(unittest.TestCase):
         with unittest.mock.patch.object(tools, 'run', side_effect=fake_run):
             with unittest.mock.patch.object(tools, 'download',
                                             side_effect=handle_download):
-                with test_util.capture_sys_output() as _:
+                with terminal.capture() as _:
                     for name in Bintool.get_tool_list():
                         btool = Bintool.create(name)
                         for method in range(bintool.FETCH_COUNT):
diff --git a/tools/binman/cbfs_util_test.py b/tools/binman/cbfs_util_test.py
index 4c415b7ce94..2494a6b9405 100755
--- a/tools/binman/cbfs_util_test.py
+++ b/tools/binman/cbfs_util_test.py
@@ -20,6 +20,7 @@ from binman import bintool
 from binman import cbfs_util
 from binman.cbfs_util import CbfsWriter
 from binman import elf
+from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
@@ -314,7 +315,7 @@ class TestCbfs(unittest.TestCase):
         newdata = data[:-4] + struct.pack('<I', cbw._header_offset + 1)
 
         # We should still be able to find the master header by searching
-        with test_util.capture_sys_output() as (stdout, _stderr):
+        with terminal.capture() as (stdout, _stderr):
             cbfs = cbfs_util.CbfsReader(newdata)
         self.assertIn('Relative offset seems wrong', stdout.getvalue())
         self.assertIn('u-boot', cbfs.files)
@@ -330,7 +331,7 @@ class TestCbfs(unittest.TestCase):
         # Drop most of the header and try reading the modified CBFS
         newdata = data[:cbw._header_offset + 4]
 
-        with test_util.capture_sys_output() as (stdout, _stderr):
+        with terminal.capture() as (stdout, _stderr):
             with self.assertRaises(ValueError) as e:
                 cbfs_util.CbfsReader(newdata)
         self.assertIn('Relative offset seems wrong', stdout.getvalue())
@@ -351,7 +352,7 @@ class TestCbfs(unittest.TestCase):
 
         # Remove all but 4 bytes of the file headerm and try to read the file
         newdata = data[:pos + 4]
-        with test_util.capture_sys_output() as (stdout, _stderr):
+        with terminal.capture() as (stdout, _stderr):
             with io.BytesIO(newdata) as fd:
                 fd.seek(pos)
                 self.assertEqual(False, cbr._read_next_file(fd))
@@ -373,7 +374,7 @@ class TestCbfs(unittest.TestCase):
         # Create a new CBFS with only the first 16 bytes of the file name, then
         # try to read the file
         newdata = data[:pos + cbfs_util.FILE_HEADER_LEN + 16]
-        with test_util.capture_sys_output() as (stdout, _stderr):
+        with terminal.capture() as (stdout, _stderr):
             with io.BytesIO(newdata) as fd:
                 fd.seek(pos)
                 self.assertEqual(False, cbr._read_next_file(fd))
@@ -389,7 +390,7 @@ class TestCbfs(unittest.TestCase):
 
         try:
             cbfs_util.DEBUG = True
-            with test_util.capture_sys_output() as (stdout, _stderr):
+            with terminal.capture() as (stdout, _stderr):
                 cbfs_util.CbfsReader(data)
             self.assertEqual('name u-boot\nftype 50\ndata %s\n' % U_BOOT_DATA,
                              stdout.getvalue())
@@ -416,7 +417,7 @@ class TestCbfs(unittest.TestCase):
 
         # Create a new CBFS with the tag changed to something invalid
         newdata = data[:pos] + struct.pack('>I', 0x123) + data[pos + 4:]
-        with test_util.capture_sys_output() as (stdout, _stderr):
+        with terminal.capture() as (stdout, _stderr):
             cbfs_util.CbfsReader(newdata)
         self.assertEqual('Unknown attribute tag 123\n', stdout.getvalue())
 
@@ -441,7 +442,7 @@ class TestCbfs(unittest.TestCase):
         tag_pos = (4 + pos + cbfs_util.FILE_HEADER_LEN +
                    cbfs_util.ATTRIBUTE_ALIGN)
         newdata = data[:tag_pos + 4]
-        with test_util.capture_sys_output() as (stdout, _stderr):
+        with terminal.capture() as (stdout, _stderr):
             with io.BytesIO(newdata) as fd:
                 fd.seek(pos)
                 self.assertEqual(False, cbr._read_next_file(fd))
diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
index 2f22639dffc..5b173392898 100644
--- a/tools/binman/elf_test.py
+++ b/tools/binman/elf_test.py
@@ -13,6 +13,7 @@ import unittest
 
 from binman import elf
 from u_boot_pylib import command
+from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 from u_boot_pylib import tout
@@ -187,7 +188,7 @@ class TestElf(unittest.TestCase):
             entry = FakeEntry(24)
             section = FakeSection()
             elf_fname = self.ElfTestFile('u_boot_binman_syms')
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 elf.LookupAndWriteSymbols(elf_fname, entry, section)
             self.assertTrue(len(stdout.getvalue()) > 0)
         finally:
diff --git a/tools/binman/fip_util_test.py b/tools/binman/fip_util_test.py
index 56aa56f4643..cb4001be020 100755
--- a/tools/binman/fip_util_test.py
+++ b/tools/binman/fip_util_test.py
@@ -22,6 +22,7 @@ sys.path.insert(2, os.path.join(OUR_PATH, '..'))
 # pylint: disable=C0413
 from binman import bintool
 from binman import fip_util
+from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
@@ -215,7 +216,7 @@ toc_entry_t toc_entries[] = {
 
         macros = fip_util.parse_macros(self._indir)
         names = fip_util.parse_names(self._indir)
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             fip_util.create_code_output(macros, names)
         self.assertIn(
             "UUID 'UUID_TRUSTED_OS_FW_KEY_CERT' is not mentioned in tbbr_config.c file",
@@ -239,7 +240,7 @@ FIP_TYPE_LIST = [
     ] # end
 blah de blah
                         ''', binary=False)
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             fip_util.main(self.args, self.src_file)
         self.assertIn('Needs update', stdout.getvalue())
 
@@ -256,7 +257,7 @@ FIP_TYPE_LIST = [
              0x9d, 0xf3, 0x19, 0xed, 0xa1, 0x1f, 0x68, 0x01]),
     ] # end
 blah blah''', binary=False)
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             fip_util.main(self.args, self.src_file)
         self.assertIn('is up-to-date', stdout.getvalue())
 
@@ -269,7 +270,7 @@ blah blah''', binary=False)
         args = self.args.copy()
         args.remove('-D')
         tools.write_file(self.src_file, '', binary=False)
-        with test_util.capture_sys_output():
+        with terminal.capture():
             fip_util.main(args, self.src_file)
 
     @unittest.skipIf(not HAVE_FIPTOOL, 'No fiptool available')
@@ -389,7 +390,7 @@ Trusted Boot Firmware BL2: offset=0xC0, size=0xE, cmdline="--tb-fw"
     def test_fiptool_errors(self):
         """Check some error reporting from fiptool"""
         with self.assertRaises(Exception) as err:
-            with test_util.capture_sys_output():
+            with terminal.capture():
                 FIPTOOL.create_bad()
         self.assertIn("unrecognized option '--fred'", str(err.exception))
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index e46a1e84372..7ee43d87b25 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -36,6 +36,7 @@ from binman.etype import fdtmap
 from binman.etype import image_header
 from binman.image import Image
 from u_boot_pylib import command
+from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 from u_boot_pylib import tout
@@ -1792,14 +1793,14 @@ class TestFunctional(unittest.TestCase):
 
     def testEntryDocs(self):
         """Test for creation of entry documentation"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             control.WriteEntryDocs(control.GetEntryModules())
         self.assertTrue(len(stdout.getvalue()) > 0)
 
     def testEntryDocsMissing(self):
         """Test handling of missing entry documentation"""
         with self.assertRaises(ValueError) as e:
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 control.WriteEntryDocs(control.GetEntryModules(), 'u_boot')
         self.assertIn('Documentation is missing for modules: u_boot',
                       str(e.exception))
@@ -1914,7 +1915,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'keydir': 'devkeys',
         }
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('071_gbb.dts', force_missing_bintools='futility',
                              entry_args=entry_args)
         err = stderr.getvalue()
@@ -2010,7 +2011,7 @@ class TestFunctional(unittest.TestCase):
         entry_args = {
             'keydir': 'devkeys',
         }
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('074_vblock.dts',
                              force_missing_bintools='futility',
                              entry_args=entry_args)
@@ -2054,7 +2055,7 @@ class TestFunctional(unittest.TestCase):
 
         # We should only get the expected message in verbose mode
         for verbosity in (0, 2):
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 retcode = self._DoTestFile('006_dual_image.dts',
                                            verbosity=verbosity,
                                            images=['image2'])
@@ -2243,7 +2244,7 @@ class TestFunctional(unittest.TestCase):
 
     def testExtendSizeBad(self):
         """Test an extending entry which fails to provide contents"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             with self.assertRaises(ValueError) as e:
                 self._DoReadFileDtb('089_extend_size_bad.dts', map=True)
         self.assertIn("Node '/binman/_testing': Cannot obtain contents when "
@@ -2372,7 +2373,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackOverlapMap(self):
         """Test that overlapping regions are detected"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             with self.assertRaises(ValueError) as e:
                 self._DoTestFile('014_pack_overlap.dts', map=True)
         map_fname = tools.get_output_filename('image.map')
@@ -2566,7 +2567,7 @@ class TestFunctional(unittest.TestCase):
     def testIfwiMissing(self):
         """Test that binman still produces an image if ifwitool is missing"""
         self._SetupIfwi('fitimage.bin')
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('111_x86_rom_ifwi.dts',
                              force_missing_bintools='ifwitool')
         err = stderr.getvalue()
@@ -2910,7 +2911,7 @@ class TestFunctional(unittest.TestCase):
         tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 self._DoBinman('ls', '-i', updated_fname)
         finally:
             if tmpdir:
@@ -3074,7 +3075,7 @@ class TestFunctional(unittest.TestCase):
         tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 self._DoBinman('extract', '-i', updated_fname, 'u-boot',
                                '-f', fname)
         finally:
@@ -3725,7 +3726,7 @@ class TestFunctional(unittest.TestCase):
         u_boot_fname1 = os.path.join(outdir, 'u-boot')
         os.remove(u_boot_fname1)
 
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             control.ReplaceEntries(updated_fname, None, outdir, [])
         self.assertIn("Skipping entry '/u-boot' from missing file",
                       stderr.getvalue())
@@ -3866,7 +3867,7 @@ class TestFunctional(unittest.TestCase):
     def testMkimageMissing(self):
         """Test that binman still produces an image if mkimage is missing"""
         self._SetupSplElf()
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('156_mkimage.dts',
                              force_missing_bintools='mkimage')
         err = stderr.getvalue()
@@ -3886,7 +3887,7 @@ class TestFunctional(unittest.TestCase):
 
     def testExtblobMissingOk(self):
         """Test an image with an missing external blob that is allowed"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             ret = self._DoTestFile('158_blob_ext_missing.dts',
                                    allow_missing=True)
         self.assertEqual(103, ret)
@@ -3897,7 +3898,7 @@ class TestFunctional(unittest.TestCase):
 
     def testExtblobMissingOkFlag(self):
         """Test an image with an missing external blob allowed with -W"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             ret = self._DoTestFile('158_blob_ext_missing.dts',
                                    allow_missing=True, ignore_missing=True)
         self.assertEqual(0, ret)
@@ -3908,7 +3909,7 @@ class TestFunctional(unittest.TestCase):
 
     def testExtblobMissingOkSect(self):
         """Test an image with an missing external blob that is allowed"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('159_blob_ext_missing_sect.dts',
                              allow_missing=True)
         err = stderr.getvalue()
@@ -3916,7 +3917,7 @@ class TestFunctional(unittest.TestCase):
 
     def testPackX86RomMeMissingDesc(self):
         """Test that an missing Intel descriptor entry is allowed"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('164_x86_rom_me_missing.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: intel-descriptor")
@@ -3926,7 +3927,7 @@ class TestFunctional(unittest.TestCase):
         self._SetupIfwi('fitimage.bin')
         pathname = os.path.join(self._indir, 'fitimage.bin')
         os.remove(pathname)
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('111_x86_rom_ifwi.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: intel-ifwi")
@@ -4148,7 +4149,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFitMissingOK(self):
         """Test that binman still produces a FIT image if mkimage is missing"""
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('162_fit_external.dts', allow_missing=True,
                              force_missing_bintools='mkimage')
         err = stderr.getvalue()
@@ -4222,7 +4223,7 @@ class TestFunctional(unittest.TestCase):
 
     def testFitExtblobMissingOk(self):
         """Test a FIT with a missing external blob that is allowed"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('168_fit_missing_blob.dts',
                              allow_missing=True)
         err = stderr.getvalue()
@@ -4391,7 +4392,7 @@ class TestFunctional(unittest.TestCase):
         control.missing_blob_help = control._ReadMissingBlobHelp()
         control.missing_blob_help['wibble'] = 'Wibble test'
         control.missing_blob_help['another'] = 'Another test'
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('168_fit_missing_blob.dts',
                              allow_missing=True)
         err = stderr.getvalue()
@@ -4660,7 +4661,7 @@ class TestFunctional(unittest.TestCase):
 
     def testLz4Missing(self):
         """Test that binman still produces an image if lz4 is missing"""
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('185_compress_section.dts',
                              force_missing_bintools='lz4')
         err = stderr.getvalue()
@@ -5057,7 +5058,7 @@ class TestFunctional(unittest.TestCase):
     def testTiming(self):
         """Test output of timing information"""
         data = self._DoReadFile('055_sections.dts')
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             state.TimingShow()
         self.assertIn('read:', stdout.getvalue())
         self.assertIn('compress:', stdout.getvalue())
@@ -5152,7 +5153,7 @@ class TestFunctional(unittest.TestCase):
         self.assertEqual(version, state.GetVersion(self._indir))
 
         with self.assertRaises(SystemExit):
-            with test_util.capture_sys_output() as (_, stderr):
+            with terminal.capture() as (_, stderr):
                 self._DoBinman('-V')
         self.assertEqual('Binman %s\n' % version, stderr.getvalue())
 
@@ -5172,7 +5173,7 @@ class TestFunctional(unittest.TestCase):
 
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
-            with test_util.capture_sys_output() as (stdout, _):
+            with terminal.capture() as (stdout, _):
                 self._DoBinman('extract', '-i', updated_fname, '-F', 'list')
             self.assertEqual(
                 '''Flag (-F)   Entry type            Description
@@ -5214,7 +5215,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtblobListMissingOk(self):
         """Test an image with an missing external blob that is allowed"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('216_blob_ext_list_missing.dts',
                              allow_missing=True)
         err = stderr.getvalue()
@@ -5291,7 +5292,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 self._DoBinman('ls', '-i', updated_fname)
         finally:
             if tmpdir:
@@ -5374,7 +5375,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(True, fent.valid)
 
     def testFipMissing(self):
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('209_fip_missing.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(err, "Image 'image'.*missing.*: rmm-fw")
@@ -5428,7 +5429,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testFakeBlob(self):
         """Test handling of faking an external blob"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('217_fake_blob.dts', allow_missing=True,
                              allow_fake_blobs=True)
         err = stderr.getvalue()
@@ -5438,7 +5439,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtblobListFaked(self):
         """Test an extblob with missing external blob that are faked"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('216_blob_ext_list_missing.dts',
                              allow_fake_blobs=True)
         err = stderr.getvalue()
@@ -5446,7 +5447,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testListBintools(self):
         args = ['tool', '--list']
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             self._DoBinman(*args)
         out = stdout.getvalue().splitlines()
         self.assertTrue(len(out) >= 2)
@@ -5470,20 +5471,20 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         args = ['tool', '--fetch', '_testing']
         with unittest.mock.patch.object(tools, 'download',
                                         side_effect=fail_download):
-            with test_util.capture_sys_output() as (stdout, _):
+            with terminal.capture() as (stdout, _):
                 self._DoBinman(*args)
         self.assertIn('failed to fetch with all methods', stdout.getvalue())
 
     def testBintoolDocs(self):
         """Test for creation of bintool documentation"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             control.write_bintool_docs(control.bintool.Bintool.get_tool_list())
         self.assertTrue(len(stdout.getvalue()) > 0)
 
     def testBintoolDocsMissing(self):
         """Test handling of missing bintool documentation"""
         with self.assertRaises(ValueError) as e:
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 control.write_bintool_docs(
                     control.bintool.Bintool.get_tool_list(), 'mkimage')
         self.assertIn('Documentation is missing for modules: mkimage',
@@ -5503,7 +5504,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         tmpdir = None
         try:
             tmpdir, updated_fname = self._SetupImageInTmpdir()
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 self._RunBinman('ls', '-i', updated_fname)
         finally:
             if tmpdir:
@@ -5528,7 +5529,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keydir': 'devkeys',
         }
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('220_fit_subentry_bintool.dts',
                     force_missing_bintools='futility', entry_args=entry_args)
         err = stderr.getvalue()
@@ -5725,7 +5726,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'tee-os-path': 'missing.elf',
         }
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile(
                 '226_fit_split_elf.dts', entry_args=entry_args,
                 extra_indirs=[test_subdir], verbosity=3, **kwargs)
@@ -5780,7 +5781,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testMkimageMissingBlob(self):
         """Test using mkimage to build an image"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('229_mkimage_missing.dts', allow_missing=True,
                              allow_fake_blobs=True)
         err = stderr.getvalue()
@@ -6493,7 +6494,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
                          fdt_util.fdt32_to_cpu(node.props['entry'].value))
         self.assertEqual(U_BOOT_DATA, node.props['data'].bytes)
 
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self.checkFitTee('264_tee_os_opt_fit.dts', '')
         err = stderr.getvalue()
         self.assertRegex(
@@ -6526,7 +6527,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testExtblobOptional(self):
         """Test an image with an external blob that is optional"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             data = self._DoReadFile('266_blob_ext_opt.dts')
         self.assertEqual(REFCODE_DATA, data)
         err = stderr.getvalue()
@@ -6682,7 +6683,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
             'tee-os-path': 'missing.bin',
         }
         test_subdir = os.path.join(self._indir, TEST_FDT_SUBDIR)
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             data = self._DoReadFileDtb(
                 '276_fit_firmware_loadables.dts',
                 entry_args=entry_args,
@@ -6718,7 +6719,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testTooldir(self):
         """Test that we can specify the tooldir"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self.assertEqual(0, self._DoBinman('--tooldir', 'fred',
                                                'tool', '-l'))
         self.assertEqual('fred', bintool.Bintool.tooldir)
@@ -6727,7 +6728,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(['fred'], tools.tool_search_paths)
 
         # Try with a few toolpaths; the tooldir should be at the end
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self.assertEqual(0, self._DoBinman(
                 '--toolpath', 'mary', '--toolpath', 'anna', '--tooldir', 'fred',
                 'tool', '-l'))
@@ -6832,7 +6833,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': 'keyfile',
         }
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('279_x509_cert.dts',
                              force_missing_bintools='openssl',
                              entry_args=entry_args)
@@ -6846,7 +6847,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testMkimageMissingBlobMultiple(self):
         """Test missing blob with mkimage entry and multiple-data-files"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('292_mkimage_missing_multiple.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertIn("is missing external blobs and is non-functional", err)
@@ -7192,7 +7193,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         entry_args = {
             'keyfile': keyfile,
         }
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('296_ti_secure.dts',
                              force_missing_bintools='openssl',
                              entry_args=entry_args)
@@ -7368,7 +7369,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self._MakeInputFile("ssk.pem", data)
         self._SetupPmuFwlElf()
         self._SetupSplElf()
-        with test_util.capture_sys_output() as (_, stderr):
+        with terminal.capture() as (_, stderr):
             self._DoTestFile('307_xilinx_bootgen_sign.dts',
                              force_missing_bintools='bootgen')
         err = stderr.getvalue()
@@ -7571,7 +7572,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def test_assume_size_ok(self):
         """Test handling of the assume-size where it fits OK"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('327_assume_size_ok.dts', allow_missing=True,
                              allow_fake_blobs=True)
         err = stderr.getvalue()
@@ -7581,7 +7582,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def test_assume_size_no_fake(self):
         """Test handling of the assume-size where it fits OK"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self._DoTestFile('327_assume_size_ok.dts', allow_missing=True)
         err = stderr.getvalue()
         self.assertRegex(
@@ -7813,7 +7814,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testMkeficapsuleMissingOk(self):
         """Test that binman deals with mkeficapsule being missing"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             ret = self._DoTestFile('311_capsule.dts',
                                    force_missing_bintools='mkeficapsule',
                                    allow_missing=True)
@@ -7838,7 +7839,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
 
     def testSymbolsCompressed(self):
         """Test binman complains about symbols from a compressed section"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self.checkSymbols('338_symbols_comp.dts', U_BOOT_SPL_DATA, None)
         out = stdout.getvalue()
         self.assertIn('Symbol-writing: no value for /binman/section/u-boot',
diff --git a/tools/binman/image_test.py b/tools/binman/image_test.py
index 7d65e2d589a..26e161c91fc 100644
--- a/tools/binman/image_test.py
+++ b/tools/binman/image_test.py
@@ -7,7 +7,7 @@
 import unittest
 
 from binman.image import Image
-from u_boot_pylib.test_util import capture_sys_output
+from u_boot_pylib import terminal
 
 class TestImage(unittest.TestCase):
     def testInvalidFormat(self):
@@ -29,7 +29,7 @@ class TestImage(unittest.TestCase):
     def testMissingSymbolOptional(self):
         image = Image('name', 'node', test=True)
         image._entries = {}
-        with capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             val = image.GetSymbolValue('_binman_type_prop_pname', True, 'msg', 0)
         self.assertEqual(val, None)
         self.assertEqual("Warning: msg: Entry 'type' not found in list ()\n",
diff --git a/tools/buildman/func_test.py b/tools/buildman/func_test.py
index d70849b47ab..51c6855420e 100644
--- a/tools/buildman/func_test.py
+++ b/tools/buildman/func_test.py
@@ -670,7 +670,7 @@ Some images are invalid'''
 
     def testThreadExceptions(self):
         """Test that exceptions in threads are reported"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             self.assertEqual(102, self._RunControl('-o', self._output_dir,
                                                    test_thread_exceptions=True))
         self.assertIn(
@@ -808,7 +808,7 @@ Some images are invalid'''
 # CONFIG_LOCALVERSION_AUTO is not set
 ''', cfg_data)
 
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             lines, cfg_data = self.check_command('-r', '-a', 'LOCALVERSION')
         self.assertIn(b'SOURCE_DATE_EPOCH=0', lines[0])
 
@@ -1032,14 +1032,14 @@ endif
         outfile = os.path.join(self._output_dir, 'test-boards.cfg')
         if os.path.exists(outfile):
             os.remove(outfile)
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             result = self._RunControl('-R', outfile, brds=None,
                                       get_builder=False)
         self.assertTrue(os.path.exists(outfile))
 
     def test_print_prefix(self):
         """Test that we can print the toolchain prefix"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             result = self._RunControl('-A', 'board0')
         self.assertEqual('arm-\n', stdout.getvalue())
         self.assertEqual('', stderr.getvalue())
@@ -1083,7 +1083,7 @@ endif
 
     def test_print_arch(self):
         """Test that we can print the board architecture"""
-        with test_util.capture_sys_output() as (stdout, stderr):
+        with terminal.capture() as (stdout, stderr):
             result = self._RunControl('--print-arch', 'board0')
         self.assertEqual('arm\n', stdout.getvalue())
         self.assertEqual('', stderr.getvalue())
diff --git a/tools/buildman/test.py b/tools/buildman/test.py
index c5feb74a105..41a1f9ae65e 100644
--- a/tools/buildman/test.py
+++ b/tools/buildman/test.py
@@ -610,7 +610,7 @@ class TestBuild(unittest.TestCase):
     def testToolchainDownload(self):
         """Test that we can download toolchains"""
         if use_network:
-            with test_util.capture_sys_output() as (stdout, stderr):
+            with terminal.capture() as (stdout, stderr):
                 url = self.toolchains.LocateArchUrl('arm')
             self.assertRegex(url, 'https://www.kernel.org/pub/tools/'
                     'crosstool/files/bin/x86_64/.*/'
@@ -1054,7 +1054,7 @@ class TestBuild(unittest.TestCase):
         self.assertEqual([f'{home}/mypath'], toolchains.paths)
 
         # Check scanning
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             toolchains.Scan(verbose=True, raise_on_error=False)
         lines = iter(stdout.getvalue().splitlines() + ['##done'])
         self.assertEqual('Scanning for tool chains', next(lines))
@@ -1071,7 +1071,7 @@ class TestBuild(unittest.TestCase):
         self.assertEqual('##done', next(lines))
 
         # Check adding a toolchain
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             toolchains.Add('~/aarch64-linux-gcc', test=True, verbose=True)
         lines = iter(stdout.getvalue().splitlines() + ['##done'])
         self.assertEqual('Tool chain test:  BAD', next(lines))
diff --git a/tools/dtoc/test_dtoc.py b/tools/dtoc/test_dtoc.py
index c4a0889aebe..1a85ebcf81a 100755
--- a/tools/dtoc/test_dtoc.py
+++ b/tools/dtoc/test_dtoc.py
@@ -26,6 +26,7 @@ from dtoc.dtb_platdata import get_value
 from dtoc.dtb_platdata import tab_to
 from dtoc.src_scan import conv_name_to_c
 from dtoc.src_scan import get_compat_name
+from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
@@ -879,7 +880,7 @@ U_BOOT_DRVINFO(gpios_at_0) = {
         """Test output from a device tree file with an invalid driver"""
         dtb_file = get_dtb_file('dtoc_test_invalid_driver.dts')
         output = tools.get_output_filename('output')
-        with test_util.capture_sys_output() as _:
+        with terminal.capture() as _:
             dtb_platdata.run_steps(
                 ['struct'], dtb_file, False, output, [], None, False,
                 scan=copy_scan())
@@ -890,7 +891,7 @@ struct dtd_invalid {
 };
 ''', data)
 
-        with test_util.capture_sys_output() as _:
+        with terminal.capture() as _:
             dtb_platdata.run_steps(
                 ['platdata'], dtb_file, False, output, [], None, False,
                 scan=copy_scan())
@@ -1522,7 +1523,7 @@ U_BOOT_DRVINFO(spl_test2) = {
     def test_stdout(self):
         """Test output to stdout"""
         dtb_file = get_dtb_file('dtoc_test_simple.dts')
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             self.run_test(['struct'], dtb_file, None)
         self._check_strings(self.struct_text, stdout.getvalue())
 
@@ -1744,7 +1745,7 @@ U_BOOT_DRVINFO(spl_test2) = {
         """Test alias for a uclass that doesn't exist"""
         dtb_file = get_dtb_file('dtoc_test_alias_bad_uc.dts')
         output = tools.get_output_filename('output')
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             plat = self.run_test(['struct'], dtb_file, output)
         self.assertEqual("Could not find uclass for alias 'other1'",
                          stdout.getvalue().strip())
@@ -1821,7 +1822,7 @@ U_BOOT_DRVINFO(spl_test2) = {
         del scan._structs['dm_test_uc_priv']
 
         # Now generate the uclasses, which should provide a warning
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             plat.generate_uclasses()
         self.assertEqual(
             'Warning: Cannot find header file for struct dm_test_uc_priv',
diff --git a/tools/dtoc/test_src_scan.py b/tools/dtoc/test_src_scan.py
index 64b740841ca..385efedc851 100644
--- a/tools/dtoc/test_src_scan.py
+++ b/tools/dtoc/test_src_scan.py
@@ -15,6 +15,7 @@ import unittest
 from unittest import mock
 
 from dtoc import src_scan
+from u_boot_pylib import terminal
 from u_boot_pylib import test_util
 from u_boot_pylib import tools
 
@@ -80,7 +81,7 @@ class TestSrcScan(unittest.TestCase):
             fout.write(b'\x81')
 
         scan = src_scan.Scanner(None, [driver_fn])
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.scan_drivers()
         self.assertRegex(stdout.getvalue(),
                          r"Skipping file '.*' due to unicode error\s*")
@@ -170,7 +171,7 @@ class TestSrcScan(unittest.TestCase):
         node.parent = FakeNode()
 
         scan = src_scan.Scanner(None, None)
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             name, aliases = scan.get_normalized_compat_name(node)
         self.assertEqual('rockchip_rk3288_grf', name)
         self.assertEqual([], aliases)
@@ -189,7 +190,7 @@ class TestSrcScan(unittest.TestCase):
 
         scan._driver_aliases['rockchip_rk3288_srf'] = 'rockchip_rk3288_grf'
 
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             name, aliases = scan.get_normalized_compat_name(node)
         self.assertEqual('', stdout.getvalue().strip())
         self.assertEqual('rockchip_rk3288_grf', name)
@@ -197,7 +198,7 @@ class TestSrcScan(unittest.TestCase):
         self.assertEqual(EXPECT_WARN, scan._warnings)
 
         prop.value = 'rockchip,rk3288-srf'
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             name, aliases = scan.get_normalized_compat_name(node)
         self.assertEqual('', stdout.getvalue().strip())
         self.assertEqual('rockchip_rk3288_grf', name)
@@ -379,7 +380,7 @@ struct another_struct {
         tools.write_file(output, b'struct this is a test \x81 of bad unicode')
 
         scan = src_scan.Scanner(None, None)
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.scan_header(output)
         self.assertIn('due to unicode error', stdout.getvalue())
 
@@ -456,7 +457,7 @@ U_BOOT_DRIVER(%s) = {
         self.assertTrue(drv2.warn_dups)
 
         # We should see a warning
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.mark_used([node])
         self.assertEqual(
             "Warning: Duplicate driver name 'nvidia_tegra114_i2c' (orig=file2.c, dups=file1.c)",
@@ -477,7 +478,7 @@ U_BOOT_DRIVER(%s) = {
         self.assertFalse(drv1.warn_dups)
 
         # We should not see a warning
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.mark_used([node])
         self.assertEqual('', stdout.getvalue().strip())
 
@@ -539,7 +540,7 @@ U_BOOT_DRIVER(i2c_tegra) = {
         # get_normalized_compat_name() uses this to check for root node
         tnode.parent = FakeNode()
 
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.get_normalized_compat_name(node)
             scan.get_normalized_compat_name(tnode)
         self.assertEqual('', stdout.getvalue().strip())
@@ -547,14 +548,14 @@ U_BOOT_DRIVER(i2c_tegra) = {
         self.assertEqual(2, len(scan._missing_drivers))
         self.assertEqual({'rockchip_rk3288_grf', 'nvidia_tegra114_i2c'},
                          scan._missing_drivers)
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.show_warnings()
         self.assertIn('rockchip_rk3288_grf', stdout.getvalue())
 
         # This should show just the rockchip warning, since the tegra driver
         # is not in self._missing_drivers
         scan._missing_drivers.remove('nvidia_tegra114_i2c')
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.show_warnings()
         self.assertIn('rockchip_rk3288_grf', stdout.getvalue())
         self.assertNotIn('tegra_i2c_ids', stdout.getvalue())
@@ -563,7 +564,7 @@ U_BOOT_DRIVER(i2c_tegra) = {
         # used, the warning related to that driver will be shown
         drv = scan._drivers['i2c_tegra']
         drv.used = True
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.show_warnings()
         self.assertIn('rockchip_rk3288_grf', stdout.getvalue())
         self.assertIn('tegra_i2c_ids', stdout.getvalue())
@@ -572,7 +573,7 @@ U_BOOT_DRIVER(i2c_tegra) = {
         scan._warnings['i2c_tegra'].update(
             scan._warnings['nvidia_tegra114_i2c'])
         del scan._warnings['nvidia_tegra114_i2c']
-        with test_util.capture_sys_output() as (stdout, _):
+        with terminal.capture() as (stdout, _):
             scan.show_warnings()
         self.assertEqual('''i2c_tegra: WARNING: the driver nvidia_tegra114_i2c was not found in the driver list
          : file.c: Warning: unexpected suffix ' + 1' on .of_match line for compat 'tegra_i2c_ids'
diff --git a/tools/patman/func_test.py b/tools/patman/func_test.py
index 720746e21f5..a31c950051b 100644
--- a/tools/patman/func_test.py
+++ b/tools/patman/func_test.py
@@ -25,7 +25,6 @@ from patman import settings
 from u_boot_pylib import gitutil
 from u_boot_pylib import terminal
 from u_boot_pylib import tools
-from u_boot_pylib.test_util import capture_sys_output
 
 import pygit2
 from patman import status
@@ -221,7 +220,7 @@ class TestFunctional(unittest.TestCase):
         cover_fname, args = self._create_patches_for_test(series)
         get_maintainer_script = str(pathlib.Path(__file__).parent.parent.parent
                                     / 'get_maintainer.pl') + ' --norolestats'
-        with capture_sys_output() as out:
+        with terminal.capture() as out:
             patchstream.fix_patches(series, args)
             if cover_fname and series.get('cover'):
                 patchstream.insert_cover_letter(cover_fname, series, count)
@@ -367,7 +366,7 @@ Changes in v2:
         series.branch = 'mybranch'
         cover_fname, args = self._create_patches_for_test(series)
         self.assertFalse(cover_fname)
-        with capture_sys_output() as out:
+        with terminal.capture() as out:
             patchstream.fix_patches(series, args, insert_base_commit=True)
         self.assertEqual('Cleaned 1 patch\n', out[0].getvalue())
         lines = tools.read_file(args[0], binary=False).splitlines()
@@ -530,7 +529,7 @@ complicated as possible''')
             # Check that it can detect the current branch
             self.assertEqual(2, gitutil.count_commits_to_branch(None))
             col = terminal.Color()
-            with capture_sys_output() as _:
+            with terminal.capture() as _:
                 _, cover_fname, patch_files = control.prepare_patches(
                     col, branch=None, count=-1, start=0, end=0,
                     ignore_binary=False, signoff=True)
@@ -539,7 +538,7 @@ complicated as possible''')
 
             # Check that it can detect a different branch
             self.assertEqual(3, gitutil.count_commits_to_branch('second'))
-            with capture_sys_output() as _:
+            with terminal.capture() as _:
                 series, cover_fname, patch_files = control.prepare_patches(
                     col, branch='second', count=-1, start=0, end=0,
                     ignore_binary=False, signoff=True)
@@ -558,7 +557,7 @@ complicated as possible''')
                 self.assertNotIn(b'base-commit:', tools.read_file(fname))
 
             # Check that it can skip patches at the end
-            with capture_sys_output() as _:
+            with terminal.capture() as _:
                 _, cover_fname, patch_files = control.prepare_patches(
                     col, branch='second', count=-1, start=0, end=1,
                     ignore_binary=False, signoff=True)
@@ -600,7 +599,7 @@ complicated as possible''')
             os.chmod('dummy-script.sh', 0x555)
 
             # Finally, do the test
-            with capture_sys_output():
+            with terminal.capture():
                 output = tools.run(PATMAN_DIR / 'patman', '--dry-run')
                 # Assert the email address is part of the dry-run
                 # output.
@@ -766,7 +765,7 @@ diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
         """Test Patchwork patches not matching the series"""
         series = Series()
 
-        with capture_sys_output() as (_, err):
+        with terminal.capture() as (_, err):
             status.collect_patches(series, 1234, None, self._fake_patchwork)
         self.assertIn('Warning: Patchwork reports 1 patches, series has 0',
                       err.getvalue())
diff --git a/tools/u_boot_pylib/terminal.py b/tools/u_boot_pylib/terminal.py
index 2cd5a54ab52..84531831760 100644
--- a/tools/u_boot_pylib/terminal.py
+++ b/tools/u_boot_pylib/terminal.py
@@ -7,6 +7,8 @@
 This module handles terminal interaction including ANSI color codes.
 """
 
+from contextlib import contextmanager
+from io import StringIO
 import os
 import re
 import shutil
@@ -271,3 +273,17 @@ class Color(object):
             base = self.BRIGHT_START if bright else self.NORMAL_START
             start = base % (color + 30)
         return start + text + self.RESET
+
+
+# Use this to suppress stdout/stderr output:
+# with terminal.capture() as (stdout, stderr)
+#   ...do something...
+@contextmanager
+def capture():
+    capture_out, capture_err = StringIO(), StringIO()
+    old_out, old_err = sys.stdout, sys.stderr
+    try:
+        sys.stdout, sys.stderr = capture_out, capture_err
+        yield capture_out, capture_err
+    finally:
+        sys.stdout, sys.stderr = old_out, old_err
diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index 4835847bfc6..f6b94265c9f 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -3,7 +3,6 @@
 # Copyright (c) 2016 Google, Inc
 #
 
-from contextlib import contextmanager
 import doctest
 import glob
 import multiprocessing
@@ -14,8 +13,6 @@ import unittest
 
 from u_boot_pylib import command
 
-from io import StringIO
-
 use_concurrent = True
 try:
     from concurrencytest import ConcurrentTestSuite
@@ -113,20 +110,6 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
         raise ValueError('Test coverage failure')
 
 
-# Use this to suppress stdout/stderr output:
-# with capture_sys_output() as (stdout, stderr)
-#   ...do something...
-@contextmanager
-def capture_sys_output():
-    capture_out, capture_err = StringIO(), StringIO()
-    old_out, old_err = sys.stdout, sys.stderr
-    try:
-        sys.stdout, sys.stderr = capture_out, capture_err
-        yield capture_out, capture_err
-    finally:
-        sys.stdout, sys.stderr = old_out, old_err
-
-
 class FullTextTestResult(unittest.TextTestResult):
     """A test result class that can print extended text results to a stream
 
-- 
2.43.0

