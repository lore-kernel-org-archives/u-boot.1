Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D925CD8C8C
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 23:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073098484F;
	Mon,  8 Jun 2026 01:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cLoIfxFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7A4284869; Mon,  8 Jun 2026 01:05:45 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E2884825
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 01:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e71b2d527dso661423a34.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 16:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780873542; x=1781478342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ov9dvST6mgRXDbmZDXQj74tFpuDbJ8ZyS67yx3CMyUg=;
 b=cLoIfxFSrDcXxAg6VGHks+t+4vn0KKivM05xqBD17O9C6d6B7rfpim/qkhbReVmX8T
 tOIwP+4KXKNJsTK6oEK2mrqJM80tkdWh6sfqe1pjAUHWMuYzfQ3znwt8UT8uLkSF5Hpy
 qy4cqF9y6Nmtv5VnwvHVjJGZlzGvRsaAqBHlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780873542; x=1781478342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ov9dvST6mgRXDbmZDXQj74tFpuDbJ8ZyS67yx3CMyUg=;
 b=ktGAprsarag8R4LXG0P1GZfpuExnzUlajT77DuIbW0M+yJuQxnWVMHP4UyYU//uc+q
 qKnwe9XDE/fx5DBSaCxOmzNjrxRalZIMf/bxoVvcYje2cd6mxkiynjnjZJRIyChTcjMY
 obJBxwqKg4i8o9bN3fVvlEp3vTaDz+64TcoUpIHA5R+RQ8NzQeVz0gg7Zz4bfu5YHVM5
 CVCchWNxQ+mZNHm6rWtuFg4nJApN74McDyXwcckT/qOZ5RJBQsd12wkHwLTZa3X0V7+4
 9KuiQWeKC1ucn5BfqQ7U2zeYi/mdCzArps3530AOlLnwjLA0ppEGZ9HvlQENnZduzNNP
 bifw==
X-Gm-Message-State: AOJu0Yy4FXIiJzzy/a/FVHu6TIUJ6h+KAX1qCGAl3Nkt13n5UnjbX9qd
 szs403U2x22LjL9F6HVmRbrH8Md69U3GxICGzAS9YBb4iZmDZZkQI4KkU8vcMzH43qpWhBmlgNC
 +BZPZ+Q==
X-Gm-Gg: Acq92OExbjyFR0vbHQrej4DLgkFkzMlfbcNUv8l7xuW8sgXsTQOmCc/2XhrQJV12vfh
 rS0xxla8Ts7K2oRGIrAwjntk3yLRq22cDyn/NHhAsrW5z2kZsCaijrf7GbCOnB6gUU8WmuMtIDI
 +Q4wmWih0bPoQqlaghIM3inTwxv/ZOWbHz/MZo+Q2sCKaLdci+hcX326pN6KyLfVr/8mL/u28wj
 ZutBA5tj8P/emuNiuTZNJhTFomkRx0Iz0PEnyF7L3NMTvyMQJeVOH1VS3a6tnp7lBgJn2eWExAL
 ijX60uKyyAsTSlBwm++Rw6dXqZe5KdfYk5SDo4Kagd1wEclLoxsNRRJi/6aEk6NuVDaALKEVGRS
 GRrD9QT8ZyCHZv3nali1LJNVJ5jG6O6ldf01qBDsmBXZosj+i1ykI60mUTGP4q0S+tm/ta7pnep
 TJ/j2kZK1TD8kKUxBJXP8qXJIlFDIhsQwtYA72X3U=
X-Received: by 2002:a05:6820:c2d1:20b0:69d:7b82:3ce8 with SMTP id
 006d021491bc7-69e68c0bdadmr5196317eaf.32.1780873541702; 
 Sun, 07 Jun 2026 16:05:41 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7d4f449sm13916389fac.8.2026.06.07.16.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 16:05:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/5] doc: edison: Rewrite the update instructions
Date: Sun,  7 Jun 2026 17:05:14 -0600
Message-ID: <20260607230519.3022520-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260607230519.3022520-1-sjg@chromium.org>
References: <20260607230519.3022520-1-sjg@chromium.org>
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

Split the two ways of getting U-Boot onto the board: a plain DFU
transfer into u-boot0 when a working U-Boot is already present, and the
xFSTK mask ROM recovery when it is not. Drop the steps that only applied
to replacing the original 2014 U-Boot, document the 4KB alignment gap
the mask ROM needs (and that the bare u-boot.bin lacks), note that a
bricked board enters DnX without any straps, and add udev rules for
running the tools without sudo.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/board/intel/edison.rst | 187 ++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 118 deletions(-)

diff --git a/doc/board/intel/edison.rst b/doc/board/intel/edison.rst
index 782d75a6745..1d2b48f0a51 100644
--- a/doc/board/intel/edison.rst
+++ b/doc/board/intel/edison.rst
@@ -4,48 +4,75 @@
 Edison
 ======
 
-Build Instructions for U-Boot as main bootloader
-------------------------------------------------
+Building U-Boot
+---------------
 
-Simple you can build U-Boot and obtain u-boot.bin::
+Build U-Boot for the Edison::
 
    $ make edison_defconfig
-   $ make all
+   $ make
 
-Updating U-Boot on Edison
--------------------------
+This produces ``u-boot.bin`` (the raw U-Boot binary) and ``u-boot-edison.img``
+(the full image, with the OSIP header that the mask ROM expects, used by the
+xFSTK recovery flow below).
 
-By default Intel Edison boards are shipped with preinstalled heavily
-patched U-Boot v2014.04. Though it supports DFU which we may be able to
-use.
+.. note::
 
-1. Prepare u-boot.bin as described in chapter above. You still need one
-   more step (if and only if you have original U-Boot), i.e. run the
-   following command::
+   The mask ROM loads the OS image to 0x01100000 but jumps to 0x01101000, so
+   U-Boot must sit 4KB into the loaded data. binman pads ``u-boot-edison.img``
+   with 4KB of zeroes ahead of U-Boot to provide this gap. The bare
+   ``u-boot.bin`` does not contain the padding, so when flashing it directly
+   over DFU you must prepend the 4KB yourself (see below).
 
-     $ truncate -s %4096 u-boot.bin
+There are two ways to get U-Boot onto the board:
 
-2. Run your board and interrupt booting to U-Boot console. In the console
-   call::
+- over DFU, when the board already runs a working U-Boot -- this is the normal
+  case and needs nothing but ``dfu-util``;
+- with the xFSTK downloader, when the board has no usable firmware and has to
+  be recovered through the mask ROM.
 
-     => run do_force_flash_os
+Updating U-Boot over DFU
+------------------------
 
-3. Wait for few seconds, it will prepare environment variable and runs
-   DFU. Run DFU command from the host system::
+Once a working U-Boot is present, updating it is just a DFU transfer into the
+``u-boot0`` eMMC partition; the board boots the new U-Boot on the next reset.
 
-     $ dfu-util -v -d 8087:0a99 --alt u-boot0 -D u-boot.bin
+1. Prepend the 4KB alignment gap to ``u-boot.bin``::
 
-4. Return to U-Boot console and following hint. i.e. push Ctrl+C, and
-   reset the board::
+     $ { head -c 4096 /dev/zero; cat u-boot.bin; } > u-boot-edison-dfu.bin
+
+2. Reset the board, interrupt autoboot to reach the U-Boot prompt and start
+   DFU::
+
+     => run do_dfu_alt_info_mmc
+     => dfu 0 mmc 0
+
+   U-Boot also opens this window automatically for a few seconds during boot
+   (see ``dfu_to_sec`` and ``do_probe_dfu`` in the environment), so a host can
+   flash without stopping at the prompt.
+
+3. From the host, write the image to the ``u-boot0`` partition::
+
+     $ dfu-util -d 8087:0a99 --alt u-boot0 -D u-boot-edison-dfu.bin
+
+4. Stop DFU on the board (Ctrl+C) and reset::
 
      => reset
 
-Updating U-Boot using xFSTK
----------------------------
+Recovering a board with xFSTK
+-----------------------------
+
+Use this when the board has no usable U-Boot -- a blank or bricked board, or to
+install U-Boot for the first time. It reflashes both the Intel firmware (IFWI)
+and U-Boot through the mask ROM, so it needs the Edison recovery image (the DNX
+and IFWI blobs) in addition to ``u-boot-edison.img``.
 
-You can also update U-Boot using the xfstk-dldr-solo tool if you can build it.
-One way to do that is to follow the `xFSTK`_ instructions. In short, after you
-install all necessary dependencies and clone repository, it will look like this:
+A board with no valid firmware drops into the mask ROM's DnX download mode (USB
+ID 8086:e005) automatically on power-up; no recovery straps are needed for that.
+The FM/RM straps only force an otherwise-healthy board into recovery.
+
+You need the ``xfstk-dldr-solo`` tool. If your distribution does not package it,
+build it from the `xFSTK`_ sources:
 
 .. code-block:: sh
 
@@ -55,12 +82,12 @@ install all necessary dependencies and clone repository, it will look like this:
   git checkout v$BUILD_VERSION
   ...
 
-Once you have built it, you can copy xfstk-dldr-solo to /usr/local/bin and
-libboost_program_options.so.1.54.0 to /usr/lib/i386-linux-gnu/ and with luck
-it will work. You might find this `drive`_ helpful.
+Copy ``xfstk-dldr-solo`` to ``/usr/local/bin`` and
+``libboost_program_options.so.1.54.0`` to ``/usr/lib/i386-linux-gnu/``. You
+might find this `drive`_ helpful for the recovery image and the libraries.
 
-If it does, then you can download and unpack the Edison recovery image,
-install dfu-util, reset your board and flash U-Boot like this:
+Download and unpack the Edison recovery image, then, with the board powered
+off, run:
 
 .. code-block:: sh
 
@@ -70,101 +97,25 @@ install dfu-util, reset your board and flash U-Boot like this:
       --fwimage recover/edison_ifwi-dbg-00.bin \
       --osdnx recover/edison_dnx_osr.bin
 
-This should show the following
+and power-cycle the board within about 10 seconds. To check that the board is
+in download mode, look for the mask ROM:
 
 .. code-block:: none
 
-  XFSTK Downloader Solo 1.8.5
-  Copyright (c) 2015 Intel Corporation
-  Build date and time: Aug 15 2020 15:07:13
-
-  .Intel SoC Device Detection Found
-  Parsing Commandline....
-  Registering Status Callback....
-  .Initiating Download Process....
-  .......(lots of dots)........XFSTK-STATUS--Reconnecting to device - Attempt #1
-  .......(even more dots)......................
-
-You have about 10 seconds after resetting the board to type the above command.
-If you want to check if the board is ready, type:
-
-.. code-block:: none
-
-  lsusb | grep -E "8087|8086"
+  $ lsusb | grep -E "8087|8086"
   Bus 001 Device 004: ID 8086:e005 Intel Corp.
 
-If you see a device with the same ID as above, the board is waiting for your
-command.
-
-After about 5 seconds you should see some console output from the board:
+The tool flashes the firmware and U-Boot and the board resets. Within a few
+seconds U-Boot starts, and once the DFU alt list appears (USB ID 8087:0a99) the
+board is ready for the DFU updates described above.
 
-.. code-block:: none
-
-  ******************************
-  PSH KERNEL VERSION: b0182b2b
-  		WR: 20104000
-  ******************************
-
-  SCU IPC: 0x800000d0  0xfffce92c
-
-  PSH miaHOB version: TNG.B0.VVBD.0000000c
-
-  microkernel built 11:24:08 Feb  5 2015
-
-  ******* PSH loader *******
-  PCM page cache size = 192 KB
-  Cache Constraint = 0 Pages
-  Arming IPC driver ..
-  Adding page store pool ..
-  PagestoreAddr(IMR Start Address) = 0x04899000
-  pageStoreSize(IMR Size)          = 0x00080000
-
-  *** Ready to receive application ***
-
-After another 10 seconds the xFSTK tool completes and the board resets. About
-10 seconds after that should see the above message again and then within a few
-seconds U-Boot should start on your board:
-
-.. code-block:: none
-
-  U-Boot 2020.10-rc3 (Sep 03 2020 - 18:44:28 -0600)
-
-  CPU:   Genuine Intel(R) CPU   4000  @  500MHz
-  DRAM:  980.6 MiB
-  WDT:   Started with servicing (60s timeout)
-  MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
-  Loading Environment from MMC... OK
-  In:    serial
-  Out:   serial
-  Err:   serial
-  Saving Environment to MMC... Writing to redundant MMC(0)... OK
-  Saving Environment to MMC... Writing to MMC(0)... OK
-  Net:   No ethernet found.
-  Hit any key to stop autoboot:  0
-  Target:blank
-  Partitioning using GPT
-  Writing GPT: success!
-  Saving Environment to MMC... Writing to redundant MMC(0)... OK
-  Flashing already done...
-  5442816 bytes read in 238 ms (21.8 MiB/s)
-  Valid Boot Flag
-  Setup Size = 0x00003c00
-  Magic signature found
-  Using boot protocol version 2.0c
-  Linux kernel version 3.10.17-poky-edison+ (ferry@kalamata) #1 SMP PREEMPT Mon Jan 11 14:54:18 CET 2016
-  Building boot_params at 0x00090000
-  Loading bzImage at address 100000 (5427456 bytes)
-  Magic signature found
-  Kernel command line: "rootwait ..."
-  Magic signature found
-
-  Starting kernel ...
-
-  ...
+.. note::
 
-  Poky (Yocto Project Reference Distro) 1.7.2 edison ttyMFD2
+   To run ``dfu-util`` and ``xfstk-dldr-solo`` without ``sudo``, add udev rules
+   granting access to the Edison USB IDs, for example::
 
-  edison login:
+     SUBSYSTEM=="usb", ATTR{idVendor}=="8086", ATTR{idProduct}=="e005", MODE="0666"
+     SUBSYSTEM=="usb", ATTR{idVendor}=="8087", ATTR{idProduct}=="0a99", MODE="0666"
 
 .. _xFSTK: https://github.com/edison-fw/xFSTK
 .. _drive: https://drive.google.com/drive/u/0/folders/1URPHrOk9-UBsh8hjv-7WwC0W6Fy61uAJ
-- 
2.43.0

