Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE16CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 14:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A547B84908;
	Tue, 16 Jun 2026 16:25:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oBjEuxKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AECC68493A; Tue, 16 Jun 2026 16:25:11 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCCB848EB
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 16:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-43bfe055ffbso2933900fac.1
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1781619907; x=1782224707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XeDq+tQSRbgi2jiSaU1600OaRoObpFXjsce5w79Lliw=;
 b=oBjEuxKVVha8uN0ToftLrMIo2I8sNO9YMHggj+6J9VEFwEbGBA7oalt4M3S5+jS4e4
 BzJQFJM7utQQv8VWDwbQTeEOY7Jn69fK5I+YscLVD9WJ5D2VPiMnKFxgAuE1fOLMM2Kn
 mDETc4fo3Xvcvi5y++FUh+uRGHkfrrSh+YCA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781619907; x=1782224707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XeDq+tQSRbgi2jiSaU1600OaRoObpFXjsce5w79Lliw=;
 b=YCWuPvVxHaPYbcBRqmnHxXb+NStQPsfx3/y8d2eWTgNtnjKGEvHkNnzij4r3qO2NH2
 DLCRSlgNRariZNoJpS6HXs+FpaSQjjEtkvjpnzn+FhSEh0q/gp2sRQM4+8c4oDLrFRej
 RatTbFYWdqjvW9MTZda2ivNjVii75QPkoWWQ5XvnsCrYRPVNMlAyNwHwDIR9+uxxBOxl
 HApzp866rsJRrCyeb5IAoAxqgod5uQ1vBUQwdrI560VEUrUYuKuOkuxyWXBXDU3XRA2G
 D1cysTuL2xUuskJwIytgvlF16ybVNGlwpovuXJt6OXaer0S8fLZn0WFE1xmBDBN67YsV
 TCUA==
X-Gm-Message-State: AOJu0Yzt4hhiKoOD7n/pRikJd8Fauxb3arGAxtQkGymTy9+3MAK0Xb/E
 SI6vLxDS4I/JehobWujfj/kZ9HMyZOGudn0j79w0FnRw45S8j8CKuI9V84rSOmfNHwma9tu2a+7
 Bo3U=
X-Gm-Gg: Acq92OHcLJnLHNFXYKtwMKp4P/UO/EljqZwjjUovw1O5v3A+zPQN87zxfjjeT74BYZS
 FreRkyR8PXCDGKoV3oKLWgLEkk/IMDKjnYALFhkSG0E9cLdAQgKFxgi9P8OAg85Y26oeH0tZm8k
 /g/OW6sBMeL+rzf9UKyJtB1SGMlpxEy6G2Jboj4B9cnB5pBkE+9v55ygWExF5iqsY0oXK0Srkh5
 GycWNrZ0TO0C2PfUiounri81ETasOhwWDIbmWJ8vpuAsDy3LNwHLNhpGGfCSa0jqnVaczacqDTG
 Flbpl38+3HEqXpb1C73FfttREF8hQUFUO3W/+BKIBqyLwuNRKrPxQ4pY7N0M66E+7JCNcF2G1EK
 fwSdp5KxJGL0EMCXMn2UloXz63S+oHRKnsu3ys1Z/l+1vpNpKVrRKKwtGWYMSGn+Gsww+PiYcbL
 mltpV9C6PKXDXQi11BQQ==
X-Received: by 2002:a05:6870:639e:b0:440:67b1:b59a with SMTP id
 586e51a60fabf-4430b5e5564mr3062860fac.16.1781619907388; 
 Tue, 16 Jun 2026 07:25:07 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4430900e368sm2215230fac.16.2026.06.16.07.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 07:25:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/5] doc: edison: Rewrite the update instructions
Date: Tue, 16 Jun 2026 08:24:20 -0600
Message-ID: <20260616142444.48193-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616142444.48193-1-sjg@chromium.org>
References: <20260616142444.48193-1-sjg@chromium.org>
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
the mask ROM needs and which binman output to flash (rather than the
bare u-boot.bin), note that a bricked board enters DnX without any
straps, and add udev rules for running the tools without sudo.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Keep a reference to the stock U-Boot v2014.04 the board ships with
- Flash the binman-built u-boot-edison-dfu.bin over DFU instead of
  prepending the 4KB gap to u-boot.bin by hand
- Restore the xFSTK progress output and the note that the reconnection
  attempts are normal
- Refer to the board as the Intel Edison

 doc/board/intel/edison.rst | 178 +++++++++++++++----------------------
 1 file changed, 74 insertions(+), 104 deletions(-)

diff --git a/doc/board/intel/edison.rst b/doc/board/intel/edison.rst
index 782d75a6745..9594d4d7721 100644
--- a/doc/board/intel/edison.rst
+++ b/doc/board/intel/edison.rst
@@ -4,48 +4,77 @@
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
+This produces ``u-boot.bin`` (the raw U-Boot binary), ``u-boot-edison-dfu.bin``
+(U-Boot with the 4KB alignment gap ahead of it, for flashing over DFU) and
+``u-boot-edison.img`` (the full image, with the OSIP header that the mask ROM
+expects, used by the xFSTK recovery flow below).
 
-By default Intel Edison boards are shipped with preinstalled heavily
-patched U-Boot v2014.04. Though it supports DFU which we may be able to
-use.
+.. note::
 
-1. Prepare u-boot.bin as described in chapter above. You still need one
-   more step (if and only if you have original U-Boot), i.e. run the
-   following command::
+   The mask ROM loads the OS image to 0x01100000 but jumps to 0x01101000, so
+   U-Boot must sit 4KB into the loaded data. binman provides this gap, padding
+   with 4KB of zeroes ahead of U-Boot in both ``u-boot-edison-dfu.bin`` and
+   ``u-boot-edison.img``. The bare ``u-boot.bin`` does not contain the padding,
+   so flash one of those binman outputs rather than ``u-boot.bin`` itself.
 
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
+By default Intel Edison boards ship with a heavily patched stock U-Boot
+v2014.04. It also provides DFU, so this same procedure can replace it with an
+upstream build.
 
-4. Return to U-Boot console and following hint. i.e. push Ctrl+C, and
-   reset the board::
+1. Reset the board, interrupt autoboot to reach the U-Boot prompt and start
+   DFU::
+
+     => run do_dfu_alt_info_mmc
+     => dfu 0 mmc 0
+
+   U-Boot also opens this window automatically for a few seconds during boot
+   (see ``dfu_to_sec`` and ``do_probe_dfu`` in the environment), so a host can
+   flash without stopping at the prompt.
+
+2. From the host, write the binman-built payload to the ``u-boot0``
+   partition::
+
+     $ dfu-util -d 8087:0a99 --alt u-boot0 -D u-boot-edison-dfu.bin
+
+3. Stop DFU on the board (Ctrl+C) and reset::
 
      => reset
 
-Updating U-Boot using xFSTK
----------------------------
+Recovering a board with xFSTK
+-----------------------------
 
-You can also update U-Boot using the xfstk-dldr-solo tool if you can build it.
-One way to do that is to follow the `xFSTK`_ instructions. In short, after you
-install all necessary dependencies and clone repository, it will look like this:
+Use this when the board has no usable U-Boot -- a blank or bricked board, or to
+install U-Boot for the first time. It reflashes both the Intel firmware (IFWI)
+and U-Boot through the mask ROM, so it needs the Intel Edison recovery image
+(the DNX and IFWI blobs) in addition to ``u-boot-edison.img``.
+
+A board with no valid firmware drops into the mask ROM's DnX download mode (USB
+ID 8086:e005) automatically on power-up; no recovery straps are needed for that.
+The FM/RM straps only force an otherwise-healthy board into recovery.
+
+You need the ``xfstk-dldr-solo`` tool. If your distribution does not package it,
+build it from the `xFSTK`_ sources:
 
 .. code-block:: sh
 
@@ -55,12 +84,12 @@ install all necessary dependencies and clone repository, it will look like this:
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
+Download and unpack the Intel Edison recovery image, then, with the board
+powered off, run:
 
 .. code-block:: sh
 
@@ -70,101 +99,42 @@ install dfu-util, reset your board and flash U-Boot like this:
       --fwimage recover/edison_ifwi-dbg-00.bin \
       --osdnx recover/edison_dnx_osr.bin
 
-This should show the following
+and power-cycle the board within about 10 seconds. The tool prints progress
+similar to this:
 
 .. code-block:: none
 
-  XFSTK Downloader Solo 1.8.5
-  Copyright (c) 2015 Intel Corporation
-  Build date and time: Aug 15 2020 15:07:13
-
-  .Intel SoC Device Detection Found
   Parsing Commandline....
   Registering Status Callback....
   .Initiating Download Process....
   .......(lots of dots)........XFSTK-STATUS--Reconnecting to device - Attempt #1
   .......(even more dots)......................
 
-You have about 10 seconds after resetting the board to type the above command.
-If you want to check if the board is ready, type:
+The reconnection attempts are normal and not a sign of trouble. To check that
+the board is in download mode, look for the mask ROM:
 
 .. code-block:: none
 
-  lsusb | grep -E "8087|8086"
+  $ lsusb | grep -E "8087|8086"
   Bus 001 Device 004: ID 8086:e005 Intel Corp.
 
-If you see a device with the same ID as above, the board is waiting for your
-command.
-
-After about 5 seconds you should see some console output from the board:
+A few seconds after the reset the board prints its PSH boot output, ending with:
 
 .. code-block:: none
 
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
   *** Ready to receive application ***
 
-After another 10 seconds the xFSTK tool completes and the board resets. About
-10 seconds after that should see the above message again and then within a few
-seconds U-Boot should start on your board:
+The tool then flashes the firmware and U-Boot and the board resets. Within a
+few seconds U-Boot starts, and once the DFU alt list appears (USB ID 8087:0a99)
+the board is ready for the DFU updates described above.
 
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

