Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356E4E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 18:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473AC8004F;
	Sun, 15 Dec 2024 19:03:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NcebdcVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C34D80050; Sun, 15 Dec 2024 19:03:12 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA3980040
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 19:03:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8f65ef5abso28659936d6.3
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 10:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734285789; x=1734890589; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QjkWNbrMUWyvmm8ie7VU0BnCohCEt9f5qmhtybzo8XI=;
 b=NcebdcVD0hBFKLx2zCv47Q9AezObm92HInHJFS8t1BzuZFb0FtCEjkSGENjG9lhheO
 O1mpC58x8y8Me5gkiofqDbGPYmQqac8ybeimMlDlyhmj/LQla2osqEm//VukgTNXTTyM
 /REqgTyGPxzhd5XxyfSeKutcynIoP0VmDOS6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734285789; x=1734890589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjkWNbrMUWyvmm8ie7VU0BnCohCEt9f5qmhtybzo8XI=;
 b=xPoyvLGF+uImE8+Iqpncsr1O2rlmzrFDq4g6gjQ3UA72ceqIpKA0d1jVBrp0ig62Pr
 dH7o9UZFsmGa2WJLdD/Qv/XF8dFYSiGu574UZt2Mg8fLUkTYCUKWEOhTqjj1rcJaU3Tj
 DB7Lsm49qLVivGyQcdsrFpbrWX6BuFQtuVCNAmaaUcUrR3DXz0xk5/6AOrRv3Wj90FoJ
 3qB0OyfJxhIpv+FFCt3wXZje6TPiiLmIjd2tsL/GkHdkeVCPXA+k3bS43v3ZvHXDg67Z
 1Cxok4OD+BN3q5tMdipj55bjodhv/HfHzUXuvbmsJna3Eh9MwwJb8miKOV3AWqaKbzsB
 8q+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaG/te0vrwxipdffBPWUNQ2DiYg6FonTEb4T7l1IWi+8M3Kc9rVXz51MS8jrvNpnrQaFsxG/k=@lists.denx.de
X-Gm-Message-State: AOJu0Yynol+dBXX+Dr9OiulMitM1BN0wqIOVlc6DjukjSPF0AJ6oQjR6
 hCNq2wJG4UwChfkF+1km3ofl/WJT1jDCOQZ7afOUhg9RINawNUCB9w8xMKjPcmw=
X-Gm-Gg: ASbGnctTW2vtMrkYS1ZRNcXhdIUnFzq+rr4x6fTeU092/X/xkIvZzunTBDk/nrZQgcM
 AwjbERh337wOaQKmULDLcTPySDr2Ev99BRcewySvhJU8yZCFYk/HzgQJ0kSasn+BX771qcFVD1m
 rcBj/3IkdnEr0UOP3A0uEzvSHDk7JMfjibwHZykqNII42EbkAITgBVgG+fcmzXiEO150f9fm9hE
 2EqktNKHme4sXC9Js7KatvscGnE0JUWZpD2pEyOO7I+MhqyiK7mi1tY
X-Google-Smtp-Source: AGHT+IFoczCkoXDMwd1E2vZv4vGK7Qkzt3aiY1cHiZw33QOGc6eczA/Q6ZixIxobMpbXMqYAQ/LS6A==
X-Received: by 2002:a05:6214:1314:b0:6d8:99cf:d2db with SMTP id
 6a1803df08f44-6dc8cad6199mr220114136d6.38.1734285788498; 
 Sun, 15 Dec 2024 10:03:08 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd2840a5sm18700566d6.69.2024.12.15.10.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 10:03:07 -0800 (PST)
Date: Sun, 15 Dec 2024 12:03:04 -0600
From: Tom Rini <trini@konsulko.com>
To: j.ne@posteo.net, Sinan Akman <sinan@writeme.com>
Cc: Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de
Subject: Re: [PATCH 0/4] Misc. PowerPC MPC83xx fixes/cleanups
Message-ID: <20241215180304.GF1505244@bill-the-cat>
References: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P6u17TXWngTTATSC"
Content-Disposition: inline
In-Reply-To: <20241215-mpc83xx-misc-v1-0-8cd6daae4f93@posteo.net>
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


--P6u17TXWngTTATSC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 04:18:12PM +0100, J. Neusch=E4fer via B4 Relay wrot=
e:

> This patchset contains a few small fixes/cleanups for the MPC83xx
> platform.
>=20
> Signed-off-by: J. Neusch=E4fer <j.ne@posteo.net>
> ---
> J. Neusch=E4fer (4):
>       powerpc: mpc83xx: Fix timer value calculation
>       powerpc: mpc83xx: Allow including initreg.h into multiple files
>       powerpc: mpc83xx: Use defined constant for SPCR[TBEN]
>       gpio: mpc8xxx: Preserve pre-init state of outputs
>=20
>  arch/powerpc/cpu/mpc83xx/initreg/initreg.h |  8 ++++----
>  arch/powerpc/cpu/mpc83xx/interrupts.c      |  3 ++-
>  drivers/gpio/mpc8xxx_gpio.c                | 12 +++++++++++-
>  drivers/timer/mpc83xx_timer.c              |  2 +-
>  4 files changed, 18 insertions(+), 7 deletions(-)

Sinan, do you have time to look at these patches by chance?

--=20
Tom

--P6u17TXWngTTATSC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdfGdQACgkQFHw5/5Y0
tyznxAv/Y6CP/3O4fwtF1Xk3TfWqhtf3TCbFqFFAdkFm8lUW7pVLLA79JT+J6pdd
4ra7Nemy/orXGPdn9RyscSi9p/0t81qY2G/6RAaVRv8R/9jxZXmPKLnJjiK/jVSq
JhxMWjsHwQL6EZFufdH/HwAPtfKuEMV9NMtsPmxsB0kPZO3sprBH9IZIV7ekF0zC
3f/2llY22FNHR1z9UkIG46HWIWWqyeyYRySFLg3ivG56af6AK7GjE6XNq4LRUpNC
In7m5gER6wtrFp3aRkAVRLMHgMVREf5FTu4nSbQB69A6faNmoqQZBr5WXG+20bSL
jomRdPrnyPjQfo2OnvJU4il/TngTijq15bQysXFm2cLrf2cigrFMgWAa5jFd6o6W
7vklTb2WggBt6PfIMwQwQTxo/awXoC73zx8TxkTNy+KPM6gmGBQ9+y0Oj0NPI5r/
8V1l8WRt6spToKog3qighzz+Cb/lNAw6GfmSeWyprXRmabk/vw/0d6dyzxLx1hW6
y/TSmY4D
=YMck
-----END PGP SIGNATURE-----

--P6u17TXWngTTATSC--
