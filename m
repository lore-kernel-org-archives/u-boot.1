Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38A6C27C4F
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 18:17:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D111688904;
	Thu, 13 Jun 2024 20:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IUaIl9R2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DF98857B; Thu, 13 Jun 2024 20:17:37 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B72488904
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 20:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec0f3b9bb8so1488951fa.1
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 11:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718302654; x=1718907454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mdZOBsDI3LGE1A7ZhxvRxCQyA9DGQa2mu97ae1MpOX8=;
 b=IUaIl9R2L6+vz4gD0HD5yKD6hXeevyH0XDwMGfTSKmZmkto5ng9KfTctyljR7tho8e
 nq1BmB2YGcqLzJEkQKwLcq09Z/FMTIeF8mpzmnalqnBN91LL0PNJfQODEzjK3fMYImI/
 3HwXt3TFG+z54w6J4XNKKIjg9rSi+G+9iH3Fh7P+LgJJbZLTi7np2hhpjHocCeZTDLUB
 JeKq0n4Ljj0HNwdMtrmJspCY1+YmdpP3Zme3H+r4oDF0v34rhOI/3y+WKL8v4OKwt/EF
 osicVgSKMjb5LC5YH/VQG5Pk7iluZZQLmaAN7aI7yWN0ncp1YHeKSPrabQkyD3dyZJJf
 Czgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718302654; x=1718907454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mdZOBsDI3LGE1A7ZhxvRxCQyA9DGQa2mu97ae1MpOX8=;
 b=dI9AoWG9OAFBhe7bSH7JisLV8s5CAA3zuz3ah3uiUK+XizCa25VhOEW9LIuQaEyA0c
 EwopM/1W7e1la2P21lQ55C3Mhr5P5eGbeEs5ycxO9Q9uxb68a43qoqiq5aenAs7CuyVc
 ZFEqgEEofXXYzzMUHYYYMScSpdw7BLmcBia4YrekRs89rco9uvhseuZATYfVlbZBznNC
 KPyo7lytcREX6I26JtNP/uVkl1RwKN1W/d3WAIyFLMXbJcj84Gso9o5VQOKipnm4JVPF
 KU6156JZSy8eLXzF527UPoyfwXvLmsmu7QC+dlcStk82hc4GPQYUwNFmo8il1TY+FOMa
 CwDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7eKh+dzbipSQwcbZOItAZaffpgTrtsU7zf/xX+ix9UWyE6Y7dgoX+UyhHkBgC/oBYHMxzgkdYjrDDaigQPoUiRCbaVw==
X-Gm-Message-State: AOJu0Yz9g+8OthPDjsAHI2HBqkW9XqM3j6afrw5lDpuB4U4SKgQC+rs0
 Au1Hw2h88gpDvnbMrEKElhQwH4nT1eEMQWOfVJlQtiesAuD8sm4VDN4VONd1cO0EXVOnI5T9LzM
 dvyyUJcpSswK+wqLU5ycWXbKTxyPfvXDpTGvJCA==
X-Google-Smtp-Source: AGHT+IEOGZGQoWtiONz15/ElhKX7ND4IijhI7lM1TcLotGbe2srIFqi5FO48FTkjAZ82rvIICcM+vleaIhJuceDH+pQ=
X-Received: by 2002:a2e:9118:0:b0:2eb:d67a:18b with SMTP id
 38308e7fff4ca-2ec0e60e0c6mr4026281fa.49.1718302654464; Thu, 13 Jun 2024
 11:17:34 -0700 (PDT)
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
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 13 Jun 2024 23:47:22 +0530
Message-ID: <CADg8p96jTPW-ebwjR+k_N0SL4cV0_6NdwOZ5Ee_+Ukuu==UJvg@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
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

On Thu, 13 Jun 2024 at 22:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
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
>
> Device-paths must be created from EFI pool memory as they may be freed
> via FreePool() according to the EFI specification. And these we create
> whenever a block-device is probed.
>
> We should not make any assumptions that conflict with the UEFI
> specification.
>
> In our initial discussion with Ilias one idea was to merge LMB and EFI
> memory management. This merged system would have to consider the
> requirements of the UEFI specifications like a finer grained memory type
> system and page boundaries.

Not sure about merging LMB and EFI memory management, but I am looking
at using the LMB API's for EFI allocations for the next version. The
LMB API's as they stand today, align pretty neatly with the
requirements of the efi_allocate_pages() function, which really is the
EFI memory allocation function. I think it should be possible to use
the LMB API's(with a different flag passed to differentiate between
LMB and EFI reservations) from the EFI memory module. I think things
like maintaining the EFI memory map should still reside in the EFI
memory module.

-sughosh

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
