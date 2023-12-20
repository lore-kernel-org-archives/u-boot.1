Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAEDC3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 22:38:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 124DF87808;
	Wed, 20 Dec 2023 23:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MY7hnbHp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2C3387808; Wed, 20 Dec 2023 23:38:22 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A329877C8
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 23:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d33574f64eso2386717b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703111899; x=1703716699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B1KyUcxrJOvS/M+lGT/CJr0pr7nKbQzkpRt8nvPbals=;
 b=MY7hnbHpMupiCo9oTx5Khrv7j6385gbIjHzRs9R9ULIeW/59BbIv24JVpmEh1SZsfU
 cPRbNVT1Bko4LoSDvG7j0XE524XyrPfivguTY+QT1NkSFpfQmvx58+y1+WUQhOLrw62w
 QGdOea4TQ0mz+0vbdiIHjem+0OKeJdgMvblPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703111899; x=1703716699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B1KyUcxrJOvS/M+lGT/CJr0pr7nKbQzkpRt8nvPbals=;
 b=t/DX664GNcZcoAwAwWemKmHm/iFzpK5sfXEtzTAzJS6SjfwSxU9qx+rThXxJw9KaAr
 MCzyWRe55FV61O9rORxeifS4Ha16F7nkW43Xpvx9H9LQzjPtTdP5aXCHzF2iTLTeD+G0
 fx2cUNc9CldwbJo4m30fcRlgGbqv4hWau6lsRwrjOKbUQmp+51mBllmICnfyCLRw49qW
 WOKQtqvN+D9xsBqs+vf4Tc4mZXH1hzLe2bIYJMiYB6kdHsMs1Mup1rNL1SIABCK7XZwe
 97z76vbNElA8q/61+7NkS8HX3cww0E5dhqCCyCdX0AdR4l8Pvrrgl8dWTHKJQ/G4a12g
 /Ncg==
X-Gm-Message-State: AOJu0YxrRln7MQ2rCrR6sMh2I6vPuwqswvvK2htdtrO9uyPUQOnJD+SR
 8Guay2pXF+L4QdV78/RhyhBlpw==
X-Google-Smtp-Source: AGHT+IE0s5yqR1rnQeqzAAVmFUQraGur3p5AbZ2N3o092enp64poZNdYymqhCBcuQw0HRrLaV9bOPg==
X-Received: by 2002:a0d:ca8b:0:b0:5e5:7254:2c2d with SMTP id
 m133-20020a0dca8b000000b005e572542c2dmr474780ywd.53.1703111899186; 
 Wed, 20 Dec 2023 14:38:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 fb4-20020a05690c310400b005e92fd632e0sm227339ywb.24.2023.12.20.14.38.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 14:38:18 -0800 (PST)
Date: Wed, 20 Dec 2023 17:38:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: u-boot@lists.denx.de, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH] sbp1: Add support for IBM SBP1 board
Message-ID: <20231220223816.GF2513409@bill-the-cat>
References: <20231220091236.1059109-1-naresh.solanki@9elements.com>
 <20231220191211.GO2513409@bill-the-cat>
 <CABqG17h=HC=Fifze+5G2kQ7x5DTW_THzNrsua8ZM=e1uLDn+Vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Td5Ixd/sywZaeAlX"
Content-Disposition: inline
In-Reply-To: <CABqG17h=HC=Fifze+5G2kQ7x5DTW_THzNrsua8ZM=e1uLDn+Vw@mail.gmail.com>
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


--Td5Ixd/sywZaeAlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 02:38:11AM +0530, Naresh Solanki wrote:
> Hi Tom
>=20
> On Thu, 21 Dec 2023 at 00:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 20, 2023 at 02:42:24PM +0530, Naresh Solanki wrote:
> > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > >
> > > Add defconfig & devicetree for IBM SBP1 board BMC based on AST2600 So=
C.
> > >
> > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > > ---
> > >
> > > Changes:
> > > - Update MAINTAINERS
> > > ---
> > >  arch/arm/dts/Makefile                |   4 +-
> > >  arch/arm/dts/ast2600-sbp1.dts        |  96 ++++++++++++++++++++
> > >  board/aspeed/evb_ast2600/MAINTAINERS |   1 +
> > >  configs/ibm-sbp1_defconfig           | 126 +++++++++++++++++++++++++=
++
> > >  4 files changed, 226 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/arm/dts/ast2600-sbp1.dts
> > >  create mode 100644 configs/ibm-sbp1_defconfig
> >
> > Is this device tree submitted upstream?
> This devicetree is meant for uboot.
> devicetree for linux kernel is wip.

Right, but the DTs in U-Boot are intended to be re-synced with the
kernel and medium to long term the goal should be that the run-time DT
U-Boot has is passed to the OS.

--=20
Tom

--Td5Ixd/sywZaeAlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWDbNUACgkQFHw5/5Y0
tywxBgv9FVkHQSWjRBjqoDjv9D3HSAo9EFwS/s88cYtX0Ow+XiDv0wz/LdqnUTys
9lczizFG59gP7F9/vKT4sq95fKn5io1r5yM+C86ed5LdbsEZ1LdpRNk4juWijtt5
mgoSvvZns+j6I+DhsGBWfz+sJiFQvqShalRENa7BCWt+uRyqVbCfkzRoKEoyJX7k
8sJ0mgONvgqhJMCiLgA8gMHrYUwfZsrjRyNZcgEHP5c+DH4N/5MXxHAFhT3kI7VN
c7mu4iupnY50enCd6gr5tihOHnxozUgCnHYFb9wAH4VxsilPOVyxxv8RwHN6xtM2
4/yhs/bIChy0HfEhL9ZkpDxHamVLwuvxzX0EFwnFNkMNIiFhbbrh0zS5OYKzi6HY
qhz4XreHeiwyTRcPQSkNOdsQ1GMWyCsjqkB6flTfKs8Vkkj8PcFlMWPoaiWMFM3N
z+5pTZJwCBSu/9mj/t8I+AIT0vs0QgXMeyS4jy6DJc9rPxJyO2zH67APWOZC2lzV
Kj7mgSSZ
=mDSU
-----END PGP SIGNATURE-----

--Td5Ixd/sywZaeAlX--
