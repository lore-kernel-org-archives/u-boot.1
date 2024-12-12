Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DA0E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 10:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C1180214;
	Thu, 12 Dec 2024 11:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bgQ6R/Mg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A82F801A9; Thu, 12 Dec 2024 11:37:42 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43C01801FD
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 11:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so65259766b.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 02:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733999860; x=1734604660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TVpaPvURewmLq/+8frpxaZeBJ2NNLBWbBgpQV/zfpXo=;
 b=bgQ6R/MgnBxtxuvUEUwdq7KraG+0uvIEN1DjkD5/vd1TdGq2jUuawd+gRko4wWaSp0
 Tq2gDvzhL3rBGvNpqbKpNb32cGW2o+keUCxIM9Ogvhs65b0zUl399LZ5lNoHtlzOhoUQ
 gqtUQ9LpFffD23lrlrlYkF63mzOCxdjF8jsPg0eqUb8mvC225wuaATXjTo8k4+SwynFX
 gk8UzkjGfccFRkLKSs8ydJp7wvJwmAVHhCj/afTuhBd8kKLqi0RemsmaA7mvTKmrmAmv
 kJUrs5GFinOG2AGNLMIzBM5uN8m+eA9xbAZhg+Ugx80VICHoYiCC9HAUlQMrYEm5VM1e
 RUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733999860; x=1734604660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TVpaPvURewmLq/+8frpxaZeBJ2NNLBWbBgpQV/zfpXo=;
 b=Tl1iGl8EdGkggZ/XtjlpwFRNixrkU+O5I5bIjbITd6Yn55HRDjcAwXVFBo6S73aH/f
 Z/P0U4YjbetbrIus6tDiUtd1VcKfOVB6C0Rhh2jfBxhmEhR6kLq3agsvVyx5LYhVc/x4
 qXgMAhoRhKdpkfxtJhvdftH6+GPkFjALzJyZuzh3VHHAm7Ve5CmMeVv22YMFy+k0vBVv
 BJ0UwqiOeOayHMLuUhp3s3nhrLzS0KMlS/hbv6b8I19YQRcJBR/Lubi/mubGQ/zYe0sQ
 0faZqwlsnSZRq567VEm5SXnLKKaFnsA606U7gmbD3eQVqrp3EJ+HtM4OtYP3e7JuSnGD
 N0RQ==
X-Gm-Message-State: AOJu0YxEwWFbB7qVRTpSew8dW4WlpI0ZbXgWHIbuuaZRGXDA2nDansl2
 WF6tJEo/R3+GiIt3dmNPMGLRHvkvJo/8KX8FBTxu/nmJy4N+ukassgtRFQ==
X-Gm-Gg: ASbGnctqxcfIC1dMNtlQ5N85iquToAZbEyatdxu1mjDgzPVhbihBKr9ea2yC7ijyyZm
 W2u0aXq2O2K9QyFJjrje9asjusuVQB+e6xAxbmcvNVUWkdCcadZZ/d+2LQP51CJWZILWTMzPxnG
 1UgxquhRQCTuhvzTZkRVYqBNkI+mfj31n/HBiTtIIrW5TOd2mmJ5Y19ETP3rhJR8nsmNa0Llk6t
 ATQt3rU178FxnXteW6/qvvIW1RsNQjdNy+ehR2NVntQNdrF
X-Google-Smtp-Source: AGHT+IF0V8iD3uFEuI6iQSoSBSYn3yS6onc2rr1C2sIWaylrIzqwCQoj0Ma/zJVie7fy/PE7k4SUGw==
X-Received: by 2002:a17:906:30ca:b0:aa6:b4f8:fc84 with SMTP id
 a640c23a62f3a-aa6c1761fbemr334646866b.0.1733999859452; 
 Thu, 12 Dec 2024 02:37:39 -0800 (PST)
Received: from xeon.. ([188.163.112.48]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa68770c481sm569415966b.110.2024.12.12.02.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 02:37:39 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Thierry Reding <treding@nvidia.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/2] doc: board: tegra: update device information
Date: Thu, 12 Dec 2024 12:37:06 +0200
Message-ID: <20241212103711.7516-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241212103711.7516-1-clamor95@gmail.com>
References: <20241212103711.7516-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Adjust and update existing manuals to reflect the most recent
updates.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 doc/board/asus/grouper.rst         | 12 ++++++------
 doc/board/asus/transformer_t20.rst |  6 +++---
 doc/board/asus/transformer_t30.rst | 13 +++++++------
 doc/board/htc/endeavoru.rst        |  9 ++++-----
 doc/board/lg/x3_t30.rst            | 20 ++++++++++----------
 doc/board/microsoft/surface-rt.rst |  4 ++--
 doc/board/wexler/qc750.rst         |  9 ++++-----
 7 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/doc/board/asus/grouper.rst b/doc/board/asus/grouper.rst
index d56a9ca3921..14469582907 100644
--- a/doc/board/asus/grouper.rst
+++ b/doc/board/asus/grouper.rst
@@ -25,7 +25,7 @@ along with cellular one.
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make grouper_defconfig # For all grouper versions and tilapia
     $ make
 
@@ -79,18 +79,18 @@ Flashing with the NV3P protocol
 *******************************
 
 Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
-pre-loading vendor bootloader with the Fusée Gelée.
+enter it by pre-loading vendor bootloader with the Fusée Gelée.
 
 With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
 encrypted state in form, which can just be written RAW at the start of eMMC.
 
 .. code-block:: bash
 
-    $ wheelie --blob blob.bin
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+    $ ./run_bootloader.sh -s T30 -t ./bct/grouper.bct -b android_bootloader.bin
+    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
 
-When flashing is done, reboot the device.
+When flashing is done, reboot the device. Note that if you have cellular version,
+use ``tilapia.bct``.
 
 Flashing with a pre-loaded U-Boot
 *********************************
diff --git a/doc/board/asus/transformer_t20.rst b/doc/board/asus/transformer_t20.rst
index d4bc12d1619..4f4f893c3a8 100644
--- a/doc/board/asus/transformer_t20.rst
+++ b/doc/board/asus/transformer_t20.rst
@@ -25,7 +25,7 @@ defconfig. Valid fragments are ``tf101.config``, ``tf101g.config`` and
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make transformer_t20_defconfig tf101.config # For TF101
     $ make
 
@@ -84,8 +84,8 @@ encrypted state in form, which can just be written RAW at the start of eMMC.
 
 .. code-block:: bash
 
-    $ wheelie --blob blob.bin
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+    $ wheelie -1 --bl bootloader.bin --bct tf101.bct --odm 0x300d8011 || break
+    $ nvflash --resume --rawdevicewrite 0 2048 repart-block.bin
 
 When flashing is done, reboot the device.
 
diff --git a/doc/board/asus/transformer_t30.rst b/doc/board/asus/transformer_t30.rst
index bebc4b9fad3..012a38251aa 100644
--- a/doc/board/asus/transformer_t30.rst
+++ b/doc/board/asus/transformer_t30.rst
@@ -22,6 +22,7 @@ Build U-Boot
 
 U-Boot features ability to detect transformer device model on which it is
 loaded. The list of supported devices include:
+
 - ASUS Transformer Prime TF201
 - ASUS Transformer Pad (3G/LTE) TF300T/TG/TL
 - ASUS Transformer Infinity TF700T
@@ -30,7 +31,7 @@ loaded. The list of supported devices include:
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make transformer_t30_defconfig
     $ make
 
@@ -84,18 +85,18 @@ Flashing with the NV3P protocol
 *******************************
 
 Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
-pre-loading vendor bootloader with the Fusée Gelée.
+enter it by pre-loading vendor bootloader with the Fusée Gelée.
 
 With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
 encrypted state in form, which can just be written RAW at the start of eMMC.
 
 .. code-block:: bash
 
-    $ wheelie --blob blob.bin
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+    $ ./run_bootloader.sh -s T30 -t ./bct/tf201.bct -b android_bootloader.bin
+    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
 
-When flashing is done, reboot the device.
+When flashing is done, reboot the device. Note that you should adjust bct file
+name according to your device.
 
 Flashing with a pre-loaded U-Boot
 *********************************
diff --git a/doc/board/htc/endeavoru.rst b/doc/board/htc/endeavoru.rst
index e0edefe28ae..53df2d09a6f 100644
--- a/doc/board/htc/endeavoru.rst
+++ b/doc/board/htc/endeavoru.rst
@@ -21,7 +21,7 @@ Build U-Boot
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make endeavoru_defconfig
     $ make
 
@@ -72,16 +72,15 @@ Flashing with the NV3P protocol
 *******************************
 
 Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
-pre-loading vendor bootloader with the Fusée Gelée.
+enter it by pre-loading vendor bootloader with the Fusée Gelée.
 
 With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
 encrypted state in form, which can just be written RAW at the start of eMMC.
 
 .. code-block:: bash
 
-    $ wheelie --blob blob.bin
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+    $ ./run_bootloader.sh -s T30 -t ./bct/endeavoru.bct -b android_bootloader.bin
+    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
 
 When flashing is done, reboot the device.
 
diff --git a/doc/board/lg/x3_t30.rst b/doc/board/lg/x3_t30.rst
index 618b00d34e3..9ff75034b72 100644
--- a/doc/board/lg/x3_t30.rst
+++ b/doc/board/lg/x3_t30.rst
@@ -24,7 +24,7 @@ board defconfig. Valid fragments are ``p880.config`` and ``p895.config``.
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make x3_t30_defconfig p895.config # For LG Optimus Vu
     $ make
 
@@ -75,18 +75,18 @@ Flashing with the NV3P protocol
 *******************************
 
 Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
-pre-loading vendor bootloader with the Fusée Gelée.
+enter it by pre-loading vendor bootloader with the Fusée Gelée.
 
 With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
 encrypted state in form, which can just be written RAW at the start of eMMC.
 
 .. code-block:: bash
 
-    $ wheelie --blob blob.bin
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
+    $ ./run_bootloader.sh -s T30 -t ./bct/p895.bct -b android_bootloader.bin
+    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
 
-When flashing is done, reboot the device.
+When flashing is done, reboot the device. Note that if you have Optimus 4x HD,
+use ``p880.bct``.
 
 Flashing with a pre-loaded U-Boot
 *********************************
@@ -122,7 +122,7 @@ the user to use/partition it in any way the user desires.
 Self Upgrading
 --------------
 
-Place your ``u-boot-dtb-tegra.bin`` on the first partition of the eMMC (using
-ability of u-boot to mount it). Enter bootmenu, choose update bootloader option
-with Power button and U-Boot should update itself. Once the process is
-completed, U-Boot will ask to press any button to reboot.
+Place your ``u-boot-dtb-tegra.bin`` on the first partition of the eMMC or MicroSD
+card if it is supported (using ability of u-boot to mount it). Enter bootmenu,
+choose update bootloader option with Power button and U-Boot should update itself.
+Once the process is completed, U-Boot will ask to press any button to reboot.
diff --git a/doc/board/microsoft/surface-rt.rst b/doc/board/microsoft/surface-rt.rst
index b5645e79340..2b29cce40a9 100644
--- a/doc/board/microsoft/surface-rt.rst
+++ b/doc/board/microsoft/surface-rt.rst
@@ -14,7 +14,7 @@ Build U-Boot
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make surface-rt_defconfig
     $ make
 
@@ -38,4 +38,4 @@ directory with
 To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
 eMMC. Additionally, if the Volume Down button is pressed while loading, the
 device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
-as mass storage, fastboot, reboot, reboot RCM, poweroffand enter U-Boot console.
+as mass storage, fastboot, reboot, reboot RCM, poweroff and enter U-Boot console.
diff --git a/doc/board/wexler/qc750.rst b/doc/board/wexler/qc750.rst
index b61e40176b0..169629c7e47 100644
--- a/doc/board/wexler/qc750.rst
+++ b/doc/board/wexler/qc750.rst
@@ -21,7 +21,7 @@ Build U-Boot
 
 .. code-block:: bash
 
-    $ export CROSS_COMPILE=arm-linux-gnueabi-
+    $ export CROSS_COMPILE=arm-none-eabi-
     $ make qc750_defconfig
     $ make
 
@@ -71,16 +71,15 @@ pre-loading just built U-Boot into RAM.
 Flashing with the NV3P protocol
 *******************************
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
-pre-loading vendor bootloader with the Fusée Gelée.
+Nv3p is a custom Nvidia protocol used to recover bricked devices. Tegrarcm is
+used to handle such state.
 
 With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
 encrypted state in form, which can just be written RAW at the start of eMMC.
 
 .. code-block:: bash
 
-    $ wheelie --bct qc750.bct --bl bootloader.bin
+    $ tegrarcm --bct qc750.bct --bootloader android_bootloader.bin --loadaddr 0x80108000
     $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
 
 When flashing is done, reboot the device.
-- 
2.43.0

