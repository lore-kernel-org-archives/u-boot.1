Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A0DC83F2D
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E07288440;
	Thu, 29 Aug 2024 16:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p84GE6Jd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD30A88440; Thu, 29 Aug 2024 16:51:51 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504A988966
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:51:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-456774a0fe7so4060461cf.0
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724943108; x=1725547908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TEVtdAcBGBAR0tz9IAD5XG27JyGkzSthbMLMOkt8Byg=;
 b=p84GE6JdV5+9bsmMsPjonVDhnXoeTyu3h1997zH+KTtuZ6Tmvjxch/kHpXYJacqegU
 VjhlOqZe3FpMkYOKTs0E6WePEllMrXFTzBCayWV4t5JQSk+tY+KUo2wJDSCRbkUbn0vs
 vdtOhkbQQMQwVb6wRVKDrBSr3Vz+s0ggvvyc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724943108; x=1725547908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEVtdAcBGBAR0tz9IAD5XG27JyGkzSthbMLMOkt8Byg=;
 b=IK9CqE1UEbqYZ/UCIQuAEd0/pZXhGHUDLHLL0LcA6onchm/Eo1ID/8rzzwUUsviXW1
 AB7XYS5HkRVT9p7jxZNhFSKTtMVlgOYuk8gezDp6/KaNnrq6QaftMuFnvYPK8Cz03fkI
 UYpZkn7cjYHVHQTT07hYMqGXG2d9SiQsNh2vAzcPg4DHg0vKCQrKkaCsAtzHP0bfc/DI
 A2jnJ7bH2RzrQ8OUKXXLxpZ5F1H6N4LiJnjJ1nl9EXuaFKgLHiSxL9mey24KeiqQCGHi
 22OBLLNrzBJKidEp7SfiI74vtYZzVpOjYYAg8pdvNsNgnnSNjg8HWgyP2MnwUehVPTLs
 UG5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo02ZYyRyKeSv51QAc5QY6LCEf2VeK1Qet9P0soVtFgZNKdkfXK4DGlNhtMHyB2KgBmWtNiPM=@lists.denx.de
X-Gm-Message-State: AOJu0Yy03q2LFDAsa0zZcY3sqzVu9WAxsoffYTEpX1sXKgru10p70GC8
 QM32E59ab1ZDUcZ5XRqIvKCtvYyi8LEmqKsAe+0LXVNVq04/+tFYUuFCt803k0A=
X-Google-Smtp-Source: AGHT+IGKw4CTmojupWm6wXvWPzANVlCvhUIisW71t6h7+fRFdMboSeAxuZCXugJtEaJIlj3296cnkQ==
X-Received: by 2002:a05:622a:578f:b0:44f:e056:fe06 with SMTP id
 d75a77b69052e-4567f5941bcmr33495751cf.36.1724943107975; 
 Thu, 29 Aug 2024 07:51:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682d9592asm5389641cf.83.2024.08.29.07.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 07:51:47 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:51:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Oliver.Gaskell@analog.com
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 u-boot@lists.denx.de, adsp-linux@analog.com,
 Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx boards
Message-ID: <20240829145143.GA2479150@bill-the-cat>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R54pBoCx/59MGJcf"
Content-Disposition: inline
In-Reply-To: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
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


--R54pBoCx/59MGJcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 11:02:08AM +0100, Oliver Gaskell via B4 Relay wrote:
> ADSP-SC5xx is a series of ARM-based DSPs.
> This comprises the armv7 based SC57x, SC58x and SC594 series, and the
> armv8 based SC598.
>=20
> This patch series includes configurations, init code, and minimal DTs
> to enable Analog Devices' evaluation boards for these SoCs to boot
> through SPL and into U-Boot Proper, as well as devicetree schemas for
> the added DTs.
>=20
> This patch series depends on ("arm: Add Analog Devices SC5xx Machine
> Type") (https://lists.denx.de/pipermail/u-boot/2024-April/552043.html)

Since that series has been merged since early May, what is this series
based on top of? It should be based on top of current (or close enough
to not matter) -next. Also, has everything been passed through
checkpatch.pl and the results looked at? Thanks.

--=20
Tom

--R54pBoCx/59MGJcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQivkACgkQFHw5/5Y0
tyzXzwv4nSjqOQZLYHvU3YYveFH2j1Nk6tfMG77JTPXvzc228PxT4tGbyb+4x19/
tAdt8GR+jved/QAK6i7yi7FKdLNwZWV2ytNBHCzIo0asTKayICsWTXc8yLaxtufu
peJTBY5QSc40My9xNn3VyNUTtNUoC1/qesjqTzV01FKCgP+YMs2oEfNQeEJnTrTf
qlLDG7h/mMGHmoP3xprnwb8KqvGKnH3yKyLxfqABDDG+1YqtBApTYqITSOT+gFVL
dk3IlfP9ZJhmLZYsx1e3lXiBvyVHzlhNFY8se5ZuBXTRVCkPknnLtiHdB0pxg2r8
QfggGJH+lYFGiJwcRKgbJTHCrTQtcUC+qJtK6dalq5Nkk+BXTXgQn0EZ6+4Ny/Sv
Y9MP6CrMrncRz3PEbyzCwrKSii6y5vlCjn/bxsq+OlMIidHUMINOeKxViGU9r99N
DAlbdCJfqyUkQit2Fv2F2zfG0DISd8RnWUIOFoe21CCx3qf6MT/6iZZCIDnbeDBj
a/VXf48=
=3qPv
-----END PGP SIGNATURE-----

--R54pBoCx/59MGJcf--
