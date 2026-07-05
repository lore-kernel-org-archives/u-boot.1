Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58580C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 06:09:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3063846FD;
	Sun,  5 Jul 2026 08:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="xiOqavet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC45E83314; Sun,  5 Jul 2026 08:09:08 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF027848F3
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 08:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-845ea8924fdso2076439b3a.0
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 23:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1783231744; x=1783836544;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OUrLkL1wGs6duYMrK4GVtDMO3sDpmE/Zm26zDtZafTM=;
 b=xiOqavetQMOABDvMp4dV5Yzp+fNcdkMNWIfCZhsNTN+9mFx8D1lXG9fYRc4+kI1iFY
 qJABl/EwgBgxTyGjiadcsHhNty3bJeA5VEYjJYZHMFoZ0CiZ61+ER75XZOzh9FU4AGrQ
 ubFXPFVPfQb4li+JYPUAD7WIngyqE+Jed97zaWgvqT24SvROPiyhrUKbtt64Nwe8lAyo
 aqB0Zg3MQk9QB18+7yB9uesK+lLWwxx7R9q8KOgODYNhZ9FRHT9scoo0lP0vLxoDdxrr
 624wJI17GTEOVlQ8s9I+xhQP9m0HPDta2olGq7SGpiIaNlGWqOW7xQQvuACz8JEpsjXR
 FtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783231744; x=1783836544;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OUrLkL1wGs6duYMrK4GVtDMO3sDpmE/Zm26zDtZafTM=;
 b=YRgAUCSRL94M20H9WMd6KcALbEsXrp2nPZzp51uT0fsflsBqFk4IX2mfRqEeQoC25j
 jPs/mW/DmB1iP/r/K6OCqfaRDASWWssPtftcmmlVML43o4WNI+7z7vnGjwgIZNpwYsCa
 KJxlov/MmZfBa6LZJWf28xo/2hPLQn3pIRCmIBDJzM4Rs2WstswLJ+SuJPf7ZDdt4nui
 ZrH4ym6OcodmlDdlZjaXiAinHw0ilOHn7BkfkXuDQEHl3FGc4F1HyLLbme0dV5w6uaCE
 ygrhJk3uhJ0e/rHTGvd4CDulK5ax+KZ+hl0OJt++ZPtCUw12af42r2VcRfRi+uZmRXwC
 Hksg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+b+sf//MrV2jvK9XbiB3DjvWCmMWFssp2SJPKmYBzxASve/hqqmPThqELVMm37q9ZDlaW/s/I=@lists.denx.de
X-Gm-Message-State: AOJu0YykvNrZ/ZvWKsZxytZDgkMc1OHYwOWBZUH5V5cv+UrLhQAJpvzh
 S1J4utrCWFyz6q5nCIKf+GU5yG3DO7el2aTgg2LmqLd3HH/klEsOtAfe2cAia4wP3eE=
X-Gm-Gg: AfdE7cmkqqzGGXlZZ/1W9lhIzUb6kEHrkDeN4+W84lnqcNprMtNv+r0D5uzLkn01qF/
 7LvrkiR8l8+aXPehsLyqNbG28f0+1sOmWgN/QgKSl2fR3yBp9isP4maRS/jn+zja2m/i0xwi9zO
 yDpi7ZGtPw0NMUbIY7PcZd4wFPvKUrAfUx2p5l9CEWN9YjEOEIb59W1X2koACH5BQwMviN7B74q
 rhOI45giu4vpTucZu8pmW87RyCa4JaTqsMC82p4pDV0vtHVPD/64YbMNQexZoxTTfGQIr4GumHF
 w0pxoBoxBEeez/hcyJcOeG9RJmTMXHKEaYpuIBcDKc5lTWBAlamgVpjD7k/yofaE0h6JSHQgVak
 fHI/4Zw1qDp9DmV1kM+dCTBM94/pjMPltyslHJMbcQgnjHCwGyMVOQnFg1b+LHBFehaILUJnA83
 0RiSv5KCLlldMfMRctqY+dZK+DQMNmhB16L7cePOFShR1AW2WzhUbuzmXU1B8teogY/xIOzhEnZ
 MnO6yuam9cQxzVcTzp267gRP6Sc7CRJs2jB7kbKN8ZHbgQyUWIHiw==
X-Received: by 2002:a05:6a20:9188:b0:3bf:d1f9:b1ca with SMTP id
 adf61e73a8af0-3c03e421934mr5495407637.30.1783231743796; 
 Sat, 04 Jul 2026 23:09:03 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f38ee1333sm22291719eec.24.2026.07.04.23.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 23:09:03 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 05 Jul 2026 14:07:58 +0800
Subject: [PATCH v3 7/9] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-m4-v3-7-5a9bc7f25fc5@riscstar.com>
References: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
In-Reply-To: <20260705-m4-v3-0-5a9bc7f25fc5@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong.xu@riscstar.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
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

Add document on how to flash images into eMMC of K1 SoC based boards.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v3:
- Add document on how to flash images into SD card.
---
 board/spacemit/k1/MAINTAINERS |   2 +-
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-mmc.rst | 320 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index ca994e2a1fb..7a34476ea7c 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -6,7 +6,7 @@ S:	Maintained
 F:	arch/riscv/dts/k1-*-u-boot.dtsi
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
-F:	doc/board/spacemit/bananapi-f3.rst
+F:	doc/board/spacemit/
 F:	drivers/gpio/spacemit_gpio.c
 F:	drivers/i2c/k1_i2c.c
 F:	drivers/mmc/spacemit_sdhci.c
diff --git a/doc/board/spacemit/index.rst b/doc/board/spacemit/index.rst
index a5e35ee12ab..71854e5735b 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,5 +6,6 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-mmc
    k1-spl
 
diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
new file mode 100644
index 00000000000..b0fe78c75ce
--- /dev/null
+++ b/doc/board/spacemit/k1-mmc.rst
@@ -0,0 +1,320 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 eMMC and SD Card Boot Guide
+=======================================
+
+This guide covers two separate methods for booting and flashing U-Boot on
+SpacemiT K1 based boards:
+
+1. **eMMC Flash**: Flashing U-Boot and SPL images to eMMC via USB fastboot.
+2. **SD Card Boot**: Creating a bootable Bianbu SD card and optionally
+   replacing U-Boot on the card.
+
+Tested boards: Banana Pi BPI-F3, MusePi Pro.
+
+
+Chapter 1: eMMC Flash (U-Boot via USB Fastboot)
+===============================================
+
+SpacemiT K1 U-Boot Flash Guide
+==============================
+
+This guide explains how to flash U-Boot on SpacemiT K1 based boards. It covers
+flashing images via USB fastboot.
+
+.. note::
+
+   This procedure flashes images to eMMC over USB fastboot. The fastboot
+   function is not enabled in our SPL yet, so the download stage runs the
+   SpacemiT released SPL; our built FSBL.bin and fit.itb are the images
+   written to eMMC and used on the next normal boot.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 board with USB Type-C and UART access
+- USB-to-UART adapter (3.3V TTL)
+- ``minicom`` or equivalent serial terminal, configured at 115200 8N1
+- ``fastboot`` and ``flashserver`` tool on the host
+
+Hardware Setup
+~~~~~~~~~~~~~~
+
+Refer to k1-spl.rst.
+
+Flash images on eMMC
+~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Get the release package from Spacemit website. It contains SPL image, and so on.
+
+https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip
+
+Unzip images and store them into a directory.
+
+**2. Obtain flashserver tool**
+
+Get ``flashserver`` from Spacemit website.
+
+.. code-block:: bash
+
+    $wget https://cdn-resource.spacemit.com/file/flash/flashserver
+    $chmod +x flashserver
+    $mv flashserver {flash image path}/
+
+**3. Copy built SPL and U-Boot images**
+
+Build U-Boot as mentioned in k1-spl.rst. Create a new directory to save.
+The official u-boot.itb is used to download images. So the built U-Boot should
+not replace the official one.
+
+.. code-block:: bash
+
+    $mkdir {flash image path}/build
+    $cd {flash image path}
+    $ln -sf {path to FSBL.bin} ./build/
+    $ln -sf {path to u-boot.itb} ./build/fit.itb
+
+``{path to FSBL.bin}`` is the signed FSBL produced by ``fsbl.sh`` in
+k1-spl.rst, e.g. ``~/uboot-2022.10/spl_bin/FSBL.bin``.
+``{path to u-boot.itb}`` is the U-Boot build output, e.g.
+``~/u-boot/u-boot.itb``.
+
+**4. Update configuration files**
+
+The ``partition_2M.json`` and ``partition_universal.json`` files come from
+the release package. Patch the ``fsbl`` and ``uboot`` entries to point at
+the images staged under ``build/`` (pick the layout that matches your eMMC):
+
+.. code-block:: diff
+
+   diff -puNr bianbu-25/partition_2M.json clean/partition_2M.json
+   --- bianbu-25/partition_2M.json	2026-03-02 11:55:58.631116807 +0800
+   +++ clean/partition_2M.json	2026-05-20 11:25:21.683801401 +0800
+   @@ -13,7 +13,7 @@
+          "name": "fsbl",
+          "offset": "128K",
+          "size": "256K",
+   -      "image": "factory/FSBL.bin"
+   +      "image": "build/FSBL.bin"
+        },
+        {
+          "name": "env",
+   @@ -31,7 +31,7 @@
+          "name": "uboot",
+          "offset": "640K",
+          "size": "-",
+   -      "image": "u-boot.itb"
+   +      "image": "build/fit.itb"
+        }
+      ]
+    }
+   diff -puNr bianbu-25/partition_universal.json clean/partition_universal.json
+   --- bianbu-25/partition_universal.json	2026-03-02 11:55:58.642116862 +0800
+   +++ clean/partition_universal.json	2026-05-20 11:26:23.932581853 +0800
+   @@ -14,7 +14,7 @@
+               "name": "fsbl",
+               "offset": "128K",
+               "size": "256K",
+   -            "image": "factory/FSBL.bin"
+   +            "image": "build/FSBL.bin"
+           },
+           {
+               "name": "env",
+   @@ -32,7 +32,7 @@
+               "name": "uboot",
+               "offset": "2M",
+               "size": "2M",
+   -            "image": "u-boot.itb"
+   +            "image": "build/fit.itb"
+           },
+           {
+               "name": "bootfs",
+
+Deploying via USB Fastboot
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+To enter BootROM fastboot mode:
+
+1. Power off the board by unplugging its power supply.
+2. **Press and hold** the FDL button (called "Boot Key" on some boards;
+   see the board layout above for the BPI-F3).
+3. While holding the button, use a USB cable to connect the OTG port to
+   your host. This cable is also used by fastboot to upload the firmware.
+4. Release the button.
+
+On the host, ``fastboot devices`` should list the board::
+
+    dfu-device     DFU download
+
+The serial console shows the BootROM's USB download handler trace,
+including a line like::
+
+    usb2d_initialize : enter
+
+This indicates the board is ready to accept an image via USB.
+
+.. tip::
+
+   If you are worried about insufficient USB power, you can first plug
+   in the power, then release the button, and then plug in the USB
+   cable.
+
+On the host:
+
+.. code-block:: console
+
+    $sudo ./flashserver
+
+When ``flashserver`` is running, it lists the detected fastboot devices.
+Enter the corresponding number to select one.
+
+
+Chapter 2: SD Card Boot
+=======================
+
+
+SpacemiT K1 Bianbu SD Card Image Flashing and U-Boot Update Guide
+==================================================================
+
+This guide explains how to prepare a bootable SD card with Bianbu OS for
+SpacemiT K1 based boards and how to replace the U-Boot binary on the SD
+card with a custom build.
+
+Prerequisites
+~~~~~~~~~~~~~
+
+- A SpacemiT K1 based development board
+- A microSD card (at least 8 GB capacity recommended)
+- A card reader for your host computer
+- A Linux host system (for ``dd``, ``fdisk``, ``lsblk`` commands)
+- The Bianbu SD card image from
+   <https://spacemit.com/community/resources-download/Images%20Collects/K1/Bianbu>
+- A custom ``u-boot.itb`` file (device tree blob or U-Boot FIT image) to be
+  written to the U-Boot partition
+
+Prepare the SD Card & the image
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**1. Download the image**
+
+Download the released package from the official SpacemiT website:
+
+<https://archive.spacemit.com/image/k1/version/bianbu/v2.3.5/Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip>
+
+**2. Extract the image**
+
+.. code-block:: console
+
+   $ unzip Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img.zip
+
+**3. Identify the SD card device**
+
+Insert the microSD card into your card reader, then run:
+
+.. code-block:: console
+
+   $ lsblk
+
+Compare the output before and after inserting the card to identify
+the new device. It will typically appear as ``/dev/sdb``, ``/dev/sdc``,
+or ``/dev/mmcblk0``.
+
+**4. Write the image to the SD card**
+
+.. code-block:: console
+
+   $ sudo dd if=./Bianbu-Minimal-K1-sdcard-V2.3.5-20260601180942.img of=/dev/sdb bs=1M status=progress
+
+The SD card is now ready as a bootable Bianbu system disk.
+
+
+Understanding the SD Card Partition Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After writing the image, the SD card has the following partition structure
+(verified with ``sudo fdisk -l /dev/sdb``):
+
+.. code-block:: text
+
+   Device      Start     End Sectors  Size Type
+   /dev/sdb1     256     767     512  256K Linux filesystem
+   /dev/sdb2     768     895     128   64K Linux filesystem
+   /dev/sdb3    2048    4095    2048    1M Linux filesystem
+   /dev/sdb4    4096    8191    4096    2M Linux filesystem
+   /dev/sdb5    8192  532479  524288  256M Linux filesystem
+   /dev/sdb6  532480 4726783 4194304    2G Linux filesystem
+
+The role of each partition:
+
++----------+----------+--------------------------------------------------+
+| Partition| Size     | Purpose                                          |
++==========+==========+==================================================+
+| ``sdb1`` | 256 KB   | Boot information for Boot ROM                    |
++----------+----------+--------------------------------------------------+
+| ``sdb2`` | 64 KB    | FSBL (First Stage Bootloader)                    |
++----------+----------+--------------------------------------------------+
+| ``sdb3`` | 1 MB     | OpenSBI / U-Boot environment                     |
++----------+----------+--------------------------------------------------+
+| ``sdb4`` | 2 MB     | **U-Boot binary (``u-boot.itb``)**               |
++----------+----------+--------------------------------------------------+
+| ``sdb5`` | 256 MB   | Boot partition (FAT32, kernel + device tree)     |
++----------+----------+--------------------------------------------------+
+| ``sdb6`` | 2 GB     | Root filesystem (ext4)                           |
++----------+----------+--------------------------------------------------+
+
+
+Replacing U-Boot on the SD Card
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+This section explains how to replace the U-Boot binary on the SD card
+with your own custom ``u-boot.itb`` file. For this guide, the custom file
+is a ``Device Tree Blob`` , which fits within
+the 2 MB ``/dev/sdb4`` partition.
+
+
+**1. Confirm the SD card device and partition**
+
+.. code-block:: console
+
+   $ sudo fdisk -l /dev/sdb
+
+Ensure that ``/dev/sdb4`` exists and has the expected size (2 MB),
+and that the replacement ``u-boot.itb`` is no larger than the size.
+
+
+**2. Write the new U-Boot image**
+
+.. code-block:: console
+
+   $ sudo dd if=./u-boot.itb of=/dev/sdb4 bs=1M status=progress
+
+Example successful output:
+
+.. code-block:: text
+
+   0+1 records in
+   0+1 records out
+   873033 bytes (873 kB, 853 KiB) copied, 1.22109 s, 715 kB/s
+
+
+**3. Synchronize**
+
+.. code-block:: console
+
+   $ sync
+
+**4. Eject the SD card**
+
+.. code-block:: console
+
+   $ sudo eject /dev/sdb
+
+Booting and Testing
+~~~~~~~~~~~~~~~~~~~
+
+Insert the SD card into the development board, connect the serial
+console (115200 8N1), and power on the board.
+
+- If the board boots successfully, the new device tree or U-Boot image
+  is compatible with your hardware.

-- 
2.51.0

