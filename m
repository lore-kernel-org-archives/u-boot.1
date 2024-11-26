Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11966D3B9B7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:15:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94A2D895F1;
	Tue, 26 Nov 2024 17:15:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pAK/KJgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78678972F; Tue, 26 Nov 2024 17:15:47 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F8B895EC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso403858466b.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 08:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732637745; x=1733242545; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5ecDo1OCslmCzjzNvc8m/o39zJzDGMbPZZEsI9miejg=;
 b=pAK/KJgndAw9Q9wpo87jGebSBhJXbQw482rwmi6RlKpK5DkciV+JKEFJ1hbOjDo5zo
 pU2MvQXi6xutlDwmd1AF7m659UnmVT1ATfPVQSt5T0sIfNIvn6o2nFjruhpzm38IOEgJ
 Hye24V7y82wBGFdMMrPgaMKkXhhyCaqCS1ajzMR77IeG0WOmJVNMC49jT8OEJX6GGvMJ
 xpF+MFuNRySZZlrNVKz9qg/PE13Bh8ktNnspnQYFGYzUtcO5DYP8SCTg77ko37q0WNxZ
 tUoZtYavycfidRhwa9U4ZzUZUj3UQveMVEiEIj53ZrgjOsFvuhbEi1CY0ivYZO9jafvL
 bq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732637745; x=1733242545;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ecDo1OCslmCzjzNvc8m/o39zJzDGMbPZZEsI9miejg=;
 b=dbbhwflzzVDDUbW3DKinJFlseAEUuGIY2HgfDgjwkU/fB4xq/MB3JXqRnmhd8AYkAH
 I3v9iniaaFItTU+m65pLB26KLSvzUhTk0vpFP05zTxN9bvdB/zM+s6jL1Ymj346ExDSS
 ewnxYw937f7e6gTJSeDZ+E6Y33M9hw0AN1EfltnHS+DWj6vn2wE7QcgKIzQUPKHCxNhe
 PaCBCd6LHGq3h7GBwaWL/0W/0KmJNzjVZo87Y+DWWSSLiL41jk02d94xyR5RaRSBSQ81
 GwAKAoQzWi/lE3pdkmddDwQvOOeLLMMKt00mjkwLw0Y2w64az7qsDIlpsgElw2liJAdE
 vHBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS1yk8lEc6CxL2sf1sTfb38PzygF9tB+MnOzovzoe+Eutfjy9j6D+37BWetjwQDdmHv0W8AAk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6b5kCdRjR4qbl/51wq/tU4MkLfB01M0JAMTBbxILGQ1Nr8dRT
 pm939ppeqQyhHmStjoHEEbWKsZdZufGdoBsthWunNzFlgX69+/TKNcrWQh32mpk=
X-Gm-Gg: ASbGncsB4ECcF5pRMtw9j3EFbif2DvK4wk41CCq3gcAqq/yG2jOo+ZuXhMyT9ui1LtP
 XCoHeCJD88tapuBH8RKK0sKNuYWKPxm/GIKsNN9h7Q3HadQ2qhmKj4CUPEK1LtnQFCRjgFcDAl2
 TPH51cXWQ/F2SkJ7M4cRpQDFq8nmG9F6rI3bcrSXATCGmI3B/iXVLmwgHAu+Qyc8zmqFBx3erhj
 rPIGYYrNxHG5WUit8BPET4I8BBwsk1GdYVxl1xlcsts4jSb+R3h6q2E5ibdP7plH9LJyfFbRezl
 3JEhC+5OIxHUHFaZmxf41G4B446E2Obk
X-Google-Smtp-Source: AGHT+IEzUTK5P08CSTfL3X+LizISDkgNChnoWoTjqwmQSd5Ybl2hbQk8ohLDcE9Q43P5EnYM9Lslhw==
X-Received: by 2002:a17:907:2cc6:b0:a99:3db2:eb00 with SMTP id
 a640c23a62f3a-aa5649cf412mr425411266b.28.1732637745112; 
 Tue, 26 Nov 2024 08:15:45 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519?
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa54423e8e9sm368547166b.77.2024.11.26.08.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 08:15:44 -0800 (PST)
Message-ID: <a8cd7895-7968-4ef9-bc5f-dd36c04d9db8@linaro.org>
Date: Tue, 26 Nov 2024 17:15:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/board_f: init malloc earlier
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>
Cc: Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Raymond Mao <raymond.mao@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241124183832.2476928-1-caleb.connolly@linaro.org>
 <CAFLszThqtA_WBxOU-EnEvw956ZMN9KErx_C4gTzW_+p_tGu9qw@mail.gmail.com>
 <cd43db10-4939-4958-97f2-9a2046d82160@linaro.org>
 <CAFLszTgEhfbk4ug=JoU_jTgdzSkF-fXuqamGmPJHpdogwocbRA@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFLszTgEhfbk4ug=JoU_jTgdzSkF-fXuqamGmPJHpdogwocbRA@mail.gmail.com>
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

Hi Simon,

On 26/11/2024 16:38, Simon Glass wrote:
> Hi Caleb,
> 
> On Tue, 26 Nov 2024 at 05:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Hi Simon,
>>
>> On 26/11/2024 01:32, Simon Glass wrote:
>>> Hi Caleb,
>>>
>>> On Sun, 24 Nov 2024 at 11:38, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>>>
>>>> Currently the early malloc initialisation is done partially in
>>>> board_init_f_init_reserve() (on arm64 at least), which configures
>>>> gd->malloc_base. But it isn't actually usable until initf_malloc() is
>>>> called which doesn't happen until after fdtdec_setup().
>>>>
>>>> This causes problems in a few scenarios:
>>>>
>>>> 1. when using MULTI_DTB_FIT as this needs a working malloc (especially
>>>>    for compressed FIT).
>>>
>>> Hmmm, how does this work today?
>>
>> I honestly have no idea, I assume boards that make use of it do some
>> custom board_f.
> 
> OK.
> 
>>>
>>>> 2. Some platforms may need to allocate memory as part of memory map
>>>>    initialisation (e.g. Qualcomm will need this to parse the memory map
>>>>    from SMEM).
>>>
>>> That really needs to be tidied up. When does this fixup need to be
>>> done? I imagine it is somewhere prior to setup_dest_addr() ? Perhaps
>>
>> It's necessary in order to figure out gd->ram_base/ram_size. We do it in
>> board_fdt_blob_setup() so that we can support another use-case where
>> U-Boot has an internal FDT (which it should use) but the memory layout
>> is provided via an external FDT which is unavailable (although this
>> usecase isn't enabled upstream yet).
>>
>>> we could introduce an event to do 'memory map' stuff?
>>
>> We could, but considering that on most platforms the pre-relocation
>> malloc is fixed at build time and at a known location relative to U-Boot
>> there is no reason for us to arbitrary decide that some codepaths at the
>> start of board_f aren't allowed to use malloc().
>>
>> Just moving the malloc initialization earlier ensures malloc() is
>> consistently available and greatly simplifies things.
> 
> I'd like to see a more generic solution to this problem...I think we
> discussed this before?

I think so. I'm not sure I follow with "more generic solution"?
> 
> To my eye it looks like if we called an event in setup_dest_addr() we
> could allow ram_base to be set.

Right, it's possible/likely that we could clean up how mach-snapdragon
currently does memory parsing.

I do think this patch would still be justified even if we ignore the
Qualcomm case.
> 
>>
>> fwiw, I had another variation of this patch which dropped initf_malloc()
>> entirely and just set up gd->malloc_limit/malloc_ptr in
>> board_init_f_init_reserve() since that's where we set malloc_base
>> anyways. But after digging some more there seem to be quite a few other
>> entrypoints into U-Boot that don't go through
>> board_init_f_init_reserve() (e.g. sandbox, EFI app) and it seemed more
>> error prone to duplicate the implementation there.
> 
> Fair enough.
> 
> One more thing I notice in your board_fdt_blob_setup() implementation
> in arch/arm/mach-snapdragon/board.c :
> 
> It seems to be using either an built-in or external devicetree. It
> seems that we should show this in dm_announce(), i.e. with the call to
> fdtdec_get_srcname() ?

Yes, the way it's implemented currently assumes that if CONFIG_OF_BOARD
is set that we'd never use the built-in DT and mach-snapdragon doesn't
fit this assumption. It's not a high priority but for sure something I'd
like to see fixed.

Kind regards,
> 
> Regards,
> Simon
> 
> 
>>
>> Kind regards
>>
>>>
>>> Regards,
>>> Simon
>>>
>>>
>>>>
>>>> Move the initf_malloc() call earlier so that malloc is available during
>>>> fdtdec_setup().
>>>>
>>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>>>> ---
>>>>  common/board_f.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/common/board_f.c b/common/board_f.c
>>>> index 98dc2591e1d0..bddfa6b992b9 100644
>>>> --- a/common/board_f.c
>>>> +++ b/common/board_f.c
>>>> @@ -867,15 +867,15 @@ static int initf_upl(void)
>>>>  }
>>>>
>>>>  static const init_fnc_t init_sequence_f[] = {
>>>>         setup_mon_len,
>>>> +       initf_malloc,
>>>>  #ifdef CONFIG_OF_CONTROL
>>>>         fdtdec_setup,
>>>>  #endif
>>>>  #ifdef CONFIG_TRACE_EARLY
>>>>         trace_early_init,
>>>>  #endif
>>>> -       initf_malloc,
>>>>         initf_upl,
>>>>         log_init,
>>>>         initf_bootstage,        /* uses its own timer, so does not need DM */
>>>>         event_init,
>>>> --
>>>> 2.47.0
>>>>
>>
>> --
>> // Caleb (they/them)
>>

-- 
// Caleb (they/them)

