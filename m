Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FBFC3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 09:41:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAC6381F32;
	Wed,  7 May 2025 11:41:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="puTtrd1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 983EB8212F; Wed,  7 May 2025 11:41:53 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22FD8007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 11:41:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-878627ac2ddso187556241.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 02:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746610909; x=1747215709; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GDYHj/g0pWROc4xqjxTfUJUL7w8ify2+zyRXpFexbII=;
 b=puTtrd1SVQ/sHYlBwY+ihMs326IWR9n4vCLLUjfpzi/BrpokZde5XK1K8N5Htm1nHI
 D3viqQSVdeh9ck3t5xKrbPMDGYifhMuz2e/CrJCiSXH2BOIppYGx7OouV+K7Bix+7uE1
 /xrDsu7orCStsBck6+0aWnzKZz/7+HrwZA3dkcoJNYXCytoHpXFwY+gHpkykDrdXQ/Fa
 Mw//7jY/LkzyEhXhOLT07rw6Nwxu8SvrDjcN9uyRe0fJ3LMJFKSUaGbHJIHZNJVRYUEt
 3SmLWA2EVCEMCz5SLE49vCImGJAmJRJAbR5FiY344lpbKln0NMkACMwgM9VXKs9jOKoX
 RIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746610909; x=1747215709;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GDYHj/g0pWROc4xqjxTfUJUL7w8ify2+zyRXpFexbII=;
 b=G57dhBC6psARkqk+i+j2nOmD9o4HSaSw5oBEx6ebIQsOZlKa7bk1v6ohjQ558pLdrs
 TsxwWAfkBxxUZJAsD8qykd1QP5zzLZnVZy+gmlxjN5gxHrYZIjkU+LIDMRQvgSZg1/KI
 L3G0J6wAjWxGD7NptYhSSx6Kt0fwwKkN2hIqYnoYW0RfhwAzEpg+epOSgPU85O+b7IGc
 45Gz7rVDLQVBoCFV67vZRF2tO2lW/v98DXkPvNjuowiWU9wWwmaS/zIbl8bCxZwk9xr6
 t9duHsqS7jejSVPhQkfU9hWgiZwzHQBVycwTDYfSh6wRw3vGZgYlZaQKzMYVzUyXnMao
 M3NA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpgcYdPM6lX0c1cZ8toQZxA4xtizhgPK5qZDhSyKUO8mXhY6sZCqO4jtUVoLZQfnJYHUUwM6o=@lists.denx.de
X-Gm-Message-State: AOJu0YwdRueAI+NkC+gJ9RlE9FCvaqYYAHt9RLB2i+/H/dwMkImbBrdE
 mHMm80cCcMVDlcBxYLaKpkeJtg58G3aeAGRFwJ6PQHXIRZbx4pgu1Kp4EtkH0M4GtB6bhyOEevT
 oVwbJEQ7de99xVc2t04O2Gik3XkRPaDwgTILi3Q==
X-Gm-Gg: ASbGncuDLg9blbFfUy9CN/rLTPawdIRJlv+UMGhcE2WVmf0H8Vayf/UZRBue3OSezUn
 THxfElvmtYr1nzT2pxSpN7+/p8iPM0Dn/ZXvShVIZhvlDVSbrySepflYoBqE8FeiDIQyflLgA1h
 16ssq1oyyiMtNozO5Mu+xHCqc=
X-Google-Smtp-Source: AGHT+IGTwVFa1swcnO233tDO7lp5CnOOoOXKoWu253+VEQjN7Lk0+E77saSkk+zy2XsU85BEZhS3pPOplTluJzFjISA=
X-Received: by 2002:a05:6102:3e85:b0:4dc:8a4f:23dd with SMTP id
 ada2fe7eead31-4dc8a4f267dmr1105215137.0.1746610909578; Wed, 07 May 2025
 02:41:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
 <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
 <CADg8p9547kkDg=N990eGqfOF+4e+vG1MRda-faKw7bXOn-2g+w@mail.gmail.com>
In-Reply-To: <CADg8p9547kkDg=N990eGqfOF+4e+vG1MRda-faKw7bXOn-2g+w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 7 May 2025 15:11:38 +0530
X-Gm-Features: ATxdqUHeUmtCgcAXq0hkrOpg0BqGqSJLeBa6PJXn_UkhREYQe1FcIXSirKNeRfM
Message-ID: <CADg8p94OcjLZxAyxuvAHCim2zAhdYEkp5cpegeN0oZ5dm9=hzw@mail.gmail.com>
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

On Wed, 7 May 2025 at 13:19, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 6 May 2025 at 16:35, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> >
> >
> > Sughosh Ganu <sughosh.ganu@linaro.org> schrieb am Di., 6. Mai 2025, 12:50:
> >>
> >> On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >> >
> >> > On 5/6/25 11:24, Sughosh Ganu wrote:
> >> > > U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
> >> > > the width of the phys_{addr,size}_t data types based on the register
> >> > > size of the architecture.
> >> > >
> >> > > Currently, even the 32-bit RiscV platforms have a 64-bit
> >> > > phys_{addr,size}_t data types. This causes issues on the 32-bit
> >> > > platforms, where the upper 32-bits of the variables of these types
> >> > > can have junk data, and that can cause all kinds of side-effects.
> >> >
> >> > How could it be that the upper 32-bit have junk data?
> >> >
> >> > When we convert from a shorter variable the compiler should fill the
> >> > upper bits with zero.
> >>
> >> That does not seem to be happening. The efi_fit test fails on the
> >> qemu-riscv32 platform, when attempting to boot the OS from the FIT
> >> image.
> >>
> >> These are the values of the base address that I see in the
> >> _lmb_alloc_addr() function.
> >>
> >> _lmb_alloc_addr: 755, rgn => -1, base => 0x1a1c0e00802000bc, size => 0x50b1
> >
> >
> > As you are running on QEMU you should be able to track down where the value is actually assigned with gdb. This could for instance be a buffer overrun.
>
> I was able to hook up gdb and re-create the issue. What I observe is
> that when the lmb_allocate_mem() function is called, the base address
> parameter, which is 64-bits, shows a value with the upper 32-bits not
> zeroed out. So, this looks like a compiler issue, where the upper
> 32-bits are not being zeroed out. Fwiw, this shows up with the
> compiler being used in the CI environment, as well as the one that I
> am using.

Thinking a bit on this, I don't think this is a compiler issue. The
problem is that we are using the ulong type in some places(especially
in the boot* commands) for storing the address values, while we use
phys_addr_t in other places. And because this is a pointer being
passed across functions, when the data-type that the pointer is
pointing to changes from a 32-bit to 64-bit value, the upper 32-bits
get considered. So the issue is that we use ulong in some places, and
phys_addr_t in others for storing the addresses.

But I think that the solution for this(at least for now) is to set
phys_addr_t based on the underlying architecture. In the long run,
there needs to be an audit of the usage of ulong for storing
addresses, and that needs to be changed to phys_addr_t.

-sughosh

>
> /toolchains/riscv32-linux/bin/riscv32-linux-gcc --version
> riscv32-linux-gcc (GCC) 13.2.0
>
> /toolchains/riscv32-linux/bin/riscv32-linux-ld --version
> GNU ld (GNU Binutils) 2.41
>
> Given that LPAE is not being used on riscv32 platforms in U-Boot, I
> think this patch should be considered. Thanks.
>
> -sughosh
>
> >
> > If we don't correct the root cause, it will hit us again.
> >
> > Best regards
> >
> > Heinrich
> >
> >>
> >> The actual value that gets passed is 0x802000bc. The upper 32-bits do
> >> not get zeroed out. Which causes the _lmb_alloc_addr() to return an
> >> error. You can check my branch [1], where I have put a temporary
> >> commit to print the values that cause the issue.
> >>
> >> -sughosh
> >>
> >> [1] - https://source.denx.de/u-boot/contributors/sng/u-boot/-/commits/lmb_apis_cleanup_bisectable_v2
> >>
> >> >
> >> > >
> >> > > This was discovered on the qemu Riscv 32-bit platform  when the return
> >> > > value of an LMB API was checked, and some LMB allocation that ought
> >> > > not to have failed, was failing. The upper 32-bits of the address
> >> > > variable contained garbage, resulting in failures.
> >> > >
> >> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >> > > ---
> >> > >
> >> > > Note:
> >> > > Although the LMB API cleanup series depends on this patch, I am
> >> > > sending it separately so that it gets noticed by the RiscV
> >> > > maintainers. Sometimes a patch may not get the required attention when
> >> > > sent as part of another seemingly unrelated series.
> >> > >
> >> > >
> >> > >   arch/riscv/include/asm/types.h | 9 +++++++--
> >> > >   1 file changed, 7 insertions(+), 2 deletions(-)
> >> > >
> >> > > diff --git a/arch/riscv/include/asm/types.h b/arch/riscv/include/asm/types.h
> >> > > index 49f7a5d6b3a..45d806c83eb 100644
> >> > > --- a/arch/riscv/include/asm/types.h
> >> > > +++ b/arch/riscv/include/asm/types.h
> >> > > @@ -35,8 +35,13 @@ typedef u64 dma_addr_t;
> >> > >   typedef u32 dma_addr_t;
> >> > >   #endif
> >> > >
> >> > > -typedef unsigned long long phys_addr_t;
> >> > > -typedef unsigned long long phys_size_t;
> >> > > +#ifdef CONFIG_PHYS_64BIT
> >> > > +typedef u64 phys_addr_t;
> >> > > +typedef u64 phys_size_t;
> >> > > +#else
> >> > > +typedef u32 phys_addr_t;
> >> > > +typedef u32 phys_size_t;
> >> >
> >> > This matches what has been done for ARM.
> >> >
> >> > 86c915628d58 ("riscv: Change phys_addr_t and phys_size_t to 64-bit")
> >> > changed the definition to 64bit phys addr_t to support the 34bit
> >> > physical addresses (similar to LPAE on arm32).
> >> >
> >> > I don't think that we need 34bit support currently. But I would prefer
> >> > if we could find the root cause why the upper 32bit gets messed up as
> >> > this might point to a generic problem.
> >> >
> >> > Best regards
> >> >
> >> > Heinrich
> >> >
> >> > > +#endif
> >> > >
> >> > >   #endif /* __KERNEL__ */
> >> > >
> >> >
