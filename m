Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CE7C43602
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7941C84B20;
	Wed,  1 Jul 2026 11:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O0ilqHWH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D7B84B57; Wed,  1 Jul 2026 11:45:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F10584AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBE5743C61;
 Wed,  1 Jul 2026 09:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DDF1F000E9;
 Wed,  1 Jul 2026 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782899148;
 bh=pxpMJSAr6F8kVpc0SCIc4y2A8o08b1KelLKIGE2KwX4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O0ilqHWHTAh+nRdoeViJ++pFq5bsMet0ALd1+hkIca2F69T3M4hfhPhTYxIEDou+M
 6ap7XKD2vALqTM4Icc/SwSDux2y2VOE0sN23+L1toVFgpxKacT9EWGnYMwboERxFSr
 c8hNM1MYu58RFlbrwXE+Vtkn3FiXM9PLx5q5J8tfG1Ol1Q90aZTqCgAe/ZDALnAtMF
 4CtVMcgvDu9ndg1gGZw5Ga4dQBDKQV5F0l4X5pc4XV/qAzxvZ3EhO5eZSlYDko6NgM
 aIJRnQAReXWqPVDh+qng1DFjIML646i3+U3tAPQ9cIuiDGJQ2dv5HuYkgCBf4jPgqC
 +fTM5mNEYlmug==
Date: Wed, 1 Jul 2026 10:45:44 +0100
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
Subject: Re: [PATCH 2/8] misc: mpfs_syscontroller: add mailbox RX helper for
 service responses
Message-ID: <20260701-outburst-distance-7ef04973c998@spud>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-3-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yqz14w1QQ/mSKZwP"
Content-Disposition: inline
In-Reply-To: <20260625122325.834568-3-jamie.gibbons@microchip.com>
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

--Yqz14w1QQ/mSKZwP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Yqz14w1QQ/mSKZwP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakThyAAKCRB4tDGHoIJi
0qOdAP4m4O87a5Lw1gcyD/gDsHSfzIiLtmuf/D25pytVTuOPEQEAydFH3KQLobYW
xAP21BkSg+DzZrBu7tc2uP/lDzzSpwM=
=l+Zt
-----END PGP SIGNATURE-----

--Yqz14w1QQ/mSKZwP--
