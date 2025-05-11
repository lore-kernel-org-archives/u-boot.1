Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F40C3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA23E828BC;
	Sun, 11 May 2025 16:18:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M7TtgW0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3E7829A0; Sun, 11 May 2025 16:18:49 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6DBE828BC
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-5fbeadf2275so6263209a12.2
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973125; x=1747577925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQ37YOEKKr7xKQSE9/xfEFQwucN5x64Axt4z7PIIYM0=;
 b=M7TtgW0p8V+Q2Cy9N9HK8J99fkp384o2LaN9ClM4sFKxGGAOuai7PsaTDYJc68Erwm
 xU+QuoK0RNB7rcwUvpcQLa0o7cMaM6A74SFesdlEerLHucLjSJZyCtpfLs37TY3YNPOC
 WMQNxJCfFoJZsdBo+Cm1fSrdr4LkC5nAQg0D0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973125; x=1747577925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQ37YOEKKr7xKQSE9/xfEFQwucN5x64Axt4z7PIIYM0=;
 b=ZJR8ZRsp8YPa1m3n33aDDRxU06am0fzqcAzUzjpc2AI8WxV6/jFRt5nI/OafJ1Y8O9
 YOLM9+FxPYbCI+eyDVSkRjlMkRl5WrMTIiYVGK8H+vYPUHc/6LlS/DbnIZgcjJpLCURK
 aGNYeaTZjEnnNEQgxQgN/gt0t0sLvYUUOs2M0iz6x1SK/V7UCA9aAJo2HbtVll01ECzd
 9TiVpe2x2vPD3vZFLH3R/VYD6uvfhiUsRxYH2ne8uHDHMxfAMeGSrsux94GClhVrmGaL
 x8bB8BFx9Ebfty9ELTAm4jNbcLXQW5gmmVd5AitWRcF0zf+5CyE0qy4n4BQl2j/zBhXo
 IQmQ==
X-Gm-Message-State: AOJu0Yy/8bDkxlwn/zyHuro26jhCOEuYIUcJ9W/eJjqcf+ai8xdC4HzG
 KmwhMZO118mwlgY3v1Y5Qg3JTod5vQ6irIRFe3Vz41Vmm/uk+5JmlBgDQ5JhNIeTGH3clvyIqBe
 dESkpbGPp5W4A
X-Gm-Gg: ASbGncv/Aa10vdGgDjx8MAFMe5asL8+TJWC+LoDD54pPlFRdbYEyD5e4ZElMY85vmf6
 Je42fOTdTY48WN7xqKNlYXaB2mpkErLhWT7lJQZP6SEt9c6D5ZqZBC+fnTFqVy1k7HHtv0u+1e7
 3g2qJFE359tQkWhEzdF9zOBQr/4+5aIS+ZlciSnFuFBlCqtL/1agPbWx7cnA4/uwCZCI3Nwyo31
 DeTlsff/6gVJSKrLJnmz9+OI9XrPStYO0cvZfnyRQtQm99BvYjVT9yXC3HV5Wy9BMI0njbsiKVX
 Mlwi/w9NOKGA8b5itn4BlxbcfNWiDt8aR4h38mfm9kY1Fqc=
X-Google-Smtp-Source: AGHT+IFj3X0jufE1rX4MV6erThycbGesia8kt5gFwc33BLxWKBJ1W3dLPzZZOZTs1GUBLCKIB0F/Pg==
X-Received: by 2002:a17:907:7fa6:b0:ad2:40f4:c251 with SMTP id
 a640c23a62f3a-ad240f4cad2mr414893366b.35.1746973125079; 
 Sun, 11 May 2025 07:18:45 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad21985858asm477789266b.176.2025.05.11.07.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 07:18:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] scripts: Convert the build-qemu script to Python
Date: Sun, 11 May 2025 16:18:21 +0200
Message-ID: <20250511141828.2367318-7-sjg@chromium.org>
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

Convert this to Python and make use of the build_helpers module. Update
that module to remove old options and improve the ordering of options.

The script doubles in size, part of which is being a lot more friendly
with virtiofsd problems, as well as adding a verbose mode.

Update the documentation as well.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                    |   2 +-
 doc/board/emulation/script.rst |  78 +++++--
 scripts/build-qemu             | 414 +++++++++++++++++++++++++++++++++
 scripts/build-qemu.sh          | 211 -----------------
 scripts/build_helper.py        |  17 +-
 5 files changed, 485 insertions(+), 237 deletions(-)
 create mode 100755 scripts/build-qemu
 delete mode 100755 scripts/build-qemu.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index aebccd9678f..3dae1c618ba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1126,7 +1126,7 @@ S:	Maintained
 W:	https://docs.u-boot.org/en/latest/board/emulation/script.html
 F:	configs/qemu_x86*
 F:	doc/board/emulation/script.rst
-F:	scripts/build-qemu.sh
+F:	scripts/build-qemu
 F:	scripts/build_helper.py
 
 ENVIRONMENT
diff --git a/doc/board/emulation/script.rst b/doc/board/emulation/script.rst
index 23981e333cb..cf718ad41a7 100644
--- a/doc/board/emulation/script.rst
+++ b/doc/board/emulation/script.rst
@@ -3,25 +3,66 @@
 Script for building and running
 ===============================
 
-You may find the script `scripts/build-qemu.sh` helpful for building and testing
+You may find the script `scripts/build-qemu` helpful for building and testing
 U-Boot on QEMU.
 
-If uses a environment variables to control how it works:
+If uses a settings file `~/.u_boot_qemu` to control how it works:
 
-ubdir
+build_dir
     base directory for building U-Boot, with each board being in its own
     subdirectory
 
-imagedir
-    directory containing OS images, containin a subdirectory for each distro
-    type (e.g. ubuntu/
+image_dir
+    directory containing OS images, containing a subdirectory for each distro
+    type (e.g. `ubuntu/`)
 
-Once configured, you can build and run QEMU for arm64 like this::
+bzimage
+    path to a bzImage file to supply to boot x86 Linux
+
+efi_image_file
+    output filename for the disk image containing an EFI app / payload
+
+efi_dir
+    directory when pre-built UEFI images are kept, e.g. OVMF-pure-efi.i386.fd
+
+sct_dir
+    directory when the UEFI Self-Certification Test (SCT) is kept
+
+sct_mnt
+    temporary mount point for building SCT: note this requires sudo
+
+A sample file is written if you don't have one, e.g.::
+
+    # U-Boot QEMU-scripts config
+
+    [DEFAULT]
+    # Set to the build directory where you build U-Boot out-of-tree
+    # We avoid in-tree build because it gets confusing trying different builds
+    # Each board gets a build in a separate subdir
+    build_dir = /tmp/b
+
+    # Image directory (for OS images)
+    image_dir = ~/dev/os
+
+    # Build the kernel with: make O=/tmp/kernel
+    bzimage = /tmp/kernel/arch/x86/boot/bzImage
+
+    # EFI image-output filename
+    efi_image_file = try.img
 
-    scripts/build-qemu.sh -rsw
+    # Directory where OVMF-pure-efi.i386.fd etc. are kept
+    efi_dir = ~/dev/efi
 
-No support is currently included for specifying a root disk, so this script can
-only be used to start installers.
+    # Directory where SCT image (sct.img) is kept
+    sct_dir = ~/dev/efi/sct
+
+    # Directory where the SCT image is temporarily mounted for modification
+    sct_mnt = /mnt/sct
+
+
+Once configured, you can build and run QEMU for arm64 like this::
+
+    scripts/build-qemu -rsw
 
 Options
 ~~~~~~~
@@ -34,6 +75,15 @@ Options are available to control the script:
 -B
     Don't build; assume a build exists
 
+-d/--disk DISK
+    Root disk image file to use with QEMU
+
+-e/--sct-run
+    Package an run UEFI Self-Certification Test (SCT)
+
+-E/--use-tianocore
+    Run Tianocore (OVMF) instead of U-Boot
+
 -k
     Use kvm - kernel-based Virtual Machine. By default QEMU uses its own
     emulator
@@ -52,10 +102,8 @@ Options are available to control the script:
 -s
     Use serial only (no display)
 
+-S/--sct-seq SCT_SEQ
+    SCT sequence-file to be written into the SCT image if -e
+
 -w
     Use word version (32-bit). By default, 64-bit is used
-
-.. note::
-
-    Note: For now this is a shell script, but if it expands it might be better
-    as Python, accepting the slower startup.
diff --git a/scripts/build-qemu b/scripts/build-qemu
new file mode 100755
index 00000000000..a9249a2f87c
--- /dev/null
+++ b/scripts/build-qemu
@@ -0,0 +1,414 @@
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
diff --git a/scripts/build-qemu.sh b/scripts/build-qemu.sh
deleted file mode 100755
index f9ee0072573..00000000000
--- a/scripts/build-qemu.sh
+++ /dev/null
@@ -1,211 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0+
-#
-# Script to build U-Boot suitable for booting with QEMU, possibly running
-# it, possibly with an OS image
-
-# This just an example. It assumes that
-
-# - you build U-Boot in ${ubdir}/<name> where <name> is the U-Boot board config
-# - your OS images are in ${imagedir}/{distroname}/...
-
-# So far the script supports only ARM and x86.
-
-set -e
-
-usage() {
-	(
-	if [[ -n "$1" ]]; then
-		echo "$1"
-		echo
-	fi
-	echo "Usage: $0 -aBkrsw"
-	echo
-	echo "   -a <arch> - Select architecture (arm, x86)"
-	echo "   -B        - Don't build; assume a build exists"
-	echo "   -e        - Run UEFI Self-Certification Test (SCT)"
-	echo "   -k        - Use kvm (kernel-based Virtual Machine)"
-	echo "   -o <name> - Run Operating System ('ubuntu' only for now)"
-	echo "   -r        - Run QEMU with the image"
-	echo "   -R <os>   - Select OS release (e.g. 24.04)"
-	echo "   -s        - Use serial only (no display)"
-	echo "   -S <seq>  - Select SCT sequence-file"
-	echo "   -w        - Use word version (32-bit)" ) >&2
-	exit 1
-}
-
-# Directory tree for OS images
-imagedir=${imagedir-/vid/software/linux}
-
-# Directory for UEFI Self-Certification Test (SCT)
-sctdir=${sctdir-/vid/software/devel/uefi/sct}
-
-# Mount point for use when writing to disk images
-mnt=${mnt-/mnt}
-
-# architecture (arm or x86)
-arch=arm
-
-# 32- or 64-bit build
-bitness=64
-
-# Build U-Boot
-build=yes
-
-# Extra setings
-extra=
-
-# Operating System to boot (ubuntu)
-os=
-
-release=24.04.1
-
-# run the image with QEMU
-run=
-
-# run QEMU without a display (U-Boot must be set to stdout=serial)
-serial=
-
-# Use kvm
-kvm=
-
-# Set ubdir to the build directory where you build U-Boot out-of-tree
-# We avoid in-tree build because it gets confusing trying different builds
-ubdir=${ubdir-/tmp/b}
-
-while getopts "a:Beko:rR:sS:w" opt; do
-	case "${opt}" in
-	a)
-		arch=$OPTARG
-		;;
-	B)
-		build=
-		;;
-	e)
-		extra+=" -m 4G -smp 4"
-		extra+=" -display none"
-		extra+=" -device virtio-gpu-pci"
-		extra+=" -device qemu-xhci"
-		extra+=" -device usb-kbd"
-		extra+=" -drive file=${sctdir}/sct.img,format=raw,if=none,id=vda"
-		extra+=" -device virtio-blk-device,drive=vda,bootindex=1"
-		extra+=" -device virtio-net-device,netdev=net0"
-		extra+=" -netdev user,id=net0"
-		;;
-	k)
-		kvm="-enable-kvm"
-		;;
-	o)
-		os=$OPTARG
-
-		# Expand memory and CPUs
-		extra+=" -m 4G -smp 4"
-		;;
-	r)
-		run=1
-		;;
-	R)
-		release=$OPTARG
-		;;
-	s)
-		serial=1
-		;;
-	S)
-		seq=$OPTARG
-		;;
-	w)
-		bitness=32
-		;;
-	*)
-		usage
-		;;
-	esac
-done
-
-# Build U-Boot for the selected board
-build_u_boot() {
-	buildman -w -o $DIR --board $BOARD -I || exit $?
-}
-
-# Write the SCT test-sequence file into the SCT image
-update_sct_seq() {
-	if [[ -z "${seq}" ]]; then
-		return
-	fi
-	LOOP=$(sudo losetup --show -f -P "${sctdir}/sct.img")
-	PART="${LOOP}p1"
-	sudo mount -o loop ${PART} ${mnt} -o uid=$(id -u),gid=$(id -g)
-	cp "${seq}" "${mnt}/."
-	sudo umount ${mnt}
-	sudo losetup -d ${LOOP}
-}
-
-# Run QEMU with U-Boot
-run_qemu() {
-	if [[ -n "${os_image}" ]]; then
-		extra+=" -drive if=virtio,file=${os_image},format=raw,id=hd0"
-	fi
-	if [[ -n "${serial}" ]]; then
-		extra+=" -display none -serial mon:stdio"
-	else
-		extra+=" -serial mon:stdio"
-	fi
-	echo "Running ${qemu} ${extra}"
-	"${qemu}" -bios "$DIR/${BIOS}" \
-		-m 512 \
-		-nic none \
-		${kvm} \
-		${extra}
-}
-
-# Check architecture
-case "${arch}" in
-arm)
-	BOARD="qemu_arm"
-	BIOS="u-boot.bin"
-	qemu=qemu-system-arm
-	extra+=" -machine virt -accel tcg"
-	suffix="arm"
-	if [[ "${bitness}" == "64" ]]; then
-		BOARD="qemu_arm64"
-		qemu=qemu-system-aarch64
-		extra+=" -cpu cortex-a57"
-		suffix="arm64"
-	fi
-	;;
-x86)
-	BOARD="qemu-x86"
-	BIOS="u-boot.rom"
-	qemu=qemu-system-i386
-	suffix="i386"
-	if [[ "${bitness}" == "64" ]]; then
-		BOARD="qemu-x86_64"
-		qemu=qemu-system-x86_64
-		suffix="amd64"
-	fi
-	;;
-*)
-	usage "Unknown architecture '${arch}'"
-esac
-
-# Check OS
-case "${os}" in
-ubuntu)
-	os_image="${imagedir}/${os}/${os}-${release}-desktop-${suffix}.iso"
-	;;
-"")
-	;;
-*)
-	usage "Unknown OS '${os}'"
-esac
-
-DIR=${ubdir}/${BOARD}
-
-if [[ -n "${build}" ]]; then
-	build_u_boot
-	update_sct_seq
-fi
-
-if [[ -n "${run}" ]]; then
-	run_qemu
-fi
diff --git a/scripts/build_helper.py b/scripts/build_helper.py
index 923270c95c7..a8385ed1545 100644
--- a/scripts/build_helper.py
+++ b/scripts/build_helper.py
@@ -38,19 +38,20 @@ class Helper:
             tools.write_file(fname, '''# U-Boot QEMU-scripts config
 
 [DEFAULT]
-# Image-output filename
-image_file = try.img
-
-# Image directory (for prebuilt UEFI-images)
-image_dir = ~/dev/uefi
-
 # Set ubdir to the build directory where you build U-Boot out-of-tree
 # We avoid in-tree build because it gets confusing trying different builds
+# Each board gets a build in a separate subdir
 build_dir = /tmp/b
 
+# Image directory (for OS images)
+image_dir = ~/dev/os
+
 # Build the kernel with: make O=/tmp/kernel
 bzimage = /tmp/kernel/arch/x86/boot/bzImage
 
+# EFI image-output filename
+efi_image_file = try.img
+
 # Directory where OVMF-pure-efi.i386.fd etc. are kept
 efi_dir = ~/dev/efi
 
@@ -59,10 +60,6 @@ sct_dir = ~/dev/efi/sct
 
 # Directory where the SCT image is temporarily mounted for modification
 sct_mnt = /mnt/sct
-
-# Directory containing Tianocore builds (e.g. OVMF-pure-efi.x64.fd)
-tianocore_dir = ~/dev/efi/tianocore
-
 ''', binary=False)
         self.settings.read(fname)
 
-- 
2.43.0

