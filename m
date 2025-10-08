Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910D8CCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 19:07:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A996F83914;
	Wed,  8 Oct 2025 21:07:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VgBTLBLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2E983919; Wed,  8 Oct 2025 21:07:19 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65BE883906
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 21:07:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-64c7c78369aso105137eaf.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 12:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759950436; x=1760555236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2OTfqMhvxKHvgJwGPQRVjVkeh7ym3LEuhbH3wApKOCE=;
 b=VgBTLBLdFAri/wrenT4O2yKfanHFkQkOL/ZyTMFmPECNFstx5TC4YnEzXg4JE2zCQz
 oJWKifTkG49R6IzaMizjuA7g60zaTdk410j4g+7+k6zo7IF65swCcizVjfvdg59WMRUl
 68vzf5wZFCyH2aoA2TJeo6kWGqHq0r0BstQ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759950436; x=1760555236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OTfqMhvxKHvgJwGPQRVjVkeh7ym3LEuhbH3wApKOCE=;
 b=Hk7bL/WPirXHBQWqaHHwUQ2zAlmLT1dx5zsKmMpNVYkQw4futsHS3TgMsFJPa5p6P6
 m2LAZjrpY/PPBgtY9BIdEps2GLX478sFXgZ3ZYsExcPswSTkkHo5V+KoqmaAuAGyol0u
 hf7JKAQtrpUjP4PURtmDAnoj0rERRxL1Yt3uY/elCoKKpRY+kwN/UoqHhNj0kNf2NvXP
 mgy1DDfAxIGf/EKp+42P/LROg1WxI67JWzycC+fdZ+RIEQxw1iQjuas7oXYhjbAKA7iE
 csaWbY70Q3ncRpnfmWjRMCB0LnAYvq+pcTELnKujr01GvSOT6PUu/GlAWdqrMhtzSq7H
 NSqA==
X-Gm-Message-State: AOJu0YwKrECDNjTMWt9Dlg3RBBvCiDjMwZLW/pVWYV0dA5iE4N81Anrt
 Eb0Xe4JyWkY/RC8A6TG9lPwG2ckcI4cwX9y5jexxIrcSiv47nR7lDzDxEKiCrIH+45E=
X-Gm-Gg: ASbGncv4LuypDRmPhr5XCdf4/KNJOZV9VCLBQsmsVNubJGKVVTcTFqbLmVUrO6dyThK
 FQ8UWlCi/NwN84HOBZ5QWx0fo0tAeIMfQTQFajj5ucHe1I0cH+d57Nv65sFAzNntvjs3SXUOYC/
 +rYdwAwDfVJnlXd1YWHt9YhEzMWS+Zed0o3JIvd2ZMr4Jx4goYMEV/x+Iofm1yfHZrLr5znZRKm
 PbZKT9Id5ctQUHxNdFxOkugjl9jr3tNh/+qe02kWcchJUAmz+jeEamKO4U56jXpYlZ5xwdEH2qf
 aXG936t+LVh9nnvFDnmaaYbUEtDU/jV1hm/icc5Aeh8C5s/JE7yquJTrtfHH6zwygkgwt6zMRJ5
 SqbYG456kxvQy52uOPuFVdTILHPaMc1x+rhDNg7PGT49MWXeuolFX8l859g4gDVQxr/tcoamZbR
 J1mNd4sPyBUg==
X-Google-Smtp-Source: AGHT+IESgED7ERA7lGYc1QnVhLD3Yze+NokUmCNtS30zuBSxZXapICPwDHGcqv1jjP+VZUcvM/qEMw==
X-Received: by 2002:a05:6820:8389:b0:63d:bc20:a61a with SMTP id
 006d021491bc7-64fffe9a56cmr2083485eaf.7.1759950436098; 
 Wed, 08 Oct 2025 12:07:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64ff6e21e2bsm1416650eaf.7.2025.10.08.12.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 12:07:15 -0700 (PDT)
Date: Wed, 8 Oct 2025 13:07:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Brian Sune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v1] cmd/dma: documentation
Message-ID: <20251008190713.GH298503@bill-the-cat>
References: <20251008174408.381-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nGe5SAgw9YsmKXxR"
Content-Disposition: inline
In-Reply-To: <20251008174408.381-1-briansune@gmail.com>
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


--nGe5SAgw9YsmKXxR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 01:44:08AM +0800, Brian Sune wrote:
> This explains how
> to use the new U-Boot command 'dmareset'.
>=20
> Signed-off-by: Brian Sune <briansune@gmail.com>
> ---
>  doc/usage/cmd/dmareset.rst | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 doc/usage/cmd/dmareset.rst

This needs to be included in doc/usage/index.rst (alphabetically sorted
still) in the shell commands section. Also please do "make htmldocs
KDOC_WERROR=3D1" and make sure there's no complains for v2, I see some
style issues it will trigger. To build the docs a python venv is
suggested and you'll need to pip install -r doc/sphinx/requirements.txt
-r test/py/requirements.txt.  Thanks!

--=20
Tom

--nGe5SAgw9YsmKXxR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOa2XQAKCRAr4qD1Cr/k
ChWWAQCJLME+gDt+xeU0DFYz7pduhwYrmfmRpm2VPpfTJlU93QD9HBQbru3PlsNs
shk8rLz2+lXFt9pLSplFpAjW8QUqRwI=
=e/CD
-----END PGP SIGNATURE-----

--nGe5SAgw9YsmKXxR--
