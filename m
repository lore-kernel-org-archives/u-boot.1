Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001B1D41D51
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:39:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87EFF89430;
	Tue, 12 Nov 2024 14:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sTo9LwK8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5117789432; Tue, 12 Nov 2024 14:39:27 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43D19891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:39:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so50186715e9.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731418765; x=1732023565; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4c2TlQ4WEMgaiXhVRguU4phA9JQdiDBBV7C/Epjuz5g=;
 b=sTo9LwK8izWP+lBnRvXwebthzGy8lVQdOZUcP2VqXYPao+ksgWv7LS0gJhLUh5biSD
 cxzDSTh7yX3Lzf81TTnbUaVMmEci+Hd8kd6zAp3qfUtvdp56ginV9zjq7LAyJERvUaX1
 TgJmVj9h791BAM8DFDoZPikVmiEUsNXh8m1Q7n+acEUn6PBDgftg5nvveaZSb6m7A6+f
 W2fJLCUKwNAZmTkTXR8Xa7eid0zvqFp5NjOnzbZM3gcONMvKgZVP6n/0Ju8nrv9JF6mz
 vFnBzyrfqqSDZOlsGJ6Ka+vTgQgQShrbu/LCQXAL69uFPe9RXdY+myxNPpFpIz4z7lmE
 BJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731418765; x=1732023565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4c2TlQ4WEMgaiXhVRguU4phA9JQdiDBBV7C/Epjuz5g=;
 b=rDdIKfcPF4PhvWxtpYSR1I4mYPO9Ez6uCAgEvLLN9AhkCpsKLsCh4Ne9EVaRXRlb6t
 t4ZNCnV97lqTrEpwwhHuYfi6Ar1VhbidXtMSwiZAUh64XKXchP8rAOqubrpEISScuLc5
 2blenqph0rtujtnPTcCNOnmTu9I73NBcP2ViT/V4f6k8fLo0nSswKJ7caEZzN4tBT4Zz
 yLHLUoP5bSSt5ewlwHH0pKWwEa4TO1bCqDtdb+zLFM7o0eGhH9+nN1RPp/8U7PW249lN
 x1ZubINb70ZcsLL6fl5k/ykAllE4hd/nGdPAlNL9ScjOk7AAg4EvPuP9GTwSR3nafDjZ
 agow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkcBxGI9TXSU5l/xe8/cBNrM8m1qqf72kOuCY7uWJOTFG7Z+6UFai0Eso+XmUbPJO1wk+H7Y0=@lists.denx.de
X-Gm-Message-State: AOJu0YxE5VrxZ03cpIXR+8I+2xv6TlGZnusct6bwCF0RYsBbBzEPFZDk
 aQe6PlwTrlZJPr4rt1S/DBzCBHJ93t0I3lDzQBYbOLh1wEb/7RldPBM68Qzxc/Y=
X-Google-Smtp-Source: AGHT+IGNhgSg1oh5nl3U/QTydieEzQa+KM0gr8gDjhJarxxfXYYy5eqXNfuUx8euEU3bpJ0ykX9WyQ==
X-Received: by 2002:a05:600c:1d1b:b0:42c:a574:6360 with SMTP id
 5b1f17b1804b1-432b7522b25mr137723365e9.29.1731418764678; 
 Tue, 12 Nov 2024 05:39:24 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b3505sm243467125e9.15.2024.11.12.05.39.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:39:23 -0800 (PST)
Message-ID: <56e48bdf-0dd0-469a-9acb-7c5b75c1a48e@linaro.org>
Date: Tue, 12 Nov 2024 15:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] mtd: nand: Update NAND manufacturer Ids
To: Benedikt Spranger <b.spranger@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, u-boot@lists.denx.de
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018083006.10349-6-b.spranger@linutronix.de>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241018083006.10349-6-b.spranger@linutronix.de>
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

Hi Benedikt ,

On 10/18/24 11:30, Benedikt Spranger wrote:
> Align manufacturer Ids with the Id list from Linux kernel v6.11.
> While at it, sort the entries in alphabetical order.
> 
> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/mtd/nand/raw/nand_ids.c | 22 ++++++++++++----------
>  include/linux/mtd/rawnand.h     | 23 +++++++++++++----------
>  2 files changed, 25 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_ids.c b/drivers/mtd/nand/raw/nand_ids.c
> index 4f46378ffe1..e40facf774c 100644
> --- a/drivers/mtd/nand/raw/nand_ids.c
> +++ b/drivers/mtd/nand/raw/nand_ids.c
> @@ -180,20 +180,22 @@ struct nand_flash_dev nand_flash_ids[] = {
>  
>  /* Manufacturer IDs */
>  struct nand_manufacturer nand_manuf_ids[] = {
> -	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
> -	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
> +	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
> +	{NAND_MFR_ATO, "ATO"},
> +	{NAND_MFR_EON, "Eon"},
> +	{NAND_MFR_EON, "ESMT"},

Did you mean NAND_MFR_ESMT here ?

>  	{NAND_MFR_FUJITSU, "Fujitsu"},
> -	{NAND_MFR_NATIONAL, "National"},
> -	{NAND_MFR_RENESAS, "Renesas"},
> -	{NAND_MFR_STMICRO, "ST Micro"},
>  	{NAND_MFR_HYNIX, "Hynix", &hynix_nand_manuf_ops},
> -	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
> -	{NAND_MFR_AMD, "AMD/Spansion", &amd_nand_manuf_ops},
> +	{NAND_MFR_INTEL, "Intel"},
>  	{NAND_MFR_MACRONIX, "Macronix", &macronix_nand_manuf_ops},
> -	{NAND_MFR_EON, "Eon"},
> +	{NAND_MFR_MICRON, "Micron", &micron_nand_manuf_ops},
> +	{NAND_MFR_NATIONAL, "National"},
> +	{NAND_MFR_RENESAS, "Renesas"},
> +	{NAND_MFR_SAMSUNG, "Samsung", &samsung_nand_manuf_ops},
>  	{NAND_MFR_SANDISK, "SanDisk"},
> -	{NAND_MFR_INTEL, "Intel"},
> -	{NAND_MFR_ATO, "ATO"},
> +	{NAND_MFR_STMICRO, "ST Micro"},
> +	{NAND_MFR_TOSHIBA, "Toshiba", &toshiba_nand_manuf_ops},
> +	{NAND_MFR_WINBOND, "Winbond"},
>  	{0x0, "Unknown"}
>  };
>  
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 537c62424a1..eaa6ec84b07 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1030,20 +1030,23 @@ static inline void *nand_get_manufacturer_data(struct nand_chip *chip)
>  /*
>   * NAND Flash Manufacturer ID Codes
>   */
> -#define NAND_MFR_TOSHIBA	0x98
> -#define NAND_MFR_SAMSUNG	0xec
> +#define NAND_MFR_AMD		0x01
> +#define NAND_MFR_ATO		0x9b
> +#define NAND_MFR_EON		0x92
> +#define NAND_MFR_ESMT		0xc8
>  #define NAND_MFR_FUJITSU	0x04
> -#define NAND_MFR_NATIONAL	0x8f
> -#define NAND_MFR_RENESAS	0x07
> -#define NAND_MFR_STMICRO	0x20
>  #define NAND_MFR_HYNIX		0xad
> -#define NAND_MFR_MICRON		0x2c
> -#define NAND_MFR_AMD		0x01
> +#define NAND_MFR_INTEL		0x89
>  #define NAND_MFR_MACRONIX	0xc2
> -#define NAND_MFR_EON		0x92
> +#define NAND_MFR_MICRON		0x2c
> +#define NAND_MFR_NATIONAL	0x8f
> +#define NAND_MFR_RENESAS	0x07
> +#define NAND_MFR_SAMSUNG	0xec
>  #define NAND_MFR_SANDISK	0x45
> -#define NAND_MFR_INTEL		0x89
> -#define NAND_MFR_ATO		0x9b
> +#define NAND_MFR_STMICRO	0x20
> +/* Kioxia is new name of Toshiba memory. */
> +#define NAND_MFR_TOSHIBA	0x98
> +#define NAND_MFR_WINBOND	0xef
>  
>  /* The maximum expected count of bytes in the NAND ID sequence */
>  #define NAND_MAX_ID_LEN 8

