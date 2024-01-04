Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE29C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:16:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3909A87933;
	Thu,  4 Jan 2024 13:16:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I2fcjpfi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F8A8793B; Thu,  4 Jan 2024 13:16:10 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 977BC876EA
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50eabfac2b7so448519e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704370568; x=1704975368; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frBD4HOGsLR6VE34kxbJU1OKT8zNOTN4luj01hICfY8=;
 b=I2fcjpfiJdEWIDArOwLMGRZjciFIbNR3gFTetn7AsmUDX/WMWfomzV3OsSEqTVK9Cd
 0aQe6wY4BPpZz6Tw8bwXDxPIyI6wK/IavTWuaGT25M6mEaQlcXEuw1dthFoo0gC64Zza
 9525wd3ehW6xdD9MGYjs8xEZZTfETs1vYMD9j4t977DEK3+/YF0kVw9NYAL1+sIZ8sKw
 Iu2VZU3iYWLFbAWoIMg4QGZ2ceH7R+VMrDV+/uL38//j04kfYeye02pdQLt8lpG9ds2w
 i888v6IBz6QD2AcQZNCWxfgd9KskXSia9qG+quGgyl2pmCjAXqMtW65pRP7xz8XwzJ4b
 3UKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704370568; x=1704975368;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=frBD4HOGsLR6VE34kxbJU1OKT8zNOTN4luj01hICfY8=;
 b=loHrzinDxEHjq5ynBtkg5BjQwR4V9nLSOfKYiScfQWaqmfmudOF+zHPhGbQbU+T1D3
 ni4qjruuhxqtctyvjf6eewdpVpMhywuPxyV9iIdvCkQBf6wIobGPuEwCkhZ3JurL9z7O
 0DNtfXdsNxBlBD6Vy+kYUZN8BwJsCz5xY+k/05btZ6Fm+58l7H+OofGA9fYv0yuOcA/c
 tZqRo6sd2CaHXdKEaPS09lRUNEfu/x2D7pJ01Lut9CnlFslYEXju7t6plckXZNjaiQv/
 CgW3sXNDtET4UCAnbTLxRFZKo2Lv6y6kYBA1s26T10N1FrFpu6aGPvq8GuP48lvKzCJk
 C/4g==
X-Gm-Message-State: AOJu0YweI6c9aGZGQu6vpoZ6nibqPUzDFnncbfaf83JBadRxiXYb2Yg4
 QYKcKnXSVG35X4C2T1vRuQfgx27WpySFemEfWoo=
X-Google-Smtp-Source: AGHT+IFlSJlupTO3AxXnszDDLZmHf0XYqEY/q0UpJnkqWwjmoX3XxOjxOI5vt5L678stNWT5hkyrqOGrErlW/x/lERk=
X-Received: by 2002:a05:6512:98b:b0:50e:70d8:249b with SMTP id
 w11-20020a056512098b00b0050e70d8249bmr283442lft.130.1704370566987; Thu, 04
 Jan 2024 04:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20240104114619.280513-1-o451686892@gmail.com>
 <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
In-Reply-To: <45cc3cf3-4120-460d-b275-fc019156ce20@amd.com>
From: Weizhao Ouyang <o451686892@gmail.com>
Date: Thu, 4 Jan 2024 20:15:55 +0800
Message-ID: <CAHk0HosXQ8iU0G3tZcQUf44FPdSzGOh7X9mH85Ja6nCEe46drA@mail.gmail.com>
Subject: Re: [PATCH] cmd: sf: Fix sf probe crash
To: Michal Simek <michal.simek@amd.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
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

On Thu, Jan 4, 2024 at 8:00=E2=80=AFPM Michal Simek <michal.simek@amd.com> =
wrote:
>
>
>
> On 1/4/24 12:46, Weizhao Ouyang wrote:
> > Handle the return value of spi_flash_probe_bus_cs() to avoid sf probe
> > crashes.
> >
> > Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
> > ---
> >   cmd/sf.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
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
>
> if (ret)
>         return ret;
>
> don't you want to rather propagate that error?
>

Well, since the spi_flash is empty, the following code will
print the error message and return.

BR,
Weizhao
