Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D003CFB42B
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A28889C3;
	Sat,  5 Oct 2024 21:34:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lhg7HsTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED270889C3; Sat,  5 Oct 2024 21:34:48 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B21889C3
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a9b3cd75e5so321472085a.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728156886; x=1728761686; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yYl/A+04S4ahIseLCriKrjx96OphSp7ZeTGQh+FVEZw=;
 b=Lhg7HsTvCbWdLOenyvKNNLvIps4s9C3kGnR0/2Jms6ToawUJkHe5t32aO/GI9xt66r
 wwPbNyCHtoUI0P9Rl7SXltN7z4PFGhMjGspEeuELGRBDWTXtp/kJyw+puhDRVRKEcyR+
 g357+t8nJ9UvTcwAI/FNuaGufQP0MUcbJ+4PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156886; x=1728761686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yYl/A+04S4ahIseLCriKrjx96OphSp7ZeTGQh+FVEZw=;
 b=WUu3sxrP+5PyzrUF46mKpJKBLgHSpatr0dGOCF6wKc8olBJkuNrpwhBTH39V7Tbg/h
 uM11hDlusXh+NnJrOHHyr5QkPNqQRk5n8573MfKrxGxA7Tl4w/hiUTdRj5zEPEEvQ6q/
 JpwHyH4yqdRPnTULys7wlKnbyuLlecDBiBUghkAagSHC9u8BzRYFoeCvD1axjP7z+7sp
 SGetu2qmfXMkUxPd6czJ/Fd4a5UixpOtO98zbDL4g3YuEBcTjjd8P1WNbR4i2KZ6NsRN
 n/erxR4HQR794wcqT/wrCYz97rMHodzOJdsAZozau8QxxRj6BVsDNphx6HO0eIrdu80U
 fYew==
X-Gm-Message-State: AOJu0YxhXLGHd/J4sDiTIvjzMfAUwx7s7d0EUFZKZjdTE6vwbjF9rtxT
 pJls6Nn1nyLlmY9HYSjfxJ2pav/qiSRRT/WQfOZSVgKS2vNZ2q65oCHwPdggBps=
X-Google-Smtp-Source: AGHT+IHpHBkFAAut9snqzZ0xMs8oQXDFPu6rugphO+lrNXqqMLt8Xc0z9efVH21GbnW+z2GC62SpkQ==
X-Received: by 2002:a05:620a:4085:b0:7a9:ac2d:596c with SMTP id
 af79cd13be357-7ae6f45442fmr1269974185a.32.1728156885670; 
 Sat, 05 Oct 2024 12:34:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae75620040sm103340585a.18.2024.10.05.12.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:34:43 -0700 (PDT)
Date: Sat, 5 Oct 2024 13:34:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] ARM: stm32: Update MAINTAINERS file globs for STM32MP
 DHSOM
Message-ID: <20241005193439.GM4737@bill-the-cat>
References: <20241004235641.395703-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xbxJOVqNvJwcRRzd"
Content-Disposition: inline
In-Reply-To: <20241004235641.395703-1-marex@denx.de>
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


--xbxJOVqNvJwcRRzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 01:56:21AM +0200, Marek Vasut wrote:

> Update the MAINTAINERS file glob to cover all of STM32MP DHSOM related fi=
les.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xbxJOVqNvJwcRRzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcBlMwACgkQFHw5/5Y0
tyyY2Qv/cQQRr9lU4X8bvIJJArf4r9zUQGbK+ymr6VVHcV8pz8vtmO5RzA00JZmU
H4M9Mk9SdYdJ4szDchJRxxZIMPDlT1c4HeQsRr48mptKbb7L9/rqLgh86OU0WrZl
cMiOFPPcovR2ORLRamjD2k/fPbQ2HPTXjeO4nRpsz/4p1wxiUUl+OJ1S/ClTO3zN
siKGYfBzWXNuZfFEjtM7fbjmYxZMKyydxw4N8FMXEdFjMjmybpELzbRo0d7IPrrD
U0sQLLVEcXIwmty3GLw1nfihm8p8+0VaezOL29+BPoHfvu2Tvmyo0D52NkaP+Apg
8qVRC/O4xKrip1aSO7t7dp74kbO5D2/2MoQuWRlKdWDZ+2cBVzyaae5G/eDRz+L/
s2hFYcTvZuT8hvsQAm4Ex0BSk/W3jxiF1EfmfsJ7U1ybrqEeI0hrRwZy24eGlSvF
U+3rW5TxL96Gjube7sstgt0FELNScS6XmkkTivx3iiIhP8CTpbB1yRr4/cNgL5+F
thresb70
=vYP1
-----END PGP SIGNATURE-----

--xbxJOVqNvJwcRRzd--
