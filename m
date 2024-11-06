Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECDFD59F50
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 16:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D43891D2;
	Wed,  6 Nov 2024 17:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BhrzWgUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A6988F92; Wed,  6 Nov 2024 17:11:05 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50FF891D2
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 17:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99eb8b607aso902668766b.2
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 08:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730909458; x=1731514258; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eu5E42xuBa2g4RsMh05pISjBBd6t2TEkK4oOJFuRcCw=;
 b=BhrzWgUVehKurPVv8Z9jCnvFb+7wsVjniPuuYQg9jHQBhvJ5rXHx2bHSYU7tTv4rVa
 Uuj2A/P30/AzEQuIP0JDWnwMYMNUQlGx246oWjLhP7HGl43+2FD722+CwRVX6JHocy3z
 dhnACdxo7GRU/c6yLzi4fVNfjN9KSTw1EbhCddzQTA46ukJi3TJ321b8LI7H8gfJTZmF
 dy8TJON1NJrZjL47hofExCWf/+64iPzBWgnE0BoSQBXZXlcGD2AjY40n7AKENG7amaTW
 3+u0YzuAEzOuxPdwwakV/MfrpF4ddloSgNfw7Nx3P6OBIaIigl5sfcM+At5ebYaumvIa
 6bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730909458; x=1731514258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eu5E42xuBa2g4RsMh05pISjBBd6t2TEkK4oOJFuRcCw=;
 b=kMElIojP2OjwW5I/NiQgirZoRhAFSpck0ZnqjTgIPxdu1i5POMRsmlHBjFWM4thPpY
 3j+xlENYD/zXFe4l4AGyUUmNf9epiY5w4ewuAunhRKrPbiJK6rl0mbjr285qh4X3m80b
 sikVwOllWqUyBnV34ZoQV5D5wQBVOzPmqDycHJb970YAjJjdGHLW9mGbiwfvxhduB9ak
 MbnPTsm0k9rnUxCCXX1pYYJzQoZNHmxMvs6Ir++l7fpnbl9FCReFxwkjBFkJZFDg0waH
 u9NTkEJmZwVaXmT4mdNs/WDzXRU4aJsLvV3QWs6gJcpk2yKiPwWUzEKwfQBqWLFv2y+A
 XZog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT8FEj4s0LuSZqq9H6RRd9qOUN+SOW275fKngLHpyvwLU2ghSek2EIuFkNZHN8hXvnvqgB3dM=@lists.denx.de
X-Gm-Message-State: AOJu0YzkT12H4RAynr9NnMpddhQ2GYkCAK/fhmXGxAny68FSKhqt1/1u
 dgRfELTCyLacMjnP/LbFSya3+i8Nzq57HEjSBS5vZb5vRkChx4HEk3+y156x6rz90vwSLl349nY
 sVRDKdUtXt5lWm/Dp4FGmB/o+AJE=
X-Google-Smtp-Source: AGHT+IG3wkLxLxHFaXZ4ORJSLOaziyqmKsSZxXJSyiEkQNF+dTAAWy8LVDtzClDORaT2db+H+OEIWb9REShJfW1WXYM=
X-Received: by 2002:a17:907:728d:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a9de5d6e1f2mr4503656666b.11.1730909458115; Wed, 06 Nov 2024
 08:10:58 -0800 (PST)
MIME-Version: 1.0
References: <20241101103501.21432-1-bigunclemax@gmail.com>
 <20241101103501.21432-4-bigunclemax@gmail.com>
 <r2umutw5zvze6xyvxe43bcd3dly6ckhvd3anjp3ucbmymnla26@6phsgsuabhwq>
In-Reply-To: <r2umutw5zvze6xyvxe43bcd3dly6ckhvd3anjp3ucbmymnla26@6phsgsuabhwq>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Wed, 6 Nov 2024 19:10:47 +0300
Message-ID: <CALHCpMhhWGALSCp_6NN_Sr1Fv7oFZCdYc=K5MmZJ=JX7H7gKcw@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] usb: tcpm: fix toggling in host (SRC) mode
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wang Jie <dave.wang@rock-chips.com>, u-boot@lists.denx.de
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

Hi,

=D0=BF=D1=82, 1 =D0=BD=D0=BE=D1=8F=D0=B1. 2024=E2=80=AF=D0=B3. =D0=B2 21:32=
, Sebastian Reichel
<sebastian.reichel@collabora.com>:
>
> Hi,
>
> On Fri, Nov 01, 2024 at 01:34:52PM +0300, bigunclemax@gmail.com wrote:
> > From: Maksim Kiselev <bigunclemax@gmail.com>
> >
> > PU\PD resistors on CC lines must be configured before running the TCPM
> > state machine.
> >
> > Also, when the Type-C port acts as a host (SRC), the VBUS sould be enab=
led
> > only after the toggling has been completed. And we have to wait for
> > the corresponding IRQ to finish the toggling process. But this doesn't
> > happen because we exit from tcpm_poll_event() if VBUS !=3D OK.
> >
> > So, Let's check for VBUS state only when the port acts as a host (SRC)
> > to solve this problem.
> >
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
>
> I will look into this patch next week and give it a try on the Rock
> 5B. As a first feedback the commit message seems to confuse data and
> power roles. SRC (source) and SNK (sink) are for the power direction
> while "host" and "device" are used for the data direction. With
> USB-PD these are independent from each other.

Yes, you're right. I'll drop a host mention from the commit message in
the next version.
This patch is for the case when our board acts as a source (SRC).

Best wishes,
Maksim

> You seem to have the
> old USB model in mind where e.g. a USB keyboard ("device") gets
> power from the PC ("host"). But USB-PD allows setups like a USB-C
> hub ("device") having its own power-supply and providing a laptop
> ("host") with power.
>
> Greetings,
>
> -- Sebastian
>
> >  drivers/usb/tcpm/tcpm.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/tcpm/tcpm.c b/drivers/usb/tcpm/tcpm.c
> > index 0aee57cb2f4..c9f8dbdc795 100644
> > --- a/drivers/usb/tcpm/tcpm.c
> > +++ b/drivers/usb/tcpm/tcpm.c
> > @@ -2122,6 +2122,12 @@ static void tcpm_init(struct udevice *dev)
> >       else
> >               port->vbus_vsafe0v =3D true;
> >
> > +     if (port->self_powered)
> > +             tcpm_set_cc(dev, TYPEC_CC_OPEN);
> > +     else
> > +             tcpm_set_cc(dev, tcpm_default_state(port) =3D=3D SNK_UNAT=
TACHED ?
> > +                             TYPEC_CC_RD : tcpm_rp_cc(port));
> > +
> >       tcpm_set_state(dev, tcpm_default_state(port), 0);
> >
> >       if (drvops->get_cc(dev, &cc1, &cc2) =3D=3D 0)
> > @@ -2234,7 +2240,7 @@ static void tcpm_poll_event(struct udevice *dev)
> >       const struct dm_tcpm_ops *drvops =3D dev_get_driver_ops(dev);
> >       struct tcpm_port *port =3D dev_get_uclass_plat(dev);
> >
> > -     if (!drvops->get_vbus(dev))
> > +     if (!drvops->get_vbus(dev) && (tcpm_default_state(port) =3D=3D SN=
K_UNATTACHED))
> >               return;
> >
> >       while (port->poll_event_cnt < TCPM_POLL_EVENT_TIME_OUT) {
> > --
> > 2.45.2
> >
