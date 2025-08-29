Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC08CA0FF0
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 19:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C51DE83526;
	Fri, 29 Aug 2025 21:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FrlWJb9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7763D83642; Fri, 29 Aug 2025 21:18:36 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535EE83487
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 21:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-61e1c0229b3so502158eaf.3
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756495113; x=1757099913; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ie+FKWUHoP5jenlxdzNnqnBmW8VAUjiTp1ekfZf3cMU=;
 b=FrlWJb9KrI0Pfwis62S3jPdB14yrWvpIeO/Ie2D+uGYfmFzxsCMC86zs5LwqghbCfT
 VnnZJuxcVGAC465Wys27sWO49efuGvPDq6O0IeFA+wXm2Cn2MpKXW2ZiBJHqVy2Q/DNe
 nNjE22+E2VJAmrSYjB524E+SP94Gw7/HrVi5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756495113; x=1757099913;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ie+FKWUHoP5jenlxdzNnqnBmW8VAUjiTp1ekfZf3cMU=;
 b=rQ4kwDzrR731TE5ZnVj2v+nDbyQ1bAniaNSC0k5P8kr39FI73Zfc59xXB20vM5wbYQ
 Bvq2cefAaomIMNTuYxo4S51xK1CNzfvLgtI6JGoayVEhti/AFNakZZ1Dr00tWN1TzWv3
 LvtFKjqadRXavnvmztV/PkNBEU/A/MmCgMnZPrCltwCvyZgFh+9K2PWhdHK/l+OohEJ8
 4gLpHo5CqAqrYNjSWv+uDVHEwHkFl4J65QVunAdRLZKf/H7r1XAjKnsV2zAlhJ/z/5nU
 Eh/4n8CiQXR8mi2CdBvlgUAyoJEWH3kS1cjwEWesWr/giofo6dmGnv60v4Z68pmbMZVY
 QQCQ==
X-Gm-Message-State: AOJu0YytyuNICgGvZqicbXcb50uif9Am0OPAoJgf0pg1PtDlp2eBGSv9
 sNS7L844X4m+EIs3wQzgCr2ZZnImnx68r8ViIrFSF+OSqBGBWq2gfIHCm7Z5pK93igx024H1POM
 n3v5GggE=
X-Gm-Gg: ASbGncv+0BMFvojT7wvj5C+66jr+AzTPsLwomgZDbkUp3NOIFzsxFftRrX28+cmqBfU
 w/5H6VESRIk5+MgQMVl5gC91PX9Of74TkZGrcsUnO+BgsGuyqcNvUkTL2YphhqxsGPvnCVHYat9
 Tr0cQPUoaA0OJGEZz2RpBCbrfLReO3Opmw+2iid/8Za4YZPgFjAVypV+5LxuwNhY7V78xUKelKR
 5revt50zhMSerraufLtRLdWnaaAcVkWFH8U08R6bjfZFcCMRdNTlhkcoVM9hDGyh2RWPchZQK79
 0eu7zPmWu6/tCf6QJWTgLUn+h6/xMtAiVzCLukb2R59vYM51hiV1cIivG19spwHRyPIk9BlmGKs
 SVEcbCr03394AeqPTvpc5kVMy8ewOHcCEG43mCvQCQIti4dEq6WeCYgF7
X-Google-Smtp-Source: AGHT+IH/fXwjXFxQ1GwFmCj0AlsSxkoFrBMAwHFIJHdHDZTXBtxFdMqdqHW+k3zWkMtt/BEfRV3TCQ==
X-Received: by 2002:a05:6820:221f:b0:61e:2be3:97bb with SMTP id
 006d021491bc7-61e2be3a2f7mr794172eaf.5.1756495112988; 
 Fri, 29 Aug 2025 12:18:32 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61e3206cb40sm13088eaf.12.2025.08.29.12.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 12:18:32 -0700 (PDT)
Date: Fri, 29 Aug 2025 13:18:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Falcon on bb-black: SPL jumps to 'u-boot.img', although 'args'
 file exists.
Message-ID: <20250829191830.GZ124814@bill-the-cat>
References: <CAJE-K+AQucBKAUODYnw1xQkOKcXU17VgDVrGtzOEjTRtSTsmaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6rjrpugf+sJte5Xx"
Content-Disposition: inline
In-Reply-To: <CAJE-K+AQucBKAUODYnw1xQkOKcXU17VgDVrGtzOEjTRtSTsmaw@mail.gmail.com>
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


--6rjrpugf+sJte5Xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:16:57PM +0530, Sidharth Seela wrote:

> Greetings Tom,
> Requesting a tiny help.
> A have read u-boots documentation on FALCON, and also consulted
> doc/board/ti/am335x_evm.rst and some examples from bootlin doc on falcon[=
1].
>=20
> I am unable to understand why falcon_image_file and
> falcon_args_file are not being loaded, I have boot_os=3Dyes. I have follo=
wed the
> FAT SD cards section of your Documentation, yet I am finding that SPL is
> loading u-boot.img from SD-card.

It's been quite a while since anyone took this specific path, yes.
You'll likely need to instrument things with some printf statements to
see what's going on, and then patches to code or documentation once
you've got this working would be much appreciated.

--=20
Tom

--6rjrpugf+sJte5Xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaLH9AgAKCRAr4qD1Cr/k
CjblAQDon5Iy4D8sb/4inH4+CT7liDvnnzEjv3o8N2RBwfykBQD/QMdvpJrDGgBc
PF4eFanymtc8eGHzaGf1OON8GpzaDgs=
=0y3M
-----END PGP SIGNATURE-----

--6rjrpugf+sJte5Xx--
