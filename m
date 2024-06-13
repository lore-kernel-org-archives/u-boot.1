Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3875C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 19:06:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3262788938;
	Thu, 13 Jun 2024 21:06:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ModmOdB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8739E8894E; Thu, 13 Jun 2024 21:06:13 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 262E5882E0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 21:06:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6ae259b1c87so21458596d6.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718305570; x=1718910370; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t4SyJdMZkhsOXqrYnXcAaGUuFNRC7u0Mbfeq8L+KYcY=;
 b=ModmOdB+dX6yu772PRkPTm50CUxklOC6IPn7HMtTxEkY+46x5QDIgRPIhs/kOlk7I2
 SALYpcETUMUdvPhfeICwxhe3OG5sWQMLm9FFwDLaJkQBcJbKpEhJoy3z25B6R7zrLb/i
 BU6x9kQxsbq1hHPCQE/AfUj3IZPW0XphecDIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718305570; x=1718910370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4SyJdMZkhsOXqrYnXcAaGUuFNRC7u0Mbfeq8L+KYcY=;
 b=hwtTlp79LUdbVstEEGXweiCq6cfQWsV2DgibpQmT7ULSAvd0zvGXvm9YTDq9IRNeOt
 DsABSO1G1FjJL1LnS8cdvB+eyOE/Gv5jnGlV/GNWS/K2C/BIcEqXTG43L/Y5FHGb3+4u
 +kgtzuHnMn1WY8eezItvOGjGqL/yQfesbQ3Nb4LP4fzd04YVy6OR6VYqj2hnoivdRZwk
 cNA5hFSVBNMqNuBG9xBuMCyzDjl2wqdFxOTXz0wYYEGUfeRKhc4DTWo4amKzLCD3bzHC
 8gp+ZBZ0VsjPxF3O+sah+QOqdPwbhPortTqU89jBt2DxV2XIcLy7cSLq9qumK2mHCRkx
 AoUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGJHVEC7utimWUEDwgOmW/decHXea+fU5cowsW05Vj1+hUO/P+M2xl3acDYNMaHz2K8EY/Qym4Bd0AKZWi3yM0SV0JQQ==
X-Gm-Message-State: AOJu0YylssbZdh+9hNncAXYiOeqwdW06vYVGncYrOd6QO/03/vV9B1CN
 SJkXqLoqj3DbWz8V1Nk2Oq4n+hRK1V17i3Ze4CRCR80JVtR9M1MzzroQ11QzD8R9r8/9HlqLbD1
 zX7xtE7WYUoZyUVFhhYp42mPP8Y7irMKjh/tx
X-Google-Smtp-Source: AGHT+IFxOBVpsSj55N1Df11h7Lli5owxVsaBlHUSoKzAkprQ+BNgUm8huQhN92nrYcVQ7u+GQkBW5n17+6bADTHoFPs=
X-Received: by 2002:ad4:4bd1:0:b0:6b0:9039:bfcb with SMTP id
 6a1803df08f44-6b2af26efc4mr12162176d6.12.1718305569708; Thu, 13 Jun 2024
 12:06:09 -0700 (PDT)
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
In-Reply-To: <1604c2a7-d72e-491f-806f-da29d14f0a17@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Jun 2024 13:05:58 -0600
Message-ID: <CAFLszTjMnxN-pNLxe=pamC=OQpKtPRAL0Xrr17x8Sn+oU+8gQA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
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

Hi Heinrich,

On Thu, 13 Jun 2024 at 11:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 13.06.24 18:59, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 13 Jun 2024 at 09:42, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
> >>> Hi Tom,
> >>>
> >>> On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
> >>>>
> >>>> On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> >>>>> Hi Tom,
> >>>>>
> >>>>> On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> >>>>>>
> >>>>>> On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> >>>>>>
> >>>>>> [snip]
> >>>>>>> Also IMO there is only really one LMB list today. We create it at the
> >>>>>>> start of bootm and then it is done when we boot. The file-loading
> >>>>>>> stuff is what makes all this confusing...and with bootstd that is
> >>>>>>> under control as well.
> >>>>>>>
> >>>>>>> At lot of this effort seems to be about dealing with random scripts
> >>>>>>> which load things. We want to make sure we complain if something
> >>>>>>> overlaps. But we should be making the bootstd case work nicely and
> >>>>>>> doing things within that framework. Also EFI sort-of has its own
> >>>>>>> thing, which it is very-much in control of.
> >>>>>>>
> >>>>>>> Overall I think this is a bit more subtle that just combining allocators.
> >>>>>>
> >>>>>> I think this gets to the main misunderstanding. The problem isn't
> >>>>>> handling bootstd, or EFI boot, or even assorted scripts. Those are all
> >>>>>> cases where things are otherwise (sufficiently) well-defined. The
> >>>>>> problem is "security" and that a "carefully crafted payload" could do
> >>>>>> something malicious. That's why we have to do all of this stuff sooner
> >>>>>> rather than later in our boot process.
> >>>>>
> >>>>> That's the first I have heard of this, actually, but a bit more detail
> >>>>> would help. How does the payload get loaded? I'm just not sure about
> >>>>> the overall goals. It seems that everyone else is already familiar -
> >>>>> can someone please take the time to point me to the details?
> >>>>
> >>>> Well, the short version I believe of the first CVE we got (and so
> >>>> started abusing LMB) was along the lines of "load an image near where
> >>>> the U-Boot stack is, smash things for fun and exploits".
> >>>
> >>> OK. I am surprised that LMB does not catch that. It is supposed to add
> >>> the stack and various other things right at the start before loading
> >>> any file. So even if it clears the LMB each time, it should not be
> >>> able to do that. Having said this, the code may be buggy as I don't
> >>> think we have tests for U-Boot's overall functional behaviour in these
> >>> situations.
> >>
> >> Right, LMB does catch the example I gave (because we made all of the
> >> load from storage/network functions init an lmb and we always make sure
> >> a new lmb gets U-Boot stack/etc). The next thing we didn't catch was
> >> "what if EFI does the loading?" and we've kludged around that, and in
> >> turn had some of the thorny questions. Some of that is what I think
> >> you're asking about in this part of the thread, to which the answer is
> >> "EFI spec says you need to place X in memory", so we just need to
> >> reserve it when it's asked for, so that something else can't come along
> >> and smash it maliciously.
> >
> > OK I see. Of course it isn't just EFI that has this issue. I believe
> > the answer (for small blocks) is to use malloc(), which I think we do
> > with a few exceptions which Ilias pointed out. For things like the TPM
> > log and ACPI tables we should probably use a bloblist, as we do on
> > x86. For large things (like loading a kernel) we should use LMB. I've
> > been thinking about how best to tie this to boot, as opposed to random
> > allocations in U-Boot itself, which would lead to fragmentation and
> > strange behaviour. I think bootstd is a great place to have a
> > persistent LMB. It can be attached to bootstd_priv.
> >
> > My hope is that EFI is just another boot method, where
> > already-allocating things are presented to the OS. Apart from the
> > Ilias exceptions, I believe this is how it works today.
> >
> > Where I think this heads in the wrong direction is using
> > EFI-allocation functions before we are booting an EFI image. EFI has
> > no concept of what is 'in empty space' so it leads to the lmb
> > conflict, the subject of this discussion.
>
> EFI binaries can return to the command line interface.
> EFI binaries may be drivers that stay resident and run in the background
> after returning to the command line interface. They might for instance
> provide block devices.

Hmm you mentioned that before but I'm still not quite understanding.
Do you mean that the EFI app returns back to U-Boot, leaving the
driver active? If so, how does U-Boot use the driver? I'm just not
familiar with how such a construct could work in a single-threaded
U-Boot.

>
> Device-paths must be created from EFI pool memory as they may be freed
> via FreePool() according to the EFI specification. And these we create
> whenever a block-device is probed.

The implementation of pool memory rounds up to pages and uses that. It
might be more efficient to use malloc()/free() instead, given that we
mark the malloc() space as reserved when we call the EFI app.

>
> We should not make any assumptions that conflict with the UEFI
> specification.

Indeed.

>
> In our initial discussion with Ilias one idea was to merge LMB and EFI
> memory management. This merged system would have to consider the
> requirements of the UEFI specifications like a finer grained memory type
> system and page boundaries.
>
> Best regards
>
> Heinrich
>
> >
> > This is all quite subtle and probably worthy of a VC discussion.
> >
> >>
> >> But that also raised the more general problem, and why we need a
> >> persistent reservation list, of allowing boards/SoCs to say they want to
> >> reserve a block of memory for whatever, and have that obeyed, for real.
> >> For example, the mach-apple logic of "just pick some memory locations to
> >> use for kernel/dtb/initrd" isn't really as safe as it should be since
> >> those reservations aren't really seen anywhere once the function
> >> returns, it's just setting some environment variables.
> >
> > Yes, that part of it I understand. Somehow I either didn't see or
> > forgot that board_late_init() code. With the script-based boot it
> > makes some sort of sense, but with bootstd we should have allocation
> > of addresses dealt with there. I have held off on retiring
> > kernel_addr_r etc. as the scripts are still in use. But perhaps it
> > would be a good time to convert bootstd to use lmb instead?
> >
> > Regards,
> > Simon
>
