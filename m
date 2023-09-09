Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0DAEEB57C
	for <u-boot@archiver.kernel.org>; Sat,  9 Sep 2023 09:33:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBF6F86537;
	Sat,  9 Sep 2023 11:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5jWTQbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4E7685DFA; Sat,  9 Sep 2023 11:33:41 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73CAA86940
 for <u-boot@lists.denx.de>; Sat,  9 Sep 2023 11:33:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer+oss@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so29836575e9.1
 for <u-boot@lists.denx.de>; Sat, 09 Sep 2023 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694252018; x=1694856818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=nJ2fNPtQTXZZWlrYuaTV3q56Q3LcE0/hov+j21wXvrU=;
 b=D5jWTQbq3runUFZCPha5CCtVQizOZEuq3faqmfb2SAGlXc+iIefvzE+qeoVgU8wzTI
 w4/vPPPbt3Zku+7R1dn6NddBp8JsWP2nthyy5Abgm5990Qw0cy7s282ro8bAWMM5Pe9X
 Kf3rqks9BldaC2mU1aTcMfEgvgWGExMWOUDJdL86/OOaqSMFJh0QeXjeS1QWxKLlnxYN
 fvkno32NAcPAdBp2oAgHdxOuRQb9yXzDu1/Ju4+QFOW1naxzkkzeYawUGwv1Xtw5aifs
 1aa5G3LJSIdABaMxYJu50vPKHAFxilbdICXCyPBo+lOq3zemu4RkT+//ZB9Bw15hWynL
 6CeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694252018; x=1694856818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nJ2fNPtQTXZZWlrYuaTV3q56Q3LcE0/hov+j21wXvrU=;
 b=gJ8ee3WiilOPRF22xj8StWihrzwftYQcQ8w0lSADzglhVVJIJPJx0Eoj9iFATVr4vY
 11u3nzkq7r893STVTDb/K6W7wnsJW1pzBpIqXlNXae/LPFNR59e/+ySYBSuWkVyb3Cm+
 UDeUTrnBEqJsRU2n5P1wW6aO11mCbwrH7cL617l8tYvL8deUeJNm7zeM2vCvGp/LKk4k
 3hlPnH903vz1/JWywrX55TJTwqvIukHW8pH7m4AD6mBdGv26Ofm1Vv1h5/TmF0UAlzSl
 g7Erlqc1aqaQgS54ocAa7jY5JADMiy/2JiYuNJfV9ChQ0zFvzGSOXzGwfbwHEG+9lZX0
 m+Ow==
X-Gm-Message-State: AOJu0Yw7ZNwZLOSumL3ykXJCJN1LABi3cdVwSDsnHEQ91XKkMzudrCqy
 Fw8wuYdqroWkHacA4mCg1eproogI5XJbpQ==
X-Google-Smtp-Source: AGHT+IEdK//c8ExDiHXNzPC5A3dJhGU4PiFI7+nBw2OqnQbMDtEsFrjsLyndioDwYxZL1bPSMr3SGA==
X-Received: by 2002:a05:600c:1e14:b0:401:d1a3:d7f7 with SMTP id
 ay20-20020a05600c1e1400b00401d1a3d7f7mr3822144wmb.30.1694252017544; 
 Sat, 09 Sep 2023 02:33:37 -0700 (PDT)
Received: from pegmas-T15.fritz.box ([151.51.159.106])
 by smtp.gmail.com with ESMTPSA id
 2-20020a05600c22c200b003fefca26c72sm4160515wmg.23.2023.09.09.02.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 02:33:37 -0700 (PDT)
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@edgeble.ai>, FUKAUMI Naoki <naoki@radxa.com>,
 Johan Jonker <jbx6244@gmail.com>
Cc: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Subject: [PATCH v2 2/2] doc: rockchip: Update and improve info on rk3308,
 TPL and TF-A
Date: Sat,  9 Sep 2023 11:33:33 +0200
Message-Id: <20230909093333.11976-1-massimo.pegorer+oss@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Update and improve documentation about build steps for SoCs that
require using TF-A and TPL binaries provided by Rockchip, such as
rk3308. Add rk3308 boards case to rST document. Add ROCK Pi S in
the list of supported boards. Minor page format improvements.

Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
---
 doc/README.rockchip             | 10 +-------
 doc/board/rockchip/rockchip.rst | 43 +++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/doc/README.rockchip b/doc/README.rockchip
index 52b5140eca..84caff8a24 100644
--- a/doc/README.rockchip
+++ b/doc/README.rockchip
@@ -38,16 +38,8 @@ Building
     (or you can use another cross compiler if you prefer)
 
 2. To build RK3308 board:
-   - Get the rkbin
-     => git clone https://github.com/rockchip-linux/rkbin.git
 
-   - Compile U-Boot
-     => cd /path/to/u-boot
-     => export BL31=/path/to/rkbin/bin/rk33/rk3308_bl31_v2.22.elf
-     => make roc-cc-rk3308_defconfig
-     => make CROSS_COMPILE=aarch64-linux-gnu- all
-     => ./tools/mkimage -n rk3308 -T rksd -d /path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin idbloader.img
-     => cat spl/u-boot-spl.bin  >> idbloader.img
+   See doc/board/rockchip/rockchip.rst
 
 3. To build RK3399 board:
 
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de9fe8e642..d0fa7a9c8f 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -53,6 +53,7 @@ List of mainline supported Rockchip boards:
      - Google Speedy (chromebook_speedy)
      - Amarula Vyasa-RK3288 (vyasa-rk3288)
 * rk3308
+     - Radxa ROCK Pi S (rock-pi-s-rk3308)
      - Rockchip Evb-RK3308 (evb-rk3308)
      - Roc-cc-RK3308 (roc-cc-rk3308)
 * rk3326
@@ -142,6 +143,19 @@ To build TF-A:
 
 Specify the PLAT= with desired Rockchip platform to build TF-A for.
 
+For SoCs whose TF-A code is not available as open source, use BL31 binary provided by Rockchip:
+
+.. code-block:: bash
+
+        git clone --depth 1 https://github.com/rockchip-linux/rkbin
+
+TPL
+^^^
+
+For some SoCs U-Boot sources lack of support to inizialize DRAM.
+In these cases, to get a fully functional image following :ref:`PackageWithTPLandSPL`, use DDR binary provided by Rockchip rkbin repository as ROCKCHIP_TPL when building U-Boot.
+Otherwise, follow :ref:`PackageWithRockchipMiniloader`. 
+
 U-Boot
 ^^^^^^
 
@@ -172,6 +186,15 @@ To build rk3288 boards:
         make evb-rk3288_defconfig
         make CROSS_COMPILE=arm-linux-gnueabihf-
 
+To build rk3308 boards:
+
+.. code-block:: bash
+
+        export BL31=../rkbin/bin/rk33/rk3308_bl31_v2.26.elf
+        export ROCKCHIP_TPL=../rkbin/bin/rk33/rk3308_ddr_589MHz_uartX_mY_v2.07.bin
+        make evb-rk3308_defconfig
+        make CROSS_COMPILE=aarch64-linux-gnu-
+
 To build rk3328 boards:
 
 .. code-block:: bash
@@ -218,11 +241,13 @@ To build rk3588 boards:
 Flashing
 --------
 
+.. _`PackageWithTPLandSPL`:
+
 1. Package the image with U-Boot TPL/SPL
------------------------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 SD Card
-^^^^^^^
+"""""""
 
 All Rockchip platforms (except rk3128 which doesn't use SPL) are now
 supporting a single boot image using binman.
@@ -235,7 +260,7 @@ To write an image that boots from a SD card (assumed to be /dev/sda):
         sync
 
 eMMC
-^^^^
+""""
 
 eMMC flash would probe on mmc0 in most of the Rockchip platforms.
 
@@ -274,7 +299,7 @@ For Rockchip 32-bit platforms the U-Boot proper image
 is u-boot-dtb.img
 
 SPI
-^^^
+"""
 
 Write u-boot-rockchip-spi.bin to offset 0 of SPI flash.
 
@@ -286,8 +311,10 @@ Copy u-boot-rockchip-spi.bin into SD card and boot from SD:
         load mmc 1:1 $kernel_addr_r u-boot-rockchip-spi.bin
         sf update $fileaddr 0 $filesize
 
+.. _`PackageWithRockchipMiniloader`:
+
 2. Package the image with Rockchip miniloader
----------------------------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Image package with Rockchip miniloader requires rkbin [1].
 
@@ -327,14 +354,14 @@ Note:
 2. 0x200000 is a load address and is an option for some platforms.
 
 3. Package the RK3066 image with U-Boot TPL/SPL on NAND
--------------------------------------------------------
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Unlike later SoC models the rk3066 BootROM doesn't have SDMMC support.
 If all other boot options fail then it enters into a BootROM mode on the USB OTG port.
 This method loads TPL/SPL on NAND with U-Boot and kernel on SD card.
 
 SD Card
-^^^^^^^
+"""""""
 
 U-Boot expects a GPT partition map and a boot directory structure with files on the SD card.
 
@@ -369,7 +396,7 @@ To write a U-Boot image to the SD card (assumed to be /dev/sda):
         sync
 
 NAND
-^^^^
+""""
 
 Bring device in BootROM mode:
 
-- 
2.34.1

