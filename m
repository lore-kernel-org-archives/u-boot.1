Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E570F46C4E
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 16:11:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97198405F;
	Mon,  6 Apr 2026 18:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s7tZsD8q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFA448406D; Mon,  6 Apr 2026 18:11:04 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AEB48352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 18:11:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbcb467f2bso2328659a34.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 09:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775491860; x=1776096660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5V1cNsaY7g7gr3z9L7KY1mzqqFSmdN1pARVuNvjkeUo=;
 b=s7tZsD8qcC29pJA0b3gNX56Upv1R0sslGLI+MD6My5IRAVTAzJM1XYgrs05vyBz8kR
 6Ep181Vkn9XpxirOQMzaOTOcMojQozazzaz0Ej3HP1tRYSb1yJ5OrBWbq9xwx0a0CZLd
 ajpp13PcqJusWaMZWIDt/wz/8LOtpkVfETcsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775491860; x=1776096660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5V1cNsaY7g7gr3z9L7KY1mzqqFSmdN1pARVuNvjkeUo=;
 b=XGllKVqCWvQ84yGlHQTSjR7f3R7KoA5C3H9iTpbMLdQEEeyB887JnT3c8K1N19M+4K
 fD8brAhMWbzz7o0yEfiVhhdIkMlKOcjE51JWLE9ikT2H489cfdOZBTuWj8uZG5njielY
 N4dk7jkTX++21lhYAi7IHHz92YNjG/88ZXCy9Ffxd/N2H35649vHMsmsOApvUaEdvddm
 8tRwbnpV5VMpaEpvlcVGOKrzqL+O/cuB0pEOVM8txASZf8x8DTvnf4yaIZBhN6Gfjjza
 4IbDJyd0yVV5PZUknOCRRJYSxlETjL6kRkV8xEYkGPRADj0kPnbaAmOaihHnHSGgcNQK
 7d4Q==
X-Gm-Message-State: AOJu0YxWIjsZgUeDERLaABAHTnGPYv4+av2eJKd4PwVlJvbJwGcIMTIx
 YvK2U5BeSdW5AIHa4PLevmrgfvCYLw5my6VrRvUMVHs5b2xJe7q2HMbEEI+zeFsFia0=
X-Gm-Gg: AeBDieu/EG3YndQKjJ2RlZUwI/5qKJfx2o+D+eTnI6T3xZPpaeVfZcPJEG3TsSaMuPN
 Fu7jfBFm6eGgCPcE5TkfvhHGgfKi1MNzV67/k+EVV6jPb1AY6nwlz4RzTD5x6GirKjEDxE8JBGA
 mpB2FW23LlaIVQaX0IvnZdNaXfac+Q8DoL+AsFlyDL67aq2RgFr/7WYBnOp8qwXqRzWzgoutc8L
 Avr7EQEG+Hgo8pvf4DkuR1SBAPfnECIJijR+3q/3HGIA/lar+1Ag2sSW6bjgn1m8bJpJhiY4JpO
 Bwg10/mM/U+Mz0R1rb/4avnHtYkGN0WAtkMC5KDnJaYdnmv36QKLq+pp1F9sRzvN/8TS5yWQMKB
 N+aqwcQJ1fGshgwHafp4jocztI7fkwN3pmp/0bjMctkHCSKsBU7DN378EZz6HdP0KfU55AMy7D6
 mWGvJYB54gA1WKjSzBB5G+Qa8r9HM0PA5Yu/mJ5SXL+r/0u4jUdkWlq82Hjdjeqd7zi0wK6MQxc
 2NYG4qYf8xCPrVhPkv1HG0aVAx977pyn5DIYfoGB0x2qhDc
X-Received: by 2002:a05:6830:2546:b0:7d7:49bf:48cf with SMTP id
 46e09a7af769-7dbb6ee704emr8439082a34.4.1775491860559; 
 Mon, 06 Apr 2026 09:11:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba73d8126sm10271333a34.27.2026.04.06.09.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 09:10:59 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:10:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
Message-ID: <20260406161057.GS41863@bill-the-cat>
References: <20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org>
 <20260405-ui-cosmetics-v1-1-bffec3cac741@postmarketos.org>
 <20260406153000.GP41863@bill-the-cat>
 <td2xjd.37hr0tkamw99c@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DFfJ9fm+NhOIYrmH"
Content-Disposition: inline
In-Reply-To: <td2xjd.37hr0tkamw99c@postmarketos.org>
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


--DFfJ9fm+NhOIYrmH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2026 at 03:39:38PM +0000, Ferass El Hafidi wrote:
> On Mon, 06 Apr 2026 15:30, Tom Rini <trini@konsulko.com> wrote:
> > On Sun, Apr 05, 2026 at 10:49:04AM +0000, Ferass El Hafidi wrote:
> >=20
> > > The autoboot prompt used to only be customizable in Kconfig when
> > > AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
> > > autoboot prompt alongside a splash screen, there is no reason for
> > > AUTOBOOT_KEYED to be required for this.
> > >=20
> > > Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
> > > print_boot_delay() instead of a hardcoded string.
> > >=20
> > > Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> > > ---
> > >  boot/Kconfig      | 31 ++++++++++++++++---------------
> > >  common/autoboot.c |  4 +++-
> > >  2 files changed, 19 insertions(+), 16 deletions(-)
> > >=20
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index bfed452d77e..6c8ec356996 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -1560,6 +1560,22 @@ config AUTOBOOT
> > >  	help
> > >  	  This enables the autoboot.  See doc/README.autoboot for detail.
> > > +config AUTOBOOT_PROMPT
> > > +	string "Autoboot stop prompt"
> > > +	default "Autoboot in %d seconds\\n" if AUTOBOOT_KEYED
> > > +	default "\\rHit any key to stop autoboot: %d"
> > > +	help
> > > +	  This string is displayed before the boot delay selected by
> > > +	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
> > > +	  output indicating that autoboot is in progress.
> > > +
> > > +	  Note that this define is used as the (only) argument to a
> > > +	  printf() call, so it may contain '%' format specifications,
> > > +	  provided that it also includes, separated by commas exactly
> > > +	  like in a printf statement, the required arguments. It is
> > > +	  the responsibility of the user to select only such arguments
> > > +	  that are valid in the given context.
> > > +
> > >  if AUTOBOOT
> > >  config BOOTDELAY
> > > @@ -1597,21 +1613,6 @@ config AUTOBOOT_FLUSH_STDIN
> > >  	  This can't be enabled for the sandbox as flushing stdin would
> > >  	  break the autoboot unit tests.
> > > -config AUTOBOOT_PROMPT
> > > -	string "Autoboot stop prompt"
> > > -	default "Autoboot in %d seconds\\n"
> > > -	help
> > > -	  This string is displayed before the boot delay selected by
> > > -	  CONFIG_BOOTDELAY starts. If it is not defined	there is no
> > > -	  output indicating that autoboot is in progress.
> > > -
> > > -	  Note that this define is used as the (only) argument to a
> > > -	  printf() call, so it may contain '%' format specifications,
> > > -	  provided that it also includes, separated by commas exactly
> > > -	  like in a printf statement, the required arguments. It is
> > > -	  the responsibility of the user to select only such arguments
> > > -	  that are valid in the given context.
> > > -
> > >  config AUTOBOOT_ENCRYPTION
> > >  	bool "Enable encryption in autoboot stopping"
> > >  	help
> > > diff --git a/common/autoboot.c b/common/autoboot.c
> > > index 1783ef92c94..d12d618fea3 100644
> > > --- a/common/autoboot.c
> > > +++ b/common/autoboot.c
> > > @@ -379,7 +379,9 @@ static int abortboot_key_sequence(int bootdelay)
> > >  static void print_boot_delay(int bootdelay)
> > >  {
> > > -	printf(ANSI_CLEAR_LINE "\rHit any key to stop autoboot: %d", bootde=
lay);
> > > +#ifdef CONFIG_AUTOBOOT_PROMPT
> > > +	printf(ANSI_CLEAR_LINE CONFIG_AUTOBOOT_PROMPT, bootdelay);
> > > +#endif
> > >  }
> > >  static int abortboot_single_key(int bootdelay)
> >=20
> > We shouldn't need to guard this, as it's always prompted for now during
> > configuration, yes?
> >=20
>=20
> I did this in case it happened to be unset, and also to provide a way to
> silence the prompt entirely.

I believe it must be set (there may or may not be some fun around
CMDLINE=3Dn), but this doesn't allow for the prompt to be unset, if I'm
recalling some of the fun around Kconfig -> defines works (defined to ""
is not the same as undefined, we would need to add a new bool Kconfig
option, that's why there's USE_PREBOOT and PREBOOT for example).

--=20
Tom

--DFfJ9fm+NhOIYrmH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadPbCgAKCRAr4qD1Cr/k
CoAPAQCasBuAYNX0ZFVTAafjHur2UfCvgy+lm55iWs2AHZiZCQEAzkbZdaiOqGsC
hFdK4qR/xnOcsDwRi6nW2rRBq1BOkwA=
=/MGN
-----END PGP SIGNATURE-----

--DFfJ9fm+NhOIYrmH--
