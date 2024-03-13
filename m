Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28524C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 17:12:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7165D87EA8;
	Wed, 13 Mar 2024 18:12:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B6EPKLBy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38BAF8709C; Wed, 13 Mar 2024 18:12:45 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 726EF87ED8
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 18:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33e94c12cfaso994524f8f.3
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710349960; x=1710954760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d6n4o5BqZv/6P9AjvJ6taCXTvFGOj1Rh3BQ2i3HOeTg=;
 b=B6EPKLByJw4Yyd6AbY694V+KShOA6yjWBl5Ca2VAh1Avw/vJFPh3a8SPOPFasYvU6t
 nhlNMC7EOzSdVAdqDsiPK7ua5kgDI/ZnwYB+5vWQc6k5ItJnnQkj1voY5EYi5CEBM3PB
 yxhcDqbq0PQ8OIadzqLS5+WrDF+EXfK2eG4RCgpEy6Q5rhNJYKX73Yu3j2lCreBpz29b
 662Q5Mx9jHOO/ioY3elX7Bmbo6tRaS5cZfcUyOochiClFklGBw3hvY80F3Ge5xQZXPAs
 vy5AYJArbS80xaffdDGxJfh80zvva19OTvegJnGrO9z5zTnTMqHzo4N0wU/H8EXnebbK
 vEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710349960; x=1710954760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6n4o5BqZv/6P9AjvJ6taCXTvFGOj1Rh3BQ2i3HOeTg=;
 b=KFUV03u04g5IlOjtm6i2C5mNZ/IstfC8YAc8m3u81FJ0EL7Wi4pkMCZWUVBabbhwAd
 UvYsmQ2wSbDBgAHn6jtJ/8Owyyj6GxYaA1dI7D3lXZjeHCARr+7sK9drpD6PmIx6vdcK
 CxvINbPQLYhV/hX7CR8/72k7qj0nYj4FirXNqEEc6OAtdGpPdLLjPoQDEOrw4Bmgr+7I
 K7Qe1qDSMHXSeKRHv51Rhf19Xs+EGVJsRK4lWhVP6ALc3qMD/7nWWgue6yCby+pDNy1a
 aVM/jNgVQajA8KDlbn90nL5vtJ4DcR6HBwXxD95+t9zSiqEkDttRrEnalE+iLg6ie2qK
 G77g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFiBfxosX1iARCN19IZmL4EMDtU+vk6qzwMO2XMbHx0Xpzwrr8s+NuG7v4ndxwvbofxEPlBM26lhG1UipRL5g1JUKdDA==
X-Gm-Message-State: AOJu0Yw66GOSLK3A9HJ7dHgaqbUVIX9rjpqpCmKfBnKxDdBa8bnOGpgy
 gMjFuF227iERdouhIEVvKWoarmn4YeYu3EoW+sjiL4ZEeRnqUcXnUV3Yem7S3XQ=
X-Google-Smtp-Source: AGHT+IHPtw+TthLvw4Oe6NPfaXy7w07PcBECMqojSftgtFOfqPmnjgjXSGE8Er+j9osmMUDdMpyxDQ==
X-Received: by 2002:a05:6000:102:b0:33e:c0c5:1795 with SMTP id
 o2-20020a056000010200b0033ec0c51795mr444217wrx.54.1710349959778; 
 Wed, 13 Mar 2024 10:12:39 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 df10-20020a5d5b8a000000b0033de10c9efcsm646920wrb.114.2024.03.13.10.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 10:12:39 -0700 (PDT)
Message-ID: <e0fb5308-bd89-47b1-927f-aa76e4a87bab@linaro.org>
Date: Wed, 13 Mar 2024 17:12:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] clk: qcom: add support for power domains uclass
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
 <20240311213334.3567389-4-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240311213334.3567389-4-volodymyr_babchuk@epam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Volodymyr,

On 11/03/2024 21:33, Volodymyr Babchuk wrote:
> Now sub-drivers for particular SoCs can register them as power domain
> drivers. This is needed for upcoming SM8150 support, because it needs
> to power up the Ethernet module.
> 
Thanks again for working on this.

I've been trying to rework my SDM845 USB support patches based on this,
and I've run into quite a few issues with CONFIG_POWER_DOMAIN.

Basically, it boils down to the RPM(h)PD, with no driver a bunch of
stuff breaks (including UART). I tried writing a no-op PD driver for it
but this didn't seem to work super well, and wouldn't scale (every soc
has it's own rpm(h)pd compatible).

In the end, I think supporting CONFIG_POWER_DOMAIN is the right approach
here. I have been able to get things working by leveraging OF_LIVE and
modifying the livetree during boot, similarly to how I plan to do for
USB. See [1].

Even with this, all the drivers we probe pre-relocation (like UART) need
the DM_FLAG_DEFAULT_PD_CTRL_OFF flag if they reference the RPM(h)PD, as
the of_fixup stuff doesn't happen until after relocation. I have a patch
which fixes that for sdm845 here [2].

I'll test this on the other boards and then re-send my USB patches
(including the two below) rebased on your series.

I'm a little worried this might come back to bite us later, but I think
by then it'll be worth trying to find a way to have U-Boot handle these
"safe to ignore" devices directly.

[1]:
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8af7731445721adab2206839d6df2d0f4f5f32d9
[2]:
https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/33b094103fb7e856cff6c08345a16ef8231ffaea
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> Caleb suggested to use "imply POWER_DOMAIN", not "depends
> POWER_DOMAIN" in the Kconfig, but this does not work:
> $ make CROSS_COMPILE=aarch64-linux-gnu- ARCH=arm
> scripts/kconfig/conf  --syncconfig Kconfig
> drivers/clk/Kconfig:3:error: recursive dependency detected!
> drivers/clk/Kconfig:3:  symbol CLK is selected by IMX8M_POWER_DOMAIN
> drivers/power/domain/Kconfig:35:        symbol IMX8M_POWER_DOMAIN depends on POWER_DOMAIN
> drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is implied by CLK_QCOM
> drivers/clk/qcom/Kconfig:3:     symbol CLK_QCOM depends on CLK
> For a resolution refer to Documentation/kbuild/kconfig-language.txt
> subsection "Kconfig recursive dependency limitations"
> 
> 
> Changes in v3:
>  - Added "depends POWER_DOMAIN" to Kconfig (see note)
>  - Use readl_poll_timeout() instead of open coded wait loop
>  - Print warning if power domain can't be enabled/disabled
> 
> Changes in v2:
>  - Reworked qcom_cc_bind() function
>  - Added timeout to qcom_power_set()
>  - Minor fixes in register names and formatting
> 
>  drivers/clk/qcom/Kconfig      |   2 +-
>  drivers/clk/qcom/clock-qcom.c | 132 ++++++++++++++++++++++++++++++----
>  drivers/clk/qcom/clock-qcom.h |   6 ++
>  3 files changed, 126 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 0df0d1881a..8dae635ac2 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -2,7 +2,7 @@ if ARCH_SNAPDRAGON || ARCH_IPQ40XX
>  
>  config CLK_QCOM
>  	bool
> -	depends on CLK && DM_RESET
> +	depends on CLK && DM_RESET && POWER_DOMAIN
>  	def_bool n
>  
>  menu "Qualcomm clock drivers"
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 729d190c54..7a5938a06a 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -22,7 +22,9 @@
>  #include <linux/bug.h>
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
> +#include <linux/iopoll.h>
>  #include <reset-uclass.h>
> +#include <power-domain-uclass.h>
>  
>  #include "clock-qcom.h"
>  
> @@ -30,6 +32,13 @@
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
>  #define CBCR_BRANCH_OFF_BIT     BIT(31)
>  
> +#define GDSC_SW_COLLAPSE_MASK		BIT(0)
> +#define GDSC_POWER_DOWN_COMPLETE	BIT(15)
> +#define GDSC_POWER_UP_COMPLETE		BIT(16)
> +#define GDSC_PWR_ON_MASK		BIT(31)
> +#define CFG_GDSCR_OFFSET		0x4
> +#define GDSC_STATUS_POLL_TIMEOUT_US	1500
> +
>  /* Enable clock controlled by CBC soft macro */
>  void clk_enable_cbc(phys_addr_t cbcr)
>  {
> @@ -223,7 +232,7 @@ U_BOOT_DRIVER(qcom_clk) = {
>  int qcom_cc_bind(struct udevice *parent)
>  {
>  	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(parent);
> -	struct udevice *clkdev, *rstdev;
> +	struct udevice *clkdev = NULL, *rstdev = NULL, *pwrdev;
>  	struct driver *drv;
>  	int ret;
>  
> @@ -238,20 +247,41 @@ int qcom_cc_bind(struct udevice *parent)
>  	if (ret)
>  		return ret;
>  
> -	/* Bail out early if resets are not specified for this platform */
> -	if (!data->resets)
> -		return ret;
> +	if (data->resets) {
> +		/* Get a handle to the common reset handler */
> +		drv = lists_driver_lookup_name("qcom_reset");
> +		if (!drv) {
> +			ret = -ENOENT;
> +			goto unbind_clkdev;
> +		}
> +
> +		/* Register the reset controller */
> +		ret = device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)data,
> +						   dev_ofnode(parent), &rstdev);
> +		if (ret)
> +			goto unbind_clkdev;
> +	}
>  
> -	/* Get a handle to the common reset handler */
> -	drv = lists_driver_lookup_name("qcom_reset");
> -	if (!drv)
> -		return -ENOENT;
> +	if (data->power_domains) {
> +		/* Get a handle to the common power domain handler */
> +		drv = lists_driver_lookup_name("qcom_power");
> +		if (!drv) {
> +			ret = -ENOENT;
> +			goto unbind_rstdev;
> +		}
> +		/* Register the power domain controller */
> +		ret = device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)data,
> +						   dev_ofnode(parent), &pwrdev);
> +		if (ret)
> +			goto unbind_rstdev;
> +	}
>  
> -	/* Register the reset controller */
> -	ret = device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)data,
> -					   dev_ofnode(parent), &rstdev);
> -	if (ret)
> -		device_unbind(clkdev);
> +	return 0;
> +
> +unbind_rstdev:
> +	device_unbind(rstdev);
> +unbind_clkdev:
> +	device_unbind(clkdev);
>  
>  	return ret;
>  }
> @@ -306,3 +336,79 @@ U_BOOT_DRIVER(qcom_reset) = {
>  	.ops = &qcom_reset_ops,
>  	.probe = qcom_reset_probe,
>  };
> +
> +static int qcom_power_set(struct power_domain *pwr, bool on)
> +{
> +	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
> +	void __iomem *base = dev_get_priv(pwr->dev);
> +	const struct qcom_power_map *map;
> +	u32 value;
> +	int ret;
> +
> +	if (pwr->id >= data->num_power_domains)
> +		return -ENODEV;
> +
> +	map = &data->power_domains[pwr->id];
> +
> +	if (!map->reg)
> +		return -ENODEV;
> +
> +	value = readl(base + map->reg);
> +
> +	if (on)
> +		value &= ~GDSC_SW_COLLAPSE_MASK;
> +	else
> +		value |= GDSC_SW_COLLAPSE_MASK;
> +
> +	writel(value, base + map->reg);
> +
> +	if (on)
> +		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +					 value,
> +					 (value & GDSC_POWER_UP_COMPLETE) ||
> +					 (value & GDSC_PWR_ON_MASK),
> +					 GDSC_STATUS_POLL_TIMEOUT_US);
> +
> +	else
> +		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> +					 value,
> +					 (value & GDSC_POWER_DOWN_COMPLETE) ||
> +					 !(value & GDSC_PWR_ON_MASK),
> +					 GDSC_STATUS_POLL_TIMEOUT_US);
> +
> +
> +	if (ret == -ETIMEDOUT)
> +		printf("WARNING: GDSC %lu is stuck during power on/off\n",
> +		       pwr->id);
> +	return ret;
> +}
> +
> +static int qcom_power_on(struct power_domain *pwr)
> +{
> +	return qcom_power_set(pwr, true);
> +}
> +
> +static int qcom_power_off(struct power_domain *pwr)
> +{
> +	return qcom_power_set(pwr, false);
> +}
> +
> +static const struct power_domain_ops qcom_power_ops = {
> +	.on = qcom_power_on,
> +	.off = qcom_power_off,
> +};
> +
> +static int qcom_power_probe(struct udevice *dev)
> +{
> +	/* Set our priv pointer to the base address */
> +	dev_set_priv(dev, (void *)dev_read_addr(dev));
> +
> +	return 0;
> +}
> +
> +U_BOOT_DRIVER(qcom_power) = {
> +	.name = "qcom_power",
> +	.id = UCLASS_POWER_DOMAIN,
> +	.ops = &qcom_power_ops,
> +	.probe = qcom_power_probe,
> +};
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 01088c1901..12a1eaec2b 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -59,9 +59,15 @@ struct qcom_reset_map {
>  	u8 bit;
>  };
>  
> +struct qcom_power_map {
> +	unsigned int reg;
> +};
> +
>  struct clk;
>  
>  struct msm_clk_data {
> +	const struct qcom_power_map	*power_domains;
> +	unsigned long			num_power_domains;
>  	const struct qcom_reset_map	*resets;
>  	unsigned long			num_resets;
>  	const struct gate_clk		*clks;

-- 
// Caleb (they/them)
