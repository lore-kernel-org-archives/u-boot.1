Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C63BC47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:40:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769A28793B;
	Thu,  4 Jan 2024 13:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XvDZ9BvO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9341F87979; Thu,  4 Jan 2024 13:40:49 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C99B87756
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:40:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5534dcfdd61so772759a12.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704372047; x=1704976847; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ztxEfbFunTKbk5UZIc68u5Rkjf+1oIrbd6Gv4bSENY=;
 b=XvDZ9BvOVU3JgTA10xQ9FQOCXU7DzsTsX7C8PVi1+S7vYdMjpMpJwcy8wp5rEXBcOI
 rehs/iiMAdOsaL9XlAX4FS0xCXgyo67s311HJD21JJfZDtIzfG6FeYaOFFWrMxwGpW5N
 gQn0SID5uWchop5DKcCeHFSoXs5TLw/lgaVvhFnvz2A4EUN2enD10RtlF4el8uxgBxg+
 3vxkXJwZNiLu8VlZ/faJxxuGWi1RzD8cNTdTam4SoyhCS2tZCOWUVn5ujufhF5ZJHCpf
 97diucmkA9VSTYRmbgEWp6KcDtnjj7BzC56+Z9V4GkX/4XW9qtppNbjxRz9b/dySZfw5
 Mt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704372047; x=1704976847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ztxEfbFunTKbk5UZIc68u5Rkjf+1oIrbd6Gv4bSENY=;
 b=FxVLNFqGNyhcCXkv23FGSAF6aDrP7k11sjGhQsiwQJYmncwldqNceF6YyQ1kPfKx4G
 dCsN8BP8DIiZxgARcynBAgLNZQigo/VHuLKJI0+avR+W4UZ1qpjpl47OoOZZh8+/ZdNd
 +J8jaBmcuWFkBVoQxt6P5xo56NeAVahUaYJoLM73lAOwiIsT558QcTao9CR9grKiIPfH
 bkaYXilk6OvN7ry9pFA22lliA6MYhdFEsZLA74GgMO1ivZU/t3wSrQZbqQi41P2FZQGg
 I9nJ7UbKxTQU9HFyec5NJz/mVvEadY4GT+WEcLrpf2yCI8ibTcsH86VIv+6+bqghY9Kb
 4HTw==
X-Gm-Message-State: AOJu0YySi+nH46oBKTvIwzZP/KZGLZmsU5599LPU3IA3z/nr+Yeum4aH
 mOmvHt5E9eL1jiMNCl0YH19cYJCxbXi7oEpHQ4s=
X-Google-Smtp-Source: AGHT+IHgulVS1aX775gH6hcWDk+AQVxgxpfLSgyN9Ndy3q2HdeYOaVKNGXyhn5jWz1HzBBUYuWMQAsUD/lkslG7vwPY=
X-Received: by 2002:aa7:c44c:0:b0:556:528d:7739 with SMTP id
 n12-20020aa7c44c000000b00556528d7739mr537611edr.15.1704372046145; Thu, 04 Jan
 2024 04:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
 <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
 <CAOf5uwkvZxAH_qRdZKV5OMD0oTyohRZ3yYS5mWhCzZ+QGtx=GA@mail.gmail.com>
In-Reply-To: <CAOf5uwkvZxAH_qRdZKV5OMD0oTyohRZ3yYS5mWhCzZ+QGtx=GA@mail.gmail.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 4 Jan 2024 20:40:34 +0800
Message-ID: <CAHk0Hov05U0Xmn6ywdfbONZumNoPsc-j9HuONM7nGpYYr_do7g@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
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

On Thu, Jan 4, 2024 at 8:29=E2=80=AFPM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Thu, Jan 4, 2024 at 1:16=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.c=
om> wrote:
> >
> > On Thu, Jan 4, 2024 at 8:00=E2=80=AFPM Michal Simek <michal.simek@amd.c=
om> wrote:
> > >
> > >
> > >
> > > On 1/4/24 12:46, Weizhao Ouyang wrote:
> > > > Handle the return value of spi_flash_probe_bus_cs() to avoid sf pro=
be
> > > > crashes.
> > > >
> > > > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > > > ---
> > > >   cmd/sf.c | 5 +++--
> > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/cmd/sf.c b/cmd/sf.c
> > > > index 730996c02b..e3866899f6 100644
> > > > --- a/cmd/sf.c
> > > > +++ b/cmd/sf.c
> > > > @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char *c=
onst argv[])
> > > >       }
> > > >       flash =3D NULL;
> > > >       if (use_dt) {
> > > > -             spi_flash_probe_bus_cs(bus, cs, &new);
> > > > -             flash =3D dev_get_uclass_priv(new);
> > > > +             ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> > >
> > > if (ret)
> > >         return ret;
> > >
> > > don't you want to rather propagate that error?
> > >
> >
> > Well, since the spi_flash is empty, the following code will
> > print the error message and return.
> >
>
> flash =3D NULL;
>
>   if (!flash) {
>                 printf("Failed to initialize SPI flash at %u:%u (error %d=
)\n",
>                        bus, cs, ret);
>                 return 1;
>   }
>
> This code does not change error handling that is already present here.

Hi Michael,

Sorry I didn't get your point. This patch is designed to avoid
spi_flash_probe_bus_cs() crash by null pointer, and let the
current existing error handling to prompt it. So I'm not
trying to change the current error handling.

BR,
Weizhao

> Michael
>
> > BR,
> > Weizhao
>
>
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
