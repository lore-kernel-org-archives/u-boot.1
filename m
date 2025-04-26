Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4C7C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9389F82105;
	Sat, 26 Apr 2025 19:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="OnUepC7I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9591E81E0F; Sat, 26 Apr 2025 19:03:50 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5486782119
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 1231325C33;
 Sat, 26 Apr 2025 19:03:47 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3id-L7mCh5Un; Sat, 26 Apr 2025 19:03:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745687025; bh=D1YV5R8L2xok4VY3Dz6/zl/IQaMACBEeKQG3eBCqEH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OnUepC7IUAUhqS3QM2FXjvnleV0ICHQAIU8x2hESWrEfh1QhQWtQ4xWAelAEri98W
 SceKz1IRCtJ9EXldHe7v5OpxBCFXi5E+74ClU2YPbxUnKWdEBIWSpIyI4L+QJzuyVF
 11+52+OAUliziPu3yeK/E/t6ohbgqkqPhRd/vAmkM0yY61eAF+F3LQphU/DF4WbGfj
 IHdVKgrdU94AvF4EKFaE/27Sk+Gi8cha11WO6F3RLwmOo7fvzUVPF9nQ1PoBtX4etP
 MxCeizaCjiP7Tf4er6M46HgRB7AqB0mQQn55mNlLzrHwsNOTi9kobf9TEVARSVb8i6
 cEUMLg6aSuR4Q==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov <w.egorov@phytec.de>,
 Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 10/10] doc: thead: lpi4a: Update documentation
Date: Sat, 26 Apr 2025 17:03:21 +0000
Message-ID: <20250426170322.35601-2-ziyao@disroot.org>
In-Reply-To: <20250426165704.35523-1-ziyao@disroot.org>
References: <20250426165704.35523-1-ziyao@disroot.org>
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

Support for eMMC, SD card, GPIO and SPL have been available in LPi4A
port. Update the documentation of support status and build
instructions.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 doc/board/thead/lpi4a.rst | 58 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/doc/board/thead/lpi4a.rst b/doc/board/thead/lpi4a.rst
index e395c6ae12c..7e4c4ea81ee 100644
--- a/doc/board/thead/lpi4a.rst
+++ b/doc/board/thead/lpi4a.rst
@@ -32,6 +32,8 @@ Mainline support
 The support for following drivers are already enabled:
 
 1. ns16550 UART Driver.
+2. eMMC and SD card
+
 
 Building
 ~~~~~~~~
@@ -43,15 +45,32 @@ Building
 
    export CROSS_COMPILE=<riscv64 toolchain prefix>
 
-The U-Boot is capable of running in M-Mode, so we can directly build it.
+3. Build DDR firmware
+
+DDR driver requires a firmware to function, to build it:
+
+.. code-block:: bash
+
+	git clone --depth 1 https://github.com/ziyao233/th1520-firmware
+	cd th1520-firmware
+	lua5.4 ddr-generate.lua src/<CONFIGURATION_NAME>.lua th1520-ddr-firmware.bin
+
+4. Build U-Boot images
+
+The U-Boot is capable of running in M-Mode, so we can directly build it without
+OpenSBI. The DDR firmware should be copied to U-Boot source directory before
+building.
 
 .. code-block:: console
 
 	cd <U-Boot-dir>
+	cp <path-to-ddr-firmware> th1520-ddr-firmware.bin
 	make th1520_lpi4a_defconfig
 	make
 
-This will generate u-boot-dtb.bin
+This will generate u-boot-dtb.bin and u-boot-with-spl.bin. The former contains
+only proper U-Boot and is for chainloading; the later contains also SPL and
+DDR firmware and is ready for booting by BROM directly.
 
 Booting
 ~~~~~~~
@@ -61,7 +80,7 @@ and chain load the mainline u-boot image either via tftp or emmc storage,
 then bootup from it.
 
 Sample boot log from Lichee PI 4A board via tftp
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 .. code-block:: none
 
@@ -127,3 +146,36 @@ Sample boot log from Lichee PI 4A board via tftp
         Err:   serial@ffe7014000
         Model: Sipeed Lichee Pi 4A
         LPI4A=>
+
+SPL support is still in an early stage and not all of the functionalities are
+available when booting from mainline SPL. When using mainline SPL,
+u-boot-with-spl.bin should be loaded to SRAM through fastboot.
+
+Sample boot log from Lichee PI 4A board via fastboot and mainline SPL
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. code-block:: none
+
+	brom_ver 8
+	[APP][E] protocol_connect failed, exit.
+	Starting download of 636588 bytes
+
+	downloading of 636588 bytes finished
+
+	U-Boot SPL 2025.04-rc2-00049-geaa9fc99d4cd-dirty (Apr 26 2025 - 13:31:41 +0000)
+	Trying to boot from RAM
+
+
+	U-Boot 2025.04-rc2-00049-geaa9fc99d4cd-dirty (Apr 26 2025 - 13:31:41 +0000)
+
+	CPU:   thead,c910
+	Model: Sipeed Lichee Pi 4A
+	DRAM:  8 GiB
+	Core:  30 devices, 9 uclasses, devicetree: separate
+	MMC:   mmc@ffe7080000: 0, mmc@ffe7090000: 1
+	Loading Environment from <NULL>... OK
+	In:    serial@ffe7014000
+	Out:   serial@ffe7014000
+	Err:   serial@ffe7014000
+	Model: Sipeed Lichee Pi 4A
+	LPI4A=>
-- 
2.49.0

