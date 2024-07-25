Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A8C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 09:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C81E86FB1;
	Thu, 25 Jul 2024 11:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="GI3bYTUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C650787E64; Thu, 25 Jul 2024 11:41:41 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75745866EE
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 11:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a7ac469e4c4so60796966b.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721900499; x=1722505299;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=favh8M4n2AkUF/UmM2nwJU8h0tKz5jFs0zDkWyo5PoI=;
 b=GI3bYTUgwkm+2GpTxNXZP2jNB/AC5pB0eUGYB8T09awoYgXuuH4vkQxeN4ZiCJ7IDV
 8JmgXV65o1BMKhh/2tqKa/U8ThVWDTFdqUcZXMPBRUtPmIrGhQldfsczo4dAq+zkbNPp
 Ge41p07tO1DGR0vXFwnu6/KmduqCkEeABRMzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721900499; x=1722505299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=favh8M4n2AkUF/UmM2nwJU8h0tKz5jFs0zDkWyo5PoI=;
 b=jtR0mwz7aes9L8nuHYrG1TpFlG9z+QdPN3WXg/dfh5HQ4pDE7vEEKqHonvlCajpZk1
 5SpTFSwzOjtFa/uEID9XmFuadhRZzc5Q2MrTUupnV77/3K20ACVOhYg5PuwF+PXxCkV+
 je2SB4CsoKDcYPrtGaKkXm2YtH+roFN6cpFAd3b936wrzCWvS0MrphEWcfioGblK3was
 a5QjJjHO2Qi1nC74u52k1ImUK0B6mMBZCGkYaAa6GEjCbP2C0zRTQ4gVD9iV960MhX3D
 idI9/BQ+Du3/fv0SBKrIK5inYQgqfs0oEHfHWua/tswEEL9Sea55e8a3Tl706DGUTXcn
 C8xg==
X-Gm-Message-State: AOJu0Yx0GBjmU6WSXdRlE3s9nJABXUaDHwxmEYnjZJ3gIndI/rzNK1Q0
 FU0GimRWeFycG3BKiTHgfwrG9KlSh5GRsXjffqTgHYfCDdU81ZPDGiVfstz6790kYWT5VGf/g9I
 llmoSQtZ7SkKx4QOeVQPoSG2YQeNeTIpPUKAIgw==
X-Google-Smtp-Source: AGHT+IE4o0kRmmqT3ApXtBivqloTjS6U+/sVvrgJOUaghJW6f6XHHWU24btkfNueeuEdHCkb+EBP09euzYF27FmDBe4=
X-Received: by 2002:a17:907:6d13:b0:a7a:acae:3419 with SMTP id
 a640c23a62f3a-a7ab3162321mr470902566b.28.1721900498915; Thu, 25 Jul 2024
 02:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240721214552.63965-2-zli@ogga.fr>
 <59a891ca-1f02-4ffa-8727-0934025d88c5@microchip.com>
In-Reply-To: <59a891ca-1f02-4ffa-8727-0934025d88c5@microchip.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 25 Jul 2024 11:41:28 +0200
Message-ID: <CAOf5uwnP7gGDakGHL1cFSyJQefJ=DG+a5tORU3B8-a7q9+gBiA@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
To: Balamanikandan.Gunasundar@microchip.com
Cc: u-boot@lists.denx.de
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

Hi

On Thu, Jul 25, 2024 at 11:36=E2=80=AFAM
<Balamanikandan.Gunasundar@microchip.com> wrote:
>
> Acked-by: Balamanikandan Gunasundar
> <balamanikandan.gunasundar@microchip.com>
>
> On 22/07/24 3:15 am, Zixun LI wrote:
> > [Some people who received this message don't often get email from admin=
@hifiphile.com. Learn why this is important at https://aka.ms/LearnAboutSen=
derIdentification ]
> >
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > When ECC parameters are not specified in DT, first try ONFI ECC paramet=
ers
> > before fallback to maximum strength.
> >
> > It's the Linux driver behavior since the driver rewriting in f88fc12.
> >
> >  From then 2 nand system refactors have been done in 6a1b66d6 and 53576=
c7b,
> > chip->ecc_strength_ds and chip->ecc_step_ds became
> > nanddev_get_ecc_requirements(). U-Boot didn't follow the refactor and
> > always use these 2 fields.
> >
> > v2: Fix formatting, add upstream commit hash.
> >
> > Signed-off-by: Zixun LI <zli@ogga.fr>
> > ---
> >   drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd=
/nand/raw/atmel/nand-controller.c
> > index ee4ec6da58..817fab4ca3 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -1029,11 +1029,15 @@ static int atmel_nand_pmecc_init(struct nand_ch=
ip *chip)
> >                  req.ecc.strength =3D ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH=
;
> >          else if (chip->ecc.strength)
> >                  req.ecc.strength =3D chip->ecc.strength;
> > +       else if (chip->ecc_strength_ds)
> > +               req.ecc.strength =3D chip->ecc_strength_ds;
> >          else
> >                  req.ecc.strength =3D ATMEL_PMECC_MAXIMIZE_ECC_STRENGTH=
;
> >
> >          if (chip->ecc.size)
> >                  req.ecc.sectorsize =3D chip->ecc.size;
> > +       else if (chip->ecc_step_ds)
> > +               req.ecc.sectorsize =3D chip->ecc_step_ds;
> >          else
> >                  req.ecc.sectorsize =3D ATMEL_PMECC_SECTOR_SIZE_AUTO;
> >
> > --
> > 2.45.2
> >
>

Feel free to apply on microchip uboot branch if you are on hurry

Michael

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
