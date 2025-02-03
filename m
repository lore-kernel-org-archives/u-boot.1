Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3A8C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19E3A801BE;
	Mon,  3 Feb 2025 18:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ljK1J/8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D883800D7; Mon,  3 Feb 2025 18:43:10 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A538B800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ee29277d44so2999250b6e.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604586; x=1739209386; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrpKtCxPhDRuqhnTHRoVJIYFummICes/909W5b83FCU=;
 b=ljK1J/8BuR2y0vtZt0T8oMxWJOIEfy0gPzGvwLK2V8iMeBE+XuRJ/8lDTheCimkjuy
 QPB3Gf/lB4Vn/OUm/EDYsvB6UUBx5mga3lHiDfhHohuZPD6DLlUhkKhYqZYnt5UmQfzF
 CCC5KXWVNcf2NEMb//x4KlGnZaJ5e4X2Ts0v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604586; x=1739209386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WrpKtCxPhDRuqhnTHRoVJIYFummICes/909W5b83FCU=;
 b=TRojfZpG6Gw2VH3FipwdbjLEUbQH1ALwm6h1gkSlm81orLXPj28JSqTrQIx/2FCDZn
 h7WDb8JnESTGndRH2ZSbnic1cboTfSz5XdfKdi1ik+jEsp6mZ1EWc7tAnmgHn1AFNtWL
 zBqxTtgPK/dnIucTQP/927IsG0tBfAtomQzsg6h3q0dnXZG9hHfa3mnrFDJ3P9T+VPex
 rvz0FLf8OJYtmxwgw/CcR4qqN00zZ569N3wfi2f0KskK4yo0Aj/9ZvMY/S7jki2R6H/D
 GeFIxFsD4GkRmA0rFuBCux2uqLGmM919j3pJXxn2luE5DU4ilC7oMpBJhLk2F6o0m6CS
 QqFg==
X-Gm-Message-State: AOJu0YyzIi18skpwMe8TYjGy8vSBXEJGcqnPsabBqkcopGNMaj2vvsSi
 RBSLFdHBuLZB3SvSolMLy5FdI1mz7D0R15S70QAqe9yyl1Ua4/5n0Za64sSgyeZ2JHJI5irD778
 =
X-Gm-Gg: ASbGnctXDi2MS224dsFK8x1lv+Aw13xNs2v6hcpLHWfv74YGgeunqYe5D3eiOBr1L9a
 pe+hgi3IWmJMAxFa6raR0Td4aq5rxfbQ7S3CVcMIVpanQ+iTrIPiDqGZT1OBFS5ITdVOY5Dhnwt
 Nx56n6scLOfCvNc7pQIOkxLRKkrzSx+cQLY4HOZdy3hrcDhDxnhpnMpdhEwbvNGgXms+YucMoRV
 /v1Pc5lib4qL/DiLX2XwgD2i6NAXXnWFN8RHrOdcNHW9u1D2b2b162+JXGmrPLJWTMz3p4oscF6
 ihdUq7N4fXrypaUMJOmiLX77W8c+DLMjQ9MTKDeAJFRkxfG3wVPm
X-Google-Smtp-Source: AGHT+IH+m5edM8A5vCWToXRiCWAVfVggEDjyeXPJvDiSES8IIH01m1rDyqt3Cr/+ZRzTqMAX48tKYw==
X-Received: by 2002:a05:6808:3196:b0:3e7:b800:fa0 with SMTP id
 5614622812f47-3f323a3c654mr16768746b6e.10.1738604585503; 
 Mon, 03 Feb 2025 09:43:05 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:04 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/32] Convert build-efi script to Python
Date: Mon,  3 Feb 2025 10:41:54 -0700
Message-ID: <20250203174245.1331464-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

Before this gets any longer, convert it to Python so it is easier to
maintain.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                        |   2 +-
 doc/develop/uefi/u-boot_on_efi.rst |   4 +-
 scripts/build-efi.py               | 258 +++++++++++++++++++++++++++++
 scripts/build-efi.sh               | 207 -----------------------
 4 files changed, 261 insertions(+), 210 deletions(-)
 create mode 100755 scripts/build-efi.py
 delete mode 100755 scripts/build-efi.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ba0c98cef2..a8e81577090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1072,7 +1072,7 @@ F:	doc/develop/uefi/u-boot_on_efi.rst
 F:	drivers/block/efi-media-uclass.c
 F:	drivers/block/sb_efi_media.c
 F:	lib/efi/efi_app.c
-F:	scripts/build-efi.sh
+F:	scripts/build-efi.py
 F:	test/dm/efi_media.c
 
 EFI LOGGING
diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
index 245b4af1fa3..9d441cdc2c5 100644
--- a/doc/develop/uefi/u-boot_on_efi.rst
+++ b/doc/develop/uefi/u-boot_on_efi.rst
@@ -96,7 +96,7 @@ that EFI does not support booting a 64-bit application from a 32-bit
 EFI (or vice versa). Also it will often fail to print an error message if
 you get this wrong.
 
-You may find the script `scripts/build-efi.sh` helpful for building and testing
+You may find the script `scripts/build-efi.py` helpful for building and testing
 U-Boot on UEFI on QEMU. It also includes links to UEFI binaries dating from
 2021.
 
@@ -201,7 +201,7 @@ Example run
 
 This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
 
-   $ scripts/build-efi.sh -wsPr
+   $ scripts/build-efi.py -wsPr
    Packaging efi-x86_app32
    Running qemu-system-i386
 
diff --git a/scripts/build-efi.py b/scripts/build-efi.py
new file mode 100755
index 00000000000..495817bc064
--- /dev/null
+++ b/scripts/build-efi.py
@@ -0,0 +1,258 @@
+#!/usr/bin/env python
+# SPDX-License-Identifier: GPL-2.0+
+"""
+Script to build an EFI thing suitable for booting with QEMU, possibly running
+it also.
+
+UEFI binaries for QEMU used for testing this script:
+
+OVMF-pure-efi.i386.fd at
+https://drive.google.com/file/d/1jWzOAZfQqMmS2_dAK2G518GhIgj9r2RY/view?usp=sharing
+
+OVMF-pure-efi.x64.fd at
+https://drive.google.com/file/d/1c39YI9QtpByGQ4V0UNNQtGqttEzS-eFV/view?usp=sharing
+
+Use ~/.build-efi to configure the various paths used by this script.
+"""
+
+from argparse import ArgumentParser
+import configparser
+import glob
+import os
+import re
+import shutil
+import sys
+import time
+
+
+OUR_PATH = os.path.dirname(os.path.realpath(__file__))
+OUR1_PATH = os.path.dirname(OUR_PATH)
+
+# Bring in the patman and dtoc libraries (but don't override the first path
+# in PYTHONPATH)
+sys.path.insert(2, os.path.join(OUR1_PATH, 'tools'))
+
+
+# pylint: disable=C0413
+from u_boot_pylib import command
+from u_boot_pylib import tools
+
+
+def parse_args():
+    """Parse the program arguments
+
+    Return:
+        Namespace object
+    """
+    parser = ArgumentParser(
+        epilog='Script for running U-Boot as an EFI app/payload')
+    parser.add_argument('-a', '--app', action='store_true',
+                        help='Package up the app')
+    parser.add_argument('-k', '--kernel', action='store_true',
+                        help='Add a kernel')
+    parser.add_argument('-o', '--old', action='store_true',
+                        help='Use old EFI app build (before 32/64 split)')
+    parser.add_argument('-p', '--payload', action='store_true',
+                        help='Package up the payload')
+    parser.add_argument('-P', '--partition', action='store_true',
+                        help='Create a partition table')
+    parser.add_argument('-r', '--run', action='store_true',
+                        help='Run QEMU with the image')
+    parser.add_argument('-s', '--serial', action='store_true',
+                        help='Run QEMU with serial only (no display)')
+    parser.add_argument('-w', '--word', action='store_true',
+                        help='Use word version (32-bit) rather than 64-bit')
+
+    args = parser.parse_args()
+
+    if args.app and args.payload:
+        raise ValueError('Please choose either app or payload, not both')
+    return args
+
+
+def get_settings():
+    """Get settings from the settings file
+
+    Return:
+        ConfigParser containing settings
+    """
+    settings = configparser.ConfigParser()
+    fname = f'{os.getenv("HOME")}/.build-efi'
+    if not os.path.exists(fname):
+        print('No config file found ~/.build-efi\nCreating one...\n')
+        tools.write_file(fname, '''[build-efi]
+# Mount path for the temporary image
+mount_point = /mnt/test-efi
+
+# Image-output filename
+image_file = try.img
+
+# Set ubdir to the build directory where you build U-Boot out-of-tree
+# We avoid in-tree build because it gets confusing trying different builds
+build_dir = /tmp/b
+
+# Build the kernel with: make O=/tmp/kernel
+bzimage = /tmp/kernel/arch/x86/boot/bzImage
+
+# Place where OVMF-pure-efi.i386.fd etc. are kept
+efi_dir = .
+''', binary=False)
+    settings.read(fname)
+    return settings
+
+
+class BuildEfi:
+    """Class to collect together the various bits of state while running"""
+    def __init__(self, settings, args):
+        self.settings = settings
+        self.img = self.get_setting('image_file', 'try.img')
+        self.build_dir = self.get_setting("build_dir", '/tmp')
+        self.mnt = self.get_setting("mount_point", '/mnt/test-efi')
+        self.tmp = None
+        self.args = args
+
+    def get_setting(self, name, fallback=None):
+        """Get a setting by name
+
+        Args:
+            name (str): Name of setting to retrieve
+            fallback (str or None): Value to return if the setting is missing
+        """
+        return self.settings.get('build-efi', name, fallback=fallback)
+
+    def run_qemu(self, bitness, serial_only):
+        """Run QEMU
+
+        Args:
+            bitness (int): Bitness to use, 32 or 64
+            serial_only (bool): True to run without a display
+        """
+        extra = []
+        efi_dir = self.get_setting("efi_dir")
+        if bitness == 64:
+            qemu = 'qemu-system-x86_64'
+            bios = 'OVMF-pure-efi.x64.fd'
+        else:
+            qemu = 'qemu-system-i386'
+            bios = 'OVMF-pure-efi.i386.fd'
+        if serial_only:
+            extra = ['-display', 'none', '-serial', 'mon:stdio']
+            serial_msg = ' (Ctrl-a x to quit)'
+        else:
+            extra = ['-serial', 'mon:stdio']
+            serial_msg = ''
+        print(f'Running {qemu}{serial_msg}')
+
+        # Use 512MB since U-Boot EFI likes to have 256MB to play with
+        cmd = [qemu, '-bios', os.path.join(efi_dir), bios)]
+        cmd += '-m', '512'
+        cmd += '-drive', f'id=disk,file={self.img},if=none,format=raw'
+        cmd += '-device', 'ahci,id=ahci'
+        cmd += '-device', 'ide-hd,drive=disk,bus=ahci.0'
+        cmd += '-nic', 'none'
+        cmd += extra
+        command.run(*cmd)
+
+    def setup_files(self, build, build_type):
+        """Set up files in the staging area
+
+        Args:
+            build (str): Name of build being packaged, e.g. 'efi-x86_app32'
+            build_type (str): Build type ('app' or 'payload')
+        """
+        print(f'Packaging {build}')
+        if not os.path.exists(self.tmp):
+            os.mkdir(self.tmp)
+        fname = f'u-boot-{build_type}.efi'
+        tools.write_file(f'{self.tmp}/startup.nsh', f'fs0:{fname}',
+                         binary=False)
+        shutil.copy(f'{self.build_dir}/{build}/{fname}', self.tmp)
+
+    def copy_files(self):
+        """Copy files into the filesystem"""
+        command.run('sudo', 'cp', *glob.glob(f'{self.tmp}/*'), self.mnt)
+        if self.args.kernel:
+            bzimage = self.get_setting('bzimage_file', 'bzImage')
+            command.run('sudo', 'cp', bzimage, f'{self.mnt}/vmlinuz')
+
+    def setup_raw(self):
+        """Create a filesystem on a raw device and copy in the files"""
+        command.output('mkfs.vfat', self.img)
+        command.run('sudo', 'mount', '-o', 'loop', self.img, self.mnt)
+        self.copy_files()
+        command.run('sudo', 'umount', self.mnt)
+
+    def setup_part(self):
+        """Set up a partition table
+
+        Create a partition table and put the filesystem in the first partition
+        then copy in the files
+        """
+
+        # Create a gpt partition table with one partition
+        command.run('parted', self.img, 'mklabel', 'gpt', capture_stderr=True)
+
+        # This doesn't work correctly. It creates:
+        # Number  Start   End     Size    File system  Name  Flags
+        #  1      1049kB  24.1MB  23.1MB               boot  msftdata
+        # Odd if the same is entered interactively it does set the FS type
+        command.run('parted', '-s', '-a', 'optimal', '--',
+                    self.img, 'mkpart', 'boot', 'fat32', '1MiB', '23MiB')
+
+        # Map this partition to a loop device. Output is something like:
+        # add map loop48p1 (252:3): 0 45056 linear 7:48 2048
+        out = command.output('sudo', 'kpartx', '-av', self.img)
+        m = re.search(r'(loop.*p.)', out)
+        if not m:
+            raise ValueError(f'Invalid output from kpartx: {out}')
+
+        boot_dev = m.group(1)
+        dev = f'/dev/mapper/{boot_dev}'
+
+        command.output('mkfs.vfat', dev)
+
+        command.run('sudo', 'mount', '-o', 'loop', dev, self.mnt)
+
+        try:
+            self.copy_files()
+        finally:
+            # Sync here since this makes kpartx more likely to work the first time
+            command.run('sync')
+            command.run('sudo', 'umount', self.mnt)
+
+            # For some reason this needs a sleep or it sometimes fails, if it was
+            # run recently (in the last few seconds)
+            try:
+                cmd = 'sudo', 'kpartx', '-d', self.img
+                command.output(*cmd)
+            except command.CommandExc:
+                time.sleep(0.5)
+                command.output(*cmd)
+
+    def start(self):
+        """This does all the work"""
+        args = self.args
+        bitness = 32 if args.word else 64
+        build_type = 'payload' if args.payload else 'app'
+        self.tmp = f'{self.build_dir}/efi{bitness}{build_type}'
+        build = f'efi-x86_{build_type}{bitness}'
+
+        if args.old and bitness == 32:
+            build = f'efi-x86_{build_type}'
+
+        self.setup_files(build, build_type)
+
+        command.output('qemu-img', 'create', self.img, '24M')
+
+        if args.partition:
+            self.setup_part()
+        else:
+            self.setup_raw()
+
+        if args.run:
+            self.run_qemu(bitness, args.serial)
+
+
+if __name__ == "__main__":
+    efi = BuildEfi(get_settings(), parse_args())
+    efi.start()
diff --git a/scripts/build-efi.sh b/scripts/build-efi.sh
deleted file mode 100755
index 6b7df2e9bfe..00000000000
--- a/scripts/build-efi.sh
+++ /dev/null
@@ -1,207 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Script to build an EFI thing suitable for booting with QEMU, possibly running
-# it also.
-
-# This just an example. It assumes that
-
-# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board config
-# - /mnt/x is a directory used for mounting
-# - you have access to the 'pure UEFI' builds for QEMU
-#
-# UEFI binaries for QEMU used for testing this script:
-#
-# OVMF-pure-efi.i386.fd at
-# https://drive.google.com/file/d/1jWzOAZfQqMmS2_dAK2G518GhIgj9r2RY/view?usp=sharing
-
-# OVMF-pure-efi.x64.fd at
-# https://drive.google.com/file/d/1c39YI9QtpByGQ4V0UNNQtGqttEzS-eFV/view?usp=sharing
-
-bzimage_fname=/tmp/kernel/arch/x86/boot/bzImage
-
-set -e
-
-usage() {
-	echo "Usage: $0 [-a | -p] [other opts]" 1>&2
-	echo 1>&2
-	echo "   -a   - Package up the app" 1>&2
-	echo "   -k   - Add a kernel" 1>&2
-	echo "   -o   - Use old EFI app build (before 32/64 split)" 1>&2
-	echo "   -p   - Package up the payload" 1>&2
-	echo "   -P   - Create a partition table" 1>&2
-	echo "   -r   - Run QEMU with the image" 1>&2
-	echo "   -s   - Run QEMU with serial only (no display)" 1>&2
-	echo "   -w   - Use word version (32-bit)" 1>&2
-	exit 1
-}
-
-# 32- or 64-bit EFI
-bitness=64
-
-# app or payload ?
-type=app
-
-# create a partition table and put the filesystem in that (otherwise put the
-# filesystem in the raw device)
-part=
-
-# run the image with QEMU
-run=
-
-# run QEMU without a display (U-Boot must be set to stdout=serial)
-serial=
-
-# before the 32/64 split of the app
-old=
-
-# package up a kernel as well
-kernel=
-
-# Set ubdir to the build directory where you build U-Boot out-of-tree
-# We avoid in-tree build because it gets confusing trying different builds
-ubdir=/tmp/b/
-
-while getopts "akopPrsw" opt; do
-	case "${opt}" in
-	a)
-		type=app
-		;;
-	p)
-		type=payload
-		;;
-	k)
-		kernel=1
-		;;
-	r)
-		run=1
-		;;
-	s)
-		serial=1
-		;;
-	w)
-		bitness=32
-		;;
-	o)
-		old=1
-		;;
-	P)
-		part=1
-		;;
-	*)
-		usage
-		;;
-	esac
-done
-
-run_qemu() {
-	extra=
-	if [[ "${bitness}" = "64" ]]; then
-		qemu=qemu-system-x86_64
-		bios=OVMF-pure-efi.x64.fd
-	else
-		qemu=qemu-system-i386
-		bios=OVMF-pure-efi.i386.fd
-	fi
-	if [[ -n "${serial}" ]]; then
-		extra="-display none -serial mon:stdio"
-	else
-		extra="-serial mon:stdio"
-	fi
-	echo "Running ${qemu}"
-	# Use 512MB since U-Boot EFI likes to have 256MB to play with
-	"${qemu}" -bios "${bios}" \
-		-m 512 \
-		-drive id=disk,file="${IMG}",if=none,format=raw \
-		-nic none -device ahci,id=ahci \
-		-device ide-hd,drive=disk,bus=ahci.0 ${extra}
-}
-
-setup_files() {
-	echo "Packaging ${BUILD}"
-	mkdir -p $TMP
-	cat >$TMP/startup.nsh <<EOF
-fs0:u-boot-${type}.efi
-EOF
-	sudo cp ${ubdir}/${BUILD}/u-boot-${type}.efi $TMP
-
-	# Can copy in other files here:
-	#sudo cp ${ubdir}/$BUILD/image.bin $TMP/chromeos.rom
-	#sudo cp /boot/vmlinuz-5.4.0-77-generic $TMP/vmlinuz
-}
-
-# Copy files into the filesystem
-copy_files() {
-	sudo cp $TMP/* $MNT
-	if [[ -n "${kernel}" ]]; then
-		sudo cp ${bzimage_fname} $MNT/vmlinuz
-	fi
-}
-
-# Create a filesystem on a raw device and copy in the files
-setup_raw() {
-	mkfs.vfat "${IMG}" >/dev/null
-	sudo mount -o loop "${IMG}" $MNT
-	copy_files
-	sudo umount $MNT
-}
-
-# Create a partition table and put the filesystem in the first partition
-# then copy in the files
-setup_part() {
-	# Create a gpt partition table with one partition
-	parted "${IMG}" mklabel gpt 2>/dev/null
-
-	# This doesn't work correctly. It creates:
-	# Number  Start   End     Size    File system  Name  Flags
-	#  1      1049kB  24.1MB  23.1MB               boot  msftdata
-	# Odd if the same is entered interactively it does set the FS type
-	parted -s -a optimal -- "${IMG}" mkpart boot fat32 1MiB 23MiB
-
-	# Map this partition to a loop device
-	kp="$(sudo kpartx -av ${IMG})"
-	read boot_dev<<<$(grep -o 'loop.*p.' <<< "${kp}")
-	test "${boot_dev}"
-	dev="/dev/mapper/${boot_dev}"
-
-	mkfs.vfat "${dev}" >/dev/null
-
-	sudo mount -o loop "${dev}" $MNT
-
-	copy_files
-
-	# Sync here since this makes kpartx more likely to work the first time
-	sync
-	sudo umount $MNT
-
-	# For some reason this needs a sleep or it sometimes fails, if it was
-	# run recently (in the last few seconds)
-	if ! sudo kpartx -d "${IMG}" > /dev/null; then
-		sleep .5
-		sudo kpartx -d "${IMG}" > /dev/null || \
-			echo "Failed to remove ${boot_dev}, use: sudo kpartx -d ${IMG}"
-	fi
-}
-
-TMP="/tmp/efi${bitness}${type}"
-MNT=/mnt/x
-BUILD="efi-x86_${type}${bitness}"
-IMG=try.img
-
-if [[ -n "${old}" && "${bitness}" = "32" ]]; then
-	BUILD="efi-x86_${type}"
-fi
-
-setup_files
-
-qemu-img create "${IMG}" 24M >/dev/null
-
-if [[ -n "${part}" ]]; then
-	setup_part
-else
-	setup_raw
-fi
-
-if [[ -n "${run}" ]]; then
-	run_qemu
-fi
-- 
2.43.0

