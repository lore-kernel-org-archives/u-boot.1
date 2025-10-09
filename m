Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC54CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 14:58:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069DE844AE;
	Thu,  9 Oct 2025 16:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZBidN/iJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88FF684529; Thu,  9 Oct 2025 16:58:53 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABDA84181
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 16:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso8454575e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760021930; x=1760626730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q1QHzv38hjfVgxFhcwPwNkHEucnQjlJhu3TV+yDBSCI=;
 b=ZBidN/iJ30kzypD3AemYoIgGgHv3Lfz5sGKoCmsCmSJ8K9COKI9ORmDiNiRSWvXCaQ
 rpGNXCUPUF7hwDJnOd3uFevOVie6TwlQEvWgCsv2dRLPvudzN9QB3x0Uj1IYtjqrTGmf
 drrNrb8rob+tcYVT9lg5IdJTO/5xexqNP9WcOEs5bBI+HzEJC/xAVZDj4RpdNtpUwVXQ
 F2YB9URSVdnZbM7mZftzrq2rP19ufRFAk5M7LNUo8GEaGoEgYX6tob/X5rUNYaBNUqBv
 o2xy5QrSQheVuDAeBcKX1DwUCTNVC+KnoGzHX+nbTB4eqlogDnPTl00SceuWNVlY+XhF
 ExXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760021930; x=1760626730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q1QHzv38hjfVgxFhcwPwNkHEucnQjlJhu3TV+yDBSCI=;
 b=BtcGUKivOTPajTbwQklLQXiIhhpnmTcNSkXnoh9Wz5cH6m1z8bZc6TJMQJhLGoFvD8
 he3A449dpPQFTP8nNGE8IW8h9e9CzWgz9dDnHPHiNLmlkqrm6vz73cKZK919ky9CxEBq
 uNT98g/GJVbwVBQviHQP2wsoNFHvhxABb+n14eO46+u47SDU4jjHjMj7M5gGsYmIySPg
 3iQhObYeIJ5JYDT/q3yzDjiRDrYYPoq0HIcRtcLwz1q1/Z9gIoWSM8rTQ9BWeowm+5k5
 fWTuFmYSX5O1tj+tGMveVUGOTf147h1JXVnlCMDhJmqWacuvQ+sPeUtNC1lDRlH5JwZv
 eQCA==
X-Gm-Message-State: AOJu0Yw6UwiVfr6GwlAabYwrA9FgiiITonM27/REcv9kHk9e4lZJgZkn
 iMF3OSv42hYSLHR5v8pybGvyQ0lKfmGlxodsW3HdG0USAlc1GH2ejFXN6DVljjwoZpXLUaJS78Z
 ZE0SPG60=
X-Gm-Gg: ASbGnctACWqTl2EzjYiMNyQBqO3J/qkUCj1N38iKgajTjytqKJJAvNdbwsu9ZY/hzmQ
 0nWhr79cCub63bAnQAWi5eH3Bi45M/lrQMHYSEDIa4XmE1zryi471K2DuPs0BZwD8DwgVPmeP/i
 o6yoF9n3muCbeuHEC/qEz3IK+M6H7tJpPqdSWAwFmESu9JmdWuex3KqEWbGVSaJDcgnMDtxu+Jg
 Z5panXRWsxUKqk7Qz7wdEtvo6YuHwka6CITsP/qWgTdqov1JYRbXBZ/MlvLHj1aZj4B7/Vmp/Aw
 1A6WAkTz1m7nABNdhnhZHyX2f4xsC5kEOBrRf+5nRIwYBu2cDsCs4KgqAjysPw/o8O/b+nDqTGa
 QMcXWzdAOFBswqDW5/gMeaOkjjYxX18b7Za20+8Ihmljf2DJmA84lhtGPUs+AFSmhPrRS
X-Google-Smtp-Source: AGHT+IGbpyFcGNO1AWIcMaoJF9n7Quor2TWKyHEWyvTjWTiy/+XjAZaM7fzHsxdeTWxQdVquTqcSWg==
X-Received: by 2002:a05:600c:5488:b0:46e:45f7:34fc with SMTP id
 5b1f17b1804b1-46fa9b105ffmr54605685e9.29.1760021929973; 
 Thu, 09 Oct 2025 07:58:49 -0700 (PDT)
Received: from [192.168.0.36] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm35798213f8f.50.2025.10.09.07.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 07:58:49 -0700 (PDT)
Message-ID: <0372ee71-0b8a-449f-983e-63ef024e5ac3@linaro.org>
Date: Thu, 9 Oct 2025 17:58:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL
 interaction
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250926153136.3680867-1-trini@konsulko.com>
 <e4db9bab-9de2-4810-ab19-7654be60dae5@linaro.org>
 <20251009142601.GN298503@bill-the-cat>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20251009142601.GN298503@bill-the-cat>
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



On 10/9/25 17:26, Tom Rini wrote:
> On Thu, Oct 09, 2025 at 12:48:29PM +0300, Eugen Hristev wrote:
>>
>>
>> On 9/26/25 18:31, Tom Rini wrote:
>>> The way that the NAND driver under DM_NAND_ATMEL is probed is by the
>>> dummy memory driver controlled by ATMEL_EBI. Rather than require that
>>> for NAND to work both be enabled, make NAND select ATMEL_EBI and do not
>>> prompt for ATMEL_EBI as it only triggers the probe for NAND.
>>>
>>> Signed-off-by: Tom Rini <trini@konsulko.com>
>>> ---
>>> Cc: Eugen Hristev <eugen.hristev@linaro.org>
>>> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> Cc: Michael Trimarchi <michael@amarulasolutions.com>
>>> ---
>>>  drivers/memory/Kconfig       | 2 +-
>>>  drivers/mtd/nand/raw/Kconfig | 1 +
>>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
>>> index eaee739c6aab..591d9d9c6569 100644
>>> --- a/drivers/memory/Kconfig
>>> +++ b/drivers/memory/Kconfig
>>> @@ -14,7 +14,7 @@ config MEMORY
>>>  	  For now this uclass has no methods yet.
>>>  
>>>  config ATMEL_EBI
>>> -	bool "Support for Atmel EBI"
>>> +	bool
>>>  	help
>>>  	  Driver for Atmel EBI controller. This is a dummy
>>>  	  driver. Doesn't provide an access to EBI controller. Select
>>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
>>> index aa4bb2a0595c..f083113486ed 100644
>>> --- a/drivers/mtd/nand/raw/Kconfig
>>> +++ b/drivers/mtd/nand/raw/Kconfig
>>> @@ -50,6 +50,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
>>>  config DM_NAND_ATMEL
>>>  	bool "Support Atmel NAND controller with DM support"
>>>  	depends on ARCH_AT91
>>
>> Which branch is this patch based on ?
>> I have a conflict because this line ^^ is missing in master ("depends on
>> ARCH_AT91")
>> Is there another patch for that ?
> 
> Ugh, yes, sorry, this patch depends on:
> https://patchwork.ozlabs.org/project/uboot/patch/20250711151604.2224243-1-trini@konsulko.com/
> 

Then maybe Dario can pick this up together with the dependency patch ?
