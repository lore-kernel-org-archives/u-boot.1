Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B5CC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 10:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA0DD8211F;
	Tue,  6 May 2025 12:50:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZLxLRB//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59E0782163; Tue,  6 May 2025 12:50:13 +0200 (CEST)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A31A8800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 12:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4c30a4bcceeso1961088137.3
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746528609; x=1747133409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZflZRdvPoHqI8KLyT2FzVNHJcfuL9gYq9fcDr9ubEiA=;
 b=ZLxLRB//uwl1WOFyZiM1w3JqEDZhGveZbvOQ4uVDXetYxRBjX7Xd1D+6Mjwc7sejjg
 jYi38wwhLxvUm/cLVETT54rI92ISn99i1sVm8TcirMx2W5HqH22y5j2+oTr1uWO1pkT7
 atA2C7MnpOzv/lRnHTsPXtGg7s6MefUL79bfrEHcrQM1ul/pMPj2kZlcb2Kxk7UF+zdI
 I2XyfKpjfWIyd3mEpkELZQjkvzz7Q5zNLFHSm3Y70j902Kvuh8NSFa8o4hLBI2Mb2fSW
 lGQ25XUovvTeikqUfowougwTe5PBAxsbfOWAmEwZxIZOvoFz4tEBmFQB+Bxoz83pvhiG
 XQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746528609; x=1747133409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZflZRdvPoHqI8KLyT2FzVNHJcfuL9gYq9fcDr9ubEiA=;
 b=mtU+HG85++W3QOMeLdv41Z1wQJj9KFZs0PSKCGPWVtX3By0kMZQUP3pzmVXV+vjGSW
 mVZeTnAReqWvM2NJHM2Akohl0oNl7eOmVX1PWyiuc8dgdC5W4GjQjdX16hIYlZr0CGxW
 jcMYktdmdwRKk2PmTs1/jsjpvzJ33Bh0yBOmm7ikUxx+wFpMV54MXdqBXcVRjsXMF1Ue
 UNJoZa6D7oPX76W9mkUuQsK3MwYV5O+QFDnAq8u9bsB2Y4BqFPVT5uhVqjNhGqlQ0FQN
 YwQSIDcPWhdhfZNopF6/7aDlO4d8eafOKr2NteNCxBfeCGngC4bkIgorXoZX+slq6Zd/
 yohQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqOKKyKEhZbvLaM/0okXA7simJMgRVQvYgO7eaB8sbmyv3k0bEnK/t2gbkagS7ZKlP839biTM=@lists.denx.de
X-Gm-Message-State: AOJu0YzIUmIqgCKu7EmeUb0ypbdy8kC3ipQ513CtGwqBiezfgUR/NnGo
 q/fZeVSk74/GUHcWYhlbapJXeG/5WeXDEwdJEchHKlmxHHf9UtTx4uibIE2S7mCCxVKw81uRx4I
 fLqNlRlXHOx05s6T8DdoKlOkBV6cjn4mkRSWjQQ==
X-Gm-Gg: ASbGnctFrF7ed/283lHWuLjBJcVTaikG4CHZ3Aa9Te4hJjyxeyJjq2OsUGJ+oZzMlsv
 alQPtzUIImHUxSM3yNCVC34syLafjXajkytqyqQdUbOWCq56bIH5zPFQ9vNGiPsJB881u0H04Jr
 43g1HVioKqlbhDbEslOETcvt0=
X-Google-Smtp-Source: AGHT+IF5Dp87qrXD5if/8NvbrPIh6q3KUGOdY6OBSJ4rgJ7MRNHy/ZOF+knJOocWGK6FOFdR1rQ5VSng9V4fnOv6onA=
X-Received: by 2002:a05:6102:918:b0:4c1:8928:cefb with SMTP id
 ada2fe7eead31-4db148197a4mr6621301137.12.1746528609441; Tue, 06 May 2025
 03:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
In-Reply-To: <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 6 May 2025 16:19:58 +0530
X-Gm-Features: ATxdqUHul2Z1_15a3mrpxInym7SiQ81LmTNsjtqUkb_GWvbDZF3bu3VFF9_juhQ
Message-ID: <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
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

On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 5/6/25 11:24, Sughosh Ganu wrote:
> > U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
> > the width of the phys_{addr,size}_t data types based on the register
> > size of the architecture.
> >
> > Currently, even the 32-bit RiscV platforms have a 64-bit
> > phys_{addr,size}_t data types. This causes issues on the 32-bit
> > platforms, where the upper 32-bits of the variables of these types
> > can have junk data, and that can cause all kinds of side-effects.
>
> How could it be that the upper 32-bit have junk data?
>
> When we convert from a shorter variable the compiler should fill the
> upper bits with zero.

That does not seem to be happening. The efi_fit test fails on the
qemu-riscv32 platform, when attempting to boot the OS from the FIT
image.

These are the values of the base address that I see in the
_lmb_alloc_addr() function.

_lmb_alloc_addr: 755, rgn => -1, base => 0x1a1c0e00802000bc, size => 0x50b1

The actual value that gets passed is 0x802000bc. The upper 32-bits do
not get zeroed out. Which causes the _lmb_alloc_addr() to return an
error. You can check my branch [1], where I have put a temporary
commit to print the values that cause the issue.

-sughosh

[1] - https://source.denx.de/u-boot/contributors/sng/u-boot/-/commits/lmb_apis_cleanup_bisectable_v2

>
> >
> > This was discovered on the qemu Riscv 32-bit platform  when the return
> > value of an LMB API was checked, and some LMB allocation that ought
> > not to have failed, was failing. The upper 32-bits of the address
> > variable contained garbage, resulting in failures.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >
> > Note:
> > Although the LMB API cleanup series depends on this patch, I am
> > sending it separately so that it gets noticed by the RiscV
> > maintainers. Sometimes a patch may not get the required attention when
> > sent as part of another seemingly unrelated series.
> >
> >
> >   arch/riscv/include/asm/types.h | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/types.h b/arch/riscv/include/asm/types.h
> > index 49f7a5d6b3a..45d806c83eb 100644
> > --- a/arch/riscv/include/asm/types.h
> > +++ b/arch/riscv/include/asm/types.h
> > @@ -35,8 +35,13 @@ typedef u64 dma_addr_t;
> >   typedef u32 dma_addr_t;
> >   #endif
> >
> > -typedef unsigned long long phys_addr_t;
> > -typedef unsigned long long phys_size_t;
> > +#ifdef CONFIG_PHYS_64BIT
> > +typedef u64 phys_addr_t;
> > +typedef u64 phys_size_t;
> > +#else
> > +typedef u32 phys_addr_t;
> > +typedef u32 phys_size_t;
>
> This matches what has been done for ARM.
>
> 86c915628d58 ("riscv: Change phys_addr_t and phys_size_t to 64-bit")
> changed the definition to 64bit phys addr_t to support the 34bit
> physical addresses (similar to LPAE on arm32).
>
> I don't think that we need 34bit support currently. But I would prefer
> if we could find the root cause why the upper 32bit gets messed up as
> this might point to a generic problem.
>
> Best regards
>
> Heinrich
>
> > +#endif
> >
> >   #endif /* __KERNEL__ */
> >
>
