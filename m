Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE62C43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4059284B53;
	Wed,  1 Jul 2026 11:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="owwU22YH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0B584B65; Wed,  1 Jul 2026 11:52:11 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33DB7847C3
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:52:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 84AEF4179D;
 Wed,  1 Jul 2026 09:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F063D1F000E9;
 Wed,  1 Jul 2026 09:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782899527;
 bh=E3+ClUdQYUfezDK9c+Djp4ztFgVjn3+mJRcxG4FMdW4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=owwU22YHLRdCvoTa6LNjhKaUAAOqZiMLcdXCG9P5cvwHjC7ykjOCk8DouDrIz88QT
 TmNTdRnMyiryOGtBKomBK1WmAGh+eZtT1JnE4LBJwNlIOJI5p1RU4vA739x9nY1PAo
 S/BVVUI4seBpbBD5nLmtD7Tk3Vdmz7sagydGir8dYgDqmstUhLAyjH4u34t6DsDgfK
 G/I4e8M6WmknVE98uhvrZ6HQ4ia8XSBpsxFuk0q6AB8A9D8GiJadGD2ZFdd0w3A4pg
 m1jpQZp3pH7h1D6/5+LgNMRdXtHs0rd5EeKE72i1yONi6IzWuSyZHKBNHPSd78umur
 dgLLVHj9w9s2Q==
Date: Wed, 1 Jul 2026 10:52:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Jamie Gibbons <jamie.gibbons@microchip.com>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Valentina Fernandez Alanis <valentina.fernandezalanis@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Herren <sputnik@on-the-web.ch>, Michal Simek <michal.simek@amd.com>,
 Adriana Nicolae <adriana@arista.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [PATCH 3/8] misc: mpfs_syscontroller: bind RNG sub-device
Message-ID: <20260701-bruising-gleeful-a1707dec5c1c@spud>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-4-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3XPJQr2lbYurB7GE"
Content-Disposition: inline
In-Reply-To: <20260625122325.834568-4-jamie.gibbons@microchip.com>
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

--3XPJQr2lbYurB7GE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--3XPJQr2lbYurB7GE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakTjQgAKCRB4tDGHoIJi
0uTFAQDPuZB+nQy54vaDDZUQKvwHxV9HNjApoMZjm1zu6hIeFwD9FczFeAufeLPr
LyGeLrXy1BUCDbkAixMTRRVLu3C5Kgs=
=LNVm
-----END PGP SIGNATURE-----

--3XPJQr2lbYurB7GE--
