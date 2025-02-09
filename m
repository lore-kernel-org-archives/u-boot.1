Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7555DC0219E
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 18:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9416803B5;
	Sun,  9 Feb 2025 19:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="WxTNRy+s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21930807D7; Sun,  9 Feb 2025 19:56:04 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAED4800B3
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 19:55:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1739127344; x=1739732144; i=xypron.glpk@gmx.de;
 bh=F0ZAr/E23c7fe8WHMuREvhT0lh2wNmQbMLdUqfgoLM0=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=WxTNRy+sF8ghQx8kfdc3CQyJO7tQduBGRTtZuWjvSaSotjlIQwtCIizkyLdSYBat
 wYE7Uv2F9F7VHXf1D/lIs/xsO7q5zQee0UFHvwdxWN1IK4pr9h4aN5pcznrsz30qb
 LdqyRzMIG98rj17doCV1iKEqD1DhQiVWeRZeQOJ1KKxRouQg96XB+PYf4bPrLxafQ
 l2b4tr/k83xc/oo/gw+a8befPrQPFOFc/DYxNSQSAFOOAqsEbzrA8hoM0CF+eUbOT
 /Ux4a7Cp0yvUNvqk2t/WaEgnQM5Bx86CFvwLX4lzNXv9uDON2MnMYdhq5qcZEsl0e
 B35JIq4AvHFqAAsAYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([46.114.104.145]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJE27-1txLVj1VaV-00Y51S; Sun, 09
 Feb 2025 19:55:44 +0100
Date: Sun, 09 Feb 2025 19:55:40 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 01/32] Convert build-efi script to Python
User-Agent: Thunderbird for Android
In-Reply-To: <20250203174245.1331464-2-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-2-sjg@chromium.org>
Message-ID: <73BE9F0B-C407-4995-8E27-34E45518C67A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q40y/Q1W24cypFPOu47OICRuwvG2cgJPvNXRgyG/4yQvo0NO5sR
 lX8wBSVabZkrmmk5Vje30htGzE9xF/KQ4ptzKmJHquy2aIGl/JRNNzszcuX/VwX9nhMe86C
 NO7+tY3uDaQGWekJcYiXxwuUzmU3xtcOAFnX/XwuJH6wZI62xTpi6cbCyMv40GCFlM2cT7t
 xIoaIPoNVmDLAxSSsOcVw==
UI-OutboundReport: notjunk:1;M01:P0:Loz0u2OlQKY=;891fDbMtKTPCRTLI2fBIcMJgcJ0
 RfmaXjYdDBHH2cmqdgGdYeKiII25xwYbIYuKinZv8vnbRI+c9Iwn/EvmJ8fQlrhswQm3jWdpP
 Qz6LgikMm5v49q00wmvVEIknOhxIpnHp31ps4PjacjEBgJ4wbhsa4ObpMUZSxiY1to3BJ9Ry8
 jJ4VaaHfpItgho4fXITq8Vecbsrtf5xoj4wgOGEZBi2/uzYu0vQPcEZe8nSdAlmabsRQDpNQL
 UGmXzS7KOcpZ8bUQeOlVjF7ndnB61fKs5T509ioDsYgevDZ6sbUByn+vKp3TMUCBD6gHcrawF
 kZ7SIxi2rDCQuq0HIDdEChq8I937i5KwPcTxSdHg4AUOpQ2L/wGFbSLBHuYP50v5AI20Mw2X9
 7KaFCfF8nQmMyQES3zkiGmkFoMieG1dROAq8eqzYmrSsQ8ZA8nQ5wEr7INRKSCIM6QF96H0as
 mI0WM2Y3bYO1876ey7O/8CQ7gHYszdALFaNCW6R3t/wrpJ12toM+YiW7eVfnQInUUIrJcbMQH
 1S+hNy+TLXATf5lGRksJjxbtiw89KaKpzhK9GM59WTbqKAsz/hJGBhux9oa0CSGCeZDg96XGs
 wiOYRIGYrEa2tVEAlm0ORPFWHnadQEYuXU2WkO1AlGrhcfTajR5rjZdcSBZKNg5fT/AQjQzmv
 8Z3USgm6Va1wOfI0ieuBnlUj+/+BJrGOeVU9LoikRJhgZG9w6lWmm0QPt4D0L8O429XXcXd/m
 hzZCQnzcsjs/0Zt8DXIWx6M7j+bFH/DCg5/Umi4nXo2+Vs8TC2QkJqYCaK3pi9tS86t8LCYCp
 m03wd9q6BUZJkRRDeVRpeTuY/9f0eWYZVDWMi0U9pnP8eL8hNkAXel6zuqVUF9oRvrxkwdSTC
 Bn73J+JKlR0MOSCBpVJF6lDTBtak6WYOAX2s2R9k9nb70ohgOvRKgtvnOyPDrfcEYkWtMw/Jw
 FlEhuoWLdkopm9ebdr7qdr6GdaJVOJ861rtE+Ip1s+JkAFaT7mE3Ay8EmjndEMRtEIvQ9L/Ga
 icdItno9Htq0tVVpqZv0aUUKtAPCZ6meHmgLgrX6jqTe+d0p+P+xrkwDXnU61YRiE8Wx0HHDC
 hNpO6gaK5qBzeObs6McbcOoDT9wrm4s+VKDOuMt/yklW2IEMDDGdxFUk8E37m0QGe6eb0L0iv
 vAQPSIIVSXWyvMgvH4gER3tL6MIQc1gMw8AG+E64pv8pZT8L0aWEU7IGaHysSylsIQY9nC8fQ
 1cLKfd4cWWYrmxEtjXouuGy0AkwlKvSkUkLxTzMvoTCb8SbWRoccUXGBdeEcyrvjDIpgc7M8n
 /jCUUVVLHR5u2F7M4aLwcOnElsaoZzWQw93QOAitRUxuNvS0bk3PK/tPUx8LZtCIJpqTlY9Ev
 xAkLM6OBS9sJHsGzG54NnR0W99o2llzhz6XrcHu4K8mARF87yui965lwByHgiiEF4YsFYNPsS
 eAqFpIQ==
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

Am 3=2E Februar 2025 18:41:54 MEZ schrieb Simon Glass <sjg@chromium=2Eorg>:
>Before this gets any longer, convert it to Python so it is easier to
>maintain=2E
>
>Signed-off-by: Simon Glass <sjg@chromium=2Eorg>
>---
>
> MAINTAINERS                        |   2 +-
> doc/develop/uefi/u-boot_on_efi=2Erst |   4 +-
> scripts/build-efi=2Epy               | 258 +++++++++++++++++++++++++++++
> scripts/build-efi=2Esh               | 207 -----------------------
> 4 files changed, 261 insertions(+), 210 deletions(-)
> create mode 100755 scripts/build-efi=2Epy
> delete mode 100755 scripts/build-efi=2Esh
>
>diff --git a/MAINTAINERS b/MAINTAINERS
>index 9ba0c98cef2=2E=2Ea8e81577090 100644
>--- a/MAINTAINERS
>+++ b/MAINTAINERS
>@@ -1072,7 +1072,7 @@ F:	doc/develop/uefi/u-boot_on_efi=2Erst
> F:	drivers/block/efi-media-uclass=2Ec
> F:	drivers/block/sb_efi_media=2Ec
> F:	lib/efi/efi_app=2Ec
>-F:	scripts/build-efi=2Esh
>+F:	scripts/build-efi=2Epy
> F:	test/dm/efi_media=2Ec
>=20
> EFI LOGGING
>diff --git a/doc/develop/uefi/u-boot_on_efi=2Erst b/doc/develop/uefi/u-bo=
ot_on_efi=2Erst
>index 245b4af1fa3=2E=2E9d441cdc2c5 100644
>--- a/doc/develop/uefi/u-boot_on_efi=2Erst
>+++ b/doc/develop/uefi/u-boot_on_efi=2Erst
>@@ -96,7 +96,7 @@ that EFI does not support booting a 64-bit application =
from a 32-bit
> EFI (or vice versa)=2E Also it will often fail to print an error message=
 if
> you get this wrong=2E
>=20
>-You may find the script `scripts/build-efi=2Esh` helpful for building an=
d testing
>+You may find the script `scripts/build-efi=2Epy` helpful for building an=
d testing
> U-Boot on UEFI on QEMU=2E It also includes links to UEFI binaries dating=
 from
> 2021=2E
>=20
>@@ -201,7 +201,7 @@ Example run
>=20
> This shows running with serial enabled (see `include/configs/efi-x86_app=
=2Eh`)::
>=20
>-   $ scripts/build-efi=2Esh -wsPr
>+   $ scripts/build-efi=2Epy -wsPr
>    Packaging efi-x86_app32
>    Running qemu-system-i386
>=20
>diff --git a/scripts/build-efi=2Epy b/scripts/build-efi=2Epy
>new file mode 100755
>index 00000000000=2E=2E495817bc064
>--- /dev/null
>+++ b/scripts/build-efi=2Epy
>@@ -0,0 +1,258 @@
>+#!/usr/bin/env python
>+# SPDX-License-Identifier: GPL-2=2E0+
>+"""
>+Script to build an EFI thing suitable for booting with QEMU, possibly ru=
nning
>+it also=2E
>+
>+UEFI binaries for QEMU used for testing this script:
>+
>+OVMF-pure-efi=2Ei386=2Efd at
>+https://drive=2Egoogle=2Ecom/file/d/1jWzOAZfQqMmS2_dAK2G518GhIgj9r2RY/vi=
ew?usp=3Dsharing
>+
>+OVMF-pure-efi=2Ex64=2Efd at
>+https://drive=2Egoogle=2Ecom/file/d/1c39YI9QtpByGQ4V0UNNQtGqttEzS-eFV/vi=
ew?usp=3Dsharing

Who would dare to download binaries of unknown origin and execute these?

The filenames do not match what is created by upstream EDK II=2E

These references should be removed=2E

Instead you could provide the EDK II version that you used for testing and=
 the file name created by EDK II=2E



>+
>+Use ~/=2Ebuild-efi to configure the various paths used by this script=2E
>+"""
>+
>+from argparse import ArgumentParser
>+import configparser
>+import glob
>+import os
>+import re
>+import shutil
>+import sys
>+import time
>+
>+
>+OUR_PATH =3D os=2Epath=2Edirname(os=2Epath=2Erealpath(__file__))
>+OUR1_PATH =3D os=2Epath=2Edirname(OUR_PATH)
>+
>+# Bring in the patman and dtoc libraries (but don't override the first p=
ath
>+# in PYTHONPATH)
>+sys=2Epath=2Einsert(2, os=2Epath=2Ejoin(OUR1_PATH, 'tools'))
>+
>+
>+# pylint: disable=3DC0413
>+from u_boot_pylib import command
>+from u_boot_pylib import tools
>+
>+
>+def parse_args():
>+    """Parse the program arguments
>+
>+    Return:
>+        Namespace object
>+    """
>+    parser =3D ArgumentParser(
>+        epilog=3D'Script for running U-Boot as an EFI app/payload')
>+    parser=2Eadd_argument('-a', '--app', action=3D'store_true',
>+                        help=3D'Package up the app')
>+    parser=2Eadd_argument('-k', '--kernel', action=3D'store_true',
>+                        help=3D'Add a kernel')
>+    parser=2Eadd_argument('-o', '--old', action=3D'store_true',
>+                        help=3D'Use old EFI app build (before 32/64 spli=
t)')
>+    parser=2Eadd_argument('-p', '--payload', action=3D'store_true',
>+                        help=3D'Package up the payload')
>+    parser=2Eadd_argument('-P', '--partition', action=3D'store_true',
>+                        help=3D'Create a partition table')
>+    parser=2Eadd_argument('-r', '--run', action=3D'store_true',
>+                        help=3D'Run QEMU with the image')
>+    parser=2Eadd_argument('-s', '--serial', action=3D'store_true',
>+                        help=3D'Run QEMU with serial only (no display)')
>+    parser=2Eadd_argument('-w', '--word', action=3D'store_true',
>+                        help=3D'Use word version (32-bit) rather than 64=
-bit')
>+
>+    args =3D parser=2Eparse_args()
>+
>+    if args=2Eapp and args=2Epayload:
>+        raise ValueError('Please choose either app or payload, not both'=
)
>+    return args
>+
>+
>+def get_settings():
>+    """Get settings from the settings file
>+
>+    Return:
>+        ConfigParser containing settings
>+    """
>+    settings =3D configparser=2EConfigParser()
>+    fname =3D f'{os=2Egetenv("HOME")}/=2Ebuild-efi'
>+    if not os=2Epath=2Eexists(fname):
>+        print('No config file found ~/=2Ebuild-efi\nCreating one=2E=2E=
=2E\n')
>+        tools=2Ewrite_file(fname, '''[build-efi]
>+# Mount path for the temporary image
>+mount_point =3D /mnt/test-efi
>+
>+# Image-output filename
>+image_file =3D try=2Eimg
>+
>+# Set ubdir to the build directory where you build U-Boot out-of-tree
>+# We avoid in-tree build because it gets confusing trying different buil=
ds
>+build_dir =3D /tmp/b
>+
>+# Build the kernel with: make O=3D/tmp/kernel
>+bzimage =3D /tmp/kernel/arch/x86/boot/bzImage
>+
>+# Place where OVMF-pure-efi=2Ei386=2Efd etc=2E are kept

Is this i386 only? What would you use for arm64 and amd64?

>+efi_dir =3D =2E
>+''', binary=3DFalse)
>+    settings=2Eread(fname)
>+    return settings
>+
>+
>+class BuildEfi:
>+    """Class to collect together the various bits of state while running=
"""
>+    def __init__(self, settings, args):
>+        self=2Esettings =3D settings
>+        self=2Eimg =3D self=2Eget_setting('image_file', 'try=2Eimg')
>+        self=2Ebuild_dir =3D self=2Eget_setting("build_dir", '/tmp')
>+        self=2Emnt =3D self=2Eget_setting("mount_point", '/mnt/test-efi'=
)
>+        self=2Etmp =3D None
>+        self=2Eargs =3D args
>+
>+    def get_setting(self, name, fallback=3DNone):
>+        """Get a setting by name
>+
>+        Args:
>+            name (str): Name of setting to retrieve
>+            fallback (str or None): Value to return if the setting is mi=
ssing
>+        """
>+        return self=2Esettings=2Eget('build-efi', name, fallback=3Dfallb=
ack)
>+
>+    def run_qemu(self, bitness, serial_only):
>+        """Run QEMU
>+
>+        Args:
>+            bitness (int): Bitness to use, 32 or 64
>+            serial_only (bool): True to run without a display
>+        """
>+        extra =3D []
>+        efi_dir =3D self=2Eget_setting("efi_dir")
>+        if bitness =3D=3D 64:
>+            qemu =3D 'qemu-system-x86_64'
>+            bios =3D 'OVMF-pure-efi=2Ex64=2Efd'

This is not a file name used by EDK II=2E

And what about arm64?

>+        else:
>+            qemu =3D 'qemu-system-i386'
>+            bios =3D 'OVMF-pure-efi=2Ei386=2Efd'
>+        if serial_only:
>+            extra =3D ['-display', 'none', '-serial', 'mon:stdio']
>+            serial_msg =3D ' (Ctrl-a x to quit)'
>+        else:
>+            extra =3D ['-serial', 'mon:stdio']
>+            serial_msg =3D ''
>+        print(f'Running {qemu}{serial_msg}')
>+
>+        # Use 512MB since U-Boot EFI likes to have 256MB to play with
>+        cmd =3D [qemu, '-bios', os=2Epath=2Ejoin(efi_dir), bios)]

For EDK II you should use pflash=2E

>+        cmd +=3D '-m', '512'
>+        cmd +=3D '-drive', f'id=3Ddisk,file=3D{self=2Eimg},if=3Dnone,for=
mat=3Draw'
>+        cmd +=3D '-device', 'ahci,id=3Dahci'
>+        cmd +=3D '-device', 'ide-hd,drive=3Ddisk,bus=3Dahci=2E0'

How outdated is this? Use virtio=2E

>+        cmd +=3D '-nic', 'none'

Why none? Use virtio=2E

>+        cmd +=3D extra
>+        command=2Erun(*cmd)
>+
>+    def setup_files(self, build, build_type):
>+        """Set up files in the staging area
>+
>+        Args:
>+            build (str): Name of build being packaged, e=2Eg=2E 'efi-x86=
_app32'
>+            build_type (str): Build type ('app' or 'payload')
>+        """
>+        print(f'Packaging {build}')
>+        if not os=2Epath=2Eexists(self=2Etmp):
>+            os=2Emkdir(self=2Etmp)
>+        fname =3D f'u-boot-{build_type}=2Eefi'
>+        tools=2Ewrite_file(f'{self=2Etmp}/startup=2Ensh', f'fs0:{fname}'=
,
>+                         binary=3DFalse)
>+        shutil=2Ecopy(f'{self=2Ebuild_dir}/{build}/{fname}', self=2Etmp)
>+
>+    def copy_files(self):
>+        """Copy files into the filesystem"""
>+        command=2Erun('sudo', 'cp', *glob=2Eglob(f'{self=2Etmp}/*'), sel=
f=2Emnt)
>+        if self=2Eargs=2Ekernel:
>+            bzimage =3D self=2Eget_setting('bzimage_file', 'bzImage')
>+            command=2Erun('sudo', 'cp', bzimage, f'{self=2Emnt}/vmlinuz'=
)

Please, do not use sudo=2E

You can create partitioned disks with files without falling back to sudo=
=2E

Best regards

Heinrich

>+
>+    def setup_raw(self):
>+        """Create a filesystem on a raw device and copy in the files"""
>+        command=2Eoutput('mkfs=2Evfat', self=2Eimg)
>+        command=2Erun('sudo', 'mount', '-o', 'loop', self=2Eimg, self=2E=
mnt)
>+        self=2Ecopy_files()
>+        command=2Erun('sudo', 'umount', self=2Emnt)
>+
>+    def setup_part(self):
>+        """Set up a partition table
>+
>+        Create a partition table and put the filesystem in the first par=
tition
>+        then copy in the files
>+        """
>+
>+        # Create a gpt partition table with one partition
>+        command=2Erun('parted', self=2Eimg, 'mklabel', 'gpt', capture_st=
derr=3DTrue)
>+
>+        # This doesn't work correctly=2E It creates:
>+        # Number  Start   End     Size    File system  Name  Flags
>+        #  1      1049kB  24=2E1MB  23=2E1MB               boot  msftdat=
a
>+        # Odd if the same is entered interactively it does set the FS ty=
pe
>+        command=2Erun('parted', '-s', '-a', 'optimal', '--',
>+                    self=2Eimg, 'mkpart', 'boot', 'fat32', '1MiB', '23Mi=
B')
>+
>+        # Map this partition to a loop device=2E Output is something lik=
e:
>+        # add map loop48p1 (252:3): 0 45056 linear 7:48 2048
>+        out =3D command=2Eoutput('sudo', 'kpartx', '-av', self=2Eimg)
>+        m =3D re=2Esearch(r'(loop=2E*p=2E)', out)
>+        if not m:
>+            raise ValueError(f'Invalid output from kpartx: {out}')
>+
>+        boot_dev =3D m=2Egroup(1)
>+        dev =3D f'/dev/mapper/{boot_dev}'
>+
>+        command=2Eoutput('mkfs=2Evfat', dev)
>+
>+        command=2Erun('sudo', 'mount', '-o', 'loop', dev, self=2Emnt)
>+
>+        try:
>+            self=2Ecopy_files()
>+        finally:
>+            # Sync here since this makes kpartx more likely to work the =
first time
>+            command=2Erun('sync')
>+            command=2Erun('sudo', 'umount', self=2Emnt)
>+
>+            # For some reason this needs a sleep or it sometimes fails, =
if it was
>+            # run recently (in the last few seconds)
>+            try:
>+                cmd =3D 'sudo', 'kpartx', '-d', self=2Eimg
>+                command=2Eoutput(*cmd)
>+            except command=2ECommandExc:
>+                time=2Esleep(0=2E5)
>+                command=2Eoutput(*cmd)
>+
>+    def start(self):
>+        """This does all the work"""
>+        args =3D self=2Eargs
>+        bitness =3D 32 if args=2Eword else 64
>+        build_type =3D 'payload' if args=2Epayload else 'app'
>+        self=2Etmp =3D f'{self=2Ebuild_dir}/efi{bitness}{build_type}'
>+        build =3D f'efi-x86_{build_type}{bitness}'
>+
>+        if args=2Eold and bitness =3D=3D 32:
>+            build =3D f'efi-x86_{build_type}'
>+
>+        self=2Esetup_files(build, build_type)
>+
>+        command=2Eoutput('qemu-img', 'create', self=2Eimg, '24M')
>+
>+        if args=2Epartition:
>+            self=2Esetup_part()
>+        else:
>+            self=2Esetup_raw()
>+
>+        if args=2Erun:
>+            self=2Erun_qemu(bitness, args=2Eserial)
>+
>+
>+if __name__ =3D=3D "__main__":
>+    efi =3D BuildEfi(get_settings(), parse_args())
>+    efi=2Estart()
>diff --git a/scripts/build-efi=2Esh b/scripts/build-efi=2Esh
>deleted file mode 100755
>index 6b7df2e9bfe=2E=2E00000000000
>--- a/scripts/build-efi=2Esh
>+++ /dev/null
>@@ -1,207 +0,0 @@
>-#!/bin/bash
>-# SPDX-License-Identifier: GPL-2=2E0+
>-#
>-# Script to build an EFI thing suitable for booting with QEMU, possibly =
running
>-# it also=2E
>-
>-# This just an example=2E It assumes that
>-
>-# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board=
 config
>-# - /mnt/x is a directory used for mounting
>-# - you have access to the 'pure UEFI' builds for QEMU
>-#
>-# UEFI binaries for QEMU used for testing this script:
>-#
>-# OVMF-pure-efi=2Ei386=2Efd at
>-# https://drive=2Egoogle=2Ecom/file/d/1jWzOAZfQqMmS2_dAK2G518GhIgj9r2RY/=
view?usp=3Dsharing
>-
>-# OVMF-pure-efi=2Ex64=2Efd at
>-# https://drive=2Egoogle=2Ecom/file/d/1c39YI9QtpByGQ4V0UNNQtGqttEzS-eFV/=
view?usp=3Dsharing
>-
>-bzimage_fname=3D/tmp/kernel/arch/x86/boot/bzImage
>-
>-set -e
>-
>-usage() {
>-	echo "Usage: $0 [-a | -p] [other opts]" 1>&2
>-	echo 1>&2
>-	echo "   -a   - Package up the app" 1>&2
>-	echo "   -k   - Add a kernel" 1>&2
>-	echo "   -o   - Use old EFI app build (before 32/64 split)" 1>&2
>-	echo "   -p   - Package up the payload" 1>&2
>-	echo "   -P   - Create a partition table" 1>&2
>-	echo "   -r   - Run QEMU with the image" 1>&2
>-	echo "   -s   - Run QEMU with serial only (no display)" 1>&2
>-	echo "   -w   - Use word version (32-bit)" 1>&2
>-	exit 1
>-}
>-
>-# 32- or 64-bit EFI
>-bitness=3D64
>-
>-# app or payload ?
>-type=3Dapp
>-
>-# create a partition table and put the filesystem in that (otherwise put=
 the
>-# filesystem in the raw device)
>-part=3D
>-
>-# run the image with QEMU
>-run=3D
>-
>-# run QEMU without a display (U-Boot must be set to stdout=3Dserial)
>-serial=3D
>-
>-# before the 32/64 split of the app
>-old=3D
>-
>-# package up a kernel as well
>-kernel=3D
>-
>-# Set ubdir to the build directory where you build U-Boot out-of-tree
>-# We avoid in-tree build because it gets confusing trying different buil=
ds
>-ubdir=3D/tmp/b/
>-
>-while getopts "akopPrsw" opt; do
>-	case "${opt}" in
>-	a)
>-		type=3Dapp
>-		;;
>-	p)
>-		type=3Dpayload
>-		;;
>-	k)
>-		kernel=3D1
>-		;;
>-	r)
>-		run=3D1
>-		;;
>-	s)
>-		serial=3D1
>-		;;
>-	w)
>-		bitness=3D32
>-		;;
>-	o)
>-		old=3D1
>-		;;
>-	P)
>-		part=3D1
>-		;;
>-	*)
>-		usage
>-		;;
>-	esac
>-done
>-
>-run_qemu() {
>-	extra=3D
>-	if [[ "${bitness}" =3D "64" ]]; then
>-		qemu=3Dqemu-system-x86_64
>-		bios=3DOVMF-pure-efi=2Ex64=2Efd
>-	else
>-		qemu=3Dqemu-system-i386
>-		bios=3DOVMF-pure-efi=2Ei386=2Efd
>-	fi
>-	if [[ -n "${serial}" ]]; then
>-		extra=3D"-display none -serial mon:stdio"
>-	else
>-		extra=3D"-serial mon:stdio"
>-	fi
>-	echo "Running ${qemu}"
>-	# Use 512MB since U-Boot EFI likes to have 256MB to play with
>-	"${qemu}" -bios "${bios}" \
>-		-m 512 \
>-		-drive id=3Ddisk,file=3D"${IMG}",if=3Dnone,format=3Draw \
>-		-nic none -device ahci,id=3Dahci \
>-		-device ide-hd,drive=3Ddisk,bus=3Dahci=2E0 ${extra}
>-}
>-
>-setup_files() {
>-	echo "Packaging ${BUILD}"
>-	mkdir -p $TMP
>-	cat >$TMP/startup=2Ensh <<EOF
>-fs0:u-boot-${type}=2Eefi
>-EOF
>-	sudo cp ${ubdir}/${BUILD}/u-boot-${type}=2Eefi $TMP
>-
>-	# Can copy in other files here:
>-	#sudo cp ${ubdir}/$BUILD/image=2Ebin $TMP/chromeos=2Erom
>-	#sudo cp /boot/vmlinuz-5=2E4=2E0-77-generic $TMP/vmlinuz
>-}
>-
>-# Copy files into the filesystem
>-copy_files() {
>-	sudo cp $TMP/* $MNT
>-	if [[ -n "${kernel}" ]]; then
>-		sudo cp ${bzimage_fname} $MNT/vmlinuz
>-	fi
>-}
>-
>-# Create a filesystem on a raw device and copy in the files
>-setup_raw() {
>-	mkfs=2Evfat "${IMG}" >/dev/null
>-	sudo mount -o loop "${IMG}" $MNT
>-	copy_files
>-	sudo umount $MNT
>-}
>-
>-# Create a partition table and put the filesystem in the first partition
>-# then copy in the files
>-setup_part() {
>-	# Create a gpt partition table with one partition
>-	parted "${IMG}" mklabel gpt 2>/dev/null
>-
>-	# This doesn't work correctly=2E It creates:
>-	# Number  Start   End     Size    File system  Name  Flags
>-	#  1      1049kB  24=2E1MB  23=2E1MB               boot  msftdata
>-	# Odd if the same is entered interactively it does set the FS type
>-	parted -s -a optimal -- "${IMG}" mkpart boot fat32 1MiB 23MiB
>-
>-	# Map this partition to a loop device
>-	kp=3D"$(sudo kpartx -av ${IMG})"
>-	read boot_dev<<<$(grep -o 'loop=2E*p=2E' <<< "${kp}")
>-	test "${boot_dev}"
>-	dev=3D"/dev/mapper/${boot_dev}"
>-
>-	mkfs=2Evfat "${dev}" >/dev/null
>-
>-	sudo mount -o loop "${dev}" $MNT
>-
>-	copy_files
>-
>-	# Sync here since this makes kpartx more likely to work the first time
>-	sync
>-	sudo umount $MNT
>-
>-	# For some reason this needs a sleep or it sometimes fails, if it was
>-	# run recently (in the last few seconds)
>-	if ! sudo kpartx -d "${IMG}" > /dev/null; then
>-		sleep =2E5
>-		sudo kpartx -d "${IMG}" > /dev/null || \
>-			echo "Failed to remove ${boot_dev}, use: sudo kpartx -d ${IMG}"
>-	fi
>-}
>-
>-TMP=3D"/tmp/efi${bitness}${type}"
>-MNT=3D/mnt/x
>-BUILD=3D"efi-x86_${type}${bitness}"
>-IMG=3Dtry=2Eimg
>-
>-if [[ -n "${old}" && "${bitness}" =3D "32" ]]; then
>-	BUILD=3D"efi-x86_${type}"
>-fi
>-
>-setup_files
>-
>-qemu-img create "${IMG}" 24M >/dev/null
>-
>-if [[ -n "${part}" ]]; then
>-	setup_part
>-else
>-	setup_raw
>-fi
>-
>-if [[ -n "${run}" ]]; then
>-	run_qemu
>-fi

