Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA9FC2BA15
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E584D8840C;
	Wed, 19 Jun 2024 14:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vzdxGRfW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3541B882DC; Wed, 19 Jun 2024 14:56:34 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 002318842A
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 64D203F5B0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 12:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718801790;
 bh=dX8UD9vIAzntq5/BJGINRymbrvRDBYEHvXnbn4/5ZwM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=vzdxGRfWPSXX5fpoXqFCfAWl8qkstpJlC0pPq5Z9kjRFRb8jLoSwnRMpEnfpJy6t7
 rtvv0O56e9fvI0mbUfj5WGRrzahZSc4rC+FZmAUE2TaiEfKw8tuGQNrrCLf8HJcqe0
 +PD7jqDyIqwqGowTA3gbhXXtQOiHkXeH2d+qL+W0Lpwy5vlC8EpfnAoBVumrzG4E6E
 VnU27THd/HW4qqfNNVBUIX/7hLJYA0C+X3RbXTtavTxdAbFP8OQaFdBLZ1afURSxzt
 ppzRd0O29GRn6/TEb6htol4HU5AgKw+TSqj2DDUv00J6uiKbT5XXHCRnoI1o1N5xOz
 ow5A/HChDeuVw==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2ebfa13d277so53717721fa.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718801790; x=1719406590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dX8UD9vIAzntq5/BJGINRymbrvRDBYEHvXnbn4/5ZwM=;
 b=bMpCeZrxoOuDuEvg566XXpl2Hm6+CJmr9349182GkaokzGPz/Zgoc+DwcJQmC1LPkp
 LHkNJl936bDM2tmJHB/4li3GBJvix0vBFiMYJ76abiOrVLTvqejuc+m1guuWRsvlufOr
 bkpkDnhdoGMhLQ2zNF7U4OqUG3G20pWinyTY1lZosAgh0h6M0OxLNLa0XBb85s2zvR3/
 03B6thvJx77uPxMaWsBVdzmEAhJJW0XoLC+y3TuEUi7P52HrqQFnXDQ5Tmk6aOE+nV6U
 FsVIKCfSohrFDqmuuP89kuiJ2vswlTSvqHFzIpb66Sr8mIZLIYO8nEOo4o4LzB3rO/Xc
 7dwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgOyIALjLYC98oTxnJ3uK4wwGlq9g2UkZdmF1Fx53WcTxnA/SZehBMhsXQJJpjaMNzWuXnps5rDr+1euBw5mm8dWhu/A==
X-Gm-Message-State: AOJu0YzWOzk/cLuG7KIQBtw3Cy/ckWRUQVBxAeVbIkLZgGQw92zOc+cJ
 LW4qMuGCoNLCTLJ5oYe0Wqjz3pek6Tqyf2SXpWHF9U8L0hYTKKNIPhfecTuuz0EKEFHGmUA3Z+I
 sQrF6/7m8Zc2dZrsGCqIvAcUcsA8e4Zn6+u9vBEBUFO9gKz/+WwAq6xKS0FMinABOqgY=
X-Received: by 2002:a2e:8495:0:b0:2ec:1629:1634 with SMTP id
 38308e7fff4ca-2ec3cfe0d37mr16596251fa.52.1718801789841; 
 Wed, 19 Jun 2024 05:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHl16dCbS8JyCmOATcCt29BheIqPVMZhauIQR/jmjdZixldXDwq87qYR6uq1+1435pXSqBLIw==
X-Received: by 2002:a2e:8495:0:b0:2ec:1629:1634 with SMTP id
 38308e7fff4ca-2ec3cfe0d37mr16596111fa.52.1718801789451; 
 Wed, 19 Jun 2024 05:56:29 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-178-202-041-025.um47.pools.vodafone-ip.de. [178.202.41.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42286fe9263sm264326455e9.15.2024.06.19.05.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 05:56:26 -0700 (PDT)
Message-ID: <e8c883a8-7dd6-434b-b477-41959e3e7746@canonical.com>
Date: Wed, 19 Jun 2024 14:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm: implement invalidate_icache_all on ARM11
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
 <20240616173105.7430-3-heinrich.schuchardt@canonical.com>
 <CAC_iWj+VpDYAdzj0fqxBPAPshVt03g9SCNafxN-8RPdrPVDiMg@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+VpDYAdzj0fqxBPAPshVt03g9SCNafxN-8RPdrPVDiMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19.06.24 14:22, Ilias Apalodimas wrote:
> Hi Heinrich,
> 
> On Sun, 16 Jun 2024 at 20:31, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> In EFI sub-system we rely on invalidate_icache_all() to invalidate the
>> instruction cache after loading binaries. Add the missing implementation on
>> ARM1136, ARM1176.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/arm/cpu/arm11/cpu.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/arch/arm/cpu/arm11/cpu.c b/arch/arm/cpu/arm11/cpu.c
>> index 01d2e1a125d..4bf0446b543 100644
>> --- a/arch/arm/cpu/arm11/cpu.c
>> +++ b/arch/arm/cpu/arm11/cpu.c
>> @@ -116,3 +116,15 @@ void enable_caches(void)
>>   #endif
>>   }
>>   #endif
>> +
>> +#if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
>> +/* Invalidate entire I-cache */
>> +void invalidate_icache_all(void)
>> +{
>> +       unsigned long i = 0;
>> +
>> +       asm ("mcr p15, 0, %0, c7, c5, 0" : : "r" (i));
> 
> This looks correct, but can't we define it as
> __asm__("mcr p15, 0, %0, c7, c5, 0" : : "r" (0)); ?

Both compile to the same code. So we should simplify the expression.

arch/arm/cpu/armv7/cache_v7.c and other modules always uses asm and not 
__asm__.

@Tom:
Can we specify what is preferred in doc/develop/codingstyle.rst?

https://gcc.gnu.org/onlinedocs/gcc/Alternate-Keywords.html gives some 
background.

Best regards

Heinrich

> 
> Thanks
> /Ilias
>> +}
>> +#else
>> +void invalidate_icache_all(void) {}
>> +#endif
>> --
>> 2.43.0
>>

