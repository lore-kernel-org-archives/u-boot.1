Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F45C2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B2387D07;
	Mon, 24 Jun 2024 10:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rwRloiQu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E43B787DEA; Mon, 24 Jun 2024 10:37:41 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CAC87CFE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:37:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d1782679fso4606219a12.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 01:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1719218259; x=1719823059;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ND4MEjNhUWG1UC/XT0vmhFU1y3Ke+pQUvXQAAbb2Zw=;
 b=rwRloiQursa3pbTwXxDAgCfhFic+Fl+0JyTFh1GeydNB1Wg6VKK/k0cUEos6dQ2Eqt
 7vHEgL5aFQ4M4PzunoMYnUOfHhx8LALO3w4adEGF1vwD40yBocHajgwxEOT85Gqq0tGW
 XZ255sZg2SOJIJjlgyH3oKhSZNy5vN3VU7H7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719218259; x=1719823059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ND4MEjNhUWG1UC/XT0vmhFU1y3Ke+pQUvXQAAbb2Zw=;
 b=twpUlJ9lzUusXBvxSY00fHvLgSRYVoARV+FEbGfGTLT40GOoT6c7UW+OVECUmsQPv4
 eF+rKnHql5Bol0iIJY0yDYEDE0HKQtoJ1vficDpW+1V7tOewskwBcazq+O68ZGIAOUxX
 QgQoNQp4Al616SeS/CbYVyGLoYoyOI4TBMyMIDcgLc0oWGZFR1E71szqN8r6u2mImnWa
 /i1dRXQ6Cfg6CMnHYcW/TkTMMHSwRZgXy89Yn7cgUIYjx/hLY/aQxqWvye3+Qq48NNx2
 D9W4BY16RmYgrr1qCt5ITC8gp1Psul2ThOx3uZodg7VEEv+sZm0CGg6XnRUo/p1u+MNK
 wBZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB3c3hns8mNKv49kcXa8EgKQDMht/xAQMjF53d7B2/hYAMYEYB3BhqXOgjBiAi/JfPlEE+KCV3IJw+mJksBu2+ao+4mQ==
X-Gm-Message-State: AOJu0YxJIy33id+pAzukFbbtrwpgrUq5D1P2vK+dFvCreztq0xF9Cjzq
 ETX+Biw9AxPi7yFjNcCgdBR/NA9XqYxpqyA/AOuwjOslgeIqEQAl32uk+Ln+VNh3dBhVt4JvRx+
 qJ1eqIhCL/DgjthnkxrdGWJOJC3k6Kc5uuCzrng==
X-Google-Smtp-Source: AGHT+IHYgLO0QjGwTI3X/hwj/kFMeDPwJfWnQms61MIlVyXYH6JoPTcTLdjUcl766+vmW5j7WYyq+L5U7NYx7p2znlE=
X-Received: by 2002:a50:f696:0:b0:57d:669:cafb with SMTP id
 4fb4d7f45d1cf-57d4bde244cmr2165829a12.40.1719218259254; Mon, 24 Jun 2024
 01:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240602200836.3949773-1-avkrasnov@salutedevices.com>
 <20240602200836.3949773-2-avkrasnov@salutedevices.com>
 <bc2584a6-38ac-c396-a70f-7904dfcbae39@salutedevices.com>
In-Reply-To: <bc2584a6-38ac-c396-a70f-7904dfcbae39@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Mon, 24 Jun 2024 10:37:27 +0200
Message-ID: <CAOf5uwnmMmY5c0zj9Y1EOYxfFJ0mUy9Vvj9-7kZ0=Ry-uVrS_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] mtd: rawnand: nand_base: support for
 'NAND_IS_BOOT_MEDIUM' flag
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, kernel@sberdevices.ru, oxffffaa@gmail.com
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

Yes I have seen and I will review today and cross-check. Did you lunch
the testing on the other patches series? I would like to merge
at all but we were having some build breakage

Michael

On Mon, Jun 24, 2024 at 7:16=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
> Hi, sorry, pls ping :)
>
> Thanks
>
> On 02.06.2024 23:08, Arseniy Krasnov wrote:
> > Based on Linux kernel:
> > commit f922bd798bb9 ("mtd: rawnand: add an option to specify NAND chip =
as a boot device")
> >
> > Allow to define a NAND chip as a boot device. This can be helpful
> > for the selection of the ECC algorithm and strength in case the boot
> > ROM supports only a subset of controller provided options.
> >
> > Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> > ---
> >  drivers/mtd/nand/raw/nand_base.c | 3 +++
> >  include/linux/mtd/rawnand.h      | 6 ++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index c40a0f23d7..ed605b4af5 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -4458,6 +4458,9 @@ static int nand_dt_init(struct mtd_info *mtd, str=
uct nand_chip *chip, ofnode nod
> >       if (ret =3D=3D 16)
> >               chip->options |=3D NAND_BUSWIDTH_16;
> >
> > +     if (ofnode_read_bool(node, "nand-is-boot-medium"))
> > +             chip->options |=3D NAND_IS_BOOT_MEDIUM;
> > +
> >       if (ofnode_read_bool(node, "nand-on-flash-bbt"))
> >               chip->bbt_options |=3D NAND_BBT_USE_FLASH;
> >
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index fb002ae641..4eb880d8fb 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -218,6 +218,12 @@ enum nand_ecc_algo {
> >  /* Device needs 3rd row address cycle */
> >  #define NAND_ROW_ADDR_3              0x00004000
> >
> > +/*
> > + * Whether the NAND chip is a boot medium. Drivers might use this info=
rmation
> > + * to select ECC algorithms supported by the boot ROM or similar restr=
ictions.
> > + */
> > +#define NAND_IS_BOOT_MEDIUM  0x00400000
> > +
> >  /* Options valid for Samsung large page devices */
> >  #define NAND_SAMSUNG_LP_OPTIONS NAND_CACHEPRG
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
