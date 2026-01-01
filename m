Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CBF2EED628
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 17:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FF6683BC9;
	Thu,  1 Jan 2026 18:15:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZZzevlt4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 343C783C04; Thu,  1 Jan 2026 18:15:44 +0100 (CET)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AFF183BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 18:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-65ecd7fcf36so3224254eaf.1
 for <u-boot@lists.denx.de>; Thu, 01 Jan 2026 09:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767287741; x=1767892541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E+iJg+R/kQ02+g94OcJYGKFNBIJBVB/T8VB4MVRLmbM=;
 b=ZZzevlt4pnfwepyn+BJOSJvu6Eh1N2RKFlijAsnZlUgjP4cmhsCXws7LkKTVrBHFwc
 GUKTD+lSZCdwA6hhhiaQBhV/2zdAGJuiLTDdSAvujS8bP5Uw3zNrJJ3PagLyCUJivcPd
 E8mELWDUkowMwbvgSqnIwGvsU4B4RBG3AuM40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767287741; x=1767892541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E+iJg+R/kQ02+g94OcJYGKFNBIJBVB/T8VB4MVRLmbM=;
 b=Xdqi3ATedAojRkT8rqCg+vxbUV2k/LgkvMSTh25L3Mtv6I6edN0v39O5AwABtUYIHm
 I+CF1RmuzdmJYhDrqPuRiPUs7upRkCoQiJ8VScNgDtr1dT7G1xANCn5143eYaQICPJy0
 fveTsFRGA63H4LJ3Tnl4joeHkEcbM4YOXZnpGKDc4r+szXwunVSSPZFeuG5yHUzgfleh
 X0zHti7U4hJqALXwMOON2HMy2XN2hrRickIyhbb1dPozS9z525hR/0Gw6AWlImdB94cP
 GmwCtziJaOaW41YZaApNrW8kjrRdcfonOyKP99ZWsbkCquuFuJurHTpwJqyJv63166/y
 kZJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf6bR3w/JWo4WZyZ9vedIeNDBD6qTKwLcforsXcOE+KbFhr33KsAo8HX/zRDSHR/FRmNLCv/4=@lists.denx.de
X-Gm-Message-State: AOJu0YwlDLAnrbwQR2l1zry0C78D7RU3d3ulWbaTAtwRLO9H9EqNNjh7
 I1+Jvs8PjSTfTYZw6jjMfipX5rtdKSp1HT4XbaCSm1VjBVrSweQIdcAUluAl9k/l6nA=
X-Gm-Gg: AY/fxX4efPT4Bp7dJEsQdLyFHIgjyxgQsI8llUqa8XDfNgjoh3lLXDrvbfjEXGelD5C
 yGQrNqCuwkpUC4HfZaZ0oxqkC6am8sDwpkX8+0uDR5N5uvkaeUAhiPdWtITq93g6GPTiPpM5gox
 bVPTwGQYFKEHt2NYIVwigqlhyhWnDu6+zaA7vuDXuppWMwwv/e4fKAkmONVH4rgX4tiAxp4C9Yt
 xgdHflKv0GtgBqEy6S/gXCD+WAFMhbsCLcz6cvFcDl6cb5XMl27+hhrimrmuEexXoWeK7E5swnZ
 nQl1cAC56U4Rf6mZCWfE0M2svJeyj0MbIqh+rkLny5kgaWKvkbVCiy8AHU1k2hrnIRs7SWNHLPU
 8+3jMVcXzmDi39ExQ3rtkuXh/9q1AznYyeslp2L1J9rZU6ocjXG43klZolzfFOEFUKFLMcgW4o/
 8bkwt+W/An6LPMPWg3DdFwhPqgZfnLEQhCxT+cgyA3gGbAnMUqmXocCZGpqyurche0wVGwrR6yF
 va+qxjf3yBDcA5l93iIcePSAN4EL8nL8+mgG2g=
X-Google-Smtp-Source: AGHT+IFXEqLoVA1Wv0Riesdmuwishpeof2g7WeBiTRCf3u3EKLXp9aZH0e9igzn+tFoOJ8dKT/Xmlw==
X-Received: by 2002:a4a:e08e:0:b0:659:9a49:8ffb with SMTP id
 006d021491bc7-65d0ea7ab72mr11426267eaf.40.1767287740702; 
 Thu, 01 Jan 2026 09:15:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65d0f515721sm23907010eaf.8.2026.01.01.09.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jan 2026 09:15:39 -0800 (PST)
Date: Thu, 1 Jan 2026 11:15:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] dm: dummy implementations of live-tree functions
Message-ID: <20260101171537.GE710860@bill-the-cat>
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-5-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zt9i/YrvOglpOB0w"
Content-Disposition: inline
In-Reply-To: <20251231191054.247270-5-heinrich.schuchardt@canonical.com>
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


--zt9i/YrvOglpOB0w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 08:10:54PM +0100, Heinrich Schuchardt wrote:

> We have opted to prefer 'if' over '#if' to more easily see problems in
> contributed code.
>=20
> When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy the compiler does not
> execute all optimization paths and references live-tree functions
> even if CONFIG_$(PHASE_)OF_LIVE is not defined.
>=20
> E.g. building qemu-riscv64_smode_defconfig with
> CONFIG_CC_OPTIMIZE_FOR_DEBUG=3Dy fails due to missing symbols.
>=20
> Provide dummy implementation to allow debug builds.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

I think we need to look harder at re-factoring drivers/core/ofnode.c to
move the live portions elsewhere. It's 175 platforms out of 1489 using
it today so we can probably do better. The very first thing I stumbled
on is that OF_TRANSLATE might have incorrect deps? A quick glance at
of_translate_dma_address / of_translate_address says to me it should all
be optimized out in the not-OF_LIVE case.

--=20
Tom

--zt9i/YrvOglpOB0w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVartQAKCRAr4qD1Cr/k
CiGAAP9HDyg4xrg4/DWZC1QJnokWZ015/fntDLMDd+iIpu7v3QEA/vspP4TGEOyP
wQPzP9+TCWpYi2j8Edjm9zvbG6+oVQ0=
=sUJ/
-----END PGP SIGNATURE-----

--zt9i/YrvOglpOB0w--
