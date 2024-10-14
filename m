Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C7FCFC501
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 07:18:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B8188F46;
	Mon, 14 Oct 2024 09:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iFZQPJDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35DDC88FE5; Mon, 14 Oct 2024 09:18:50 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D794D86BF1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 09:18:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c97cc837c3so1006762a12.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728890327; x=1729495127;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDftOGxF4JZbTQbbe6WxiADrjJlNdSsbdOAxbJoWuM4=;
 b=iFZQPJDHwl93RqluI2gAoOeWZvlin2DpL1mU4Wl+NMVvriHzwuxZtwm4DE67NFcL4I
 cp/eFfHz5X1KrgbWv9VnzuJKNGSKtmy/AKYF+qSy+KuTyliosvKs84LbFqDCUUtjXSIm
 J0uaVrcX24oqEWFsmaaSIH4V+VCFxKx8+j7cM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728890327; x=1729495127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDftOGxF4JZbTQbbe6WxiADrjJlNdSsbdOAxbJoWuM4=;
 b=d7YkrE5K03ipX/iCMwxGlUsARwNgdRXrhE78MCbin1WHy0YMyw114AJRpwmMI8/qxP
 9G7VJ0CB9qooB3TTbf39Zm92+hFz5a0R4lzanuRPFXkjtUoIM52fVFM0nlqi5ayuI99H
 xnK1oBI8gBh6tArXh0VJ/OHcMR3o38cKl50K+ZjsAegi0t46GZNRvHC0GVAuMGIMNfZP
 fwFHQFkrS8AP35ZAIUrtH30M04LcctKVqw2+9U1w+Kc1dPHZXlonpEwxXZTKTKTSePCU
 0J3Lmubqs3akXaoXNVQr1T1GQwQpKVce+0wEDkN002ilfXPds4ISIqsY/BIUsFtrX1ZY
 3k5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWta23XGNG4BIfR6Dflhqg/6n6k7SEvpSytIH+dvk0BeYXape4684oWbCqXTSaFYnIfN209D5s=@lists.denx.de
X-Gm-Message-State: AOJu0YwlnxcBb4o1DcLi4kJk7Xqq7w5xdaoe/Av1VZCm6a77wXW1cw3c
 2Ef6RfmkqN+WxywrLbQNKqK2RaEa3ZqcuvFjEo9Q7Fk++mE8UDilDjerHv93ZPJxC6MG84SSbDD
 A2Ikft+YtLuNLjyxWVq1aPBt/FmogEyEWpm2uLQ==
X-Google-Smtp-Source: AGHT+IFENkHqp7w0mZY6EcwaNz+haCz6qT2hTIUHyXdc92uExeLVLXyPdHLZT6xx00V3B8ftr4O4tfK3WI/nanu/bOI=
X-Received: by 2002:a05:6402:5188:b0:5c9:59e6:e908 with SMTP id
 4fb4d7f45d1cf-5c959e6f56amr6156000a12.6.1728890327228; Mon, 14 Oct 2024
 00:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240721214552.63965-2-zli@ogga.fr>
 <59a891ca-1f02-4ffa-8727-0934025d88c5@microchip.com>
 <CAOf5uwnP7gGDakGHL1cFSyJQefJ=DG+a5tORU3B8-a7q9+gBiA@mail.gmail.com>
 <3827b52f-e31f-4d41-9a56-b619c35a5705@collabora.com>
 <CAOf5uwnfjRsOQ9NBmgQA9mtU6nm9mOj60KxD26DOZ2rhdchQ4A@mail.gmail.com>
In-Reply-To: <CAOf5uwnfjRsOQ9NBmgQA9mtU6nm9mOj60KxD26DOZ2rhdchQ4A@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 14 Oct 2024 09:18:34 +0200
Message-ID: <CAOf5uw=9i8K2tfCUpNxEfXStndfgwhkBUWv7URTvw2ZrLeWaLg@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: nand: raw: atmel: Use ONFI ECC params if available
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Balamanikandan.Gunasundar@microchip.com, u-boot@lists.denx.de, 
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

On Wed, Oct 9, 2024 at 10:24=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Mon, Jul 29, 2024 at 10:07=E2=80=AFAM Eugen Hristev
> <eugen.hristev@collabora.com> wrote:
> >
> > On 7/25/24 12:41, Michael Nazzareno Trimarchi wrote:
> > > Hi
> > >
> > > On Thu, Jul 25, 2024 at 11:36=E2=80=AFAM
> > > <Balamanikandan.Gunasundar@microchip.com> wrote:
> > >>
> > >> Acked-by: Balamanikandan Gunasundar
> > >> <balamanikandan.gunasundar@microchip.com>
> > >>
> > >> On 22/07/24 3:15 am, Zixun LI wrote:
> > >>> [Some people who received this message don't often get email from a=
dmin@hifiphile.com. Learn why this is important at https://aka.ms/LearnAbou=
tSenderIdentification ]
> > >>>
> > >>> EXTERNAL EMAIL: Do not click links or open attachments unless you k=
now the content is safe
> > >>>
> > >>> When ECC parameters are not specified in DT, first try ONFI ECC par=
ameters
> > >>> before fallback to maximum strength.
> > >>>
> > >>> It's the Linux driver behavior since the driver rewriting in f88fc1=
2.
> > >>>
> > >>>  From then 2 nand system refactors have been done in 6a1b66d6 and 5=
3576c7b,
> > >>> chip->ecc_strength_ds and chip->ecc_step_ds became
> > >>> nanddev_get_ecc_requirements(). U-Boot didn't follow the refactor a=
nd
> > >>> always use these 2 fields.
> > >>>
> > >>> v2: Fix formatting, add upstream commit hash.
> > >>>
> > >>> Signed-off-by: Zixun LI <zli@ogga.fr>
> > >>> ---
> > >>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
> > >>>   1 file changed, 4 insertions(+)
> > >>>
> > >>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers=
/mtd/nand/raw/atmel/nand-controller.c
> > >>> index ee4ec6da58..817fab4ca3 100644
> > >>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > >>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > >>> @@ -1029,11 +1029,15 @@ static int atmel_nand_pmecc_init(struct nan=
d_chip *chip)
> > >>>                  req.ecc.strength =3D ATMEL_PMECC_MAXIMIZE_ECC_STRE=
NGTH;
> > >>>          else if (chip->ecc.strength)
> > >>>                  req.ecc.strength =3D chip->ecc.strength;
> > >>> +       else if (chip->ecc_strength_ds)
> > >>> +               req.ecc.strength =3D chip->ecc_strength_ds;
> > >>>          else
> > >>>                  req.ecc.strength =3D ATMEL_PMECC_MAXIMIZE_ECC_STRE=
NGTH;
> > >>>
> > >>>          if (chip->ecc.size)
> > >>>                  req.ecc.sectorsize =3D chip->ecc.size;
> > >>> +       else if (chip->ecc_step_ds)
> > >>> +               req.ecc.sectorsize =3D chip->ecc_step_ds;
> > >>>          else
> > >>>                  req.ecc.sectorsize =3D ATMEL_PMECC_SECTOR_SIZE_AUT=
O;
> > >>>
> > >>> --
> > >>> 2.45.2
> > >>>
> > >>
> > >
> > > Feel free to apply on microchip uboot branch if you are on hurry
> > >
> > > Michael
> > >
> > Hello Michael,
> >
> > This is fine, you(or Dario) can pick this up through the nand tree.
> >
> > Eugen
>
> I totally missed, I will pick up today
>

Applied thanks

> Michael
>
> --
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com



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
