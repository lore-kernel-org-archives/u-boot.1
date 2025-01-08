Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A7FE77199
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E785C805F0;
	Wed,  8 Jan 2025 15:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="upC/xM/4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6332980602; Wed,  8 Jan 2025 15:40:56 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E66638001F
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso30355211a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736347253; x=1736952053; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H4k7HpXCO3AFeRdxZHoJUwJ8aJafDjgYKNnGF0x7KH0=;
 b=upC/xM/4nvymw0OmM2sLEfCPgrYziyviVTzjOQlX6gcwX0FJkgEsLDcF36eLbQEY0o
 Xtqtgt0CCco4yG7ZWBRXZLbktG/qKeoTxWN+IRlwz576BrEbFcnR2cxSG4bXZp2jmjpg
 auQnB3YUbgBsPFZYxbqAKtApC2MLrUAhIemq+Xsu4pKiR3m9FUur+NHt7APACEWAZtYb
 Tl0DQaJk+9N1a59ZWXv7W+Lnrj6aFq/TsP/k8EaIuxU/mEAV8JWaxYg7Ie/RR9fnZabd
 gYy2fKiAm4Y1y4Kjw72XbzHbiLc+95M2pqHPc7NMDHeQ7s/lKGdc7jtiYQ2d0//+6n8i
 a2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736347253; x=1736952053;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H4k7HpXCO3AFeRdxZHoJUwJ8aJafDjgYKNnGF0x7KH0=;
 b=fM9rNgRFlrLjbDr0vXi6bkvE/UtPOW8WU4RWM5nPuCF07yqjo4ejdUEUSFizXf7LqH
 novKS+ykieBGAlLZYayfMwF6fCpSJtL5kgQJasC8QhSUVJsCHj9YFTGYY1bPdNupaIvF
 iFeRuJ3SpOpJd5cTfPVRkDI+Szk/KfkOFMUnJ0yjn1PVThIXU70CJcC2tiqhlbY85s3V
 2xqc3giDrV3/waP094fBjhq/zL5OX/idBdIAMGYOJT/bZN6gdNgTaNWHsZf06MbQvHyL
 vCnFHc3r6RUm96ilpd5C9Me1Cc+wsyZBV9rtAmex/L9mMGPJb6dhcvPuytRicvI1dk4K
 oIpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJk3mmRbTrDUCk3emkzvG1AUCR1Rhr/WIRsqW1r6f0JWLMpWFcwuLMhibaqRNUFCT7orzn54U=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8oxLD2c6mpeLBoPsqTHSj/kS+dsW8zl6w2CR9NSJ4md8qlZrO
 XIhfF9Tl8TNp/a7LaFdQYqdaqURm6r1ZB3vbnZcobbqKhMar5LLqBy4xvtFii6dmeXVxFbgpuHy
 Z
X-Gm-Gg: ASbGncv7Q3mwtWbBlb+2QS568tuCif3DwWgdVDcDLXYRHBE+au4KS7o0bHVER74s2bZ
 tJIugRryZOD25d1YGUl9rub95GHfYkri/2EZv8JvB6xEJCQiOPz6+TN2nd6t+JbrmNNk1+7AmTw
 lgGxTJHMgUzFNVQZ2GidFjkb4bS14On90HQkhXokb+Js/Fek5h3iU2HuYqeGpGTjv7xwauDFSB3
 KdTU0AU2dXnqlg9wKd+vKzpUQmTwlISH/069A3lrmzG/HlqYmYPtwR6rPjO30vTwD/6bYOXNx+h
 hUEgwybp+TLSs0Gvg7riZXrJOAhqwtuF2yFodAY=
X-Google-Smtp-Source: AGHT+IElpsB/qJ4sZfNHYsQYOuD9YT3womfJygpvulT4HLLyaANhkh3RYNdqEdf9u9zfDu14RBTopg==
X-Received: by 2002:a05:6402:320b:b0:5d0:cfdd:2ac1 with SMTP id
 4fb4d7f45d1cf-5d972dfcbcfmr2879329a12.6.1736347253363; 
 Wed, 08 Jan 2025 06:40:53 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806fed723sm26211448a12.64.2025.01.08.06.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 06:40:51 -0800 (PST)
Message-ID: <6dcaf2a0-3c08-4bcc-9e7d-8cf7a77cd54c@linaro.org>
Date: Wed, 8 Jan 2025 15:40:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk/qcom: Treat different GDSCs didderently
Content-Language: en-US
To: Alexey Minnekhanov <alexeymin@postmarketos.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
References: <20250108115911.4163437-1-alexeymin@postmarketos.org>
 <20250108115911.4163437-2-alexeymin@postmarketos.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250108115911.4163437-2-alexeymin@postmarketos.org>
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

Hi Alexey,

Thanks for the patch! Really happy to see support for this new platform.

On 08/01/2025 12:59, Alexey Minnekhanov wrote:
> Apparently not all GDSCs are the same. In Linux driver, depending on which
> GDSC flags are set, different status register is checked when powering it
> on/off. And on top of that, different bit inside that register is tested.
> 
> Port missing parts from Linux driver to U-Boot:
>  - add GDSC flags;
>  - adjust logic when checking GDSC status to match one in Linux driver.

Sorry it's a bit of a pain, but could you split this into two patch and
adjust the ordering so we don't risk breaking someones bisect if they
land here. I'd propose:

Patch 1: as-is
Patch 2: add the flags enum and adjust struct qcom_power_map
Patch 3: would be the "port to new flags" patch
Patch 4: adjust qcom_power_set() (the bulk of this patch)
Patch 5: add sdm660 clock driver

does this make sense?
> 
> This fixes e.g. SDM660's USB_30_GDSC to be forever stuck during power on,
> since unlike SDM845 one it doesn't have POLL_CFG_GDSCR flag.
> 
> Even though only POLL_CFG_GDSCR is the important one here, add all flags
> from Linux driver, to make it easier to compare which flags are needed
> for which GDSC, making porting process easier.

This is great, thanks for taking the time to add all of these.

Kind regards,
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---
>  drivers/clk/qcom/clock-qcom.c | 45 ++++++++++++++++++++++++-----------
>  drivers/clk/qcom/clock-qcom.h | 16 ++++++++++++-
>  2 files changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 1cfc430c14a5..bf9249b55af3 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -461,7 +461,7 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
>  	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(pwr->dev);
>  	void __iomem *base = dev_get_priv(pwr->dev);
>  	const struct qcom_power_map *map;
> -	u32 value;
> +	u32 value, status_reg;
>  	int ret;
>  
>  	if (pwr->id >= data->num_power_domains)
> @@ -481,19 +481,36 @@ static int qcom_power_set(struct power_domain *pwr, bool on)
>  
>  	writel(value, base + map->reg);
>  
> -	if (on)
> -		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> -					 value,
> -					 (value & GDSC_POWER_UP_COMPLETE) ||
> -					 (value & GDSC_PWR_ON_MASK),
> -					 GDSC_STATUS_POLL_TIMEOUT_US);
> -
> -	else
> -		ret = readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
> -					 value,
> -					 (value & GDSC_POWER_DOWN_COMPLETE) ||
> -					 !(value & GDSC_PWR_ON_MASK),
> -					 GDSC_STATUS_POLL_TIMEOUT_US);
> +	/* depending on the type of gdsc the status register is different */
> +	/* and we need to check different status bit */
> +	if (map->flags & POLL_CFG_GDSCR) {
> +		status_reg = map->reg + CFG_GDSCR_OFFSET;
> +
> +		if (on)
> +			ret = readl_poll_timeout(base + status_reg,
> +						 value,
> +						 (value & GDSC_POWER_UP_COMPLETE),
> +						 GDSC_STATUS_POLL_TIMEOUT_US);
> +		else
> +			ret = readl_poll_timeout(base + status_reg,
> +						 value,
> +						 (value & GDSC_POWER_DOWN_COMPLETE),
> +						 GDSC_STATUS_POLL_TIMEOUT_US);
> +	} else {
> +		status_reg = map->reg;
> +
> +		if (on)
> +			ret = readl_poll_timeout(base + status_reg,
> +						 value,
> +						 (value & GDSC_PWR_ON_MASK),
> +						 GDSC_STATUS_POLL_TIMEOUT_US);
> +
> +		else
> +			ret = readl_poll_timeout(base + status_reg,
> +						 value,
> +						 !(value & GDSC_PWR_ON_MASK),
> +						 GDSC_STATUS_POLL_TIMEOUT_US);
> +	}
>  
>  	if (ret == -ETIMEDOUT)
>  		printf("WARNING: GDSC %lu is stuck during power o%s\n",
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 78d9b1d81ece..84965b2555c7 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -63,8 +63,22 @@ struct qcom_reset_map {
>  	u8 bit;
>  };
>  
> +enum qcom_gdsc_flags {
> +	VOTABLE = BIT(0),
> +	CLAMP_IO = BIT(1),
> +	HW_CTRL = BIT(2),
> +	SW_RESET = BIT(3),
> +	AON_RESET = BIT(4),
> +	POLL_CFG_GDSCR = BIT(5),
> +	ALWAYS_ON = BIT(6),
> +	RETAIN_FF_ENABLE = BIT(7),
> +	NO_RET_PERIPH = BIT(8),
> +	HW_CTRL_TRIGGER = BIT(9),
> +};
> +
>  struct qcom_power_map {
> -	unsigned int reg;
> +	unsigned int reg; /* GDSCR */
> +	unsigned int flags;
>  };
>  
>  struct clk;

-- 
// Caleb (they/them)

