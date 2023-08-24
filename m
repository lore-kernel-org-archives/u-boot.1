Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83194C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 03:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79B686537;
	Thu, 24 Aug 2023 05:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iiq0eeDu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6996786584; Thu, 24 Aug 2023 05:11:30 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8ED8656F
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 05:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BB4H109486;
 Wed, 23 Aug 2023 22:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692846671;
 bh=5y/p5yQL1UDhWofs2eelB0UfmQHw6eaR+XUXQUaR3xM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iiq0eeDuFVupHUP/iJI+qv3m3SPMie6s6J5qq1UjddRwW0Lgl/rB5OYom3DcQ6/m2
 eBdCdXt8+T65tYNwEPmjnMkoy8AeOWB3QJ6cZ6R7l1pw31pSIP4dug4Y3Hg/GBFWUI
 Eej0Q5v+XYmaYffR2JrR5Sx/6jO+1UQpE4sjXIvw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O3BB0t012271
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 22:11:11 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 22:11:10 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 22:11:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O3BAfb013371;
 Wed, 23 Aug 2023 22:11:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon
 Glass <sjg@google.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH V5 17/17] doc: board: ti: Add BeaglePlay documentation
Date: Wed, 23 Aug 2023 22:11:01 -0500
Message-ID: <20230824031101.3460411-18-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230824031101.3460411-1-nm@ti.com>
References: <20230824031101.3460411-1-nm@ti.com>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Changes Since V4:
- Just the verbage comment from Simon

V4: https://lore.kernel.org/r/20230822184135.2328409-9-nm@ti.com
V3: https://lore.kernel.org/all/20230815164440.2713726-5-nm@ti.com/
V2: https://lore.kernel.org/u-boot/20230727234446.3651836-5-nm@ti.com/
V1: https://lore.kernel.org/all/20230725185253.2123433-7-nm@ti.com/

 doc/board/ti/am62x_beagleplay.rst    | 256 ++++++++++
 doc/board/ti/img/beagleplay_emmc.svg | 697 +++++++++++++++++++++++++++
 doc/board/ti/k3.rst                  |   1 +
 3 files changed, 954 insertions(+)
 create mode 100644 doc/board/ti/am62x_beagleplay.rst
 create mode 100644 doc/board/ti/img/beagleplay_emmc.svg

diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
new file mode 100644
index 000000000000..8fbeb715c4a8
--- /dev/null
+++ b/doc/board/ti/am62x_beagleplay.rst
@@ -0,0 +1,256 @@
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
+  :alt: Boot flow diagram
+
+- On this platform, 'TI Foundational Security' (TIFS) functions as the
+  security enclave master while 'Device Manager' (DM), also known as the
+  'TISCI server' in "TI terminology", offers all the essential services.
+  The A53 or M4F (Aux core) sends requests to TIFS/DM to accomplish these
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
+  :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/dm_tispl.bin.svg
+  :alt: tispl.bin image format
+
+Flash to eMMC
+-------------
+
+The eMMC layout selected is user-friendly for developers. The
+boot hardware partition of the eMMC only contains the fixed-size
+tiboot3.bin image. This is because the contents of the boot partitions
+need to run from the SoC's internal SRAM, which remains a fixed size
+constant. The other components of the boot sequence, such as tispl.bin
+and u-boot.img, are located in the /BOOT partition in the User Defined
+Area (UDA) hardware partition of the eMMC. These components can vary
+significantly in size. The choice of keeping tiboot3.bin in boot0 or
+boot1 partition depends on A/B update requirements.
+
+.. image:: img/beagleplay_emmc.svg
+  :alt: eMMC partitions and boot file organization for BeaglePlay
+
+The following are the steps from Linux shell to program eMMC:
+
+.. code-block:: bash
+
+  # # Enable Boot0 boot
+  # mmc bootpart enable 1 2 /dev/mmcblk0
+  # mmc bootbus set single_backward x1 x8 /dev/mmcblk0
+  # mmc hwreset enable /dev/mmcblk0
+
+  # # Clear eMMC boot0
+  # echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
+  # dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k
+  # # Write tiboot3.bin
+  # dd if=tiboot3.bin of=/dev/mmcblk0boot0 bs=128k
+
+  # # Copy the rest of the boot binaries
+  # mount /dev/mmcblk0p1 /boot/firmware
+  # cp tispl.bin /boot/firmware
+  # cp u-boot.img /boot/firmware
+  # sync
+
+.. warning ::
+
+  U-Boot is configured to prioritize booting from an SD card if it
+  detects a valid boot partition and boot files on it, even if the
+  system initially booted from eMMC. The boot order is set as follows:
+
+  * SD/MMC
+  * eMMC
+  * USB
+  * PXE
+
+LED patterns during boot
+------------------------
+
+.. list-table:: USR LED status indication
+   :widths: 16 16
+   :header-rows: 1
+
+   * - USR LEDs (012345)
+     - Indicates
+
+   * - 00000
+     - Boot failure or R5 image not started up
+
+   * - 11111
+     - A53 SPL/U-boot has started up
+
+   * - 10101
+     - OS boot process has been initiated
+
+   * - 01010
+     - OS boot process failed and drops to U-Boot shell
+
+.. note ::
+
+  In the table above, 0 indicates LED switched off and 1 indicates LED
+  switched ON.
+
+.. warning ::
+
+  If the "red" power LED is not glowing, the system power supply is not
+  functional. Please refer to `BeaglePlay documentation
+  <https://beagleplay.org/>`_ for further information.
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
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup and debugging information.
+
+.. warning::
+
+  **OpenOCD support since**: v0.12.0
+
+  If the default package version of OpenOCD in your development
+  environment's distribution needs to be updated, it might be necessary to
+  build OpenOCD from the source.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_tag_connect
+    :end-before: .. k3_rst_include_end_openocd_connect_tag_connect
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
+    :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
+
+For example, with BeaglePlay (AM62X platform), the openocd_connect.cfg:
+
+.. code-block:: tcl
+
+  # TUMPA example:
+  # http://www.tiaowiki.com/w/TIAO_USB_Multi_Protocol_Adapter_User's_Manual
+  source [find interface/ftdi/tumpa.cfg]
+
+  transport select jtag
+
+  # default JTAG configuration has only SRST and no TRST
+  reset_config srst_only srst_push_pull
+
+  # delay after SRST goes inactive
+  adapter srst delay 20
+
+  if { ![info exists SOC] } {
+    # Set the SoC of interest
+    set SOC am625
+  }
+
+  source [find target/ti_k3.cfg]
+
+  ftdi tdo_sample_edge falling
+
+  # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
+  # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
+  adapter speed 16000
diff --git a/doc/board/ti/img/beagleplay_emmc.svg b/doc/board/ti/img/beagleplay_emmc.svg
new file mode 100644
index 000000000000..c6ff19b77384
--- /dev/null
+++ b/doc/board/ti/img/beagleplay_emmc.svg
@@ -0,0 +1,697 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!--SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause-->
+
+<!--Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/-->
+
+<svg
+   version="1.1"
+   width="771px"
+   height="351px"
+   viewBox="-0.5 -0.5 771 351"
+   id="svg142"
+   sodipodi:docname="beagleplay_emmc.svg"
+   inkscape:version="1.1.2 (0a00cf5339, 2022-02-04)"
+   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
+   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
+   xmlns:xlink="http://www.w3.org/1999/xlink"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg"
+   xmlns:xhtml="http://www.w3.org/1999/xhtml">
+  <sodipodi:namedview
+     id="namedview144"
+     pagecolor="#ffffff"
+     bordercolor="#666666"
+     borderopacity="1.0"
+     inkscape:pageshadow="2"
+     inkscape:pageopacity="0.0"
+     inkscape:pagecheckerboard="0"
+     showgrid="false"
+     inkscape:zoom="1.460441"
+     inkscape:cx="380.0222"
+     inkscape:cy="175.28952"
+     inkscape:window-width="3440"
+     inkscape:window-height="1416"
+     inkscape:window-x="0"
+     inkscape:window-y="0"
+     inkscape:window-maximized="1"
+     inkscape:current-layer="g18" />
+  <defs
+     id="defs2" />
+  <g
+     id="g132">
+    <rect
+       x="90"
+       y="0"
+       width="120"
+       height="60"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect4" />
+    <rect
+       x="210"
+       y="0"
+       width="120"
+       height="60"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect6" />
+    <rect
+       x="330"
+       y="0"
+       width="120"
+       height="60"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect8" />
+    <rect
+       x="450"
+       y="0"
+       width="320"
+       height="60"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect10" />
+    <rect
+       x="120"
+       y="15"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect12" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g18">
+      <switch
+         id="switch16">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margin-left: 121px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Boot0</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="150"
+           y="34"
+           fill="#000000"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text14">Boot0</text>
+      </switch>
+    </g>
+    <rect
+       x="240"
+       y="15"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect20" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g26">
+      <switch
+         id="switch24">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margin-left: 241px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">Boot1</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="270"
+           y="34"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text22">Boot1</text>
+      </switch>
+    </g>
+    <rect
+       x="360"
+       y="15"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect28" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g34">
+      <switch
+         id="switch32">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margin-left: 361px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">RPMB</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="390"
+           y="34"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text30">RPMB</text>
+      </switch>
+    </g>
+    <rect
+       x="480"
+       y="15"
+       width="280"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect36" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g42">
+      <switch
+         id="switch40">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 278px; height: 1px; padding-top: 30px; margin-left: 481px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">User Defined Area (UDA)</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="620"
+           y="34"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text38">User Defined Area (UDA)</text>
+      </switch>
+    </g>
+    <rect
+       x="450"
+       y="60"
+       width="70"
+       height="60"
+       rx="9"
+       ry="9"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect44" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g50">
+      <switch
+         id="switch48">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 68px; height: 1px; padding-top: 90px; margin-left: 451px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">BOOT</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="485"
+           y="94"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text46">BOOT</text>
+      </switch>
+    </g>
+    <rect
+       x="520"
+       y="60"
+       width="120"
+       height="60"
+       rx="9"
+       ry="9"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect52" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g58">
+      <switch
+         id="switch56">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 118px; height: 1px; padding-top: 90px; margin-left: 521px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">rootfs</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="580"
+           y="94"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text54">rootfs</text>
+      </switch>
+    </g>
+    <rect
+       x="700"
+       y="60"
+       width="70"
+       height="60"
+       rx="9"
+       ry="9"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect60" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g66">
+      <switch
+         id="switch64">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 68px; height: 1px; padding-top: 90px; margin-left: 701px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">swap</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="735"
+           y="94"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text62">swap</text>
+      </switch>
+    </g>
+    <rect
+       x="640"
+       y="60"
+       width="60"
+       height="60"
+       rx="9"
+       ry="9"
+       fill="rgb(255, 255, 255)"
+       stroke="rgb(0, 0, 0)"
+       pointer-events="all"
+       id="rect68" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g74">
+      <switch
+         id="switch72">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 90px; margin-left: 641px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">...</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="670"
+           y="94"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text70">...</text>
+      </switch>
+    </g>
+    <path
+       d="M 130 130 L 180 130 L 180 180 L 100 180 L 100 160 Z"
+       fill="#ffe6cc"
+       stroke="#d79b00"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path76" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g82">
+      <switch
+         id="switch80">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 78px; height: 1px; padding-top: 155px; margin-left: 101px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">tiboot3.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="140"
+           y="159"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text78">tiboot3.bin</text>
+      </switch>
+    </g>
+    <path
+       d="M 470 130 L 520 130 L 520 180 L 440 180 L 440 160 Z"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path84" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g90">
+      <switch
+         id="switch88">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 78px; height: 1px; padding-top: 155px; margin-left: 441px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">tispl.bin</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="480"
+           y="159"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text86">tispl.bin</text>
+      </switch>
+    </g>
+    <path
+       d="M 470 180 L 520 180 L 520 230 L 440 230 L 440 210 Z"
+       fill="#d5e8d4"
+       stroke="#82b366"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path92" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g98">
+      <switch
+         id="switch96">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 78px; height: 1px; padding-top: 205px; margin-left: 441px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">u-boot.img</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="480"
+           y="209"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text94">u-boot.img</text>
+      </switch>
+    </g>
+    <path
+       d="M 420 300 L 520 300 L 520 350 L 390 350 L 390 330 Z"
+       fill="#e1d5e7"
+       stroke="#9673a6"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path100" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g106">
+      <switch
+         id="switch104">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 128px; height: 1px; padding-top: 325px; margin-left: 391px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">extlinux/extlinux.conf</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="455"
+           y="329"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text102">extlinux/extlinux.conf</text>
+      </switch>
+    </g>
+    <path
+       d="M 420 240 L 520 240 L 520 290 L 390 290 L 390 270 Z"
+       fill="#dae8fc"
+       stroke="#6c8ebf"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path108" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g114">
+      <switch
+         id="switch112">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 128px; height: 1px; padding-top: 265px; margin-left: 391px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">uEnv.txt / boot.scr<xhtml:br />
+(optional)</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="455"
+           y="269"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text110">uEnv.txt / boot.scr...</text>
+      </switch>
+    </g>
+    <rect
+       x="0"
+       y="15"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect116" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g122">
+      <switch
+         id="switch120">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 30px; margin-left: 1px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">eMMC<xhtml:br />
+hardware partitions</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="30"
+           y="34"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text118">eMMC...</text>
+      </switch>
+    </g>
+    <rect
+       x="365"
+       y="75"
+       width="60"
+       height="30"
+       fill="none"
+       stroke="none"
+       pointer-events="all"
+       id="rect124" />
+    <g
+       transform="translate(-0.5 -0.5)"
+       id="g130">
+      <switch
+         id="switch128">
+        <foreignObject
+           pointer-events="none"
+           width="100%"
+           height="100%"
+           requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+           style="overflow: visible; text-align: left;">
+          <xhtml:div
+             style="display: flex; align-items: unsafe center; justify-content: unsafe center; width: 58px; height: 1px; padding-top: 90px; margin-left: 366px;">
+            <xhtml:div
+               data-drawio-colors="color: rgb(0, 0, 0); "
+               style="box-sizing: border-box; font-size: 0px; text-align: center;">
+              <xhtml:div
+                 style="display: inline-block; font-size: 12px; font-family: Helvetica; color: rgb(0, 0, 0); line-height: 1.2; pointer-events: all; white-space: normal; overflow-wrap: normal;">UDA partitions</xhtml:div>
+            </xhtml:div>
+          </xhtml:div>
+        </foreignObject>
+        <text
+           x="395"
+           y="94"
+           fill="rgb(0, 0, 0)"
+           font-family="Helvetica"
+           font-size="12px"
+           text-anchor="middle"
+           id="text126">UDA partit...</text>
+      </switch>
+    </g>
+  </g>
+  <switch
+     id="switch140">
+    <g
+       requiredFeatures="http://www.w3.org/TR/SVG11/feature#Extensibility"
+       id="g134" />
+    <a
+       transform="translate(0,-5)"
+       xlink:href="https://www.diagrams.net/doc/faq/svg-export-text-problems"
+       target="_blank"
+       id="a138">
+      <text
+         text-anchor="middle"
+         font-size="10px"
+         x="50%"
+         y="100%"
+         id="text136">Text is not SVG - cannot display</text>
+    </a>
+  </switch>
+</svg>
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 5f9bd4dfcbe9..ef31ccd12a42 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -30,6 +30,7 @@ K3 Based SoCs
 .. toctree::
    :maxdepth: 1
 
+   am62x_beagleplay
    am62x_sk
    ../toradex/verdin-am62
    am64x_evm
-- 
2.40.0

