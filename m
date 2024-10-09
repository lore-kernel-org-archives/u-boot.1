Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFE4CED62A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 08:25:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D62C689079;
	Wed,  9 Oct 2024 10:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="pUW8d+96";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A9C89080; Wed,  9 Oct 2024 10:25:12 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4631288928
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 10:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c8784e3bc8so8934127a12.1
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 01:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1728462309; x=1729067109;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6O2JuTNJdR59CYFKMKQez9udD/NCcASJOdYchTIoY0=;
 b=pUW8d+96iIhnjNZOcfDGt3dZvb3Q9VAzGk7c8vlVT8yNp7vO2q7CF5bnq3x55GZGbL
 wdajwH2zGBqocMVUFfX/Ju5rBEAOIggXgTeCalsydHkRQRBKXs89VcN32ocL9IQ9U31n
 Q9yNK7u7XmDCzq77LMsRZDWjH2v8xwgagcy7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728462309; x=1729067109;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z6O2JuTNJdR59CYFKMKQez9udD/NCcASJOdYchTIoY0=;
 b=jUIIfRzaXavj0P7UEsaRq4lgvptIMeYISqmRO/bc1iNy8WWlpWd8K9V/8hEsWIg9yZ
 /FxIj8284M7absUL9LlLcXYllAf+kEL9sOL/7++Xe+l/bL9tOVlrpXWBHncLU3pWfdNw
 AjZWhjv9dLCejPT4LQGZCDnvrchhAUFPC+kEinsziI+0QSEueHKXs9DJPLh6Gt3qgCcU
 4AJlC7vKLTybQGuWtFgulmZ2ubgU+yAMoyOu+48NSDrA4VobbR7ccOvq3L3KogDS5X31
 npP6VfcR0xA+LbV3dmeJLTAQeblLZZ2Cu3kR7TfrbgyFeueEQpeXMeKQhMin9jiPl03R
 MvUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcP9W+x0AAajh/ifPixrr7ePGoD4kWuaOGlyeJhzTms++DEO/sbAmDokb/1TInmFoLxExcP04=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0A7EUHzU9wUuXrkUTK1xfS4iI+d3YKUgGwX4Wz0i/2aXSgEFM
 M+k8iqUXk5fAwYSPPry3zmegoInnb3RZ/Q8KJ+3cwoQTRSGmkJrFMLAX73jZ1ZKPmudycofXVuT
 iWvI/u0dgIIHLDyyLpCXIV54XrtoOAthKwcz4hQ==
X-Google-Smtp-Source: AGHT+IGAxWCLrIXOSCDNNLKNs6/2Je40exoq4krkYW6agk8dyYnvwF0u/lOkua7ny42P5mmzSdDi11X4oOc/tijPHv0=
X-Received: by 2002:a05:6402:5243:b0:5c9:1cf3:8fca with SMTP id
 4fb4d7f45d1cf-5c91d670b1emr1529113a12.24.1728462309171; Wed, 09 Oct 2024
 01:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240721214552.63965-2-zli@ogga.fr>
 <59a891ca-1f02-4ffa-8727-0934025d88c5@microchip.com>
 <CAOf5uwnP7gGDakGHL1cFSyJQefJ=DG+a5tORU3B8-a7q9+gBiA@mail.gmail.com>
 <3827b52f-e31f-4d41-9a56-b619c35a5705@collabora.com>
In-Reply-To: <3827b52f-e31f-4d41-9a56-b619c35a5705@collabora.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 9 Oct 2024 10:24:57 +0200
Message-ID: <CAOf5uwnfjRsOQ9NBmgQA9mtU6nm9mOj60KxD26DOZ2rhdchQ4A@mail.gmail.com>
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

On Mon, Jul 29, 2024 at 10:07=E2=80=AFAM Eugen Hristev
<eugen.hristev@collabora.com> wrote:
>
> On 7/25/24 12:41, Michael Nazzareno Trimarchi wrote:
> > Hi
> >
> > On Thu, Jul 25, 2024 at 11:36=E2=80=AFAM
> > <Balamanikandan.Gunasundar@microchip.com> wrote:
> >>
> >> Acked-by: Balamanikandan Gunasundar
> >> <balamanikandan.gunasundar@microchip.com>
> >>
> >> On 22/07/24 3:15 am, Zixun LI wrote:
> >>> [Some people who received this message don't often get email from adm=
in@hifiphile.com. Learn why this is important at https://aka.ms/LearnAboutS=
enderIdentification ]
> >>>
> >>> EXTERNAL EMAIL: Do not click links or open attachments unless you kno=
w the content is safe
> >>>
> >>> When ECC parameters are not specified in DT, first try ONFI ECC param=
eters
> >>> before fallback to maximum strength.
> >>>
> >>> It's the Linux driver behavior since the driver rewriting in f88fc12.
> >>>
> >>>  From then 2 nand system refactors have been done in 6a1b66d6 and 535=
76c7b,
> >>> chip->ecc_strength_ds and chip->ecc_step_ds became
> >>> nanddev_get_ecc_requirements(). U-Boot didn't follow the refactor and
> >>> always use these 2 fields.
> >>>
> >>> v2: Fix formatting, add upstream commit hash.
> >>>
> >>> Signed-off-by: Zixun LI <zli@ogga.fr>
> >>> ---
> >>>   drivers/mtd/nand/raw/atmel/nand-controller.c | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/m=
td/nand/raw/atmel/nand-controller.c
> >>> index ee4ec6da58..817fab4ca3 100644
> >>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> >>> @@ -1029,11 +1029,15 @@ static int atmel_nand_pmecc_init(struct nand_=
chip *chip)
> >>>                  req.ecc.strength =3D ATMEL_PMECC_MAXIMIZE_ECC_STRENG=
TH;
> >>>          else if (chip->ecc.strength)
> >>>                  req.ecc.strength =3D chip->ecc.strength;
> >>> +       else if (chip->ecc_strength_ds)
> >>> +               req.ecc.strength =3D chip->ecc_strength_ds;
> >>>          else
> >>>                  req.ecc.strength =3D ATMEL_PMECC_MAXIMIZE_ECC_STRENG=
TH;
> >>>
> >>>          if (chip->ecc.size)
> >>>                  req.ecc.sectorsize =3D chip->ecc.size;
> >>> +       else if (chip->ecc_step_ds)
> >>> +               req.ecc.sectorsize =3D chip->ecc_step_ds;
> >>>          else
> >>>                  req.ecc.sectorsize =3D ATMEL_PMECC_SECTOR_SIZE_AUTO;
> >>>
> >>> --
> >>> 2.45.2
> >>>
> >>
> >
> > Feel free to apply on microchip uboot branch if you are on hurry
> >
> > Michael
> >
> Hello Michael,
>
> This is fine, you(or Dario) can pick this up through the nand tree.
>
> Eugen

I totally missed, I will pick up today

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
