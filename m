Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9F6C25B10
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 10:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08213884AA;
	Thu,  9 May 2024 12:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="g/rh5wjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E45C880AD; Thu,  9 May 2024 12:12:11 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062AB88480
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 12:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.lan (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id E311D4081A; 
 Thu,  9 May 2024 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715249525;
 bh=w8QaHU64+vaGJUaczfpolmO0I7V1EP8nb7xAqfuOJG0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=g/rh5wjRAZCPUMRcqy+9QVB7dSOp5xdAFkIcKimSm1Nz2FdgEM97GN7B0SepDD3+l
 uCPslU0LOiyvviU06e/XGnFaL5XbEIurXACvLQ/1vYAeYypT8fBfaCx2tLTKPbK3oJ
 9/ZuhSJrkVN51b48NBngFQZcqSETHRFTUVR68mcWdaKSQ+I/BsHap+czYDDVcT9Hl1
 YgENBJcQHeqt8l04SK4MagcQfhjU0jV9EkHYTbDxPEGGhXuhRS71r2nDmwh7g1v9xX
 A3irvA/KESCy/aWadxDi0rHSPyhO5ceTrQ26zuPmWqRkZ6gfqXz9J4axiCKEAclT81
 viHcLGO85TK/Q==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Lukasz Tekieli <tekieli.lukasz@gmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Shiji Yang <yangshiji66@outlook.com>, Shengyu Qu <wiagn233@outlook.com>,
 Michal Simek <michal.simek@amd.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Mason Huo <mason.huo@starfivetech.com>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/5] doc: Milk-V Mars CM and Milk-V Mars CM Lite
Date: Thu,  9 May 2024 12:11:51 +0200
Message-ID: <20240509101155.18666-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240509101155.18666-1-heinrich.schuchardt@canonical.com>
References: <20240509101155.18666-1-heinrich.schuchardt@canonical.com>
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

Provide a man-page describing the usage of U-Boot on
the Milk-V Mars CM and Milk-V Mars CM Lite boards.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	correct device-tree names
	suggest not to use mac initialize
	refer to XMODEM-1K
v2:
	refer to tio as tool for booting via UART
	describe how to update serial number
	description updates as suggested by E. Shattow
---
 doc/board/starfive/index.rst          |   1 +
 doc/board/starfive/milk-v_mars_cm.rst | 193 ++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)
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
index 00000000000..68561adadfc
--- /dev/null
+++ b/doc/board/starfive/milk-v_mars_cm.rst
@@ -0,0 +1,193 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Milk-V Mars CM
+==============
+
+U-Boot for the Milk-V Mars CM uses the same U-Boot binaries as the VisionFive 2
+board. In U-Boot SPL the actual board is detected and the device-tree patched
+accordingly.
+
+The Milk-V Mars CM Lite comes without eMMC and needs a different pin muxing
+than the Milk-V Mars CM. The availability and size of the eMMC shows up in the
+serial number displayed by the *mac* command, e.g.
+MARC-V10-2340-D002E016-00000304. The number after the E is the MMC size. U-Boot
+takes a value of E000 as an indicator for the Lite version. Unfortunately the
+vendor has not set this value correctly on some Lite boards.
+
+Please, use CONFIG_STARFIVE_NO_EMMC=y if EEPROM data indicates eMMC is present
+on the Milk-V Mars CM Lite. Otherwise you will not be able to read from the
+SD-card.
+
+The serial number can be corrected using the *mac* command:
+
+.. code-block::
+
+    mac read_eeprom
+    mac product_id MARC-V10-2340-D002E000-00000304
+    mac write_eeprom
+
+.. note::
+
+   The *mac initialize* command overwrites the vendor string and the MAC
+   addresses. This is why it is avoided here.
+
+By default the EEPROM is write protected. The write protection may be overcome
+by connecting the "GND" and "EN" test pads on top of the module.
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
+	make PLATFORM=generic FW_TEXT_START=0x40000000
+
+(*FW_TEXT_START* is not needed anymore after OpenSBI patch d4d2582eef7a
+"firmware: remove FW_TEXT_START" which should appear in OpenSBI 1.5.)
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
+starfive/jh7110-milkv-mars-cm.dtb (with eMMC storage) or
+starfive/jh7110-milkv-mars-cm-lite.dtb (without eMMC storage).
+
+To overrule this selection the variable can be set manually and saved in the
+environment
+
+::
+
+    env set fdtfile my_device-tree.dtb
+    env save
+
+or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
+provide a default value.
+
+The variable *$fdtfile* is used in the boot process to automatically load
+a device-tree provided by the operating system. For details of the boot
+process refer to the :doc:`U-Boot Standard Boot <../../../develop/bootstd>`
+description.
+
+Boot source selection
+~~~~~~~~~~~~~~~~~~~~~
+
+The low speed connector nRPIBOOT line is used to switch the boot source.
+
+* If nRPIBOOT is connected to ground, the board boots from UART.
+* If nRPIBOOT is not connected, the board boots from SPI flash.
+
+Compute module boards typically have a switch or jumper for this line.
+
+Flashing a new U-Boot version
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+U-Boot SPL is provided as file spl/u-boot-spl.bin.normal.out. Main U-Boot is
+in file u-boot.itb.
+
+Assuming your new U-Boot version is on partition 1 of an SD-card you could
+install it to the SPI flash with:
+
+::
+
+    sf probe
+    load mmc 0:1 $kernel_addr_r u-boot-spl.bin.normal.out
+    sf update $kernel_addr_r 0 $filesize
+    load mmc 0:1 $kernel_addr_r u-boot.itb
+    sf update $kernel_addr_r 0x100000 $filesize
+
+For loading the files from a TFTP server refer to the dhcp and tftpboot
+commands.
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
+With nRPIBOOT connected to ground for UART boot, power the board and upload
+u-boot-spl.bin.normal.out via XMODEM. Then upload u-boot.itb via YMODEM.
+
+The XMODEM implementation in the boot ROM is not fully specification compliant.
+It sends too many NAKs in a row. Tio is a terminal emulation that tolerates
+these faults.
+
+::
+
+    $ tio -b 115200 --databits 8 --flow none --stopbits 1 /dev/ttyUSB0
+    [08:14:54.700] tio v2.7
+    [08:14:54.700] Press ctrl-t q to quit
+    [08:14:54.701] Connected
+
+    (C)StarFive
+    CCC
+    (C)StarFive
+    CCCCCCCC
+
+Press *ctrl-t x* to initiate XMODEM-1K transfer.
+
+::
+
+    [08:15:14.778] Send file with XMODEM
+    [08:15:22.459] Sending file 'u-boot-spl.bin.normal.out'
+    [08:15:22.459] Press any key to abort transfer
+    ........................................................................
+    .......................................................................|
+    [08:15:22.459] Done
+
+    U-Boot SPL 2024.07-rc1-00075-gd6a4ab20097 (Apr 25 2024 - 16:32:10 +0200)
+    DDR version: dc2e84f0.
+    Trying to boot from UART
+    CC
+
+Press *ctrl-t y* to initiate YMODEM transfer.
+
+::
+
+    [08:15:50.331] Send file with YMODEM
+    [08:15:53.540] Sending file 'u-boot.itb'
+    [08:15:53.540] Press any key to abort transfer
+    ........................................................................
+    …
+    ...............|
+    [08:15:53.540] Done
+    Loaded 1040599 bytes
+
+
+    U-Boot 2024.07-rc1-00075-gd6a4ab20097 (Apr 25 2024 - 16:32:10 +0200)
+
+Booting from SPI flash
+~~~~~~~~~~~~~~~~~~~~~~
+
+With nRPIBOOT connected disconnected from ground for SPI boot, power up the
+board. You should see the U-Boot prompt on the serial console.
-- 
2.43.0

