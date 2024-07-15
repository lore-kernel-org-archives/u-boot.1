Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089AFC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:49:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7783388874;
	Mon, 15 Jul 2024 16:49:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oSMC0S6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D62188877; Mon, 15 Jul 2024 16:49:05 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E5788842
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:49:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-70847d0cb1fso2406959a34.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721054942; x=1721659742; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vQGkEIolpumJAg9eFo6FRpJ/UDO009eXgYdyiBq8PvI=;
 b=oSMC0S6H0AEahp6i3/qXJJwLnrh4qrbVU4tXkegM9B8YJTy0CklOYVr0akuDKrUFgQ
 IxUpgylWec2VhGukdqRA/YCsCUDHMbqCRsk5BrhFSDb7kO/O3guvwcAbKcaDZYxbNR9E
 fQ+o1TQB8Rn+F1N134oaK1ub5iDxY8oR176Kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721054942; x=1721659742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vQGkEIolpumJAg9eFo6FRpJ/UDO009eXgYdyiBq8PvI=;
 b=GGxAizvy6/xdbyQl5oE2dnsEZ3UEP24Zlq/fg5j/rX73BDCERtyArKPXucZr1hBElL
 2zQVcP3O/kyokIq8AF+sePo4upkRLpSUNKRd5ULTe/IlMRU/QuazxnjplJua1cLRLJyi
 cEN5965/nMUSJaUGBwzQdyAIrQU4stXHvQMKN2UGq7NNGd/N+vGnfZLaZzR6UwHsQB5p
 2nPlX6bZ8YoHzzI3IoMKojLYUw65011pi7w1Cb30hyfeZwTYzeHElgANvWcF5rRMAbP5
 DwgWt3flpgBGA0smk1LgpBU5QRfjD87gaxjYT2/WiOkcM5BlrokZuUzDMGEOW9Pf4+ot
 Qc/A==
X-Gm-Message-State: AOJu0Yz+IdW1iIEM2tl9jAjfswSXbJdZAGc8S3zxZNM8EYDl9dBmSQ1z
 PFM1mqOHpotWNd2LVyrf84q27utrANZyPDVpV29novA+E6ceNceDF9if1/mB345MqXDW5jUEg9E
 /
X-Google-Smtp-Source: AGHT+IGXuNgwjgxxDP7LMCIxOj5GBnp7HLxx8OrD2ryr/nlflAlAV85zhrhw6/KfPeARZnCI0gi3WQ==
X-Received: by 2002:a9d:5c11:0:b0:703:5b46:1c3f with SMTP id
 46e09a7af769-70375a45c66mr20570882a34.24.1721054942065; 
 Mon, 15 Jul 2024 07:49:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0c51133sm972677a34.2.2024.07.15.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:49:01 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:48:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3] bootstash: Do not provide a default address for all
Message-ID: <20240715144859.GH38804@bill-the-cat>
References: <20240715114200.817719-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P1cC3iJqivSAMtLg"
Content-Disposition: inline
In-Reply-To: <20240715114200.817719-1-sjg@chromium.org>
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


--P1cC3iJqivSAMtLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:42:00PM +0100, Simon Glass wrote:

> From: Tom Rini <trini@konsulko.com>
>=20
> A valid memory location to stash bootstage information at will be
> architecture dependent. Move the existing defaults to the main Kconfig
> file for this option and set 0x0 as the default only for sandbox.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v3:
> - Use stub functions to avoid unnecessary #ifdefs

Ah, I see now, thanks.

--=20
Tom

--P1cC3iJqivSAMtLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVNtcACgkQFHw5/5Y0
tywDNQv+MafPMDLPeQDRaqWal9ZXvGpuUHjrb46s0ErJ/lTF+98uT7boRsKzeJ1y
m9IxVd7MgHOE5DuOrxlL401DvGWrJbsuL9I3UlaYYEjad74dYy02QWf0bKkBxcsC
vtm19nkf7byWQg2Uk1vZ2NxLBeIJmJg0CBA/4QdJaMWE6qxgpYJDh/TTIsVFW0sZ
YoJJI6w35UMOR15hWdvvo9X1uwpzhAwLBOiRogsG1TO9E+azSr2Zlcb6RLFdGsM5
91L/zzmthuXGV2aQAz2AT43QZUyl407nV3h6Db1O+/FUl91/uwhebJdSGnYlPlz9
OB0TbFf1yrR0fsvDRfZeUMVZlbeUIwwrz/sgMNoTbQzmUwpNbjItpHXQ/cfCBB9U
VZbJDBqpb8R//u+yMWwpdO3zfx6bpOO41elDeXIK4nXyD1fa+sQw9QNWwi0PcvwQ
arX7cl1vGzvRaRjdXXurJWD0KEZKBOqjHdvACmxEdPnZkKI7+K7ZyzXxp7kf81Pm
AP/ghb3R
=K2r8
-----END PGP SIGNATURE-----

--P1cC3iJqivSAMtLg--
