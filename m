Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B505FC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D671838DF;
	Wed, 28 May 2025 14:33:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GDVermcr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3467A839CB; Wed, 28 May 2025 14:33:29 +0200 (CEST)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC020838DF
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:33:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso4773631b3a.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435602; x=1749040402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uMCotNfLaBgeytXJNMEFT75AWX6YBbiCeHWHYwOZSs=;
 b=GDVermcrV1v7t32ZQdlEXVfFeK2j9c6xULJCHLaG1oqvy+JdgGtNpPAvc4RsABMKQp
 rvRy6rjK5kNKQrMkSQS8uLSglwjXW1uHMcDv1Pm1MzK0MCjFnenQkUyWRmYMZwVZ1dyv
 glkZG4iZ+yPGZcWQSwg1kZ2TUgN2zbsjfVlWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435602; x=1749040402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uMCotNfLaBgeytXJNMEFT75AWX6YBbiCeHWHYwOZSs=;
 b=FgNRhhXbGmuAg90YGQDFfTGd5cJziXt8iEIZOVlwq+W+wzVT99WpA52Ujv5cRodlke
 k2meHzCVm/QaBPQhA4BZ21YLJyC6kgQxAeWCmWIGwTua/cXLlBGclSZjgg41zG/DjxPC
 019cHXx4YF3co41RObULyq2HSEnN5RVyLC0xc7wphehC5wIWVOBDm0MMES7d2dFC+rg/
 YKvschYP6kVdVdlG7SgwY37ZGTrIB6BU4D7jB1fXJe5gArD7xoO3AGAL7zQm6Tu8AELg
 Vf8WCOcMuAVmxB6VTNG1x1/EkzK/uMBaDwgWSii1uYp+5/Ddm27MzG6QE+6TghGhiCvf
 XgCw==
X-Gm-Message-State: AOJu0YyjxN3kH7hfalAk4n8EdQq415OA7L5tvnduBZtn9+oNskV+do3v
 /5gcodjV+GwiFFBpQ/550SJ4aWehr721Fgo2eqiMjx4QeDWrgW3/+HxSkH4WzFtqJ1RvwW32T8V
 7xuawblyqqz8=
X-Gm-Gg: ASbGncsGiyew/SNMLmA3MqX6rlmgFgozY7him7lITOAes0yps6YwUvaDvf7yvJ81L6i
 jzsKwwQEsXqGXHC7gVq20upNyCJIWq8o+RCL468op7MFnuYI2/LBMN8YoOSvu+r147G4X1Bh8u8
 nAia1Xr9A5eCQLAmrT4u/84bdSGjP5xBNEZujriahFtQYnK+Wf8qwP5L2AXa4Gu/8s7keGoaZGE
 9iwKMJXUOW9x5iA1hF87u++d7PdgDaC2B8fzq+e3yKxrKvCXrTsUIGXYRWQPrV38gl/hgjdaV56
 e7ispYoqZIoljnbnbbyX35HOoScp+6AKwFXeE2KYK97IUwAcvENkcpDQNMOL7pn8n5qtLt5J1y/
 PLtbhzZf2Z320
X-Google-Smtp-Source: AGHT+IGGiicDk2ZPnEAd2Q4mqAg+adfUsZsiLCQKaJGGJs27rp+BRscXToGg7MqYNWrrz7Mv+WPGag==
X-Received: by 2002:a05:6602:b94:b0:85b:5494:5519 with SMTP id
 ca18e2360f4ac-86cbb7e4a20mr1678565439f.5.1748435590725; 
 Wed, 28 May 2025 05:33:10 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.33.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:33:10 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 01/25] RFC: scripts: Add scripts for running QEMU
Date: Wed, 28 May 2025 06:32:03 -0600
Message-ID: <20250528123236.1138632-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

These is present in my tree. Provide it as a patch to simplify testing
this series with QEMU.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 scripts/build-efi       | 173 +++++++++++++++++
 scripts/build-qemu      | 415 ++++++++++++++++++++++++++++++++++++++++
 scripts/build_helper.py | 126 ++++++++++++
 3 files changed, 714 insertions(+)
 create mode 100755 scripts/build-efi
 create mode 100755 scripts/build-qemu
 create mode 100644 scripts/build_helper.py

diff --git a/scripts/build-efi b/scripts/build-efi
new file mode 100755
index 00000000000..2f4b916c49b
--- /dev/null
+++ b/scripts/build-efi
@@ -0,0 +1,173 @@
+#!/usr/bin/env python3
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
+import os
+import shutil
+
+from build_helper import Helper
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
+    parser.add_argument('-A', '--arm', action='store_true',
+                        help='Run on ARM architecture')
+    parser.add_argument('-B', '--no-build', action='store_true',
+                        help="Don't build (an existing build must be present")
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
+class BuildEfi:
+    """Class to collect together the various bits of state while running"""
+    def __init__(self, args):
+        self.helper = Helper()
+        self.helper.read_settings()
+        self.img = self.helper.get_setting('efi_image_file', 'efi.img')
+        self.build_dir = self.helper.get_setting("build_dir", '/tmp')
+        self.args = args
+
+    def run_qemu(self, bitness, serial_only):
+        """Run QEMU
+
+        Args:
+            bitness (int): Bitness to use, 32 or 64
+            serial_only (bool): True to run without a display
+        """
+        extra = []
+        efi_dir = self.helper.get_setting('efi_dir')
+        if self.args.arm:
+            qemu_arch = 'aarch64'
+            extra += ['--machine', 'virt', '-cpu', 'max']
+            bios = os.path.join(efi_dir, 'OVMF-pure-efi.aarch64.fd.64m')
+            var_store = os.path.join(efi_dir, 'varstore.img')
+            extra += [
+                '-drive', f'if=pflash,format=raw,file={bios},readonly=on',
+                '-drive', f'if=pflash,format=raw,file={var_store}'
+                ]
+            extra += ['-drive',
+                      f'id=hd0,file={self.img},if=none,format=raw',
+                      '-device', 'virtio-blk-device,drive=hd0']
+        else:  # x86
+            if bitness == 64:
+                qemu_arch = 'x86_64'
+                bios = 'OVMF-pure-efi.x64.fd'
+            else:
+                qemu_arch = 'i386'
+                bios = 'OVMF-pure-efi.i386.fd'
+            extra += ['-bios', os.path.join(efi_dir, bios)]
+            extra += ['-drive', f'id=disk,file={self.img},if=none,format=raw']
+            extra += ['-device', 'ahci,id=ahci']
+            extra += ['-device', 'ide-hd,drive=disk,bus=ahci.0']
+        qemu = f'qemu-system-{qemu_arch}'
+        if serial_only:
+            extra += ['-display', 'none', '-serial', 'mon:stdio']
+            serial_msg = ' (Ctrl-a x to quit)'
+        else:
+            if self.args.arm:
+                extra += ['-device', 'virtio-gpu-pci']
+            extra += ['-serial', 'mon:stdio']
+            serial_msg = ''
+        print(f'Running {qemu}{serial_msg}')
+
+        # Use 512MB since U-Boot EFI likes to have 256MB to play with
+        cmd = [qemu]
+        cmd += '-m', '512'
+        cmd += '-nic', 'none'
+        cmd += extra
+        command.run(*cmd)
+
+    def setup_files(self, build, build_type, dst):
+        """Set up files in the staging area
+
+        Args:
+            build (str): Name of build being packaged, e.g. 'efi-x86_app32'
+            build_type (str): Build type ('app' or 'payload')
+            dst (str): Destination directory
+        """
+        print(f'Packaging {build}')
+        fname = f'u-boot-{build_type}.efi'
+        tools.write_file(f'{dst}/startup.nsh', f'fs0:{fname}', binary=False)
+        shutil.copy(f'{self.build_dir}/{build}/{fname}', dst)
+
+    def do_build(self, build):
+        """Build U-Boot for the selected board"""
+        res = command.run_one('buildman', '-w', '-o',
+                              f'{self.build_dir}/{build}', '--board', build,
+                              '-I', raise_on_error=False)
+        if res.return_code and res.return_code != 101:  # Allow warnings
+            raise ValueError(
+                f'buildman exited with {res.return_code}: {res.combined}')
+
+    def start(self):
+        """This does all the work"""
+        args = self.args
+        bitness = 32 if args.word else 64
+        arch = 'arm' if args.arm else 'x86'
+        build_type = 'payload' if args.payload else 'app'
+        build = f'efi-{arch}_{build_type}{bitness}'
+
+        if not args.no_build:
+            self.do_build(build)
+
+        if args.old and bitness == 32:
+            build = f'efi-{arch}_{build_type}'
+
+        with self.helper.make_disk(self.img, fs_type='vfat',
+                                   use_part=args.partition) as dirpath:
+            self.setup_files(build, build_type, dirpath)
+            if self.args.kernel:
+                bzimage = self.helper.get_setting('bzimage_file', 'bzImage')
+                command.run('cp', bzimage, f'{dirpath}/vmlinuz')
+
+        if args.run:
+            self.run_qemu(bitness, args.serial)
+
+
+if __name__ == "__main__":
+    efi = BuildEfi(parse_args())
+    efi.start()
diff --git a/scripts/build-qemu b/scripts/build-qemu
new file mode 100755
index 00000000000..5798da3775c
--- /dev/null
+++ b/scripts/build-qemu
@@ -0,0 +1,415 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0+
+#
+"""Script to build/run U-Boot with QEMU
+
+It assumes that
+
+- you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot
+  board config
+- your OS images are in ${imagedir}/{distroname}/
+
+So far the script supports only ARM and x86
+"""
+
+import sys
+import os
+import argparse
+import subprocess
+import shlex
+import time
+from pathlib import Path
+
+from build_helper import Helper
+
+OUR_PATH = os.path.dirname(os.path.realpath(__file__))
+OUR1_PATH = os.path.dirname(OUR_PATH)
+
+# Bring in the patman and dtoc libraries (but don't override the first path
+# in PYTHONPATH)
+sys.path.insert(2, os.path.join(OUR1_PATH, 'tools'))
+
+# pylint: disable=C0413
+from u_boot_pylib import command
+from u_boot_pylib import tools
+from u_boot_pylib import tout
+
+
+def parse_args():
+    """Parses command-line arguments"""
+    parser = argparse.ArgumentParser(
+        description='Build and/or run U-Boot with QEMU',
+        formatter_class=argparse.RawTextHelpFormatter)
+    parser.add_argument('-a', '--arch', default='arm', choices=['arm', 'x86'],
+                        help='Select architecture (arm, x86) Default: arm')
+    parser.add_argument('-B', '--no-build', action='store_true',
+                        help="Don't build; assume a build exists")
+    parser.add_argument('-d', '--disk',
+                        help='Root disk image file to use with QEMU')
+    parser.add_argument('-D', '--share-dir', metavar='DIR',
+                        help='Directory to share into the guest via virtiofs')
+    parser.add_argument('-e', '--sct-run', action='store_true',
+                        help='Run UEFI Self-Certification Test (SCT)')
+    parser.add_argument('-E', '--use-tianocore', action='store_true',
+                        help='Run Tianocore (OVMF) instead of U-Boot')
+    parser.add_argument(
+        '-k', '--kvm', action='store_true',
+        help='Use KVM (Kernel-based Virtual Machine) for acceleration')
+    parser.add_argument('-o', '--os', metavar='NAME', choices=['ubuntu'],
+                        help='Run a specified Operating System')
+    parser.add_argument('-v', '--verbose', action='store_true',
+                        help='Show executed commands')
+    parser.add_argument('-r', '--run', action='store_true',
+                        help='Run QEMU with the built/specified image')
+    parser.add_argument(
+        '-R', '--release', default='24.04.1',
+        help='Select OS release version (e.g, 24.04) Default: 24.04.1')
+    parser.add_argument(
+        '-s', '--serial-only', action='store_true',
+        help='Use serial console only (no graphical display for QEMU)')
+    parser.add_argument(
+        '-S', '--sct-seq',
+        help='SCT sequence-file to be written into the SCT image if -e')
+    parser.add_argument('-w', '--word-32bit', action='store_true',
+                        help='Use 32-bit version for the build/architecture')
+
+    return parser.parse_args()
+
+
+class BuildQemu:
+    """Build and/or run U-Boot with QEMU based on command line arguments"""
+
+    def __init__(self, args):
+        """Set up arguments and configure paths"""
+        self.args = args
+
+        self.helper = Helper()
+        self.helper.read_settings()
+        self.imagedir = Path(self.helper.get_setting('image_dir', '~/dev'))
+        self.ubdir = Path(self.helper.get_setting('build_dir', '/tmp/b'))
+        self.sctdir = Path(self.helper.get_setting('sct_dir', '~/dev/efi/sct'))
+        self.tiano = Path(self.helper.get_setting('tianocore_dir',
+                                                  '~/dev/tiano'))
+        self.mnt = Path(self.helper.get_setting('sct_mnt', '/mnt/sct'))
+
+        self.bitness = 32 if args.word_32bit else 64
+        self.qemu_extra = []
+        self.mem = '512M'  # Default QEMU memory
+
+        if args.disk:
+            self.mem = '4G'
+            self.qemu_extra.extend(['-smp', '4'])
+
+        if args.sct_run:
+            self.mem = '4G'
+            self.qemu_extra.extend(['-smp', '4'])
+            # SCT usually runs headlessly
+            self.qemu_extra.extend(['-display', 'none'])
+            # For potential interaction within SCT
+            self.qemu_extra.extend(['-device', 'qemu-xhci'])
+            self.qemu_extra.extend(['-device', 'usb-kbd'])
+            sct_image_path = self.sctdir / 'sct.img'
+            if not sct_image_path.exists():
+                tout.fatal(f'Error: SCT image {sct_image_path} not found, '
+                           'required for -e')
+            self.qemu_extra.extend([
+                '-drive', f'file={sct_image_path},format=raw,if=none,id=vda',
+                '-device', 'virtio-blk-pci,drive=vda,bootindex=1'])
+            # Basic networking for SCT, if needed
+            self.qemu_extra.extend([
+                '-device', 'virtio-net-pci,netdev=net0',
+                '-netdev', 'user,id=net0'])
+            args.serial_only = True  # SCT implies serial output
+
+        if args.os:
+            self.mem = '4G'
+            self.qemu_extra.extend(['-smp', '4'])
+
+        self.kvm_params = []
+        if args.kvm:
+            self.kvm_params = ['-enable-kvm', '-cpu', 'host']
+
+        bios_override = None
+        if args.use_tianocore:
+            bios_override = Path(self.tiano, 'OVMF-pure-efi.x64.fd')
+            if not bios_override.exists():
+                tout.fatal(
+                    'Error: Tianocore BIOS specified (-E) but not found at '
+                    f'{bios_override}')
+
+        self.seq_fname = Path(args.sct_seq) if args.sct_seq else None
+        self.img_fname = Path(args.disk) if args.disk else None
+
+        # arch-specific setup
+        if args.arch == 'arm':
+            self.board = 'qemu_arm'
+            default_bios = 'u-boot.bin'
+            self.qemu = 'qemu-system-arm'
+            self.qemu_extra.extend(['-machine', 'virt'])
+            if not args.kvm:
+                self.qemu_extra.extend(['-accel', 'tcg'])
+            qemu_arch = 'arm'
+            if self.bitness == 64:
+                self.board = 'qemu_arm64'
+                self.qemu = 'qemu-system-aarch64'
+                self.qemu_extra.extend(['-cpu', 'cortex-a57'])
+                qemu_arch = 'arm64'
+        elif args.arch == 'x86':
+            self.board = 'qemu-x86'
+            default_bios = 'u-boot.rom'
+            self.qemu = 'qemu-system-i386'
+            qemu_arch = 'i386'  # For OS image naming
+            if self.bitness == 64:
+                self.board = 'qemu-x86_64'
+                self.qemu = 'qemu-system-x86_64'
+                qemu_arch = 'amd64'
+        else:
+            raise ValueError(f"Invalid arch '{args.arch}'")
+
+        self.os_path = None
+        if args.os == 'ubuntu':
+            img_name = (f'{args.os}-{args.release}-desktop-{qemu_arch}.iso')
+            self.os_path = self.imagedir / args.os / img_name
+
+        self.build_dir = self.ubdir / self.board
+        self.bios = (bios_override if bios_override
+                     else self.build_dir / default_bios)
+
+    @staticmethod
+    def execute_command(cmd_list, desc, check=True, **kwargs):
+        """Execute a shell command and handle errors
+
+        Args:
+            cmd_list (list of str): The command and its arguments as a list
+            desc (str): A description of the command being executed
+            check (bool): Raise CalledProcessError on non-zero exit code
+            kwargs: Additional arguments for subprocess.run
+
+        Return:
+            subprocess.CompletedProcess: The result of the subprocess.run call
+
+        Raises:
+            SystemExit: If the command is not found or fails and check is True
+        """
+        tout.info(f"Executing: {desc} -> {shlex.join(cmd_list)}")
+        try:
+            # Decode stdout/stderr by default if text=True
+            if 'text' not in kwargs:
+                kwargs['text'] = True
+            return subprocess.run(cmd_list, check=check, **kwargs)
+        except FileNotFoundError:
+            tout.fatal(f"Error: Command '{cmd_list[0]}' not found")
+        except subprocess.CalledProcessError as proc:
+            tout.error(f'Error {desc}: Command failed with exit code '
+                       f'{proc.returncode}')
+            if proc.stdout:
+                tout.error(f'Stdout:\n{proc.stdout}')
+            if proc.stderr:
+                tout.error(f'Stderr:\n{proc.stderr}')
+            tout.fatal('Failed')
+
+    def build_u_boot(self):
+        """Build U-Boot using buildman
+        """
+        self.build_dir.mkdir(parents=True, exist_ok=True)
+        cmd = ['buildman', '-w', '-o', str(self.build_dir), '--board',
+               self.board, '-I']
+
+        self.execute_command(
+            cmd,
+            f'Building U-Boot for {self.board} in {self.build_dir}')
+
+    def update_sct_sequence(self):
+        """Update the SCT image with a specified sequence file
+
+        Requires sudo for loop device setup and mounting
+        """
+        if not (self.args.sct_run and self.seq_fname and
+                self.seq_fname.exists()):
+            if (self.args.sct_run and self.seq_fname and
+                    not self.seq_fname.exists()):
+                tout.warning(f'Warning: SCT sequence file {self.seq_fname}'
+                             'not found')
+            return
+
+        fname = self.sctdir / 'sct.img'
+        if not fname.exists():
+            tout.fatal(f'Error: SCT image {fname} not found')
+
+        loopdev = None
+        try:
+            # Find free loop device and attach
+            loopdev = command.output_one_line(
+                'sudo', 'losetup', '--show', '-f', '-P', str(fname))
+            partition_path_str = f'{loopdev}p1'
+
+            uid, gid = os.getuid(), os.getgid()
+            mount_cmd = ['sudo', 'mount', partition_path_str,
+                         str(self.mnt), '-o', f'uid={uid},gid={gid},rw']
+            mount_cmd.extend(['-t', 'vfat'])
+
+            self.execute_command(mount_cmd,
+                                 f'Mounting {partition_path_str} to {self.mnt}')
+
+            target_sct_path = self.mnt / self.seq_fname.name
+            self.execute_command(
+                ['sudo', 'cp', str(self.seq_fname), str(target_sct_path)],
+                f'Copying {self.seq_fname.name} to {self.mnt}'
+            )
+            tout.info(f"Copied {self.seq_fname} to {target_sct_path}")
+
+        finally:
+            if Path(self.mnt).is_mount():
+                self.execute_command(['sudo', 'umount', str(self.mnt)],
+                                     f'Unmounting {self.mnt}', check=False)
+            if loopdev:
+                self.execute_command(['sudo', 'losetup', '-d', loopdev],
+                                     f'Detaching loop device {loopdev}',
+                                     check=False)
+
+    def run_qemu(self):
+        """Construct and run the QEMU command"""
+        if not self.bios.exists():
+            tout.fatal(f"Error: BIOS file '{self.bios}' not found")
+
+        qemu_cmd = [str(self.qemu)]
+        if self.bios:
+            qemu_cmd.extend(['-bios', str(self.bios)])
+        qemu_cmd.extend(self.kvm_params)
+        qemu_cmd.extend(['-m', self.mem])
+
+        if not self.args.sct_run:
+            qemu_cmd.extend(['-netdev', 'user,id=net0,hostfwd=tcp::2222-:22',
+                             '-device', 'virtio-net-pci,netdev=net0'])
+
+        # Display and Serial
+        # If -e (sct_run) is used, "-display none" is in qemu_extra
+        # If -s (serial_only) is used, we want no display
+        has_display_option = any(
+            item.startswith('-display') for item in self.qemu_extra)
+        if self.args.serial_only and not has_display_option:
+            qemu_cmd.extend(['-display', 'none'])
+        if not any(item.startswith('-serial') for item in self.qemu_extra):
+            qemu_cmd.extend(['-serial', 'mon:stdio'])
+
+        # Add other parameters gathered from options
+        qemu_cmd.extend(self.qemu_extra)
+        if self.os_path:
+            if not self.os_path.exists():
+                tout.error(f'OS image {self.os_path} specified but not found')
+            qemu_cmd.extend([
+                '-drive',
+                f'if=virtio,file={self.os_path},format=raw,id=hd0,readonly=on'])
+
+        if self.img_fname:
+            if self.img_fname.exists():
+                qemu_cmd.extend([
+                    '-drive',
+                    f'if=virtio,file={self.img_fname},format=raw,id=hd1'])
+            else:
+                tout.warning(f"Disk image '{self.img_fname}' not found")
+
+        sock = Path('/tmp/virtiofs.sock')
+        proc = None
+        if self.args.share_dir:
+            virtfs_dir = Path(self.args.share_dir)
+            if not virtfs_dir.is_dir():
+                tout.fatal(f'Error: VirtFS share directory {virtfs_dir} '
+                           f'is not a valid directory')
+
+            virtiofsd = Path('/usr/libexec/virtiofsd')
+            if not virtiofsd.exists():
+                tout.fatal(f'Error: virtiofsd not found at {virtiofsd}')
+
+            # Clean up potential old socket file
+            if sock.exists():
+                try:
+                    sock.unlink()
+                    tout.info(f'Removed old socket file {sock}')
+                except OSError as e:
+                    tout.warning(
+                        f'Warning: Could not remove old socket file {sock}: '
+                        f'{e}')
+
+            qemu_cmd.extend([
+                '-chardev', f'socket,id=char0,path={sock}',
+                '-device',
+                'vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=hostshare',
+                '-object',
+                f'memory-backend-file,id=mem,size={self.mem},mem-path=/dev/shm'
+                    ',share=on',
+                '-numa', 'node,memdev=mem'])
+
+            virtiofsd_cmd = [
+                str(virtiofsd),
+                '--socket-path', str(sock),
+                '--shared-dir', str(virtfs_dir),
+                '--cache', 'auto']
+            try:
+                # Use Popen to run virtiofsd in the background
+                proc = subprocess.Popen(virtiofsd_cmd, stdout=subprocess.PIPE,
+                                        stderr=subprocess.PIPE)
+                # Give virtiofsd a moment to start and create the socket
+                time.sleep(0.5)
+                if not sock.exists() and proc.poll() is not None:
+                    stdout, stderr = proc.communicate()
+                    tout.error('Error starting virtiofsd. Exit code: '
+                               f'{proc.returncode}')
+                    if stdout:
+                        tout.error(f"virtiofsd stdout:\n{stdout.decode()}")
+                    if stderr:
+                        tout.error(f"virtiofsd stderr:\n{stderr.decode()}")
+                    tout.fatal('Failed')
+
+            except (subprocess.CalledProcessError, FileNotFoundError) as exc:
+                tout.fatal(f'Failed to start virtiofsd: {exc}')
+
+        tout.info(f'QEMU:\n{shlex.join(qemu_cmd)}\n')
+        try:
+            subprocess.run(qemu_cmd, check=True)
+        except FileNotFoundError:
+            tout.fatal(f"Error: QEMU executable '{self.qemu}' not found")
+        except subprocess.CalledProcessError as e:
+            tout.fatal(f'QEMU execution failed with exit code {e.returncode}')
+        finally:
+            # Clean up virtiofsd process and socket if it was started
+            if proc:
+                tout.info('Terminating virtiofsd')
+                proc.terminate()
+                try:
+                    proc.wait(timeout=5)
+                except subprocess.TimeoutExpired:
+                    tout.warning(
+                        'virtiofsd did not terminate gracefully; killing')
+                    proc.kill()
+                if sock.exists():
+                    try:
+                        sock.unlink()
+                    except OSError as e_os:
+                        tout.warning('Warning: Could not remove virtiofs '
+                                     f'socket {sock}: {e_os}')
+
+    def start(self):
+        """Build and run QEMU"""
+        if not self.args.no_build and not self.args.use_tianocore:
+            self.build_u_boot()
+
+        # Update SCT sequence if -e and -S are given
+        if self.args.sct_run and self.seq_fname:
+            self.update_sct_sequence()
+
+        if self.args.run:
+            self.run_qemu()
+
+
+def main():
+    """Parses arguments and initiates the BuildQemu process
+    """
+    args = parse_args()
+    tout.init(tout.INFO if args.verbose else tout.WARNING)
+
+    qemu = BuildQemu(args)
+    qemu.start()
+
+if __name__ == '__main__':
+    main()
diff --git a/scripts/build_helper.py b/scripts/build_helper.py
new file mode 100644
index 00000000000..a8385ed1545
--- /dev/null
+++ b/scripts/build_helper.py
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+"""Common script for build- scripts
+
+"""
+
+import configparser
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
+    def read_settings(self):
+        """Get settings from the settings file"""
+        self.settings = configparser.ConfigParser()
+        fname = f'{os.getenv("HOME")}/.u_boot_qemu'
+        if not os.path.exists(fname):
+            print('No config file found: {fname}\nCreating one...\n')
+            tools.write_file(fname, '''# U-Boot QEMU-scripts config
+
+[DEFAULT]
+# Set ubdir to the build directory where you build U-Boot out-of-tree
+# We avoid in-tree build because it gets confusing trying different builds
+# Each board gets a build in a separate subdir
+build_dir = /tmp/b
+
+# Image directory (for OS images)
+image_dir = ~/dev/os
+
+# Build the kernel with: make O=/tmp/kernel
+bzimage = /tmp/kernel/arch/x86/boot/bzImage
+
+# EFI image-output filename
+efi_image_file = try.img
+
+# Directory where OVMF-pure-efi.i386.fd etc. are kept
+efi_dir = ~/dev/efi
+
+# Directory where SCT image (sct.img) is kept
+sct_dir = ~/dev/efi/sct
+
+# Directory where the SCT image is temporarily mounted for modification
+sct_mnt = /mnt/sct
+''', binary=False)
+        self.settings.read(fname)
+
+    def get_setting(self, name, fallback=None):
+        """Get a setting by name
+
+        Args:
+            name (str): Name of setting to retrieve
+            fallback (str or None): Value to return if the setting is missing
+        """
+        raw = self.settings.get('DEFAULT', name, fallback=fallback)
+        return os.path.expandvars(os.path.expanduser(raw))
+
+    def stage(self, name):
+        """Context manager to count requests across a range of patchwork calls
+
+        Args:
+            name (str): Stage name
+
+        Return:
+            _Stage: contect object
+
+        Usage:
+            with self.stage('name'):
+                ...do things
+
+            Note that the output only appears if the -N flag is used
+        """
+        return self._Stage(name)
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

