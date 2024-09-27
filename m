Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D3CDD1CD
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 16:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B43598913A;
	Fri, 27 Sep 2024 18:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SwwuGxTP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBD978913B; Fri, 27 Sep 2024 18:52:42 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600BD89133
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 18:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2458774dso16144546d6.3
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727455959; x=1728060759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=35WJSAck4PSNay6L+fsPR5VlPbbMSsHtFXQGdEL06OA=;
 b=SwwuGxTPd4S8rcTAs6XY4cMKv+BDk0jMwWVfKWSQqFj78k9O+dmMSNT0uyiskD4G2J
 2eaz6BHhJ4srIFq0dC/NED1snCPA9GUl0sgppCaZ2c0pdDnI8P6SPrKfLX3mOPI+uBua
 s7G/dueC69a5veU5NIHnZTKALEYlgsHR0OiR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727455959; x=1728060759;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=35WJSAck4PSNay6L+fsPR5VlPbbMSsHtFXQGdEL06OA=;
 b=V2FBs41zQKxRTucyoHaU7pyKLYYuEok1k29G8lDO8KumQnEWJsQsxgjxh94etZrkIx
 2VTLIPbTFV5Opau3VjlgwBZXb33WEmBrO2lTvquaJFg0RGI/h7mVmbK5rNn1QlqDPf6F
 j9ih+0MZThF8DcQ08RR8lle6OecXoj5u8OC6l8x5BRHwNI9Hs0m7W3zQu1XiVCvsZR5J
 19BjAl+8NnNpmOWLDSIjzrr+eZr0mQyE4ObmEg3tg56xeFlKrBpNIR+I4aprQRzLTW3e
 5YIdSISABCemoSOxZLrcbes/ZDrzVRqqO29BFmWI9obveCNbePKt6puaIcc4xWKh7eJq
 KUbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnerFCQ6HFRbYChC9Fu6l7wi8qsYzAmBGw4oFEfTBny+ZN9YS7DrWOArVckzrwXQy7GqtgWgs=@lists.denx.de
X-Gm-Message-State: AOJu0YwbQMAtJl9ZP0xWsET4SGfv2+rbFP3wNEjC2iSBL8Q9JcMY8lLT
 WW8dCRqdEUKJm6wvTX+0ZoCy+ReL1odpiI+jn97psOVe4tGmt7Bb6HQl5uB6/8MoJLpCiKFpYpq
 zmr5NnabUAiQ4QE+UdMvZliWff/IqSi0nmVEA
X-Google-Smtp-Source: AGHT+IEx4VRF/w7H1aC1YgWJR9Jd3fkNnjm6pOB63MxyHElcuGapZjX+DDo3OaCTbFWBf6StzV/d4pYR00lPoLUwN6A=
X-Received: by 2002:a05:6214:4a01:b0:6cb:397a:84ba with SMTP id
 6a1803df08f44-6cb3b63db90mr66296126d6.39.1727455959206; Fri, 27 Sep 2024
 09:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
 <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
 <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
 <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
 <CALNFmy3-0u=RhhiPgCzj2szzhaADXrWm79jkD1p3pmpmto456g@mail.gmail.com>
 <CAFLszThqaF9oSxEW5ZYw9udqtC+8n3BhQj313qUvRvrQV=OwWw@mail.gmail.com>
 <CAC_iWjKPrUu+j5dJNbQWZB+J7OUa1X01e_d8cN=YSrO_86cOhA@mail.gmail.com>
 <CAFLszTjoZuF6x38j_PyQdO9W_zzyQY+DPrXKm8J2pM-T_GYsgA@mail.gmail.com>
 <CAC_iWjLR7ndQAPOhe+Z-11F-nFXBGpPUOZB=Mmwt36CzJtvD0g@mail.gmail.com>
 <CAFLszThcqgvAf0DDKhOXnKAdQ21r-PLDppTM=CASbaaONTei4g@mail.gmail.com>
 <CAC_iWjJnANTb27oWVJiucUSPfuE5gW7HWDQCjTegDy1iVeQqNg@mail.gmail.com>
In-Reply-To: <CAC_iWjJnANTb27oWVJiucUSPfuE5gW7HWDQCjTegDy1iVeQqNg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 10:52:28 -0600
Message-ID: <CAFLszTjw7TohX+-B==zbCBVFyyCVCnvpKbysim1o6eJCfQsCPg@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Fri, 27 Sept 2024 at 07:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > > > > > in one place with 'bloblist list'
> > > > > > > >
> > > > > > >
> > > > > > > So what's the consent and the next step here?
> > > > > > > Is the current code OK as is, as it works with both BLOBLIST and without?
> > > > > > > Should I drop support for one or the other?
> > > > > >
> > > > > > Just BLOBLIST. The EFI allocation is done using efi_acpi.c which you
> > > > > > can check to make sure it is working.
> > > > > >
> > > > > > Using efi_allocate_pages() before the app starts is not good.
> > > > >
> > > > > Simon, please stop trying to enforce decisions on subsystems you don't
> > > > > maintain. I am pretty sure both Heinrich and I said no to this.
> > > >
> > > > I am the ACPI maintainer, and x86 maintainer long before ACPI came in
> > > > for ARM (which I originally hacked together, as you know). I also
> > > > wrote bloblist, including the header file which says:
> > >
> > > That's not the EFI subsystem though. And last time I checked where the
> > > ACPI tables are allocated makes no difference as long as they are
> > > installed on a config table.
> >
> > With my maintainer hat on, ACPI tables go in a bloblist.
> >
> > The difference it makes is that the tables end up in the U-Boot memory-area.
> >
> > >
> > > >
> > > >  * 6. Bloblist is designed to be passed to Linux as reserved memory.
> > > > While linux
> > > >  * doesn't understand the bloblist header, it can be passed the indivdual blobs.
> > >
> > > And as I already said, *when* bloblist is consumed by any OS and you
> > > have a valid use case other than "I can do bloblist list and I like
> > > it", you can change 3 lines of code and allocate the ACPI table there.
> >
> > Bloblist is not intended to be consumed by an OS. It is a firmware
> > construct, a way for U-Boot to arrange things in such a way that they
> > can be located and updated at runtime. What objection do you actually
> > have to using bloblist for tables?
>
> That bloblist, is currently used for the firmware handoff protocol.
> And that protocol *ends* when U-Boot launches, so I don't see why
> adding anything there that's not defined makes any sense.
>
> >
> > >
> > > >  * For example, ACPI tables can reside in a blob and the address of those is
> > > >  * passed to Linux, without Linux ever being away of the existence of a
> > > >  * bloblist. Having all the blobs contiguous in memory simplifies the
> > > >  * reserved-memory space.
> > >
> > > No, it doesn't because all of the other tables are currently allocated
> > > by the EFI subsystem. So it actually fragments it. Apart from that You
> > > dont really know what the OS is going to do with that memory. It
> > > depends on the EFI memory type and OS decisions.
> >
> > The ACPI table is not allocated by the EFI subsystem. Neither is
> > SMBIOS, which currently uses malloc() but should move into a bloblist
> > too.
>
> SMBIOS is different. it's not tightly linked to EFI. But we mark that
> region properly in memory as well.
>
> > The system table is in U-Boot's data region. Much of EFI's data
> > and all the driver model stuff is in the malloc() region.
>
> You keep saying "much of EFI data" and I keep repeating that whatever
> is *not* needed by the EFI spec, internal allocations, lists, etc we
> use malloc. Whatever is described in the EFI spec, we use
> efi_allocate_XXXXXX()
>
> >
> > >
> > > >
> > > > This decision has serious impacts on memory management in U-Boot. It
> > > > also bears on the complexity of memory, how bootstd works, board
> > > > scripts and the like. We should discuss this and figure out a path
> > > > forward.
> > >
> > > It has close to zero impact because *all* of the EFI memory lives in
> > > top memory. So apart from the EFI_BOUNCE_BUFFER perhaps,  I don't see
> > > why the impact is """serious""".
> > > EFI allocates memory which does not affect U-Boot of file loading
> > > apart from the max size allowed. Now with LMB it is marked as
> > > reserved. So why is this any different from any other LMB reservation?
> > > It's memory used by someone that you aren't allowed to use, just like
> > > we reserve U-Boot memory. If there's a bug in reservations, by all
> > > means, let's fix it.
> >
> > I think you are saying that because only a small amount of memory is
> > affected it doesn't matter much.
>
> No, I am saying this because you need to allocate the memory
> regardless if you want to support EFI. So as long as it's not in the
> middle of the memory space, not allowing you to load stuff, it makes
> little difference.
>
> > Well, I suppose so. But if it doesn't
> > matter, why is Sughosh spending all this time solving the problem?
>
> First of all, we got multiple asks from Tom saying LMB wasn't doing
> all that it should for a long time and needed fixing regardless.
> LMB prior to the patches was calling efi_get_memory_map_alloc() on the
> reserve function and be aware of EFI mappings, but that wasn't the
> best solution. With the lmb created on the fly we also had to call
> that function every time before LMB could decide what memory is free.
>
> > Also with [1] I definitely saw it allocating stuff where it should
> > not. If it has so little impact, why are we still discussing it?
>
> So why is this a problem if LMB now says "you are going to overwrite
> system memory"?
> Also, how are you loading the kernel and initrd? To boot with EFI? Can
> you send me a reproducer?
> What I imagine is happening is that you deliberately choose a high
> address, which somehow gets overwritten. But with LMB in place this
> goes away.
>
> >  Also,
> > my efforts seem to have uncovered latent bugs, where EFI tests fail if
> > there is not a large margin after each allocation. That should be
> > cause for concern. We would not put up with that elsewhere in U-Boot.
> >
> > I am not trying to mess with EFI in U-Boot, if that is what you are
> > worried about. Actually I haven't been paying it enough attention as
> > it is in good hands...but I need to put more time into it. As a
> > subsystem it is here for the long haul and it needs to interoperate
> > properly.
>
> Unfortunately, it doesn't have to merely interpolate. There are some
> spec requirements we can't twist around because we used to do things
> differently 8 years ago. The clear answer here, is disable EFI for
> anyone that thinks it's so intrusive. And report breakages so we can
> fix them.
>
> > I was at a conference last week where there was a talk about
> > U-Boot as an EFI app with a pass-through (i.e. not calling
> > exit-boot-services) to Linux's EFI stub. There is a lot of activity in
> > this area. EFI is an important piece of technology in the industry.
> > But this is U-Boot, and we just need to design things properly. I have
> > quietly commented on some of my concerns (e.g. efi_set_bootdev()) but
> > have not put time into fixing them.
>
> Me neither, but hopefully once the LWIP and mbedTLS are merged, we
> will have time to fix a few things.
>
> >
> > There is no need for the 6-8 tidy allocations, which are done before
> > the app starts, to be allocated in the wrong place, with a small
> > impact. We can just do it in malloc(). Let's just fix it.
>
> I won't repeat why this is problematic, I've explained more than once.
> On top of that this is opportunistic, the way we run things e.g the
> cmd subsystem, efi will be initialized regardless. An app might as
> well return, so without a clear use case of breakage I don't think we
> should change that.
>
> >
> > There is no need for the tables to be allocated in an EFI-specific
> > way, or using lmb.
>
> Neither is for bloblist
>
> > We have bloblist for that purpose. What's the
> > concern?
>
> That it's easier and cleanr for me to review and maintain code that's
> as close to the spec as possible. And I see no reasons to use
> bloblist. Or at least none that are so important.

Hmmm, I hope you agree that we are not making a lot of progress here.
So let's arrange a call and see if we can discuss these two issues:

- tables in bloblist
- use of efi-allocate-pages before the app starts

I'm sure we won't resolve them in one call, but perhaps we can find
some common ground.

In the meantime, it would certainly help if the EFI-test series could
be applied. If not, let's add that to the agenda too.

Regards,
Simon

> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240725135629.3505072-7-sjg@chromium.org/
