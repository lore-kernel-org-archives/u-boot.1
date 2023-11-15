Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B00C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 10:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AC3870FC;
	Wed, 15 Nov 2023 11:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O8XHfXIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E248082A; Wed, 15 Nov 2023 11:38:48 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB50870FC
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:38:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso10154264a12.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 02:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1700044724; x=1700649524;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9VmR1ghBNHx4r4juENiOMKIi9RdOoP9dwsU/RLjwJdM=;
 b=O8XHfXIETCdNn/T/bRBvwTiTDo/X+oHCi8H88tLGPDgVnclTlw6Ux4xLlQxtwspNNi
 IIttamWSCqc1Ko2RWGcXESGaiiJYft1sc56jTe+EzvAI6l6IofOWXdLcPVgpZNhX3fTx
 7ozD2vfmWvUscU97X3n7Is/lXtqn0LzU3AORM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700044724; x=1700649524;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9VmR1ghBNHx4r4juENiOMKIi9RdOoP9dwsU/RLjwJdM=;
 b=ak2iK50yZkWuBgQZkyWUu65LnTU2Pv80aRoYPFQBWKpQVUIHZa+Qp4fLa2g0xeEpdI
 pncMLMXPfa4mI2va67PvC1V6ztkwcuZDSdc3vXQGiGT2jopu1xBclP3HCAFsjGn1ZKmz
 JeHjWKxkeS9Nsuu8i96XNtkYThe2BWe8ujFPRMj0BFyvqNx7MEGPl7QjXE3FioxjPGqY
 0nP/gd/DZFhzd2nmKM5NcjNxyYs4Ijiu5Dhm6cGlXM6PBfjSugq7n98vpIn86I7uQNc6
 PUdSxxy3Vyui2DZi+Op82mPQhRIxyTvHGjvIw/Z1xmp/0VGPwbClkUfAVSUqZjO1WNyb
 kk8w==
X-Gm-Message-State: AOJu0YyI+6TpvfBG6hp8PXGpfoTqJL9FFxye0abybnBPpQhq0JsUi3e8
 6go/94PXkLj4pVisz+jPnoUFjHEt6Vgrbe1zkpp+DcnRlpvg6DiS
X-Google-Smtp-Source: AGHT+IHYY56r31ZwHDk50G3yy2jFg4arSFeQ/OQ3j+VZb/GOpfQwqbAWZneZYoVx13IFQyzWjJZWiflkTyU5OzKXyXQ=
X-Received: by 2002:a17:907:7b8f:b0:9da:f85a:233f with SMTP id
 ne15-20020a1709077b8f00b009daf85a233fmr11933215ejc.28.1700044724287; Wed, 15
 Nov 2023 02:38:44 -0800 (PST)
MIME-Version: 1.0
References: <20231115054044.3937543-1-hs@denx.de>
 <AM7PR10MB37364EB893AFCEC4765D42DFFFB1A@AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM7PR10MB37364EB893AFCEC4765D42DFFFB1A@AM7PR10MB3736.EURPRD10.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 15 Nov 2023 11:38:33 +0100
Message-ID: <CAOf5uwkA2jSjXj9hrcB8YqEyP6HmJx76KZ6xvy7b-6XrO8aCfw@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
To: "Leto, Enrico" <enrico.leto@siemens.com>, Roger Quadros <rogerq@kernel.org>
Cc: "hs@denx.de" <hs@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
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

On Wed, Nov 15, 2023 at 11:37=E2=80=AFAM Leto, Enrico <enrico.leto@siemens.=
com> wrote:
>
> Patch is working by me.
>
> > -----Original Message-----
> > From: Heiko Schocher <hs@denx.de>
> > Sent: Wednesday, November 15, 2023 6:41 AM
> > To: U-Boot Mailing List <u-boot@lists.denx.de>; Leto, Enrico (SI BP R&D=
 ZG FW
> > CCP) <enrico.leto@siemens.com>
> > Cc: Schocher, Heiko (EXT) (DENX Software Engineering GmbH) <hs@denx.de>=
;
> > Dario Binacchi <dario.binacchi@amarulasolutions.com>; Michael Trimarchi
> > <michael@amarulasolutions.com>
> > Subject: [PATCH] mtd: rawnand: omap_gpmc: fix BCH8 HW based correction
> >
> > commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based
> > correction")
> >
> > broke AM335x based boards booting from NAND with ECC BCH8 code.
> >
> > Use omap_enable_hwecc() instead of omap_enable_hwecc_bch() in SPL
> > restores correct SPL nand_read_page functionality.
> >
> > Tested on draco thuban board.
> >
> > Signed-off-by: Heiko Schocher <hs@denx.de>
> >
> > ---
> > fix NAND boot for BCH8 based TI AM335x boards
> >
> > Fix is based on series from Enrico:
> >

We need test the boards that Roger add here.

Michael

> > https://lists.d/
> > enx.de%2Fpipermail%2Fu-boot%2F2023-
> > November%2F536793.html&data=3D05%7C01%7Cenrico.leto%40siemens.com
> > %7Cbd939f15167c49cc97b708dbe59d6e9e%7C38ae3bcd95794fd4addab4
> > 2e1495d55a%7C1%7C0%7C638356236545245361%7CUnknown%7CTWFp
> > bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> > CI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DIUqjryYUtp%2Fdm9GgCALPTl8f%
> > 2BlcrO0ErXjkvoDwz7v4%3D&reserved=3D0
> >
> > and fixes NAND boot for the draco thuban board. But this patch apply al=
so
> > without the patches from above patchseries, see azure build:
> >
> > https://dev.a/
> > zure.com%2Fhs0298%2Fhs%2F_build%2Fresults%3FbuildId%3D111%26vie
> > w%3Dresults&data=3D05%7C01%7Cenrico.leto%40siemens.com%7Cbd939f15
> > 167c49cc97b708dbe59d6e9e%7C38ae3bcd95794fd4addab42e1495d55a%
> > 7C1%7C0%7C638356236545245361%7CUnknown%7CTWFpbGZsb3d8eyJ
> > WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> > %7C3000%7C%7C%7C&sdata=3DS2itRHsR49lD9TlBexYw9J5waXiuFcS%2BhUp
> > %2B7Yi60MA%3D&reserved=3D0
> >
> > which is clean.
> >
> > Above commit seems to change only U-Boot code and did not adapt
> > am335x_spl_bch.c, which breaks nand_read_page in SPL code for AM335x
> > based boards. So use in SPL "old" hw setup and reading page from NAND i=
n
> > SPL works again.
> >
> >
> >  drivers/mtd/nand/raw/omap_gpmc.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/omap_gpmc.c
> > b/drivers/mtd/nand/raw/omap_gpmc.c
> > index 1a5ed0de31..c9b66dadbd 100644
> > --- a/drivers/mtd/nand/raw/omap_gpmc.c
> > +++ b/drivers/mtd/nand/raw/omap_gpmc.c
> > @@ -983,7 +983,11 @@ static int omap_select_ecc_scheme(struct
> > nand_chip *nand,
> >               nand->ecc.strength      =3D 8;
> >               nand->ecc.size          =3D SECTOR_BYTES;
> >               nand->ecc.bytes         =3D 14;
> > +#if defined(CONFIG_SPL_BUILD)
> > +             nand->ecc.hwctl         =3D omap_enable_hwecc;
> > +#else
> >               nand->ecc.hwctl         =3D omap_enable_hwecc_bch;
> > +#endif
> >               nand->ecc.correct       =3D omap_correct_data_bch;
> >               nand->ecc.calculate     =3D omap_calculate_ecc_bch;
> >               nand->ecc.read_page     =3D omap_read_page_bch;
> > --
> > 2.37.3
>


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
