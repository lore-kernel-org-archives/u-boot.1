Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831F1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 14:05:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAA1886B1;
	Fri, 19 Apr 2024 16:05:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q/qDAt0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6BD688667; Fri, 19 Apr 2024 16:05:31 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE1A88693
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 16:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4391410b1c7so538551cf.2
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 07:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713535525; x=1714140325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ctm463pQgXHhyBdTDBB6xq86G/NAbAtIdT4+WpNb9Ls=;
 b=q/qDAt0SqGNGyzluvXNPO3kN5HkdcpBj8MBpldzqjSFiiiYR5FOZxXlz7+h8tji9Gl
 6Ih28fx2KT4BRKz3HpygzITI40dG74PFWcTsPMxcMaQWInyhFBdLw7kz8Gg41PqbGqjp
 GJprZFarnsX8D2O3pgPV5IsXfmn9foTlOctNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713535525; x=1714140325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ctm463pQgXHhyBdTDBB6xq86G/NAbAtIdT4+WpNb9Ls=;
 b=FqH9+v/t5D/0yrK28tOJqm6kST6wL1exvkf+RnZRY1xrKeNmmOa6ctKIA9XcStW1Ap
 SwHGJursMGdE+XxkLecE7kw2KoufX2IjxZV8NAAvNGE2CJ9f7q7y4vHUHTEnqSKxgcFN
 xQDsqE9mLipgS3BFNZEZefO4i8v4D9uLQNwqGC4FJLG2b9C8gp0iXgoXBGJC/yt0wHnY
 e/WnFpAisVdjSiDF6sdibMW3PUjhYuoiL34DvDUipTNoOOmok6apNqLbzlfEWRHu/Avc
 RgTQr6NOLR8YWwfTcMWwMYUbHI+cwGhwX0VW6dc90F5OsxqymWQILOJgGnbevmBGJUDU
 rYGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9q4H79oRqXACSaYBSkqWfIHc9LeCE93SMzxAy7MLASDHqHXcQSAN/Xfr0eMUAErUZyhKCWoIylFl2HnFttyhr0kdGnQ==
X-Gm-Message-State: AOJu0YxsMjJzV7+rq8LCw7lod8fHwu0khWYyPvcz6rHy96qXOM2U8sI2
 AJp8S9JGWpvR1l4J4OQwlA0Wln+EH8/y/3d8VzWxEUG2FB1rvfWf7/E8inGlFYg=
X-Google-Smtp-Source: AGHT+IEyiisEey1l09WsE0B2ems+BBugsqeta8pH7alcjH11zVEtoP8RfIbdzpyvoAG0UmP2Qwhjhw==
X-Received: by 2002:ac8:5990:0:b0:437:c00f:c671 with SMTP id
 e16-20020ac85990000000b00437c00fc671mr2889985qte.21.1713535525627; 
 Fri, 19 Apr 2024 07:05:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 j18-20020ac86652000000b00437392f1c20sm1595210qtp.76.2024.04.19.07.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 07:05:25 -0700 (PDT)
Date: Fri, 19 Apr 2024 08:05:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, Anatolij Gustschin <agust@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Anton Bambura <jenneron@protonmail.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/7] Tegra panel improvements
Message-ID: <20240419140522.GL1054907@bill-the-cat>
References: <20240131065721.4245-1-clamor95@gmail.com>
 <CAPVz0n10Fb4H-Haj+s-Jjt_UgpWXSSWOFdJVeJATwTr22Do5_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iRUFYX0uEBG5oKWH"
Content-Disposition: inline
In-Reply-To: <CAPVz0n10Fb4H-Haj+s-Jjt_UgpWXSSWOFdJVeJATwTr22Do5_g@mail.gmail.com>
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


--iRUFYX0uEBG5oKWH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 02:29:20PM +0300, Svyatoslav Ryhel wrote:

> Hello Tom! This patch set is hanging in patchwork for 3 month
> without any comments. If no one has anything to say, may you
> pick it into master?

There's a number of video related patches outstanding currently,
Anatolij will you be able to put together a PR soon? Thanks.

>=20
> Best regards,
> Svyatoslav R.
>=20
> =D1=81=D1=80, 31 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 08:57 Sv=
yatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > The current patch set improves the logic of existing panels and
> > bridge used by Tegra 3 devices and brings support for additional
> > DSI panels used by Tegra 4 devices.
> >
> > New and existing drivers are fully reusable, contain no device
> > specific parts, and are written according to existing datasheets.
> >
> > ---
> > Changes from v1:
> > - improved ssd2825 code style
> > - added TC358768 RGB to DSI bridge bringup commit (used by TF700T)
> > - added Parade DP501 transmitter bringup (used by Lenovo Ideapad Yoga 1=
1)
> > ---
> >
> > Anton Bambura (1):
> >   video: panel: add Samsung LTL106HL02 MIPI DSI panel driver
> >
> > Jonas Schw=C3=B6bel (1):
> >   video: bridge: add basic support for the Parade DP501 transmitter
> >
> > Svyatoslav Ryhel (5):
> >   video: panel: add LG LG070WX3 MIPI DSI panel driver
> >   video: bridge: add Toshiba TC358768 RGB to DSI bridge support
> >   video: endeavoru-panel: shift the init sequence by one step earlier
> >   video: bridge: ssd2825: shift the init sequence by one step earlier
> >   video: renesas: shift the init sequence by one step earlier
> >
> >  drivers/video/Kconfig              |  17 +
> >  drivers/video/Makefile             |   2 +
> >  drivers/video/bridge/Kconfig       |  19 +
> >  drivers/video/bridge/Makefile      |   2 +
> >  drivers/video/bridge/dp501.c       | 579 +++++++++++++++++
> >  drivers/video/bridge/ssd2825.c     |  86 +--
> >  drivers/video/bridge/tc358768.c    | 985 +++++++++++++++++++++++++++++
> >  drivers/video/endeavoru-panel.c    | 128 ++--
> >  drivers/video/lg-ld070wx3.c        | 186 ++++++
> >  drivers/video/renesas-r61307.c     |  93 +--
> >  drivers/video/renesas-r69328.c     |  81 +--
> >  drivers/video/samsung-ltl106hl02.c | 157 +++++
> >  12 files changed, 2155 insertions(+), 180 deletions(-)
> >  create mode 100644 drivers/video/bridge/dp501.c
> >  create mode 100644 drivers/video/bridge/tc358768.c
> >  create mode 100644 drivers/video/lg-ld070wx3.c
> >  create mode 100644 drivers/video/samsung-ltl106hl02.c
> >
> > --
> > 2.40.1
> >

--=20
Tom

--iRUFYX0uEBG5oKWH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYieh4ACgkQFHw5/5Y0
tywtwwv7BNc42A/zTY4EkKVyhN1ArXeotTULbjyBXA6z/oO7VAKvMC3Q6O1xGqUk
Ajxg9CGmj5ecESU/XPWwPLoAf4A6pfk9IMkifNjIpXuSkowigtvQYzhy3TKX1DLd
NTuhNGsMF+CRpD8666ALbQHUsMJuaTM5pE6RiiPzW5Q81UjBB4ySkv2NikclgGtz
bUtb4wPZF6j6QAgF1/yWMY+VGXpf1BPKbexxv6Wzs3iRPs64P7KDNeGeyVGr3b+0
IXDUmcyXLv2lAOFhVRb8ndmqDxTcl5xDZj9IjJ7umIM6hxgzXCz5CFpK3vcW0DUX
vDSDFE1i4vohrSLBt0zTvzjEspU2SwEkzkyEgUlML08WfufXhQ2GHItEtTuufO0V
GVCYBiG6I5V1jIJgNHfrjFbFN3Jdn8/7Agdpio6wIgWsZhqUR0Kf3K9AKBZCwE/Y
CYQcW787JPXmSMhI7Kz4hTGS0GsAn3dulbsdBEnEsQ7XCUBC2YtqFmQyH59EykDK
FAQEyf5B
=R/Jp
-----END PGP SIGNATURE-----

--iRUFYX0uEBG5oKWH--
