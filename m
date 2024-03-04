Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6592C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 14:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C89087F85;
	Mon,  4 Mar 2024 15:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IZi7zP7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7016F87F09; Mon,  4 Mar 2024 15:16:23 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C10687F85
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 15:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7880ea7e2b0so66521285a.0
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 06:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709561780; x=1710166580; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cT+GQgosuisMHU6c5w3kMHsvKVjdrlNMMULWaysCppE=;
 b=IZi7zP7odsqbLxSzfkQrqEnFc+6SEHgSoM8RAt5dbJC+s+MEiXBCbcEMwOB1t9LFBj
 Tktul6JG9Gd2bH2uswYj0N8j8Ik4rfzGVfPJAlFAHFtqmaLpJ9kQ1aXLRLhzlIugmody
 FUNCW4XbHRE2ZW6sNlQ22Sh/CS3ZUL0t30GGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709561780; x=1710166580;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cT+GQgosuisMHU6c5w3kMHsvKVjdrlNMMULWaysCppE=;
 b=va/5SXAm8WaniFUtAsIO6Pg4AMcRm+dO78Gq9eOdLitdd11nrAT3hLC1uuGZudBuYI
 q8m23xv05+ofkl3R2JXeVbNDg5WdcI86N6yYG+WitIsIvpj5wOszwINwa/ncchO7FQCh
 sAIXi1rapKIE2i0OhavZlhDl78SP6eVjEYHsbUI/K/VEjMkbx9YBr2Ysh3UUM52/+l5Z
 p1QvzzrylBn+gxTSSRiOjTCdblpNiAxPiQeC4KEpJpPiXyeqD2sxXzxd+Z9vWZBQCHHT
 avLFbtass8oyfC4K7E5N4t/40cM+JhBKstrKAmrSiHoThyUSlQ9h9/BLM9fGw725LfXm
 fkww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCTVqV0wLlbK8Rt889xHD+S+BVnuKtH4anTMKjPv1hNEQxsyTGPu4KJmYwmKtM8UauWfJgmXlAEUGn0+LOnReGrR5QNA==
X-Gm-Message-State: AOJu0YznbjemJotARuFKcmIpHXRA9qbjjTMLciOkjOiFzJpq/6w0+Pj1
 pCUmHRBy0wsB9hDie6LZV0Xi5Kp2grIDn1gPWTpsDVZOCliuk7aM8REFhefLCwA=
X-Google-Smtp-Source: AGHT+IHZu/AYdqFkzVqa3Esr7LLWPJ+LFVfRjeioEcb6sA+PMZ4sAYFY7cSpM5Hszy0DBYcKWL1UXA==
X-Received: by 2002:a05:620a:40d3:b0:788:2e47:b290 with SMTP id
 g19-20020a05620a40d300b007882e47b290mr1753122qko.73.1709561780129; 
 Mon, 04 Mar 2024 06:16:20 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 cx25-20020a05620a51d900b00787ace473c0sm4402787qkb.16.2024.03.04.06.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 06:16:19 -0800 (PST)
Date: Mon, 4 Mar 2024 09:16:17 -0500
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Andre Przywara <andre.przywara@arm.com>, Bin Meng <bmeng@tinylab.org>,
 Linus Walleij <linus.walleij@linaro.org>, Fabio Estevam <festevam@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v2 2/2] arm64: Enable CONFIG_64BIT for static analysis
Message-ID: <20240304141617.GF1523872@bill-the-cat>
References: <6a7328b8-eb22-4ad6-a1d6-eaecd2f8a067@moroto.mountain>
 <6907b26a-9eb2-4ffd-8337-50ee96155c05@canonical.com>
 <007f1c98-4871-49d6-b601-4766ff45e20c@prolan.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3AzeRJIW4Z2jm/xz"
Content-Disposition: inline
In-Reply-To: <007f1c98-4871-49d6-b601-4766ff45e20c@prolan.hu>
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


--3AzeRJIW4Z2jm/xz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 03:11:04PM +0100, Cs=F3k=E1s Bence wrote:
> 2024. 03. 04. 14:44 keltez=E9ssel, Heinrich Schuchardt =EDrta> How about =
other
> 64bit architectures (sandbox64, x86_64)?
>=20
> I think that could be its own patchset.

Yes, a follow-up is fine.

>=20
> > Best regards
> >=20
> > Heinrich
>=20
> Bence
>=20
> P.S., does anyone know why I'm being CC'ed here? Did I participate in this
> thread at some point? I only remember contributing to lib/rsa and also a
> small patch to arch/arm/lib/vectors.S. Maybe because the latter touched
> arch/arm/Kconfig as well, so now I should expect to get loads of mail for=
 a
> month or two?

I wouldn't say loads of mail since it's the top-level arm Kconfig file
but yes, git history is going to suggest you for a while.

--=20
Tom

--3AzeRJIW4Z2jm/xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl164ACgkQFHw5/5Y0
tyx/OQv/VIB3p0LmYVV6FiJwNQVj3xRjuD6Itw/sgvTPgvrHpAPeo9HHlglzA8Zs
wpUXogb3Oswyub6slfLfM0XD0OlTjxveSTedaXc/6lyYPIqjnB7og2MLL1wthNK3
WxjRcCgRtsojsLveBkk8Q/tbbcyYK9wHbKvTTSYJzb3I5OfgaDt6UPBvk+87LHhd
MiMpFr7DT9cD7qTrRbvNMQkkqekCm/PZ9SuBfSYNvpD0Af6lcaH6Emz08hmXqRtz
IyfiGtJnvm5qYlql97xzmLtAv9F0So3tAeafTm/eS16hTovBo1ve201k3PNddFbE
6EqZKqh9CaW+HybXfMRsbaKSHfyA3FIRNjlPU8vbgUdf96Wd2m3q4vZ4Dc8mWN9q
4fBWoqhf3HOGrPgweMf1wR5fbVcCTbBn8DCRbhSWaFAHeQWdQ2zCCeW2WXTeSDCJ
BPfEU7HKNpQpW/Hazh7LfGl0xAtx5hQQfQDJ+pxugxacjAd2uEsc9nxV5MgcYGHD
KMhcyUVF
=22xI
-----END PGP SIGNATURE-----

--3AzeRJIW4Z2jm/xz--
