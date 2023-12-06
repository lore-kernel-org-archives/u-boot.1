Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC2FC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 12:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18C5E878AF;
	Wed,  6 Dec 2023 13:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qm9V3e9a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9374F877C5; Wed,  6 Dec 2023 13:39:58 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1CC9878DA
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 13:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B6CdllJ088218;
 Wed, 6 Dec 2023 06:39:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701866387;
 bh=CyJfyzldrLJbasYvhrtM0D7SaLysds0hjvYEoNwTHKo=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=qm9V3e9a4OtxU2oDHSbUu3odxlBhxhlSFAham8wlBYp0zsnPdrTpr7vg6hErGVWwe
 mm/9wtNMUH3KW6zd0M/trkTeq9QYspsQvEC7E4mYXGMolTPTmfT3xidjgpzU13j7C+
 aaIhqTCg8vU3yVFSXdL/ZtyRaspyc4ywkMbxmKZw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B6Cdl4W042204
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Dec 2023 06:39:47 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Dec 2023 06:39:46 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Dec 2023 06:39:46 -0600
Received: from TI.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B6Cbrqr096939;
 Wed, 6 Dec 2023 06:39:40 -0600
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v6 16/17] doc: board: ti: k3: Add J784S4 EVM and AM69 SK
 documentation
Date: Wed, 6 Dec 2023 18:07:52 +0530
Message-ID: <20231206123753.1486031-17-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206123753.1486031-1-a-nandan@ti.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
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

TI K3 J784S4 and AM69 are new additions to the K3 SoC family.
Add documentation about the J784S4 EVM and AM69 SK.

Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 doc/board/ti/j784s4_evm.rst | 303 ++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst         |   1 +
 2 files changed, 304 insertions(+)
 create mode 100644 doc/board/ti/j784s4_evm.rst

diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
new file mode 100644
index 0000000000..bb7ed0b031
--- /dev/null
+++ b/doc/board/ti/j784s4_evm.rst
@@ -0,0 +1,303 @@
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
+- On this platform, "TI Foundational Security (TIFS)" functions as the
+  security enclave master. While "Device Manager (DM)", also known as the
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
+The following tables show some common boot modes used on J784S4 SoC platform.
+More details can be found in the Technical Reference Manual:
+http://www.ti.com/lit/zip/spruj52 under the `Boot Mode Pins` section.
+
+.. list-table:: J784S4 EVM Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW9: 12345678
+     - SW8: 12345678
+
+   * - SD
+     - 00000000
+     - 10000010
+
+   * - EMMC
+     - 01000000
+     - 10000000
+
+   * - OSPI
+     - 01000000
+     - 00000110
+
+   * - UART
+     - 01110000
+     - 00000000
+
+   * - USB DFU
+     - 00100000
+     - 10000000
+
+For SW8 and SW9, the switch state in the "ON" position = 1.
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
+   * - OSPI
+     - 1110
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
+  **Debugging the platform via JTAG requires latest OpenOCD tag**
+
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
index a127215ce5..a2f49af03f 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -40,6 +40,7 @@ K3 Based SoCs
    ../beagle/j721e_beagleboneai64
    j721e_evm
    j721s2_evm
+   j784s4_evm
 
 Boot Flow Overview
 ------------------
-- 
2.34.1

