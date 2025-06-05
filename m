Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CD6C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 14:25:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8FF78091A;
	Thu,  5 Jun 2025 16:25:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pOglxbi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA8981E72; Thu,  5 Jun 2025 16:25:26 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07BB7803DF
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 16:25:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-60b8a9be972so314910eaf.1
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749133523; x=1749738323; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fH/76E5uDjKGGAYmngxm6Q8RZByUEAO1J2qd2UG1rrM=;
 b=pOglxbi1UxtSp6vN2wKvAYb/OuNwogve5mTL/mh4qTovLwvTW6w+ef2yvJKbloXP+r
 jrd1RERm9YIA5lzlpMEnzZxXrBeapuJK65jbS9/EoRPlsqdFEzM9Au1PvuSX1+x+6Y7d
 04ALkB0/9vzsNnpPGXpEkufeqoSqCWUtCxgyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133523; x=1749738323;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fH/76E5uDjKGGAYmngxm6Q8RZByUEAO1J2qd2UG1rrM=;
 b=EDKUYb+8oO7s+/qJYHTTF2gdh0Znfhtkhs/7379tkNiFM1e0GXM8SHMpN5pdLLT+iD
 f2NaawSbXAwfvHrMpRbgrZpwdKomPIvA+KlSYbafaJSX59Jwnh9I5k9eERa/m0UmtPRn
 9NjZA/VJcFudpwKgOuIo4Lpz8VD9rrn6z7tpKrRoCa7mDrtmFJawXXLkVnPOkAhgP+3m
 gH/ke0JJ7DiLbulckurB8HJU9kUkRJRn3Z5raDxTx9mr9Fur9oY0Th6oShUWeNCLG3+U
 EzMwq6wqnLAJAdrVBRW3SgIC1/UmmdeKdoAkx8dAgoH59rlX2hfAiZtMx87BczFsKEeb
 cdIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlaAKJdeiRdGUYHEfVizKdiwtISRcP+GOJNRYiLYgbWdogxdCtW+WO1ziU1Y/KgomPsjq/1cw=@lists.denx.de
X-Gm-Message-State: AOJu0YwynMqRLjv6hsgMQZrok40CMIwaLNHjw8Rc7uwEgBR2pZ2Ab5bg
 blU5hG+E5q/3TYoknGXJxn9hpYAq9T5Mpx6XUogAPsCiFwhNODd55tQYaMhjtBKqsKE=
X-Gm-Gg: ASbGncseezJN1n+XchOj2NCQudNCJpnIyXnxHL7O+edWs8N3j95zYiiLhgTG4jlLgMd
 b6TbbZuB116wys65eIsYThihK6c62z+k10TgUelH3Cs93+X2STdsglnr8dL10ftnMT4t6k52spq
 Bmfm6jn8C0UmNwMOzrYc/dXBuBWGBcWbcychGzrU7WgfTZgWCvHzseDLP4QdZKfCCOC3YyLkde/
 cO4bwM9fxfaazaVVNmxqPB0154NMS5BVxC1xb0GfFylS5HNKOH/8XNzCaTLaWOTgGkSiWlliS1A
 akJvrKe6/yEpaHzKbTooAPGUdSeeQ7rAibubsaxpResXLkAL2wAU6RSQ+LobBAa+b5dJolVdq1J
 CgG/5lIyGyF+x
X-Google-Smtp-Source: AGHT+IGiXu6dEem01Y6Tfqjoqk4pDfDg2Rj1n1V0YjzuhNhUj8INuJSR1CC41N3+DTdHdXFUxAXS+Q==
X-Received: by 2002:a05:6870:3d96:b0:2e9:512:ee1a with SMTP id
 586e51a60fabf-2e9bf151aefmr5003877fac.4.1749133522564; 
 Thu, 05 Jun 2025 07:25:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e906c0f8c6sm3123335fac.43.2025.06.05.07.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 07:25:21 -0700 (PDT)
Date: Thu, 5 Jun 2025 08:25:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: gaurav.jain@nxp.com, olaf.baehring@draeger.com, peng.fan@nxp.com,
 tharvey@gateworks.com, u-boot@lists.denx.de
Subject: Re: [PATCH] Revert "caam: Fix CAAM error on startup"
Message-ID: <20250605142519.GX1382132@bill-the-cat>
References: <20250605105244.619858-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ttK7gaQyyN2JkgCk"
Content-Disposition: inline
In-Reply-To: <20250605105244.619858-1-festevam@gmail.com>
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


--ttK7gaQyyN2JkgCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 05, 2025 at 07:52:44AM -0300, Fabio Estevam wrote:

> This reverts commit 159b6f0e119962ce5da645f548cefe9196c8778e.
>=20
> Since commit 159b6f0e1199 ("caam: Fix CAAM error on startup") the followi=
ng
> regression was reported by Tim Harvey:
>=20
> "I've found that this patch causes a regression on an imx8mm board
> (imx8mm_venice_defconfig) where the first call to caam_rng_read fails
> here in jr_dequeue but if you call it again it works. With some
> debugging added:
> SEC0:  RNG instantiated
> ...
> Hit any key to stop autoboot:  0
> u-boot=3D> rng list
> RNG #0 - caam-rng
> u-boot=3D> rng 0 10
> caam_rng_read caam-rng len=3D16
> run_descriptor_jr_idx idx=3D0
> Error in SEC deq: -1
> caam_rng_read_one run_descriptor_jr failed: -1
> caam_rng_read caam-rng caam_rng_read_one failed: -5
> Reading RNG failed
> u-boot=3D> rng 0 10
> caam_rng_read caam-rng len=3D16
> run_descriptor_jr_idx idx=3D0
> 00000000: ad 2e ad c0 2a 12 27 c4 65 82 66 19 be ef f6 07  ....*.'.e.f...=
=2E.
>=20
> If I revert your patch caam_rng_read works initially and on subsequent
> calls."
>=20
> " I ran into this when I was testing
> lwIP HTTPS as it causes anything that uses dm_rng to fail the first
> time (such as HTTPS)."
>=20
> Revert it for now to avoid the regression.
>=20
> Reported-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

I would like to wait a day or two before merging this, to give the
original author a chance to chime in but I would like to see this for
-rc4 this coming Monday (unless there's an active thread on fixing the
problem for everyone, in which case we just need that resulting fix for
the release..). Thanks all!

--=20
Tom

--ttK7gaQyyN2JkgCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhBqM8ACgkQFHw5/5Y0
tyzn5wwAp5cxXLBCEtrtyl8a19Gx23re3OyUq7ETRte6XpX0aFe2XuiKU8x2Qd6h
fh+WHm7GZrvsgmDK6w5svH9V5f/5MvZoISnEcy4VT62m3ksguwmtzUupe7nHPAdA
UWOk/DFfDvG6lBde+73rzhE+sZJ8Xfc7A8gxjKrIYZGPKMZSS03RwQZtWShBHfzL
VVNRU0KVJUk8qb2/Y97Hls8VOohQVBqcElcbSYQI92IlYDZP+CCHi6LILCyRgwRJ
6QtNei5xR+qfuWPGDK+lnWQrvzXVb0vgKFuSIOFDsq1aVE22TXfzzZhy15SextYD
EWbcIFYKcuOtnht6klYgr+5y3dO1sAkn1LjsMnD5ID2ItjBVbC74m1D7iEJkQVlo
xlcD+pgCQibM9kS8qn2al2o8XfWbRacXdT6MnQAnbHi7w7fqIEX1I38hfgrS0Qw6
o3QORuvkGfq3wmwB91drejhsPywXGEC0K+CXW2+VDS5zRis8+gHh+pKNU6bWEJwU
/jfgLkA3
=k20V
-----END PGP SIGNATURE-----

--ttK7gaQyyN2JkgCk--
