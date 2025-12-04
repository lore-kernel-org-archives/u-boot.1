Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C0D1D892
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 09:46:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B7E83CD2;
	Thu,  4 Dec 2025 10:46:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L4zQvrNG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0368883CF5; Thu,  4 Dec 2025 10:46:27 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B936183C40
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 10:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7DCDE60192;
 Thu,  4 Dec 2025 09:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D22C4CEFB;
 Thu,  4 Dec 2025 09:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764841583;
 bh=qem1MJC/98eHfuONzYYC4qW90yxaqQRZoHARsMTEnbo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L4zQvrNGKUqZcuFANmgGAb3F14YF8hUAwry3xWUbjb9DQzWwey6EK2R1SytGKHyme
 E2DAqJSk6raeTPmf08d+RQcEu2CgBxkTAwGQE3wRu4UOuU7BfBSwuCn24ExF6lnmDF
 9URGJ6PbT4mJrys5IcobGLZfj53mJ5EcrlDnmo5yCg3Iz6zass8R99ndfiPiTLQnD5
 554oYadFj7WrykuTFfR+JULkoKsa9WPUk9DIn4trfV7e9xMvMs4JhqWN/JgVdM6/9L
 upMjeX/ZFcaejVB7uE9Hyi9B2cyXittxYx/Kv/KvXFP/B5A4nVwynUcWkN51WaNLEo
 QnYuf+pq1xMow==
Date: Thu, 4 Dec 2025 09:46:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Leo Liang <ycliang@andestech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v1 2/9] riscv: dts: starfive: Add VisionFive 2 Lite board
 device tree
Message-ID: <20251204-exemplify-tribunal-bae6a028909e@spud>
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-3-hal.feng@starfivetech.com>
 <ff0313ed-5d43-4603-aed4-6e41b2abed37@freeshell.de>
 <ZQ2PR01MB13075E9B291AF6D313AF347DE6FC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <aTFWSF-MFs40a37w@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iaVKTYjBowTKhQdp"
Content-Disposition: inline
In-Reply-To: <aTFWSF-MFs40a37w@swlinux02>
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


--iaVKTYjBowTKhQdp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 05:37:22PM +0800, Leo Liang wrote:
>=20
> Got it. I have learned that the patchset is still being reviewed.
> (https://lore.kernel.org/linux-riscv/20251125075604.69370-1-hal.feng@star=
fivetech.com/T/#t)
> I will merge this patchset after the dts/upstream/ is sync'ed with Linux =
device tree.

Something must have gone wrong, because I applied those and sent a mail
(via b4) that I had done so. They should appear in v6.19-rc1.

--iaVKTYjBowTKhQdp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaTFYagAKCRB4tDGHoIJi
0suPAQC+bmKpW0cAv2R/1r5O2L8twKOWytbEqmXhp+2NEr5TWgEA3QtRGTHQyEbc
Qi8Q7xrX8p5soq3N6bQROTcYW88X1QE=
=dpy8
-----END PGP SIGNATURE-----

--iaVKTYjBowTKhQdp--
