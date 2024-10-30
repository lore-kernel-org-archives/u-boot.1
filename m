Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E25D7495A
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 03:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3C3891DB;
	Wed, 30 Oct 2024 04:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cedb67r7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E25B891DD; Wed, 30 Oct 2024 04:54:42 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D449F891BB
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 04:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b1b224f6c6so6661085a.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 20:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730260479; x=1730865279; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GaW/OALUCAIPPzbXe3zCBbBs8uA3HhTph7NAozQ5v+w=;
 b=cedb67r7/KS5pti05tvjRwMAiYMlK+/tvte4VEdATAtgVnXHql14GHCp4Id5oEThHs
 kSrH7vli9SNsYMN27y8+GPsSPFOc1NSIomkC7THcCv+C66+UW4nOBAI33ke7PmXgVYqN
 VW8XiH6veQusJFo9Xmt/BVu0lyh5WTEQWDvvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730260479; x=1730865279;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaW/OALUCAIPPzbXe3zCBbBs8uA3HhTph7NAozQ5v+w=;
 b=Oe4vP4fmu5IamiLWOwy0NNKliXkl0pqTMlPs6aSuXMQg6+OgW4rBxgNdGBDXHBeeGM
 dS4c24VvnhDcgHGpj3DzhWZ28dFFejeDEElyVktjEJCnXK00ggwJam++3FrYZ3epU9Vj
 +Q8LBB+9AQcWClfdSFAlj74KqAVkZwlBtBOU9WpscU3FTz7Mv/Cl3d8+kPp0GQ5cDESR
 Ak7NlQ0mqPSFkwdOzwem6wPs0AtBXxK+5RrC5TjuiaLz7Ne/Fx3o/d04vxTe++KKzG4r
 JrybFAe/jx/xwn3DioJQEZnI5VX5sLI1dGSriICMYIMHM+7Mhg7vA/PGdXOasvmsNcCK
 VQkA==
X-Gm-Message-State: AOJu0Yw2OYH8dJuigTstNjozGGeLvFqtyfJkvHU9dKvHVM0ldvx+bo8m
 NniTEkcCqB8m6F8vvAf+JpLOM8QhocAEjWiYnWVGvSpShmGwdcOj41FAwIrl7Pc=
X-Google-Smtp-Source: AGHT+IFNdt+FoiJLkrRZkdYjgrl14OcYrQc2Xvg8wP5pTDJoIAjP8jKE8USGYWI4TYNWiinDj+IPjg==
X-Received: by 2002:a05:620a:430a:b0:7b1:1cb8:1a56 with SMTP id
 af79cd13be357-7b193eebacemr2478488785a.14.1730260478724; 
 Tue, 29 Oct 2024 20:54:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d34555esm480248185a.117.2024.10.29.20.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 20:54:36 -0700 (PDT)
Date: Tue, 29 Oct 2024 21:54:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20241029
Message-ID: <20241030035433.GK2558755@bill-the-cat>
References: <20241030000841.436660-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iirZTItU1GQMMEII"
Content-Disposition: inline
In-Reply-To: <20241030000841.436660-1-festevam@gmail.com>
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


--iirZTItU1GQMMEII
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 09:08:41PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit dfe9e29f8381213c377bfa1de4d1ba7587c3b1=
c3:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-sh (2024-10-29 10=
:05:30 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20241029
>=20
> for you to fetch changes up to d88bcd6d247a2b5d1683e393d8c9dc0259cd29f0:
>=20
>   net: dwc_eth_qos: Remove obsolete imx8 includes (2024-10-29 16:25:53 -0=
300)
>=20
> u-boot-imx-master-20241029

Applied to u-boot/master, thanks!

--=20
Tom

--iirZTItU1GQMMEII
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchrfYACgkQFHw5/5Y0
tyyvpgv+OMRBdBfQaZwVrGDjM9Abuesj+lIzBTzuhi1DT2hgk7SO+NC+A7E4Zwa7
avkiulZml8MTTBNUiT+6LBd5mX+9mEMiIqy+jPY+cDy7ljgw/NnTW1eKCqB0p1Im
r9demMguaZ0bfMmc3cblos3kYjDxxnBoArLA4DEPrUXhn4v6GxJt0sAdgKDwgz05
JgiaFro5F3a2F/oV53JKmIcmnkRZJFs1rz1Gtfq2f0C3ZjECMqu3X+r0Yd+efXQ3
AtuS4HnzgDrjs9QzuRVMb3XnuXuJoa3Dmu4fA1nmWm4GDgJuH1j++/RBxKBhxo8a
PcJb3Y7A+Eq8Pq3NT7fGZxc10vdxSCicdGVOco3gHlQLW6AZzFh+GQKQx749lwMW
DGHT4JsVEAmB5kkVTrGzUdLQ0mNJDtHUnmR4hm8jlygL+yQYKinbLycu3y+Zz9Kp
L99NYTALYhkJ+TELAQNxjRRrHmvl6s7cQCLR5zsE83RqSpLXjtv+uUuEueDAlhPT
AsSi4KrD
=CiMB
-----END PGP SIGNATURE-----

--iirZTItU1GQMMEII--
