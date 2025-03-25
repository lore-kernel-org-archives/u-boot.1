Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47AF3C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 17:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BF98192A;
	Tue, 25 Mar 2025 18:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tyEHgnEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5902A81B42; Tue, 25 Mar 2025 18:02:13 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDABF81026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 18:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-22622ddcc35so8056945ad.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 10:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742922128; x=1743526928; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D9xfHmifK1wDh+BqOhu8Fj17rqB8uYkz+JQxtDXevfo=;
 b=tyEHgnEYNQxMrIXYZiXk2sgez9bTdPnw5MfX4Uqfh7b5jTPC3CT0APVVjatMsxXJko
 c5sTi5ZROo/CFyvoKJBodSQQY3km8S17LPjPBNUF8TaubUwVtmN08wOmGiBlHJTkvD5B
 MHxoD7pL5EHSSVMh9GJ2w7JRrinFwsvRwhFko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742922128; x=1743526928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D9xfHmifK1wDh+BqOhu8Fj17rqB8uYkz+JQxtDXevfo=;
 b=S5Xi4QBMxLnz/atN1C/06+905A+sw5rmyQAh297EVB5YETqT5gDEtdsVMrW7dLpTwg
 Lm4GjBulSR89vB5d8NuUuQJIdGr8vbDZNtd4Aqgnfq220A15tvANK4aC6l/0/SZLyj6I
 e+g8AFe0nPWlK9VOUgzFPvcUmtnFD41Uh5M9NuHvUxGscY+RATEMdnAMH7tbDzsQLiQq
 RSro8mAz/KcX2NdHUB7Bzk3W77PhMcPsUvaXuhX8GZsvXs3/JyZlKVUOzsQkMPU+u/hn
 Cyuo1dV1A1tzIhh7f+x3mIIdhoJwXn18v5vSZE/puVBx9D1GhEw+F9FizPp/We5wh2y4
 uvRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaZPbjIXUhsFUGVjcPdHqZ8XpNPcWK9pJDNmTXPhjiHvACeWSy3ttmtjxaHOpiV4/19LHHV8w=@lists.denx.de
X-Gm-Message-State: AOJu0YwVtN9yKHVTs/5uGP1W3l4cWKrU73+Qtk4SG8wxTiGHxARzhm09
 NViMJTLPMT7YPLyLC/jpPfuXhBUGzhM1AVX9DyJO1HHG32DwbyRXRhGI3XYEa+Y=
X-Gm-Gg: ASbGncsaLzl+G2AiEqa9DWbqR/Znv7PptbR8HtuMxpUEIODvb6AtF5QLagM5Sz3xEG+
 2Zk0veoj7yn0uoBqJK/RFwT1O7V/W8vGvd7HVPgXCqW1UrrtMHzMfI9VA3JlFNnGIVWhNFFBIlB
 LN5cQ+J2bYcz+rCtvzSB4pzMtn83SWlH2a0mLXDyVIvSml9aL8ealgB8TEcRoJNcZEpe4k+LLaQ
 jIesLejYxnzmgC3XlY7SE2y+/wslwKZEOCVnxHri3/8DXs9u65ys3KcbvZcvEecQYst8zJiYgy1
 pz3Pz6CxdhUo8eujcRpoXaxW4Pr9yxi6dWeFAROxz0k=
X-Google-Smtp-Source: AGHT+IFemOUcygTDuBFziLalyjBISB6x0yKbPlGaQ8BjUR0QPLKMA5kQthrsMA67mItd60lbxHQO6g==
X-Received: by 2002:a05:6a21:b90:b0:1f5:7c6f:6c96 with SMTP id
 adf61e73a8af0-1fe42f996e7mr29589008637.22.1742922128248; 
 Tue, 25 Mar 2025 10:02:08 -0700 (PDT)
Received: from bill-the-cat ([2806:2f0:5140:4ba6:9e6b:ff:fe16:a05f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a29177sm9342214a12.62.2025.03.25.10.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 10:02:07 -0700 (PDT)
Date: Tue, 25 Mar 2025 11:02:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 2/8] env: Rename SYS_REDUNDAND_ENVIRONMENT to
 ENV_REDUNDAND_ENVIRONMENT
Message-ID: <20250325170205.GK93000@bill-the-cat>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-2-marek.vasut+renesas@mailbox.org>
 <de961532-3565-49f1-b205-556684105a11@cherry.de>
 <bffe08af-3151-4064-bfd9-8a660a70599a@mailbox.org>
 <cc0f556c-e9ed-458d-83d3-0f459f6e6c25@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vWf8hqUBmWpJE9cF"
Content-Disposition: inline
In-Reply-To: <cc0f556c-e9ed-458d-83d3-0f459f6e6c25@cherry.de>
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


--vWf8hqUBmWpJE9cF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:02:46AM +0100, Quentin Schulz wrote:
> Hi Marek,
>=20
> On 3/24/25 11:52 PM, Marek Vasut wrote:
> > On 3/24/25 1:33 PM, Quentin Schulz wrote:
> > > Hi Marek,
> > >=20
> > > On 3/22/25 10:55 PM, Marek Vasut wrote:
> > > > Rename the variable and add ENV_ prefix, so that all configuration
> > > > options which are related to environment would have an CONFIG_ENV_
> > > > prefix. No functional change.
> > > >=20
> > > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > ---
> > > [...]
> > > > diff --git a/env/Kconfig b/env/Kconfig
> > > > index a177a354c8b..9ef45a7e3fe 100644
> > > > --- a/env/Kconfig
> > > > +++ b/env/Kconfig
> > > > @@ -463,7 +463,7 @@ config ENV_IS_IN_UBI
> > > > =A0=A0=A0=A0=A0=A0=A0 the environment in.=A0 This will enable redun=
dant
> > > > environments in UBI.
> > > > =A0=A0=A0=A0=A0=A0=A0 It is assumed that both volumes are in the sa=
me MTD partition.
> > > > -config SYS_REDUNDAND_ENVIRONMENT
> > > > +config ENV_REDUNDAND_ENVIRONMENT
> > >=20
> > > Do either of the following:
> > >=20
> > > 1) fix typo: s/REDUNDAND/REDUNDANT/
> > > 2) shorten name to be consistent with other symbols and avoid
> > > "env[...]environment" redundancy: config ENV_REDUND
> > CONFIG_ENV_REDUNDANT works for you ?
>=20
> Fine with me!

Me as well, thanks! And for v2, please make a cover letter for when I
merge this in.

--=20
Tom

--vWf8hqUBmWpJE9cF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfi4Y0ACgkQFHw5/5Y0
tywsBAwAsRrXekZmwUzG/+mhkMJgtwD45ftt8BCOOR36dAZgk05GNv200/SFsEKA
MJFc6/udulQla2lD94to1ebeQqfH2mwX6JXLApWuyHmgzP0+8ie/aNfbJPo4jk1K
mGAb+TAEebPrXCrCROAo/IcKuURCY9WDBL+ZgTLBDACkvP1ggF8LwcwIiNbNtwGu
NtnLEZmuqX4L78WRpdBOWfx6q7OwHF0IcFZxvsDk1gqSc4SNVDR+5Buaus/Sbt1o
2cXX8TrB0N4AHzBasK8aediRw3TexzPO5IbpOxUT73Cb5H26DXGBB8S7XZfzOi1i
xjg3BzMW6QJaONd2Aao2JJ6nLQ8uEV48ShAIRs7rmpV4WR8oNoqAcLnH7rxq6vsq
Pkhw4J/o2i6OaQ8by6cNe9MgzeWE4hDQdPLNWVUzWXEsDvVA4s1/yaJIG8+3G5Y0
P/6Q48BGb0RRa0Nxv0pj5yPGW5hvjGV51hSNMt6tEXmYsNJ7SvqoIXhoi1JLy5N2
CEGzoAw0
=X5Xt
-----END PGP SIGNATURE-----

--vWf8hqUBmWpJE9cF--
