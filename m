Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81120CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 07:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2623831D6;
	Tue, 21 Oct 2025 09:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sli+aDM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B426833F6; Tue, 21 Oct 2025 09:41:49 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFE2A8004F
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 09:41:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-79af647cef2so4461905b3a.3
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761032505; x=1761637305; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fRrTtWZ721d2rGOiJd4+wGuMaIMihZUbA+wREfH4owA=;
 b=Sli+aDM+scsc1pT790KeMtX6A6qrYmJpKb5VypRgATa9GTfTanZmsUu7S4iFSjAomt
 dC1hHDPp9/LqdoSZ++rMLxZBa0i6iOBM+zWRAHEIIrgnyhkgTrzgqY/aaXkAZrUiM+S0
 y23MCGd1CCfm7Chv/ft6K6QMFRm/nygYoxkJY2+LC5L3bgA23td9M+WmFY28YXDawSmK
 OgtNCLSHSOVouUaEwcj4ySn8yTcFpiaHI0bUpXsMcARTuSFvIhH0K3J9EGu3rPr1bMQ3
 87K1Krk5ftY6rtE4QqEIfiBCyow5CnJ6fuzojNWIwI4VzCKD9uf3YxDgIABIjvRdnVCX
 G0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761032505; x=1761637305;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fRrTtWZ721d2rGOiJd4+wGuMaIMihZUbA+wREfH4owA=;
 b=NvBq0oI4AU3UFwvA4PFERWBMACHTPSS86WQAMk2CV0poi3k8oXm24hI+jnwOqFMxSm
 22ReQIT2erTz8S2yxerVEvkQOmKfRVIPfxi9OmSsqp+Uw2DuunK6xmaXb7r5hLK++CjD
 zPjNolqLsvxJXiXT2MqSVnP/whvJza0Ma8mGyOiG+01Kh5zsbeNNja0Qs5raISbQytVm
 09+OWnTV3bhEa9B56zqUB4dZ49lc2akl/nMakDwY3vDkzkGAFTv85wwkhjytJOD59Kbg
 EnUo7QnLUTbcWr5y/n9zdogPuuIot8ZDb1R3yYMOpy/DImMMNh/Hbc3RUeGXwcxYLoxO
 38yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVx7sSzBtaIFfc09Q8j2NO3E7A1hHXFs4CdJuDBDtl48JzloXNxlZEh1Lj2ypcmdFExdj5UXiE=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8MjipuckjikbnSDuMkhsVrkcsOfz2NFsHXdhPxtFkqCSA1DX9
 2eFntnrXL9SI1isE6EvTbueUFynrQQ9iWQoqmZsEaS3HPmieO/UBwjTK
X-Gm-Gg: ASbGncu2F4XIYu6XO4p05Q1DlePMFml79cx85TjKJjjaFdGJ1zd4pJTVxu6dteu576A
 fzP90S3xq5HqIu4F7lVXcGXS6ayimZHahqAsSlL1ns2UxJ+BjQu2t6g/f3RNscpRU7nFkxX/9j3
 Im7keaQQ2r26KZzr2wB/E+Sownje+SIEtC+8ic1HqKTIc2Lz30O8KP1KvtQ0HByeK+7SNUeBwmy
 eJefU8FQCb/fvGlFVw1TwccvxEgFUbbpNLrlwnKjj19XzJyNrTbEqGkwWfb7vwWJLGpzJYBz2OO
 9m+FuwvZMBnJ09/F/l/Bp29iVIxgOaiaz4e0Vt+nykohr9ff+I16rNigRqqOza8gOD1fbNkeZgg
 FJRAfY6nk6plDQO3e7eiop6WbdBGv8L4U6kGTlNQdUaONggSrnd7IsnOB0mDpFTra90iJ/WQ2u6
 80FmENJAGXTA3oYS64Hs7o97Ktx6M195HCobv8qpJdHjBBa4qy0PI/RK1mqMgX
X-Google-Smtp-Source: AGHT+IEvKIRvkcigZFvIu5q76CJQFwZjr9VV7h49xwqDouOpMWj/X/h2OufJ89kauGNVUg9r9XP6sw==
X-Received: by 2002:a05:6a00:8d3:b0:77f:620f:45bd with SMTP id
 d2e1a72fcca58-7a220a455bcmr18637136b3a.7.1761032505312; 
 Tue, 21 Oct 2025 00:41:45 -0700 (PDT)
Received: from [10.52.184.151] (sp49-96-229-144.msd.spmode.ne.jp.
 [49.96.229.144]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a23010df83sm10457409b3a.59.2025.10.21.00.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 00:41:44 -0700 (PDT)
Message-ID: <020c68a0-b5ad-4fec-91bb-a75effa15143@gmail.com>
Date: Tue, 21 Oct 2025 16:41:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Set address mode in SEMPER flash when SFDP
 is skipped
To: Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 venkatesh.abbarapu@amd.com, Shinsuke.Okada@infineon.com,
 Bacem.Daassi@infineon.com, Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
References: <20251020072528.10279-1-Takahiro.Kuwano@infineon.com>
 <7f46828a-94b5-4e63-a18c-ec139484275e@linaro.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <7f46828a-94b5-4e63-a18c-ec139484275e@linaro.org>
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

Hi Tudor,

On 10/21/2025 3:36 AM, Tudor Ambarus wrote:
> Hi, Takahiro,
> 
> On 10/20/25 8:25 AM, tkuw584924@gmail.com wrote:
>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>
>> nor->addr_mode_nbytes is set during SFDP parse. Infineon SEMPER flash
>> family relies on that parameter to read and write registers. To support
>> use cases of skipping SFDP, set address mode in device specific setup()
>> function.
>>
>> Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>> ---
>>  drivers/mtd/spi/spi-nor-core.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
>> index 6f352c5c0e2..e382a518a34 100644
>> --- a/drivers/mtd/spi/spi-nor-core.c
>> +++ b/drivers/mtd/spi/spi-nor-core.c
>> @@ -3794,6 +3794,16 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
>>  #ifdef CONFIG_SPI_FLASH_BAR
>>  	return -ENOTSUPP; /* Bank Address Register is not supported */
>>  #endif
>> +
>> +	/* Setup address mode here, in case SFDP is skipped. */
> 
> Under which conditions is the SFDP skipped?
> 
In u-boot, SFDP is config option and some defconfig do not use it.

>> +	if (!nor->addr_mode_nbytes) {
>> +		ret = set_4byte(nor, nor->info, 1);
> 
> why do you need this call? Isn't enough the one done in spi_nor_init()?
> 
The addr_mode_nbytes is refereed in spansion_read_any_reg() during
setup().

> Cheers,
> ta> +		if (ret)
>> +			return ret;
>> +
>> +		nor->addr_mode_nbytes = 4;
>> +	}
>> +
>>  	/*
>>  	 * S25FS256T has multiple sector architecture options, with selection of
>>  	 * count and location of 128KB and 64KB sectors. This driver supports

