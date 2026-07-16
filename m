Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B057FC44514
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 20:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D3F84C23;
	Thu, 16 Jul 2026 22:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tcVfPocJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2ED084C23; Thu, 16 Jul 2026 22:03:26 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C42584B86
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 22:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-448b0ff4a57so2292761fac.2
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784232203; x=1784837003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qVbGCImfvRRgVW6FGrHGptjeNKXUBfFtcynxgi+9YPM=;
 b=tcVfPocJ82NR6HUrp0hB1ndOq6bO9sF3eicLpK3qrD53bM8Kb58mKO4o+GeaVBcY0c
 i6A5RvL/+H9QF3s4ibrT1jJPPHavferontUq55nnivj4zgE9Pe4rRVBIWP8Rg3EVWMok
 /2Kgxiekzi44btCEg8hW3qdqjQpjiG+EfheLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232203; x=1784837003;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qVbGCImfvRRgVW6FGrHGptjeNKXUBfFtcynxgi+9YPM=;
 b=DYG8hjuDWKs/fxeSjY9riyJa73lsJAo4QZ/1bN2nmaYqsfbtk/V2nXREEtvet2G4HE
 R/pflf70nX0B3qdzteRLMjOXz017mrtvMt9KQKyyry0lyxf8CbV5D//BhCMoU0W3Yxz8
 byYbo+egApkAw1YGd4Q8mxhYROTYDdIGvta0/hi5BGU2v/5sy+iVYGXrIXrz912npKny
 9luExlckAlq4x0tcBUnvUlYyOp4wiqGE7mswuXA+VIoCmXhIU1QalO3kjs1ou6+lRKsP
 v3v/MSXS7XfurN1xYYWXS0JBk9VZtJ6yA9qOUHZyMsm8qItk9qVtHjz0UuOQbvvIFHxq
 d4mA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSv/ZJNJ4zyUTDqDdOYNEJaHF4ECm/ri8CS9bgHapNdmOLNXxPPMoFygaKC7eK3KteOc9Gc1o=@lists.denx.de
X-Gm-Message-State: AOJu0Yzk37a9vjTBolBz/k9ou0LL6hqAc4J3U0GPjviKnx8lPxUG5fVA
 QJdbiqrXlz2hy/K5edxpN5FCd+TT16F7NNtL7wlmhSDWQ7nfdbLkodTC2icS5Wohwxk=
X-Gm-Gg: AfdE7ckJt5Xf6KAHziyC965Akbv2XEoAMykGnmVHjHrDD2AkPbK8V7JcPQJDmco+sYj
 ubPTd2qCmLnVis84YfKRx2SACQWWzXp6i6sJ1Tj4BAX8bfB0LNuNglsFb6fzC5Uf6FyX6QbejP7
 7YxvD/7FVC6GFhLFyxjk4NE877mWgfUC30132G+7bZyBV6fkT531Tv15oKsPswTasxz8g9hPB/z
 aZD19g3REkxVAYM9JbnjWEIOr/N+dec2Bd+2u5ZDhk/buPRnRN1DbfmIsTYrZ1NAzziDNCxNVQR
 2Mca9PUGdJvGXwXvd7DS+PZ5n1JZa4wUqKfqGtgSQhfLetW8mhvU9H4+q179mtI53kYMqOeUzlH
 Q6kxREuroqVTbcWC+l1FwYKboLVAixD6bV5LR0tzltaBMAo2PIM89VwThy1J/OtzMFbudqe8MAZ
 pTAhpE26Qn5rybz8MIQV2O/JLXAe2kv+Tf7SEXJrvuYtvz3zxIOC5jZ3EGuQkDWArfEZE+0+52a
 PeHY8b1Fp3XmEy0Ep99Vc4gVNS6IiTilylv7A==
X-Received: by 2002:a05:6870:b289:b0:448:ca54:6ba7 with SMTP id
 586e51a60fabf-45682b667b6mr352582fac.38.1784232202421; 
 Thu, 16 Jul 2026 13:03:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4546f12a6casm15319175fac.8.2026.07.16.13.03.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:03:20 -0700 (PDT)
Date: Thu, 16 Jul 2026 14:03:18 -0600
From: Tom Rini <trini@konsulko.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bohdan Chubuk <chbgdn@gmail.com>
Subject: Re: [PATCH] mmc: sunxi: support DM MMC in SPL
Message-ID: <20260716200318.GA3179201@bill-the-cat>
References: <20260626205153.2744981-1-james.hilliard1@gmail.com>
 <20260628171716.4a9d7793@ryzen.lan>
 <CADvTj4opB+XMbupiBZtmZnuvDUtyDFkjWR5E1u2QMTXzjMqzrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JCTRB0fO6hTDqb/1"
Content-Disposition: inline
In-Reply-To: <CADvTj4opB+XMbupiBZtmZnuvDUtyDFkjWR5E1u2QMTXzjMqzrA@mail.gmail.com>
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


--JCTRB0fO6hTDqb/1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 03:27:48PM -0600, James Hilliard wrote:
> On Sun, Jun 28, 2026 at 10:16=E2=80=AFAM Andre Przywara <andre.przywara@a=
rm.com> wrote:
> >
> > On Fri, 26 Jun 2026 14:51:50 -0600
> > James Hilliard <james.hilliard1@gmail.com> wrote:
> >
> > Hi James,
> >
> > > sunxi SPL normally uses the legacy MMC interface while U-Boot
> > > proper uses the DM driver. Boards which enable SPL_DM_MMC need
> >
> > I think I mentioned this before: enabling the device model in the SPL
> > (or not) is not a *device* decision, but a platform one.
>=20
> I'm a bit confused here, uboot's configuration system from what I can tell
> is designed to allow enabling device model for specific devices and even
> for specific drivers.

Right. And to be clear, in your tree you're working to upstream out of,
only the h616 platforms end up enabling SPL_DM and not all of the
existing ARCH_SUNXI, yes?

> Why would this need to be a platform level decision? Given that boards
> that don't have enough SRAM for SPL DM support tend to be older, we
> will presumably want to migrate newer boards to SPL DM at some point
> in the future anyways.
>=20
> > And for
> > technical reasons, mostly to support older devices, which have no other
> > choice, but also to keep it simple and the SPL small, we do not use DM
> > in the SPL on Allwinner boards.
>=20
> I mean, this seems to me to be justification for continuing to support
> legacy drivers, not justification for not supporting DM as well since the=
re
> are also many sunxi boards that don't have that limitation.

This would be a separate set of potential cleanups to evaluate later on.

> > I see the SPL as the continuation of the
> > BootROM, which is completely board agnostic.
>=20
> At a minimum SPL is still fairly SoC specific. Although in practice it se=
ems
> to not be all that board agnostic, I think if anything DM support makes it
> more agnostic by allowing better factoring of the device specific stuff.
>=20
> > The SPL can mimic this
> > behaviour, to follow the decisions that the BootROM made, for instance
> > about the boot device. The only difference here is the DRAM
> > initialisation, which requires some board specific data, but so far we
> > got away with just hardcoding it.
>=20
> This is one of a few reasons I wanted to get SPL DM functional on sunxi.
>=20
> > If that is not good anymore, I think
> > we can find other solutions than pulling in the whole world of SPL_DM
> > support.
> >
> > So what is the purpose of this exercise, why do you want DM_SPL
> > supported?
>=20
> Some cryptoengine uboot drivers I was working on adding seemed to
> need DM_SPL, also I think handling DRAM profiles becomes easier with
> it somewhat.
>=20
> > Keep in mind that there are 178 Allwinner boards supported in
> > U-Boot, so there better would be good reasons to change something
> > fundamental like this for all of them. It changing it for a number of
> > them is not better, because this doubles the test matrix, so we have to
> > test now that it works on both legacy and DM_SPL boards - which frankly
> > nobody will do.
>=20
> Well it doesn't actually double the test matrix since presumably boards
> that are not SPL DM compatible will continue to use non-DM drivers only.

And today nothing ARCH_SUNXI enables SPL, but they all could enable it
today and get an assortment of failures. With what James is doing, some
could now enable it and have it work, or more easily work.

> Wouldn't we typically just pick either DM or non-DM configs for upstream
> uboot testing/configs for any particular board to avoid maintaining more
> configurations than necessary in the test matrix?
>=20
> > And aside from that, please do NOT add any more #ifdef's to the U-Boot
> > code.
>=20
> This seemed to be how other subsystems handled both DM and non-DM
> driver support, is there a better way?

So looking at this patch, it needs to be split up a whole lot more, to
make it easier to review and clearer what's being changed. Also, there's
a lot of places in code where it looks like you're handling
dependencies that Kconfig should handle instead. By which I mean, if we
have SPL_DM_MMC and we're in the driver, we don't need to handle
SPL_DM_CLK=3Dn or SPL_OF_REAL=3Dn. You can find examples of that, but
they're older code that also needs to be cleaned up. It might be the
case that the driver itself needs some re-organization first to make
what your end goal needs, easier to do.

--=20
Tom

--JCTRB0fO6hTDqb/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalk5AgAKCRAr4qD1Cr/k
CvquAP9tevNMvFuX7neTsP5BzEXencq3HasymXy0bVzxnmFVhgEAqLUBsuIPuTYR
G4VczU1rZC5BiwnLStxp+uNHBB5sggk=
=k3dE
-----END PGP SIGNATURE-----

--JCTRB0fO6hTDqb/1--
