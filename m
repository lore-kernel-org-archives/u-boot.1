Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03376C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:34:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA35870EF;
	Mon,  6 Nov 2023 17:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PAIdhZdX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38B1870E2; Mon,  6 Nov 2023 17:33:05 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C11A870ED
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7788ebea620so301569285a.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288382; x=1699893182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UbRuBsu0NH5fmYyYoengjE3mIcTWnqUnZCFlRQ78vTo=;
 b=PAIdhZdXhp6uYyW/4cDNJ0hqiUTnzSEJDJHXOba0JOXFoiALFSxF4N2N/UdruY9DIG
 Kl6oFzX7F4Y/6J1T28jyGxBKig1Fdwpc19RavISvPFHNq3FFG6WxWuqORZwsqWUiQjuv
 ucD5RUIKo3Xnt3MOX7nDe08SyoLr2LntEP828=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288382; x=1699893182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbRuBsu0NH5fmYyYoengjE3mIcTWnqUnZCFlRQ78vTo=;
 b=nd0JkWHGs1N/PcNQjvWNZ5zuy5mWu5HWXga3GKfK28w+SCuD4LNlG1HusQshgl3Trw
 e1emjt1rMye59wqAZYetOGysDkZnN7oy8Ln0PgU+co0FdA0gXSw9SoGDgs4AZr+M6xoh
 GN1RuTvGxDOd72g98QieNAi7Wk/Z6tFfBEA6v+sUsQZDPVHYWrVVsKtI1jVZ6IU+HEoJ
 fzW1htpogcYpvKTLmwXjEOdk0hJe6ikb2p6joK+ZIj4jH0g7357ZbXrfTXB/dTiBIjX6
 Kp+xYP2O6UlZQ1sF7vGyLx5kgqHfXfB8VwCmdFqb1BrN3go/6MjHgjWwURikEsmhm98c
 tGSw==
X-Gm-Message-State: AOJu0YyTZ003XFc77WSiI5T5Vkze3UQ3ow5hKZnmyODQXRYZO+FdiswB
 +KI+Nmgi9bulx+fw+GY5DMRyjJp66Dy4iFrg4oJw/g==
X-Google-Smtp-Source: AGHT+IEd8pgY6ogr5O00OToAai/javsUl2Rjw6s/b5TJ42s/vak98jkwIt8nFzLxEhll0xtZO25Pvg==
X-Received: by 2002:a05:620a:4089:b0:779:d1a6:ee76 with SMTP id
 f9-20020a05620a408900b00779d1a6ee76mr35255537qko.37.1699288381995; 
 Mon, 06 Nov 2023 08:33:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 s8-20020a05620a16a800b00767b0c35c15sm3402025qkj.91.2023.11.06.08.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:01 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Dylan Hung <kobedylan@gmail.com>
Cc: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com,
 BMC-SW@aspeedtech.com, joel@jms.id.au, joe.hershberger@ni.com,
 rfried.dev@gmail.com, u-boot@lists.denx.de,
 Dylan Hung <dylan_hung@aspeedtech.com>
Subject: Re: [PATCH] net: ftgmac100: Add reset control
Message-ID: <20231106163259.GP496310@bill-the-cat>
References: <20230727015814.3459990-1-dylan_hung@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UmvqAonmNHsakrE7"
Content-Disposition: inline
In-Reply-To: <20230727015814.3459990-1-dylan_hung@aspeedtech.com>
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


--UmvqAonmNHsakrE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 09:58:14AM +0800, Dylan Hung wrote:

> Add optional reset control, especially for the Aspeed SOC. For the
> hardware without a reset line, the reset assertion/deassertion will be
> skipped.
>=20
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Reviewed-by: Ryan Chen <ryan_chen@aspeedtech.com>
> Reviewed-by: Ramon Fried <rfried.dev@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--UmvqAonmNHsakrE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFTsACgkQFHw5/5Y0
tyyX4wv8Dsede9LKy0IjcADz1SItanbm8pEYg3PdGQ3BtfiwLbZtvgVwheuLF+oC
zoyZvuXUxE7BXmUscR+A+t1iIUeEn/LNKnsr7T95XU1Z7u0Lw8AIOMnITav4QacF
fBIqqKlWzVwBt68FuZQFHqhPfWyZaBC34/dXkMamRhfA8AREkbP8mpJXYnb4B5bc
y4Jn5Ss7aoz0F9OVyj5n8/oFKNhVzhVn5YGUHl2bakNQv+B7dEqO61NACs6uriph
74l0hkHL3o4l5aNZpctztT81Y1pIjs3MDH9hJNc4weSZzHshFfU8soN5cZ3NYanH
wU8+uAyiLhr78s/MFb6OdmOlCdYorITIkQ0O6mehZSE3VADGXUHWogriTBwIKw0A
nXCnmbp2UWSD+svt9uS0/i0npZqCMe7jR6Roe/BeVpfF+UnyESDgtMFWpFhKb2tP
VAfwmFwYWlxTdGWBsD5F4w2EoY7c4z22ySsedMg+XSJfuJIM95+GmC2M1h25iXuA
V1u0Jkoy
=Y9ic
-----END PGP SIGNATURE-----

--UmvqAonmNHsakrE7--
