Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA233C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 21:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E9AF8083E;
	Sat,  8 Feb 2025 22:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FbkPgHWf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3C618083F; Sat,  8 Feb 2025 22:33:46 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 953E4807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 22:33:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e549b0f8d57so2762325276.3
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 13:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739050423; x=1739655223; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Uz1lpAl92j0Xkbm2mfTQ4k0Vcb8lTF4hEUovT4YkZio=;
 b=FbkPgHWfw3p/55B6Z46VfD0h7IgeFrIvNiO8kVIeXRy0aJmjY3dBcOdGTL7RKuMAPs
 nks25t3P++5BbqaR38rcySynQE7qoOh0VuwaXq7emMHtlDjvWA4O1OLd3UNcBZ3xsK2z
 gCDpxDkvV1Sm/AtQ60UtbMYi08Bli/ihEwkXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739050423; x=1739655223;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uz1lpAl92j0Xkbm2mfTQ4k0Vcb8lTF4hEUovT4YkZio=;
 b=Zq/Ys6x2rYe56PFDrBhRchOI671WRWKJGB7Ofk5VRfiikyRih+eUgdFUcT9n+9JMbn
 AUHCxcmJtD6+yaR3p7QNXIoAVXvHKSqR3BtkjxmYz9iB8UeYxm7N0AUghPBXkeB3/XrK
 jW90IuRX8mUvQbrS2zfjlDUHGrs1S7uSi+GKgj84IhlmgSoKKBN/BabSRPbT9f2g/TQO
 nCs95k7sfS4KcqrThKnec0Gi4sYsQ1EB1pn8kIL4PZmLWzhI8W6KT5uwtGikQBsvs08c
 N467eknhbF8j6DeNGowcJvmnpDBJtqOUTg/bRYnQx0bPg8C+xHnGSc2f/ylDDWu+BFM3
 QPMQ==
X-Gm-Message-State: AOJu0YxL4zY2Q8vWIwVAymycrmXAIAtEiC51EtZu3AmhCwu48bxMUwOU
 lklwp3/vbztaueR9PQGZI2NXew0aolxEXcDqTS267jctQkXyCeWGaUCYC/N7tbg=
X-Gm-Gg: ASbGncsBxzaCUSreTGQpzyoQ2uxL5JdnZeifoBZBJgkRW2Xr0SgEON7wNV2UUKowoLb
 24kLbE2RWi5W0WrvS/pr9cCFV0j/iNFGD+iGwEnQ4oKaPlnCFHKEfpAUvAKGm3qwJIMWHnqCCrF
 U9iOc2SC2nGf3fAyo8VEb0ebMdIjSC5v1hZzaPwyyX+junlNpV/90hCWfMER4jsIlX4XN01N3ps
 r7pFNOabPzJq7HzBCITT+YXdXrHlrWYnHTdK8Oyc9XKHd/cUsHHcEOduhr8kTRuMLNQEFTVZCiY
 k7WOJpjXZOWEoH0=
X-Google-Smtp-Source: AGHT+IEIf8nArdBZM3JsiaQ8B5PaIyB/vQa7JZQtO7TT09KfJJwDgtiR0DL9BxZfnfGFWJDWrqce+g==
X-Received: by 2002:a05:6902:2785:b0:e57:f8cd:f0a4 with SMTP id
 3f1490d57ef6-e5b46291d9amr6725771276.34.1739050423482; 
 Sat, 08 Feb 2025 13:33:43 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5b3a0f5353sm1635045276.0.2025.02.08.13.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 13:33:42 -0800 (PST)
Date: Sat, 8 Feb 2025 15:33:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v2 17/29] efi: arm: Implement access to global_data for EFI
Message-ID: <20250208213340.GG1233568@bill-the-cat>
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wmrh+eg8DRP5p72K"
Content-Disposition: inline
In-Reply-To: <20250208171154.1305761-18-sjg@chromium.org>
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


--wmrh+eg8DRP5p72K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 08, 2025 at 10:11:37AM -0700, Simon Glass wrote:

> The EFI app likes to use a simple variable for global data. Implement
> this for ARM (for use only with 64-bit ARM at present).
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--wmrh+eg8DRP5p72K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmenzbQACgkQFHw5/5Y0
tyzYkgv/SIxfft5IuPGIjUFpVA1fA+JKhUFVxhqDFkav+5b3xBL64B0BLHgs/xm7
NXq0WzTN1qiem3kVZnMMU1A2J1mrye23b05fgStFWTF+1KdviWhfKt8+z7gNmb3O
SoBp8wsVSuk4AY9kwa9ihVTgcF2PedaBqR0IbKti4DowhzqXqlmXSTdMO6ogHjn3
838+mjjScX/LWovpcTx7A+H2yHo+VNTyniqvCS7Z8H7X53v+RyhA8mlawndADM6U
jnH/TvwS+LMG3rMh+z4zFUj5ZjjMivcRaN3qZGf+YpKKB9rpX6jOnL4Bo1wCrcdR
LqZHoYxWtJTtaMVi46ZyUEs8X/ZqEMeeLLbN40utiNJNdGWPc0jJlQO2NAEaa9P/
bbY9MrWKZZSGDiGiZIOQCdmt9aVQd/oZA4dYZFF5qeUwzuwIBx/uyi2qhllAl4di
gE+B+dDWLA8VZoBhBiEruK0A7/M46iJUMVOEWrgmaOVNBveEOjev3CcGk/ah7cVb
d3zK1zxQ
=Cke0
-----END PGP SIGNATURE-----

--wmrh+eg8DRP5p72K--
