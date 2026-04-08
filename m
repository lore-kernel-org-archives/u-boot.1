Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8737D10F995F
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 16:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0193183D8A;
	Wed,  8 Apr 2026 18:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qWGWzw2w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F7A83F98; Wed,  8 Apr 2026 18:51:13 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37ACD838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 18:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-4230a00de40so659952fac.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775667070; x=1776271870; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lLX8mi81AYZFzqqF7hcyE3VCIJxWzTaZrrv8YodRlKM=;
 b=qWGWzw2wTjIQy5Uyq48RDJHTgDvnq3dp0UNkjo/UCwuwfxcaEfhuonAUTrUt4Hohyb
 bCKrw40OXDw1KrWzMfYoC6aAVUgzGtbJBfpz1f+LVq+9eRRy5Lq0mCmK7A+BqoGAVBHO
 9IQEf7HSPYGlVfdKdFIEwzoTvOCbM9w42zBOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667070; x=1776271870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lLX8mi81AYZFzqqF7hcyE3VCIJxWzTaZrrv8YodRlKM=;
 b=TpKwnwAvKNw3/QTt6zlqJUSMshNEQNmVmayPyXhqrTOnJNo32eMG4nm+IMtvk9VZyg
 DGS74VwJusIyChhqpNEQqGDuSjSMyJAdRH4rEjZdePP1pXNmkRGDt45tru2JAeDh95/j
 +sfaApgHwDOnZoIXV/GxpI1+Q5GkdTMlUPjqNBquIRGUzp8pAj9QECywDEC49ebNwJRR
 yA8exhwVsEP1/NdHx/bra9TeikQHMOzY5EIYEu0rUdUTvkxuBVgpSnCB7XitATQ6yJOa
 K72T6vYWhZ5IQHiJ+h6F4hmQUf6NJ74tq0dim5wnzdXVaRC/ZSo893sPfJG/d/UGE3Ei
 psxw==
X-Gm-Message-State: AOJu0YxrXvgROsbjcdiUe+w63lbcUdpfPVOmhaRWMqJWcrSIm+af4BlB
 kN6RJtb5OhuzQHbAcYdXAAIfynNHeWgfpCExtlrkQNLfKI4u6bw1Jsp7WrstRrD+c20=
X-Gm-Gg: AeBDiesnwTRR5oP+ru+TGDgv4bujho88qJTn9k3i0q/ZcBHIvXusP1qFbm8+g+iqChG
 bM41g7Gi56vlFu4YoYN+sQSgWDHgyfNZrmdxD+1f2dlgqcvbBwiqLUBNb99KfpL6yLuXRFicyyz
 p0IHau/MGbYMWG/2FEftwYrd8Z7II+ds9yGToigMTphbMSGuJaM6UG4vMm8J/m6bvyRAdrE2DFx
 Qp0Od+TDkMdyzE9gLuc8H3lViPeIV/6O0pjPNSFQy9chyNdgCfDym+WxqhJp5gDR+S63NbzCleX
 nF0CmTXIQOf3hy0urBEjqfnrOSrf9kVriHy77BU1szFPg2OiSLQrmFmbRLytRe1jHrsTppx8Mkt
 Nt+MAkmlRtjB2yVyFsYHSE9DHUghAur0gzB1WDFwwaAcQbqteMQiJ5vDVwX2gwW0GYV3/rBjg/l
 z2aweprQohFc0xt5hkNNFWwsAKRxl3hrOVDsjxCgRkgfLNtnlT8tLBsKdLn4/na6ysZy/3b2Va7
 U51U6VnzrWrFRyuqkZhOS19M85hdYnb4ilwuxptEt4qPSZA
X-Received: by 2002:a05:6870:1719:b0:41c:24f3:7851 with SMTP id
 586e51a60fabf-423bcb8c013mr124782fac.3.1775667069906; 
 Wed, 08 Apr 2026 09:51:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4230fb42ec7sm13962217fac.0.2026.04.08.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:51:09 -0700 (PDT)
Date: Wed, 8 Apr 2026 10:51:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Ferass El Hafidi <funderscore@postmarketos.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 1/2] autoboot: allow custom prompt without requiring
 AUTOBOOT_KEYED
Message-ID: <20260408165106.GJ41863@bill-the-cat>
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
 <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i2WfNV+3xrxBNgce"
Content-Disposition: inline
In-Reply-To: <20260408-ui-cosmetics-v2-1-721dc6d2116a@postmarketos.org>
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


--i2WfNV+3xrxBNgce
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 04:34:56PM +0000, Ferass El Hafidi wrote:

> The autoboot prompt used to only be customizable in Kconfig when
> AUTOBOOT_KEYED was enabled. For a usecase such as having a nicer
> autoboot prompt alongside a splash screen, there is no reason for
> AUTOBOOT_KEYED to be required for this.
>=20
> Remove the dependency to AUTOBOOT_KEYED, and use AUTOBOOT_PROMPT in
> print_boot_delay() instead of a hardcoded string.
>=20
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i2WfNV+3xrxBNgce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaHdgAKCRAr4qD1Cr/k
CnGLAQDT/roaFgjbb+y1rWVFlhLR0ZBthF34u6rtS4EY5eUHGAD9GDkg9TyLB7Fb
vQzAaMJKPy4J8tEH5jhB5OTrznLq1gU=
=KKGV
-----END PGP SIGNATURE-----

--i2WfNV+3xrxBNgce--
