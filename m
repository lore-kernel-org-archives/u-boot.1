Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B421EC54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 17:15:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2A287ED1;
	Wed, 13 Mar 2024 18:15:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sQoKiV4B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E223C87EAD; Wed, 13 Mar 2024 18:15:32 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7580887ED1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 18:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-413ef7f46ccso451085e9.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710350128; x=1710954928; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cosdXYCUPPkY74nbmUyl+kAgEAZL+dVrhZ9tPExpEEo=;
 b=sQoKiV4BJbmQHdQyLsxfnnrW4vW2117DpFQ2AkaHt3F+AliJl03HJ79Gexj2w1Ph65
 8rPU8e1DCHQLZt3pe/ltOsn1vv0Y6/CUhA4goSRXn3SDlTkvS8R4dxEYsMhLppw9ad+8
 XtXp859QGVjtlY8GgcHhMVsE6+2wmT2DcEcohBMTD074iUkI6Ex0RgWTWxRhaX+apkwC
 1qXJbAe/qocW8hCVdbNT7BGqG5DkeMceVigwHLu6YUlruZFR29CnAR5DcvCKogCIgtsI
 M0wVeG56mh9Sln4qka1UG3f020dfOrjG5y9Cc4T60H/4P6ufnMGFRXASRoRGppOhewGh
 KGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710350128; x=1710954928;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cosdXYCUPPkY74nbmUyl+kAgEAZL+dVrhZ9tPExpEEo=;
 b=rVAtL9JKglBlfgBEZVOCT7K/V9nbaEN0hChgBKlc8Dc4iFn+LjwQuOJ4xIQdiEKqd+
 yhBYzr6Ig7g7N5XBuuOoxIZ7FgExVTdZbm1/vDFTB+KV1OqBUKZfM8cstRzJa07CURue
 QSwmKnSA6MhjGQjxRYUDYfzeLantrWYbTFEj4A2UOEtRZnzIWPl2LIH9ip+cz7MXBKS1
 1jHODTshF0cjaOOX9nlnOGqnwGzKnmi4vYSFkCgG1dtWNalfKM+wTEaiz3PZ4ASesNZj
 cDPpC8fFS9DDe8OMVpz3xO4hr/Whef9Za40M+5igN5f2Kagy0sRlLtjf2ojKc83nA7+l
 8nsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZoI4PKJ24uwnog57de1r2ywI1NxUOYB8VfCZqu5FY1HX+nVIpvjIU7K25mYtVC81XwBO0dqIh7irTa+gvvJfS/94Jw==
X-Gm-Message-State: AOJu0YwtF6nx3+/fYOU8MVoWCcmyPDKd/fSnzIty/Y6XY6n0sFjD1IIi
 mrhRh3WDGffVEReBuWlwoxgBS+pJxZgUZPuSspXBV2krUCPNlpudB/nIP8/QfwI=
X-Google-Smtp-Source: AGHT+IHzIuRIQcLjqcuvnI1BOQji2HVlF3tgWRUHBDTtN3UNy3yxZOtOIsooQqoJ91Zau8PFTTlLQw==
X-Received: by 2002:a5d:59af:0:b0:33e:b758:a039 with SMTP id
 p15-20020a5d59af000000b0033eb758a039mr1805766wrr.28.1710350127836; 
 Wed, 13 Mar 2024 10:15:27 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a056000105100b0033e34c53354sm12086813wrx.56.2024.03.13.10.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 10:15:27 -0700 (PDT)
Message-ID: <f0b5bbb8-bda0-4329-8be6-95a4017a5204@linaro.org>
Date: Wed, 13 Mar 2024 17:15:26 +0000
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



On 11/03/2024 21:33, Volodymyr Babchuk wrote:
> Now sub-drivers for particular SoCs can register them as power domain
> drivers. This is needed for upcoming SM8150 support, because it needs
> to power up the Ethernet module.
> 
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

This results in a similar dependency error to the one above unless
CONFIG_POWER_DOMAIN is enabled in the defconfig. I think we'll just add
"select POWER_DOMAIN" to ARCH_SNAPDRAGON, same as we have for DM_RESET.

I'll do then when picking this series up, just a note to self.
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
