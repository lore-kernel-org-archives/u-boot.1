Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E568C83F2C
	for <u-boot@archiver.kernel.org>; Sun,  3 Sep 2023 09:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33B82857BF;
	Sun,  3 Sep 2023 11:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XNvEsp0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCD4686411; Sun,  3 Sep 2023 11:51:48 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B78F18144A
 for <u-boot@lists.denx.de>; Sun,  3 Sep 2023 11:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimo.pegorer@gmail.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-58d40c2debeso5016967b3.2
 for <u-boot@lists.denx.de>; Sun, 03 Sep 2023 02:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693734704; x=1694339504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NZ4g0wXB1BzRTv48k10Sp/UcJoyOiv9boFd1Y8Fvj7s=;
 b=XNvEsp0rBdnVc0qs95Nb0Xb9WlLnAgwB8YU1rscXrITpZcYqB9ILu5cFT9HR3AQzex
 YKlxa7Jc/8cEkOcOQNoEw3TdWcpWvHXLws1rcOERT98nGgxH34qn9vVGQmxokJ0I739M
 /F3nKb60v1rwepwScg0abpbhisytsZ/g/F7Pa+MsBRs6JtXnCc66bsxb9I1mmln7L6Js
 f/sRUcEl7Kh9Iuj/1zlC1NWOBSMJ347azL04E63+45FiNoqFVkNcFryxNjHbQMqb2DfM
 pg3y+WHxZaH92ktkgNvoOZBdVncKU8Nmnugm3zkBqQxguUzhgoUw9YpniJAKkSuLhNAW
 DJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693734704; x=1694339504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NZ4g0wXB1BzRTv48k10Sp/UcJoyOiv9boFd1Y8Fvj7s=;
 b=UkCEddSYgYaQkNB/0dq/xYbhQ+LSroYfnSIhYxugDAJuhvdBesicj7/gDSt7H7vFNS
 89Kq+4JqhjCyQ21iFObQWTKDXkS6biZ4Z/aMps1hvCnJSrw+ra/xr4o/Zu+AyjdzwMiS
 ehRT5+zUvjdwQZqhIx+Qo4NGaZxIEq/f5VDGsFCHlwZfC9bclLaTnGFNft6mk2VweH2S
 cFDZ50v0qMHzeSh/HbWSN2TsYNFoG4E5d1uIopl9UHdWcAzM+Jw8iQ83gB6aKpLk06Ge
 PpAu/kqIjnm0Pz9slC3ZGQ14JJfPMjvIZVhOsimsBbe1b+PcudD2WbMVnV4DpGiRIxNG
 l0LA==
X-Gm-Message-State: AOJu0Yw/6e/Y62APhOUTUZWK0NKmYgvAMpKNYDP8T0KH+hCaISMaoVNf
 o2XmoqBPYQdAdo+BcD1Nrly5aTH0gXQpR9aPQGI=
X-Google-Smtp-Source: AGHT+IFaMqgSUur2hSAqAqqf6gTFIkKF28QJ92f/RTs6GgKvDbrtYl4Nds/6HNg2olQYi16Ysoq99VAm4142eGt9AGw=
X-Received: by 2002:a0d:df97:0:b0:589:f883:c8f1 with SMTP id
 i145-20020a0ddf97000000b00589f883c8f1mr7660465ywe.37.1693734704389; Sun, 03
 Sep 2023 02:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230902163212.343746-1-massimo.pegorer+oss@gmail.com>
 <56b4c1d1-e86c-722c-c9fa-87082cae8307@gmail.com>
In-Reply-To: <56b4c1d1-e86c-722c-c9fa-87082cae8307@gmail.com>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Sun, 3 Sep 2023 11:51:33 +0200
Message-ID: <CAC928Ha2qUwbYv6yuAsf2f4qmCCoaA4-ya4B6qY48bJ60GgXaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] doc: rockchip: Update and complete info about RK3308
To: Johan Jonker <jbx6244@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>,
 FUKAUMI Naoki <naoki@radxa.com>
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

Hi Johan,

Il giorno dom 3 set 2023 alle ore 10:36 Johan Jonker
<jbx6244@gmail.com> ha scritto:
>
>
>
> On 9/2/23 18:32, Massimo Pegorer wrote:
> > Update documentation about build steps for RK3308, using an external
> > TPL. Add RK3308 case to rST document. Add ROCK Pi S in the list of
> > supported boards.
> >
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >  doc/README.rockchip             |  4 ++--
> >  doc/board/rockchip/rockchip.rst | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/doc/README.rockchip b/doc/README.rockchip
> > index 52b5140eca..cfbd858c3b 100644
> > --- a/doc/README.rockchip
> > +++ b/doc/README.rockchip
> > @@ -38,16 +38,16 @@ Building
> >      (or you can use another cross compiler if you prefer)
> >
>
> >  2. To build RK3308 board:
> > +
> >     - Get the rkbin
> >       => git clone https://github.com/rockchip-linux/rkbin.git
> >
> >     - Compile U-Boot
> >       => cd /path/to/u-boot
> >       => export BL31=/path/to/rkbin/bin/rk33/rk3308_bl31_v2.22.elf
> > +     => export ROCKCHIP_TPL=/path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin
> >       => make roc-cc-rk3308_defconfig
> >       => make CROSS_COMPILE=aarch64-linux-gnu- all
> > -     => ./tools/mkimage -n rk3308 -T rksd -d /path/to/rkbin/bin/rk33/rk3308_ddr_589MHz_uart2_m0_v1.26.bin idbloader.img
> > -     => cat spl/u-boot-spl.bin  >> idbloader.img
> >
>
> Hi Massimo,
>
> The text in this document should moved to doc/board/rockchip.
> This paragraph above is therefor redundant, so it can be removed I think.
>
> Johan

OK, thanks, I agree on redundant. But I do not know if everything here
- other than RK3308 info - has already been moved to
doc/board/rockchip.rst, so to remove it. On the other hand, leaving as
it is (i.e. not updated) would be misleading.

If everybody agree I can remove it in a V2, or otherwise just delete
the RK3308 section.

Massimo

> >  3. To build RK3399 board:
> >
> > diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> > index de9fe8e642..b38c3d3136 100644
> > --- a/doc/board/rockchip/rockchip.rst
> > +++ b/doc/board/rockchip/rockchip.rst
> > @@ -53,6 +53,7 @@ List of mainline supported Rockchip boards:
> >       - Google Speedy (chromebook_speedy)
> >       - Amarula Vyasa-RK3288 (vyasa-rk3288)
> >  * rk3308
> > +     - Radxa ROCK Pi S (rock-pi-s-rk3308)
> >       - Rockchip Evb-RK3308 (evb-rk3308)
> >       - Roc-cc-RK3308 (roc-cc-rk3308)
> >  * rk3326
> > @@ -172,6 +173,15 @@ To build rk3288 boards:
> >          make evb-rk3288_defconfig
> >          make CROSS_COMPILE=arm-linux-gnueabihf-
> >
> > +To build rk3308 boards:
> > +
> > +.. code-block:: bash
> > +
> > +        export BL31=../rkbin/bin/rk33/rk3308_bl31_vX.YZ.elf
> > +        export ROCKCHIP_TPL=../rkbin/bin/rk33/rk3308_ddr_589MHz_uart0_m0_vX.YZ.bin
> > +        make evb-rk3308_defconfig
> > +        make CROSS_COMPILE=aarch64-linux-gnu-
> > +
> >  To build rk3328 boards:
> >
> >  .. code-block:: bash
