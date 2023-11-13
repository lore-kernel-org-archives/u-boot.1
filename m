Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E93C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 14:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EAC5871E9;
	Mon, 13 Nov 2023 15:52:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NhjbLzPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5A687124; Mon, 13 Nov 2023 15:52:05 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB7E8711D
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 15:51:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEppUS020791;
 Mon, 13 Nov 2023 08:51:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699887111;
 bh=FrYb2XAADUXLyL0c4MtvWF/NCGqjhl3lC/2VIXxPaxU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=NhjbLzPS0RG9QQEFL1vTt9Ee1tWQkBns7J1tege2f5H//xUpjUUA+cgcHAWU3YNl3
 aYdqTnfx2a7f99U4FnU130PnqWbNDdZJtzxj/cWD7UB3oieJfmln7Na7kG9As12xZf
 686L4tdDKYuZCdc3F/unSR5ZcDpZiouYTa5ACcoA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADEppLL099394
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 08:51:51 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 08:51:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 08:51:51 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADEppXZ073461;
 Mon, 13 Nov 2023 08:51:51 -0600
From: Nishanth Menon <nm@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, Neha
 Malcom Francis <n-francis@ti.com>, Roger Quadros <rogerq@kernel.org>, Bryan
 Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra
 <j-luthra@ti.com>, <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/8] doc: board: ti: Add AM62A documentation
Date: Mon, 13 Nov 2023 08:51:49 -0600
Message-ID: <20231113145149.1926732-9-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231113145149.1926732-1-nm@ti.com>
References: <20231113145149.1926732-1-nm@ti.com>
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

From: Jai Luthra <j-luthra@ti.com>

Add generic boot-flow diagrams, and SoC-specific info around build
steps.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/am62ax_sk.rst | 213 +++++++++++++++++++++++++++++++++++++
 doc/board/ti/k3.rst        |   1 +
 2 files changed, 214 insertions(+)
 create mode 100644 doc/board/ti/am62ax_sk.rst

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
new file mode 100644
index 000000000000..60726b6652ce
--- /dev/null
+++ b/doc/board/ti/am62ax_sk.rst
@@ -0,0 +1,213 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Jai Luthra <j-luthra@ti.com>
+
+AM62A Platforms
+===============
+
+Introduction:
+-------------
+The AM62A SoC family is built on the K3 Multicore SoC architecture platform,
+providing a deep learning accelerator, multi-camera support with ISP, video
+transcoder and other BOM-saving integrations.
+The AM62A SoC enables cost-sensitive automotive applications including driver
+and in-cabin monitoring systems, next generation of eMirror system, as well as
+a broad set of industrial applications in Factory Automation, Building
+Automation, Robotics and more.
+
+Some highlights of this SoC are:
+
+* Quad-Cortex-A53s (running up to 1.4GHz) in a single cluster.
+* Cortex-R5F for general-purpose or safety usage.
+* Deep Learning Accelerator with Single-core C7x Vector DSP with MMA (up to
+  1.0GHz).
+* Vision Processing Accelerator (VPAC) with a 315MPixel/s ISP (up to 5MP @
+  60fps) supporting 16-bit RAW input with RGB-IR separation.
+* 4K Video encoder and decoder for HEVC (Level 5.1 High-tier) and H.264 (Level
+  5.2) supporting upto 240MPixels/s and MJPEG encoder at 416MPixels/s
+* Single display with 24-bit RGB parallel (DPI) interface supporting upto
+  165Mhz pixel clock for 2K resolution.
+* Integrated Giga-bit Ethernet switch supporting up to a total of two
+  external ports (TSN capable).
+* 9xUARTs, 5xSPI, 6xI2C, 2xUSB2, 3xCAN-FD, 3x eMMC and SD, GPMC for
+  NAND/FPGA connection, OSPI memory controller, 3xMcASP for audio,
+  1x CSI-RX-4L for Camera, eCAP/eQEP, ePWM, among other peripherals.
+* Dedicated Centralized System Controller for Security, Power, and
+  Resource Management.
+* Multiple low power modes support, ex: Deep sleep, Standby, MCU-only,
+  enabling battery powered system design.
+
+More details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruj16
+
+Platform information:
+
+* https://www.ti.com/tool/SK-AM62A-LP
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
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
+.. code-block:: bash
+
+ $ export UBOOT_CFG_CORTEXR=am62ax_evm_r5_defconfig
+ $ export UBOOT_CFG_CORTEXA=am62ax_evm_a53_defconfig
+ $ export TFA_BOARD=lite
+ $ # we dont use any extra TFA parameters
+ $ unset TFA_EXTRA_ARGS
+ $ export OPTEE_PLATFORM=k3-am62ax
+ $ # we dont use any extra OPTEE parameters
+ $ unset OPTEE_EXTRA_ARGS
+
+1. Trusted Firmware-A:
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_build_steps_tfa
+    :end-before: .. k3_rst_include_end_build_steps_tfa
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
+
+Target Images
+--------------
+In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
+variant (GP, HS-FS, HS-SE) requires a different source for these files.
+
+ - GP
+
+        * tiboot3-am62ax-gp-evm.bin from step 3.1
+        * tispl.bin_unsigned, u-boot.img_unsigned from step 3.2
+
+ - HS-FS
+
+        * tiboot3-am62ax-hs-fs-evm.bin from step 3.1
+        * tispl.bin, u-boot.img from step 3.2
+
+ - HS-SE
+
+        * tiboot3-am62ax-hs-evm.bin from step 3.1
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
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62 platform. More
+details can be found in the Technical Reference Manual:
+https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
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
+  **OpenOCD support since**: August 2023 (git master)
+
+  Until the next stable release of OpenOCD is available in your development
+  environment's distribution, it might be necessary to build OpenOCD `from the
+  source <https://github.com/openocd-org/openocd>`_.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. code-block:: bash
+
+  openocd -f board/ti_am62a7evm.cfg
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 89d70db88647..b8318f0994fe 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -30,6 +30,7 @@ K3 Based SoCs
 .. toctree::
    :maxdepth: 1
 
+   am62ax_sk
    am62x_beagleplay
    am62x_sk
    ../toradex/verdin-am62
-- 
2.40.0

