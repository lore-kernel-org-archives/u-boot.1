Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD1D3409C
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7B0084101;
	Tue, 27 Jan 2026 17:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hlTypMwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D6B984127; Tue, 27 Jan 2026 17:06:44 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0E148408D
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:06:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-66103641d76so1324666eaf.1
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 08:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769530000; x=1770134800; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tqnKmBACgtAKo51PkuAy5LIWZXO22QXSRthzwAabsSM=;
 b=hlTypMwtx34EDCjU68f5zjVX2BSB8A4ojKXzUlUcO4GGWkujMjRPhKS+Ial4BKIlIk
 SF75P4QHwyBdEFHwF02JQGJALgUzRvIPRiTrZvQugaGH4db1gBj7IScHQZ8TkAZr9EeE
 AuFoUHQ6mkwD4SaDIesom1PmTwTDOQQbjauZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769530000; x=1770134800;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqnKmBACgtAKo51PkuAy5LIWZXO22QXSRthzwAabsSM=;
 b=mqQvKmuUqFo/WiBizaKhzFfKmBltWgiQJxxXG4LK+chnL+Bo0neNALZH0v9jlM0jyY
 Bbb2WdswUGhZJB1t6LYeJpyl45vOOZCFsDV8+Ll5FcTItB0SCIpqQvj+8nllsyq0z6qZ
 E6+FlCdPhsxwMmcmt9aCouA2tuv9T4fQFt9og5qqIDpep8/E25JB1wJk1I+Q8oizX5ef
 rFeAuFHucFjbiZvgDbVM2WBF5qJwzoUd1hrg2h9K8DYGIhQNYq2o9iwMmakdLP8LnbM7
 DqZ2VCll5A/NcPqrn2OJfPG1ld8i1FxInuDZMKq3ZQK5ivDp1d3dvQ81LyywhEL8nsln
 ZM8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqSyrMqGgQzZiAdknPg0LIXiAO8PB20bzibr9rlNfKg0SLHUbn7tW18BqBOhKQUefrwlJw3a4=@lists.denx.de
X-Gm-Message-State: AOJu0YyoQ4AQEc9ej4GJEdFPOjMPwOUnIVWIiGgbw7qTcUp1z7SnGwMF
 Xoz2FbXEnxnU6IglSAv24oZdcjgaqfGDXLcZ0Q2/Ab0N1HjmAndB1cglZ/tw2/WoJ68=
X-Gm-Gg: AZuq6aKwnaOocsW9wa6SnCUIpNFk3yLa4lbPmPlOIJQ8ldIpcc7ms1E2ZepbbF2tNRV
 Ke5iusCN9LKJehSwjVDV5xkP5yx9OVlxngv33fRL1luXBvpDW8+Q6ZSYv8Q71ninPwEtgSTMu9v
 cs+5+t2XMCdfzZkjRU3XgPiYa/AdGLRC4qzCUoEmNUgHjtNDol4oOaAHPBIbHfta8fNzCIoGcvf
 gGIkUADeToVui2Cu6id0MUzB8igrlZuZRmnP6XMxnwu2zfT4ISZkj/5V5hA41J6ej4bDF5LU8z8
 6morkWpaBWIRjLuW+OqlSet1BRuhVnUy+VC9z2Jus8zaaF8BeCu+KmntoHl6L+6aE+Ex58ju5rr
 tBoOtJQzanFSHLRgsp/grgGrlapRa+MJr8JcFrgnkn1pZQcAyrIqN7i6dHChA2UWg0hAwMzIrYV
 2gg848IfkAj8TMlnmPkbrzXw1LB9pwYgHtaHiCErSgEKXIasYML/Lm92IsU82OhPStlXLGlfOOz
 2KQW84AcyD9gtxBI+MesenOsVUMxhk+XaOJ8rs=
X-Received: by 2002:a05:6820:c88:b0:65f:7470:38bd with SMTP id
 006d021491bc7-662f20dac20mr935994eaf.58.1769530000426; 
 Tue, 27 Jan 2026 08:06:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f4cf9c63sm479612eaf.15.2026.01.27.08.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 08:06:39 -0800 (PST)
Date: Tue, 27 Jan 2026 10:06:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Sean Anderson <sean.anderson@seco.com>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Prasad Padhi <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, afd@ti.com,
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com,
 bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
Message-ID: <20260127160637.GD3416603@bill-the-cat>
References: <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
 <20260126225842.GY3416603@bill-the-cat>
 <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k8Flhz7SoQWGS9N3"
Content-Disposition: inline
In-Reply-To: <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
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


--k8Flhz7SoQWGS9N3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 01:36:59AM +0100, Marek Vasut wrote:
> On 1/26/26 11:58 PM, Tom Rini wrote:
>=20
> > > > Some validation of "len" has to be done before it is fed into strcm=
p() here.
> > >=20
> > > Well if you are concerned about lacking a nul-terminator then we will
> > > read at most 8 bytes beyond the string.
>=20
> Which is wrong, and trivial to fix -- check the "len" that is already
> provided to you by fdt_getprop() and make sure it is exactly length of
> FIT_TYPE_PROP before doing the strcmp() . Then you should be safe.
>=20
> > > The other thing that can go wrong is if we get something like
> > > "flat_dt\0extra data" we will match.
>=20
> This I did not consider. So maybe what needs to be done is compare the
> length and then memcmp() instead of strcmp().
>=20
> > > Surprisingly the closest we have to this construct is fdt_string_eq_.=
 I
> > > suppose this is because most strings in U-Boot are guaranteed to be
> > > nul-terminated.
>=20
> fdt_string_eq_() seems like the best fit, yes , nice.

Bad news, fdt_string_eq_() is an internal call in libfdt. Good news,
fdt_getprop() makes use of it via its eventual call chain. Which I think
gets back to what I said earlier, libfdt is doing the input sanitization
for us, or so many other places are more useful to exploit?

--=20
Tom

--k8Flhz7SoQWGS9N3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXjijAAKCRAr4qD1Cr/k
Ch1DAQD/3nk/DSP9bF6KtkGifRZMjHpHD2gZ2qUXBFNeg2p9DAD6AlfLIn8bmU4K
1fLGwOMVHlf3IjzAnELk+BgL+6dtdAE=
=xg0J
-----END PGP SIGNATURE-----

--k8Flhz7SoQWGS9N3--
