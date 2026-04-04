Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92582D7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81842841CD;
	Sat,  4 Apr 2026 16:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PY+ON3g8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA56841D6; Sat,  4 Apr 2026 16:04:29 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A668419C
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso760345a34.3
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311464; x=1775916264; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms9VRvuYO6+TEJI4Bs1br1pfUz6gOiYXR50tIbdNYPM=;
 b=PY+ON3g8xB7rePevPwajBESJhvzWbh8MkAQOYXESxFtfrY8MvVOIRxIdg2y+V62wbX
 FzER3r52JBlarR1ITMUH3i+wIGTL5Fre31Oz55s91fzGaEyvJ7tNnbOrvp6hxco/wypd
 X7fi44Okny33gs6nQvV0G1i4pogDp+mitaBcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311464; x=1775916264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ms9VRvuYO6+TEJI4Bs1br1pfUz6gOiYXR50tIbdNYPM=;
 b=Qy+K4w7h87ANjxncotGQKI6B+2O1VOklNl9z+VVB1zzdNf0H7cuJNVoARExCHduomB
 zljWRpNegk6QkUXaT9J/lHejGwvuiReBcb4r42TPem0c1DSgs2YGH+J3uSnkaaxJ6OmZ
 KlE1bI4X0q8tdvcdEbQ3pZudTUlni/kgtjekMMaVRmU3Q8UhcicIz/M+eHcoSWQ3Ool2
 z82LMgb2ne4bi/RkkiwmYjBYbSFgQjV0b4WpW8biEl4JntNWI93RWEFRuMLgC8OG6jCw
 FJGG/Ss1IeK2xghcFc3mgQrsi2IeHgHxrOXMSTo+8WIeP6rhVFSfdhtmF5iAzaxFBhzx
 csrQ==
X-Gm-Message-State: AOJu0Yz2H07lUgIVBp+iiDJ1kRTHP5GprZPqwIOWdAWIyJM9G4uxntJz
 spplPwNCXCRHLCtIMmXhH8nkY81ZxBNu2pbuwuLy+WkbCX2hGN+z4E6WvSCyrkE+ogjGpOTtWLU
 rOwE=
X-Gm-Gg: AeBDiesRVAwaPKe6t3GOGH7uw10EqDYsYmWqQbCx4F/KQppzBLAS+vML0g+5uwC35u1
 OEUzc2XbIzIQkLGm6JFahAkiT1fwElggZxqQp3fIlK87jwwcfqQZ3JBbuwr55QXNjiuvwjL99II
 eNCyIQiAltVw717xTToMn3rCpakX3oGIRVEEYE7QNSv+YCmLdoaZdlbU0H3X2CFUPcN7/QvPf+Y
 w9T6lADNvbJX90dC2n0FCIy4H9m8rDNcffNEtiMvk0znW9YgRxk1k+9ASayL08Ar3In8mvzAYVo
 3YZx71ORy8gdGx6Ddge9xr08cpf510n7YTtWiC/j+mge90Y9KiQcEguUTzT8XsiRVuXdIaaCZyC
 aoebuPCGEVGzdOeuykk1QNv9GJX/Y846R0Z4tk7HycqQYpJ2wy0Wl53ncGOO15kvlolJkAebpGI
 J0B83kycQ5KORVJuP/Pw==
X-Received: by 2002:a05:6870:ff96:b0:41b:cc55:c398 with SMTP id
 586e51a60fabf-4230fcd57b8mr3668204fac.15.1775311464259; 
 Sat, 04 Apr 2026 07:04:24 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:04:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/14] test: Convert test_fs fixtures to use FsHelper
Date: Sat,  4 Apr 2026 08:03:18 -0600
Message-ID: <20260404140328.3724864-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

Replace all direct calls to the mk_fs() function with FsHelper in the
filesystem test fixtures. Each fixture now creates an FsHelper instance,
populates its srcdir with test files, then calls mk_fs() on the object.

This removes manual scratch-directory management and cleanup code, since
FsHelper handles the source directory and image-file lifecycle.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_fs/conftest.py | 198 ++++++++++--------------------
 1 file changed, 64 insertions(+), 134 deletions(-)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index cc5c0fc3756..ba125cc7073 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -9,7 +9,7 @@ import re
 from subprocess import call, check_call, check_output, CalledProcessError
 from fstest_defs import *
 # pylint: disable=E0611
-from tests import fs_helper
+from tests.fs_helper import FsHelper
 
 supported_fs_basic = ['fat16', 'fat32', 'exfat', 'ext4', 'fs_generic']
 supported_fs_ext = ['fat12', 'fat16', 'fat32', 'exfat', 'fs_generic']
@@ -200,33 +200,26 @@ def fs_obj_basic(request, u_boot_config):
     fs_type = request.param
     fs_cmd_prefix = fstype_to_prefix(fs_type)
     fs_cmd_write = 'save' if fs_type == 'fs_generic' or fs_type == 'exfat' else 'write'
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
-
-    small_file = scratch_dir + '/' + SMALL_FILE
-    big_file = scratch_dir + '/' + BIG_FILE
-
+    fsh = FsHelper(u_boot_config, fs_type, 3072, '3GB')
     try:
-        check_call('mkdir -p %s' % scratch_dir, shell=True)
-    except CalledProcessError as err:
-        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rm -f %s' % fs_img, shell=True)
-        return
+        fsh.setup()
+
+        small_file = fsh.srcdir + '/' + SMALL_FILE
+        big_file = fsh.srcdir + '/' + BIG_FILE
 
-    try:
         # Create a subdirectory.
-        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=True)
+        check_call('mkdir %s/SUBDIR' % fsh.srcdir, shell=True)
 
         # Create big file in this image.
         # Note that we work only on the start 1MB, couple MBs in the 2GB range
         # and the last 1 MB of the huge 2.5GB file.
         # So, just put random values only in those areas.
         check_call('dd if=/dev/urandom of=%s bs=1M count=1'
-	    % big_file, shell=True)
+            % big_file, shell=True)
         check_call('dd if=/dev/urandom of=%s bs=1M count=2 seek=2047'
             % big_file, shell=True)
         check_call('dd if=/dev/urandom of=%s bs=1M count=1 seek=2499'
@@ -234,65 +227,54 @@ def fs_obj_basic(request, u_boot_config):
 
         # Create a small file in this image.
         check_call('dd if=/dev/urandom of=%s bs=1M count=1'
-	    % small_file, shell=True)
-
-        # Delete the small file copies which possibly are written as part of a
-        # previous test.
-        # check_call('rm -f "%s.w"' % MB1, shell=True)
-        # check_call('rm -f "%s.w2"' % MB1, shell=True)
+            % small_file, shell=True)
 
         # Generate the md5sums of reads that we will test against small file
         out = check_output(
             'dd if=%s bs=1M skip=0 count=1 2> /dev/null | md5sum'
-	    % small_file, shell=True).decode()
+            % small_file, shell=True).decode()
         md5val = [ out.split()[0] ]
 
         # Generate the md5sums of reads that we will test against big file
         # One from beginning of file.
         out = check_output(
             'dd if=%s bs=1M skip=0 count=1 2> /dev/null | md5sum'
-	    % big_file, shell=True).decode()
+            % big_file, shell=True).decode()
         md5val.append(out.split()[0])
 
         # One from end of file.
         out = check_output(
             'dd if=%s bs=1M skip=2499 count=1 2> /dev/null | md5sum'
-	    % big_file, shell=True).decode()
+            % big_file, shell=True).decode()
         md5val.append(out.split()[0])
 
         # One from the last 1MB chunk of 2GB
         out = check_output(
             'dd if=%s bs=1M skip=2047 count=1 2> /dev/null | md5sum'
-	    % big_file, shell=True).decode()
+            % big_file, shell=True).decode()
         md5val.append(out.split()[0])
 
         # One from the start 1MB chunk from 2GB
         out = check_output(
             'dd if=%s bs=1M skip=2048 count=1 2> /dev/null | md5sum'
-	    % big_file, shell=True).decode()
+            % big_file, shell=True).decode()
         md5val.append(out.split()[0])
 
         # One 1MB chunk crossing the 2GB boundary
         out = check_output(
             'dd if=%s bs=512K skip=4095 count=2 2> /dev/null | md5sum'
-	    % big_file, shell=True).decode()
+            % big_file, shell=True).decode()
         md5val.append(out.split()[0])
 
-        try:
-            # 3GiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0xc0000000, '3GB', scratch_dir)
-        except CalledProcessError as err:
-            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-            return
+        fsh.mk_fs()
 
     except CalledProcessError as err:
         pytest.skip('Setup failed for filesystem: ' + fs_type + '. {}'.format(err))
         return
     else:
-        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fs_img, md5val]
+        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fsh.fs_img, md5val]
     finally:
-        call('rm -rf %s' % scratch_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
+        fsh.cleanup()
 
 #
 # Fixture for extended fs test
@@ -312,26 +294,19 @@ def fs_obj_ext(request, u_boot_config):
     fs_type = request.param
     fs_cmd_prefix = fstype_to_prefix(fs_type)
     fs_cmd_write = 'save' if fs_type == 'fs_generic' or fs_type == 'exfat' else 'write'
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
-
-    min_file = scratch_dir + '/' + MIN_FILE
-    tmp_file = scratch_dir + '/tmpfile'
-
+    fsh = FsHelper(u_boot_config, fs_type, 128, '128MB')
     try:
-        check_call('mkdir -p %s' % scratch_dir, shell=True)
-    except CalledProcessError as err:
-        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rm -f %s' % fs_img, shell=True)
-        return
+        fsh.setup()
+
+        min_file = fsh.srcdir + '/' + MIN_FILE
+        tmp_file = fsh.srcdir + '/tmpfile'
 
-    try:
         # Create a test directory
-        check_call('mkdir %s/dir1' % scratch_dir, shell=True)
+        check_call('mkdir %s/dir1' % fsh.srcdir, shell=True)
 
         # Create a small file and calculate md5
         check_call('dd if=/dev/urandom of=%s bs=1K count=20'
@@ -370,21 +345,15 @@ def fs_obj_ext(request, u_boot_config):
 
         check_call('rm %s' % tmp_file, shell=True)
 
-        try:
-            # 128MiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', scratch_dir)
-        except CalledProcessError as err:
-            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-            return
+        fsh.mk_fs()
 
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fs_img, md5val]
+        yield [fs_ubtype, fs_cmd_prefix, fs_cmd_write, fsh.fs_img, md5val]
     finally:
-        call('rm -rf %s' % scratch_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
+        fsh.cleanup()
 
 #
 # Fixture for mkdir test
@@ -403,20 +372,19 @@ def fs_obj_mkdir(request, u_boot_config):
     """
     fs_type = request.param
     fs_cmd_prefix = fstype_to_prefix(fs_type)
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
+    fsh = FsHelper(u_boot_config, fs_type, 128, '128MB')
     try:
-        # 128MiB volume
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', None)
+        fsh.mk_fs()
     except:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_cmd_prefix, fs_img]
-    call('rm -f %s' % fs_img, shell=True)
+        yield [fs_ubtype, fs_cmd_prefix, fsh.fs_img]
+    fsh.cleanup()
 
 #
 # Fixture for unlink test
@@ -435,57 +403,44 @@ def fs_obj_unlink(request, u_boot_config):
     """
     fs_type = request.param
     fs_cmd_prefix = fstype_to_prefix(fs_type)
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
-
+    fsh = FsHelper(u_boot_config, fs_type, 128, '128MB')
     try:
-        check_call('mkdir -p %s' % scratch_dir, shell=True)
-    except CalledProcessError as err:
-        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rm -f %s' % fs_img, shell=True)
-        return
+        fsh.setup()
 
-    try:
         # Test Case 1 & 3
-        check_call('mkdir %s/dir1' % scratch_dir, shell=True)
+        check_call('mkdir %s/dir1' % fsh.srcdir, shell=True)
         check_call('dd if=/dev/urandom of=%s/dir1/file1 bs=1K count=1'
-                                    % scratch_dir, shell=True)
+                                    % fsh.srcdir, shell=True)
         check_call('dd if=/dev/urandom of=%s/dir1/file2 bs=1K count=1'
-                                    % scratch_dir, shell=True)
+                                    % fsh.srcdir, shell=True)
 
         # Test Case 2
-        check_call('mkdir %s/dir2' % scratch_dir, shell=True)
+        check_call('mkdir %s/dir2' % fsh.srcdir, shell=True)
         for i in range(0, 20):
             check_call('mkdir %s/dir2/0123456789abcdef%02x'
-                                    % (scratch_dir, i), shell=True)
+                                    % (fsh.srcdir, i), shell=True)
 
         # Test Case 4
-        check_call('mkdir %s/dir4' % scratch_dir, shell=True)
+        check_call('mkdir %s/dir4' % fsh.srcdir, shell=True)
 
         # Test Case 5, 6 & 7
-        check_call('mkdir %s/dir5' % scratch_dir, shell=True)
+        check_call('mkdir %s/dir5' % fsh.srcdir, shell=True)
         check_call('dd if=/dev/urandom of=%s/dir5/file1 bs=1K count=1'
-                                    % scratch_dir, shell=True)
+                                    % fsh.srcdir, shell=True)
 
-        try:
-            # 128MiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', scratch_dir)
-        except CalledProcessError as err:
-            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-            return
+        fsh.mk_fs()
 
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_cmd_prefix, fs_img]
+        yield [fs_ubtype, fs_cmd_prefix, fsh.fs_img]
     finally:
-        call('rm -rf %s' % scratch_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
+        fsh.cleanup()
 
 #
 # Fixture for symlink fs test
@@ -503,26 +458,19 @@ def fs_obj_symlink(request, u_boot_config):
         volume file name and  a list of MD5 hashes.
     """
     fs_type = request.param
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    scratch_dir = u_boot_config.persistent_data_dir + '/scratch'
-
-    small_file = scratch_dir + '/' + SMALL_FILE
-    medium_file = scratch_dir + '/' + MEDIUM_FILE
-
+    fsh = FsHelper(u_boot_config, fs_type, 1024, '1GB')
     try:
-        check_call('mkdir -p %s' % scratch_dir, shell=True)
-    except CalledProcessError as err:
-        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rm -f %s' % fs_img, shell=True)
-        return
+        fsh.setup()
+
+        small_file = fsh.srcdir + '/' + SMALL_FILE
+        medium_file = fsh.srcdir + '/' + MEDIUM_FILE
 
-    try:
         # Create a subdirectory.
-        check_call('mkdir %s/SUBDIR' % scratch_dir, shell=True)
+        check_call('mkdir %s/SUBDIR' % fsh.srcdir, shell=True)
 
         # Create a small file in this image.
         check_call('dd if=/dev/urandom of=%s bs=1M count=1'
@@ -542,21 +490,15 @@ def fs_obj_symlink(request, u_boot_config):
             % medium_file, shell=True).decode()
         md5val.extend([out.split()[0]])
 
-        try:
-            # 1GiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x40000000, '1GB', scratch_dir)
-        except CalledProcessError as err:
-            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-            return
+        fsh.mk_fs()
 
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_img, md5val]
+        yield [fs_ubtype, fsh.fs_img, md5val]
     finally:
-        call('rm -rf %s' % scratch_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
+        fsh.cleanup()
 
 #
 # Fixture for rename test
@@ -584,21 +526,15 @@ def fs_obj_rename(request, u_boot_config):
         return out.decode().split()[0]
 
     fs_type = request.param
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
-    mount_dir = u_boot_config.persistent_data_dir + '/scratch'
-
+    fsh = FsHelper(u_boot_config, fs_type, 128, '128MB')
     try:
-        check_call('mkdir -p %s' % mount_dir, shell=True)
-    except CalledProcessError as err:
-        pytest.skip('Preparing mount folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rm -f %s' % fs_img, shell=True)
-        return
+        fsh.setup()
+        mount_dir = fsh.srcdir
 
-    try:
         md5val = {}
         # Test Case 1
         check_call('mkdir %s/test1' % mount_dir, shell=True)
@@ -657,21 +593,15 @@ def fs_obj_rename(request, u_boot_config):
         new_rand_file('%s/test11/dir1/file1' % mount_dir)
         md5val['test11'] = file_hash('%s/test11/dir1/file1' % mount_dir)
 
-        try:
-            # 128MiB volume
-            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', mount_dir)
-        except CalledProcessError as err:
-            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-            return
+        fsh.mk_fs()
 
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_img, md5val]
+        yield [fs_ubtype, fsh.fs_img, md5val]
     finally:
-        call('rm -rf %s' % mount_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
+        fsh.cleanup()
 
 #
 # Fixture for fat test
@@ -697,19 +627,19 @@ def fs_obj_fat(request, u_boot_config):
     MIN_FAT16_SIZE = 8208 * 1024
 
     fs_type = request.param
-    fs_img = ''
 
     fs_ubtype = fstype_to_ubname(fs_type)
     check_ubconfig(u_boot_config, fs_ubtype)
 
     fs_size = MAX_FAT12_SIZE if fs_type == 'fat12' else MIN_FAT16_SIZE
+    size_mb = (fs_size + (1 << 20) - 1) >> 20
 
+    fsh = FsHelper(u_boot_config, fs_type, size_mb, f'{fs_size}')
     try:
-        # the volume size depends on the filesystem
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{fs_size}')
+        fsh.mk_fs()
     except:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
     else:
-        yield [fs_ubtype, fs_img]
-    call('rm -f %s' % fs_img, shell=True)
+        yield [fs_ubtype, fsh.fs_img]
+    fsh.cleanup()
-- 
2.43.0

