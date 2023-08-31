Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CA1C83F10
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 322DF86584;
	Thu, 31 Aug 2023 15:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foundries.io header.i=@foundries.io header.b="JWx9zh0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C74C8657F; Thu, 31 Aug 2023 15:57:07 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3260386584
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oleksandr.suvorov@foundries.io
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso6225235ad.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1693490221; x=1694095021; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1i/byvJYTIcXYLdbzW/K/toccxsKgkVyQ7uCiRIj3lg=;
 b=JWx9zh0oZ0BTjnr8loYKIJisO1KvXJJnvRleYyOcXcFuEDLCc1Q4XF3Zy48uWuh2dC
 zSACajeCs5FtmJkXWn/+sVQqj+FufQcDHUgPUwNNRO++XhIWUl4nsqkNpK3OYcSgNEQS
 ZgpfSY8Pq9O/50+m8/zSacUshHVc0v4pumcRLEeq13RkaP4ageXoB7ZlKqp4cKYtYBVz
 mBln4qyZKFIXX/GnRazZ6V4kmz3soCXDN/D+ZL3QIEf5e5iw4On+57Cwx6LYtxWXqdPR
 Bi6SIlBch1P7vkR5OQ1exCY7OJ84wGRHRx6Wrb7sV3tEPDbHw50peTLhz4odE1IvcaEA
 TtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490221; x=1694095021;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1i/byvJYTIcXYLdbzW/K/toccxsKgkVyQ7uCiRIj3lg=;
 b=aHGNVGhHSvTJZgUBR3WZdxKdXFXyjelBWS0ZLYZU0oiH3EpSrmJNJjbbM7inaeUUf1
 pAAzzKSv8oLSt+yU4WbyRtsL7gBSiV59ZLcD7yDgBvh8HzziaBQx2OlHyNEIuWAzz4yk
 22UVe+u4G+HpXjlWS1taXGBdxlLKdCSe8TVfRlv3qOeKOp8yNaosnaiT4cxqAy9PRokX
 xPQfC3Snfi0hiV/4yIlONYHvmpIWMxqzvNQxskqHgGnhVxUJLcCnP/5u50CL9J1h65go
 +QWMqS3GQDvmDQLl9HTL51J9sBLJMPU0AANpLQFCYK6ty47PuODJo0gEwE3ANjIRfXHb
 5B/w==
X-Gm-Message-State: AOJu0Yz9bW4S2wgrATt3LchY8EOxXXoRi+c2JtbEU9doJWz5CQi87R8t
 sZ/8MhbG7BHIbSNHjEzEoeZ6L1I7AEtqQst+8sjKkg==
X-Google-Smtp-Source: AGHT+IHMGh4aLj3UYbJyJsbg3gevnss93EjaYjqVA1D52AOdiedF/IrUVqeBIAENm7+0SZXg5H7Yi88dh5djwzWCVog=
X-Received: by 2002:a17:902:ef93:b0:1b7:e49f:1d with SMTP id
 iz19-20020a170902ef9300b001b7e49f001dmr5074821plb.62.1693490221384; Thu, 31
 Aug 2023 06:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230826132410.378846-1-oleksandr.suvorov@foundries.io>
 <aa9044e9-62a6-4bf2-a390-eb6d3d5d9bf0@gmx.de>
 <CAOF=9Asr33iVjGANQTPLYurxJn+QjDXuNE09dN66bBuKc6SHFQ@mail.gmail.com>
 <20230826235000.GX3953269@bill-the-cat>
In-Reply-To: <20230826235000.GX3953269@bill-the-cat>
From: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Date: Thu, 31 Aug 2023 16:56:45 +0300
Message-ID: <CAOF=9Av-CSAty+vdzdjrDYyCasNPHbUh9uPMnOmqrOTkJrP6sQ@mail.gmail.com>
Subject: Re: [PATCH] mach-imx: bootaux: fix building with disabled bootelf
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Fabio Estevam <festevam@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
 Stefan Agner <stefan.agner@toradex.com>, 
 Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Aug 27, 2023 at 2:50=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, Aug 26, 2023 at 06:16:36PM +0300, Oleksandr Suvorov wrote:
> > Hi Heinrich,
> >
> > On Sat, Aug 26, 2023 at 4:46=E2=80=AFPM Heinrich Schuchardt <xypron.glp=
k@gmx.de> wrote:
> > >
> > > On 8/26/23 15:24, Oleksandr Suvorov wrote:
> > > > If CMD_ELF disabled and IMX_BOOTAUX enabled, the u-boot building en=
ds
> > > > up with a linking error [1]. Select LIB_ELF for all cases when
> > > > valid_elf_image() is used in the imx_bootaux module.
> > > >
> > > > [1]
> > > > ld: /tmp/ccaF1rpv.ltrans0.ltrans.o: in function `do_bootaux':
> > > > arch/arm/mach-imx/imx_bootaux.c:108: undefined reference to `valid_=
elf_image'
> > > >
> > > > Fixes: c0f037f6a2a ("mach-imx: bootaux: elf firmware support")
> > > > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > > > ---
> > > >
> > > >   arch/arm/mach-imx/Kconfig | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> > > > index d94b5828d0d..cbe62d6b8f9 100644
> > > > --- a/arch/arm/mach-imx/Kconfig
> > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > @@ -32,6 +32,7 @@ config IMX_RDC
> > > >   config IMX_BOOTAUX
> > > >       bool "Support boot auxiliary core"
> > > >       depends on ARCH_MX7 || ARCH_MX6 || ARCH_VF610 || ARCH_IMX8 ||=
 ARCH_IMX8M
> > > > +     select LIB_ELF if !ARCH_IMX8 || IMX8QXP
> > >
> > > For CONFIG_IMX8QXP=3Dy arch/arm/mach-imx/imx8/cpu.c uses valid_elf_im=
age().
> > >
> > > Shouldn't the IMX8QXP case be handled in arch/arm/mach-imx/imx8/Kconf=
ig?
> > >
> > > config IMX8QXP
> > >         select LIB_ELF
> >
> > We need to select LIB_ELF for this SoC only if IMX_BOOTAUX is enabled:
> > the arch/arm/mach-imx/imx8/cpu.c guards with #ifdef CONFIG_IMX_BOOTAUX
> > functions that
> > call lib/elf.o members.
>
> And what about the rest of the platforms above?  There's certainly some
> missing Kconfig enforcement of requirements, but I suspect it's wider
> than just one set of SoC families for a long-standing feature.

You may be right. As bootaux command implementation for other boards
may use elf functionality in future, it
would be better to enable LIB_ELF unconditionally.

>
> --
> Tom



--=20
Best regards,

Oleksandr Suvorov
Software Engineer
T: +380 63 8489656
E: oleksandr.suvorov@foundries.io
W: www.foundries.io
