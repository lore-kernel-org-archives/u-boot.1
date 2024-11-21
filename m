Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087F8E64025
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 22:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C247C896ED;
	Thu, 21 Nov 2024 23:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GiUEoxs6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC3E896C2; Thu, 21 Nov 2024 23:32:30 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B8A896C5
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 23:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6e34339d41bso12681217b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 14:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732228346; x=1732833146; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=grVCJAamUcXBKvf7wFpNznTL3+Y+eH4IC6hb/bJXcvA=;
 b=GiUEoxs68A6wcCkGOhJlkDVwQEOy4E08Hk26BwcRv6mLNRafUHgjVFPx6Hu6wWWhlp
 OwyXBp82Hji2g47M+KpsHDICjAWPpOtT6kIFNTpnXYIWfX9tj7+k9Ou6xGYXgK9DTrRy
 M22fBKBFFnNvS7tJ4Hv/dw3gg7xfylgOIoRyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732228346; x=1732833146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grVCJAamUcXBKvf7wFpNznTL3+Y+eH4IC6hb/bJXcvA=;
 b=PLcx9AAyneyRM1CsYA5b/JdGBGOHhEYc0CCpGPet4fyjSIyPg4dsgQhytcxzDISkkE
 Tjrn1XIvVMJI9t9ve51ZVPxF+hMnyy4jOEQvSSZaRCDvcnzqmqcHPCdpdf8C53NLgoXS
 HDHe44IhMnIRec/enYMI2c1MZY2c4x6vGPPevAJTxHUdxfD/WPRTXCp6XQkjBiDuBTm8
 TC5KOdWDFlrhtyjZE100ByLBsBEcq3S6b0O20CckiMF9z6Uu67ohqtDaUNiUJbE3ZrBa
 etdI/rNnImb9lfdI89EXWuNldI8tPMsvJp4yXRVD/NKw47TFa0kOWKFwad/9NXTKuEPV
 T69w==
X-Gm-Message-State: AOJu0YzLivwa+KoRel0p/t5ksU2T0jifLOdJmNe7QZ2Sd0mie3pnRpuA
 8WFgVZDC5mN/hje466PEFrEgIifInoiyhUYRFS9ARS1lWCNCC1kMeLAx8lCqxSoNJk+yhZXDECs
 =
X-Gm-Gg: ASbGncv0FmX4g22ZCBF+Cq+pbBZ4jFr+ro2rUkOGKIYUwYKYlVUM9HFz27jHbPGSF1R
 Qbsop10xBBZi8MtX8X6jHPtdwB4srMhVa2+jDEdQV8V5mA0YcQTyN8sUUvr72BL5fmcqe0CqyvI
 EEc0Q9zh8ieB/1pvIo0Vem22Tx2ARiimtU2zWwraPGc1KNDiNbARQxkJqADs7SDLSA9oFIzBrhZ
 0/3M3nllURZQNmJNXXcSGr6qAi1xHqd/d8p0dcsNXvSDZ0=
X-Google-Smtp-Source: AGHT+IHzYsgxv8pkJCH3dEugPQUuo2h8x5D05Jhtdumjd/FZ5cYtMFiC8n79vv+ue5mEEqgG/KB2fQ==
X-Received: by 2002:a05:690c:4b83:b0:6db:db7b:891c with SMTP id
 00721157ae682-6eee089f4admr10990617b3.14.1732228345950; 
 Thu, 21 Nov 2024 14:32:25 -0800 (PST)
Received: from chromium.org ([12.181.243.100])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6eedfe2a46esm1687507b3.38.2024.11.21.14.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 14:32:25 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v2 1/8] test_fs: Allow running unprivileged
Date: Thu, 21 Nov 2024 15:32:07 -0700
Message-ID: <20241121223217.330117-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241121223217.330117-1-sjg@chromium.org>
References: <20241121223217.330117-1-sjg@chromium.org>
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

From: Richard Weinberger <richard@nod.at>

There is no need to mount the filesystem on the host side.
All filesystem tools offer some way to fill the fs without mounting.

So, create the content on the host side, create and fill the fs
without mounting.
No more sudo or guestmount needed.

This new approach works because the tests don't care about user IDs
and no device files are needed.
If user IDs start to matter it's still possible to use wrapper
tools like fakeroot in future while filling the fs.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Simon Glass <sjg@chromium.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---

Changes in v2:
- Fix a few pylint errors

 test/py/tests/fs_helper.py        |  11 +-
 test/py/tests/test_fs/conftest.py | 175 ++++++------------------------
 test/py/tests/test_ut.py          |   4 +-
 3 files changed, 47 insertions(+), 143 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 380f4c4dca3..ccfc0201a49 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -9,7 +9,7 @@ import re
 import os
 from subprocess import call, check_call, check_output, CalledProcessError
 
-def mk_fs(config, fs_type, size, prefix, size_gran = 0x100000):
+def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000):
     """Create a file system volume
 
     Args:
@@ -17,6 +17,7 @@ def mk_fs(config, fs_type, size, prefix, size_gran = 0x100000):
         fs_type (str): File system type, e.g. 'ext4'
         size (int): Size of file system in bytes
         prefix (str): Prefix string of volume's file name
+        src_dir (str): Root directory to use, or None for none
         size_gran (int): Size granularity of file system image in bytes
 
     Raises:
@@ -39,6 +40,12 @@ def mk_fs(config, fs_type, size, prefix, size_gran = 0x100000):
     else:
         fs_lnxtype = fs_type
 
+    if src_dir:
+        if fs_lnxtype == 'ext4':
+            mkfs_opt = mkfs_opt + ' -d ' + src_dir
+        elif fs_lnxtype != 'vfat':
+            raise ValueError(f'src_dir not implemented for fs {fs_lnxtype}')
+
     count = (size + size_gran - 1) // size_gran
 
     # Some distributions do not add /sbin to the default PATH, where mkfs lives
@@ -55,6 +62,8 @@ def mk_fs(config, fs_type, size, prefix, size_gran = 0x100000):
                                       shell=True).decode()
             if 'metadata_csum' in sb_content:
                 check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
+        elif fs_lnxtype == 'vfat' and src_dir:
+            check_call(f'mcopy -i {fs_img} -vsmpQ {src_dir}/* ::/', shell=True)
         return fs_img
     except CalledProcessError:
         call(f'rm -f {fs_img}', shell=True)
diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index fca54488374..59342a6e3dd 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -156,64 +156,6 @@ def tool_is_in_path(tool):
             return True
     return False
 
-fuse_mounted = False
-
-def mount_fs(fs_type, device, mount_point):
-    """Mount a volume.
-
-    Args:
-        fs_type: File system type.
-        device: Volume's file name.
-        mount_point: Mount point.
-
-    Return:
-        Nothing.
-    """
-    global fuse_mounted
-
-    try:
-        check_call('guestmount --pid-file guestmount.pid -a %s -m /dev/sda %s'
-            % (device, mount_point), shell=True)
-        fuse_mounted = True
-        return
-    except CalledProcessError:
-        fuse_mounted = False
-
-    mount_opt = 'loop,rw'
-    if re.match('fat', fs_type):
-        mount_opt += ',umask=0000'
-
-    check_call('sudo mount -o %s %s %s'
-        % (mount_opt, device, mount_point), shell=True)
-
-    # may not be effective for some file systems
-    check_call('sudo chmod a+rw %s' % mount_point, shell=True)
-
-def umount_fs(mount_point):
-    """Unmount a volume.
-
-    Args:
-        mount_point: Mount point.
-
-    Return:
-        Nothing.
-    """
-    if fuse_mounted:
-        call('sync')
-        call('guestunmount %s' % mount_point, shell=True)
-
-        try:
-            with open("guestmount.pid", "r") as pidfile:
-                pid = int(pidfile.read())
-            util.waitpid(pid, kill=True)
-            os.remove("guestmount.pid")
-
-        except FileNotFoundError:
-            pass
-
-    else:
-        call('sudo umount %s' % mount_point, shell=True)
-
 #
 # Fixture for basic fs test
 #     derived from test/fs/fs-test.sh
@@ -241,14 +183,6 @@ def fs_obj_basic(request, u_boot_config):
     small_file = mount_dir + '/' + SMALL_FILE
     big_file = mount_dir + '/' + BIG_FILE
 
-    try:
-
-        # 3GiB volume
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0xc0000000, '3GB')
-    except CalledProcessError as err:
-        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-        return
-
     try:
         check_call('mkdir -p %s' % mount_dir, shell=True)
     except CalledProcessError as err:
@@ -256,15 +190,6 @@ def fs_obj_basic(request, u_boot_config):
         call('rm -f %s' % fs_img, shell=True)
         return
 
-    try:
-        # Mount the image so we can populate it.
-        mount_fs(fs_type, fs_img, mount_dir)
-    except CalledProcessError as err:
-        pytest.skip('Mounting to folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rmdir %s' % mount_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
-        return
-
     try:
         # Create a subdirectory.
         check_call('mkdir %s/SUBDIR' % mount_dir, shell=True)
@@ -326,15 +251,20 @@ def fs_obj_basic(request, u_boot_config):
 	    % big_file, shell=True).decode()
         md5val.append(out.split()[0])
 
+        try:
+            # 3GiB volume
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0xc0000000, '3GB', mount_dir)
+        except CalledProcessError as err:
+            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
+            return
+
     except CalledProcessError as err:
         pytest.skip('Setup failed for filesystem: ' + fs_type + '. {}'.format(err))
-        umount_fs(mount_dir)
         return
     else:
-        umount_fs(mount_dir)
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rmdir %s' % mount_dir, shell=True)
+        call('rm -rf %s' % mount_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -363,14 +293,6 @@ def fs_obj_ext(request, u_boot_config):
     min_file = mount_dir + '/' + MIN_FILE
     tmp_file = mount_dir + '/tmpfile'
 
-    try:
-
-        # 128MiB volume
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB')
-    except CalledProcessError as err:
-        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-        return
-
     try:
         check_call('mkdir -p %s' % mount_dir, shell=True)
     except CalledProcessError as err:
@@ -378,15 +300,6 @@ def fs_obj_ext(request, u_boot_config):
         call('rm -f %s' % fs_img, shell=True)
         return
 
-    try:
-        # Mount the image so we can populate it.
-        mount_fs(fs_type, fs_img, mount_dir)
-    except CalledProcessError as err:
-        pytest.skip('Mounting to folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rmdir %s' % mount_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
-        return
-
     try:
         # Create a test directory
         check_call('mkdir %s/dir1' % mount_dir, shell=True)
@@ -427,15 +340,21 @@ def fs_obj_ext(request, u_boot_config):
         md5val.append(out.split()[0])
 
         check_call('rm %s' % tmp_file, shell=True)
+
+        try:
+            # 128MiB volume
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', mount_dir)
+        except CalledProcessError as err:
+            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
+            return
+
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
-        umount_fs(mount_dir)
         return
     else:
-        umount_fs(mount_dir)
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rmdir %s' % mount_dir, shell=True)
+        call('rm -rf %s' % mount_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -461,7 +380,7 @@ def fs_obj_mkdir(request, u_boot_config):
 
     try:
         # 128MiB volume
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB')
+        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', None)
     except:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
@@ -492,14 +411,6 @@ def fs_obj_unlink(request, u_boot_config):
 
     mount_dir = u_boot_config.persistent_data_dir + '/mnt'
 
-    try:
-
-        # 128MiB volume
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB')
-    except CalledProcessError as err:
-        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-        return
-
     try:
         check_call('mkdir -p %s' % mount_dir, shell=True)
     except CalledProcessError as err:
@@ -507,15 +418,6 @@ def fs_obj_unlink(request, u_boot_config):
         call('rm -f %s' % fs_img, shell=True)
         return
 
-    try:
-        # Mount the image so we can populate it.
-        mount_fs(fs_type, fs_img, mount_dir)
-    except CalledProcessError as err:
-        pytest.skip('Mounting to folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rmdir %s' % mount_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
-        return
-
     try:
         # Test Case 1 & 3
         check_call('mkdir %s/dir1' % mount_dir, shell=True)
@@ -538,15 +440,20 @@ def fs_obj_unlink(request, u_boot_config):
         check_call('dd if=/dev/urandom of=%s/dir5/file1 bs=1K count=1'
                                     % mount_dir, shell=True)
 
+        try:
+            # 128MiB volume
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x8000000, '128MB', mount_dir)
+        except CalledProcessError as err:
+            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
+            return
+
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
-        umount_fs(mount_dir)
         return
     else:
-        umount_fs(mount_dir)
         yield [fs_ubtype, fs_img]
     finally:
-        call('rmdir %s' % mount_dir, shell=True)
+        call('rm -rf %s' % mount_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -575,14 +482,6 @@ def fs_obj_symlink(request, u_boot_config):
     small_file = mount_dir + '/' + SMALL_FILE
     medium_file = mount_dir + '/' + MEDIUM_FILE
 
-    try:
-
-        # 1GiB volume
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x40000000, '1GB')
-    except CalledProcessError as err:
-        pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
-        return
-
     try:
         check_call('mkdir -p %s' % mount_dir, shell=True)
     except CalledProcessError as err:
@@ -590,15 +489,6 @@ def fs_obj_symlink(request, u_boot_config):
         call('rm -f %s' % fs_img, shell=True)
         return
 
-    try:
-        # Mount the image so we can populate it.
-        mount_fs(fs_type, fs_img, mount_dir)
-    except CalledProcessError as err:
-        pytest.skip('Mounting to folder failed for filesystem: ' + fs_type + '. {}'.format(err))
-        call('rmdir %s' % mount_dir, shell=True)
-        call('rm -f %s' % fs_img, shell=True)
-        return
-
     try:
         # Create a subdirectory.
         check_call('mkdir %s/SUBDIR' % mount_dir, shell=True)
@@ -621,15 +511,20 @@ def fs_obj_symlink(request, u_boot_config):
             % medium_file, shell=True).decode()
         md5val.extend([out.split()[0]])
 
+        try:
+            # 1GiB volume
+            fs_img = fs_helper.mk_fs(u_boot_config, fs_type, 0x40000000, '1GB', mount_dir)
+        except CalledProcessError as err:
+            pytest.skip('Creating failed for filesystem: ' + fs_type + '. {}'.format(err))
+            return
+
     except CalledProcessError:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
-        umount_fs(mount_dir)
         return
     else:
-        umount_fs(mount_dir)
         yield [fs_ubtype, fs_img, md5val]
     finally:
-        call('rmdir %s' % mount_dir, shell=True)
+        call('rm -rf %s' % mount_dir, shell=True)
         call('rm -f %s' % fs_img, shell=True)
 
 #
@@ -665,7 +560,7 @@ def fs_obj_fat(request, u_boot_config):
 
     try:
         # the volume size depends on the filesystem
-        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{fs_size}', 1024)
+        fs_img = fs_helper.mk_fs(u_boot_config, fs_type, fs_size, f'{fs_size}', None, 1024)
     except:
         pytest.skip('Setup failed for filesystem: ' + fs_type)
         return
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6d44191976b..70ac012b3ad 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -540,8 +540,8 @@ def test_ut_dm_init(u_boot_console):
         u_boot_utils.run_and_log(
             u_boot_console, f'sfdisk {fn}', stdin=b'type=83')
 
-    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB')
-    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB')
+    fs_helper.mk_fs(u_boot_console.config, 'ext2', 0x200000, '2MB', None)
+    fs_helper.mk_fs(u_boot_console.config, 'fat32', 0x100000, '1MB', None)
 
     mmc_dev = 6
     fn = os.path.join(u_boot_console.config.source_dir, f'mmc{mmc_dev}.img')
-- 
2.43.0

