Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE505C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 13:31:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C7DE8650D;
	Mon, 28 Aug 2023 15:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cq/XBY3n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998538651A; Mon, 28 Aug 2023 15:31:00 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFFBC86505
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SDUrl2022723;
 Mon, 28 Aug 2023 08:30:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693229453;
 bh=so6t9ZyjhY9RJjxrIJYs/don2b8BbOdoZ7JGLNHBozA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cq/XBY3nGsKnaYQ9g/JEI0VBga36mcKCs1Vr4eUW/mnEP7DiFk1RL1kjm3I5DG1pO
 wzfBx0vwJ3o3TpGaBHGVXJuPQyeTL4pO+v9c1pAW0jiTDlPOn5sjo/z9ovJDvxp2is
 DCvkryX8uhOfOFNcx/PwME6HODLmpBymscwltDYo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SDUrF8061978
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 08:30:53 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 08:30:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 08:30:52 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SDUq60083325;
 Mon, 28 Aug 2023 08:30:52 -0500
Date: Mon, 28 Aug 2023 08:30:52 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, <g@lunchbox>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 5/6] docs: ti: j721s2_evm: Create documentation from
 J7200 docs
Message-ID: <20230828133052.2b352w34oe2o7emg@backward>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v2-0-a5f141be40bc@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v2-5-a5f141be40bc@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v2-5-a5f141be40bc@ti.com>
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

i$subject: doc: board: ti: Add j721s2-evm documentation

On 16:47-20230825, Manorit Chawdhry wrote:
> The documentation is based off J7200 documentation tailored for J721S2.
> 
> TRM for J721S2: https://www.ti.com/lit/pdf/spruj28
> Product Page: https://www.ti.com/product/TDA4AL-Q1
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  doc/board/ti/j721s2_evm.rst | 263 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst         |   1 +
>  2 files changed, 264 insertions(+)
> 
> diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
> new file mode 100644
> index 000000000000..1b560eb4a60e
> --- /dev/null
> +++ b/doc/board/ti/j721s2_evm.rst
> @@ -0,0 +1,263 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Manorit Chawdhry <m-chawdhry@ti.com>
> +
> +J721S2 Platforms
> +================
> +
> +Introduction:
> +-------------
> +The J721S2 family of SoCs are part of K3 Multicore SoC architecture platform
> +targeting automotive applications. They are designed as a low power, high
> +performance and highly integrated device architecture, adding significant
> +enhancement on processing power, graphics capability, video and imaging
> +processing, virtualization and coherent memory support.
> +
> +The device is partitioned into three functional domains, each containing
> +specific processing cores and peripherals:
> +
> +1. Wake-up (WKUP) domain:
> +        * ARM Cortex-M4F processor, runs TI Foundational Security (TIFS)
> +
> +2. Microcontroller (MCU) domain:
> +        * Dual core ARM Cortex-R5F processor, runs device management
> +          and SoC early boot
> +
> +3. MAIN domain:
> +        * Dual core 64-bit ARM Cortex-A72, runs HLOS
> +
> +More info can be found in TRM: https://www.ti.com/lit/pdf/spruj28
> +
> +Platform information:
> +
> +* https://www.ti.com/tool/J721S2XSOMXEVM

How about am68-sk documentation?

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
> + $ # This is not a typo, j784s4 is the

is the .... ?

> + $ # OP-TEE platform for j721s2
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
> +        * tiboot3-j721s2-gp-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> +        * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> +
> + - HS-FS
> +
> +        * tiboot3-j721s2-hs-fs-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> +        * tispl.bin, u-boot.img from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> +
> + - HS-SE
> +
> +        * tiboot3-j721s2-hs-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> +        * tispl.bin, u-boot.img from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
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

Anything similar for A72 memory map?

> +
> +Switch Setting for Boot Mode
> +----------------------------
> +
> +Boot Mode pins provide means to select the boot mode and options before the
> +device is powered up. After every POR, they are the main source to populate
> +the Boot Parameter Tables.
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

What about AM68-SK ?

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
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. code-block:: bash
> +
> +  openocd -f board/ti_j721s2evm.cfg
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index 5f9bd4dfcbe9..423d55526dc5 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -36,6 +36,7 @@ K3 Based SoCs
>     am65x_evm
>     j7200_evm
>     j721e_evm
> +   j721s2_evm
>  
>  Boot Flow Overview
>  ------------------
> 
> -- 
> 2.41.0
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
