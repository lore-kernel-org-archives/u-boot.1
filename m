Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5967FEE49AB
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 06:54:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88D9086432;
	Wed, 23 Aug 2023 08:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vgj72cdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BCD86435; Wed, 23 Aug 2023 08:54:28 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E809086427
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 08:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99cce6f7de2so715745866b.3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 23:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1692773666; x=1693378466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/jsoNy/YCfD5lh0VNDI2jAwtILgMJUbQPpPn2cIC/sQ=;
 b=Vgj72cdtWOyYEsNCfEp11bk7+ZGmKPb0U2xtOdsFq2xOPJHggWWE17M/H+ppXDVixC
 nxrEXfZ1nX9rcLv9VgukzG5KYyvL+p9GT7BHjs+HoclqiNft20ZwUCwF5IOv/TYE9ii/
 1kWioNVE5odPncXbnkt49lbdwuSNZ2mrC8X10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692773666; x=1693378466;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/jsoNy/YCfD5lh0VNDI2jAwtILgMJUbQPpPn2cIC/sQ=;
 b=GMxkiJtSO3T7QpAZ6Fu3CBEiUmM/SdeTtXO1nzXHNA6Cv6oS0RjbEjlztqh1ANG5OI
 b3vlNzW0rk9iPfthqdwXUvqusrd3WoTa6aP6Ovvf6aPtTnc5THq3haGF2xkN65jmvkYq
 iM01I7oXYfeyr6BDTnZN0u50ux+KqXE03w1LYnToUbsyLi7Hsvimd+zLSHWosQMQmIt6
 7fYdMzDe2XlqEkSVuaA8AJRLlN9wWN1DvcmS9UUrxLD9KNvQFiEyGrOsssScOS7ncG/R
 tszefVMabCi7EMQw+6bjf0iGBAsWb6mWUFQQFZtZTG6Lcdu2V0BZMcY7wuZppKYmta9H
 7Q1w==
X-Gm-Message-State: AOJu0YyRUQlxxR7fyBMdNutiDpTaubs5UcG/IPaj9sdTitT1kWsXsCOA
 vu2WPfHyz6/1SSidx0psUVYKqVrAbftGYxhaVEHod35ZFXJkh//3
X-Google-Smtp-Source: AGHT+IFdNxtcZE7N8ubb6X4pm0mybIz90eL2aVtfxQKeb9bxyX+5j29G6PUjpeTF9pDp4HkbibrwrcgI+xLbbCMTvGg=
X-Received: by 2002:a17:906:9be3:b0:992:3897:1985 with SMTP id
 de35-20020a1709069be300b0099238971985mr9451540ejc.43.1692773666336; Tue, 22
 Aug 2023 23:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230808130250.188588-1-ada@thorsis.com>
 <20230808130250.188588-3-ada@thorsis.com>
 <CAOf5uwkgaoGyB3kS7Kf4GZyvAcGDJMTRPajXa4SQVy7LU6BJDA@mail.gmail.com>
 <20230808-elusive-apple-4e3ce1331b5a@ifak-system.com>
 <e913d8c6-3daf-0a58-3813-253cb5dee79c@collabora.com>
In-Reply-To: <e913d8c6-3daf-0a58-3813-253cb5dee79c@collabora.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 23 Aug 2023 08:54:15 +0200
Message-ID: <CAOf5uwkzJXU6XU-3gaSAkApzjv0Yf_C7iqjwrVptsyWyfRTm8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mtd: nand: raw: atmel: Add error handling when
 rb-gpios missing
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>,
 u-boot@lists.denx.de, Mihai Sain <mihai.sain@microchip.com>
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

On Wed, Aug 23, 2023 at 8:28=E2=80=AFAM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> Hi,
>
> On 8/8/23 18:03, Alexander Dahl wrote:
> > Hello Michael,
> >
> > Am Tue, Aug 08, 2023 at 03:49:45PM +0200 schrieb Michael Nazzareno Trim=
archi:
> >> Hi
> >>
> >> On Tue, Aug 8, 2023 at 3:03=E2=80=AFPM Alexander Dahl <ada@thorsis.com=
> wrote:
> >>>
> >>> Adapt behaviour to Linux kernel driver.
> >>>
> >>> The return value of gpio_request_by_name_nodev() was not checked befo=
re,
> >>> and thus in case 'rb-gpios' was missing in DT, rb.type was set to
> >>> ATMEL_NAND_GPIO_RB nevertheless, leading to output like this for
> >>> example (on sam9x60-curiosity with the line removed from dts):
> >>>
> >>>      NAND:  Could not find valid ONFI parameter page; aborting
> >>>      device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> >>>      Macronix NAND 512MiB 3,3V 8-bit
> >>>      512 MiB, SLC, erase size: 256 KiB, page size: 4096, OOB size: 64
> >>>      atmel-nand-controller nand-controller: NAND scan failed: -22
> >>>      Failed to probe nand driver (err =3D -22)
> >>>      Failed to initialize NAND controller. (error -22)
> >>>      0 MiB
> >>>
> >>> Note: not having that gpio assigned in dts is fine, the driver does n=
ot
> >>> override nand_chip->dev_ready() then and a generic solution is used.
> >>>
> >>> Fixes: 6a8dfd57220d ("nand: atmel: Add DM based NAND driver")
> >>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> >>> ---
> >>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 11 +++++++----
> >>>   1 file changed, 7 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/m=
td/nand/raw/atmel/nand-controller.c
> >>> index 2b29c8def6..8e745a5111 100644
> >>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> @@ -1600,10 +1600,13 @@ static struct atmel_nand *atmel_nand_create(s=
truct atmel_nand_controller *nc,
> >>>                          nand->cs[i].rb.type =3D ATMEL_NAND_NATIVE_RB=
;
> >>>                          nand->cs[i].rb.id =3D val;
> >>>                  } else {
> >>> -                       gpio_request_by_name_nodev(np, "rb-gpios", 0,
> >>> -                                                  &nand->cs[i].rb.gp=
io,
> >>> -                                                  GPIOD_IS_IN);
> >>> -                       nand->cs[i].rb.type =3D ATMEL_NAND_GPIO_RB;
> >>> +                       ret =3D gpio_request_by_name_nodev(np, "rb-gp=
ios", 0,
> >>> +                                                        &nand->cs[i]=
.rb.gpio,
> >>> +                                                        GPIOD_IS_IN)=
;
> >>> +                       if (ret)
> >>> +                               dev_err(nc->dev, "Failed to get R/B g=
pio (err =3D %d)\n", ret);
> >>
> >> Should not then an error here
> >
> > Different log level or no message at all?
> >
> > Note: Linux prints the same message with error level in that case.
> >
> > Greets
> > Alex
> >
>
> Since the rb-gpios is optional, we can continue probing without it.
> Throwing an error message is optional and pure informative. So I am fine
> with it
>

Yes ok, but I'm not sure linux give an error if the gpio is get as
optional and condition
is IS_ERR. Am I right?

For the rest is fine

Michael

> What I wanted to ask is what happens with nand->cs[i].rb.type , is it 0
> by default ?
>
> Other than that, I can apply this patch, Michael, do you have any more
> comments on it ?
>
> Thanks,
> Eugen
> >>
> >> Michael
> >>
> >>> +                       else
> >>> +                               nand->cs[i].rb.type =3D ATMEL_NAND_GP=
IO_RB;
> >>>                  }
> >>>
> >>>                  gpio_request_by_name_nodev(np, "cs-gpios", 0,
> >>> --
> >>> 2.30.2
> >>>
> >>
> >>
> >> --
> >> Michael Nazzareno Trimarchi
> >> Co-Founder & Chief Executive Officer
> >> M. +39 347 913 2170
> >> michael@amarulasolutions.com
> >> __________________________________
> >>
> >> Amarula Solutions BV
> >> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> >> T. +31 (0)85 111 9172
> >> info@amarulasolutions.com
> >> www.amarulasolutions.com
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
