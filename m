Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7E3C2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5644286C51;
	Fri, 18 Aug 2023 02:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EsXwkFEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0A6C86C33; Fri, 18 Aug 2023 02:27:34 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8B4B86C4D
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34baf19955cso1408425ab.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318449; x=1692923249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rr1roqYmbF1MR7oM4ygcGiem7446wgbhL8mkLQJxPrE=;
 b=EsXwkFEcGBcPxk1Ch4Hk5wyoPsmcr0YFuIlZpTn+4e+YVS/NVMw7+Uwc2Y24xyHxMt
 B0XqDfq3qkeIqb+WwSoKEzEBq38qpxBmL3gWbFfAXZI+2QPwJzNw5bOvSUH8m+JdUrMr
 19QOw4UZyOZFajUPYuBzoi7GXShzl86L3VZMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318449; x=1692923249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rr1roqYmbF1MR7oM4ygcGiem7446wgbhL8mkLQJxPrE=;
 b=NO4Ttj9NA5Y7FENdpNyp1hBRVSi64iVhv1CCcfypMcrpuLer9waCPuPmIk73eTMm/Q
 V7x2r4ppiVDPx5OYibsphmgiWn1Hsk7T7bUgZDC/q29Eox48fV9lDLnfqkJDOkplF4te
 9HOzNkgnhkESBqOZveHjfKY1SLmiyoTwRLHANflbBdWvrSjBzpzwhJwuZ9GNHvJPQMAP
 w+um9+fnWL/uHN+1+omLW97OcI+vWoAs50+CT4For4KQSnJy0MIS9vp6qpGJf/lsk3sl
 DHVKZkrp1lq8yHpXZLyBWdt0v1nxJC6jKFA0BmX96emVQ/FrsirhUwszomJAxVFWsfWF
 vEzw==
X-Gm-Message-State: AOJu0YxNekz3aH3eQeVdMkK9TuJYdvgYLGyo0xOqMOhSg2I/Vfo3oldn
 QZztOeYgfgp+6BL2ziCOUafLyh38axpo48CXVcI=
X-Google-Smtp-Source: AGHT+IEx4iAwOWF5+KPSHJszTD0ocnnpw8XXPN5B2obn8Q9SZzV7o1jwvRpsUXdWzFkeY+zp0Pkwww==
X-Received: by 2002:a05:6e02:ed0:b0:348:1a1d:79a5 with SMTP id
 i16-20020a056e020ed000b003481a1d79a5mr1080072ilk.15.1692318448906; 
 Thu, 17 Aug 2023 17:27:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 19/20] x86: doc: Split out manual booting into its own file
Date: Thu, 17 Aug 2023 18:26:58 -0600
Message-ID: <20230818002706.853550-20-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

Move this out of the main file since for simple users it is easier to
rely on standard boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch

 doc/arch/x86/index.rst       |   1 +
 doc/arch/x86/manual_boot.rst | 276 +++++++++++++++++++++++++++++++++++
 doc/arch/x86/x86.rst         | 272 +---------------------------------
 3 files changed, 280 insertions(+), 269 deletions(-)
 create mode 100644 doc/arch/x86/manual_boot.rst

diff --git a/doc/arch/x86/index.rst b/doc/arch/x86/index.rst
index 3dc19d603d4c..69db0a5d6489 100644
--- a/doc/arch/x86/index.rst
+++ b/doc/arch/x86/index.rst
@@ -9,3 +9,4 @@ x86
    :maxdepth: 2
 
    x86
+   manual_boot
diff --git a/doc/arch/x86/manual_boot.rst b/doc/arch/x86/manual_boot.rst
new file mode 100644
index 000000000000..ec069f2c3972
--- /dev/null
+++ b/doc/arch/x86/manual_boot.rst
@@ -0,0 +1,276 @@
+Booting Ubuntu Manually
+-----------------------
+
+This shows a manual approach to booting Ubuntu without standard boot or the EFI
+interface.
+
+As an example of how to set up your boot flow with U-Boot, here are
+instructions for starting Ubuntu from U-Boot. These instructions have been
+tested on Minnowboard MAX with a SATA drive but are equally applicable on
+other platforms and other media. There are really only four steps and it's a
+very simple script, but a more detailed explanation is provided here for
+completeness.
+
+Note: It is possible to set up U-Boot to boot automatically using syslinux.
+It could also use the grub.cfg file (/efi/ubuntu/grub.cfg) to obtain the
+GUID. If you figure these out, please post patches to this README.
+
+Firstly, you will need Ubuntu installed on an available disk. It should be
+possible to make U-Boot start a USB start-up disk but for now let's assume
+that you used another boot loader to install Ubuntu.
+
+Use the U-Boot command line to find the UUID of the partition you want to
+boot. For example our disk is SCSI device 0::
+
+   => part list scsi 0
+
+   Partition Map for SCSI device 0  --   Partition Type: EFI
+
+      Part	Start LBA	End LBA		Name
+        Attributes
+        Type GUID
+        Partition GUID
+      1	0x00000800	0x001007ff	""
+        attrs:	0x0000000000000000
+        type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
+        guid:	9d02e8e4-4d59-408f-a9b0-fd497bc9291c
+      2	0x00100800	0x037d8fff	""
+        attrs:	0x0000000000000000
+        type:	0fc63daf-8483-4772-8e79-3d69d8477de4
+        guid:	965c59ee-1822-4326-90d2-b02446050059
+      3	0x037d9000	0x03ba27ff	""
+        attrs:	0x0000000000000000
+        type:	0657fd6d-a4ab-43c4-84e5-0933c84b4f4f
+        guid:	2c4282bd-1e82-4bcf-a5ff-51dedbf39f17
+      =>
+
+This shows that your SCSI disk has three partitions. The really long hex
+strings are called Globally Unique Identifiers (GUIDs). You can look up the
+'type' ones `here`_. On this disk the first partition is for EFI and is in
+VFAT format (DOS/Windows)::
+
+   => fatls scsi 0:1
+               efi/
+
+   0 file(s), 1 dir(s)
+
+
+Partition 2 is 'Linux filesystem data' so that will be our root disk. It is
+in ext2 format::
+
+   => ext2ls scsi 0:2
+   <DIR>       4096 .
+   <DIR>       4096 ..
+   <DIR>      16384 lost+found
+   <DIR>       4096 boot
+   <DIR>      12288 etc
+   <DIR>       4096 media
+   <DIR>       4096 bin
+   <DIR>       4096 dev
+   <DIR>       4096 home
+   <DIR>       4096 lib
+   <DIR>       4096 lib64
+   <DIR>       4096 mnt
+   <DIR>       4096 opt
+   <DIR>       4096 proc
+   <DIR>       4096 root
+   <DIR>       4096 run
+   <DIR>      12288 sbin
+   <DIR>       4096 srv
+   <DIR>       4096 sys
+   <DIR>       4096 tmp
+   <DIR>       4096 usr
+   <DIR>       4096 var
+   <SYM>         33 initrd.img
+   <SYM>         30 vmlinuz
+   <DIR>       4096 cdrom
+   <SYM>         33 initrd.img.old
+   =>
+
+and if you look in the /boot directory you will see the kernel::
+
+   => ext2ls scsi 0:2 /boot
+   <DIR>       4096 .
+   <DIR>       4096 ..
+   <DIR>       4096 efi
+   <DIR>       4096 grub
+            3381262 System.map-3.13.0-32-generic
+            1162712 abi-3.13.0-32-generic
+             165611 config-3.13.0-32-generic
+             176500 memtest86+.bin
+             178176 memtest86+.elf
+             178680 memtest86+_multiboot.bin
+            5798112 vmlinuz-3.13.0-32-generic
+             165762 config-3.13.0-58-generic
+            1165129 abi-3.13.0-58-generic
+            5823136 vmlinuz-3.13.0-58-generic
+           19215259 initrd.img-3.13.0-58-generic
+            3391763 System.map-3.13.0-58-generic
+            5825048 vmlinuz-3.13.0-58-generic.efi.signed
+           28304443 initrd.img-3.13.0-32-generic
+   =>
+
+The 'vmlinuz' files contain a packaged Linux kernel. The format is a kind of
+self-extracting compressed file mixed with some 'setup' configuration data.
+Despite its size (uncompressed it is >10MB) this only includes a basic set of
+device drivers, enough to boot on most hardware types.
+
+The 'initrd' files contain a RAM disk. This is something that can be loaded
+into RAM and will appear to Linux like a disk. Ubuntu uses this to hold lots
+of drivers for whatever hardware you might have. It is loaded before the
+real root disk is accessed.
+
+The numbers after the end of each file are the version. Here it is Linux
+version 3.13. You can find the source code for this in the Linux tree with
+the tag v3.13. The '.0' allows for additional Linux releases to fix problems,
+but normally this is not needed. The '-58' is used by Ubuntu. Each time they
+release a new kernel they increment this number. New Ubuntu versions might
+include kernel patches to fix reported bugs. Stable kernels can exist for
+some years so this number can get quite high.
+
+The '.efi.signed' kernel is signed for EFI's secure boot. U-Boot has its own
+secure boot mechanism - see `this`_ & `that`_. It cannot read .efi files
+at present.
+
+To boot Ubuntu from U-Boot the steps are as follows:
+
+1. Set up the boot arguments. Use the GUID for the partition you want to boot::
+
+   => setenv bootargs root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro
+
+Here root= tells Linux the location of its root disk. The disk is specified
+by its GUID, using '/dev/disk/by-partuuid/', a Linux path to a 'directory'
+containing all the GUIDs Linux has found. When it starts up, there will be a
+file in that directory with this name in it. It is also possible to use a
+device name here, see later.
+
+2. Load the kernel. Since it is an ext2/4 filesystem we can do::
+
+   => ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic
+
+The address 30000000 is arbitrary, but there seem to be problems with using
+small addresses (sometimes Linux cannot find the ramdisk). This is 48MB into
+the start of RAM (which is at 0 on x86).
+
+3. Load the ramdisk (to 64MB)::
+
+   => ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic
+
+4. Start up the kernel. We need to know the size of the ramdisk, but can use
+   a variable for that. U-Boot sets 'filesize' to the size of the last file it
+   loaded::
+
+   => zboot 03000000 0 04000000 ${filesize}
+
+Type 'help zboot' if you want to see what the arguments are. U-Boot on x86 is
+quite verbose when it boots a kernel. You should see these messages from
+U-Boot::
+
+   Valid Boot Flag
+   Setup Size = 0x00004400
+   Magic signature found
+   Using boot protocol version 2.0c
+   Linux kernel version 3.13.0-58-generic (buildd@allspice) #97-Ubuntu SMP Wed Jul 8 02:56:15 UTC 2015
+   Building boot_params at 0x00090000
+   Loading bzImage at address 100000 (5805728 bytes)
+   Magic signature found
+   Initial RAM disk at linear address 0x04000000, size 19215259 bytes
+   Kernel command line: "root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro"
+
+   Starting kernel ...
+
+U-Boot prints out some bootstage timing. This is more useful if you put the
+above commands into a script since then it will be faster::
+
+   Timer summary in microseconds:
+          Mark    Elapsed  Stage
+             0          0  reset
+       241,535    241,535  board_init_r
+     2,421,611  2,180,076  id=64
+     2,421,790        179  id=65
+     2,428,215      6,425  main_loop
+    48,860,584 46,432,369  start_kernel
+
+   Accumulated time:
+                  240,329  ahci
+                1,422,704  vesa display
+
+Now the kernel actually starts (if you want to examine kernel boot up message on
+the serial console, append "console=ttyS0,115200" to the kernel command line)::
+
+   [    0.000000] Initializing cgroup subsys cpuset
+   [    0.000000] Initializing cgroup subsys cpu
+   [    0.000000] Initializing cgroup subsys cpuacct
+   [    0.000000] Linux version 3.13.0-58-generic (buildd@allspice) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #97-Ubuntu SMP Wed Jul 8 02:56:15 UTC 2015 (Ubuntu 3.13.0-58.97-generic 3.13.11-ckt22)
+   [    0.000000] Command line: root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro console=ttyS0,115200
+
+It continues for a long time. Along the way you will see it pick up your
+ramdisk::
+
+   [    0.000000] RAMDISK: [mem 0x04000000-0x05253fff]
+   ...
+   [    0.788540] Trying to unpack rootfs image as initramfs...
+   [    1.540111] Freeing initrd memory: 18768K (ffff880004000000 - ffff880005254000)
+   ...
+
+Later it actually starts using it::
+
+   Begin: Running /scripts/local-premount ... done.
+
+You should also see your boot disk turn up::
+
+   [    4.357243] scsi 1:0:0:0: Direct-Access     ATA      ADATA SP310      5.2  PQ: 0 ANSI: 5
+   [    4.366860] sd 1:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 GB/29.8 GiB)
+   [    4.375677] sd 1:0:0:0: Attached scsi generic sg0 type 0
+   [    4.381859] sd 1:0:0:0: [sda] Write Protect is off
+   [    4.387452] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
+   [    4.399535]  sda: sda1 sda2 sda3
+
+Linux has found the three partitions (sda1-3). Mercifully it doesn't print out
+the GUIDs. In step 1 above we could have used::
+
+   setenv bootargs root=/dev/sda2 ro
+
+instead of the GUID. However if you add another drive to your board the
+numbering may change whereas the GUIDs will not. So if your boot partition
+becomes sdb2, it will still boot. For embedded systems where you just want to
+boot the first disk, you have that option.
+
+The last thing you will see on the console is mention of plymouth (which
+displays the Ubuntu start-up screen) and a lot of 'Starting' messages::
+
+   * Starting Mount filesystems on boot                                   [ OK ]
+
+After a pause you should see a login screen on your display and you are done.
+
+If you want to put this in a script you can use something like this::
+
+   setenv bootargs root=UUID=b2aaf743-0418-4d90-94cc-3e6108d7d968 ro
+   setenv boot zboot 03000000 0 04000000 \${filesize}
+   setenv bootcmd "ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic; ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic; run boot"
+   saveenv
+
+The \ is to tell the shell not to evaluate ${filesize} as part of the setenv
+command.
+
+You can also bake this behaviour into your build by hard-coding the
+environment variables if you add this to minnowmax.h:
+
+.. code-block:: c
+
+	#undef CONFIG_BOOTCOMMAND
+	#define CONFIG_BOOTCOMMAND	\
+		"ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic; " \
+		"ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic; " \
+		"run boot"
+
+	#undef CFG_EXTRA_ENV_SETTINGS
+	#define CFG_EXTRA_ENV_SETTINGS "boot=zboot 03000000 0 04000000 ${filesize}"
+
+and change CONFIG_BOOTARGS value in configs/minnowmax_defconfig to::
+
+   CONFIG_BOOTARGS="root=/dev/sda2 ro"
+
+.. _here: https://en.wikipedia.org/wiki/GUID_Partition_Table
+.. _this: http://events.linuxfoundation.org/sites/events/files/slides/chromeos_and_diy_vboot_0.pdf
+.. _that: http://events.linuxfoundation.org/sites/events/files/slides/elce-2014.pdf
diff --git a/doc/arch/x86/x86.rst b/doc/arch/x86/x86.rst
index e75b5a73ffc0..c435225da4eb 100644
--- a/doc/arch/x86/x86.rst
+++ b/doc/arch/x86/x86.rst
@@ -97,272 +97,9 @@ mtrr
 
 Booting Ubuntu
 --------------
-As an example of how to set up your boot flow with U-Boot, here are
-instructions for starting Ubuntu from U-Boot. These instructions have been
-tested on Minnowboard MAX with a SATA drive but are equally applicable on
-other platforms and other media. There are really only four steps and it's a
-very simple script, but a more detailed explanation is provided here for
-completeness.
-
-Note: It is possible to set up U-Boot to boot automatically using syslinux.
-It could also use the grub.cfg file (/efi/ubuntu/grub.cfg) to obtain the
-GUID. If you figure these out, please post patches to this README.
-
-Firstly, you will need Ubuntu installed on an available disk. It should be
-possible to make U-Boot start a USB start-up disk but for now let's assume
-that you used another boot loader to install Ubuntu.
-
-Use the U-Boot command line to find the UUID of the partition you want to
-boot. For example our disk is SCSI device 0::
-
-   => part list scsi 0
-
-   Partition Map for SCSI device 0  --   Partition Type: EFI
-
-      Part	Start LBA	End LBA		Name
-        Attributes
-        Type GUID
-        Partition GUID
-      1	0x00000800	0x001007ff	""
-        attrs:	0x0000000000000000
-        type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
-        guid:	9d02e8e4-4d59-408f-a9b0-fd497bc9291c
-      2	0x00100800	0x037d8fff	""
-        attrs:	0x0000000000000000
-        type:	0fc63daf-8483-4772-8e79-3d69d8477de4
-        guid:	965c59ee-1822-4326-90d2-b02446050059
-      3	0x037d9000	0x03ba27ff	""
-        attrs:	0x0000000000000000
-        type:	0657fd6d-a4ab-43c4-84e5-0933c84b4f4f
-        guid:	2c4282bd-1e82-4bcf-a5ff-51dedbf39f17
-      =>
-
-This shows that your SCSI disk has three partitions. The really long hex
-strings are called Globally Unique Identifiers (GUIDs). You can look up the
-'type' ones `here`_. On this disk the first partition is for EFI and is in
-VFAT format (DOS/Windows)::
-
-   => fatls scsi 0:1
-               efi/
-
-   0 file(s), 1 dir(s)
-
-
-Partition 2 is 'Linux filesystem data' so that will be our root disk. It is
-in ext2 format::
-
-   => ext2ls scsi 0:2
-   <DIR>       4096 .
-   <DIR>       4096 ..
-   <DIR>      16384 lost+found
-   <DIR>       4096 boot
-   <DIR>      12288 etc
-   <DIR>       4096 media
-   <DIR>       4096 bin
-   <DIR>       4096 dev
-   <DIR>       4096 home
-   <DIR>       4096 lib
-   <DIR>       4096 lib64
-   <DIR>       4096 mnt
-   <DIR>       4096 opt
-   <DIR>       4096 proc
-   <DIR>       4096 root
-   <DIR>       4096 run
-   <DIR>      12288 sbin
-   <DIR>       4096 srv
-   <DIR>       4096 sys
-   <DIR>       4096 tmp
-   <DIR>       4096 usr
-   <DIR>       4096 var
-   <SYM>         33 initrd.img
-   <SYM>         30 vmlinuz
-   <DIR>       4096 cdrom
-   <SYM>         33 initrd.img.old
-   =>
-
-and if you look in the /boot directory you will see the kernel::
-
-   => ext2ls scsi 0:2 /boot
-   <DIR>       4096 .
-   <DIR>       4096 ..
-   <DIR>       4096 efi
-   <DIR>       4096 grub
-            3381262 System.map-3.13.0-32-generic
-            1162712 abi-3.13.0-32-generic
-             165611 config-3.13.0-32-generic
-             176500 memtest86+.bin
-             178176 memtest86+.elf
-             178680 memtest86+_multiboot.bin
-            5798112 vmlinuz-3.13.0-32-generic
-             165762 config-3.13.0-58-generic
-            1165129 abi-3.13.0-58-generic
-            5823136 vmlinuz-3.13.0-58-generic
-           19215259 initrd.img-3.13.0-58-generic
-            3391763 System.map-3.13.0-58-generic
-            5825048 vmlinuz-3.13.0-58-generic.efi.signed
-           28304443 initrd.img-3.13.0-32-generic
-   =>
-
-The 'vmlinuz' files contain a packaged Linux kernel. The format is a kind of
-self-extracting compressed file mixed with some 'setup' configuration data.
-Despite its size (uncompressed it is >10MB) this only includes a basic set of
-device drivers, enough to boot on most hardware types.
-
-The 'initrd' files contain a RAM disk. This is something that can be loaded
-into RAM and will appear to Linux like a disk. Ubuntu uses this to hold lots
-of drivers for whatever hardware you might have. It is loaded before the
-real root disk is accessed.
-
-The numbers after the end of each file are the version. Here it is Linux
-version 3.13. You can find the source code for this in the Linux tree with
-the tag v3.13. The '.0' allows for additional Linux releases to fix problems,
-but normally this is not needed. The '-58' is used by Ubuntu. Each time they
-release a new kernel they increment this number. New Ubuntu versions might
-include kernel patches to fix reported bugs. Stable kernels can exist for
-some years so this number can get quite high.
-
-The '.efi.signed' kernel is signed for EFI's secure boot. U-Boot has its own
-secure boot mechanism - see `this`_ & `that`_. It cannot read .efi files
-at present.
-
-To boot Ubuntu from U-Boot the steps are as follows:
-
-1. Set up the boot arguments. Use the GUID for the partition you want to boot::
-
-   => setenv bootargs root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro
-
-Here root= tells Linux the location of its root disk. The disk is specified
-by its GUID, using '/dev/disk/by-partuuid/', a Linux path to a 'directory'
-containing all the GUIDs Linux has found. When it starts up, there will be a
-file in that directory with this name in it. It is also possible to use a
-device name here, see later.
-
-2. Load the kernel. Since it is an ext2/4 filesystem we can do::
-
-   => ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic
-
-The address 30000000 is arbitrary, but there seem to be problems with using
-small addresses (sometimes Linux cannot find the ramdisk). This is 48MB into
-the start of RAM (which is at 0 on x86).
-
-3. Load the ramdisk (to 64MB)::
-
-   => ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic
-
-4. Start up the kernel. We need to know the size of the ramdisk, but can use
-   a variable for that. U-Boot sets 'filesize' to the size of the last file it
-   loaded::
-
-   => zboot 03000000 0 04000000 ${filesize}
-
-Type 'help zboot' if you want to see what the arguments are. U-Boot on x86 is
-quite verbose when it boots a kernel. You should see these messages from
-U-Boot::
-
-   Valid Boot Flag
-   Setup Size = 0x00004400
-   Magic signature found
-   Using boot protocol version 2.0c
-   Linux kernel version 3.13.0-58-generic (buildd@allspice) #97-Ubuntu SMP Wed Jul 8 02:56:15 UTC 2015
-   Building boot_params at 0x00090000
-   Loading bzImage at address 100000 (5805728 bytes)
-   Magic signature found
-   Initial RAM disk at linear address 0x04000000, size 19215259 bytes
-   Kernel command line: "root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro"
-
-   Starting kernel ...
-
-U-Boot prints out some bootstage timing. This is more useful if you put the
-above commands into a script since then it will be faster::
-
-   Timer summary in microseconds:
-          Mark    Elapsed  Stage
-             0          0  reset
-       241,535    241,535  board_init_r
-     2,421,611  2,180,076  id=64
-     2,421,790        179  id=65
-     2,428,215      6,425  main_loop
-    48,860,584 46,432,369  start_kernel
-
-   Accumulated time:
-                  240,329  ahci
-                1,422,704  vesa display
-
-Now the kernel actually starts (if you want to examine kernel boot up message on
-the serial console, append "console=ttyS0,115200" to the kernel command line)::
-
-   [    0.000000] Initializing cgroup subsys cpuset
-   [    0.000000] Initializing cgroup subsys cpu
-   [    0.000000] Initializing cgroup subsys cpuacct
-   [    0.000000] Linux version 3.13.0-58-generic (buildd@allspice) (gcc version 4.8.2 (Ubuntu 4.8.2-19ubuntu1) ) #97-Ubuntu SMP Wed Jul 8 02:56:15 UTC 2015 (Ubuntu 3.13.0-58.97-generic 3.13.11-ckt22)
-   [    0.000000] Command line: root=/dev/disk/by-partuuid/965c59ee-1822-4326-90d2-b02446050059 ro console=ttyS0,115200
-
-It continues for a long time. Along the way you will see it pick up your
-ramdisk::
-
-   [    0.000000] RAMDISK: [mem 0x04000000-0x05253fff]
-   ...
-   [    0.788540] Trying to unpack rootfs image as initramfs...
-   [    1.540111] Freeing initrd memory: 18768K (ffff880004000000 - ffff880005254000)
-   ...
-
-Later it actually starts using it::
-
-   Begin: Running /scripts/local-premount ... done.
-
-You should also see your boot disk turn up::
-
-   [    4.357243] scsi 1:0:0:0: Direct-Access     ATA      ADATA SP310      5.2  PQ: 0 ANSI: 5
-   [    4.366860] sd 1:0:0:0: [sda] 62533296 512-byte logical blocks: (32.0 GB/29.8 GiB)
-   [    4.375677] sd 1:0:0:0: Attached scsi generic sg0 type 0
-   [    4.381859] sd 1:0:0:0: [sda] Write Protect is off
-   [    4.387452] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
-   [    4.399535]  sda: sda1 sda2 sda3
-
-Linux has found the three partitions (sda1-3). Mercifully it doesn't print out
-the GUIDs. In step 1 above we could have used::
-
-   setenv bootargs root=/dev/sda2 ro
-
-instead of the GUID. However if you add another drive to your board the
-numbering may change whereas the GUIDs will not. So if your boot partition
-becomes sdb2, it will still boot. For embedded systems where you just want to
-boot the first disk, you have that option.
-
-The last thing you will see on the console is mention of plymouth (which
-displays the Ubuntu start-up screen) and a lot of 'Starting' messages::
-
-   * Starting Mount filesystems on boot                                   [ OK ]
-
-After a pause you should see a login screen on your display and you are done.
-
-If you want to put this in a script you can use something like this::
-
-   setenv bootargs root=UUID=b2aaf743-0418-4d90-94cc-3e6108d7d968 ro
-   setenv boot zboot 03000000 0 04000000 \${filesize}
-   setenv bootcmd "ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic; ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic; run boot"
-   saveenv
-
-The \ is to tell the shell not to evaluate ${filesize} as part of the setenv
-command.
-
-You can also bake this behaviour into your build by hard-coding the
-environment variables if you add this to minnowmax.h:
-
-.. code-block:: c
-
-	#undef CONFIG_BOOTCOMMAND
-	#define CONFIG_BOOTCOMMAND	\
-		"ext2load scsi 0:2 03000000 /boot/vmlinuz-3.13.0-58-generic; " \
-		"ext2load scsi 0:2 04000000 /boot/initrd.img-3.13.0-58-generic; " \
-		"run boot"
-
-	#undef CFG_EXTRA_ENV_SETTINGS
-	#define CFG_EXTRA_ENV_SETTINGS "boot=zboot 03000000 0 04000000 ${filesize}"
-
-and change CONFIG_BOOTARGS value in configs/minnowmax_defconfig to::
-
-   CONFIG_BOOTARGS="root=/dev/sda2 ro"
+Typically U-Boot boots distributions automatically so long an `CONFIG_BOOTSTD`,
+`CONFIG_BOOTSTD_DEFAULTS` and `CONFIG_EFI_LOADER` are enabled. See
+:doc:`manual_boot` for how to do this manually.
 
 Test with SeaBIOS
 -----------------
@@ -747,8 +484,5 @@ TODO List
 .. _microcode: http://en.wikipedia.org/wiki/Microcode
 .. _SFI: http://simplefirmware.org
 .. _MP: http://www.intel.com/design/archives/processors/pro/docs/242016.htm
-.. _here: https://en.wikipedia.org/wiki/GUID_Partition_Table
-.. _this: http://events.linuxfoundation.org/sites/events/files/slides/chromeos_and_diy_vboot_0.pdf
-.. _that: http://events.linuxfoundation.org/sites/events/files/slides/elce-2014.pdf
 .. _SeaBIOS: http://www.seabios.org/SeaBIOS
 .. _ACPI: http://www.acpi.info
-- 
2.42.0.rc1.204.g551eb34607-goog

