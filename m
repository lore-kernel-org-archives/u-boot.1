Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A99FD3774
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 16:38:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A6DE841F2;
	Wed, 25 Feb 2026 17:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PNMQdwzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA261841F7; Wed, 25 Feb 2026 17:33:01 +0100 (CET)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B04D841E6
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 17:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x443.google.com with SMTP id
 d2e1a72fcca58-824b05d2786so5362794b3a.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772037157; x=1772641957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hk90ND8ujHmqMREU/HXgN4STWEIdtbwjrxUu3I7hqUw=;
 b=PNMQdwzjfdhRcvgDNzzs+lkXAzOnj671hR5SiG2JEtFdsjtGALmxXGG+9U5Y8kLSLA
 yY5zvs2zlAp8fbPKZQ9wbZEoHEXrhKpr7ZtNnWPBHW3kbmpibZXA1SHat00Wq4p9mdM1
 EngMgY6FXLTtgkeU20OI3VAYvNwVqtO8UTTCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772037157; x=1772641957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hk90ND8ujHmqMREU/HXgN4STWEIdtbwjrxUu3I7hqUw=;
 b=PN9T981nj7DlbWHplo9JGcyyiG0O8ZPC1JTke1v/W6P9QOjj7ezMrwCPlW2YoSgJAV
 aGeaLXZZfAW8x4GaMCbUd7cHz/wIr467wJnjCxENxgnd+yLn+5PZwawI8ow1AR8H6Nnx
 5GEiLOzhQZdfsR6K4rHnvJcNijTJC8tD3Uk9+VwPgh6p+SIOLTFIDxRotAX6zv1+YKF5
 xI/SrdA4TC6ZbSyzEx2gZ9wRLyw6CMG2l+6jwHWNj4jGk60iERLORL1CwGyeDioielMx
 ReWMlEQ8n2CsgwNvy/OwiQNRnJXhByAGN9w2wU4r2Sc8d/9ya9BTi92cmU5RINYm3kyj
 UYQw==
X-Gm-Message-State: AOJu0Yw+bUk89cGXIB6tc/6GWqkQYnCXz9EnKL0YDLdlgoMtVZeFZK4T
 +AbjztioNfsUG6N/YXuP4BhMtIc79eTKK1zrqyA6cOn1MtdPVHny3oy2RBuJLlcns5VNtHXY5k+
 cvjN/jg==
X-Gm-Gg: ATEYQzzp6Aexn7NwdfbI6Mqg88jun26OHMYiecJ/HKYJQ2RSssjtks56PWX4lBzQVg9
 yZL2kK4U/Z1RHNk+U9K9ZBd4w8wfwrzwIVyVRD6eFQ7Ab+HEGji8uH4ORHqQ1ywOF/Z0L6KP/q8
 7Ey4o23FgoH3UienKxSghyFOB4sGi2mFDdKAKrFgP3FcWYpc52LFEPNkwXqq6xxL+86GrSeWqIW
 kNsgAyBJsIOX415dz27rDEvWQKAgHa1z1dMAZfEnyigc2/i2CJ/Jprn5WnxwRZxeEkpGmuban52
 sUZRGI8rU/FSmq22Z8czZXBAVMrzMZWT0zsNenBkRgvJNA/PDbfXoOSqqNPxkDoFZVg1Pf6rnii
 S6OEWR4iTeRCyce1IyhTjn17P9tdvHvhSXcsFMWVn39sd7T2c2SUAZvZydI8HpiGmlWyyM/uoUa
 5EmTGvdHm6Xno9IGSpFA==
X-Received: by 2002:a05:6830:81e5:b0:7c7:6043:dd8f with SMTP id
 46e09a7af769-7d52be7b8d0mr10870202a34.15.1772036669987; 
 Wed, 25 Feb 2026 08:24:29 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf7874csm13534383a34.1.2026.02.25.08.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 08:24:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH 4/6] test: Convert fs_helper to use a class
Date: Wed, 25 Feb 2026 09:23:48 -0700
Message-ID: <20260225162357.3449937-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225162357.3449937-1-sjg@chromium.org>
References: <20260225162357.3449937-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

It is somewhat inconvenient that callers to mk_fs() must create their
own temporary directory. Convert it to a class so this can be handled
automatically, using a context manager.

Rather than specifying the file size in bytes, use MB since it is rare
to need a smaller file.

Update mk_fs() to use this new class.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 test/py/tests/fs_helper.py | 209 +++++++++++++++++++++++++++----------
 1 file changed, 154 insertions(+), 55 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 6649aa7bc47..531974d7dbe 100644
--- a/test/py/tests/fs_helper.py
+++ b/test/py/tests/fs_helper.py
@@ -7,14 +7,158 @@
 
 import re
 import os
+import shutil
 from subprocess import call, check_call, check_output, CalledProcessError
 from subprocess import DEVNULL
+import tempfile
 
-# size_gran (int): Size granularity of file system image in bytes
-SIZE_GRAN = 1 << 20
 
+class FsHelper:
+    """Creating a filesystem containing test files
 
-def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False):
+    Usage:
+        with FsHelper(ubman.config, 'ext4', 10, 'mmc1') as fsh:
+            # create files in the self.srcdir directory
+            fsh.mk_fs()
+            # Now use the filesystem
+
+        # The filesystem and srcdir are erased after the 'with' statement.
+
+        To set the image filename:
+
+            with FsHelper(ubman.config, 'ext4', 10, 'mmc1') as fsh:
+                fsh.fs_img = 'myfile.img'
+                fsh.mk_fs()
+                ...
+
+        It is also possible to use an existing srcdir:
+
+            with FsHelper(ubman.config, 'fat32', 10, 'usb2') as fsh:
+                fsh.srcdir = src_dir
+                fsh.mk_fs()
+                ...
+
+    Properties:
+        fs_img (str): Filename for the filesystem image; this is set to a
+            default value but can be overwritten
+    """
+    def __init__(self, config, fs_type, size_mb, prefix):
+        """Set up a new object
+
+        Args:
+            config (u_boot_config): U-Boot configuration
+            fs_type (str): File system type: one of ext2, ext3, ext4, vfat,
+                fat12, fat16, fat32, exfat, fs_generic (which means vfat)
+            size_mb (int): Size of file system in MB
+            prefix (str): Prefix string of volume's file name
+        """
+        if ('fat' not in fs_type and 'ext' not in fs_type and
+             fs_type not in ['exfat', 'fs_generic']):
+            raise ValueError(f"Unsupported filesystem type '{fs_type}'")
+
+        self.config = config
+        self.fs_type = fs_type
+        self.size_mb = size_mb
+        self.prefix = prefix
+        self.quiet = True
+
+        # Use a default filename; the caller can adjust it
+        leaf = f'{prefix}.{fs_type}.img'
+        if config:
+            self.fs_img = os.path.join(config.persistent_data_dir, leaf)
+            if os.path.exists(self.fs_img):
+                os.remove(self.fs_img)
+        else:
+            self.fs_img = leaf
+
+        # Some distributions do not add /sbin to the default PATH, where mkfs
+        # lives
+        if '/sbin' not in os.environ["PATH"].split(os.pathsep):
+            os.environ["PATH"] += os.pathsep + '/sbin'
+
+        self.tmpdir = None
+        self.srcdir = None
+        self._do_cleanup = False
+
+    def _get_fs_args(self):
+        """Get the mkfs options and program to use
+
+        Returns:
+            tuple:
+                str: mkfs options, e.g. '-F 32' for fat32
+                str: mkfs program to use, e.g 'ext4' for ext4
+        """
+        if self.fs_type == 'fat12':
+            mkfs_opt = '-F 12'
+        elif self.fs_type == 'fat16':
+            mkfs_opt = '-F 16'
+        elif self.fs_type == 'fat32':
+            mkfs_opt = '-F 32'
+        elif self.fs_type.startswith('ext'):
+            mkfs_opt = f'-d {self.srcdir}'
+        else:
+            mkfs_opt = ''
+
+        if self.fs_type == 'exfat':
+            fs_lnxtype = 'exfat'
+        elif re.match('fat', self.fs_type) or self.fs_type == 'fs_generic':
+            fs_lnxtype = 'vfat'
+        else:
+            fs_lnxtype = self.fs_type
+        return mkfs_opt, fs_lnxtype
+
+    def mk_fs(self):
+        """Make a new filesystem and copy in the files"""
+        self.setup()
+        fs_img = self.fs_img
+        with open(fs_img, 'wb') as fsi:
+            fsi.truncate(self.size_mb << 20)
+        self._do_cleanup = True
+
+        mkfs_opt, fs_lnxtype = self._get_fs_args()
+        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
+                stdout=DEVNULL if self.quiet else None)
+
+        if self.fs_type.startswith('ext'):
+            # Disable metadata checksums which U-Boot does not support
+            check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
+        elif fs_lnxtype == 'exfat' and self.srcdir:
+            check_call(f'fattools cp {self.srcdir}/* {fs_img}', shell=True)
+        elif self.srcdir and os.listdir(self.srcdir):
+            flags = f"-smpQ{'' if self.quiet else 'v'}"
+            check_call(f'mcopy -i {fs_img} {flags} {self.srcdir}/* ::/',
+                    shell=True)
+
+    def setup(self):
+        """Set up the srcdir ready to receive files"""
+        if not self.srcdir:
+            if self.config:
+                self.srcdir = os.path.join(self.config.persistent_data_dir,
+                                           f'{self.prefix}.{self.fs_type}.tmp')
+                if os.path.exists(self.srcdir):
+                    shutil.rmtree(self.srcdir)
+                os.mkdir(self.srcdir)
+            else:
+                self.tmpdir = tempfile.TemporaryDirectory('fs_helper')
+                self.srcdir = self.tmpdir.name
+
+    def cleanup(self):
+        """Remove created image"""
+        if self.tmpdir:
+            self.tmpdir.cleanup()
+        if self._do_cleanup:
+            os.remove(self.fs_img)
+
+    def __enter__(self):
+        self.setup()
+        return self
+
+    def __exit__(self, extype, value, traceback):
+        self.cleanup()
+
+
+def mk_fs(config, fs_type, size, prefix, src_dir=None, size_gran = 0x100000,
+          fs_img=None, quiet=False):
     """Create a file system volume
 
     Args:
@@ -29,59 +173,14 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
-    if not fs_img:
-        leaf = f'{prefix}.{fs_type}.img'
-        fs_img = os.path.join(config.persistent_data_dir, leaf)
-
-    if fs_type == 'fat12':
-        mkfs_opt = '-F 12'
-    elif fs_type == 'fat16':
-        mkfs_opt = '-F 16'
-    elif fs_type == 'fat32':
-        mkfs_opt = '-F 32'
-    else:
-        mkfs_opt = ''
-
-    if fs_type == 'exfat':
-        fs_lnxtype = 'exfat'
-    elif re.match('fat', fs_type) or fs_type == 'fs_generic':
-        fs_lnxtype = 'vfat'
-    else:
-        fs_lnxtype = fs_type
-
-    if src_dir:
-        if fs_lnxtype == 'ext4':
-            mkfs_opt = mkfs_opt + ' -d ' + src_dir
-        elif fs_lnxtype not in ('vfat', 'exfat'):
-            raise ValueError(f'src_dir not implemented for fs {fs_lnxtype}')
-
-    count = (size + SIZE_GRAN - 1) // SIZE_GRAN
-
-    # Some distributions do not add /sbin to the default PATH, where mkfs lives
-    if '/sbin' not in os.environ["PATH"].split(os.pathsep):
-        os.environ["PATH"] += os.pathsep + '/sbin'
+    fsh = FsHelper(config, fs_type, size >> 20, prefix)
+    fsh.srcdir = src_dir
+    fsh.quiet = quiet
+    if fs_img:
+        fsh.fs_img = fs_img
+    fsh.mk_fs()
+    return fsh.fs_img
 
-    try:
-        check_call(f'rm -f {fs_img}', shell=True)
-        check_call(f'truncate -s $(( {SIZE_GRAN} * {count} )) {fs_img}',
-                   shell=True)
-        check_call(f'mkfs.{fs_lnxtype} {mkfs_opt} {fs_img}', shell=True,
-                   stdout=DEVNULL if quiet else None)
-        if fs_type == 'ext4':
-            sb_content = check_output(f'tune2fs -l {fs_img}',
-                                      shell=True).decode()
-            if 'metadata_csum' in sb_content:
-                check_call(f'tune2fs -O ^metadata_csum {fs_img}', shell=True)
-        elif fs_lnxtype == 'vfat' and src_dir:
-            flags = f"-smpQ{'' if quiet else 'v'}"
-            check_call(f'mcopy -i {fs_img} {flags} {src_dir}/* ::/',
-                       shell=True)
-        elif fs_lnxtype == 'exfat' and src_dir:
-            check_call(f'fattools cp {src_dir}/* {fs_img}', shell=True)
-        return fs_img
-    except CalledProcessError:
-        call(f'rm -f {fs_img}', shell=True)
-        raise
 
 def setup_image(ubman, devnum, part_type, img_size=20, second_part=False,
                 basename='mmc'):
-- 
2.43.0

