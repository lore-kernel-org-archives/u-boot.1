Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04FFC43327
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 15:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C24FE84A30;
	Mon, 29 Jun 2026 17:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="PTIh4cjm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0ABB6849FB; Mon, 29 Jun 2026 17:52:27 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C7884A3E
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 17:52:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-13b29f58698so120341c88.1
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 08:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782748343; x=1783353143;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XZ+P+5L463w52BFUHyPTGRxQy/kJDMxzXbR0vLWJOhA=;
 b=PTIh4cjmdzfr3AXHFWPJAuLcJ7DktXMYZI5jl9xYyYM5R+2cs3GXsfc4JVUh6+yZNc
 JCaXUj9KhDyE99C5/m1JpJy0CQE7TJ6QDJRfnjRKuLSOTXQ45Cq/F5qEk2TA8Si6t5ej
 HGPhLdJGrSA7Bvj37dwO0jyJM33qHaLp5BLIMXKYuDBQGMyF2UDXAASFHE+7Bzr0ZUVi
 aHA433cnJLZxSkz7H1R8e+dOoa6Z8XCXZ6O6ASnGbnfRZd4vzHE8OMB5S/gxD7RJwos9
 iFXF7xgZ9dgOVHyYT6bI5RzTC9rRmaIVZQbpo70N12+mvZx27VsNRPZtTmdW1ibsAVGT
 4mFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782748343; x=1783353143;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XZ+P+5L463w52BFUHyPTGRxQy/kJDMxzXbR0vLWJOhA=;
 b=jhMbr9BSgiat7A7EDLQvKOymEj9j9ZlO633O62PYNpcjc7dVD5eQYpV7/vJcpcvvnO
 fegmSC65Pn9fLNeBFH20k0F9FwGEWpKXZ+4wrM3juGeEL68CVY4Iv2nkatQ+76UwTk/f
 3KD3+GUcpsoPDhNygtu8yqEsYq9nPVQk4EdRZ1Ar8KuFM/ggel9ziOMqMh3lNgpGQtna
 yBnqDC7sj7+1sJYoE75I7e7emHz9AICR5W6TXUrwci2Or4EiEYpoQVzpNJ/qcPvM/KP3
 ZjE/gUK1OOJ2PyPYbs0VQm7v052cwLMEOBExI2UbWzSSKlYphdIh21FTZ6E/mBaA+pPi
 ga+g==
X-Forwarded-Encrypted: i=1;
 AFNElJ915t93mp8iwtrnMgpZlE0iVmMVt8I7CoZDUfQDaPzvnMFgxkcRCj7/qobwevxKYGk493SsEcY=@lists.denx.de
X-Gm-Message-State: AOJu0YwaPn5JJdfeLocUvBmSvBsT/XGf9KVp1KDYFKmZCZUSZxd8s0tc
 dBn5HFoXpoQVkmGYPB7iudR9jJt4SyFiMW5d7cjT4jJP94j0Zz95G9NjT+jDZT4g4dc=
X-Gm-Gg: AfdE7clti2WuomhqIccVK3q1rkdNWNixj1nrKbWhzrb4iDVZYYpTz+OCmlbchcxcInW
 L/gXZnQTxKvSXbGqBespfci66Dlgo0NJExSVBW5nN/dfzPg10L9+EAeyZTO4FjcIoYaD/DJGYL7
 j3+pFh5wv7Av3r10u/nyG3IX2neJPUz7+UeH1fRGfqMY1G846NADi9SwXbq0cqDHXHX0hR6ndwI
 lI6WbMTd4rIN/EiOQhXObthBs5gDMV48ItE39FjLumUoazKP+6xfYY+p/DNrKyoPjpw6epB0E48
 LwyZHOvF4HcczxU1k6ZQxuAuc6WSpWH0n6yRTsNcZp/QZEWRFBmWs4RN9Y208JGxLUAFR/NBpDm
 Ag98XI6VFejD07iOBemIYAmbyY0S/R9P6ayvOT34hcHWkWSXBDHy043CIvvIAeq8Ex567IwYO5j
 CeWgt3DIcmqsh1HHyRmgUvTeEqrvwSnz4VEYiYzavaXEQ9Bj+n96ObWpydofKMlSZeLulUKj+N5
 2ELjhILal9s042/RpLRP4LXVtfTfhxNVHxdMzFweS3H5qa5d8yGxw==
X-Received: by 2002:a05:7022:661e:b0:136:90d9:f1f6 with SMTP id
 a92af1059eb24-139dbac2d03mr16316342c88.25.1782748342365; 
 Mon, 29 Jun 2026 08:52:22 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6d2e4sm46510090c88.7.2026.06.29.08.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 08:52:21 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 29 Jun 2026 23:51:20 +0800
Subject: [PATCH v2 v2 6/8] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-m4-v2-6-cbc91c6b83d8@riscstar.com>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
In-Reply-To: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
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
 Guodong Xu <guodong.xu@riscstar.com>, Eric Chung <eric.chung@riscstar.com>
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
 board/spacemit/k1/MAINTAINERS   |   2 +-
 doc/board/spacemit/index.rst    |   1 +
 doc/board/spacemit/k1-flash.rst | 157 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)

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
2.51.0

