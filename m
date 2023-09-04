Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3E3C83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 04:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D5C98647B;
	Mon,  4 Sep 2023 06:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l6p9Z2Fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB38A8648F; Mon,  4 Sep 2023 06:55:39 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D57B854BD
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 06:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3844tXg7002454;
 Sun, 3 Sep 2023 23:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693803333;
 bh=JgZRx1Jeju9WlPOUhcQdmZWkWwielyECuBROKPX8Qb0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=l6p9Z2FvPlrln9PQFJ9d5WHJ5jroZ6M36lS0IAvj8XSDCU2IERjDgKxcV0ls3Pxgx
 a7cVpWBmmip7EJkwlZTnb1Gq9oSNil5mPDntJARlucxsjpN5UrNS8XyzO6jJQjF8q0
 aOoB88n1ZRRkHU2Q5fo70rKOci3JN5gO0L0Io590=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3844tXc9018305
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 3 Sep 2023 23:55:33 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Sep 2023 23:55:32 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Sep 2023 23:55:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3844tVPN007837;
 Sun, 3 Sep 2023 23:55:31 -0500
Date: Mon, 4 Sep 2023 10:25:30 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v3 5/6] docs: board: ti: Add j721s2_evm documentation
Message-ID: <20230904045530.nca2u44l4xk6eyql@ula0497581>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v3-0-fd6602912536@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v3-5-fd6602912536@ti.com>
 <20230901191543.yfsqny5v54csztff@disdain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230901191543.yfsqny5v54csztff@disdain>
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

Hi Nishanth,

On 14:15-20230901, Nishanth Menon wrote:
> On 12:32-20230901, Manorit Chawdhry wrote:
> > The documentation is based off J7200 documentation tailored for J721S2.
> 
> You can drop the documentation based off j7200... Just state this
> documentation is for J721S2.
> 
> > 
> > TRM for J721S2: https://www.ti.com/lit/pdf/spruj28
> > Product Page: https://www.ti.com/product/TDA4AL-Q1
> > 
> > Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  doc/board/ti/j721s2_evm.rst | 298 ++++++++++++++++++++++++++++++++++++++++++++
> >  doc/board/ti/k3.rst         |   1 +
> >  2 files changed, 299 insertions(+)
> 
> Thanks for including am68_sk documentation
> 
> > 
> > diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
> > new file mode 100644
> > index 000000000000..6b091ad37578
> > --- /dev/null
> > +++ b/doc/board/ti/j721s2_evm.rst
> > @@ -0,0 +1,298 @@
> > +.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> > +.. sectionauthor:: Manorit Chawdhry <m-chawdhry@ti.com>
> > +
> > +J721S2 and AM68 Platforms
> > +=========================
> > +
> > +Introduction:
> > +-------------
> > +The J721S2 family of SoCs are part of K3 Multicore SoC architecture platform
> > +targeting automotive applications. They are designed as a low power, high
> > +performance and highly integrated device architecture, adding significant
> > +enhancement on processing power, graphics capability, video and imaging
> > +processing, virtualization and coherent memory support.
> > +
> > +The AM68 Starter Kit/Evaluation Module (EVM) is based on the J721S2 family
> > +of SoCs. They are designed for machine vision, traffic monitoring, retail
> > +automation, and factory automation.
> > +
> > +The device is partitioned into three functional domains, each containing
> > +specific processing cores and peripherals:
> > +
> > +1. Wake-up (WKUP) domain:
> > +        * ARM Cortex-M4F processor, runs TI Foundational Security (TIFS)
> > +
> > +2. Microcontroller (MCU) domain:
> > +        * Dual core ARM Cortex-R5F processor, runs device management
> > +          and SoC early boot
> 
> Just use a single space for spacing?
> 
> > +
> > +3. MAIN domain:
> > +        * Dual core 64-bit ARM Cortex-A72, runs HLOS
> 
> just use a single space?
> 
> > +
> > +More info can be found in TRM: https://www.ti.com/lit/pdf/spruj28
> > +
> [...]
> 
> > +
> > +Target Images
> > +--------------
> > +In order to boot we need tiboot3.bin, tispl.bin and u-boot.img. Each SoC
> > +variant (GP, HS-FS, HS-SE) requires a different source for these files.
> > +
> > + - GP
> > +
> > +        * tiboot3-j721s2-gp-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> > +        * tispl.bin_unsigned, u-boot.img_unsigned from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> > +
> > + - HS-FS
> > +
> > +        * tiboot3-j721s2-hs-fs-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> > +        * tispl.bin, u-boot.img from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> > +
> > + - HS-SE
> > +
> > +        * tiboot3-j721s2-hs-evm.bin from :ref:`step 3.1 <j721s2_evm_rst_u_boot_r5>`
> > +        * tispl.bin, u-boot.img from :ref:`step 3.2 <j721s2_evm_rst_u_boot_a72>`
> 
> Use  a single space? to separate. I think we should probably clean up
> the other docs as follow on.
> 
> > +
> > +Image formats:
> > +--------------
> > +
> [...]
> 
> > +Switch Setting for Boot Mode
> > +----------------------------
> > +
> > +Boot Mode pins provide means to select the boot mode and options before the
> > +device is powered up. After every POR, they are the main source to populate
> > +the Boot Parameter Tables.
> > +
> > +Boot Mode Pins for J721S2
> 
> J721S2-EVM ?
> 
> > +^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> 
> [...]
> 
> > +
> > +For SW8 and SW9, the switch state in the "ON" position = 1.
> > +
> > +Boot Mode Pins for AM68
> 
> SK-AM68 ?
> 
> [..]
> 
> > +Debugging U-Boot
> > +----------------
> > +
> > +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> > +detailed setup information.
> > +
> > +.. warning::
> > +
> > +  **OpenOCD support since**: v0.12.0
> > +
> > +  If the default package version of OpenOCD in your development
> > +  environment's distribution needs to be updated, it might be necessary to
> > +  build OpenOCD from the source.
> > +
> > +.. include::  k3.rst
> > +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> > +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> > +
> > +To start OpenOCD and connect to the board
> > +
> > +.. code-block:: bash
> > +
> > +  openocd -f board/ti_j721s2evm.cfg
> 
> This will work for the evm, but the am68-SK doesn't seem to have XDS110
> on board.
> 
> You will need the following sections to help debug on SK-AM68:
> k3_rst_include_start_openocd_connect_cti20
> and:
> k3_rst_include_start_openocd_cfg_external_intro
> 
> and:
>   openocd_connect.cfg:
> 
> .. code-block:: tcl
> 
>   # TUMPA example:
>   # http://www.tiaowiki.com/w/TIAO_USB_Multi_Protocol_Adapter_User's_Manual
>   source [find interface/ftdi/tumpa.cfg]
> 
>   transport select jtag
> 
>   # default JTAG configuration has only SRST and no TRST
>   reset_config srst_only srst_push_pull
> 
>   # delay after SRST goes inactive
>   adapter srst delay 20
> 
>   if { ![info exists SOC] } {
>     # Set the SoC of interest
>     set SOC j721s2
>   }
> 
>   source [find target/ti_k3.cfg]
> 
>   ftdi tdo_sample_edge falling
> 
>   # Speeds for FT2232H are in multiples of 2, and 32MHz is tops
>   # max speed we seem to achieve is ~20MHz.. so we pick 16MHz
>   adapter speed 16000
> 

Will be sending a v4 with the fixes. Thanks for reviewing!

Regards,
Manorit

> > diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
> > index 5f9bd4dfcbe9..423d55526dc5 100644
> > --- a/doc/board/ti/k3.rst
> > +++ b/doc/board/ti/k3.rst
> > @@ -36,6 +36,7 @@ K3 Based SoCs
> >     am65x_evm
> >     j7200_evm
> >     j721e_evm
> > +   j721s2_evm
> >  
> >  Boot Flow Overview
> >  ------------------
> > 
> > -- 
> > 2.41.0
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
