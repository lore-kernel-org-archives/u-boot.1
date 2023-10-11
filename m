Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9081CDB477
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 18:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E703786D02;
	Wed, 11 Oct 2023 20:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bkM9J8Yd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 026938082A; Wed, 11 Oct 2023 20:36:54 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F187086C53
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5a7c08b7744so1823197b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049405; x=1697654205; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v4xE2Zr3ccqXif5coQD/JbnHc31GXfbXU6ioosYKeJc=;
 b=bkM9J8YdsO8cgZM5VpcheFgPbyBpRcjHWub7D1iw5o2dgXP2GxXH9CHLMJasjg3Ffw
 /j/B9TVNWIOBcUigS9ujv4FpRc34CozEVOh0oHe79fYiPk2KdOWFZSS8LhuNRuMOByOc
 3cpjmXw/W8A8eNti+SzLQFkq6tBwtJbMZME5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049405; x=1697654205;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v4xE2Zr3ccqXif5coQD/JbnHc31GXfbXU6ioosYKeJc=;
 b=CKk4Hawsh/0n4v+ePXw/uWCfc8VQA70y1vBa2ZcnP8XNJOUvEoiLy8HQfNtoV0h9J+
 GSdEMam4wSII1wook9xCizBKvMl2+lI0xuFlLBlqPVfLlBrZFFK8hCtOTLFYDHkvXsZh
 9J0dnZiC6Rd7MxGWeQGJJbvz9AUQhzG5Nxr/BkPNOEm55g8gFPGQklZPSoQlKqfNPi8y
 VO4Jj6nD61WoHxQ9ovzzo4xc7Pj/70aspxoTynPhk0oSEMWyWo2xLJvJ1D2PKFb04CCe
 PANw/jt+tFI1b3KxDXAhOLtlfoTPUVgup2ubxw6m6InKcBwx7xuCj9a5WkBg/hXIlUxE
 KAmw==
X-Gm-Message-State: AOJu0YyRxqus1hxAU1m2LbKg5hhJFbHiCLXgXWR/P4xyY/QiBqPBKFrQ
 4Gt4OSd1lHZUtmKJ6ik1vVmAVA==
X-Google-Smtp-Source: AGHT+IH6eUCkjADGDmEclEZGqsQOfPxiVU4yQSLLLMXZfTS9nH720Og7rkoODXTzV5CHsvml0Lw0dA==
X-Received: by 2002:a0d:e88d:0:b0:59b:d7c0:ea0c with SMTP id
 r135-20020a0de88d000000b0059bd7c0ea0cmr23724805ywe.11.1697049404726; 
 Wed, 11 Oct 2023 11:36:44 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 r135-20020a0de88d000000b005a1cc37aff1sm5286236ywe.20.2023.10.11.11.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:36:44 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:36:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721e-sk/common-proc-board: Fix boot
Message-ID: <20231011183641.GK3119521@bill-the-cat>
References: <20231005181514.4054241-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ps1q6LNMy7IYBj4v"
Content-Disposition: inline
In-Reply-To: <20231005181514.4054241-1-nm@ti.com>
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


--Ps1q6LNMy7IYBj4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 01:15:14PM -0500, Nishanth Menon wrote:

> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node
> as pre-reloc after relocation") A53 u-boot proper is broken. This is
> because nodes marked as 'bootph-pre-ram' are not available at u-boot
> proper before relocation.
>=20
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
>=20
> Fixes: 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1")
> Cc: Neha Francis <n-francis@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Tested-by: Tom Rini <trini@konsulko.com> # J721E-EVM GP
> Tested-by: Neha Malcom Francis <n-francis@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Applied to u-boot/master, thanks!

--=20
Tom

--Ps1q6LNMy7IYBj4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm6zkACgkQFHw5/5Y0
tyyYnAv8DxSmQbKiCtwrC1b6kIdFOCs7tcFuSBk/xVCq1HbnWQyt7zEhG8QpANYK
2nBfnFLjtSfOzJw6YI+kXvF8kzFNoPRpcW05B5sSBYwQjxW8PWsBke440PB1TqN1
xy391Rq+zXRNdZW5uvuM3vX0r9S53miX/uLSNdHla/5zu+Zf0pNi1PZTtfnq5z5n
YFphUNk2KMRGOVch03sTNsUDI0eByDDnd9xSTcA9+0zIWkWNRaHRQ7+sLKafYtCY
FQK1KggpCqRegWrkndZk3OCQTt2AJeD6rWPBZ2zE2N+2JEuLBqG659+ZQV99Tc7P
CLzt1J8e7rmEJI6K9Elzl4IvdhQZtsnWhrIuRZv4PhFTmP4H7vJ4q4nOQdlLei3A
AdGefjRX6plXnp2os0657JSfx9MlWGdNQXn+qKumvFHGRqBWhF/BEgta0uNrWBM1
rrcnqmNTT2IwzHLIur77qLDSGTK18yAVAgCnbcBrBRe3OZjvmjomxU7t447bxLCd
vXaiLnYy
=b1TR
-----END PGP SIGNATURE-----

--Ps1q6LNMy7IYBj4v--
