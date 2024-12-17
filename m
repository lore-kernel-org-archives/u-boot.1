Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D447E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 14:25:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BD0801FB;
	Tue, 17 Dec 2024 15:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jqU60VlT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AE0580214; Tue, 17 Dec 2024 15:25:36 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B0D801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:25:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d884e8341bso40882746d6.0
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 06:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734445533; x=1735050333; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHguCjUR3MzBMrD8L6SpfUGA65CozzSMll3rg32ABjs=;
 b=jqU60VlTRR/Y9pYEbFkd6gtrFOgaOiWJ6Y5rm1iq2hbiFuZOTuQAo3PSn/fEe9AHWQ
 V2SN4h+bFTYZaJNLKDw2pCanG3/k6OBHwBLgEjc4rypLiIECnTY8WcZCsWM7Kol85g9q
 3oalN5imc9tbzLUzh7rwDHA0Uh8tE7hNLAV78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734445533; x=1735050333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHguCjUR3MzBMrD8L6SpfUGA65CozzSMll3rg32ABjs=;
 b=sW8bQOj7YnmneiiZNZS62ro1Ui+QaFOgDwVFxQIgPUeHClmLfM09Rggtm26oyMm6vq
 xgFqmrtmZ9/j6SLgfCejvDKb/ShGs/XspCfr/eXGjB1pN9OpiEm9PKVSSZuLBPCatVRE
 jMaYBMwXJRTDol1Ilph/XeaTcWq7XCPIHFCjwj0SQToNpgqFk5Ee7yvfiMTiJTTP/NFR
 SVsG78xrbn0Z9EQ0H7f3zOilKJAJx9LyOWJgYQ+6hSSo0biDZN/xFjfbGoLWptWD225p
 CW2O8BeB258MQCNZhx8sX6HEtLvP3SoFMEM6AVifN7tiXtB8cjx6vUNuU1MdwuR81o5+
 GhyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCdH4XD2q4yTlzTg7nsaLmTES6F8jkxbtf67iXqRMSau367WTnCFwk15upq1IjbArtOlQg6II=@lists.denx.de
X-Gm-Message-State: AOJu0YwdFJYk+V1pTO733SXOFTv8R/ABNWvZE5vwssv3wfLrfS88cgLK
 NEbnK4aKuzsmSbVXh7ORuud94JXzGZ9a66cnBZZVj7gl48jBgRug785jGb1e7Ic=
X-Gm-Gg: ASbGncv2jURoEGg1E3anhKTYgMEzw9IkDpTV9Uu7vaX63EJaLdSJpebSZCVSUUx6BVa
 pv9zE1d1aSpao8AIH/za75TD3PMAmSG1bqYQ2YzcNB/TULjQvhp/J+1oaAK/Xj5douLneeqO0CF
 DDIXYmPiIJoZNh20uZmBoRSZY7ww4tLtLf4PBhWHs3GarSbpjv0PCG+Z0XxEogZ4KUBQuTc7kHL
 oi6nvtZ6kHp+KzDxm0OuPo47LdGsKOlEiHro5UzM0xGxQk7EkyMylCY
X-Google-Smtp-Source: AGHT+IH3C2S2zLdbw4rDYJ2q4gvkj0JF4LG0DgC+MxpvEuAWJQ+vMrZhK+L9w2EpVYiO3zpJ7CgtGg==
X-Received: by 2002:a0c:fd44:0:b0:6dc:d101:2baf with SMTP id
 6a1803df08f44-6dcd1012c8cmr170145636d6.17.1734445532846; 
 Tue, 17 Dec 2024 06:25:32 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd363137sm38937806d6.75.2024.12.17.06.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 06:25:31 -0800 (PST)
Date: Tue, 17 Dec 2024 08:25:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
Message-ID: <20241217142527.GL1505244@bill-the-cat>
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5chiKt5xD+0y40WG"
Content-Disposition: inline
In-Reply-To: <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
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


--5chiKt5xD+0y40WG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 08:00:56AM -0600, Simon Glass wrote:

> While we do plan to switch to OF_SEPARATE now it is supported, it seems
> worth at least showing how OF_EMBED could be used instead, just for the
> record.
>=20
> So make the Makefile rule conditional on OF_SEPARATE and adjust fdtdec
> to avoid a build error when OF_EMBED is used.
>=20
> Finally. the dtb symbol has a double underscore, so update it to avoid a
> build warning.
>=20
> With future patches, OF_EMBED will no-longer be used with the EFI app,
> so it is expected that it will eventually stop working.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: 2e7bf25f6bf ("Support separate DTB files with the UEFI app")
> ---
>=20
>  Makefile                       | 2 +-
>  include/asm-generic/sections.h | 2 +-
>  lib/fdtdec.c                   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> Applied to sjg/master, thanks!

Since you've picked up several series that no one was objecting to and
providing reasonable feedback on and applied them to your own tree, do
you plan to squash/rebase them and repost so they can be applied to
master / next at some point?

--=20
Tom

--5chiKt5xD+0y40WG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdhidcACgkQFHw5/5Y0
tyygUAwAuN2ozyGE2KXcod+D0sT6L8IsDF7K1pdM7Cx8Ah5N4iyQlJmNa0Y1IywC
A7LO7Jx2XZtaq/whoRcmrhrRrq593HJgRzTV3OON8pYzcUd0QHsUyjc4mYHh9709
Keq4uFWwg3+GAle3fCuT04l69jDZHWlVZsrF5nxYgfS1iepo3oDn/vjskgklF78O
zdoHfhZ5cbEia6CsUi2bWmzsTZsmRxhgM712WwR3HzfZaMIjHq8SiEaOMwRcuFMv
kuZ2UJq5UXc50cnooodXUkeJoTFioWHOvUNuUXn7Aq7FDHHerEvD711uElvtLY0g
f5CUEQErULBaRmABC3ZveKGL+f/+QYXtIhbqPiEOfAC+wzvxP8Ze+gDUmVFcbbdx
9zgfo/0AI2vNtPSQeGYGRg6+mJxELbjrTRBkqrVwAXaESPETYwylF78ebkt+tuvb
BERVO6MkTOduS1dl+2v9V8bWWS6rAVREogYke4o4QkSQy5ljhlamQ+JwgyyGNIiN
8ixL9Z0u
=z/D2
-----END PGP SIGNATURE-----

--5chiKt5xD+0y40WG--
