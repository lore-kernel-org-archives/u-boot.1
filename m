Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E511CD6E7B
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 19:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C381849CD;
	Fri,  5 Jun 2026 21:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XAdsKzPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3FB1849CE; Fri,  5 Jun 2026 21:23:33 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E236884995
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 21:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6e9408e30so1681876a34.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 12:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780687410; x=1781292210; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=94of0u8aL37obD9Is32QZagIdD/bkr4VDHGqYz/A0gA=;
 b=XAdsKzPGB+mDwOC9Lh5bl7rZwuCpWAIsGymjO7kozw81baG/R9ORjPqEha/wZgRaC3
 tN2cE/nXmC28vtz4aW669O3GM7VFOZI/chhQ+EmnfmI7dSZpGcrbqsMyfY/5x6TXqjNu
 OjjSqzcrDW4KSbWXimRE7TPC6zYGChF7f+8dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780687410; x=1781292210;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94of0u8aL37obD9Is32QZagIdD/bkr4VDHGqYz/A0gA=;
 b=HFuanGzGeKQBXCieeaLR4cORWFIxFzy2qjibDQX1y2AveTWH3hhDxfWZ0ETawl9nrb
 rPTawACGWnQ7aYlUbV0o0tTZ14MITq+bCW0ZM0oSHNY3ykEfy6b65hvv+yiZJXgT65y4
 gaZSjZqP/s07fmE26xIic9cPuHraG3dA1rLqb4w9120Bh559KILDiNcjRueFjHYwxISB
 M7mKKr77PQBjLjLudPuiEditpwAG71jpL5BYY+g2L7KnWsb+qBMjQT/IgYi+xTwoOjCg
 TePRTXmhziYpx/UTzLDslYbiVj08P+5Z4JYPWqjz5Ac1k2/ZChpAtOq+x9ZbGnXibcqy
 FX9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ87vGSPAjMtLtyl4ZZicarD5FDMVH+sWOaUn6k6v4T+szDKlNpfI6Hq7xpJd3VKVd98wECDUJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YxIqMw+RLNFiM6ajrCPxo+ab5CgDsQyDDHNumEFXW8lpTmBlIT2
 H+YIZo0OonuA+HyYvaMQ5hZtz9KouULXueHA6IvDfHTGXC/tuuInJRVzIAd6phNqn5Q=
X-Gm-Gg: Acq92OFxwhfGVY9dBjsUVcIkyB4dzqJTCB2xhfiCxlTR7Bo4nEO40gRS2KvLfcHxZma
 US/PXCPS3v4WQ2QeOAx9ExOfZOKbTYUBiadKfBMuOqMiyXgjW7JrwMG8T9W4Psc83SWJ5IBAICF
 UTnqVaYXF5irWFOWeKgXDa/uln+Z+ui/Q/wf8BMdyHKDiZHmb/0/W4gfOe6JTu/aroRcX8K5U8T
 h3s6dFgFYjavkVjYS/bBFewEmTv196ydsybEjEN/kIJDdOfKWHk9hKYnlcDeHH8ddk7NEZJXWkV
 zMNcQV9uS2wSYcAKjIxIWbgzLLmmwhowkRrZ6l4hqqV5IoDdwo8IjQvUm8DFT87dS3PUqXticUi
 BiqbDpZjfhpCugW2KmY0oJJGQDN53GGOY2D5DTmccQ/KqSVtqvfz/FIKEFmomrorT6gCElwsaq6
 kdceqfpZJNl2waGdutRko2vXQvylOOZeXPzyWoy2ht7yLft6XpBbJyUTyJGxhhV3zxyoved3GNL
 +R8sQChgmLRARVn7brRlBcTKn0WqJClvIC260WdmbwdAwHCSVsFdkmQlkFNjQ==
X-Received: by 2002:a05:6820:200f:b0:69e:3e2a:a844 with SMTP id
 006d021491bc7-69e68c8a7eemr2572261eaf.51.1780687410687; 
 Fri, 05 Jun 2026 12:23:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-440d7b79b7asm8392114fac.2.2026.06.05.12.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 12:23:30 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:23:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 andre.przywara@arm.com, daniel.schwierzeck@gmail.com,
 hs@nabladev.com, jerome.forissier@arm.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, mateusz.kulikowski@gmail.com, marex@denx.de,
 ag.dev.uboot@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] Kconfig: replace deprecated help word
Message-ID: <20260605192327.GB382693@bill-the-cat>
References: <89147ab9-5167-4be0-818f-30e2b39021ec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mobphtJ3mvsgAJsO"
Content-Disposition: inline
In-Reply-To: <89147ab9-5167-4be0-818f-30e2b39021ec@gmail.com>
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


--mobphtJ3mvsgAJsO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 09:04:58PM +0200, Johan Jonker wrote:

> Replace deprecated help word.
>=20
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>=20
> find . -name 'Kconfig' -exec sed -i -e 's/---help---/help/g' {} \;

I appreciate the thought but the problem is that then the text needs to
be indented too by two spaces. Since there's 222 of them and some will
also require re-wrapping, it's not a small task unfortunately.

--=20
Tom

--mobphtJ3mvsgAJsO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiMiLwAKCRAr4qD1Cr/k
Ch/OAP994iuPVsCdJzXKrZ3ShkZf1jR8je7ZzUf0aYZEE2l9eQEA6vPuOaBRU1dA
0w4qE8mE60lA2371hM8x67s5CeQF0gs=
=9Xz0
-----END PGP SIGNATURE-----

--mobphtJ3mvsgAJsO--
