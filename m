Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1050F51416
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:33:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D7483F2D;
	Fri,  6 Mar 2026 23:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CNpkzrzW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C09783F8A; Fri,  6 Mar 2026 23:33:24 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B634B83F2D
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c1d2123dso10721219a34.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772836400; x=1773441200; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=d2oeBjJF2hUFSaB5rg0q6stK8Oa+SnM/8WFWy1TKplg=;
 b=CNpkzrzWvD+7O/PCZYcYKSy54WFuxhwNA5G1rFVWqrYQ5qq8LmJemqoABkUZ95gI0M
 p1dr6Qs3PNdw1P1mEqzUWP0kI9LUP60NIzU0WBdSnh6cDUHQfTVsGOF7I8QL0/SLCG+f
 JFGLeHyp3Rb6zr45+6vi8wIENctz+M/peQ7LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772836400; x=1773441200;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d2oeBjJF2hUFSaB5rg0q6stK8Oa+SnM/8WFWy1TKplg=;
 b=g7OuQ7S5oZDTkD83ri98aRTmQ6AgcH6rfzNwDNYYroFlWZUifhiZ483KBfFpW7PVzm
 N+xqP/y2QvzR9To6jY6mrx8sQIFJFMesqJfjE6eCf0Jynaz6KQJwkGJ4BS89S6uGCDT2
 p+/LFjawNEa0We4fnHhkF+aFqbKGv+XpV5xwBvPSLRx5FaSzKXJUQnkjtHL+tePKQ0TQ
 4VI9KOYSELP3Blal/kob7oG8Tm3vADnsoW6ag0bTccUBblUkJqOORo+EQxdpE6pcxi8N
 4Rrp9qvtXw8tqcFcAeIwHVM0YaP4Bqjh5Gcxh95wteNdvHi+XdV1fWXWUrUWYZUR2fMv
 njpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJfUh3Ugqi7fcUeHSNpb1mui/ovem4/ygoGNYF+yL0+4sv2q0wgvodwth7jjgfoPLmYvvySVA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0BpBWsfwN/2tYeCwpXLW0Z+xpDb1ClUv1dhKLj229s+Xuu1O3
 QMOth2jJprKGJlPFW2fNh+BoS6ayaNfHtNoGzMg/j4X1SamKhEkK+eMRS7HFMmSOXpo=
X-Gm-Gg: ATEYQzyaEMtj43bltjsJwPk9MzV4jQnIzMjGBMRa/AyrDuGqq6lrRM+6+JMtFZUm97g
 RDdIsZeVIkjKkR+YBNQ2EFsGA9P5vY/DJZs0uxqjjD5X8f7Uw1XEiVcZohLv8yPNQVlr6v8bOLa
 JH9dMPwg0cL++UlpfvNRRT9aLBEXyrff25y57e3fXRXbeq8Asg1KQL6+/uPycP58cviSiuY16x3
 VNA+m8mru9TYRPgaCzVOP+IIEokI0PNUH7Y09kOP4pmkDPSIlIIyd31w1Wn+ewV3CyYzDdx4y7Z
 hVC6jYhFEZDkGJvEHvd6cSoMVb7SYOw0ZsjyyNnM3c+TL+f6Bm4fdH2aybNykoUmOZrPT1efhzU
 SjbNr4mrtcUqazgXO2XIE6SjL4uXELFch3BBj254pNwOK0J3UZxeue42vJydNOO6McF/AipH+CG
 aK/MnVOIUxVXNZ84z/6/f3kn3R3yStFimmyLNlGqIjcsXtN/yE4RwXWBTvOmMGm2Fp1LrR1IJiT
 uPgL49od/NHn8idktyCSz1FErv9HuqS6VHV9Jl3Xi0dRURr50M=
X-Received: by 2002:a05:6830:620f:b0:7d1:9516:6858 with SMTP id
 46e09a7af769-7d72702d2a3mr2584454a34.24.1772836400499; 
 Fri, 06 Mar 2026 14:33:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728c5e182sm1717721a34.6.2026.03.06.14.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:33:19 -0800 (PST)
Date: Fri, 6 Mar 2026 16:33:17 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Subject: Re: [PATCH] video: stm32: dsi: add .of_to_plat callback
Message-ID: <20260306223317.GW1388590@bill-the-cat>
References: <20260205-dsi-v1-1-eb5805068e97@gmail.com>
 <50a9f6c3-4284-460c-a429-49b4a53c836e@foss.st.com>
 <beec85d9-a580-4ae3-854d-3c957b888eb2@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iT2IUXMr7v49cPNk"
Content-Disposition: inline
In-Reply-To: <beec85d9-a580-4ae3-854d-3c957b888eb2@gmail.com>
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


--iT2IUXMr7v49cPNk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 05:23:23PM +0100, Rapha=EBl Gallais-Pou wrote:
> Hi,
>=20
> Can this one be picked up for v2026.04 or is there something I should do ?

Patrick, Patrice, should I take this directly or is there some
objection? Thanks!

>=20
> Best regards,
> Rapha=EBl
>=20
> On 2/24/26 11:01, Patrick DELAUNAY wrote:
> > Hi,
> >=20
> > On 2/5/26 00:35, Raphael Gallais-Pou wrote:
> > > Drivers should extract device-tree data before probing via the
> > > .of_to_plat hook.
> > >=20
> > > Implement it for stm32_dsi driver.=A0 By doing so, it also solve a
> > > variable shadowing in stm32_dsi_probe() where &clk was used as
> > > peripheral clock and ref clock.
> > >=20
> > > For readability some struct have been renamed such as:
> > >=20
> > > =A0=A0 * struct stm32_dsi_priv *dsi -> struct stm32_dsi_priv *priv
> > > =A0=A0 * struct clk clk -> struct clk pclk
> > >=20
> > > Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> > > ---
> > > This patch has been tested on stm32mp157c-dk2 board.
> > > ---
> > > =A0 drivers/video/stm32/stm32_dsi.c | 168 +++++++++++++++++++++
> > > +------------------
> > > =A0 1 file changed, 91 insertions(+), 77 deletions(-)
> > >=20
> >=20
> >=20
> > Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> >=20
> > Thanks
> > Patrick
> >=20
>=20

--=20
Tom

--iT2IUXMr7v49cPNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaatWLQAKCRAr4qD1Cr/k
CoE1AQD0QdtbMbeQWfGAyCvGDkTF+iCXaKP1cAdA53DFCj1ofwEA1lEsjeig/AbB
UE70mQCIWAkSqc+nzhAhi2ubd3bi5Aw=
=Q5ST
-----END PGP SIGNATURE-----

--iT2IUXMr7v49cPNk--
