Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8372C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:35:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2844787DA0;
	Fri, 23 Feb 2024 21:26:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="abW0t6Bj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F022587653; Fri, 23 Feb 2024 19:55:32 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A59D087BF0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 19:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41NIswsm002339;
 Fri, 23 Feb 2024 12:54:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708714498;
 bh=gCKBZgBc4bCWiwOlWbY5RSqXuLt4NhueyxynrAuqQqo=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=abW0t6BjmlXDBeIzyXBsFa+YvcLQp5NRiCilIMHgkEA1DcTB7mS/ku/VsE9fBDoI9
 l2EZ61hV9NciBkhp1kelC16A2AYvTWIYjv6QEkyttM8JIt3hs4nQ/9c/e1GOiGdhxp
 luWazDGaDw39fFq9tdeJcP+Oks8wp6HSuKNIZWcQ=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41NIsw24101983
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 23 Feb 2024 12:54:58 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 23
 Feb 2024 12:54:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 23 Feb 2024 12:54:58 -0600
Received: from TI.dhcp.ti.com (ti.dhcp.ti.com [10.24.68.115] (may be forged))
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41NIpvhw051632; 
 Fri, 23 Feb 2024 12:54:47 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Tom Rini <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>, "Lukasz
 Majewski" <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Jesse Taube <mr.bossman075@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Kever Yang <kever.yang@rock-chips.com>, Michal Simek
 <michal.simek@amd.com>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Tianling Shen
 <cnsztl@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Hai Pham
 <hai.pham.ud@renesas.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Hari Nagalla" <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Roger Quadros <rogerq@kernel.org>,
 "Aradhya Bhatia" <a-bhatia1@ti.com>, Joao Paulo Goncalves
 <joao.goncalves@toradex.com>, Bhavya Kapoor <b-kapoor@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Vignesh Raghavendra <vigneshr@ti.com>, Udit
 Kumar <u-kumar1@ti.com>, "Heinrich Schuchardt" <xypron.glpk@gmx.de>, Jason
 Kacines <j-kacines@ti.com>, "Jayesh Choudhary" <j-choudhary@ti.com>, Andre
 Przywara <andre.przywara@arm.com>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v9 15/15] doc: board: ti: k3: Add J784S4 EVM and AM69 SK
 documentation
Date: Sat, 24 Feb 2024 00:21:56 +0530
Message-ID: <20240223185156.3065032-16-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223185156.3065032-1-a-nandan@ti.com>
References: <20240223185156.3065032-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 23 Feb 2024 21:25:51 +0100
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

TI K3 J784S4 and AM69 are new additions to the K3 SoC family.
Add documentation about the J784S4 EVM and AM69 SK.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 board/ti/j784s4/MAINTAINERS |   1 +
 doc/board/ti/j784s4_evm.rst | 299 ++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst         |   1 +
 3 files changed, 301 insertions(+)
 create mode 100644 doc/board/ti/j784s4_evm.rst

diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
index 46f4ba5da96..b7605ff335b 100644
--- a/board/ti/j784s4/MAINTAINERS
+++ b/board/ti/j784s4/MAINTAINERS
@@ -10,6 +10,7 @@ F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
 F:	arch/arm/dts/k3-j784s4-r5-evm.dts
 F:	arch/arm/dts/k3-j784s4-ddr.dtsi
 F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
+F:	doc/board/ti/j784s4_evm.rst
 
 AM69 SK BOARD
 M:	Apurva Nandan <a-nandan@ti.com>
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
new file mode 100644
index 00000000000..5c4bd2c927d
--- /dev/null
+++ b/doc/board/ti/j784s4_evm.rst
@@ -0,0 +1,299 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+.. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
+
+J784S4 and AM69 Platforms
+=========================
+
+Introduction
+------------
+The J784S4 SoC belongs to the K3 Multicore SoC architecture
+platform, providing advanced system integration in automotive,
+ADAS and industrial applications requiring AI at the network edge.
+This SoC extends the K3 Jacinto 7 family of SoCs with focus on
+raising performance and integration while providing interfaces,
+memory architecture and compute performance for multi-sensor, high
+concurrency applications.
+
+The device is partitioned into three functional domains, each containing
+specific processing cores and peripherals:
+
+1. Wake-up (WKUP) domain
+    * ARM Cortex-M4F processor, runs TI Foundational Security (TIFS)
+
+2. Microcontroller (MCU) domain
+    * Dual core ARM Cortex-R5F processor, runs device management
+      and SoC early boot
+
+3. MAIN domain
+    * Two clusters of quad core 64-bit ARM Cortex-A72, runs HLOS
+    * Dual core ARM Cortex-R5F processor used for RTOS applications
+    * Four C7x DSPs used for Machine Learning applications.
+
+
+More info can be found in TRM: http://www.ti.com/lit/zip/spruj52
+
+Platform information:
+
+* https://www.ti.com/tool/J784S4XEVM
+* https://www.ti.com/tool/SK-AM69
+
+Boot Flow
+---------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/boot_diagram_k3_current.svg
+    :alt: K3 boot flow
+
+- On this platform, "TI Foundational Security" (TIFS) functions as the
+  security enclave master. While "Device Manager" (DM), also known as the
+  "TISCI server" in TI terminology, offers all the essential services.
+
+- As illustrated in the diagram above, R5 SPL manages power and clock
+  services independently before handing over control to DM. The A72 or
+  the C7x (Aux core) software components request TIFS/DM to handle
+  security or device management services.
+
+Sources
+-------
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure
+---------------
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
+ $ export UBOOT_CFG_CORTEXR=j784s4_evm_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=j784s4_evm_a72_defconfig
+ $ export TFA_BOARD=j784s4
+ $ export TFA_EXTRA_ARGS="K3_USART=0x8"
+ $ export OPTEE_PLATFORM=k3-j784s4
+ $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
+
+.. j784s4_evm_rst_include_start_build_steps
+
+1. Trusted Firmware-A
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+
+2. OP-TEE
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot
+
+.. _j784s4_evm_rst_u_boot_r5:
+
+* 3.1 R5
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+.. _j784s4_evm_rst_u_boot_a72:
+
+* 3.2 A72
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+.. j784s4_evm_rst_include_end_build_steps
+
+Target Images
+-------------
+In order to boot we need tiboot3.bin, tispl.bin and u-boot.img. Each SoC
+variant (GP, HS-FS, HS-SE) requires a different source for these files.
+
+ - GP
+
+    * tiboot3-j784s4-gp-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
+
+ - HS-FS
+
+    * tiboot3-j784s4-hs-fs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
+
+ - HS-SE
+
+    * tiboot3-j784s4-hs-evm.bin from :ref:`step 3.1 <j784s4_evm_rst_u_boot_r5>`
+    * tispl.bin, u-boot.img from :ref:`step 3.2 <j784s4_evm_rst_u_boot_a72>`
+
+Image formats
+-------------
+
+- tiboot3.bin
+
+.. image:: img/multi_cert_tiboot3.bin.svg
+    :alt: tiboot3.bin format
+
+- tispl.bin
+
+.. image:: img/dm_tispl.bin.svg
+    :alt: tispl.bin format
+
+R5 Memory Map
+-------------
+
+.. list-table::
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Region
+     - Start Address
+     - End Address
+
+   * - SPL
+     - 0x41c00000
+     - 0x41c40000
+
+   * - EMPTY
+     - 0x41c40000
+     - 0x41c61f20
+
+   * - STACK
+     - 0x41c65f20
+     - 0x41c61f20
+
+   * - Global data
+     - 0x41c65f20
+     - 0x41c66000
+
+   * - Heap
+     - 0x41c66000
+     - 0x41c76000
+
+   * - BSS
+     - 0x41c76000
+     - 0x41c80000
+
+   * - DM DATA
+     - 0x41c80000
+     - 0x41c84130
+
+   * - EMPTY
+     - 0x41c84130
+     - 0x41cff9fc
+
+   * - MCU Scratchpad
+     - 0x41cff9fc
+     - 0x41cffbfc
+
+   * - ROM DATA
+     - 0x41cffbfc
+     - 0x41cfffff
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+Boot Mode Pins for J784S4-EVM
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The following tables show some common boot modes used on J784S4 EVM platform.
+More details can be found in the Technical Reference Manual:
+http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
+
+.. list-table:: J784S4 EVM Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW11: 12345678
+     - SW7: 12345678
+
+   * - SD
+     - 10000010
+     - 00000000
+
+   * - EMMC
+     - 10000000
+     - 01000000
+
+   * - OSPI
+     - 00000110
+     - 01000000
+
+   * - UART
+     - 00000000
+     - 01110000
+
+For SW7 and SW11, the switch state in the "ON" position = 1.
+
+Boot Mode Pins for AM69-SK
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The following table show some common boot modes used on AM69-SK platform.
+More details can be found in the User Guide for AM69-SK:
+https://www.ti.com/lit/ug/spruj70/spruj70.pdf under the `Bootmode Settings`
+section.
+
+.. list-table:: AM69 SK Boot Modes
+   :widths: 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW2: 1234
+
+   * - SD
+     - 0000
+
+   * - EMMC
+     - 0110
+
+   * - UART
+     - 1010
+
+For SW2, the switch state in the "ON" position = 1.
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+  **OpenOCD support since**: September 2023 (git master)
+
+  Until the next stable release of OpenOCD is available in your development
+  environment's distribution, it might be necessary to build OpenOCD `from the
+  source <https://github.com/openocd-org/openocd>`_.
+
+Debugging U-Boot on J784S4-EVM and AM69-SK
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to J784S4-EVM or AM69-SK board, use the
+following.
+
+.. code-block:: bash
+
+  openocd -f board/ti_j784s4evm.cfg
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 3c33efd2e38..15e1ed232bf 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -41,6 +41,7 @@ K3 Based SoCs
    ../beagle/j721e_beagleboneai64
    j721e_evm
    j721s2_evm
+   j784s4_evm
 
 Boot Flow Overview
 ------------------
-- 
2.34.1

