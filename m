Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38F9C0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 17:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA7387518;
	Sat, 28 Oct 2023 19:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 060C587539; Sat, 28 Oct 2023 19:49:38 +0200 (CEST)
Received: from mx1.tinet.cat (mx1.dipta.cat [195.76.233.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D35DD874D8
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 19:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=tinet.cat
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xdrudis@tinet.cat
X-ASG-Debug-ID: 1698515372-12aaf231ae7b34c0001-4l7tJC
Received: from smtp01.tinet.cat (smtp.tinet.cat [195.77.216.131]) by
 mx1.tinet.cat with ESMTP id eczNsWwSM8ECfd4J;
 Sat, 28 Oct 2023 19:49:32 +0200 (CEST)
X-Barracuda-Envelope-From: xdrudis@tinet.cat
X-Barracuda-Effective-Source-IP: smtp.tinet.cat[195.77.216.131]
X-Barracuda-Apparent-Source-IP: 195.77.216.131
Received: from xdrudis.tinet.cat (191.red-79-152-186.dynamicip.rima-tde.net
 [79.152.186.191])
 by smtp01.tinet.cat (Postfix) with ESMTPSA id 8EABF605DE45;
 Sat, 28 Oct 2023 19:49:32 +0200 (CEST)
Date: Sat, 28 Oct 2023 19:49:22 +0200
From: Xavier Drudis Ferran <xdrudis@tinet.cat>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [SPAM] [PATCH 1/1] doc: short overlong title underlines
Message-ID: <ZT1JokpeyhfJKSIM@xdrudis.tinet.cat>
X-ASG-Orig-Subj: Re: [SPAM] [PATCH 1/1] doc: short overlong title underlines
References: <20231028100312.20623-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231028100312.20623-1-heinrich.schuchardt@canonical.com>
X-Barracuda-Connect: smtp.tinet.cat[195.77.216.131]
X-Barracuda-Start-Time: 1698515372
X-Barracuda-URL: https://webmail.tinet.cat:443/cgi-mod/mark.cgi
X-Barracuda-Scan-Msg-Size: 32008
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 1.0000 1.0000 4.3430
X-Barracuda-Spam-Score: 5.34
X-Barracuda-Spam-Status: No, SCORE=5.34 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=6.0 KILL_LEVEL=8.0 tests=BSF_RULE7568M, BSF_RULE_7582B,
 MAILTO_TO_SPAM_ADDR
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.115999
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.00 MAILTO_TO_SPAM_ADDR    Includes a link to a likely spammer email
 0.50 BSF_RULE7568M          Custom Rule 7568M
 0.50 BSF_RULE_7582B         Custom Rule 7582B
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

El Sat, Oct 28, 2023 at 12:03:12PM +0200, Heinrich Schuchardt deia:
> Title underlines should match the length of the title. Unfortunately
> docutils only catches underlines that are too short.
> 
> Add some missing empty lines after titles.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Xavier Drudis Ferran <xdrudis@tinet.cat>

> ---
>  doc/arch/arm64.ffa.rst                 | 20 ++++++++++----------
>  doc/board/AndesTech/ae350.rst          |  2 +-
>  doc/board/actions/cubieboard7.rst      |  4 ++--
>  doc/board/actions/index.rst            |  2 +-
>  doc/board/armltd/index.rst             |  2 +-
>  doc/board/mediatek/index.rst           |  2 +-
>  doc/board/nxp/imx8mm_evk.rst           |  9 +++++----
>  doc/board/nxp/ls1046ardb.rst           |  2 +-
>  doc/board/nxp/mx6ul_14x14_evk.rst      |  2 +-
>  doc/board/openpiton/riscv64.rst        |  4 ++--
>  doc/board/purism/librem5.rst           |  2 +-
>  doc/board/qualcomm/sdm845.rst          |  7 ++++++-
>  doc/board/samsung/index.rst            |  2 +-
>  doc/board/st/st-dt.rst                 |  2 +-
>  doc/board/st/stm32_MCU.rst             |  2 +-
>  doc/board/starfive/visionfive2.rst     |  3 ++-
>  doc/board/thead/index.rst              |  2 +-
>  doc/board/ti/am62x_beagleplay.rst      |  4 ++--
>  doc/board/ti/am62x_sk.rst              |  5 +++--
>  doc/board/ti/am64x_evm.rst             |  3 ++-
>  doc/board/ti/am65x_evm.rst             |  3 ++-
>  doc/board/ti/j7200_evm.rst             |  3 ++-
>  doc/board/ti/j721e_evm.rst             |  3 ++-
>  doc/board/ti/j721s2_evm.rst            |  6 +++++-
>  doc/board/ti/k3.rst                    |  4 ++--
>  doc/board/xilinx/xilinx.rst            |  2 +-
>  doc/build/source.rst                   |  2 +-
>  doc/develop/driver-model/ethernet.rst  | 12 ++++++------
>  doc/develop/driver-model/migration.rst |  2 +-
>  doc/develop/driver-model/nvmxip.rst    |  8 ++++----
>  doc/develop/driver-model/spi-howto.rst |  2 +-
>  doc/develop/falcon.rst                 |  2 +-
>  doc/usage/cmd/askenv.rst               |  2 +-
>  doc/usage/cmd/bootdev.rst              |  4 ++--
>  doc/usage/cmd/cat.rst                  |  2 +-
>  doc/usage/cmd/coninfo.rst              |  2 +-
>  doc/usage/cmd/mmc.rst                  |  2 +-
>  doc/usage/cmd/part.rst                 |  2 +-
>  doc/usage/cmd/wdt.rst                  |  2 +-
>  doc/usage/cmd/xxd.rst                  |  2 +-
>  doc/usage/fit/beaglebone_vboot.rst     |  2 +-
>  doc/usage/measured_boot.rst            |  4 ++--
>  tools/binman/entries.rst               |  2 +-
>  43 files changed, 86 insertions(+), 70 deletions(-)
> 
> diff --git a/doc/arch/arm64.ffa.rst b/doc/arch/arm64.ffa.rst
> index 4ecdc31716..f966f8ba6a 100644
> --- a/doc/arch/arm64.ffa.rst
> +++ b/doc/arch/arm64.ffa.rst
> @@ -40,7 +40,7 @@ The U-Boot FF-A support provides the following parts:
>  - Sandbox FF-A test cases.
>  
>  FF-A and SMC specifications
> --------------------------------------------
> +---------------------------
>  
>  The current implementation of the U-Boot FF-A support relies on
>  `FF-A v1.0 specification`_ and uses SMC32 calling convention which
> @@ -56,12 +56,12 @@ Hypervisors are supported if they are configured to trap SMC calls.
>  The FF-A support uses 64-bit registers as per `SMC Calling Convention v1.2 specification`_.
>  
>  Supported hardware
> ---------------------------------
> +------------------
>  
>  Aarch64 plaforms
>  
>  Configuration
> -----------------------
> +-------------
>  
>  CONFIG_ARM_FFA_TRANSPORT
>      Enables the FF-A support. Turn this on if you want to use FF-A
> @@ -70,7 +70,7 @@ CONFIG_ARM_FFA_TRANSPORT
>      When using sandbox, the sandbox FF-A emulator and FF-A sandbox driver will be used.
>  
>  FF-A ABIs under the hood
> ----------------------------------------
> +------------------------
>  
>  Invoking an FF-A ABI involves providing to the secure world/hypervisor the
>  expected arguments from the ABI.
> @@ -89,7 +89,7 @@ The driver reads the response and processes it accordingly.
>  This methodology applies to all the FF-A ABIs.
>  
>  FF-A bus discovery on Arm 64-bit platforms
> ----------------------------------------------
> +------------------------------------------
>  
>  When CONFIG_ARM_FFA_TRANSPORT is enabled, the FF-A bus is considered as
>  an architecture feature and discovered using ARM_SMCCC_FEATURES mechanism.
> @@ -136,7 +136,7 @@ When one of the above actions fails, probing fails and the driver stays not acti
>  and can be probed again if needed.
>  
>  Requirements for clients
> --------------------------------------
> +------------------------
>  
>  When using the FF-A bus with EFI, clients must query the SPs they are looking for
>  during EFI boot-time mode using the service UUID.
> @@ -159,13 +159,13 @@ the 32-bit or 64-bit version of FFA_MSG_SEND_DIRECT_{REQ, RESP}.
>  The calling convention between U-Boot and the secure world stays the same: SMC32.
>  
>  Requirements for user drivers
> --------------------------------------
> +-----------------------------
>  
>  Users who want to implement their custom FF-A device driver while reusing the FF-A Uclass can do so
>  by implementing their own invoke_ffa_fn() in the user driver.
>  
>  The bus driver layer
> -------------------------------
> +--------------------
>  
>  FF-A support comes on top of the SMCCC layer and is implemented by the FF-A Uclass drivers/firmware/arm-ffa/arm-ffa-uclass.c
>  
> @@ -210,7 +210,7 @@ The following features are provided:
>  - FF-A bus can be compiled and used without EFI
>  
>  Relationship between the sandbox emulator and the FF-A device
> ----------------------------------------------------------------
> +-------------------------------------------------------------
>  
>  ::
>  
> @@ -222,7 +222,7 @@ Relationship between the sandbox emulator and the FF-A device
>      ffa                  0  [    ]   sandbox_arm_ffa               `-- sandbox-arm-ffa
>  
>  The armffa command
> ------------------------------------
> +------------------
>  
>  armffa is a command showcasing how to use the FF-A bus and how to invoke the driver operations.
>  
> diff --git a/doc/board/AndesTech/ae350.rst b/doc/board/AndesTech/ae350.rst
> index 42a2b4d0b5..99622fd325 100644
> --- a/doc/board/AndesTech/ae350.rst
> +++ b/doc/board/AndesTech/ae350.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  AE350
> -======
> +=====
>  
>  AE350 is the mainline SoC produced by Andes Technology using AndesV5 CPU core
>  based on RISC-V architecture.
> diff --git a/doc/board/actions/cubieboard7.rst b/doc/board/actions/cubieboard7.rst
> index 74f2b12e41..1f73fc40f8 100644
> --- a/doc/board/actions/cubieboard7.rst
> +++ b/doc/board/actions/cubieboard7.rst
> @@ -20,7 +20,7 @@ Though, one can enter ADFU mode and flash debian image(from host machine) where
>  getting into u-boot prompt is easy.
>  
>  Enter ADFU Mode
> -----------------
> +---------------
>  
>  Before write the firmware, let the development board entering the ADFU mode: insert
>  one end of the USB cable to the PC, press and hold the ADFU button, and then connect
> @@ -28,7 +28,7 @@ the other end of the USB cable to the Mini USB port of the development board, re
>  the ADFU button, after connecting it will enter the ADFU mode.
>  
>  Check whether entered ADFU Mode
> ---------------------------------
> +-------------------------------
>  
>  The user needs to run the following command on the PC side to check if the ADFU
>  device is detected. ID realted to "Actions Semiconductor Co., Ltd"  means that
> diff --git a/doc/board/actions/index.rst b/doc/board/actions/index.rst
> index c596879158..e925fcd0f6 100644
> --- a/doc/board/actions/index.rst
> +++ b/doc/board/actions/index.rst
> @@ -2,7 +2,7 @@
>  .. Copyright (C) 2020 Amit Singh Tomar <amittomer25@gmail.com>
>  
>  Actions
> -========
> +=======
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/doc/board/armltd/index.rst b/doc/board/armltd/index.rst
> index fc1d75aac2..052a9698f4 100644
> --- a/doc/board/armltd/index.rst
> +++ b/doc/board/armltd/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0
>  
>  Arm Ltd
> -=============
> +=======
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/doc/board/mediatek/index.rst b/doc/board/mediatek/index.rst
> index 38cd8cb5b2..c55d5aeb5c 100644
> --- a/doc/board/mediatek/index.rst
> +++ b/doc/board/mediatek/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  Mediatek
> -=========
> +========
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/doc/board/nxp/imx8mm_evk.rst b/doc/board/nxp/imx8mm_evk.rst
> index 327ce6e49c..bb11029fbc 100644
> --- a/doc/board/nxp/imx8mm_evk.rst
> +++ b/doc/board/nxp/imx8mm_evk.rst
> @@ -36,7 +36,7 @@ Get the ddr firmware
>     $ cp firmware-imx-8.9/firmware/ddr/synopsys/lpddr4*.bin $(builddir)
>  
>  Build U-Boot for sd card
> ---------------------------
> +------------------------
>  
>  .. code-block:: bash
>  
> @@ -54,8 +54,8 @@ Boot
>  ----
>  Set Boot switch to SD boot
>  
> -Build U-Boot for qspi flash  card
> -------------------------------------
> +Build U-Boot for qspi flash card
> +--------------------------------
>  
>  .. code-block:: bash
>  
> @@ -81,7 +81,8 @@ From sd card to memory
>     $ sf write $loadaddr 0x00 <size_of_flash.bin_in_hex>
>  
>  Boot from QSPI Flash
> ------------------------
> +--------------------
> +
>  Set Boot Switch to QSPI Flash
>  
>  Pin configuration for imx8mm_revC evk to boot from qspi flash
> diff --git a/doc/board/nxp/ls1046ardb.rst b/doc/board/nxp/ls1046ardb.rst
> index 49b4842b30..8c0bc82dde 100644
> --- a/doc/board/nxp/ls1046ardb.rst
> +++ b/doc/board/nxp/ls1046ardb.rst
> @@ -54,7 +54,7 @@ LS1046ARDB board Overview
>  - ARM JTAG support
>  
>  Memory map from core's view
> -----------------------------
> +---------------------------
>  
>  ================== ================== ================ =====
>  Start Address      End Address        Description      Size
> diff --git a/doc/board/nxp/mx6ul_14x14_evk.rst b/doc/board/nxp/mx6ul_14x14_evk.rst
> index 3e57ba1ee8..c135a21bf5 100644
> --- a/doc/board/nxp/mx6ul_14x14_evk.rst
> +++ b/doc/board/nxp/mx6ul_14x14_evk.rst
> @@ -4,7 +4,7 @@ mx6ul_14x14_evk
>  ===============
>  
>  How to use U-Boot on Freescale MX6UL 14x14 EVK
> ------------------------------------------------
> +----------------------------------------------
>  
>  - Build U-Boot for MX6UL 14x14 EVK:
>  
> diff --git a/doc/board/openpiton/riscv64.rst b/doc/board/openpiton/riscv64.rst
> index 3a97793f07..c379fbf9ff 100644
> --- a/doc/board/openpiton/riscv64.rst
> +++ b/doc/board/openpiton/riscv64.rst
> @@ -11,14 +11,14 @@ OpenPiton has been verified in both ASIC and multiple Xilinx FPGA prototypes
>  running full-stack Debian linux.
>  
>  RISC-V Standard Bootflow
> --------------------------
> +------------------------
>  
>  Currently, OpenPiton implements RISC-V standard bootflow in the following steps
>  mover.S -> u-boot-spl -> opensbi -> u-boot -> Linux
>  This board supports S-mode u-boot as well as M-mode SPL
>  
>  Building OpenPition
> ----------------------
> +-------------------
>  
>  If you'd like to build OpenPiton, please go to OpenPiton github repo
>  (at https://github.com/PrincetonUniversity/openpiton) to build from the latest
> diff --git a/doc/board/purism/librem5.rst b/doc/board/purism/librem5.rst
> index fb050c6302..a7975e1659 100644
> --- a/doc/board/purism/librem5.rst
> +++ b/doc/board/purism/librem5.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  Librem5
> -==========
> +=======
>  
>  U-Boot for the Purism Librem5 phone
>  
> diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
> index d3f218e835..a65f00df39 100644
> --- a/doc/board/qualcomm/sdm845.rst
> +++ b/doc/board/qualcomm/sdm845.rst
> @@ -2,10 +2,11 @@
>  .. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
>  
>  Snapdragon 845
> -================
> +==============
>  
>  About this
>  ----------
> +
>  This document describes the information about Qualcomm Snapdragon 845
>  supported boards and it's usage steps.
>  
> @@ -17,8 +18,10 @@ Qualcomm's UEFI-based ABL (Android) Bootloader.
>  
>  Installation
>  ------------
> +
>  Build
>  ^^^^^
> +
>  Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
>  
>  	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> @@ -29,10 +32,12 @@ This will build ``u-boot.bin`` in the configured output directory.
>  
>  Generate FIT image
>  ^^^^^^^^^^^^^^^^^^
> +
>  See doc/uImage.FIT for more details
>  
>  Pack android boot image
>  ^^^^^^^^^^^^^^^^^^^^^^^
> +
>  We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
>  and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
>  with appended dtb, so let's mimic linux to satisfy stock bootloader.
> diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
> index c904372dff..971805e201 100644
> --- a/doc/board/samsung/index.rst
> +++ b/doc/board/samsung/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  Samsung
> -========
> +=======
>  
>  .. toctree::
>     :maxdepth: 2
> diff --git a/doc/board/st/st-dt.rst b/doc/board/st/st-dt.rst
> index 67e16ef165..2a285c8180 100644
> --- a/doc/board/st/st-dt.rst
> +++ b/doc/board/st/st-dt.rst
> @@ -2,7 +2,7 @@
>  .. sectionauthor:: Patrick Delaunay <patrick.delaunay@foss.st.com>
>  
>  U-Boot device tree bindings
> -----------------------------
> +---------------------------
>  
>  The U-Boot specific bindings are defined in the U-Boot directory:
>  doc/device-tree-bindings
> diff --git a/doc/board/st/stm32_MCU.rst b/doc/board/st/stm32_MCU.rst
> index 7ff7c730fa..61650bc801 100644
> --- a/doc/board/st/stm32_MCU.rst
> +++ b/doc/board/st/stm32_MCU.rst
> @@ -2,7 +2,7 @@
>  .. sectionauthor:: Patrice Chotard <patrice.chotardy@foss.st.com>
>  
>  STM32 MCU boards
> -=================
> +================
>  
>  This is a quick instruction for setup STM32 MCU boards.
>  
> diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
> index 9ee758e56c..6cb033ead0 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -4,7 +4,8 @@ StarFive VisionFive2
>  ====================
>  
>  JH7110 RISC-V SoC
> ----------------------
> +-----------------
> +
>  The JH7110 is 4+1 64-bit RISC-V SoC from StarFive.
>  
>  The StarFive VisionFive2 development platform is based on JH7110 and capable
> diff --git a/doc/board/thead/index.rst b/doc/board/thead/index.rst
> index 41566d3a36..2c4b3fb8cb 100644
> --- a/doc/board/thead/index.rst
> +++ b/doc/board/thead/index.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  T-HEAD
> -========
> +======
>  
>  .. toctree::
>     :maxdepth: 1
> diff --git a/doc/board/ti/am62x_beagleplay.rst b/doc/board/ti/am62x_beagleplay.rst
> index 39913b29ab..17738ea4f9 100644
> --- a/doc/board/ti/am62x_beagleplay.rst
> +++ b/doc/board/ti/am62x_beagleplay.rst
> @@ -70,7 +70,7 @@ Set the variables corresponding to this platform:
>      :end-before: .. am62x_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
>  Copy the below images to an SD card and boot:
>  
>  * tiboot3-am62x-gp-evm.bin from R5 build as tiboot3.bin
> @@ -109,7 +109,7 @@ There are multiple storage media options on BeaglePlay, but primarily:
>    depends on the SD card quality.
>  
>  Flash to uSD card or how to deal with "bricked" Board
> ---------------------------------------------------------
> +-----------------------------------------------------
>  
>  When deploying or working on Linux, it's common to use the onboard
>  eMMC. However, avoiding the eMMC and using the uSD card is safer when
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index d7437c6d22..4703ce6f7f 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -2,7 +2,7 @@
>  .. sectionauthor:: Vignesh Raghavendra <vigneshr@ti.com>
>  
>  AM62 Platforms
> -===============
> +==============
>  
>  Introduction:
>  -------------
> @@ -117,7 +117,8 @@ Set the variables corresponding to this platform:
>  .. am62x_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
> +
>  In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
>  variant (GP, HS-FS, HS-SE) requires a different source for these files.
>  
> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> index db27461cb1..69afee08f6 100644
> --- a/doc/board/ti/am64x_evm.rst
> +++ b/doc/board/ti/am64x_evm.rst
> @@ -107,7 +107,8 @@ Set the variables corresponding to this platform:
>  .. am64x_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
> +
>  In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
>  variant (GP, HS-FS, HS-SE) requires a different source for these files.
>  
> diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
> index 7cebb1ca62..4f4e1c5b7c 100644
> --- a/doc/board/ti/am65x_evm.rst
> +++ b/doc/board/ti/am65x_evm.rst
> @@ -117,7 +117,8 @@ Set the variables corresponding to this platform:
>  .. am65x_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
> +
>  In order to boot we need tiboot3.bin, sysfw.itb, tispl.bin and u-boot.img.
>  Each SoC variant (GP and HS) requires a different source for these files.
>  
> diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
> index bcf8dc1c5f..152b216888 100644
> --- a/doc/board/ti/j7200_evm.rst
> +++ b/doc/board/ti/j7200_evm.rst
> @@ -106,7 +106,8 @@ Set the variables corresponding to this platform:
>  .. j7200_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
> +
>  In order to boot we need tiboot3.bin, tispl.bin and u-boot.img. Each SoC
>  variant (GP, HS-FS, HS-SE) requires a different source for these files.
>  
> diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
> index cadaac0178..bfb7500d23 100644
> --- a/doc/board/ti/j721e_evm.rst
> +++ b/doc/board/ti/j721e_evm.rst
> @@ -111,7 +111,8 @@ Set the variables corresponding to this platform:
>  .. j721e_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
> +
>  In order to boot we need tiboot3.bin, sysfw.itb, tispl.bin and u-boot.img.
>  Each SoC variant (GP, HS-FS and HS-SE) requires a different source for these
>  files.
> diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
> index fec2acabe8..5fbe608844 100644
> --- a/doc/board/ti/j721s2_evm.rst
> +++ b/doc/board/ti/j721s2_evm.rst
> @@ -6,6 +6,7 @@ J721S2 and AM68 Platforms
>  
>  Introduction:
>  -------------
> +
>  The J721S2 family of SoCs are part of K3 Multicore SoC architecture platform
>  targeting automotive applications. They are designed as a low power, high
>  performance and highly integrated device architecture, adding significant
> @@ -38,6 +39,7 @@ Platform information:
>  
>  Boot Flow:
>  ----------
> +
>  Below is the pictorial representation of boot flow:
>  
>  .. image:: img/boot_diagram_k3_current.svg
> @@ -60,6 +62,7 @@ Sources:
>  
>  Build procedure:
>  ----------------
> +
>  0. Setup the environment variables:
>  
>  .. include::  k3.rst
> @@ -120,7 +123,8 @@ Set the variables corresponding to this platform:
>  .. j721s2_evm_rst_include_end_build_steps
>  
>  Target Images
> ---------------
> +-------------
> +
>  In order to boot we need tiboot3.bin, tispl.bin and u-boot.img. Each SoC
>  variant (GP, HS-FS, HS-SE) requires a different source for these files.
>  
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 89d70db886..1629d3bd31 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -238,7 +238,7 @@ other build sources. we shall use the following, in the build descriptions below
>  .. k3_rst_include_end_board_env_vars_desc
>  
>  Building tiboot3.bin
> -^^^^^^^^^^^^^^^^^^^^^
> +^^^^^^^^^^^^^^^^^^^^
>  
>  1. To generate the U-Boot SPL for the wakeup domain, use the following
>     commands, substituting :code:`{SOC}` for the name of your device (eg:
> @@ -273,7 +273,7 @@ domain of your K3 SoC.
>     UBoot SPL will only look for and load the files with these names.
>  
>  Building tispl.bin
> -^^^^^^^^^^^^^^^^^^^
> +^^^^^^^^^^^^^^^^^^
>  
>  The `tispl.bin` is a standard fitImage combining the firmware need for
>  the main domain to function properly as well as Device Management (DM)
> diff --git a/doc/board/xilinx/xilinx.rst b/doc/board/xilinx/xilinx.rst
> index 8c9afb482d..5464625ac1 100644
> --- a/doc/board/xilinx/xilinx.rst
> +++ b/doc/board/xilinx/xilinx.rst
> @@ -2,7 +2,7 @@
>  ..  (C) Copyright 2019 Xilinx, Inc.
>  
>  U-Boot device tree bindings
> -----------------------------
> +---------------------------
>  
>  All the device tree bindings used in U-Boot are specified in Linux
>  kernel. Please refer dt bindings from below specified paths in Linux
> diff --git a/doc/build/source.rst b/doc/build/source.rst
> index 470f793985..d21ee055f3 100644
> --- a/doc/build/source.rst
> +++ b/doc/build/source.rst
> @@ -1,5 +1,5 @@
>  Obtaining the source
> -=====================
> +====================
>  
>  The source of the U-Boot project is maintained in a Git repository.
>  
> diff --git a/doc/develop/driver-model/ethernet.rst b/doc/develop/driver-model/ethernet.rst
> index cdbccca34d..73c3a728db 100644
> --- a/doc/develop/driver-model/ethernet.rst
> +++ b/doc/develop/driver-model/ethernet.rst
> @@ -1,5 +1,5 @@
>  Ethernet Driver Guide
> -=======================
> +=====================
>  
>  The networking stack in Das U-Boot is designed for multiple network devices
>  to be easily added and controlled at runtime.  This guide is meant for people
> @@ -14,7 +14,7 @@ Some drivers are still using the old Ethernet interface, differences between
>  the two and hints about porting will be handled at the end.
>  
>  Driver framework
> -------------------
> +----------------
>  
>  A network driver following the driver model must declare itself using
>  the UCLASS_ETH .id field in the U-Boot driver struct:
> @@ -67,7 +67,7 @@ bus. Also it would take care of any special PHY setup (power rails, enable
>  bits for internal PHYs, etc.).
>  
>  Driver methods
> -----------------
> +--------------
>  
>  The real work will be done in the driver method functions the driver provides
>  by defining the members of struct eth_ops:
> @@ -158,7 +158,7 @@ So the call graph at this stage would look something like:
>  
>  
>  CONFIG_PHYLIB / CONFIG_CMD_MII
> ---------------------------------
> +------------------------------
>  
>  If your device supports banging arbitrary values on the MII bus (pretty much
>  every device does), you should add support for the mii command.  Doing so is
> @@ -193,7 +193,7 @@ should logically follow.
>  ................................................................
>  
>  Legacy network drivers
> -------------------------
> +----------------------
>  
>  !!! WARNING !!!
>  
> @@ -221,7 +221,7 @@ instructions on how to port this over. For the records, the old way of
>  initialising a network driver is as follows:
>  
>  Old network driver registration
> -~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  When U-Boot initializes, it will call the common function eth_initialize().
>  This will in turn call the board-specific board_eth_init() (or if that fails,
> diff --git a/doc/develop/driver-model/migration.rst b/doc/develop/driver-model/migration.rst
> index fe1ae210de..03fea943b2 100644
> --- a/doc/develop/driver-model/migration.rst
> +++ b/doc/develop/driver-model/migration.rst
> @@ -100,7 +100,7 @@ Maintainers should submit patches switching over to using CONFIG_DM_I2C and
>  other base driver model options in time for inclusion in the 2021.10 release.
>  
>  CFG_SYS_TIMER_RATE and CFG_SYS_TIMER_COUNTER
> ---------------------------------------------------
> +--------------------------------------------
>  Deadline: 2023.01
>  
>  These are legacy options which have been replaced by driver model.
> diff --git a/doc/develop/driver-model/nvmxip.rst b/doc/develop/driver-model/nvmxip.rst
> index e85dc220b9..4a7650c8d2 100644
> --- a/doc/develop/driver-model/nvmxip.rst
> +++ b/doc/develop/driver-model/nvmxip.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  NVM XIP Block Storage Emulation Driver
> -=======================================
> +======================================
>  
>  Summary
>  -------
> @@ -54,12 +54,12 @@ The NVMXIP Uclass provides the following drivers:
>  The implementation is generic and can be used by different platforms.
>  
>  Supported hardware
> ---------------------------------
> +------------------
>  
>  Any plaform supporting readq().
>  
>  Configuration
> -----------------------
> +-------------
>  
>  config NVMXIP
>  	  This option allows the emulation of a block storage device
> @@ -77,7 +77,7 @@ config NVMXIP_QSPI
>  	  write their own driver (same as nvmxip_qspi in addition to the custom settings).
>  
>  Device Tree nodes
> ---------------------
> +-----------------
>  
>  Multiple QSPI XIP flash devices can be used at the same time by describing them through DT
>  nodes.
> diff --git a/doc/develop/driver-model/spi-howto.rst b/doc/develop/driver-model/spi-howto.rst
> index 97fbf750cb..9dc3b9b4aa 100644
> --- a/doc/develop/driver-model/spi-howto.rst
> +++ b/doc/develop/driver-model/spi-howto.rst
> @@ -218,7 +218,7 @@ DM tells you. The name is not quite right. So in this case we would use:
>  
>  
>  Write of_to_plat() [for device tree only]
> --------------------------------------------------
> +-----------------------------------------
>  
>  This method will convert information in the device tree node into a C
>  structure in your driver (called platform data). If you are not using
> diff --git a/doc/develop/falcon.rst b/doc/develop/falcon.rst
> index 2f25fc8532..8a46c0efa1 100644
> --- a/doc/develop/falcon.rst
> +++ b/doc/develop/falcon.rst
> @@ -220,7 +220,7 @@ setting the GPIO (on twister GPIO 55 is used) to kernel mode.
>  The kernel is loaded directly by the SPL without passing through U-Boot.
>  
>  Example with FDT: a3m071 board
> --------------------------------
> +------------------------------
>  
>  To boot the Linux kernel from the SPL, the DT blob (fdt) needs to get
>  prepared/patched first. U-Boot usually inserts some dynamic values into
> diff --git a/doc/usage/cmd/askenv.rst b/doc/usage/cmd/askenv.rst
> index 347bd59458..b85ceface1 100644
> --- a/doc/usage/cmd/askenv.rst
> +++ b/doc/usage/cmd/askenv.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+:
>  
>  askenv command
> -===============
> +==============
>  
>  Synopsis
>  --------
> diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> index 6c68d0bf84..fb638b5807 100644
> --- a/doc/usage/cmd/bootdev.rst
> +++ b/doc/usage/cmd/bootdev.rst
> @@ -76,7 +76,7 @@ name is provided, all hunters are run.
>  
>  
>  bootdev select
> -~~~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~~~
>  
>  Use this to select a particular bootdev. You can select it by the sequence
>  number or name, as shown in `bootdev list`.
> @@ -89,7 +89,7 @@ unselected.
>  
>  
>  bootdev info
> -~~~~~~~~~~~~~~~
> +~~~~~~~~~~~~
>  
>  This shows information on the current bootdev, with the format looking like
>  this:
> diff --git a/doc/usage/cmd/cat.rst b/doc/usage/cmd/cat.rst
> index 5ef4731fe3..5aaf497f27 100644
> --- a/doc/usage/cmd/cat.rst
> +++ b/doc/usage/cmd/cat.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+:
>  
>  cat command
> -===============
> +===========
>  
>  Synopsis
>  --------
> diff --git a/doc/usage/cmd/coninfo.rst b/doc/usage/cmd/coninfo.rst
> index f913148c44..76cb6c3329 100644
> --- a/doc/usage/cmd/coninfo.rst
> +++ b/doc/usage/cmd/coninfo.rst
> @@ -21,7 +21,7 @@ environment variables stdin, stdout, stderr which contain a comma separated
>  list of device names.
>  
>  Example
> ---------
> +-------
>  
>  .. code-block:: console
>  
> diff --git a/doc/usage/cmd/mmc.rst b/doc/usage/cmd/mmc.rst
> index 71a0303109..c07c980fa3 100644
> --- a/doc/usage/cmd/mmc.rst
> +++ b/doc/usage/cmd/mmc.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+:
>  
>  mmc command
> -============
> +===========
>  
>  Synopsis
>  --------
> diff --git a/doc/usage/cmd/part.rst b/doc/usage/cmd/part.rst
> index 8a594aaff2..eee5225cad 100644
> --- a/doc/usage/cmd/part.rst
> +++ b/doc/usage/cmd/part.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+:
>  
>  part command
> -===============
> +============
>  
>  Synopis
>  -------
> diff --git a/doc/usage/cmd/wdt.rst b/doc/usage/cmd/wdt.rst
> index 8d80433c1f..8bb8b36178 100644
> --- a/doc/usage/cmd/wdt.rst
> +++ b/doc/usage/cmd/wdt.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+:
>  
>  wdt command
> -============
> +===========
>  
>  Synopsis
>  --------
> diff --git a/doc/usage/cmd/xxd.rst b/doc/usage/cmd/xxd.rst
> index 0de1223dce..13bb4389cc 100644
> --- a/doc/usage/cmd/xxd.rst
> +++ b/doc/usage/cmd/xxd.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+:
>  
>  xxd command
> -===============
> +===========
>  
>  Synopsis
>  --------
> diff --git a/doc/usage/fit/beaglebone_vboot.rst b/doc/usage/fit/beaglebone_vboot.rst
> index 0580ee10bd..a102be187b 100644
> --- a/doc/usage/fit/beaglebone_vboot.rst
> +++ b/doc/usage/fit/beaglebone_vboot.rst
> @@ -86,7 +86,7 @@ c. You will now have a U-Boot image::
>  
>  
>  Step 2: Build Linux
> ---------------------
> +-------------------
>  
>  a. Find the kernel image ('Image') and device tree (.dtb) file you plan to
>     use. In our case it is am335x-boneblack.dtb and it is built with the kernel.
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> index 0aad590859..9691904a9d 100644
> --- a/doc/usage/measured_boot.rst
> +++ b/doc/usage/measured_boot.rst
> @@ -1,7 +1,7 @@
>  .. SPDX-License-Identifier: GPL-2.0+
>  
>  Measured Boot
> -=====================
> +=============
>  
>  U-Boot can perform a measured boot, the process of hashing various components
>  of the boot process, extending the results in the TPM and logging the
> @@ -16,7 +16,7 @@ TPM PCRs match the contents of the event log. This can further be checked
>  against the hash results of previous boots.
>  
>  Requirements
> ----------------------
> +------------
>  
>  * A hardware TPM 2.0 supported by the U-Boot drivers
>  * CONFIG_TPM=y
> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> index e7b4e9380e..97428f68d0 100644
> --- a/tools/binman/entries.rst
> +++ b/tools/binman/entries.rst
> @@ -1,5 +1,5 @@
>  Binman Entry Documentation
> -===========================
> +==========================
>  
>  This file describes the entry types supported by binman. These entry types can
>  be placed in an image one by one to build up a final firmware image. It is
> -- 
> 2.40.1
> 
