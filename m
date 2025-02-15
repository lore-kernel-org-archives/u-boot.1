Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F84AC021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 13:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A416680C6F;
	Sat, 15 Feb 2025 14:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WjcPgXWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD0B80C98; Sat, 15 Feb 2025 14:38:30 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E35A080756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 14:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ab7e1286126so513204666b.0
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 05:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739626707; x=1740231507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mkuhNqS1FDVZKzzgsg3Uycr4FZjGMWvI746hHQfmt1M=;
 b=WjcPgXWVn/2E+91sTHno6xp/pkoGGScS4n1yK+/qryQ0Ym7t64V/ksh32FXw3Bb8Ir
 G6XTOEkWkNdQhR/Z0/6DW5WMPySOkrUmQDO4aTgw22iwWxPl9TQC9OAc1KKrlUNqR9fL
 jxvFEGvERPpdBz/hdORSyT4EzS29uf9WOpDwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739626707; x=1740231507;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mkuhNqS1FDVZKzzgsg3Uycr4FZjGMWvI746hHQfmt1M=;
 b=sIDXKG3o/C4ivySoHGOSQyZMcdxdb/h7T8Etrq/UN/hBvl1zMMGsEicbXyaYbs2wdE
 ouQfXpAP15d9Sp/fBeYz0NY60rwxEDRC8K/hTQwnR0JMrs/vLt4+2f4w0iuFs0B2C895
 npku2g7OoY3gCvpw7l4WDFAesYUuHx+Hv/oeI44GzfYBh08t2ciz8douyVgwOtf58f3g
 C5uQhruxr7jwZR8/m5bmAPYst1nFAxN6/2YyFuk+SJP/kDcR9fqOLAlFoFBhFQNMDEN/
 CNTac0tNb51UvPCD4mMG6b6kkxWDvy39cS4p4/2I2NZsHaHX/hiEPnqbc2y4XqxSzChi
 T4wg==
X-Gm-Message-State: AOJu0Ywba3ysECdVxZx6gFyvzvbeGvvdoYz59S5wazZE7AbTDgGqk5Ms
 ReHll9o3jfu1ZG9vLGUpjAwzT6VLe2Z/bmzDYt3PXRmb4XViQFngMh+CITp2/s0gJ7jv/jb+a7q
 B4VsSyp4OFN/lLnAN4BgZoifQAdVudUwo2zLNMNa+/n5zVEY=
X-Gm-Gg: ASbGncvTja9SxK8AIoh+L3MLVvzUd8RS3/fAviQzq/giNW9vhuSLqOUPJaAOitAB1Ia
 gxwk/3hgCR5zmddN2z059tLoPde0zhE6qYn9DamjX3YB10mKRwk2GqDLtnH9bAAFoePU6DpVZKw
 ==
X-Google-Smtp-Source: AGHT+IGB+AQqhCLeJueYmmV8pBP8KY48txy/H18uAJ+lCRaXeuTKL/3kYEHQ0GNSpge9VErWfOdDxDhVrztoFRep09I=
X-Received: by 2002:a17:906:54c:b0:ab7:c3c9:2ab1 with SMTP id
 a640c23a62f3a-abb7112ef02mr237491566b.50.1739626707272; Sat, 15 Feb 2025
 05:38:27 -0800 (PST)
MIME-Version: 1.0
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
 <73BE9F0B-C407-4995-8E27-34E45518C67A@gmx.de>
In-Reply-To: <73BE9F0B-C407-4995-8E27-34E45518C67A@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 15 Feb 2025 06:38:15 -0700
X-Gm-Features: AWEUYZn6eRdLEXW9sTTLSB325xHRFl2fxQihFAyeV3nzO8n83ECkbPPyWolZdMo
Message-ID: <CAFLszThqve23Sv8E83jQkgCJ6MOaihT3P3Dstr_XLeRNQXS_fQ@mail.gmail.com>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Heinrich,

On Sun, 9 Feb 2025 at 11:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 3. Februar 2025 18:41:54 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >Before this gets any longer, convert it to Python so it is easier to
> >maintain.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > MAINTAINERS                        |   2 +-
> > doc/develop/uefi/u-boot_on_efi.rst |   4 +-
> > scripts/build-efi.py               | 258 +++++++++++++++++++++++++++++
> > scripts/build-efi.sh               | 207 -----------------------
> > 4 files changed, 261 insertions(+), 210 deletions(-)
> > create mode 100755 scripts/build-efi.py
> > delete mode 100755 scripts/build-efi.sh
> >
> >diff --git a/MAINTAINERS b/MAINTAINERS
> >index 9ba0c98cef2..a8e81577090 100644
> >--- a/MAINTAINERS
> >+++ b/MAINTAINERS
> >@@ -1072,7 +1072,7 @@ F:       doc/develop/uefi/u-boot_on_efi.rst
> > F:    drivers/block/efi-media-uclass.c
> > F:    drivers/block/sb_efi_media.c
> > F:    lib/efi/efi_app.c
> >-F:    scripts/build-efi.sh
> >+F:    scripts/build-efi.py
> > F:    test/dm/efi_media.c
> >
> > EFI LOGGING
> >diff --git a/doc/develop/uefi/u-boot_on_efi.rst b/doc/develop/uefi/u-boot_on_efi.rst
> >index 245b4af1fa3..9d441cdc2c5 100644
> >--- a/doc/develop/uefi/u-boot_on_efi.rst
> >+++ b/doc/develop/uefi/u-boot_on_efi.rst
> >@@ -96,7 +96,7 @@ that EFI does not support booting a 64-bit application from a 32-bit
> > EFI (or vice versa). Also it will often fail to print an error message if
> > you get this wrong.
> >
> >-You may find the script `scripts/build-efi.sh` helpful for building and testing
> >+You may find the script `scripts/build-efi.py` helpful for building and testing
> > U-Boot on UEFI on QEMU. It also includes links to UEFI binaries dating from
> > 2021.
> >
> >@@ -201,7 +201,7 @@ Example run
> >
> > This shows running with serial enabled (see `include/configs/efi-x86_app.h`)::
> >
> >-   $ scripts/build-efi.sh -wsPr
> >+   $ scripts/build-efi.py -wsPr
> >    Packaging efi-x86_app32
> >    Running qemu-system-i386
> >
> >diff --git a/scripts/build-efi.py b/scripts/build-efi.py
> >new file mode 100755
> >index 00000000000..495817bc064
> >--- /dev/null
> >+++ b/scripts/build-efi.py
> >@@ -0,0 +1,258 @@
> >+#!/usr/bin/env python
> >+# SPDX-License-Identifier: GPL-2.0+
> >+"""
> >+Script to build an EFI thing suitable for booting with QEMU, possibly running
> >+it also.
> >+
> >+UEFI binaries for QEMU used for testing this script:
> >+
> >+OVMF-pure-efi.i386.fd at
> >+https://drive.google.com/file/d/1jWzOAZfQqMmS2_dAK2G518GhIgj9r2RY/view?usp=sharing
> >+
> >+OVMF-pure-efi.x64.fd at
> >+https://drive.google.com/file/d/1c39YI9QtpByGQ4V0UNNQtGqttEzS-eFV/view?usp=sharing
>
> Who would dare to download binaries of unknown origin and execute these?
>
> The filenames do not match what is created by upstream EDK II.
>
> These references should be removed.
>
> Instead you could provide the EDK II version that you used for testing and the file name created by EDK II.

The idea is not to execute them natively, but under QEMU. What
filenames should be used? How can people get these files, if not
through a download link?

>
>
>
> >+
> >+Use ~/.build-efi to configure the various paths used by this script.
> >+"""
> >+
> >+from argparse import ArgumentParser
> >+import configparser
> >+import glob
> >+import os
> >+import re
> >+import shutil
> >+import sys
> >+import time
> >+
> >+
> >+OUR_PATH = os.path.dirname(os.path.realpath(__file__))
> >+OUR1_PATH = os.path.dirname(OUR_PATH)
> >+
> >+# Bring in the patman and dtoc libraries (but don't override the first path
> >+# in PYTHONPATH)
> >+sys.path.insert(2, os.path.join(OUR1_PATH, 'tools'))
> >+
> >+
> >+# pylint: disable=C0413
> >+from u_boot_pylib import command
> >+from u_boot_pylib import tools
> >+
> >+
> >+def parse_args():
> >+    """Parse the program arguments
> >+
> >+    Return:
> >+        Namespace object
> >+    """
> >+    parser = ArgumentParser(
> >+        epilog='Script for running U-Boot as an EFI app/payload')
> >+    parser.add_argument('-a', '--app', action='store_true',
> >+                        help='Package up the app')
> >+    parser.add_argument('-k', '--kernel', action='store_true',
> >+                        help='Add a kernel')
> >+    parser.add_argument('-o', '--old', action='store_true',
> >+                        help='Use old EFI app build (before 32/64 split)')
> >+    parser.add_argument('-p', '--payload', action='store_true',
> >+                        help='Package up the payload')
> >+    parser.add_argument('-P', '--partition', action='store_true',
> >+                        help='Create a partition table')
> >+    parser.add_argument('-r', '--run', action='store_true',
> >+                        help='Run QEMU with the image')
> >+    parser.add_argument('-s', '--serial', action='store_true',
> >+                        help='Run QEMU with serial only (no display)')
> >+    parser.add_argument('-w', '--word', action='store_true',
> >+                        help='Use word version (32-bit) rather than 64-bit')
> >+
> >+    args = parser.parse_args()
> >+
> >+    if args.app and args.payload:
> >+        raise ValueError('Please choose either app or payload, not both')
> >+    return args
> >+
> >+
> >+def get_settings():
> >+    """Get settings from the settings file
> >+
> >+    Return:
> >+        ConfigParser containing settings
> >+    """
> >+    settings = configparser.ConfigParser()
> >+    fname = f'{os.getenv("HOME")}/.build-efi'
> >+    if not os.path.exists(fname):
> >+        print('No config file found ~/.build-efi\nCreating one...\n')
> >+        tools.write_file(fname, '''[build-efi]
> >+# Mount path for the temporary image
> >+mount_point = /mnt/test-efi
> >+
> >+# Image-output filename
> >+image_file = try.img
> >+
> >+# Set ubdir to the build directory where you build U-Boot out-of-tree
> >+# We avoid in-tree build because it gets confusing trying different builds
> >+build_dir = /tmp/b
> >+
> >+# Build the kernel with: make O=/tmp/kernel
> >+bzimage = /tmp/kernel/arch/x86/boot/bzImage
> >+
> >+# Place where OVMF-pure-efi.i386.fd etc. are kept
>
> Is this i386 only? What would you use for arm64 and amd64?

Please can you check the series before responding to one patch? It is
very confusing when you add comments to one patch (the conversion to
Python) which are intended for another (adding ARM support).

>
> >+efi_dir = .
> >+''', binary=False)
> >+    settings.read(fname)
> >+    return settings
> >+
> >+
> >+class BuildEfi:
> >+    """Class to collect together the various bits of state while running"""
> >+    def __init__(self, settings, args):
> >+        self.settings = settings
> >+        self.img = self.get_setting('image_file', 'try.img')
> >+        self.build_dir = self.get_setting("build_dir", '/tmp')
> >+        self.mnt = self.get_setting("mount_point", '/mnt/test-efi')
> >+        self.tmp = None
> >+        self.args = args
> >+
> >+    def get_setting(self, name, fallback=None):
> >+        """Get a setting by name
> >+
> >+        Args:
> >+            name (str): Name of setting to retrieve
> >+            fallback (str or None): Value to return if the setting is missing
> >+        """
> >+        return self.settings.get('build-efi', name, fallback=fallback)
> >+
> >+    def run_qemu(self, bitness, serial_only):
> >+        """Run QEMU
> >+
> >+        Args:
> >+            bitness (int): Bitness to use, 32 or 64
> >+            serial_only (bool): True to run without a display
> >+        """
> >+        extra = []
> >+        efi_dir = self.get_setting("efi_dir")
> >+        if bitness == 64:
> >+            qemu = 'qemu-system-x86_64'
> >+            bios = 'OVMF-pure-efi.x64.fd'
>
> This is not a file name used by EDK II.
>
> And what about arm64?

It would help if you could indicate the name you want.

arm64 is in the next patch. This one just converts to Python.

>
> >+        else:
> >+            qemu = 'qemu-system-i386'
> >+            bios = 'OVMF-pure-efi.i386.fd'
> >+        if serial_only:
> >+            extra = ['-display', 'none', '-serial', 'mon:stdio']
> >+            serial_msg = ' (Ctrl-a x to quit)'
> >+        else:
> >+            extra = ['-serial', 'mon:stdio']
> >+            serial_msg = ''
> >+        print(f'Running {qemu}{serial_msg}')
> >+
> >+        # Use 512MB since U-Boot EFI likes to have 256MB to play with
> >+        cmd = [qemu, '-bios', os.path.join(efi_dir), bios)]
>
> For EDK II you should use pflash.
>
> >+        cmd += '-m', '512'
> >+        cmd += '-drive', f'id=disk,file={self.img},if=none,format=raw'
> >+        cmd += '-device', 'ahci,id=ahci'
> >+        cmd += '-device', 'ide-hd,drive=disk,bus=ahci.0'
>
> How outdated is this? Use virtio.
>
> >+        cmd += '-nic', 'none'
>
> Why none? Use virtio.
>
> >+        cmd += extra
> >+        command.run(*cmd)
> >+
> >+    def setup_files(self, build, build_type):
> >+        """Set up files in the staging area
> >+
> >+        Args:
> >+            build (str): Name of build being packaged, e.g. 'efi-x86_app32'
> >+            build_type (str): Build type ('app' or 'payload')
> >+        """
> >+        print(f'Packaging {build}')
> >+        if not os.path.exists(self.tmp):
> >+            os.mkdir(self.tmp)
> >+        fname = f'u-boot-{build_type}.efi'
> >+        tools.write_file(f'{self.tmp}/startup.nsh', f'fs0:{fname}',
> >+                         binary=False)
> >+        shutil.copy(f'{self.build_dir}/{build}/{fname}', self.tmp)
> >+
> >+    def copy_files(self):
> >+        """Copy files into the filesystem"""
> >+        command.run('sudo', 'cp', *glob.glob(f'{self.tmp}/*'), self.mnt)
> >+        if self.args.kernel:
> >+            bzimage = self.get_setting('bzimage_file', 'bzImage')
> >+            command.run('sudo', 'cp', bzimage, f'{self.mnt}/vmlinuz')
>
> Please, do not use sudo.
>
> You can create partitioned disks with files without falling back to sudo.

How do you do that? Do you mean like we do in test/py/ ?

[..]

Regards,
Simon
