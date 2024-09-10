Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22657EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99BF589070;
	Tue, 10 Sep 2024 14:15:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QX9YQZR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07D0E89072; Tue, 10 Sep 2024 14:14:59 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB9A28906A
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c260b19f71so5569684a12.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725970496; x=1726575296; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJtMCdLv8Ydqxmf65qEEHv0XgZ0MCEeUy75z32ykc/g=;
 b=QX9YQZR6piszT6thV7WkxRM2A3uO5qFYy9REG1W/beRNO9EjJ1spH+hStw5Yn6zsOf
 4AGZZxlliJMFcEEiQrGk0DhbBqF5kR+ue/3xKn5LzvdA08mo1WYSuRKUiwRvbqlJ5xus
 Ts40MZKulFHHRR5S0QiJ9hC2KOXmd4ZcQ+b9EpeQqDkPsyVefGF0s+d+PEoEmMPPBWOg
 1LW1g3fgMwuXT/taU8dIuTnGJ4wmlu82YUsC6H2zVpSLjq/BgIl6j4J76cCAcPw8msfn
 UbyTAqZ8LId/RPge4n7Yt6tFTwSA9kLixRA8bFCNwz2GPAgBnGGKODR+jzT54pNGhW3F
 UeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725970496; x=1726575296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yJtMCdLv8Ydqxmf65qEEHv0XgZ0MCEeUy75z32ykc/g=;
 b=bG6fRw+GzXaWJIhkn6OJzg5kyPuP3dQECMgnyPonzebMpvb9R4ljVbn3DuXTcXibTH
 jRo9irm5vlnxWAIwszyI7PcoA0CVcSWlItCFGosfCr0VsnBtmCgYQ57rd/Fl2+8KwVJC
 FNgSxpD57OzRaiyFIbvM/EZbfvTxa1OMErKE4fd8bK6D/R01VgCSOuHuDcWJF0wfQN1K
 OmH9fIlkkvh9mJSRzG93sGGcfysaI6cDmAE2OWVCZDRK/sMRaTwQ/cHLnmrpjPaUDTjL
 R5FhYcEViioj0d0ZK8CCzyP1epouCJY9AC9dc2jWSWxKH3n5lGWEvMvWR81aloXluZtl
 fZJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ/BSWa4zCrzjxQ621CkOzStfSVR43Sny/bGx7OhjmAGJJ4c8bk38gJ+fnVEZqKYlGoXUesCo=@lists.denx.de
X-Gm-Message-State: AOJu0YyavSzULyCOboVfo6T/O5AqYClQLUrY7DYcvBP1hzdusQA1XTf5
 foEqNTxcVf/natsyS4dx2VSInjItKQZ+efjuH1rgPBG/ebfBUGy5k3kgNqYhP/M=
X-Google-Smtp-Source: AGHT+IGmLRIz+dKDyrfbxCwXji3EiZAUhzv8gR8coesTiPmhor7b0zd+IAJJgFYGaC1j+zsSuh8XVQ==
X-Received: by 2002:a17:907:2d0d:b0:a8d:7210:e28d with SMTP id
 a640c23a62f3a-a8ffab8443emr48674866b.29.1725970496251; 
 Tue, 10 Sep 2024 05:14:56 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a27a9fsm472467766b.91.2024.09.10.05.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:14:55 -0700 (PDT)
Message-ID: <09a00f61-ee64-42ac-ae76-9a9194edd649@linaro.org>
Date: Tue, 10 Sep 2024 14:14:54 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 2/2] pinctr: qcom: sm8250: add special pins pins
 configuration data
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-0-50623a7e4931@linaro.org>
 <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-2-50623a7e4931@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240910-topic-sm8x50-msm-gpio-special-pins-sm8250-v1-2-50623a7e4931@linaro.org>
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



On 10/09/2024 10:58, Neil Armstrong wrote:
> Add the special pins configuration data to allow setup the bias
> of the UFS and SDCard pins on the SM8250 SoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-sm8250.c | 41 ++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250.c b/drivers/pinctrl/qcom/pinctrl-sm8250.c
> index dac24f11bc2..69c907e3868 100644
> --- a/drivers/pinctrl/qcom/pinctrl-sm8250.c
> +++ b/drivers/pinctrl/qcom/pinctrl-sm8250.c
> @@ -18,8 +18,37 @@
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  
>  static const struct pinctrl_function msm_pinctrl_functions[] = { { "qup12", 1 },
> -								 { "gpio", 0 },
> -								 { "sdc2_clk", 0 } };
> +								 { "gpio", 0 }, };
> +#define SDC_PINGROUP(pg_name, ctl, pull, drv)		\
> +	{						\
> +		.name = pg_name,			\
> +		.ctl_reg = ctl,				\
> +		.io_reg = 0,				\
> +		.pull_bit = pull,			\
> +		.drv_bit = drv,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +	}
> +
> +#define UFS_RESET(pg_name, offset)			\
> +	{						\
> +		.name = pg_name,			\
> +		.ctl_reg = offset,			\
> +		.io_reg = offset + 0x4,			\
> +		.pull_bit = 3,				\
> +		.drv_bit = 0,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = 0,				\
> +	}
> +
> +static const struct msm_special_pin_data sm8250_special_pins_data[] = {
> +	[0] = UFS_RESET("ufs_reset", SOUTH + 0xb8000),
> +	[1] = SDC_PINGROUP("sdc2_clk", NORTH + 0xb7000, 14, 6),
> +	[2] = SDC_PINGROUP("sdc2_cmd", NORTH + 0xb7000, 11, 3),
> +	[3] = SDC_PINGROUP("sdc2_data", NORTH + 0xb7000, 9, 0),
> +};
>  
>  static const unsigned int sm8250_pin_offsets[] = {

Could you also remove the special pin entries at the end of this array?

Kind regards,
>  	[0] = SOUTH,   [1] = SOUTH,   [2] = SOUTH,   [3] = SOUTH,   [4] = NORTH,   [5] = NORTH,
> @@ -62,7 +91,12 @@ static const char *sm8250_get_function_name(struct udevice *dev, unsigned int se
>  
>  static const char *sm8250_get_pin_name(struct udevice *dev, unsigned int selector)
>  {
> -	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +	if (selector >= 180 && selector <= 183)
> +		snprintf(pin_name, MAX_PIN_NAME_LEN,
> +			 sm8250_special_pins_data[selector - 180].name);
> +	else
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
> +
>  	return pin_name;
>  }
>  
> @@ -76,6 +110,7 @@ static struct msm_pinctrl_data sm8250_data = {
>  		.pin_offsets = sm8250_pin_offsets,
>  		.pin_count = ARRAY_SIZE(sm8250_pin_offsets),
>  		.special_pins_start = 180,
> +		.special_pins_data = sm8250_special_pins_data,
>  	},
>  	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>  	.get_function_name = sm8250_get_function_name,
> 

-- 
// Caleb (they/them)
