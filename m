Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64C4C35FF1
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AF278197D;
	Mon, 17 Mar 2025 04:14:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181299;
	bh=8RGPPkGEjN6rB6uB3iSleGiR6SCEpSF4YrDcJeSs/7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IyrmrIlp0WCzvtKCs6MvkNh67FsI0yQ9o5//DBKG9wb5Sma6vsmfkcBEHaUiBzTmA
	 k5uOlSAmrD7eyHPcQXFpilnGuk9Deg4z7Xhmj5h4ToqnYYlJFhn3DRSRdqfdHZHP57
	 uObCIi/jRoAukH4u0IzOioo9EKQrsqu3G4jT8jizoaC7+LTNT2hZX+I014Bwt8ysqG
	 adtS8L3KWdbfdDI78h+hgrhN084O3oZWtY7mwmsiR6SdK8ZD/uyxjrW/o0BPHDzNPq
	 DXBpzMlnN3/Ju6tUTwiW8cIM5q1AQfyLxgNjBTek8eh0vq6cjyIDf6eIwUlg7lccgf
	 i7LB/2qf5RwHw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A32F88191C; Mon, 17 Mar 2025 04:14:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A87B81101
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hmJIhQeo"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D16DC103D1FFE; Mon, 17 Mar 2025 04:14:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181294; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=8RGPPkGEjN6rB6uB3iSleGiR6SCEpSF4YrDcJeSs/7k=;
 b=hmJIhQeocOeAHuH7oP4aZf2aGW/nIqeUAma6/qQj5uiQvJi13sowQSztKdIj+TBx7jptc9
 sVY8BWbnSfIyFkvl+aL3d2as3VHe49uGT+lZpsvDIWVN4vT32FVWEiauuvEuc9+ltrR4ud
 pVRFPOGSEjHyK58xw/UGE5CIujoY4jhLulKRg6/+JWUYG4VNzpjJ/9mu2zSq7cfouw+AWj
 0LyjhgAB2T4HRR5el+QKHJ1cBdEh2G+cG50ZtGlO9UJ6iyvWcUskYho2iR4gZa+M7Q3CIC
 SsH3cMJa7DPkFMQEFfGrFpo6R9/I0aM/v/cn2/oIqzendCs0bTkCIo4PstqdKA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 03/11] test_fs: Allow testing FS_GENERIC
Date: Mon, 17 Mar 2025 04:12:42 +0100
Message-ID: <20250317031418.223019-4-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317031418.223019-1-marex@denx.de>
References: <20250317031418.223019-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

The generic filesystem interface was so far untested. The interface
is similar to the FS specific interfaces with FS specific prefixes,
like ext4ls, fatmkdir, ... but it does not have any prefixes, i.e.
it provides plain ls, mkdir, ... commands.

Extend the test parameters to include 'fs_cmd_prefix' and optionally
'fs_cmd_write' parameters. The 'fs_cmd_prefix' allow specifying the
filesystem specific command prefix, like 'ext4' in 'ext4ls'. The
'fs_cmd_write' allows selecting between 'write'/'save' command name
for storing files into the filesystem, see last paragraph.

Introduce new 'fs_generic' fs_type which is used to parametrize existing
tests and run them without any prefixes if detected, thus testing the
generic filesystem interface. Use the fatfs as the backing store for the
generic FS tests.

The check_ubconfig needs to be slightly adjusted to avoid test for
CMD_FS_GENERIC_WRITE which does not exist separately from CMD_FS_GENERIC.

The CMD_FS_GENERIC does not provide generic 'write' command, instead
the generic equivalent command is called 'save' . Add simple ternary
oeprator to use 'save' command for CMD_FS_GENERIC tests and '..write'
commands for filesystem specific tests.

Enable generic filesystem tests for basic/extended/mkdir/unlink tests.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
V3: Rebase on u-boot/next
---
 test/py/tests/fs_helper.py           |   2 +-
 test/py/tests/test_fs/conftest.py    |  40 +++++--
 test/py/tests/test_fs/test_basic.py  |  71 ++++++------
 test/py/tests/test_fs/test_ext.py    | 156 +++++++++++++--------------
 test/py/tests/test_fs/test_mkdir.py  |  42 ++++----
 test/py/tests/test_fs/test_unlink.py |  38 +++----
 6 files changed, 187 insertions(+), 162 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index ccfc0201a49..378d5ae0690 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -35,7 +35,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
     else:
         mkfs_opt = ''
 
-    if re.match('fat', fs_type):
+    if re.match('fat', fs_type) or fs_type == 'fs_generic':
         fs_lnxtype = 'vfat'
     else:
         fs_lnxtype = fs_type
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 47a584ffe7c..691bdf41ede 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -11,11 +11,11 @@ from fstest_defs import *
 # pylint: disable=E0611
 from tests import fs_helper
 
-supported_fs_basic = ['fat16', 'fat32', 'ext4']
-supported_fs_ext = ['fat12', 'fat16', 'fat32']
+supported_fs_basic = ['fat16', 'fat32', 'ext4', 'fs_generic']
+supported_fs_ext = ['fat12', 'fat16', 'fat32', 'fs_generic']
 supported_fs_fat = ['fat12', 'fat16']
-supported_fs_mkdir = ['fat12', 'fat16', 'fat32']
-supported_fs_unlink = ['fat12', 'fat16', 'fat32']
+supported_fs_mkdir = ['fat12', 'fat16', 'fat32', 'fs_generic']
+supported_fs_unlink = ['fat12', 'fat16', 'fat32', 'fs_generic']
 supported_fs_symlink = ['ext4']
 supported_fs_rename = ['fat12', 'fat16', 'fat32']
 
@@ -108,6 +108,22 @@ def pytest_generate_tests(metafunc):
 #
 # Helper functions
 #
+def fstype_to_prefix(fs_type):
+    """Convert a file system type to an U-Boot command prefix
+
+    Args:
+        fs_type: File system type.
+
+    Return:
+        A corresponding command prefix for file system type.
+    """
+    if fs_type == 'fs_generic':
+        return ''
+    elif re.match('fat', fs_type):
+        return 'fat'
+    else:
+        return fs_type
+
 def fstype_to_ubname(fs_type):
     """Convert a file system type to an U-Boot specific string
 
@@ -141,6 +157,8 @@ def check_ubconfig(config, fs_type):
     """
     if not config.buildconfig.get('config_cmd_%s' % fs_type, None):
         pytest.skip('.config feature "CMD_%s" not enabled' % fs_type.upper())
+    if fs_type == 'fs_generic':
+        return
     if not config.buildconfig.get('config_%s_write' % fs_type, None):
         pytest.skip('.config feature "%s_WRITE" not enabled'
         % fs_type.upper())
@@ -178,6 +196,8 @@ def fs_obj_basic(request, u_boot_config):
         volume file name and  a list of MD5 hashes.
     """
     fs_type = request.param
+    fs_cmd_prefix = fstype_to_prefix(fs_type)
+    fs_cmd_write = 'save' if fs_type == 'fs_generic' else 'write'
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
@@ -267,7 +287,7 @@ def fs_obj_basic(request, u_boot_config):
         pytest.skip('Setup failed for filesystem: ' + fs_type + '. {}'.format(err))
         return
     else:
-        yield [fs_ubtype, fs_img, md5val]
+        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fs_img, md5val]
     finally:
         call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
@@ -288,6 +308,8 @@ def fs_obj_ext(request, u_boot_config):
         volume file name and  a list of MD5 hashes.
     """
     fs_type = request.param
+    fs_cmd_prefix = fstype_to_prefix(fs_type)
+    fs_cmd_write = 'save' if fs_type == 'fs_generic' else 'write'
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
@@ -357,7 +379,7 @@ def fs_obj_ext(request, u_boot_config):
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_img, md5val]
+        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fs_img, md5val]
     finally:
         call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
@@ -378,6 +400,7 @@ def fs_obj_mkdir(request, u_boot_config):
         volume file name.
     """
     fs_type = request.param
+    fs_cmd_prefix = fstype_to_prefix(fs_type)
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
@@ -390,7 +413,7 @@ def fs_obj_mkdir(request, u_boot_config):
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_img]
+        yield [fs_ubtype, fs_cmd_prefix, fs_img]
     call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -409,6 +432,7 @@ def fs_obj_unlink(request, u_boot_config):
         volume file name.
     """
     fs_type = request.param
+    fs_cmd_prefix = fstype_to_prefix(fs_type)
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
@@ -456,7 +480,7 @@ def fs_obj_unlink(request, u_boot_config):
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_img]
+        yield [fs_ubtype, fs_cmd_prefix, fs_img]
     finally:
         call('rm -rf %s' % scratch_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
diff --git a/test/py/tests/test_fs/test_basic.py b/test/py/tests/test_fs/test_basic.py
index 5a02348bb94..64a3b50f52a 100644
--- a/test/py/tests/test_fs/test_basic.py
+++ b/test/py/tests/test_fs/test_basic.py
@@ -20,32 +20,32 @@ class TestFsBasic(object):
         """
         Test Case 1 - ls command, listing a root directory and invalid directory
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 1a - ls'):
             # Test Case 1 - ls
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sls host 0:0' % fs_type])
+                '%sls host 0:0' % fs_cmd_prefix])
             assert(re.search('2621440000 *%s' % BIG_FILE, ''.join(output)))
             assert(re.search('1048576 *%s' % SMALL_FILE, ''.join(output)))
 
         with ubman.log.section('Test Case 1b - ls (invalid dir)'):
             # In addition, test with a nonexistent directory to see if we crash.
             output = ubman.run_command(
-                '%sls host 0:0 invalid_d' % fs_type)
+                '%sls host 0:0 invalid_d' % fs_cmd_prefix)
             assert('' == output)
 
     def test_fs2(self, ubman, fs_obj_basic):
         """
         Test Case 2 - size command for a small file
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 2a - size (small)'):
             # 1MB is 0x0010 0000
             # Test Case 2a - size of small file
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%ssize host 0:0 /%s' % (fs_type, SMALL_FILE),
+                '%ssize host 0:0 /%s' % (fs_cmd_prefix, SMALL_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=100000' in ''.join(output))
@@ -53,7 +53,7 @@ class TestFsBasic(object):
         with ubman.log.section('Test Case 2b - size (/../<file>)'):
             # Test Case 2b - size of small file via a path using '..'
             output = ubman.run_command_list([
-                '%ssize host 0:0 /SUBDIR/../%s' % (fs_type, SMALL_FILE),
+                '%ssize host 0:0 /SUBDIR/../%s' % (fs_cmd_prefix, SMALL_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=100000' in ''.join(output))
@@ -62,13 +62,13 @@ class TestFsBasic(object):
         """
         Test Case 3 - size command for a large file
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 3 - size (large)'):
             # 2.5GB (1024*1024*2500) is 0x9C40 0000
             # Test Case 3 - size of big file
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%ssize host 0:0 /%s' % (fs_type, BIG_FILE),
+                '%ssize host 0:0 /%s' % (fs_cmd_prefix, BIG_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=9c400000' in ''.join(output))
@@ -77,12 +77,12 @@ class TestFsBasic(object):
         """
         Test Case 4 - load a small file, 1MB
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 4 - load (small)'):
             # Test Case 4a - Read full 1MB of small file
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, SMALL_FILE),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
@@ -96,12 +96,12 @@ class TestFsBasic(object):
         """
         Test Case 5 - load, reading first 1MB of 3GB file
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 5 - load (first 1MB)'):
             # Test Case 5a - First 1MB of big file
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s %x 0x0' % (fs_type, ADDR, BIG_FILE, LENGTH),
+                '%sload host 0:0 %x /%s %x 0x0' % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
@@ -115,14 +115,14 @@ class TestFsBasic(object):
         """
         Test Case 6 - load, reading last 1MB of 3GB file
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 6 - load (last 1MB)'):
             # fails for ext as no offset support
             # Test Case 6a - Last 1MB of big file
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x9c300000'
-                    % (fs_type, ADDR, BIG_FILE, LENGTH),
+                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
@@ -136,14 +136,14 @@ class TestFsBasic(object):
         """
         Test Case 7 - load, 1MB from the last 1MB in 2GB
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 7 - load (last 1MB in 2GB)'):
             # fails for ext as no offset support
             # Test Case 7a - One from the last 1MB chunk of 2GB
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x7ff00000'
-                    % (fs_type, ADDR, BIG_FILE, LENGTH),
+                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
@@ -157,14 +157,14 @@ class TestFsBasic(object):
         """
         Test Case 8 - load, reading first 1MB in 2GB
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 8 - load (first 1MB in 2GB)'):
             # fails for ext as no offset support
             # Test Case 8a - One from the start 1MB chunk from 2GB
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x80000000'
-                    % (fs_type, ADDR, BIG_FILE, LENGTH),
+                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
@@ -178,14 +178,14 @@ class TestFsBasic(object):
         """
         Test Case 9 - load, 1MB crossing 2GB boundary
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 9 - load (crossing 2GB boundary)'):
             # fails for ext as no offset support
             # Test Case 9a - One 1MB chunk crossing the 2GB boundary
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s %x 0x7ff80000'
-                    % (fs_type, ADDR, BIG_FILE, LENGTH),
+                    % (fs_cmd_prefix, ADDR, BIG_FILE, LENGTH),
                 'printenv filesize'])
             assert('filesize=100000' in ''.join(output))
 
@@ -199,14 +199,14 @@ class TestFsBasic(object):
         """
         Test Case 10 - load, reading beyond file end'):
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 10 - load (beyond file end)'):
             # Generic failure case
             # Test Case 10 - 2MB chunk from the last 1MB of big file
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
                 '%sload host 0:0 %x /%s 0x00200000 0x9c300000'
-                    % (fs_type, ADDR, BIG_FILE),
+                    % (fs_cmd_prefix, ADDR, BIG_FILE),
                 'printenv filesize',
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
@@ -216,22 +216,22 @@ class TestFsBasic(object):
         """
         Test Case 11 - write'
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 11 - write'):
             # Read 1MB from small file
             # Write it back to test the writes
             # Test Case 11a - Check that the write succeeded
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
-                '%swrite host 0:0 %x /%s.w $filesize'
-                    % (fs_type, ADDR, SMALL_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, SMALL_FILE),
+                '%s%s host 0:0 %x /%s.w $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, SMALL_FILE)])
             assert('1048576 bytes written' in ''.join(output))
 
             # Test Case 11b - Check md5 of written to is same
             # as the one read from
             output = ubman.run_command_list([
-                '%sload host 0:0 %x /%s.w' % (fs_type, ADDR, SMALL_FILE),
+                '%sload host 0:0 %x /%s.w' % (fs_cmd_prefix, ADDR, SMALL_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
@@ -241,7 +241,7 @@ class TestFsBasic(object):
         """
         Test Case 12 - write to "." directory
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 12 - write (".")'):
             # Next test case checks writing a file whose dirent
             # is the first in the block, which is always true for "."
@@ -249,7 +249,8 @@ class TestFsBasic(object):
             # Test Case 12 - Check directory traversal
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%swrite host 0:0 %x /. 0x10' % (fs_type, ADDR)])
+                '%s%s host 0:0 %x /. 0x10'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR)])
             assert('Unable to write' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -257,23 +258,23 @@ class TestFsBasic(object):
         """
         Test Case 13 - write to a file with "/./<filename>"
         """
-        fs_type,fs_img,md5val = fs_obj_basic
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_basic
         with ubman.log.section('Test Case 13 - write  ("./<file>")'):
             # Read 1MB from small file
             # Write it via "same directory", i.e. "." dirent
             # Test Case 13a - Check directory traversal
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, SMALL_FILE),
-                '%swrite host 0:0 %x /./%s2 $filesize'
-                    % (fs_type, ADDR, SMALL_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, SMALL_FILE),
+                '%s%s host 0:0 %x /./%s2 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, SMALL_FILE)])
             assert('1048576 bytes written' in ''.join(output))
 
             # Test Case 13b - Check md5 of written to is same
             # as the one read from
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /./%s2' % (fs_type, ADDR, SMALL_FILE),
+                '%sload host 0:0 %x /./%s2' % (fs_cmd_prefix, ADDR, SMALL_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
@@ -282,7 +283,7 @@ class TestFsBasic(object):
             # as the one read from
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /%s2' % (fs_type, ADDR, SMALL_FILE),
+                '%sload host 0:0 %x /%s2' % (fs_cmd_prefix, ADDR, SMALL_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
diff --git a/test/py/tests/test_fs/test_ext.py b/test/py/tests/test_fs/test_ext.py
index 9c213f2da55..a75cd74dade 100644
--- a/test/py/tests/test_fs/test_ext.py
+++ b/test/py/tests/test_fs/test_ext.py
@@ -33,20 +33,20 @@ class TestFsExt(object):
         """
         Test Case 1 - write a file with absolute path
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 1 - write with abs path'):
             # Test Case 1a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w1 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w1 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             assert('20480 bytes written' in ''.join(output))
 
             # Test Case 1b - Check md5 of file content
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /dir1/%s.w1' % (fs_type, ADDR, MIN_FILE),
+                '%sload host 0:0 %x /dir1/%s.w1' % (fs_cmd_prefix, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
@@ -56,20 +56,20 @@ class TestFsExt(object):
         """
         Test Case 2 - write to a file with relative path
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 2 - write with rel path'):
             # Test Case 2a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x dir1/%s.w2 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x dir1/%s.w2 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             assert('20480 bytes written' in ''.join(output))
 
             # Test Case 2b - Check md5 of file content
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x dir1/%s.w2' % (fs_type, ADDR, MIN_FILE),
+                '%sload host 0:0 %x dir1/%s.w2' % (fs_cmd_prefix, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[0] in ''.join(output))
@@ -79,14 +79,14 @@ class TestFsExt(object):
         """
         Test Case 3 - write to a file with invalid path
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 3 - write with invalid path'):
             # Test Case 3 - Check if command expectedly failed
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/none/%s.w3 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/none/%s.w3 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             assert('Unable to write file /dir1/none/' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -94,22 +94,22 @@ class TestFsExt(object):
         """
         Test Case 4 - write at non-zero offset, enlarging file size
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 4 - write at non-zero offset, enlarging file size'):
             # Test Case 4a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w4 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w4 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             output = ubman.run_command(
-                '%swrite host 0:0 %x /dir1/%s.w4 $filesize 0x1400'
-                    % (fs_type, ADDR, MIN_FILE))
+                '%s%s host 0:0 %x /dir1/%s.w4 $filesize 0x1400'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE))
             assert('20480 bytes written' in output)
 
             # Test Case 4b - Check size of written file
             output = ubman.run_command_list([
-                '%ssize host 0:0 /dir1/%s.w4' % (fs_type, MIN_FILE),
+                '%ssize host 0:0 /dir1/%s.w4' % (fs_cmd_prefix, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=6400' in ''.join(output))
@@ -117,7 +117,7 @@ class TestFsExt(object):
             # Test Case 4c - Check md5 of file content
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /dir1/%s.w4' % (fs_type, ADDR, MIN_FILE),
+                '%sload host 0:0 %x /dir1/%s.w4' % (fs_cmd_prefix, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[1] in ''.join(output))
@@ -127,22 +127,22 @@ class TestFsExt(object):
         """
         Test Case 5 - write at non-zero offset, shrinking file size
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 5 - write at non-zero offset, shrinking file size'):
             # Test Case 5a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w5 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w5 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             output = ubman.run_command(
-                '%swrite host 0:0 %x /dir1/%s.w5 0x1400 0x1400'
-                    % (fs_type, ADDR, MIN_FILE))
+                '%s%s host 0:0 %x /dir1/%s.w5 0x1400 0x1400'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE))
             assert('5120 bytes written' in output)
 
             # Test Case 5b - Check size of written file
             output = ubman.run_command_list([
-                '%ssize host 0:0 /dir1/%s.w5' % (fs_type, MIN_FILE),
+                '%ssize host 0:0 /dir1/%s.w5' % (fs_cmd_prefix, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=2800' in ''.join(output))
@@ -150,7 +150,7 @@ class TestFsExt(object):
             # Test Case 5c - Check md5 of file content
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /dir1/%s.w5' % (fs_type, ADDR, MIN_FILE),
+                '%sload host 0:0 %x /dir1/%s.w5' % (fs_cmd_prefix, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[2] in ''.join(output))
@@ -160,22 +160,22 @@ class TestFsExt(object):
         """
         Test Case 6 - write nothing at the start, truncating to zero
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 6 - write nothing at the start, truncating to zero'):
             # Test Case 6a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w6 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w6 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             output = ubman.run_command(
-                '%swrite host 0:0 %x /dir1/%s.w6 0 0'
-                    % (fs_type, ADDR, MIN_FILE))
+                '%s%s host 0:0 %x /dir1/%s.w6 0 0'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE))
             assert('0 bytes written' in output)
 
             # Test Case 6b - Check size of written file
             output = ubman.run_command_list([
-                '%ssize host 0:0 /dir1/%s.w6' % (fs_type, MIN_FILE),
+                '%ssize host 0:0 /dir1/%s.w6' % (fs_cmd_prefix, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=0' in ''.join(output))
@@ -185,22 +185,22 @@ class TestFsExt(object):
         """
         Test Case 7 - write at the end (append)
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 7 - write at the end (append)'):
             # Test Case 7a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w7 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w7 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             output = ubman.run_command(
-                '%swrite host 0:0 %x /dir1/%s.w7 $filesize $filesize'
-                    % (fs_type, ADDR, MIN_FILE))
+                '%s%s host 0:0 %x /dir1/%s.w7 $filesize $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE))
             assert('20480 bytes written' in output)
 
             # Test Case 7b - Check size of written file
             output = ubman.run_command_list([
-                '%ssize host 0:0 /dir1/%s.w7' % (fs_type, MIN_FILE),
+                '%ssize host 0:0 /dir1/%s.w7' % (fs_cmd_prefix, MIN_FILE),
                 'printenv filesize',
                 'setenv filesize'])
             assert('filesize=a000' in ''.join(output))
@@ -208,7 +208,7 @@ class TestFsExt(object):
             # Test Case 7c - Check md5 of file content
             output = ubman.run_command_list([
                 'mw.b %x 00 100' % ADDR,
-                '%sload host 0:0 %x /dir1/%s.w7' % (fs_type, ADDR, MIN_FILE),
+                '%sload host 0:0 %x /dir1/%s.w7' % (fs_cmd_prefix, ADDR, MIN_FILE),
                 'md5sum %x $filesize' % ADDR,
                 'setenv filesize'])
             assert(md5val[3] in ''.join(output))
@@ -218,17 +218,17 @@ class TestFsExt(object):
         """
         Test Case 8 - write at offset beyond the end of file
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 8 - write beyond the end'):
             # Test Case 8a - Check if command expectedly failed
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w8 $filesize'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w8 $filesize'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             output = ubman.run_command(
-                '%swrite host 0:0 %x /dir1/%s.w8 0x1400 %x'
-                    % (fs_type, ADDR, MIN_FILE, 0x100000 + 0x1400))
+                '%s%s host 0:0 %x /dir1/%s.w8 0x1400 %x'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE, 0x100000 + 0x1400))
             assert('Unable to write file /dir1' in output)
             assert_fs_integrity(fs_type, fs_img)
 
@@ -236,14 +236,14 @@ class TestFsExt(object):
         """
         Test Case 9 - write to a non-existing file at non-zero offset
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 9 - write to non-existing file with non-zero offset'):
             # Test Case 9a - Check if command expectedly failed
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%sload host 0:0 %x /%s' % (fs_type, ADDR, MIN_FILE),
-                '%swrite host 0:0 %x /dir1/%s.w9 0x1400 0x1400'
-                    % (fs_type, ADDR, MIN_FILE)])
+                '%sload host 0:0 %x /%s' % (fs_cmd_prefix, ADDR, MIN_FILE),
+                '%s%s host 0:0 %x /dir1/%s.w9 0x1400 0x1400'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MIN_FILE)])
             assert('Unable to write file /dir1' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -252,7 +252,7 @@ class TestFsExt(object):
         'Test Case 10 - create/delete as many directories under root directory
         as amount of directory entries goes beyond one cluster size)'
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 10 - create/delete (many)'):
             # Test Case 10a - Create many files
             #   Please note that the size of directory entry is 32 bytes.
@@ -262,9 +262,9 @@ class TestFsExt(object):
 
             for i in range(0, 66):
                 output = ubman.run_command(
-                    '%swrite host 0:0 %x /FILE0123456789_%02x 100'
-                    % (fs_type, ADDR, i))
-            output = ubman.run_command('%sls host 0:0 /' % fs_type)
+                    '%s%s host 0:0 %x /FILE0123456789_%02x 100'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, i))
+            output = ubman.run_command('%sls host 0:0 /' % fs_cmd_prefix)
             assert('FILE0123456789_00' in output)
             assert('FILE0123456789_41' in output)
 
@@ -272,8 +272,8 @@ class TestFsExt(object):
             for i in range(0, 66):
                 output = ubman.run_command(
                     '%srm host 0:0 /FILE0123456789_%02x'
-                    % (fs_type, i))
-            output = ubman.run_command('%sls host 0:0 /' % fs_type)
+                    % (fs_cmd_prefix, i))
+            output = ubman.run_command('%sls host 0:0 /' % fs_cmd_prefix)
             assert(not 'FILE0123456789_00' in output)
             assert(not 'FILE0123456789_41' in output)
 
@@ -281,9 +281,9 @@ class TestFsExt(object):
             # Please note no.64 and 65 are intentionally re-created
             for i in range(64, 128):
                 output = ubman.run_command(
-                    '%swrite host 0:0 %x /FILE0123456789_%02x 100'
-                    % (fs_type, ADDR, i))
-            output = ubman.run_command('%sls host 0:0 /' % fs_type)
+                    '%s%s host 0:0 %x /FILE0123456789_%02x 100'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, i))
+            output = ubman.run_command('%sls host 0:0 /' % fs_cmd_prefix)
             assert('FILE0123456789_40' in output)
             assert('FILE0123456789_79' in output)
 
@@ -294,7 +294,7 @@ class TestFsExt(object):
         'Test Case 11 - create/delete as many directories under non-root
         directory as amount of directory entries goes beyond one cluster size)'
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 11 - create/delete (many)'):
             # Test Case 11a - Create many files
             #   Please note that the size of directory entry is 32 bytes.
@@ -304,9 +304,9 @@ class TestFsExt(object):
 
             for i in range(0, 66):
                 output = ubman.run_command(
-                    '%swrite host 0:0 %x /dir1/FILE0123456789_%02x 100'
-                    % (fs_type, ADDR, i))
-            output = ubman.run_command('%sls host 0:0 /dir1' % fs_type)
+                    '%s%s host 0:0 %x /dir1/FILE0123456789_%02x 100'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, i))
+            output = ubman.run_command('%sls host 0:0 /dir1' % fs_cmd_prefix)
             assert('FILE0123456789_00' in output)
             assert('FILE0123456789_41' in output)
 
@@ -314,8 +314,8 @@ class TestFsExt(object):
             for i in range(0, 66):
                 output = ubman.run_command(
                     '%srm host 0:0 /dir1/FILE0123456789_%02x'
-                    % (fs_type, i))
-            output = ubman.run_command('%sls host 0:0 /dir1' % fs_type)
+                    % (fs_cmd_prefix, i))
+            output = ubman.run_command('%sls host 0:0 /dir1' % fs_cmd_prefix)
             assert(not 'FILE0123456789_00' in output)
             assert(not 'FILE0123456789_41' in output)
 
@@ -323,9 +323,9 @@ class TestFsExt(object):
             # Please note no.64 and 65 are intentionally re-created
             for i in range(64, 128):
                 output = ubman.run_command(
-                    '%swrite host 0:0 %x /dir1/FILE0123456789_%02x 100'
-                    % (fs_type, ADDR, i))
-            output = ubman.run_command('%sls host 0:0 /dir1' % fs_type)
+                    '%s%s host 0:0 %x /dir1/FILE0123456789_%02x 100'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, i))
+            output = ubman.run_command('%sls host 0:0 /dir1' % fs_cmd_prefix)
             assert('FILE0123456789_40' in output)
             assert('FILE0123456789_79' in output)
 
@@ -335,15 +335,15 @@ class TestFsExt(object):
         """
         Test Case 12 - write plain and mangle file
         """
-        fs_type,fs_img,md5val = fs_obj_ext
+        fs_type,fs_cmd_prefix,fs_cmd_write,fs_img,md5val = fs_obj_ext
         with ubman.log.section('Test Case 12 - write plain and mangle file'):
             # Test Case 12a - Check if command successfully returned
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%swrite host 0:0 %x /%s 0'
-                    % (fs_type, ADDR, PLAIN_FILE),
-                '%swrite host 0:0 %x /%s 0'
-                    % (fs_type, ADDR, MANGLE_FILE)])
+                '%s%s host 0:0 %x /%s 0'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, PLAIN_FILE),
+                '%s%s host 0:0 %x /%s 0'
+                    % (fs_cmd_prefix, fs_cmd_write, ADDR, MANGLE_FILE)])
             assert('0 bytes written' in ''.join(output))
             # Test Case 12b - Read file system content
             output = check_output('mdir -i %s' % fs_img, shell=True).decode()
diff --git a/test/py/tests/test_fs/test_mkdir.py b/test/py/tests/test_fs/test_mkdir.py
index df680a87d57..1578c3cba3a 100644
--- a/test/py/tests/test_fs/test_mkdir.py
+++ b/test/py/tests/test_fs/test_mkdir.py
@@ -18,16 +18,16 @@ class TestMkdir(object):
         """
         Test Case 1 - create a directory under a root
         """
-        fs_type,fs_img = fs_obj_mkdir
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_mkdir
         with ubman.log.section('Test Case 1 - mkdir'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%smkdir host 0:0 dir1' % fs_type,
-                '%sls host 0:0 /' % fs_type])
+                '%smkdir host 0:0 dir1' % fs_cmd_prefix,
+                '%sls host 0:0 /' % fs_cmd_prefix])
             assert('dir1/' in ''.join(output))
 
             output = ubman.run_command(
-                '%sls host 0:0 dir1' % fs_type)
+                '%sls host 0:0 dir1' % fs_cmd_prefix)
             assert('./'   in output)
             assert('../'  in output)
             assert_fs_integrity(fs_type, fs_img)
@@ -37,16 +37,16 @@ class TestMkdir(object):
         """
         Test Case 2 - create a directory under a sub-directory
         """
-        fs_type,fs_img = fs_obj_mkdir
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_mkdir
         with ubman.log.section('Test Case 2 - mkdir (sub-sub directory)'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%smkdir host 0:0 dir1/dir2' % fs_type,
-                '%sls host 0:0 dir1' % fs_type])
+                '%smkdir host 0:0 dir1/dir2' % fs_cmd_prefix,
+                '%sls host 0:0 dir1' % fs_cmd_prefix])
             assert('dir2/' in ''.join(output))
 
             output = ubman.run_command(
-                '%sls host 0:0 dir1/dir2' % fs_type)
+                '%sls host 0:0 dir1/dir2' % fs_cmd_prefix)
             assert('./'   in output)
             assert('../'  in output)
             assert_fs_integrity(fs_type, fs_img)
@@ -56,11 +56,11 @@ class TestMkdir(object):
         Test Case 3 - trying to create a directory with a non-existing
         path should fail
         """
-        fs_type,fs_img = fs_obj_mkdir
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_mkdir
         with ubman.log.section('Test Case 3 - mkdir (non-existing path)'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%smkdir host 0:0 none/dir3' % fs_type])
+                '%smkdir host 0:0 none/dir3' % fs_cmd_prefix])
             assert('Unable to create a directory' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -68,11 +68,11 @@ class TestMkdir(object):
         """
         Test Case 4 - trying to create "." should fail
         """
-        fs_type,fs_img = fs_obj_mkdir
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_mkdir
         with ubman.log.section('Test Case 4 - mkdir (".")'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%smkdir host 0:0 .' % fs_type])
+                '%smkdir host 0:0 .' % fs_cmd_prefix])
             assert('Unable to create a directory' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -80,11 +80,11 @@ class TestMkdir(object):
         """
         Test Case 5 - trying to create ".." should fail
         """
-        fs_type,fs_img = fs_obj_mkdir
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_mkdir
         with ubman.log.section('Test Case 5 - mkdir ("..")'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%smkdir host 0:0 ..' % fs_type])
+                '%smkdir host 0:0 ..' % fs_cmd_prefix])
             assert('Unable to create a directory' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -93,29 +93,29 @@ class TestMkdir(object):
         'Test Case 6 - create as many directories as amount of directory
         entries goes beyond a cluster size)'
         """
-        fs_type,fs_img = fs_obj_mkdir
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_mkdir
         with ubman.log.section('Test Case 6 - mkdir (create many)'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%smkdir host 0:0 dir6' % fs_type,
-                '%sls host 0:0 /' % fs_type])
+                '%smkdir host 0:0 dir6' % fs_cmd_prefix,
+                '%sls host 0:0 /' % fs_cmd_prefix])
             assert('dir6/' in ''.join(output))
 
             for i in range(0, 20):
                 output = ubman.run_command(
                     '%smkdir host 0:0 dir6/0123456789abcdef%02x'
-                    % (fs_type, i))
-            output = ubman.run_command('%sls host 0:0 dir6' % fs_type)
+                    % (fs_cmd_prefix, i))
+            output = ubman.run_command('%sls host 0:0 dir6' % fs_cmd_prefix)
             assert('0123456789abcdef00/'  in output)
             assert('0123456789abcdef13/'  in output)
 
             output = ubman.run_command(
-                '%sls host 0:0 dir6/0123456789abcdef13/.' % fs_type)
+                '%sls host 0:0 dir6/0123456789abcdef13/.' % fs_cmd_prefix)
             assert('./'   in output)
             assert('../'  in output)
 
             output = ubman.run_command(
-                '%sls host 0:0 dir6/0123456789abcdef13/..' % fs_type)
+                '%sls host 0:0 dir6/0123456789abcdef13/..' % fs_cmd_prefix)
             assert('0123456789abcdef00/'  in output)
             assert('0123456789abcdef13/'  in output)
             assert_fs_integrity(fs_type, fs_img)
diff --git a/test/py/tests/test_fs/test_unlink.py b/test/py/tests/test_fs/test_unlink.py
index 7e911f02413..1e2df3dbfd8 100644
--- a/test/py/tests/test_fs/test_unlink.py
+++ b/test/py/tests/test_fs/test_unlink.py
@@ -19,16 +19,16 @@ class TestUnlink(object):
         """
         Test Case 1 - delete a file
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 1 - unlink (file)'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%srm host 0:0 dir1/file1' % fs_type,
-                '%sls host 0:0 dir1/file1' % fs_type])
+                '%srm host 0:0 dir1/file1' % fs_cmd_prefix,
+                '%sls host 0:0 dir1/file1' % fs_cmd_prefix])
             assert('' == ''.join(output))
 
             output = ubman.run_command(
-                '%sls host 0:0 dir1/' % fs_type)
+                '%sls host 0:0 dir1/' % fs_cmd_prefix)
             assert(not 'file1' in output)
             assert('file2' in output)
             assert_fs_integrity(fs_type, fs_img)
@@ -37,18 +37,18 @@ class TestUnlink(object):
         """
         Test Case 2 - delete many files
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 2 - unlink (many)'):
             output = ubman.run_command('host bind 0 %s' % fs_img)
 
             for i in range(0, 20):
                 output = ubman.run_command_list([
-                    '%srm host 0:0 dir2/0123456789abcdef%02x' % (fs_type, i),
-                    '%sls host 0:0 dir2/0123456789abcdef%02x' % (fs_type, i)])
+                    '%srm host 0:0 dir2/0123456789abcdef%02x' % (fs_cmd_prefix, i),
+                    '%sls host 0:0 dir2/0123456789abcdef%02x' % (fs_cmd_prefix, i)])
                 assert('' == ''.join(output))
 
             output = ubman.run_command(
-                '%sls host 0:0 dir2' % fs_type)
+                '%sls host 0:0 dir2' % fs_cmd_prefix)
             assert('0 file(s), 2 dir(s)' in output)
             assert_fs_integrity(fs_type, fs_img)
 
@@ -56,11 +56,11 @@ class TestUnlink(object):
         """
         Test Case 3 - trying to delete a non-existing file should fail
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 3 - unlink (non-existing)'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%srm host 0:0 dir1/nofile' % fs_type])
+                '%srm host 0:0 dir1/nofile' % fs_cmd_prefix])
             assert('nofile: doesn\'t exist' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -68,15 +68,15 @@ class TestUnlink(object):
         """
         Test Case 4 - delete an empty directory
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 4 - unlink (directory)'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%srm host 0:0 dir4' % fs_type])
+                '%srm host 0:0 dir4' % fs_cmd_prefix])
             assert('' == ''.join(output))
 
             output = ubman.run_command(
-                '%sls host 0:0 /' % fs_type)
+                '%sls host 0:0 /' % fs_cmd_prefix)
             assert(not 'dir4' in output)
             assert_fs_integrity(fs_type, fs_img)
 
@@ -85,11 +85,11 @@ class TestUnlink(object):
         Test Case 5 - trying to deleting a non-empty directory ".."
         should fail
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 5 - unlink ("non-empty directory")'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%srm host 0:0 dir5' % fs_type])
+                '%srm host 0:0 dir5' % fs_cmd_prefix])
             assert('directory is not empty' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -97,11 +97,11 @@ class TestUnlink(object):
         """
         Test Case 6 - trying to deleting a "." should fail
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 6 - unlink (".")'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%srm host 0:0 dir5/.' % fs_type])
+                '%srm host 0:0 dir5/.' % fs_cmd_prefix])
             assert('directory is not empty' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
 
@@ -109,10 +109,10 @@ class TestUnlink(object):
         """
         Test Case 7 - trying to deleting a ".." should fail
         """
-        fs_type,fs_img = fs_obj_unlink
+        fs_type,fs_cmd_prefix,fs_img = fs_obj_unlink
         with ubman.log.section('Test Case 7 - unlink ("..")'):
             output = ubman.run_command_list([
                 'host bind 0 %s' % fs_img,
-                '%srm host 0:0 dir5/..' % fs_type])
+                '%srm host 0:0 dir5/..' % fs_cmd_prefix])
             assert('directory is not empty' in ''.join(output))
             assert_fs_integrity(fs_type, fs_img)
-- 
2.47.2

