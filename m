Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8888AC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 21:18:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F365A88BFC;
	Wed, 21 Aug 2024 23:18:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ru+ClhJo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB0A88E58; Wed, 21 Aug 2024 23:18:07 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F9BC88BE4
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 23:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5bf0261f162so246200a12.0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1724275085; x=1724879885;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KMi8C0AJXRHh3lmRYJZnB3PwuOFkimgNngB9W4ADE9s=;
 b=Ru+ClhJoKf+AA68imgzAM4TcnZg/3vi5hyji/uhi8xZnZ7JqCDY1NJBQ6Yma0QhujF
 /3egRAIhI8JoJMKNOoYpGISqVK+5hedDPlXV3nbHjxJi9RiOgvN1NF+wHmohfJla37lX
 CV/zVGKdtcaXU9z/hKBhtJ2mscMJLzWHk52y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724275085; x=1724879885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KMi8C0AJXRHh3lmRYJZnB3PwuOFkimgNngB9W4ADE9s=;
 b=FlmS+d2uP+igmhHic9R81yo8W8mXmrlG3k2HfUGcb04dgqVpMaqVdmfETwaVaI2prL
 q/4Ig2Zw/bIHDbvbgJM6yPDcwd35KSp9G6vbHrqimxY6lAJQ3Vpz+l8nOu52JE48b5Jk
 xmYM5XB8RO9STgVhZZAMiligju7qM+S06tD0Q3jLQfU1aJftYOXY+JiGHr+xH2lk54YK
 g6aIbzF7GeX/l28d4oNwSOTgL/K2pV4VpnCFtbnOGM+D85DFK4iHSyd/oWfHf7NHRULY
 KCCyfOsuBQrWYGJ+hqVavM6EiSOD6nkL3nWOsgC4RX0dZqvy0u/xd/licHdPMxbxTSHq
 utqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH47h8yePuK0QItLXYcrMpTLSgUsb5Ahpwh+s0pOUyKW+8xjPKoxbD8/qdVDPEqvOMyt+Rv18=@lists.denx.de
X-Gm-Message-State: AOJu0YxRMQK6ygEI3r7uA4EUMxvYdA2eb/hEOdS7A3urxPLXzJ5IsxUq
 Q+O8Br6aWVgo8fQxGm/vakzeTYU9X8/yCUa7wnQhV48JGB14HZBCwmMwYsCKV/CQqb8ZNFJvVQY
 2SUaVRjPq/05khD3F9aSbzPTLw5hBDfGrENmToA==
X-Google-Smtp-Source: AGHT+IGDipYZkKfJWEymzdq80zTmK50hLFcxUTfPQS0WYOmcAdqOBsfmKH6uGHYNmi5l4pRhq0XA43fk5xx9GYdoLkw=
X-Received: by 2002:a17:907:7f94:b0:a86:8b2f:49b3 with SMTP id
 a640c23a62f3a-a868b2f4dedmr59305466b.46.1724275084276; Wed, 21 Aug 2024
 14:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240708071352.3022327-1-avkrasnov@salutedevices.com>
 <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
In-Reply-To: <82c914ec-db68-5971-8ac0-6ed359872175@salutedevices.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 21 Aug 2024 23:17:51 +0200
Message-ID: <CAOf5uwmuZoDpVTGA=vTm_7Ywkw8OWi0e2NpG3Q1ZgO6R=UnuHQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Meson: R/W support for pages used by boot ROM
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>, 
 U-Boot-Denx <u-boot@lists.denx.de>, u-boot-amlogic@groups.io, 
 kernel <kernel@sberdevices.ru>, oxffffaa@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I will read them tomorrow ;)

Thank you for understanding

Michael

Il mer 21 ago 2024, 22:25 Arseniy Krasnov <avkrasnov@salutedevices.com> ha
scritto:

> Hi, sorry, pls ping  =F0=9F=98=84
>
> Thanks
>
> On 08.07.2024 10:13, Arseniy Krasnov wrote:
> > Patchset is based on patchset for Linux (today merged to nand-next):
> >
> https://lore.kernel.org/linux-mtd/20240507230903.3399594-1-avkrasnov@salu=
tedevices.com/
> >
> > Here is description from it:
> >
> >  >  Amlogic's boot ROM code needs that some pages on NAND must be writt=
en
> >  >  in special "short" ECC mode with scrambling enabled. Such pages:
> >  >  1) Contain some metadata about hardware.
> >  >  2) Located with some interval starting from 0 offset, until some
> >  >     specified offset. Interval and second offset are set in the
> >  >     device tree.
> >  >
> >  >  This patchset adds R/W support for such pages. To enable it we can
> setup
> >  >  it in dts:
> >  >
> >  >      nand-is-boot-medium;
> >  >      amlogic,boot-pages =3D <1024>;
> >  >      amlogic,boot-page-step =3D <128>;
> >  >
> >  >  It means that each 128th page in range 0 to 1024 pages will be
> accessed
> >  >  in special mode ("short" ECC + scrambling). In practice this featur=
e
> is
> >  >  needed when we want to update first block of NAND - driver will
> enable
> >  >  required mode by itself using value from device tree.
> >
> > The only difference is that patchset for Linux updates DT bindings, whi=
le
> > this adds NAND_IS_BOOT_MEDIUM flag support.
> >
> > Changelog:
> >  v1 -> v2:
> >  * Pls see per-patch changelog.
> >
> > Arseniy Krasnov (3):
> >   mtd: rawnand: nand_base: support for 'NAND_IS_BOOT_MEDIUM' flag
> >   mtd: rawnand: meson: refactor use of 'meson_nfc_cmd_access()'
> >   mtd: rawnand: meson: read/write access for boot ROM pages
> >
> >  drivers/mtd/nand/raw/meson_nand.c | 84 +++++++++++++++++++++----------
> >  drivers/mtd/nand/raw/nand_base.c  |  3 ++
> >  include/linux/mtd/rawnand.h       |  5 ++
> >  3 files changed, 65 insertions(+), 27 deletions(-)
> >
>
