Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6F4C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C2188B67;
	Thu,  1 Aug 2024 16:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J3AnJanJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EE2D88B36; Thu,  1 Aug 2024 16:42:42 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED79688B63
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70968db52d0so1386443a34.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523359; x=1723128159; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zYG3ivsFnQ7hhCX9FyhinV+Va97uHnNo7qzFZnNPOz0=;
 b=J3AnJanJZqqQnByc3Xj8YpwbhGM4Tel7GAurgk9kYX4IdydHYiYCHMD7YkU3Ll+6zZ
 oEcX8qWbuhGktgukwbxN1hB3B1YRap2QibWlMpR2tRlH2VgO4OmDBMp6L+fWxSKwXcJl
 1fWNabBCVJnCeqNAJnZsTNvREIfCplJGA8Yuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523359; x=1723128159;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zYG3ivsFnQ7hhCX9FyhinV+Va97uHnNo7qzFZnNPOz0=;
 b=d87gImf2fmc9gUgk2g2ryotwRTFx0TAhRIVVkTQjiieIYzJucYSQamncZFNv5GtdjP
 w3qGvtvlsyMDxGX/Ox5UZDePkHEw29P4vDzoS4aFIzXDszQxvFfJerFIcuZ0aAONJ+WM
 agCTbAhxIfpjwzIqnG+LpDBKa681l07w7qr+tj7ZrADOzLSs/Ugz93bBH46/cRcB/atf
 gdqjfEeHL/xkMcrqTshADlTShCMbN+4pXD9QLTHnBo5LtssVdemllq7EwavOyNDTZpXY
 wVjekk4n/v+u0D7cHMu/5f08pm34UhDz6appBsLzguj6LgvuhDUAzbQ9BvaiPLahU4Lk
 5bCA==
X-Gm-Message-State: AOJu0YzHLewcwAM57kOTr3XNsCUmdYT7M3tYL3hPFyTWDSn9W5UUxkFW
 9TL1avslWUwV32YpgYOEyLDCWb5rOX5ibiz9FndkHfUn+CxgjnuaS/W0+oi/IjYHZard6r4z648
 ICpBTHKyC+LXQ3UivooRP8rTN9ob/zrJI7jYP
X-Google-Smtp-Source: AGHT+IEwkL4LG4L/NbEGLdOC/FZU4fitYFAHwhvb4FwXxhzJZ64Rr6B/XCAJFu7MNOFrJN4JREFKizY5PtOzlmV06ZE=
X-Received: by 2002:a05:6358:42a1:b0:1a6:72b8:d08f with SMTP id
 e5c5f4694b2df-1af3bb29a12mr28645655d.29.1722523358621; Thu, 01 Aug 2024
 07:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-11-Zhiqiang.Hou@nxp.com>
 <CAFLszTgzXzUym-JBNk8i+50TsN81vU=Nhs_GMzvR+jmYaqMPsQ@mail.gmail.com>
 <DB9PR04MB9236CF945D9E444C5808FC2F84B22@DB9PR04MB9236.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB9236CF945D9E444C5808FC2F84B22@DB9PR04MB9236.eurprd04.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:28 -0600
Message-ID: <CAFLszTg7casCckSwQuC0VqYYaDvyOwnzQRUu6tTLESKGvhS+Zg@mail.gmail.com>
Subject: Re: [PATCHv4 10/14] cmd: cpu: add release subcommand
To: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "marex@denx.de" <marex@denx.de>, 
 "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
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

Hi Zhiqiang,

On Wed, 31 Jul 2024 at 20:37, Z.Q. Hou <zhiqiang.hou@nxp.com> wrote:
>
> Hi Simon,
>
> > -----Original Message-----
> > From: Simon Glass <sjg@chromium.org>
> > Sent: Wednesday, July 31, 2024 10:39 PM
> > To: Z.Q. Hou <zhiqiang.hou@nxp.com>
> > Cc: u-boot@lists.denx.de; trini@konsulko.com; Peng Fan
> > <peng.fan@nxp.com>; festevam@gmail.com; marex@denx.de;
> > lukma@denx.de; seanga2@gmail.com; xypron.glpk@gmx.de
> > Subject: Re: [PATCHv4 10/14] cmd: cpu: add release subcommand
> >
> > Hi Zhiqiang,
> >
> > On Tue, 30 Jul 2024 at 01:09, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote=
:
> > >
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > Add a new subcommand 'release' to bring up a core to run baremetal an=
d
> > > RTOS applications.
> > >
> > > For example on i.MX8M Plus EVK, release the LAST core to run a RTOS
> > > application, passing the sequence number of the CPU core to release,
> > > here it is 3:
> > >     u-boot=3D> cpu list
> > >       0: cpu@0      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> > >       1: cpu@1      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 30C
> > >       2: cpu@2      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> > >       3: cpu@3      NXP i.MX8MP Rev1.1 A53 at 1200 MHz at 31C
> > >
> > >     u-boot=3D> load mmc 1:2 c0000000 /hello_world.bin
> > >     66008 bytes read in 5 ms (12.6 MiB/s)
> > >     u-boot=3D> dcache flush; icache flush
> > >     u-boot=3D> cpu release 3 c0000000
> > >     Released CPU core (mpidr: 0x3) to address 0xc0000000
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > ---
> > > V4:
> > >  - Updated the change logs.
> > >
> > >  cmd/cpu.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 42 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/cmd/cpu.c b/cmd/cpu.c
> > > index 9e323069b9..2755250756 100644
> > > --- a/cmd/cpu.c
> > > +++ b/cmd/cpu.c
> > > @@ -3,6 +3,7 @@
> > >   * Copyright (c) 2015 Google, Inc
> > >   * Written by Simon Glass <sjg@chromium.org>
> > >   * Copyright (c) 2017 =C3=81lvaro Fern=C3=A1ndez Rojas <noltari@gmai=
l.com>
> > > + * Copyright 2024 NXP
> > >   */
> > >
> > >  #include <command.h>
> > > @@ -18,6 +19,19 @@ static const char
> > *cpu_feature_name[CPU_FEAT_COUNT] =3D {
> > >         "Device ID",
> > >  };
> > >
> > > +static struct udevice *cpu_find_device(unsigned long cpu_id) {
> > > +       struct udevice *dev;
> > > +
> > > +       for (uclass_first_device(UCLASS_CPU, &dev); dev;
> > > +            uclass_next_device(&dev)) {
> > > +               if (cpu_id =3D=3D dev_seq(dev))
> > > +                       return dev;
> > > +       }
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  static int print_cpu_list(bool detail)  {
> > >         struct udevice *dev;
> > > @@ -82,10 +96,36 @@ static int do_cpu_detail(struct cmd_tbl *cmdtp, i=
nt
> > flag, int argc,
> > >         return 0;
> > >  }
> > >
> > > +static int do_cpu_release(struct cmd_tbl *cmdtp, int flag, int argc,
> > > +                         char *const argv[]) {
> > > +       struct udevice *dev;
> > > +       unsigned long cpu_id;
> > > +       unsigned long long boot_addr;
> > > +
> > > +       if (argc !=3D 3)
> > > +               return CMD_RET_USAGE;
> > > +
> > > +       cpu_id =3D dectoul(argv[1], NULL);
> >
> > I just noticed this...normally we use hex for parameters.
>
> Yes, but the <core ID> is from the CPU device sequence number listed by t=
he 'cpu list', which is printed in dec. So I think use dec parameter here i=
s reasonable.

We will have devices with hundreds of CPUs so decimal is probably
going to bite us. U-Boot uses hex for most values.

Anyway, let's worry about it later. What you have is fine.

Regards,
Simon
