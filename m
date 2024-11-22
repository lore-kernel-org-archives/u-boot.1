Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2761E69191
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 20:50:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A346897E9;
	Fri, 22 Nov 2024 21:50:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ic+F57Ue";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5C8893A0; Fri, 22 Nov 2024 21:50:29 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14BB189366
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 21:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-718066adb47so1455275a34.0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 12:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732308626; x=1732913426; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NmrDiKrdTyRtoUVLx/KS4Ga9Uk2ZOQa9lDmcEon8txA=;
 b=ic+F57UeVT4K8mS8poT0uqxUXP6jbHrXBaga31HWDXduqm8B8eBWcJ8vladb3/X58X
 B1jbNTkoNbBXWHd/15cE3I30RXEtJizVNXUuh/gFyhEyyt/2zonZYseYBqhNnEFINsLl
 J2BOtyUQeKrbY4BImh1cCBlOu9NFqoUtT7tDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732308626; x=1732913426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmrDiKrdTyRtoUVLx/KS4Ga9Uk2ZOQa9lDmcEon8txA=;
 b=aJ3tbiLhjDhGCFJVMG0iZGOzADY32X0M0Y8jgN60fko3rt9yL6O75cH4E0cDumMXcG
 YG5CGC5R35fUTN8+1O57VVKCyoir0JnKHKAQx3QBjFaWiYmERZ9onIYcA9TSGQboS00X
 191qp/0bLto9uvZFSjbTM5NoO4iRV+WInbARFhbzpCjJYIsxtKFum/NKjwnKvUx/8uNo
 vX7FadauHz8XbxfVfsa7kVSw3xTGabHnLN4uRDsWpM/279Zo3IHjIobWtiUTTLNgUgGI
 I5JDUzjHKAnJYf4sqhp8vXRjbHdgfc8Wm2vnr1eEFAG9jNufuDTQyP3MyHe8ldNiY2nc
 pupQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+KRD5AIDqnk8PELEV0WUGRfFqmGSsMbJ1RAFi4bI2JwZBo4zFYfCqCVel89GDPW0tQWNy9yc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5pq3+r2RVrXgIKO7BPcmEn0p6rxbLWtyvPyvXsnyE3iJyw6PJ
 MHwYt0dMUfNPjQV8+KZZzxxdEZF8OFyQRu36RKIEfkhRUJxaWSYkVbrQmhVGuYA=
X-Gm-Gg: ASbGncszb8fm45D7g8FEeU5f8DB/ceMsoNEO3l2b2NGNUgeDIAH1EwIWWfgkG7cB6S/
 NtPeq3sKI55XP3b9b3eJP0X0lQarFN6QjZ4pWe7Ufhw5Z04jgDzhw9kEsUOeC3UalVe2YRrdGWz
 sisGq3HrLK6PsWLQ37Ef69SQj/DEt3YHGLNtaAKYnmLQj3n+hH/v+toQX5WBA8L6jPdM7U2X8oH
 bEArEjrHJhqLMDSdIkkobpsLE4ydfFDCG/dd5tsLaGvoBgt8A==
X-Google-Smtp-Source: AGHT+IE8V7Q1dqZtpiO5+TuRNP74neNZGpmNFpG6qwX+71jzpATmg6rJyjPxK6UsyT5BA7Y8e8oX9g==
X-Received: by 2002:a05:6830:3898:b0:718:14ca:2fdc with SMTP id
 46e09a7af769-71c04cecda1mr4996441a34.22.1732308625807; 
 Fri, 22 Nov 2024 12:50:25 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b49f54sm14130846d6.104.2024.11.22.12.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2024 12:50:24 -0800 (PST)
Date: Fri, 22 Nov 2024 14:50:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] u-boot-elf.lds: mark executable
Message-ID: <20241122205020.GA3180363@bill-the-cat>
References: <20241114170356.3248124-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P444gJoc7+6orCKg"
Content-Disposition: inline
In-Reply-To: <20241114170356.3248124-1-caleb.connolly@linaro.org>
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


--P444gJoc7+6orCKg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 06:03:53PM +0100, Caleb Connolly wrote:

> Some pre-loaders/bootROMs like those on Qualcomm platforms actually
> use the ELF format and respect the headers. Mark U-Boot as executable so
> we can actually run it on these boards.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/u-boot-elf.lds | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/u-boot-elf.lds b/arch/u-boot-elf.lds
> index 1666027e3635..eb84a22dd71b 100644
> --- a/arch/u-boot-elf.lds
> +++ b/arch/u-boot-elf.lds
> @@ -1,5 +1,9 @@
>  ENTRY(CONFIG_PLATFORM_ELFENTRY)
> +PHDRS
> +{
> +	data PT_LOAD FLAGS(7);
> +}
>  SECTIONS
>  {
>  	. =3D CONFIG_PLATFORM_ELFENTRY;
> =20

This leads to thunderx_88xx and many others failing with:
aarch64-linux-ld.bfd: no sections assigned to phdrs

--=20
Tom

--P444gJoc7+6orCKg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdA7oUACgkQFHw5/5Y0
tyyh1wv/TR+h97Y8RbsbuJV1Wz8ZYajn3YL5r2OmPXNV7kOFBFVnl+dthX48g2Zq
uks2uhmbhhQ/PCZ9csBDBa7I7iC2d/IM+Xj8zRv4COTyGYfPukMNsmShskdCnsv5
jbhbXrpw+pMKMkphDMTXgJunkUdMaQ3na5k/IUZH1fPMrE0Pd2zo9jqzfmNrejib
UnfTEJkWGW5rE/SuMP0Lb1ciI+Q61lzQfvy0yzxEbA9CCZ+pFRKPnuf90kLftqi4
TX2etCZNLozxFxcdIJcUhdDJXT4fZIBJaF03O2TlfK2AFv2/4+gXZJlJCJedHPye
F5CfxZrRy8XlmNYfaw4b1pZgyfn14sT5WD7n3px6uN/x28O1zApZBt+AdjCb9jY1
sSO4YShepW0Wd4bqCw6L174MNclOgR847DM4Be3n6QCXoS34BMukoy/2J4Luol3w
PuLwUXzelCDm7FEpfUYPn8yHY1t53vmqWTGIFyE8RKkVPOhq9VW8wGBJsPmWZs7J
CvBRvWOo
=aAqS
-----END PGP SIGNATURE-----

--P444gJoc7+6orCKg--
