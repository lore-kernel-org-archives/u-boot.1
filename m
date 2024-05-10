Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FC6C25B4F
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 05:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD17788856;
	Fri, 10 May 2024 07:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E+OMFCbV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBF68884C; Fri, 10 May 2024 07:52:49 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF77D88176
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 07:52:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [149.11.192.251])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CD73C4081A; 
 Fri, 10 May 2024 05:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1715320362;
 bh=1o9wFFSuj8fNvKXRoOmhhztIp5Uq4zFVIianpDwINIE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version:Content-Type;
 b=E+OMFCbVeai2GYpfxa5WfZp4J7hHEWu94Ly6xd8jVeisjr7HI18HT95+wEDpgKr5m
 tCzyEBNtMdwStqCo5yWqyB9zR7w6OHR4FWmFnGkXQWh2edeqVnxi4SEcsigCjDn4cr
 v+RfXjy40ib3xIPUTFM7DAlSy0QITvFMBmCgvz0xircqKIeSu+0Iumovb8YVOWQpR5
 yTqov4WDOfOqLtHWxFqSjtrEGmWc64N3bydT24VBbNhFgEWP4wOaqtT8Y34C5yb8i2
 qgO9FZNnh3DwmRdVpl6G06ui2kcHo2IVxsGJG+xODTdKdx35RDP3HB6yVLRXPNrFib
 WFrvP+Z/b6xJQ==
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
Subject: [PATCH v4 3/5] doc: Milk-V Mars CM and Milk-V Mars CM Lite
Date: Fri, 10 May 2024 07:52:19 +0200
Message-ID: <20240510055223.11617-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
References: <20240510055223.11617-1-heinrich.schuchardt@canonical.com>
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
Reviewed-by: E Shattow <lucent@gmail.com>
---
v4:
	remove .rst extension from toctree links
	remove superfluous word 'connected' describing booting from SPI
	flash
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
@@ -7,5 +7,6 @@ StarFive
 .. toctree::
    :maxdepth: 1
 
-   milk-v_mars.rst
+   milk-v_mars
+   milk-v_mars_cm
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
+With nRPIBOOT disconnected from ground for SPI boot, power up the board. You
+should see the U-Boot prompt on the serial console.
-- 
2.43.0

