Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226A6CD98D2
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 13:54:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E1F583FEE;
	Sun, 14 Jun 2026 15:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BCB384105; Sun, 14 Jun 2026 15:54:32 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA4683EEF
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 15:54:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 3A54337002F4
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:54:28 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id F024FB4569D; Sun, 14 Jun 2026 13:54:26 +0000 (UTC)
Received: from collins (unknown [192.168.1.1])
 by laika.paulk.fr (Postfix) with ESMTPSA id A5655B45693;
 Sun, 14 Jun 2026 13:54:25 +0000 (UTC)
Date: Sun, 14 Jun 2026 15:54:22 +0200
From: Paul Kocialkowski <paulk@sys-base.io>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 =?utf-8?B?QW5kcsOp?= Przywara <andre.przywara@arm.com>,
 Cody Eksal <masterr3c0rd@epochal.quest>
Subject: Re: [PATCH] ARM: fdt: copy TF-A reserved memory into fdt passed to
 Linux
Message-ID: <ai6yjsgw-3hnNgNM@collins>
References: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HjHTlzpFI4/kasf+"
Content-Disposition: inline
In-Reply-To: <20260613204202.2360922-1-alexander.sverdlin@gmail.com>
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


--HjHTlzpFI4/kasf+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Le Sat 13 Jun 26, 22:41, Alexander Sverdlin a =C3=A9crit :
> Currently some ARM-based platforms reserve TF-A memory in their own ways:
> - Mediatek gets BL31 region via SMC call in ft_system_setup()
> - K3 uses CONFIG_K3_ATF_LOAD_ADDR, effectively in ft_system_setup()
>=20
> And others like Allwinner simply forget to do it, which results in Linux
> overwriting TF-A and crashing.

To be fair we've been adding the reserved memory regions statically in
the Linux device-trees to mitigate the issue.

But another thing we do overwrite current is the cpu idle states, which
are added by fdt_add_cpu_idle_states in tf-a. These are only set when the
SCP firmware is available (which is checked at run-time) and they are
never propagated to the final device-tree. Including the definitions
statically would result in cpu idle calls done even without the SCP
firmware, which would probably fail (although maybe some states can
still be supported).

Also note that the usual way to deal with this is to not load any
device-tree when booting the kernel, which will implicitly let U-Boot
use its current device-tree for Linux (with the modifications brought by
tf-a).

But of course I agree that it is very desirable to "forward" the
device-tree modifications to the kernel device-tree so we are not stuck
with whatever device-tree U-Boot was built with.

> Unfortunately seems that the things are not much better on TF-A side and
> there is no universal way to get the reserved memory region across
> platforms. But there is at least a most common way in TF-A, namely
> reserving  memory range in the FDT, in particular:
> - Allwinner	("tf-a@40000000" node)
> - ARM FPGA	("tf-a@80000000" node)
> - Xilinx	("tf-a" node)

RaspberryPi seems to be using "atf@0". Generally speaking the property
is a free-form argument to fdt_add_reserved_memory in tf-a and I don't
think we can have a common way to match them.

Introducing a Kconfig property for the prefix would be a satisfying
solution in my opinion.

> While this patch aims to improve the situation for Allwinner platforms,
> it's deliberately adding more generic code to pave the potential way of
> unification for other platforms.
>
> Note that fdtdec_add_reserved_memory() has a check for an already existing
> carveout with exactly matching boundaries and will not create a duplicate
> even if the name doesn't match. It would not however detect an already
> existing bigger carveout fully containing the one requested.
>
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> The patch has been developed to faciliate Allwinner A133 SoC support, whe=
re
> most of the work currently happens on TF-A [1] and Linux [2] sides, but
> I wanted to send this patch upfront to get the first feedback and because
> already supported H616 SoC would already benefit from the patch.

Thanks for looking at this!

Like I said, I guess the same needs to be done for the cpuidle psci
nodes.

> [1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/49754
> [2] https://lore.kernel.org/all/20260605070923.3045073-1-alexander.sverdl=
in@gmail.com/
> [3] https://lore.kernel.org/all/b428d57ba5464f1226daf099877f4c25fa4fc191.=
camel@gmail.com/
>=20
>  arch/arm/lib/bootm-fdt.c | 55 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/arch/arm/lib/bootm-fdt.c b/arch/arm/lib/bootm-fdt.c
> index 2671f9a0ebf..19d917943c1 100644
> --- a/arch/arm/lib/bootm-fdt.c
> +++ b/arch/arm/lib/bootm-fdt.c
> @@ -14,7 +14,9 @@
>   * Copyright (C) 2001  Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
>   */
> =20
> +#include <dm/ofnode.h>
>  #include <fdt_support.h>
> +#include <linux/ioport.h>
>  #ifdef CONFIG_ARMV7_NONSEC
>  #include <asm/armv7.h>
>  #endif
> @@ -24,6 +26,52 @@
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> +static int tfa_copy_reserved_memory(void *new_blob)

I would keep a fdt-related prefix to the name, so something like:
fdt_update_tfa_reserved_memory or
fdt_update_bl31_reserved_memory

> +{
> +#ifdef CONFIG_OF_CONTROL
> +	ofnode node, subnode;
> +
> +	/*
> +	 * TF-A for several platforms inserts its memory region as
> +	 * reserved-memory node

This will always be the case, I don't think we need a comment about it.

> +	 */
> +	node =3D ofnode_path("/reserved-memory");
> +	if (!ofnode_valid(node))
> +		return 0;
> +
> +	ofnode_for_each_subnode(subnode, node) {
> +		struct fdt_memory carveout;
> +		struct resource res;
> +		const char *name;
> +		int ret;
> +
> +		name =3D ofnode_get_name(subnode);
> +		if (!name)
> +			return -FDT_ERR_BADSTRUCTURE;
> +
> +		/* only handle TF-A reservations */

Please capitalize the first letter and end with a dot (same for all
comments).

> +		if (strncmp(name, "tf-a", 4))
> +			continue;
> +
> +		/* check if this subnode has a reg property */
> +		ret =3D ofnode_read_resource(subnode, 0, &res);
> +		if (ret)
> +			continue;
> +
> +		carveout.start =3D res.start,
> +		carveout.end =3D res.end,
> +
> +		ret =3D fdtdec_add_reserved_memory(new_blob, "tf-a", &carveout,
> +						 NULL, 0, NULL,
> +						 FDTDEC_RESERVED_MEMORY_NO_MAP);
> +		if (ret < 0)
> +			return ret;

Looks good otherwise.

> +	}
> +#endif
> +
> +	return 0;
> +}
> +
>  #ifdef CONFIG_FMAN_ENET
>  __weak int fdt_update_ethernet_dt(void *blob)
>  {
> @@ -56,6 +104,13 @@ int arch_fixup_fdt(void *blob)
>  		return ret;
>  #endif
> =20
> +	ret =3D tfa_copy_reserved_memory(blob);
> +	if (ret) {
> +		printf("ERROR: transfer of TF-A nodes to new fdt failed: %s\n",
> +		       fdt_strerror(ret));

This is very unlikely, not sure it is worth an error message.
Other calls in the same function are silent.

> +		return ret;
> +	}
> +
>  #ifdef CONFIG_ARMV8_SPIN_TABLE
>  	ret =3D spin_table_update_dt(blob);
>  	if (ret)
> --=20
> 2.54.0
>=20

All the best,

Paul

--=20
Paul Kocialkowski,

Independent contractor - sys-base - https://www.sys-base.io/
Free software developer - https://www.paulk.fr/

Expert in multimedia, graphics and embedded hardware support with Linux.

--HjHTlzpFI4/kasf+
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAmouso4ACgkQhP3B6o/u
lQzWEA/9G05dnAs4D+aw+dZp8eHyVnnosb3FGeEuI9I+2Z2Brt1jIq9Y1NO1rrld
fmKPAXVYiGvR/kXowgPg2vxPr08Hd1UoM7Bx6tkP9cHm9ckojNCe0w6F/zrUetZe
cHgSbpQt1t5WHM4mcMudHZ3kmP9tnYF3aPSI9U6QkZ9B/k2OslledPeJV6akVNFi
OgqUQL9YmU3Uwz0INrBDbkEmvsulKWdjCezOLkjMpJgYEGKVCTNUXwTBD35vicqw
+hqEAPB9Q0Bxq7u9Ligx1rvLXmZ71BbX+qbXmcvyqnsiptAW6Ffu7Q1CgZhh8s+i
GyYvncTWADw8viaQEFgyCiFsiyNGqduWwTssHQ5RigIsp/VSYtElvCvrsBv5PZg5
NrVue4xTlaIcW4qGxEOfHSNJCKYTr9qr0pAvK4SuKYENMNiwN7hl6fRiGPqdsXe8
fpvQuH8kmp4jRb10HKMAB/Au/h4E9mCEtzUqeIOfuY0hNSvZj40Kmb/RFgEp4/aQ
eMcTkZTP4co90si1KnW+wAZC4Wgd33+7YNmUVBLUQcbtEEyOfwhz0+WPMXLUAnsX
AG1ijS54ehE8djj9aj/190YnqcdivGubgB0mgtNcfGf65DWGAfhTV5qLvossqLMo
tjZPlJrypROzZqC18A+m8GzI+VoeeR464ZKhfRS9PdpIe+RRluI=
=axc8
-----END PGP SIGNATURE-----

--HjHTlzpFI4/kasf+--
