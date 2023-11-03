Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E794C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 00:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E5D86FDA;
	Fri,  3 Nov 2023 01:39:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TWwoElPq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20904876FA; Fri,  3 Nov 2023 01:38:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED47C876DF
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 01:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cB6L003521;
 Thu, 2 Nov 2023 19:38:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698971891;
 bh=uVCxOyQc5/t66hIVaijodXWpo2y10kBrzANzm1g1CKs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=TWwoElPqa1X56gg9rEfX/vylgX1BYxat5rKzV2PWDszXcnIP11VWyLLCc11h8LoKj
 /ulXDX/1ob22qIGfQG0cYaxcSI0uDAaTR+BYs3ekGwjbp7eTAWXg4UJakvXqUNAjSu
 XnTcZQ0+Lvcb28u/suTK2rPegKc5G+gG9STUP3yY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A30cB0j124983
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 19:38:11 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 19:38:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 19:38:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A30cBsS030085;
 Thu, 2 Nov 2023 19:38:11 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 15/15] doc: board: ti: Add BeagleBone AI-64 documentation
Date: Thu, 2 Nov 2023 19:38:05 -0500
Message-ID: <20231103003805.2420005-16-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231103003805.2420005-1-nm@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
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

Add base documentation for BeagleBone AI-64.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 doc/board/ti/j721e_beagleboneai64.rst | 327 ++++++++++++++++++++++++++
 doc/board/ti/k3.rst                   |   1 +
 2 files changed, 328 insertions(+)
 create mode 100644 doc/board/ti/j721e_beagleboneai64.rst

diff --git a/doc/board/ti/j721e_beagleboneai64.rst b/doc/board/ti/j721e_beagleboneai64.rst
new file mode 100644
index 000000000000..18e154bd417a
--- /dev/null
+++ b/doc/board/ti/j721e_beagleboneai64.rst
@@ -0,0 +1,327 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Nishanth Menon <nm@ti.com>
+
+J721E/TDA4VM Beagleboard.org BeagleBone AI-64
+=============================================
+
+Introduction:
+-------------
+
+BeagleBoard.org BeagleBone AI-64 is an open source hardware single
+board computer based on the Texas Instruments TDA4VM SoC featuring
+dual-core 2.0GHz Arm Cortex-A72 processor, C7x+MMA and 2 C66x
+floating-point VLIW DSPs, 3x dual ARM Cortex-R5 co-processors,
+2x 6-core Programmable Real-Time Unit and Industrial Communication
+SubSystem, PowerVR Rogue 8XE GE8430 3D GPU. The board features 4GB
+DDR4, USB3.0 Type-C, 2x USB SS Type-A, miniDisplayPort, 2x 4-lane
+CSI, DSI, 16GB eMMC flash, 1G Ethernet, M.2 E-key for WiFi/BT, and
+BeagleBone expansion headers.
+
+Further information can be found at:
+
+* Product Page: https://beagleboard.org/ai-64
+* Hardware documentation: https://git.beagleboard.org/beagleboard/beaglebone-ai-64
+
+Boot Flow:
+----------
+Below is the pictorial representation of boot flow:
+
+.. image:: img/boot_diagram_j721e.svg
+  :alt: Boot flow diagram
+
+- On this platform, DMSC runs 'TI Foundational Security' (TIFS) which
+  functions as the security enclave master. The 'Device Manager' (DM),
+  also known as the 'TISCI server' in "TI terminology", running on boot
+  R5F, offers all the essential services required for device management.
+  The A72, C7x, C6x or R5F (Aux cores) sends requests to TIFS/DM to
+  accomplish the needed services, as illustrated in the diagram above.
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
+.. prompt:: bash $
+
+  export UBOOT_CFG_CORTEXR="j721e_evm_r5_defconfig beagleboneai64_r5.config"
+  export UBOOT_CFG_CORTEXA="j721e_evm_a72_defconfig beagleboneai64_a72.config"
+  export TFA_BOARD=generic
+  # we dont use any extra TFA parameters
+  unset TFA_EXTRA_ARGS
+  export OPTEE_PLATFORM=k3-j721e
+  # we dont use any extra OP-TEE parameters
+  unset OPTEE_EXTRA_ARGS
+
+.. include::  j721e_evm.rst
+    :start-after: .. j721e_evm_rst_include_start_build_steps
+    :end-before: .. j721e_evm_rst_include_end_build_steps
+
+Target Images
+--------------
+Copy the below images to an SD card and boot:
+
+* tiboot3-j721e-gp-evm.bin from R5 build as tiboot3.bin
+* tispl.bin_unsigned from Cortex-A build as tispl.bin
+* u-boot.img_unsigned from Cortex-A build as u-boot.img
+
+Image formats
+-------------
+
+- tiboot3.bin
+
+.. image:: img/no_multi_cert_tiboot3.bin.svg
+  :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/dm_tispl.bin.svg
+  :alt: tispl.bin image format
+
+- sysfw.itb
+
+.. image:: img/sysfw.itb.svg
+  :alt: sysfw.itb image format
+
+Additional hardware for U-Boot development
+------------------------------------------
+
+* Serial Console is critical for U-Boot development on BeagleBone AI-64. See
+  `BeagleBone AI-64 connector documentation
+  <https://docs.beagleboard.org/latest/boards/beaglebone/ai-64/ch07.html>`_.
+* uSD is preferred option over eMMC, and a SD/MMC reader will be needed.
+* (optionally) JTAG is useful when working with very early stages of boot.
+
+Default storage options
+-----------------------
+
+There are multiple storage media options on BeagleBone AI-64, but primarily:
+
+* Onboard eMMC (default) - reliable, fast and meant for deployment use.
+* SD/MMC card interface (hold 'BOOT' switch and power on) - Entirely
+  depends on the SD card quality.
+
+Flash to uSD card or how to deal with "bricked" Board
+--------------------------------------------------------
+
+When deploying or working on Linux, it's common to use the onboard
+eMMC. However, avoiding the eMMC and using the uSD card is safer when
+working with U-Boot.
+
+If you choose to  hand format your own bootable uSD card, be
+aware that it can be difficult. The following information
+may be helpful, but remember that it is only sometimes
+reliable, and partition options can cause issues. These
+can potentially help:
+
+* https://git.ti.com/cgit/arago-project/tisdk-setup-scripts/tree/create-sdcard.sh
+* https://elinux.org/Beagleboard:Expanding_File_System_Partition_On_A_microSD
+
+The simplest option is to start with a standard distribution
+image like those in `BeagleBoard.org Distros Page
+<https://www.beagleboard.org/distros>`_ and download a disk image for
+BeagleBone AI-64. Pick a 16GB+ uSD card to be on the safer side.
+
+With an SD/MMC Card reader and `Balena Etcher
+<https://etcher.balena.io/>`_, having a functional setup in minutes is
+a trivial matter, and it works on almost all Host Operating Systems.
+Yes Windows users, Windows Subsystem for Linux(WSL) based development
+with U-Boot and update uSD card is practical.
+
+Updating U-Boot is a matter of copying the tiboot3.bin, tispl.bin and
+u-boot.img to the "BOOT" partition of the uSD card. Remember to sync
+and unmount (or Eject - depending on the Operating System) the uSD
+card prior to physically removing from SD card reader.
+
+Also see following section on switch setting used for booting using
+uSD card.
+
+.. note::
+  Great news! If the board has not been damaged physically, there's no
+  need to worry about it being "bricked" on this platform. You only have
+  to flash an uSD card, plug it in, and reinstall the image on eMMC. This
+  means that even if you make a mistake, you can quickly fix it and rest
+  easy.
+
+  If you are frequently working with uSD cards, you might find the
+  following useful:
+
+  * `USB-SD-Mux <https://www.linux-automation.com/en/products/usb-sd-mux.html>`_
+  * `SD-Wire <https://wiki.tizen.org/SDWire>`_
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
+  :alt: eMMC partitions and boot file organization for BeagleBone AI-64
+
+The following are the steps from Linux shell to program eMMC:
+
+.. prompt:: bash #
+
+  # Enable Boot0 boot
+  mmc bootpart enable 1 2 /dev/mmcblk0
+  mmc bootbus set single_backward x1 x8 /dev/mmcblk0
+  mmc hwreset enable /dev/mmcblk0
+
+  # Clear eMMC boot0
+  echo '0' >> /sys/class/block/mmcblk0boot0/force_ro
+  dd if=/dev/zero of=/dev/mmcblk0boot0 count=32 bs=128k
+  # Write tiboot3.bin
+  dd if=tiboot3.bin of=/dev/mmcblk0boot0 bs=128k
+
+  # Copy the rest of the boot binaries
+  mount /dev/mmcblk0p1 /boot/firmware
+  cp tispl.bin /boot/firmware
+  cp u-boot.img /boot/firmware
+  sync
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
+  The green LED very next to the serial connector labelled "WKUP UART0"
+  is the power LED (LED6). This is the same color as the rest of the USR
+  LEDs. If the "green" LED6 power LED is not glowing, the system power
+  supply is not functional. Please refer to `BeagleBone AI-64 documentation
+  <https://beagleboard.org/ai-64/>`_ for further information.
+
+Switch Setting for Boot Mode
+----------------------------
+
+The boot time option is configured via "BOOT" button on the board.
+See `BeagleBone AI-64 Schematics <https://git.beagleboard.org/beagleboard/beaglebone-ai-64/-/blob/main/BeagleBone_AI-64_SCH.pdf>`_
+for details.
+
+.. list-table:: Boot Modes
+   :widths: 16 16 16
+   :header-rows: 1
+
+   * - BOOT Switch Position
+     - Primary Boot
+     - Secondary Boot
+
+   * - Not Pressed
+     - eMMC
+     - SD Card
+
+   * - Pressed
+     - SD Card
+     - SD Card
+
+To switch to SD card boot mode, hold the BOOT button while powering on
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
+For example, with BeagleBone AI-64 (J721e platform), the openocd_connect.cfg:
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
+    set SOC j721e
+  }
+
+  source [find target/ti_k3.cfg]
+
+  ftdi tdo_sample_edge falling
+
+  # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
+  # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
+  adapter speed 16000
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 89d70db88647..52a5d4a095f2 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -36,6 +36,7 @@ K3 Based SoCs
    am64x_evm
    am65x_evm
    j7200_evm
+   j721e_beagleboneai64
    j721e_evm
    j721s2_evm
 
-- 
2.40.0

