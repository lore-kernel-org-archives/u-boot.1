Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4128C3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD7B8295C;
	Sun, 11 May 2025 16:18:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="coJy30m5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66F2F82A46; Sun, 11 May 2025 16:18:43 +0200 (CEST)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com
 [IPv6:2a00:1450:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7F3828BC
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x642.google.com with SMTP id
 a640c23a62f3a-acb415dd8faso606320466b.2
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973119; x=1747577919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J93kNWioB7Eltwtci6qu7eErqhJe6UhLXgBI66nddCY=;
 b=coJy30m5gbiAsNgtpl8pSHZQtTVU8kRz2ICTqyEj7VIV3iF5jEG4kNbMfPhoBtIYHE
 CBbL71AB8gznk0ykZUPSN8xSqpQq5G4q/iQS8B33aziJJ0GriCLZ4zs9v7JjVYOmk7cM
 usgQIcLIOalc4rj/UdIGCBRA1ZHj57eomXh/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973119; x=1747577919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J93kNWioB7Eltwtci6qu7eErqhJe6UhLXgBI66nddCY=;
 b=WeYv4sYoFEbOP7o81JW3rZ5iwj6JjHlZLrRkkebshHbwtRn8GZJ8HroUNZ8ktPyQ/+
 eFgO9ciNsCZijeDlJrr3VfLIHNbLm3tSq0lXM6pi0Y2Fhwtcw1nrmri33uIXYAiUP/w+
 0g2sMBlqu3xIJT0HwyIfN+l8ZjLyKQYgoA+KI9loHWGoaYVzgKp7jF4dtERsQiS+HHkl
 Ee3Uoe8g4Fdy/QyP5ir2FVKZm5sP2aBcsi5t0gLOuL7hWcDuPdZ9sFXtdmIok9XdoYsi
 PPs6oYijRZeonYta3fD501i9p7Hwpok4lQU/7wykv8meXWQU/x/J37H/e1lt3gfraZFz
 SNUA==
X-Gm-Message-State: AOJu0Yy2orT5xNkoOG8gq4BJUi2BjIq9ZR4nU8jSPaLV5JFQNuv203eC
 59O1hyKqTVqipvFfG5uM13FOgV/6xqDa7mngZSIdjAgiYyYdSl1cMyLqs5JIpm71rCooUJ6t0WA
 AtCXPcu7cYHH2
X-Gm-Gg: ASbGncsBOrs6sfYRQY5CmiLnERD4X5SZti9IkKHReEOrKJhK3ZwjxKKES74PyJ6j+fm
 oaQ7YJyTP4TwK3LC+FWkvG+2rZiMhnL0+RFAWOcNvhtMzYFCbCODz2ofAMO2DmxqfsMIE//YVzK
 75fu0qkivfoivFBrBLcuhVDz/MsPCGgDQAldW8bIHAHlgQBnZIxpYblb9fq8km8sRu+IgEgqoUP
 p8qvKg71WUpRLeWUboHtf/rjFzGcWKYUWJz8xDQ1jwk3mhvd18ZA2U8Vrc3nNreUGJlCWg3TFt6
 X+aEKySBjOEk2/gjEuq7rtx9vhLyZKRCEf4fhzYCgHwRYR8=
X-Google-Smtp-Source: AGHT+IErSdIuuqdXpWzX+UOx3y5MHazguLGsREUR0zOLNrF1SzVYTdvD9yQn9YVZchXCWKeDeCkaxQ==
X-Received: by 2002:a17:907:7b07:b0:ad2:2be9:58fd with SMTP id
 a640c23a62f3a-ad22be95fccmr653094166b.57.1746973119266; 
 Sun, 11 May 2025 07:18:39 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/6] scripts: Convert the build-efi script to avoid sudo
Date: Sun, 11 May 2025 16:18:18 +0200
Message-ID: <20250511141828.2367318-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511141828.2367318-1-sjg@chromium.org>
References: <20250511141828.2367318-1-sjg@chromium.org>
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

Make use of the mk_fs() function to avoid needing to use sudo to mount
the loopback partition. This makes the script a little more friendly for
those nervous about sudo in their tools.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS             |   1 +
 scripts/build-efi       | 104 +++++-----------------------------------
 scripts/build_helper.py |  64 +++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 92 deletions(-)
 create mode 100644 scripts/build_helper.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 939c46ef23a..aebccd9678f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1127,6 +1127,7 @@ W:	https://docs.u-boot.org/en/latest/board/emulation/script.html
 F:	configs/qemu_x86*
 F:	doc/board/emulation/script.rst
 F:	scripts/build-qemu.sh
+F:	scripts/build_helper.py
 
 ENVIRONMENT
 M:	Joe Hershberger <joe.hershberger@ni.com>
diff --git a/scripts/build-efi b/scripts/build-efi
index e71028baa6d..a2b5540ad29 100755
--- a/scripts/build-efi
+++ b/scripts/build-efi
@@ -17,21 +17,10 @@ Use ~/.build-efi to configure the various paths used by this script.
 
 from argparse import ArgumentParser
 import configparser
-import glob
 import os
-import re
 import shutil
-import sys
-import time
-
-
-OUR_PATH = os.path.dirname(os.path.realpath(__file__))
-OUR1_PATH = os.path.dirname(OUR_PATH)
-
-# Bring in the patman and dtoc libraries (but don't override the first path
-# in PYTHONPATH)
-sys.path.insert(2, os.path.join(OUR1_PATH, 'tools'))
 
+from build_helper import Helper
 
 # pylint: disable=C0413
 from u_boot_pylib import command
@@ -108,11 +97,10 @@ efi_dir = .
 class BuildEfi:
     """Class to collect together the various bits of state while running"""
     def __init__(self, settings, args):
+        self.helper = Helper()
         self.settings = settings
         self.img = self.get_setting('image_file', 'try.img')
         self.build_dir = self.get_setting("build_dir", '/tmp')
-        self.mnt = self.get_setting("mount_point", '/mnt/test-efi')
-        self.tmp = None
         self.args = args
 
     def get_setting(self, name, fallback=None):
@@ -174,83 +162,18 @@ class BuildEfi:
         cmd += extra
         command.run(*cmd)
 
-    def setup_files(self, build, build_type):
+    def setup_files(self, build, build_type, dst):
         """Set up files in the staging area
 
         Args:
             build (str): Name of build being packaged, e.g. 'efi-x86_app32'
             build_type (str): Build type ('app' or 'payload')
+            dst (str): Destination directory
         """
         print(f'Packaging {build}')
-        if not os.path.exists(self.tmp):
-            os.mkdir(self.tmp)
         fname = f'u-boot-{build_type}.efi'
-        tools.write_file(f'{self.tmp}/startup.nsh', f'fs0:{fname}',
-                         binary=False)
-        shutil.copy(f'{self.build_dir}/{build}/{fname}', self.tmp)
-
-    def copy_files(self):
-        """Copy files into the filesystem"""
-        command.run('sudo', 'cp', *glob.glob(f'{self.tmp}/*'), self.mnt)
-        if self.args.kernel:
-            bzimage = self.get_setting('bzimage_file', 'bzImage')
-            command.run('sudo', 'cp', bzimage, f'{self.mnt}/vmlinuz')
-
-    def setup_raw(self):
-        """Create a filesystem on a raw device and copy in the files"""
-        command.output('mkfs.vfat', self.img)
-        command.run('sudo', 'mkdir', '-p', self.mnt)
-        command.run('sudo', 'mount', '-o', 'loop', self.img, self.mnt)
-        self.copy_files()
-        command.run('sudo', 'umount', self.mnt)
-
-    def setup_part(self):
-        """Set up a partition table
-
-        Create a partition table and put the filesystem in the first partition
-        then copy in the files
-        """
-
-        # Create a gpt partition table with one partition
-        command.run('parted', self.img, 'mklabel', 'gpt', capture_stderr=True)
-
-        # This doesn't work correctly. It creates:
-        # Number  Start   End     Size    File system  Name  Flags
-        #  1      1049kB  24.1MB  23.1MB               boot  msftdata
-        # Odd if the same is entered interactively it does set the FS type
-        command.run('parted', '-s', '-a', 'optimal', '--',
-                    self.img, 'mkpart', 'boot', 'fat32', '1MiB', '23MiB')
-
-        # Map this partition to a loop device. Output is something like:
-        # add map loop48p1 (252:3): 0 45056 linear 7:48 2048
-        out = command.output('sudo', 'kpartx', '-av', self.img)
-        m = re.search(r'(loop.*p.)', out)
-        if not m:
-            raise ValueError(f'Invalid output from kpartx: {out}')
-
-        boot_dev = m.group(1)
-        dev = f'/dev/mapper/{boot_dev}'
-
-        command.output('mkfs.vfat', dev)
-
-        command.run('sudo', 'mount', '-o', 'loop', dev, self.mnt)
-
-        try:
-            self.copy_files()
-        finally:
-            # Sync here since this makes kpartx more likely to work the first time
-            command.run('sync')
-            command.run('sudo', 'umount', self.mnt)
-
-            # For some reason this needs a sleep or it sometimes fails, if it was
-            # run recently (in the last few seconds)
-            try:
-                cmd = 'sudo', 'kpartx', '-d', self.img
-                command.output(*cmd)
-            except command.CommandExc:
-                time.sleep(0.5)
-                cmd = 'sudo', 'kpartx', '-d', self.img
-                command.output(*cmd)
+        tools.write_file(f'{dst}/startup.nsh', f'fs0:{fname}', binary=False)
+        shutil.copy(f'{self.build_dir}/{build}/{fname}', dst)
 
     def do_build(self, build):
         """Build U-Boot for the selected board"""
@@ -267,7 +190,6 @@ class BuildEfi:
         bitness = 32 if args.word else 64
         arch = 'arm' if args.arm else 'x86'
         build_type = 'payload' if args.payload else 'app'
-        self.tmp = f'{self.build_dir}/efi{bitness}{build_type}'
         build = f'efi-{arch}_{build_type}{bitness}'
 
         if not args.no_build:
@@ -276,14 +198,12 @@ class BuildEfi:
         if args.old and bitness == 32:
             build = f'efi-{arch}_{build_type}'
 
-        self.setup_files(build, build_type)
-
-        command.output('qemu-img', 'create', self.img, '24M')
-
-        if args.partition:
-            self.setup_part()
-        else:
-            self.setup_raw()
+        with self.helper.make_disk(self.img, fs_type='vfat',
+                                   use_part=args.partition) as dirpath:
+            self.setup_files(build, build_type, dirpath)
+            if self.args.kernel:
+                bzimage = self.helper.get_setting('bzimage_file', 'bzImage')
+                command.run('cp', bzimage, f'{dirpath}/vmlinuz')
 
         if args.run:
             self.run_qemu(bitness, args.serial)
diff --git a/scripts/build_helper.py b/scripts/build_helper.py
new file mode 100644
index 00000000000..15177a48e80
--- /dev/null
+++ b/scripts/build_helper.py
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+"""Common script for build- scripts
+
+"""
+
+import contextlib
+import os
+import shutil
+import subprocess
+import sys
+import tempfile
+
+OUR_PATH = os.path.dirname(os.path.realpath(__file__))
+OUR1_PATH = os.path.dirname(OUR_PATH)
+
+# Bring in the patman and test libraries (but don't override the first path in
+# PYTHONPATH)
+sys.path.insert(2, os.path.join(OUR1_PATH, 'tools'))
+sys.path.insert(2, os.path.join(OUR1_PATH, 'test/py/tests'))
+
+from u_boot_pylib import command
+from u_boot_pylib import tools
+import fs_helper
+
+
+class Helper:
+    def __init__(self):
+        self.settings = None
+
+    @contextlib.contextmanager
+    def make_disk(self, fname, size_mb=20, fs_type='ext4', use_part=False):
+        """Create a raw disk image with files on it
+
+        Args:
+            fname (str): Filename to write the images to
+            fs_type (str): Filesystem type to create (ext4 or vfat)
+            size_mb (int): Size in MiB
+            use_part (bool): True to create a partition table, False to use a
+                raw disk image
+
+        Yields:
+            str: Directory to write the files into
+        """
+        with tempfile.NamedTemporaryFile() as tmp:
+            with tempfile.TemporaryDirectory(prefix='build_helper.') as dirname:
+                try:
+                    yield dirname
+                    fs_helper.mk_fs(None, fs_type, size_mb << 20, None, dirname,
+                                    fs_img=tmp.name, quiet=True)
+                finally:
+                    pass
+
+            if use_part:
+                with open(fname, 'wb') as img:
+                    img.truncate(size_mb << 20)
+                    img.seek(1 << 20, 0)
+                    img.write(tools.read_file(tmp.name))
+                subprocess.run(
+                    ['sfdisk', fname], text=True, check=True,
+                    capture_output=True,
+                    input=f'type=c, size={size_mb-1}M, start=1M,bootable')
+            else:
+                shutil.copy2(tmp.name, fname)
-- 
2.43.0

