Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C7CC0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 13:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9652D878DA;
	Sat, 28 Oct 2023 15:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RAK/H2bL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7274A878DE; Sat, 28 Oct 2023 15:26:59 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAFF87790
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 15:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-41cd6e1d4fbso20726151cf.1
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698499616; x=1699104416; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4IBqvg8lsmM9aXIsegk916+t1lWGfsr1jwzv7gg9VrA=;
 b=RAK/H2bLxumYU/GbQuvQWJRq9mEQyF4eafFMj3EU4iG5/COuANzhcL4IridREOf5eZ
 FFovoV/Vf3VS1iyNSwOY5njKnXKK2+Hs/XbjM6aHdOF5TbzYnYmA4VV+FfykBVYnikKn
 YzZjmco0QSGwk60vOgSiUGm3tFtUfHgXjwnLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698499616; x=1699104416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4IBqvg8lsmM9aXIsegk916+t1lWGfsr1jwzv7gg9VrA=;
 b=T6jw5FTLn+T0jMGlemAAjqzXqUgPIljOg+ZzHEhRLCC+nN4ziHxcir0Aq3r9YsJuHK
 mAJEkjVSBh+FpGfHr8UNSL3xwzICFBRueiV8jAQppxamvWLDYcI4Do+w1p3tD16E1ih4
 fO3pdRdDVA2MTbY4+UXAkMR+7J4qfsOa0lnzALlABjCULkJD22a4X0VHM6rTiwttUqII
 zsTkFZzhg2P0ScixDH0duseQf7//6vTkTpF4EZ1EwP+w7vJ0SqfdyL3nj0o5kuDElcfQ
 Ls+MlcBIUs5AT8qGrHs99ZTKOypnMM0n1Xwny/YIgfBe3kaF71Z55rk5ENiiNsBOQhav
 +o9g==
X-Gm-Message-State: AOJu0YwzRbyhDshkMmur1xm3tmwudJagKyqqvQ8GpAu5Z3ODPr48AE/8
 emGLHg4TOeL5ro72ZpYfJJvGcQ==
X-Google-Smtp-Source: AGHT+IEL9/0BlGwdnBFYQPACVj3Cqg3UfXWf+0tdZHBpPvL949ZvwPUVgRAxZcLXDRREFMV+iDZ15g==
X-Received: by 2002:a05:6214:5191:b0:66f:b228:f261 with SMTP id
 kl17-20020a056214519100b0066fb228f261mr5771346qvb.7.1698499616112; 
 Sat, 28 Oct 2023 06:26:56 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a0cebc8000000b00670e7ae4964sm506278qvq.91.2023.10.28.06.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 06:26:55 -0700 (PDT)
Date: Sat, 28 Oct 2023 09:26:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Martin =?iso-8859-1?Q?F=E4cknitz?= <faecknitz@hotsplots.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] mpc85xx: relocate code in non-SPL build
Message-ID: <20231028132653.GH496310@bill-the-cat>
References: <20231019230655.24974-1-faecknitz@hotsplots.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fyDAYSBKHAbAFjqL"
Content-Disposition: inline
In-Reply-To: <20231019230655.24974-1-faecknitz@hotsplots.de>
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


--fyDAYSBKHAbAFjqL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 01:06:55AM +0200, Martin F=E4cknitz wrote:

> When building a non-SPL image, relocation is needed. This patch restores
> the old behaviour before commit b35316fb67: CONFIG_SPL_SKIP_RELOCATE was
> only defined if CONFIG_SPL_BUILD was defined.
>=20
> Fixes: b35316fb67cb ("Convert CONFIG_SPL_INIT_MINIMAL et al to Kconfig")
> Signed-off-by: Martin F=E4cknitz <faecknitz@hotsplots.de>

This is now applied to u-boot/master, thanks!  But also, can you please
confirm that top of tree now works for you, and which defconfig that is?
As part of my testing I check for size changes before/after and this
doesn't change any platform, which would lead to how I had missed the
problem during the conversion.

--=20
Tom

--fyDAYSBKHAbAFjqL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU9DBoACgkQFHw5/5Y0
tyx1TAv/ZENEram1gkF6Pwidadd3P0Ce3TvHZLcPSk+LX1SYiqX1/ZAdmSv+e/ZO
+hBmSVd56T3YmAy2r58khPCkQHiWPNXX95hN1CniNmnJ2Qil3AxJeuXj4RM4neN7
v13Agf4aiH3GqzeP+lgD1gyOerBNIVETVclz3KGL4nRmqV3vo28jCJ2jYXbpiR1C
v9eRDFATHPr53VTSmOMeRUSoXu0JR3kG0Odw6Ip9Cd4tiXuxdS2ddD/0V7ct3827
g//55XSKG8maUo7TZiFvJ9X4CWU91ozwCJvmnqYejUlfx8kbcVhnHCU73cVGk2G2
Lq0d/qj2plsNqenSKLNEDaeOJeiAWOILMsgU3yZDDZKsf0QrUC3Lwm0/RKGQO3N0
f+nr9UVjS10EdQievEZm1ra6a8TZvyxP/kruE57dJlF513DVYOdf5THj6ja87rLc
sNTQm2J2vntWFiX5IhhCpxTqPQaCrZlAwWOZk4wV5IeEDT77IU7HIocOmfkeicCr
5xynHlGX
=GLya
-----END PGP SIGNATURE-----

--fyDAYSBKHAbAFjqL--
