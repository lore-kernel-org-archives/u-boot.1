Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D023C4345F
	for <u-boot@archiver.kernel.org>; Sun, 14 Apr 2024 13:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D75448808B;
	Sun, 14 Apr 2024 15:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iDvY0M5J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 814CD880A7; Sun, 14 Apr 2024 15:45:36 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA3188052
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 15:45:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-618944792c3so14170097b3.1
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713102333; x=1713707133;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2NsIOlc3l1jGR17/pLqVU9r9SnNGkOt2xGPb9KamRo=;
 b=iDvY0M5JGTfdwvGEa8TdgZNxPIMStKz1QO+5ePjpmyvLr1jjrn1Zud3k63Tjqg96mm
 p5u+Nju262pwNnt7DLIVSaYRnt9tvWRHoleGqhSDlRehfJGLo2VpC6hHFG53UaAPC30D
 QJPjiBtubxAAJtR0tVqc5/BOLYipRWjOF1bxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713102333; x=1713707133;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2NsIOlc3l1jGR17/pLqVU9r9SnNGkOt2xGPb9KamRo=;
 b=lExNLaJABGduv83Kk8DadMHjVjJChRj1P2mBTvlRsEdCI9jLN2ZqTcn8+NYm0+FApu
 kqJGBCLYPim7BzW9Pzro8cpYe57LGzBqLBzBZkvpLWZQw842pFI8IFbnzg+KHmW8n44N
 dUnQq5yu+mpLy4lUgS1qKrsWlsociknYvNHfXwy6UacltgjXiNuTbLtid/mRSOGFbHtX
 cHxnFrnLsu/DvcWFMs+KdK864eExbvgW+GkL2pTzF8Za4QX55CuEIrgLymVQx9Vp1E+h
 AHlvqcT/TiAxh8W/IfGiwpF/U30Qfu3jjcrtXhwVwSG3rofnffPx/B21FXAv9AXJ3Qt9
 oMNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtSdMe63EQ6jbodBseq3d2aEeWlHOGP4xwkkvf+l9xvyjSZSoSbrCdMe0yAnWfbsQb25xH7+mqKt5AwS86D/QF591lUA==
X-Gm-Message-State: AOJu0YwMCDrPJhLEvSCpnCwSIJqzY8nk116nRllKtEUK6vW6kC/9OHXq
 Zan7pAgrtZCJJtDShSj9kPXEipCai+WOlql1uqZ+ATY0DdbtYeJPnFIdGAWCOo9QghYG8u4ZUdb
 RSf1uJ9GqCn4UKeLo8704YGE41lqCbdoW+bXwwS0FrFIO6jU2mGM=
X-Google-Smtp-Source: AGHT+IHZVHD3zQEb3prJYIMgMw4pMS/e9sShRG+peN6GJtJMo0ViDTNEPlyyaw3DAsbOez09Hq84KnDOWddaL8Z+Yxc=
X-Received: by 2002:a0d:d794:0:b0:609:ef57:2266 with SMTP id
 z142-20020a0dd794000000b00609ef572266mr7521761ywd.34.1713102333150; Sun, 14
 Apr 2024 06:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <59ba9347-ec51-4c81-b488-83c67035abd8@kwiboo.se>
In-Reply-To: <59ba9347-ec51-4c81-b488-83c67035abd8@kwiboo.se>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 14 Apr 2024 15:45:22 +0200
Message-ID: <CABGWkvqxejPGiwFkDNukS2Ud3_XDxmo+NjCUhE6rdrN52=h3Ag@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Weizhao Ouyang <o451686892@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Michal Simek <michal.simek@amd.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
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

Hi Weizhao,

On Fri, Mar 15, 2024 at 7:07=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi,
>
> On 2024-01-04 12:46, Weizhao Ouyang wrote:
> > Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> > crashes.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
>
> This fixes a null pointer dereference when running "sf probe" and there
> are no spi devices enabled in the device tree for my boards, so:
>
> Fixes: 3feea0ba196a ("spi: spi_flash_probe_bus_cs() rely on DT for spi sp=
eed and mode")
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
>
> Regards,
> Jonas
>
> > ---
> >  cmd/sf.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/cmd/sf.c b/cmd/sf.c
> > index 730996c02b..e3866899f6 100644
> > --- a/cmd/sf.c
> > +++ b/cmd/sf.c
> > @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *const=
 argv[])
> >       }
> >       flash =3D NULL;
> >       if (use_dt) {
> > -             spi_flash_probe_bus_cs(bus, cs, &new);
> > -             flash =3D dev_get_uclass_priv(new);
> > +             ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> > +             if (!ret)
> > +                     flash =3D dev_get_uclass_priv(new);
> >       } else {
> >               flash =3D spi_flash_probe(bus, cs, speed, mode);
> >       }
>

Applied to nand-next

Thanks and regards
Dario
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
