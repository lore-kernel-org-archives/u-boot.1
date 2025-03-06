Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89C1C28B23
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:19:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D9B81668;
	Thu,  6 Mar 2025 15:19:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="z1GDVVIa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30ABE814A4; Thu,  6 Mar 2025 15:19:06 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA01181273
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=5160866d43=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526CbbFr026806;
 Thu, 6 Mar 2025 15:19:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 aPAHMSfspi9rk9ZPO14zxSG2szshajOSRgoU2nYeb8o=; b=z1GDVVIa9oNU+yft
 Fi7YshVJMSDEEIElWExuP0zjM2VO/5ZiFC+a2sz8GjDDhCQW6OJRsl6a1s62V+fH
 xdjQiC62270+WoQMcuCJjG9ITalfUI7VVzAdwI9WbbG5iu+cdg/6uXdJ37pM7eLf
 u675EBvv3Z07N11BbvCYz/uI0SC28tRt4YrNCkJv7G/S45ELFb4TNSXqPp4wWYt6
 IBcWYtOXUk9Y+lPluCgtDV8qrnJT+GFHQzYYHAzcXXG97ET35waCge0ELvdLqtm0
 pOM7Ziql3XXBtOJqn4yR1GSIE7nQaYV9XUXfWaYFJVDR0iKncd0sLZv24QyRgMM0
 baErAQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 453t83y5da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 15:19:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7834B400C7;
 Thu,  6 Mar 2025 15:18:00 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8A27E52D114;
 Thu,  6 Mar 2025 15:16:58 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 15:16:57 +0100
Message-ID: <14c29f9f-a635-46ea-b2f3-fd747435cbd9@foss.st.com>
Date: Thu, 6 Mar 2025 15:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mach-stm32: add multifunction timer driver support
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250306105620.624760-1-cheick.traore@foss.st.com>
 <20250306115558.2.Iadb806237d44fb33d4a7b54da7b6a22efcd15d5f@changeid>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250306115558.2.Iadb806237d44fb33d4a7b54da7b6a22efcd15d5f@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
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



On 3/6/25 11:56, Cheick Traore wrote:
> Add support for STM32MP timer multi-function driver.
> These timers can be use as counter, trigger or pwm generator.
> This driver will be used to manage the main resources of the timer to
> provide them to the functionnalities which need these ones.
> 
> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
> ---
> 
>  arch/arm/mach-stm32mp/Kconfig               |  6 ++
>  arch/arm/mach-stm32mp/Makefile              |  1 +
>  arch/arm/mach-stm32mp/include/mach/timers.h | 55 ++++++++++++++
>  arch/arm/mach-stm32mp/timers.c              | 82 +++++++++++++++++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 arch/arm/mach-stm32mp/include/mach/timers.h
>  create mode 100644 arch/arm/mach-stm32mp/timers.c
> 
> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
> index 25663a99464..002da2e3d3b 100644
> --- a/arch/arm/mach-stm32mp/Kconfig
> +++ b/arch/arm/mach-stm32mp/Kconfig
> @@ -153,6 +153,12 @@ config CMD_STM32KEY
>  		This command is used to evaluate the secure boot on stm32mp SOC,
>  		it is deactivated by default in real products.
>  
> +config MFD_STM32_TIMERS
> +	bool "STM32 multifonction timer support"
> +	help
> +	  Select this to enable support for the multifunction timer found on
> +	  STM32 devices.
> +
>  source "arch/arm/mach-stm32mp/Kconfig.13x"
>  source "arch/arm/mach-stm32mp/Kconfig.15x"
>  source "arch/arm/mach-stm32mp/Kconfig.25x"
> diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
> index db7ed19bd91..103e3410ad9 100644
> --- a/arch/arm/mach-stm32mp/Makefile
> +++ b/arch/arm/mach-stm32mp/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_STM32MP15X) += stm32mp1/
>  obj-$(CONFIG_STM32MP13X) += stm32mp1/
>  obj-$(CONFIG_STM32MP25X) += stm32mp2/
>  
> +obj-$(CONFIG_MFD_STM32_TIMERS) += timers.o
>  obj-$(CONFIG_STM32_ECDSA_VERIFY) += ecdsa_romapi.o
>  ifndef CONFIG_XPL_BUILD
>  obj-y += cmd_stm32prog/
> diff --git a/arch/arm/mach-stm32mp/include/mach/timers.h b/arch/arm/mach-stm32mp/include/mach/timers.h
> new file mode 100644
> index 00000000000..a84465bb28e
> --- /dev/null
> +++ b/arch/arm/mach-stm32mp/include/mach/timers.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
> + * Author: Cheick Traore <cheick.traore@foss.st.com>
> + *
> + * Originally based on the Linux kernel v6.1 include/linux/mfd/stm32-timers.h.
> + */
> +
> +#ifndef __STM32_TIMERS_H
> +#define __STM32_TIMERS_H
> +
> +#include <clk.h>
> +
> +#define TIM_CR1		0x00	/* Control Register 1      */
> +#define TIM_CR2		0x04	/* Control Register 2      */
> +#define TIM_SMCR	0x08	/* Slave mode control reg  */
> +#define TIM_DIER	0x0C	/* DMA/interrupt register  */
> +#define TIM_SR		0x10	/* Status register	   */
> +#define TIM_EGR		0x14	/* Event Generation Reg    */
> +#define TIM_CCMR1	0x18	/* Capt/Comp 1 Mode Reg    */
> +#define TIM_CCMR2	0x1C	/* Capt/Comp 2 Mode Reg    */
> +#define TIM_CCER	0x20	/* Capt/Comp Enable Reg    */
> +#define TIM_CNT		0x24	/* Counter		   */
> +#define TIM_PSC		0x28	/* Prescaler               */
> +#define TIM_ARR		0x2c	/* Auto-Reload Register    */
> +#define TIM_CCRx(x)	(0x34 + 4 * ((x) - 1))	/* Capt/Comp Register x (x ∈ {1, .. 4})	*/
> +#define TIM_BDTR	0x44	/* Break and Dead-Time Reg */
> +#define TIM_DCR		0x48	/* DMA control register    */
> +#define TIM_DMAR	0x4C	/* DMA register for transfer */
> +#define TIM_TISEL	0x68	/* Input Selection         */
> +
> +#define TIM_CR1_CEN	BIT(0)	/* Counter Enable	   */
> +#define TIM_CR1_ARPE	BIT(7)
> +#define TIM_CCER_CCXE	(BIT(0) | BIT(4) | BIT(8) | BIT(12))
> +#define TIM_CCER_CC1E	BIT(0)
> +#define TIM_CCER_CC1P	BIT(1)	/* Capt/Comp 1  Polarity   */
> +#define TIM_CCER_CC1NE	BIT(2)	/* Capt/Comp 1N out Ena    */
> +#define TIM_CCER_CC1NP	BIT(3)	/* Capt/Comp 1N Polarity   */
> +#define TIM_CCMR_PE	BIT(3)	/* Channel Preload Enable  */
> +#define TIM_CCMR_M1	(BIT(6) | BIT(5))  /* Channel PWM Mode 1 */
> +#define TIM_BDTR_MOE	BIT(15)	/* Main Output Enable      */
> +#define TIM_EGR_UG	BIT(0)	/* Update Generation       */
> +
> +#define MAX_TIM_PSC		0xFFFF
> +
> +struct stm32_timers_plat {
> +	void __iomem *base;
> +};
> +
> +struct stm32_timers_priv {
> +	u32 max_arr;
> +	ulong rate;
> +};
> +
> +#endif
> diff --git a/arch/arm/mach-stm32mp/timers.c b/arch/arm/mach-stm32mp/timers.c
> new file mode 100644
> index 00000000000..a3207895f40
> --- /dev/null
> +++ b/arch/arm/mach-stm32mp/timers.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
> + * Author: Cheick Traore <cheick.traore@foss.st.com>
> + *
> + * Originally based on the Linux kernel v6.1 drivers/mfd/stm32-timers.c.
> + */
> +
> +#include <dm.h>
> +#include <asm/io.h>
> +#include <asm/arch/timers.h>
> +#include <dm/device_compat.h>
> +
> +static void stm32_timers_get_arr_size(struct udevice *dev)
> +{
> +	struct stm32_timers_plat *plat = dev_get_plat(dev);
> +	struct stm32_timers_priv *priv = dev_get_priv(dev);
> +	u32 arr;
> +
> +	/* Backup ARR to restore it after getting the maximum value */
> +	arr = readl(plat->base + TIM_ARR);
> +
> +	/*
> +	 * Only the available bits will be written so when readback
> +	 * we get the maximum value of auto reload register
> +	 */
> +	writel(~0L, plat->base + TIM_ARR);
> +	priv->max_arr = readl(plat->base + TIM_ARR);
> +	writel(arr, plat->base + TIM_ARR);
> +}
> +
> +static int stm32_timers_of_to_plat(struct udevice *dev)
> +{
> +	struct stm32_timers_plat *plat = dev_get_plat(dev);
> +
> +	plat->base = dev_read_addr_ptr(dev);
> +	if (!plat->base) {
> +		dev_err(dev, "can't get address\n");
> +		return -ENOENT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_timers_probe(struct udevice *dev)
> +{
> +	struct stm32_timers_priv *priv = dev_get_priv(dev);
> +	struct clk clk;
> +	int ret = 0;
> +
> +	ret = clk_get_by_index(dev, 0, &clk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_enable(&clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock: ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	priv->rate = clk_get_rate(&clk);
> +
> +	stm32_timers_get_arr_size(dev);
> +
> +	return ret;
> +}
> +
> +static const struct udevice_id stm32_timers_ids[] = {
> +	{ .compatible = "st,stm32-timers" },
> +	{}
> +};
> +
> +U_BOOT_DRIVER(stm32_timers) = {
> +	.name  = "stm32_timers",
> +	.id = UCLASS_NOP,
> +	.of_match = stm32_timers_ids,
> +	.of_to_plat = stm32_timers_of_to_plat,
> +	.plat_auto = sizeof(struct stm32_timers_plat),
> +	.probe = stm32_timers_probe,
> +	.priv_auto = sizeof(struct stm32_timers_priv),
> +	.bind = dm_scan_fdt_dev,
> +};


Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
