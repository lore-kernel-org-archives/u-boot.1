Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D54CCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68C3E82A9E;
	Mon, 27 Oct 2025 07:40:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fZUNZbKD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1079C82E34; Mon, 27 Oct 2025 07:40:45 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC59380422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tkuw584924@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-269af38418aso49126145ad.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761547241; x=1762152041; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dNBJ31F7xx3O4l39QAmaucJLdT6E2Ol4LiTpcyfuJ7A=;
 b=fZUNZbKDfHNc0EG99cTjZiaKVdXaFu6nCQjFNCugPVOPAm0gZW8jZG6H/+l+h5U97x
 fIUJ1wIFFA6YQUrScuhVc0jQpxsgY5WxHTfRIdiWL1OIGkX0X2iBLqtuXS5kF60HmIwT
 +Jvd+OkKytsiTJHlq+D19WXT0N7h+fhKnCDw+btZiaHzrqZNldWRok2KNypOMF80v3Pr
 E037CymFDCeKmmBiyojDziEG8vi6MK0cfkQwWFWZ/6wKm4fNMUkzuGMIotTxXbkMTYCY
 qEcATF95bDiqyvqgH/TOcrOnSfwqyq8lkSU1GvYesBKn8CAs4Yk2PeQI//jCJtTd8t+u
 29yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761547241; x=1762152041;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dNBJ31F7xx3O4l39QAmaucJLdT6E2Ol4LiTpcyfuJ7A=;
 b=KZGVSxzSjDHTaOAZqTf0sJEHGJcNp9McZxEDKjkrTVoSAm25udiePxf+ehF0Ena6HH
 3MHFAqb0DRHyvZ1b4IxhJjD9rObM/PR3Jko+OOkDMyjT2r+XryTF0V6iV6rAWbuZaGUJ
 8LTKGKXhoRFFAJQZrjJw76ChAq40kSV/VKR1YriiPDTRfOBTKKpT3U2O0CD9V4eM7kXX
 OAVuu5rNFPwFu7DT+xfjUJYVmXXlI30ya65uGvAYN84c+IUkeiaYNnayWV6CrTmSt+ci
 i7O5b8XBlf06KDRJeqZQ02I+HlSQwb41SyVOurlObK+8MorqWiGD0wGFw70u7g/lorqJ
 hhpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvvgShaVCLE7WbCOPg7tzde8vthDSFQaQUcrLiVaMSxMVpDZUQWkqree1HTnYfxJN0Wr1anc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+/EUsPD4L/4GsT+hckLJu8rF86S+Lgvmx386hdtY/MV7SlCFN
 f9hzQJeA+YqBdkQASMkGUt4bvKk7kRBQp8qsy5Ew9B9YL4Vn1rv/NLP4
X-Gm-Gg: ASbGncu2jfnBADSQJqWG5Ks8ux/F8airZCJk3zetU90Oi1dPnsZGHEo5Y72IieN2jHs
 oc97+HmqmcZTvF8Si9PjjWGT3ATiYaagg69TKBVpcmQo5JqChVkSAxen7P0sPVTZp/Uz0jKNFv5
 V4sLQxb1npPTmSF9HArL7ivYwePyCMVa0SjDmLuxW5ProRuFxwZfSyeaoqUlQ6hv2ORqMOLHIGa
 HgS4fTIqB9eVcAROdl1BrnsCkHjkQ+kxqBBHfR8Sjlvq1GyJ5oOwbGUIc3Y9vxWVcaQnQXpdIzD
 D14pBdvrzJn9MzwbgbScy+Uv0vmT/UdvqpG6seW09vI9iZvbCzeHlQhcJqWy70zJbFSvYK1zYSq
 FoWxyrTy4k3MHgTEcrKj//E3OH6zG86Irvtx/fqixvtjJvHDT32yiEYk6jFYcGrHMPnBB89HHSg
 BVY6Dg+vdM5atp52VqOWTkD2b8VuO+kEhBEQHYGsESpf8j/XAyabh4bNjsJho8
X-Google-Smtp-Source: AGHT+IGIOa9NytdEf7hWrBfhFpImcO+fdWfi9ga7Ocv/3XqxX97aVjAGY9s0eAoi1GYYAzDuy8Pm9g==
X-Received: by 2002:a17:903:1746:b0:269:a4ed:13c9 with SMTP id
 d9443c01a7336-290caf85146mr425415735ad.30.1761547241106; 
 Sun, 26 Oct 2025 23:40:41 -0700 (PDT)
Received: from [192.168.0.5] (KD106168128197.ppp-bb.dion.ne.jp.
 [106.168.128.197]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29498cf3410sm70834065ad.8.2025.10.26.23.40.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Oct 2025 23:40:40 -0700 (PDT)
Message-ID: <3a61cd70-bf84-4878-8da3-f62b1b1e1199@gmail.com>
Date: Mon, 27 Oct 2025 15:40:36 +0900
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
 <020c68a0-b5ad-4fec-91bb-a75effa15143@gmail.com>
 <44de860f-f910-461d-bb95-afb8ca6ee194@linaro.org>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <44de860f-f910-461d-bb95-afb8ca6ee194@linaro.org>
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

On 10/23/2025 5:21 PM, Tudor Ambarus wrote:
> 
> 
> On 10/21/25 8:41 AM, Takahiro Kuwano wrote:
>> Hi Tudor,
> 
> Hi!
> 
>>
>> On 10/21/2025 3:36 AM, Tudor Ambarus wrote:
>>> Hi, Takahiro,
>>>
>>> On 10/20/25 8:25 AM, tkuw584924@gmail.com wrote:
>>>> From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>>
>>>> nor->addr_mode_nbytes is set during SFDP parse. Infineon SEMPER flash
>>>> family relies on that parameter to read and write registers. To support
>>>> use cases of skipping SFDP, set address mode in device specific setup()
>>>> function.
>>>>
>>>> Tested-by: Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
>>>> Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
>>>> ---
>>>>  drivers/mtd/spi/spi-nor-core.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
>>>> index 6f352c5c0e2..e382a518a34 100644
>>>> --- a/drivers/mtd/spi/spi-nor-core.c
>>>> +++ b/drivers/mtd/spi/spi-nor-core.c
>>>> @@ -3794,6 +3794,16 @@ static int s25_s28_setup(struct spi_nor *nor, const struct flash_info *info,
>>>>  #ifdef CONFIG_SPI_FLASH_BAR
>>>>  	return -ENOTSUPP; /* Bank Address Register is not supported */
>>>>  #endif
>>>> +
>>>> +	/* Setup address mode here, in case SFDP is skipped. */
>>>
>>> Under which conditions is the SFDP skipped?
>>>
>> In u-boot, SFDP is config option and some defconfig do not use it.
> 
> I'd argue this is a good idea. Maybe for the tiny duplicate version
> of the driver could be, but for the main driver, it's not.
> 
> I'd also argue the tiny driver idea was ideal to start with. Instead
> we should have tried to modularize SPI NOR, by vendors, static init
> and SFDP.
> 
>>
>>>> +	if (!nor->addr_mode_nbytes) {
>>>> +		ret = set_4byte(nor, nor->info, 1);
>>>
>>> why do you need this call? Isn't enough the one done in spi_nor_init()?
>>>
>> The addr_mode_nbytes is refereed in spansion_read_any_reg() during
>> setup().
> 
> Right. So you set it twice. Can we set it just once?
> 
> I guess you can feel my disapproval about where the code is leading to if
> we continue like this: unmaintainable code.
> 
Yeah, I will revisit to cleanup and isolation.

Thanks,
Takahiro

