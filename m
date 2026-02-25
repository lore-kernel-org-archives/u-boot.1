Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96DAF4BB99
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 10:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 592E08366F;
	Wed, 25 Feb 2026 11:42:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CeG+Wgey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04BA28366F; Wed, 25 Feb 2026 11:42:43 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B2282A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:42:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 54CD840851;
 Wed, 25 Feb 2026 10:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ACEFC4AF09;
 Wed, 25 Feb 2026 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772016159;
 bh=e8/WV1cs3rwAinQa0yjGKUthHHU/XYy8TqOj4V3j3C8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CeG+WgeyS/nXqOvtyMlL42CyOx+BDLoLKDf+D4YIZYFy0U4oaY/tI+dvgZVdrF8pS
 j4FBD0l7dhY6O/WsY6tSeoosqWHgNFhFX3g74bWnQjjs7b9ZBoc/kdYJmuMcjk6iQ9
 nZ/DXBTTVmljkqSejG8i95tXvJ/flaP5ZdF6p7HkZw4A0KBGra9JiilGbMliCtHCx4
 FXdLiBjYdA7UrNNfIhSNGkDBlQb/Zc8yd3KrWAqZ3R9qrM8oqyYlfMgNlUaP/aqf9L
 6betG50kNrSUm8D/27Zv6xEzSAGcphxndmAZpcFZ2/oHvnVAaj00WVLsbbNo79mlEm
 xlChsRW74Zj+w==
Date: Wed, 25 Feb 2026 10:42:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Green Wan <green.wan@sifive.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, E Shattow <e@freeshell.de>,
 Bin Meng <bmeng.cn@gmail.com>,
 Lukas Auer <lukas.auer@aisec.fraunhofer.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: don't imply non-existent CONFIG_IP_DYN.
Message-ID: <20260225-hurling-onto-c4dfac50d31e@spud>
References: <20260225095414.45365-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mVIjmZzSK40Q0Z0U"
Content-Disposition: inline
In-Reply-To: <20260225095414.45365-1-heinrich.schuchardt@canonical.com>
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


--mVIjmZzSK40Q0Z0U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 10:54:14AM +0100, Heinrich Schuchardt wrote:
> The symbol CONFIG_IP_DYN does not exist, but multiple contributors
> copied an imply statement.
>=20
> Remove the imply IP_DYN statements.
>=20
> Fixes: 3fda0262c33f ("riscv: Add SiFive FU540 board support")

Should this not also be
Fixes: 64413e1b7ca ("riscv: Add Microchip MPFS Icicle Kit support")
Fixes: 70415e1e528 ("board: sifive: add HiFive Unmatched board support")
Fixes: 6f902b85b6e ("board: starfive: Add Kconfig for StarFive VisionFive v=
2 Board")
?
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/microchip/mpfs_generic/Kconfig | 1 -
>  board/sifive/unleashed/Kconfig       | 1 -
>  board/sifive/unmatched/Kconfig       | 1 -
>  board/starfive/visionfive2/Kconfig   | 1 -

--mVIjmZzSK40Q0Z0U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ7SGQAKCRB4tDGHoIJi
0ukyAP9G3boiAoz4Iey1J1nts1ZMr93W5pQqtpzWdzT0ooZw2wD/QJQTXh2SZ2KB
lNFoDHL7P6+sIrXAnFyGZoszZ2M8Ywc=
=1cJu
-----END PGP SIGNATURE-----

--mVIjmZzSK40Q0Z0U--
