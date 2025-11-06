Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28E8CCFA13
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 19:35:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A04183C08;
	Thu,  6 Nov 2025 20:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IlbsnbMZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D168C83C0B; Thu,  6 Nov 2025 20:35:34 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC12583C02
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 20:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-656b8ca52e8so548665eaf.3
 for <u-boot@lists.denx.de>; Thu, 06 Nov 2025 11:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762457730; x=1763062530; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=a20OL1n8RWtDVnUfGMSZKFS1GpC/C9+70ylc+ECCbFM=;
 b=IlbsnbMZUOL3ByvfYASxrsMFgoK8c2XKF9ByhDPKh8yk50rTmZgfjN3vxb+cVU/YxJ
 KluIhwZOMGrLswMK6XDGuoRWI7exBIoPTrnxcTmgnZ9FXRskYpDiz9FE+bj67i/yfWHL
 GBqUpEZmzsy3RNxu9a77Gy60Ros/18Sn5Ft20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762457730; x=1763062530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a20OL1n8RWtDVnUfGMSZKFS1GpC/C9+70ylc+ECCbFM=;
 b=lEilBVbzYRQsPCYRCl4Z7GSdZPNO6sskjAtX5a2jR5g37hYibWl70hSOsYIKW6DFEC
 0u2rn8aQNGa5sbhfFTTBCq9Q3gih5esDyojFWRO1q3fFGYGsQ/PhKUr3qecKHOKuJHHn
 9lBIG4IuADyE8hUiXP9zlcX+Njo6jUA4KSrxT3+1lpZNfmH2XE4s+YmjnqLfm87pOQQj
 j7LeOMMVArshC/+jftOcjIF0boElMrDdxDXeJArc/zLGi18AGYRGyuoPRqI1a25q9n3D
 riNvaCzAdCEeLnTTHqEfGFeDiSsAbZXQpenHx6E0czg6AllUeLlI2dDfGcj6PmDHvbiu
 qWlQ==
X-Gm-Message-State: AOJu0YxK7/Pkv+U4L84GwM3X0lQcNqfEOdk8KoNiJ4m9C+D4rQfFwQl9
 Sc9wYluVqigZFpGn/FPvLV9KiIekpHCCDBVTaz55evkU5NaLSu6Rz1jC8ObX9SmaVsWClHOU4KV
 4dQcAaRiuVg==
X-Gm-Gg: ASbGncsJsRWc0HjRS91WKkJ1NHZoCaydR4Oy8tFF4YAO+8319o9wx0uyxH70akTuS4Q
 oJe/7XgCq84/cEGho2wy/C34Ppj+j0/txJtBDKnEbyV+J5LU4GBM3xjx8Hp1ws0IU82KxjJ4Fa8
 2fZoFJJj9jmiK1OePh8vZWJhSSN8Cusv1ZXhMHzc2wM9/iyn/WcYMxR+G/RT+ht/76fGANQo69E
 jLUSexaYqyN27f+jmvs5EkRL3v2bYm7EDZd1DokluNglqzyGcGRSVJ4WtYR4ajDHoO7ni4x7Rtu
 1S7R4DLl7+gZv0m+N3LO3IbjrLAMWyalqgko/fzIa1IumQ+0rR/PCxmEYnGnUciU/mL1qCDxgm8
 8WHss63MA+4gzBkBm+CmdDTiRBrc+zZAwOaK4jM0AeL63THyfC1tpeV5HkYUjjtMKM020GWxtik
 2X2+fACdtBepofd1kzKyHScjfv3N6AK0wnKfMRs2hQ5SiV6QRcjw==
X-Google-Smtp-Source: AGHT+IFM8rzgyKAmr+jfys11kDHxcsI2vLdMi4Pitjlaaa655UBGM7qq3AooXsXNiCu9pv2kQqczUg==
X-Received: by 2002:a05:6820:80c3:b0:656:84e7:8fde with SMTP id
 006d021491bc7-656cddc984amr442217eaf.3.1762457730425; 
 Thu, 06 Nov 2025 11:35:30 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-656c56f9f35sm1249755eaf.4.2025.11.06.11.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 11:35:29 -0800 (PST)
Date: Thu, 6 Nov 2025 13:35:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Schenker <dev@pschenker.ch>
Cc: u-boot@lists.denx.de, stefan@embear.ch,
 Philippe Schenker <philippe.schenker@impulsing.ch>,
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Beleswar Padhi <b-padhi@ti.com>, Daniel Schultz <d.schultz@phytec.de>,
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH v1 0/6] remoteproc: k3-r5: Build fixes and security
 improvements
Message-ID: <20251106193527.GA3087996@bill-the-cat>
References: <20251023094631.16742-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yZjOaogb8L+dmZA"
Content-Disposition: inline
In-Reply-To: <20251023094631.16742-1-dev@pschenker.ch>
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


--1yZjOaogb8L+dmZA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:46:18AM +0200, Philippe Schenker wrote:

> From: Philippe Schenker <philippe.schenker@impulsing.ch>
>=20
>=20
> This series fixes compilation errors when building for R5 cores and
> addresses a security issue where authenticated images were not being
> used correctly.
>=20
> Patch 1: Cosmetic removal of duplicate code
>=20
> Patches 2-3: Fix build errors caused by type mismatches between
> function signatures and the types used in R5 builds.
>=20
> Patches 4-5: fix a bug where ti_secure_image_post_process() relocates
> images during authentication, but callers were still using the original
> unverified addresses.
>=20
> Patch 6: Implements is_running operation to allow querying R5F core statu=
s.
>=20
> Note: If preferred, I can split this series.

With the series applied, I see warnings now on:
j721e_beagleboneai64_r5 am62x_beagleplay_r5 am67a_beagley_ai_r5
phycore_am62ax_r5 phycore_am62ax_r5_ethboot phycore_am62ax_r5_usbdfu
phycore_am62x_r5 phycore_am62x_r5_ethboot phycore_am62x_r5_usbdfu
phycore_am64x_r5 am62ax_evm_r5 am62dx_evm_r5 am62px_evm_r5
am62px_evm_r5_ethboot am62x_evm_r5 am62x_evm_r5_ethboot am62x_lpsk_r5
am64x_evm_r5 am65x_evm_r5 am65x_evm_r5_usbdfu am65x_evm_r5_usbmsc
j7200_evm_r5 j721e_evm_r5 j721e_sk_r5 am68_sk_r5 am68_sk_r5_ethboot
j721s2_evm_r5 j722s_evm_r5 j722s_evm_r5_ethboot am69_sk_r5
am69_sk_r5_ethboot j742s2_evm_r5 j784s4_evm_r5 verdin-am62_r5
verdin-am62p_r5
like:
arch/arm/mach-k3/security.c:122:20: error: cast to pointer from integer of =
different size [-Werror=3Dint-to-pointer-cast]
   122 |         *p_image =3D (void *)image_addr;

--=20
Tom

--1yZjOaogb8L+dmZA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQz4fAAKCRAr4qD1Cr/k
CrmLAQCm8/iJ2+jbtYP9K2kmfWtJG6K07SZP5Wxh9joX9n5luAD8CjME5KeW3w/r
LNN81m1Ab7agL+PSWFW2JjUGweV19Q8=
=0oRY
-----END PGP SIGNATURE-----

--1yZjOaogb8L+dmZA--
