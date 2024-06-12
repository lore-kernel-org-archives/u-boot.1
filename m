Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5976C27C77
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 16:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC1718883E;
	Wed, 12 Jun 2024 18:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KI35vdrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501B68881B; Wed, 12 Jun 2024 18:01:05 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5A1D88856
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 18:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5ba090b0336so20309eaf.1
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718208061; x=1718812861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QLjSmeCxm/ta9cYygfiZSfeOqDTusWo9KzkWUkiww+Q=;
 b=KI35vdrKER1l69pJQPhqGpol7jXUR1xyijyG51sSVVh9RqtYD48ZQvWuX/iyfGRPj9
 yh/01e4Jpm1WI0nP45ntFExuS2egZhoY/+aStNZCdfMCSC+l919fviDRl5gu608F73b0
 W51Do14tpdG05oppr43EAooFEX6o2qZJ2A/Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718208061; x=1718812861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLjSmeCxm/ta9cYygfiZSfeOqDTusWo9KzkWUkiww+Q=;
 b=dn+OKRSofZnSad4WIplRLbbQ6CzwjjQ8OGt+d6ZTg+gLseF4AGbu2sm3uxC+aNAv2d
 5t9TyPHoYgR9QlRc/zKmkeiKvRpWuf0wPGGXk0yhtsBAMkHldxqeeLgikkDtu5MMSHCj
 3nb3tC4PNb+c6pTQfkUYvyWiIY1ymq5w9wOALKPgQHs2N3JgbTu4o+VqiZD6eALFTk1H
 hWnlsZ8Hhqt9uLC0rSEiD+b+kWfyyAauUf422i/+7g5dnpoIdJDQ4ldFI9cP4b7IYVIk
 Y3AVNt/l/V6s+8okp7zIVZEDIr4GchNfomJCvrm21WmLjhRmxI39vlUuUwALENDajZ+9
 pLIA==
X-Gm-Message-State: AOJu0Yweh6a9y0M9JOt6LtPEhWXV8VdWkONmZcyQxTcG4oWkdWbbiI7l
 0nhPS0cAOOFl9e8E6O5M2GOzbUId5bvZI/+D5hnmbgo9ArbRoCpN8IdV463EqA0=
X-Google-Smtp-Source: AGHT+IFkWGPfi9cDB3/OE61EBCOmLfJvJJSYp9Gfzcafq32OdM7rkvKLG6mVAASZuGNLaoaovEWwZQ==
X-Received: by 2002:a05:6820:623:b0:5bb:1ae0:17f0 with SMTP id
 006d021491bc7-5bb3ba4d062mr2704487eaf.6.1718208061157; 
 Wed, 12 Jun 2024 09:01:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bae7b1369csm1329966eaf.2.2024.06.12.09.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 09:01:00 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:00:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aaron Williams <awilliams@marvell.com>
Subject: Re: [PATCH 13/20] CI: Ensure pip install is always performed in venv
Message-ID: <20240612160058.GT68077@bill-the-cat>
References: <20240611-docker-image-v1-0-51472eb70357@flygoat.com>
 <20240611-docker-image-v1-13-51472eb70357@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G+WVc8uzZOOSkRQm"
Content-Disposition: inline
In-Reply-To: <20240611-docker-image-v1-13-51472eb70357@flygoat.com>
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


--G+WVc8uzZOOSkRQm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:04:12PM +0100, Jiaxun Yang wrote:

> Since Ubuntu focal it's nolonger permitted to perform global
> pip install.
>=20
> Ensure that pip install is always performed in venv.
> For buildman alone, all dependencies are already in docker
> so there is no need to perform pip install.
>=20
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--G+WVc8uzZOOSkRQm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZpxjoACgkQFHw5/5Y0
tywweQv9Fr5aEH1zGHUq+0KYkVLPRCLFD3NY/b0FDEC1eafEUnKQ/looJF5dQo8t
OZIHMGxV/jgAjYEk5AMvZ8PxEqOlRB4IIsoT0WBmqB60qhHslodA6TypVa4dAKkU
crE8AwoaQmdRKtdRoscKkXmegXXzUJTMiyKj3zpK75BoWJVlBrbzwJVB1gjxYfAh
ffubIOkaZp135s5Wlmr0UfHMX/qbu36+KMzTm10pHugAWpfomk+AXsBJFOdRd/ul
Ss9jtgqHQSCEGfSg9VOXUiC5EE6ywWdDCuA4h1pShse+MRdNaoEI6HP1SILO4C4r
hA+OIKo3t2I15nhz6KSgBPwdhjurLTxCYfbsjPr2cb3bWoJUibHTpFxRhupuVAWC
Ldm9FLEyogolfsnZR43QwDVW29WZWyi2bZ+rIC+Hj15Grptip/MDqBgJQTarXH7o
k5sw78bptOt9jiFyIm6mKh59lHXn2OWOfnndmJXfvyn1egF7eknCsVXXFN5fiqSB
weeaTzF4
=hOGS
-----END PGP SIGNATURE-----

--G+WVc8uzZOOSkRQm--
