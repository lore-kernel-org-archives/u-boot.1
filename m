Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EA2C27C52
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 23:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F04E88009;
	Fri,  7 Jun 2024 01:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XvGnnbZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71B9C88009; Fri,  7 Jun 2024 01:55:08 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF58D8842C
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 01:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-24c9f628e71so759074fac.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717718103; x=1718322903; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4vFYaEe2rqUoERYkG6XJL3Pfe6BkszOfGlBs/m7cBkU=;
 b=XvGnnbZVGe8g7iKtKJoUsz2I1tRWvmhZUiLFJ/HDLXgY5Z8PMrx3jE2TIZXTYZW8Sz
 KGPnEUDXvO5I6hdgevzCWhDbf4ATVWtEDWFD4FQnLolPAZ2TE3nebP3x5QFx54ldIK5w
 nw/nc4+1lC3jb1eevacJ7VXyiio4mu4fWauh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717718103; x=1718322903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vFYaEe2rqUoERYkG6XJL3Pfe6BkszOfGlBs/m7cBkU=;
 b=VR2PiiO54v7Iwnz1AIAjKDX0fXms+DIo0ejF0ZmycOCUttmsGIKRSGcv08IuCmNQ8b
 6KZn/qLF+N9U/DsXxnrbwqXAB2ycuo0yrZo3f7mj1RzCOGGu+t9zMml6zICPruaNDjOK
 ZizKl93LGYw0uV61HfwbmOoNmsRkCWiz+kcm904rGrvKP9TW7CHEv6xH2ONtPtRGrK1m
 Hf0ApzvWTYr6m+mDzt6lB+eY/FpLVpaNmZk1Q44Xpil9SkjeP9uHuyfPsikfMwrvSnXY
 iTakghEp+F7P2eSG1xR9RY7N8Tx5b+Cfip4Hl8gwdnpOH9MBBsfAhPG02xAU4SsNg5Fo
 M6Kw==
X-Gm-Message-State: AOJu0YxVq082PTysW8RnIQlUbh+p6q7FU84byaMSv6r8sMVu18Of3Yr2
 cUj1Q36TuLmkL863dSNyV5pcvdY+feZ2sR2RD2FZD+Jn+PzmY/POz1ZjF3epsV8=
X-Google-Smtp-Source: AGHT+IHHxF6xQbUkDujkZW5gEtvwE04y76Xam6cfD5V/boq4iYq3Ap6nX3qnpSZmRidjz9kDEEx1Hw==
X-Received: by 2002:a05:6870:d113:b0:240:eab9:1635 with SMTP id
 586e51a60fabf-254644debcfmr1032011fac.21.1717718103397; 
 Thu, 06 Jun 2024 16:55:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25447d71e28sm623599fac.10.2024.06.06.16.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 16:55:02 -0700 (PDT)
Date: Thu, 6 Jun 2024 17:55:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fiona Klute <fiona.klute@gmx.de>, Sam Povilus <sam.povilus@amd.com>
Subject: Re: Pull request doc-2024-07-rc5
Message-ID: <20240606235500.GF68077@bill-the-cat>
References: <8ec6229a-0f90-43fc-9c78-dea655ef5ccb@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n/3UixDYZTonhxe5"
Content-Disposition: inline
In-Reply-To: <8ec6229a-0f90-43fc-9c78-dea655ef5ccb@gmx.de>
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


--n/3UixDYZTonhxe5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 09:42:07AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 4b992573b34b1586e323e27b177680a6efec1c=
76:
>=20
>   Merge https://gitlab.denx.de/u-boot/custodians/u-boot-usb (2024-06-05
> 10:59:10 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/doc-2024-07-rc5
>=20
> for you to fetch changes up to 0efc5a9f670144cad7f287711f25c69cba0fde39:
>=20
>   doc: process.rst: Document device tree resync rules (2024-06-06
> 09:28:20 +0200)
>=20
> Gitlab CI showed no issues building the documentation:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20988
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--n/3UixDYZTonhxe5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZiTFQACgkQFHw5/5Y0
tyzp3Av/aYtrYlMMoAcBh+2SEqi+BcmmRbqNOiYwInztz8ba55wTD4o8yK2NHNp/
1NCLr2PdMBmLanT87Vyb3rxPsV6cARHohfq0IHsBZiOYSeS04acMGYtLTtnMxSjB
QRDMCqABFHnk8piBGiJ2yTW4uMn35ep2cEJn6Y2pWCnCC+HFI5mOGMwrI9PoeCCI
QPE0KD14VksUzwdjuNPRw6aEh+nU/WowQql94/aMtkoBkqNOvBhG7LmE6akPUAi2
yG4UxskaNlMgMpKPbkOOhRIo9FFCk7ld8Hyqr7iOdZN4XHrffxmWHLDAbJRGvcyE
Uv+xA4tJPyqFxas8xylM03bVusu7jb1tLqhOG7rPfKDcWT5GSqxQesh1PB8/XSeh
ZQJKlHITJj8sn5KATipXXb5si7F+x2DHiYq/hD06IBYN8yV+CI8cfmlb2kaWJX5Y
QtYHaDUUhFxu9l6hrdxCPsiyg8Drfq9MUBL6hZSxppxTmQ9A1iy0Q/o+Fv/ZNZqf
3NA9Te/X
=9Vsm
-----END PGP SIGNATURE-----

--n/3UixDYZTonhxe5--
