Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F2EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C1584AE9;
	Wed,  1 Jul 2026 11:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nqAGXKZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8B9A84B64; Wed,  1 Jul 2026 11:55:21 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD238847C3
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B3126001D;
 Wed,  1 Jul 2026 09:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB4D1F00A3A;
 Wed,  1 Jul 2026 09:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782899718;
 bh=vitUXS6dtYdY93K9jv3fIlwdXumSirlDyxMQrawRuwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nqAGXKZsgGxv3v+44aZJ2ttewjRpgoLZttaYMIbMB/tsvF+9ESH4iOF+nh7jQi5Af
 yRyvCeJaE5gNeZ5mBOEV411h6lba95ISXAHNjUCXTEhFRrfyxKAxc2yB3iz2W0hD9R
 RBjm3AeitCv0Qu01wnzgyVRkCeKcTv6ZqzUQELLbdsDazbiZ2oDDeYP+APmmRFiAAU
 uCSJNjgSmC9IwPo8aoKkcbZa1u4T26BZD91pQ/W9fXh18GHHSZOQMmfqwtK44wfxap
 n+H58ruVuwXjRUybztloAdm6eTy5KFmvCwxk9CwH32bo2n9mgMcPfNJa0NwyYLtbQ8
 yOklL9R8up8jA==
Date: Wed, 1 Jul 2026 10:55:13 +0100
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
Subject: Re: [PATCH 4/8] rng: add Microchip PolarFire SoC hardware RNG driver
Message-ID: <20260701-task-dental-e3790f99a083@spud>
References: <20260625122325.834568-1-jamie.gibbons@microchip.com>
 <20260625122325.834568-5-jamie.gibbons@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q+1Mb2sR3MgliIFm"
Content-Disposition: inline
In-Reply-To: <20260625122325.834568-5-jamie.gibbons@microchip.com>
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

--Q+1Mb2sR3MgliIFm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 01:23:21PM +0100, Jamie Gibbons wrote:
> Add a U-Boot RNG driver for Microchip's PolarFire SoC (MPFS). The
> hardware RNG is accessed indirectly via the MPFS system controller using
> the mailbox interface.
>=20
> The driver implements the UCLASS_RNG interface, requesting random data
> from the system controller and returning it to the caller.
>=20
> This allows use of the PolarFire SoC hardware RNG via the
> standard 'rng' command and DM RNG API.
>=20
> Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>
> ---
>  configs/microchip_mpfs_generic_defconfig |   1 +
>  drivers/rng/Kconfig                      |   7 ++
>  drivers/rng/Makefile                     |   1 +
>  drivers/rng/mpfs_rng.c                   | 106 +++++++++++++++++++++++
>  4 files changed, 115 insertions(+)
>  create mode 100644 drivers/rng/mpfs_rng.c
>=20
> diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip=
_mpfs_generic_defconfig
> index 973ed09fa87..66acaad7e9b 100644
> --- a/configs/microchip_mpfs_generic_defconfig
> +++ b/configs/microchip_mpfs_generic_defconfig
> @@ -30,3 +30,4 @@ CONFIG_ENV_RELOC_GD_ENV_ADDR=3Dy
>  CONFIG_BOOTP_SEND_HOSTNAME=3Dy
>  CONFIG_DM_MTD=3Dy
>  CONFIG_SYSRESET=3Dy
> +CONFIG_DM_RNG=3Dy

Not entirely sure if this change should be in this patch, but turning on
RNG_MPFS seems like a good idea to me, not just DM_RNG?

> diff --git a/drivers/rng/Kconfig b/drivers/rng/Kconfig
> index 19b2b707677..856ffda2f5e 100644
> --- a/drivers/rng/Kconfig
> +++ b/drivers/rng/Kconfig
> @@ -23,6 +23,13 @@ config RNG_MESON
>  	  Enable support for hardware random number generator
>  	  of Amlogic Meson SoCs.
> =20
> +config RNG_MPFS
> +	tristate "Microchip PolarFire SoC Random Number Generator support"
> +	depends on DM_RNG && MPFS_SYSCONTROLLER
> +	help
> +	  Enable support for hardware random number generator
> +	  of Microchip's PolarFire SoCs.
> +
>  config RNG_SANDBOX
>  	bool "Sandbox random number generator"
>  	depends on SANDBOX
> diff --git a/drivers/rng/Makefile b/drivers/rng/Makefile
> index 30c58272d41..50622d4705f 100644
> --- a/drivers/rng/Makefile
> +++ b/drivers/rng/Makefile
> @@ -5,6 +5,7 @@
> =20
>  obj-$(CONFIG_$(PHASE_)DM_RNG) +=3D rng-uclass.o
>  obj-$(CONFIG_RNG_MESON) +=3D meson-rng.o
> +obj-$(CONFIG_RNG_MPFS) +=3D mpfs_rng.o
>  obj-$(CONFIG_RNG_SANDBOX) +=3D sandbox_rng.o
>  obj-$(CONFIG_RNG_MSM) +=3D msm_rng.o
>  obj-$(CONFIG_RNG_NPCM) +=3D npcm_rng.o
> diff --git a/drivers/rng/mpfs_rng.c b/drivers/rng/mpfs_rng.c
> new file mode 100644
> index 00000000000..61bd520d8a2
> --- /dev/null
> +++ b/drivers/rng/mpfs_rng.c
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Microchip's PolarFire SoC (MPFS) System Controller Driver
> + *
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + *
> + * Author: Jamie Gibbons <jamie.gibbons@microchip.com>
> + *
> + */
> +
> +#include <dm.h>
> +#include <dm/device.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <linux/printk.h>
> +#include <mailbox.h>
> +#include <malloc.h>
> +#include <mpfs-mailbox.h>
> +#include <rng.h>
> +#include <string.h>
> +
> +#define CMD_OPCODE						0x21
> +#define CMD_DATA_SIZE					0U
> +#define CMD_DATA						NULL
> +#define MBOX_OFFSET						0U
> +#define RESP_OFFSET						0U
> +#define RNG_RESP_BYTES					32U
> +
> +/**
> + * struct mpfs_rng_priv - Structure representing System Controller data.
> + * @mpfs_syscontroller_priv:	System Controller
> + */
> +struct mpfs_rng_priv {
> +	struct mpfs_syscontroller_priv *sys_controller;
> +};
> +
> +static int mpfs_rng_read(struct udevice *dev, void *data, size_t len)
> +{
> +	struct mpfs_rng_priv *rng_priv =3D dev_get_priv(dev);
> +	u32 response_msg[RNG_RESP_BYTES / sizeof(u32)];
> +	size_t count =3D 0, copy_size;
> +	int ret;
> +
> +	struct mpfs_mss_response response =3D {
> +		.resp_status =3D 0U,
> +		.resp_msg =3D (u32*)response_msg,
> +		.resp_size =3D RNG_RESP_BYTES,
> +	};
> +	struct mpfs_mss_msg msg =3D {
> +		.cmd_opcode =3D CMD_OPCODE,
> +		.cmd_data_size =3D CMD_DATA_SIZE,
> +		.response =3D &response,
> +		.cmd_data =3D CMD_DATA,
> +		.mbox_offset =3D MBOX_OFFSET,
> +		.resp_offset =3D RESP_OFFSET,
> +	};
> +
> +	while (count < len) {
> +		ret =3D mpfs_syscontroller_run_service(rng_priv->sys_controller, &msg);
> +		if (ret =3D=3D -EBUSY)
> +			return 0;
> +		if (ret)
> +			return ret;

With patch 7, isn't this redundant because there's no longer any chance
of getting an -EBUSY anymore?

> +
> +		ret =3D mpfs_syscontroller_recv_response(rng_priv->sys_controller, &ms=
g, 1000);
> +		if (ret =3D=3D -EBUSY)
> +			return 0;
> +		if (ret)
> +			return ret;
> +
> +		copy_size =3D (len - count > RNG_RESP_BYTES) ? RNG_RESP_BYTES : (len -=
 count);
> +		memcpy((u8 *)data + count, response_msg, copy_size);
> +		count +=3D copy_size;
> +	}
> +
> +	return len;
> +}
> +
> +static int mpfs_rng_probe(struct udevice *dev)
> +{
> +	struct mpfs_rng_priv *rng_priv =3D dev_get_priv(dev);
> +
> +	rng_priv->sys_controller =3D mpfs_syscontroller_get(dev->parent);
> +	if (IS_ERR(rng_priv->sys_controller)) {
> +		dev_err(dev, "Failed to get system controller\n");
> +		return PTR_ERR(rng_priv->sys_controller);
> +	}
> +
> +	dev_info(dev, "Registered MPFS hwrng\n");

This seems like a development printout that can be dropped?

Cheers,
Conor.

> +	return 0;
> +}
> +
> +static const struct dm_rng_ops mpfs_rng_ops =3D {
> +	.read =3D mpfs_rng_read,
> +};
> +
> +U_BOOT_DRIVER(mpfs_rng) =3D {
> +	.name           =3D "mpfs_rng",
> +	.id             =3D UCLASS_RNG,
> +	.probe          =3D mpfs_rng_probe,
> +	.priv_auto	    =3D sizeof(struct mpfs_rng_priv),
> +	.ops            =3D &mpfs_rng_ops,
> +};
> --=20
> 2.43.0
>=20

--Q+1Mb2sR3MgliIFm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakTkAQAKCRB4tDGHoIJi
0gIGAQDnCXXyS32WjicCdfdbcd80W+rGz/CT769rUFNpisVllAD5AdGaZMP3sJ2M
an06vmze80glcZCOROMQ53ka4+UjTQ8=
=gDsX
-----END PGP SIGNATURE-----

--Q+1Mb2sR3MgliIFm--
