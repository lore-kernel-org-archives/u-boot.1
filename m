Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A538C3ABA9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 16:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650398215F;
	Wed, 30 Apr 2025 18:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j9KoOzkF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2179D82BD7; Wed, 30 Apr 2025 18:02:30 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 774E780079
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3f8d2f8d890so59451b6e.0
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746028946; x=1746633746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Jml9r0kM6IkqM+5OzvcHMGgu12f/pBvuUWcyYJiEq8w=;
 b=j9KoOzkF04cL8Xo0zXAt4n+t1q8l72pmrfTSSBAzJuMmX6jfcEXj8RdzII7LmmqRkG
 95evmQJrBD/FV6qV0ix+xrWKcz1V0L3oqpRIB59Q1Y8kMWs8nhQW64djXS2TM8CRJyXH
 AxEaPPG+Lx1j00uLwYxQaWD2T1fe77FQC0AI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746028946; x=1746633746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jml9r0kM6IkqM+5OzvcHMGgu12f/pBvuUWcyYJiEq8w=;
 b=o8j/hCAHNJbPLSdd9z72l7CqyqC8HfUFB6bhcXZL6iia4W8XnR0ut4sgZCTx5e+Zs8
 XvEQfBKc89G73grlwfK3+PG8iyFTCrT2ZTuJC35WzXjzbLdAwN6dBc0D1yTqvY2Bf5LD
 oxwge1tb2hGtnQYHWSoyfRDENLw/ykiOmYIALulPi4/tqDy7SDGLbtMollJqMVilnsUE
 Sb9pExImsurFvq1IXLf5hWYeF5EDFCeafCotcNTEmVuznHgjvZjB6QW4lSxt7QbynAS4
 XvjYDwLCxs7t8iWBbHkt0HIczFlGvLidbvvF7P674QHQ/xLP8UdxMDwzxvZhSPQVMkGY
 7DiQ==
X-Gm-Message-State: AOJu0YxpfUzcDZmXt0FKVJJyXREvFM4l1PGkUT4+D2qx6Fq8qu27vNP6
 Ap0dYhbcHyHFawabFr4jcb/Ombgw6FYsHcHBwe7zvznIki4JOO86sZGzskTQQRY=
X-Gm-Gg: ASbGnctXTyCI5HHozNElPLZUQyFqpxI9F5bqXupD7b/8Xuo30S5G7OynlAxBPJQtKGM
 lMXeHbklQL8WQr3xDcW1S7FNtGlwcZHEqRS3UgC0S54Lv2EDpASg1OUbITF98hAm3k9mjWPdSv4
 NDqZQmW+SdEntLnMDHd/5zXPd/bEGGlflzR9dbo56wPjDlGejms8RYwXs5s+htJnUZ+aXhY5dh9
 kOV4dnYzkzGyZBDR6lY6mvO8nr4DZIXHOSW9FxQJ1THktXA4VBQBM9ZSKAK+yiYla/tCi4sC+MJ
 UvQ052q8R8iI2F/rfpmJ9D9rCWiqmu84yHAyvf5flbUzEWUErG3hUbC2FyMUXU0ebqZ2LwmqvRv
 kxQ==
X-Google-Smtp-Source: AGHT+IEMany7vqKZAH21dqtSLf7daKUkHrrYOnWsmX/IYXbnjJpVakauaFFvWKmhEqcc+2BQ7jYH4g==
X-Received: by 2002:a05:6808:4481:b0:401:ea47:2c4a with SMTP id
 5614622812f47-402d24eb4eamr2275741b6e.28.1746028946203; 
 Wed, 30 Apr 2025 09:02:26 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40212c4de7csm867985b6e.50.2025.04.30.09.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 09:02:25 -0700 (PDT)
Date: Wed, 30 Apr 2025 10:02:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
Message-ID: <20250430160223.GU1261075@bill-the-cat>
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430141657.GO1261075@bill-the-cat>
 <D9K3I0TAUJ5J.14MKHV437D997@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GzY2xQmP8BFJfQFW"
Content-Disposition: inline
In-Reply-To: <D9K3I0TAUJ5J.14MKHV437D997@ti.com>
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


--GzY2xQmP8BFJfQFW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 09:27:30PM +0530, Anshul Dalal wrote:
> On Wed Apr 30, 2025 at 7:46 PM IST, Tom Rini wrote:
> > On Wed, Apr 30, 2025 at 07:27:50PM +0530, Anshul Dalal wrote:
> >
> >> As discussed here[1], the go command causes undefined behavior when us=
ed
> >> for running custom OSes since the icache might hold outdated data. OSes
> >> usually also expect the MMU to be disabled upon execution.
> >>=20
> >> Therefore this patch adds a call to cleanup_before_linux before we jump
> >> to the loaded program/os which disables both the caches and the MMU.
> >> This makes the go command's behavior consistent with riscv platforms.
> >>=20
> >> NOTE: This might cause regressions with users expecting a configured M=
MU
> >> but I'm unsure if it's a supported use case for the go command anyway.
> >>=20
> >> [1]: https://lore.kernel.org/u-boot/D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com/
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >
> > This is the inverse of what needs to be done, sorry. RISC-V shouldn't be
> > doing this type of cleanup. I know it sounds reductive but "go means
> > go". We have all of the other bootX commands for "prepare the system and
> > boot the thing at $address".
>=20
> Well, "go means go" implies we jump to the necessary DDR address and
> start executing. But with caches enabled, it fails in cases where we
> have that specific address in the icache already. In that case the
> execution starts from whatever's stored in the icache and not really
> DDR.

Yes, and if you're using go you're supposed to disable the cache and
force a flush. Or you're doing something Interesting and nothing else
should be getting in the way.

--=20
Tom

--GzY2xQmP8BFJfQFW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgSSYUACgkQFHw5/5Y0
tyyP2Qv9HBGy7AHa8m1Ug/XqDcmy3VVeswuzkCpdrvLkh3FaXhhzwwvcqMRC/NkY
fg6/qfvOmINQ4JayyzBbyESfDTjSd9IW87fb//W1gF0rZCMlhjA8wXhALsV+l/nB
ttxJTJ50xVfMQzZweP/RWMTEUDctg+9GNAjAk5NxWeCRIaQuuHGfVQB59Htq7oJx
q8NVuHTLf9rCXMv3aXmQ25UXJxG/WkNF2yNRDh1Zgay6b0tgUlFqz2Vz2HAYLOli
5H55JR2Ech6qnISnYht4D62ciuPy0GC6X3o3jAFf4h+/R70IEvLCIZeFBIMKla38
8EoNkY3Fq9aX8FIh01iJy8vQ1l5avXhhhn5fH2zUpucXsxvHpEiwgpN4ok0rsD4y
eaPcvPBxkugxgcw8T8Am0eSFauIcgU35BPcfzP/2B0MXXfivtH0SlgoEiidB93lh
Tme3WJiE1h7lVHikQaJKVy4Fjrd2WdIlFzyfoFIQAJ2FYyctrs8RHLvpyDrvOf60
v6DQ+9K2
=CcUX
-----END PGP SIGNATURE-----

--GzY2xQmP8BFJfQFW--
