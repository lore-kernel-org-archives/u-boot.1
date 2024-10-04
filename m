Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41005CF8861
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 22:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB3F888D36;
	Sat,  5 Oct 2024 00:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZVd/HiOn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 071AE88D06; Sat,  5 Oct 2024 00:14:29 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC1588B0A
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 00:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7acb0499ffeso221633085a.1
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 15:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728080066; x=1728684866; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pk01qqzpHdrrlSumtPbYoIT4xVWWg2XQOa+nCXsGR2U=;
 b=ZVd/HiOn96ApBvNF8j8ItnVay0kwsmU9wLz2G68IN60wYSxBHiH/AQNgiSROjgSuR0
 afjA6I0ajZkAxMiLHiFA7EpNUIOjeTByVpv9/Oq3bG+oI1htgF4bv6joEbD9COFbgxfv
 vXRdIdOxrk4WbBxcUbAwmNmL51PwQGEPFi+QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728080066; x=1728684866;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pk01qqzpHdrrlSumtPbYoIT4xVWWg2XQOa+nCXsGR2U=;
 b=gvsncxOz6uDhOwXulm1pyNFl9vMTVX1iVQrNf0lzcbjyAYwpYwldBYVp+aXavkygs5
 IJiMo+TBdXZS6rmbZfoa3GYotvnwWIHegUMQMyxTLURD+Nka17+7MuDW+LZ674VV6oYX
 AcFXSCzbdi+5BO90ek1exdw6XfEhMOm0sXZVgBvMsbZcsv1NTct45kboBF92oWXzpGdM
 /eQJwbaoiCJu4jzviSVq+FG3RjOSWi2TbBycc9FzPse6iq0y94Q21i3cp2GFD13Maj68
 amZTnSMzLZGPJ7IkE/lXQa1jNVK3uW7q47LA/sSpmtN9k350ka82wWN6yJAJQR0EFJM+
 uVIg==
X-Gm-Message-State: AOJu0Yw25spFw+5mI0LXrQPMPwODhoFa4GH6A25v42o1RtIzTtJCeoM8
 B+AGTZ/hEBpOHDWARNC6+BRtJmXS7HqcWvOsOAHgTU9laXvsnD44NImCRiOkuSg7FhgWLfd7wrD
 aiNA=
X-Google-Smtp-Source: AGHT+IEKdfkr/N+Nz5WHDnA9a6D4HEMvYsHqi60vj7qC9uThHd8Vi4Vz5gvIiuxB/BV3uGYVQ3FBaw==
X-Received: by 2002:a05:620a:1a9f:b0:7ac:e879:1a20 with SMTP id
 af79cd13be357-7ae6f432d43mr762602985a.1.1728080065740; 
 Fri, 04 Oct 2024 15:14:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae75762d9csm23443885a.113.2024.10.04.15.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 15:14:24 -0700 (PDT)
Date: Fri, 4 Oct 2024 16:14:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] ARM: stm32: Update MAINTAINERS file globs for STM32MP
 DHSOM
Message-ID: <20241004221421.GK4737@bill-the-cat>
References: <20241004215213.252840-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2PQXcoz4ys/RusKz"
Content-Disposition: inline
In-Reply-To: <20241004215213.252840-1-marex@denx.de>
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


--2PQXcoz4ys/RusKz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 04, 2024 at 11:51:46PM +0200, Marek Vasut wrote:
> Update the MAINTAINERS file glob to cover all of STM32MP DHSOM related fi=
les.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  board/dhelectronics/dh_stm32mp1/MAINTAINERS | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/board/dhelectronics/dh_stm32mp1/MAINTAINERS b/board/dhelectr=
onics/dh_stm32mp1/MAINTAINERS
> index 865588f5b8b..d6c33c15aac 100644
> --- a/board/dhelectronics/dh_stm32mp1/MAINTAINERS
> +++ b/board/dhelectronics/dh_stm32mp1/MAINTAINERS
> @@ -2,8 +2,7 @@ DH_STM32MP1_PDK2 BOARD
>  M:	Marek Vasut <marex@denx.de>
>  L:	u-boot@dh-electronics.com
>  S:	Maintained
> -F:	arch/arm/dts/stm32mp15xx-dhcom*
> +F:	arch/arm/dts/stm32mp*dhco*
>  F:	board/dhelectronics/dh_stm32mp1/
> -F:	configs/stm32mp15_dhcom_basic_defconfig
> -F:	configs/stm32mp15_dhcor_basic_defconfig
> +F:	configs/stm32*_dhco*defconfig
>  F:	include/configs/stm32mp15_dh_dhsom.h

Do you want to try the "N:	some-regex" syntax to see if that makes
it less likely to regress in the future? If not, this is fine.

--=20
Tom

--2PQXcoz4ys/RusKz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcAaLoACgkQFHw5/5Y0
tyzynwv/YVeQb/tjpjqF2SDo0L8s89DDTggdGL2FbSNhpDU1tn/ox3d43MJkv/iG
4EUf74bMZuvzkdRJtoxFK/e6l2yEz4jIavrlnvm3WBZU0KpKmYbZrERr68HPhkvq
IN/EQKrvZPP4jsYBiR2fpe9GesmUtoPX3/Cswx6gPOUj/4a75oNE3MgfD5+vQSh7
KUFxe2wCmCHMNQdrO7cVdJloo4pvVVwcyBbvP+YB0R5wA+0vK+cFd8uv7gp8cct1
lHMEVqaLcwdqt4Sx+Smkytsx3N4JSoiYZ1OLuph6xu9fIuIWRM+5PEdqCy8tMk4U
SKQSpkmqvDc39Y1S897lA/4+XLFhGzl/U9nPMlnBQF/MRW90WLqFn38Y4Xisl2h7
RbdUmJKYEQWCjR3SiwPgMUAMGOuOFEd6Jxs8ty18JL10IyuR4h1zmSnK+79YL/wC
v0Vt5kiQEKtoQJxq6RN6OHdt9vVI8GdtEKw4zGRui8xvO8TkR+iJnIx+2UBNEbo/
j0xXPUex
=PaBZ
-----END PGP SIGNATURE-----

--2PQXcoz4ys/RusKz--
