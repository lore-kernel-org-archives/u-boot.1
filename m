Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B482FC28B20
	for <u-boot@archiver.kernel.org>; Sat, 29 Mar 2025 00:07:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F43810F4;
	Sat, 29 Mar 2025 01:07:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tCw/70sP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE72D81951; Sat, 29 Mar 2025 01:07:47 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F2F6809A5
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 01:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-72c1818c394so1584877a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743206863; x=1743811663; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P6/2hIJuAY4sjl/29Q/SizTaNMs5pLr2N7f+ME2Xqiw=;
 b=tCw/70sP1pWoEPc9pDY/BXfo5XJZygG9MyvHOJeYcAGUDpw/B1QFDqABcHiffxZnso
 vgwafh8vYSAmi4iGpwoFsRwjXYOQDSBtCMKNlhhqpemRL5ISWoK81ZK8q6XBm0rrVixe
 /DxG6tY2jmYfS+sPoMediAuxA5GcUbX/CKNLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743206863; x=1743811663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6/2hIJuAY4sjl/29Q/SizTaNMs5pLr2N7f+ME2Xqiw=;
 b=iqz1DZMQKXhrYOzRZIeHOolfZrkTggRUKI87SzmYRyELMDb0yZkACze7E//6aNWtUU
 LXZMxOXkWMlxV2yTtp+UJUjFOT4tnOkw/ulrA3cwjV8ThO3Xfg85c6gVrjQKU9WCXvs3
 jjLRS5F08csBAg1yqvB1OI+g3vRtWILk7CTE5ZIB6MXWb4QYQkCNywoBowNayGA7wPTN
 Xlbq4w6TJCYlLP8CqOElCNmPioQdHzJGen4vpPAcldBI3pfpi2zxbwrySZN6ptJY+QPm
 cLwW+sgU2B8SFkChnsHdQszrvICOgUUVGlQ5qbYQNs2Ul+t7OmpguIfuzKUM0WmDj6U1
 El/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhcwzXNSQriE05NDxSc2+UMQmzff+vUa9LezJPOnl+IBXCObZfVSDpqV2rbIhiFscTutmdgNI=@lists.denx.de
X-Gm-Message-State: AOJu0YwM/lEyPZ2iBpIz2SlLOXkamiWFhEgDR8dXR3T3HvzQceGb0uWf
 TLqZG+Zwjq0Ey38daHmb1vQHdlLRn10krW/SuAvUGJ7bJ5mArNLM1kYTD0XP+9Q=
X-Gm-Gg: ASbGncv+Xm/11rRTO93tCh1eVSU0GTPZITALf6Xp6Fv4kJSjCehMyZVEuOcNvoZdLdo
 6qMG0esV+s4SunI96I4XwAT2s2O1DAdhO6QnwTFiEQAV09zjaQrVNaQ95jO5YtX2aArUiWeQMKM
 y4fBYNGeTiGY0CwMjA3EsIf302ypCKNtoxwoFgbIvHGx3nMNK3Ai0+87N6XCJ9qYzxDyWZrG2Ht
 +p72uuuNREOhrwluWsGcbStQm8CzQKM72ZGyHwZV0nJybGuBavj+uSGVPzSfj1CZIXqzSnfwtbT
 LsMko6I4QgwTRPozMF4N6935bL5VxJXX1EMVXawGQGbjitlYMN7wXJ5FRPiPFaqD/4kgAbXDbK0
 oHyoxHg==
X-Google-Smtp-Source: AGHT+IF7WSauVjDyDJ8Zop531y9Sh+ER7qE7kXeCitoBfeIHT/HrzZ/y+SQmUMmWyxr6OWqhph+Qfw==
X-Received: by 2002:a05:6830:3690:b0:72b:8889:8222 with SMTP id
 46e09a7af769-72c63793a27mr1122798a34.8.1743206863180; 
 Fri, 28 Mar 2025 17:07:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58267427sm563504a34.49.2025.03.28.17.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 17:07:42 -0700 (PDT)
Date: Fri, 28 Mar 2025 18:07:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Greg Malysa <greg.malysa@timesys.com>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Trevor Woerner <twoerner@gmail.com>, huang lin <hl@rock-chips.com>
Subject: Re: [PATCH v3 19/31] rockchip: Provide a VPL phase on rk3399
Message-ID: <20250329000739.GL93000@bill-the-cat>
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-20-sjg@chromium.org>
 <6721d34c-83eb-44d9-9be5-a4f8346481e3@kwiboo.se>
 <CAFLszTiEwMqyhwJ6NvkhpE3cOw7z+VHmhqMdHcPVGyr6rK4yEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qfWa9imeI3KmEYfI"
Content-Disposition: inline
In-Reply-To: <CAFLszTiEwMqyhwJ6NvkhpE3cOw7z+VHmhqMdHcPVGyr6rK4yEA@mail.gmail.com>
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


--qfWa9imeI3KmEYfI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 11:40:01PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 28 Mar 2025 at 10:16, Jonas Karlman <jonas@kwiboo.se> wrote:
> >
> > Hi Simon,
> >
> > On 2025-03-28 16:34, Simon Glass wrote:
> > > Add support for this new phase, which runs after TPL. It determines t=
he
> > > state of the machine, then selects which SPL image to use. SDRAM init=
 is
> > > then done in SPL, so that it is updatable.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > > - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
> > > - Skip spl-boot-order.c for VPL (rather than modifying it)
> > >
> > >  arch/arm/include/asm/spl.h               |   1 +
> > >  arch/arm/mach-rockchip/Kconfig           |  25 +++++-
> > >  arch/arm/mach-rockchip/Makefile          |  11 ++-
> > >  arch/arm/mach-rockchip/rk3399/Kconfig    |   9 ++
> > >  arch/arm/mach-rockchip/spl.c             |   3 +
> > >  arch/arm/mach-rockchip/tpl.c             |   2 +-
> > >  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++++++++++++=
++
> > >  arch/arm/mach-rockchip/vpl.c             |  53 +++++++++++
> > >  common/spl/Kconfig                       |   1 +
> > >  9 files changed, 205 insertions(+), 7 deletions(-)
> > >  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
> > >  create mode 100644 arch/arm/mach-rockchip/vpl.c
> > >
> >
> > This patch and therefore this series does not apply to the next branch.
> >
> > Are there any depends that are missing or are you only testing based on
> > your own fork?
>=20
> Until we are ready to apply things, yes I am using the sjg tree. See
> the tags in the cover letters of patches I send. For this one it is:
>=20
> base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> branch: vbi3
>=20
> So no, there is nothing else that this series depends on and if you
> can review it I can send a PR for Tom for -next one all necessary
> changes are made.

If you want something to be reviewed you need to base it on next and not
your tree. Your experiment with posting stuff on top of your own tree is
already making other members of the community have trouble reviewing
your code and they should not be expected to look in your own tree to
have to test changes as that's wasting their time.

--=20
Tom

--qfWa9imeI3KmEYfI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfnOcsACgkQFHw5/5Y0
tywBFgv+LV7OrFI9gDdELSuRZ7p21F6xOBswRMRejB8j7W/xWkJcj6HzvBvEa34e
yKknt7UPLnpAz/nXjAAp9LR4iZQJJMt/sWVlcxMwOCkXMBEP9m39uYVhphCQYVdE
ziFbqib7HZON4yHsMhNbUrdsiZvQAxGlhk2GY8rYRPFiqE/xmUmHITu37jHWwsJI
PAS4RDvfv+985mK0KTh0qCzKeX7IcR32848ihETtsAHGzZ+N3T2neiawHmQJAwXs
v+RfHdqBEr/H9KLwi6p9VzVwuAiE29dkBfBMWnsqwYN4I5foqkPOY2xqXKoblV9v
qvRLu8Vu9xNLir7UwiyFqa1ro3DDag235/wPAXGyT9ZJ5pNl8MalCUALBSZf5K2E
HVEQFP5lWHyZvaRI/vakdjigE7uxWmzekk1kIqJM1DLSSD0RPIlhfeqXmzF9gr+D
PDouX48EYimn+0EiHRfqFhm/rbmbTdgX1hHQHezFFZWpiwgSs3SuGgdwYsDPM50p
jWyVt7+z
=cpYw
-----END PGP SIGNATURE-----

--qfWa9imeI3KmEYfI--
