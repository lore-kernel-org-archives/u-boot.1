Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560F3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 06:32:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A93FA87CFC;
	Mon, 15 Apr 2024 08:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kCh3MJ4v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C25AF8787C; Mon, 15 Apr 2024 08:32:44 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 367E688159
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 08:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-61587aa9f4cso28485087b3.3
 for <u-boot@lists.denx.de>; Sun, 14 Apr 2024 23:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1713162761; x=1713767561;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQ9KipRTV4JH2tP3ZnBT+h01d4bWOWnH2bfExMc4dmo=;
 b=kCh3MJ4vHM0zDnoRpIUrTYRmGY9nI0BKufl1Lp/UXTCuUmI+b8uOu4ICtwyl83wTUe
 t3gDx7FYbc4oFJh5cazrTYbH90zfRNUGEOJWgLWVp9PhavojyuA1JZiD1yAEI4z9af6T
 k3d+YiyCNvqXlrSrX7v0Jx0NvHHv/4m9Bo5as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713162761; x=1713767561;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQ9KipRTV4JH2tP3ZnBT+h01d4bWOWnH2bfExMc4dmo=;
 b=QeCIZ4wEzc64c92L1yExt8h9xz2ZeEGSucFFvgKhYLdLcR6HwSTj4pDRP6wcYTxssA
 poOJbaUkQpImaWOTrsSagVz6DdmHWE651+I4bYzaImwm5RaPEHW08NsZIxjwaG5Gi4Is
 3pi2sPfyH8ZiSTmttxlSyc9raWMaya5XjSLrj17DpcBdvYkiXZ0sBERu5n1CkdWhwAkZ
 B3nWyLRq0lxLKmQMfXKi96Lst8KbYTlqR0X09IdHBMdgt8x7xU8vZizGlSl3DNY4EW/D
 DzUaF2apYpCOlB6VAciMF/WOgxOSI3dzHfUvyFavIgdnRGPBmWeppijlG96SKUiWMx0/
 QS5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuAmiKc4qJnP/5xREjhwsM4UKTeQDhatK5buLgLXKHR2RPwcgYRWCcEClDf5edexN5gC1sVU91RAwsxL7IzRdjQ7OtxA==
X-Gm-Message-State: AOJu0YwH4TiNZ3LWCtG0mghisNihD46emVhM75lRF+9nvzPr1T71d0Jd
 zAFAsiPJra0r3xIHq3+TQPiORlUSIa4PDM/RXwL9PTHmuuL26shWOi9TTx+r40aPq0iW5zxC7QU
 bnDRQo1W4c+Is5wXxUZKnDNclzBIV1AyeNlJt7A==
X-Google-Smtp-Source: AGHT+IGfwlYg/T60PWwmPI6TavBwh4nccUGXFBasgF8RXsZGsYWfWJaf/6m7wegQa56qMFmA+43sFH+0K0rYFehwvR4=
X-Received: by 2002:a0d:d68c:0:b0:61a:c992:369c with SMTP id
 y134-20020a0dd68c000000b0061ac992369cmr1971691ywd.43.1713162761041; Sun, 14
 Apr 2024 23:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240320090214.40465-1-ada@thorsis.com>
 <CABGWkvrF3UxEzw2eh1kb7To+aQ8iaWMyrnU8Qz0tYJGumY0QGw@mail.gmail.com>
 <20240415-fruit-theorize-e06b014a60cd@thorsis.com>
In-Reply-To: <20240415-fruit-theorize-e06b014a60cd@thorsis.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 15 Apr 2024 08:32:30 +0200
Message-ID: <CABGWkvr3iN88AF2ywOqLppYTbRqX84BgnCyawHmyfebB4=xahg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mtd: nand: raw: Collected improvements
To: Alexander Dahl <ada@thorsis.com>
Cc: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>, u-boot@lists.denx.de, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mihai Sain <mihai.sain@microchip.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, Li Bin <bin.li@microchip.com>
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

Hello Alexander,

On Mon, Apr 15, 2024 at 8:13=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> Hello Dario,
>
> Am Sun, Apr 14, 2024 at 03:41:38PM +0200 schrieb Dario Binacchi:
> > Hi Alexander,
> >
> > On Wed, Mar 20, 2024 at 10:02=E2=80=AFAM Alexander Dahl <ada@thorsis.co=
m> wrote:
> > >
> > > Hello everyone,
> > >
> > > while working on NAND flash support for a custom board based on the a=
t91
> > > SAM9X60 SoC I stumbled over some issues in the raw nand subsystem.
> > >
> > > Four of six patches are minor fixes.
> > >
> > > Patch 4 introduces a new subcommand for the new atmel nand controller
> > > driver.  Patch 6 introduces a new subcommand for the nand command to
> > > override ONFI timing mode.  Both are are for debugging purposes only =
and
> > > thus optional, and need to be enabled through menu.  Both helped me a
> > > lot when investigating issues.
> > >
> > > Series is based on upstream next branch, but should also apply to mas=
ter
> > > cleanly.
> > >
> > > Greets
> > > Alex
> > >
> > > v1:
> > >
> > > Link: https://lore.kernel.org/u-boot/20240307091014.39796-1-ada@thors=
is.com/T/#t
> > >
> > > v2:
> > >
> > > - rebased on recent next
> > > - collected tags
> > > - improved patch 4 after feedback from Mihai
> > > - added new patch 5 with another help text fix
> > > - added new patch 6 with a new debug command
> > > - reworded cover letter
> > >
> > > See per patch changes in patches for more detailed changes.
> > >
> > > Alexander Dahl (6):
> > >   mtd: nand: raw: Use macro nand_to_mtd() where appropriate
> > >   mtd: nand: raw: Port another option flag from Linux
> > >   mtd: nand: raw: Fix (most) Kconfig indentation
> > >   mtd: nand: raw: atmel: Introduce optional debug commands
> > >   mtd: nand: raw: atmel: Fix comment in timings preparation
> > >   cmd: nand: Add new optional sub-command 'onfi'
> > >
> > >  cmd/Kconfig                                  |  10 +
> > >  cmd/nand.c                                   |  61 ++++
> > >  drivers/mtd/nand/raw/Kconfig                 | 115 +++----
> > >  drivers/mtd/nand/raw/atmel/nand-controller.c | 299 +++++++++++++++++=
+-
> > >  drivers/mtd/nand/raw/nand_base.c             |   8 +-
> > >  include/linux/mtd/rawnand.h                  |   8 +
> > >  6 files changed, 441 insertions(+), 60 deletions(-)
> > >
> > >
> > > base-commit: f048104999db28d49362201eaebfc91adb14f47c
> > > --
> > > 2.39.2
> > >
> > Applied to nand-next the first 4 patches.
> > For the others, we will conduct further testing before applying them.
>
> Thanks so far.  :-)
>
> I have another fix for the atmel raw nand driver, which I forgot to
> send with this series.  I could add it to v3.

Of course, feel free to add it to version 3.

Thanks and regards,
Dario

> Or should I send it
> separately?
>
> Greets
> Alex



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
