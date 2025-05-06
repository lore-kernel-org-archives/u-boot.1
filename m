Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E69C3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 11:13:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F9D8820F6;
	Tue,  6 May 2025 13:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PWmwoqYK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA64282163; Tue,  6 May 2025 13:13:30 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16D0681F66
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 13:13:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4c321929641so1544794137.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 04:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746530007; x=1747134807; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l+GlXLw85mhF+oRDMm0BOK4//Deurj0OYoRJNacgkvk=;
 b=PWmwoqYKjqmYUnVlPQcuyUqK9QSSXBDHX1bgswQadj7V1pX0/hq1G3MmF+96f73ccV
 GDMOaCEVRglI6aaqzHmp78eCirtFezYaKSWW69OreWdp6+dsBa/D6s9EN3JlX85rrsW2
 svQKRteR803miebIimGWow2V6LeQXATXCYzFIg+hJ+1zlyR8vyDOhxRkvVboDWGcqTxo
 CY9bOc5ZH6Cl4zqyM7LKgW6bfq2zHhRvVNDyYcwWdY52zUdY0zdSsmWOqeWthBlwXof1
 X9dxj5vX7OCR4ziuUXdXL/7GXuITHGKiJ5H0IgCeXBVF0LY5vlxDUhdfMFGgC706m65a
 W8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746530007; x=1747134807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+GlXLw85mhF+oRDMm0BOK4//Deurj0OYoRJNacgkvk=;
 b=SQ9ysWrdbPulowx5f2l1llP9e1sHBX87elzBce3Ab/vwdNlFDbP4M1b8uvg1pajQS5
 EKGUNSR+hIUbKfRkeTGcm7zOR/xqLRIvOdb8a5ElH1SDLtBe5QzALjiLkJSD75jpX9iV
 /vmraCvlbNtGv3ssJkdPk5Ia8Sv5kV0xPWfgNUhPWF4iLebocLr/PTNa4FkxcNsAXLh8
 bohHuAxd98WmPkgd3zI1p4xFbYjQrVMhAcj8PQpz0SHvNiZX4be3w4VilZPuYXfSr4CI
 /Id9vqMfUfiM0dFSgKYpEJHst2GwlBd3zb0Fq1mUwbjKnZstnnxJw70YCfWF9febfs04
 +TFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrR/28UkQ77XCNuAzWNF+pA60QNfSaJtO1eQBCbTRZTQJBRumCCaGHY9Ol9jZitnuXm+zfivA=@lists.denx.de
X-Gm-Message-State: AOJu0Yy59w+xwn1WotzIe/OZQMiXfkxCukn2Saq+UCO7M9PKbI8E6BmP
 5tK12aBGaLOoGsVKcf8KSrCvFhirT2nCcLg92MSVCMilLFeMs2UmoL2tfmsahF4GHWT/GibydHo
 iF/IXsr2//TXZ6b7Wz2K80vKX0nLbR745c4T8JTwPIwIWt2y2+VU=
X-Gm-Gg: ASbGncse5krHvh34HxaRuVONA0ufoSaMX2XnWnKkD/flIQu71oLq9tIMx9qiamEl2wp
 OoqeVHrUxZCEFDZOo7/blGB3Bh+RNJrrKOHhH1g5IKRTEQ4g07YspDnbbXgGvtuZWtbhU4OSnin
 mdaRYkxpt2C13bFN7tYjoKcWk=
X-Google-Smtp-Source: AGHT+IHfgvvgeIb8gXeS7Bv+Tj7qCw89jpHdX0Bo9DrPPHudNjCvikBpNqj5bqDrwcaoDYT081HejsewfM2hrAjHuH0=
X-Received: by 2002:a05:6102:5787:b0:4c1:b0ad:a0bd with SMTP id
 ada2fe7eead31-4dafb6e7810mr10266420137.23.1746530006918; Tue, 06 May 2025
 04:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
 <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
In-Reply-To: <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 6 May 2025 16:43:15 +0530
X-Gm-Features: ATxdqUG_XNsg2Jdmgx2yGfLh2aSwuXA3irIUcgL23CdzKwz1gUoFYoXFEDZ1IKs
Message-ID: <CADg8p95i1NB89V_iKwiyFZuaiBSvpArJhR4_Dj65CnvoRB-hig@mail.gmail.com>
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 6 May 2025 at 16:35, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
>
>
> Sughosh Ganu <sughosh.ganu@linaro.org> schrieb am Di., 6. Mai 2025, 12:50:
>>
>> On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com> wrote:
>> >
>> > On 5/6/25 11:24, Sughosh Ganu wrote:
>> > > U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
>> > > the width of the phys_{addr,size}_t data types based on the register
>> > > size of the architecture.
>> > >
>> > > Currently, even the 32-bit RiscV platforms have a 64-bit
>> > > phys_{addr,size}_t data types. This causes issues on the 32-bit
>> > > platforms, where the upper 32-bits of the variables of these types
>> > > can have junk data, and that can cause all kinds of side-effects.
>> >
>> > How could it be that the upper 32-bit have junk data?
>> >
>> > When we convert from a shorter variable the compiler should fill the
>> > upper bits with zero.
>>
>> That does not seem to be happening. The efi_fit test fails on the
>> qemu-riscv32 platform, when attempting to boot the OS from the FIT
>> image.
>>
>> These are the values of the base address that I see in the
>> _lmb_alloc_addr() function.
>>
>> _lmb_alloc_addr: 755, rgn => -1, base => 0x1a1c0e00802000bc, size => 0x50b1
>
>
> As you are running on QEMU you should be able to track down where the value is actually assigned with gdb. This could for instance be a buffer overrun.
>
> If we don't correct the root cause, it will hit us again.

How will we hit this issue if the phys_addr_t is set to a 32-bit
value? So, this can be investigated as to why the compiler does not
set the upper 32-bits to 0. But given your earlier comment on the fact
that LPAE is not being used, the change proposed by this patch should
work? What issue do you see with a 32-bit address space.

-sughosh

>
> Best regards
>
> Heinrich
>
>>
>> The actual value that gets passed is 0x802000bc. The upper 32-bits do
>> not get zeroed out. Which causes the _lmb_alloc_addr() to return an
>> error. You can check my branch [1], where I have put a temporary
>> commit to print the values that cause the issue.
>>
>> -sughosh
>>
>> [1] - https://source.denx.de/u-boot/contributors/sng/u-boot/-/commits/lmb_apis_cleanup_bisectable_v2
>>
>> >
>> > >
>> > > This was discovered on the qemu Riscv 32-bit platform  when the return
>> > > value of an LMB API was checked, and some LMB allocation that ought
>> > > not to have failed, was failing. The upper 32-bits of the address
>> > > variable contained garbage, resulting in failures.
>> > >
>> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>> > > ---
>> > >
>> > > Note:
>> > > Although the LMB API cleanup series depends on this patch, I am
>> > > sending it separately so that it gets noticed by the RiscV
>> > > maintainers. Sometimes a patch may not get the required attention when
>> > > sent as part of another seemingly unrelated series.
>> > >
>> > >
>> > >   arch/riscv/include/asm/types.h | 9 +++++++--
>> > >   1 file changed, 7 insertions(+), 2 deletions(-)
>> > >
>> > > diff --git a/arch/riscv/include/asm/types.h b/arch/riscv/include/asm/types.h
>> > > index 49f7a5d6b3a..45d806c83eb 100644
>> > > --- a/arch/riscv/include/asm/types.h
>> > > +++ b/arch/riscv/include/asm/types.h
>> > > @@ -35,8 +35,13 @@ typedef u64 dma_addr_t;
>> > >   typedef u32 dma_addr_t;
>> > >   #endif
>> > >
>> > > -typedef unsigned long long phys_addr_t;
>> > > -typedef unsigned long long phys_size_t;
>> > > +#ifdef CONFIG_PHYS_64BIT
>> > > +typedef u64 phys_addr_t;
>> > > +typedef u64 phys_size_t;
>> > > +#else
>> > > +typedef u32 phys_addr_t;
>> > > +typedef u32 phys_size_t;
>> >
>> > This matches what has been done for ARM.
>> >
>> > 86c915628d58 ("riscv: Change phys_addr_t and phys_size_t to 64-bit")
>> > changed the definition to 64bit phys addr_t to support the 34bit
>> > physical addresses (similar to LPAE on arm32).
>> >
>> > I don't think that we need 34bit support currently. But I would prefer
>> > if we could find the root cause why the upper 32bit gets messed up as
>> > this might point to a generic problem.
>> >
>> > Best regards
>> >
>> > Heinrich
>> >
>> > > +#endif
>> > >
>> > >   #endif /* __KERNEL__ */
>> > >
>> >
