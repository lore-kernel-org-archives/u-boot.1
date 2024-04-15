Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC90C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 11:51:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F39588233;
	Mon, 15 Apr 2024 13:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BC1uTJ8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D1F88213; Mon, 15 Apr 2024 13:51:01 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9904C8822D
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:50:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 14A4A4123A
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713181859;
 bh=9b7IwGGzZUJATp+iJLlqiXGedmkhe/b4Y3xvgNeNLR8=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=BC1uTJ8kHeCQG3yO+u1ts4mVTUsoQc0FWhOYgHG5CBTAI/9oUNDkpzoke6VFPonp4
 x2LfGg7VmdiUZsvSG8ldSIXxAn29CxEzmL/NkyWcUwCeXNHA1VywHMIZjQmpegP53y
 DQ6B13clodefOWkzJXxqom2fDadYSJNBH5F9OinoFMiPfJY2IHne2QQDkOLNhjS83r
 YmoDl+OuwgOn/zl1s9VdCBRz6AJ5feRHQRV1VS8rD+8qCb/Pe4RGuh/CYq+Pf4VWxN
 XApTHdnjH/+iCbf32iVa4goK+dgCDwnR4oHoNdLp2Eplz2i/0YlEZqUuBvVx/r7sSC
 IUnfllt6I3fJA==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-345fa9052b7so2000629f8f.1
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 04:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713181854; x=1713786654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9b7IwGGzZUJATp+iJLlqiXGedmkhe/b4Y3xvgNeNLR8=;
 b=VcHFoHBs1KBxJ2NJ7LlgVWqATqT97sxL/vW7WroeMhKwgtYhJZ+N48ic4mtODIEBKc
 t5I+CtLyYfQCjE7SEVhqbUACUlQj4da8+nWE9xu0KcxU7oCr1Vh6V2JK92NmOVB/gw9E
 s2D08cEyeCSVXZqxlkmWykJEPT6B4jPIL38kAOw4G5Pi51vzE9VHHo5BbEkzoNwe3BCU
 D8t1CbyBZX7mNPQhYnwRobktr5KPS6LWIJIIv0BTRuOiN0xloe0KQgHtIuZBnuuRYwDM
 D2P5mEJl69HSeIvlDgDQbL9IYsrGG8ekBgN8e4cIAKj5/nnQbKrj0lHWkbusxXW7Jx41
 VeUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd5YxJkXmymB/KapZyFu/o5daO1eK8iEU3MLzbDNfVhwQMUoFcE8G82OMEcK/1NjnAUlVRziyz19kr5dcVPrLWjbrj0Q==
X-Gm-Message-State: AOJu0Ywg5Ne9RtYTcwlIKuXCXveAPTDwYjIKKCzWYCR2+l73qCUsUY99
 7UVP7WfAMQ7VOY6t50uk+E7/EGIMaZMMS/1l77PdrU7C7A9MefPIlzbxpC5/EdB2XVsL0HOtJ6F
 JQk7x1caBSgvrVc1oYtGrNpYe+iH/8Lfjw4PdwkJsHaU9M8DsQ1Xh5Fm+Pain8RCzc+0=
X-Received: by 2002:a5d:470c:0:b0:343:7ced:8913 with SMTP id
 y12-20020a5d470c000000b003437ced8913mr9299702wrq.23.1713181853962; 
 Mon, 15 Apr 2024 04:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQn4EhX0Iuf0b2arj0VCs2YGSMj+Obe+kyFbr3VO4NFX83u1vK+WCMB2dmD+ZIMAE6hdfeqg==
X-Received: by 2002:a5d:470c:0:b0:343:7ced:8913 with SMTP id
 y12-20020a5d470c000000b003437ced8913mr9299687wrq.23.1713181853673; 
 Mon, 15 Apr 2024 04:50:53 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 j10-20020adff00a000000b003469e7f5c52sm11924130wro.80.2024.04.15.04.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 04:50:53 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Shengyu Qu <wiagn233@outlook.com>,
 Shiji Yang <yangshiji66@outlook.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 3/4] doc: Milk-V Mars CM and Milk-V Mars CM Lite
Date: Mon, 15 Apr 2024 13:50:34 +0200
Message-ID: <20240415115035.46199-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
References: <20240415115035.46199-1-heinrich.schuchardt@canonical.com>
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

Provide a man-page describing the usage of U-Boot on
the Milk-V Mars CM and Milk-V Mars CM Lite boards.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/board/starfive/index.rst          |   1 +
 doc/board/starfive/milk-v_mars_cm.rst | 125 ++++++++++++++++++++++++++
 2 files changed, 126 insertions(+)
 create mode 100644 doc/board/starfive/milk-v_mars_cm.rst

diff --git a/doc/board/starfive/index.rst b/doc/board/starfive/index.rst
index 2762bf74c11..afa85ad2540 100644
--- a/doc/board/starfive/index.rst
+++ b/doc/board/starfive/index.rst
@@ -7,4 +7,5 @@ StarFive
    :maxdepth: 1
 
    milk-v_mars.rst
+   milk-v_mars_cm.rst
    visionfive2
diff --git a/doc/board/starfive/milk-v_mars_cm.rst b/doc/board/starfive/milk-v_mars_cm.rst
new file mode 100644
index 00000000000..4cd6034281c
--- /dev/null
+++ b/doc/board/starfive/milk-v_mars_cm.rst
@@ -0,0 +1,125 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Mars CM
+==============
+
+U-Boot for the Milk-V Mars CM uses the same U-Boot binaries as the VisionFive 2
+board. In U-Boot SPL the actual board is detected and the device-tree patched
+accordingly.
+
+The Milk-V Mars CM Lite comes without eMMC it needs a different pin muxing.
+The size of the eMMC shows up in the serial number shown by the *mac* command,
+e.g. MARC-V10-2340-D002E016-00000304. The number after the E is the MMC size
+in GB. U-Boot takes a value of E000 as an indicator for the Lite version.
+Unfortunately the vendor has not set this value correctly on some Lite boards.
+Please, use CONFIG_STARFIVE_NO_EMMC=y to indicate a Milk-V Mars CM Lite in this
+case. Otherwise you will not be able to read from eMMC
+
+Building
+~~~~~~~~
+
+1. Add the RISC-V toolchain to your PATH.
+2. Setup ARCH & cross compilation environment variable:
+
+.. code-block:: none
+
+   export CROSS_COMPILE=<riscv64 toolchain prefix>
+
+The M-mode software OpenSBI provides the supervisor binary interface (SBI) and
+is responsible for the switch to S-Mode. It is a prerequisite to build U-Boot.
+Support for the JH7110 was introduced in OpenSBI 1.2. It is recommended to use
+a current release.
+
+.. code-block:: console
+
+	git clone https://github.com/riscv/opensbi.git
+	cd opensbi
+	make PLATFORM=generic FW_TEXT_START=0x40000000 FW_OPTIONS=0
+
+Now build the U-Boot SPL and U-Boot proper.
+
+.. code-block:: console
+
+	cd <U-Boot-dir>
+	make starfive_visionfive2_defconfig
+	make OPENSBI=$(opensbi_dir)/build/platform/generic/firmware/fw_dynamic.bin
+
+This will generate the U-Boot SPL image (spl/u-boot-spl.bin.normal.out) as well
+as the FIT image (u-boot.itb) with OpenSBI and U-Boot.
+
+Device-tree selection
+~~~~~~~~~~~~~~~~~~~~~
+
+Depending on the board version U-Boot sets variable $fdtfile to either
+starfive/jh7110-milkv-mars-cm-emmc.dtb (for the generic version or
+starfive/jh7110-milkv-mars-cm-sdcard.dtb (for the Lite version).
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    setenv fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
+provide a default value.
+
+Boot source selection
+~~~~~~~~~~~~~~~~~~~~~
+
+The low speed connector nRPIBOOT line is used to switch the boot source.
+
+* If nRPIBOOT is connected to ground, the board boots from UART.
+* If nRPIBOOT is not connected, the board boots from SPI flash.
+
+Flashing a new U-Boot version
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
+in file u-boot.itb.
+
+Assuming your new U-Boot version is on partition 1 of an SD-card you could
+install to the SPI flash with:
+
+::
+
+    sf probe
+    load mmc 1:1 $kernel_addr_r u-boot-spl.bin.normal.out
+    sf update $kernel_addr_r 0 $filesize
+    load mmc 1:1 $kernel_addr_r u-boot.itb
+    sf update $kernel_addr_r 0x100000 $filesize
+
+After updating U-Boot you may want to reboot and reset the environment to the
+default.
+
+::
+
+    env default -f -a
+    env save
+
+Booting from UART
+~~~~~~~~~~~~~~~~~
+
+For booting via UART U-Boot must be built with CONFIG_SPL_YMODEM_SUPPORT=y.
+
+Upload u-boot-spl.bin.normal.out via XMODEM. Then upload u-boot.itb via
+YMODEM.
+
+The XMODEM implementation in the boot ROM is not fully specification compliant.
+It sends too many NAKs in a row. Some tolerant terminal implementations exist.
+Or use a dedicated recovery tool e.g.
+https://github.com/xypron/JH71xx-tools/tree/VisionFive2:
+
+.. code-block:: bash
+
+    # send U-Boot SPL via XMODEM
+    vf2-recover -D /dev/ttyUSB0 -r u-boot-spl.bin.normal.out
+    # connect to board to transfer main U-Boot via YMODEM
+    picocom --send-cmd 'sz -b -vv' --baud 115200 /dev/ttyUSB0
+    # In Picocom use <CTRL+A>,<CTRL+S> to send u-boot.itb
+
+Booting from SPI flash
+~~~~~~~~~~~~~~~~~~~~~~
+
+Once you power up, you should see the U-Boot prompt on the serial console.
-- 
2.43.0

