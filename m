Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CEDC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 490D1879A7;
	Thu, 28 Dec 2023 14:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tVkVBdQp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0AB7876CA; Thu, 28 Dec 2023 14:48:16 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50100879A7
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 14:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5e784ce9bb8so45899377b3.0
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 05:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703771293; x=1704376093; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pl/Kzh6EnhJdxFrygZd20GNNdtn/Vi60D2eN9TGxT94=;
 b=tVkVBdQpbIh4c8KJJTFgR/aHQ7DVrrYfbBVucWBxcSwLub3vAz9oxfZFC/buHsSoiL
 z1gJxS7a5NOGAQqAju1hT5aJC77sgw2OkzyFnG1NWkaAjQpN7xdrgxbpctk84Kl31Vca
 4y3H4Ze+dcL69+fCqMu0/JMWbiiVFhSseIRLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703771293; x=1704376093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pl/Kzh6EnhJdxFrygZd20GNNdtn/Vi60D2eN9TGxT94=;
 b=s8UP4LfvKE/ZoCGw4DS4/eXiU3IKGqVQRirbMxxCvcf18V5QPa6jFTySdj37n2XywY
 4QhPTVF4TI54ZbtE1SCEHwnbjMSWWsf8sQG+TDAH87f/Vab6wOsQaC8/9LwezUMfgTIC
 X1Q5o1DIoTRWtzuPNbyVpsKYCeuIZKVBKGD0xG2IRK9u3STTx2dr3NrooEmtAmcoqrkV
 zbnUItBdIueZWMD94SDIJuTleHf975cVJBUjnnTTfOjIrD2FXqLFQKxYSJi9D57TSacy
 uirTwjTymf3/0AShP60IKZ5aRKGjYYWGgaoSjX2Y/BOUIpxPykx+EcyBdIiO86kH7Dnx
 PLfA==
X-Gm-Message-State: AOJu0Yw1r4RUL+yBPaeqdQboE5ev4klwv1haKI/VoQ8J+EyQD+7xpGul
 HSHVq1d/2BzR6HVhsxZu+XAdHOWmdFJ98Q==
X-Google-Smtp-Source: AGHT+IHXYwHSr0JPoH8ZQRR/qxcu4hn5wS7FsLIeJ2LRH4AU/nP+gGU4JI9rGZRd68syoR/zwmuCQg==
X-Received: by 2002:a0d:d590:0:b0:5e5:200e:8816 with SMTP id
 x138-20020a0dd590000000b005e5200e8816mr5654753ywd.33.1703771292945; 
 Thu, 28 Dec 2023 05:48:12 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n127-20020a817285000000b005ca99793930sm7416178ywc.20.2023.12.28.05.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 05:48:12 -0800 (PST)
Date: Thu, 28 Dec 2023 08:48:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Qu Wenruo <wqu@suse.com>,
 Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20231228134809.GZ2652760@bill-the-cat>
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <20231227201130.GV2652760@bill-the-cat>
 <CAFLszThJc04Zh1tFA4Cp7+oKVv2oKtk2015F37eMzPcXgqW7bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M64qE/8WyiJllNIL"
Content-Disposition: inline
In-Reply-To: <CAFLszThJc04Zh1tFA4Cp7+oKVv2oKtk2015F37eMzPcXgqW7bw@mail.gmail.com>
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


--M64qE/8WyiJllNIL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 01:37:39PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
>=20
> On Wed, Dec 27, 2023 at 8:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Dec 27, 2023 at 05:48:42PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, Dec 26, 2023 at 12:07=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > >
> > > > > Standard passage provides for a bloblist to be passed from one fi=
rmware
> > > > > phase to the next. That can be used to pass the devicetree along =
as well.
> > > > > Add an option to support this.
> > > > >
> > > > > Tests for this will be added as part of the Universal Payload wor=
k.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > > The discussion on this was not resolved and is now important due =
to the
> > > > > bloblist series from Raymond. So I am sending it again since I be=
lieve
> > > > > this is a better starting point than building on OF_BOARD
> > > >
> > > > I really don't like adding another option for "DT is given to us". =
Why
> > > > isn't adding another enum to fdt_source_t sufficient
> > >
> > > That is added by this patch, but...
> > >
> > > >, and if we have
> > > > bloblist enabled, that will look for and use if found?
> > >
> > > ...this is the question. I would like to be able to enable bloblist
> > > without *requiring* the DT to come from there, hence the separate
> > > Kconfig option.
> > >
> > > > Maybe some other
> > > > code needs to be restructured and cleaned up too?
> > >
> > > Possibly, but I really am not keen on this board-specific solution. I
> > > believe Ilias & I agreed that OF_BOARD should fade away, so I don't
> > > like adding another thing onto it.
> >
> > I think you're missing something then. It should not be board specific
> > to just find the dtb via bloblist, without a new CONFIG.
>=20
> Yes, that is what I am looking for.
>=20
> > Whatever is
> > stopping that is what needs to be refactored and then you can just
> > extend fdt_source_t without a new CONFIG option.
>=20
> OK, but I need a way to turn it off, at least for development.
>=20
> [merging in the other thread:]
>=20
> On Wed, Dec 27, 2023 at 8:11=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Dec 27, 2023 at 05:48:44PM +0000, Simon Glass wrote:
> > > Hi Ilias,
> > >
> > > On Wed, Dec 27, 2023 at 6:44=E2=80=AFAM Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Tom,
> > > >
> > > > On Tue, 26 Dec 2023 at 14:07, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Dec 26, 2023 at 09:46:25AM +0000, Simon Glass wrote:
> > > > >
> > > > > > Standard passage provides for a bloblist to be passed from one =
firmware
> > > > > > phase to the next. That can be used to pass the devicetree alon=
g as well.
> > > > > > Add an option to support this.
> > > > > >
> > > > > > Tests for this will be added as part of the Universal Payload w=
ork.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > > The discussion on this was not resolved and is now important du=
e to the
> > > > > > bloblist series from Raymond. So I am sending it again since I =
believe
> > > > > > this is a better starting point than building on OF_BOARD
> > > > >
> > > > > I really don't like adding another option for "DT is given to us"=
=2E Why
> > > > > isn't adding another enum to fdt_source_t sufficient, and if we h=
ave
> > > > > bloblist enabled, that will look for and use if found? Maybe some=
 other
> > > > > code needs to be restructured and cleaned up too?
> > > >
> > > > Same here. On top of that the bloblist has a few items in there, e.=
g a
> > > > TPM eventlog. What are we going to do? Add a Kconfig for each item?
> > >
> > > No, but that is just a straw man. The DT is special and U-Boot reports
> > > where it comes from.
> > >
> > > >
> > > > This has been going back and forth for a while. I've lost count of =
how
> > > > many times I repeated the same proposal, but here it goes again. We
> > > > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > > > are scannable at runtime. Can't we use the combination of these 2 c=
an
> > > > be used to imply we expect things from a bloblist. If we want to be
> > > > stricter in the future and explicitly expect the DT from a bloblist,
> > > > we could add a Kconfig option failing the boot if that's missing.
> > >
> > > I would like to have that Kconfig option now, not later. In my mind,
> > > the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> > > DT must come from there, or it is an error.
> >
> > Determinism doesn't require a CONFIG option, it just requires an if/else
> > tree where we say what the "correct" priority list should be and then
> > set a flag so that we can tell the user where we found it too. This also
> > means that we can get whatever is going to use this mechanism to
> > migrate over, and have less of a chicken-and-egg type of problem.
>=20
> OK I think I understand what is going on here. We need a way to enable
> OF_BLOBLIST while still allowing the prior stage to NOT provide a
> bloblist, at least for a transition period (=3D forever, I suspect, but
> that's another discussion).
>=20
> How about if OF_BLOBLIST enables the option, but we allow a fallback
> to OF_BOARD if the DT is not there?

Oh, OK, so your use case is development. Why don't we just make
OF_EMBEDDED be the first clause in the if/else (and yes, if
(IS_ENABLED(CONFIG_OF_EMBEDDED) :)) and move on still not needing a knob
for "bloblist has it"?

--=20
Tom

--M64qE/8WyiJllNIL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWNfJYACgkQFHw5/5Y0
tyxPeQv0Ch7cHroUQNsGI5yDirAUs2dClvQLrH06KLrNBgyJEw65rIJf3mmM07DT
TlHCx5YE1RCL8yQ97ghZX1f61bqOLiNnzxh51XVhNo3qxHQ2GJZI6EG9iDd3rXlM
OWtn9/ArPbzIdzrZxuB9HAqrPq/qYK4g+8Bq2a45I78SHq0HK0TGuxLmVyQK64uD
LruyPRvmnoDfPQM0VGKmntoYLeYjubYY08zw/Dpa+eNC78U6e1GL04hldhDkQFki
Ou1WsaqaUx+UvOpqg1db1orCxhnm8aVIKCMGNbUnkx3GkHy76Y6907KIOpyvxGul
Esxqim9ik4xujUwBwM9I/Q3XnERU48+DQ27g1Pw7AQR1rgeuaTO1/bdjVbP6c6dq
2o/k4cPCmXy+cOEXBZo4xOk5wnzbJ/vuJnfWvpTTgOHeWtMXX0QQ9xR3fC4/ASt8
J6IYyYaDHHH4HplBTbghmDdCOTgEjZX96RGDMe0aOp1uX49Lq7j8qfDFjXOB6ett
UzbGTnk=
=bWZG
-----END PGP SIGNATURE-----

--M64qE/8WyiJllNIL--
