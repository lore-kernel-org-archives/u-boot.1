Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB04E784BF
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AA286E27;
	Mon,  2 Oct 2023 17:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fM6vMJhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE8C80374; Mon,  2 Oct 2023 17:51:55 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B023E86E27
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FpgDF084085;
 Mon, 2 Oct 2023 10:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696261902;
 bh=5tOhKCTyg5fz9RXHc3sqO/rGJlZk4nlDqPNN5P5ttwk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fM6vMJhzMqk/fULBYHSkHHX8TipKvNqeSYuzyVf3Ob4siuFCBHj/8mOz7LY0VcAdM
 zt1VbeAgLsC5XLxmf5CSZCun+EXuPHYQo860lcRoY7fpTPJryYo3tNMJIf4felAY/G
 4YIevBgREueUffaCPRO0qrCyawr4Pue9Pfd4jksc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392Fpg6w126375
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:51:42 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:51:41 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:51:41 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FpfSe012370;
 Mon, 2 Oct 2023 10:51:41 -0500
Date: Mon, 2 Oct 2023 10:51:41 -0500
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
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 09/16] board: ti: j784s4: Add board support for J784S4
 EVM
Message-ID: <20231002155141.e6iw2kpdtrighpwi@headache>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-10-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-10-a-nandan@ti.com>
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

On 22:25-20231001, Apurva Nandan wrote:
> Add board files for J784S4 EVM.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> [ add env and board specific yaml files for binman ]
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> [ cleaned up the env files ]
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> ---
>  arch/arm/mach-k3/Kconfig         |    1 +
>  board/ti/j784s4/Kconfig          |   63 +
>  board/ti/j784s4/MAINTAINERS      |   22 +
>  board/ti/j784s4/Makefile         |    7 +
>  board/ti/j784s4/board-cfg.yaml   |   37 +
>  board/ti/j784s4/evm.c            |   82 +
>  board/ti/j784s4/j784s4.env       |   35 +
>  board/ti/j784s4/pm-cfg.yaml      |   13 +
>  board/ti/j784s4/rm-cfg.yaml      | 3058 ++++++++++++++++++++++++++++++
>  board/ti/j784s4/sec-cfg.yaml     |  380 ++++
>  board/ti/j784s4/tifs-rm-cfg.yaml | 2656 ++++++++++++++++++++++++++
>  include/configs/j784s4_evm.h     |   20 +

There is all kind of changes mixed in that makes this patch hard to review.

>  12 files changed, 6374 insertions(+)
>  create mode 100644 board/ti/j784s4/Kconfig
>  create mode 100644 board/ti/j784s4/MAINTAINERS
>  create mode 100644 board/ti/j784s4/Makefile
>  create mode 100644 board/ti/j784s4/board-cfg.yaml
>  create mode 100644 board/ti/j784s4/evm.c
>  create mode 100644 board/ti/j784s4/j784s4.env
>  create mode 100644 board/ti/j784s4/pm-cfg.yaml
>  create mode 100644 board/ti/j784s4/rm-cfg.yaml
>  create mode 100644 board/ti/j784s4/sec-cfg.yaml
>  create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
>  create mode 100644 include/configs/j784s4_evm.h
[...]

> new file mode 100644
> index 0000000000..025079c6a8
> --- /dev/null
> +++ b/board/ti/j784s4/evm.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Board specific initialization for J784S4 EVM
> + *
> + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> + *	Hari Nagalla <hnagalla@ti.com>
> + *
> + */
> +
> +#include <common.h>
> +#include <env.h>
> +#include <fdt_support.h>
> +#include <generic-phy.h>
> +#include <image.h>
> +#include <init.h>
> +#include <log.h>
> +#include <net.h>
> +#include <asm/arch/hardware.h>
> +#include <asm/gpio.h>
> +#include <asm/io.h>
> +#include <spl.h>
> +#include <dm.h>
> +#include <dm/uclass-internal.h>
> +
> +#include "../common/board_detect.h"
> +
> +#define board_is_j784s4_evm()	board_ti_k3_is("J784S4-EVM")
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
> +#ifdef CONFIG_PHYS_64BIT

stop using #ifdef. if (IS_ENABLED())
Checkpatch will warn you on this. you seem to have ignore it.

> +	gd->ram_size = 0x100000000;
> +#else
> +	gd->ram_size = 0x80000000;
> +#endif
> +
> +	return 0;
> +}
> +
> +phys_size_t board_get_usable_ram_top(phys_size_t total_size)
> +{
> +#ifdef CONFIG_PHYS_64BIT
> +	/* Limit RAM used by U-Boot to the DDR low region */
> +	if (gd->ram_top > 0x100000000)
> +		return 0x100000000;
> +#endif
> +
> +	return gd->ram_top;
> +}
> +
> +int dram_init_banksize(void)
> +{
> +	/* Bank 0 declares the memory available in the DDR low region */
> +	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
> +	gd->bd->bi_dram[0].size = 0x7fffffff;
> +	gd->ram_size = 0x80000000;
NAK. Use fdtdec_setup_mem_size_base fdtdec_setup_memory_banksize
And fix up accordingly.

> +
> +#ifdef CONFIG_PHYS_64BIT
> +	/* Bank 1 declares the memory available in the DDR high region */
> +	gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
> +	gd->bd->bi_dram[1].size = 0x77fffffff;
> +	gd->ram_size = 0x800000000;
> +#endif
> +
> +	return 0;
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
> diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
> new file mode 100644
> index 0000000000..74f822440e
> --- /dev/null
> +++ b/board/ti/j784s4/j784s4.env
> @@ -0,0 +1,35 @@
> +#include <env/ti/ti_armv7_common.env>
> +#include <env/ti/mmc.env>
> +#include <env/ti/ufs.env>
> +#include <env/ti/k3_dfu.env>
> +
> +#if CONFIG_CMD_REMOTEPROC
> +#include <env/ti/k3_rproc.env>
> +#endif
> +
> +default_device_tree=ti/k3-j784s4-evm.dtb
> +findfdt=
> +	setenv name_fdt ${default_device_tree};
> +	if test CONFIG_DEFAULT_DEVICE_TREE = "k3-j784s4-evm"; then
> +		setenv name_fdt ti/k3-j784s4-evm.dtb; fi;
> +	setenv fdtfile ${name_fdt}

Explained that this is a NAK.
> +name_kern=Image
> +console=ttyS2,115200n8
> +args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02880000
> +	${mtdparts}
> +run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp

ti_mmc is a boot_target in stdboot?? no, it wont work.

Also change the boot meth to mmc1 (SD), mmc0(emmc), usb pxe dhcp.

> +boot=mmc
> +mmcdev=1
> +dorprocboot=1
> +bootpart=1:2
> +bootdir=/boot
> +rd_spec=-
> +
> +rproc_fw_binaries= 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw

No clue what the above mess is.

> +
> +splashfile=ti.gz
> +splashimage=0x82000000
> +splashpos=m,m
> +splashsource=mmc

You have splash screen support?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
