Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C660EE57F6
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 10:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1805D8644E;
	Fri,  8 Sep 2023 12:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m0NYMF7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806548685B; Fri,  8 Sep 2023 07:39:39 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F3678644E
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 07:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3885dY9H128956;
 Fri, 8 Sep 2023 00:39:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694151574;
 bh=lA2Kwn5mODAklYE5otA+FzzOhH3+zJ9VmVsTx3G8pE0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=m0NYMF7VFxKWHncuGx1SbICibB0bZ3wA0p64OofIMq0qloBG+VkhYbi/xxxtXRExg
 SuC8T+1JSa5UtnJSVM3A+H24XV+8Lq81N/QWeD6tfrTzGUjJ3Le3J28HwzC6KCAq+C
 oZiLvwL2QbS1hYpBMTrspxg6CspcV8k86PQij+iw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3885dYok034334
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 00:39:34 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 00:39:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 00:39:32 -0500
Received: from [10.24.69.34] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3885dT1S003184;
 Fri, 8 Sep 2023 00:39:29 -0500
Message-ID: <30919c1d-b5bb-8fd5-5945-27de699a2c3d@ti.com>
Date: Fri, 8 Sep 2023 11:09:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 5/6] docs: board: ti: Add j721s2_evm documentation
Content-Language: en-US
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Andrew Davis <afd@ti.com>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v4-5-dc114bece5d7@ti.com>
From: Apurva Nandan <a-nandan@ti.com>
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v4-5-dc114bece5d7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 12:59:17 +0200
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


On 04/09/23 16:08, Manorit Chawdhry wrote:
> Add the documentation for J721S2-EVM and SK-AM68
>
> TRM for J721S2/AM68: https://www.ti.com/lit/pdf/spruj28
> Product Page for J721S2: https://www.ti.com/tool/J721S2XSOMXEVM
> Product Page for AM68: https://www.ti.com/tool/SK-AM68
>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   doc/board/ti/j721s2_evm.rst | 341 ++++++++++++++++++++++++++++++++++++++++++++
>   doc/board/ti/k3.rst         |   1 +
>   2 files changed, 342 insertions(+)
>
> diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
> new file mode 100644
> index 000000000000..a72a47ee8603
> --- /dev/null
> +++ b/doc/board/ti/j721s2_evm.rst
> @@ -0,0 +1,341 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Manorit Chawdhry <m-chawdhry@ti.com>
> +
> +J721S2 and AM68 Platforms
> +=========================
> +
> +Introduction:
> +-------------
> +The J721S2 family of SoCs are part of K3 Multicore SoC architecture platform
> +targeting automotive applications. They are designed as a low power, high
> +performance and highly integrated device architecture, adding significant
> +enhancement on processing power, graphics capability, video and imaging
> +processing, virtualization and coherent memory support.
> +
> +The AM68 Starter Kit/Evaluation Module (EVM) is based on the J721S2 family
> +of SoCs. They are designed for machine vision, traffic monitoring, retail
> +automation, and factory automation.
> +
> +The device is partitioned into three functional domains, each containing
> +specific processing cores and peripherals:
> +
> +1. Wake-up (WKUP) domain:
> +    * ARM Cortex-M4F processor, runs TI Foundational Security (TIFS)
> +
> +2. Microcontroller (MCU) domain:
> +    * Dual core ARM Cortex-R5F processor, runs device management
> +      and SoC early boot
> +
> +3. MAIN domain:
> +    * Dual core 64-bit ARM Cortex-A72, runs HLOS
> +
> +More info can be found in TRM: https://www.ti.com/lit/pdf/spruj28
> +
> +Platform information:
> +
> +* https://www.ti.com/tool/J721S2XSOMXEVM
> +* https://www.ti.com/tool/SK-AM68
> +
> +Boot Flow:
> +----------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: img/boot_diagram_k3_current.svg
> +
> +- On this platform, "TI Foundational Security" (TIFS) functions as the
> +  security enclave master while "Device Manager" (DM), also known as the
> +  "TISCI server" in TI terminology, offers all the essential services.
> +
> +- As illustrated in the diagram above, R5 SPL manages power and clock
> +  services independently before handing over control to "DM". The A72 or
> +  the C7x (Aux core) software components request TIFS/DM to handle
> +  security or device management services.
> +
> +Sources:
> +--------
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +Build procedure:
> +----------------
> +0. Setup the environment variables:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_desc
> +    :end-before: .. k3_rst_include_end_common_env_vars_desc
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_board_env_vars_desc
> +    :end-before: .. k3_rst_include_end_board_env_vars_desc
> +
> +Set the variables corresponding to this platform:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_common_env_vars_defn
> +    :end-before: .. k3_rst_include_end_common_env_vars_defn
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=j721s2_evm_r5_defconfig
> + $ export UBOOT_CFG_CORTEXA=j721s2_evm_a72_defconfig
> + $ export TFA_BOARD=generic
> + $ export TFA_EXTRA_ARGS="K3_USART=0x8"
> + $ # The following is not a typo, j784s4 is the OP-TEE platform for j721s2
> + $ export OPTEE_PLATFORM=k3-j784s4
> + $ export OPTEE_EXTRA_ARGS="CFG_CONSOLE_UART=0x8"
> +
> +.. j721s2_evm_rst_include_start_build_steps
> +
> +1. Trusted Firmware-A:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_tfa
> +    :end-before: .. k3_rst_include_end_build_steps_tfa
> +
> +
> +2. OP-TEE:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_optee
> +    :end-before: .. k3_rst_include_end_build_steps_optee
> +
> +3. U-Boot:
> +
> +.. _j721s2_evm_rst_u_boot_r5:
> +
> +* 3.1 R5:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +.. _j721s2_evm_rst_u_boot_a72:
> +
> +* 3.2 A72:
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +.. j721s2_evm_rst_include_end_build_steps
> +
> +Target Images
> +--------------
> +In order to boot we need tiboot3.bin, tispl.bin and u-boot.img. Each SoC
> +variant (GP, HS-FS, HS-SE) requires a different source for these files.
> +
> + - GP
> +
> +    * tiboot3-j721s2-gp-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> +    * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> +
> + - HS-FS
> +
> +    * tiboot3-j721s2-hs-fs-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> +    * tispl.bin, u-boot.img from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> +
> + - HS-SE
> +
> +    * tiboot3-j721s2-hs-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> +    * tispl.bin, u-boot.img from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> +
> +Image formats:
> +--------------
> +
> +- tiboot3.bin
> +
> +.. image:: img/multi_cert_tiboot3.bin.svg
> +
> +- tispl.bin
> +
> +.. image:: img/dm_tispl.bin.svg
> +
> +R5 Memory Map:
> +--------------
> +
> +.. list-table::
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Region
> +     - Start Address
> +     - End Address
> +
> +   * - SPL
> +     - 0x41c00000
> +     - 0x41c40000
> +
> +   * - EMPTY
> +     - 0x41c40000
> +     - 0x41c61f20
> +
> +   * - STACK
> +     - 0x41c65f20
> +     - 0x41c61f20
> +
> +   * - Global data
> +     - 0x41c65f20
> +     - 0x41c66000
> +
> +   * - Heap
> +     - 0x41c66000
> +     - 0x41c76000
> +
> +   * - BSS
> +     - 0x41c76000
> +     - 0x41c80000
> +
> +   * - DM DATA
> +     - 0x41c80000
> +     - 0x41c84130
> +
> +   * - EMPTY
> +     - 0x41c84130
> +     - 0x41cff9fc
> +
> +   * - MCU Scratchpad
> +     - 0x41cff9fc
> +     - 0x41cffbfc
> +
> +   * - ROM DATA
> +     - 0x41cffbfc
> +     - 0x41cfffff
> +
> +Switch Setting for Boot Mode
> +----------------------------
> +
> +Boot Mode pins provide means to select the boot mode and options before the
> +device is powered up. After every POR, they are the main source to populate
> +the Boot Parameter Tables.
> +
> +Boot Mode Pins for J721S2-EVM
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following table shows some common boot modes used on J721S2 platform.
> +More details can be found in the Technical Reference Manual:
> +https://www.ti.com/lit/pdf/spruj28 under the `Boot Mode Pins` section.
> +
> +.. list-table:: Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW9: 12345678
> +     - SW8: 12345678
> +
> +   * - SD
> +     - 00000000
> +     - 10000010
> +
> +   * - EMMC
> +     - 01000000
> +     - 10000000
> +
> +   * - OSPI
> +     - 01000000
> +     - 00000110
> +
> +   * - UART
> +     - 01110000
> +     - 00000000
> +
> +   * - USB DFU
> +     - 00100000
> +     - 10000000
> +
> +For SW8 and SW9, the switch state in the "ON" position = 1.
> +
> +Boot Mode Pins for SK-AM68
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following table shows some common boot modes used on AM68-SK platform.
> +More details can be found in the User Guide for AM68-SK:
> +https://www.ti.com/pdf/spruj68 under the `Bootmode Settings` section.
The above user guide link doesn't work :)
> +
> +.. list-table:: Boot Modes
> +   :widths: 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW1: 1234
> +
> +   * - SD
> +     - 0000
> +
> +   * - xSPI
> +     - 0010
> +
> +   * - UART
> +     - 1010
> +
> +   * - Ethernet
> +     - 0100
> +
> +For SW1, the switch state in the "ON" position = 1.
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup information.
> +
> +.. warning::
> +
> +  **OpenOCD support since**: v0.12.0
> +
> +  If the default package version of OpenOCD in your development
> +  environment's distribution needs to be updated, it might be necessary to
> +  build OpenOCD from the source.
> +
> +Debugging U-Boot on J721S2-EVM
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. code-block:: bash
> +
> +  openocd -f board/ti_j721s2evm.cfg
> +
> +Debugging U-Boot on SK-AM68
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_cti20
> +    :end-before: .. k3_rst_include_end_openocd_connect_cti20
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_cfg_external_intro
> +    :end-before: .. k3_rst_include_end_openocd_cfg_external_intro
> +
> +For SK-AM68, the openocd_connect.cfg is as follows:
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
> +    set SOC j721s2
> +  }
> +
> +  source [find target/ti_k3.cfg]
> +
> +  ftdi tdo_sample_edge falling
> +
> +  # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
> +  # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
> +  adapter speed 16000
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 5f9bd4dfcbe9..423d55526dc5 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -36,6 +36,7 @@ K3 Based SoCs
>      am65x_evm
>      j7200_evm
>      j721e_evm
> +   j721s2_evm
>   
>   Boot Flow Overview
>   ------------------
>
