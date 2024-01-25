Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72F0C47DDF
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 15:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5E587015;
	Thu, 25 Jan 2024 16:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LDAQ1vSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66D8B8753E; Thu, 25 Jan 2024 16:11:42 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BB5C86FC9
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 16:11:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so9069582a12.3
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 07:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706195500; x=1706800300; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jXrFXM0iFuHvt0wya5vpWiTfPGtef5N5mA6Wopfus1I=;
 b=LDAQ1vSaVJpj57QsiSdO0vlWkZ60OJBLA9pJ90riH8szdqJWGyqbgJ+4wskpV9W3Zu
 qNM2wEEjc0oUWgMyphLxkVW2ZLjTSbSJo9SSFPbvjEZ9MOycXIYmLeHnLetFNPrwUTOc
 0oekjlNk/+oREEtumQYXWsAYM2BRSMj57fgkvYLnws9o50BKky+dJWKaIZg6A+FQzr5r
 l/ZOaPS3RVeVbgR7mmOLor674WE1Xujzix/oLiyLvGLXmK14vGBNslPX0mweraIXOEY+
 tD4c+UMCd3yEceSbvceRDJ6JP1wG6ScopUOfMrV2dvAyPrjJ9Bt2rA0VXHD5D4x0VFnN
 Cm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706195500; x=1706800300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jXrFXM0iFuHvt0wya5vpWiTfPGtef5N5mA6Wopfus1I=;
 b=b3lHX23Rbe2Hgd35i/7vjy4Wks25hpg0FobuDSDQMPTqYN4HWhTK4slgjPHWDCRqMZ
 Ff6lI3yT9XwEVyfBmYm9puKyfchtbe69vPnPPgo3aYPL1J+dQWoM4/VOhS6dVJKW+EHB
 rCqN7K+0QDrTY/ooXvaa/4BKfAgeXuZjkxQEyTJs7caV2bImVCyLdDjfS45L20Z0jwTQ
 NSeINNdfdC+7WfqW5XYvraRcG+NI/cmLbwf0MVbktX8bRyRbA5YCmrZsvlmEtfdGyES6
 KC8LknlNnHn4CLMspCFoHd3d1AIwQckEA3gg0u5HbKmC5raNYq2xLxpXoD0xTf0MvfGw
 G4Vw==
X-Gm-Message-State: AOJu0YxuAERZ3iapGr9pdjV3PiHugKbFMofgKzhfTq7y449QsdVmr5XU
 5ecLaGDxCTWJlksxDwNo7fh6F57ysq6Fgu+oSZ0ycHZV77LbrIJv3lHKcvPvO6DV78oHWWSs3oQ
 4HmfUo2v8kODymY0Idk4bUgplXz0=
X-Google-Smtp-Source: AGHT+IEJSu9wnD66DUQQ8XTMSlHQJZNoGdga63Pri2oKiNlkXTi6JLWsyNCenXjuV6yyszhy1kfcNwjKQZeullZ8TjE=
X-Received: by 2002:aa7:d491:0:b0:55a:7385:e9d8 with SMTP id
 b17-20020aa7d491000000b0055a7385e9d8mr694583edr.27.1706195498762; Thu, 25 Jan
 2024 07:11:38 -0800 (PST)
MIME-Version: 1.0
References: <20240125140502.22400-1-o451686892@gmail.com>
 <20240125140502.22400-4-o451686892@gmail.com>
 <94019c2e-44bb-49d5-b1ce-beebb0085871@gmx.de>
In-Reply-To: <94019c2e-44bb-49d5-b1ce-beebb0085871@gmx.de>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 25 Jan 2024 23:11:27 +0800
Message-ID: <CAHk0HotuzT+ZYFrR74hK6aOqFKGrOhAyXt2YXxn-UGAa9V_V0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] cmd: rng: Add rng list command
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, u-boot@lists.denx.de, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Etienne Carriere <etienne.carriere@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>
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

On Thu, Jan 25, 2024 at 10:49=E2=80=AFPM Heinrich Schuchardt <xypron.glpk@g=
mx.de> wrote:
>
> On 25.01.24 15:05, Weizhao Ouyang wrote:
> > Add rng list command to list all probed RNG device.
>
> Thank you for your contribution.
>
> Would the following be more accurate?
>
> The 'rng list' command probes all RNG devices and list those devices
> that are successfully probed.

Yeah.

>
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   cmd/rng.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/cmd/rng.c b/cmd/rng.c
> > index 52f722c7af..4818133f94 100644
> > --- a/cmd/rng.c
> > +++ b/cmd/rng.c
> > @@ -18,6 +18,19 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, i=
nt argc, char *const argv[])
> >       int devnum;
> >       struct udevice *dev;
> >       int ret =3D CMD_RET_SUCCESS;
> > +     int idx;
>
> Please, put the definition into the code block where it is used.

Sorry I imported the draft code, will remove it in the next version.

>
> > +
> > +     if (argc =3D=3D 2 && !strcmp(argv[1], "list")) {
>
> int idx =3D 0;
>
> > +             uclass_foreach_dev_probe(UCLASS_RNG, dev) {
> > +                     printf("RNG #%d - %s\n", dev->seq_, dev->name);
>
> ++idx;
>
> > +             }
> > +
> > +             if (!idx) {
> > +                     printf("*** no RNG devices available ***\n");
>
> If idx is not initialized, depending on the random value of idx on the
> stack you get a printout or not, e.g.
>
> =3D> rng list
> RNG #0 - riscv_zkr
> RNG #1 - virtio-rng#8
> *** no RNG devices available ***
>
> Do we need the message to be so noisy? How about
>
> log_err("No RNG device\n");
>
>
> > +                     return CMD_RET_FAILURE;
> > +             }
>
> We prefer having an empty line before return statements.
>
> Best regards
>
> Heinrich
>
> > +             return CMD_RET_SUCCESS;
> > +     }
> >
> >       switch (argc) {
> >       case 1:
> > @@ -57,6 +70,8 @@ static int do_rng(struct cmd_tbl *cmdtp, int flag, in=
t argc, char *const argv[])
> >   }
> >
> >   U_BOOT_LONGHELP(rng,
> > +     "[list]\n"
> > +     "  - list all the probe rng device\n"
> >       "[dev [n]]\n"
> >       "  - print n random bytes(max 64) read from dev\n");
> >
>

BR,
Weizhao
