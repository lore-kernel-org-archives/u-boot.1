Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE81C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 15:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC938846EE;
	Wed, 16 Aug 2023 17:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="f6O4Wbpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921EE869D6; Wed, 16 Aug 2023 17:35:12 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EBA580DF7
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 17:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37GFZ3id116901;
 Wed, 16 Aug 2023 10:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692200103;
 bh=HLd47dUPt3fl09tXT75mPEsopih4xTk9BxknkukZmM8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=f6O4Wbpd0DjfibD0wyP4YCdgDB5m+gQemLvN95j2G1zLTOdQfdwCyEpUzOY3I7qef
 hBcVSzbjJMEWc8QAoGqQC5bnyYpPUcwMJHiUnggyF1XT2uN04APdzpCH8YBEAnJnwT
 fGZ5OkOLIdYkYKmfOPKVOn29ltEm5/Qp77kEVB+Y=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37GFZ3gS025995
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Aug 2023 10:35:03 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Aug 2023 10:35:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Aug 2023 10:35:03 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37GFZ3ue023675;
 Wed, 16 Aug 2023 10:35:03 -0500
Date: Wed, 16 Aug 2023 10:35:03 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 3/3] docs: ti: j721s2_evm: Create documentation from
 J7200 docs
Message-ID: <20230816153503.up6ercmspho3oop6@jigsaw>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v1-0-f4548452760a@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v1-3-f4548452760a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v1-3-f4548452760a@ti.com>
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

On 14:53-20230816, Manorit Chawdhry wrote:
> The documentation is based off J7200 documentation tailored for J721S2.
> 
> TRM for J721S2: https://www.ti.com/lit/pdf/spruj28
> Product Page: https://www.ti.com/product/TDA4AL-Q1
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  MAINTAINERS                 |   1 +
>  doc/board/ti/j721s2_evm.rst | 228 ++++++++++++++++++++++++++++++++++++++++++++
>  doc/board/ti/k3.rst         |   1 +
>  3 files changed, 230 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 77a8b0ac2181..1b14ce541e91 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -667,6 +667,7 @@ F:	arch/arm/mach-omap2/
>  F:	arch/arm/include/asm/arch-omap*/
>  F:	arch/arm/include/asm/ti-common/
>  F:	board/ti/
> +F:	doc/board/ti
>  F:	drivers/dma/ti*
>  F:	drivers/firmware/ti_sci.*
>  F:	drivers/gpio/omap_gpio.c

if this is a proposal, split this into it's own patch please.
doc/board/ti is a wide range. I'd suggest do the specific
documentation in the board specific MAINTAINER file as well to spread
the maintainership load over.


> diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
> new file mode 100644
> index 000000000000..519e43610dcf
> --- /dev/null
> +++ b/doc/board/ti/j721s2_evm.rst
> @@ -0,0 +1,228 @@
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
> +        * Device Management and Security Controller (DMSC)
> +
> +2. Microcontroller (MCU) domain:
> +        * Dual Core ARM Cortex-R5F processor
> +
> +3. MAIN domain:
> +        * Dual core 64-bit ARM Cortex-A72
> +
> +More info can be found in TRM: https://www.ti.com/lit/pdf/spruj28
> +
> +Platform information:
> +
> +* https://www.ti.com/tool/J721S2XSOMXEVM
> +
> +Boot Flow:
> +----------
> +Below is the pictorial representation of boot flow:
> +
> +.. image:: img/boot_diagram_k3_current.svg
> +
> +- Here DMSC acts as master and provides all the critical services. R5/A72
> +  requests DMSC to get these services done as shown in the above diagram.

Is this statement accurate? in J7200, DMSC provides a pure TIFS function.

Maybe improve it with a version of the following, perhaps?

On this platform, 'TI Foundational Security' (TIFS) functions as the
security enclave master while 'Device Manager' (DM), also known as the
'TISCI server' in "TI terminology," offers all the essential services.
As illustrated in the diagram above, R5 SPL manages power and clock
services independently before handing over control to "DM." The A53 or
the M4F (Aux core) software components request TIFS/DM to handle
security or device management services.

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
> +* 4.1 R5:

4.1 or 3.1 ?

> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 4.2 A72:

same.
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
> +        * tiboot3-j721s2-gp-evm.bin from step 4.1

I think we should just use https://docs.readthedocs.io/en/stable/guides/cross-referencing-with-sphinx.html#explicit-targets
to do provide references than numbered scheme.


> +        * tispl.bin_unsigned, u-boot.img_unsigned from step 4.2
> +
> + - HS-FS
> +
> +        * tiboot3-j721s2-hs-fs-evm.bin from step 4.1
> +        * tispl.bin, u-boot.img from step 4.2

These as well

> +
> + - HS-SE
> +
> +        * tiboot3-j721s2-hs-evm.bin from step 4.1
> +        * tispl.bin, u-boot.img from step 4.2

and here.

I just noticed we have a similar problem in other rst files as well.
might be worth a cleanup.

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

We need to add the section on openOCD, but I think next does'nt have
the commit for the same - so we might need to do that as a separate
patch.

> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index d2f86b0a11a7..b0be048edb12 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -35,6 +35,7 @@ K3 Based SoCs
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
