Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C558C46CD2
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 13:54:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDDDF87858;
	Fri, 22 Dec 2023 14:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozO5pbKG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64FE87858; Fri, 22 Dec 2023 14:54:34 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D6F8775F
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 14:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42786514fe6so11910841cf.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703253271; x=1703858071; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UYt+MAbLnEy55i7fhZOlGygK0aybhm/jNDhaBSPcNys=;
 b=ozO5pbKGpoTq3qxWjRg8q3VMzF5sNo7XmNOR5c1wiF6/bwuHpHzlGtMGpOaPtYpUBe
 whVt1lDGZyi1g1BkgAqORjrzfd7yx7UL4U7hqWXYeGQCzOAeyHKgOl88k7QpMxaAM20Y
 1yw3ZZsz0vkvQDc6in2EjmMlY3Vgi7xEukpDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703253271; x=1703858071;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UYt+MAbLnEy55i7fhZOlGygK0aybhm/jNDhaBSPcNys=;
 b=sZ+3UEn4PLOuGlpVNb+IIw3Z0ODoblBgvpn5luAujYlG1PlXphLGbAnZEFw9RQ59ah
 HmA/hOAE3xLRf3qSObAnJysdjLROI3H5ngRNMdCpQz9TIYsuQIgnSNp3RELxUci9xq3A
 u7G4YK/saX1uoISyDj7++c2lya6vJ2Xw7+m9B8mE4mriobSgdmnUddLBWU/gpb1Ib7OX
 SbLeQPZYexSwPfs8qhBOZFxeQLAH2OP+xBT/Hcc9wC6EarbFXdEDwMtH8QNIVkavVSIb
 1rzHaCB9nYAJAibTCwx2ASu5gXKttVSrioik5vqxvBoBljxgi3TwK+AIHVDs0IKc5NGb
 igFw==
X-Gm-Message-State: AOJu0YydTb6U17c7Qzy5SbvUIw3ZOLAh3lhVXnwZR+0fKhRkq9dRvutQ
 bTdYWn48FVdXvg0kPV+p1YRiTeim79tfVg==
X-Google-Smtp-Source: AGHT+IFFqbFzz6wtlcf5XeujQuoIl/SDveoHRCFTXRhNmEmoTwTbwD+8yOV12OOWTWCw4+nYzbTd9Q==
X-Received: by 2002:a05:622a:607:b0:425:4043:764b with SMTP id
 z7-20020a05622a060700b004254043764bmr1544174qta.115.1703253271266; 
 Fri, 22 Dec 2023 05:54:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a6f1-1968-9d2f-89bf.res6.spectrum.com.
 [2603:6081:7b00:6400:a6f1:1968:9d2f:89bf])
 by smtp.gmail.com with ESMTPSA id
 bc14-20020a05622a1cce00b00427a49c4faesm1071881qtb.4.2023.12.22.05.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:54:30 -0800 (PST)
Date: Fri, 22 Dec 2023 08:54:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH v2 7/8] dts: meson-gxbb: Switch to using upstream DT
Message-ID: <20231222135427.GB2513409@bill-the-cat>
References: <20231222061208.3009970-1-sumit.garg@linaro.org>
 <20231222061208.3009970-8-sumit.garg@linaro.org>
 <20231222123133.GX2513409@bill-the-cat>
 <CAFA6WYNbLRVZJq_geK4h9Z4oDdJ=8ne39AUqLMfL-Bf4zpnF_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nu6LJRLFkc2Ji9Lq"
Content-Disposition: inline
In-Reply-To: <CAFA6WYNbLRVZJq_geK4h9Z4oDdJ=8ne39AUqLMfL-Bf4zpnF_g@mail.gmail.com>
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


--Nu6LJRLFkc2Ji9Lq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 06:50:32PM +0530, Sumit Garg wrote:
> On Fri, 22 Dec 2023 at 18:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 22, 2023 at 11:42:07AM +0530, Sumit Garg wrote:
> >
> > > Although there were still some variations in board DTS files based on
> > > meson-gxbb SoC but I think those were minor differences from upstream
> > > and shouldn't impact boot on these devices.
> > >
> > > So switch to upstream DT via mirroring amlogic/ directory from
> > > devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> > > building DTB from there including *-u-boot.dtsi files from
> > > arch/$(ARCH)/dts/ directory.
> > >
> > > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  configs/nanopi-k2_defconfig           | 3 ++-
> > >  configs/odroid-c2_defconfig           | 3 ++-
> > >  configs/p200_defconfig                | 3 ++-
> > >  configs/p201_defconfig                | 3 ++-
> > >  configs/videostrong-kii-pro_defconfig | 3 ++-
> > >  configs/wetek-hub_defconfig           | 3 ++-
> > >  configs/wetek-play2_defconfig         | 3 ++-
> > >  dts/arch/arm64/Makefile               | 9 +++++++++
> > >  dts/arch/arm64/amlogic                | 1 +
> > >  9 files changed, 24 insertions(+), 7 deletions(-)
> > >  create mode 120000 dts/arch/arm64/amlogic
> >
> > Do we need all of the Makefile portions of this? One of the things that
> > works today is that trees listed in ONFIG_DEFAULT_DEVICE_TREE (and a few
> > other variables) will be automatically built. We might just need the new
> > Makefiles to just have:
> > include $(srctree)/scripts/Makefile.dts
> > and then the trees a given config will need will be built.
>=20
> That sounds fine for Amlogic SoC and many others too with
> CONFIG_DEFAULT_DEVICE_TREE=3D"" CONFIG_OF_LIST=3D"" options available.
> However, if in future we have truely generalized U-Boot (like efforts
> for Qcom platform) then CONFIG_OF_LIST=3D"" may become an overloaded
> choice.

I don't object to listing them when needed, I'm just not totally sure on
how the use case really works out. But we can cross that when we get
there, too.

--=20
Tom

--Nu6LJRLFkc2Ji9Lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWFlQ0ACgkQFHw5/5Y0
tyy3OQv8Dys/3XmMvKq2qokq5tjECFu8zpULHZaV3bCCgIhgSuIprEcTRbIOLMxH
2Z2rgwkA0W9t5p+kLOxkPmUAlaVX6Cr5WZEV/1w/71IWHE5o9uo9TqlhLP0z7lHl
a6CzVwuBaQt1IhrCnFwRYoiV1NEAGpDbU/6hXSQN5ed2JWy+WUggPPvdwT+IwyR1
ujHQpc9VsHjXOTs+TRDy//CArJ1SkJ62giK1lfOnyiChTjLFH66W1B6rMQj5qBnf
D8a/SgFxKjjn7RzuCPR9Rb5z56A8uvfPzwZewosF8t69btEmtN8mb37dSPRgeQbx
0d6Lbn0lFbgoA7m9mSSB+wfHMng6q+Hsg97H+7pc4dy29LyuWtopZCE9DKC8qf2p
/Yyj8hwVLN8gvONuiQEWII2XerX0fgEyxoNRp2C02mPNZzeEOCk1DMWJt+EXKIAR
ifsgCl2XDW5OCsTm5GGK7koxp6LNhivBFvgDn9C5qo2lfcSNGQOQJE2UEKgsiO22
T3eMJnc/
=3v88
-----END PGP SIGNATURE-----

--Nu6LJRLFkc2Ji9Lq--
