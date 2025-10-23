Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16604CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 08:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 834978323A;
	Thu, 23 Oct 2025 10:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OoDhYSdi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4093D83303; Thu, 23 Oct 2025 10:22:00 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3B58006D
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 10:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-63c12ff0c5eso1203538a12.0
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761207717; x=1761812517; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iBIcpOoI8sLHCJNIBctAZisTgPa/jhhcqD5qVhi0A6k=;
 b=OoDhYSdi4gg9XwaVYB5l1bcPrR6GxGl7dBDmdCO8P7pMYRPHLNOPYqsOzTksrBl3Sy
 4b6mwDpRRWHEDQ7Nva+6eTKcjZEjVs180ZBIooha7c5dZ8rsZCRwxMCQUMhOT5j9mx/Q
 urVV8PQSmb8PKFLItrvn6XatoAgZ4xh2+1Mk8hO0Wj67A5EaJVhxxlp/DKLVColhMdG/
 DXsOb7mUXvGjcfbzdtAfHdsLZ6htbBqexYWic4E4/OWXH8NmlQvon9j17XA/Cj+kOC0M
 6wZ8IxieFyvYzNkUYNijSL92K2/lGU6Pz/LG0CAarB9kOT+xliKrZ3lEenNhy7VYAoBp
 4D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761207717; x=1761812517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBIcpOoI8sLHCJNIBctAZisTgPa/jhhcqD5qVhi0A6k=;
 b=cbcVFNF/HxiKKJ3XzfbZwvK9eRVcvA5JMyjH6liwQmPraoOFD9rFtslj+ai2VYFeQu
 GM7w+D+lAdWNSZZHWbC9/YW+S5s+INjslbpyIBDskhBWykg2X0PzlUrVJKXL/j2/eZs/
 yoWNX5lliOu9mZqaHCfCvhRkqVwQxVEKuS+cB2ekWZ/5YK7QofFLZwjAlXMIlJMlYBzr
 dacCTSP8iJwqzK93rPUUFwjwgjijC0hQpFDpYrqp+WFMem35XCbPcDHnz/aewdoUuDvJ
 xoFvbnxXiTkgVoQgke/hwjwLt44a6JToN0gztTzTwf/g75X7XjWNBN0JHd1SUfMqeja4
 3gyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj8bSp4SOfZZbxCq/niV21GEL7LaYyCB5Ln1XgktcxMSI7O1+ShXVtiXvbwwMkfc7INVf+apA=@lists.denx.de
X-Gm-Message-State: AOJu0Yx24aXJXAw8HgzgtytriBoKlyjI02K1r99iZITYAzHmRnPNur7y
 OR28lI2wKqByZ4FEf2t3Vr4PS1JTrbhyRFTuWNtW8QE2cOWdK2uVKFrR7uIHrJqboEw=
X-Gm-Gg: ASbGncsX3BU1oblbXKunhzZQe6oN2lgCnKafW3OUgL/NXm/TL2qjhXs3wjkpGCjVHOY
 ATUa7hhBSpJs5L1hBggcj6v3yfRy8ZDqSf9lGIdrSGRz8UTcuzxh3j7SMx1GPsNP12dzL2B8OwW
 afeO4XvM780vGGNuA1ljctkWYaGTGm+mV0Ze4vW838fDVy/h69e1F+thUHniqlp2x1+V8xi3NLK
 DRR+5MDuoD7GnspL10Ez4PbQ/TrvltOi5QEy2gVXZdeESub3v3wisZHn4ha6c138itGtxpaY9kx
 u+gIrsychPNCS4v6TsUis34dcyNCZRsNCqL5IXHCXEJn7KQXyJhIndWcEFRD2Tw8eedCOqMjtJp
 qOvliY9MVztTJ1osD6TSZNM+HJ3sl9WaDtwoTxD+lwbFjmt/6A50EM+0EC5S2tAlOLQ0Guiog6P
 farTMvvNxT
X-Google-Smtp-Source: AGHT+IEnlwYO3F1FhXTKDcuJarKTFbjw0U4tRtR+8Ri/Dw+7VTliktWA5xECNcLr2Txb3fEj3fVGYA==
X-Received: by 2002:a05:6402:d0e:b0:61a:7385:29e3 with SMTP id
 4fb4d7f45d1cf-63e173ce7f3mr6120975a12.18.1761207717284; 
 Thu, 23 Oct 2025 01:21:57 -0700 (PDT)
Received: from [10.11.12.107] ([79.115.63.145])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e3f3349b3sm1087615a12.37.2025.10.23.01.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 01:21:56 -0700 (PDT)
Message-ID: <44de860f-f910-461d-bb95-afb8ca6ee194@linaro.org>
Date: Thu, 23 Oct 2025 09:21:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Set address mode in SEMPER flash when SFDP
 is skipped
To: Takahiro Kuwano <tkuw584924@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 venkatesh.abbarapu@amd.com, Shinsuke.Okada@infineon.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
References: <20251020072528.10279-1-Takahiro.Kuwano@infineon.com>
 <7f46828a-94b5-4e63-a18c-ec139484275e@linaro.org>
 <020c68a0-b5ad-4fec-91bb-a75effa15143@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <020c68a0-b5ad-4fec-91bb-a75effa15143@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 23 Oct 2025 10:27:17 +0200
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



On 10/21/25 8:41 AM, Takahiro Kuwano wrote:
> Hi Tudor,

Hi!

> 
> On 10/21/2025 3:36 AM, Tudor Ambarus wrote:
>> Hi, Takahiro,
>>
>> On 10/20/25 8:25 AM, tkuw584924@gmail.com wrote:
>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>
>>> nor->addr_mode_nbytes is set during SFDP parse. Infineon SEMPER flash
>>> family relies on that parameter to read and write registers. To support
>>> use cases of skipping SFDP, set address mode in device specific setup()
>>> function.
>>>
>>> Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
>>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>> ---
>>>  drivers/mtd/spi/spi-nor-core.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
>>> index 6f352c5c0e2..e382a518a34 100644
>>> --- a/drivers/mtd/spi/spi-nor-core.c
>>> +++ b/drivers/mtd/spi/spi-nor-core.c
>>> @@ -3794,6 +3794,16 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
>>>  #ifdef CONFIG_SPI_FLASH_BAR
>>>  	return -ENOTSUPP; /* Bank Address Register is not supported */
>>>  #endif
>>> +
>>> +	/* Setup address mode here, in case SFDP is skipped. */
>>
>> Under which conditions is the SFDP skipped?
>>
> In u-boot, SFDP is config option and some defconfig do not use it.

I'd argue this is a good idea. Maybe for the tiny duplicate version
of the driver could be, but for the main driver, it's not.

I'd also argue the tiny driver idea was ideal to start with. Instead
we should have tried to modularize SPI NOR, by vendors, static init
and SFDP.

> 
>>> +	if (!nor->addr_mode_nbytes) {
>>> +		ret = set_4byte(nor, nor->info, 1);
>>
>> why do you need this call? Isn't enough the one done in spi_nor_init()?
>>
> The addr_mode_nbytes is refereed in spansion_read_any_reg() during
> setup().

Right. So you set it twice. Can we set it just once?

I guess you can feel my disapproval about where the code is leading to if
we continue like this: unmaintainable code.

Cheers,
ta

> 
>> Cheers,
>> ta> +		if (ret)
>>> +			return ret;
>>> +
>>> +		nor->addr_mode_nbytes = 4;
>>> +	}
>>> +
>>>  	/*
>>>  	 * S25FS256T has multiple sector architecture options, with selection of
>>>  	 * count and location of 128KB and 64KB sectors. This driver supports
> 
