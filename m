Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7589BF4BB99
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 10:40:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E94F58366F;
	Wed, 25 Feb 2026 11:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SE7zZH9d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A5683AA9; Wed, 25 Feb 2026 11:40:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D13E82A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 11:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3076060053;
 Wed, 25 Feb 2026 10:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F53C19423;
 Wed, 25 Feb 2026 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772016015;
 bh=9CyCgeXc+BMuMLQz4RQc2VAAYL6fWWg/CG0IT+sdn7M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SE7zZH9dcqOvmMt4f2rjvdDK5ALIqQcuN0S9eAcIyhVE5JaPDP9mFPiXyW/k851Rr
 jZq4rF1v6cMKfGj9FlDJfjLQezrIYUCPDNBxIvcYzhcObzVN75ROSwK1K8FH9rcKjA
 znN3dvyyVGiDY8h2qcVNvM4WBzabvzXFEy+PlGOh/Hus+G3OWehqyNm9UE+tHxwYzk
 GoOwNpvdZaLrT+RivDcdVQ15EAtfEZ7chRhx8aIpStp2cD7ysxwMQEKTbR3leI2c+y
 1V0bCy3xokU4FoH5x+DuOaTRkMoy+eDPaR64kxNMyJkOwlv2mwnr4STeOhxGrpKZqw
 vh1l8u9LpOkeg==
Date: Wed, 25 Feb 2026 10:40:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't
 exist
Message-ID: <20260225-bagpipe-jellied-de21366481df@spud>
References: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6C3U+4rmWzdmXNUJ"
Content-Disposition: inline
In-Reply-To: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
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


--6C3U+4rmWzdmXNUJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 11:28:31AM +0100, Heinrich Schuchardt wrote:
> Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_CLINT.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/riscv/cpu/mpfs/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
> index bcf1ede818b..8054313d182 100644
> --- a/arch/riscv/cpu/mpfs/Kconfig
> +++ b/arch/riscv/cpu/mpfs/Kconfig
> @@ -6,8 +6,6 @@ config MICROCHIP_MPFS
>  	imply CPU
>  	imply CPU_RISCV
>  	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> -	imply SIFIVE_CLINT if RISCV_MMODE
> -	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE

Is this correct? Does it not mean that I just didn't update these to
match the rename done in 9675d920278 ("riscv: Rename SiFive CLINT to
RISC-V ALINT")? My original patch I think predates that rename, so I
probably just sent it on without testing these since we don't use SPL
or U-Boot in M-Mode. If the generic CPU wants them in these scenarios,
then we do too, so the renamed versions are probably a better fit?

>  	imply CMD_CPU
>  	imply SPL_CPU
>  	imply SPL_OPENSBI
> --=20
> 2.51.0
>=20

--6C3U+4rmWzdmXNUJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ7RjAAKCRB4tDGHoIJi
0gXeAQDvmKl3hABnRB89+94lXLiPc+wU+a79yN626CzZwFtdsAEAmX5O1+9a0iSi
hSx1bG2ywUrD6tviYpA0XQmzcpK6qAQ=
=yVMl
-----END PGP SIGNATURE-----

--6C3U+4rmWzdmXNUJ--
