Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7498C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019118793B;
	Thu,  4 Jan 2024 13:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hcGFrQ91";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9261B8797C; Thu,  4 Jan 2024 13:43:32 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9521F87756
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so53262566b.1
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1704372210; x=1704977010;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+uboODLXxeMv3mfjoOvL1lektej5kNSNWvorczgfng=;
 b=hcGFrQ91uIW8XMvCEu09iYbb/WryHJjg8eqewgjfmiGEb4bOrKOaNSob5q3n+QzsCt
 JgoqaGPApRSaQB3x/Xsg1Mrzobt5rp2vCbiqTyCLpgx+uyH4rEtFdw+KdMC2ngupk4M4
 O+4FO97l5Rxg/kuXpKMm+O34QT9hJer9LTNao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704372210; x=1704977010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+uboODLXxeMv3mfjoOvL1lektej5kNSNWvorczgfng=;
 b=WPc6MiqHmPjQ0kyfl3+WD46jojpHX8Nq6+5vpEJHoucFDoZW66aT5vueNP73Mfi6cI
 LMivHXo00VSiY8SusmU8AWDwBTei+WXmIcrlLx0qRiTrIuZ9f9MXkwg72I0YVPRdnECo
 0C6Ssk3cwFHWPGBxWOTP9tC9jMZsj6KX4vBeqIegs3ILdOghIOR2soz3Ps1qBVtxa05r
 Rn/eAvxQ0GpyHvg5UqPpuaFiP/7HiUZDM0ikgniEkrRCBhcRNY1ELmqDpZDTp4LkVEuY
 VXITPB20UfEPKoH5lV1lZsRfFW4lVCaToMsphyV85ed21UQ8TsZ3xuMarlcqEkt8gRjJ
 7X6A==
X-Gm-Message-State: AOJu0YzM/xXXxFxLgzAwnknJ4axmdw/DfwcDnUrRGArzWZu8W42sm1Hb
 1ostg9jpzprIJYuM1uvBGuxSZ1VxWlCRSnB/ygEzLkazmn16PQ==
X-Google-Smtp-Source: AGHT+IHFDYW16i2Uf90OA+10saM65hcKus0j+S6ViCIsNRr8N7wIDAuo3J+xSK5jQLc9jnIJN62rSBCSC6V7w+PjhDc=
X-Received: by 2002:a17:906:4b4d:b0:a28:7485:711c with SMTP id
 j13-20020a1709064b4d00b00a287485711cmr309810ejv.96.1704372210016; Thu, 04 Jan
 2024 04:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
 <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
 <CAOf5uwkvZxAH_qRdZKV5OMD0oTyohRZ3yYS5mWhCzZ+QGtx=GA@mail.gmail.com>
 <CAHk0Hov05U0Xmn6ywdfbONZumNoPsc-j9HuONM7nGpYYr_do7g@mail.gmail.com>
In-Reply-To: <CAHk0Hov05U0Xmn6ywdfbONZumNoPsc-j9HuONM7nGpYYr_do7g@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 4 Jan 2024 13:43:18 +0100
Message-ID: <CAOf5uwm6V=Laj-D4u_7AYiX+1endHj6FZ5zrD+iVvwh7reVEtQ@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Weizhao Ouyang <o451686892@gmail.com>
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

Hi

On Thu, Jan 4, 2024 at 1:40=E2=80=AFPM Weizhao Ouyang <o451686892@gmail.com=
> wrote:
>
> On Thu, Jan 4, 2024 at 8:29=E2=80=AFPM Michael Nazzareno Trimarchi
> <michael@amarulasolutions.com> wrote:
> >
> > Hi
> >
> > On Thu, Jan 4, 2024 at 1:16=E2=80=AFPM Weizhao Ouyang <o451686892@gmail=
.com> wrote:
> > >
> > > On Thu, Jan 4, 2024 at 8:00=E2=80=AFPM Michal Simek <michal.simek@amd=
.com> wrote:
> > > >
> > > >
> > > >
> > > > On 1/4/24 12:46, Weizhao Ouyang wrote:
> > > > > Handle the return value of spi_flash_probe_bus_cs() to avoid sf p=
robe
> > > > > crashes.
> > > > >
> > > > > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > > > > ---
> > > > >   cmd/sf.c | 5 +++--
> > > > >   1 file changed, 3 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/cmd/sf.c b/cmd/sf.c
> > > > > index 730996c02b..e3866899f6 100644
> > > > > --- a/cmd/sf.c
> > > > > +++ b/cmd/sf.c
> > > > > @@ -135,8 +135,9 @@ static int do_spi_flash_probe(int argc, char =
*const argv[])
> > > > >       }
> > > > >       flash =3D NULL;
> > > > >       if (use_dt) {
> > > > > -             spi_flash_probe_bus_cs(bus, cs, &new);
> > > > > -             flash =3D dev_get_uclass_priv(new);
> > > > > +             ret =3D spi_flash_probe_bus_cs(bus, cs, &new);
> > > >
> > > > if (ret)
> > > >         return ret;
> > > >
> > > > don't you want to rather propagate that error?
> > > >
> > >
> > > Well, since the spi_flash is empty, the following code will
> > > print the error message and return.
> > >
> >
> > flash =3D NULL;
> >
> >   if (!flash) {
> >                 printf("Failed to initialize SPI flash at %u:%u (error =
%d)\n",
> >                        bus, cs, ret);
> >                 return 1;
> >   }
> >
> > This code does not change error handling that is already present here.
>
> Hi Michael,
>
> Sorry I didn't get your point. This patch is designed to avoid
> spi_flash_probe_bus_cs() crash by null pointer, and let the
> current existing error handling to prompt it. So I'm not
> trying to change the current error handling.
>

I have said exactly the same so I agree with you.

Michael

> BR,
> Weizhao
>
> > Michael
> >
> > > BR,
> > > Weizhao
> >
> >
> >
> > --
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com



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
