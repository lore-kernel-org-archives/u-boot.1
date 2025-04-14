Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D09CC369A2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 14:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EA208212A;
	Mon, 14 Apr 2025 16:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p03SHqIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA2F82139; Mon, 14 Apr 2025 16:03:13 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75F48211F
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 16:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EE30Ha2709492
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 09:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744639380;
 bh=gSF1W3iz2HnKFAl3frf4MD2lQOs29OTkkmfGN+ZTFtE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=p03SHqIoqYJPZ8ARV+vIgebywFVWsukqgeJ0SuSCGOcZcKfHAtHJCkvuvN7CBAlEp
 pTW1YWkTLofgrCiMfbZVzsYCWtxeEEp37j24/FZI5JbkJAwy/KjAkXuW2nVPCtKj8p
 MUdyWxLiSd6xaEATu7SnrqSiG+xQq/CKfXS/F0tY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EE301b065157
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 09:03:00 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 09:03:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 09:02:59 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EE2xGQ087307;
 Mon, 14 Apr 2025 09:02:59 -0500
Message-ID: <d988e2d0-cc25-40eb-981b-c03d96a621b1@ti.com>
Date: Mon, 14 Apr 2025 09:02:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] doc: beagle: Add BeagleY-AI documentation
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>
References: <20250411225717.3117370-1-nm@ti.com>
 <20250411225717.3117370-10-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250411225717.3117370-10-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 4/11/25 5:57 PM, Nishanth Menon wrote:
> Document the BeagleY-AI usage, build and basic debug hints
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   doc/board/beagle/am67a_beagley_ai.rst | 228 ++++++++++++++++++++++++++
>   doc/board/beagle/index.rst            |   1 +
>   doc/board/ti/k3.rst                   |   1 +
>   3 files changed, 230 insertions(+)
>   create mode 100644 doc/board/beagle/am67a_beagley_ai.rst
> 
> diff --git a/doc/board/beagle/am67a_beagley_ai.rst b/doc/board/beagle/am67a_beagley_ai.rst
> new file mode 100644
> index 000000000000..a77a4094898a
> --- /dev/null
> +++ b/doc/board/beagle/am67a_beagley_ai.rst
> @@ -0,0 +1,228 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Nishanth Menon <nm@ti.com>
> +
> +AM67A Beagleboard.org BeagleY-AI
> +================================
> +
> +Introduction:
> +-------------
> +
> +BeagleBoard.org BeagleY-AI is an easy to use, affordable open source
> +hardware single board computer based on the Texas Instruments AM67A,
> +which features a quad-core 64-bit Arm CPU subsystem, 2 general-purpose
> +digital-signal-processors (DSP) and matrix-multiply-accelerators (MMA),
> +GPU, vision and deep learning accelerators, and multiple Arm Cortex-R5
> +cores for low-power, low-latency GPIO control.
> +
> +Further information can be found at:
> +
> +* Product Page: https://beagley-ai.org/
> +* Hardware documentation: https://openbeagle.org/beagley-ai/beagley-ai
> +
> +Boot Flow:
> +----------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: ../ti/img/boot_diagram_k3_current.svg
> +  :alt: Boot flow diagram
> +
> +- On this platform, 'TI Foundational Security' (TIFS) functions as the
> +  security enclave master while 'Device Manager' (DM), also known as the
> +  'TISCI server' in "TI terminology", offers all the essential services.
> +  The A53 or R5F (Aux core) sends requests to TIFS/DM to accomplish these
> +  services, as illustrated in the diagram above.
> +
> +Sources:
> +--------
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_firmwares
> +    :end-before: .. k3_rst_include_end_tifsstub
> +
> +Build procedure:
> +----------------
> +0. Setup the environment variables:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. prompt:: bash $
> +
> +  export UBOOT_CFG_CORTEXR=am67a_beagley_ai_r5_defconfig
> +  export UBOOT_CFG_CORTEXA=am67a_beagley_ai_a53_defconfig
> +  export TFA_BOARD=lite
> +  # we dont use any extra TFA parameters
> +  unset TFA_EXTRA_ARGS
> +  export OPTEE_PLATFORM=k3-am62x
> +
> +.. include::  ../ti/j722s_evm.rst
> +    :start-after: .. j722s_evm_rst_include_start_build_steps
> +    :end-before: .. j722s_evm_rst_include_end_build_steps
> +
> +Target Images
> +-------------
> +Copy these images to an SD card and boot:
> +
> +* tiboot3-j722s-hs-fs-evm.bin from Cortex-R5 build as tiboot3.bin.
> +* tispl.bin and u-boot.img from Cortex-A build.
> +
> +Image formats
> +-------------
> +
> +- tiboot3.bin
> +
> +.. image:: ../ti/img/multi_cert_tiboot3.bin.svg
> +  :alt: tiboot3.bin image format
> +
> +- tispl.bin
> +
> +.. image:: ../ti/img/tifsstub_dm_tispl.bin.svg
> +  :alt: tispl.bin image format
> +
> +Additional hardware for U-Boot development
> +------------------------------------------
> +
> +* Serial Console is critical for U-Boot development on BeagleY-AI. See
> +  `BeagleY-AI serial console documentation
> +  <https://docs.beagleboard.org/boards/beagley/ai/02-quick-start.html#beagley-ai-headless>`_.
> +* The only onboard storage option is uSD.
> +* (optionally) JTAG is useful when working with very early stages of boot.
> +
> +Flash to uSD card or how to deal with "bricked" Board
> +-----------------------------------------------------
> +
> +The only storage option on the platform is uSD card. However, if you
> +choose to hand format your own bootable uSD card, be aware that it can
> +be difficult. The following information may be helpful, but remember
> +that it is only sometimes reliable, and partition options can cause
> +issues. These can potentially help:
> +
> +* https://git.ti.com/cgit/arago-project/tisdk-setup-scripts/tree/create-sdcard.sh

This script is a legacy nightmare and will easily break your computer if
not used correctly or if the script still works at all. Much easier way
to format and SD card for K3 is:

https://github.com/nmenon/k3-upstream-boot-build/blob/main/Makefile#L101

And that can be distilled down to just the 3 steps:

# Create image with partition table
parted --script <SD CARD DEVICE> \
	mklabel msdos \
	mkpart primary fat16 4MiB 20MiB \
	mkpart primary ext4 20MiB 100% \
	set 1 boot on \
	set 1 bls_boot off \
	set 1 lba on
# Create boot partition
	mkfs.vfat <SD CARD DEVICE>1
# Create root partition
	mkfs.ext4 <SD CARD DEVICE>2

Andrew

> +* https://elinux.org/Beagleboard:Expanding_File_System_Partition_On_A_microSD
> +
> +The simplest option is to start with a standard distribution
> +image like those in `BeagleBoard.org Distros Page
> +<https://www.beagleboard.org/distros>`_ and download a disk image for
> +BeagleY-AI. Pick a 16GB+ uSD card to be on the safer side.
> +
> +With an SD/MMC Card reader and `Balena Etcher
> +<https://etcher.balena.io/>`_, having a functional setup in minutes is
> +a trivial matter, and it works on almost all Host Operating Systems.
> +Yes Windows users, Windows Subsystem for Linux(WSL) based development
> +with U-Boot and update uSD card is practical.
> +
> +Updating U-Boot is a matter of copying the tiboot3.bin, tispl.bin and
> +u-boot.img to the "BOOT" partition of the uSD card. Remember to sync
> +and unmount (or Eject - depending on the Operating System) the uSD
> +card prior to physically removing from SD card reader.
> +
> +.. note::
> +  Great news! If the board has not been damaged physically, there's no
> +  need to worry about it being "bricked" on this platform. You only have
> +  to flash an uSD card, plug it in. This means that even if you make a
> +  mistake, you can quickly fix it and rest easy.
> +
> +  If you are frequently working with uSD cards, you might find the
> +  following useful:
> +
> +  * `USB-SD-Mux <https://www.linux-automation.com/en/products/usb-sd-mux.html>`_
> +  * `SD-Wire <https://wiki.tizen.org/SDWire>`_
> +
> +LED patterns during boot
> +------------------------
> +
> +.. list-table:: USR LED status indication in order
> +   :widths: 16 16
> +   :header-rows: 1
> +
> +   * - LED Color
> +     - Indicates
> +
> +   * - Only RED at startup
> +     - Boot failure or R5 image not started up
> +
> +   * - Steady Green
> +     - A53 U-boot has started up
> +
> +   * - Red/Orange
> +     - OS boot process has been initiated
> +
> +   * - Steady Green
> +     - OS boot process failed and drops to U-Boot shell
> +
> +.. warning ::
> +
> +  If the "red" power LED is not glowing, the system power supply is not
> +  functional. Please refer to `BeagleY-AI documentation
> +  <https://beagley-ai.org/>`_ for further information.
> +
> +A53 SPL DDR Memory Layout
> +-------------------------
> +
> +.. include::  ../ti/j722s_evm.rst
> +    :start-after: .. j722s_evm_rst_include_start_ddr_mem_layout
> +    :end-before: .. j722s_evm_rst_include_end_ddr_mem_layout
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup and debugging information.
> +
> +.. warning::
> +
> +  **OpenOCD support since**: commit 33749a7fbeb5
> +
> +  If the default package version of OpenOCD in your development
> +  environment's distribution needs to be updated, it might be necessary to
> +  build OpenOCD from the source.
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_tag_connect
> +    :end-before: .. k3_rst_include_end_openocd_connect_tag_connect
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
> +    :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
> +
> +For example, with BeagleY-AI (J722S/AM67A platform), the openocd_connect.cfg:
> +
> +.. code-block:: tcl
> +
> +  # TUMPA example:
> +  # http://www.tiaowiki.com/w/TIAO_USB_Multi_Protocol_Adapter_User's_Manual
> +  source [find interface/ftdi/tumpa.cfg]
> +
> +  transport select jtag
> +
> +  # default JTAG configuration has only SRST and no TRST
> +  reset_config srst_only srst_push_pull
> +
> +  # delay after SRST goes inactive
> +  adapter srst delay 20
> +
> +  if { ![info exists SOC] } {
> +    # Set the SoC of interest
> +    set SOC j722s
> +  }
> +
> +  source [find target/ti_k3.cfg]
> +
> +  ftdi tdo_sample_edge falling
> +
> +  # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
> +  # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
> +  adapter speed 16000
> diff --git a/doc/board/beagle/index.rst b/doc/board/beagle/index.rst
> index 9124546ebc79..e33d39fc677f 100644
> --- a/doc/board/beagle/index.rst
> +++ b/doc/board/beagle/index.rst
> @@ -11,4 +11,5 @@ ARM based boards
>      :maxdepth: 2
>   
>      am62x_beagleplay
> +   am67a_beagley_ai.rst
>      j721e_beagleboneai64
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 0deb4d768f9c..c8acbc9950f5 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -44,6 +44,7 @@ K3 Based SoCs
>   K3 SoC based boards in other sections
>   
>   * :doc:`../beagle/am62x_beagleplay`
> +* :doc:`../beagle/am67a_beagley_ai`
>   * :doc:`../beagle/j721e_beagleboneai64`
>   * :doc:`../phytec/phycore-am62x`
>   * :doc:`../phytec/phycore-am62ax`
