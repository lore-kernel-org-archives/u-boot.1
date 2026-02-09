Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB61E81BD3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:56:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FB45805D7;
	Mon,  9 Feb 2026 18:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQTTk3Vl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82BFD83C30; Mon,  9 Feb 2026 18:56:21 +0100 (CET)
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D950E80325
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x144.google.com with SMTP id
 2adb3069b0e04-59de66fda55so3982482e87.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659777; x=1771264577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6SwzQuY5a+12acRxTYURpSD0Yys8NSCc7RcIzqk/ko=;
 b=DQTTk3Vls2xBPV3JZoeQ/yH4IbZDtUJ3Ppm1ye0aXQ64y8o7JLKlAbjVBMhQOMwDlQ
 vcjiTzcyQfJ4VDFgMBFcXNFazprdyBojLYPPmpXpfrExm+QRrt0jnUMd2/fFxCgGw7Bn
 X015KX+8ExGdo8tHQqGwd0L2frw/aDdVxmzphXz16QTo4bASfBTkjhO2iyUf10g+wsas
 q8b/r7IT7VabgGgvaxXBYWZlvuO7bIRo6ZUy39IVdsVvqGy4r7hWXLWxcxsFs+X7dsKd
 3A1ZYwackUv0M0s/d1vk4vmWvsIsaNikyuHMVV9WBmPiLTLIir9r4o0LBS3BQckfoDfR
 B2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659777; x=1771264577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i6SwzQuY5a+12acRxTYURpSD0Yys8NSCc7RcIzqk/ko=;
 b=F3UZsCVtd48D2kuwj5Ena4SiDqMoS6riEhfIdG1ZiEAcgYnLeHJFuAJpq83NcmqJHw
 16muDxX3TkMcyMs9SQOq4EAthLIzQrMwo/XmJzX2ZRfYomU+XuYye9PN1454YhiDQUiT
 kiDHtZXIfu5Pmt6KPFSlmwq7PZmGNEIfcTr0WxsHAD3GoMJ/MYCXiGRCyt6M9B7/yVF+
 oaM0a27vFBLrT+LkfEnI2FIEvsO3WMj6j0Cgz0Grf0+J+3til1GpF7qrIjbiMq+x8K4Z
 HQvIRWamnbo6XdpvsIdQ+Izj+MNQBGRszR7p71PMZ1VqbsQ/CURuspSGP0fJ6yVWW4Oc
 mMvw==
X-Gm-Message-State: AOJu0YwhsdrV9nX9lZcekl+bYeZh72TqAxujFhV3/4Y9f1fjNO+Y6wkv
 ZFziMqdNA5lBHfb23TTDy8U7laCWbSn0ihSKWEMGua+VBZ6X3N2lT5/d
X-Gm-Gg: AZuq6aJE9Lf/yjwx4jRtHJa5BsFjoO7Ied6iPtLQDZiUMwb0ZY022bMex4pZ65KfxmQ
 dCpFzd6ZiKysUgGJ2ioF1P26SJw5vX30CHcYaVqLJHPEJCk/QIcwx9GLJemIDLzFKFSxGP6lKUk
 yrH6owQLNS05uQcg4Wo0oE/CZpb/D7ztHxT0bI5G3Q+gfwK7K0v6aqOmCegI1ucQqqr7mehkLs0
 x0I0iM+rM+PMlngRDFkv3kHHz4hpVU5w9moJ0RP3smxyx91t2a51qA4rGgXL4JQdL1nhPB7bPME
 R1ujY0+26P6goI+tfBNmzgKzdj7cxEEfvTsocX1eSkEpVKF3VaUCbtIb2F9BCEvA5oV5AnlRl1O
 qI7FE/pw6657B0jzr2rGaXpX2i7rX9POLIjayB+6fY8ujrhiBUNKIFIuGjfjUH6hcbOgGQ8adMo
 Yh
X-Received: by 2002:a05:6512:6411:b0:59e:4eb3:c69 with SMTP id
 2adb3069b0e04-59e4eb30f2fmr1705187e87.5.1770659776277; 
 Mon, 09 Feb 2026 09:56:16 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e4c86dd3esm1706373e87.54.2026.02.09.09.56.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:56:14 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Geis <pgwipeout@gmail.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] doc: board: tegra: improve documentation
Date: Mon,  9 Feb 2026 19:55:50 +0200
Message-ID: <20260209175553.31609-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209175553.31609-1-clamor95@gmail.com>
References: <20260209175553.31609-1-clamor95@gmail.com>
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

Remove redundant chapters, clarify and reword confusing sections.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 doc/board/acer/picasso.rst         | 95 ++++++++++++++++++------------
 doc/board/asus/grouper.rst         | 65 ++++++++------------
 doc/board/asus/transformer_t20.rst | 64 ++++++++------------
 doc/board/asus/transformer_t30.rst | 74 +++++++++++------------
 doc/board/htc/endeavoru.rst        | 63 +++++++-------------
 doc/board/lg/star.rst              | 62 +++++++------------
 doc/board/lg/x3_t30.rst            | 62 +++++++------------
 doc/board/microsoft/surface-2.rst  |  2 +-
 doc/board/motorola/mot.rst         | 23 +++++++-
 doc/board/ouya/ouya.rst            | 64 ++++++++------------
 doc/board/samsung/n1.rst           |  3 +-
 doc/board/wexler/qc750.rst         | 54 ++++++-----------
 doc/board/xiaomi/mocha.rst         | 12 ++--
 13 files changed, 273 insertions(+), 370 deletions(-)

diff --git a/doc/board/acer/picasso.rst b/doc/board/acer/picasso.rst
index b1d360defd8..97380b5f045 100644
--- a/doc/board/acer/picasso.rst
+++ b/doc/board/acer/picasso.rst
@@ -5,7 +5,8 @@ U-Boot for the Acer Iconia Tab A500
 
 ``DISCLAMER!`` Moving your Acer Iconia Tab A500 to use U-Boot assumes
 replacement of the vendor Acer bootloader. Vendor Android firmwares will no
-longer be able to run on the device. This replacement IS reversible.
+longer be able to run on the device. This replacement IS reversible if you have
+backups.
 
 Quick Start
 -----------
@@ -13,6 +14,7 @@ Quick Start
 - Build U-Boot
 - Process U-Boot
 - Flashing U-Boot into the eMMC
+- Flashing U-Boot into the eMMC with NvFlash
 - Boot
 - Self Upgrading
 
@@ -36,61 +38,45 @@ in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
 usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+to recover the device in case of a failed update. You need to know your device
+individual SBK to continue.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev a500
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev a500 --sbk <your sbk> --split
 
-Processing for pre-loaded U-Boot
-********************************
+where SBK has next form ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX``
 
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by pre-loading vendor bootloader into RAM with the nvflash.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered by holding ``power`` and ``volume up`` buttons on
+turned off tablet connected to the host PC. Host PC should detect APX USB
+device in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ nvflash --setbct --bct picasso.bct --configfile flash.cfg --bl bootloader.bin
-        --sbk 0xXXXXXXXX 0xXXXXXXXX 0xXXXXXXXX 0xXXXXXXXX --sync # replace with your SBK
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device.
-
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+    $ ./utils/nvflash_t20 --setbct --bct ./bct/picasso.bct --configfile ./utils/flash.cfg
+        --bl u-boot-dtb-tegra.bin --sbk <your sbk> --sync
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -104,6 +90,37 @@ After, on host PC, do:
 
 Device will reboot.
 
+Flashing U-Boot into the eMMC with NvFlash
+------------------------------------------
+
+``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
+
+This method is discouraged and is used only if fastboot commands from previous
+chapter failed with ``Writing '0.1' FAILED (remote: 'too large for partition')``
+error. This error means that your tablet has 512 Kb boot0/boot1 partitions which
+is too small to contain U-Boot image as the minimum boot partition size must
+me 1 MB. This situation can be workarounded but self-update will not work and
+flashing to eMMC will wipe U-Boot. This should not be a big issue since installing
+OS on microSD is a preferred method anyway.
+
+This method involves use of Nv3p. Nv3p is a custom Nvidia protocol used to
+recover bricked devices. Devices can enter it by pre-loading vendor bootloader
+into RAM with the nvflash.
+
+With Nv3p, ``repart-block.bin`` is used (produced by re-crypt without ``--split``
+key). It contains BCT and a bootloader in encrypted state in form, which can just
+be written RAW at the start of eMMC. Place your ``repart-block.bin`` and vendor
+bootloader with name ``bootloader.bin`` into fusee-tools folder and run:
+
+.. code-block:: bash
+
+    $ ./utils/nvflash_t20 --setbct --bct ./bct/picasso.bct --configfile ./utils/flash.cfg
+        --bl ./bootloader.bin --sbk <your sbk> --sync
+    $ ./utils/nvflash_t20 --resume --rawdevicewrite 0 1024 ./repart-block.bin
+
+When flashing is done, reboot the device.
+
 Boot
 ----
 
@@ -113,8 +130,8 @@ device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
 as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
 and update bootloader (check the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/asus/grouper.rst b/doc/board/asus/grouper.rst
index 14469582907..78183482a00 100644
--- a/doc/board/asus/grouper.rst
+++ b/doc/board/asus/grouper.rst
@@ -5,7 +5,8 @@ U-Boot for the ASUS/Google Nexus 7 (2012)
 
 ``DISCLAMER!`` Moving your ASUS/Google Nexus 7 (2012) to use U-Boot assumes
 replacement of the vendor ASUS bootloader. Vendor android firmwares will no
-longer be able to run on the device. This replacement IS reversible.
+longer be able to run on the device. This replacement IS reversible if you
+have backups.
 
 Quick Start
 -----------
@@ -39,65 +40,45 @@ Process U-Boot
 in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
-usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update. You need to know your
-tablet's individual SBK to continue.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update. You need to know your device
+individual SBK to continue.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev grouper --sbk <your sbk>
+    $ ./re-crypt.py --dev grouper --sbk <your sbk> --split # or --dev tilapia
 
 where SBK has next form ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX``
 
-The script will produce a ``repart-block.bin`` ready to flash.
-
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it by pre-loading vendor bootloader with the Fusée Gelée.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered by holding ``power`` and ``volume up`` buttons on
+turned off tablet connected to the host PC. Host PC should detect APX USB
+device in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ ./run_bootloader.sh -s T30 -t ./bct/grouper.bct -b android_bootloader.bin
-    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device. Note that if you have cellular version,
-use ``tilapia.bct``.
-
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+    $ ./run_bootloader.sh -s T30 -t ./bct/grouper.bct --b u-boot-dtb-tegra.bin # or tilapia.bct
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -120,8 +101,8 @@ bootmenu. Bootmenu contains entries to mount eMMC as mass storage, fastboot,
 reboot, reboot RCM, poweroff, enter U-Boot console and update bootloader (check
 the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/asus/transformer_t20.rst b/doc/board/asus/transformer_t20.rst
index 4f4f893c3a8..2b721b4c076 100644
--- a/doc/board/asus/transformer_t20.rst
+++ b/doc/board/asus/transformer_t20.rst
@@ -5,7 +5,8 @@ U-Boot for the ASUS Eee Pad Transformer device family
 
 ``DISCLAMER!`` Moving your ASUS Eee Pad Transformer/Slider to use U-Boot
 assumes replacement of the vendor ASUS bootloader. Vendor Android firmwares
-will no longer be able to run on the device. This replacement IS reversible.
+will no longer be able to run on the device. This replacement IS reversible
+if you have backups.
 
 Quick Start
 -----------
@@ -40,61 +41,46 @@ in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
 usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+to recover the device in case of a failed update. You need to know your device
+individual SBK to continue.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev tf101
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev tf101v1 --split # or tf101v2 or sl101 as --dev
 
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it either by using ``wheelie`` with the correct ``blob.bin`` file or by
-pre-loading vendor bootloader with the Fusée Gelée.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered by holding ``power`` and ``volume up`` buttons on
+turned off tablet connected to the host PC. Host PC should detect APX USB
+device in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ wheelie -1 --bl bootloader.bin --bct tf101.bct --odm 0x300d8011 || break
-    $ nvflash --resume --rawdevicewrite 0 2048 repart-block.bin
-
-When flashing is done, reboot the device.
-
-Flashing with a pre-loaded U-Boot
-*********************************
+    $ ./utils/nvflash_t20 --setbct --bct ./bct/<dev>.bct --configfile ./utils/flash.cfg
+        --bl u-boot-dtb-tegra.bin --sbk <your sbk> --sync
 
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+Where <dev> is your devie codename, either ``tf101`` or ``sl101`` and <your sbk> is SBK
+of your device in the form ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX``
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -117,8 +103,8 @@ device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
 as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
 and update bootloader (check the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/asus/transformer_t30.rst b/doc/board/asus/transformer_t30.rst
index 012a38251aa..cb55b2dbd56 100644
--- a/doc/board/asus/transformer_t30.rst
+++ b/doc/board/asus/transformer_t30.rst
@@ -5,7 +5,7 @@ U-Boot for the ASUS Transformer device family
 
 ``DISCLAMER!`` Moving your ASUS Transformer to use U-Boot assumes replacement
 of the vendor ASUS bootloader. Vendor Android firmwares will no longer be
-able to run on the device. This replacement IS reversible.
+able to run on the device. This replacement IS reversible if you have backups.
 
 Quick Start
 -----------
@@ -45,65 +45,51 @@ Process U-Boot
 in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
-usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update. You need to know your
-tablet's individual SBK to continue.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update. You need to know your device
+individual SBK to continue.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev tf201 --sbk <your sbk>
+    $ ./re-crypt.py --dev tf201 --sbk <your sbk> --split
 
 where SBK has next form ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX``
 
-The script will produce a ``repart-block.bin`` ready to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+``NOTE!`` If you have TF700T it may have different sizes of boot0/boot1 partitions,
+re-crypt sets default boot partition size to 2MB and if you have different size
+add ``--bootsize` key with yout boot partition size in bytes to the command.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it by pre-loading vendor bootloader with the Fusée Gelée.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered by holding ``power`` and ``volume up`` buttons on
+turned off tablet connected to the host PC. Host PC should detect APX USB
+device in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ ./run_bootloader.sh -s T30 -t ./bct/tf201.bct -b android_bootloader.bin
-    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device. Note that you should adjust bct file
-name according to your device.
+    $ ./run_bootloader.sh -s T30 -t ./bct/<dev>.bct --b u-boot-dtb-tegra.bin
 
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+Where <dev> is your devie codename (``tf201``, ``tf300t``, ``tf700t`` etc.).
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -124,6 +110,14 @@ Some of Transformers use a separate 4 MB SPI flash, which contains all data
 required for boot. It is flashed from within U-Boot itself, preloaded into RAM
 using Fusée Gelée.
 
+Create ``repart-block.bin`` using re-crypt without ``--split`` key:
+
+.. code-block:: bash
+
+    $ git clone https://gitlab.com/grate-driver/re-crypt.git
+    $ cd re-crypt # place your u-boot-dtb-tegra.bin here
+    $ ./re-crypt.py --dev tf600t --sbk <your sbk>
+
 After creating your ``repart-block.bin`` you have to place it on a 1st partition
 of microSD card formated in fat. Then insert this microSD card into your tablet
 and boot it using Fusée Gelée and U-Boot, which was included into
@@ -147,8 +141,8 @@ device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
 as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
 and update bootloader (check the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/htc/endeavoru.rst b/doc/board/htc/endeavoru.rst
index 53df2d09a6f..415356da4e5 100644
--- a/doc/board/htc/endeavoru.rst
+++ b/doc/board/htc/endeavoru.rst
@@ -3,9 +3,9 @@
 U-Boot for the HTC One X (endeavoru)
 ====================================
 
-``DISCLAMER!`` Moving your HTC ONe X to use U-Boot assumes replacement of the
+``DISCLAMER!`` Moving your HTC One X to use U-Boot assumes replacement of the
 vendor hboot. Vendor android firmwares will no longer be able to run on the
-device. This replacement IS reversible.
+device. This replacement IS reversible if you have backups.
 
 Quick Start
 -----------
@@ -35,61 +35,42 @@ Process U-Boot
 in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
-usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev endeavoru
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev endeavoru --split
 
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it by pre-loading vendor bootloader with the Fusée Gelée.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. For HTC One X (endeavoru) this mode can be entered using ``fastboot oem rcm``
+command from modified S-OFF bootloader or using testpad on motherboard. Host PC
+should detect APX USB device in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ ./run_bootloader.sh -s T30 -t ./bct/endeavoru.bct -b android_bootloader.bin
-    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device.
-
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+    $ ./run_bootloader.sh -s T30 -t ./bct/endeavoru.bct --b u-boot-dtb-tegra.bin
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -112,8 +93,8 @@ bootmenu. Bootmenu contains entries to mount eMMC as mass storage, fastboot,
 reboot, reboot RCM, poweroff, enter U-Boot console and update bootloader (check
 the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/lg/star.rst b/doc/board/lg/star.rst
index 9e480929182..580a6ee9468 100644
--- a/doc/board/lg/star.rst
+++ b/doc/board/lg/star.rst
@@ -5,7 +5,7 @@ U-Boot for the LG Optimus 2X P990
 
 ``DISCLAMER!`` Moving your device to use U-Boot assumes replacement of the
 vendor bootloader. Vendor Android firmwares will no longer be able to run on
-the device. This replacement IS reversible.
+the device. This replacement IS reversible if you have backups.
 
 Quick Start
 -----------
@@ -35,62 +35,42 @@ Process U-Boot
 in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
-usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev star
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev star --split
 
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue. Additionally you must install ``tegrarcm``.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it by pre-loading vendor bootloader with nvflash.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered by holding ``power`` and both volume buttons on
+turned off phone connected to the host PC. Host PC should detect APX USB device
+in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ ./nvflash_v1.13.87205 --bct star.bct --setbct --odmdata 0xC8000
-      --configfile flash.cfg --bl android_bootloader.bin --sync
-    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 2048 repart-block.bin
-
-When flashing is done, reboot the device.
-
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+    $ tegrarcm --bct ./bct/star.bct --bootloader u-boot-dtb-tegra.bin --loadaddr 0x108000
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -113,8 +93,8 @@ device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
 as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
 and update bootloader (check the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/lg/x3_t30.rst b/doc/board/lg/x3_t30.rst
index 9ff75034b72..45a75f6d57f 100644
--- a/doc/board/lg/x3_t30.rst
+++ b/doc/board/lg/x3_t30.rst
@@ -5,7 +5,7 @@ U-Boot for the LG X3 T30 device family
 
 ``DISCLAMER!`` Moving your LG P880 or P895 to use U-Boot assumes replacement
 of the vendor LG bootloader. Vendor android firmwares will no longer be able
-to run on the device. This replacement IS reversible.
+to run on the device. This replacement IS reversible if you have backups.
 
 Quick Start
 -----------
@@ -38,62 +38,42 @@ Process U-Boot
 in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
-usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev p895
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev p895 --split # or --dev p880
 
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it by pre-loading vendor bootloader with the Fusée Gelée.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered by holding ``power`` and both buttons on turned
+off phone connected to the host PC. Host PC should detect APX USB device in
+``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
 
 .. code-block:: bash
 
-    $ ./run_bootloader.sh -s T30 -t ./bct/p895.bct -b android_bootloader.bin
-    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device. Note that if you have Optimus 4x HD,
-use ``p880.bct``.
-
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+    $ ./run_bootloader.sh -s T30 -t ./bct/p895.bct --b u-boot-dtb-tegra.bin # or p880.bct
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -116,8 +96,8 @@ bootmenu. Bootmenu contains entries to mount eMMC as mass storage, fastboot,
 reboot, reboot RCM, poweroff, enter U-Boot console and update bootloader (check
 the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/microsoft/surface-2.rst b/doc/board/microsoft/surface-2.rst
index 8185c6f5ae4..93d9d613cdb 100644
--- a/doc/board/microsoft/surface-2.rst
+++ b/doc/board/microsoft/surface-2.rst
@@ -33,7 +33,7 @@ directory with
 
 .. code-block:: bash
 
-    $ ./run_bootloader.sh -s T30 -t ./bct/surface-2.bct
+    $ ./run_bootloader.sh -s T114 -t ./bct/surface-2.bct
 
 To boot Linux, U-Boot will look for an ``extlinux.conf`` on MicroSD and then on
 eMMC. Additionally, if the Volume Down button is pressed while loading, the
diff --git a/doc/board/motorola/mot.rst b/doc/board/motorola/mot.rst
index d0f89bcd357..80f85ec9dfd 100644
--- a/doc/board/motorola/mot.rst
+++ b/doc/board/motorola/mot.rst
@@ -67,9 +67,26 @@ Flashing U-Boot into the eMMC
 ``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
+
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
+
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. For Motorola Atrix 4G (MB860) and Droid X2 (MB870) this mode can be entered
+from vendor bootloader menu and with special cable from prerequisites chapter.
+Host PC should detect APX USB device in ``lsusb``.
+
 U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
 U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
+
+.. code-block:: bash
+
+    $ ./utils/nvflash_t20 --setbct --bct ./bct/olympus.bct --configfile ./utils/flash.cfg
+      --bl u-boot-dtb-tegra.bin --sbk <your sbk> --sync
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -92,8 +109,8 @@ device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
 as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
 and update bootloader (check the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/ouya/ouya.rst b/doc/board/ouya/ouya.rst
index 641affc6294..6cc68b01f90 100644
--- a/doc/board/ouya/ouya.rst
+++ b/doc/board/ouya/ouya.rst
@@ -5,7 +5,7 @@ U-Boot for the Ouya Game Console (ouya)
 
 ``DISCLAMER!`` Moving your Ouya to use U-Boot assumes replacement of the
 vendor bootloader. Vendor android firmwares will no longer be able to run on the
-device. This replacement IS reversible.
+device. This replacement IS reversible if you have backups.
 
 Quick Start
 -----------
@@ -35,62 +35,44 @@ Process U-Boot
 in re-crypt repo issues. NOT HERE!
 
 re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
-usable by device. This process is required only on the first installation or
-to recover the device in case of a failed update.
-
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
+usable by device. This process is required only on the first installation or to
+recover the device in case of a failed update. You need to know your device
+individual SBK to continue.
 
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev ouya
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev ouya --sbk <your sbk> --split
 
-Processing for pre-loaded U-Boot
-********************************
+where SBK has next form ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX`` ``0xXXXXXXXX``
 
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM. Regardless of the method bct and bootloader
-will end up in boot0 and boot1 partitions of eMMC.
-
-Flashing with the NV3P protocol
-*******************************
-
-``DISCLAMER!`` All questions related to NvFlash should be asked in the proper
+``DISCLAMER!`` All questions related to fusee-tools should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Devices can
-enter it by pre-loading vendor bootloader with the Fusée Gelée.
-
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-.. code-block:: bash
-
-    $ ./run_bootloader.sh -s T30 -t ./bct/ouya.bct -b android_bootloader.bin
-    $ ./utiils/nvflash_v1.13.87205 --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device.
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue.
 
-Flashing with a pre-loaded U-Boot
-*********************************
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered from testpad on motherboard with device connected
+to the host PC. Host PC should detect APX USB device in ``lsusb``.
 
 U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
 U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+fusee-tools:
+
+.. code-block:: bash
+
+    $ ./run_bootloader.sh -s T30 -t ./bct/ouya.bct --b u-boot-dtb-tegra.bin
 
 While pre-loading U-Boot, interrupt bootflow by pressing ``CTRL + C`` (USB keyboard
 must be plugged in before U-Boot is preloaded, else it will not work), input
@@ -113,8 +95,8 @@ bootmenu provides entries to mount eMMC as mass storage, fastboot, reboot,
 reboot RCM, poweroff, enter U-Boot console and update bootloader (check
 the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/samsung/n1.rst b/doc/board/samsung/n1.rst
index 4dbb3141774..89bd2c8d6d1 100644
--- a/doc/board/samsung/n1.rst
+++ b/doc/board/samsung/n1.rst
@@ -5,7 +5,8 @@ U-Boot for the Samsung N1 device family
 
 ``DISCLAMER!`` Moving your Samsung Galaxy R (GT-I9103) or Samsung Captivate Glide
 (SGH-i927) to use U-Boot assumes replacement of the sboot. Vendor android firmwares
-will no longer be able to run on the device. This replacement IS reversible.
+will no longer be able to run on the device. This replacement IS reversible if you
+have backups.
 
 Quick Start
 -----------
diff --git a/doc/board/wexler/qc750.rst b/doc/board/wexler/qc750.rst
index 169629c7e47..8cf118032cf 100644
--- a/doc/board/wexler/qc750.rst
+++ b/doc/board/wexler/qc750.rst
@@ -5,7 +5,7 @@ U-Boot for the WEXLER QC750 tablet
 
 ``DISCLAMER!`` Moving your WEXLER QC750 to use U-Boot assumes replacement
 of the vendor bootloader. Vendor Android firmwares will no longer be able
-to run on the device. This replacement IS reversible.
+to run on the device. This replacement IS reversible if you have backups.
 
 Quick Start
 -----------
@@ -38,26 +38,13 @@ re-crypt is a tool that processes the ``u-boot-dtb-tegra.bin`` binary into form
 usable by device. This process is required only on the first installation or
 to recover the device in case of a failed update.
 
-Permanent installation can be performed either by using the tegrarcm or by
-pre-loading just built U-Boot into RAM.
-
-Processing for the NV3P protocol
-********************************
-
 .. code-block:: bash
 
     $ git clone https://gitlab.com/grate-driver/re-crypt.git
     $ cd re-crypt # place your u-boot-dtb-tegra.bin here
-    $ ./re-crypt.py --dev qc750
-
-The script will produce a ``repart-block.bin`` ready to flash.
+    $ ./re-crypt.py --dev qc750 --split
 
-Processing for pre-loaded U-Boot
-********************************
-
-The procedure is the same, but the ``--split`` argument is used with the
-``re-crypt.py``. The script will produce ``bct.img`` and ``ebt.img`` ready
-to flash.
+The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
 Flashing U-Boot into the eMMC
 -----------------------------
@@ -65,31 +52,24 @@ Flashing U-Boot into the eMMC
 ``DISCLAMER!`` All questions related to tegrarcm should be asked in the proper
 place. NOT HERE! Flashing U-Boot will erase all eMMC, so make a backup before!
 
-Permanent installation can be performed either by using the nv3p protocol or by
-pre-loading just built U-Boot into RAM.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
-Flashing with the NV3P protocol
-*******************************
+You have to clone and prepare fusee-tools from here: https://gitlab.com/grate-driver/fusee-tools
+according to fusee-tools README to continue. Additionally you must install ``tegrarcm``.
 
-Nv3p is a custom Nvidia protocol used to recover bricked devices. Tegrarcm is
-used to handle such state.
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered via testpad on unpopulated RCM button on motherboard
+on device connected to the host PC. Host PC should detect APX USB device in ``lsusb``.
 
-With nv3p, ``repart-block.bin`` is used. It contains BCT and a bootloader in
-encrypted state in form, which can just be written RAW at the start of eMMC.
+U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
+U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
+of U-Boot permanently into eMMC. This is how U-Boot can be preloaded using
+tegrarcm:
 
 .. code-block:: bash
 
-    $ tegrarcm --bct qc750.bct --bootloader android_bootloader.bin --loadaddr 0x80108000
-    $ nvflash --resume --rawdevicewrite 0 1024 repart-block.bin
-
-When flashing is done, reboot the device.
-
-Flashing with a pre-loaded U-Boot
-*********************************
-
-U-Boot pre-loaded into RAM acts the same as when it was booted "cold". Currently
-U-Boot supports bootmenu entry fastboot, which allows to write a processed copy
-of U-Boot permanently into eMMC.
+    $ tegrarcm --bct ./bct/qc750.bct --bootloader u-boot-dtb-tegra.bin --loadaddr 0x80108000
 
 While pre-loading U-Boot, hold the ``volume down`` button which will trigger
 the bootmenu. There, select ``fastboot`` using the volume and power buttons.
@@ -112,8 +92,8 @@ device will enter bootmenu. Bootmenu contains entries to mount MicroSD and eMMC
 as mass storage, fastboot, reboot, reboot RCM, poweroff, enter U-Boot console
 and update bootloader (check the next chapter).
 
-Flashing ``repart-block.bin`` eliminates vendor restrictions on eMMC and allows
-the user to use/partition it in any way the user desires.
+Flashing ``bct.img`` and ``ebt.img`` eliminates vendor restrictions on eMMC and
+allows the user to use/partition it in any way the user desires.
 
 Self Upgrading
 --------------
diff --git a/doc/board/xiaomi/mocha.rst b/doc/board/xiaomi/mocha.rst
index 230081e3287..6339e4eb574 100644
--- a/doc/board/xiaomi/mocha.rst
+++ b/doc/board/xiaomi/mocha.rst
@@ -60,11 +60,15 @@ installation or to recover the device in case of a failed update.
 
 The script will produce ``bct.img`` and ``ebt.img`` ready to flash.
 
-Permanent installation can be performed by pre-loading just built U-Boot
-into RAM via tegrarcm. While pre-loading U-Boot, hold the ``volume down``
-button which will trigger the bootmenu. There, select ``fastboot`` using
-the volume and power buttons.
+Permanent installation can be performed by pre-loading just built U-Boot into RAM.
+Bct and bootloader will end up in boot0 and boot1 partitions of eMMC.
 
+Bootloader preloading is performed to device in APX/RCM mode connected to host
+PC. This mode can be entered via testad on motherboard on turned off device
+connected to the host PC. Host PC should detect APX USB device in ``lsusb``.
+
+While pre-loading U-Boot, hold the ``volume down`` button which will trigger
+the bootmenu. There, select ``fastboot`` using the volume and power buttons.
 After, on host PC, do:
 
 .. code-block:: bash
-- 
2.51.0

