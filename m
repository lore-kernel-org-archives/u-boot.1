Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E71C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:01:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7AC987F00;
	Tue, 12 Mar 2024 19:01:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pg4KNTlA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CF988792D; Tue, 12 Mar 2024 19:01:40 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4885F87C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 19:01:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412e784060cso596375e9.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 11:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710266497; x=1710871297; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdsJ2uNYodk2pmeTVoft4OCmwEddZSQWnaDMVoPLurc=;
 b=pg4KNTlAoQkuNAyjgScgElm1uAG63Gh1Zz7O4VIWmfdJB1ORiqoxdIYAwBKjmamUpL
 fzeQjAoQy6cwvT3or9+aJJmaJV4Oa9ylUugaVCr6LXJXnfL4WCgqYpJbylOBWjT+xWe9
 wTIMZ1/HZAUS2izK/wXO3qU4YNyUDndJl0cTilF3hkcK9vSE4uRthkrrN5TLdBW+wKnH
 dqtfw6gB5tIwIyjg/Acr4oulPz9Jcy0sSJrmhdhMuY7llN+/ZRRUT6FvYcolFfwfL7jf
 zcBsINWGqr2A40SUF0l2TbzX90JXViXQzZNcXddRelfsVGVjTN2yHl4ThQc9qN5Izkpv
 CXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710266497; x=1710871297;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LdsJ2uNYodk2pmeTVoft4OCmwEddZSQWnaDMVoPLurc=;
 b=pkAeKQ1Oih6LcWmK6aKa31wYOS8WyisJHPzVpRjoSHcofiySUgshbka3+6Kk7xLieC
 Kp1ZN1ntksYLxF9KmDHtW779S97TAmz2y0bzeRexdhq3/Ni0VeZfK+tmsIhgTVNrUuVc
 CDqXrF+XhhgwRz5a5XZTURNCsx2ttAnEeM1kOtnCltQuHMSRkMGUDJAcG6X4vys0jDQU
 xOJYMVSgPNpG40JBNa43kW8mwZ/XtiPnC6gL8EF29vFdDKkQox0xEsogCI+TbszXRmvL
 nC0fXWtE6vL2jkpLrmSDP855JarLDQdOs1DDplMe3PclXo9YRLnsC0SDDSGcwHfNt+pY
 WG0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5jj7mvsREdKp3TIFHfdmYpWYmxnUYz/VIqTJgce6wAmNAEnpcJtBKIQZVP6nazV/ydMOJ5g9CUqHbr4HO9oKWdCDmAw==
X-Gm-Message-State: AOJu0YzDl11ilTLmDfU+u9wc4KBKw/lRoTdDfnaB6XVKE/kF9P1AQqUA
 IIjJvJxMesI5NyEWkZve8OMHXBdHdeFgQ3OdB3lBnVyi9NTJ25W1QnBqppFQOyk=
X-Google-Smtp-Source: AGHT+IEYDn3cL0KLaqvQVu9DDHzTZgfOE9PBfFgVCcTBXJo+HPXDe520fypJ7a//jg6r1jUIU9f11w==
X-Received: by 2002:a05:600c:4f4e:b0:413:2ff9:bb04 with SMTP id
 m14-20020a05600c4f4e00b004132ff9bb04mr255222wmq.11.1710266496599; 
 Tue, 12 Mar 2024 11:01:36 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm13068004wmo.7.2024.03.12.11.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 11:01:35 -0700 (PDT)
Message-ID: <4e10f28d-48d5-4724-a8ed-4f260a677948@linaro.org>
Date: Tue, 12 Mar 2024 18:01:35 +0000
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

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
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
