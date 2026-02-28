Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBFDFFEE4EE
	for <u-boot@archiver.kernel.org>; Sat, 28 Feb 2026 18:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE62B83F53;
	Sat, 28 Feb 2026 19:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CL2yQmuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F37EE83F20; Sat, 28 Feb 2026 19:23:34 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAD7583F2D
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 19:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-506a019a7f3so40105201cf.3
 for <u-boot@lists.denx.de>; Sat, 28 Feb 2026 10:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772303011; x=1772907811; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbSPbayxnzwqrPANUf/rz4pVcO1SzIRJ9asVAgOndoA=;
 b=CL2yQmuhfe0J30A100ERnbKjX4OvfKsbpdJlNXzWz6511TnqQsPp65aM/DeDmf7+f+
 WvygXZ/zWS0uzUMgDGv8sHEXi6WGSxwAxDdXgdA94jhDjOQLHa0KhOonYuKr5JZuGRxx
 6OzcgQbY7p0VnES1OcYiL1KrzeQcJe2XXqKfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772303011; x=1772907811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AbSPbayxnzwqrPANUf/rz4pVcO1SzIRJ9asVAgOndoA=;
 b=DFZdIhpQlqpfWtq5gcW1SHWRAhWFGNS8bAGVr37qtVaQSe2KNdOKOvwjMRo5OZIoYg
 NHEeA8Ya0cYJLB3cUWwZt0CkrR711BHn9OsPjXCOFNFLoXhw9zhfIMuPPMjb/8Q8WL2/
 /9olUOtJ48pEEZHs9fP7EBUj3JJsxQ/Lvd2l1UzAiZDziQsPycG5Axm3tWPHLpxBYuhh
 HjrtjRO1JbCtSJ8BMzv78OcrIOI9yE2ByrYSHuPbR8G0qEwV/W5u8L8G61BT4QQ1CWIu
 Lllpuwhzot55GBqoFNEddDfoqtfX96UZ8H5QSx3+8WuYhbxJ9qPYxJIhjniuM7tltz2x
 WLGw==
X-Gm-Message-State: AOJu0YxmEdwvjOhooFE1f483zZi2Ipe1FEbIWQrGNPoGIEdKZMRh9JAX
 YHbv4EAxwSfZMDv0tWtL793hyMmLU5IoOWrceyJkuNYEIFIjkkN9NFLvAD+yEmm4AhYj3T5m46u
 ue7Q=
X-Gm-Gg: ATEYQzwyIT2VxH64Vbjb1SkLjpJaY3Mwn27uJm/WTgJA7t6ihjWNio8YZnZ/Vl7XGZa
 /rZH9R9uEv73kDSgM8V49YsWHFuatLbrGp3eYSlIsAAk3rRAA0onloV+HHQgxwbW3X/VAZJArf6
 h3NgdqXTXHfhWsKk7YiM1uMrw/qKWHb5MxvKpItFOpltbnv5Frt8OBF6L1w53K6fLbPPjsGWt1H
 0SpDQy8xDPfO4WhVwcRbwNRBOxRfcHFLptdknpzUaO9+BXZli70ho12vysvNVA1lvKVuFOWvub2
 /OzIC/1qrXuooiyABpKcRVX3Agtzj9QyutxXrJSfv/Nn/NI4T+V4JzCDmkLzeUxqJs2YF5cBQ5P
 5PMcC6mxRcV9aJ3SVOSRrhA+vPMHFR0CQJiwq3AqA8wUhEAhm9SdDKn5/vcuqGg6KG88MCQpWPc
 GG/v5lT3pEs4PRrlRaiRVdqW24fA3I
X-Received: by 2002:ac8:7c4b:0:b0:4f1:c6be:c853 with SMTP id
 d75a77b69052e-50752792e61mr94644641cf.25.1772303010945; 
 Sat, 28 Feb 2026 10:23:30 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449a66f1sm78508601cf.12.2026.02.28.10.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 10:23:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 5/7] test: Convert fs_helper to use a class
Date: Sat, 28 Feb 2026 11:22:45 -0700
Message-ID: <20260228182304.3728735-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228182304.3728735-1-sjg@chromium.org>
References: <20260228182304.3728735-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/tests/fs_helper.py | 209 +++++++++++++++++++++++++++----------
 1 file changed, 154 insertions(+), 55 deletions(-)

diff --git a/test/py/tests/fs_helper.py b/test/py/tests/fs_helper.py
index 72e18588288..fac811f352e 100644
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
@@ -31,59 +175,14 @@ def mk_fs(config, fs_type, size, prefix, src_dir=None, fs_img=None, quiet=False)
     Raises:
         CalledProcessError: if any error occurs when creating the filesystem
     """
-    if not fs_img:
-        fs_img = f'{prefix}.{fs_type}.img'
-    fs_img = os.path.join(config.persistent_data_dir, fs_img)
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
-        elif fs_lnxtype != 'vfat' and fs_lnxtype != 'exfat':
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
+        fsh.fs_img = os.path.join(config.persistent_data_dir, fs_img)
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

