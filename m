Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3E5C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 275E98763C;
	Tue, 21 Nov 2023 23:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RHWfJdAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81C71875F4; Tue, 21 Nov 2023 23:11:39 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9505E8761B
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-daf26d84100so5977611276.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604694; x=1701209494; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mxPZm8iq4VEmwbBfh8Q22R6xKCuatO8KkNV/iQVTG+Y=;
 b=RHWfJdAN9Ltrq6GJFMV2ClOsqe9/YbshPhKgP4cWZBbwmEaG7cBR6rrlLroXpuu+Ws
 8zwHwSu8c99cjl00UqrHZbsPdjVpxyQ1PBwwOFpK82o6GcSwi4lalEK1Oh/+s1S86jgc
 lsP5pE2B9Z/6xLMnciYu9D/94/b0qFRgJxgUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604694; x=1701209494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mxPZm8iq4VEmwbBfh8Q22R6xKCuatO8KkNV/iQVTG+Y=;
 b=HA1RBniMJRH6cgVAdWd68yqgFP73Jnci7+fKP3PbuJwTEKC3mVxkHndexTJhjxqs/O
 qf83hCkC4YW+hFww09C3DK9LD0acXxNxv28MGa0xf/kTNP/11UGvPjIjibIyUU0dZfbd
 hQmZidfjhXDb4ZufsKOtSBtD1ixKbUeNfuRYS6YvnoHr5AbVLR1VXL7rMqFZMNX/rcFD
 xi7yd2GtocL0jcJTdb4qE1LPAJ+hIxNuIJbm2uoh+wyJqKSNM5Q6fvFomssUcxPuBDnP
 dZ0UDQ4gfQ5EE7/VoHDqyE39idGKKvBS67QBTpad/i1nz+reXXCKwJ/X/lt03xMGdPBW
 j5jg==
X-Gm-Message-State: AOJu0YzoPlqpKsl9REzzJYc4ZqfWEkUFhuMpuTHdTshNdvNtfTESrGRC
 vmVKuVca9Pg+n6r34hJ25z3kO97xoEXJWeLFCv2jh2DWee6QdRtVOI0=
X-Google-Smtp-Source: AGHT+IF/AFa14kXFHFDHM5MuB++wxzKiSYmi3ile+HyjKjDV2hC/wLuBY2eNjpWEN1ymLKjcDKmHzI8IqdoYIqN0mNo=
X-Received: by 2002:a25:8388:0:b0:d5b:80df:21f5 with SMTP id
 t8-20020a258388000000b00d5b80df21f5mr363827ybk.23.1700604694024; Tue, 21 Nov
 2023 14:11:34 -0800 (PST)
MIME-Version: 1.0
References: <20231117225214.2144414-1-trini@konsulko.com>
 <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
 <20231119202802.GF2513409@bill-the-cat>
 <CAPnjgZ3D_KRDYsA8u5K+kSKAe5n-w2vXMizPTxZphyeavQcbSg@mail.gmail.com>
 <20231121140321.GT2513409@bill-the-cat>
In-Reply-To: <20231121140321.GT2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:06 -0700
Message-ID: <CAPnjgZ3A=3xy9nZpYoCYicUF3qLJm_-=o=BJLPny1yaU5BarLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] global: Clean up arch/*/dts/Makefile
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Tom,

On Tue, 21 Nov 2023 at 07:03, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 20, 2023 at 07:16:12PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sun, 19 Nov 2023 at 13:28, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Nov 19, 2023 at 12:09:07PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 17 Nov 2023 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > With commit 3609e1dc ("dts: automatically build necessary .dtb files")
> > > > > we now have logic that will ensure that all device trees needed in the
> > > > > binary are built automatically. Any device tree that the developer needs
> > > > > while working can still be built normally via make arch/.../foo.dtb so
> > > > > we can simply drop the rest of this logic.
> > > > >
> > > > > Suggested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > >  arch/arc/dts/Makefile        |    8 -
> > > > >  arch/arm/dts/Makefile        | 1436 +---------------------------------
> > > > >  arch/m68k/dts/Makefile       |   18 -
> > > > >  arch/microblaze/dts/Makefile |    2 -
> > > > >  arch/mips/dts/Makefile       |   37 -
> > > > >  arch/nios2/dts/Makefile      |    2 -
> > > > >  arch/powerpc/dts/Makefile    |   32 -
> > > > >  arch/riscv/dts/Makefile      |    9 -
> > > > >  arch/sandbox/dts/Makefile    |    5 -
> > > > >  arch/sh/dts/Makefile         |    2 +-
> > > > >  arch/x86/dts/Makefile        |   22 -
> > > > >  arch/xtensa/dts/Makefile     |    2 -
> > > > >  configs/iot2050_defconfig    |    1 +
> > > > >  13 files changed, 6 insertions(+), 1570 deletions(-)
> > > >
> > > > I can see the motivation for this, but it ends up moving us away from
> > > > driver model and devicetree, IMO. For example, rk3399 and other
> > > > rockchip boards use DT for their init so the same U-Boot can be used
> > > > for all, mostly. Ideally that is the way all boards would be, as they
> > > > are in Linux.
> > > >
> > > > But here I have to manually add all the rk3399 boards to OF_LIST for
> > > > each board and enable SPL_LOAD_FIT (and SPL_FRAMEWORK but that is
> > > > fine) to make this work.
> > >
> > > How are you doing this today on N rk3399 boards if you aren't tweaking a
> > > CONFIG option to get the correct dtb in to the final binary? That I
> > > think is where we go back-and-forth on stuff like this.
> >
> > Basically without SPL_FIT_LOAD it works by stuffing the correct DT
> > into the final image just before it is flashed. But I do imagine in a
> > world where (say) TPL is different for each board but SPL, TF-A,
> > OP-TEE and U-Boot proper are the same for each board.
> >
> > But really we need to encourage these complex SoCs to use runtime
> > configuration from go to whoa. Where DT cannot be used (e.g. TPL) we
> > can do the Zephyr trick or perhaps create a little SoC-specific config
> > block which is provided separately and tacked onto the generic TPL
> > image. Having said that, TPL images are small, so the impact of having
> > one per board is not great.
> >
> > > If there's
> > > deconfigs that can support N boards, but only list a, or only a few, dtb
> > > files in the right CONFIG variable how do you get it to run on the
> > > others? I know you noted some Exynos platforms it's a simple concat to
> > > make another platform work instead. But I really don't know how common
> > > that is in theory, and even less so in practice. Picking up rk3399, you
> > > need bl31 and op-tee and you can only get those so generic too.
> >
> > I understand that they are 100% generic for rk3399. E.g. for TF-A you
> > use PLAT=rk3399 and that is that.
> >
> > >
> > > And part of the issue is that with Linux, the "do board specific things"
> > > just gets pushed down a layer, to us. We have to just know X/Y/Z at
> > > build time so that someone else can know it at run time.
> >
> > Sure, and naturally that gets pushed down from U-Boot proper (which I
> > think is becoming quite generic) to SPL, TPL, etc.
> >
> > If it would help, I could try out (say) rockpro64-rk3399 and
> > firefly-rk3399 to show how this works?
> >
> > I know it is tempting to build everything individually, but it won't
> > be nice. Binman knows what is needed for each board and can be used
> > (one day) to create update files for an SoC without duplication. As
> > soon as you give up on the commonality, everything just explodes in
> > size, complexity and user confusion.
>
> I guess with all of what you said I still don't understand why we need
> the sometimes wrong and not really used lists of dtb files in
> arch/*/dts/Makefile. A rockpro64-rk3399-tpl-only_defconfig still needs
> to say CONFIG_DEFAULT_DEVICETREE="rk3399-rockpro64" so that you build
> the tree so that it's available to binman. We have configs today that
> build and support N boards, and so use SPL_LOAD_FIT and are as generic
> as they can be. The only thing that this patch here changes is that
> you're relying on an implicit CONFIG symbol to list whatever device
> trees you want to be built and this patch says that you need to use one
> of the explicit CONFIG symbols instead.

It's really just that this patch is making this very hard.

For example, all ROCKCHIP_RK3399 (should be ARCH_ROCKCHIP_RK3399?)
should boot with just a DT change. We should be setting that as the
standard, just as is done in Linux.

By splitting everything out into individual targets, there really is
no chance that people will do the right thing, here.

>
> If you want to try and demonstrate a more generic way of doing things,
> sunxi is probably the best bet for that because there's no TARGET
> configs there, everything is SoC + device tree. But it's not making any
> use of the lists that get removed here.

There is lots of ridiculous stuff in arch/arm/dts/Makefile - it is a
real mess and I agree we should clean it up. I have not done a good
job of reviewing it and I don't think people understand devicetree
very well in firmware. I could take that on if that is what is needed
here.

Looking at Linux arm32 now it has a subdir for each arch and inside
that it has only ARCH (e.g. for rockchip) or MACH (for sunxi) or SOC
(for some reason, microchip). For U-Boot we don't have a separate
arm64 dir so would need to think about that, too.

OK I will take a look at sunxi and see what can be done there. There
is an active maintainer there, which helps.

Regards,
Simon
