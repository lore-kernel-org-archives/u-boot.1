Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CC2C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 08:44:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C938080824;
	Wed, 12 Feb 2025 09:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gj8ZKtmX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D11280842; Wed, 12 Feb 2025 09:44:25 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBBF2807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-ab7f76aeedbso39341166b.3
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739349862; x=1739954662; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gy4zTm+n9ydUMs397jDwRqGITTu2C26ZdEfG753upg0=;
 b=gj8ZKtmXR5ULS4eCUu2QtOhjjPAqKRsRwuHdmZcSwzrh4vWiFhb8Qxt5GWDxMdDEG/
 cEn92bvBlcYyU+9t4lNF93Ih2o1AvFX/hZ6EDwUjFfh/EpLP892nP1KeJrrnr0GcWgl9
 idhsZX6FJyY04YcQww47gi8+s1yMifTJMzIvWRC5Alp/ltP54W/HR7/QwFSzWpZqo2/G
 qpJ0qdDyqYzFLjat28UnwTgCkeAZGWLaFXOpMCaojoIE/P3vCeCIsW9n67VIGOt6PV7p
 /In0QN8n7CtZyRjmMhrHcmlZWRDT9V3Cs7TTIkL8Q15wb8AlN7yINXrwA8QqNWKPsezA
 qcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739349862; x=1739954662;
 h=content-transfer-encoding:in-reply-to:cc:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gy4zTm+n9ydUMs397jDwRqGITTu2C26ZdEfG753upg0=;
 b=LiX6tG96fO7sYovuu5qF0y9dLocgx+OBF173XMnXzIPmT2m6L40OiOGZ8Ix9WdM6LM
 p6z1Pwo+AqDBVQoThMG3EzBKpQlr0+AJgPQQ3VT9onNeZlsI8KMg0z8NCq6raYYkcWYC
 rXlEWwbIoFsSF6+m5+D4lkehohxp7r78Nuw8MWQn5N+ddGQvz/wulzEEcnX0EF4oPVml
 DysVfmsUGyuYY9tFDWHezC5xbG7HZSJHwJBg4xt2A9CpdbiTuUUVhSyxNOFfDWRGJTfO
 kW7akL3RyoXrXhs6bDTTYuuM3TkD6Kqfqa2sVWe5LYGoUSH6jVmiRRnaDRz6RaZ/u3jN
 07TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUngsI6gpCRY3oexbhtZA1slL4CMy4k21ClrxmexnHknPcAR4/I72GvfRCDqDcLdA3EHUSj/bU=@lists.denx.de
X-Gm-Message-State: AOJu0YyByxV6fSc7BJapqDizxPtwmw2gf1/dKSd23jlgkv0GOQJi6EtN
 2dPEs+EWtMVG9U56ove0yP2qpOt1md2ZW8XzPTuSL9GK66wSp9WraYbmo8agnxw=
X-Gm-Gg: ASbGncv/+v9y9R6U50OhbrhFYxH0ABqzJhvWJSQUqWjrgJSXMjNmNGIqsHMt2KrgB7a
 lIHpxMvmGdUCDjHr2jiD37lND18Di6IKPst8qsfAwkZ2QHRZl6odykQ18aH60lptAZ5C6k+xeus
 rW8W5KM7eRNLtLRo/CZWUipa01JD45QRx+tu6TwzHW7EbQHg+duQJeGuXvDxNfY+0gOLja0mMmB
 FtAzg7dxtfT0eKUR63nhr7VjhGwsPPDeagoEoCXjTxGHIL1a6gf6OYwS6IS5ssN+drvQ3EHmdQf
 /MqEivYc2dUbISg5GCtZLog=
X-Google-Smtp-Source: AGHT+IEGvy9USeM+0PRkje6on6XWOIcTLezDun7hssnuVsPXj7OljnkU62IYiDox9fJWcA057F56uA==
X-Received: by 2002:a05:6402:518c:b0:5dc:d8d2:e38f with SMTP id
 4fb4d7f45d1cf-5deadde71e1mr5494903a12.31.1739349862191; 
 Wed, 12 Feb 2025 00:44:22 -0800 (PST)
Received: from [192.168.0.24] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab7bc28c58csm622167366b.135.2025.02.12.00.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:44:21 -0800 (PST)
Message-ID: <4702c602-0c81-4153-a7a5-eccf18b58b37@linaro.org>
Date: Wed, 12 Feb 2025 10:44:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] mtd: nand: raw: atmel: Fix pulse read timing for
 certain NAND flashes
To: Alexander Dahl <ada@thorsis.com>, dario.binacchi@amarulasolutions.com
References: <20240415074547.779264-1-ada@thorsis.com>
 <20240415075755.780653-1-ada@thorsis.com>
 <20240528-among-detective-e8ad4c9b5457@thorsis.com>
 <20240930-pamperer-prance-8b4566ba43a6@thorsis.com>
 <3a3cc57c-e696-408f-a050-39502081b6f3@microchip.com>
 <20250212-untidy-rockstar-373666ce4271@thorsis.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
Cc: Bin.Li@microchip.com, Nicolas.Ferre@microchip.com, u-boot@lists.denx.de,
 michael@amarulasolutions.com, Mihai.Sain@microchip.com,
 Balamanikandan.Gunasundar@microchip.com
In-Reply-To: <20250212-untidy-rockstar-373666ce4271@thorsis.com>
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



On 2/12/25 09:09, Alexander Dahl wrote:
> Hello,
> 
> Am Wed, Oct 09, 2024 at 04:45:02AM +0000 schrieb Balamanikandan.Gunasundar@microchip.com:
>> On 30/09/24 1:37 pm, Alexander Dahl wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>>
>>> Hello,
>>>
>>> Am Tue, May 28, 2024 at 12:32:44PM +0200 schrieb Alexander Dahl:
>>>> Hei hei,
>>>>
>>>> Am Mon, Apr 15, 2024 at 09:57:55AM +0200 schrieb Alexander Dahl:
>>>>>  From reading the S34ML02G1 and the SAM9X60 datasheets again, it seems
>>>>> like we have to wait tREA after rising RE# before sampling the data.
>>>>> Thus pulse time must be at least tREA.
>>>>>
>>>>> Without this fix we got PMECC errors when reading, after switching to
>>>>> ONFI timing mode 3 on SAM9X60 SoC with S34ML02G1 raw NAND flash chip.
>>>>>
>>>>> The approach to set timings used before worked on sam9g20 and sama5d2
>>>>> with the same flash (S34ML02G1), probably because those have a slower
>>>>> mck clock rate and thus the resolution of the timings setup is not as
>>>>> tight as with sam9x60.
>>>>>
>>>>> The approach to fix the issue was carried over from at91bootstrap, and
>>>>> has been successfully tested in at91bootstrap, U-Boot and Linux.
>>>>>
>>>>> Link: https://github.com/linux4sam/at91bootstrap/issues/174
>>>>> Cc: Li Bin <bin.li@microchip.com>
>>>>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>      v3:
>>>>>      - initial patch version (not present in v1 and v2)
>>>>
>>>> This patch was send as part of a series, which you wanted to have some
>>>> more time to test.  Besides that, has anyone looked into this
>>>> particular fix?  Maybe it can be applied separately?
>>>
>>> I'd kindly ask what the status of this patch series is from U-Boot
>>> NAND subsystem maintainers POV?  Could you test it?  Should I rebase
>>> and resend?
>>>
>>> Two of these three patches are specific to at91 family, what's the
>>> opinion of at91 maintainers on this?
>>>
>>> Link to the series discussion for reference:
>>>
>>> https://lore.kernel.org/u-boot/20240415074547.779264-1-ada@thorsis.com/T/#u
>>>
>>> Greets
>>> Alex
>>>
>>
>> Hi Alex,
>>
>> Apologies for the delay in response. I also faced the same kind of 
>> problem while testing our new sam7d65 board with MX30LF4G28AD nand 
>> flash. I just had a workaround to increase the pulse time by 5 nsecs 
>> just for testing. The issue has been reported to the validation team and 
>> an investigation is under progress.
>>
>> I would request a few more days for this patch alone.
> 
> Why did the _same_ change I posted here last year in April appeared
> in linux4sam now with different credits? o.O
> 
> https://github.com/linux4sam/u-boot-at91/commit/4175c4c8535ea886e2c0fd99e94ead6bc7a4df5f
> 
> For reference: the issue was discussed in length here before I made
> the patch for U-Boot last year:
> 
> https://github.com/linux4sam/at91bootstrap/issues/174
> 
> Besides: this patch series was still not reviewed and not merged.
> Dear U-Boot NAND subsystem maintainer, what's the status?
> 
> Greets
> Alex

Hello Alex,

As this change appeared downstream, apparently it's validated.

I can apply this as a fix through at91 tree.

Dario do you mind if I do that ? Apparently the patch is now on your list.

Eugen
> 
>>
>> Thanks,
>> Bala.
>>
>>>>
>>>> Greets
>>>> Alex
>>>>
>>>>>
>>>>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 13 +++++++++----
>>>>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> index bbafc88e44c..00ffeadd113 100644
>>>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>>>> @@ -1133,7 +1133,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>>>>>                                        const struct nand_data_interface *conf,
>>>>>                                        struct atmel_smc_cs_conf *smcconf)
>>>>>   {
>>>>> -   u32 ncycles, totalcycles, timeps, mckperiodps;
>>>>> +   u32 ncycles, totalcycles, timeps, mckperiodps, pulse;
>>>>>      struct atmel_nand_controller *nc;
>>>>>      int ret;
>>>>>
>>>>> @@ -1259,11 +1259,16 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
>>>>>                       ATMEL_SMC_MODE_TDFMODE_OPTIMIZED;
>>>>>
>>>>>      /*
>>>>> -    * Read pulse timing directly matches tRP:
>>>>> +    * Read pulse timing would directly match tRP,
>>>>> +    * but some NAND flash chips (S34ML01G2 and W29N02KVxxAF)
>>>>> +    * do not work properly in timing mode 3.
>>>>> +    * The workaround is to extend the SMC NRD pulse to meet tREA
>>>>> +    * timing.
>>>>>       *
>>>>> -    * NRD_PULSE = tRP
>>>>> +    * NRD_PULSE = max(tRP, tREA)
>>>>>       */
>>>>> -   ncycles = DIV_ROUND_UP(conf->timings.sdr.tRP_min, mckperiodps);
>>>>> +   pulse = max(conf->timings.sdr.tRP_min, conf->timings.sdr.tREA_max);
>>>>> +   ncycles = DIV_ROUND_UP(pulse, mckperiodps);
>>>>>      totalcycles += ncycles;
>>>>>      ret = atmel_smc_cs_conf_set_pulse(smcconf, ATMEL_SMC_NRD_SHIFT,
>>>>>                                        ncycles);
>>>>> --
>>>>> 2.39.2
>>>>>
>>>>
>>

