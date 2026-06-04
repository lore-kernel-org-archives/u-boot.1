Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2E2CD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 20:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23B28849A3;
	Thu,  4 Jun 2026 22:22:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4ATyHk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F6BD849A3; Thu,  4 Jun 2026 21:03:43 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640FF84957
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 21:03:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e6cfdc92bfso389434a34.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780599819; x=1781204619; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xswlS4KYhWMb4IkPKo+t22QpF8fExe7NwtDxkWyucbU=;
 b=N4ATyHk/0cG+77rCna0LBCC3cUdfIP3KxSMAuYv+68DucpEHdeTp8Q1ue3Dx/8YZJq
 04wEARI1nj2XPb1u5QQJ3Z8pJkaF4TAoDkKkYPAfJOgccOmeusGpMZDG0disa+LFKbAF
 TBudv8CzCNLbfctuzfZQHPHUCJzdaXP/j9Q2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780599819; x=1781204619;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xswlS4KYhWMb4IkPKo+t22QpF8fExe7NwtDxkWyucbU=;
 b=riSOtmpd2zwd/exKXB2HLngiGlk34dY9MQMlbP5sPfHsUvYxRGzpL1VET4JYtxNjhL
 u46RB/UT/WaiWc35cNwNR1oVOCcP7hMOGcpDBqo9QT+gu/osuKiK6fw1waxAdasXmBSk
 V172zR/GyIbc4vl7Yri2pOQeMDrN/hG+/GtsrDzomULFkgFkBIZtT/mv+0CxFqvIk/5S
 DX1f1//hypnAJblyfDOQJB5uk71F4RF+Jdg8+PgHSPT2fyJxB9VUamZ2n6YQqkp542/y
 kuevDKQ2iDyx2UJpvDhI+Hk+0i4q2aflTPhDtmN4MwdCIcrRU2EQbuSgd0xN4TSjE7m+
 cCCg==
X-Gm-Message-State: AOJu0Yyn4J64rfois4RkM8rStzjdtU5S/d2Rufbk3PYSh9t4BzMxh5yh
 5dUmFFjuxh7gIdzff7U2ltx9LFt3QDB6qlvuMBKd3qNk+jQI3JUrValMExdFc3x7EAo=
X-Gm-Gg: Acq92OGvbEd/CoSN/ujpE6/Cw4EMAcETS1vZryx/32ZGBVMqzlZUxLjAY25JgjH3X/W
 yjZna7P0Aq4OqZ2zRH8MuNd/iWMd7l78N/7MXwfRAP1gkA2T0HhAAt6Nnmq+6Q/8BECJ/6YJLI9
 +B/Kt+YCjKRa5S6a64PfJ2Ml6Zt3RdC8Jb/13ePN3OcXMDxff7holD3BalqV8vPx2ilAby7iMhO
 iIZMw5H+ojEemZWfL0KUPjXdl9wMIjhdlpC81l8EhWZBxjgR+Nl7g5cjXdUEax5CnK6vypR2TQt
 2IWoGFRfp6BgiDG7W40V8jnqyha/fFojn8p2ocYtFyCYnClHFiu2QrQXftLe6DnLdAOt7kFEbdm
 n+i5RHZ/F0gZ/T/MbqFVT67ZA2SmbjQjIQqnJQhJXUfsCLo9rGU1sGY9apcdYazIklBg4WFcJEl
 S13d7h/2bp7igtDoLMx+LfXKwohEycBwcNYkzRZaC5lsp8ejeAoP/MXfV6z1ZLvI9P3Pdb0w620
 eVbVnVzZLsdnyMDs+6Qh0x/GMhIU7sPdsKYCz4GdRquyn8bbd/EN9KxfpUQww==
X-Received: by 2002:a05:6830:6687:b0:7e6:f5bc:496 with SMTP id
 46e09a7af769-7e6f5bc0dc7mr4422178a34.16.1780599818777; 
 Thu, 04 Jun 2026 12:03:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e7468fa7sm4383663a34.1.2026.06.04.12.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 12:03:38 -0700 (PDT)
Date: Thu, 4 Jun 2026 13:03:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: u-boot@lists.denx.de, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Heiko Schocher <hs@nabladev.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Charkov <alchark@gmail.com>, Simon Glass <sjg@chromium.org>,
 Yao Zi <me@ziyao.cc>, Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2 0/6] arm: omap: Add back omap4 support
Message-ID: <20260604190334.GW627328@bill-the-cat>
References: <20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com>
 <046255c0-2a21-4f1f-b6b9-135e2e376da5@bootlin.com>
 <20260604142913.GQ627328@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tmGu9Lgx9db+Y8B4"
Content-Disposition: inline
In-Reply-To: <20260604142913.GQ627328@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 04 Jun 2026 22:22:28 +0200
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


--tmGu9Lgx9db+Y8B4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 08:29:13AM -0600, Tom Rini wrote:
> On Thu, Jun 04, 2026 at 09:51:01AM +0200, Bastien Curutchet wrote:
> > Hi all,
> >=20
> > On 5/21/26 8:45 AM, Bastien Curutchet wrote:
> > > Hi all,
> > >=20
> > > This series aims to add back the omap4 support. This support was remo=
ved
> > > by commit b0ee3fe642c ("arm: ti: Remove omap4 platform support") beca=
use
> > > at that moment, none of the OMAP4-based boards had done the migration=
 to
> > > DM_I2C.
> > > My use case is an old product based on the Variscite's omap4 system on
> > > module. I needed to upgrade U-Boot on it for security reasons. I think
> > > that this work could benefit to other people who may have same kind of
> > > product to maintain.
> > >=20
> > > Patch 1 to 3 remove the omap's clock driver dependency to the AM33xx
> > > as it is also present in omap4 platforms. I tested these changes on t=
he
> > > beaglebone black to ensure I didn't break the AM33xx case.
> > >=20
> > > Patch 4 & 5 revert the deletion of the omap4 support. The revert makes
> > > checkpatch.pl angry. I fixed quite a lots of warnings already but it
> > > remains two kinds of warnings:
> > > - CamelCase on timings structure, I left the CamelCase because IMHO i=
t's
> > >    more readable this way.
> > > - #ifdef CONFIG_XYZ shouldn't be used anymore. I left one of this bec=
ause
> > >    I didn't find a clean way to get rid of it.
> > >=20
> > > Patch 6 adds support for the Variscite's system on module. This syste=
m on
> > > module is supported by the Linux project through
> > > ti/omap/omap4-var-som-om44.dtsi
> > >=20
> > > Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > > ---
> > > Changes in v2:
> > > - PATCH 5: Set myself as OMAP4 maintainer
> > > - PATCH 6: Set SYS_CONFIG_NAME to ti_omap4_common to get rid of omap4=
_var_som.h
> > > - Link to v1: https://lore.kernel.org/r/20260519-omap4-support-v1-0-b=
4a2a7435775@bootlin.com
> > >=20
> >=20
> > Gentle ping here, has anyone had time to take a look at this ?
>=20
> It's on my list, thanks.

This breaks building on am335x_evm among others. Please make sure that
at least all CONFIG_AM33XX platforms build, or use CI to test
everything:
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html
Thanks!

--=20
Tom

--tmGu9Lgx9db+Y8B4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiHMAgAKCRAr4qD1Cr/k
CjUCAP9sG8dtMRRetTWt07qdpgnbT8ECihFoADVSz2kAWFLxDwD/ZJ88FSGXGJtg
EtGLmXwyR39apB/0M0NuEbW26KJPJgs=
=mNlj
-----END PGP SIGNATURE-----

--tmGu9Lgx9db+Y8B4--
