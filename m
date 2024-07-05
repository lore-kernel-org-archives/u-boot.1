Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CDD4C3271E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:39:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EB8388636;
	Sat,  6 Jul 2024 00:39:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ONukMFax";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD5F88637; Sat,  6 Jul 2024 00:39:27 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5B988630
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:39:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3d9234b77dfso197115b6e.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219164; x=1720823964; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jA6590pF+/cc0eXD5qmhvJcCf/fWZpMGKkPVLFWBHZQ=;
 b=ONukMFaxHl8I4p3rXJVvL5+pNdGU9loohNSsi+tS/VUoJcOapjCOSi0jwR+XH8hyWg
 01KFkajZckrDAilmn8Mhl18RvlJ0L6CODSE2E4GHdIrV/ksbYT2qACWlk3fWYuidfBCD
 6LpbXmzPMgLRbtqC3CYRlEMBFmGcPNmkH4F6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219164; x=1720823964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jA6590pF+/cc0eXD5qmhvJcCf/fWZpMGKkPVLFWBHZQ=;
 b=XcvXNjeV1D1jvFAtNXSLSN+C3wQAvgb3x0CxN4i2PgnHbA6gYuNwJ8HEjsuzd3B51v
 WD6xScR5OWJjpPGSGzcPyiujww9O/h070m88nETQQ/jdhzYOCtKGk91B8HrAuoYNfJ73
 1zI7bQTemdTGvuJ2ZkvLw6/lat9p1Dhnd+P+vP4zDikegyh5y9YPJMG1ZEu8OT40mETV
 8V/V4RaceMEuoMAa1r8X5EZ5Evt/YhYbSEYNNTZ/GWEvhkxK7/BL/tPlB5nzoMADspGt
 UcrBny21Ts+0w+niseniDXkPrrWikv5QSjYkydoXHMS09r38h863y9doJisthNrsdojS
 CK1g==
X-Gm-Message-State: AOJu0YzZIgwVpGqxDw8AKO0Mkbpx0vxBYaGlkc2InlmNJsjDYOLUNUV1
 nUbb/K5RDStg14dsBQOmb+27Gw1AbZBpKiGRKSfkeXQ6Slstw7QdgziX1Rl8/Ds=
X-Google-Smtp-Source: AGHT+IEGBJcLBygYl46wSAc35NhlOut6Fi6FWRJnNnaj9jvD8uVH0uxHVQgzPl6llPSFg6yU+6Z5zQ==
X-Received: by 2002:a05:6808:219a:b0:3d6:342b:d7f3 with SMTP id
 5614622812f47-3d914eba858mr6324074b6e.52.1720219163753; 
 Fri, 05 Jul 2024 15:39:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62f9b93fesm2908064b6e.6.2024.07.05.15.39.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:39:23 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:39:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] configs: Remove duplicate newlines
Message-ID: <20240705223920.GQ38804@bill-the-cat>
References: <20240616151940.37802-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/g9qx50BrQ8xKWMG"
Content-Disposition: inline
In-Reply-To: <20240616151940.37802-1-marek.vasut+renesas@mailbox.org>
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


--/g9qx50BrQ8xKWMG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 05:19:11PM +0200, Marek Vasut wrote:

> Drop all duplicate newlines from config headers.
> No functional change.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/master, thanks!

--=20
Tom

--/g9qx50BrQ8xKWMG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdhUACgkQFHw5/5Y0
tyzJFQv9GVSn+dGQBS87qxADMME6KJnbEi9S1wDiDcPJarI5joyAz+e1/SOAtZiS
uABiVvjCgu9MUHtkhEI71uHxZtIDAk9gNGDlJY1AGnOVJMfFG8EfMMxC2zZF8Rbe
wZ1zL1GTnGXPpfdXdXlKl26HrSp2sn3HltXaAOWzjrI4Lg3TQ5g8YA8VjbuRqxbr
bGPAClqmh/mt1cwm5QNnD/gxfEbMrkAqPcTt88f9ui/pP0LeiIMB+b5VM165OI3i
u7cFO/QH87/uc6SLJk8rpuGzAcuuKsOnwOFIbGfLWrWOXfRlStiY7Rvz0BuOsDT7
p+/eh8gZPHYPiPio/L4MlxbPJvJwtGuAaKmtkNwMjgz3PB3GF7rc1G3rg2gSVQBH
cLaAn3VgVpZIV0F7vPSc/dNi/04t1zdhV0ONxGx8qgdCT8KIoXhJ6D5wUjO1CaXS
sTiRRviDGSNi+X2P1PHBCeGOZSdTdc+DSYjCzQEkUvgHJlEfyT95ovdwki0f4/wJ
2UX4xWqb
=PuuH
-----END PGP SIGNATURE-----

--/g9qx50BrQ8xKWMG--
