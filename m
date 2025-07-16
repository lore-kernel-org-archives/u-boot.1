Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C2DC83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 10:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E161D831AC;
	Wed, 16 Jul 2025 12:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J/kPkShL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0CD3831D5; Wed, 16 Jul 2025 12:33:24 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C28882C87
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 12:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C6B136115E;
 Wed, 16 Jul 2025 10:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8177BC4CEF0;
 Wed, 16 Jul 2025 10:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752662000;
 bh=C+njW5vZ7PvCsqH1y1Q/KfZqFQrkrcEHVl440ZexRHk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=J/kPkShLlrpSU+LHyJr0aeZFQh9BFRdcEUujD7bMOwYxU4IdZdeNi4zHcQ2djrtVW
 neVUzN+RbkxlgovsLnv7NmCtcjdBorK5Gx2jGDyEHK2hittdJ+4//FUNJT8aMI8Gv6
 kzjaO9eJFFQdZqsTjbHP+iYmF7t3YOy+3kQ3os3ZYMqailFqg6mLHT4ayq4wxcehxS
 ivIXiQDVhx748WHKkuNR6U43mA3aVKXl1J+/1UllLCSiIqK6l/8AKhG2bKoH4+WEjh
 nPOCL4K8Jj+YN7AClroczPgciWDik7Mo5vIrtmMEglneE2Z0yZhQwhDzgZZDsmFr1w
 1fK/UXUL1oaQg==
Date: Wed, 16 Jul 2025 11:33:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Martin Herren <sputnik@on-the-web.ch>
Cc: u-boot@lists.denx.de, Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/3] riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
Message-ID: <20250716-observant-compile-949c212107d6@spud>
References: <20250714133345.128853-1-sputnik@on-the-web.ch>
 <20250714133345.128853-2-sputnik@on-the-web.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ol32EojhH75JRzJL"
Content-Disposition: inline
In-Reply-To: <20250714133345.128853-2-sputnik@on-the-web.ch>
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


--ol32EojhH75JRzJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 03:33:10PM +0200, Martin Herren wrote:
> For all riscv defconfigs that use the current default value.
>=20
> This is done in provision of changing the default value to the most
> common used value of 0x4000000.
>=20
> Signed-off-by: Martin Herren <sputnik@on-the-web.ch>
> ---
>=20
> (no changes since v1)
>=20
>  configs/k230_canmv_defconfig            | 1 +

>  configs/microchip_mpfs_icicle_defconfig | 1 +

tbh, I think this should get the new default value instead of the old
one. Pretty sure in our downstream users we've made it larger and this
is one of the first things I end up changing whenever I do some
debugging or w/e with upstream U-Boot since there's not much chance of
fitting some kernel with all the debug etc bells and whistles into
the current size.

>  configs/sipeed_maix_bitm_defconfig      | 1 +
>  configs/sipeed_maix_smode_defconfig     | 1 +
>  configs/xilinx_mbv32_defconfig          | 1 +
>  configs/xilinx_mbv32_smode_defconfig    | 1 +
>  configs/xilinx_mbv64_defconfig          | 1 +
>  configs/xilinx_mbv64_smode_defconfig    | 1 +
>  8 files changed, 8 insertions(+)

--ol32EojhH75JRzJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaHd/6wAKCRB4tDGHoIJi
0pogAQDUXUogDHJZ4sMh9XL24UQYyfeezy0i0oXuAYjZnrXZUgD9EJXRLL/dqPqN
5eg9H+0yNqnU5Ti68rn3AV+HWoYpIAc=
=hZjt
-----END PGP SIGNATURE-----

--ol32EojhH75JRzJL--
