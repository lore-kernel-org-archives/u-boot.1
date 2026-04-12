Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2231EE937E1
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 11:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66DD84227;
	Sun, 12 Apr 2026 13:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ULkQIls0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D10BB841D7; Sun, 12 Apr 2026 13:24:39 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30B1184222
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 13:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dbcf927395so2052162a34.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775993075; x=1776597875; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ZEcZEYVEXNb8uU8+BrYsp2Wj3HiMZ08j0r/2uf5zrw=;
 b=ULkQIls0YRFQTbUh18p41xNdrCMxmnlzLTB4mpT0hUG4XpseTUDWKMOKrYO1fR5mP1
 hpT9K/pq2nO+bic/o7JL2ehyZ5eDc3aNeOR85Q88JDbKcEvyMZPPyG+2TKMTW9AvYqjO
 7MnwrV3rnhGzgE/9lvSFSyQeQTfKF4+5NrRFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775993075; x=1776597875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ZEcZEYVEXNb8uU8+BrYsp2Wj3HiMZ08j0r/2uf5zrw=;
 b=pBFtCnFfoNABH7qGgIK5W/ixR5OFD5s/dCrS6TXm4Mt+GsYUN2gDYs6maK0DI3gmqR
 zTG1iqpw7b5f8+n7Eoe0XRS8KW+0J97Ko2BgZGJePCPgUYaAd6R31xrOAnloBAf7Ql9e
 aM8WjZWfcxNgj+bID0Q3ikqQ0Mm6vKN61pF7WnwlfE/GMO+yRPRwA1WmLjC16A18rjdC
 2GJWbVBaVCbVszget44Ct57DJcUiW3X96QZPb2fKxcVsr8v9J2afD747Fgj544O0+P9u
 XQ19U9OFhcZ2nvwAJoq0aM8MeNPVPxeOpZ5w3Lkj4rxzdpS+i3ZgXgSTcgGaM1k6aNuv
 BWyw==
X-Gm-Message-State: AOJu0YyjaMTCaiXzv3bdKs22qDItHYjqVC8ZHUMQ+UjzUQjyWRwX3YtX
 vSOAIpP45bcMpydFCQDwoLAOMNx/WqRCD/0XeNwY0D9HWvfI4R5KoKn0FJdegTe7nX5a7tcOTkt
 h/YsCnw==
X-Gm-Gg: AeBDiesTmJ2WRskBpPx2vQfvYLrfj/4VA8jGnk4jeI3Hreac2qrPbSuLeojCG8htB+9
 oERomNRuVWTXChAcr3N6SqQavxrhadRK8Tk4j4Miqt+b6GsPdyByXeCifIDlIfiZ821QTg5fzIc
 YXfyesaDqaUIKBBSyhZcwDSOmx2G6Zffk8zTyTW+QDmKnUQbb2/BT1M6NHPWf0w/qajTr179Ib/
 iLCcZKKkheu6K/4j4l8kbbcr//DbkX9j/uaE4+0S/AA6icBWdbj5ekI+1+j1oz5Asas2lX8fHr5
 68pE80IBmYiWUkZ0m5FY3/4/GzeCCqGMRKzGSVmWsPyxdmyyXgt2133r0tvSHMtUH1gb9pOuMaU
 fOdPbus4DqbUhTCxmKh4cTproavxI0eWKwFvLJXShTv3p+++64agpuxVIw96fzFl0n61xLIc9zg
 tH7oovX7dVFcjTqCSCAw==
X-Received: by 2002:a4a:e84a:0:b0:67f:abdd:24b9 with SMTP id
 006d021491bc7-68be7de9138mr4524053eaf.29.1775993074954; 
 Sun, 12 Apr 2026 04:24:34 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd395606sm6622071fac.1.2026.04.12.04.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2026 04:24:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 12/12] test: fs: Update Python tests to call C
 implementations
Date: Sun, 12 Apr 2026 05:19:49 -0600
Message-ID: <20260412111958.943933-13-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412111958.943933-1-sjg@chromium.org>
References: <20260412111958.943933-1-sjg@chromium.org>
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

Update test_basic.py to call the new C-based filesystem tests via the
'ut' command. This allows tests to run more directly, calling the actual
FS layer, without having to go through the command interface and
worrying about which filesystem command to use.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/tests/test_fs/conftest.py   |   4 +-
 test/py/tests/test_fs/test_basic.py | 346 ++++++++--------------------
 2 files changed, 98 insertions(+), 252 deletions(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 0205048e73a..5fc796097e3 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -198,8 +198,6 @@ def fs_obj_basic(request, u_boot_config):
         volume file name and  a list of MD5 hashes.
     """
     fs_type = request.param
-    fs_cmd_prefix = fstype_to_prefix(fs_type)
-    fs_cmd_write = 'save' if fs_type == 'fs_generic' or fs_type == 'exfat' else 'write'
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
@@ -289,7 +287,7 @@ def fs_obj_basic(request, u_boot_config):
         pytest.skip('Setup failed for filesystem: ' + fs_type + '. {}'.format(err))
         return
     else:
-        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fs_img, md5val]
+        yield [fs_ubtype, fs_img, md5val]
     finally:
         call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index 88b163ce305..7f805d04dd5 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -6,298 +6,146 @@
 
 """
 This test verifies basic read/write operation on file system.
+
+Tests are implemented in C (test/fs/fs_basic.c) and called from here.
+Python handles filesystem image setup and environment variable configuration.
 """
 
 import pytest
-import re
-from fstest_defs import *
+from fstest_defs import SMALL_FILE, BIG_FILE
 from fstest_helpers import assert_fs_integrity
 
-@pytest.mark.boardspec('sandbox')
-@pytest.mark.slow
-class TestFsBasic(object):
-    def test_fs1(self, ubman, fs_obj_basic):
-        """
-        Test Case 1 - ls command, listing a root directory and invalid directory
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
-        with ubman.log.section('Test Case 1a - ls'):
-            # Test Case 1 - ls
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sls host 0:0' % fs_cmd_prefix])
-            assert(re.search('2621440000 *%s' % BIG_FILE, ''.join(output)))
-            assert(re.search('1048576 *%s' % SMALL_FILE, ''.join(output)))
 
-        with ubman.log.section('Test Case 1b - ls (invalid dir)'):
-            # In addition, test with a nonexistent directory to see if we crash.
-            output = ubman.run_command(
-                '%sls host 0:0 invalid_d' % fs_cmd_prefix)
-            assert('' == output)
+def run_c_test(ubman, fs_type, fs_img, test_name, small=None, big=None,
+               md5val=None):
+    """Run a C unit test with proper setup.
 
-        with ubman.log.section('Test Case 1c - test -e'):
-            # Test Case 1 - test -e
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                'test -e host 0:0 1MB.file && echo PASS'])
-            assert('PASS' in ''.join(output))
+    Args:
+        ubman (ConsoleBase): U-Boot console manager
+        fs_type (str): Filesystem type (ext4, fat, fs_generic, exfat)
+        fs_img (str): Path to filesystem image
+        test_name (str): Name of C test function (without _norun suffix)
+        small (str): Filename of small test file (optional)
+        big (str): Filename of big test file (optional)
+        md5val (str): Expected MD5 value for verification (optional)
 
-        with ubman.log.section('Test Case 1d - test -e (invalid file)'):
-            # In addition, test with a nonexistent file to see if we crash.
-            output = ubman.run_command(
-                'test -e host 0:0 2MB.file || echo PASS')
-            assert('PASS' in ''.join(output))
+    Returns:
+        bool: True if test passed, False otherwise
+    """
+    # Build the command with arguments
+    cmd = f'ut -f fs {test_name}_norun fs_type={fs_type} fs_image={fs_img}'
+    if small:
+        cmd += f' small={small}'
+    if big:
+        cmd += f' big={big}'
+    if md5val:
+        cmd += f' md5val={md5val}'
 
-    def test_fs2(self, ubman, fs_obj_basic):
-        """
-        Test Case 2 - size command for a small file
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
-        with ubman.log.section('Test Case 2a - size (small)'):
-            # 1MB is 0x0010 0000
-            # Test Case 2a - size of small file
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%ssize host 0:0 /%s' % (fs_cmd_prefix, SMALL_FILE),
-                'printenv filesize',
-                'setenv filesize'])
-            assert('filesize=100000' in ''.join(output))
+    # Run the C test
+    ubman.run_command(cmd)
+
+    # Check result
+    result = ubman.run_command('echo $?')
+    return result.strip() == '0'
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.slow
+class TestFsBasic:
+    """Test basic filesystem operations via C unit tests."""
+
+    def test_fs1(self, ubman, fs_obj_basic):
+        """Test Case 1 - ls command, listing root and invalid directories"""
+        fs_type, fs_img, _ = fs_obj_basic
+        with ubman.log.section('Test Case 1 - ls'):
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_ls',
+                              small=SMALL_FILE, big=BIG_FILE)
 
-        with ubman.log.section('Test Case 2b - size (/../<file>)'):
-            # Test Case 2b - size of small file via a path using '..'
-            output = ubman.run_command_list([
-                '%ssize host 0:0 /SUBDIR/../%s' % (fs_cmd_prefix, SMALL_FILE),
-                'printenv filesize',
-                'setenv filesize'])
-            assert('filesize=100000' in ''.join(output))
+    def test_fs2(self, ubman, fs_obj_basic):
+        """Test Case 2 - size command for a small file"""
+        fs_type, fs_img, _ = fs_obj_basic
+        with ubman.log.section('Test Case 2 - size (small)'):
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_size_small',
+                              small=SMALL_FILE)
 
     def test_fs3(self, ubman, fs_obj_basic):
-        """
-        Test Case 3 - size command for a large file
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 3 - size command for a large file"""
+        fs_type, fs_img, _ = fs_obj_basic
         with ubman.log.section('Test Case 3 - size (large)'):
-            # 2.5GB (1024*1024*2500) is 0x9C40 0000
-            # Test Case 3 - size of big file
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%ssize host 0:0 /%s' % (fs_cmd_prefix, BIG_FILE),
-                'printenv filesize',
-                'setenv filesize'])
-            assert('filesize=9c400000' in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_size_big',
+                              big=BIG_FILE)
 
     def test_fs4(self, ubman, fs_obj_basic):
-        """
-        Test Case 4 - load a small file, 1MB
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 4 - load a small file, 1MB"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 4 - load (small)'):
-            # Test Case 4a - Read full 1MB of small file
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, SMALL_FILE),
-                'printenv filesize'])
-            assert('filesize=100000' in ''.join(output))
-
-            # Test Case 4b - Read full 1MB of small file
-            output = ubman.run_command_list([
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[0] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_load_small',
+                              small=SMALL_FILE, md5val=md5val[0])
 
     def test_fs5(self, ubman, fs_obj_basic):
-        """
-        Test Case 5 - load, reading first 1MB of 3GB file
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 5 - load, reading first 1MB of 3GB file"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 5 - load (first 1MB)'):
-            # Test Case 5a - First 1MB of big file
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s %x 0x0' % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
-                'printenv filesize'])
-            assert('filesize=100000' in ''.join(output))
-
-            # Test Case 5b - First 1MB of big file
-            output = ubman.run_command_list([
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[1] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_load_big_first',
+                              big=BIG_FILE, md5val=md5val[1])
 
     def test_fs6(self, ubman, fs_obj_basic):
-        """
-        Test Case 6 - load, reading last 1MB of 3GB file
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 6 - load, reading last 1MB of 3GB file"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 6 - load (last 1MB)'):
-            # fails for ext as no offset support
-            # Test Case 6a - Last 1MB of big file
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s %x 0x9c300000'
-                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
-                'printenv filesize'])
-            assert('filesize=100000' in ''.join(output))
-
-            # Test Case 6b - Last 1MB of big file
-            output = ubman.run_command_list([
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[2] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_load_big_last',
+                              big=BIG_FILE, md5val=md5val[2])
 
     def test_fs7(self, ubman, fs_obj_basic):
-        """
-        Test Case 7 - load, 1MB from the last 1MB in 2GB
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 7 - load, 1MB from the last 1MB in 2GB"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 7 - load (last 1MB in 2GB)'):
-            # fails for ext as no offset support
-            # Test Case 7a - One from the last 1MB chunk of 2GB
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s %x 0x7ff00000'
-                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
-                'printenv filesize'])
-            assert('filesize=100000' in ''.join(output))
-
-            # Test Case 7b - One from the last 1MB chunk of 2GB
-            output = ubman.run_command_list([
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[3] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img,
+                              'fs_test_load_big_2g_last',
+                              big=BIG_FILE, md5val=md5val[3])
 
     def test_fs8(self, ubman, fs_obj_basic):
-        """
-        Test Case 8 - load, reading first 1MB in 2GB
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 8 - load, reading first 1MB in 2GB"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 8 - load (first 1MB in 2GB)'):
-            # fails for ext as no offset support
-            # Test Case 8a - One from the start 1MB chunk from 2GB
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s %x 0x80000000'
-                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
-                'printenv filesize'])
-            assert('filesize=100000' in ''.join(output))
-
-            # Test Case 8b - One from the start 1MB chunk from 2GB
-            output = ubman.run_command_list([
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[4] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img,
+                              'fs_test_load_big_2g_first',
+                              big=BIG_FILE, md5val=md5val[4])
 
     def test_fs9(self, ubman, fs_obj_basic):
-        """
-        Test Case 9 - load, 1MB crossing 2GB boundary
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 9 - load, 1MB crossing 2GB boundary"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 9 - load (crossing 2GB boundary)'):
-            # fails for ext as no offset support
-            # Test Case 9a - One 1MB chunk crossing the 2GB boundary
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s %x 0x7ff80000'
-                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
-                'printenv filesize'])
-            assert('filesize=100000' in ''.join(output))
-
-            # Test Case 9b - One 1MB chunk crossing the 2GB boundary
-            output = ubman.run_command_list([
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[5] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img,
+                              'fs_test_load_big_2g_cross',
+                              big=BIG_FILE, md5val=md5val[5])
 
     def test_fs10(self, ubman, fs_obj_basic):
-        """
-        Test Case 10 - load, reading beyond file end'):
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 10 - load, reading beyond file end"""
+        fs_type, fs_img, _ = fs_obj_basic
         with ubman.log.section('Test Case 10 - load (beyond file end)'):
-            # Generic failure case
-            # Test Case 10 - 2MB chunk from the last 1MB of big file
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s 0x00200000 0x9c300000'
-                    % (fs_cmd_prefix, ADDR, BIG_FILE),
-                'printenv filesize',
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-        assert('filesize=100000' in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_load_beyond',
+                              big=BIG_FILE)
 
     def test_fs11(self, ubman, fs_obj_basic):
-        """
-        Test Case 11 - write'
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 11 - write"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 11 - write'):
-            # Read 1MB from small file
-            # Write it back to test the writes
-            # Test Case 11a - Check that the write succeeded
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, SMALL_FILE),
-                '%s%s host 0:0 %x /%s.w $filesize'
-                    % (fs_cmd_prefix, fs_cmd_write, ADDR, SMALL_FILE)])
-            assert('1048576 bytes written' in ''.join(output))
-
-            # Test Case 11b - Check md5 of written to is same
-            # as the one read from
-            output = ubman.run_command_list([
-                '%sload host 0:0 %x /%s.w' % (fs_cmd_prefix, ADDR, SMALL_FILE),
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[0] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_write',
+                              small=SMALL_FILE, md5val=md5val[0])
             assert_fs_integrity(fs_type, fs_img)
 
     def test_fs12(self, ubman, fs_obj_basic):
-        """
-        Test Case 12 - write to "." directory
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 12 - write to "." directory"""
+        fs_type, fs_img, _ = fs_obj_basic
         with ubman.log.section('Test Case 12 - write (".")'):
-            # Next test case checks writing a file whose dirent
-            # is the first in the block, which is always true for "."
-            # The write should fail, but the lookup should work
-            # Test Case 12 - Check directory traversal
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%s%s host 0:0 %x /. 0x10'
-                    % (fs_cmd_prefix, fs_cmd_write, ADDR)])
-            assert('Unable to write' in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_write_dot')
             assert_fs_integrity(fs_type, fs_img)
 
     def test_fs13(self, ubman, fs_obj_basic):
-        """
-        Test Case 13 - write to a file with "/./<filename>"
-        """
-        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
+        """Test Case 13 - write to a file with '/./<filename>'"""
+        fs_type, fs_img, md5val = fs_obj_basic
         with ubman.log.section('Test Case 13 - write  ("./<file>")'):
-            # Read 1MB from small file
-            # Write it via "same directory", i.e. "." dirent
-            # Test Case 13a - Check directory traversal
-            output = ubman.run_command_list([
-                'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, SMALL_FILE),
-                '%s%s host 0:0 %x /./%s2 $filesize'
-                    % (fs_cmd_prefix, fs_cmd_write, ADDR, SMALL_FILE)])
-            assert('1048576 bytes written' in ''.join(output))
-
-            # Test Case 13b - Check md5 of written to is same
-            # as the one read from
-            output = ubman.run_command_list([
-                'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /./%s2' % (fs_cmd_prefix, ADDR, SMALL_FILE),
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[0] in ''.join(output))
-
-            # Test Case 13c - Check md5 of written to is same
-            # as the one read from
-            output = ubman.run_command_list([
-                'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /%s2' % (fs_cmd_prefix, ADDR, SMALL_FILE),
-                'md5sum %x $filesize' % ADDR,
-                'setenv filesize'])
-            assert(md5val[0] in ''.join(output))
+            assert run_c_test(ubman, fs_type, fs_img, 'fs_test_write_dotpath',
+                              small=SMALL_FILE, md5val=md5val[0])
             assert_fs_integrity(fs_type, fs_img)
-- 
2.43.0

