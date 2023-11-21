Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66755C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4438D875EB;
	Tue, 21 Nov 2023 03:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cWlTCxjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F5E7875E0; Tue, 21 Nov 2023 03:16:55 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B3F875CB
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:16:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5cbb4de4328so31547b3.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700533008; x=1701137808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kV+vDRcpg2dJr054qfHOaSdmkAD3ODCKgisP26zjkno=;
 b=cWlTCxjQysNonpFluEiS+em2iblP8fkM/IHTmQF4w+aedVDLLQMmryXNk+1TVZvdlp
 bRxcs6F/mZXnrLVYNfBgujDLUft3JU+MTiKn0+g23n9lxJcd40rzBpJxxCiCMbXsHo3p
 p434DQoY7KRA10DUySJeZzSQGAwWxSg+dDt7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700533008; x=1701137808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kV+vDRcpg2dJr054qfHOaSdmkAD3ODCKgisP26zjkno=;
 b=dH/BgysukLAlPbqze7jY4N1N1TPJ8gttoKIpIQYdVYcOov4H3cCn6N1vFrTUK52RYB
 ga0XiMJi4I6nSr24fCp0ST0XfhZ916F2V7gipvuM9zkY93alz9/9VIEon1nhp2gDhe/D
 LB4pS0H/K0sQJYLO2ChfOAKy5HQ92qjzQqA1OIWsFevL38GZ7g++DFuynFacsHng9gyZ
 ErxCj2zGM3VHXBCgCBNaLAurZaDyVSBAfDlfBUaXf5s7mU/0olXwi7IlOqPZVs1G5kH4
 OPxhA5tqIDk45m0yqTSnO08ss5FSbixKfaLIrjhx7fTO2VVKCTYktkD/NVX34pMz1ySJ
 mhaw==
X-Gm-Message-State: AOJu0YwYVipwgJcEKZCkiRDYcA2qQCxO+FTtsWLDgGhTxYAnzhnuUBHU
 0+vWidAxBn+iQxwI0dDB1ooi8L5kIk2rWHw4APuD9lcdyJAuFZQ8p2M=
X-Google-Smtp-Source: AGHT+IE1NkMixGs0CR7rBQioWabwZIiFxpIV0XA4yQ5jJGhQkkmzvbMbC4NrxmjPnNVIBadt40fwy8Bq9qBIlFM32ys=
X-Received: by 2002:a0d:da85:0:b0:5c4:2fb6:ad99 with SMTP id
 c127-20020a0dda85000000b005c42fb6ad99mr10414240ywe.9.1700533008191; Mon, 20
 Nov 2023 18:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20231117225214.2144414-1-trini@konsulko.com>
 <CAPnjgZ23gJb6mu53Tmmy9OdaRLu9zCCLgJTGsTVjjKcCv63VqA@mail.gmail.com>
 <20231119202802.GF2513409@bill-the-cat>
In-Reply-To: <20231119202802.GF2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Nov 2023 19:16:12 -0700
Message-ID: <CAPnjgZ3D_KRDYsA8u5K+kSKAe5n-w2vXMizPTxZphyeavQcbSg@mail.gmail.com>
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

On Sun, 19 Nov 2023 at 13:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, Nov 19, 2023 at 12:09:07PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 17 Nov 2023 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > With commit 3609e1dc ("dts: automatically build necessary .dtb files")
> > > we now have logic that will ensure that all device trees needed in the
> > > binary are built automatically. Any device tree that the developer needs
> > > while working can still be built normally via make arch/.../foo.dtb so
> > > we can simply drop the rest of this logic.
> > >
> > > Suggested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >  arch/arc/dts/Makefile        |    8 -
> > >  arch/arm/dts/Makefile        | 1436 +---------------------------------
> > >  arch/m68k/dts/Makefile       |   18 -
> > >  arch/microblaze/dts/Makefile |    2 -
> > >  arch/mips/dts/Makefile       |   37 -
> > >  arch/nios2/dts/Makefile      |    2 -
> > >  arch/powerpc/dts/Makefile    |   32 -
> > >  arch/riscv/dts/Makefile      |    9 -
> > >  arch/sandbox/dts/Makefile    |    5 -
> > >  arch/sh/dts/Makefile         |    2 +-
> > >  arch/x86/dts/Makefile        |   22 -
> > >  arch/xtensa/dts/Makefile     |    2 -
> > >  configs/iot2050_defconfig    |    1 +
> > >  13 files changed, 6 insertions(+), 1570 deletions(-)
> >
> > I can see the motivation for this, but it ends up moving us away from
> > driver model and devicetree, IMO. For example, rk3399 and other
> > rockchip boards use DT for their init so the same U-Boot can be used
> > for all, mostly. Ideally that is the way all boards would be, as they
> > are in Linux.
> >
> > But here I have to manually add all the rk3399 boards to OF_LIST for
> > each board and enable SPL_LOAD_FIT (and SPL_FRAMEWORK but that is
> > fine) to make this work.
>
> How are you doing this today on N rk3399 boards if you aren't tweaking a
> CONFIG option to get the correct dtb in to the final binary? That I
> think is where we go back-and-forth on stuff like this.

Basically without SPL_FIT_LOAD it works by stuffing the correct DT
into the final image just before it is flashed. But I do imagine in a
world where (say) TPL is different for each board but SPL, TF-A,
OP-TEE and U-Boot proper are the same for each board.

But really we need to encourage these complex SoCs to use runtime
configuration from go to whoa. Where DT cannot be used (e.g. TPL) we
can do the Zephyr trick or perhaps create a little SoC-specific config
block which is provided separately and tacked onto the generic TPL
image. Having said that, TPL images are small, so the impact of having
one per board is not great.

> If there's
> deconfigs that can support N boards, but only list a, or only a few, dtb
> files in the right CONFIG variable how do you get it to run on the
> others? I know you noted some Exynos platforms it's a simple concat to
> make another platform work instead. But I really don't know how common
> that is in theory, and even less so in practice. Picking up rk3399, you
> need bl31 and op-tee and you can only get those so generic too.

I understand that they are 100% generic for rk3399. E.g. for TF-A you
use PLAT=rk3399 and that is that.

>
> And part of the issue is that with Linux, the "do board specific things"
> just gets pushed down a layer, to us. We have to just know X/Y/Z at
> build time so that someone else can know it at run time.

Sure, and naturally that gets pushed down from U-Boot proper (which I
think is becoming quite generic) to SPL, TPL, etc.

If it would help, I could try out (say) rockpro64-rk3399 and
firefly-rk3399 to show how this works?

I know it is tempting to build everything individually, but it won't
be nice. Binman knows what is needed for each board and can be used
(one day) to create update files for an SoC without duplication. As
soon as you give up on the commonality, everything just explodes in
size, complexity and user confusion.

Regards,
Simon
