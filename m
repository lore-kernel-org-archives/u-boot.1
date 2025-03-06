Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D04C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F11A808A2;
	Thu,  6 Mar 2025 14:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Uk+srqhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30139808A2; Thu,  6 Mar 2025 14:53:26 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A85380756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=51605bb86b=fabrice.gasnier@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526DQ11q026794;
 Thu, 6 Mar 2025 14:53:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 uK1iz0ywTK1eH5a//QDdyBfg8TkfIAeURiU1d0+j4sk=; b=Uk+srqhmniV+oe1H
 8BPhk+eQjJr0Bi1Rix6RL72hkqr3FLY7DoIbj0tx/83WJljSBfkBHCn7nGFlkUKM
 ZewydUakjC8TW92LgGkuo6S+G+hgMus3dgobSpx+Loxbi33JcQzxXO9nX3yDs2ZP
 6X8hbzzoh6bs6CdWudchEAEVQRMs93ixy6lQe9QmKPpdKV6E4HsFPG2PY7xxkmxi
 ftL5mUonLoWEjcfs3cddpmRqZve1ZxuOMPH5NqxHdDjs9g9yvbaKmcq47eka/6Xw
 pgPd9MmHeDOgYc3jK3rR4LLmbpyrP3M80p/AxdqTL0A7yjtNARH2UukqY8OweK2x
 8l/b7Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 453t83xyb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 06 Mar 2025 14:53:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7D28340044;
 Thu,  6 Mar 2025 14:51:41 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 385E5540881;
 Thu,  6 Mar 2025 14:49:16 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 14:49:16 +0100
Received: from [10.48.86.222] (10.48.86.222) by SAFDAG1NODE1.st.com
 (10.75.90.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 14:49:15 +0100
Message-ID: <bdb245a3-30ac-4467-84d1-fca76827775d@foss.st.com>
Date: Thu, 6 Mar 2025 14:49:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] pwm: stm32: add driver to support pwm with timer
To: Cheick Traore <cheick.traore@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>
References: <20250306105620.624760-1-cheick.traore@foss.st.com>
 <20250306115558.3.I6cd0bcc67440b8e8c8be0493a25de9bea8a14bf1@changeid>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20250306115558.3.I6cd0bcc67440b8e8c8be0493a25de9bea8a14bf1@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.222]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
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
> Add driver to support pwm on STM32MP1X SoCs. The PWM signal is generated
> using a multifuntion timer which provide a pwm feature. Clock rate and
> addresses are retrieved from the multifunction timer driver.
> 
> Signed-off-by: Cheick Traore <cheick.traore@foss.st.com>
> ---
> 
>  drivers/pwm/Kconfig     |   8 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stm32.c | 202 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 211 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32.c

Hi Cheick,

Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thanks,
Best Regards,
Fabrice

> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6e79868d0ef..de312656746 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -105,6 +105,14 @@ config PWM_TEGRA
>  	  32KHz clock is supported by the driver but the duty cycle is
>  	  configurable.
>  
> +config PWM_STM32
> +	bool "Enable support for STM32 PWM"
> +	depends on DM_PWM && MFD_STM32_TIMERS
> +	help
> +	  This enables PWM driver for STMicroelectronics STM32 pulse width
> +	  modulation. It uses STM32 timer devices that can have up to 4 output
> +	  channels, with complementary outputs and configurable polarity.
> +
>  config PWM_SUNXI
>  	bool "Enable support for the Allwinner Sunxi PWM"
>  	depends on DM_PWM
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index e4d10c8dc3e..76305b93bc9 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -22,5 +22,6 @@ obj-$(CONFIG_PWM_ROCKCHIP)	+= rk_pwm.o
>  obj-$(CONFIG_PWM_SANDBOX)	+= sandbox_pwm.o
>  obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
>  obj-$(CONFIG_PWM_TEGRA)		+= tegra_pwm.o
> +obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
>  obj-$(CONFIG_PWM_SUNXI)		+= sunxi_pwm.o
>  obj-$(CONFIG_PWM_TI_EHRPWM)	+= pwm-ti-ehrpwm.o
> diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
> new file mode 100644
> index 00000000000..6c47df893be
> --- /dev/null
> +++ b/drivers/pwm/pwm-stm32.c
> @@ -0,0 +1,202 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025, STMicroelectronics - All Rights Reserved
> + * Author: Cheick Traore <cheick.traore@foss.st.com>
> + *
> + * Originally based on the Linux kernel v6.10 drivers/pwm/pwm-stm32.c.
> + */
> +
> +#include <div64.h>
> +#include <dm.h>
> +#include <pwm.h>
> +#include <asm/io.h>
> +#include <asm/arch/timers.h>
> +#include <dm/device_compat.h>
> +#include <linux/time.h>
> +
> +#define CCMR_CHANNEL_SHIFT	8
> +#define CCMR_CHANNEL_MASK	0xFF
> +
> +struct stm32_pwm_priv {
> +	bool have_complementary_output;
> +	bool invert_polarity;
> +};
> +
> +static u32 active_channels(struct stm32_timers_plat *plat)
> +{
> +	return readl(plat->base + TIM_CCER) & TIM_CCER_CCXE;
> +}
> +
> +static int stm32_pwm_set_config(struct udevice *dev, uint channel,
> +				uint period_ns, uint duty_ns)
> +{
> +	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
> +	struct stm32_timers_priv *priv = dev_get_priv(dev_get_parent(dev));
> +	unsigned long long prd, div, dty;
> +	unsigned int prescaler = 0;
> +	u32 ccmr, mask, shift;
> +
> +	/*
> +	 * Period and prescaler values depends on clock rate
> +	 * First we need to find the minimal value for prescaler such that
> +	 *
> +	 *        period_ns * clkrate
> +	 *   ------------------------------ < max_arr + 1
> +	 *   NSEC_PER_SEC * (prescaler + 1)
> +	 *
> +	 * This equation is equivalent to
> +	 *
> +	 *        period_ns * clkrate
> +	 *   ---------------------------- < prescaler + 1
> +	 *   NSEC_PER_SEC * (max_arr + 1)
> +	 *
> +	 * Using integer division and knowing that the right hand side is
> +	 * integer, this is further equivalent to
> +	 *
> +	 *   (period_ns * clkrate) // (NSEC_PER_SEC * (max_arr + 1)) ≤ prescaler
> +	 */
> +
> +	div = (unsigned long long)priv->rate * period_ns;
> +	do_div(div, NSEC_PER_SEC);
> +	prd = div;
> +
> +	do_div(div, priv->max_arr + 1);
> +	prescaler = div;
> +	if (prescaler > MAX_TIM_PSC)
> +		return -EINVAL;
> +
> +	do_div(prd, prescaler + 1);
> +	if (!prd)
> +		return -EINVAL;
> +
> +	/*
> +	 * All channels share the same prescaler and counter so when two
> +	 * channels are active at the same time we can't change them
> +	 */
> +	if (active_channels(plat) & ~(1 << channel * 4)) {
> +		u32 psc, arr;
> +
> +		psc = readl(plat->base + TIM_PSC);
> +		arr = readl(plat->base + TIM_ARR);
> +		if (psc != prescaler || arr != prd - 1)
> +			return -EBUSY;
> +	}
> +
> +	writel(prescaler, plat->base + TIM_PSC);
> +	writel(prd - 1, plat->base + TIM_ARR);
> +	setbits_le32(plat->base + TIM_CR1, TIM_CR1_ARPE);
> +
> +	/* Calculate the duty cycles */
> +	dty = prd * duty_ns;
> +	do_div(dty, period_ns);
> +
> +	writel(dty, plat->base + TIM_CCRx(channel + 1));
> +
> +	/* Configure output mode */
> +	shift = (channel & 0x1) * CCMR_CHANNEL_SHIFT;
> +	ccmr = (TIM_CCMR_PE | TIM_CCMR_M1) << shift;
> +	mask = CCMR_CHANNEL_MASK << shift;
> +	if (channel < 2)
> +		clrsetbits_le32(plat->base + TIM_CCMR1, mask, ccmr);
> +	else
> +		clrsetbits_le32(plat->base + TIM_CCMR2, mask, ccmr);
> +
> +	setbits_le32(plat->base + TIM_BDTR, TIM_BDTR_MOE);
> +
> +	return 0;
> +}
> +
> +static int stm32_pwm_set_enable(struct udevice *dev, uint channel,
> +				bool enable)
> +{
> +	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
> +	struct stm32_pwm_priv *priv = dev_get_priv(dev);
> +	u32 mask;
> +
> +	/* Enable channel */
> +	mask = TIM_CCER_CC1E << (channel * 4);
> +	if (priv->have_complementary_output)
> +		mask |= TIM_CCER_CC1NE << (channel * 4);
> +
> +	if (enable) {
> +		setbits_le32(plat->base + TIM_CCER, mask);
> +		/* Make sure that registers are updated */
> +		setbits_le32(plat->base + TIM_EGR, TIM_EGR_UG);
> +		/* Enable controller */
> +		setbits_le32(plat->base + TIM_CR1, TIM_CR1_CEN);
> +	} else {
> +		clrbits_le32(plat->base + TIM_CCER, mask);
> +		/* When all channels are disabled, we can disable the controller */
> +		if (!active_channels(plat))
> +			clrbits_le32(plat->base + TIM_CR1, TIM_CR1_CEN);
> +	}
> +
> +	return 0;
> +}
> +
> +static int stm32_pwm_set_invert(struct udevice *dev, uint channel,
> +				bool polarity)
> +{
> +	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
> +	struct stm32_pwm_priv *priv = dev_get_priv(dev);
> +	u32 mask;
> +
> +	mask = TIM_CCER_CC1P << (channel * 4);
> +	if (priv->have_complementary_output)
> +		mask |= TIM_CCER_CC1NP << (channel * 4);
> +
> +	clrsetbits_le32(plat->base + TIM_CCER, mask, polarity ? mask : 0);
> +
> +	return 0;
> +}
> +
> +static void stm32_pwm_detect_complementary(struct udevice *dev)
> +{
> +	struct stm32_timers_plat *plat = dev_get_plat(dev_get_parent(dev));
> +	struct stm32_pwm_priv *priv = dev_get_priv(dev);
> +	u32 ccer;
> +
> +	/*
> +	 * If complementary bit doesn't exist writing 1 will have no
> +	 * effect so we can detect it.
> +	 */
> +	setbits_le32(plat->base + TIM_CCER, TIM_CCER_CC1NE);
> +	ccer = readl(plat->base + TIM_CCER);
> +	clrbits_le32(plat->base + TIM_CCER, TIM_CCER_CC1NE);
> +
> +	priv->have_complementary_output = (ccer != 0);
> +}
> +
> +static int stm32_pwm_probe(struct udevice *dev)
> +{
> +	struct stm32_timers_priv *timer = dev_get_priv(dev_get_parent(dev));
> +
> +	if (timer->rate > 1000000000) {
> +		dev_err(dev, "Clock freq too high (%lu)\n", timer->rate);
> +		return -EINVAL;
> +	}
> +
> +	stm32_pwm_detect_complementary(dev);
> +
> +	return 0;
> +}
> +
> +static const struct pwm_ops stm32_pwm_ops = {
> +	.set_config	= stm32_pwm_set_config,
> +	.set_enable	= stm32_pwm_set_enable,
> +	.set_invert	= stm32_pwm_set_invert,
> +};
> +
> +static const struct udevice_id stm32_pwm_ids[] = {
> +	{ .compatible = "st,stm32-pwm" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(stm32_pwm) = {
> +	.name		= "stm32_pwm",
> +	.id		= UCLASS_PWM,
> +	.of_match	= stm32_pwm_ids,
> +	.ops		= &stm32_pwm_ops,
> +	.probe          = stm32_pwm_probe,
> +	.priv_auto	= sizeof(struct stm32_pwm_priv),
> +};
