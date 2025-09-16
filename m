Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB6CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6775281E13;
	Tue, 16 Sep 2025 20:34:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPWusIuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 693CE83071; Tue, 16 Sep 2025 20:34:40 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1A7803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-32a9c1d2b95so3387094fac.0
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047677; x=1758652477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=72OenqphIDukDkAr/6ZDHV3GTiE5FJ5mh3/JlXLEMKE=;
 b=GPWusIuNJgj++rWwZNa0oyyl5BDblq4uimd03imle9FpUtrLS5Ef2T1ddN6dZuO3tG
 suyTLbXykD19zu5YAPgkjhfz9AsESk26DKH/TYnNRF4WN9XmgOE08S4EnvfkNKVLXeil
 b2BDqqF60enNioPxdLgauGQr8u0a8jv6AO3uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047677; x=1758652477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72OenqphIDukDkAr/6ZDHV3GTiE5FJ5mh3/JlXLEMKE=;
 b=Fo4NOeLc0aI/SZG46fOK44GP/3x4wTdKd2ZOJlGztVMmG5UdxA/NLgjoEcuGazk4Db
 V9FYTBhpBrjIpdGiFnxz3Md7oYjrD5P9dpc09imZzkRpRpqJynL6eK/pm7OIof0ecRa7
 AxcbYE6hVg5CeeK7GIKavqDuils/d9U8aLm4SXV8kFGP26QwXnVFpdo6Ndrcl54bI4f6
 +OWMttYRxjeRssqrmkPYwSWMyP9IDKUbjCGg3ZEVR4ZuTv8w5OnicsWrTV5BLHZ+8EyZ
 6bxvWLAa+PueEYS+lcJehq/i9prVNTfsXfn/UGPX4ea0gqwI5LgafDcUwa6olJySQTjt
 q3+Q==
X-Gm-Message-State: AOJu0Yyz61GozCgMCTecQMQCJVGRGEY1Zgsit5G8Wtj/Xyfy5M/o7cil
 06y8gxSsnlulLL3jl2EsAHhGKPViAgZkMnQqUqgd3j3bD73fzpjaqhvZFxA9P4K5J4PmDkf+sMq
 9fK5dq2w=
X-Gm-Gg: ASbGnctIPWGNMVkIQbql3nwU/qZ1L6BTDKvuZuAjtTtTG4qvDNf1H3EU0HJLBywFlFm
 1ygeOTk83bKzMuEQ2tl5eSh0bZa8oT+z3qfmMw0Juk/rP9QdTDqQK7HGXzbzkzOyvEwLd4henUw
 3y8c85EASdAsUvEu0MXtikujAV/d6PT0yrftFitWEJCw+W7hy7QSmEYLb2y/q+CUMd61ImKKOlL
 ZDtvIjE0XQ1Bxm3eusMBfwd1/VJG5a3AloGM0dUZEvHhlyQP6aYp2ZOXXzyuueRDNv2wmg/7P2R
 9E2L5VuBsCwZTt0eSUBxM+hU6g5eJxAnS2eujStrWLlAEiVOFlZVTOPOAe2Tbf7OpzRA2IfKSLX
 6TbyoEsDcKHi/DrIxyykWPferW1tzwrOH+7BOQUkGF0IYUOXOYZygd4EyZnoh/MfVY2KtTIHR+F
 1rvQ==
X-Google-Smtp-Source: AGHT+IGmnxe4vXikmK8BdN2mKTVsF/i1hrKx93xwaz6KkBR43zpRiKCeL9dt4f+s7PS92qmnf4wfNA==
X-Received: by 2002:a05:6870:705c:20b0:332:1b00:6dc with SMTP id
 586e51a60fabf-3321b0f701emr4829029fac.10.1758047677020; 
 Tue, 16 Sep 2025 11:34:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-757c0e39e4csm2308090a34.36.2025.09.16.11.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:34:36 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:34:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com,
 kever.yang@rock-chips.com, hl@rock-chips.com, tim@feathertop.org,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v1 4/8] spl: ubi: refactor spl_ubi_load_image for falcon
 mode
Message-ID: <20250916183433.GD124814@bill-the-cat>
References: <20250916105857.163951-1-anshuld@ti.com>
 <20250916105857.163951-5-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u4wtpNC13H9k1ie0"
Content-Disposition: inline
In-Reply-To: <20250916105857.163951-5-anshuld@ti.com>
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


--u4wtpNC13H9k1ie0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 04:28:52PM +0530, Anshul Dalal wrote:

> This patch moves the falcon mode handling logic out of
> spl_ubi_load_image to spl_ubi_load_image_os, this allows for cleaner
> handling for fallback to U-Boot in case falcon mode fails.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
[snip]
> -		puts("Loading Linux failed, falling back to U-Boot.\n");
> +		printf("%s: Failed in falcon boot: %d", __func__, ret);
> +		printf("Fallback to U-Boot\n");

Switching from puts to printf doesn't gain us new information here and
may pull in printf when we only had puts before. SPL needs more
consideration than usual about size growth.

--=20
Tom

--u4wtpNC13H9k1ie0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMmtuQAKCRAr4qD1Cr/k
CrjqAPsFaDqeHPIPlw7vSSzqhrRdHok7ghxcpHRXAuvaSiNYOwEA32jhcHfqEz9g
IYhu+7kIl6S+awR0vWJFQ9E54Bz8rws=
=L4ZE
-----END PGP SIGNATURE-----

--u4wtpNC13H9k1ie0--
