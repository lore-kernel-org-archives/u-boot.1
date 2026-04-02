Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F351D6AB18
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 23:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7892583DC9;
	Fri,  3 Apr 2026 01:30:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nU0fcOSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB6C839DF; Fri,  3 Apr 2026 01:30:37 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A106283D8A
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 01:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-46808125c65so494678b6e.2
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 16:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775172633; x=1775777433; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fXHnIGL0Liudu36Ree3/pXE3LWvIwVti2/GjjXPQbgo=;
 b=nU0fcOSFeqsbTCYHUO1HB+x29trvvBXQ/1/5LcnUK6rH4v/AJy7oijjHzbzYUWqhDp
 4XoODP9Oyf7ru9q+9bDZROGX5e4KC/WlL2QLpDWRnLJeaqfnh5IPDlroiMUvodZAIwOA
 P51k7vJqnkde7UI3qZZxvrivIJanUlYCtmJTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775172633; x=1775777433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fXHnIGL0Liudu36Ree3/pXE3LWvIwVti2/GjjXPQbgo=;
 b=Xn23I4Kr1J9cmFCdhUslpqL9MqjgEGnem8Srcpl0hBJTnKaj7Kr71FJ6ZhyFgBE8m3
 Gzemq8UTf/zS01RB+veKD2dzdjGVpsWomGwraI25h5xD7X1s6XJAKG+CZIvX1Na2WfgE
 G3JFGpJprkKnW0j2jPws1TV11Wk7YBbQpcpAl6DzIS7jE/dRr0oIS0cvvXx/NkZJTkvL
 OmtY0mbmLh1h+BKMRcUW430r5YT0vMdOlJq9ZBxh6T/97js5QbVYBXS+BjHEWwOKB8HB
 i5i8jxpGg3gJaS8GUbCGMEpjzQsJGHWO9CdC8Uj7FkzTjaLft8YkHnOBhWbHge4Q1A7G
 msaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUKFszNAewTSDguixiFoy21P/bqO0v2VEZTSt74GCo5VN79BqvUu8o2nlmERDrZjN+AiLEvaE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5EqrQILLo/iBgxgmd3fR7PoSLA8AQpie2ZoP0D4Ob9sFi2V0N
 SRzaDMvAWiq3sz+MfIKEEmKCHyCB8voUEVeG6s/lvn6S5eQhbFR7OOPFwGaQkCw/db4=
X-Gm-Gg: ATEYQzwV+j4bIhN/fSQT+a2uD2Jn6/JfN+PS4Yt0oDRp8G4wQjYSE7iJ8LcffcRl2if
 4HT+Rl0+GGydFhzafvS8dRyTfCBvLXYHmqW7QiwZHptYI4kjKPFx6idDBXL4za6BvNDLbrU5DD5
 CkcnlX0qur77Y7jPMKEiZAzCF9Oz3GBHJpnb3bOtUf06RSbKKF95hMZ3p85Vxcw0206sbYZJOSp
 xdEs9U5W5J5AGfEpZQL+WrdO2RhGNx504ThVs9VqmP4VWMSDhghFCL2sXNkFiiQdQ17DZnKtiqK
 BFyowlBgDK5dSZ4UFDU4NHDGOHsoDf0SqAPnqEiUZ5uRMoD95NLlhH+nmUCTNLquscWUkiKUiQ6
 cD5bMSUBt6Qu+yVBzqcZaLJTRcogp6skAdPZlb7uuy5N1jaSX5lBYAIUfyz/UpSVfggwREdEG3b
 h3gj6K8tHIEbv5vVuatDXH3xuQY5e+9XD5RnOezVW9k+KgiPh9rG7CVb6LcU/GK4mv0nXimF6k6
 ij9imO1DND5LnU15Rfj25leyb+dwWM7h0wfJm6IsFpp7Hgb
X-Received: by 2002:a05:6808:22a8:b0:464:82b8:efff with SMTP id
 5614622812f47-46ef791a124mr658980b6e.29.1775172633287; 
 Thu, 02 Apr 2026 16:30:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d92f66ca2sm2474269b6e.13.2026.04.02.16.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 16:30:32 -0700 (PDT)
Date: Thu, 2 Apr 2026 17:30:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Franz Schnyder <fra.schnyder@gmail.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH] board: toradex: Quote variables in `test` cmd expression
Message-ID: <20260402233029.GI41863@bill-the-cat>
References: <20260331-fix-test-cmd-empty-v1-1-56cb93fc8f43@toradex.com>
 <20260401051027.GA4471@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EtrmaGb62mDyOhDn"
Content-Disposition: inline
In-Reply-To: <20260401051027.GA4471@francesco-nb>
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


--EtrmaGb62mDyOhDn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2026 at 07:10:27AM +0200, Francesco Dolcini wrote:
> On Tue, Mar 31, 2026 at 10:10:10AM +0200, Franz Schnyder wrote:
> > From: Franz Schnyder <franz.schnyder@toradex.com>
> >=20
> > With correct POSIX handling, unquoted empty variables can turn the
> > expression like
> > 	test -n ${fdtfile}
> > into
> > 	test -n
> >=20
> > The POSIX handling for single argument `test` evaluates it as true,
> > so the fallback initialization will be skipped unexpectedly.
> > Quoting variable expansions in `test` expressions will always result in
> > correct behavior for empty and non-empty values.
> > This change was triggered by
> > commit 8b0619579b22 ("cmd: test: fix handling of single-argument form o=
f test")
> > The aim is to have a less fragile codebase that is not dependent on a
> > quirk of the shell implementation.
> >=20
> > Use quoted variable expansions in `test` expressions throughout.
> >=20
> > Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
>=20
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

I've decided to go with:
https://patchwork.ozlabs.org/project/uboot/patch/20260330140106.401876-1-ra=
vi@prevas.dk/
to make sure that everyone that might hit this problem doesn't end up
broken, thanks.

--=20
Tom

--EtrmaGb62mDyOhDn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCac78EgAKCRAr4qD1Cr/k
CkrVAP0Q1YDs2SYoEYHqTFfiLb7RrPnYcqxRwFHAPsjRRKMyewD/STeyWq4Kj71Q
oi1+AwKDTx1KqXHj4V3Ey7Ff4YJuXAA=
=fFce
-----END PGP SIGNATURE-----

--EtrmaGb62mDyOhDn--
