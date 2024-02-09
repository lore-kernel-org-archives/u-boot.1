Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8956FC48260
	for <u-boot@archiver.kernel.org>; Fri,  9 Feb 2024 01:57:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96084879D7;
	Fri,  9 Feb 2024 02:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=lessconfused.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=lessconfused.com header.i=@lessconfused.com header.b="ee/FoTd+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2622F87B85; Fri,  9 Feb 2024 02:57:40 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C6687873
 for <u-boot@lists.denx.de>; Fri,  9 Feb 2024 02:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=lessconfused.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=da@lessconfused.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-296c2b74448so344292a91.0
 for <u-boot@lists.denx.de>; Thu, 08 Feb 2024 17:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lessconfused.com; s=lessconfused; t=1707443855; x=1708048655;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eRY+i09Aamz2tHKIeaqO7d1JBUsa7hRszKWNKrRBDv0=;
 b=ee/FoTd+ZpTjrS82AZla4XCw7MuwGTxh8Epe88X9wLWUIUSgiszf3FONJ6RGy17uiO
 v9ISe/8CkmkQyjQ9vkvj09OSabKXTdQy1NTV6J3xC06ew7kpwPmFrYTS7rLoNQl3a9I2
 M6gYqc+a6odtG9eBID/NGbCn+GrIVSABcvQGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707443855; x=1708048655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRY+i09Aamz2tHKIeaqO7d1JBUsa7hRszKWNKrRBDv0=;
 b=E1tmrDBR0AqOPY78LBmOy09+oUPIxOjdbtNFI519UDTRxzS4mLB3TD4BreZ1ZA9Vrn
 k7CA2uu6LHD3J6/IBC5+eQM6EmjNMAGqgqn+asiCUn7dpy7VOvG04szzihiTxPGRrOxF
 dlHTu611jaawyku/Vd+8yAeT9C8PR/OwlE5tPojSnUoGH6bbzdc5y0LTd8ff5XVnRymC
 7Lisv2GL7AftX8DqyOaIziBEcpSiSFGohsgb5cnJ9LrGXrxEOuBnJT89xbueDy6EwQSW
 p1HJOQu6awcGHk1MXFZXZrqpRdkVA/UvEwKA1wijMpD6FDWsQyL04hmstYBE3rY9Wn40
 76pQ==
X-Gm-Message-State: AOJu0YxGqDrZeffR8tJ4B7N8CV9Sweq8kfSHIXGdNSU29X5MavGWq4Q+
 gqKTZ7daQ48LYe4cxOcKJznF6h1Zays/+/1gdd+g7yXWBtlyYsZazab4DJXQL5oB4FnAsmB6DC7
 jnz+heDvJ6i5cmFX91VKaYCSBDhqsJq3WKyufkWHjRzfyyO284N8=
X-Google-Smtp-Source: AGHT+IG59FxFlh5yvxsRiiOHM/L2VrcrujIEmpwCdPSrsKO4XpjiZJ5h9pEVZP3L1oERve6TxwTtavlb7g2zL3YoNK4=
X-Received: by 2002:a17:90b:2249:b0:296:df78:82c8 with SMTP id
 hk9-20020a17090b224900b00296df7882c8mr207484pjb.22.1707443855258; Thu, 08 Feb
 2024 17:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-14-jonas@kwiboo.se>
 <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
In-Reply-To: <72bd1e6d81755da0300a5da9a64b7408@manjaro.org>
From: Da Xue <da@lessconfused.com>
Date: Thu, 8 Feb 2024 20:57:23 -0500
Message-ID: <CACdvmAjfCWicRd=LKKyob7fZo79AFkUQKy0e1HBb0zyJuoO70g@mail.gmail.com>
Subject: Re: [PATCH 13/15] rockchip: rk3328: Add support to build bootable SPI
 image
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, Feb 7, 2024 at 10:53=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Jonas,
>
> On 2024-02-07 01:02, Jonas Karlman wrote:
> > Similar to RK35xx the BootRom in RK3328 can read all data and look for
> > idbloader at 0x8000, same as on SD and eMMC.
> >
> > Use the rksd format and modify the mkimage offset to generate a
> > bootable
> > u-boot-rockchip-spi.bin that can be written to 0x0 of SPI NOR flash.
> >
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> Could you, please, clarify a bit why the "rkspi" format isn't used
> instead of "rksd"?

"The SPI code has a bug that means that the 2=E2=80=AFKiB blocks in which t=
he
bootloader is loaded have a stride of 4KiB, leaving the 2KiB inbetween
as unused padding."

RK3399 has the 2K SPI bug and necessitated the rkspi format. RK3328
came after RK3399 and resolved this bug so the SPI and MMC formats are
now the same.

I verified on a ROC-RK3328-CC-V2.

>
> > ---
> >  arch/arm/dts/rk3328-u-boot.dtsi        | 11 +++++++++++
> >  arch/arm/mach-rockchip/rk3328/rk3328.c |  1 +
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/arch/arm/dts/rk3328-u-boot.dtsi
> > b/arch/arm/dts/rk3328-u-boot.dtsi
> > index b90d78878d77..2a5dca97dd4b 100644
> > --- a/arch/arm/dts/rk3328-u-boot.dtsi
> > +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> > @@ -120,3 +120,14 @@
> >  &usb20_otg {
> >       hnp-srp-disable;
> >  };
> > +
> > +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> > +&binman {
> > +     simple-bin-spi {
> > +             mkimage {
> > +                     args =3D "-n", CONFIG_SYS_SOC, "-T", "rksd";
> > +                     offset =3D <0x8000>;
> > +             };
> > +     };
> > +};
> > +#endif
> > diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c
> > b/arch/arm/mach-rockchip/rk3328/rk3328.c
> > index b591d38fe412..b82b209de9e2 100644
> > --- a/arch/arm/mach-rockchip/rk3328/rk3328.c
> > +++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
> > @@ -36,6 +36,7 @@
> >
> >  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] =3D {
> >       [BROM_BOOTSOURCE_EMMC] =3D "/mmc@ff520000",
> > +     [BROM_BOOTSOURCE_SPINOR] =3D "/spi@ff190000/flash@0",
> >       [BROM_BOOTSOURCE_SD] =3D "/mmc@ff500000",
> >  };
