Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D6DD21683
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 14:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C32684082;
	Thu,  4 Dec 2025 15:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j7q6Sti9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 936C884083; Thu,  4 Dec 2025 15:48:47 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 735F783A57
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 15:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-65979e14157so280738eaf.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 06:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764859724; x=1765464524; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ygTpmRhEAek+XHG/I7NyP+1F5g9Cu7c7lSEalkb4c2k=;
 b=j7q6Sti9f0BpVj/XI0ayhPFPHznV4c27JXIV1JgFUwuJDC0DCMJTH9m9pDP5NS0hrH
 uqCeyMFX6iJNnybk2uaQp3zRjyVOpYKFHkLGIWiiIezYO+ugb9O/Z/YzvfB596jQAPXF
 TscqtUhZ0w813BRle5tcLI7oyNZnu7Oy7cjwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764859724; x=1765464524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ygTpmRhEAek+XHG/I7NyP+1F5g9Cu7c7lSEalkb4c2k=;
 b=QkUmfJfmCYP8ymBGE4pYq8uM0bIupJwGFJPnsSb9pPElIb9ThSZZAHLqEJuBlV0yqZ
 hP9R+RBECr3On4NtKf4aBaHWuXwa4ST5QV3ekhDDZRjDjzCXZtKaEwpEd+uZSJTp/bZO
 4egE/VmW5iQEMKi+dTlOulJDrfFOaiZd0JXtseXY9akffeU8J9O4EWR3CIgDZziCXhtK
 OH8jZIXebzkR1czFiTRKCLYNwYdC/7uH1jyGicGYR+ByOlUeU1XE0NVBtgvwM3M65hUq
 feNJPn4nk+DBg3oporALx0uKEScGNb15LHSvA3R158tzOnc2+1AkqvjSjPcxnhqnu5mD
 fD7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyQ0TRkbDblSyL4p8lGox9NLmfYhwbGu6qZfzxXaHU66v1SYXBwG2PO+AP7mwV9XNoELqzfm4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8eQ2jEDgNgY40ZdME66/EKYh9HCzrncedbythZVfXA03UnGZX
 mOwHVi4lbFz6YnIvOU/EBsPBo9ikc3eZ58gfS1gjhqbic3+6lBlXI1YSof2lK6O51WA=
X-Gm-Gg: ASbGncsbMAOuk2J+P4JZZ6Xs1h5wtf41i3+IFZXtB0UGVkxKpw9GpOX/CdEme88plYC
 GUjZn2NXK+T8OyAPI/ZNcCmNZPS1zBoDQ0Z3xTVOcjO00R04Ith+jmr0fzrc1OMDQVVSKPFje43
 JmIsBHqxOiGsAI81mEklWTsXyNdDoCeVrEto6ZT1+lnY58tKZEw7FpveL+FkvNo2cUaf3JtLNBA
 ERgshMrhK/2bHfEKSMmp6J/vWGPDppMz06x0mQx0SaUluOLa4onLAP16b04je5KFlOcu4pC5HUd
 puyYzfGeCD8qskD0WFcvlljB6W1hv4b3a/MHuhcfrrKQ+Y/FSP5i18IS6bUL1X4Cd2l8wAW4uPl
 XRS0I8xUOd80LGOU3DevhFWLsVUBwx5QPs6BKOO0hwU+HMAWRL+PMKpZxjwBG0j5JVlzDXD8Cjx
 3+kCavHKy1ZNZ2NM+9Lb1c08ve6DlcfwtehHtuaBbiIR07BevYPA==
X-Google-Smtp-Source: AGHT+IF2hmlPK34gijsEHPer6nzxssUB9+x6ZW6QYzT6cYo5mp0T+FE2JEMg0ohuoao2aPjeUvQxQg==
X-Received: by 2002:a05:6808:1b0f:b0:450:839a:557 with SMTP id
 5614622812f47-4536e3a40fdmr3206704b6e.9.1764859724174; 
 Thu, 04 Dec 2025 06:48:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45380161d4dsm686092b6e.21.2025.12.04.06.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 06:48:43 -0800 (PST)
Date: Thu, 4 Dec 2025 08:48:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, mkorpershoek@kernel.org,
 n-francis@ti.com, anshuld@ti.com
Subject: Re: [PATCH] doc: board: ti: Add J742S2 support
Message-ID: <20251204144840.GX303283@bill-the-cat>
References: <20251204142451.834404-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qThlHo+w8JFm2gby"
Content-Disposition: inline
In-Reply-To: <20251204142451.834404-1-u-kumar1@ti.com>
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


--qThlHo+w8JFm2gby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 07:54:51PM +0530, Udit Kumar wrote:
> J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is used
> to build u-boot for J742S2 EVM board.
>=20
> Add guide users on how to build for that board.
>=20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index 22442874110..4162a42c075 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -1,8 +1,8 @@
>  .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>  .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
> =20
> -J784S4 and AM69 Platforms
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +J742S2, J784S4 and AM69 Platforms
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is too many '=3D' and now CI doc building will fail with a warning.
Please build doc changes with:
          make htmldocs KDOC_WERROR=3D1

To ensure CI passes. Everything else looks fine, thanks.

--=20
Tom

--qThlHo+w8JFm2gby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTGfSAAKCRAr4qD1Cr/k
CnZyAP980F1zR+hxj/KsY4nK6vJrL9D8ZciLWyrTcTCbKlQKWwEA/tdiywmgn26M
KEO/5+vZfR2/ZwyCr9wtKjhnP3sJ6gE=
=zQS/
-----END PGP SIGNATURE-----

--qThlHo+w8JFm2gby--
