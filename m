Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B9EEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10D5F88DAE;
	Thu, 12 Sep 2024 08:13:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bhtrfh3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4704A88DDA; Thu, 12 Sep 2024 08:06:56 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3F6188D6A
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c26fd60b7bso72261a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121212; x=1726726012; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxTh+cENqM/tR3TD+EzMZLpEkxFuHwGK5xXomJk/S3o=;
 b=bhtrfh3RzM3qrS6FIazHzS4hQRncC+ROx6StaSkWeYmt/y0ndbl/R4hJ6uAB1F5YkM
 bWAAzXrJTsOyjq2Q6+kYJnC9aAb+owE3RZHktVFrOCWa1XoCoL+es8E/UOKjFqsMcDto
 6MeYovFf3m+K+txNUX4I+sNTfC2oXPD2QQVaekJ3yePymGy1WqOeC3XPK2jN/B/ApuSd
 vuC/6ccfAuH8jLp6r4gAXifNEQmBgr9wz6NN4CxG+11Uri5pBW4awaQ79HqUzpuWza6F
 kn3MTQdPBN7mH6ReUR4b6F8ZCq3CJIzE/Al3FvEnf3aepGHnil30jDsDzc/W6yGH5UHE
 KlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121212; x=1726726012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxTh+cENqM/tR3TD+EzMZLpEkxFuHwGK5xXomJk/S3o=;
 b=J+d+n60Kop0sDM40zpKW734ydoP5eC7VWiuLCXh1VaYZvH9Kv6+7R0LC/ZcCz+oUka
 A7If+Utn7RCNeZ1yazZUXtS0w4H5wUgmaL9sr3/zRnq8iLVH1WDs8BKERZio63EPJygk
 jhFwg7+wlC/I7Q+hVeqI0+ScB6PWNbw25KDe5rNK5u+EL1MtjVKvWRAXYGWJzVdrM23g
 KaW0BcUHOIwdrxaCWAef5iACPwROPRtdtyTCVkxnUYgPW4sV1i6k5hH9W64ZRGHqhBRp
 dkRXRxU596j+VkepDW2oCG3w5uvic1G3L8MeqoTwq4S+Fj35maFgeOmHrY0eY0Rt2ATV
 SjIw==
X-Gm-Message-State: AOJu0YyQqkFQGjew/iAgHXgQeKZqXB5byagoqOdob76+pDbqIo+Gj2G1
 DpaLZMsiq415PhMpqa43SJzZZBk62s0HOCT4ku7VdYaoGeXjzSqyOAykeA==
X-Google-Smtp-Source: AGHT+IHyt65wOlWRzax1H/Ju+7kGNc2Hu+VkgLeQ540GXVqc9/ifdPIscOQWO2XplSgqhyROEzC2VA==
X-Received: by 2002:a17:907:6e8e:b0:a8d:2624:1a85 with SMTP id
 a640c23a62f3a-a9029641b35mr52940466b.12.1726121212025; 
 Wed, 11 Sep 2024 23:06:52 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:51 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 1/9] doc: board: enclustra: add Enclustra Intel AA1 SoM
Date: Thu, 12 Sep 2024 06:06:41 +0000
Message-Id: <20240912060649.190-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Start documentation section for Enclustra. Cover Enclustra Intel SoMs and
related carrier board setups.

- Mercury AA1 (Arria10)

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 doc/board/enclustra/index.rst       |   9 ++
 doc/board/enclustra/mercury-aa1.rst | 209 ++++++++++++++++++++++++++++
 doc/board/index.rst                 |   1 +
 3 files changed, 219 insertions(+)
 create mode 100644 doc/board/enclustra/index.rst
 create mode 100644 doc/board/enclustra/mercury-aa1.rst

diff --git a/doc/board/enclustra/index.rst b/doc/board/enclustra/index.rst
new file mode 100644
index 0000000000..00727d0861
--- /dev/null
+++ b/doc/board/enclustra/index.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Enclustra
+=========
+
+.. toctree::
+   :maxdepth: 2
+
+   mercury-aa1
diff --git a/doc/board/enclustra/mercury-aa1.rst b/doc/board/enclustra/mercury-aa1.rst
new file mode 100644
index 0000000000..0331756045
--- /dev/null
+++ b/doc/board/enclustra/mercury-aa1.rst
@@ -0,0 +1,209 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+.. sectionauthor:: Lothar Rubusch <l.rubusch@gmail.com>
+
+Mercury AA1 Module (Arria1 10)
+==============================
+
+- SoM: https://www.enclustra.com/en/products/system-on-chip-modules/mercury-aa1/
+- Carrier board Mercury+ ST1: https://www.enclustra.com/en/products/base-boards/mercury-st1/
+- Carrier board Mercury+ PE1: https://www.enclustra.com/en/products/base-boards/mercury-pe1-200-300-400/
+- Carrier board Mercury+ PE3: https://www.enclustra.com/en/products/base-boards/mercury-pe3/
+
+There are slightly different variants of the AA1 SoM, going by the identifier.
+
+- Me-aa1-270-2i2-d11e-nfx3
+- Me-aa1-270-3e4-d11e-nfx3
+- Me-aa1-480-2i3-d12e-nfx3
+
+The u-boot setup is specific to a quartus design. Generate handoff files from
+the design. Pass them to a python script to produce a handoff.h file. This is
+needed as input for building the device-tree for u-boot. Eventually, building
+the final u-boot depends on the particular Quartus design, the particular
+carrier board, the selected boot media and boot mode.
+
+Enclustra provides reference design examples which can be built with yocto
+using their meta-layer.
+
+- Reference Design AA1 on ST1: https://github.com/enclustra/Mercury_AA1_ST1_Reference_Design
+- Reference Design AA1 on PE1: https://github.com/enclustra/Mercury_AA1_PE1_Reference_Design
+- Reference Design AA1 on PE3: https://github.com/enclustra/Mercury_AA1_PE3_Reference_Design
+- Yocto meta-layer: https://github.com/enclustra/meta-enclustra-socfpga
+
+Quick Start
+-----------
+
+- Setup and build a Quartus design project
+- Obtain the hps.xml file from the Quartus design project
+- Generate the handoff.h file for u-boot
+- Adjust the device-tree file according to your setup
+- Build u-boot
+- Flash u-boot
+
+Build U-Boot
+------------
+
+The Quartus design produces a design specific ``hps.xml``, an ``emif.xml`` and
+a corresponding ``id`` file contained in a folder ``handoff``.
+
+Generate the handoff.h file for u-boot, from a provided ``hps.xml`` using the
+script provided in u-boot.
+
+.. code-block:: bash
+
+    $ arch/arm/mach-socfpga/qts-filter-a10.sh <where you saved it>/hps.xml arch/arm/dts/socfpga_arria10_mercury_aa1_handoff.h
+
+Adjust the device-tree file according to your setup. Follow the comments in the
+file.
+
+.. code-block:: bash
+
+    $ vi ./arch/arm/dts/enclustra-aa1.dts
+
+Build u-boot. Source your favorite toolchain for ARM first.
+
+.. code-block:: bash
+
+    $ make socfpga_enclustra_mercury_aa1_defconfig
+    $ make -j8
+
+Setup and compile a boot script as needed. Depending on the boot-mode select
+``sd-aa1.cmd`` for SD/eMMC, or ``qspi-aa1.cmd`` for QSPI flash. Also,
+optionally prepare an environment file. Examples of boot command files and
+environment files are provided.
+
+.. code-block:: bash
+
+    $ ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "Uboot mmc startscript" -d board/enclustra/bootscripts/sd-aa1.cmd boot.scr
+    $ ./tools/mkenvimage -s 0x80000 -o uboot.env board/enclustra/mercury_aa1/mercury_aa1.env
+
+Device-Tree setup
+-----------------
+
+The basic u-boot device-tree fragments are provided here. The handoff tools
+will generate further u-boot device-tree fragments. The various .dtsi files
+then need to be included in a top-level .dts file.
+
+Flash the U-Boot Binary to a Micro SD Card
+------------------------------------------
+
+The following example describes the full approach. Prepare a micro SD card with
+three partitions as follows:
+
+* ``type=c, start=2048, size=409600``
+* ``type=a2, start=411648, size=14336``
+* ``type=83, start=425984, size=1619968``
+
+.. code-block:: bash
+
+    $ sudo fdisk /dev/sda
+        n,p,1,2048,+20M
+        t,1,c
+        n,p,2,409600,+1M
+        t,2,a2
+        n,p,3,425984,<REST>
+        t,3,83
+        w
+
+Note: The ``bitstream.itb`` is needed to start the bootloader. A kernel
+``devicetree.dtb`` is needed to boot into the system. Both are not part of
+u-boot, but are be provided through yocto using Enclustra's meta-layer.
+
+Generally the bitstream files depend on the logic design, but the meta-layer
+provides a demo design. Copy the ``bitstream.periph.rbf`` and
+``bitstream.core.rbf`` from your design or yocto's deploy folder. The
+``bitstream.its`` in board/enclustra then is used to bundle them.
+
+ .. code-block:: bash
+
+    $ cp bitstream.periph.rbf ./board/enclustra/mercury_aa1/
+    $ cp bitstream.core.rbf ./board/enclustra/mercury_aa1/
+    $ ./tools/mkimage -E -f ./board/enclustra/mercury_aa1/bitstream.its bitstream.itb
+
+Format the SD card, and copy the following artifacts to the mounted boot
+partition, e.g. on /dev/sda (check before).
+
+ .. code-block:: bash
+
+    $ mkfs.vfat -n boot /dev/sda1
+    $ mount /dev/sda1 /media/boot
+    $ cp ./{boot.scr,u-boot.img,uboot.env,bitstream.itb,Image,devicetree.dtb} /media/boot/
+    $ umount /dev/sda1
+
+Flash the SPL directly.
+
+ .. code-block:: bash
+
+    $ dd if=./spl/u-boot-splx4.sfp of=/dev/sda2 conv=fdatasync bs=4k status=progress
+
+Format and flash a rootfs from image or files to the third partition.
+
+ .. code-block:: bash
+
+    $ mkfs.ext4 -L rootfs /dev/sda3
+    $ mount /dev/sda3 /media/rootfs
+    $ tar xf ./rootfs.tar -C /media/rootfs
+    $ umount /dev/sda3
+
+Boot Media
+----------
+
+Alternative boot media are possible as officially documented by Enclustra.
+
+* Micro-SD card
+* eMMC
+* QSPI
+
+NB: eMMC and QSPI can be flashed from off the u-boot shell. Usually after
+flashing, the coorect boot mode needs to be set by a BSEL switch. Approaches
+are described consistently in the offical Enclustra documentation according to
+their releases mentioned as links.
+
+Before turning on the setup, make sure to have the correct voltage configured
+at the carrier board, using the jumpers on the voltage pin header. Also make
+sure to have switched to the correct boot media using typically some dip
+switches to be found on the carrier board.
+
+Boot Log
+--------
+
+The demo shows booting a AA1 + ST1 setup and stopping at the u-boot shell.
+
+Here is the console output::
+
+  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)
+  FPGA: Checking FPGA configuration setting ...
+  FPGA: Start to program peripheral/full bitstream ...
+  FPGA: Early Release Succeeded.
+  FPGA: Checking FPGA configuration setting ...
+  FPGA: Start to program peripheral/full bitstream ...
+  FPGA: Early Release Succeeded.
+
+  U-Boot SPL 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)
+  DDRCAL: Success
+  DDRCAL: Scrubbing ECC RAM (2048 MiB).
+  DDRCAL: Scrubbing ECC RAM done.
+  FPGA: Checking FPGA configuration setting ...
+  FPGA: Start to program core bitstream ...
+  Full Configuration Succeeded.
+  FPGA: Enter user mode.
+  Trying to boot from MMC1
+
+
+  U-Boot 2024.10-rc4-00416-gf0b9c383e6c3 (Sep 08 2024 - 14:03:59 +0000)socfpga_arria10
+
+  CPU:   Altera SoCFPGA Arria 10
+  BOOT:  SD/MMC External Transceiver (1.8V)
+  Model: Enclustra Mercury+ AA1
+  DRAM:  2 GiB
+  Core:  80 devices, 20 uclasses, devicetree: separate
+  MMC:   dwmmc0@ff808000: 0
+  Loading Environment from FAT... OK
+  In:    serial
+  Out:   serial
+  Err:   serial
+  Model: Enclustra Mercury+ AA1
+  ethaddr set to 20:B0:F7:06:0D:BE
+  eth1addr set to 20:B0:F7:06:0D:BF
+  Net:   eth0: ethernet@ff800000
+  =>
+
diff --git a/doc/board/index.rst b/doc/board/index.rst
index 417c128c7a..42244a689b 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -24,6 +24,7 @@ Board-specific doc
    congatec/index
    coreboot/index
    emulation/index
+   enclustra/index
    gateworks/index
    google/index
    highbank/index
-- 
2.25.1

