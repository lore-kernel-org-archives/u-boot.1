Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057E8EB64DE
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5FEB89095;
	Tue, 10 Sep 2024 14:56:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KMLZ/vPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFA587EF7; Tue, 10 Sep 2024 09:38:55 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 826F587873
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 09:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so5828485e9.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725953933; x=1726558733; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LesTSiqn5EhuMVSzwC9pJrnFzs/buwCiR/qoldFs37U=;
 b=KMLZ/vPGp9Jkvu+GG9RWp0Ts2CMqhKsBtHvUbVGQKpL5HK/sZ2nmRJNukRqajRH3+0
 eME07cqB+tDwShg/zm5PzbDOImyGh6S6qf8zMQJ7yf0H0k1QyeLI7KaLiKwfOjxpk/AZ
 iSxb8IiTHB4pqfMn9EzBV6wXMIiH/M2eim9QNHG8i+BB2tLsqyGOU1u2eGrS72IadCpq
 ukT+JQCffg2VHlDCk0cMKMvI6+z3QwM6nKk1/cw/hxu7BNAY/D5c8lMkOmFlhPB1oyqa
 OZmktxFt5KcZzPvD5Zqirf4+Rh1LYybnWzhqMMEeGQFfM6Zhbsh/VspjrqN8Rwp4xE0H
 IBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725953933; x=1726558733;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LesTSiqn5EhuMVSzwC9pJrnFzs/buwCiR/qoldFs37U=;
 b=W1q2C5OvDUEK8c6L42bGtZk5nrVPIub6d42CfJByadHTsxQ9hxw1pobbBiVuA4EkM7
 yOfIVHY+BosgVVBylTs+GfHuvqnVIbzaJdWOKyeigdI3ojfgYNjFd9GrYN2cMrKrq5Og
 Tqr3g9KEhIJDUjXIYo70C/J/zVYaCCJf03X0GPGYD2yTDPUcdfSNZPaAqyCYnTjYKPhC
 WvKtrR+x+z+qXZRX3u41u5h7cQv+46dLpv9q3RPgCTQME7efijMPgQIRV27qG9NVLxWe
 3BLBsihpQ40kj3MXwZfKPi5e0bXljb72oag5qOCbDrTROKk+8slHXR9POlkt3lO/aEV6
 NLMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWseYNT9fFF9PlGd8ac2cfWnyqgQaFV7wjM7H60B5f42gLF3/VAxkqgWAW2eeHOCVRqAWSuJPI=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1E3qcPh8qVzZv3EZrLzIeCQ1oJL6NVkIwkA02aXB/PG9CbhYW
 9IiW3zm5iC38OpUu+AHr3cBR+dUNUeq+KUKuCaWt1gp+tTG3vnqrN+Kwa6pebxI=
X-Google-Smtp-Source: AGHT+IH3DAKa7vqfLwLQ+AwjAcr2P8tXQE8M1ocBXe7aMpud7w+J+wyTgX/HHQmBK8rTveHbAFhm9w==
X-Received: by 2002:a05:600c:1d0e:b0:42c:bae0:f05f with SMTP id
 5b1f17b1804b1-42cbae0f237mr38924835e9.13.1725953932042; 
 Tue, 10 Sep 2024 00:38:52 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dbf42sm8028201f8f.102.2024.09.10.00.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:38:51 -0700 (PDT)
Message-ID: <bb38351e-2e2a-4127-885c-e42b84950558@linaro.org>
Date: Tue, 10 Sep 2024 10:38:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor: Remove SPI_NOR_SKIP_SFDP flag
To: tkuw584924@gmail.com, u-boot@lists.denx.de
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, mwalle@kernel.org,
 pratyush@kernel.org, Bacem.Daassi@infineon.com,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
References: <cover.1722917617.git.Takahiro.Kuwano@infineon.com>
 <b87c372691e30ea19d71858cfc2c06b96337b1e7.1722917617.git.Takahiro.Kuwano@infineon.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-US
In-Reply-To: <b87c372691e30ea19d71858cfc2c06b96337b1e7.1722917617.git.Takahiro.Kuwano@infineon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 14:56:36 +0200
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



On 08.08.2024 09:00, tkuw584924@gmail.com wrote:
> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
> 
> This flag is not used in INFO table so checking info->flags has no
> effect.
> 
> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>

this patch can be send on its own I guess. Maybe Jagan can take it now:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/spi/sf_internal.h  | 9 ++++-----
>  drivers/mtd/spi/spi-nor-core.c | 5 ++---
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/spi/sf_internal.h b/drivers/mtd/spi/sf_internal.h
> index d3ef69ec74..57608750c9 100644
> --- a/drivers/mtd/spi/sf_internal.h
> +++ b/drivers/mtd/spi/sf_internal.h
> @@ -64,11 +64,10 @@ struct flash_info {
>  					 * to support memory size above 128Mib.
>  					 */
>  #define NO_CHIP_ERASE		BIT(12) /* Chip does not support chip erase */
> -#define SPI_NOR_SKIP_SFDP	BIT(13)	/* Skip parsing of SFDP tables */
> -#define USE_CLSR		BIT(14)	/* use CLSR command */
> -#define SPI_NOR_HAS_SST26LOCK	BIT(15)	/* Flash supports lock/unlock via BPR */
> -#define SPI_NOR_OCTAL_READ	BIT(16)	/* Flash supports Octal Read */
> -#define SPI_NOR_OCTAL_DTR_READ	BIT(17)	/* Flash supports Octal DTR Read */
> +#define USE_CLSR		BIT(13)	/* use CLSR command */
> +#define SPI_NOR_HAS_SST26LOCK	BIT(14)	/* Flash supports lock/unlock via BPR */
> +#define SPI_NOR_OCTAL_READ	BIT(15)	/* Flash supports Octal Read */
> +#define SPI_NOR_OCTAL_DTR_READ	BIT(16)	/* Flash supports Octal DTR Read */
>  };
>  
>  extern const struct flash_info spi_nor_ids[];
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 54fd2869a2..feafc48a49 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -3013,9 +3013,8 @@ static int spi_nor_init_params(struct spi_nor *nor,
>  	/* Override the parameters with data read from SFDP tables. */
>  	nor->addr_width = 0;
>  	nor->mtd.erasesize = 0;
> -	if ((info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> -	     SPI_NOR_OCTAL_DTR_READ)) &&
> -	    !(info->flags & SPI_NOR_SKIP_SFDP)) {
> +	if (info->flags & (SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +	    SPI_NOR_OCTAL_DTR_READ)) {
>  		struct spi_nor_flash_parameter sfdp_params;
>  
>  		memcpy(&sfdp_params, params, sizeof(sfdp_params));
