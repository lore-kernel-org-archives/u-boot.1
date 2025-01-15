Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE2DC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 08:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E1D880040;
	Wed, 15 Jan 2025 09:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="q6DAVMVi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D71680214; Wed, 15 Jan 2025 09:53:07 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3E6980027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 09:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E060B3F287
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 08:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1736931183;
 bh=YDMK+XrPKG/EYYd3kgTRWRF1yJ1hZV7/WaX4sVWnxuM=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=q6DAVMViq0kV+u7It8v43chGXZ89NXOBGs6J5eVazugFCwlH5bzfo+mI+NS0bo2zw
 LFAZPosnDCZc9WaWGow/JdnzCOmVSdutkJXdGnoRpEIKQEWviTHsMRfyBA+q+cD3ns
 DbG0SxAR0+TrPz/xTMl9fk7oJgbYczKPDiKvq6FoEOoUP1uLpB2lZ+FehQi+XHNhCr
 fD1kRdf1Tl11zablSYe2rPEPa4IV//FiblFAltgouqJaPQmNigIjgEBwiN16O7XeSw
 bje7Fiqa1VUDIpKKipZjQKs9lUl9KY+Chm4OUz7p1YIlkbg2xpXEJLIPHBbpf4hWCq
 3h7P5TxRs4/Wg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4362b9c15d8so33736065e9.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 00:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931183; x=1737535983;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YDMK+XrPKG/EYYd3kgTRWRF1yJ1hZV7/WaX4sVWnxuM=;
 b=cO2CYF62ypgMKJHl9IDf/4J8iySOgDU74vNykPrDYSGpRKcA2xW+NA3+U0Q/9glx1j
 G3YwqTytx6Oqean3Q0V5RvECgB/uBhnw2QRf5l4tbeyGHuSDdmFUDMsId0+GnRCFAHQ9
 dotOKB3xHnlDNVNxrshAe9CqEDAU3u4W+V/Dz085h5E7Mqe2PHnNmAgePA1T/BTIKqlI
 QxxVgam/D3khw4+O5NH1O6bsaKVIa2MUkDpTyxyFURvvyY7hn/pBhKCtIfCIOu9J0Stc
 7GrE9P3qLkjMWEhwKeWbU0vdhqbRR1yxltcoSGBc8g4taXOJnPW41cVlid5CxPkko5RH
 5/9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9BE1QG9EaTx6QWOGdoj7yXN4UdVFUa+QPQKgbWkisdEApDR3ESMWr3rwfKi9OnQBMXSZXJk4=@lists.denx.de
X-Gm-Message-State: AOJu0YxuX2mTNRZL8Mf18ZehFHukADAc4+UBUtIS1Q4QrCiE2IuC2dW4
 OiStJOoVI5NuHpzxeVE53XNpyK9+rBIIJCncBsGjkCgFOTPyHUe/58Zx7P92TXGu61h2B+ozxM0
 7ru23Mr5Hd38Y63vVqFykqdIlQlwHIypqh6IULmjHklXNzsLpFD3nDKNhN/a5gRKDjyw=
X-Gm-Gg: ASbGncvwhLbX2bMhyvDrrv/YZEokgqkTC02ANp3OIn6kHExI5MaWRXhLIwtmkDJCXOT
 G7mCmXo0OQLr4JdsoOQxn9YHuN/PTbBa/0yvnbIRtp3j3/azP2Y1CrexY6wFPmlQk+vONh7tanG
 zi55GzPaeA2O9qk3ocfbjfUSitApRCAd1e14hj6LEsqv09Ih8U35CtVwIyj13tqw+kpqIMIjOob
 AG4x4n9z9Eqorq0KUUosL/R5dzTZS3J4ZPWbrawBnEPB5xFzwpwJ3y6vl8D2XIC9MpCdKWxSI0V
 R2LMunQQsFcnERoqkGe+NEYaVZeQmJSJ/hiodvemhJzV
X-Received: by 2002:a05:600c:4684:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-436e26e50c9mr216718825e9.21.1736931183407; 
 Wed, 15 Jan 2025 00:53:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMv/HuObbaL3cPv070JNeRkaFGdMp6yzzOOPyLEPTYs0caS1KkQd4ijgpf5MrJpB95N59gOA==
X-Received: by 2002:a05:600c:4684:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-436e26e50c9mr216718615e9.21.1736931182972; 
 Wed, 15 Jan 2025 00:53:02 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:a38a:5aa7:b37:f5fa:7b6b?
 ([2a02:3035:6e0:a38a:5aa7:b37:f5fa:7b6b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499502sm15769065e9.4.2025.01.15.00.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 00:53:02 -0800 (PST)
Message-ID: <0b2d844f-3719-4b9e-a3b2-28c6cfe33ebe@canonical.com>
Date: Wed, 15 Jan 2025 09:53:00 +0100
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAC_iWjJdT_pn89aq3m1RaZesQSiKRGEqz4dVhoN6ntz4=2xqPg@mail.gmail.com>
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

On 15.01.25 09:06, Ilias Apalodimas wrote:
> Hi Heinrich
> 
> 
> On Tue, 14 Jan 2025 at 12:30, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> Use the same include as arm64 for the linker script.
>>
>> Adjust the 32-bit ARM PE-COFF header accordingly and harmonize it with the
>> 64-bit ARM header.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/arm/lib/crt0_arm_efi.S  | 37 ++++++++++---------
>>   arch/arm/lib/elf_arm_efi.lds | 71 +-----------------------------------
>>   2 files changed, 20 insertions(+), 88 deletions(-)
>>
>> diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
>> index b5dfd4e3819..590fcf515da 100644
>> --- a/arch/arm/lib/crt0_arm_efi.S
>> +++ b/arch/arm/lib/crt0_arm_efi.S
>> @@ -14,11 +14,11 @@
>>          /*
>>           * Magic "MZ" signature for PE/COFF
>>           */
>> -       .globl  image_base
>> -image_base:
>> +       .globl  ImageBase
>> +ImageBase:
>>          .short  IMAGE_DOS_SIGNATURE             /* 'MZ' */
>>          .skip   58                              /* 'MZ' + pad + offset == 64 */
>> -       .long   pe_header - image_base          /* Offset to the PE header */
>> +       .long   pe_header - ImageBase           /* Offset to the PE header */
>>   pe_header:
>>          .long   IMAGE_NT_SIGNATURE              /* 'PE' */
>>   coff_header:
>> @@ -38,16 +38,16 @@ optional_header:
>>          .short  IMAGE_NT_OPTIONAL_HDR32_MAGIC   /* PE32 format */
>>          .byte   0x02                            /* MajorLinkerVersion */
>>          .byte   0x14                            /* MinorLinkerVersion */
>> -       .long   _edata - _start                 /* SizeOfCode */
>> +       .long   _etext - _start                 /* SizeOfCode */
> 
> Was that an error all along? Or the boundaries changed by using the
> include file?

According to https://learn.microsoft.com/en-us/windows/win32/debug/pe-format

SizeOfCode:
"The size of the code (text) section, or the sum of all code sections if 
there are multiple sections."

We only have one code section.

Looking at EDK2's Shell.efi SizeOfCode equals the VirtualSize of the 
.text section. It does not include the .data section.

Best regards

Heinrich

> 
>>          .long   0                               /* SizeOfInitializedData */
>>          .long   0                               /* SizeOfUninitializedData */
>> -       .long   _start - image_base             /* AddressOfEntryPoint */
>> -       .long   _start - image_base             /* BaseOfCode */
>> +       .long   _start - ImageBase              /* AddressOfEntryPoint */
>> +       .long   _start - ImageBase              /* BaseOfCode */
>>          .long   0                               /* BaseOfData */
> [...]
> 
> Other than that it looks ok
> 
> Thanks for cleaning this up!
> /Ilias

