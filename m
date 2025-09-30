Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72CBCCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39C683526;
	Tue, 30 Sep 2025 16:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PQuyHw1u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD2D983510; Tue, 30 Sep 2025 16:38:04 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F263583510
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-92aee734485so85848439f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759243080; x=1759847880; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q+MlOmqJJS30WlBmy7t2avgF941jzTipa1YyIUXso8M=;
 b=PQuyHw1up81//urBLBo5KuJP9r7GXXqL2o1Dz8LxysA+6mEk8UfLDvivJWN2WEeL1z
 TUAS3qzcNex/Dp9uu9mmVbD1h4SB8emxcayCpQsVJ5PpGNNUsJdwLd1PdBVa6HR1XRSJ
 LrCKaQSaSuuFO+sguUFxByWnHxfJR/AQYnFFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759243080; x=1759847880;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+MlOmqJJS30WlBmy7t2avgF941jzTipa1YyIUXso8M=;
 b=u0ZvxPFB7JUdsk5yojeNyBIbkULo4/OauB93WNb6rAyKDoLrAYBKkNGUo2Y6ztnVf0
 fadTU8vgPhhK2ZqdKXuiNrcmix8zLVVBHR73jpyuK2yzrms6rqIBltd3K3ghv+tDTQLk
 y6q7NFEyxQJTiSdz6vJZQiNHzQz3J+XdF1pukBiNHmmntZ73C/4NgaSc0FLXDtqFkGPm
 eB2zDnTi0BgXZ445D6VQ/T3xNnUQGU0albvZEUMEm0OdLThKwVz1Pn0M31BKuYZbS8pk
 GMMhJevzZNjgebo+2cdC/inW/8MAnFfqO2wecIUdmel6Hd/VUAJymA9WcubccHJCEUmn
 n2ew==
X-Gm-Message-State: AOJu0Yzt21n2P8T3fcWiMF5LmxhzxrpZnjLF0A6MsmM2hiEBHawThPj9
 JehGrdQFSGFIBgS5YYLtmJPR0Wj9WG0//uOXCiT/o/rsLsSgaJhZCZYw9/OlW9u2miQ=
X-Gm-Gg: ASbGnctwTuwPTUeXqtXJmWP2R42pPZeEwXsGo1W1FN9//wEnjYrbcS82FN1Ui4/hy0j
 l+i+9afCc/vgNkN3Ez8blBJ34yZ+AHn8BfPU8DtoEVIFdUNk0scU8o6ahFvoKxXhdlrDZc4W8c3
 oiQd0EXsqomb7G69K7fO5hQHEhqpRFQDxgDjc3GO3Dr5YqmHArwWP++oy//vIw+me0k2zrSQ50a
 xPpzBVH3LmkWmC3BcpUlkzzuW9fVH7PyA3zNm6r2gRPPg69cN6yjtIR62CUQnJUV7ix2H5JW7Kq
 9dYWEb3D7LOiwwTFEtUanhheREoyW5GNkRDfUrvydUXjdorTvgykQi3vzGKXlqkeirRQ9ozAK1w
 PHo6YX4rYfmXfavClyHlpq4zZSC4srUoGsq2rPPchuoVwwaugtByLW2kV8Ge7YPCHm12ClPkX/W
 QwNB9A
X-Google-Smtp-Source: AGHT+IEogENtvSUCi0/DvPiDvlu8tKjs2RFgyWbfrr4qbaINCLlzq+8REu1PbHMOZ2SBbofDYSlf0A==
X-Received: by 2002:a05:6602:27c5:b0:8a3:70e4:9abb with SMTP id
 ca18e2360f4ac-9379f9b77ebmr9074139f.0.1759243080374; 
 Tue, 30 Sep 2025 07:38:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-903fb455cf1sm521457939f.11.2025.09.30.07.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:37:59 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:37:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>,
 Mathew McBride <matt@traverse.com.au>
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
Message-ID: <20250930143756.GW6093@bill-the-cat>
References: <20250929224336.GS6093@bill-the-cat>
 <20250930064938.GB17703@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u1ZbiQ5XQpPVKTgZ"
Content-Disposition: inline
In-Reply-To: <20250930064938.GB17703@nxa18884-linux.ap.freescale.net>
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


--u1ZbiQ5XQpPVKTgZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 02:49:38PM +0800, Peng Fan wrote:
> Hi Tom,
>=20
> On Mon, Sep 29, 2025 at 04:43:36PM -0600, Tom Rini wrote:
> >Hey all,
> >
> >As part of working on "allyesconfig" support I ran into the following
> >problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> >implement support for the VSC8584 PHY. The vitesse.c driver is much
> >older and only had VSC8584 support added for a specific Freescale
> >Layerscape platform whereas mscc.c is modern and been updated with
> >newer PHYs as well. And we need one driver to support this phy, not two.
> >I am inclined to remove support from vitesse.c. However, only 4
> >platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
> >
> >I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> >that use PHY_VITESEE today to see what their feedback is on which way to
> >go here. I'm ignoring PowerPC because that can just stay on the
> >PHY_VITESSE driver based on timing of changes in git log.
>=20
> There are many Layerscape boards that we need to support are still using
> PHY_VITESEE. I need to check internal to ask for resources to help on
> the migration.  BTW, to support allyesconfig, is it feasible to
> make the two configs exclusive, saying "depends on !X".

There are Kconfig workarounds available, but there's enough work to be
done still that I'd rather see about fixing the root causes, or as a
worst case here, remove the duplicate code from PHY_VITESSE and enable
PHY_MSCC as well on the boards that need something from each driver
still, if we can't switch them to the newer driver outright.

--=20
Tom

--u1ZbiQ5XQpPVKTgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNvrRAAKCRAr4qD1Cr/k
ClfTAP93xM9xsJfvEgmWgoriQkYkQ7vBkBFHpxonACL82ojfhQD+IHbZaSpsWy2Z
22orHgacub1iL5evMGv/ACxCBx7Sfg0=
=WQGn
-----END PGP SIGNATURE-----

--u1ZbiQ5XQpPVKTgZ--
