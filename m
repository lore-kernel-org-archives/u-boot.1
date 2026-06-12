Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC44DCD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 20:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B6A84910;
	Fri, 12 Jun 2026 22:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n5AQJmFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C81AC84717; Fri, 12 Jun 2026 22:19:28 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5522184935
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 22:19:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-517583cb07aso13872331cf.2
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 13:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781295565; x=1781900365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFU2xITeCOnDVKPPDBMnBlus8WEwS+hovPqdD2c760o=;
 b=n5AQJmFGpf381VitJMOZ9/r/aO7zcHztQ+RiAI26VL5xKZAvisNl/rJSFMCHGnUqG5
 SeNB2qxfRsO8Fe7ek/ojnELdZDb0+UKVQwJOsfw0vn4SkSosR/+HagyZ6QiJFerZles2
 nKEvBc/TIBeSM+K7aGkFS4WfkViVYetZ6koKh44ho2+Ee7KRfqZ29mRDxdngca4xzwfG
 8KcTdnzl1BPytVBVw7ms3SM3D0WGUgIu23meK8yOONykRzZ0HTTX/B9pXFBMCYPFoXj7
 kWfU9B96MZkLyuSrMAdx+E/isUIB6yEtL7gWiV0eLp4QgcAbqKPKapCDUB2X3nWSum0u
 mCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781295565; x=1781900365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZFU2xITeCOnDVKPPDBMnBlus8WEwS+hovPqdD2c760o=;
 b=mw69hTKOkwBpQcpiSjQH5pHri+QHFfTq7r5Uw879G2/pw3Yz4Vh7zV06FvdBTme68C
 jC116deE1PMokPnxir5CKcKnBW2QDAld+3q3jRtDdCZpaVv0/OXWjlmyc6SPMt6vJcor
 anLEgdKU34rchmx5Gsnv9/ocFuxr1PrC2XCeu7eE/TgIjLaUb+jVZ/a5AnBtuMt3ikVK
 nlfIFkhfTP7zGoHdH4oMNMKnR7kc8ixIK+jd0fcb++lLkprZ1mxZ6ms3sqAmBNzPSF25
 El7PpdnCm3ouHuOt9Dm/DFwjpieh0TMpz1rJJvyBpMTNFZKs5gB/koWKqiEo899hxstY
 VtCw==
X-Gm-Message-State: AOJu0YwX0eVcqrwDBhgleWieraGNrA22EKeOYoNToiQKFQPnZKnI3+A5
 pHvnTm8YQ3/PgNbiOqpXc5Mu/dmy+jkQd0sB5UW7/7wKUoX2F2uu8g1dOhUkKLmd
X-Gm-Gg: Acq92OHhOFI/D3f65S3E715VY/+rPPHjw4KvcfrCf1kS57/svhGuCbVMr7nfqGBXczF
 2HOi2lmXZNQPLWPQRMITq/BqiAvZS4o8AmClYGtYHEtBPKF0FGDjESj5A97ThOCbOz/XH1YjS7+
 GJVaKK1wx+Hwk6xATaVFZt087BCkeONTavCv54j9dtwNPhLRQAc7XyutzEzdpPYT3CqjpFkYLix
 CDsOQoIoyR4rO+ZzWON2uKgRexTI65S7RAC6/hPB9WPAZt3mO8QW8CGL0/vR9WJAxSdJDPTtuAL
 h1uMYfFVDkJYhYfxjPB6/pDyWYkKuTOI7uq3PuaaEdy4Oa6t9av/2MPgo0A9WvMW+AjV8axADHr
 1/hF2QMRuKaTJIKmsHYK0yN8lz7glSSAgBusxPfQIyBl2Df9S2PYO01NAhKHfvY6nAl0lyBIdLQ
 oaiDg+L593cYi9LJ6Asb+DmWdL8cFDsBL/vZcTgRQQlP+DDD5LMOeu8jxvrL6SJxCHC7nIuOPlg
 TREcWt9
X-Received: by 2002:a05:622a:d13:b0:517:7701:c085 with SMTP id
 d75a77b69052e-51953519b39mr17914591cf.21.1781295565010; 
 Fri, 12 Jun 2026 13:19:25 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517fb7a3c4asm31304551cf.14.2026.06.12.13.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 13:19:24 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH 5/8] doc: spacemit: flash on K1 SoC based boards
Date: Fri, 12 Jun 2026 16:18:58 -0400
Message-Id: <20260612201901.73657-6-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260612201901.73657-1-raymondmaoca@gmail.com>
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
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

From: Guodong Xu <guodong@riscstar.com>

Add document on how to flash images into eMMC of K1 SoC based boards.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 board/spacemit/k1/MAINTAINERS   |   2 +-
 doc/board/spacemit/index.rst    |   1 +
 doc/board/spacemit/k1-flash.rst | 157 ++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 doc/board/spacemit/k1-flash.rst

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
index a5e35ee12ab..186c9b13602 100644
--- a/doc/board/spacemit/index.rst
+++ b/doc/board/spacemit/index.rst
@@ -6,5 +6,6 @@ SpacemiT
    :maxdepth: 1
 
    bananapi-f3
+   k1-flash
    k1-spl
 
diff --git a/doc/board/spacemit/k1-flash.rst b/doc/board/spacemit/k1-flash.rst
new file mode 100644
index 00000000000..c33625772b6
--- /dev/null
+++ b/doc/board/spacemit/k1-flash.rst
@@ -0,0 +1,157 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 U-Boot Flash Guide
+==============================
+
+This guide explains how to flash U-Boot on SpacemiT K1 based boards. It covers
+flashing images via USB fastboot.
+
+Tested boards: Banana Pi BPI-F3, MusePi Pro.
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
-- 
2.25.1

