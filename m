Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D69ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 13:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1CE89095;
	Tue, 10 Sep 2024 15:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D2zhVySI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 527D18909D; Tue, 10 Sep 2024 14:59:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0555788A1D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cba6cdf32so14907925e9.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725973196; x=1726577996; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2LNlJBgYG8nswm5zwzkwBd1ce5jm3texoe/iTeaHPg8=;
 b=D2zhVySI19ur7jEDIvKxaFvkl7Xham0aMMMBekvVWy/RYaWjAKL1Sc+u+rO5w9TxTh
 RE+lEfRfG5iYt16TmhzBEezQV30rkThEew3Ee6yiaSEOz+Q99hfvhm8zA6FGHaetnYCt
 umQlTH33nQfeAm4O25q9jcvIUyBN9lqbl0UKBM7Ad2T0TTsjcP0KHJuVlCsYNKfnY1L0
 KhpZwb8WA7xulBqVtmdmJjJ8pvgTrSFeBVI+2COeGbHFYubA295L9f4ceMByhsFs8wAy
 NQeaKekFsqLGsm8mLBmixPcMQnADiPx2fgbWv6NknDOHhs3YfT+2yxpiNbzNfEb5e+PO
 89NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725973196; x=1726577996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2LNlJBgYG8nswm5zwzkwBd1ce5jm3texoe/iTeaHPg8=;
 b=EEso7I3JtWGB7+9q2LD2prbv0EWG0KmBOfex/sn8xYHLkN8hlSDZugn1USK46yw8LA
 uSSNj3wOo71x4b0k7uQFoV76WNkpVwhTSLH5K0jo/3bkY49CmMsBUovJwjDfqXgOFuzx
 rnA3nFHq/Ut4+X54/G7tOpk0HpjqNlY5uuw8IbBEFV/9P2Wn7a/t/j1C15apLQPcwa10
 7hgXXGv0krrcAjkYBrBFsFgGhBoeHYBsM5qYCPipYi/Ae5L09YiamUvDAN9JkkKWagQD
 BmzJA5h9upFfaEP/tJCRyFQfnlzndesANCE+eIhor+d8vBc9fJL4UJUcvmRS4mL4bH4y
 l1lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0WbHy53efbjRjjdK2fRJ/P9Nwl7st1ybNwTW+TbyrMprEnjRhWaSHkEwm+2B76DvpVT+E07U=@lists.denx.de
X-Gm-Message-State: AOJu0YzIHDwPgHS0ZPF/tqR6ec62L/NKtet9wanpcnvzighq8C3HEZsT
 aa8KCd8ks+N2DffKd27Bdjb+WXaX46g0xPV71OlY8hbQiL1CneBKNyJ0Waqadcg=
X-Google-Smtp-Source: AGHT+IHLIXrRR0rvtECZOZDhsgyI5GX+Cbd23tadomL240cPCjxOnsYOF371IzK69Jm7aDpIfF9dTA==
X-Received: by 2002:a5d:558d:0:b0:374:bcc7:b9bb with SMTP id
 ffacd0b85a97d-378896100e6mr9311247f8f.35.1725973195773; 
 Tue, 10 Sep 2024 05:59:55 -0700 (PDT)
Received: from [192.168.7.95] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cb5affb16sm84661755e9.37.2024.09.10.05.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:59:55 -0700 (PDT)
Message-ID: <a9b45795-ea5b-4b40-a916-87d8c59a3d60@linaro.org>
Date: Tue, 10 Sep 2024 14:59:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spl: ram: hide SPL_RAM_SUPPORT
To: Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>, Samuel Holland
 <samuel@sholland.org>, Lukas Funke <lukas.funke@weidmueller.com>
References: <20240910090013.2686124-1-jerome.forissier@linaro.org>
 <51833d83-d6e2-0bff-67a9-cf9a04ea9c91@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <51833d83-d6e2-0bff-67a9-cf9a04ea9c91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 9/10/24 14:49, Sean Anderson wrote:
> On 9/10/24 05:00, Jerome Forissier wrote:
>> Make SPL_RAM_SUPPORT a hidden Kconfig symbol, automatically selected
>> by SPL_RAM_DEVICE or SPL_DFU. Avoids the situation where SPL_RAM_SUPPORT
>> may be enabled without the other two being enabled, which results in the
>> following build warning:
>>
>> common/spl/spl_ram.c:19:14: warning: ‘spl_ram_load_read’ defined but not used [-Wunused-function]
>>     19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong sector,
>>        |              ^~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>   common/spl/Kconfig | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> Replaces "spl: ram: fix build warning when neither RAM_DEVICE nor DFU
>> are enabled" [1].
>>
>> [1] https://lists.denx.de/pipermail/u-boot/2024-September/564302.html
>>
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index c08ff064493..885a012461c 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1238,15 +1238,11 @@ config SPL_POWER_DOMAIN
>>         the drivers in drivers/power/domain as part of a SPL build.
>>     config SPL_RAM_SUPPORT
>> -    bool "Support booting from RAM"
>> -    default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
>> -    help
>> -      Enable booting of an image in RAM. The image can be preloaded or
>> -      it can be loaded by SPL directly into RAM (e.g. using USB).
>> +    bool
>>     config SPL_RAM_DEVICE
>>       bool "Support booting from preloaded image in RAM"
>> -    depends on SPL_RAM_SUPPORT
>> +    select SPL_RAM_SUPPORT
>>       default y if MICROBLAZE || ARCH_SOCFPGA || ARCH_TEGRA || ARCH_ZYNQ
>>       help
>>         Enable booting of an image already loaded in RAM. The image has to
> 
> I think SPL_DFU should also select SPL_RAM_SUPPORT

Indeed, my mistake. v2 coming shortly.

-- 
Jerome
