Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44171C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64DC8451F;
	Thu,  7 Aug 2025 13:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E78B383A92; Thu,  7 Aug 2025 13:41:14 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFB7F8452C
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 577BexIV078320
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Thu, 7 Aug 2025 19:41:00 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 19:40:59 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <tim609@andestech.com>
Subject: [PATCH 6/6] doc: board: voyager: Add documentation for Voyager
Date: Thu, 7 Aug 2025 19:40:55 +0800
Message-ID: <20250807114055.369462-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 577BexIV078320
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

Add documentation for Voyager board.

Signed-off-by: Randolph Sheng-Kai Lin <randolph@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 doc/board/andestech/voyager.rst | 81 +++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 doc/board/andestech/voyager.rst

diff --git a/doc/board/andestech/voyager.rst b/doc/board/andestech/voyager.rst
new file mode 100644
index 00000000000..63553216d60
--- /dev/null
+++ b/doc/board/andestech/voyager.rst
@@ -0,0 +1,81 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Voyager
+=======
+
+Qilai RISC-V SoC
+----------------
+The QiLai SoC chip is Andes' first RISC-V SoC. It includes high performance
+quad-core Andes AX45MP cluster and one NX27V vector processor.
+
+The Voyager development platform is based on Qilai and capable of running Linux.
+
+Mainline support
+----------------
+
+The support for following drivers are already enabled:
+
+1. UART driver
+2. MMC driver
+3. SPI driver
+
+Building
+~~~~~~~~
+
+How to build U-Boot SPL
+~~~~~~~~~~~~~~~~~~~~~~~
+Before building U-Boot SPL, OpenSBI must be build first.
+OpenSBI can be cloned and build for Voyager as below:
+
+1. Get the RISC-V toolchain.
+2. Setup cross compilation environment variable.
+
+.. code-block:: none
+
+    git clone https://github.com/riscv-software-src/opensbi.git
+    cd opensbi
+    make PLATFORM=generic
+
+Copy OpenSBI FW_DYNAMIC image (build/platform/generic/firmware/fw_dynamic.bin)
+into U-Boot root directory, then
+
+.. code-block:: console
+
+   export CROSS_COMPILE=riscv64-linux-gnu-
+   cd <U-Boot-dir>
+   cp fw_dynamic.bin .
+   make voyager_spl_defconfig
+   make
+
+Booting
+~~~~~~~
+
+Currently, we rely on vendor ROM code to initialize the DDR
+and load the u-boot image, then boot from it.
+
+Sample boot log from Voyager board
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. code-block:: none
+
+    U-Boot SPL 2025.10-rc1-00130-ga28bcbba4778-dirty (Aug 06 2025 - 17:46:10 +0800)
+    Trying to boot from RAM
+
+    U-Boot 2025.10-rc1-00130-ga28bcbba4778-dirty (Aug 06 2025 - 17:46:10 +0800)
+
+    CPU:   riscv
+    Model: andestech,ax45
+    DRAM:  16 GiB
+    Core:  25 devices, 14 uclasses, devicetree: board
+    MMC:   mmc@30c00000: 0
+    Loading Environment from SPIFlash... SF: Detected mx25u1635e with page size 256 Bytes, erase size 4 KiB, total 2 MiB
+    *** Warning - bad CRC, using default environment
+
+    In:    serial@30300000
+    Out:   serial@30300000
+    Err:   serial@30300000
+    Net:   No ethernet found.
+    Hit any key to stop autoboot: 0
+    No ethernet found.
+    No ethernet found.
+    RISC-V #
-- 
2.34.1

