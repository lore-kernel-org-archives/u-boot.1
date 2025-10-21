Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7707CCD1A5
	for <u-boot@archiver.kernel.org>; Tue, 21 Oct 2025 20:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3416E8323A;
	Tue, 21 Oct 2025 22:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bFpbjigq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 131D7832BC; Tue, 21 Oct 2025 22:36:57 +0200 (CEST)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC998807C0
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 22:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-64990f4dba2so106323eaf.1
 for <u-boot@lists.denx.de>; Tue, 21 Oct 2025 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761079013; x=1761683813; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a4E8F0ImPgaYFUtoZzpfDyK1e1CU/ESG/Dqsg15Drh0=;
 b=bFpbjigqnNrwEmf2yIdcArSR5aR4Qe1XPwIHYvuDIGnwINqR0vQUe6JhPuVNOMhH+U
 5QqM4mM76jZxEP2D0T5mwnEado4wYTzQSVxqXnmlEr7CtEjBwoPuVCKmD+VHIpkqTD8X
 wke+Q9uMXCAmkxDsXDHLAh7feMblFJxyRLOd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079013; x=1761683813;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4E8F0ImPgaYFUtoZzpfDyK1e1CU/ESG/Dqsg15Drh0=;
 b=i+XRJrQwu7Bm0XJg5ArUFbmRSBLjBghSrR9Ie5MCBKYLwA7YoTCuHzr7ChTovQW32A
 AsGsxQMzV4/Rd7C7VHbeW2xrW7HOkNPNiZ6EM0hpeSfB6qNtO3Akzt0hUOdcpTN6LyDe
 1IZ/cob9yQkh8V0x4setV6U58CST0tKmOcesVYa19XMB9K1x/TIGNrPYy4LnMV3V52hF
 C5vxWXGtDhD1gAJvOJoHGveGwHMIF2FHdBbU6q5kgEnvVoSU+ENTYEK00EuHN/X6snem
 xOs+V1gqWovgdDmCxgB17stXrhbPV8XmXCcaXig7IQRkUXhoNcPNdcy2EzkIqLiwWfgm
 rMZQ==
X-Gm-Message-State: AOJu0YyEL6JHZru/FPXlSEH9mqQNU7jnJl1ZyfsdOJy35SsO6uIuzSo9
 qxfdz0nO9L8sbtt1fzThB9r8AunztXcX7Pq1DakftOdti3Bq/t2vcrL3bnClOGkJOzHBFtHilm8
 rtjNKsuE16Q==
X-Gm-Gg: ASbGncusDSUT0YrWCGGTRvhM/3SraJJA7JZMV4VjySgwB8bGHkYrQXRTsqRHuiq/kDZ
 uhMmGUhzlbIIjzCXODgafrCy10I+COZkY3dLpvHKm1THcbBisvXQTBy8g+4+aOHZ4BrkOIR/Gc6
 NEAIE/Af+sTrzua02Tq2TuQWY2R03M78JHUgbeWrqO9aL4X+gyAI3RFlbBwWCMvuVajy27AJ7iP
 IBJoqin0C+HPkQ5AMj9lzijUA10cnURTT0y92mcsR9C1x2w/JfCn+r2AtyBGwnJnEbp+E0HNJqs
 GzcaeWPrDvb8p8fECr0nw0FwoLFq6chRklgyK4d/vjkCjZxclDpPzN8o9INdmAeSS8hQwrxYtNt
 2BLzyB+yDjyDb0HxwSAn7V9KLXWX9r86rp14X3l18/5EmZ8s3w2rA+Teq+rLvrwZQAywYbSHfak
 5yxXquWg4+NMfpeW/keavl++Dx/oRcIikKApoCrDzNVMInfFZl1Q==
X-Google-Smtp-Source: AGHT+IH8Pj0/YYoAHAJ06TX4A3BymkgasbYyF60gQe3CpSH9pwltFQylns8P0vDxEjPuWe9QzLGnAQ==
X-Received: by 2002:a05:6808:2219:b0:444:c761:c091 with SMTP id
 5614622812f47-4495cfe5d00mr640405b6e.10.1761079013623; 
 Tue, 21 Oct 2025 13:36:53 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-651f07086adsm1149647eaf.13.2025.10.21.13.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 13:36:52 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:36:50 -0600
From: Tom Rini <trini@konsulko.com>
To: jasper@fancydomain.eu
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com,
 Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
Subject: Re: [PATCH] env: Invert gd->env_valid for env_mmc_save
Message-ID: <20251021203650.GG6688@bill-the-cat>
References: <20240510113834.826783-1-jasper@fancydomain.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c6Ax0ulaYdUCGKFo"
Content-Disposition: inline
In-Reply-To: <20240510113834.826783-1-jasper@fancydomain.eu>
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


--c6Ax0ulaYdUCGKFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 01:38:34PM +0200, jasper@fancydomain.eu wrote:

> From: Jasper Orschulko <jasper@fancydomain.eu>
>=20
> The A/B update strategy of the env's has a gap in the first 2 calls of sa=
veenv.
> The env's are stored twice on the first memory area if:
> gd->env_valid =3D=3D ENV_INVALID.
>=20
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to MMC(1)... OK
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to MMC(1)... OK  <-- !!!
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to redundant MMC(1)... OK
> u-boot=3D> saveenv
> Saving Environment to MMC... Writing to MMC(1)... OK
>=20
> Signed-off-by: Michael Glembotzki <Michael.Glembotzki@iris-sensing.com>
> Signed-off-by: Jasper Orschulko <jasper@fancydomain.eu>

Sorry for the extreme delay here. I was hoping for more feedback from
others and then it slipped my mind. And then we had a long thread
addressing this same problem for env/sf.c. So I've applied this now
(with a slight reword to note the env/sf.c fix) and posted a patch to
address env/fat.c and env/ubi.c.

Applied to u-boot/master, thanks!

--=20
Tom

--c6Ax0ulaYdUCGKFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPfu2gAKCRAr4qD1Cr/k
CiLmAPsEGLJ12lRSzsESadWM3xqp7oRhQieN0ymm7YdNh+PPkQD/ac/VEEOyIhZB
q+14gEMSby7YeiyoXNw21Orm7Netows=
=ygID
-----END PGP SIGNATURE-----

--c6Ax0ulaYdUCGKFo--
