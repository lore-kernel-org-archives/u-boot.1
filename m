Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E33C28B2F
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 03:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7C0F81C67;
	Mon, 17 Mar 2025 04:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742181311;
	bh=MgO2C3bMTc20ESWNiVsJte2TOqJP4ufltawS7kELMqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lSrScOoBpHi1yUr+F+efBbK4XHqwpTrY8PRv6bPb7Uy2b9LmxDNSfpLcReZqw9S85
	 WyGWtkjMoAdikZG0KjyeoMrpeJpSLEQK1tPsqUyvItRsshHG6BUsYyqXEsrRsn9Aol
	 KxEAGv1bEI4FytjVDEgPK0zRnRtJeO0DoGYAfhKNznidNL+TlY0HdL4umlZOprWHHD
	 6hU7hHs6Jj39+jbw6l00BTJd6TLSa5zlhaU8caD6dSiRTzjrfsWJx4fzb1Y+K7knKg
	 eKQMdUWvGI+DSKBdNsf5OQo3Uw/RImvoY+aZ+vLAYfpS53iYcPL6Y7mz5m3e1GpAPK
	 FnMcNiNjARGwQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31FCB810F5; Mon, 17 Mar 2025 04:15:08 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F140481A04
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 04:15:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WIc5bTX9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E2F3103D1FFE; Mon, 17 Mar 2025 04:15:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742181305; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=MgO2C3bMTc20ESWNiVsJte2TOqJP4ufltawS7kELMqI=;
 b=WIc5bTX927j5G3wYOr/yXWedWgbmHpAozTffTc4WIhJvvhIRD87un4fYNyYsUXmobUUq/j
 bM0S1ozj3vPkON8EEUHF1RIRzamk1AmxXaV+2AIcFazeHsZP3I93ecjh75KIfkbFsQSaaj
 ttnJZm9XYIoYVmRd97Z8D2RZRgwwZRbAAn97oyZx4Co/GQXdNIkxcjCDzf/UkqOuqAgNTT
 4oN8m3qkzFl8JGaVQLs30YS/UxEHxoxLlasb3+X1rUNBKx6Hfz0b6fN1LAM1JGKdkuP9Uh
 03DrICWEhy5zsgAql0t2mmWwTd6/gB9fvt6MzejEGCb+iO1gmtFrT/70yrt/2Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 11/11] test_fs: Add exfat tests
Date: Mon, 17 Mar 2025 04:12:50 +0100
Message-ID: <20250317031418.223019-12-marex@denx.de>
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

Add tests for the exfat filesystem. These tests are largely an
extension of the FS_GENERIC tests with the following notable
exceptions.

The filesystem image for exfat tests is generated using combination
of exfatprogs mkfs.exfat and python fattools. The fattols are capable
of generating exfat filesystem images too, but this is not used, the
fattools are only used as a replacement for dosfstools 'mcopy' and
'mdir', which are used to insert files and directories into existing
fatfs images and list existing fatfs images respectively, without the
need for superuser access to mount such images.

The exfat filesystem has no filesystem specific command, there is only
the generic filesystem command interface, therefore check_ubconfig()
has to special case exfat and skip check for CONFIG_CMD_EXFAT and
instead check for CONFIG_FS_EXFAT.

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
V2: - s@exfatutils@exfatprogs@
    - Fill in fsck.exfat into fstest_helpers.py
    - Fill in exfatprogs into CI docker container template
V3: Use elif in test/py/tests/test_fs/fstest_helpers.py
---
 test/py/requirements.txt                |  1 +
 test/py/tests/fs_helper.py              |  8 ++++++--
 test/py/tests/test_fs/conftest.py       | 20 +++++++++++---------
 test/py/tests/test_fs/fstest_helpers.py |  2 ++
 test/py/tests/test_fs/test_ext.py       | 20 ++++++++++++++------
 tools/docker/Dockerfile                 |  1 +
 6 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/test/py/requirements.txt b/test/py/requirements.txt
index acfe17dce9f..804a427b351 100644
--- a/test/py/requirements.txt
+++ b/test/py/requirements.txt
@@ -2,3 +2,4 @@ filelock==3.0.12
 pycryptodomex==3.21.0
 pytest==6.2.5
 pytest-xdist==2.5.0
+FATtools==1.0.42
diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 378d5ae0690..94a5b94f479 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -35,7 +35,9 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
     else:
         mkfs_opt = ''
 
-    if re.match('fat', fs_type) or fs_type == 'fs_generic':
+    if fs_type == 'exfat':
+        fs_lnxtype = 'exfat'
+    elif re.match('fat', fs_type) or fs_type == 'fs_generic':
         fs_lnxtype = 'vfat'
     else:
         fs_lnxtype = fs_type
@@ -43,7 +45,7 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
     if src_dir:
         if fs_lnxtype == 'ext4':
             mkfs_opt = mkfs_opt + ' -d ' + src_dir
-        elif fs_lnxtype != 'vfat':
+        elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
             raise ValueError(f'src_dir not implemented for fs {fs_lnxtype}')
 
     count = (size + size_gran - 1) // size_gran
@@ -64,6 +66,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
                 check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
         elif fs_lnxtype == 'vfat' and src_dir:
             check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shell=True)
+        elif fs_lnxtype == 'exfat' and src_dir:
+            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
         return fs_img
     except CalledProcessError:
         call(f'rm -f {fs_img}', shell=True)
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 691bdf41ede..c73fb4abbcb 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -11,11 +11,11 @@ from fstest_defs import *
 # pylint: disable=E0611
 from tests import fs_helper
 
-supported_fs_basic = ['fat16', 'fat32', 'ext4', 'fs_generic']
-supported_fs_ext = ['fat12', 'fat16', 'fat32', 'fs_generic']
+supported_fs_basic = ['fat16', 'fat32', 'exfat', 'ext4', 'fs_generic']
+supported_fs_ext = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
 supported_fs_fat = ['fat12', 'fat16']
-supported_fs_mkdir = ['fat12', 'fat16', 'fat32', 'fs_generic']
-supported_fs_unlink = ['fat12', 'fat16', 'fat32', 'fs_generic']
+supported_fs_mkdir = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
+supported_fs_unlink = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
 supported_fs_symlink = ['ext4']
 supported_fs_rename = ['fat12', 'fat16', 'fat32']
 
@@ -117,7 +117,7 @@ def fstype_to_prefix(fs_type):
     Return:
         A corresponding command prefix for file system type.
     """
-    if fs_type == 'fs_generic':
+    if fs_type == 'fs_generic' or fs_type == 'exfat':
         return ''
     elif re.match('fat', fs_type):
         return 'fat'
@@ -155,9 +155,11 @@ def check_ubconfig(config, fs_type):
     Return:
         Nothing.
     """
-    if not config.buildconfig.get('config_cmd_%s' % fs_type, None):
+    if fs_type == 'exfat' and not config.buildconfig.get('config_fs_%s' % fs_type, None):
+        pytest.skip('.config feature "FS_%s" not enabled' % fs_type.upper())
+    if fs_type != 'exfat' and not config.buildconfig.get('config_cmd_%s' % fs_type, None):
         pytest.skip('.config feature "CMD_%s" not enabled' % fs_type.upper())
-    if fs_type == 'fs_generic':
+    if fs_type == 'fs_generic' or fs_type == 'exfat':
         return
     if not config.buildconfig.get('config_%s_write' % fs_type, None):
         pytest.skip('.config feature "%s_WRITE" not enabled'
@@ -197,7 +199,7 @@ def fs_obj_basic(request, u_boot_config):
     """
     fs_type = request.param
     fs_cmd_prefix = fstype_to_prefix(fs_type)
-    fs_cmd_write = 'save' if fs_type == 'fs_generic' else 'write'
+    fs_cmd_write = 'save' if fs_type == 'fs_generic' or fs_type == 'exfat' else 'write'
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
@@ -309,7 +311,7 @@ def fs_obj_ext(request, u_boot_config):
     """
     fs_type = request.param
     fs_cmd_prefix = fstype_to_prefix(fs_type)
-    fs_cmd_write = 'save' if fs_type == 'fs_generic' else 'write'
+    fs_cmd_write = 'save' if fs_type == 'fs_generic' or fs_type == 'exfat' else 'write'
     fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
diff --git a/test/py/tests/test_fs/fstest_helpers.py b/test/py/tests/test_fs/fstest_helpers.py
index c1447b4d43e..d25326ee993 100644
--- a/test/py/tests/test_fs/fstest_helpers.py
+++ b/test/py/tests/test_fs/fstest_helpers.py
@@ -9,6 +9,8 @@ def assert_fs_integrity(fs_type, fs_img):
     try:
         if fs_type == 'ext4':
             check_call('fsck.ext4 -n -f %s' % fs_img, shell=True)
+        elif fs_type == 'exfat':
+            check_call('fsck.exfat -n %s' % fs_img, shell=True)
         elif fs_type in ['fat12', 'fat16', 'fat32']:
             check_call('fsck.fat -n %s' % fs_img, shell=True)
     except CalledProcessError:
diff --git a/test/py/tests/test_fs/test_ext.py b/test/py/tests/test_fs/test_ext.py
index a75cd74dade..41f126e7876 100644
--- a/test/py/tests/test_fs/test_ext.py
+++ b/test/py/tests/test_fs/test_ext.py
@@ -345,11 +345,19 @@ class TestFsExt(object):
                 '%s%s host 0:0 %x /%s 0'
                     % (fs_cmd_prefix, fs_cmd_write, ADDR, MANGLE_FILE)])
             assert('0 bytes written' in ''.join(output))
-            # Test Case 12b - Read file system content
-            output = check_output('mdir -i %s' % fs_img, shell=True).decode()
-            # Test Case 12c - Check if short filename is not mangled
-            assert(str2fat(PLAIN_FILE) in ''.join(output))
-            # Test Case 12d - Check if long filename is mangled
-            assert(str2fat(MANGLE_FILE) in ''.join(output))
+            if fs_type == 'exfat':
+                # Test Case 12b - Read file system content
+                output = check_output('fattools ls %s' % fs_img, shell=True).decode()
+                # Test Case 12c - Check if short filename is not mangled
+                assert(PLAIN_FILE in ''.join(output))
+                # Test Case 12d - Check if long filename is mangled
+                assert(MANGLE_FILE in ''.join(output))
+            else:
+                # Test Case 12b - Read file system content
+                output = check_output('mdir -i %s' % fs_img, shell=True).decode()
+                # Test Case 12c - Check if short filename is not mangled
+                assert(str2fat(PLAIN_FILE) in ''.join(output))
+                # Test Case 12d - Check if long filename is mangled
+                assert(str2fat(MANGLE_FILE) in ''.join(output))
 
             assert_fs_integrity(fs_type, fs_img)
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 569912303fc..80e9247aa60 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -74,6 +74,7 @@ RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
 	e2fsprogs \
 	efitools \
 	erofs-utils \
+	exfatprogs \
 	expect \
 	fakeroot \
 	flex \
-- 
2.47.2

