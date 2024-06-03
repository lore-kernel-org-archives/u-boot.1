Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA3FC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 17:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA2568834B;
	Mon,  3 Jun 2024 19:56:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qkz7sSh/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79100882AF; Mon,  3 Jun 2024 19:56:16 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5019B8837A
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 19:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5b96a78639aso2080422eaf.1
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717437373; x=1718042173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qQTN4ckRUV2Na+XTgR9T1PPzkpylFpndDiM+MEleK70=;
 b=qkz7sSh/gJM6McMfBzyDaEiJk+2G1toB8ZBBz2M221N8R3C40Xl9Cq+CuQE1E/q97C
 DOTtZ899XNusuoXvtUKHCpI+XwjyfuGFoYaaLrYHXTDI+IlEYvcoot9QD05MrPygRN3s
 z6e3mdOnXzXoLW8/D7peiOqjRrbZJ+CR3moy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437373; x=1718042173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qQTN4ckRUV2Na+XTgR9T1PPzkpylFpndDiM+MEleK70=;
 b=FsH3VJR432t8RrTuyqOtUgSLkzrFfD0FwF98CArWCrM86ICP5+4Hb4KKdA/bgGOyY/
 lL1CVRFGQgZo/gqfYG/rMLLBrF94bS8w/gurf5X2EcwPLVBvBEkqFxyf+WmoQWOyLSfy
 N9Ie8zQT5dnYYzK63KbE+qRDKGfObfjvHC4uOl14TVzkq+6gY7/UIZ1F0yZHMiN6pzxJ
 Dq0hytQpWJLxUeIrn0TOVrjkXhX0fduyOwWDQxtc1KBRnPvekY8dv0sdDwpP2jyICxvQ
 P+buQ7ge6rJgfi7Xhy7PyTSSdk/MH4gePSMGvLtZme+ye+Hg7M1byTz4OXdVONUs/vxZ
 mqlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCIXAGO6mi/WqdOhdRNAB7yqADtfPo7MzoYFEqbmGFtQ4sebbQv2qIxWNeLVFMHBnYXisGOQ1VjZr7xAYm62F8JvMNfQ==
X-Gm-Message-State: AOJu0YwM9NrFPPEYJFvr1AHMEbPTUCwOmPYAhWjdbDxUSDBfvHWBijiK
 6Q2Oc2icQDbEMPEoDsFu8P+IP8lvk+2i9YRVycxm2SSoj87UXJjfh2MG9R7xKnNW8pD+4qMBvVr
 p
X-Google-Smtp-Source: AGHT+IHc4gdgO0CN14RnzgrneVIWSOgFiPvmkIYZj8/CDBQ8bHkzbdAyNvoyG93idkHF0TMsm9QFOA==
X-Received: by 2002:a05:6820:1ca7:b0:5b2:3782:7848 with SMTP id
 006d021491bc7-5ba05dde222mr10810402eaf.6.1717437372842; 
 Mon, 03 Jun 2024 10:56:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ba003fdf6bsm1487194eaf.25.2024.06.03.10.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:56:12 -0700 (PDT)
Date: Mon, 3 Jun 2024 11:56:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: Re: [PATCH 2/2] net: phy: Replace PHY_ANEG_TIMEOUT with Kconfig symbol
Message-ID: <20240603174419.GE68077@bill-the-cat>
References: <20240531164733.192105-1-marek.vasut+renesas@mailbox.org>
 <20240531164733.192105-2-marek.vasut+renesas@mailbox.org>
 <20240601092154.GA4383@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bL9jrZ0r//z2TRux"
Content-Disposition: inline
In-Reply-To: <20240601092154.GA4383@francesco-nb>
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


--bL9jrZ0r//z2TRux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 01, 2024 at 11:21:54AM +0200, Francesco Dolcini wrote:
> Hello Marek,
>=20
> On Fri, May 31, 2024 at 06:47:17PM +0200, Marek Vasut wrote:
> > Switch PHY_ANEG_TIMEOUT to CONFIG_PHY_ANEG_TIMEOUT Kconfig symbol.
> > This removes one more configuration headers option finalizes its
> > Kconfig symbol conversion. No functional change expected.
> >=20
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> ...
>=20
> > diff --git a/include/configs/apalis_imx6.h b/include/configs/apalis_imx=
6.h
> > index 0df3917e200..6fd43511ee4 100644
> > --- a/include/configs/apalis_imx6.h
> > +++ b/include/configs/apalis_imx6.h
> > @@ -22,7 +22,6 @@
> >  #define CFG_SYS_FSL_USDHC_NUM	3
> > =20
> >  /* Network */
> > -#define PHY_ANEG_TIMEOUT		15000 /* PHY needs longer aneg time */
>=20
> You should remove also the line before, after removing the define it's
> just a stale comment.

It would be nice, but there's lots of similar garbage remaining from
other transitions, so to me it's not a deal-breaker here.

--=20
Tom

--bL9jrZ0r//z2TRux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZeA7AACgkQFHw5/5Y0
tyzOwAv8DVswTiu5IixSAOtXNSH2PEMv5yTYkSGFkV442HIYN9B2oZ6kePS9RClS
7mI/tFurVydSnvNu968+W7zMI7x9+tZUSiPSmDP0Iggo1RScbG0glA58L6YvKok9
VTiy6/KYFvxh2oY5qiPSgKSm1XO4DCenx2yTT2GJka9mxFSMJN7xIJRxTL2Im+qU
iHSB4XnqSwgoMeC9w3DOOYi80gjxutUST6x0h8afwHF3R2OdObRdu9Le3B55EWRj
/qxFb+2G+r3tq2ru7v91utbo60Z7d2aiCsTxpnSDQ1sLdurB9ho125I3FI3zVVWk
Ly/gt5l0tOzc5iockXQreOJB4e4WSWQPH3HfQ/vWn3iMaJASMgf9pGeWE0uJ02do
3swdMZWJclMe7wmIP7HzPTTC1xqWJVO3895FgJ0m6U9yKb95sq8u3cftaezqufzQ
PYHP5jAMr5oWt4Kyg8O2We3jvGcug1Fx0bsEvMZ+6F1jBhIEp7e6eyPIVVeAhSv+
5+aZ6syc
=8QQB
-----END PGP SIGNATURE-----

--bL9jrZ0r//z2TRux--
