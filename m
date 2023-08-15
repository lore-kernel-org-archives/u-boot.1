Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECCCC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 16:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EB1869E1;
	Tue, 15 Aug 2023 18:44:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aEItmAth";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0DBA869B1; Tue, 15 Aug 2023 18:44:50 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82C4C8699A
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 18:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37FGihls071894;
 Tue, 15 Aug 2023 11:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692117883;
 bh=awgijJjodQgAPCfzmUB7b5mYT0x4ghHZ+euYJCuXgAg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aEItmAthZfzzQFeLg+cdasto6IT0uL23TvhTy9tN1peN1x4UmYGNbUQ5FNsm0/JkF
 fc/QRhHtZ2KbZ+ZhKb+oHzrvCnuUuggFYVWsPdOEjzfjBDLo8aruPrGJfTyahqsJ8L
 Ob2C/FwJ/2brHNmO0cuCkFnn/B7mEBMbShwWGA7M=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37FGiheD093256
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 15 Aug 2023 11:44:43 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Aug 2023 11:44:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Aug 2023 11:44:42 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37FGig3B100652;
 Tue, 15 Aug 2023 11:44:42 -0500
From: Nishanth Menon <nm@ti.com>
To: <n-francis@ti.com>, <trini@konsulko.com>
CC: <bb@ti.com>, <praneeth@ti.com>, <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 4/4] doc: board: ti: Add BeaglePlay documentation
Date: Tue, 15 Aug 2023 11:44:40 -0500
Message-ID: <20230815164440.2713726-5-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230815164440.2713726-1-nm@ti.com>
References: <20230815164440.2713726-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add base documentation for BeaglePlay

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V2:
* Update build instructions for config fragments
* Minor link look and feel fixups.

V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/
 doc/board/ti/am62x_beagleplay.rst | 121 ++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst               |   1 +
 2 files changed, 122 insertions(+)
 create mode 100644 doc/board/ti/am62x_beagleplay.rst

diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
new file mode 100644
index 000000000000..d87f98b89acc
--- /dev/null
+++ b/doc/board/ti/am62x_beagleplay.rst
@@ -0,0 +1,121 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Nishanth Menon <nm@ti.com>
+
+AM62x Beagleboard.org Beagleplay
+================================
+
+Introduction:
+-------------
+
+BeagleBoard.org BeaglePlay is an easy to use, affordable open source
+hardware single board computer based on the Texas Instruments AM625
+SoC that allows you to create connected devices that work even at long
+distances using IEEE 802.15.4g LR-WPAN and IEEE 802.3cg 10Base-T1L.
+Expansion is provided over open standards based mikroBUS, Grove and
+QWIIC headers among other interfaces.
+
+Further information can be found at:
+
+* Product Page: https://beagleplay.org/
+* Hardware documentation: https://git.beagleboard.org/beagleplay/beagleplay
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/boot_diagram_k3_current.svg
+
+- On this platform, 'TI Foundational Security' (TIFS) functions as the
+  security enclave master while 'Device Manager' (DM), also known as the
+  'TISCI server' in "TI terminology", offers all the essential services.
+  The A53/M4F (Aux core) sends requests to TIFS/DM to accomplish these
+  services, as illustrated in the diagram above.
+
+Sources:
+--------
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure:
+----------------
+0. Setup the environment variables:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR="am62x_evm_r5_defconfig beagleplay_r5.config"
+ $ export UBOOT_CFG_CORTEXA="am62x_evm_a53_defconfig beagleplay_a53.config"
+ $ export TFA_BOARD=lite
+ $ # we dont use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am62x
+ $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+
+.. include::  am62x_sk.rst
+    :start-after: .. am62x_evm_rst_include_start_build_steps
+    :end-before: .. am62x_evm_rst_include_end_build_steps
+
+Target Images
+--------------
+Copy the below images to an SD card and boot:
+
+* tiboot3-am62x-gp-evm.bin from R5 build as tiboot3.bin
+* tispl.bin_unsigned from Cortex-A build as tispl.bin
+* u-boot.img_unsigned from Cortex-A build as uboot.img
+
+Image formats:
+--------------
+
+- tiboot3.bin
+
+.. image:: img/multi_cert_tiboot3.bin.svg
+
+- tispl.bin
+
+.. image:: img/dm_tispl.bin.svg
+
+A53 SPL DDR Memory Layout
+-------------------------
+
+.. include::  am62x_sk.rst
+    :start-after: .. am62x_evm_rst_include_start_ddr_mem_layout
+    :end-before: .. am62x_evm_rst_include_end_ddr_mem_layout
+
+Switch Setting for Boot Mode
+----------------------------
+
+The boot time option is configured via "USR" button on the board.
+See `Beagleplay Schematics <https://git.beagleboard.org/beagleplay/beagleplay/-/blob/main/BeaglePlay_sch.pdf>`_
+for details.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - USR Switch Position
+     - Primary Boot
+     - Secondary Boot
+
+   * - Not Pressed
+     - eMMC
+     - UART
+
+   * - Pressed
+     - SD/MMC File System (FS) mode
+     - USB Device Firmware Upgrade (DFU) mode
+
+To switch to SD card boot mode, hold the USR button while powering on
+with Type-C power supply, then release when power LED lights up.
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index d2f86b0a11a7..d041610f53b3 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -30,6 +30,7 @@ K3 Based SoCs
 .. toctree::
    :maxdepth: 1
 
+   am62x_beagleplay
    am62x_sk
    ../toradex/verdin-am62
    am65x_evm
-- 
2.40.0

