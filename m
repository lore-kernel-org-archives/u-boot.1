Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C72C54E64
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 02:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C10387E91;
	Tue, 26 Mar 2024 03:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t7QXr9UP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B500879A0; Tue, 26 Mar 2024 03:00:44 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FC4387F74
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 03:00:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-690de619293so32333956d6.0
 for <u-boot@lists.denx.de>; Mon, 25 Mar 2024 19:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711418441; x=1712023241; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xnBVOGuFKU3CNpv9eGvaJc4zx0IeJeE4YoXqPCIKOEI=;
 b=t7QXr9UPAor0fdwxEKPZ1If6DvhtffqkjfBfeK0p6BzZiN/8zfZ5duhcW2itpsCRFz
 Sqqmg9mhoiOKFn4kvxzW5mbtwbhYYZp6WbT/hCXCnDgrNF5Vh71hym6ptwGFqcLbmO1u
 zGeNddm1JYT4bpS4lklaZA6DPW0lM/yq4f6DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711418441; x=1712023241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnBVOGuFKU3CNpv9eGvaJc4zx0IeJeE4YoXqPCIKOEI=;
 b=mjQgeYF38gzML0QYeXXek0seJF1GMDEhnogz6V48d0g8FYPMyxqdAVtyPk+77DNLiy
 pX1/ejOsldkaZ40FZ1Gxk8gd44ccHG2cH/0Q/rpObfuAvrFLwbMmZ6fndwhNb/eVw2ec
 /jKPlBLeiSN/upHQWv56LH+aCqDtkQ8aUicMK0jTjUvBQr8Mash3bOPW5nsn3nIbj0XS
 hWd+QbLeONjkmw8beUQzAAKMA/f973b1/tsqzoJjMQ/Q0zN5ZCPvigDLR6XlmbF7XceH
 6PlqDWrnSYRo+lMUV3X1wz1UAM5c92d7mmaHzVL17cSF9g0eZBIibXveWf/cJDKyJG9F
 E1ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjqw8ItZbPKWqNXZBiBzgzYreaAC0OMdIcxDX3fIdHqi/CBv2kjcSv1BtoItOcFtyiukNl0jbYuo46jtgqwvowgrTV6A==
X-Gm-Message-State: AOJu0YyzVJqrkg46IUGQwcYOlxQCqDvt7WEOH3aHHVEI+291ZYXxkvan
 S+CihpbUwDNMLBgVN7mvKO49hSrYgDQM+pZlzDNAH+jPgGBFpH8vW13tpJBUzSg=
X-Google-Smtp-Source: AGHT+IGNeT6l8VdGNb1cOYfO503A2ImU0cPNQpVQhGu28DPLSpcTfV0aHiLSDAasbvRIqZ1v7PBHUQ==
X-Received: by 2002:a05:6214:762:b0:696:98ca:7603 with SMTP id
 f2-20020a056214076200b0069698ca7603mr1560332qvz.3.1711418441123; 
 Mon, 25 Mar 2024 19:00:41 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 gu2-20020a056214260200b00691823f0980sm4716015qvb.0.2024.03.25.19.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 19:00:40 -0700 (PDT)
Date: Mon, 25 Mar 2024 22:00:38 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>, srk@ti.com, s-vadapalli@ti.com,
 vigneshr@ti.com, r-gunasekaran@ti.com, danishanwar@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/5] net: mdio-uclass: probe generic Ethernet PHY driver
 & Fix Beagleplay Ethernet
Message-ID: <20240326020038.GF3442575@bill-the-cat>
References: <20240305-for-2024-07-beagleplay-eth-v1-0-e1294a575cc1@kernel.org>
 <a91f3573-0e2c-49ff-bbe0-933eff7eedc7@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ra66cdRjLbVcQ9R4"
Content-Disposition: inline
In-Reply-To: <a91f3573-0e2c-49ff-bbe0-933eff7eedc7@kernel.org>
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


--Ra66cdRjLbVcQ9R4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 02:16:53PM +0200, Roger Quadros wrote:
> Hi Tom / Joe,
>=20
> On 05/03/2024 15:24, Roger Quadros wrote:
> > Currently, the GPIO Reset Device Tree properties of the
> > PHY node are ignored when the PHY is probed via mdio-uclass driver [1].
> >=20
> > To resolve this, for each child of the MDIO bus node, bind and probe
> > the generic Ethernet PHY driver if CONFIG_DM_ETH_PHY is enabled.
> >=20
> > This should now show the generic_phy_driver in "dm tree"
> > and also apply the GPIO reset before the MDIO bus driver scans the bus
> > for the PHYs.
> >=20
> >  ethernet      0  [ + ]   am65_cpsw_nuss_port       |   |-- ethernet@80=
00000port@1
> >  bootdev       3  [   ]   eth_bootdev               |   |   `-- port@1.=
bootdev
> >  mdio          0  [ + ]   cpsw_mdio                 |   `-- mdio@f00
> >  eth_phy_ge    0  [ + ]   eth_phy_generic_drv       |       |-- etherne=
t-phy@0
> >  eth_phy_ge    1  [ + ]   eth_phy_generic_drv       |       `-- etherne=
t-phy@1
> >=20
> > To test this on Beagleplay, the following series is required
> >=20
> > [1] Switch am65-cpsw to DM MDIO
> >  https://lore.kernel.org/all/20240228-for-2024-07-am65-cpsw-mdio-v2-0-f=
74f972eafeb@kernel.org/
> >=20
> > The last 3 patches are marked [not-for-merge]. They are to show how the
> > whole solution can work to fix Ethernet on Beagleplay, which has been b=
roken
> > so far. Those DT patches will be sent once the device tree changes are =
merged
> > into Linux tree.
> >=20
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> > Roger Quadros (5):
> >       net: mdio-uclass: Bind and probe generic Ethernet PHY driver
> >       configs/am62x_beagleplay_a53_defconfig: enable DM_ETH_PHY
>=20
> Any comments to the first 2 patches in this series?

Oh, so the CI failure, unfortunately, was because sometimes those tests
hit some resource-related race condition I believe. And I took your
comment at the time to mean you would v2 them. Yes, these patches seem
fine as is and I'll pick up assorted changes for -next soon. Thanks for
your patience.

--=20
Tom

--Ra66cdRjLbVcQ9R4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYCLEYACgkQFHw5/5Y0
tyyxFwv/SjOPIkX94bZdLYp53zqhL7jmwpzf6lC86wm8SYVoTOe1+yVxJPHG316O
5GYgWXCOyGLqfkTcQUHLjOTgZ4gnbdV7kXs0i91onDuLSxfYyfe+8rrWy2KIOymg
Hr7v6yrPcCkOBgse6PqvstFgH6MeokAP5fBgpTNpbR6OZIIKEPo7c6Y/RfE++hj8
SBMC2bKO14HjRufnmdfslJTlcFVy9TVlAgGFEJlx4fFkzCo4BSVTwJ+ldRtjBwWx
S07DxEzLXLzL9FpfNnkZb/jiHOe+CIOAyRkvY8GQ8IHMGYOmWxehtVXP+Bgw5twN
phfBMub+Z/Zv4aWKp9mT8MEsVRxZOputbISylwqhNCq8C70idFR9CeeyhEm6PXKe
hWC0gA0LJo1O/u2PIFYtzc8FFnSdN7kD3mwnwz8iXnyHSANxCS0hXcx1FZAQaLpI
IJENp4iowX9PGHWA6OMWsX8evKlYulY9VHCo3EF45ZABXub9qJhJcIdLpSUD2K3g
qO/muG6g
=SQDZ
-----END PGP SIGNATURE-----

--Ra66cdRjLbVcQ9R4--
