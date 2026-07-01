Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D54C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4710784B86;
	Wed,  1 Jul 2026 12:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lKapEn/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1976484B87; Wed,  1 Jul 2026 12:05:43 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF0484B72
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4CE541915;
 Wed,  1 Jul 2026 10:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED301F00A3A;
 Wed,  1 Jul 2026 10:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782900339;
 bh=rLVRaGzt16ejDoyPa3cB7vKy8ZPjqm3r4PnkuGNeKWk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lKapEn/xCOpmbxcL5w5zVPUpYUrwpK0bUJw+8cotBB0pktnHXBB7MxaGgzou7devM
 bMPl/4VQcsmNnWzsz8KolncGAb9Ei8t6zdluTbE+7N3sPaYyB0rYpGZquXTpHMl9ZC
 6ixZ/rdoSMVAprxLGuRi0FPz2ZTjAY8DCf07zi6igT1bApxJhvlpo1gUxTFuwR1Tfj
 SOriblFA35IZsS9PHrL5BbWAnr1VFkFuyQhk0r3/NNV77kI0tVXomhQHn1z/eahr5/
 Jg7zHfOkP+YZy+mgtk7pT0cJjM6ahTO2hlya1sxtqCQ/Kzjcd4Y6mfaW/dSDirF+q7
 g2ArWxbz59h3Q==
Date: Wed, 1 Jul 2026 11:05:35 +0100
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
Subject: Re: [PATCH 6/8] mailbox: mpfs-mbox: replace unbounded BUSY polling
 with bounded waits
Message-ID: <20260701-overlay-ambiguity-f2d28e65e815@spud>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-7-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CtQAsFA3bM2l5EtZ"
Content-Disposition: inline
In-Reply-To: <20260625122325.834568-7-jamie.gibbons@microchip.com>
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

--CtQAsFA3bM2l5EtZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--CtQAsFA3bM2l5EtZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakTmbwAKCRB4tDGHoIJi
0gB1AQCWPXaUyrBeIaJp8xbh//D+LLDRqmbTEAURecHpkmpRZgEAk3UDTBR0jIF8
XJKdTNsnsJITGpSQdPUH+8AsDxFNdgI=
=rsj0
-----END PGP SIGNATURE-----

--CtQAsFA3bM2l5EtZ--
