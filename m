Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB28CF54ACC
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 14:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C35C80517;
	Tue, 24 Mar 2026 15:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LN2Hp36N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 899B6807C0; Tue, 24 Mar 2026 15:59:17 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC4D80212
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 15:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d7eb85fb81so1497203a34.0
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774364354; x=1774969154; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kltq/UHaD/wPopTvCXbE3VL6aLVmgprbNTi1kf4pPUw=;
 b=LN2Hp36NhWc4K7S5Z5bxYk7WBA9X682P369HkZtpYn77kKUnnHeuKFE+visZfbVaoK
 K389UTXPIagP8omtWIPYncYZpi2Fc1MD/CxEdgXgTPhw+XdcGssLknmeFafHVT5bu8Cc
 K6pXQndmjS7DEI/xCKva/KuDIF+dAFHxvjLLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774364354; x=1774969154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kltq/UHaD/wPopTvCXbE3VL6aLVmgprbNTi1kf4pPUw=;
 b=JAiW7tURbHMkhu/HSmIRsqYVfPiKclkOtSJi5VmTDpXodqtW2NGr4z6t1y0k05XRFE
 Xh35H5uey4v5NeKp0F+H6WQKsKgHr/qc9q7ZCGAKAS7xBzaVHNg0GI8BbQ3XeBC9NLxT
 qQdRB/8uY6bVmbWH3zmWSo17FPN8Zn7Ug4oYGPfe0mScQxm1waOqp8FHicscmFOz52v7
 MCLTWs1QRTdTwMC+uE8figGiGXsSjnbUvcphU9yfBn1I3/zkHttX/l7k5JcAnrggKhqq
 KsfQyq6cLUGUgS5MGuB32g5e6nkRVba2yPnbrc2PZCR8+HM5B9z1ZdbKNSpXS5636R8p
 aNFg==
X-Gm-Message-State: AOJu0YyFR3gQT0bKvnRBQFaDZ/DyxSSeE8t3Cw9dVvvy4NCU4aFSeEVb
 wCXwqXM9MKFEVV/NNhXEv0bTaq/k858S2HabR2j5pkO2YO5mSMMvWEeFwKzXHmC/28A=
X-Gm-Gg: ATEYQzxzhp+FIr72riIOMoG04dR6eHqfLgUIRjgPgTYIuExnmdf2hw753zpbE5uK/BH
 NIqfDbZn0776nlb0BGFTadRoyKJwluP8IF7sWu4gprfug1faUESnzvVCRh6BHjKk9okOYbUKcUs
 g9A1y/Nx0ImwqnEkEpdNtlltmuiqeHZR86hj9lV7m1aHXPRnxF1Plf6LeA+HZyHs3HSNx0QiKcO
 kl9vKgpyeePfWsscbwTJdu4VbJ6DBljhwy4X1/OrrffuClATl9Elm6j6P59yB4a708Ow25s9rVt
 eB/OeveVUUEiBUj/feFD3ulI5KUw07tcm7pwqidLDbrmy/A8vhoGwNE4Po9F+pO2CuC5ho2O9bL
 JzLd5oXEdw2kxTkvIk+u7owqb8iD1aXwsddLEHAQ9JiDPlyTl4OjmG+4cauOwcsn9kCZkLQAQNb
 /0a+OWlitAOBmlcffbf/7cqvUXhOGouRHNXPIM/rF/tw9mGqB8C8TGf6R6OTyjjWjsjiuQE+cUb
 tdAbGSyVCVSy0R0CJoZ7IVQ3vClW/wHx4KD7CkSp2wqREZm
X-Received: by 2002:a05:6830:f97:b0:7d9:c783:5cc0 with SMTP id
 46e09a7af769-7d9c7835cfemr1947958a34.33.1774364354030; 
 Tue, 24 Mar 2026 07:59:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadd17d9sm13368818a34.14.2026.03.24.07.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 07:59:13 -0700 (PDT)
Date: Tue, 24 Mar 2026 08:59:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 u-boot-amlogic@groups.io, uboot-stm32@st-md-mailman.stormreply.com,
 u-boot-qcom@groups.io, linux@analog.com
Subject: Re: [PATCH] global: Correct duplicate U_BOOT_DRIVER entry names
Message-ID: <20260324145910.GP502704@bill-the-cat>
References: <20260323225537.896180-1-trini@konsulko.com>
 <ef7c8db3-0df8-4d32-983f-4b2dd81b298e@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MvxPhYR2QUvihehD"
Content-Disposition: inline
In-Reply-To: <ef7c8db3-0df8-4d32-983f-4b2dd81b298e@mailbox.org>
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


--MvxPhYR2QUvihehD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:28:13AM +0100, Marek Vasut wrote:
>=20
> [...]
>=20
> > diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3=
-meson-g12a.c
> > index 41d15996e5b2..49e9c3fa0e99 100644
> > --- a/drivers/usb/dwc3/dwc3-meson-g12a.c
> > +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> > @@ -533,7 +533,7 @@ static const struct udevice_id dwc3_meson_g12a_ids[=
] =3D {
> >   	{ }
> >   };
> > -U_BOOT_DRIVER(dwc3_generic_wrapper) =3D {
> > +U_BOOT_DRIVER(dwc3_meson_g12a) =3D {
>=20
> Could you please add usb_ as a prefix in front those usb drivers ?

As we talked about on IRC a bit, globally we're not consistent with
prefix or suffix or nothing. Your suggestion of a new macro that takes
the uclass name and rest of the driver name and constructs U_BOOT_DRIVER
=66rom that sounds great and would be a good general improvement. If you
can file an issue about it please I'll try and find some time to look in
to doing that.

--=20
Tom

--MvxPhYR2QUvihehD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacKmugAKCRAr4qD1Cr/k
CmpyAQCuN4p26T/REii2QoFiw0+VYKRzKAkpxhJdroMVZggDdAEA6sQoSKo9eVVD
YEQJqehffXAcWEV/EoPeILkWOYavEgU=
=m20y
-----END PGP SIGNATURE-----

--MvxPhYR2QUvihehD--
