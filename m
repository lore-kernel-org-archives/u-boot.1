Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B3AC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FCFE870D5;
	Thu, 30 Nov 2023 15:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NTXpA8z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6D8875FE; Thu, 30 Nov 2023 15:52:34 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A2A986F64
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AUEqJGn062597;
 Thu, 30 Nov 2023 08:52:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701355939;
 bh=EWu9yGYvUmXbUQK+dZYylOVSdaZ99y1sV1AoHGXJUWk=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=NTXpA8z1pqjfUlGQPWp/e+KYv78P0fOvmjSx1mMuoUc1AcDfTgTABofj5WS42VgxF
 K7DhUro7m8HE3ZuPQBYn4WVDeaxKr6bk0LF3hps4fH22h8jVEBFjzdHuFqIOSQMN4g
 ccwGm217xeA1Lbfj4VlqdgcWzGD6KJT2wFSszZzA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AUEqJFQ003004
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Nov 2023 08:52:19 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 08:52:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 08:52:18 -0600
Received: from [10.249.32.108] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AUEqHgc012402;
 Thu, 30 Nov 2023 08:52:17 -0600
Message-ID: <4ce67ef1-6d8f-4f3f-a8ad-23038ad2e6aa@ti.com>
Date: Thu, 30 Nov 2023 08:52:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/17] board: ti: j784s4: Add board support for J784S4
 EVM
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-10-a-nandan@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231130115552.3580995-10-a-nandan@ti.com>
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

On 11/30/23 5:55 AM, Apurva Nandan wrote:
> Add board files for J784S4 EVM.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add env and board specific yaml files for binman ]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [ cleaned up the env files ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   arch/arm/mach-k3/Kconfig        |  1 +
>   arch/arm/mach-k3/j784s4/Kconfig | 35 ++++++++++++++++++++++++++++++
>   board/ti/j784s4/Makefile        |  7 ++++++
>   board/ti/j784s4/evm.c           | 38 +++++++++++++++++++++++++++++++++
>   include/configs/j784s4_evm.h    | 20 +++++++++++++++++
>   5 files changed, 101 insertions(+)
>   create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
>   create mode 100644 board/ti/j784s4/Makefile
>   create mode 100644 board/ti/j784s4/evm.c
>   create mode 100644 include/configs/j784s4_evm.h
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 150d0bfa14..445b49e245 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -157,5 +157,6 @@ source "arch/arm/mach-k3/am62x/Kconfig"
>   source "arch/arm/mach-k3/am62ax/Kconfig"
>   source "arch/arm/mach-k3/j721e/Kconfig"
>   source "arch/arm/mach-k3/j721s2/Kconfig"
> +source "arch/arm/mach-k3/j784s4/Kconfig"
>   
>   endif
> diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
> new file mode 100644
> index 0000000000..03d3f91371
> --- /dev/null
> +++ b/arch/arm/mach-k3/j784s4/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> +#	Hari Nagalla <hnagalla@ti.com>
> +
> +if SOC_K3_J784S4
> +
> +choice
> +	prompt "K3 J784S4 board"
> +	optional
> +
> +config TARGET_J784S4_A72_EVM
> +	bool "TI K3 based J784S4 EVM running on A72"
> +	select ARM64
> +	select BOARD_LATE_INIT
> +	select SYS_DISABLE_DCACHE_OPS
> +	select BINMAN
> +
> +config TARGET_J784S4_R5_EVM
> +	bool "TI K3 based J784S4 EVM running on R5"
> +	select CPU_V7R
> +	select SYS_THUMB_BUILD
> +	select K3_LOAD_SYSFW
> +	select RAM
> +	select SPL_RAM
> +	select K3_DDRSS
> +	select BINMAN
> +	imply SYS_K3_SPL_ATF
> +
> +endchoice
> +
> +source "board/ti/j784s4/Kconfig"
> +
> +endif
> +
> diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
> new file mode 100644
> index 0000000000..3fc70eb8fb
> --- /dev/null
> +++ b/board/ti/j784s4/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> +#	Hari Nagalla <hnagalla@ti.com>
> +#
> +
> +obj-y += evm.o
> diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
> new file mode 100644
> index 0000000000..4857c9d2f6
> --- /dev/null
> +++ b/board/ti/j784s4/evm.c
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Board specific initialization for J784S4 EVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + *
> + */
> +
> +#include <image.h>
> +#include <init.h>
> +#include <spl.h>
> +
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +int dram_init(void)
> +{
> +	return fdtdec_setup_mem_size_base();
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	return fdtdec_setup_memory_banksize();
> +}
> +
> +int board_late_init(void)
> +{
> +	return 0;
> +}
> +
> +void spl_board_init(void)
> +{
> +}
> diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
> new file mode 100644
> index 0000000000..1b780134ca
> --- /dev/null
> +++ b/include/configs/j784s4_evm.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Configuration header file for K3 J784S4 EVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + */
> +
> +#ifndef __CONFIG_J784S4_EVM_H
> +#define __CONFIG_J784S4_EVM_H
> +
> +#include <linux/sizes.h>

Is this include needed?

> +
> +/* DDR Configuration */
> +#define CFG_SYS_SDRAM_BASE1		0x880000000

Do you need this? It should always be the same, no need to
make a per-SoC definition for it. I just sent out a patch
fixing the same for other K3[0].

Andrew

[0] https://lists.denx.de/pipermail/u-boot/2023-November/539024.html

> +
> +/* Now for the remaining common defines */
> +#include <configs/ti_armv7_common.h>
> +
> +#endif /* __CONFIG_J784S4_EVM_H */
