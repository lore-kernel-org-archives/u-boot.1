Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D4C531DC
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 18:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EF36888A0;
	Mon, 12 Aug 2024 20:41:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V1xeRCpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7028785E; Mon, 12 Aug 2024 20:41:57 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E58788874
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-709340f1cb1so1337441a34.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723488114; x=1724092914; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PuA84AZjmXh/HmWAQ9cFWNcX7sUdw/FBMlOOABiBauo=;
 b=V1xeRCpzTiuDN8UT4GKq8cqU9KSGkS5mRx1sQ4nA+Clm+JaSeG2zZ3kYpTzZNPGgN0
 RKy5qlnj5lN93bjDRadP9rygo05cLNcWw1jkPWxKaIfhMCFJwLRe5ovnTzMA3g641sFW
 QUJ2PZovwz2quL9jP2DEJkxeONdyu1sRBE2Q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488114; x=1724092914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuA84AZjmXh/HmWAQ9cFWNcX7sUdw/FBMlOOABiBauo=;
 b=Z7HJ3kRwioOCKeQcY3+jAl6tnlEce5cE4sewz071RDVQa3pAhFhgXInB3njZRjGKTZ
 9DvhdnQJp4GZI4iUY6YeQIYK4UybHwlsmWCDnUPajDN84nag3OFbREzz/A6n7yxuANt9
 Zqz7zxG/ve444KevAmlmAmL/en/bI/YaeSwKxAid1KGldCftrnY/IbWCpRYSYHWyabnk
 EONV8aEtyB357IfH0ko1RHl+hngKZy/qHyTJMrcUy6RhLOYR8F+B31feqKzjVFO8z8Y8
 P8zHrogA1Pp9JRRZBRxkAi/PYAl+d9DH6Limfopivl3TJu/G0zbnlxUW+p44iZzk/92U
 fdhw==
X-Gm-Message-State: AOJu0YxPY+aMZGnuXlGJmQR/mG0MqZ+VWHYz3MV6HSO9q9d4LC01XE8v
 jxQwNM2vJ7HdqiajUaFCj7V2bh5kquDMfS+yF6m0briMTEtavE4+NT8Iox1Xdqw=
X-Google-Smtp-Source: AGHT+IFMRlEJx8SK8TCB+L5tlw4Z2FL8UE7d5PjnS83h1wmko+YC3Slf07lNcYEF3heqPDW1eOI5ZQ==
X-Received: by 2002:a05:6830:374a:b0:709:3b06:d578 with SMTP id
 46e09a7af769-70c9393cbffmr1618369a34.26.1723488114029; 
 Mon, 12 Aug 2024 11:41:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da3e73ac0dsm1359545eaf.40.2024.08.12.11.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 11:41:53 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:41:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Ravi Minnikanti <rminnikanti@marvell.com>
Subject: Re: Please pull u-boot-ubi
Message-ID: <20240812184151.GE1626301@bill-the-cat>
References: <bfabd86c-6fb5-06e9-b0cc-c1aeaa1b1d09@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oOK9EdC6yP2ryKyx"
Content-Disposition: inline
In-Reply-To: <bfabd86c-6fb5-06e9-b0cc-c1aeaa1b1d09@denx.de>
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


--oOK9EdC6yP2ryKyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 10:24:07AM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from u-boot-ubi the ubi fixes for 2024.10-rc3
>=20
> The following changes since commit 7bd2559cb30a4e800db519e88a22a25f13c753=
ec:
>=20
>   Merge tag 'tpm-master-09082024' of
> https://source.denx.de/u-boot/custodians/u-boot-tpm.git (2024-08-09 14:00=
:04
> -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-ubi.git tags/ubifixes-f=
or-v2024-10-rc3
>=20
> for you to fetch changes up to d16bda85ff0762aa96e36fa65d2e3b5342d73d7a:
>=20
>   ubifs: Call ubifs_iput when ubifs_iget is used (2024-08-11 06:52:15 +02=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--oOK9EdC6yP2ryKyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma6V28ACgkQFHw5/5Y0
tyzs7wv+PSUAYkranjAkntGlEMzTPhfJfDOBaZ7csdN++c5OJ/ZNscT75V7f3+X3
K6/uWjrljZBLeChLHsdVlmsL+R4nj+Iqd8IPcOXfd1yVPlrwkUo28a+fo0meQAtM
jBchVJ+oTBQIFYFS4rYlagd5CiGSXL9o+YiFrPhRJvfwrLt3zO0KdqaK61j6XLKS
xO65L4VzXaJHTI1ffwUQycB8bhxNZ16pldoOdySFk2i7y33Kje0JZWV57IvykXUL
pgfEoJjdwqoHJ/0pnKZImqAeFcd9/vEfd0KUHgJdCzjmdmucydS0OyRjwCafhBw2
m1kDGL04ooM2ja4zWUSW4FB59pIuP6bPvMM1qgAi3UKWZ1V01BsBAsARvCK0io+A
GCEsBxM79QwLWVM8s0S4BDFBGHWVuTgSvr/wXCsXZz6i5L+P1ovVFgfBbE7dvP9/
1eR3UmakxC6eKk2y73x0nyTt0KKbXp+xh5vJXki+ix7xq9OEvqBHMR+2tmUrdFqW
msrT1PFZ
=AiZO
-----END PGP SIGNATURE-----

--oOK9EdC6yP2ryKyx--
