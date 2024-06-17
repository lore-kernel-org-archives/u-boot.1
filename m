Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32023C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 14:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CCE88283;
	Mon, 17 Jun 2024 16:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fhAUwCfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3974882B8; Mon, 17 Jun 2024 16:39:56 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A94E88208
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 16:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5b9706c84e5so2517977eaf.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718635193; x=1719239993; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CmG+E8z8F3soQbZmUXi6g1zInFC2P94mIHMqffyaA2Q=;
 b=fhAUwCfuqXOF3/U+IkkQ68EwQ548UW9oFpQfiDJXDTrkIQV8azAi8szJiJp6puYC8o
 hPgJVrBTJvzweYgrOb+Z2jNjoZ0IWNudK3sSk+aJxOydpUjTQcNyFqGcoF4vnsjCkXrh
 /Skl1BJ80pY1VJTBcnUHTM8tIYUAjflF+DmYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718635193; x=1719239993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmG+E8z8F3soQbZmUXi6g1zInFC2P94mIHMqffyaA2Q=;
 b=ke3iwyDPUPHjUJmamfSKNJHqVXsYyOv1NRtEv0+bCr9R1v1fuFQPYr6RxFFF4vfJjU
 lHb0MyySNHR7jCVzN/A94dG4xD6V7M8DLx5VmKcvPxX/jMIarjogEk6XRR4kf5drH6ZX
 u2JcZmG52U3slsy5X52juCUOMEGIcp+JlFDDHZmtrseyS4rO8PIAt5X5oQEAQgdSIIaE
 79HYNUiRyU5B+aECVRa01uWlFOf7NdAshfKXOILTARi1bQBBvh9VykBYCvMGe89lmu3/
 3qvTIek6olro6zCMV2T6STehEBICCBBzkyCJwSTiskxU2EViaJA/dNyaWf1+26bz43oK
 +R0Q==
X-Gm-Message-State: AOJu0Yxn9V4wISa/d4+HWrlhWtHvO0I8axxQ5l38sLOLR91/lYoFnWYG
 NewRgZHrCC1WXYoBtIV7yO55Ag7GLEvPvLGO8pWZ49iLu+sQiadSnaNfo2sdpb7cNCjroKxt5VA
 zIcg=
X-Google-Smtp-Source: AGHT+IFwldvENO1A9OxKqs4KT291gjM95FNfW31TpRYws7vlSHSf+df8GWB46hag1ITnovzfT6uvxg==
X-Received: by 2002:a05:6820:1ad4:b0:5ba:fcd2:acf0 with SMTP id
 006d021491bc7-5bdadb9e67bmr9990999eaf.3.1718635193061; 
 Mon, 17 Jun 2024 07:39:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5bd5e19f210sm1183629eaf.27.2024.06.17.07.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:39:52 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:39:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240614
Message-ID: <20240617143950.GT68077@bill-the-cat>
References: <20240614160447.2087616-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2qDVVeZ2ILkZqzKT"
Content-Disposition: inline
In-Reply-To: <20240614160447.2087616-1-festevam@gmail.com>
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


--2qDVVeZ2ILkZqzKT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 01:04:47PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this single fix from u-boot-imx/master, thanks.
>=20
> The following changes since commit ca6a992e09441d6cca73439c63c3735f86b36e=
a4:
>=20
>   cmd: sound: fix help text (2024-06-13 09:31:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240614
>=20
> for you to fetch changes up to 09d63e647a0eee024b493ad1d0e0d4a7a65ae500:
>=20
>   board: imx8mn_s2: Update timing with production one (2024-06-14 11:42:1=
9 -0300)
>=20
> u-boot-imx-master-20240614

Applied to u-boot/master, thanks!

--=20
Tom

--2qDVVeZ2ILkZqzKT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwSrMACgkQFHw5/5Y0
tyy/oQwAsXiAzZs589OWG6PxJyD2+WyS627je731WNj3R/CWiLShvvpABEhhh3wb
e3pTFFO31Gu3ZqrLLT61mk4YG3ReLBnWZipd6RQ6lNABI9SKpI6ViPYb7/aMnMEz
Lq+YNnpNq/yt6q2i1YtvM9Q+ADPrpnw6AORQ5RbW3NaE6ZzObQkeNh8/y5TDNtte
rSeXSmcxfiRYrYMYiCRQ/C1hXSvcmjMJWObrGB8tWtHzT/UoRcKCzS3teI5o+0kH
USffzJFVC26EBJ/PfuE4CZbb6jZyQlJYPkEuOEvi8eukQYlRILfStP21XDL0dPjd
Trmz6B9J3akKYDJE05D9PEdy2Z8l/a9SlJD8+Cle6OLroa327DAejRrR1a3DBIgG
/6j+0uicARnKk375+ljnoJbKULdpefIbLvWNxrW6vAZPcN8Q7qG78oQeuouPUHbd
ujnAoiEGsHv3EWF76cyGTlhK8JIPXzyi4s+UQsI+GI/t44kMjM32fnp1ggM6j+fX
1T+nRiZ0
=Wxla
-----END PGP SIGNATURE-----

--2qDVVeZ2ILkZqzKT--
