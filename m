Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BFBC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 21:54:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF2D8869E;
	Thu, 22 Aug 2024 23:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BNd3v1OH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D23E88651; Thu, 22 Aug 2024 23:54:35 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 102BA887BB
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 23:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-70942ebcc29so1118062a34.0
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724363672; x=1724968472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fMxXa6El06A9s/GDO+DYWPRHG2rnq6H1Os0cTBlJUfo=;
 b=BNd3v1OHxioFxzp2OHnjf/1higeWsyRdzPOvn/gqQswTsEDCos/TSQ9puH9k7lYD+l
 cWpyERwlk+AYC3gTXkv7he8gYDyB1rxZBgZVbd1S+ePsg+sQRmy2JT9Mj6bl8NNA8UZp
 wFwbVF/BGDyt9T0BinJe78spq6cqsl73R/BlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724363672; x=1724968472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMxXa6El06A9s/GDO+DYWPRHG2rnq6H1Os0cTBlJUfo=;
 b=cfV8A/vjjs9c/n15MJQJ4qENLFrc0dedlcRQcfqplPyLJRp1DbP4ogVQpBKwHlSmPM
 0qX2w17irHw3/rEMEVVCaLKV4TmCrBG0LIj+zi9u7t3MbjoGcjV9Lw+lEhvkF95rU0x5
 ki9zpd6rlXnlklYsSdcxtvVUqNyJLbDZcIkGaCMnI6xQpJ7CjmTqvWkjwqiy1RdzGGBT
 CS7BDd5W4HF7WLcv0EO5p9DegPJeZyB2+VGZqeoU+TGb8meF1p12/2Fd6DQKC1/W22Io
 xrKuw409k6T5d7fyoJd0hpa+cJtmvVx4mNqUtz2s0Buv8D92iKkbDtCT5raO1uZTGbHH
 D3+A==
X-Gm-Message-State: AOJu0Yx2hr9rQ+ykn2BIVx52W841SDkGCVPyuXthcu6zJeYgOyv61/8r
 l7kuOTqOVHqClkla/gqpGURx8/hIEQm6p4Jm2Rnn7Qe+Q4R+xttuVwLBB0AtU4Q=
X-Google-Smtp-Source: AGHT+IHve3IrucJxpD+5jbw5jbL91cUdJ7eP7eJM3OdAmq9olMlChbi6/7TOYGjsPJRo5OI2vRUlpQ==
X-Received: by 2002:a05:6808:f01:b0:3d9:2a77:b81b with SMTP id
 5614622812f47-3de2a8ed647mr233816b6e.34.1724363671782; 
 Thu, 22 Aug 2024 14:54:31 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-236.totalplay.net.
 [187.190.197.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3de2252d574sm451725b6e.6.2024.08.22.14.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 14:54:31 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:54:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240822215429.GX1626301@bill-the-cat>
References: <CGME20240822102010epcas1p434e5a447b002e8bdea5423a034c2e444@epcas1p4.samsung.com>
 <118b01daf47c$de3b9620$9ab2c260$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CLqKMucdE+T9UFBs"
Content-Disposition: inline
In-Reply-To: <118b01daf47c$de3b9620$9ab2c260$@samsung.com>
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


--CLqKMucdE+T9UFBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 07:20:10PM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit d51764417dc37ead471a5597f7815ae455e84e=
a3:
>=20
>   am335x_hs_evm_spi_defconfig: Add MAINTAINERS entry (2024-08-15 16:07:45
> -0600)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 25a972368cf926b4d70c22a2de65d959774d5cc5:
>=20
>   doc: samsung: Mention enabled eMMC in E850-96 board doc (2024-08-19
> 16:09:06 +0900)
>=20

Given the point in the release cycle, I've applied to u-boot/next
instead, thanks.

--=20
Tom

--CLqKMucdE+T9UFBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbHs5UACgkQFHw5/5Y0
tywxlgv/TwMQo1smkSuZq3ZXh++n5udjLVvJ5IRkFRUyfHkz5dcN6jgr02Ix84a9
zulE7o575XFFbzOY6Qb9tbXWviBBdQnNF7rEL4aOX0bl1Fc5QEJj5bdKDgcB4UoG
ELly0KDOSK7PBe28Mr52HLQRfp7x8o1LvHpToqxF1DWyFz2qCyXfS/nMl5ZJgV+E
n2qbysmJDsqbAWPuZDINZ4ubVsf72LQBaIiTxHzM5tiOS1Rr7QfDA6WC/vkKKXLH
/4vvxpOVrF9kWtBqScrmSx2dtDgdt0qYUwLpxlfd9f6TLBv5y0H8mcfO9d9jCvMb
mZkgzwyyIY1koosscvTpNGHNDwQ7GqRUow0mlR/2+nnEIL2WowsTeLVop+uIsA5M
A99KSlSCnmqqGmiA0JIOcmkwqa79fZX9NsHjkeqoRK2F41p1kAv81HX88wd0Rz+2
tIIFfj2OxUcQwU6EaaxMV/nl8Uo2HNkyJ+5YQ/2TjPmh1AECqaZc8Q1diY4wFzTZ
8aIK9Llv
=YOqb
-----END PGP SIGNATURE-----

--CLqKMucdE+T9UFBs--
