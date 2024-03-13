Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45107C54E66
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 22:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 547A887EE3;
	Wed, 13 Mar 2024 23:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TkfMRyaz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0168187D57; Wed, 13 Mar 2024 23:43:48 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B61E287EAD
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 23:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-29c5f81da6bso872905a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 15:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710369824; x=1710974624; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJqrYZtcg5O7nzx5ps5MoARHiB4jni5+MDPdIyl5Ebs=;
 b=TkfMRyazYKRwnY1PeNUTcgoavGMRqHDcJlf0Y+yVIW9290OlroFgix9jnntz2Isyd6
 jCkZstczQyvMGWFxRhgvmMXgceBFn/n8Hl1hiP2tNn7MRGpuoEwSQUgZuAzDxDuHlkoo
 vfPhr1voDg9O5J0DX5FMzLjTG1w7xJ6ZRQkto4QrlxC7ygJwJ5/F1GsytS2z4OaEwL0r
 3q+zOtXHfC9I2gTwinOQAtS45FOwijolp0zzKnpzWy9asFaEjgjcgI26qOGc78X1o/YK
 NUQCuOJJAWuZ4epIHZbK6dE8EKRw0fzeT4NyMi/NJIhojZ7qhs99dJnpBp05sWhFLzm9
 nZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710369824; x=1710974624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJqrYZtcg5O7nzx5ps5MoARHiB4jni5+MDPdIyl5Ebs=;
 b=RiJJN8wcHZViL5P0yuZtzRtejAaNdpA5WqVpw4oZqFyhX9lkdEHcmYfRhpTiSd4BJy
 TsdXs8Q5G6RoQOMDiOrICIVev0TxUs3oN9Frj8/+WCcpKtnQdtMZLY5rdvTSw5O5+4Bz
 XoILqwpv77eNZy1ZZmm2mcIZteOJrwm4ZdhGaUHJ49px2ZN+GL00+1DavevtM2wNVKBB
 RUs2TcZqRUy0AtLZV/mG/piGkpwKKxauqfgPuCUc9bDsydGf5nlfKBr5lnHlkoKKiFw9
 gQXBN3jbEFAOuiIpyEpyNm0yA22RjYl+gylkssYnXvgpldtd6kMqnTagYqcnBkToU5DI
 xoiw==
X-Gm-Message-State: AOJu0YyvKIdtNekTnpCK9hYnoBKpAGYvmKeDjPhf5R7x62P0s8kH5RW3
 oWBiXMW9L1aQw5f6yYejsTOvE8UqvZIXr4f9Aoihto9nhORP9cJogFUXURa6Z/g=
X-Google-Smtp-Source: AGHT+IHIIu1n+IByiZd9aOUOf/hzgD5BGhC6ZEZNe0+n52mKBsPbd8A8oE2WtR5yF4ysOZorD54AWQ==
X-Received: by 2002:a17:90a:d350:b0:29b:7461:51a7 with SMTP id
 i16-20020a17090ad35000b0029b746151a7mr241749pjx.23.1710369824040; 
 Wed, 13 Mar 2024 15:43:44 -0700 (PDT)
Received: from [192.168.0.227] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 sh13-20020a17090b524d00b0029c792dcdf0sm47222pjb.19.2024.03.13.15.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 15:43:43 -0700 (PDT)
Message-ID: <2a58e815-acfa-4659-80f5-08d314497897@linaro.org>
Date: Wed, 13 Mar 2024 12:43:29 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] arm: clean up v7 and v8 linker scripts for
 bss_start/end
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com, cfsworks@gmail.com,
 caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-3-ilias.apalodimas@linaro.org>
 <e1fabe14-0c0e-45f3-9d5a-1452cb9b954e@linaro.org>
 <CAC_iWjKhM6Ono+C-t-3g=OSo=5wF8jAYzoZ-NUyNUt7MHTMy=w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAC_iWjKhM6Ono+C-t-3g=OSo=5wF8jAYzoZ-NUyNUt7MHTMy=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 23:51:43 +0100
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

On 3/13/24 11:43, Ilias Apalodimas wrote:
> Hi Richard,
> 
> On Wed, 13 Mar 2024 at 22:19, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 3/13/24 06:23, Ilias Apalodimas wrote:
>>> +++ b/arch/arm/cpu/armv8/u-boot-spl.lds
>>> @@ -63,18 +63,11 @@ SECTIONS
>>>
>>>        _image_binary_end = .;
>>>
>>> -     .bss_start (NOLOAD) : {
>>> -             . = ALIGN(8);
>>> -             KEEP(*(.__bss_start));
>>> -     } >.sdram
>>> -
>>> -     .bss (NOLOAD) : {
>>> +     .bss : {
>>> +             __bss_start = .;
>>>                *(.bss*)
>>> -              . = ALIGN(8);
>>> -     } >.sdram
>>> -
>>> -     .bss_end (NOLOAD) : {
>>> -             KEEP(*(.__bss_end));
>>> +             . = ALIGN(8);
>>> +             __bss_end = .;
>>
>> Still missing the alignment on .bss, previously in .bss_start.
> 
> Since this is emitted in .sdram memory I can't define it as
> .bss ALIGN(8) : {....} since the calculated memory will be outside the
> sdram-defined region
> 
> I could define it as
> .bss : {
>          . = ALIGN(8);
>          __bss_start = .;
>          ......
> }
> 
> But instead, I added an assert at the bottom which will break the
> linking if the __bss_start is not 8byte aligned.

I think it would be clearer to assert on __bss_start address rather than 
CONFIG_SPL_BSS_START_ADDR, if that's possible.  If not, then the constant will have to do.


r~
