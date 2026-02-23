Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A68FEC113D
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 21:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D9B983D8A;
	Mon, 23 Feb 2026 22:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hCRzwPaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48A7283DAE; Mon, 23 Feb 2026 22:07:42 +0100 (CET)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D57E83C39
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 22:07:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-4645dde00a7so1512413b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 13:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771880858; x=1772485658; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=B2DnsN65ZyfL5w5bICTSX5LmK4HayKckRmcYukp2mO8=;
 b=hCRzwPaTa5Nh0mzZJFfIJF4eAIUXW9OVn0KoyXB2JDFNQkRvXJ93jEkZLBZzWjmSl5
 4PGge3x7wlpyI1hVZDWXKor6eFG72diD8VOwFiYcJvz5oX4TWXIUbXmO6AbEEL8JtUEe
 B3tZ3ym4kv0yqdYIh1F76ihz0cvmiSZaz3iUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771880858; x=1772485658;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B2DnsN65ZyfL5w5bICTSX5LmK4HayKckRmcYukp2mO8=;
 b=abks0AIm2q+4c3Jy0pBMSBS1hI8cwJMOMKhU0kz+9nVeWFGv4A0BfD1PHEYcF4RS/t
 LbUzoLCJpB3BFDmy5SGqiYLhe2eAkUePftCa7dz6b0MO0pEDENAq/WYSPKb13fjWX4x/
 FzDKX7FIJId4xkbN9k9zt00mePdrcluWQF0ZOkVwFDZP0H6GM2dhP4Bghd2OKu0kwTyR
 AQfTvCUlTgwdLrnbzXtGRqsqA/srIn4hyRyZI8VULlkkZit3yglyB7cYAgNq3SVDAzd6
 XW4GFnBHcennRlaHXeb/tSzFLgw9KKEbOsjVt9j9n+Ou8TGF+iQ/tf+I0ivwBP2m8VT5
 S6MQ==
X-Gm-Message-State: AOJu0YzjhKDXZ7F/jcYHYmMGprVTXtF7GyJOHP2T+zu/F1oVBZxG/4Eb
 zhP/xMNTO5lRGs12KvsqdXq4MFMvejwAUVt2khlj7hD62HLUkzvKQy3GR7scyqGqzao=
X-Gm-Gg: ATEYQzzxCMUGITozm+JXUo7Yj3Mc8gTfrqh+NaoGB41M+PzSt72k668qUX0eSk55QWr
 v1ljbXnPCUrXNmQn/+6Sj4ByGLczp/5ivc9ebgvEjdiZpmlaMVfn5IOOa+udbLmj3ZfDJVmi7mu
 bKG3IxRXnjjOE5w6Sfoqbl6X04NYOISmdG1/FolfpMyHwg2LeaVMJMB8Lf9Ew8bbAq2D6HCoZ8r
 OMN6BKEcype3kdMy60qffJ/fF01+dcsUxlI+pQ2l3jSDCHF/UwkW2aIyTs9X91GlpSApjPkfK03
 0/rSgdeFo5xqWuGG1Ml7wC270UC4Ku1l0/gQxZEPwF5ILUHSBZLsCq2469wVd2z3nODoU4hXVTT
 +t9J68cMehYF+DWOeJiToxp8AjD4eDH21pl3MKm4isoNI+4iwn00AUl/1rUM98rQnvSmfBZekbO
 vdJDqBwV/7eWR/uCGsvWD0/pNMm2Wq3cVSXOvS6iOA9Eff6ZdHRHPEacc1u5TmPBvrFYF1KfvA9
 9BTet+E2qI9j4j1ykTy5BXjF80lRZPKC+Tj5czQzCGXx/k8KEE=
X-Received: by 2002:a05:6870:326e:b0:404:1ec2:562c with SMTP id
 586e51a60fabf-4154539ed1emr7925689fac.6.1771880857905; 
 Mon, 23 Feb 2026 13:07:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cfed28esm8249805fac.9.2026.02.23.13.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 13:07:37 -0800 (PST)
Date: Mon, 23 Feb 2026 15:07:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Jeffrey Yu <jeyu@issi.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Mutya, Havish" <havish.mutya@amd.com>,
 Ron Kalakuntla <rkalakun@issi.com>, Ji-Ho Kim <jhkim@issi.com>,
 Johnny Chien <jchien@issi.com>, Anand Bagchi <abagchi@issi.com>
Subject: Re: [PATCH] mtd: spi-nor: ids: add ISSI IS25LP*J/*MJ/*E and
 IS25WP*J/*MJ device IDs
Message-ID: <20260223210735.GL3233182@bill-the-cat>
References: <PH7PR19MB7361D02E5CEC8F26BF50ECECB677A@PH7PR19MB7361.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="of8AgPaeWtpz+NTS"
Content-Disposition: inline
In-Reply-To: <PH7PR19MB7361D02E5CEC8F26BF50ECECB677A@PH7PR19MB7361.namprd19.prod.outlook.com>
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


--of8AgPaeWtpz+NTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 08:59:24PM +0000, Jeffrey Yu wrote:

> Add JEDEC ID table entries for additional ISSI SPI-NOR devices.
>=20
> These parts previously not yet supported.=20
> With these entries, U-Boot can match the device by JEDEC ID=20
> and use the existing ISSI SPI-NOR device handling.
>=20
> Newly added devices include:
>   - IS25LP512MJ  (JEDEC 0x9d6020)
>     https://www.issi.com/WW/pdf/25LP-WP512MJ.pdf
>   - IS25WP512MJ  (JEDEC 0x9d7020)
>     https://www.issi.com/WW/pdf/25LP-WP512MJ.pdf
>   - IS25LP010E   (JEDEC 0x9d4011)
>     https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf
>   - IS25LP020E   (JEDEC 0x9d4012)
>     https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf
>   - IS25LP040E   (JEDEC 0x9d4013)
>     https://www.issi.com/WW/pdf/25LP-WP040E-020E-010E-512E-025E.pdf
>   - IS25LP01GJ   (JEDEC 0x9d6021)
>     https://www.issi.com/WW/pdf/25LP-WP01GJ.pdf
>   - IS25LP02GG   (JEDEC 0x9d6022)
>     https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
>   - IS25LP02GJ   (JEDEC 0x9d6022)
>     https://www.issi.com/WW/pdf/25LP-WP02GJ.pdf
>   - IS25WP01GG   (JEDEC 0x9d7021)
>     https://www.issi.com/WW/pdf/25LP-WP01GG.pdf
>   - IS25WP01GJ   (JEDEC 0x9d7021)
>     https://www.issi.com/WW/pdf/25LP-WP01GJ.pdf
>   - IS25WJ128F   (JEDEC 0x9d7118)
>     https://www.issi.com/WW/pdf/25WJ128F.pdf
>   - IS25WP02GG   (JEDEC 0x9d7022)
>     https://www.issi.com/WW/pdf/25LP-WP02GG.pdf
>   - IS25WP02GJ   (JEDEC 0x9d7022)
>     https://www.issi.com/WW/pdf/25LP-WP02GJ.pdf
>=20
> Signed-off-by: jeffrey yu <jeyu@issi.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

This is much better, thank you.

--=20
Tom

--of8AgPaeWtpz+NTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZzBkwAKCRAr4qD1Cr/k
CqH4AQCDZ0E0W1mDd1/j4Bvkm6G3tNscCdaZVr7mFc7Pql/XEAEA6O5tC5vqsi4l
PsWhZeTffcHo9cGk+AGnyWiWt7RPSgk=
=JrVJ
-----END PGP SIGNATURE-----

--of8AgPaeWtpz+NTS--
