Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA2C3ABB6
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 07:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5DDE820EB;
	Wed,  7 May 2025 09:49:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dWZx+Zz6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 031678210D; Wed,  7 May 2025 09:49:43 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CA18007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 09:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-878440ee153so222698241.1
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746604179; x=1747208979; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zg8izujCJX6n4ZSsWtPsm+MbiII4lDcZjLmu+2x60iI=;
 b=dWZx+Zz6R3Vgig8ifumaDpaPJu33Z3oKXhB2kYhuNDWowSJGLiVgo1tOuz6a3DSiY6
 uBWOPMBTr7MvHFOylXhYa2OdGzgOuMBP3LRP+az/Cu5DF9kNgkC9XoUfAq5pLvd1v2/Z
 VRNVARmJxHm/oEsmhV/b58MUeIdC/a/cVDC4Yd3OzvWoeyhXNQx1/mDxnswN4gHPIgd7
 Yf65VJQhBjSSAM4c5qAPf+DogZkOEDLjWu0fiXql9eLjfyHJlQnmtXp/5GYf6YeNpb8g
 uUvPeE46usPmpFf50hkCcjEFU1F8Kd3CJ4DaT3dtnYFJDzLUpDJtWcCMJvWHwtX4yme2
 GTnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746604179; x=1747208979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zg8izujCJX6n4ZSsWtPsm+MbiII4lDcZjLmu+2x60iI=;
 b=dHONjizm7qadZ4+6GquhkcWr0fmeubNuYVG4cpPf71wI20XSJ/31qCQGkX97HX1SfG
 2YC4he9IJX49NHJx7f4FkDbGj0g87NM5AmJMcOlg2Xi2rrOdq/2AvpF2rTZxo0j9DgWf
 y9fw48x7LbUvrXjqpNAGAlkH/+Fb396kBDfAin33+FsXKLcOA6/6x7YM6Yusvci7YvHy
 n5z0RAs9c0kcuSyPurx/VEMMiPb4G2xqUt8AGh9Qcr4+rBv7Gs9hDqT79njDTZYEgyQr
 ZnCeij4KPouXH7LK3UqpSiCvHAUGBcl92fWwvrXK5Ix/Vd31SAamS44ZnHW6sqsTQcrt
 8g/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8+9CxzVoXMLSMaf8z8H59zy1l/HAlbqcFmvWH6COdqqejvCNIogWVNqAbgIBbVXdgQsumlGY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+HQ/yQH2UI2hp/X1wr01Tn1NAa5VKN+E3CjtHgSIREkOJWqPb
 UJ5P+gXZ7CIEzed8OObTBvHP5YlQ/IyUC6qcMkdElV3rHfNW3B1GE5csu7N5xxMzYyVOphmE33B
 BF/hUgBK/OPwhfAjvJdMBfprbeYCFU+WSksyexw==
X-Gm-Gg: ASbGnctXMprwX+sm6y7+LzQBvLCaFAOvqGM7CY9oFgMgi6JEPsF4UrDbsdzqB6hNmQj
 7uYga0ykjQdUBDMrJgbMLqNbLHAEPkuXeGS4OZRucXFcA4kCP7YEJLTNFQtJ8c22ydrfA7ObSwI
 UzNoREoPbO1YiRgVSIytuHpLQ=
X-Google-Smtp-Source: AGHT+IGUF9CZRLge/NWGNyKNQa3ZubpHO5llNyQSQs7M0cxsgISkLErANyYrkRrsLvzBuL+0w+F4IUNBxhwSyUk3c+c=
X-Received: by 2002:a05:6102:5794:b0:4af:fca2:1b7 with SMTP id
 ada2fe7eead31-4dc737fed90mr1655702137.14.1746604179140; Wed, 07 May 2025
 00:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
 <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
In-Reply-To: <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 7 May 2025 13:19:28 +0530
X-Gm-Features: ATxdqUGCA6IneOnLmyNEQMSCXYkN44nNCjZGP7yMjIh3zi5gEZfa31Jedywn9pQ
Message-ID: <CADg8p9547kkDg=N990eGqfOF+4e+vG1MRda-faKw7bXOn-2g+w@mail.gmail.com>
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

I was able to hook up gdb and re-create the issue. What I observe is
that when the lmb_allocate_mem() function is called, the base address
parameter, which is 64-bits, shows a value with the upper 32-bits not
zeroed out. So, this looks like a compiler issue, where the upper
32-bits are not being zeroed out. Fwiw, this shows up with the
compiler being used in the CI environment, as well as the one that I
am using.

/toolchains/riscv32-linux/bin/riscv32-linux-gcc --version
riscv32-linux-gcc (GCC) 13.2.0

/toolchains/riscv32-linux/bin/riscv32-linux-ld --version
GNU ld (GNU Binutils) 2.41

Given that LPAE is not being used on riscv32 platforms in U-Boot, I
think this patch should be considered. Thanks.

-sughosh

>
> If we don't correct the root cause, it will hit us again.
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
