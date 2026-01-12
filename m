Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4FBCF45BB
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 18:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F318382A;
	Mon, 12 Jan 2026 19:06:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gIrxaBo+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0124F8388D; Mon, 12 Jan 2026 19:06:44 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C601183759
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 19:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-3fe3cc80bc3so3727324fac.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768241200; x=1768846000; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=erthKSZ6iPdBhOLwPxkw7BloMWfY5AM7ogPjXWO1YdI=;
 b=gIrxaBo+a0TtZUD/2zeXb7bXkrf6BH/rmiEEBdRuDwFnp5oDwEZfygiLy0Ypa1JecE
 ZJD9+H5gKqTnqn5SzfCG1nNhbdOl1s2OzwPwhkm8Cpo5Bof7VzKTktxeIYZX+OuNDZ1k
 LBlYjP/wnGbLY0+qwX1zm2QNaqEMwYS/eFSDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768241200; x=1768846000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erthKSZ6iPdBhOLwPxkw7BloMWfY5AM7ogPjXWO1YdI=;
 b=EL0Jtv5Z8fVADfxI5Ei/D9PeqfYTDG524F5L+RLZdIUvAdLz8svQGA9R9pIeuA2bUC
 u8upTXNSSCIS56UnJX1tBD+DaKSS8f9xVGKRzhA8s3i38QXxMNagmzaItBr/GJu1dJQe
 7msa7PZ2YCWzbMH9uR1U/iboxLz1DfJTqXq7u7RjEXMys3sLweNG6DZQowWhxtsMXHFS
 xxAtQqooChUpUIcGdCd1zrr8TtmjsJFqnFD5kEzT4iXXVTWeBZXq6vnpw7qQplGRE7yN
 +6e+eNLwILAn6ZruS+M3/p6V8IKofPdrHMvsHa7ZXzgz96NjLyYuKYwNANA6t8mr2qzI
 r8aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfJR005N0r1vcmRloSgjeLTs7a+QjtkOEWfTsTP8ehY3E69zLmLxtY9OIqHiCRycZE/ERzSZE=@lists.denx.de
X-Gm-Message-State: AOJu0YyPCICRZS7Dnzmzw6B6ezMnl3f6d+FsFYTo4MbDERUPPFc96w15
 m1WMVcBH+WfqOgCiWHkdF2Ke9LO+0HOUmpK9+6ocqR4Ek4uvzkUmF/+OlSrKWD11sao=
X-Gm-Gg: AY/fxX6qQPpCjEobG42yqLcWywwU3u8gYjovReUi8ZdKpSJi6+qgWQnpuVWqQyNN5rF
 9ij6T8eOIzCDS61HN5NxEEEJLiVZXELgewgd1iyz9uALzSo47c1XyTeDg8dUx8f8d+z90AIwhCO
 HmShC1Q1dNHcmgmDy6f+vOBFYPcXCYb3Wih9ONT2jYXO5jaR34O7SczXR+zzYJ5b1zay2n6Iupt
 dBfeCPfRh85ZB2nJBiyMaELGXqZ7akRNmi9Ey6BWuNo+VzZp/TDP/2f1Xr8PMl1XKxHX15StJdL
 I77Aaf0kgY2uXRfKSXAPlF1GRbWaTH2O8wz9h8bwZ7RwzUG1J30RdgJOtvNwzLhhURXQx4CuKKU
 1vIAkCndrctGgOKw6YzIddsevLf8jg5C9ZOEI94KaRxoLckvci3UUNGJpNWcdRPNkUTizTf5wzm
 4ky0/QqjgaLjPwVdDw3Txy6yV80bmK6XbtG3xh7P35TuXd1l2qQAmBEZDl8MAe4SHaAo8F1Jl6P
 3dR1hZtmXKrUP4CZ3qpchf7WwaXq7GNQyDad4c=
X-Google-Smtp-Source: AGHT+IHMKosHECSc4+Zx0/DZ1EmDSc9S9i8aKwxXsTmq2VUbIcLRUggYDk1hwyiYs1cRyUGa2EZ6Vg==
X-Received: by 2002:a05:6820:2d48:b0:65e:da9a:976f with SMTP id
 006d021491bc7-65f54ed7966mr5646365eaf.11.1768241200388; 
 Mon, 12 Jan 2026 10:06:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65f48bec1c4sm7346752eaf.8.2026.01.12.10.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jan 2026 10:06:39 -0800 (PST)
Date: Mon, 12 Jan 2026 12:06:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, u-boot@lists.denx.de,
 nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 srk@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id
 for CPSW ports
Message-ID: <20260112180637.GR3416603@bill-the-cat>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
 <20260112074948.GA101138@francesco-nb>
 <20260112075636.GA105765@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l3dCGue1f5wWDFkV"
Content-Disposition: inline
In-Reply-To: <20260112075636.GA105765@francesco-nb>
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


--l3dCGue1f5wWDFkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 08:56:36AM +0100, Francesco Dolcini wrote:
> On Mon, Jan 12, 2026 at 08:49:56AM +0100, Francesco Dolcini wrote:
> > +Tom +U-Boot ML
> >=20
> > Hello Siddharth,
> >=20
> > On Sat, Oct 25, 2025 at 01:07:59PM +0530, Siddharth Vadapalli wrote:
> > > The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPSW5=
G and
> > > CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode. =
This
> > > correction has been implemented/enforced by the updates to:
> > > a) Device-Tree binding for CPSW [0]
> > > b) Driver for CPSW [1]
> > > c) Driver for CPSW MAC Port's GMII [2]
> > >=20
> > > To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update the
> > > 'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' with
> > > 'rgmii-id'.
> > >=20
> > > [0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss: =
update phy-mode in example")
> > > [1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY mo=
de for fixed RGMII TX delay")
> > > [2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMII =
ID setting")
> >=20
> > What about U-Boot?
> > I just noticed this in today U-Boot master:
> >=20
> >   RGMII mode without internal TX delay unsupported; please fix your Dev=
ice Tree
> >=20
> > and I think this is coming from the DTS update from Linux to U-Boot.
> >=20
> > Can you look into that?
>=20
> Ok, I think that the issue is that the U-Boot code was updated
> correctly, but now we need the v6.19 DT in U-Boot, and as of now we have
> 6.18 DT.
>=20
> Tom: are you planning to sync the U-Boot DT to Linux v6.19 before the next
> U-Boot release?

Once it's out, yes. But, uh, this tells me some TI folks forgot to
backport all of the dts changes too then as we shouldn't have broken
platforms in-tree like this.

--=20
Tom

--l3dCGue1f5wWDFkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWU4KQAKCRAr4qD1Cr/k
Cvk3AQDuM/GRmnrbkiiukhCxNdwOxiZCH8uDyIsMLBzAm2bFqwD+NlctSgODsb0C
erEXYpRFivilIFIFxVhDG7lW0OOJSAE=
=p3wn
-----END PGP SIGNATURE-----

--l3dCGue1f5wWDFkV--
