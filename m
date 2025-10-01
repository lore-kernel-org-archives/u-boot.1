Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E25A4CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 18:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 499BF81D6A;
	Wed,  1 Oct 2025 20:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gvYX4D5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5421C8328F; Wed,  1 Oct 2025 20:33:47 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D36DB800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 20:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30cceb749d7so125503fac.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759343623; x=1759948423; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oEO5HVM1EqSsVr0geomh500Iogj9E/LbDIiQQRZVtoI=;
 b=gvYX4D5liYvckkztWn8xjQXHSjkrLzVZFLBmyIKb5uWv7P1L3jkPXHAYIalqUj7n7E
 L7CIPoiqDjB7nTE3etYL5m++Y6379F3wjjYZJxfHSGQqr52WmRJ8AzLHTREQf6rmv+a7
 EUzCvVElR/01xVZ9f7ZiknKHlVcCTJi3oZqD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759343623; x=1759948423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oEO5HVM1EqSsVr0geomh500Iogj9E/LbDIiQQRZVtoI=;
 b=OxJ9nZvKIGUz9ft7i1Ed3phiqnT3EEQANwGiJsVLxfpwc5QDuH+5l05FQ0a7SBi9IR
 yjDTIGP4mOHYpry7+mqw94ngmM3BFSaH0EmRPG9aItqd9G12g6/u+0CabA4l8kHDA6ja
 0Lrigl/VE5OPRpeUVOZxlTPhKr5pWs3yjFldH4NuXpYbYjOmybcIiqbsDlmu29LCTkkT
 WOe79G23UlgmrL+4t52pNZxgkfsw7WP+xPCbfAn1k5yJy+CYWZP/FUgs4M9QAHhtR9pf
 /txfCgHhOWoRcDPsy55D+3bQymcQ01ApDjeapl5FHpo9cV6+gL5FdXFYNj6Eu+keHWoc
 jD5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSn2xNTy2fAg8VB+thLA188y45Iv5mtCcS1AchqqxtpZAIA4Qm/uaWhE5y5bN2gFVeG8GBaF0=@lists.denx.de
X-Gm-Message-State: AOJu0YxpPM3fJ3OwO84Z5pN5VcvoSHx8PPLkwmlef8WBfAlFmDQp+HWv
 fLs98bqLLTRicTyhWmepRifHjymzDdQP+FlSAQXtj5nI/pNlU4vWiVj50Nmxa59mgpGgUhnakax
 kxWCuR6E=
X-Gm-Gg: ASbGncuBVMU/VSbBSYHEQLUrsbP5Nmb8/Q+z9S1rWNRmp4Lr4Z6rRs8oxJXu839Ii4m
 TOoMXV/Y938qrKKkvGCRkErf5V2bdsM+bJz1cFAbToRSzDDDx94ogCCvaVxowAaKUrGmb87+3zK
 JRNxtovw+3ymDutnS1CU0qjeS5r9wOL8xPDHN8Qfu3M+OtoEl6lrjPaiBuS3k+xuMoUX1DiGI81
 iDt8IwONo3Q2tCvIr7ip9NgdTeBgXBDMu1V6PNRbjekXQlfUqj4jcgh1dZHTj1zcFx5udP/h62X
 T5IjgCyFGevlipTIdSKcaFuVYNC5nQ5sbWX5THdb+9nILbyaV0oHPiY96o8fMW/9OsLCHcStyPv
 lAHmZ9Ezkni52TogLPtgAwS0X7tEpgHCzrHmIRfFWiHzX7IxW2LR3NIPPco9tPyUryFYoGOmZIH
 js/lpJ
X-Google-Smtp-Source: AGHT+IFtTcdJ6zbYX1m23vUuqm4taV9nA0ZPTqIWSWSNEhJuoTIsEDInh/uyRLvg0BXv8oy3F+/DGQ==
X-Received: by 2002:a05:6870:312:b0:35e:59ce:6c39 with SMTP id
 586e51a60fabf-39b91a79566mr2360512fac.8.1759343623488; 
 Wed, 01 Oct 2025 11:33:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e1b7a87d2sm38706eaf.11.2025.10.01.11.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 11:33:42 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:33:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] b4-config: Improve b4 config for correct operation
Message-ID: <20251001183340.GK6093@bill-the-cat>
References: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O6GGy70NmVQetPiM"
Content-Disposition: inline
In-Reply-To: <20251001-fix_b4-v1-1-fc515dec0546@linaro.org>
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


--O6GGy70NmVQetPiM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 01, 2025 at 10:28:37AM +0100, Andrew Goodbody wrote:

> The recent change to .b4-config resulted in some expected recipients not
> being added to the address lists. Rework the commands so that all
> expected recipients are added while maintaining the ordering from the
> first change.
>=20
> Fixes: 26efc940c86 ("b4-config: configure `b4` for U-Boot")
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  .b4-config | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/.b4-config b/.b4-config
> index 6ba10cf9b50e6acb8a789544d35a13641e6c0411..1f9ada793e652c99854e4d152=
41734c9b3bfc117 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -2,6 +2,5 @@
>  # See https://b4.docs.kernel.org/en/latest/config.html
> =20
>  [b4]
> -    send-series-to =3D u-boot@lists.denx.de
> -    send-auto-to-cmd =3D echo ""
> -    send-auto-cc-cmd =3D scripts/get_maintainer.pl
> +    send-auto-to-cmd =3D scripts/get_maintainer.pl --nogit --nogit-fallb=
ack --nogit-chief-penguins --norolestats --nom
> +    send-auto-cc-cmd =3D scripts/get_maintainer.pl --nogit-fallback --no=
git-chief-penguins --norolestats --nol

Ah, oops. I thought it would just default to our .get_maintainer.conf
defaults, but I think those aren't quite right either at this point.
Thanks!

--=20
Tom

--O6GGy70NmVQetPiM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN10AQAKCRAr4qD1Cr/k
CosQAP90CBH8sVZ5hoi1lr++Lcyh3T6FUHH/B68zeE3HfraaTAD7Bnb6/me0cP7k
EYsNQhsGMJ5ii5q1UYGxjQXV83dVcg8=
=aTbq
-----END PGP SIGNATURE-----

--O6GGy70NmVQetPiM--
