Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DBEC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 20:21:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D3B687F27;
	Tue, 12 Mar 2024 21:20:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aJcql9Hx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2120787F0E; Tue, 12 Mar 2024 21:20:45 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B64987F64
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 21:20:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTAL088773;
 Tue, 12 Mar 2024 15:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710274829;
 bh=lgMQAh11fURdDPYK8ZZ+2FiE5rsyc0dSHm29id7BHRA=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=aJcql9HxBJnml4ERE75XpC9KtZN4/jyL+d5zGv3wUMQnciBXMsqn/lptTDZjKi13E
 K0tfZkr8tTe28ocqOviBN8ZgkZ6o3SlYkZEszxhCFXte3F9bVwYftEEJeupAYz2d+z
 PwJdJYCcw3Mr5ir06vepq/MQ/NIFpGzP4IksrTN4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CKKTcL086635
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Mar 2024 15:20:29 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 15:20:29 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 15:20:29 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CKKTwR097268;
 Tue, 12 Mar 2024 15:20:29 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 12 Mar 2024 15:20:30 -0500
Subject: [PATCH v4 12/13] doc: board: ti: introduce am62px documentation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240205-am62px-wip-rebasing-v4-12-fa772bfa623b@ti.com>
References: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
In-Reply-To: <20240205-am62px-wip-rebasing-v4-0-fa772bfa623b@ti.com>
To: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon
 <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew Davis
 <afd@ti.com>, Igor Opaniuk <igor.opaniuk@foundries.io>, Hari Nagalla
 <hnagalla@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=8740; i=bb@ti.com;
 h=from:subject:message-id; bh=nmOogOCCBnRoAiisNcPvXFJqNFnLGY14DAnFU3ajdqQ=;
 b=owNCWmg5MUFZJlNZVBgANAAAZH/////dTnV9fpzf/9X7m3u7u/Wuclbun/+/3N7d///tyX+wA
 RsYHZR6gMgAAAAAAANGhoDQNAAPUAAAAaA0MgyAADTaho0DQaPKabAocj1NAA0ABoDTQ0GhoA0N
 ABp6IAGgGjQD1AxNpG1MRo0ADE9QaANB6npAaA0ByGjTEMjBAGINNGgNNGEyMCAGTQAABoaGQDC
 GjRoYgAAAAyYg00GQ0AgQYNRvt6+QQWSEZf8ToR7/2/n0OlZwOYGiQDIAH6wOI9jfJnokH4csbg
 ceWNm05Xnvmb3ZKsuWEqSZ5i0rlfNREtwMS3tLMAFigpHFuj1HIdRqMpMwL543l7JWA96EL2Kth
 fvF9paOYWCfSG6qKbg1Q4ucDhdPQyDfofOAAjBNStlKdtAaxkxQIFkzA96X9LJ8c5PlV5+TRXBk
 ylWi4BQbS4788hXIodcW3VlsdQCjm3QcmYJCjhrUqZ84beRRDoVB+lulEOu3JdSQeg+cGBSKyQL
 yn6unVwRFhKftTZJ9uRPKlzNdG2b82xUDSCFWQyNApCKDY2r01iBeU4Mu+cZcwHt7SWC+6qqGAO
 6OX4/i2+AQihPQxi8sdP1gqyAUAQApumUXo5BzYzTLMRoKXkyrKjWBmiSd1vALSz6SLLMhhMf/F
 3JFOFCQVBgANA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Introduce basic documentation for the am62p family of SoCs.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 doc/board/ti/am62px_sk.rst | 289 +++++++++++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst        |   1 +
 2 files changed, 290 insertions(+)

diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
new file mode 100644
index 0000000000000..1f2982c36f9e4
--- /dev/null
+++ b/doc/board/ti/am62px_sk.rst
@@ -0,0 +1,289 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Bryan Brattlof <bb@ti.com>
+
+AM62Px Platforms
+================
+
+The AM62Px is an extension of the existing Sitara AM62x low-cost family
+of application processors built for Automotive and Linux Application
+development. Scalable Arm Cortex-A53 performance and embedded features,
+such as: multi high-definition display support, 3D-graphics
+acceleration, 4K video acceleration, and extensive peripherals make the
+AM62Px well-suited for a broad range of automation and industrial
+application, including automotive digital instrumentation, automotive
+displays, industrial HMI, and more.
+
+Some highlights of AM62P SoC are:
+
+* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
+  Dual/Single core variants are provided in the same package to allow HW
+  compatible designs.
+
+* One Device manager Cortex-R5F for system power and resource
+  management, and one Cortex-R5F for Functional Safety or
+  general-purpose usage.
+
+* One 3D GPU up to 50 GLFOPS
+
+* H.264/H.265 Video Encode/Decode.
+
+* Display support: 3x display support over OLDI/LVDS (1x OLDI-DL, 1x or
+  2x OLDI-SL), DSI, or DPI. Up to 3840x1080 @ 60fps resolution
+
+* Integrated Giga-bit Ethernet switch supporting up to a total of two
+  external ports (TSN capable).
+
+* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3xMMC and SD, GPMC for
+  NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
+  1xCSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
+
+* Dedicated Centralized Hardware Security Module with support for secure
+  boot, debug security and crypto acceleration and trusted execution
+  environment.
+
+* One 32-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
+
+* Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
+  enabling battery powered system design.
+
+For those interested, more details about this SoC can be found in the
+Technical Reference Manual here: https://www.ti.com/lit/pdf/spruj83
+
+Boot Flow:
+----------
+
+The bootflow is exactly the same as all SoCs in the am62xxx extended SoC
+family. Below is the pictorial representation:
+
+.. image:: img/boot_diagram_k3_current.svg
+  :alt: Boot flow diagram
+
+- Here TIFS acts as master and provides all the critical services. R5/A53
+  requests TIFS to get these services done as shown in the above diagram.
+
+Sources:
+--------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure:
+----------------
+
+0. Setup the environment variables:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_desc
+    :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_board_env_vars_desc
+    :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+Set the variables corresponding to this platform:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_common_env_vars_defn
+    :end-before: .. k3_rst_include_end_common_env_vars_defn
+
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=am62px_evm_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=am62px_evm_a53_defconfig
+ $ export TFA_BOARD=lite
+ $ # we dont use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am62x
+ $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
+
+.. am62px_evm_rst_include_start_build_steps
+
+1. Trusted Firmware-A:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
+
+
+2. OP-TEE:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_optee
+    :end-before: .. k3_rst_include_end_build_steps_optee
+
+3. U-Boot:
+
+* 3.1 R5:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_spl_r5
+    :end-before: .. k3_rst_include_end_build_steps_spl_r5
+
+* 3.2 A53:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_uboot
+    :end-before: .. k3_rst_include_end_build_steps_uboot
+.. am62px_evm_rst_include_end_build_steps
+
+Target Images
+--------------
+
+In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
+variant (HS-FS, HS-SE) requires a different source for these files.
+
+ - HS-FS
+
+        * tiboot3-am62px-hs-fs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+ - HS-SE
+
+        * tiboot3-am62px-hs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+Image formats:
+--------------
+
+- tiboot3.bin
+
+.. image:: img/multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/dm_tispl.bin.svg
+  :alt: tispl.bin image format
+
+A53 SPL DDR Memory Layout
+-------------------------
+
+.. am62px_evm_rst_include_start_ddr_mem_layout
+
+This provides an overview memory usage in A53 SPL stage.
+
+.. list-table::
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Region
+     - Start Address
+     - End Address
+
+   * - EMPTY
+     - 0x80000000
+     - 0x80080000
+
+   * - TEXT BASE
+     - 0x80080000
+     - 0x800d8000
+
+   * - EMPTY
+     - 0x800d8000
+     - 0x80200000
+
+   * - BMP IMAGE
+     - 0x80200000
+     - 0x80b77660
+
+   * - STACK
+     - 0x80b77660
+     - 0x80b77e60
+
+   * - GD
+     - 0x80b77e60
+     - 0x80b78000
+
+   * - MALLOC
+     - 0x80b78000
+     - 0x80b80000
+
+   * - EMPTY
+     - 0x80b80000
+     - 0x80c80000
+
+   * - BSS
+     - 0x80c80000
+     - 0x80d00000
+
+   * - BLOBS
+     - 0x80d00000
+     - 0x80d00400
+
+   * - EMPTY
+     - 0x80d00400
+     - 0x81000000
+.. am62px_evm_rst_include_end_ddr_mem_layout
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62Px
+platforms. More details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruj83 under the `Boot Mode Pins` section.
+
+.. note::
+
+   This device is very new. Currently only UART boot is available while
+   we continue to add support for the other bootmodes.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - Switch Label
+     - SW2: 12345678
+     - SW3: 12345678
+
+   * - SD
+     - 01000000
+     - 11000010
+
+   * - OSPI
+     - 00000000
+     - 11001110
+
+   * - EMMC
+     - 00000000
+     - 11010010
+
+   * - UART
+     - 00000000
+     - 11011100
+
+   * - USB DFU
+     - 00000000
+     - 11001010
+
+For SW2 and SW1, the switch state in the "ON" position = 1.
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. warning::
+
+  **OpenOCD support after**: v0.12.0
+
+  While support for the entire K3 generation including the am62xxx
+  extended family was added before v0.12.0, the tcl scripts for the
+  am62px have been accepted and will be available in the next release of
+  OpenOCD. It may be necessary to build OpenOCD from source depending on
+  the version your distribution has packaged.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. code-block:: bash
+
+  openocd -f board/ti_am62pevm.cfg
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 15e1ed232bf09..a1c01d1cf02be 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -35,6 +35,7 @@ K3 Based SoCs
    ../beagle/am62x_beagleplay
    ../phytec/phycore-am62x
    ../toradex/verdin-am62
+   am62px_sk
    am64x_evm
    am65x_evm
    j7200_evm

-- 
2.43.2

