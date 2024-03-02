Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FD7C5475B
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 00:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACAD587D8F;
	Sat,  2 Mar 2024 01:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XJO+sf75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14DB587D8F; Sat,  2 Mar 2024 01:05:59 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E680A8787C
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 01:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=konrad.dybcio@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so4189397a12.3
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 16:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709337955; x=1709942755; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dSH4VPR1R9swOBaOhMcvv81pmxJsdxblBquIuZ120uA=;
 b=XJO+sf756t7VWhn7YacTiJaW36+2w74wQWsea8ROMEwUpFxgP1rLfEiGM6JtkGW9fJ
 zg3WwfTh5+JVDw0HpMyVUR4IHdu5dPr1lu45O7+xAlR+e5Z/OZGJf/cnn9ZZloNhvpcs
 KL+1gt/x0WP3GZu0+N02V219AAsv/M/RyVmjcLCbeyEql/BDFX5lgI+jcrukiJeI6UXb
 pbq2ohn5hUP7XH3I0FVNjN07ueZL65fX1I8kPJJDouf1EwBOaZeZW0gS3+ha0IXbyJoI
 kX+F/telcQEh/4LDG4HBIIN+kex6g3218s1XfpbWl9l4gQ3S5UCj8iKXZkdAwEMJkUFB
 wlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709337955; x=1709942755;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dSH4VPR1R9swOBaOhMcvv81pmxJsdxblBquIuZ120uA=;
 b=SVlR9hT9KyPB5hKOVlfvJ3lOMDL5qWW5FbY98cO87O5R2jPCkKOxL92wcg+5VTH993
 qj9lPNIeTr2zxVaTyw0u/DAIJ+l0iYVDtTBjG3S5EYlY5Rv/i/ZvWeR+IvYLTC6QHELD
 ifdTJJxsQrxpJhoimPHJl7kDcZIC8ipLHaOX6MjTWdm1p9ekbqpe0S5YeQTNkYI2o7LB
 sa9xtI9M5bdhgYa8xiNR1tqytuR9YEEIjQ8qsNW+QgNMMWbzhmy+XB7iYtFyhMb9/Azk
 B6acN2FI5h//1LPTrGq6oM67+H8v9zGzDUacTUoLPc9hubVio/mS06bV7ofPPvV3kZ8u
 74Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP/v8b/2nGfUXiOZS6D8Gh4AuSTCQWkjNpHeIcWPwZK1n250ZC7kG+5d4biA3GNKEiRNkwRds9IHXVmoqHtydIb5GcQg==
X-Gm-Message-State: AOJu0YyKH+yDYJTycY1pD+o2FsCxdNrgHbxT8v1905EKcQW/zpPI2xzo
 mETUK/DHrUGAFxcAH0iwqtZp/BTeGlqHykYefsY0jA5LifAjVmB/NDleSIMFcWM=
X-Google-Smtp-Source: AGHT+IG0WZRnOOBEi2DycI/9aU7l4XHFZrbOVRu/Lc6ApSdkqOzCtO4/VohMKtFgsk9Lz1gW2t72Qw==
X-Received: by 2002:a50:8d89:0:b0:565:cbba:b7a1 with SMTP id
 r9-20020a508d89000000b00565cbbab7a1mr2084413edh.1.1709337954427; 
 Fri, 01 Mar 2024 16:05:54 -0800 (PST)
Received: from [192.168.216.32] (078088045141.garwolin.vectranet.pl.
 [78.88.45.141]) by smtp.gmail.com with ESMTPSA id
 fg11-20020a056402548b00b00565efe074f4sm2003317edb.85.2024.03.01.16.05.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 16:05:54 -0800 (PST)
Message-ID: <6fe23988-834a-4205-b88d-11e4625115c9@linaro.org>
Date: Sat, 2 Mar 2024 01:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] clk: qcom: add support for power domains uclass
Content-Language: en-US
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-5-volodymyr_babchuk@epam.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240229142043.1263690-5-volodymyr_babchuk@epam.com>
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

On 29.02.2024 15:21, Volodymyr Babchuk wrote:
> Now sub-drivers for particular SoCs can register them as power domain
> drivers. This is needed for upcoming SM8150 support, because it needs
> to power up the Ethernet module.
> 
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
> 
>  drivers/clk/qcom/clock-qcom.c | 93 ++++++++++++++++++++++++++++++++++-
>  drivers/clk/qcom/clock-qcom.h |  6 +++
>  2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 729d190c54..986b8e4da4 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -23,6 +23,7 @@
>  #include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <reset-uclass.h>
> +#include <power-domain-uclass.h>
>  
>  #include "clock-qcom.h"
>  
> @@ -30,6 +31,11 @@
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
>  #define CBCR_BRANCH_OFF_BIT     BIT(31)
>  
> +#define GDSC_POWER_UP_COMPLETE		BIT(16)
> +#define GDSC_POWER_DOWN_COMPLETE	BIT(15)

Please keep things sorted by bit index for bitfields and register offset
for registers

> +#define CFG_GDSCR_OFFSET		0x4
> +#define PWR_ON_MASK			BIT(31)
> +
>  /* Enable clock controlled by CBC soft macro */
>  void clk_enable_cbc(phys_addr_t cbcr)
>  {
> @@ -223,7 +229,7 @@ U_BOOT_DRIVER(qcom_clk) = {
>  int qcom_cc_bind(struct udevice *parent)
>  {
>  	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(parent);
> -	struct udevice *clkdev, *rstdev;
> +	struct udevice *clkdev, *rstdev, *pwrdev;
>  	struct driver *drv;
>  	int ret;
>  
> @@ -253,6 +259,20 @@ int qcom_cc_bind(struct udevice *parent)
>  	if (ret)
>  		device_unbind(clkdev);
>  
> +	if (!data->power_domains)
> +		return ret;
> +
> +	/* Get a handle to the common power domain handler */
> +	drv = lists_driver_lookup_name("qcom_power");
> +	if (!drv)
> +		return -ENOENT;
> +
> +	/* Register the power domain controller */
> +	ret = device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)data,
> +					   dev_ofnode(parent), &pwrdev);
> +	if (ret)
> +		device_unbind(pwrdev);
> +
>  	return ret;
>  }
>  
> @@ -306,3 +326,74 @@ U_BOOT_DRIVER(qcom_reset) = {
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
> +		value &= ~BIT(0);

These magic bits should be #defined.

> +	else
> +		value |= BIT(0);
> +
> +	writel(value, base + map->reg);
> +
> +	/* Wait for power on */
> +	while (true) {

Uhh.. I'm not sure a tight loop is the best idea here, especially since
GDSCs are known to be grumpy and not wanna power on if they're missing
a dependency. I'd say a timeout is definitely in order. 1500ms following
Linux

Konrad
