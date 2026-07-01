Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9405DC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DCB84B76;
	Wed,  1 Jul 2026 12:04:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nx4RbAnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE6684B76; Wed,  1 Jul 2026 12:04:47 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E0584B72
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:04:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43F7D601DD;
 Wed,  1 Jul 2026 10:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841AF1F000E9;
 Wed,  1 Jul 2026 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782900284;
 bh=wU4b96n845FgjPK6yuy3B9rzsQhVpG5nR8VoedOq1TI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Nx4RbAnMZgtZgp/a+l6Zzymc09PNctCtL6FU0vvyOzxc7rlirMR6hJx4O/AOlBQaw
 MOmAmlx0fa5z8QTJDVuLteetIaKEMYbnBrtcElC/Eq1G69KYoOPyVywY3nuZtpWnRx
 VSb11yvoJ29m/4nWyNo/qKx5fBnFd+UkHon1FwrEUsHAy6QghPl83GDeiOhYSCwzFg
 +ny5n0p2hSdySj7w0EH+V+7Aj22ytCNFzQ/Yv8v5c5I0tsRLmmJYAQsLh1VpfMiefY
 ZDXdeN81HSiBmw7ONmT3hCaZN/+BcVYEmXlCQ/IW9wG0FBulHXd4FfKiZUW8BXX3NJ
 aqY41SsVG5dug==
Date: Wed, 1 Jul 2026 11:04:39 +0100
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
Subject: Re: [PATCH 5/8] configs: microchip_mpfs_generic: enable MPFS RNG
 support
Message-ID: <20260701-claw-vantage-eb1a22651299@spud>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-6-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZpJkxNUpU8L/c7uC"
Content-Disposition: inline
In-Reply-To: <20260625122325.834568-6-jamie.gibbons@microchip.com>
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

--ZpJkxNUpU8L/c7uC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 01:23:22PM +0100, Jamie Gibbons wrote:
> Enable the MPFS hardware RNG and associated infrastructure in
> the Microchip PolarFire SoC generic defconfig.
>=20
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  configs/microchip_mpfs_generic_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip=
_mpfs_generic_defconfig
> index 66acaad7e9b..e3d794f08b9 100644
> --- a/configs/microchip_mpfs_generic_defconfig
> +++ b/configs/microchip_mpfs_generic_defconfig
> @@ -21,6 +21,7 @@ CONFIG_SYS_PBSIZE=3D282
>  CONFIG_DISPLAY_CPUINFO=3Dy
>  CONFIG_DISPLAY_BOARDINFO=3Dy
>  CONFIG_SYS_PROMPT=3D"RISC-V # "
> +CONFIG_CMD_RNG=3Dy
>  CONFIG_OF_UPSTREAM=3Dy
>  CONFIG_OF_BOARD=3Dy
>  CONFIG_OF_LIST=3D"microchip/mpfs-icicle-kit microchip/mpfs-sev-kit"
> @@ -29,5 +30,6 @@ CONFIG_ENV_OVERWRITE_ETHADDR_ONCE=3Dy
>  CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_BOOTP_SEND_HOSTNAME=3Dy
>  CONFIG_DM_MTD=3Dy
> -CONFIG_SYSRESET=3Dy
>  CONFIG_DM_RNG=3Dy
> +CONFIG_RNG_MPFS=3Dy
> +CONFIG_SYSRESET=3Dy

Ah right, here is is. The DM_RNG bit should move here.

--ZpJkxNUpU8L/c7uC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakTmNwAKCRB4tDGHoIJi
0oTKAP9l6sr/hklpOjQohykCirm4hiSpC8p6d/B1oliOWFp0rQD+NzvpnU6maeG/
35uUtvHftlJkdKVU86qy7ls6WddpZgA=
=z8wR
-----END PGP SIGNATURE-----

--ZpJkxNUpU8L/c7uC--
