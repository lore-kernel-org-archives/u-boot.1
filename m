Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA41C5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 14:56:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F243987C0A;
	Wed,  6 Mar 2024 15:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TqBc2oA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA25187C92; Wed,  6 Mar 2024 15:56:49 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2A5187C0A
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 15:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5dbcfa0eb5dso6393835a12.3
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709737005; x=1710341805; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g9RIs0rpMWRqbMlbFJAb2URQsCWWSzA0MGqtp5eG2Tk=;
 b=TqBc2oA/temntHaxDpPNdLU69FeAQlCUcIDVtEeMZd1JYFCE97w8+4xH/FGRojR9OD
 X7fre8XeDOSi/Xg7r4jPp8FEosdWSHaZB4c0DU9Xfxn6o3vp7nmOa6IszPIc6134w7lV
 t0zjDZ8syLEyffIDg91oRBLvoS3yWKWsUoBRHlPhU1vCIPiqmXsTdgQTIMUpD25e7bRG
 8L5gkPY/3L5RcTHDBvnol/KVQqucSoDXzBXrbxlkZGkOjuIIW3S1XsYs6oFIuVh7jJq9
 F3511xCKQwCMcmTogsJHCnzb83aeAfKMnRa8ItwL8YIneRiPh9bWBKNnqS7HB5Bwdsym
 8SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709737005; x=1710341805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g9RIs0rpMWRqbMlbFJAb2URQsCWWSzA0MGqtp5eG2Tk=;
 b=Y4BAf0Vuyiz1EADJcYfbuSebFz9WZOOt3Q6lIH+gUpVLLMNZfh1iaysppBU2nO8Xhz
 W4absz9qClZRPykAfbFbbCtads1H3KpdzxtBsHjfB9xQ9dC6und2vnZF+291AE4RZg2h
 /zaxixy/htLsMF/diaUf+ScLmDRPnqVvNn4PCUvKYTtvK90cI5Xhep0vNT8+EFVg15ap
 YFIyJVt1c3WKvYQfBVKY1mO5mtH/Oj4rugSJ42H0jGG9mPgRaGYqZg7ZkEAqmZPzYUoc
 VRwT0V0fL+rrOpl0eY3Ic2JaHJ8qpmNA9tH6yCTq60+Brql5/48XO1w4SOqq0B+eSVM8
 a/jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp4FY/QSrKElj63+NF4c+xYbkuVSM5by3gnDcnv6cSbQVHwud22KVOxOQvsLoz0f79GNqmJNRo+bHXcU9wdJllNQQVzQ==
X-Gm-Message-State: AOJu0Yxh2BXDLXDzaDhZqchoTd4H6yirLLCFH2PzRzoXJrFTaoH2Lcpf
 GQf/L83CCAVmnfJ8rHNoMQfwUDRofXNdD04mxD89/BrR3yOHcSc739/j3USdmwc=
X-Google-Smtp-Source: AGHT+IFKZh41zXmvdiv/2SSMX1XHxQplY7ryThisDhLoGtUo6L1rYdT3YATvyZ9AG27z7gAVVWB2Rw==
X-Received: by 2002:a05:6a20:80c3:b0:1a1:4d4d:ca8d with SMTP id
 d3-20020a056a2080c300b001a14d4dca8dmr4090957pza.50.1709737005090; 
 Wed, 06 Mar 2024 06:56:45 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a626504000000b006e621fd613fsm5653704pfb.80.2024.03.06.06.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 06:56:44 -0800 (PST)
Message-ID: <fe2e3969-c1d4-40db-be4c-01030667e6ab@linaro.org>
Date: Wed, 6 Mar 2024 14:56:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] clk: qcom: add support for power domains uclass
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240306005230.2638972-1-volodymyr_babchuk@epam.com>
 <20240306005230.2638972-5-volodymyr_babchuk@epam.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240306005230.2638972-5-volodymyr_babchuk@epam.com>
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

On 06/03/2024 00:53, Volodymyr Babchuk wrote:
> Now sub-drivers for particular SoCs can register them as power domain
> drivers. This is needed for upcoming SM8150 support, because it needs
> to power up the Ethernet module.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> 
> ---
> 
> Changes in v2:
>  - Reworked qcom_cc_bind() function
>  - Added timeout to qcom_power_set()
>  - Minor fixes in register names and formatting
> 
>  drivers/clk/qcom/clock-qcom.c | 128 ++++++++++++++++++++++++++++++----
>  drivers/clk/qcom/clock-qcom.h |   6 ++
>  2 files changed, 121 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 729d190c54..c3f8d96183 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <reset-uclass.h>
> +#include <power-domain-uclass.h>

The Kconfig should reflect this, please make CLK_QCOM imply POWER_DOMAIN.

[...]

> +static int qcom_power_set(struct power_domain *pwr, bool on)
> +{
> +	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
> +	void __iomem *base = dev_get_priv(pwr->dev);
> +	unsigned long timeout;
> +	const struct qcom_power_map *map;
> +	u32 value;
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
> +	timeout = timer_get_us() + GDSC_STATUS_POLL_TIMEOUT_US;
> +	/* Wait for power on */
> +	while (timeout > timer_get_us()) {
> +		value = readl(base + map->reg + CFG_GDSCR_OFFSET);
> +		if (on) {
> +			if ((value & GDSC_POWER_UP_COMPLETE) ||
> +			    (value & GDSC_PWR_ON_MASK))
> +				return 0;
> +		} else {
> +			if (value & GDSC_POWER_DOWN_COMPLETE ||
> +			    !(value & GDSC_PWR_ON_MASK))
> +				return 0;
> +		}
> +	}
> +
Usually this error condition is indicative of a driver bug somewhere -
that the GCC is misconfigured. We should follow Linux and print a noisy
"WARNING: GDSC %p stuck off/on" message here.
> +	return -ETIMEDOUT;
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
