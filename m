Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7879CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B62183CB9;
	Fri,  7 Nov 2025 11:52:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fYgEjY/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1DF83CF7; Fri,  7 Nov 2025 11:52:08 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24AF283CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:52:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640b9c7eab9so1179243a12.1
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762512725; x=1763117525; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nbRLKF5GTdxkCcR/k3sjPZBs7Fu1IxMhjGmMSzRnkLg=;
 b=fYgEjY/ttAQFT0YKnGgZF2z0V2XzMK01EmFumWVJ93zI5KkZRlgBriniMSKGaR84dM
 y47PnED70TpEfI2NC3MvGYVbPKzm6+v+YqtnQ+nchgFNU+QCt0WW5hlwEstwpUhQLVBA
 gm1xLV5o0lZXocYKSCwRmQ4vCRbb8shYi4NwrMXNU/Nm4AOEXYT14oDJnccf1Bi6+dc6
 HVTJ1udXp7mVfCb8ZgsHTKnd5V+1Cb0H5sAPPJjca62MG2WjNAOiAaktx4KejzKEuSLH
 uKcaT9JkUPkxaseAQdRhoJQdTXp+6KyQL8Pmk063bGZjccs2BHTk2qq6QpwPSXG5R2j3
 R9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762512725; x=1763117525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nbRLKF5GTdxkCcR/k3sjPZBs7Fu1IxMhjGmMSzRnkLg=;
 b=kJuOP7G33oaWr/o9SOK241NaK5xdCWidCwdiLBsHL8+xEEUDzE+fT1VxR3NsXmhnJU
 3oG1I+qhLXyjeadCdd4lc08vUDAybuEy2yBedajSJv7xQZGQpn5ZWQX6rEDUbXsvVLWE
 Fs72tkCXKpFg7ODmZWUFwZG0eRdvssyza44ruIIC+jbNhIp2wYSNVBsNpDbekcUMWVWj
 EfmxSL6SJ/CFftb0/+D70RkrdSbO3TNkuqCPou2E0i/YYo5221wLbpb8QInU9/0CsWdW
 ElHY2Ndl/wnoQZFzSQMTR6kmm/XWM7l8kfs4j2/zO4HtrNk+6AMnqBlWbHniT7KTXG5y
 XMMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4liWgz8JSquKr2FW6oNennIvvP/uEid1iceL61T0N9sF/8g4wzvdhjfEuaByGRum/qMqqj7A=@lists.denx.de
X-Gm-Message-State: AOJu0YyIGABXuCiHb3v85xQb4WerPk7uKwBFtGiq2zn0++WyHT3VzoD7
 9y0Xh5o/lOL3m7q9bh7ub4U0+NdSp4NowkWq5x8JZD5CKncApsuGEL1UU8QiKEzo6ws=
X-Gm-Gg: ASbGncvU9K7q0Y4rLlnEx4rsFPUp/o72qZYNnYKNvpYBI+FnTCvc+eNNtoEHP3huCfx
 bK8Sjw1EtpeBYsPIcMJRjVx+pkyPzGcqkWsb8L5qVnrgv6uLwlE0WQFpDiEIJ9QAPLszJaHNxhi
 KFNvhQ24lb0o6uUBmz2XRBvObjyG1w+vfk1vT+rQb4hLnXRxz3PV9DEo4lMSaX4cRY+Uv/VCNmx
 M7E9Qo4PyN8yU2tXwtyUsUh9t/yRXrXkseokdr7rD25xTtBdAtLq3gwi5DYjq3ZfWyAStqIOIc6
 iLIqiDBBvyTpUabqxk5wazQ45Rb3qvd7ypABY6XRhkIDW+XdBcUQAbiLrDyFPheVsmzA8H78+Sd
 m5uZAhvlwQU6AozEL8rZoyd8uSiS0EVK1f9GviPr19B/u2ybzdXJTptbpGs6fKbOZbgEnS7OSYI
 1VavTw9yCRLdi85+rZHyGhjnrUdfvBaVA=
X-Google-Smtp-Source: AGHT+IG0ZF2ookssx4DA7wsND6NrFNIFQeXQR9DvHuhIFMgn1BOsGW4HI+6wayYJ2gAST1OMrovJoQ==
X-Received: by 2002:a05:6402:51c8:b0:640:a03a:af98 with SMTP id
 4fb4d7f45d1cf-6413f0da013mr2575171a12.18.1762512725541; 
 Fri, 07 Nov 2025 02:52:05 -0800 (PST)
Received: from [172.20.148.34] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f8578ecsm3781027a12.19.2025.11.07.02.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Nov 2025 02:52:05 -0800 (PST)
Message-ID: <e0a9b9af-330c-4504-8ef3-ba4c3433ce4f@linaro.org>
Date: Fri, 7 Nov 2025 12:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mtd: rawnand: atmel: set pmecc data setup time
To: Zixun LI <admin@hifiphile.com>, Alexander Dahl <ada@thorsis.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-1-a1f3cf430be9@hifiphile.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251106-pmecc-v1-1-a1f3cf430be9@hifiphile.com>
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

Hello Zixun, Alexander,

On 11/6/25 13:12, Zixun LI wrote:
> Setup the pmecc data setup time as 3 clock cycles for 133MHz as
> recommended by the datasheet.
> 
> Backported from Linux: f552a7c7 ("mtd: rawnand: atmel: set pmecc data
> setup time")

Maybe use 12 digits commit hash ? I cannot find this commit in Linux

> 
> Fixes: a490e1b7c017c ("nand: atmel: Add pmecc driver")
> 
> Signed-off-by: Zixun LI <admin@hifiphile.com>
> ---
>  drivers/mtd/nand/raw/atmel/pmecc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
> index e500a0fe3f8671ff08195c94c3383696a7731eb3..7c4e9bd5f9967b119239adf2b39e683ea62b71fd 100644
> --- a/drivers/mtd/nand/raw/atmel/pmecc.c
> +++ b/drivers/mtd/nand/raw/atmel/pmecc.c
> @@ -142,6 +142,7 @@ struct atmel_pmecc_caps {
>  	int nstrengths;
>  	int el_offset;
>  	bool correct_erased_chunks;
> +	bool clk_ctrl;
>  };
>  
>  struct atmel_pmecc_user_conf_cache {
> @@ -840,6 +841,10 @@ atmel_pmecc_create(struct udevice *dev,
>  
>  	pmecc->regs.timing = 0;
>  
> +	/* pmecc data setup time */
> +	if (caps->clk_ctrl)
> +		writel(PMECC_CLK_133MHZ, pmecc->regs.base + ATMEL_PMECC_CLK);
> +
>  	/* Disable all interrupts before registering the PMECC handler. */
>  	writel(0xffffffff, pmecc->regs.base + ATMEL_PMECC_IDR);
>  	atmel_pmecc_reset(pmecc);
> @@ -884,6 +889,7 @@ static struct atmel_pmecc_caps at91sam9g45_caps = {
>  	.strengths = atmel_pmecc_strengths,
>  	.nstrengths = 5,
>  	.el_offset = 0x8c,
> +	.clk_ctrl = true,

This appears to be done only for sam9g45.

So, Alexander, this should not impact sam9x60 .

I looked a bit in the Linux driver and this appears to be just as bad:
133 Mhz clock config hardcoded. I would expect this clock to be taken
from a clock input and not hardcoded. But oh well, if this clock is to
be changed in another device, it would be exposed somewhere...

Eugen

>  };
>  
>  static struct atmel_pmecc_caps sama5d4_caps = {
> 

