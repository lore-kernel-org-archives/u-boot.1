Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3A8D1D492
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 21:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08EFD8415E;
	Thu,  8 Jan 2026 22:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cvr0FvoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40A83841DA; Thu,  8 Jan 2026 22:02:10 +0100 (CET)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A078415D
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 22:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-4557f0e5e60so2333273b6e.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 13:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767906126; x=1768510926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jS+b1qzw6+GV3sNCnksQGYkZ6lZdf4iWkm9+sO+XGQw=;
 b=Cvr0FvoJ/XQ3TaeeSogvZ5OugHE8stN9eY/bEgsrAfPdMv/bFoz/ghGKlNuoJQLQ4N
 rW8jrFKwI/Yma+mVhrvGNVE95/+ZEdjcPmBvCBWmklH0upuC5CKzO2gPXfS1Y/IbK74x
 Kl+lEDWHhsjmoHtlr/Jp/O10qIpLDc5EPjjBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906126; x=1768510926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jS+b1qzw6+GV3sNCnksQGYkZ6lZdf4iWkm9+sO+XGQw=;
 b=bUH9oulEDlVaun8IDDhY3jvrVFeV6zgbWO1cfn2A7SF4wWtbWNB/AXvKEYKqWSHOQn
 5YNDZzSRheYngTg3prMEwhfYCg+phfXCLKSHzT2M1MtzABQ8swBiOYo0vMYU1bmiH1i4
 QYI+yBzKiFScjz4ec9xnL0xmjZKiMgadj+XD8I7dxLol4fd0scA2GlrvrnbeeTHgvpKV
 mtXF2Ii85/dUj/FBCLBomms7OodzFXoNyMn5nlM39XbS0YfbpZqYlVqlDNXkk0SALRLd
 mAWd9EOad6vtpJzlpvfpL/z1eIGKdK5KFy9AZtD8qQH2rcR9TI0c4gB9C9KcQEjwaL/i
 6GKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVken/4mYyG002YQfMAbidMNAE6ODOjtAsqhNVhqP08SUUDu8B3hq9085mQdnS6W0insCLTg3I=@lists.denx.de
X-Gm-Message-State: AOJu0YyUolo8WXXZTXDMRpiLyCLuv9isY8EPrWlGDdFS4ytfEx0Pb6ey
 Fqll6V9e7GKipqj1lSYAifSaqB5OsiR+hVwimiHk4EcXy8/tbZNErE1GPr8xKioUJVc=
X-Gm-Gg: AY/fxX7O2lPCJEdNEXiwiUr+k8x3pcGVzEemSrnTkleJojzJeft525Ayg/KU7Zs7fuD
 xjOHXpe/RQxbRB/dM3M9ei4lbNii0Ux4FdpbmY8tt/1xq/cm7YO1CamH6nvfMRIBLwjc5mGfpPI
 Or9u44SPG2lRq/BesjoJ0VOCZRSXoRxG0rSJvPVlL0rmJGOTgCzRk6tH4rlxee0atm4l+TioMII
 2C9JKCyNYNcWZFref+2HI1U9yRgVwCnr6JfCBuLqqmS6pqBtEG34h5SEoe1Q9W6gubLaxkd06q4
 yCEtUNdaHWvZg9PJ76ahkkjMTI/YgyJ7Rn4+WZMMw66H5kmiI69WWqn3V+XaR9aXy12dtFHGrSF
 YIPd7dzA9a584UsXV7kqgUXcl7wHvoMvYziepluTi/t0KHsI5QrjSNWwlUklDpaC2owkbPA9PMa
 i/tN0INXmT1gSIdmora4V+iEDuol0Ogbcjwa+DK5bvmiJhY+ATBDbui3w2/y39VZ2/U8kcRDz6s
 ZQ/E2d17uz1SpQAJ2ymQX8cFNAwr9n9BBkXWW314dxgcG5GmA==
X-Google-Smtp-Source: AGHT+IGtz3x3KgBQnNLTGuhP83s0o3O1k52z/gI+IUK7g6vtD17IPsqtTcj243JZSUCXTi1fKp6yYA==
X-Received: by 2002:a05:6808:4f60:b0:45a:552f:bb9b with SMTP id
 5614622812f47-45a6be3f775mr3026028b6e.31.1767906126294; 
 Thu, 08 Jan 2026 13:02:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa5072427sm5471209fac.12.2026.01.08.13.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 13:02:05 -0800 (PST)
Date: Thu, 8 Jan 2026 15:02:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, E Shattow <e@freeshell.de>
Subject: Re: Pull request efi-next-20251225 (for next branch)
Message-ID: <20260108210203.GW3416603@bill-the-cat>
References: <1faefbf2-e8b0-4c94-85f5-025355915e0d@gmx.de>
 <8608a798-183a-4f07-bfbc-1f45ae59a6ee@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tNElJLiUvyi2e/3J"
Content-Disposition: inline
In-Reply-To: <8608a798-183a-4f07-bfbc-1f45ae59a6ee@cherry.de>
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


--tNElJLiUvyi2e/3J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2026 at 05:20:52PM +0100, Quentin Schulz wrote:
> Hi Heinrich,
>=20
> On 12/25/25 11:13 AM, Heinrich Schuchardt wrote:
> > Dear Tom,
> >=20
> > The following changes since commit
> > baf076aeb32dcdd2b022405088c3288ffc160fcf:
> >=20
> >  =A0 Merge branch 'staging' of https://
> > eur02.safelinks.protection.outlook.com/?
> > url=3Dhttps%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot- tegr=
a&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7Cf87dd0f90d6b45f7ce7508de439=
e34da%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639022543931009936%7CUnk=
nown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z=
MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUrWok7nyXyLT97iLd=
1o%2FxUIuYtwkRz7DcO8D8ogdH7Y%3D&reserved=3D0
> > into next (2025-12-23 08:11:36 -0600)
> >=20
> > are available in the Git repository at:
> >=20
> >  =A0 https://eur02.safelinks.protection.outlook.com/?
> > url=3Dhttps%3A%2F%2Fsource.denx.de%2Fu-boot%2Fcustodians%2Fu-boot- efi.=
git&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7Cf87dd0f90d6b45f7ce7508de4=
39e34da%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C639022543931023452%7CU=
nknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW=
4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DnoF%2B4QWCdd9ud=
s%2FLv5wxiCynT7PNTHKQFnDHXYn2%2BqQ%3D&reserved=3D0
> > tags/efi-next-20251225
> >=20
> > for you to fetch changes up to 4c105d2ae7b0f847668ff1ef6b410f63ab4290b7:
> >=20
> >  =A0 doc: board: starfive: update jh7110 common description (2025-12-24
> > 09:41:57 +0100)
> >=20
> > ----------------------------------------------------------------
> > Pull request efi-next-20251225
> >=20
> > Documentation:
> >=20
> > * Update StarFive Jh7110 common description.
> > * Describe command line options of the bdinfo command.
> > * Describe configuration dependencies of the bdinfo command.
> >=20
> > UEFI:
> >=20
> > * Trigger capsule updates with automatically generated boot options.
> > * In the LoadImage unit test add a check that device-paths are correctly
> >  =A0 used.
> > * In the variables at runtime test remove an unnecessary
> >  =A0 __efi_runtime_data attribute.
> >=20
> > Others:
> >=20
> > * Let the bdinfo command output device-tree information even if LMB is
> >  =A0 no used.
> > * Add long help texts for all options of the bdinfo command.
> >=20
> > ----------------------------------------------------------------
> > E Shattow (1):
> >  =A0=A0=A0=A0=A0 doc: board: starfive: update jh7110 common description
> >=20
> > Heinrich Schuchardt (4):
> >  =A0=A0=A0=A0=A0 efi_selftest: Enhance LoadImage test
> >  =A0=A0=A0=A0=A0 efi_selftest: remove unnecessary __efi_runtime_data at=
tribute
> >  =A0=A0=A0=A0=A0 test: dm: clk_ccf: clean up assert statements
> >  =A0=A0=A0=A0=A0 cmd/bdinfo: LMB and device-tree are not related
> >=20
> > Ilias Apalodimas (1):
> >  =A0=A0=A0=A0=A0 efi_loader: Trigger capsule updates with automatically=
 generated
> > boot options
> >=20
> > Quentin Schulz (3):
> >  =A0=A0=A0=A0=A0 cmd: bdinfo: provide long help with all options
> >  =A0=A0=A0=A0=A0 doc: cmd: bdinfo: specify required dependency for some=
 info
>=20
> In the future, can you please consider editing the commit log when you're
> doing modifications to patches when merging them?
>=20
> Something like
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> [added symbol dependency to lmb_dump_all]
> [removed CONFIG_LMB as symbol dependency of devicetree]
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>=20
> ? So that there's some info about what was changed from the patch that was
> sent to the ML and by whom?
>=20
> (Maybe ask for permission before doing this as well, or maybe we should h=
ave
> documentation on what can be expected from maintainers to that regard? I
> know Buildroot does this a lot (and often silently), Yocto sometimes, but
> the kernel not too often, and it's the first time (that I know of) it
> happens to me in U-Boot :) )
>=20
> I'm generally not a fan of my patches being silently modified before
> merging, though here it ended up fine so thanks for sparing me the rebase=
+v3
> respin I was thinking about starting to do :)
=20
I have, over the years, sometimes added [trini: foo] and a SoB tag, and
more recently made us of b4 making merge commits of a series trivial
(which is great and this is yet another reminder to anyone reading that
cover letters on series are important because they become the merge
commit message) and dealing with both merge issues and trivially correct
changes such as spelling or spacing fixes in the merge commit itself.

What this does speak to however is that we need to document the
expectations here as it's clear implicit expectations have been
violated, and that's on me in the end to make sure are clear and
explicit. I'll write up something for doc/develop/process.rst in the
next few days.

--=20
Tom

--tNElJLiUvyi2e/3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWAbRwAKCRAr4qD1Cr/k
Cq93AP9TVwf6asK5a7OtR4l1tekJGNFxihk2/HN1VAD9Vh/i0wD/RUF4Ecz3SCfZ
DN+kZ1vYjwt5Seg2NKoBObjfYhsnUQ4=
=Ms/x
-----END PGP SIGNATURE-----

--tNElJLiUvyi2e/3J--
