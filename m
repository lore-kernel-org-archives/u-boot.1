Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A12C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 19:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ECEA88960;
	Thu, 13 Jun 2024 21:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IuSvzeEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFD38895D; Thu, 13 Jun 2024 21:06:16 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 676DD88951
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 21:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b0783b6dd5so6428686d6.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718305573; x=1718910373; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g7nxaS6hvHG0P4QNbWTbkxJYyLcMLVWr4puALRMgsGQ=;
 b=IuSvzeEMVpIuknnuYgju7bnsMlwNViGT4ubhhJhV91M27QhLRKo0LkvFml9uLxlH7f
 DTf10zMTEu2GA+Dl7gJyvJIDZ4WTJjj0BysuHZapZ2Og+MiMAhK0BEWRrKT8XQKQpKyk
 IGzYUoXO4uUdGwzQOQ4u6xLF/2HsUEgVjKx+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718305573; x=1718910373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g7nxaS6hvHG0P4QNbWTbkxJYyLcMLVWr4puALRMgsGQ=;
 b=qevwtJq0trXpnokzGBrNPDd0B82DD7uNo0RzcyGdDZRe34tTWMIFfuFpSkAgf+8d6Y
 s7CU8Khh2gg9DdPR8GDVHlfRC4Y5WeY4jsFfrblU+YnPHGp+Q2fIiqOAKZmdi7XB5w6D
 wKzk6CGAzOzNF/4kCstlOfUsP4Ok/lcZ3ImkO4XM/PbYSzvDKWWkR8Km8GLmrLD2W9hO
 xE/eLoPEZTkum89XIHmZasW/qo4AkxsFxeexPCpHoxouug/QbHW7UfpM7+0GflvlaSE1
 CeTQ5RGAXUoYKusibF8TMQpBCam/JVMoG3QP1cY1ON3hFfec0GIQ81dhwF5I1rjvhBnH
 1tSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmo9gZQLWQ8/Rn5jRctYHtW+nWovKVXgf+1yaR81B4tOfDxRGCm7drPeFre2YJ4eyLMNcDQ8KkvykpW8L9ThuAcsIl+g==
X-Gm-Message-State: AOJu0YxH0cnM89DVlsz8QEMA39ryDlqmJK267Hvt5+jm36zmxbHc4Fbr
 vEo46rvscrhSVS4AGZBG1G0qorsrQBDmn/m350G69ys4tm7zGbOEBYXdMAAE7LGImvxMMaDhn29
 03xPH6P26yUCgF2utZj63PzK+GXr9EG+E8qEljtaZzWoDNiE=
X-Google-Smtp-Source: AGHT+IFpNAqiiOdC6H2AN5z60YmLOSIyai9pEE3Xz8HPLmyOlrcmdagJ6ZkusXT8snJiR1bSZ5H8pyh+DzwGiArn3HQ=
X-Received: by 2002:a05:6214:4c05:b0:6b0:64bd:c4aa with SMTP id
 6a1803df08f44-6b2afc76a68mr5023986d6.9.1718305573234; Thu, 13 Jun 2024
 12:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
 <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
 <20240613154206.GO68077@bill-the-cat>
 <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
 <1604c2a7-d72e-491f-806f-da29d14f0a17@gmx.de>
 <CADg8p96jTPW-ebwjR+k_N0SL4cV0_6NdwOZ5Ee_+Ukuu==UJvg@mail.gmail.com>
In-Reply-To: <CADg8p96jTPW-ebwjR+k_N0SL4cV0_6NdwOZ5Ee_+Ukuu==UJvg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jun 2024 13:06:02 -0600
Message-ID: <CAFLszTi2+RLLEQ=RGzdJKv7t2OW8UBBz55TmdD0KVQw8awOyRA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

Hi Sughosh,

On Thu, 13 Jun 2024 at 12:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Thu, 13 Jun 2024 at 22:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 13.06.24 18:59, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 13 Jun 2024 at 09:42, Tom Rini <trini@konsulko.com> wrote:
> > >>
> > >> On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
> > >>> Hi Tom,
> > >>>
> > >>> On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
> > >>>>
> > >>>> On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> > >>>>> Hi Tom,
> > >>>>>
> > >>>>> On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > >>>>>>
> > >>>>>> On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> > >>>>>>
> > >>>>>> [snip]
> > >>>>>>> Also IMO there is only really one LMB list today. We create it at the
> > >>>>>>> start of bootm and then it is done when we boot. The file-loading
> > >>>>>>> stuff is what makes all this confusing...and with bootstd that is
> > >>>>>>> under control as well.
> > >>>>>>>
> > >>>>>>> At lot of this effort seems to be about dealing with random scripts
> > >>>>>>> which load things. We want to make sure we complain if something
> > >>>>>>> overlaps. But we should be making the bootstd case work nicely and
> > >>>>>>> doing things within that framework. Also EFI sort-of has its own
> > >>>>>>> thing, which it is very-much in control of.
> > >>>>>>>
> > >>>>>>> Overall I think this is a bit more subtle that just combining allocators.
> > >>>>>>
> > >>>>>> I think this gets to the main misunderstanding. The problem isn't
> > >>>>>> handling bootstd, or EFI boot, or even assorted scripts. Those are all
> > >>>>>> cases where things are otherwise (sufficiently) well-defined. The
> > >>>>>> problem is "security" and that a "carefully crafted payload" could do
> > >>>>>> something malicious. That's why we have to do all of this stuff sooner
> > >>>>>> rather than later in our boot process.
> > >>>>>
> > >>>>> That's the first I have heard of this, actually, but a bit more detail
> > >>>>> would help. How does the payload get loaded? I'm just not sure about
> > >>>>> the overall goals. It seems that everyone else is already familiar -
> > >>>>> can someone please take the time to point me to the details?
> > >>>>
> > >>>> Well, the short version I believe of the first CVE we got (and so
> > >>>> started abusing LMB) was along the lines of "load an image near where
> > >>>> the U-Boot stack is, smash things for fun and exploits".
> > >>>
> > >>> OK. I am surprised that LMB does not catch that. It is supposed to add
> > >>> the stack and various other things right at the start before loading
> > >>> any file. So even if it clears the LMB each time, it should not be
> > >>> able to do that. Having said this, the code may be buggy as I don't
> > >>> think we have tests for U-Boot's overall functional behaviour in these
> > >>> situations.
> > >>
> > >> Right, LMB does catch the example I gave (because we made all of the
> > >> load from storage/network functions init an lmb and we always make sure
> > >> a new lmb gets U-Boot stack/etc). The next thing we didn't catch was
> > >> "what if EFI does the loading?" and we've kludged around that, and in
> > >> turn had some of the thorny questions. Some of that is what I think
> > >> you're asking about in this part of the thread, to which the answer is
> > >> "EFI spec says you need to place X in memory", so we just need to
> > >> reserve it when it's asked for, so that something else can't come along
> > >> and smash it maliciously.
> > >
> > > OK I see. Of course it isn't just EFI that has this issue. I believe
> > > the answer (for small blocks) is to use malloc(), which I think we do
> > > with a few exceptions which Ilias pointed out. For things like the TPM
> > > log and ACPI tables we should probably use a bloblist, as we do on
> > > x86. For large things (like loading a kernel) we should use LMB. I've
> > > been thinking about how best to tie this to boot, as opposed to random
> > > allocations in U-Boot itself, which would lead to fragmentation and
> > > strange behaviour. I think bootstd is a great place to have a
> > > persistent LMB. It can be attached to bootstd_priv.
> > >
> > > My hope is that EFI is just another boot method, where
> > > already-allocating things are presented to the OS. Apart from the
> > > Ilias exceptions, I believe this is how it works today.
> > >
> > > Where I think this heads in the wrong direction is using
> > > EFI-allocation functions before we are booting an EFI image. EFI has
> > > no concept of what is 'in empty space' so it leads to the lmb
> > > conflict, the subject of this discussion.
> >
> > EFI binaries can return to the command line interface.
> > EFI binaries may be drivers that stay resident and run in the background
> > after returning to the command line interface. They might for instance
> > provide block devices.
> >
> > Device-paths must be created from EFI pool memory as they may be freed
> > via FreePool() according to the EFI specification. And these we create
> > whenever a block-device is probed.
> >
> > We should not make any assumptions that conflict with the UEFI
> > specification.
> >
> > In our initial discussion with Ilias one idea was to merge LMB and EFI
> > memory management. This merged system would have to consider the
> > requirements of the UEFI specifications like a finer grained memory type
> > system and page boundaries.
>
> Not sure about merging LMB and EFI memory management, but I am looking
> at using the LMB API's for EFI allocations for the next version. The
> LMB API's as they stand today, align pretty neatly with the
> requirements of the efi_allocate_pages() function, which really is the
> EFI memory allocation function. I think it should be possible to use
> the LMB API's(with a different flag passed to differentiate between
> LMB and EFI reservations) from the EFI memory module. I think things
> like maintaining the EFI memory map should still reside in the EFI
> memory module.

Yes, that makes a lot of sense to me.

Regards,
Simon

>
> -sughosh
>
> >
> > Best regards
> >
> > Heinrich
> >
> > >
> > > This is all quite subtle and probably worthy of a VC discussion.
> > >
> > >>
> > >> But that also raised the more general problem, and why we need a
> > >> persistent reservation list, of allowing boards/SoCs to say they want to
> > >> reserve a block of memory for whatever, and have that obeyed, for real.
> > >> For example, the mach-apple logic of "just pick some memory locations to
> > >> use for kernel/dtb/initrd" isn't really as safe as it should be since
> > >> those reservations aren't really seen anywhere once the function
> > >> returns, it's just setting some environment variables.
> > >
> > > Yes, that part of it I understand. Somehow I either didn't see or
> > > forgot that board_late_init() code. With the script-based boot it
> > > makes some sort of sense, but with bootstd we should have allocation
> > > of addresses dealt with there. I have held off on retiring
> > > kernel_addr_r etc. as the scripts are still in use. But perhaps it
> > > would be a good time to convert bootstd to use lmb instead?
> > >
> > > Regards,
> > > Simon
> >
