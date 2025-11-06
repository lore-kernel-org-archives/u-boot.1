Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA76CCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 18:23:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A3383B85;
	Thu,  6 Nov 2025 19:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lZK9p3yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AB1F83BBE; Thu,  6 Nov 2025 19:23:36 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C01C483B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 19:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-44fe4c3c19cso528891b6e.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762453412; x=1763058212; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WfAIS7bOwZ6rQtG0X3AMJSJxln8uL8u07+wcIYlNlVQ=;
 b=lZK9p3yc34vSJgCMtIjMeFDuCwkXbkNp3xbAPIvRmbBWsjxEQhbvX0743YdRVeMyoT
 MQDeBTpfWohsmdquGq+KCll43Mmn688+RioEC2ENMlRxaKtHtUHoukvK8xq6UN06Z8Rx
 KBdtD+c9ZtGSwh1QAgFvh143BenhMoVUshCiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762453412; x=1763058212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WfAIS7bOwZ6rQtG0X3AMJSJxln8uL8u07+wcIYlNlVQ=;
 b=oBYEl3dM2c+iTiMYt9l6fFlaipibqIAyOByDUkXrlZnQNTK17djmMZGVHzYPPfOBr9
 6dcYljZ2KTdSrk9uTMfqAwKfZpAfQ4Cd5UindL7EJWYZoP7O03bqt6TSBd+D80Ol3cK6
 OTgSXb4ixX3MEC9AiafNMfbiHqeyNA2T9tD7jDj4UiV9hzucrASyPVdQjCrhfAhIhcLB
 npTnJJwd89zmnY3fFK+nOQlvIOeud+5HLE2VALytUNY+kQ9a29uFrplDu5Cdl84ZZbeP
 aDcWIR/4F/qG84qqQIcjyQ6jUg3ZzDsBLgrq7+jtsegKXOY+XDRRefqUPBSWS4CV4dzC
 rVsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDpcw8SLl6tKtuIm5IipQRCEE+O0zjuhgfFZQqrZgv80xiR/naM6zsEJoE1gtyuLZymewRPlo=@lists.denx.de
X-Gm-Message-State: AOJu0YzE+8nrcY3zu934+QsaGSX/ITbcEeuLu/5LNz+zsMW9BjfQfwom
 McoQeHDQDwxP0/NL3CjO3axTnTTJpcC4ZNJweq8dh7uSnrVqZwcvfHIRD+v1hplC9VM=
X-Gm-Gg: ASbGnctoeEo/KWG1r38xAOAjDjERb4ovaY8qrWrfzcilZj4NfdhILaWGARX/3pggCAw
 PwpoaLeLTaFluXQasSYtDIiJIEI5zLYfAN+IL89jQGbM5oZS42dX9szY6/1ure5r6SfCn7YbS1H
 gGULeYYs3Uw3zUzoW82bkYqsAymUZpux2hjHh7DpKpqvuytUESSsvWWIXreA0NRoHh7BXkzKeXc
 weyZlHRo+tFfFvqrKJJY7nwp+YumlY21FGz57CJGPPEcwAUUuiMiG8aIOZsphuxRr5L5G3K9atT
 veZVKtW3ZmUgQHYy3QEzF8QOKtG7OV07Yr+W0JKal15ifaWfpZ6bqLfHEWacGErEUZKSIsmzKei
 b/0TW8BV/3ks62OH59dt38mDH8blGZYpBluPAFmaNumJ/L9r0dOdNt6n5YE8MPN/amZtm3vCXrG
 F2a2bNt0wERtb9MXNbCHfOa5/IEvuxym13TL9LZdM=
X-Google-Smtp-Source: AGHT+IEPIXJ1+34tQqkTHkwmvbqbmFkibDpOfBT78vr5MabV8zVNJt2HLX2n9ljSSB+3nckDWir6Aw==
X-Received: by 2002:a05:6808:1a28:b0:43f:14d6:82b4 with SMTP id
 5614622812f47-45015ececb7mr161755b6e.35.1762453412438; 
 Thu, 06 Nov 2025 10:23:32 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450027edca3sm1049203b6e.22.2025.11.06.10.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:23:31 -0800 (PST)
Date: Thu, 6 Nov 2025 12:23:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 "Bajjuri, Praneeth" <praneeth@ti.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] distro_bootcmd: Add support for customizable
 find_distro_rootpart
Message-ID: <20251106182329.GY6688@bill-the-cat>
References: <20251031-feature_distro_rootpart-v1-0-4e7c465708e8@bootlin.com>
 <20251031-feature_distro_rootpart-v1-1-4e7c465708e8@bootlin.com>
 <CAFLszTicHdtY73+asYQ9NF_uEFg7BsSfN2cW+21FbQoxH9V_JA@mail.gmail.com>
 <20251103115225.381126f1@kmaincent-XPS-13-7390>
 <20251103171630.4df1efdd@kmaincent-XPS-13-7390>
 <20251103161905.GP6688@bill-the-cat>
 <20251104102916.3df33d55@kmaincent-XPS-13-7390>
 <20251104163816.GB6688@bill-the-cat>
 <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VjcB9YdweuqPNrFc"
Content-Disposition: inline
In-Reply-To: <20251106190001.0e5a4504@kmaincent-XPS-13-7390>
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


--VjcB9YdweuqPNrFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2025 at 07:00:01PM +0100, Kory Maincent wrote:
> On Tue, 4 Nov 2025 10:38:16 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Tue, Nov 04, 2025 at 10:29:16AM +0100, Kory Maincent wrote:
> > > On Mon, 3 Nov 2025 10:19:05 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >  =20
> > > > On Mon, Nov 03, 2025 at 05:16:30PM +0100, Kory Maincent wrote: =20
> > > > > On Mon, 3 Nov 2025 11:52:25 +0100
> > > > > Kory Maincent <kory.maincent@bootlin.com> wrote:
> > > > > > > >       =20
> > > > > > >=20
> > > > > > > How about moving to standard boot and look at this there?    =
 =20
> > > > > >=20
> > > > > > Ok, I will take a look at it.   =20
> > > > >=20
> > > > > There is a custom nand boot target [1], and I have not any am335x=
 board
> > > > > with nand memory to test it. I am afraid to break it during the u=
pdate
> > > > > to bootstd. Not sure we can accept that. What do you think?
> > > > >=20
> > > > > [1]https://elixir.bootlin.com/u-boot/v2025.10/source/include/conf=
igs/am335x_evm.h#L27
> > > > >   =20
> > > >=20
> > > > I think we can risk it. I'd even be OK with not migrating that port=
ion
> > > > and letting anyone still using those platforms, with NAND only, to =
just
> > > > use a custom boot command instead as I have strong doubts there's a=
nyone
> > > > doing anything other than that currently. =20
> > >=20
> > > Ok.
> > >=20
> > > Small questions related to standard boot:
> > > Why do we have a lot of bootmeth selected by default like
> > > BOOTMETH_EFILOADER, BOOTMETH_EFI_BOOTMGR, BOOTMETH_VBE ..., but
> > > BOOTSTD_DEFAULTS not selected by default? Shouldn't it be the contrar=
y? =20
> >=20
> > Hard to say. We got stuck on trying to find the right balance between
> > features and size growth.
>=20
> I still think we should disable these as default, moreover they are run f=
irst
> in the bootstd process as they are global bootmeth.

We changed that just now, but also running efi bootmgr is important for
the common use case of generic OS support (which is growing more for
64bit ARM than 32bit ARM).

> > > Moreover it is explicitly described that global bootmeth can be slow:
> > > https://elixir.bootlin.com/u-boot/v2025.10/source/doc/develop/bootstd=
/overview.rst#L103
> > >=20
> > > The bootmeths environment variable is never read.
> > > Changing this environment in the prompt allows to change the bootmeth=
 order
> > > thanks to this callback:
> > > https://elixir.bootlin.com/u-boot/v2025.10/source/boot/bootmeth-uclas=
s.c#L459
> > > But if we set bootmeths in the board environment it doesn't work at a=
ll.
> > > Is it intended? =20
> >=20
> > Standard boot is still in development. We're still in the process of
> > getting more SoCs migrated and in turn finding and fixing the rough
> > spots. Global boot meths have changed a bit since v2025.10 as part of
> > hopefully addressing the feedback Andre P. had as part of migrating
> > sunxi, but I think there's still the ordering half of his concerns to be
> > figured out.
>=20
> Ok thanks for your replies.
>=20
> Other question: Is it possible to not add the environment to SPL image us=
ing
> the new text environment format. I have tried to update am335_evm board t=
o it
> but I got a SPL too big error.
> I have tried to add "#if !defined(XPL_BUILD)" but it is not working.
> It seems the same generated environment file is used for all images.
> I still haven't found were it is included in the build of the SPL image.=
=20

It shouldn't change the environment size, but also environment is likely
being pulled in to SPL for network boot support which does require
environment. What do you mean by "same generated environment file is
used for all images" ? And are you building in separate object
directories for a given board or is it not being re-generated on config
changes? Or did I misunderstand? Thanks.

--=20
Tom

--VjcB9YdweuqPNrFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQznlgAKCRAr4qD1Cr/k
Ckg9AP9iAJBANuoNKZti4xpevLwvxI38RaNl/9y1NxIDZcnUIwEAvbwha/Ir5dOR
nAXGKVIV2aEUp1YsY8ZyPsiU3NDxOgc=
=GJMf
-----END PGP SIGNATURE-----

--VjcB9YdweuqPNrFc--
