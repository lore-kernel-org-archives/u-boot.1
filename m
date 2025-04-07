Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E4CC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 13:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55BAC82ED0;
	Mon,  7 Apr 2025 15:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZrSJ2BYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA92682E38; Mon,  7 Apr 2025 15:30:57 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7DD982B8E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 15:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f6dccdcadaso2754400b6e.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744032653; x=1744637453; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nps+pajMXSNHf8wxpb0exDDIkHGVlMkrJaUN97/vcTo=;
 b=ZrSJ2BYIVynNG2h/Dp/BTii1mhs6XRHXfPHI7jX6vHwIjHJWEG70dHWOp/t5WibQq5
 HwlapPcFo1CHuzSbjEVFwZZ4pmKs/jDxKcdD+I+tSuDhbzgU4pP8wAZ6RbAPDrv2s9j7
 2vERz5Mhm/QKYGn0rWf5LwLMP/5P2ZxKjHm0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744032653; x=1744637453;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nps+pajMXSNHf8wxpb0exDDIkHGVlMkrJaUN97/vcTo=;
 b=KNGSsXW/h08NawNTIOWVmoKCO6lB+ChEjKu0inaO1ZFXgUY3/VVBaRcNxWDRBYg3jC
 G/bfqy8XscMck3vadCZ3UK+vGwmu8mNLDCYHx3uhfE8aBbJTvlNL5qASsc3AV478VUOf
 gz/pRt1SmKhw2cTpZQD2RdfSfmnIAl61jhARMx7Jb52pE6jJy/kBHbfxZwmAk2GlSA6H
 Kps1y+puhD4jLeG6kTWr6Q7hjMyA/tbTOW6D0H42ati6lsFHY+L2CTaDNd2gGzU9ivo8
 e7b/ZkPZWKBp41F1C3Xd+zwjtz96ffF+Ip8bU69wfVCr0z+CSmMX2VfW0fQQDAJEYUzG
 CfPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFcTNkykGmYQtXGRTOAOmhQzd8Ym0BUr1Cl+EfKJGXUV3J/ev6gXpQ5qE/xHziCKvCzQ4TJ+k=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2DayhdIzWRpk4YhJSd1EdqMy81SBvWjQky7GUqqaK4P5s5mhI
 X3mgPKuviPRDtvnYhGa9pzTQIPTPQh7RFM1FNq6w8uCBXCN3fllWv8nhDYNIXD0=
X-Gm-Gg: ASbGnctDrW/AqIY9vc5xjZ4wHKBXy6+cVG5GDpHnIIj38tgNVz0WjsNyQ1Vbizn6A5t
 imY0RM6NCp1d8hFrVee6sr7Zl6Cx/dkB01ZtGXRvLIqRfVXdEXOGaE/zbmex3hKti1XokilndMC
 53JqBJHuDoey8yDuSUt8T3OJ5xxd/7uKonwra0AqZ3v8uerNiLt2CG943qXLWvSFowwaHLG+0Ea
 8z4XCMZvviDjV8uTO4rg72oIDk16nrI1bLO+0dznV9TUq6t1ce3z6dUgFnnlxWGGNeSbJGxV5vw
 Sf9YKhmj1XCvoJQ5tRbOuhKek9KwSkht7gOVAj0DP1sLH+tN3Jb8VqA/d1gUTtjQTmk5kC125yZ
 PFd9Hxg==
X-Google-Smtp-Source: AGHT+IHTZFVx9136O060pCf8jX/fg69W8HBeb4QchC1EJHi2lUjur1HKu9MmH2jXr8gBnYHmoaRzXg==
X-Received: by 2002:a05:6808:ec9:b0:3fe:af3a:639 with SMTP id
 5614622812f47-400466724e2mr6825426b6e.29.1744032653459; 
 Mon, 07 Apr 2025 06:30:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff4e3edsm1770194b6e.6.2025.04.07.06.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 06:30:52 -0700 (PDT)
Date: Mon, 7 Apr 2025 07:30:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Janne Grunau <j@jannau.net>, Leo <ycliang@andestech.com>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rick Chen <rick@andestech.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 4/4] dm: core: Rename dm_remove_devices_active()
Message-ID: <20250407133049.GI5495@bill-the-cat>
References: <20250407013513.638110-1-sjg@chromium.org>
 <20250407013513.638110-5-sjg@chromium.org>
 <ae928b59-23c1-4148-81b2-85dc5e261868@gmx.de>
 <CAFLszTgdCJMPVL6StLygGBT_GKJQXbpGGDT1tDqWMs9-kToEVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rzfblNGT2aB40y3J"
Content-Disposition: inline
In-Reply-To: <CAFLszTgdCJMPVL6StLygGBT_GKJQXbpGGDT1tDqWMs9-kToEVQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--rzfblNGT2aB40y3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 07, 2025 at 10:49:11PM +1200, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 7 Apr 2025 at 19:57, Heinrich Schuchardt <xypron.glpk@gmx.de> wro=
te:
> >
> > On 07.04.25 03:35, Simon Glass wrote:
> > > This function doesn't have a great name, since we talk of devices bei=
ng
> > > active once they are probed.
> > >
> > > Rename it to dm_remove_dma_devices().
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Suggested-by: Jonas Karlman <jonas@kwiboo.se>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >   arch/arm/lib/bootm.c          | 4 ++--
> > >   arch/riscv/lib/bootm.c        | 2 +-
> > >   arch/x86/lib/bootm.c          | 2 +-
> > >   drivers/core/root.c           | 2 +-
> > >   include/dm/root.h             | 6 +++---
> > >   lib/efi_loader/efi_boottime.c | 2 +-
> > >   test/dm/core.c                | 2 +-
> > >   7 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
> > > index 688c2f3f29b..ef859a2cd4c 100644
> > > --- a/arch/arm/lib/bootm.c
> > > +++ b/arch/arm/lib/bootm.c
> > > @@ -74,10 +74,10 @@ static void announce_and_cleanup(int fake)
> > >        * Call remove function of all devices with a removal flag set.
> > >        * This may be useful for last-stage operations, like cancelling
> > >        * of DMA operation or releasing device internal buffers.
> > > -      * dm_remove_devices_active() ensures that vital devices are re=
moved in
> > > +      * dm_remove_dma_devices() ensures that vital devices are remov=
ed in
> > >        * a second round.
> > >        */
> > > -     dm_remove_devices_active();
> > > +     dm_remove_dma_devices();
> > >
> > >       cleanup_before_linux();
> > >   }
> > > diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
> > > index 76c610bcee0..9aecaafef43 100644
> > > --- a/arch/riscv/lib/bootm.c
> > > +++ b/arch/riscv/lib/bootm.c
> > > @@ -57,7 +57,7 @@ static void announce_and_cleanup(int fake)
> > >        * This may be useful for last-stage operations, like cancelling
> > >        * of DMA operation or releasing device internal buffers.
> > >        */
> > > -     dm_remove_devices_active();
> > > +     dm_remove_dma_devices();
> > >
> > >       cleanup_before_linux();
> > >   }
> > > diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> > > index 3c420b00936..91e8de4e1ad 100644
> > > --- a/arch/x86/lib/bootm.c
> > > +++ b/arch/x86/lib/bootm.c
> > > @@ -50,7 +50,7 @@ void bootm_announce_and_cleanup(void)
> > >        * This may be useful for last-stage operations, like cancelling
> > >        * of DMA operation or releasing device internal buffers.
> > >        */
> > > -     dm_remove_devices_active();
> > > +     dm_remove_dma_devices();
> > >   }
> > >
> > >   #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
> > > diff --git a/drivers/core/root.c b/drivers/core/root.c
> > > index c7fb58285ca..101cc4d43fa 100644
> > > --- a/drivers/core/root.c
> > > +++ b/drivers/core/root.c
> > > @@ -148,7 +148,7 @@ int dm_remove_devices_flags(uint flags)
> > >       return 0;
> > >   }
> > >
> > > -void dm_remove_devices_active(void)
> > > +void dm_remove_dma_devices(void)
> > >   {
> > >       /* Remove non-vital devices first */
> > >       device_remove(dm_root(), DM_REMOVE_ACTIVE_ALL | DM_REMOVE_NON_V=
ITAL);
> > > diff --git a/include/dm/root.h b/include/dm/root.h
> > > index 5651b868c8b..39a069cd465 100644
> > > --- a/include/dm/root.h
> > > +++ b/include/dm/root.h
> > > @@ -169,16 +169,16 @@ int dm_uninit(void);
> > >   int dm_remove_devices_flags(uint flags);
> > >
> > >   /**
> > > - * dm_remove_devices_active - Call remove function of all active dri=
vers heeding
> > > + * dm_remove_dma_devices - Call remove function of all active driver=
s heeding
> > >    *                            device dependencies as far as know, i=
=2Ee. removing
> > >    *                            devices marked with DM_FLAG_VITAL las=
t.
> > >    *
> > >    * All active devices will be removed
> > >    */
> > > -void dm_remove_devices_active(void);
> > > +void dm_remove_dma_devices(void);
> >
> > We have to remove all active devices. Not only DMA devices but also any
> > device that creates interrupts.
> >
> > The renaming is misleading.
>=20
> Yes, but so is the existing name, as mentioned.
>=20
> How about dm_remove_for_boot() ?

I think the name itself is fine and maybe just a bit more
documentation? It's dealing with the DM_REMOVE_ACTIVE_ALL flag
after all.

--=20
Tom

--rzfblNGT2aB40y3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfz04UACgkQFHw5/5Y0
tyyy+Av+KKeoXvP4hi9r0vxsJ7oxULARFzR0lZzyV4UK6q0TwBcG+S5fCCZqAzKp
49UZ3Dz+/7FnBQF0iJoalhfoeCpwPOgGaM+rqc6DP0Q0r8w4L8f/JkSIXS3f6Oqd
odTioLkNYbuhCjJNXsL/rBN0T62bi6FSGsEGvM9mafLBPyiqIeq+btHvPJexkN5R
Sg9sBox9IRX9iImdhzPGm2WWEe+izSp1iGsKKhbivgKyeqw9Y4F8PoyP7yZpnxL4
C2RndPo9E1GmaKAK7OnpQcE9hdY4Bht43p9jC5hiWYz1KTkerpxAdnkyo6MtYbSd
J+jFNaJsfHru55IjmIwm74QuKT5Z9vHGCDQLVuhkcQjnKBpWmGnwdLAKcsYG3hH8
Q9HIlrEWt28/WQJht+c9AvTaECYa8Mxl7rJoqRztwaWINBbei1+QCDKd/8f39Lkj
ava4uR5wjjWdZmx9xxUGfx0vtK/MTSRnvhDEB37PDfSl185MSg/TWWMMTWmX5ElX
JxY9jbol
=4+1c
-----END PGP SIGNATURE-----

--rzfblNGT2aB40y3J--
