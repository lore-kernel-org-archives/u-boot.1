Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A0ACD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 14:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7A77848A1;
	Thu,  4 Jun 2026 16:43:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Up5WceRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 442A3848DF; Thu,  4 Jun 2026 16:29:22 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A65848A1
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 16:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e701435806so394086a34.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780583358; x=1781188158; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yhtkb8hWri3/rQKhYJAJc9L0zowMzAFenllyuv5ROAM=;
 b=Up5WceRdis7htHfb68I6oShTPsGhGe8YygnuhYqWFQuNA0T0iM2cL+5pvtU5b7/WiK
 nSj92DFsyv1DOCU/69zFRob1LrVXKp2SWOZ2FrqrKc0FqnONIUWfCjzSGs+O0uHlssOJ
 2dnpg52QvpINhEjTa4ShJL97X/H/MM2tnPXRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780583358; x=1781188158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhtkb8hWri3/rQKhYJAJc9L0zowMzAFenllyuv5ROAM=;
 b=ZY2L9CAY47umnIB9DSCl3Lo9XDx4pk77J8MIopu+d2Z+7OqNYvZoZjHuNkxsK6qFlF
 cY69JE4k+cf8HQKII88PmLWfUvDvwUf6pYEkbb9ZX6bZWyptSH77/Y8tNfImesEAdfpU
 anCewpPHqxWfeKuFTCoRTenv9tguDAdhJMR0NZSO3ncR5pnVZ1/j94WD0VYpgfCEVw2o
 /ApTkbXQF7avXwYLjyRniWCNm2BVy5hP+ZkEnDzZMy2PRXbPYN1McgSHlsSexYhq6rMu
 O5PqDsC6e5bPKi+gMhZlMLdvI5ewKi6jPBq/JOFqy6YzC8buRERmQr8q0hAGVOAerv/K
 9Dvg==
X-Gm-Message-State: AOJu0YxuAaL83gawAfWtnuDfistzPFhJOaZ89LVc5Fv1hXE4D6jLOAP+
 9vQpVf+PHkdfZ1i5jN3iB+gSKTpxi6CoZgqsPRzip1nkd6bRroKlV8EENH28u5GsFkQ=
X-Gm-Gg: Acq92OHEeI7VMYY4t/ofe1qf3oovVlfvgENxqZSNlv18fDNlKamBcLfLLI+8tdfmGak
 8XJ/cpftl1rj5rFpTBpSEjjlgpeToznztjSlzpvpM9GiCXbF9fmdWhVX++l1y+g6E+SEhJfy2lv
 wOW1fIi0eS7PxEYZzOTanMhFmmVz8ZuCqmEUIRkcDbt2X4HVqHvTocctI0aAcVpSYD7BSPWbYux
 sBAY1A15Y6gZhGMOMR0RyIZUhiBB5GqvoYgTFw4EVMt42qqMzll17x8z6hsalwl8iz7ie0XeMlG
 wmc/KbbtValBHOG8UtplKZrCbPzNF8L62BgQOu2kGzFmgnsRQg7mYH297rgsxFEgRza8MtygSk0
 paTZ8lmcRfeXxXbnwNBP3T+JWjsn/ZZ1eWbu6kZlwAY5NGsfYHQchRL/aFHuWYYTw+h/oqBzPt0
 LjV+nUzkvtyjwqX2cRkLIG3ygigPv/VyZROZSnDQqFqhLrXmPXzzn5SabunkrY0olly3EzA14Ov
 icPBtxHB8V0WDh496d6W8O5dHbsUSWNm+625SHGU6/WKaSe+D4BzpVxNCH9FQ==
X-Received: by 2002:a05:6820:2acf:b0:69b:94ac:da1e with SMTP id
 006d021491bc7-69e47f76fabmr3275814eaf.31.1780583358416; 
 Thu, 04 Jun 2026 07:29:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7c42c33sm4831938fac.6.2026.06.04.07.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 07:29:17 -0700 (PDT)
Date: Thu, 4 Jun 2026 08:29:13 -0600
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
Message-ID: <20260604142913.GQ627328@bill-the-cat>
References: <20260521-omap4-support-v2-0-b46cfff7a47b@bootlin.com>
 <046255c0-2a21-4f1f-b6b9-135e2e376da5@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PAPD7uDutkcIhuZu"
Content-Disposition: inline
In-Reply-To: <046255c0-2a21-4f1f-b6b9-135e2e376da5@bootlin.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 04 Jun 2026 16:43:02 +0200
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


--PAPD7uDutkcIhuZu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 04, 2026 at 09:51:01AM +0200, Bastien Curutchet wrote:
> Hi all,
>=20
> On 5/21/26 8:45 AM, Bastien Curutchet wrote:
> > Hi all,
> >=20
> > This series aims to add back the omap4 support. This support was removed
> > by commit b0ee3fe642c ("arm: ti: Remove omap4 platform support") because
> > at that moment, none of the OMAP4-based boards had done the migration to
> > DM_I2C.
> > My use case is an old product based on the Variscite's omap4 system on
> > module. I needed to upgrade U-Boot on it for security reasons. I think
> > that this work could benefit to other people who may have same kind of
> > product to maintain.
> >=20
> > Patch 1 to 3 remove the omap's clock driver dependency to the AM33xx
> > as it is also present in omap4 platforms. I tested these changes on the
> > beaglebone black to ensure I didn't break the AM33xx case.
> >=20
> > Patch 4 & 5 revert the deletion of the omap4 support. The revert makes
> > checkpatch.pl angry. I fixed quite a lots of warnings already but it
> > remains two kinds of warnings:
> > - CamelCase on timings structure, I left the CamelCase because IMHO it's
> >    more readable this way.
> > - #ifdef CONFIG_XYZ shouldn't be used anymore. I left one of this becau=
se
> >    I didn't find a clean way to get rid of it.
> >=20
> > Patch 6 adds support for the Variscite's system on module. This system =
on
> > module is supported by the Linux project through
> > ti/omap/omap4-var-som-om44.dtsi
> >=20
> > Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > ---
> > Changes in v2:
> > - PATCH 5: Set myself as OMAP4 maintainer
> > - PATCH 6: Set SYS_CONFIG_NAME to ti_omap4_common to get rid of omap4_v=
ar_som.h
> > - Link to v1: https://lore.kernel.org/r/20260519-omap4-support-v1-0-b4a=
2a7435775@bootlin.com
> >=20
>=20
> Gentle ping here, has anyone had time to take a look at this ?

It's on my list, thanks.

--=20
Tom

--PAPD7uDutkcIhuZu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiGLtgAKCRAr4qD1Cr/k
CkzMAP9a4jbfPnM37Moz3mAR8tMZlqgPDKA88S1/4+H94MATNgD/SXXPbfA9O+QW
pSXKoYpCSpWMxx53Xq19sKnBk9DSGQs=
=v1Cr
-----END PGP SIGNATURE-----

--PAPD7uDutkcIhuZu--
