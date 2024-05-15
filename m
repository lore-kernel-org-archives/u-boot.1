Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337FFC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 21:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 839F988312;
	Wed, 15 May 2024 23:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="MHC1gp1Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431A288312; Wed, 15 May 2024 23:11:50 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D015E88176
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 23:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f4d2676d1so20231e87.3
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715807507; x=1716412307; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jab4HbBb376b895WY+DpziZeDfW4uVeJx9aY3jt7FAk=;
 b=MHC1gp1QpO2QHM573m8KkxqzofL1i6N3dyaOFo1OMePiUtNzBH2zHt52zTz1DGwS03
 pb3PIxxUtRE0MvF2bI69a5JdFADk4PtlZ3o2AMKPboJwOgStWDbdCd0LeN88Qba6yGh1
 ultoiJ4hgIP05VMabX0JGQaTUIOAfmY3O8v07NZqtIfcHA5bRICoVrgUEaMWmM1urhBW
 1ps3K/N0snCyuayCilf3PDOaGhGOE2NFlEWrms0ECRAuPKi9tG/yh7kjk2uFXgDTujXo
 lqEkSsFTM/3x896N1qWZwXLbmwUwg/cXNBoJuqNpfLdhKmANZUcA1w1xFkwbW88UwmdH
 NgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715807507; x=1716412307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jab4HbBb376b895WY+DpziZeDfW4uVeJx9aY3jt7FAk=;
 b=ebVo8IzJ/plbpY+SdY9b8SB8/phO2ntEdjrIHzRfvfz0QX2hSD22Jh8SeSZ7BqmmDI
 4YVVBPlbD3/cIMjTd/q7uJiwcouKuVwSV53Z3c5mU56Nky9nD6bgPLVyN2oddKmGnUgT
 Le2amxgnTS0Pc6GLh62cijRYuGu7pyIphWqJ28jBc/GuJrxvEmwIqI71akqw2ixk16zl
 nilzy9mY2UpO0tqLkHnGpPGodVoMjJkcV8chROMUi/rantdcJh4ZrzlwB56ncoRt0Eta
 MZjINZoGuGxdkeEyeI4HPHAhpwuf8bgxoxdx43pDe94mgO0NVATk97cn4dCAeJ2JwUb5
 okhA==
X-Gm-Message-State: AOJu0YxDzzJaz5vPtNIIzdknsv5kqfLtvh11etCAtemnN3fCW0PaczpL
 V42K000xKBj2l+x3OKvq8WCzmXmJOGJ2AbU9fcm+n66JWPmothYNr2T68O0IyhC1Lz9p5QOUebt
 AHNRVF4nYs/55kS6ZxfymhAMz83KhMLZ/3N3qDg==
X-Google-Smtp-Source: AGHT+IGEq0S6DgotAbU5WNIrXQFqjBgGfqPhclg9Tex+ac/oIMRwQrBEUdVIgvQ7cCnA8FpO8ut88JeXt0FBOvJ8ZRI=
X-Received: by 2002:a05:6512:1304:b0:518:d259:8542 with SMTP id
 2adb3069b0e04-5220fb77500mr13372092e87.2.1715807506931; Wed, 15 May 2024
 14:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <f4e559f7-8b41-47e2-9b00-eb44b90dc97a@denx.de>
In-Reply-To: <f4e559f7-8b41-47e2-9b00-eb44b90dc97a@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 15 May 2024 14:11:35 -0700
Message-ID: <CAJ+vNU2Zfjd0du0xML8cQz-=2knndj5g_5_ba9KrL+jK20Kygw@mail.gmail.com>
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
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

On Wed, May 15, 2024 at 2:06=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/15/24 10:50 PM, Tim Harvey wrote:
>
> [...]
>
> > diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> > index 874ca4d6f5af..3455d60d69dc 100644
> > --- a/boot/fdt_support.c
> > +++ b/boot/fdt_support.c
> > @@ -8,6 +8,7 @@
> >
> >   #include <abuf.h>
> >   #include <env.h>
> > +#include <kaslrseed.h>
> >   #include <log.h>
> >   #include <mapmem.h>
> >   #include <net.h>
> > @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
> >       if (nodeoffset < 0)
> >               return nodeoffset;
> >
> > +     if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_S=
UPPORT)) {
> > +             err =3D fdt_kaslrseed(fdt);
> > +             if (err) {
> > +                     printf("WARNING: could not set kaslr-seed %s.\n",
> > +                            fdt_strerror(err));
> > +                     return err;
>
> Is this warning really a critical boot-breaking error ?

no, and in fact I'm printing a warning inside of fdt_kaslrseed so I
can remove the duplication of error prints in the various other places
it's called as well.

Thanks for pointing that out!

Best Regards,

Tim

>
> > +             }
> > +     }
> > +
> >       if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
> >               err =3D fdt_setprop(fdt, nodeoffset, "rng-seed",
> >                                 abuf_data(&buf), abuf_size(&buf));
>
> [...]
>
> The rest looks good !
