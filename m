Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D61C38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F9C889E6;
	Sat,  6 Jul 2024 00:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jo6ot7Fm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54899889DB; Sat,  6 Jul 2024 00:39:43 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34F35889DB
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:39:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5c652d56313so681601eaf.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219180; x=1720823980; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m3Qf2q4lIwOnSOSiXdJEJYTBsQoTubJ1kT7pqUkd76Q=;
 b=Jo6ot7FmkVAi9EzIcRiC6/DKZm6Kg95C+D5Zdms3TiANalVehzQeolH/oUVcHCqtFx
 xCminJBb6x+7o+TsMZGSt9BCNZhPDeFC1lSfH94jmZG+YcFBhqcRM3XweAAlxzqbEjkD
 zVC41lJ8l8Cx1NdcnvQZeePpni0Na0NB6I5Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219180; x=1720823980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3Qf2q4lIwOnSOSiXdJEJYTBsQoTubJ1kT7pqUkd76Q=;
 b=grlX1teyBWZSDzy4NgE0J503SmE0WANdoTiG4o7DlzOsFe2saH30vjU4pWA3Yyvrxy
 yJQvMOtjurDK1/W+OpNZEFn6eDF7+YCgYFk69jduAq4i+eMljDEiaJRvyBY4+QLY6bXJ
 elCTFEw7ItgABDrdYTI5hefqqkA3OXHCphKY1HPcSVsqucmZGunjDroYEp/KXYxhe5uq
 07F/7sH9YguascSd/rxXqIrJaAIx4U0WvqptJ1t6iRVTwkUa9ZzPRkw4Y4cGw36DsF2a
 4dNc3QL/vXgTNs2Y6KmLtRPMtLIXStDy0h02bzHX6wNbynjYBPICsru1fZZoQTm4SWV6
 Tvmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0ChbHaEkhIWByY2P7jNrxxctOPPnUqLsXfIdZn+JoniuiG4bvvMbWqA1o/aAxfDoX7+KLBRAiY1YvKnS1uRQLf+l0RQ==
X-Gm-Message-State: AOJu0YxaihPgZTnfMReKd3Kf3P5zmYt5dvbs8EeJ1W5fUFoxfqwEcl/g
 Io7fbXBFTYrGaTl29hNxYSJXVi3livYXJOv+P0LU2pzTb9oXpd60vmcCVXSeHfA=
X-Google-Smtp-Source: AGHT+IGmtdobx/T+OXhoXyzyD9nJ3zL3fTY1YdriaEzUfGKCLEHhKeDzKL2MbwLM3qFTiJuPTTceiQ==
X-Received: by 2002:a05:6820:1c9c:b0:5c6:53ea:9042 with SMTP id
 006d021491bc7-5c653ea926emr5331205eaf.4.1720219179883; 
 Fri, 05 Jul 2024 15:39:39 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c41480bf8bsm2135379eaf.1.2024.07.05.15.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:39:39 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:39:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: quentin.schulz@theobroma-systems.com, sjg@chromium.org,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
Subject: Re: [PATCH v5] cmd: bootm: add ELF file support
Message-ID: <20240705223937.GT38804@bill-the-cat>
References: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="goqEJN+/GTAsq8U5"
Content-Disposition: inline
In-Reply-To: <20240621114210.51101-1-Maxim.Moskalets@kaspersky.com>
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


--goqEJN+/GTAsq8U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 02:42:10PM +0300, Maxim Moskalets wrote:

> Some operating systems (e.g. seL4) and embedded applications are ELF
> images. It is convenient to use FIT-images to implement trusted boot.
> Added "elf" image type for booting using bootm command.
>=20
> Signed-off-by: Maxim Moskalets <maximmosk4@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--goqEJN+/GTAsq8U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdikACgkQFHw5/5Y0
tyzrFAwAueenCPTe8fogEa6r6VeycRNMd/JQ8FiNcZmZcvMDvZI6sINd8pwGibwe
DEU3mjdGGNq2VLRNXVw123pncV7QQQpuNTZdZt9+z1Zf6VN4I+7TjRk8tFnIllmr
mIGmX4mhtrHd00v9SjesWjWW5c6whMATrM2BtTYg19rje6C5nVRN1NUlPRhdni2+
0ixQLPcVlVw5UghN7QRUcoZ5fmMxYUQ+taUB41bwuU6C58AKWNDxnpdaEH6Ebrya
b9sB8mKnH+tiMBEkevtjumwgCBe+eD0javFZaKszGblIgfLLo83TDrDyqEovT4bR
kHoxC3bPuviYR91NyQ+iAJske3NVCSYB+m1L2JAZzaHcpN/yCRfa/c5Qj2KnaJGp
9UaB5JdLIVAXa//8l0Goetckh2u9EcTRvxkol4vCuKK4h2e1OsRmxFgmdvBWNGov
HvevB6kW+KvGT6EYhVnNDxTH3PkBs2gXRg2WX5TEtc61UYnJvol5m3wS9Kg2T5fQ
k/DTtyfw
=aLYd
-----END PGP SIGNATURE-----

--goqEJN+/GTAsq8U5--
