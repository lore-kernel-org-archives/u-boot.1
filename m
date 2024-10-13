Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B911CF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A50B38880B;
	Mon, 14 Oct 2024 04:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gfjRl/e/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A16B88F0C; Sun, 13 Oct 2024 16:32:43 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 536DA88F16
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c936e8ea13so757903a12.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829956; x=1729434756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCoQvfkDwXPm85uTpboXspmhEDG/6Hf/vOK8cbBQhf4=;
 b=gfjRl/e/Apti+O2PZSb/yxO8tGFufJUmhxCZ6RDcLRS9tDLIiVs9NZElqeB+iR+qTr
 zBulSOGVduJh2d1RabHCGo3gmxwUUV+Vly8XI2xtwlEkkSQw2WVbJ4Xc6QiMwTTMWb4x
 HuSD028OZuMk+Zzvxw4dK4fwPUwYYwaYsSM0Qf7xwKAZ2gVWx29ta3kaSQriigajZHe7
 v8dGTPXiGNZ/sDL8yxw45rsbQ3lJZCKs1GpJNG8vDO/VIU0yxXSiB3/ZLAQHhd8Jn8dC
 QWDwjcpaTYOkfp4u7drn11PLrqVb533EyiEZN6lnXO8xrURPlmG3998coCV+pHpmxmVB
 NOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829956; x=1729434756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DCoQvfkDwXPm85uTpboXspmhEDG/6Hf/vOK8cbBQhf4=;
 b=mgr/1iwV1q3kM9JDwQTHAkQHZtClWe+Qy865J47dZtrALJEtJdQnduzHoHOusehR7/
 i3Kv+W8iB8YnrTOJKiYOiPWS6QUXBVVQYQGlik9DzgmZ6p5+Zx6T1u/jfoXMfbeCMS/R
 eno2PbakltZidnsok2+/chgCj/s7UeWo8lPnlNIGG2msNdk20Qobnvuxoe4kOM/IG5DP
 GmEd3aoR0YHqSr5Szapns2KOmnsrCC/ZeTb2EoTO8oW0fmfe4Vpjmm73dYmhEUePQYDs
 cRDKDyrzlhjywRLNERz5i+rgyo1mnleuqTAykhjitD+tkIUxGL9G9FzIB4VRdOYvNALC
 IT9A==
X-Gm-Message-State: AOJu0YwrFM00+2tCrEUvarfU52z1oTyXeOzpge1VSDEZPkNfK/qHU92O
 JvloD5DcRsFJwxX/bSdEiUX2bGy1+6AnIO4nr+Zwv1O2+FHAlg1VSYJdsQ==
X-Google-Smtp-Source: AGHT+IG6LZ4FKk9CGYV/7H7ewTiI8AJdDr7TZrxXODvnxz3ww4O3J9XQ3k7l/GXYUpHaVfCLeVWoqg==
X-Received: by 2002:a17:906:3941:b0:a99:f3a5:a310 with SMTP id
 a640c23a62f3a-a99f3a5a49fmr148526366b.4.1728829956042; 
 Sun, 13 Oct 2024 07:32:36 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:35 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 01/10] doc: board: enclustra: add Enclustra Mercury+ AA1
Date: Sun, 13 Oct 2024 14:32:23 +0000
Message-Id: <20241013143232.2090645-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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
related carrier board setups. The section covers the Mercury+ AA1 SoM
(Intel/arria10).

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 doc/board/enclustra/index.rst       |   9 ++
 doc/board/enclustra/mercury-aa1.rst | 204 ++++++++++++++++++++++++++++
 doc/board/index.rst                 |   1 +
 3 files changed, 214 insertions(+)
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
index 0000000000..c4b3359220
--- /dev/null
+++ b/doc/board/enclustra/mercury-aa1.rst
@@ -0,0 +1,204 @@
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
+Enclustra provides reference design examples which can be built with
+OpenEmbedded using their meta-layer.
+
+- Reference Design AA1 on ST1: https://github.com/enclustra/Mercury_AA1_ST1_Reference_Design
+- Reference Design AA1 on PE1: https://github.com/enclustra/Mercury_AA1_PE1_Reference_Design
+- Reference Design AA1 on PE3: https://github.com/enclustra/Mercury_AA1_PE3_Reference_Design
+- OpenEmbedded meta-layer: https://github.com/enclustra/meta-enclustra-socfpga
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
+a corresponding ``id`` file contained in a directory ``handoff``.
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
+``sd-aa1.cmd`` for SD/eMMC, or ``qspi-aa1.cmd`` for QSPI flash.
+
+.. code-block:: bash
+
+    $ ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "U-boot mmc startscript" -d board/enclustra/bootscripts/sd-aa1.cmd boot.scr
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
+three partitions as follows e.g. on /dev/sda (check before):
+
+* ``type=c, start=2048, size=409600``
+* ``type=a2, start=411648, size=14336``
+* ``type=83, start=425984, size=1619968``
+
+.. code-block:: bash
+
+    $ cat ./partitionmap.txt
+    start=        2048, size=      102400, type=b, bootable
+    start=      104448, size=        4096, type=a2
+    start=      108544, size=      819200, type=83
+
+    $ sudo sfdisk /dev/sde < ./partitionmap.txt
+
+Note: The ``fpga.itb`` is needed to start the bootloader. A kernel
+``system.dtb`` is needed to boot into the system. Both are not part of
+u-boot, but are be provided through OpenEmbedded using Enclustra's meta-layer.
+
+Generally the bitstream files depend on the logic design, but the meta-layer
+provides a demo design. Copy the ``bitstream.periph.rbf`` and
+``bitstream.core.rbf`` from your design or OpenEmbedded's deploy directory. The
+``fpga.its`` in board/enclustra then is used to bundle them.
+
+ .. code-block:: bash
+
+    $ cp <from quartus design>/bitstream.periph.rbf ./
+    $ cp <from quartus design>/bitstream.core.rbf ./
+    $ ./tools/mkimage -E -f ./board/enclustra/mercury_aa1/fpga.its fpga.itb
+
+Format the SD card, and copy the following artifacts to the mounted boot
+partition, e.g. on /dev/sda.
+
+ .. code-block:: bash
+
+    $ mkfs.vfat -n boot /dev/sda1
+    $ mount /dev/sda1 /media/boot
+    $ cp ./{boot.scr,u-boot.img,fpga.itb,Image,system.dtb} /media/boot/
+    $ umount /dev/sda1
+
+Flash the SPL directly.
+
+ .. code-block:: bash
+
+    $ sudo dd if=./spl/u-boot-splx4.sfp of=/dev/sda2 conv=fdatasync bs=4k status=progress
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
+Note: eMMC and QSPI can be flashed from off the u-boot shell. Usually after
+flashing, the coorect boot mode needs to be set by a BSEL switch. Approaches
+are described consistently in the official Enclustra documentation according to
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
index 3fb7c84f10..26feff48cd 100644
--- a/doc/board/index.rst
+++ b/doc/board/index.rst
@@ -25,6 +25,7 @@ Board-specific doc
    congatec/index
    coreboot/index
    emulation/index
+   enclustra/index
    gateworks/index
    google/index
    highbank/index
-- 
2.25.1

