Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A11E77188
	for <u-boot@archiver.kernel.org>; Tue, 24 Dec 2024 13:56:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1147380786;
	Tue, 24 Dec 2024 14:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SfVOZ8fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2275D807A7; Tue, 24 Dec 2024 14:56:21 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7696580711
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 14:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so5487898a91.3
 for <u-boot@lists.denx.de>; Tue, 24 Dec 2024 05:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1735048577; x=1735653377;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfbfivRxVkzrTJotmsXRReXiVYHwDjMnDH2ADEzFvLE=;
 b=SfVOZ8fkROVJXh+B6McKUzbtnBjcKf3jvEYONPwOw7Wq9D/906NJCdJnS8ZnCJdk2Q
 nRGkY3kOrghwxis73yq5AaiZSNi3U2g9uCELZEaR8ORj3AwjXUvxuN1JhSvGbdMnk3y4
 SCj9RaXyXMZpngTcEsymiXX9lpaeQ4ZoP34Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735048577; x=1735653377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfbfivRxVkzrTJotmsXRReXiVYHwDjMnDH2ADEzFvLE=;
 b=lAnFgn7RnElOPaFGA0FAe3d99VPH72evcTmBlrUK3rWMJWiTjV0ag18q8hs8HuhAbl
 HSMH95BHnHqmu3XmOpOd3/4JFCfSK96Xf+KCUBA08L3zrvhvPCqzCSC9dGJ44TeVENIQ
 HoaK73whOnX8cVIxC9ND/j82wWeBAJ7MoJn97ByDhNUbqkbkHhbaOd7Mvd5GSsYQw3aa
 iKGePQG7oW4unsgfzoCQWrRdJoyHkei9vPU1ZG0pE8amZC0g+rO7o0/BlCzCTGRYYUej
 rc6AUf/73LDbLwuQY6OGbyS3n7u9gJOBW9KAorLQvXJFWVJHNLbxr8DvrsQM/bXvIxG3
 eXyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXi+PnmNcIqv2JCQ2/s1NHj+nozNGVpqu58TGJ9UjmwoX+NnAvPYoFtacJKvTIe9oUM+8dAF5k=@lists.denx.de
X-Gm-Message-State: AOJu0YweJH7s0BxzzGwFNcF+lDupBdzoQ+N/e+Mwnvh3vE9Q8eUoWt+H
 lYi8IgzYt+4s9vE6Xs/ocyJ+9kKobRsPtz2D5pwkLuoUUGNmk1bhojSfiGwaxbPmWzbYsCsLF7p
 t6u4+D3nc0dNjmY8Oj0tVXfZH8nJpYbA3Gh9pIw==
X-Gm-Gg: ASbGncug+fXSPx7SuyR7LGlz3PFjvBFy7BvUOX0HI79nnoWCr3kS70Iq87uGCOxQgyi
 KyNhEaDLFOGg/jOHzohhg1kWKeoqYDsX6wuY=
X-Google-Smtp-Source: AGHT+IG24bkZ58YNXR3Odzwd7Uoo4zz5PFP6eQAprmQW59EKFqIFJY0AgFigy2F0BfKZPK7z4of3h2f8JtiiKOEotOU=
X-Received: by 2002:a17:90a:d448:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2f452edbd0fmr25330025a91.33.1735048576863; Tue, 24 Dec 2024
 05:56:16 -0800 (PST)
MIME-Version: 1.0
References: <d087411f-c2fd-75a8-6041-31623aba53ae@salutedevices.com>
 <CAOf5uwmb6W1BjCsc437_aFnO0fjVHrr-mU0r8ZGK_jpwn-75Kg@mail.gmail.com>
 <983f63fb-e61c-3aaf-9969-eef1ca3f23c9@salutedevices.com>
In-Reply-To: <983f63fb-e61c-3aaf-9969-eef1ca3f23c9@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 24 Dec 2024 14:56:04 +0100
Message-ID: <CAOf5uwn7OAhkhxbjcFYkHdmxy4R_VsqSb7ertn09zPcGpPgQrQ@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: rawnand: meson: always use OOB bytes during write
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, kernel@salutedevices.com, 
 oxffffaa@gmail.com
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

Yes

Michael

On Tue, Dec 24, 2024 at 8:55=E2=80=AFAM Arseniy Krasnov
<avkrasnov@salutedevices.com> wrote:
>
>
>
> On 23.12.2024 15:57, Michael Nazzareno Trimarchi wrote:
> > On Sun, Dec 22, 2024 at 10:23=E2=80=AFPM Arseniy Krasnov
> > <avkrasnov@salutedevices.com> wrote:
> >>
> >> If 'oob_required' is not set by the caller (for example 'oobbuf' is NU=
LL),
> >> then driver doesn't copy OOB data from 'oob_poi' to special controller
> >> structures, so zeroes will be written as OOB. But, generic raw NAND lo=
gic
> >> in 'nand_base.c' already handles case when OOB is not required to writ=
e by
> >> filling 'oob_poi' with 0xFF's. So let's remove 'oob_required' check to
> >> always read 'oob_poi' data for OOB.
> >>
> >> Kernel driver (drivers/mtd/nand/raw/meson_nand.c) works in the same wa=
y,
> >> so need to keep same behaviour here.
> >>
> >> Fixes: c2e8c4d09a7a ("mtd: rawnand: Meson NAND controller support")
> >> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> >> ---
> >>  drivers/mtd/nand/raw/meson_nand.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/=
meson_nand.c
> >> index 81122315f4..82a12ac061 100644
> >> --- a/drivers/mtd/nand/raw/meson_nand.c
> >> +++ b/drivers/mtd/nand/raw/meson_nand.c
> >> @@ -607,9 +607,7 @@ static int meson_nfc_write_page_hwecc(struct mtd_i=
nfo *mtd, struct nand_chip *ch
> >>                 memcpy(meson_chip->data_buf, buf, mtd->writesize);
> >>
> >>         memset(meson_chip->info_buf, 0, chip->ecc.steps * PER_INFO_BYT=
E);
> >> -
> >> -       if (oob_required)
> >> -               meson_nfc_set_user_byte(chip, chip->oob_poi);
> >> +       meson_nfc_set_user_byte(chip, chip->oob_poi);
> >>
> >
> > Reviewed-by: Michael Trimarchi <michael@amarulasolutions.com>
> >
> > I will queue it
>
> Thanks. You mean it will be merged to https://source.denx.de/u-boot/custo=
dians/u-boot-nand-flash ?
>
>
> >
> >>         return meson_nfc_write_page_sub(chip, page, false);
> >>  }
> >> --
> >> 2.30.1
> >
> >
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
