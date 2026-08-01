Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E91C55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0629780E9D;
	Sat,  1 Aug 2026 16:42:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8-U81jxTNDTR; Sat,  1 Aug 2026 16:42:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DCA7380E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602520;
	bh=CbIhisqE+PIZ5uCR6iGQDZr4hXA9eWCoCcrjujhsrJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qsOXS62zIjBk9kc0j/bN+5V/5A7S2BFZKcutHchTwnI8oZY58qfaAHfTNkkXVNUHG
	 fI5BGPwy3zOsjaHATMo9yOItxN2Xm+hwbvAQXF2hEH5S/9xbBxJnXg8YnqTYCzpvXR
	 lFKUCLITk9PdUHxO5d6WX2xqWwQjpmPLX7MvwyisFkoChDdxuHqQ3QfAB9O0iwRmnk
	 39qiz+Cluhpf8IsEj0b469cyQa2iOS0WQAmAFAxE+FbkDJFAIeVSbu35tNTUgkGpk6
	 oxxxb8y3qHhn7HQgBRpGWW7/R+8zDoktgdCnLZilpzZBkENbik1pAvi8gM1ZIhXdOD
	 zxPRMzih/6ZHQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCA7380E4F;
	Sat,  1 Aug 2026 16:41:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CED493B6
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B568F6070C
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E9nQiDBesJgt for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7303B6070F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7303B6070F
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7303B6070F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:55 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1933256a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602515; x=1786207315;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CbIhisqE+PIZ5uCR6iGQDZr4hXA9eWCoCcrjujhsrJg=;
 b=EDtjlTgxYCs6qFkFswlRoTgI/rHsASzb6fADfG1RlBoSpd3ks2rCJq0u09q7P7cc/j
 uEwVdp/LhZoEWXLsEgCVogn8Asn6E6LFD6LrTtu3/io8XTlS4Kj0SOtcitqQ/d1iUAO6
 N/2n/OYyFslolsqV9ZqivCjABKZjH60RTVzAbsFe4Q2VAXOmXf7piEk/V129/Q3sQ46m
 +mkAdk+DbneoI4Si/uyN6vjWSnXJUoyTS+K8DNqebEUgiG86qMwrBdS28KSbkdcIF3Nf
 CWi/BRd9g32bEo8zO/ilSKfgum4V55A15ZojkDFypWPfz/GgdahLe4dBAMxGwKU3Qg7M
 ZvKA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0hpYk3aVIvO5bzmR5pPG1ipCnaYOf5MhFc7WA/gNXUNK6l++4EgzkSSuwi1NjJfk8jROxdN0=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzKP0dLp1TEyzHws3A6mRMjJWcdmKPaYAakUxtoPtwc1J5Q9cQE
 IFdarxF9wwbjZUCWP9WK+G5mqZ1bAdwLpcQxj6Wqj19AA0057dr+LchSOidqApkdoJc=
X-Gm-Gg: AR+sD11k2/Ea+v3IuFzegx66DzAOpqkLdR4+J4QKKQ0ukhmIItkPJLS8zvLthPLMS8L
 RCvs9CI6iaIjDaRrAJV3U7STe0U31VjrOuQV+g/xO4aiLU8zkpXIzps9V67K6DHcxqCdHJhysCb
 jqLoLdlnrhMBDEHixwCya2LN5OhQnYqr5CUpoZqVURh/OrahSED9FD9xiDEGHDkYQPA/NQKHBmg
 w7Oqfv1bQ9tvoQBLv5TGMe7tcmKfOKIz/f8dzxyRUskjsuwWnbXnAtGsKSA5nmh9fMxxXg9g5A0
 6q4PR3lxlZRp021RifOvT+NXEIIPbwl8tO2vTtKwHDP3xiho6H4rfLjAbda5X7nCGgY7cyP/2vs
 dqMRcjzfnUi/ZsTPke2pyfVVSnAUKEW8W19T2rwQ6/2rA7QKxvfHaFg4J3Gq4p7e02HeXyUniwy
 sycrHy5CHy4Ia8Pwj2Dn28SEiuLJZKkX9dBfKGERjYn45ofOC2HtYOeLmzi2ddIv4JNnsNL4yHX
 cg1XkbxQfWWIfFEG8oAdJk5QZ5XRSuE9+85lKmwvA1rHZNlBCS+rbPonXq7C4zM4YaNdPNIaPeh
 y0+9alVesHQIgQCeRHAnExNBiA==
X-Received: by 2002:a17:90b:280a:b0:380:9504:9780 with SMTP id
 98e67ed59e1d1-38fbc4d4df9mr3628838a91.29.1785602514664; 
 Sat, 01 Aug 2026 09:41:54 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:53 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:50 +0800
Subject: [PATCH v8 09/11] doc: spacemit: flash on K1 SoC based boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-9-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602515; x=1786207315;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CbIhisqE+PIZ5uCR6iGQDZr4hXA9eWCoCcrjujhsrJg=;
 b=nR+FzMgoaTUdSKu0dWQ6A5JEeRTMrBUsma2VN+xBLePva4LQMr3C/9y29UEhrD5hDY
 feC5D563PIOrIjT7La3vOwEW7fMauowiGf2cT9mhZJRHBdCIj7U5PDcq8fCIhAnYpnQL
 NATr/g6/mrAKBCy/rHdoOCrMXHZu0q26CugdzpD4KVcPSaVbshaY0yP3c69szhAt84n1
 Vc5ZqQwJkuxdsWZtYAhzs401eOH+gWaxvrF4xk8s4i0OgZGiQHSROB2UGUGshSDA7LON
 e3PsTImYbuqb43jpVuiAY0LW64Xk3MAwKLUiCUq6cva4/Ipke8XqV9I/+7bz3JDU6PY9
 3/Lw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=nR+FzMgo
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
v8:
- Remove SD Card part.
v3:
- Add document on how to flash images into SD card.
---
 board/spacemit/k1/MAINTAINERS |   2 +-
 doc/board/spacemit/index.rst  |   1 +
 doc/board/spacemit/k1-mmc.rst | 167 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 1 deletion(-)

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
index 000000000000..f30f211342ff
--- /dev/null
+++ b/doc/board/spacemit/k1-mmc.rst
@@ -0,0 +1,167 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+SpacemiT K1 eMMC Guide
+======================
+
+This guide covers the method for booting and flashing U-Boot on SpacemiT K1
+based boards via USB to eMMC.
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

-- 
2.51.0

