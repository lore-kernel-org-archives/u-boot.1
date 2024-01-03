Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4619C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:28:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31B0587705;
	Wed,  3 Jan 2024 18:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qtlSG/sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB76A87727; Wed,  3 Jan 2024 18:28:54 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57670876F8
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403HSgnH074764;
 Wed, 3 Jan 2024 11:28:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704302922;
 bh=t8bqE2BoeXUTALrnNz4d3OB/3A3afuXdo+f0SkKm2x0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qtlSG/sd81bjcXBbe0MZy6xNY7u9ZbF10ta0LhCZ2Vqug8x0Rm3YmNZlyrOOfqdF6
 Co6Bk24MK7RVOQpQTSZDmWnysoUMSLpJAn+2mfoddMjVO6jZyrwk6M1fucUH7F3IaY
 tokaSCw/2xqxZ+DE7ZFh7m1/yZIJQ8q021oUgTK4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403HSgLe028089
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 11:28:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 11:28:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 11:28:42 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403HSgvi097874;
 Wed, 3 Jan 2024 11:28:42 -0600
Date: Wed, 3 Jan 2024 11:28:42 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 08/17] board: ti: j784s4: Add board support for J784S4
 EVM
Message-ID: <20240103172842.qfbvrtpqvseify6r@battered>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-9-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-9-a-nandan@ti.com>
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

On 00:45-20231220, Apurva Nandan wrote:
> Add board files for J784S4 EVM.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add env and board specific yaml files for binman ]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [ cleaned up the env files ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> ---
>  arch/arm/mach-k3/Kconfig        |  1 +
>  arch/arm/mach-k3/j784s4/Kconfig | 34 +++++++++++++++++++++++++++++
>  board/ti/j784s4/Kconfig         | 37 ++++++++++++++++++++++++++++++++
>  board/ti/j784s4/Makefile        |  7 ++++++
>  board/ti/j784s4/evm.c           | 38 +++++++++++++++++++++++++++++++++
>  include/configs/j784s4_evm.h    | 15 +++++++++++++
>  6 files changed, 132 insertions(+)
>  create mode 100644 arch/arm/mach-k3/j784s4/Kconfig
>  create mode 100644 board/ti/j784s4/Kconfig
>  create mode 100644 board/ti/j784s4/Makefile
>  create mode 100644 board/ti/j784s4/evm.c
>  create mode 100644 include/configs/j784s4_evm.h
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index 150d0bfa14..445b49e245 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -157,5 +157,6 @@ source "arch/arm/mach-k3/am62x/Kconfig"
>  source "arch/arm/mach-k3/am62ax/Kconfig"
>  source "arch/arm/mach-k3/j721e/Kconfig"
>  source "arch/arm/mach-k3/j721s2/Kconfig"
> +source "arch/arm/mach-k3/j784s4/Kconfig"
>  
>  endif
> diff --git a/arch/arm/mach-k3/j784s4/Kconfig b/arch/arm/mach-k3/j784s4/Kconfig
> new file mode 100644
> index 0000000000..64ec305756
> --- /dev/null
> +++ b/arch/arm/mach-k3/j784s4/Kconfig
> @@ -0,0 +1,34 @@
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

Why disable dcache ops? I assume we do that because we are a coherent
architecture at A72 level thanks to MSMC? might be good to mention in
commit message.

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
> diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
> new file mode 100644
> index 0000000000..33d4770b2d
> --- /dev/null
> +++ b/board/ti/j784s4/Kconfig
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> +#	Hari Nagalla <hnagalla@ti.com>
> +
> +if TARGET_J784S4_A72_EVM
> +
> +config SYS_BOARD
> +       default "j784s4"
> +
> +config SYS_VENDOR
> +       default "ti"
> +
> +config SYS_CONFIG_NAME
> +       default "j784s4_evm"
> +
> +source "board/ti/common/Kconfig"
> +
> +endif
> +
> +if TARGET_J784S4_R5_EVM
> +
> +config SYS_BOARD
> +       default "j784s4"
> +
> +config SYS_VENDOR
> +       default "ti"
> +
> +config SYS_CONFIG_NAME
> +       default "j784s4_evm"
> +
> +config SPL_LDSCRIPT
> +	default "arch/arm/mach-omap2/u-boot-spl.lds"
> +
> +source "board/ti/common/Kconfig"
> +
> +endif
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

	env_set("fdtfile", fdtfile);

See board/xilinx/zynqmp/zynqmp.c With that fdtfile will be available by
default removing the need for findfdt and script mumbo jumbo.

> +}
> diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
> new file mode 100644
> index 0000000000..a4e0521198
> --- /dev/null
> +++ b/include/configs/j784s4_evm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Configuration header file for K3 J784S4 EVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/

btw, for next edition - 2023-2024 - here and elsewhere.

> + *	Hari Nagalla <hnagalla@ti.com>
> + */
> +
> +#ifndef __CONFIG_J784S4_EVM_H
> +#define __CONFIG_J784S4_EVM_H
> +
> +/* Now for the remaining common defines */
> +#include <configs/ti_armv7_common.h>
> +
> +#endif /* __CONFIG_J784S4_EVM_H */

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
