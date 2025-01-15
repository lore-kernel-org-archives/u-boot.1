Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17B0C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47C5F80040;
	Wed, 15 Jan 2025 11:31:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="BsmMEmDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9667F800C2; Wed, 15 Jan 2025 11:31:25 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A26880027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A948F3F291
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 10:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736937082;
 bh=s4OLdLRPiPzKHpVPTxiFZ20ZDOPV8yVQpNVk2+e+Dzw=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=BsmMEmDUXr39acAFkClGGB3OQXzICAZR1DjIwJFZE9w/TcSdjFQoy9rPmbERqZBP7
 r+WPnnEv1/htfsTVd2z//54MqHJOQ9nauhdb0Cs/bc+sbuhzlGxCmQptcoZ6ZzN4f3
 r0sJQwQ9meIHa0oPjFsuuhzGCXGQaNV4lXefIXoO7A1nn4/pw7YoZTHZZa7g+EEXXO
 limosMx036KEt98OSaLAfHu4VNo1Bekyci1Gs1P/a1xaZOmDlpiDn3JL+BTQ0j5JBZ
 Vn1mzHOYQRbHy9dFnIzTAHG3/1URKsSidp10Q/XpUSR8+AKhG3fWKOL6PEGCnM45wI
 7RFMviPOk96Sg==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aab954d1116so699155466b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 02:31:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736937082; x=1737541882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s4OLdLRPiPzKHpVPTxiFZ20ZDOPV8yVQpNVk2+e+Dzw=;
 b=pks7M+yTzYT9sGzd2fbkyZwL09CPrYlX/Wn7YAef843hcgZaU91x/Y15w/xANzYo5v
 lxU/sWzJEEpFHXGDpEt7MLVE3Np/Y5IAX1Yv99Sy6pQdps1BH+GItTHEEMjmCa21gpjP
 J3/h4oJFys3T3b3vdpnV3Pa4KUlEWcJ9hfOSI9MBNcsoTjfgoqywFBD0YXOC7fkIqoQG
 H/sbgno1Pd4TrjIWyQqudI6FoghmJ8CoxXlj2VRMcIB2xTLP1whEnC4Lgy6Ji8BGT7fX
 dBgQXGfgcjSRavgzJt4twsBXif/wRx4T4jhbK9krrbmMTSDsGAbhl0HGsUfov9aTBHK4
 v+0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlO70uSt8JZRNd/0ey4Xnw1XwkAw/1GMMf8fFkBCwbHbaQ+eEd23/nssFjOPcrEQeGn0zF1cU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3Pp+hLveTaFFAH7AGXYjaozidYrLJ4EG+p9birGcdwv1anxNO
 qeSEdZJSNmtWSgoLqYF1YWnx2ys+hcMl2kLQCxP0B/7aeU/ovWjiewPgyAFxyIGid37wP/qLlW1
 i3krp41fK2bqGl8iPwEYRY0OjowwpivOUr9+yDCqYjK4XHX4PhmIMj6ahGAVNAbQ092s=
X-Gm-Gg: ASbGncupcixPZL4zJgUFaoIYLkZB2m5mOL+k6K0TdnqBCuIhcEo5lh5vwN42ReCYGh+
 kT/3vjWYu9fbJUkLP9k0iaLsQ2CcE4jYSXAv/4dmOEZOD17GlKahDQQUHARTsu2fVeXfySBE2VB
 LSseRq1GlVgXPTt/hSJfmDWK5O/tv6ZvOgInl8IbpDuvJ2nMh3O98wN22sbcu3DfsvOCD+5L9xY
 877WxEkLB3cFVw/SSzdHQJGj6dSPmd0Nxt0gjCQG2g9XV7ODR6bMzMpGQpQFUthbQcTLl1Y05a7
 TkFwpgxstBfm80NiXM9g3Km0gNBGzddXC3nrjko2M3tU
X-Received: by 2002:a17:907:3e24:b0:aac:2298:8960 with SMTP id
 a640c23a62f3a-ab2ab6fcf7amr2810228066b.35.1736937082137; 
 Wed, 15 Jan 2025 02:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGv1tCnuymXqy5utlrEKujTlmiSbrYRi2QrNTyCzAz1Bx0WHAet60IfqCN9zuZbk7WZ3S8jfg==
X-Received: by 2002:a17:907:3e24:b0:aac:2298:8960 with SMTP id
 a640c23a62f3a-ab2ab6fcf7amr2810224866b.35.1736937081701; 
 Wed, 15 Jan 2025 02:31:21 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:a38a:5aa7:b37:f5fa:7b6b?
 ([2a02:3035:6e0:a38a:5aa7:b37:f5fa:7b6b])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99046a195sm7007476a12.57.2025.01.15.02.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 02:31:20 -0800 (PST)
Message-ID: <c1912209-55df-49ce-9dbb-6298292d44a9@canonical.com>
Date: Wed, 15 Jan 2025 11:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] efi_loader: use include in ARM EFI linker script
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Jonathan Humphreys <j-humphreys@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Prasad Kummari <prasad.kummari@amd.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250114102953.64381-1-heinrich.schuchardt@canonical.com>
 <20250114102953.64381-5-heinrich.schuchardt@canonical.com>
 <CAC_iWjJdT_pn89aq3m1RaZesQSiKRGEqz4dVhoN6ntz4=2xqPg@mail.gmail.com>
 <0b2d844f-3719-4b9e-a3b2-28c6cfe33ebe@canonical.com>
 <CAC_iWj+OR+-WdED-o=-W02NhVPvVWOoQe9mRQou2U7pjGRB6vA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWj+OR+-WdED-o=-W02NhVPvVWOoQe9mRQou2U7pjGRB6vA@mail.gmail.com>
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

On 15.01.25 10:34, Ilias Apalodimas wrote:
> On Wed, 15 Jan 2025 at 10:53, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 15.01.25 09:06, Ilias Apalodimas wrote:
>>> Hi Heinrich
>>>
>>>
>>> On Tue, 14 Jan 2025 at 12:30, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>>
>>>> Use the same include as arm64 for the linker script.
>>>>
>>>> Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
>>>> 64-bit ARM header.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>    arch/arm/lib/crt0_arm_efi.S  | 37 ++++++++++---------
>>>>    arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
>>>>    2 files changed, 20 insertions(+), 88 deletions(-)
>>>>
>>>> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
>>>> index b5dfd4e3819..590fcf515da 100644
>>>> --- a/arch/arm/lib/crt0_arm_efi.S
>>>> +++ b/arch/arm/lib/crt0_arm_efi.S
>>>> @@ -14,11 +14,11 @@
>>>>           /*
>>>>            * Magic "MZ" signature for PE/COFF
>>>>            */
>>>> -       .globl  image_base
>>>> -image_base:
>>>> +       .globl  ImageBase
>>>> +ImageBase:
>>>>           .short  IMAGE_DOS_SIGNATURE             /* 'MZ' */
>>>>           .skip   58                              /* 'MZ' + pad + offset == 64 */
>>>> -       .long   pe_header - image_base          /* Offset to the PE header */
>>>> +       .long   pe_header - ImageBase           /* Offset to the PE header */
>>>>    pe_header:
>>>>           .long   IMAGE_NT_SIGNATURE              /* 'PE' */
>>>>    coff_header:
>>>> @@ -38,16 +38,16 @@ optional_header:
>>>>           .short  IMAGE_NT_OPTIONAL_HDR32_MAGIC   /* PE32 format */
>>>>           .byte   0x02                            /* MajorLinkerVersion */
>>>>           .byte   0x14                            /* MinorLinkerVersion */
>>>> -       .long   _edata - _start                 /* SizeOfCode */
>>>> +       .long   _etext - _start                 /* SizeOfCode */
>>>
>>> Was that an error all along? Or the boundaries changed by using the
>>> include file?
>>
>> According to https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
>>
>> SizeOfCode:
>> "The size of the code (text) section, or the sum of all code sections if
>> there are multiple sections."
>>
>> We only have one code section.
>>
>> Looking at EDK2's Shell.efi SizeOfCode equals the VirtualSize of the
>> .text section. It does not include the .data section.
>>
> 
> Hmm that's interesting. gnu-efi includes .data AFAICT.
> Looking at the pe/coff spec there's SizeOfCode and
> SizeOfInitializedData (for .data) and SizeOfUninitializedData (for
> .bss).
> But in both gnu-efi and U-Boot we define those two as 0 though. So I
> think we should either keep SizeOfData as is, or define it as you
> propose and also define SizeOfInitializedData and
> SizeOfUninitializedData correctly -- and I don't know if the latter
> will have any implication on loaders.

Arm64 and RISC-V are already using SizeOfCode = _etext - _start. This 
patch only followed up on 32-bit ARM.

We should follow the example of EDK II and fill SizeOfInitializedData.

We are putting the _bss sections into .data. So SizeOfUninitializedData 
should be kept at 0.

Best regards

Heinrich

> 
> Cheers
> /Ilias
>> Best regards
>>
>> Heinrich
>>
>>>
>>>>           .long   0                               /* SizeOfInitializedData */
>>>>           .long   0                               /* SizeOfUninitializedData */
>>>> -       .long   _start - image_base             /* AddressOfEntryPoint */
>>>> -       .long   _start - image_base             /* BaseOfCode */
>>>> +       .long   _start - ImageBase              /* AddressOfEntryPoint */
>>>> +       .long   _start - ImageBase              /* BaseOfCode */
>>>>           .long   0                               /* BaseOfData */
>>> [...]
>>>
>>> Other than that it looks ok
>>>
>>> Thanks for cleaning this up!
>>> /Ilias
>>

