Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECDFC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 21:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAD2484A9E;
	Tue, 30 Jun 2026 23:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qCanZ3/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2E3D84B0C; Tue, 30 Jun 2026 23:34:04 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D7084A52
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 23:34:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-69e1f777bcaso696376eaf.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 14:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782855241; x=1783460041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2EajGS5a81cQdEsdzG4GdsLcJD6gdIK1GUxxUzOFJfI=;
 b=qCanZ3/MionQTzOmjnsR1C2OZYJpCLjpiHKUQb/ZhtoXV5KyWXDyyOIPhGMGZ2raTI
 WTtIsH60S+K+p97eUMiB2evXqcN/CmZ8WIqUTTwXalt+11y4ikWWdbvqB4agDbRaA51n
 fscTrFIyr5aNInKgKzI3FX5zctWZEyRSZKV3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782855241; x=1783460041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2EajGS5a81cQdEsdzG4GdsLcJD6gdIK1GUxxUzOFJfI=;
 b=Z6BqYEDgpdQFqySfH859vGIW55uGhYNNp3GRgYOb63BCzzswMMU+atKMRqezgS+8JG
 rVvHADtM/4p6NR6tuiOepxzuuLSqfjTe2SCi/HDeRsboWE+Bhht1PYld8p5IIu71jJC5
 /+Fl4H4S/m/3wWSSvQzrTEle1tttEgZ6kwf+pRSZt/mf3/dh4S18+wnMWQgo4hbIBk4i
 zF1+M4JLaAc3vqeip5IzhMC8y2JpByjjuO+mgdyx/ipGtyZ64r5ib4YgxJNkdnXpuhjU
 XHn8KX1mPgMSK5ad3NLILLUFbwWnC+EoTc2fGPFnqyAR5oksru94hdL9PZyfzLofpHgQ
 RjSg==
X-Gm-Message-State: AOJu0Yy17hnPGAYPbABAy4EiyOlRCMcy26zuMngwtsERGBZpG703Kdco
 O8J+CPC7hxgPG4C8VsskGuihoab/nnJpuiCZeQBNVtj+QyhswDgc0RPiwiSmFxztnJ/w0GArTDX
 MAKX8MvY=
X-Gm-Gg: AfdE7cnbmjhWZAzQ+x3Vl4SE0+CajtEIxSyzO2Yrk9sNUnTteLLYEu0U8N3MEECytJ4
 cjtgE2Tt9zb2IOxdtKv/D/8lzzrfzRFjzKcmzkE13HVwm1uPKxsokxxIg1m8m4CiSOC0KpQ/Ph+
 tHoJiA9MreWd3CYOSyrBqiR10EOrLEx+04nL1ivvWWNLqXmPEdbfEVoEQ9WpnQBhWjLgpK1DQh7
 SxpNbJ4v6XOHAFe1H4GG2lrWz5SBUzsV6euDbfJb8JRw8oCH52W3S7eEXwDwZ3h0lSnIzpLKvrl
 t3mcfTHA4nbgMOWnByWeaXvrpfhNYCdsEltsBB1NU8wpVaTmee+VVcVJR2eBKAC+7Ur6t618lih
 wMkb4yFlhgisG1Jt7o+Cu/urYOfJetv0e+tLifyAlBLr8yrNsN7o3DJ4ArCaNoA/VQb7XFsra2b
 R6ZnJEm9Fka85iXy0LAycyWmfD228UmRr0YB6FsMAEDR8euku2/ON/go0b7PFztaZkM1SmYysKt
 ZRRyrLb8ugdD6Y50f/JFhZ2S2gbvI+c2Pzbt3mT/sodeVHZG3M=
X-Received: by 2002:a05:6820:168d:b0:6a1:7897:5b04 with SMTP id
 006d021491bc7-6a192069f71mr1720298eaf.1.1782855240712; 
 Tue, 30 Jun 2026 14:34:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44c6182eb00sm56012fac.6.2026.06.30.14.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 14:33:59 -0700 (PDT)
Date: Tue, 30 Jun 2026 15:33:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] get_maintainer: ignore Tingting Meng
Message-ID: <20260630213357.GE749385@bill-the-cat>
References: <20260616131133.2143136-1-casey.connolly@linaro.org>
 <20260616143649.GH382693@bill-the-cat>
 <151e43ad-d1d8-4c14-a541-0824abb7186c@linaro.org>
 <20260617172654.GR382693@bill-the-cat>
 <e3511960-44fe-4faa-8da5-aed28a677ca9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2MVutSgor1NRVOJY"
Content-Disposition: inline
In-Reply-To: <e3511960-44fe-4faa-8da5-aed28a677ca9@linaro.org>
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


--2MVutSgor1NRVOJY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 09:18:35AM +0200, Casey Connolly wrote:
>=20
>=20
> On 6/17/26 19:26, Tom Rini wrote:
> > On Wed, Jun 17, 2026 at 05:03:52PM +0200, Casey Connolly wrote:
> > > Hi Tom,
> > >=20
> > > On 16/06/2026 16:36, Tom Rini wrote:
> > > > On Tue, Jun 16, 2026 at 03:11:26PM +0200, Casey Connolly wrote:
> > > >=20
> > > > > Their email is no longer valid and bounces, ensure we don't inclu=
de it
> > > > > in get_maintainer.pl output.
> > > > >=20
> > > > > Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> > > > > ---
> > > > >   .get_maintainer.ignore | 1 +
> > > > >   1 file changed, 1 insertion(+)
> > > > >=20
> > > > > diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
> > > > > index 899a1469b2ae..5b7d84646f62 100644
> > > > > --- a/.get_maintainer.ignore
> > > > > +++ b/.get_maintainer.ignore
> > > > > @@ -1 +1,2 @@
> > > > >   "Pali Roh=E1r" <pali@kernel.org>
> > > > > +Tingting Meng <tingting.meng@altera.com>
> > > >=20
> > > > The .get_maintainer.ignore file is a heavy-handed measure for things
> > > > more serious than just bouncing email. It looks like Tingting Meng =
just
> > > > comes up via git history and so will roll out of emails in a few mo=
nths
> > > > now, so I don't want to go this path.
> > >=20
> > > Ok, that makes sense. I have found bouncing emails and excessively lo=
ng
> > > CC lists to be a bit of a recurring email when using b4 prep
> > > --auto-to-cc, do you have any ideas on how we can improve this?
> > >=20
> > > Maybe we could tighten the timeline and/or contribution weight a bit?
> >=20
> > It's hard because we've had contributors at both ends of the spectrum
> > speak up before. I think what Marek has been doing to use "N" to get
> > more files covered by maintainers directly helps so that more things
> > will always have someone else see them and in the future maybe we can
> > try and lower the git range.
>=20
> Hmm I see. I've been getting some feedback from folks who have contributed
> to Qualcomm support that they are being CC'd in too many patches as well.
>=20
> If we will keep --git for then perhaps we could try and tune things a bit=
 to
> be less aggressive? Maybe something like:
>=20
> --git-min-percent 15 --git-since 4-months-ago --git-max-maintainers 2
>=20
> Still less than ideal for defconfigs and such but at least it would reduce
> the huge CC lists that "b4" currently makes. I think 4 months is more
> reasonable than 1 year so things will cycle through faster and folks will
> still be notified about changes up to the next release.
>=20
> That being said, if folks are speaking up about not being CC'd in patches
> that touch code they care about they really ought to add themselves to
> MAINTAINERS... We have board/qualcomm/MAINTAINERS for exactly this purpos=
e.
>=20
> The --git flags will never be perfect imho, but would you be ok with the
> changes above? Or any subset of those flags?

So, 4 months is only a bit more than one release cycle. Maybe 6, since
we're currently at 12? And I don't disagree with saying we need more
people to list themselves under MAINTAINERS if they're interested. The
feedback has been less on board / platform code, and more on general
code that just won't usually have a specific maintainer, and due to the
slowness of testing cycles on a lot of platforms, it takes a while for
corner cases to be found and reported on or a workaround / fix proposed.

--=20
Tom

--2MVutSgor1NRVOJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakQ2QQAKCRAr4qD1Cr/k
CsDLAQC08K1PEv4dJ5x0aqXGNn7/h9z8kift3zoqyl9hVE6D1QD7BA+lsZnt+SfA
x7qGWyaeevO7yPqqVfl3FPhqSihKOAU=
=pfLd
-----END PGP SIGNATURE-----

--2MVutSgor1NRVOJY--
