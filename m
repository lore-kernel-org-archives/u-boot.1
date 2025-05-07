Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125F3C3ABBF
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 18:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 379568209C;
	Wed,  7 May 2025 20:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L0u7FChE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752F3820EB; Wed,  7 May 2025 20:37:52 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D157381FAB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 20:37:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-4c36071916dso51682137.2
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 11:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746643068; x=1747247868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IaGpepk3VdFrJSkQim7KqLP0SrIYeLxHbFe+sZ9f4gM=;
 b=L0u7FChEP98F57vnb3NtHwXScBR44PuDG/4UuS88e5BTUSMaF18e0PpcMZxIlIHzNQ
 UWKoR0Uc/ZLH5HCyDNMnh5CEqJcURxEb/BcIhY2byUFzOPHsOzB7zo5vNvgtWANKRPnW
 03SEYSfsh+lTch0atE4TRyt6MfJ4VQbUDBMtZtGjo/5TfmygY9sRAUm8aBb5MCWUaRuW
 1u5yv/yBbfGfuLru7/VuDmtAQuU1iov5QET/Fxm489uax3X7UYuya+yHVuVoOxJgg5ei
 VwJmMWJgtobKT8q4GVtsWq8FZmR6iGcF4sK9AXla0QJyd1oOVL7iZIMPS7fbW1M1GxPc
 sYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746643068; x=1747247868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IaGpepk3VdFrJSkQim7KqLP0SrIYeLxHbFe+sZ9f4gM=;
 b=lZ2U725UF/2gh98G4X4hLgqdroXcYGAuhXy9D3vH0ARKx6AGasuj6fhCMLY8cQQIqp
 jGkDyHqz/K1u5ZIXtSJIhq/Vka9q5U/1cVyiU1K3OacyAx8QYe6BKj029OinqikzfKS1
 k6a4rM8aKtELm8qYaocO4imEQvzceLHV+VQhJSH37tVSu3XEK01Jk9JzxvQ2JH5nkmAU
 CurA3HsLk58ZfsyMNii7TfoXN5Y2IfYt02JJR9Yce9jMumHmYbpgJ2YtwyYRrAEK2hCt
 swhvm/SdO6DkZWLodhu434OMLppsjebyUYAIOweD1bDVdZqTCppyWypuWjW/y6HPRrZq
 WpIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUELVCZfBqEYcqac13FDOehE+51BIzfKRy9o+/2zM4kY/LH/lIVnzi4m3tw4/8lKsmy5HMrH0E=@lists.denx.de
X-Gm-Message-State: AOJu0YyXpPC5cQMAkp8WzDFyrPpBYHWfWaarrZHAsBIIlu2OjOfpk7b6
 4MDmeE+dDkQorD1vivNpC073wXvxE05fXdkhbQ6VkNn9c52dI9NZa2LEyxEQgdNcPlTMXgIlL5Z
 oKlBItIEMtn7lPy7cIQI5EGS4N3GaxqdSWXmMrQ==
X-Gm-Gg: ASbGncsx9brYecXq1Nct6q9S2mWXITmbWVCnDE4tnCXLdnjMsJ6ZxgVc+0ISks2KKe0
 zpszknOZdS60qCqwBxpbY/cUO4qQT5LM5hrqMwdBTdgeH7k+PNM8b6DN/tBRHz/UGJ4shdOTBZ1
 Bdy9ukVdPr+iglFYoLmR5ajg==
X-Google-Smtp-Source: AGHT+IHI/r9O1hU/z3vG4FP84YSs7zhezgFLcYmESQ5V273ChwXT7SBkQfZSd7KlaWg7gv/XHIuQ3KNBoeJQTUilJF0=
X-Received: by 2002:a67:e711:0:b0:4bb:c8e5:aa8b with SMTP id
 ada2fe7eead31-4dc738bc384mr4313780137.22.1746643068519; Wed, 07 May 2025
 11:37:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
 <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
 <CADg8p94crfzYzhR+jFFFRR=Xp6wY3cADXSQmKxXvVgvn9GHBkA@mail.gmail.com>
 <CAM=mAO=8gP3J9Kt5ox-Gpd43s8ozZ+t42O4dBNnYV32hMS_pMg@mail.gmail.com>
 <CADg8p9547kkDg=N990eGqfOF+4e+vG1MRda-faKw7bXOn-2g+w@mail.gmail.com>
 <CADg8p94OcjLZxAyxuvAHCim2zAhdYEkp5cpegeN0oZ5dm9=hzw@mail.gmail.com>
 <20250507154839.GL5430@bill-the-cat>
In-Reply-To: <20250507154839.GL5430@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 8 May 2025 00:07:37 +0530
X-Gm-Features: ATxdqUEvJlS3t6xQMK3HSRpO7BhaWFR88iamelgxrt3ghrEybwQ0ngD5uH8iSsc
Message-ID: <CADg8p97Puqi5my9SXCjGFmJan3hC5xPFWa45+072hcPkwyR-WQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
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

On Wed, 7 May 2025 at 21:18, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 07, 2025 at 03:11:38PM +0530, Sughosh Ganu wrote:
> > On Wed, 7 May 2025 at 13:19, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Tue, 6 May 2025 at 16:35, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > >
> > > >
> > > > Sughosh Ganu <sughosh.ganu@linaro.org> schrieb am Di., 6. Mai 2025, 12:50:
> > > >>
> > > >> On Tue, 6 May 2025 at 15:19, Heinrich Schuchardt
> > > >> <heinrich.schuchardt@canonical.com> wrote:
> > > >> >
> > > >> > On 5/6/25 11:24, Sughosh Ganu wrote:
> > > >> > > U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
> > > >> > > the width of the phys_{addr,size}_t data types based on the register
> > > >> > > size of the architecture.
> > > >> > >
> > > >> > > Currently, even the 32-bit RiscV platforms have a 64-bit
> > > >> > > phys_{addr,size}_t data types. This causes issues on the 32-bit
> > > >> > > platforms, where the upper 32-bits of the variables of these types
> > > >> > > can have junk data, and that can cause all kinds of side-effects.
> > > >> >
> > > >> > How could it be that the upper 32-bit have junk data?
> > > >> >
> > > >> > When we convert from a shorter variable the compiler should fill the
> > > >> > upper bits with zero.
> > > >>
> > > >> That does not seem to be happening. The efi_fit test fails on the
> > > >> qemu-riscv32 platform, when attempting to boot the OS from the FIT
> > > >> image.
> > > >>
> > > >> These are the values of the base address that I see in the
> > > >> _lmb_alloc_addr() function.
> > > >>
> > > >> _lmb_alloc_addr: 755, rgn => -1, base => 0x1a1c0e00802000bc, size => 0x50b1
> > > >
> > > >
> > > > As you are running on QEMU you should be able to track down where the value is actually assigned with gdb. This could for instance be a buffer overrun.
> > >
> > > I was able to hook up gdb and re-create the issue. What I observe is
> > > that when the lmb_allocate_mem() function is called, the base address
> > > parameter, which is 64-bits, shows a value with the upper 32-bits not
> > > zeroed out. So, this looks like a compiler issue, where the upper
> > > 32-bits are not being zeroed out. Fwiw, this shows up with the
> > > compiler being used in the CI environment, as well as the one that I
> > > am using.
> >
> > Thinking a bit on this, I don't think this is a compiler issue. The
> > problem is that we are using the ulong type in some places(especially
> > in the boot* commands) for storing the address values, while we use
> > phys_addr_t in other places. And because this is a pointer being
> > passed across functions, when the data-type that the pointer is
> > pointing to changes from a 32-bit to 64-bit value, the upper 32-bits
> > get considered. So the issue is that we use ulong in some places, and
> > phys_addr_t in others for storing the addresses.
> >
> > But I think that the solution for this(at least for now) is to set
> > phys_addr_t based on the underlying architecture. In the long run,
> > there needs to be an audit of the usage of ulong for storing
> > addresses, and that needs to be changed to phys_addr_t.
>
> Thanks for digging in to this more. I agree with what you're saying here
> for both the short and long term.

Heinrich and I had a discussion on IRC on this, and for the short
term, it was decided to instead have the ulong values copied into a
local variable of type phys_addr_t before calling the lmb API. This
approach too will work for now. Heinrich is of the opinion that it
would be better not to make the change to the riscv32 file as the
maintainers think it appropriate to use u64 for phys_addr_t. I will be
making this change as part of my upcoming version of the lmb API
series. I will be on leave for the next week, and will send the v2
once back. Thanks.

-sughosh

>
> --
> Tom
