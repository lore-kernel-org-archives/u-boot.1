Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FD2C54F55
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A199360708;
	Wed, 29 Jul 2026 14:49:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZO1jzcLBqrP; Wed, 29 Jul 2026 14:49:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FEFD6067E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336583;
	bh=z6yPIui6kW+2etSu0xF3IuiMFKubl8+ysPPeD1P0ZFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxN3iroNkOTfCPIx7uFhNeaBdxpi6xI/EIKCohbqxcmHdwrc3b5l8hVaIK8Ni1btL
	 H5PMJDYKt/8KBHPNgIgj/spl7yhcFU5+7yt/tUsx5/2NPWByiqRaPjj+4cuPFpjBX/
	 uCaIKGNHtqwIY6/Q9UUU+1z7HiSaNwtuMrJRRRUFrj723Mtk0xo6hp5XIkNq3L/dKq
	 YvjoFdN6Na/5ypZVAaqppjumtVszlKhWEdA56JLD4+hoAPgEbkL44PbutWHRqIamA8
	 7UWS/1xKBWNjECaHRcI/iB+p5Ol0fUKjOY4K0bV541zSETfcjyqozFmVlfmOxIOJMb
	 ly6DIdYYWIAcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FEFD6067E;
	Wed, 29 Jul 2026 14:49:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3D59490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 99C8640735
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vc-8chPKW8Fl for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2DBBA4081E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2DBBA4081E
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2DBBA4081E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:39 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso1234035a91.2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336579; x=1785941379;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z6yPIui6kW+2etSu0xF3IuiMFKubl8+ysPPeD1P0ZFs=;
 b=TYxjlGiM1Gk6Lzi9lyuCpDOvpLyq2awz5Oo0VxHMTy3iGG9b0IBIC2rjgt0YESfOJR
 3c0BHEOk6nw80g9dxDkpmCQQw3YJklx9lhDdoLsHpA5ko+aZQowUFTnLRiYcLZyXS+eO
 qP5RqcLiNrGwKa4dhVMburoHFoRqEbgAAWsF/pxdjeNGu1X/3RoQEALVDR5LwAz+TG98
 pDa42cuLjRanSj485DQMV1aktUrW+UhALsSckjsIXo1BmxW7vU3j0ae4ca791V4jexLi
 KZpt2EA0W7Zml2oVvlfJKQbSux5aCPulkLrAdHEoxQlsnCuHfvMIHVsjY8I1LXV/yPcB
 atBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYkjNUrxkWep8qxs0B7u0ELlPMY50xyTgChYNG1czl7F2VVScnoSi1AXiY4IEVLnA5BOapqPQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyR2y6hfAuDqRGZJVdssE5YlKP/HmbYf7dQKUZOAoogddSCFdDJ
 WUJLe4Bi9IF8rvtlZDim2dG1EWKcZFzTOVwGimcKpbJP0FhJTQRjz9q+fjAknTz7TVg=
X-Gm-Gg: AR+sD135lwiCw+6uVMVyY25brWwwR2CeBLPfLe07aLIfgfhc2q86N0Ah95a5DIwQZ60
 IlHypSUsU2kUpPAlaeazf8Cb2tNj4BX9nDVcz6bFdviAg2xnStKrD8zTaKEgIYZrd+E7omv8PyK
 MbW7EyVKhKBeaVkeJRX4WPXlA6uiw8FE6rQK6gePGah0tMnMuoilCF07NfDbPOepJqtYQaIpmGO
 eFD/ekkkGGY0qCPDjQbZRPENqe6ID5BoGo6OqRSVRWnscnNZhgOeEF72fzlO170gtcQBsGrExM/
 iMdDmJYmQy5FkniVV0J5V/4w7H94gLemBd0YAXU7hFGjTSoEG+vDBiHbb8hMhg9D0yT6jHc3DOT
 hkSStAvdPNjgYiqxERqbgM00Cu7UsJPNqzshStYZdsM3JAmQT34LD1M+QLyS4te9KoKX+Y4UtpV
 DXQITJQLTD5zdpuwkyOrt5qzs/RX9ycqYda1z9QWzqjoaMJYc+Ujg13aJYRrjcU/16d2f+3NTjA
 s1hDAscb0YcmXD8fK6QC97ct/iqB7m8YyPk8qK06/gZt8GzvYIxZBUsxrrwSz7Z2ci3sTRwrSGv
 5xj+eC2w+RwOgHukdGfmJJuTqg==
X-Received: by 2002:a17:90b:390d:b0:38d:ef48:b04 with SMTP id
 98e67ed59e1d1-38f6a40bd5bmr7276365a91.10.1785336578570; 
 Wed, 29 Jul 2026 07:49:38 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:38 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:27 +0800
Subject: [PATCH v7 09/11] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-9-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336579; x=1785941379;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z6yPIui6kW+2etSu0xF3IuiMFKubl8+ysPPeD1P0ZFs=;
 b=ayIWmy3U1Nbmtez0Io6WMwkpidwiMEqXrntoCN/xpYyGHEdtAMFWTNAvTOrvr4mpa8
 VHFnxLFwiKrtrdHk07HUlLtFxINd83yZxaCsukWo5kmvR/IkHIZDElEDV55shGETiaZ2
 XXu5pJrFrwWafB4xEZC+6FEGvGETm6XTbgl3TRP4LEB0c17Pe9aHw9JqiHJ+L01vGO1k
 L+q6xU3Y1BUhA0iYBw3OoangngP4bCNZZRXvA3A9OYX68/U0VIjb8VsCt6C6yKy8Z0ef
 M05B9hBIqwopHVG1efzFbIsmYiGfDjdHHDeXRCsXX6nTy7mg4M84g4OIdDas8rVG/iox
 gp9A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=ayIWmy3U
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

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
index 000000000000..b0fe78c75ce2
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

