Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DEB2C5B572
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5BF4A406C3;
	Wed, 19 Aug 2026 03:57:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IeMEzGytzGLM; Wed, 19 Aug 2026 03:57:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111867;
	bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gJptx0vVFnuFSKFnIo/jGIfCkZBi/OInkdWslL74EiE/gTBy+rYh9ZeT6ltl831Q9
	 JNuY4tV6733NJPLkQ6bSlc5TqTEQSvLCL/2s3+8da3RM34d39owEnP5J1dyKtQYita
	 CN/jAi9pB5hMmxpfvr4jisOKMYno3BVxo+IeluWmFX+M0y1NKRn//7k6+/li8Fynuh
	 I4DdYNxL/R1cU3IhN9gunWlWNyZn5n68tF4aHstQ8D9t7/rffX4hqUWlOqq4BCfh8v
	 vdBpBK1N2aN+++8nYZ553kV130ltNOBURG1DnDwdYXkG65EvmrtiBPo14WwfJanGFx
	 WcFCkssEh2Rjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2329A4069B;
	Wed, 19 Aug 2026 03:57:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 783B91395
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EC6C40666
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQPCVRuXqlRy for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ICCITgvz
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6E3ED40681
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:43 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so651519a91.1
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111862; x=1787716662;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=ICCITgvzn2aCHImvAgU1R9F1f7dBqrRpNdld8O+JEZuhjFB+80qj/2nGNVfDRsodLN
 86wl4IVk/Z+BhSDZ7+P6h03AUQst+TF7OV44aW3bWtgQF5qxEyhxr3I0qNZNTc1zHnOd
 1X2GsmAhH7ZU5rxChg142eB0gS4g9WsMkw5ZhwpLtkq7oyYQ4jOvOCyzHA1rFvYn4chd
 GDM+EhCUCm8JDnMqkzo27rPrAgdTcKnYlR9LHTo7D2csWRxn8kl5hXbN4wOL3XccDxip
 bxWYVu11NFp224FIQiTDLtXQ93ctxGecSGSey8TK2/BDC4pspX5l5428A+2sbvaYttwq
 IVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111862; x=1787716662;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=mmt/PCXbxoO5vu/WQAUsA0b+Jzn9y/gwfdBYhMJOTbdamBccw6pKskNM/sgp2ppqSK
 bepX2IG1CMlAy0ivmzaIZr98sRBbJHbPsuAEg6xmcxYe8rS2x1dKaMUlzhCQtfr1papQ
 Pzaovk17DE6Q1FqS0nHbbC6ohmNqiQs1R2po7XtraCo1DQFoAXtwzOHhwBAd9CdK4dT1
 POJ3J5dinTqbyscQk4UG0X0NV00B5Uauv5TfNvAZNVdOK4QCjjceIoEqpxPX6rIeY8mq
 F4EPO2wsVRFFFPg7YId9rDTHBV1HsqsHYcPuz+EuRZuz5ToegsRHMVj2hzI6S1GfH3Xs
 rJqg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo5CYL3kjmQbgVFJhRUvoufi42PxcXJXEhSpZ+TrBkZ445uAP4LMTGRxyQZ50hUUhgHtQ3618=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzB5bcJY5tabax6sqPjbVwA94FxAdLjEPHrKz8rMK2hyzfVCu3O
 qgBibCxHK3fwZrIw2T8oMU/zkQ28+T6SAmicsfpWUbPcllzcSL7XRHPV4sOKhNmGzJ4=
X-Gm-Gg: AR+sD10L+ghYUN0WUIFLojkCZlMnVJRZ6nxZ223n/S8MbDm70pAiF7/GJcQElJzLA0g
 XERVmVi1A8QGf4/UrxyI/MPB0WTwi0ybGkLRr5cKR/uoXYLlHjrYXGQI6R6VHgYcbK3/zSpKb8D
 40MbaZDqgoltv0vzVBTFWgGorD6uy97ve8P9K4WgXrAH8GIIivQb6AaGnjqlqu9R+uoeb/fcXsa
 CW1yMlsoo1ZKKuxPQ2ke6E80CApZIdFm93i3iGdimU6M8K7juDmIlThzwB1fo2OXRneWgeu9gXM
 Z7uYdr0Mtnco/gnlGFjdSU57Gf7r5jaBVYAmi2OTP8U4oIAdk2Iah6u2H/xE8QM4Hr7CtIeZzAo
 +df37QIMBL/OaITpAM+y/xJO7354VgmklVnjutlgvrYq/Zs3RuCp9FS1yLvJyrGgboHA0yVsV0E
 WHpyyD0MxL5Ur6HC3DW1Z2WaXf4cJn3z/Emry+9NuqUmvFRHVtL6S8rccpvRFkZvWEkL9Aq0Lyq
 zuzWKZIrGSbZnSXW/SSHOj/ObzuksNUbv9L3ILFqPZahXfhkS2cVokEkuvf28f/OugXdFE7Bodl
 Ess9Yjs7hA67bbLOHE/sxyyR2/pKBP6UsRLn
X-Received: by 2002:a17:90b:17c6:b0:381:a766:efc9 with SMTP id
 98e67ed59e1d1-39580f119e0mr2953769a91.7.1787111862469; 
 Tue, 18 Aug 2026 20:57:42 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:41 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:55:00 +0800
Subject: [PATCH v9 18/19] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-18-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
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
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add document on how to flash images into eMMC of K1 SoC based boards.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v9:
- Add to generate the partition table of SD card.
v3:
- Add document on how to flash images into SD card.
---
 board/spacemit/k1/MAINTAINERS |   2 +-
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-mmc.rst | 271 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+), 1 deletion(-)

diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index 4b2bc4ecfc10..e12288a206e0 100644
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
index a5e35ee12ab6..71854e5735bd 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,5 +6,6 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-mmc
    k1-spl
 
diff --git a/doc/board/spacemit/k1-mmc.rst b/doc/board/spacemit/k1-mmc.rst
new file mode 100644
index 000000000000..0be5d5fa1c39
--- /dev/null
+++ b/doc/board/spacemit/k1-mmc.rst
@@ -0,0 +1,271 @@
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
+- A microSD card (at least 4GB capacity recommended)
+- A card reader for your host computer
+- A Linux host system (for ``dd``, ``sgdisk``, ``lsblk`` commands)
+- The Bianbu release package from
+  <https://archive.spacemit.com/image/k1/version/bianbu/v2.3.3/Bianbu-Minimal-K1-V2.3.3-20260128183217.zip>
+- A custom ``FSBL.bin`` and ``u-boot.itb`` file to be written to the U-Boot
+  partition
+
+Prepare the SD Card & the image
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+**1. Obtain the release images**
+
+Unpack the release package to get the image files. Replace the ``FSBL.bin``
+and ``u-boot.itb`` with your custom builds.
+
+**2. Identify the SD card device**
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
+**3. Write the image to the SD card**
+
+Run ``sgdisk`` to generate the partition table, then use ``dd`` to write
+the images to the corresponding partitions.
+
+.. code-block:: console
+
+    $sudo sgdisk -o /dev/sdb
+    $sudo sgdisk -a 128 \
+        -n 1:256:767 -t 1:8300 \
+        -n 2:768:895 -t 2:8300 \
+        -n 3:2048:4095 -t 3:8300 \
+        -n 4:4096:8191 -t 4:8300 \
+        -n 5:8192:532479 -t 5:8300 \
+        -n 6:532480:4726783 -t 6:8300 \
+        /dev/sdb
+    $sudo dd if=FSBL.bin of=/dev/sdb1 bs=512 seek=0 status=progress
+    $sudo dd if=env.bin of=/dev/sdb2 bs=512 seek=0 status=progress
+    $sudo dd if=fw_dynamic.itb of=/dev/sdb3 bs=512 seek=0 status=progress
+    $sudo dd if=u-boot.itb of=/dev/sdb4 bs=512 seek=0 status=progress
+    $sudo dd if=bootfs.img of=/dev/sdb5 bs=1M status=progress
+    $sudo dd if=rootfs.ext4 of=/dev/sdb6 bs=1M status=progress
+
+The SD card is now ready as a bootable system disk.
+
+Understanding the SD Card Partition Layout
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The role of each partition:
+
++----------+----------+------------------------------------+
+| Partition| Size     | Purpose                            |
++==========+==========+====================================+
+| ``sdb1`` | 256 KB   | FSBL (First Stage Bootloader)      |
++----------+----------+------------------------------------+
+| ``sdb2`` | 64 KB    | ENV                                |
++----------+----------+------------------------------------+
+| ``sdb3`` | 1 MB     | OpenSBI                            |
++----------+----------+------------------------------------+
+| ``sdb4`` | 2 MB     | U-Boot binary (``u-boot.itb``)     |
++----------+----------+------------------------------------+
+| ``sdb5`` | 256 MB   | Boot partition (kernel)            |
++----------+----------+------------------------------------+
+| ``sdb6`` | 2 GB     | Root filesystem (ext4)             |
++----------+----------+------------------------------------+
+
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

