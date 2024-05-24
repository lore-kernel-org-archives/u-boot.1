Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B28C25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 14:15:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2671F88653;
	Fri, 24 May 2024 16:15:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TM4/4JeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FCE188682; Fri, 24 May 2024 16:15:11 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E966A88270
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 16:15:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-43fb18ad56dso3878191cf.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716560108; x=1717164908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=33N+ya+gxDV3HSjl3K5JPcDrIeAyfsc9wdofbpF+UP8=;
 b=TM4/4JeJYIz9Uq4UXpUL/HrhMTaaI15dEx7OhSnSwJRbH0uUYIjY8vYPTPGBnKoJMt
 TvjmIxBmJVAD4OkVTyqUcJyhi3oRL6Mc6GuGs2TumKwkx7TKKa+LISHP1jWhnTnud+X9
 TV10Ci8rEfrTuXAcBKmAdCR/UflQFvodcdm50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560108; x=1717164908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33N+ya+gxDV3HSjl3K5JPcDrIeAyfsc9wdofbpF+UP8=;
 b=lddrv3nUjkBEjqhh97fV3UOSw3qvI6tdl7AAKMrPavCFjT3Q1N7YGdDOZsHEIb5mO3
 ZOe5sGaPBzmd+FqAEk/qkSqpv9a0Y1/bH0MCJNjYh72BPK4Z8hC0hV1O0OZG/x58kidn
 a+ygsA1N4mWAaTQ2c2shicJu+31ddkXdx4jQHK7RwWAPgD3lZPBoxvAQjIVeBd3+jeuC
 A9GH2WfQpzdmC3qSNz2Bk4j/XmOOBs/Pjwx7Lm5wcmd7pbV0h2uUoDBwsboncvZlmFvz
 9dSxPH8lXsKnQY01L5AM5gWr7lJiAw2ufcBfdkxxmeEYryiyZEHyKboMAdZlio4KC8fo
 hcFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfFZ/A04IIf8yLX7xqmYIqTefScEo+L/KGSqmTzLCQN2MiqCJydc0A6rZ4GvgWdcgR5CzSR5EZx86OhBIjeAWm7r6KLw==
X-Gm-Message-State: AOJu0YxMp5sUaj1dhucNb84L3vw4x0Hpf+eh7EgVBAOhDmLvY7y5+qnm
 IAvz99rP6R6L7hcEx4S5Y9L/OAHq5xNxZFah71mb5anwBaZhVm6fImDu7Y3ng/A=
X-Google-Smtp-Source: AGHT+IGUuaotnL2MHwnSeg5zIoJp6yZcX3GNl4IwaD4FpYIKqdCV63oMXuz1GjO+JvoLKo8HR0BUpA==
X-Received: by 2002:ac8:5e0c:0:b0:43d:ea13:4331 with SMTP id
 d75a77b69052e-43fb0e4186cmr25770221cf.18.1716560107634; 
 Fri, 24 May 2024 07:15:07 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43fb18c2e80sm8210091cf.84.2024.05.24.07.15.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 07:15:07 -0700 (PDT)
Date: Fri, 24 May 2024 08:15:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 sjg@chromium.org, philipp.tomsich@vrull.eu, jagan@edgeble.ai,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V3] board: rockchip: Add Indiedroid Nova
Message-ID: <20240524141504.GX2568172@bill-the-cat>
References: <20240521153350.238644-1-macroalpha82@gmail.com>
 <5ee55f40-bd60-41ab-ad7f-13a9011ab84a@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="66qsR7UGbcMy4acl"
Content-Disposition: inline
In-Reply-To: <5ee55f40-bd60-41ab-ad7f-13a9011ab84a@rock-chips.com>
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


--66qsR7UGbcMy4acl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:58:34PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> =A0=A0=A0 This new boards has MAINTAINERS file, but the CI reports:
>=20
> WARNING: no maintainers for 'nova-rk3588s'
>=20
> Could you give advice for this?

Yes.

[snip]
> >   arch/arm/mach-rockchip/rk3588/Kconfig | 10 ++++
> >   board/indiedroid/nova/Kconfig         | 12 +++++
> >   board/indiedroid/nova/MAINTAINERS     |  6 +++
> >   configs/nova-rk3588s_defconfig        | 69 +++++++++++++++++++++++++++

Here's the defconfig file, but:

> > @@ -0,0 +1,6 @@
> > +INDIEDROID-NOVA-RK3588
> > +M:	Chris Morgan<macromorgan@hotmail.com>
> > +S:	Maintained
> > +F:	board/indiedroid/nova
> > +F:	include/configs/nova-rk3588s.h
> > +F:	configs/indiedroid-nova-rk3588s_defconfig

Here's the entry.

--=20
Tom

--66qsR7UGbcMy4acl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQoOEACgkQFHw5/5Y0
tywFIAv/R6iZ/WqI6xOH01aaNJ6WicZ1ks1uZq1CMu0BKLncvdgOw7zZ1EmYd9m8
JuYQCrH1uMuX7w6F7RCIbOYzSxl0jnpXAr8hpmgBTgl5+2PhFPUSbrNftDw28ZDs
fKKe27DXw9PFhaL7naSPnngKKb3bxKZ1rJ0tKm7gUFj6HzDkMWpJktg9vfhQCwNt
g4VIAnliaxOwUjES4UIk1D0OZCRbatur9ghN2UPrBBqm+pm9IpR3djiz5Hdl9iyx
0VUh8z88FfuQQuZ4WmcIsEt6z85Wr3bHJkITiGRDqyeJJm6vhmfVLwgEI7E+uUlM
d7mbNjWPV8qUDbvYk/psNpfxpSe17R/ze9JwrwpCwd1wg0BAW8/9tJb3BMfbvWrs
ALJALuZ2BXGERhK5RpUBXLd4DYy/KeAdYoo2tk+uITwGACShtXnExK6c9LXwexpr
DOMiU1rrondMKk+IOF+qKqOKN3IDBm/60Wf0BVy4tj0KU4SuKQ+Jbu2vccvQLWhw
l/eXwgn9
=wbWc
-----END PGP SIGNATURE-----

--66qsR7UGbcMy4acl--
