Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A71C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3705060617;
	Mon, 24 Aug 2026 08:52:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMJuUkjJ44Vy; Mon, 24 Aug 2026 08:52:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561558;
	bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vys/vjsg1Cbp6XgrC2pjMqbrFfkFqzBMoNEyIo8rWNVkMtYbSawOvWI7VDi9uiO9B
	 9/14X6cV8rWEd7HMStyE3BkxQgTQnvPZtUuYHhzKRJilMuPqBlJmsQTCdkpy1H6+AQ
	 ahx+sazsRjdj42LfpcWV3plEMMu/KZ6wvoKI7rDmmXGhEGd/kT0xiNwBkT8UwqFJp4
	 12OmXpFx41b+MUYYxchpY/OHpsILZMWyEe0J6yPKmsM8TdHaOKNSmVQdAjRgQGRZ+X
	 4DZWg+2oGqdq0Fv3d5oh73hPS7eEFVC/9sJiPI+JbC6kekyPvQ5i20qAjF2cg1vye7
	 9QoYD4MjTGZ0w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1313C60622;
	Mon, 24 Aug 2026 08:52:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26975230
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1889D40649
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IpBNWj8-JTSV for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:52:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=abYxTp8U
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9746640756
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:32 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2caea3f742bso50007555ad.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561552; x=1788166352;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=abYxTp8U7Y0en+2r9KrIkrrjpJ1s2Y9s+x7CHh4dZlwTaCyZfoho+cdiXN+qVvY6Wc
 eFekABYBVaHGdgQsUzJ5rMHYDlZhLVWt9Xfz7KC7F9111TTzx57pQZ1fGncldBqSswUO
 o8glMdQsBpCq3U/8fDtB6GwEQspfptXMf4/5kxfbQiiSe6OERpWS/loHL31jLAdbD1fT
 gkBgexhtkOZn7NO06SDADHVCid3WuZDSau0YMhJagz/WHrP6iu/TGT+TJdNv+sTsf7Kx
 8RwHWAZz3U/rqWJSygmcBAJfiexYJ5eCJ72Y32b43clyqfbvtQDkFB+bLr4vCzgO+9X+
 74rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561552; x=1788166352;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pb92asXeCbFivAkLJIRniCitbaHzqNimmCDsG5aalCE=;
 b=H2hseUZ4ib0Q3/h0aCnrLIt3Pxa8AqcgNi+5xUSmnTE0s3oyx2ewA4BqxgzcWOCDaN
 a9iuiTTPbmsDgtutvLUTbhhCviuy6dH2Va5F+lkaW5H2WpQMZ4HwxhcNigsgGTg8HS5S
 W4LHkE6lbdanBT2/e/mdJA8556l2ZMcMDdgVqYW+SX4bJGk1UL+u7Ryi++Q3EqCrq3Tr
 +opZnOAoszjxMJHgcIuPxze8UUFN2DrdJmcteYC3qYgfFNiecrp+w5/tfAQC+TnzjFO/
 kVq8sGyFx3bucpoIjNqFlwB6+0561LcQsRWubhzSYCGf/bcWxR9tCuaVW+fMiPwkULYQ
 aReA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAleHS9G9vPGdPG8tUJZ7Jp0Fpdqh9gPTVlRvGy2VQpncB4W2Fc/2LNFTMDw4iB1JMQ9WJXnU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kQdilPbApat8tvCZNVzciuv33FEWt3xFpIsb8mzkw6HAhMp4rz
 HBc/lmysSGYAabbbrlKChnTqlDAu1vqJWzagxAV7qaYhMGdn+PLegrVx7aX7JPaf/iI=
X-Gm-Gg: AR+sD110XdRLuPZOpqA1zbG2ZvLavYcXD6M551bAVkI8EjM01IaQOTGntgDPEv2P5wd
 r7gPRYAipl8v6b3Pntri/wIUXg1xaULGcME0scEH5Kh0Mw8PkvNFKQzlw+lQCPM3qtK9cjxQZui
 tCdL+MdLfX1LdYIzeEbfVldgZU3URpQG4U589O1Zdd6E5Uxod6e8vU8nXwAB7CoqcqImcRNkPMF
 2omv3keDkS3iubGV0MDrykI5wAafj1mhgstqp1ZdrjAy2H9sonq2dTS3rSvfslO3XoR0p4sodOw
 +WKE48iU9meZMq9jvZgCPbNbDfXVhqFHr5+jJi6zLpc22tZMnxGuOc7eIW0cjywY9qnFUmFYzgh
 IDztFBq9jTItpjMpyAAXiEZHMfbqrbRXPBPiX29ReU6OKv3dGPBLSAE7sOZiozdM2kXePy7aVhY
 3U6d08N57Gxku40eExFQB6RzeiZOyHsido+Veugl5D3HXl/ceJQ/zHG5YsRHOwXUaT2lhFXZpRX
 wUw90cMexBXskI3fWJ5zCc2VNFPRDBhfW9NdBWpbgNqANDNj4yZ2vKRgoPfIUfiEKSjZHgIoAe5
 m/DJPSaUB5FlBg19Adcein+aEQ==
X-Received: by 2002:a17:902:ebcd:b0:2ca:481:de45 with SMTP id
 d9443c01a7336-2d64afa4e37mr478756135ad.6.1787561551644; 
 Mon, 24 Aug 2026 01:52:31 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:52:30 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:51 +0800
Subject: [PATCH v10 16/17] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-16-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
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

