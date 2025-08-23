Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3060CA0EED
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 14:53:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EE681D5D;
	Sat, 23 Aug 2025 16:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C1NrC0ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328F983093; Sat, 23 Aug 2025 16:53:36 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA7C80422
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 16:53:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-435de838484so2134804b6e.3
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 07:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755960813; x=1756565613; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y4x0MubRUV47wqkNC6fDBLE6QjOLn4a3E+0FVhkPm6s=;
 b=C1NrC0ouPo9Pv3pbT9NzvIAK/FRj+jHmV93FPWTx2QtR4MhSvFBWuu+pwnBak1Ggj+
 bJo63dcGPwtHG8B07NB0u2r73trjqID4aWG/OsPYuTU/HZzi25b7nuUKzVbWkRhAB42l
 0qb/UI2w4z+T3wurpD9LloN5q2sgIypwoQyPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755960813; x=1756565613;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4x0MubRUV47wqkNC6fDBLE6QjOLn4a3E+0FVhkPm6s=;
 b=jDKZY786V8YHOSTHo3UNo85Ocj9IWEdvUAaDZt3wTnF/q/bz/mFwYt8mD5vrscMEMS
 AsqXzFiJ2R1Tkm489UGcQ6zUCnZ9zUJzPJPiw8xaLNV1hy5R05Fi1Crv/n1moiE5LTuc
 zMCFkEo7/9XoDPpMGl44oZ4HiLWLdAngVEehI5jrfxmdP6SE1C3zqRmVwKwTc3+2HqSV
 eVFsyahKtXqERdZopkIxaklTxK7WamFFrtkARwPRAiWPvbw9h3Eno4M2w9oBikmsHHxA
 oIVxOa7qSt8HmJPFHaDMGfYiM4ZGZB393tX+AquziVaUPmriTovJdUyi8P/wKv6RooXQ
 SDlQ==
X-Gm-Message-State: AOJu0YxRUsQaxLODyXiyUPYIPN0b42nhFnMPDj3zcS7H0TKk502pGCFv
 2FZGFgOfypgijJyzDWrMV8YIkr2hLScV7bxglmUoZJYvMPH49JglxTl6UlldXM653vg=
X-Gm-Gg: ASbGncvZ+gp3riH3v06b9TszINn/xS6yRvMhxkSURFPUZxfI1EXOjz7RA1bZ9FjD4rR
 wiPLykBIF7tAyTLFcjV6FB5hM30TEY5fdpVxwWnoy9kZaZOcG6VU3BKhO0JJunFM4Nn+x7R/tL0
 9vXCtCWbHf/sqseaj6yzRsBWzJp8cAokvwhoaojMiXSaPDETRobm9iiwzphz1n41I/qDruzne0F
 9LbnBoAQ4jmgTXlJY/hE9v7pPo8mFxrWMHmUk8owWTO2zb3LdY6r/zi9BNG/Dlfew/wLrOlbQPt
 3SA0cT8teicOjAFBDwzcrCs2743jGm+eS+N+JLB3Fx08eYJx5NA9n4vnXog2uy8dwosiopEgzgt
 FUChocETI8wfZTLgVh9goFzD2Y9ErqBBO7rnd6lESVT2yBDjjqaIvu2ds
X-Google-Smtp-Source: AGHT+IHv20dsIE1GBo1nndWa1DtblS+ysT7KeW2795Okv/Q2Ot5QTGycBWlAt5gD6r6fqwSLDkszNQ==
X-Received: by 2002:a05:6808:178e:b0:437:75ea:6c96 with SMTP id
 5614622812f47-437852b916fmr3371099b6e.43.1755960812616; 
 Sat, 23 Aug 2025 07:53:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-437967bf0bfsm388171b6e.2.2025.08.23.07.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Aug 2025 07:53:31 -0700 (PDT)
Date: Sat, 23 Aug 2025 08:53:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Mark Kettenis <kettenis@openbsd.org>
Cc: u-boot@lists.denx.de, j@jannau.net, maz@kernel.org,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: Re: [PATCH] pci: apple: Fix use of uninitialized variable
Message-ID: <20250823145329.GQ124814@bill-the-cat>
References: <20250823140356.11344-1-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Tddw1WD9l5XfL1dL"
Content-Disposition: inline
In-Reply-To: <20250823140356.11344-1-kettenis@openbsd.org>
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


--Tddw1WD9l5XfL1dL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 04:03:56PM +0200, Mark Kettenis wrote:

> Replace use of uninitialized variable with the PCI device number
> in an error message as this is what we use elsewhere to derive
> the PCIe port number.  Use ofnode_read_pci_addr() to read the
> PCI address of the node and derive the device number from that.
>=20
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>

Reported-by: Andrew Goodbody <andrew.goodbody@linaro.org>
patchwork should pick this up, no need for v2 unless there's real
feedback, thanks!

> ---
>  drivers/pci/pcie_apple.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/pci/pcie_apple.c b/drivers/pci/pcie_apple.c
> index 6a8e715d4b6..f5fda9835dc 100644
> --- a/drivers/pci/pcie_apple.c
> +++ b/drivers/pci/pcie_apple.c
> @@ -246,8 +246,9 @@ static int apple_pcie_setup_port(struct apple_pcie_pr=
iv *pcie, ofnode np)
>  {
>  	struct apple_pcie_port *port;
>  	struct gpio_desc reset;
> +	struct fdt_pci_addr pci_addr;
>  	fdt_addr_t addr;
> -	u32 stat, idx;
> +	u32 stat;
>  	int ret;
>  	char name[16];
> =20
> @@ -259,12 +260,13 @@ static int apple_pcie_setup_port(struct apple_pcie_=
priv *pcie, ofnode np)
>  	if (!port)
>  		return -ENOMEM;
> =20
> -	ret =3D ofnode_read_u32_index(np, "reg", 0, &idx);
> +	ret =3D ofnode_read_pci_addr(np, FDT_PCI_SPACE_CONFIG, "reg",
> +				   &pci_addr, NULL);
>  	if (ret)
>  		return ret;
> =20
>  	/* Use the first reg entry to work out the port index */
> -	port->idx =3D idx >> 11;
> +	port->idx =3D PCI_DEV(pci_addr.phys_hi);
>  	port->pcie =3D pcie;
>  	port->reset =3D reset;
>  	port->np =3D np;
> @@ -333,9 +335,10 @@ static int apple_pcie_setup_port(struct apple_pcie_p=
riv *pcie, ofnode np)
>  static int apple_pcie_probe(struct udevice *dev)
>  {
>  	struct apple_pcie_priv *pcie =3D dev_get_priv(dev);
> +	struct fdt_pci_addr pci_addr;
>  	fdt_addr_t addr;
>  	ofnode of_port;
> -	int i, ret;
> +	int ret;
> =20
>  	pcie->hw =3D (struct reg_info *)dev_get_driver_data(dev);
> =20
> @@ -357,9 +360,14 @@ static int apple_pcie_probe(struct udevice *dev)
>  	     of_port =3D ofnode_next_subnode(of_port)) {
>  		if (!ofnode_is_enabled(of_port))
>  			continue;
> +		ret =3D ofnode_read_pci_addr(of_port, FDT_PCI_SPACE_CONFIG,
> +					   "reg", &pci_addr, NULL);
> +		if (ret)
> +			continue;
>  		ret =3D apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {
> -			dev_err(pcie->dev, "Port %d setup fail: %d\n", i, ret);
> +			dev_err(pcie->dev, "Port %d setup fail: %d\n",
> +				PCI_DEV(pci_addr.phys_hi), ret);
>  			return ret;
>  		}
>  	}
> --=20
> 2.50.1
>=20

--=20
Tom

--Tddw1WD9l5XfL1dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKnV5AAKCRAr4qD1Cr/k
CvcDAP9uNCZYHeKj+a80XNLDV8t6RE8Awk0RThkjM36uPyyjlQEA165FZjaBRXFJ
oUiuT8w0++WilquJ/JFHk/Cbbft7dgs=
=0jdB
-----END PGP SIGNATURE-----

--Tddw1WD9l5XfL1dL--
