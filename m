Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B868C282EC
	for <u-boot@archiver.kernel.org>; Sat,  8 Mar 2025 14:55:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0440880050;
	Sat,  8 Mar 2025 15:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 471848058A; Sat,  8 Mar 2025 15:55:06 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 8972C8004F
 for <u-boot@lists.denx.de>; Sat,  8 Mar 2025 15:55:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: zO8+9RvBQqavi1cOH0j+rw==
X-CSE-MsgGUID: pf+sMM0rTuGC/6bW584PeA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 08 Mar 2025 23:54:58 +0900
Received: from [10.24.0.79] (unknown [10.24.0.79])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9BF30400B520;
 Sat,  8 Mar 2025 23:54:56 +0900 (JST)
Message-ID: <e317a09e-5ff6-47ae-bf9e-252c22b671e5@bp.renesas.com>
Date: Sat, 8 Mar 2025 14:54:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
Content-Language: en-GB
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
 <7ca4a573-c3b5-47b4-b5ee-76288ab6ec0c@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <7ca4a573-c3b5-47b4-b5ee-76288ab6ec0c@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------B0Yi4BNF4kkuhA8I9N38j0c5"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------B0Yi4BNF4kkuhA8I9N38j0c5
Content-Type: multipart/mixed; boundary="------------SZ9p4VTqxn3QBFRP0b2SYS0Q";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Message-ID: <e317a09e-5ff6-47ae-bf9e-252c22b671e5@bp.renesas.com>
Subject: Re: [PATCH 1/5] reset: rzg2l-usbphy-ctrl: Add new driver
References: <20250304163736.89326-1-paul.barker.ct@bp.renesas.com>
 <20250304163736.89326-2-paul.barker.ct@bp.renesas.com>
 <7ca4a573-c3b5-47b4-b5ee-76288ab6ec0c@mailbox.org>
In-Reply-To: <7ca4a573-c3b5-47b4-b5ee-76288ab6ec0c@mailbox.org>

--------------SZ9p4VTqxn3QBFRP0b2SYS0Q
Content-Type: multipart/mixed; boundary="------------LDEiRryBZDsl08E00Q09zzLh"

--------------LDEiRryBZDsl08E00Q09zzLh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 05/03/2025 20:05, Marek Vasut wrote:
> On 3/4/25 5:37 PM, Paul Barker wrote:
>=20
> [...]
>=20
>> +static int rzg2l_usbphy_ctrl_assert(struct reset_ctl *reset_ctl)
>> +{
>> +	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_priv(reset_ctl->dev)=
;
>> +	u32 val;
>> +
>> +	val =3D readl(priv->regs + RESET);
>> +	val |=3D reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
>=20
> u32 val =3D reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1;
>=20
>> +	/* If both ports are in reset, we can also place the PLL into reset.=
 */
>> +	if ((val & PHY_RESET_MASK) =3D=3D PHY_RESET_MASK)
>> +		val |=3D RESET_PLLRESET;
>=20
> setbits_le32(priv->regs + RESET, val);
>=20
>> +	writel(val, priv->regs + RESET);
>> +	return 0;
>> +}
>> +
>> +static int rzg2l_usbphy_ctrl_deassert(struct reset_ctl *reset_ctl)
>> +{
>> +	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_priv(reset_ctl->dev)=
;
>> +	u32 val;
>> +
>> +	val =3D readl(priv->regs + RESET);
>> +	val &=3D ~(reset_ctl->id ? PHY_RESET_PORT2 : PHY_RESET_PORT1);
>> +
>> +	/* If either port is out of reset, the PLL must also be out of reset=
=2E */
>> +	val |=3D RESET_SEL_PLLRESET;
>> +	val &=3D ~RESET_PLLRESET;
>> +
>> +	writel(val, priv->regs + RESET);
>=20
> clrsetbits_le32() please
>=20
>> +	return 0;
>> +}
>> +
>> +static int rzg2l_usbphy_ctrl_of_xlate(struct reset_ctl *reset_ctl,
>> +				      struct ofnode_phandle_args *args)
>> +{
>> +	if (args->args[0] >=3D NUM_PORTS)
>> +		return -EINVAL;
>> +
>> +	reset_ctl->id =3D args->args[0];
>> +	return 0;
>> +}
>> +
>> +struct reset_ops rzg2l_usbphy_ctrl_ops =3D {
>> +	.rst_assert =3D rzg2l_usbphy_ctrl_assert,
>> +	.rst_deassert =3D rzg2l_usbphy_ctrl_deassert,
>> +	.of_xlate =3D rzg2l_usbphy_ctrl_of_xlate,
>> +};
>> +
>> +static int rzg2l_usbphy_ctrl_probe(struct udevice *dev)
>> +{
>> +	struct rzg2l_usbphy_ctrl_priv *priv =3D dev_get_priv(dev);
>> +	struct reset_ctl rst;
>> +	int ret;
>> +
>> +	priv->regs =3D dev_read_addr(dev);
>> +
>> +	ret =3D reset_get_by_index(dev, 0, &rst);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to get reset line\n");
>=20
> It generally helps to include 'ret' value in the error messages, so=20
> users can immediately look up the error code and find out what is wrong=
,=20
> without recompiling U-Boot.
>=20
>> +		return ret;
>> +	}
>> +
>> +	ret =3D reset_deassert(&rst);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to de-assert reset line\n");
>=20
> DTTO
>=20
>> +		return ret;
>> +	}
>> +
>> +	/* put pll and phy into reset state */
>> +	setbits_le32(priv->regs + RESET,
>> +		     RESET_SEL_PLLRESET | RESET_PLLRESET | PHY_RESET_MASK);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct udevice_id rzg2l_usbphy_ctrl_ids[] =3D {
>> +	{ .compatible =3D "renesas,rzg2l-usbphy-ctrl", },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +U_BOOT_DRIVER(rzg2l_usbphy_ctrl) =3D {
>> +	.name           =3D "rzg2l_usbphy_ctrl",
>> +	.id             =3D UCLASS_RESET,
>> +	.of_match       =3D rzg2l_usbphy_ctrl_ids,
>> +	.probe          =3D rzg2l_usbphy_ctrl_probe,
>> +	.ops            =3D &rzg2l_usbphy_ctrl_ops,
>> +	.priv_auto      =3D sizeof(struct rzg2l_usbphy_ctrl_priv),
>> +};
>> diff --git a/include/renesas/rzg2l-usbphy.h b/include/renesas/rzg2l-us=
bphy.h
>> new file mode 100644
>> index 000000000000..1a46b585f170
>> --- /dev/null
>> +++ b/include/renesas/rzg2l-usbphy.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * RZ/G2L USB PHY common definitions
>> + *
>> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
>> + */
>> +
>> +#ifndef RENESAS_RZG2L_USBPHY_H
>> +#define RENESAS_RZG2L_USBPHY_H
>> +
>> +#include <fdtdec.h>
>> +
>> +struct rzg2l_usbphy_ctrl_priv {
>> +	fdt_addr_t regs;
>> +};
> If this structure isn't shared with any other drivers, inline it into=20
> drivers/reset/reset-rzg2l-usbphy-ctrl.c and drop the header file.

This structure is used by the VBUS regulator driver in patch 2 of this
series.

I'll fix the rest up in v2.

Thanks,

--=20
Paul Barker
--------------LDEiRryBZDsl08E00Q09zzLh
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------LDEiRryBZDsl08E00Q09zzLh--

--------------SZ9p4VTqxn3QBFRP0b2SYS0Q--

--------------B0Yi4BNF4kkuhA8I9N38j0c5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZ8xaPwUDAAAAAAAKCRDbaV4Vf/JGvT04
AP4zYN/d+1lYW5fPwS8ggu4VYqf0byV+co5kFEB3LH5+RwEA3YdfI9rxxD4K1BelFogLQt0p4flG
MI+2aCNAvV5duwo=
=8soy
-----END PGP SIGNATURE-----

--------------B0Yi4BNF4kkuhA8I9N38j0c5--
