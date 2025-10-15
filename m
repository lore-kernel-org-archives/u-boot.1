Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04112CCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 22:18:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89EDB8323A;
	Thu, 16 Oct 2025 00:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kGHx7mA0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4CE5835A2; Thu, 16 Oct 2025 00:17:58 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678348312A
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 00:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7bc626c5461so27973a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 15:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760566675; x=1761171475; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jyPOwjL5ImRyNugPq7MuNjy8PYa4Hk9qfnQyG8uhmuo=;
 b=kGHx7mA0OtaYI/vdpbjo5r2NFKgZlwc9dtx180QW5/cS8OQszeHOPpfsv7btNGj/id
 GbYtTGudB65IN8EWICl0Tjas9ATh2caehzIJj2kEncjle80wXs9Ym9dGBv4nwfqBF7+6
 tLcwNNUaC4kv9lhh2tUH1DnVuT5iRaiDsbYg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566675; x=1761171475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyPOwjL5ImRyNugPq7MuNjy8PYa4Hk9qfnQyG8uhmuo=;
 b=nCT8lxkp6XsIgKzip0OWoQjl1WnQPMMzp+uxMz7/aPK6gd88E5B8njQLpPu7lO3yqu
 jwoduDjeN7iMjpiNzEPT1mbKB+rj8EVWjlPFHTlRmbcWm7UN6y9TeZVtAnteW3BJG3g3
 j/d560Cf2YgwWSDcxyik91DQQHkWv9JTYVGuzis/03Gk0DMZovs/UQFXsMl74OUrWkyR
 9phgEw73X7jbQJDTHJi8TRkAE0h64iIxie3ZmPLY7eo3ZXq+OFyevbXZKdRr4rwcUehE
 6HyB4i2Al2TmCZ7MwELHFZgWPsZZhmY9qOjv3PTQmW3YKmxwlJX37bRF/xtgdP5jWA8f
 IhUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Md/aRalJ3u9tW90ZZvxqeP+Hk2I4vgcvDRTw5O9/rrnd4ELDlfgKpvwKTG0Mgft5d2IyoVg=@lists.denx.de
X-Gm-Message-State: AOJu0YxhEYaJBAk1MB2ZG6nnVL6G5NWCCvEDV8TPbBqoJNh+fhY45fCv
 fG+3qhaoexEolzKC6SgtdTv0pi4kmQr/ikiUtaE07b9S5aqFQlyEcgsVZHGYZETAtPc=
X-Gm-Gg: ASbGnctlM1MICvwZYFVrEtHxLQ9ROnl32N3ZYXmnz0NZEkOZZKFACg8ingyEtKUXwFU
 9arRn23+LxpWvaOvJxXf5Vea9LJt3vpKIsrWoA2eBMEQLVEWOP0oYMuDB0SKGYHFZyVhwxMlLDi
 2iWT4X8WM38aMpkJ/FSETQJKHDKyPQ9vbqbsIbbz3+ExXb0DAo4wVObkfZzWyK72adIvmVybhAh
 B72iwfTMHDnhDxdeA7TbuDGzg3p1tFxzGAeLMZvqRJmnbnQZzNnZd+Nyq2XwKI77K2ASWQ632Jl
 m7LFVyijRZDQBZJtpnb08iqvk5vv9vJpjyWXFSKWsqxbRrhScy7ci3fCcqqSohEKJ+Uiyez72Rc
 XdeQTYWwtHMUzpdqWxJR/5fKlcKXS5ZaMR12KzsTMw+bcGKKd3UZTpoCyuRqzMJHyCr3CdCuF99
 Ms6tCdhqpcUe6t3kpbLE58mBfnqWl4Y2TIxQDB2To=
X-Google-Smtp-Source: AGHT+IEdJjEmsy2FKB23zm74dbYhHAE2G4ZA34tFizW8GYhkv2BL/9TtQK93JgkvTQrn4e953E8f8g==
X-Received: by 2002:a05:6830:71a4:b0:7bf:75e6:5ba with SMTP id
 46e09a7af769-7c0df785687mr17123548a34.15.1760566675105; 
 Wed, 15 Oct 2025 15:17:55 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f8f18f29sm5755038a34.0.2025.10.15.15.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:17:54 -0700 (PDT)
Date: Wed, 15 Oct 2025 16:17:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v1 2/2] spi: Enable Kconfig and Makefile for xSPI
Message-ID: <20251015221752.GV6113@bill-the-cat>
References: <20251014101354.11182-1-boon.khai.ng@altera.com>
 <20251014101354.11182-3-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JBZJTNERjrui/5v7"
Content-Disposition: inline
In-Reply-To: <20251014101354.11182-3-boon.khai.ng@altera.com>
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


--JBZJTNERjrui/5v7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 06:13:54PM +0800, Boon Khai Ng wrote:

> Enabling the kconfig option for xSPI.
>=20
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/spi/Kconfig  | 15 +++++++++++++++
>  drivers/spi/Makefile |  1 +
>  2 files changed, 16 insertions(+)

This should be part of the first patch (and then the cover letter can be
follow the '---' if you like, or retained).

--=20
Tom

--JBZJTNERjrui/5v7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPAdjwAKCRAr4qD1Cr/k
CkHTAQCM9S6pspG1GKBDB8AyQHzGw79mgMhabpMarfYjaXifjAEAolHhcMBF+IQX
Trhg3c4a+iVK7MsnxQrgIx7/b88bMwU=
=Ga31
-----END PGP SIGNATURE-----

--JBZJTNERjrui/5v7--
