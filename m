Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9433CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 16:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1636B802C1;
	Tue, 30 Sep 2025 18:00:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TxExpEM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C4882998; Tue, 30 Sep 2025 18:00:06 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7DBD800D7
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 18:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-42a1145f626so11405285ab.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 09:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759248002; x=1759852802; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xGD0FoCL0zJAovXNGBqcCm109J7dN5N+eMKFV7quknY=;
 b=TxExpEM+bK+z837nVaAqMx4x34/7TJjl8S9z8Z0tcUpngQq+Vw7GS+hbvZoTC926j0
 5UmIM39kGgMVYV2+SYJi7+GWe242tA+KPnLMjNScqM+zBKZgrCy4kr4Y0TUrImdVmBP6
 ESmRY87SpnlUOlPqeu+Qo7EZiFPGE1pp9OoAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759248002; x=1759852802;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xGD0FoCL0zJAovXNGBqcCm109J7dN5N+eMKFV7quknY=;
 b=BirqKpVTmRrLjD3LnDpD4qxAya+QptcALWrYWt4vZ8IAqBg6EvysbIMAjURI1fgHJ7
 EDW/n5Gw2qWHOeuHMWd/QmrflPkzfwtdaNDdgAO5Vddp/xB8LJ0M9fnxUE8NCSGtXuHK
 bitw/9NwgRL4+41RHTpKEPz1xchuVAn+kraJy/J4ePKK0Hurg5hGR7OsgmJSgWLlb6ab
 SRNHgiEA5Z8vvPOkRIfu232eth2XkbckSA/JKwuwqgOXXhLOnj+o8Avem/hS92PnjDSz
 BLAb0joqOmhqSLr6CJDBrUtJAM7oj12v+xIgKV1KW0b1lyp/82PErdUKoIUq4PTkEctJ
 0cKg==
X-Gm-Message-State: AOJu0YwPlyJ5QV9Vy9Dotrsfn0wVsHDVoeDDaZy8NydJR5ZipFFRtEOy
 +xY0NysUfowz2duDaNKGzSQKd3pk0/q3YTMGUtDgTyKCb89ozMG4SQZJouJRGl+KuYc=
X-Gm-Gg: ASbGncsTKz3hEVY7mLehoNvCdV3n5Trnm8lkIadN9XJu1U+ygIqH48h/kUO2JL3Hx+j
 V6qtjTJQdgs2UEDeqa9dNgQXDBhcm3cuuieynJlcVhJcVGJt/P1VRrs8zhMGF+tjcfSInz9HSxf
 1q0v8kWIEDj6Zbml4DL6IaiiW3soKU6uq5IARbKyiVALIKDRdsLX6OphlH/dVBMUQ4/Q3ZRO+HM
 47EX1EOLkKR8jiAHSGJWuzUOO0N37caU1Cz/rmn8O7L8KB94EWndKSWdtKTXhHZkahpgeofo9xx
 5/0jqfUhg6uoBKJFLB9pvRcGLCtdBVQtr/A8keoM9JiBcPwM+aIjLlkETmH52BzdALflKXBq61C
 FK1Iq/ehQqDig97L0oHQ/eN8rk0lmq4YUp0ADTBwtNRhIrws1Qs5fHoJ/5EAGfB95iGzOh+nSdI
 Sn8jOKSR6WgCqym/A=
X-Google-Smtp-Source: AGHT+IE21tw6BAwm6qrndKg+a9EyOXfHkDJuO2LuBTZub8iGHJpN6sOIUriKv20+R5HFGkqljPm5/A==
X-Received: by 2002:a05:6e02:16cc:b0:426:3ab1:74b4 with SMTP id
 e9e14a558f8ab-42d81664c4emr5713665ab.19.1759248001618; 
 Tue, 30 Sep 2025 09:00:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-56a6a5ae6b1sm5742915173.68.2025.09.30.08.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 09:00:00 -0700 (PDT)
Date: Tue, 30 Sep 2025 09:59:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Mathew McBride <matt@traverse.com.au>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
Message-ID: <20250930155958.GD6093@bill-the-cat>
References: <20250929224336.GS6093@bill-the-cat>
 <6aa43496-d104-4e72-bde3-6c1f01507e23@app.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PoV6QG1PRmZoE8GN"
Content-Disposition: inline
In-Reply-To: <6aa43496-d104-4e72-bde3-6c1f01507e23@app.fastmail.com>
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


--PoV6QG1PRmZoE8GN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 10:16:56AM +1000, Mathew McBride wrote:
> Hi Tom,
>=20
> On Tue, Sep 30, 2025, at 8:43 AM, Tom Rini wrote:
> > Hey all,
> >=20
> > As part of working on "allyesconfig" support I ran into the following
> > problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> > implement support for the VSC8584 PHY. The vitesse.c driver is much
> > older and only had VSC8584 support added for a specific Freescale
> > Layerscape platform whereas mscc.c is modern and been updated with
> > newer PHYs as well. And we need one driver to support this phy, not two.
> > I am inclined to remove support from vitesse.c. However, only 4
> > platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
> >=20
>=20
> At the moment mscc.c in U-Boot does not implement the particular PHY mode=
l (VSC8514) that we use. This Quad GbE PHY was on a number on Freescale/NXP=
 QorIQ (PPC & Arm) dev boards. Until 2019 Freescale/NXP was selling a licen=
sed version of this chip ("F104S8A").
>=20
> The Linux version of mscc.c does support these PHYs, so we can bring acro=
ss from that driver.
> However, many PHYs in this family have complicated errata workarounds, an=
d the VSC8514 is no exception.
>=20
> I have made some attempts to "port" the mscc.c support for VSC8514 (errat=
as included) before, but it's errata workaround method does not seem to wor=
k as reliably in U-Boot as it does under Linux.
>=20
> (I also have my own version of vitesse.c which implements the errata work=
around for VSC8514, derived directly from Microchips own SDK sources. Unfor=
tunately it's too messy to submit to U-Boot, but it has worked reliably for=
 many years)=20
>=20
> > I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> > that use PHY_VITESEE today to see what their feedback is on which way to
> > go here. I'm ignoring PowerPC because that can just stay on the
> > PHY_VITESSE driver based on timing of changes in git log.
> >=20
> I'm in favor (as far as board/traverse/ten64 goes) of migrating to mscc.c=
, it is just a matter of finding the time to sit down and implement support=
 for the PHY I need (VSC8514).

Thanks for the detailed explanation. One thing that could be good enough
is just picking one driver to handle the PHY that both have (ideally
PHY_MSCC) and then improving the situation on top of that as time
and complexity permits.

--=20
Tom

--PoV6QG1PRmZoE8GN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNv+fgAKCRAr4qD1Cr/k
Cg7DAP0Yj21+cu5kwhMN7apYYEqVyIGnz9ajZ/NNvpxhd76IagEA5gSBxV4xs5A0
0ioz+6OL9asyL7l5PphnatE97ysgmQQ=
=sL+c
-----END PGP SIGNATURE-----

--PoV6QG1PRmZoE8GN--
