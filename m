Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2519D24440
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 17:15:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA2E8412F;
	Thu,  4 Dec 2025 18:15:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TxzsvUVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E3284131; Thu,  4 Dec 2025 18:15:43 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BB28410C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 18:15:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6598413b604so148639eaf.0
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764868540; x=1765473340; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=voUCEPd2hHoUNfHS9q7FjfDl8TwLuqj5p2brRe+YJ2Y=;
 b=TxzsvUVoduPl7PKLQxssrEvuaH3RFZ5wRH/ZP5ua7q1iyhNID4xXevpbNF4EMcxKyY
 PM6yYC5cI2IRN92qtChdhnVR/Bwx8w8peMtOpRFPKx0gzkImHIqGZXESPzmOgHuqUqeM
 29rFlpeUN9/hh2bocO8uf26rZ8KWjuAZ+zRvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764868540; x=1765473340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voUCEPd2hHoUNfHS9q7FjfDl8TwLuqj5p2brRe+YJ2Y=;
 b=GmMTDFaNs6UVRjbEQdpcGa7luAD+VBAaVoPlhJNfkC32btxaiTCDNj0y6s6vnG6HC1
 igFpk4N7BD/R1VUKbula3f5XtqnTkSGSUlWvkt9o2CowgKJulspXG81iWgMGhXokJ2Xa
 UbNI3E6n4feEGxuy2/WpGK2/BbTyDb0SfIBCdw3Ep5wpbSNizcNNAMn3IdB6PtgzHOfN
 A+ntAQUoTlx5XJ2d+QDJnox5Z9gcbY/MYb9L/8hgiTdcGRGVU5Pg8cuq2Y5cWQnFJxpA
 yjUjsSO9e7aHryszcb/wdn1GvfuoJwBU2yo12PoyzOxxHkIQC94NisQjh+VnhFh+v8z6
 9whA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU73r6r5ynQOcUJOoOnPQN/ttO4D7gf0RkcAk1iJ1cTQcNosQ/5c3eQ2EaVk6zsUZdYBoGi/rU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy49NGnAblAvXPIaap68BlSuec39X385ORa4DgJ+IuCf3w8ARGR
 3/v0ubR1tYstzr3KlIUYaP6lSjylrP0o1Ru4he4mmbUaABOK6vVotHqEObBt33y82AI=
X-Gm-Gg: ASbGncuO0XvydHHU8fft915gG+A+3Z8LiHumSOZ3Jw7VUv91FgSNLU4pQ5oZTyjZ/JZ
 tbMawB52xLU8SHfMKNrr2KWE3E+E4J5Ld7Sp7oIlsGa2TeDdFE/tiycsUPxqko53v554ZfxE9Fn
 zH1GeZSTYpb5cBPBUi7WehNWmlE27cGneOGFH2QlMuJ1eeJB7uZSBd2qhB6AmpzyN6GIEI3SAV1
 6t6OlaAItvDW1KSmBOv6ctU5339YGgJRtZi5Vsw2AOjkHgvpJxPXfOX5ic8yfhQC1J6mlLDoXNK
 XICHVLVMp52KiM/yq8KSSrAyDMkmBnwv1jVfcOX8DYzV09miEQNeNZPPqWKfbhZVtHNYD201Slo
 RFWwQ4hsRtG1zhgL+m/vRqi5+jJCWp0kYfurdpb2w2uKzxYazHLgmSVtq0XB2gHW3tUGps6uATI
 5wN8Cc2h2KlppNsjNwbrXj4aNSQhYQVO8/aP9UMa1gq2EKIldnHQ==
X-Google-Smtp-Source: AGHT+IHXoDFF+7eC2JliNlEC21G2W+lpGnUlSwQDFGK4L36pEnKP8ECSeXg2SJPNTQYT2KCV1SQioQ==
X-Received: by 2002:a05:6808:180e:b0:450:d568:a50 with SMTP id
 5614622812f47-45379eaac69mr2253032b6e.56.1764868539839; 
 Thu, 04 Dec 2025 09:15:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4537f89ee09sm927367b6e.2.2025.12.04.09.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 09:15:39 -0800 (PST)
Date: Thu, 4 Dec 2025 11:15:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
Message-ID: <20251204171536.GZ303283@bill-the-cat>
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
 <20251203161142.GQ303283@bill-the-cat>
 <e25260e7-70ce-41c0-aa89-a8fb5a406b57@cherry.de>
 <20251203162826.GR303283@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dGm2Imb3RsTn/eKU"
Content-Disposition: inline
In-Reply-To: <20251203162826.GR303283@bill-the-cat>
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


--dGm2Imb3RsTn/eKU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 10:28:26AM -0600, Tom Rini wrote:
> On Wed, Dec 03, 2025 at 05:23:47PM +0100, Quentin Schulz wrote:
> > Hi Tom,
> >=20
> > On 12/3/25 5:11 PM, Tom Rini wrote:
> > > On Wed, Dec 03, 2025 at 04:36:49PM +0100, Quentin Schulz wrote:
> > > > Hi Fran=E7ois,
> > > >=20
> > > > On 12/2/25 7:39 PM, Francois Berder wrote:
> > > > > If func->pins could not be allocated, one must also free
> > > > > func variable that was allocated previously.
> > > > >=20
> > > >=20
> > > > Well.... devm_* functions should take care of this when the device =
is
> > > > removed (or probe failed), but if and only if CONFIG_DEVRES is enab=
led.
> > > > However, in that case, this code may be executed outside of a probe=
 scenario
> > > > I guess (it is called in set_state() callback from the pinctrl devi=
ce). This
> > > > thus makes sense to me here.
> > > >=20
> > > > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > > >=20
> > > > I'm also wondering if we shouldn't check the return value of
> > > > single_configure_pins/bits in set_state instead of always returning=
 0?
> > > >=20
> > > > We probably need to devm_kfree a bunch of other devm_ allocations a=
s well?
> > > >=20
> > > > I see a loop in single_add_gpio_func() we should probably unwind if=
 there's
> > > > a devm_kzalloc which fails?
> > > >=20
> > > > Maybe we need a .remove callback where we devm_kfree all of functio=
ns and
> > > > gpiofuncs lists from single_priv, in case DEVRES isn't actually set?
> > >=20
> > > I've wondered, but not fired off a build to check, what the growth is
> > > going to be on default y for DEVRES. There's only a few platforms /
> > > chips doing it today and I think most drivers are written like the
> > > kernel where freeing is automatic, so there's lots of cases like this
> >=20
> > I see devm I assume it's automatically freed (or whatever counterpart o=
f the
> > devm function is) if the device is removed or fails to probe but that's
> > rarely the actual case.
> >=20
> > The issue here is that DEVRES is not enough, we would need SPL_DEVRES,
> > TPL_DEVRES, VPL_DEVRES, WHATEVER_DEVRES (added and) enabled as well as =
we do
> > compile devres only if $(CONFIG_$(PHASE_)DEVRES) and then surround code=
 with
> > CONFIG_IS_ENABLED(DEVRES).
>=20
> Yes, we'd also need to see about being concerned with xPL or not, more
> widely, with respect to DEVRES.

Checking this out now, and we've already handled the xPL case by
deciding that we just don't support DEVRES there (and there's likely not
space to do the work nor reason to, given the lifespan of the runtime).

> > > one here.
> > >=20
> >=20
> > I think this one is an exception as the device may still exist if the e=
rror
> > path is taken, so I think it makes sense to explicitly free it here,
> > regardless of DEVRES compilation state.
>=20
> And then it would only be the case of having to worry about some
> failure paths rather than how it's leaked today, if I follow things
> right.

Here's where it gets more interesting. For the cases where we could be,
but aren't, enabling DEVRES it's around 500 bytes growth, with the
reward that we get proper and expected memory management. The challenge
is that we have some platforms where there's nothing making use of
devm_kmalloc and friends and so we need to go around and manually select
DEVRES on functionality that makes use of it.

If this is a good architectural change, which it probably is, but
shouldn't be buried in this thread.

--=20
Tom

--dGm2Imb3RsTn/eKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTHBtQAKCRAr4qD1Cr/k
Ck6/AQDrePX2Jz3chiG2YSAt7dqnXCrp6UZpfeiEBN7JWlfEzAD+Pj2H01sBYuss
Dv8At3LTJYWCjPUfYTnZ5cbXBeQLkgk=
=y1oo
-----END PGP SIGNATURE-----

--dGm2Imb3RsTn/eKU--
