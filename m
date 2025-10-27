Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85C2CCF9EA
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 23:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C9D68392C;
	Tue, 28 Oct 2025 00:04:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kw6I2vtH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE258392C; Tue, 28 Oct 2025 00:04:04 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B598780422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 00:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3c94deb7c7cso2871554fac.2
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 16:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761606241; x=1762211041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=r5qILvffvKO+Ifu8e1hmIIZT48QreSih01ccshlf+BQ=;
 b=kw6I2vtH3vIWYg7VywVZCzo6zywc7K9BUCuBwZE2ZvN84xmdDHRVk6SukoLFtDC3yG
 eer/ONRCulK5782t7OkLYqxW5y06skwIFalZQREiuuuoYpIy+WZfLsBaku5ylUTsGZz2
 39GssIL6ALhc/lIJnJ4Ma7uODbQeFrXHJdqEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761606241; x=1762211041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r5qILvffvKO+Ifu8e1hmIIZT48QreSih01ccshlf+BQ=;
 b=lC5jr6XHB1sMakLN35oswZm4a/AoJrAZzU3ly57pwVC80pGjTbSAJG4/H+HF8US/6z
 uCNKnfWGI3+g9tK1MrrbNNi9iGnMvduCvp32ofuQHQnTpPtuOzHNM2hazKTg32UGG4nD
 nhfrXhmC10yA/XXfOfUbZKcYQrp7btHZWB9OJqxLsc/IESXYeweeRF6pR2cgqJA8SfwG
 dWcYbRSr8RZRCkneLwR7HF7Xu1gJtx1O3WHLA7fDvtSKotgLhKGcgzia11ObCel5DWgl
 78BMvPvVyWATe2B3rgPS958mFbxqgRTpXqd6WY1qoinjhmlRbHwzjbJ+QmVA7w47YJLI
 meTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWt+IT5w2TARBXROojwUCMtINvT1ODnIUdluslL2fQbgD5jMTCBhCR3B8p3tUCvDTXfQrlsz0=@lists.denx.de
X-Gm-Message-State: AOJu0YyzthbEMfAGH5MKVce62yBJUiH4nRRMz01fRNViW9GflafF7cXE
 4xgCN5Li2xu/uoki+B58hBeyG0mItKA48/CiXSfkNxs1XwHVfpyh+uqV7Yxwed+flshAqgmAkAL
 Ewtu929UTqq9z
X-Gm-Gg: ASbGncsaTMo743/tpxzrQ2A+8oLuQPZknCiAwUvFpYgEmr26spPdbxiFTUWXq4nDmyz
 q5fjBc61e1AG69VaEPgSk9bFQifTR3AowLboQoC84W3pQHBUr6wrs5DLLxTADETTlUoUtugb/cu
 K7lX0tbWOJmJ0pt4NZfBqU9J2lXclGbAWWCPESUY8R9OMS1JrEKoPyjcYS5p91SR5iOyNYbCzoD
 GfjMdBpEQvgntiwmMMXszc3UBwYTixvBv9EVtFvFmTtlJMeBk6uNW/8PExwcFRig23gKpoj6pOI
 SbMiJt4/FR0ZUk2NXu/rSxKbtfEkg6Z9hOvqdOn7V1P6Tdo3JTCd/NqAIG6cDVdy7tlsJWu/NlX
 E6O7quCtvgrTIb1xbfZLjhQvx6/u37ZYVrEc/Er0BkfaeZ4KXLuFd4vxlY0r8pxV1/moOJuv74m
 HhLoBULlEhf5U6XUCt8EOjiyesn0IuOrJBt6rtbrbGIDcGUjyPHQ==
X-Google-Smtp-Source: AGHT+IGooTObxPqpjLWmIH0FExiJ0ZQ8qT256+PU8FCdJj8g2R0eoO1rV5dkY8AzbN7wM6V6ljn0jQ==
X-Received: by 2002:a05:6870:a11b:b0:3d2:ad7e:e2ff with SMTP id
 586e51a60fabf-3d5d922cd06mr927374fac.25.1761606241406; 
 Mon, 27 Oct 2025 16:04:01 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3d1e3a618a9sm2968962fac.23.2025.10.27.16.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 16:04:00 -0700 (PDT)
Date: Mon, 27 Oct 2025 17:03:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] common/spl: fix endless loop in spl_fit_append_fdt()
Message-ID: <20251027230358.GD6688@bill-the-cat>
References: <20251027110523.1105773-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Lik/3+N+VcuJHBjz"
Content-Disposition: inline
In-Reply-To: <20251027110523.1105773-1-mwalle@kernel.org>
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


--Lik/3+N+VcuJHBjz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 12:05:21PM +0100, Michael Walle wrote:

> Technically, commit 24bf44cf88e7 ("spl: fit: Do not fail immediately if
> an overlay is not available") introduced that regression as the code
> will never advance if spl_fit_get_image_name() will return an error. But
> at that time, spl_fit_get_image_node() was used in spl_fit_append_fdt()
> which calls fdt_subnode_offset() to get the image node. And I presume
> the commit was about the latter failing gracefully and trying the next
> one.
>=20
> But with commit b13eaf3bb4e6 ("spl: fit: Add board level function to
> decide application of DTO") that behavior changed and the loop in
> spl_fit_append_fdt() no longer uses spl_fit_get_image_node() but
> spl_fit_get_image_name() directly. Thus it doesn't make any sense to not
> break the loop if that fails.
>=20
> Also, the original use case of commit 24bf44cf88e7 ("spl: fit: Do not
> fail immediately if an overlay is not available") is preserved because
> spl_subnode_offset() is now called within the loop and errors are
> handled gracefully (and advancing the index).
>=20
> Fixes: b13eaf3bb4e6 ("spl: fit: Add board level function to decide applic=
ation of DTO")
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Thanks for explaining what's going on in such detail.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Lik/3+N+VcuJHBjz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaP/6XgAKCRAr4qD1Cr/k
CtZQAQDXk7NLTw913edaGj7JgI6exCCLQQHdzMWsAwzoK4REagEAwW2rIf3Nyzpa
oQNVOm/BM7BuWQJS+dEvF86BC/cAEQE=
=Z66s
-----END PGP SIGNATURE-----

--Lik/3+N+VcuJHBjz--
