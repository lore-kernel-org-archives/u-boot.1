Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BEBC5B552
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BCB83214;
	Fri, 30 May 2025 11:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="XE2/0oeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1250382BAF; Fri, 30 May 2025 11:49:35 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 611A683285
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:49:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 230A925317;
 Fri, 30 May 2025 11:49:32 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFChzz1WASmn; Fri, 30 May 2025 11:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748598571; bh=rVYQC+TzqQjpn2YSZXpzgkZlWwLk6wiodHam31RA41o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XE2/0oehmYLosSrMSA4jwdXgi5xiV4SWkHVRXfYRHGii3gxgVyu6/L8Ju7ZMQLrG4
 wn0RaSC5+m0Fi1vj+kQ0eI5K98C4YwM1SP773VMwgElOlZbFQqTygLzodxSEYny8Is
 l3y6eY+tmhgvMXHmWvUvPpFmvtwkoL25jJ1o4zFHjbFIdYF0OK9yp2gFYIOM1Uokh4
 q+AcaUCxwOlpIXxLBoDG6oZKZjCqyz5yF9hJ+ADZvGyqnvl193bEaPMTh3l0EstmJ2
 YEdjTNep+MhWaT1f9OQHFepaYEf56whggLE41Xl/MO57vWgzfYkkntPt78x2mUdqpJ
 tiqrsXYDhHiPg==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 5/5] doc: thead: lpi4a: Update for S-Mode proper U-Boot support
Date: Fri, 30 May 2025 09:48:51 +0000
Message-ID: <20250530094851.57198-6-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
References: <20250530094851.57198-1-ziyao@disroot.org>
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

Proper U-Boot for Lichee Pi 4A now runs in S mode instead of M mode,
which means the extra firmware, OpenSBI, must be built and integrated
in the image, and the vendor U-Boot cannot chainload the result image
anymore as it runs in M mode.

Remove redundant information about chainloading and update build steps
to mention OpenSBI firmware.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 doc/board/thead/lpi4a.rst | 125 +++++++++++---------------------------
 1 file changed, 36 insertions(+), 89 deletions(-)

diff --git a/doc/board/thead/lpi4a.rst b/doc/board/thead/lpi4a.rst
index 7e4c4ea81ee..acd7ac2698d 100644
--- a/doc/board/thead/lpi4a.rst
+++ b/doc/board/thead/lpi4a.rst
@@ -55,123 +55,70 @@ DDR driver requires a firmware to function, to build it:
 	cd th1520-firmware
 	lua5.4 ddr-generate.lua src/<CONFIGURATION_NAME>.lua th1520-ddr-firmware.bin
 
-4. Build U-Boot images
+4. Build OpenSBI Firmware
 
-The U-Boot is capable of running in M-Mode, so we can directly build it without
-OpenSBI. The DDR firmware should be copied to U-Boot source directory before
+TH1520 port of proper U-Boot runs in S mode, thus OpenSBI is required as
+SBI firmware to setup S-mode environment and provide SBI calls. It could
+be cloned and built for TH1520 as below,
+
+.. code-block:: bash
+
+	git clone https://github.com/riscv-software-src/opensbi.git
+	cd opensbi
+	make PLATFORM=generic
+
+TH1520 support in OpenSBI requires v1.2 or a more recent version.
+
+More detailed description of steps required to build fw_dynamic firmware
+is beyond the scope of this document. Please refer to OpenSBI
+documenation.
+
+5. Build U-Boot images
+
+The DDR firmware should be copied to U-Boot source directory before
 building.
 
-.. code-block:: console
+.. code-block:: bash
 
 	cd <U-Boot-dir>
 	cp <path-to-ddr-firmware> th1520-ddr-firmware.bin
 	make th1520_lpi4a_defconfig
-	make
+	make OPENSBI=<opensbi_dir>/build/platform/generic/firmware/fw_dynamic.bin
 
-This will generate u-boot-dtb.bin and u-boot-with-spl.bin. The former contains
-only proper U-Boot and is for chainloading; the later contains also SPL and
-DDR firmware and is ready for booting by BROM directly.
+This will generate u-boot-with-spl.bin, which contains SPL, DDR firmware,
+OpenSBI firmware and proper U-Boot.
 
 Booting
 ~~~~~~~
 
-Currently, we rely on vendor u-boot to initialize the clock, pinctrl subsystem,
-and chain load the mainline u-boot image either via tftp or emmc storage,
-then bootup from it.
-
-Sample boot log from Lichee PI 4A board via tftp
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-.. code-block:: none
-
-	brom_ver 8
-	[APP][E] protocol_connect failed, exit.
-
-	U-Boot SPL 2020.01-00016-g8c870a6be8 (May 20 2023 - 01:04:49 +0000)
-	FM[1] lpddr4x dualrank freq=3733 64bit dbi_off=n sdram init
-	ddr initialized, jump to uboot
-	image has no header
+u-boot-with-spl.bin should be loaded to SRAM through fastboot. Connect
+the board to computer with Type-C cable and run
 
+.. code-block:: bash
 
-	U-Boot 2020.01-00016-g8c870a6be8 (May 20 2023 - 01:04:49 +0000)
+	fastboot flash ram u-boot-with-spl.bin
+	fastboot reboot
 
-	CPU:   rv64imafdcvsu
-	Model: T-HEAD c910 light
-	DRAM:  8 GiB
-	C910 CPU FREQ: 750MHz
-	AHB2_CPUSYS_HCLK FREQ: 250MHz
-	AHB3_CPUSYS_PCLK FREQ: 125MHz
-	PERISYS_AHB_HCLK FREQ: 250MHz
-	PERISYS_APB_PCLK FREQ: 62MHz
-	GMAC PLL POSTDIV FREQ: 1000MHZ
-	DPU0 PLL POSTDIV FREQ: 1188MHZ
-	DPU1 PLL POSTDIV FREQ: 1188MHZ
-	MMC:   sdhci@ffe7080000: 0, sd@ffe7090000: 1
-	Loading Environment from MMC... OK
-	Error reading output register
-	Warning: cannot get lcd-en GPIO
-	LCD panel cannot be found : -121
-	splash screen startup cost 16 ms
-	In:    serial
-	Out:   serial
-	Err:   serial
-	Net:
-	Warning: ethernet@ffe7070000 using MAC address from ROM
-	eth0: ethernet@ffe7070000ethernet@ffe7070000:0 is connected to ethernet@ffe7070000.  Reconnecting to ethernet@ffe7060000
-
-	Warning: ethernet@ffe7060000 (eth1) using random MAC address - 42:25:d4:16:5f:fc
-	, eth1: ethernet@ffe7060000
-	Hit any key to stop autoboot:  2
-	ethernet@ffe7060000 Waiting for PHY auto negotiation to complete.. done
-	Speed: 1000, full duplex
-	Using ethernet@ffe7070000 device
-	TFTP from server 192.168.8.50; our IP address is 192.168.8.45
-	Filename 'u-boot-dtb.bin'.
-	Load address: 0x1c00000
-	Loading: * #########################
-		 8 MiB/s
-	done
-	Bytes transferred = 376686 (5bf6e hex)
-	## Starting application at 0x01C00000 ...
-
-        U-Boot 2023.07-rc2-00004-g1befbe31c1 (May 23 2023 - 18:40:01 +0800)
-
-        CPU:   rv64imafdc
-        Model: Sipeed Lichee Pi 4A
-        DRAM:  8 GiB
-        Core:  13 devices, 6 uclasses, devicetree: separate
-        Loading Environment from <NULL>... OK
-        In:    serial@ffe7014000
-        Out:   serial@ffe7014000
-        Err:   serial@ffe7014000
-        Model: Sipeed Lichee Pi 4A
-        LPI4A=>
-
-SPL support is still in an early stage and not all of the functionalities are
-available when booting from mainline SPL. When using mainline SPL,
-u-boot-with-spl.bin should be loaded to SRAM through fastboot.
-
-Sample boot log from Lichee PI 4A board via fastboot and mainline SPL
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Sample boot log from Lichee PI 4A board via fastboot
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 .. code-block:: none
 
-	brom_ver 8
 	[APP][E] protocol_connect failed, exit.
-	Starting download of 636588 bytes
+	Starting download of 940681 bytes
 
-	downloading of 636588 bytes finished
+	downloading of 940681 bytes finished
 
-	U-Boot SPL 2025.04-rc2-00049-geaa9fc99d4cd-dirty (Apr 26 2025 - 13:31:41 +0000)
+	U-Boot SPL 2025.07-rc3-00005-g3a0ef515b8bb (May 29 2025 - 10:42:46 +0000)
 	Trying to boot from RAM
 
 
-	U-Boot 2025.04-rc2-00049-geaa9fc99d4cd-dirty (Apr 26 2025 - 13:31:41 +0000)
+	U-Boot 2025.07-rc3-00005-g3a0ef515b8bb (May 29 2025 - 10:42:46 +0000)
 
 	CPU:   thead,c910
 	Model: Sipeed Lichee Pi 4A
 	DRAM:  8 GiB
-	Core:  30 devices, 9 uclasses, devicetree: separate
+	Core:  110 devices, 9 uclasses, devicetree: separate
 	MMC:   mmc@ffe7080000: 0, mmc@ffe7090000: 1
 	Loading Environment from <NULL>... OK
 	In:    serial@ffe7014000
-- 
2.49.0

