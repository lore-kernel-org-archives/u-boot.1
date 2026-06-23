Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C530ECDB479
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 14:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E655849CE;
	Tue, 23 Jun 2026 16:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WDXpzHuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23AAC849D2; Tue, 23 Jun 2026 16:23:15 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92797849BF
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 16:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4471b489240so1378478fac.2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782224591; x=1782829391; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pw2jms6dWHaIrkOg1bL8yXzO/KlgcQs0GbmPU6ie8DA=;
 b=WDXpzHuMJbXyirRm8q1pasjCYCdcJxy6KJaOeaEWssBRuhlgOzEngXyJsAJ3nIltaT
 PuM7VdrDW1slK8T8MF9NUcfGhG7IHzYqyE1VMU7JsyVdtzNwVErAcPdZYnlFHLPqjWfR
 1sjJyIFwsLqW2LIkfiPjXXOQNkHvP40WYNDRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782224591; x=1782829391;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pw2jms6dWHaIrkOg1bL8yXzO/KlgcQs0GbmPU6ie8DA=;
 b=PnNlJrhOOZf1/4pDjbOXygRzfjyOiVuyUQUn5WHsFZFym8goJn08FCQWTQFWeFpg0U
 DO2UlN2KDz80FS2D3X2aKjm27/Gk756JSg+6IgJYJUxh39UVDnKQ1ZhQCWLF2o09FExB
 wIxRGIBh6yukbri17jLkePLv7k47eIeQ31M+brjQMR2/y8l6vs+1rks+34vd4tdNPfFh
 AdyFEZWlWO+pkvEdU8FQloKPaG0qa/iOeUSzJLzBtH/MvuDMQD2KQFcfMhoytvD/gQmZ
 GfaNdb9V0vIy9qiphNiw8JuKL9HYbmdaFqttFDkNudnjHLOPXY7pAlcEu8ik9qDHakLz
 SHug==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fvOh/hTN1YHAkEKTuv37QIKO+qyNUzEc0bIkvJCYCcjB7bsDNzcWRpv0xik3iTSQB7fK4Ty8=@lists.denx.de
X-Gm-Message-State: AOJu0YwKQlRHc2I+eNfuE1evNr/D6Mgsf3pHZqXz5Yfjo5PxUJSgFEoe
 p07aQktJdElubpRQrQw36dA1crEYXmOhoasvAoqk7NHnDh7ot8NK0gfy0c75aIMtj+E=
X-Gm-Gg: AfdE7cn8fl6cuB6FyQ2QeNcUTfWP/5ZNMFumSmuPxksnF6sTJsO4fbpdbilSKqex0Ry
 SoNW/y+U5XiUdpkIEYIcWxIXE7CDc3UAjiHnsMDetCZmMQvNNuhMcQ0AN/85z5tbx2jSv0xQQzx
 PgpVtcbPyjcMFqUUx2tE6/Y2/KXsBESsEwCZY5xKDkbPWBrxnadGEQRGWSIldjnOI9PCQK3JTkv
 QfmMMS78c/aLZOBu/PaUrz3u1RmIQOGa16/EDpn+r3kjGUoQg4AjuX4M02rZLh/hwMCRD+P8fdl
 FEvyJq5ioztdC8ElGMb2SUcLgKcemSSujXIYPNHy8j5QM6b9buiOz0FdtolENKw1+4kCVnnMidO
 kTnulbjxtqwnFQtte495cg+G5/CwoeW8oYaTStk2jMLCCOcE3wJvx+Wpcr/ezGGlOocCN05Nszd
 5MW6YibuCVDWXndAWibie2Yq0MkZCS7M1sbFPaRBYId/xFMAn533Hw5Egw4UVcJdTZq8efofjzI
 SBYG/D6a6KFn4PtKof/q6Ux4Zme/sGjzQs=
X-Received: by 2002:a05:6870:21e1:b0:42c:b844:a8a4 with SMTP id
 586e51a60fabf-447b66685b6mr2075828fac.15.1782224591302; 
 Tue, 23 Jun 2026 07:23:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-245.totalplay.net.
 [187.191.8.245]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ec52815sm8751070fac.1.2026.06.23.07.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 07:23:10 -0700 (PDT)
Date: Tue, 23 Jun 2026 08:23:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tony Dinh <mibodhi@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Javier Tia <floss@jetm.me>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Heiko Schocher <hs@nabladev.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Simon Gaynor <simon.gaynor@ezurio.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH RFC v2 4/4] all: Fix lists.denx.de links to
 lists.u-boot-project.org
Message-ID: <20260623142307.GG382693@bill-the-cat>
References: <20260623-osuosl-ml-switch-v2-0-28fd46e89e46@linaro.org>
 <20260623-osuosl-ml-switch-v2-4-28fd46e89e46@linaro.org>
 <d40725cf-7f70-4038-8a67-aafe04f90119@cherry.de>
 <f0044913-eab2-4493-9dd5-c1ade7973db6@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gM49c7uJ3n4Vcbth"
Content-Disposition: inline
In-Reply-To: <f0044913-eab2-4493-9dd5-c1ade7973db6@linaro.org>
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


--gM49c7uJ3n4Vcbth
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 04:18:59PM +0200, Neil Armstrong wrote:
> On 6/23/26 16:12, Quentin Schulz wrote:
> > Hi Neil,
> >=20
> > On 6/23/26 3:22 PM, Neil Armstrong wrote:
> > > The U-Boot Mailing-list is moving to the lists.u-boot-project.org
> > > domain, so fix all the links in comments still referencing the
> > > list.denx.de domain to the new domain.
> > >=20
> > > The URLs were manually updated since the mailman links don't
> > > match anymore after the archive import in the new mailman instance.
> > >=20
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > > =A0 arch/powerpc/config.mk=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
> > > =A0 board/boundary/nitrogen6x/README | 2 +-
> > > =A0 lib/efi_selftest/efi_selftest.c=A0 | 2 +-
> > > =A0 tools/rkcommon.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
| 4 ++--
> > > =A0 4 files changed, 5 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/config.mk b/arch/powerpc/config.mk
> > > index 6e30df6504e..26fcdc4e884 100644
> > > --- a/arch/powerpc/config.mk
> > > +++ b/arch/powerpc/config.mk
> > > @@ -32,7 +32,7 @@ archprepare: checkgcc4
> > > =A0 # GCC 3.x is reported to have problems generating the type of rel=
ocation
> > > =A0 # that U-Boot wants.
> > > -# See http://lists.denx.de/pipermail/u-boot/2012-September/135156.ht=
ml
> > > +# See http://lists.u-boot-project.org/pipermail/u-boot/2012-Septembe=
r/135156.html
> >=20
> > Sorry for the mangled URLs, it's changed company-wide at the server-lev=
el so nothing I can do about it. We went from "please don't click on any su=
spicious link because security" to "click on this very long and incomprehen=
sible link wink wink", I'll never understand.....
> >=20
> > In any case, wrong link. You want: https://lore.kernel.org/u-boot/13485=
00648.2514.2.camel@petert/ or https://lists.u-boot-project.org/pipermail/u-=
boot/2012-September/134737.html if you want to stay on our archives.
>=20
> I think we should move the links of the mailman archive since they can po=
ssibly change if we re-import or migrate
> to a new mailing list server.

And we are seeing if we can import things without changing the ID.
However..

> So my best would be to switch to https://patch.msgid.link/ with the messa=
ge-ids, I'll try to cook that but since
> the mailman interface doesn't provide the message-id it takes some time...

Yeah, best would be to move to a message-id link, if we can.

--=20
Tom

--gM49c7uJ3n4Vcbth
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajqWwwAKCRAr4qD1Cr/k
CtMbAQDFh7nJr6o6cRHvIns0P4MDxB6pxEnw1DAu7PQFZvrlUwD/UXIuMeDsUP9t
cAQXjpaJTGt8dOKHNFNecC9n78XaJAc=
=4kLC
-----END PGP SIGNATURE-----

--gM49c7uJ3n4Vcbth--
