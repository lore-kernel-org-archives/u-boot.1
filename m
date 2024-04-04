Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20729CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 15:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D1088261;
	Thu,  4 Apr 2024 17:49:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UdpIruBz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E776488001; Thu,  4 Apr 2024 17:49:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E4C88382
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 17:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434FnOli101920;
 Thu, 4 Apr 2024 10:49:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712245764;
 bh=+YN2o4Fjdz6nrSLkeOqMDDzZcGLrWNoQOZh/bp3Q+oI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=UdpIruBzZgsfRfYPD3E/BSr9p4jwSJqmAHxBbgn7zfjJ03qqpeRMRNivHlCHJxiT5
 jyiseJwaMoAp5r4kkJcBVVp8zjz0DwD2DEoJSupQ3FoTO3JCTlCDIiqIWOlVyzE/j/
 B1OAek+GdrQVdEt1YgVrd1non4Rz43OXy5DFnksM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434FnO4H049589
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 10:49:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 10:49:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 10:49:24 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434FnNpR044778;
 Thu, 4 Apr 2024 10:49:23 -0500
Message-ID: <ac5780c5-f1ca-4138-a027-d3ed65911733@ti.com>
Date: Thu, 4 Apr 2024 10:49:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/15] doc: board: ti: Add J722S-EVM documentation
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>,
 <r-gunasekaran@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
 <20240404090039.87458-16-j-choudhary@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240404090039.87458-16-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/4/24 4:00 AM, Jayesh Choudhary wrote:
> Introduce basic documentation for the J722S-EVM.
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   doc/board/ti/j722s_evm.rst | 262 +++++++++++++++++++++++++++++++++++++
>   doc/board/ti/k3.rst        |   1 +
>   2 files changed, 263 insertions(+)
>   create mode 100644 doc/board/ti/j722s_evm.rst
> 
> diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
> new file mode 100644
> index 0000000000..150330f637
> --- /dev/null
> +++ b/doc/board/ti/j722s_evm.rst
> @@ -0,0 +1,262 @@
> +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +.. sectionauthor:: Jayesh Choudhary <j-choudhary@ti.com>
> +
> +J722S-EVM Platform
> +==================
> +
> +The J722S is a family of  application processors built for Automotive and
> +Linux Application development. J722S family of SoCs is a superset of the
> +AM62P SoC family and shares similar memory map, thus the nodes are being
> +reused from AM62P includes instead of duplicating the definitions.
> +
> +Some highlights of J722S SoC (in addition to AM62P SoC features) are:
> +
> +* Two Cortex-R5F for Functional Safety or general-purpose usage and
> +  two C7x floating point vector DSP with Matrix Multiply Accelerator
> +  for deep learning.
> +
> +* Vision Processing Accelerator (VPAC) with image signal processor
> +  and Depth and Motion Processing Accelerator (DMPAC).
> +
> +* 7xUARTs, 3xSPI, 5xI2C, 2xUSB2, 2xCAN-FD, 3xMMC and SD, GPMC for
> +  NAND/FPGA connection, OSPI memory controller, 5xMcASP for audio,
> +  4xCSI-RX for Camera, 1 PCIe Gen3 controller, USB3.0 eCAP/eQEP,
> +  ePWM, among other peripherals.
> +
> +For those interested, more details about this SoC can be found in the
> +Technical Reference Manual here: https://www.ti.com/lit/zip/sprujb3
> +
> +Boot Flow:
> +----------
> +
> +The bootflow is exactly the same as all SoCs in the am62xxx extended SoC
> +family. Below is the pictorial representation:
> +
> +.. image:: img/boot_diagram_k3_current.svg
> +  :alt: Boot flow diagram
> +
> +- Here TIFS acts as master and provides all the critical services. R5/A53
> +  requests TIFS to get these services done as shown in the above diagram.
> +
> +Sources:
> +--------
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_boot_sources
> +    :end-before: .. k3_rst_include_end_boot_sources
> +
> +Build procedure:
> +----------------
> +
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
> +
> +.. code-block:: bash
> +
> + $ export UBOOT_CFG_CORTEXR=j722s_evm_r5_defconfig
> + $ export UBOOT_CFG_CORTEXA=j722s_evm_a53_defconfig
> + $ export TFA_BOARD=lite
> + $ # we dont use any extra TFA parameters
> + $ unset TFA_EXTRA_ARGS

Why unset, who is setting in the first place?

> + $ export OPTEE_PLATFORM=k3-am62x

None of the addresses OPTEE cares about changed from AM62?

> + $ export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"

Do you still need this, the HW RNG should work now.

Andrew

> +
> +.. j722s_evm_rst_include_start_build_steps
> +
> +1. Trusted Firmware-A:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_tfa
> +    :end-before: .. k3_rst_include_end_build_steps_tfa
> +
> +
> +2. OP-TEE:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_optee
> +    :end-before: .. k3_rst_include_end_build_steps_optee
> +
> +3. U-Boot:
> +
> +* 3.1 R5:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_spl_r5
> +    :end-before: .. k3_rst_include_end_build_steps_spl_r5
> +
> +* 3.2 A53:
> +
> +.. include::  ../ti/k3.rst
> +    :start-after: .. k3_rst_include_start_build_steps_uboot
> +    :end-before: .. k3_rst_include_end_build_steps_uboot
> +.. j722s_evm_rst_include_end_build_steps
> +
> +Target Images
> +--------------
> +
> +In order to boot we need tiboot3.bin, tispl.bin and u-boot.img.  Each SoC
> +variant (HS-FS, HS-SE) requires a different source for these files.
> +
> + - HS-FS
> +
> +        * tiboot3-j722s-hs-fs-evm.bin from step 3.1
> +        * tispl.bin, u-boot.img from step 3.2
> +
> + - HS-SE
> +
> +        * tiboot3-j722s-hs-evm.bin from step 3.1
> +        * tispl.bin, u-boot.img from step 3.2
> +
> +Image formats:
> +--------------
> +
> +- tiboot3.bin
> +
> +.. image:: img/multi_cert_tiboot3.bin.svg
> +  :alt: tiboot3.bin image format
> +
> +- tispl.bin
> +
> +.. image:: img/dm_tispl.bin.svg
> +  :alt: tispl.bin image format
> +
> +A53 SPL DDR Memory Layout
> +-------------------------
> +
> +.. j722s_evm_rst_include_start_ddr_mem_layout
> +
> +This provides an overview memory usage in A53 SPL stage.
> +
> +.. list-table::
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Region
> +     - Start Address
> +     - End Address
> +
> +   * - EMPTY
> +     - 0x80000000
> +     - 0x80080000
> +
> +   * - TEXT BASE
> +     - 0x80080000
> +     - 0x800d8000
> +
> +   * - EMPTY
> +     - 0x800d8000
> +     - 0x80477660
> +
> +   * - STACK
> +     - 0x80477660
> +     - 0x80477e60
> +
> +   * - GD
> +     - 0x80477e60
> +     - 0x80478000
> +
> +   * - MALLOC
> +     - 0x80478000
> +     - 0x80480000
> +
> +   * - EMPTY
> +     - 0x80480000
> +     - 0x80a00000
> +
> +   * - BSS
> +     - 0x80a00000
> +     - 0x80a80000
> +
> +   * - BLOBS
> +     - 0x80a80000
> +     - 0x80d00400
> +
> +   * - EMPTY
> +     - 0x80d00400
> +     - 0x81000000
> +.. j722s_evm_rst_include_end_ddr_mem_layout
> +
> +Switch Setting for Boot Mode
> +----------------------------
> +
> +Boot Mode pins provide means to select the boot mode and options before the
> +device is powered up. After every POR, they are the main source to populate
> +the Boot Parameter Tables.
> +
> +The following table shows some common boot modes used on J722S-EVM
> +platform. More details can be found in the Technical Reference Manual:
> +https://www.ti.com/lit/zip/sprujb3 under the `Boot Mode Pins` section.
> +
> +.. note::
> +
> +   This device is very new. Currently only UART boot is available while
> +   we continue to add support for the other bootmodes.
> +
> +.. list-table:: Boot Modes
> +   :widths: 16 16 16
> +   :header-rows: 1
> +
> +   * - Switch Label
> +     - SW3: 12345678
> +     - SW4: 12345678
> +
> +   * - SD
> +     - 11000010
> +     - 01000000
> +
> +   * - OSPI
> +     - 11001110
> +     - 00000000
> +
> +   * - EMMC
> +     - 11010010
> +     - 00000000
> +
> +   * - UART
> +     - 11011100
> +     - 00000000
> +
> +   * - USB DFU
> +     - 11001010
> +     - 00000000
> +
> +For SW2 and SW1, the switch state in the "ON" position = 1.
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup information.
> +
> +.. warning::
> +
> +  **OpenOCD support after**: v0.12.0
> +
> +  While support for the entire K3 generation including the am62xxx
> +  extended family was added before v0.12.0, the tcl scripts for the
> +  am62px have been accepted and will be available in the next release of
> +  OpenOCD. It may be necessary to build OpenOCD from source depending on
> +  the version your distribution has packaged.
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. code-block:: bash
> +
> +  openocd -f board/ti_j722sevm.cfg
> diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> index a1c01d1cf0..eba0f0e3e4 100644
> --- a/doc/board/ti/k3.rst
> +++ b/doc/board/ti/k3.rst
> @@ -42,6 +42,7 @@ K3 Based SoCs
>      ../beagle/j721e_beagleboneai64
>      j721e_evm
>      j721s2_evm
> +   j722s_evm
>      j784s4_evm
>   
>   Boot Flow Overview
