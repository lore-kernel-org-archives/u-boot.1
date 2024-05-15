Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23348C25B77
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 16:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A7788276;
	Wed, 15 May 2024 18:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="npsnkgv3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB928717A; Wed, 15 May 2024 18:00:22 +0200 (CEST)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com
 [IPv6:2607:f8b0:4864:20::e30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57FC5882AD
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 18:00:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-47efcb120feso2108772137.2
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715788818; x=1716393618; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hOBJ9XZGsThFGoxQ2QY4RsCb+KK29vNoQb1yoIhOhRI=;
 b=npsnkgv3fhsVVquxAySyouYRSNg2m99t2PaWZ8BzpO82YDc2MmYdkW4mFcA8RTWijv
 AKvPAZQq0LotbMtw+n6JDK5cYcScanKsXn2doF1sMYq5qPXY3atpG/RL3xGcPC+INils
 4JCVy4XE1/SvAJzkLXb9HbW6+bsHNICNCD+gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715788818; x=1716393618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hOBJ9XZGsThFGoxQ2QY4RsCb+KK29vNoQb1yoIhOhRI=;
 b=Dv4gHJVlMBtn2q7jMwLzH5gtXioaVChz2JN8hGrPSnae5x8TLAIis4xqKsVsCXYhpR
 l0SjG5U5fZbHsOGqX7QtKtHvyd5FzyVNo/bCw6M/i/cuBhv/nhS5SSF+Xpb9QAtVrZ/7
 gEVQfUF5h3U2kIv3BEalBhTHvOGK2nJ5cTlO3dc09bVmNGdr30pz+5y6MIgYShbmYx1P
 lcwLcQCkI4lrhhElcD0k0rhG1so1qWnRHToRwiQpE29O08XwUyW4uOfiRcTyWpSgBO3J
 EwWBQHzg4wGzKl1dvRYITviFaP2xW9mkGJHTpe0lXlo7MpLNGzxsQcogO0xwFsJi1zQN
 FbNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIw+icRX38ex5CCh2wja7Mtw3/KapoQprdx4mRcx9dY/4W+D9WoXIb7pLyzkjZFeTZX9llg1klXns6NRJK4Ln1fusNCw==
X-Gm-Message-State: AOJu0Yw/Gia5Qc6HTg+rSBTyk2hiYYYIeA6BA0Ss5xztpxmifnm8U/Ju
 t+p4wjGTr5TidivqhdDiHqwTOs0mltcmeX8NYgApgA1Yh4J8/vSmgeHb7K2HsRM=
X-Google-Smtp-Source: AGHT+IHUBMMd2ZzQUZbAcSByTJgPp3Nu3i5U9BA1ZOv6Krb/v8VRhHzGicZBO8ckWZTK5fZgC+MgcQ==
X-Received: by 2002:a05:6102:3707:b0:47c:24fa:b627 with SMTP id
 ada2fe7eead31-48077de52e5mr17453969137.13.1715788813854; 
 Wed, 15 May 2024 09:00:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1cccf3sm65485606d6.86.2024.05.15.09.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 09:00:13 -0700 (PDT)
Date: Wed, 15 May 2024 10:00:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] Squashed 'dts/upstream/' changes from
 b35b9bd1d4ee..7e08733c96c8
Message-ID: <20240515160009.GX2568172@bill-the-cat>
References: <20240514164236.516595-1-trini@konsulko.com>
 <b12a9b07-2c92-4651-b6ba-3aff6ecc9219@kwiboo.se>
 <CAFA6WYPsicMrtrDg7T8m=4-vg-QAPUY1D5E=_T8gZYgT=o2b4Q@mail.gmail.com>
 <e26ab5cc-2b2d-4e96-a073-819a935f435a@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dZeKgwQat2S3DS5q"
Content-Disposition: inline
In-Reply-To: <e26ab5cc-2b2d-4e96-a073-819a935f435a@kwiboo.se>
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


--dZeKgwQat2S3DS5q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:39:08AM +0200, Jonas Karlman wrote:

[snip]
> My main concern is how to best handle new boards and features/drivers.
> E.g. for Rockchip the RK3588 SoC is under active development, new boards
> and features/drivers are actively added/fixed in upstream Linux.

To this question specifically, dts/update-dts-subtree.sh has a "pick"
option and in some previous quick testing, it does what one would hope.
So for this case you could pick the N commits that need to be brought
it, the resulting patch would be small enough to send to the list
normally (the resync patch for v6.9 is 2.7MB) and then when I do the
next full resync it goes cleanly still.

--=20
Tom

--dZeKgwQat2S3DS5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZE3AkACgkQFHw5/5Y0
tyy7jQwAs0wzUAAL8rqaPx01qHBdeXzA+OCoOwA7gL6e0hoFKIoBOffZX5Xe1511
jZpzoHNrhw6RaTILo+2zPYNOGRvcJAW8dGr5XU8Xwz5VhNhdw8U83H+bjfr2Lan2
2vKVBTe+WrJLupRDR0L5zdkRIV0ipxbYavMeI8pCWGLKrjAzHk9mhwVnv+Q1pySa
azAzTMvHlQdRhZerBZ0eCJBg2c8tM7GmLGfI9o/LgTuwlaIFKs5qJ0ULFNHEz/cc
bW0nqpLIPH2vjUwtKqIu49hs6t+BuRvZK1mHzDWuT9AJQMAn3LXNHWZvxdkAxvYJ
Cg7/5+AgX9ppZrOZDCRPXfgu9bpUE7kyBRUfdbFJ8PuNeFd7dMTEQyGMnsbEB7At
EAk0OGALhYzorZjMC3oqPSZS/dFrAojRXnatmxrtZsQz/dzKcZddj9GHvHQ7Jxfg
3QUfUOUt2+2j0Z0r/pArR+TJtmRhbwhx9iYcNPhxsv4+LbH5R7p79jh8lONsoBqL
eCHpsG2z
=dTkl
-----END PGP SIGNATURE-----

--dZeKgwQat2S3DS5q--
