Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C96C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 12:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B097885AE;
	Fri,  9 Aug 2024 14:36:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KiPyFj5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D910888E4; Fri,  9 Aug 2024 14:36:58 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1124788413
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 14:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a7aada2358fso478582366b.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1723207015; x=1723811815;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIOifCNX7idYWD8y9YEW/ewfQyLsnN1lucl5ATI/vtA=;
 b=KiPyFj5DWjFM7cM+uTl52CJhDk6EqLcaZHWrjz8nnOxB/KCGxX+BJwOxYebx/2dJ9A
 p3nsWfeUXUkyjP5gw/RDBrBLISyNIxAvQq8agBVCZwjyD92Hop4uNlekgXXeNpnc6BQg
 TWBYDTiOFtkyGJSEi6ynbDrOLhVAAuZa9wKwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723207015; x=1723811815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIOifCNX7idYWD8y9YEW/ewfQyLsnN1lucl5ATI/vtA=;
 b=Clw6rgnfC5fXbVgkETBfbWgTU8e5qc2E2d4+7rRq/bXr3+QzFNpzJRLtRJN8AxiyqJ
 W1dCGXwjQtMjMQn8vA1zVPHs65XGr90UJAjbJJrOQKmOXr9jtyDlGQ9e9tLBSemXR1Q6
 fsQTFmPXrMMeGOhYvSPuNP2LkzcZMydvL3CFYvG7YnSslAe7vkvRLwwgfYQHKGKF/G5S
 jpkxniUvwAMxIVpbWvejs8zb80hNOvEgeB5t0y3jTu8lK5hXSrtLs+LoHBdiayYEuLEy
 tNLfTGFBglVa6Um45vwQPdDC9ES3YmWJ/xCiTkCCu5rYX/ZdKTukk5oGDwsr5FlAUV5j
 m34Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDP+WYjaRc1MZ+l4RMjULhLCX1GCKDVHxtRWcRBE3ej5rwCpU9CUioCsDbPKQwaVFKm2VHPYrFtjhnokPzPcA/t7Klig==
X-Gm-Message-State: AOJu0Yzun2QaPB1lOCrFBuvK4Upk6jT5+5dVrYfL4RthN4RE2ULwgYLb
 lQwX1quvn9D4IEwLzNRanqNh7XJwLsB5p0H6g8hfqBGSb8SBgR4p+haoM6Eqt+c3mWKR2lxqJcU
 BaKCDpe+2DtVuLWlOlQmnlGsYk5zf9IsCbaQZgQ==
X-Google-Smtp-Source: AGHT+IFTPrVCBEZSLWKIjBTC1fBmo+KHJ1Q3SIND9aB1QjVou0eN8JAYFCdC6rM2o005B5ddBM/Nq7pkegJuBJuTSWI=
X-Received: by 2002:a17:907:845:b0:a7d:a453:dba1 with SMTP id
 a640c23a62f3a-a80ab8027abmr145434766b.20.1723207015308; Fri, 09 Aug 2024
 05:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
 <20240809-challenge-causation-20cf58794b33@thorsis.com>
In-Reply-To: <20240809-challenge-causation-20cf58794b33@thorsis.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 9 Aug 2024 14:36:44 +0200
Message-ID: <CAOf5uwkcSKJCG4-L1mvy8NJZJkBauVvx9GxM5x4VQfGWvPktNQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
To: Marcus Folkesson <marcus.folkesson@gmail.com>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Alexander Dahl <ada@thorsis.com>
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

Hi all

On Fri, Aug 9, 2024 at 2:25=E2=80=AFPM Alexander Dahl <ada@thorsis.com> wro=
te:
>
> Hello Marcus,
>
> Am Fri, Aug 09, 2024 at 02:15:43PM +0200 schrieb Marcus Folkesson:
> > The condition 'ret' is always true as it is never set to other than
> > -EIO.
>
> Technically, you're right.
>
> I quickly compared with the same driver in Linux.  That has some
> additional lines for DMA transfers which probably got removed when
> porting the driver.
>
> Does the code before your patch throw compiler warnings?  If not, I
> would keep it as is.  The compiler will probably optimize it away
> anyway, and it would make future ports from Linux easier.
>

I suggest to comment it because it will happen to other people to send a si=
milar
patch

Michael

> Greets
> Alex
>
> >
> > Remove 'ret' and the condition for copy.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >
> >  drivers/mtd/nand/raw/atmel/nand-controller.c | 10 ++--------
> >  1 file changed, 2 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd=
/nand/raw/atmel/nand-controller.c
> > index ee4ec6da58..00d7e177b9 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -568,12 +568,9 @@ static void atmel_nfc_copy_to_sram(struct nand_chi=
p *chip, const u8 *buf,
> >       struct mtd_info *mtd =3D nand_to_mtd(chip);
> >       struct atmel_nand *nand =3D to_atmel_nand(chip);
> >       struct atmel_hsmc_nand_controller *nc;
> > -     int ret =3D -EIO;
> >
> >       nc =3D to_hsmc_nand_controller(nand->controller);
> > -
> > -     if (ret)
> > -             memcpy_toio(nc->sram.virt, buf, mtd->writesize);
> > +     memcpy_toio(nc->sram.virt, buf, mtd->writesize);
> >
> >       if (oob_required)
> >               memcpy_toio(nc->sram.virt + mtd->writesize, chip->oob_poi=
,
> > @@ -586,12 +583,9 @@ static void atmel_nfc_copy_from_sram(struct nand_c=
hip *chip, u8 *buf,
> >       struct mtd_info *mtd =3D nand_to_mtd(chip);
> >       struct atmel_nand *nand =3D to_atmel_nand(chip);
> >       struct atmel_hsmc_nand_controller *nc;
> > -     int ret =3D -EIO;
> >
> >       nc =3D to_hsmc_nand_controller(nand->controller);
> > -
> > -     if (ret)
> > -             memcpy_fromio(buf, nc->sram.virt, mtd->writesize);
> > +     memcpy_fromio(buf, nc->sram.virt, mtd->writesize);
> >
> >       if (oob_required)
> >               memcpy_fromio(chip->oob_poi, nc->sram.virt + mtd->writesi=
ze,
> > --
> > 2.45.1
> >



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
