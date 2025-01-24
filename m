Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEC5C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CFE080B9E;
	Fri, 24 Jan 2025 16:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732414;
	bh=oVB/RdvLvI7K+SBf45QX8qzL8ru1+ZkTGGSckDfI7bo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZZ/F5FZnZ9d6wnMg3M0M4OTemmEMcMJoLgSsWk158mx0KUPROXe6+lWPVRTV6EBm5
	 6gZS+LuwoyfKF7MQzjS470PbnCDJd9pIjM8hNtqgX22YfGdvmO2tuHTw/0BJvwyQGx
	 nwwaA08r6HHuVCOnuSc/3WA1rHEEqiy7Hh1sGwsrCsYucbkenq3mN0Y+zsKMyGOH+1
	 QF7uD/MGBJeWMq73JshQS8bbhID8G1c7SN71Am7Rj3jlEnbprF67QQFTxDprAKZ8is
	 TY0PCkTIH4aPv7DGSMZ5lJunyu9Kxx+XZqM7gbEqsDrKfoyzhsM2rFGDY3fEnBmVyp
	 LzjxTi4R2IlhQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF05F80EBD; Fri, 24 Jan 2025 16:26:51 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DE7180C98
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RxaLZDep"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 74775108882E1; Fri, 24 Jan 2025 16:26:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oVB/RdvLvI7K+SBf45QX8qzL8ru1+ZkTGGSckDfI7bo=;
 b=RxaLZDep1NGPviOSFaWuLSBX3+PqJKpqEpaRmdhYGECRv97mTQxBO0Ya0qAO/jW14u0EUC
 crCk36GSfxOfVsyTRITSA5XEGVoeZvw9XVxDzBJQD1GulRGNSctylGVq7VpmJuZ40WJ0LZ
 TZYmQ8Jl6u8qOvab6qxwnX0QFnsqv+gYN1cKEkQArs4U2JLsrHcnIAJtiwF98vyVjVGnui
 qaddOH/JfhpRd4lNPJrVOTC+vvN501S9naiJAtmeRD1zW8nvAgHUW4u5JUbPMGpzQvP3Rr
 z3BQaSk89dwmz+Lj1n/Bb63PtZDa0MjfxQPgILi2kO1W887YSF0gD4LyWacxAg==
Message-ID: <f44c1b56-5e4c-4157-80c2-d340d5125d0e@denx.de>
Date: Fri, 24 Jan 2025 16:14:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/20] imx95_evk: add i.MX95 19x19 EVK board basic
 support
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-20-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 2:29 PM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> This patch adds i.MX95 19x19 EVK board basic support.
> 
> Messaging unit for EdgeLock Secure Enclave, messaging unit for System
> Manager, uSDHC for SD Card, gpio, lpuart are supported now.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  68 ++++++++++
>   arch/arm/dts/imx95-u-boot.dtsi                | 157 +++++++++++++++++++++++
>   arch/arm/mach-imx/imx9/Kconfig                |   6 +
>   arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
>   arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 +++
>   board/freescale/imx95_evk/Kconfig             |  12 ++
>   board/freescale/imx95_evk/MAINTAINERS         |   6 +
>   board/freescale/imx95_evk/Makefile            |  11 ++
>   board/freescale/imx95_evk/imx95_19x19_evk.env |  90 +++++++++++++
>   board/freescale/imx95_evk/imx95_evk.c         |  54 ++++++++
>   board/freescale/imx95_evk/spl.c               |  72 +++++++++++
>   configs/imx95_19x19_evk_defconfig             | 177 ++++++++++++++++++++++++++
>   doc/board/nxp/imx95_evk.rst                   | 114 +++++++++++++++++
>   doc/board/nxp/index.rst                       |   1 +
>   include/configs/imx95_evk.h                   |  27 ++++
>   15 files changed, 820 insertions(+)
> 
> diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> new file mode 100644
> index 0000000000000000000000000000000000000000..2902e8f711c3ef705df27ca4fc7a89d1bd7ffc71
> --- /dev/null
> +++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include "imx95-u-boot.dtsi"
> +
> +&gpio1 {
> +	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;

Why is this override here ?

> +};
> +
> +&lpuart1 {
> +	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
> +	clock-names = "ipg", "per";

Are these overrides necessary ?

[...]

> diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
> new file mode 100644
> index 0000000000000000000000000000000000000000..8d2b5dfcf07d251c77440bae44d62bff6253dfc7
> --- /dev/null
> +++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
> @@ -0,0 +1,90 @@
> +sec_boot=no
> +initrd_addr=0x93800000
> +emmc_dev=0
> +sd_dev=1
> +scriptaddr=0x93500000
> +kernel_addr_r=CONFIG_SYS_LOAD_ADDR
> +image=Image
> +splashimage=0xA0000000
> +console=ttyLP0,115200 earlycon
> +fdt_addr_r=0x93000000
> +fdt_addr=0x93000000
> +cntr_addr=0xA8000000
> +cntr_file=os_cntr_signed.bin
> +boot_fit=no
> +fdtfile=CONFIG_DEFAULT_FDT_FILE
> +bootm_size=0x10000000
> +mmcautodetect=yes
> +mmcargs=setenv bootargs console=${console} root=${mmcroot}
> +loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
> +bootscript=echo Running bootscript from mmc ...; source
> +loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
> +loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
> +loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
> +auth_os=auth_cntr ${cntr_addr}
> +boot_os=booti ${loadaddr} - ${fdt_addr_r};
> +mmcboot=echo Booting from mmc ...;

Did you consider switching to modern "bootflow"/"bootmethod" ?

[...]

> +++ b/board/freescale/imx95_evk/imx95_evk.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <env.h>
> +#include <init.h>
> +#include <asm/global_data.h>
> +#include <asm/arch-imx9/ccm_regs.h>
> +#include <asm/arch/clock.h>
> +#include <fdt_support.h>
> +#include <asm/io.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <miiphy.h>
> +#include <netdev.h>
> +#include <asm/gpio.h>
> +#include <asm/mach-imx/sys_proto.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
> +#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"

Are all these headers really needed for this trivial C file ? I think 
not, so please remove all the unnecessary ones .

> +DECLARE_GLOBAL_DATA_PTR;
> +
> +int board_early_init_f(void)
> +{
> +	/* UART1: A55, UART2: M33, UART3: M7 */
> +	init_uart_clk(0);
> +
> +	return 0;
> +}
> +
> +int board_init(void)
> +{
> +	return 0;
> +}
> +
> +int board_late_init(void)
> +{
> +#ifdef CONFIG_ENV_IS_IN_MMC
> +	board_late_mmc_env_init();

Use if (CONFIG_IS_ENABLED()) ... please fix globally .

[...]

> +++ b/include/configs/imx95_evk.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef __IMX95_EVK_H
> +#define __IMX95_EVK_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>
> +#include <asm/arch/imx-regs.h>
> +
> +#define CFG_SYS_UBOOT_BASE	\
> +	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)

Is this option really necessary ?

Try and look at CONFIG_POSITION_INDEPENDENT .

> +#define CFG_SYS_INIT_RAM_ADDR	0x90000000
> +#define CFG_SYS_INIT_RAM_SIZE	0x200000
> +
> +#define CFG_SYS_SDRAM_BASE		0x90000000
> +#define PHYS_SDRAM				0x90000000
> +/* Totally 16GB */
> +#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
> +#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
> +
> +#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
Is this watchdog config option needed ?
