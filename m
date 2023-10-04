Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2699E8FDD1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 08:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4EA86B75;
	Wed,  4 Oct 2023 10:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF10286B7E; Wed,  4 Oct 2023 10:15:53 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 0605286B68
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 10:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,199,1694703600"; 
 d="asc'?scan'208";a="178139784"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2023 17:15:47 +0900
Received: from [10.226.93.90] (unknown [10.226.93.90])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 221F341A1494;
 Wed,  4 Oct 2023 17:15:44 +0900 (JST)
Message-ID: <44532c66-f21c-c930-9ca7-963add3196db@bp.renesas.com>
Date: Wed, 4 Oct 2023 09:15:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-8-paul.barker.ct@bp.renesas.com>
 <cf94aea9-e750-8636-9f31-941617e8b8be@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH 07/16] clk: renesas: Add RZ/G2L CPG driver
In-Reply-To: <cf94aea9-e750-8636-9f31-941617e8b8be@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------5WKtDjUQ0wJDAJtmkKovObqK"
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
--------------5WKtDjUQ0wJDAJtmkKovObqK
Content-Type: multipart/mixed; boundary="------------no0ZNnhi4h14mW035iD3vrbw";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <44532c66-f21c-c930-9ca7-963add3196db@bp.renesas.com>
Subject: Re: [PATCH 07/16] clk: renesas: Add RZ/G2L CPG driver
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-8-paul.barker.ct@bp.renesas.com>
 <cf94aea9-e750-8636-9f31-941617e8b8be@mailbox.org>
In-Reply-To: <cf94aea9-e750-8636-9f31-941617e8b8be@mailbox.org>

--------------no0ZNnhi4h14mW035iD3vrbw
Content-Type: multipart/mixed; boundary="------------DxY4js5ZhZmfNFUtA6Av1oOO"

--------------DxY4js5ZhZmfNFUtA6Av1oOO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2023 13:56, Marek Vasut wrote:
> On 9/20/23 14:42, Paul Barker wrote:
>> This driver provides clock and reset control for the Renesas RZ/G2L
>> (R9A07G044) SoC. It consists of two parts:
>>
>> * driver code which is applicable to all SoCs in the RZ/G2L family
>>
>> * static data describing the clocks and resets which are specific to t=
he
>>    R9A07G044 SoC.
>>
>> clk_set_rate() and clk_get_rate() are implemented only for the clocks
>> that are actually used in u-boot.
>>
>> The CPG driver is marked with DM_FLAG_PRE_RELOC to ensure that its bin=
d
>> function is called before the SCIF (serial port) driver is probed. Thi=
s
>> is required so that we can de-assert the relevant reset signal during
>> the serial driver probe function.
>>
>> This patch is based on the corresponding Linux v6.5 driver.
>=20
> Same thing as 02/16..04/16 applies here.
>=20
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>   arch/arm/mach-rmobile/Kconfig       |   1 +
>>   arch/arm/mach-rmobile/Kconfig.rzg2l |   1 +
>>   drivers/clk/renesas/Kconfig         |   9 +
>>   drivers/clk/renesas/Makefile        |   2 +
>>   drivers/clk/renesas/r9a07g044-cpg.c | 384 +++++++++++++++++++++
>>   drivers/clk/renesas/rzg2l-cpg.c     | 502 ++++++++++++++++++++++++++=
++
>>   drivers/clk/renesas/rzg2l-cpg.h     | 318 ++++++++++++++++++
>>   7 files changed, 1217 insertions(+)
>>   create mode 100644 drivers/clk/renesas/r9a07g044-cpg.c
>>   create mode 100644 drivers/clk/renesas/rzg2l-cpg.c
>>   create mode 100644 drivers/clk/renesas/rzg2l-cpg.h
>>
>> diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kco=
nfig
>> index fd240832d83d..fc37f6c79e50 100644
>> --- a/arch/arm/mach-rmobile/Kconfig
>> +++ b/arch/arm/mach-rmobile/Kconfig
>> @@ -74,6 +74,7 @@ config RZG2L
>>   	imply MULTI_DTB_FIT_USER_DEFINED_AREA
>>   	imply SYS_MALLOC_F
>>   	imply RENESAS_SDHI
>> +	imply CLK_RZG2L
>=20
> Keep the list sorted
>=20
>>   	help
>>   	  Enable support for the Renesas RZ/G2L family of SoCs, including t=
he
>>   	  the RZ/G2L itself (based on the R9A07G044 SoC).
>> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobi=
le/Kconfig.rzg2l
>> index 266f82c18085..7d268e8c366a 100644
>> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
>> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
>> @@ -5,6 +5,7 @@ if RZG2L
>>  =20
>>   config R9A07G044L
>>   	bool "Renesas R9A07G044L SoC"
>> +	imply CLK_R9A07G044
>=20
> Why not CLK_R9A07G044L (with L at the end) ?

The driver will also support the RZ/G2LC (R9A07G044C) when support for
that SoC is added in a later patch series.

>=20
>>   	help
>>   	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
>>  =20
>> diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig=

>> index 437a82cd48be..927d62cf99a3 100644
>> --- a/drivers/clk/renesas/Kconfig
>> +++ b/drivers/clk/renesas/Kconfig
>> @@ -156,3 +156,12 @@ config CLK_R9A06G032
>>   	depends on CLK_RENESAS
>>   	help
>>   	  Enable this to support the clocks on Renesas R9A06G032 SoC.
>> +
>> +config CLK_RZG2L
>> +	bool "Renesas RZ/G2L family clock support"
>> +	depends on CLK_RENESAS
>> +	select DM_RESET
>> +
>> +config CLK_R9A07G044
>> +	bool "RZ/G2L (R9A07G044L) clock support"
>> +	depends on CLK_RZG2L
>> diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefi=
le
>> index 48373e61b901..df7e225e9ca4 100644
>> --- a/drivers/clk/renesas/Makefile
>> +++ b/drivers/clk/renesas/Makefile
>> @@ -23,3 +23,5 @@ obj-$(CONFIG_CLK_R8A779A0) +=3D r8a779a0-cpg-mssr.o
>>   obj-$(CONFIG_CLK_R8A779F0) +=3D r8a779f0-cpg-mssr.o
>>   obj-$(CONFIG_CLK_R8A779G0) +=3D r8a779g0-cpg-mssr.o
>>   obj-$(CONFIG_CLK_R9A06G032) +=3D r9a06g032-clocks.o
>> +obj-$(CONFIG_CLK_RZG2L) +=3D rzg2l-cpg.o
>> +obj-$(CONFIG_CLK_R9A07G044) +=3D r9a07g044-cpg.o
>> diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas=
/r9a07g044-cpg.c
>> new file mode 100644
>> index 000000000000..e215db7caf15
>> --- /dev/null
>> +++ b/drivers/clk/renesas/r9a07g044-cpg.c
>> @@ -0,0 +1,384 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * RZ/G2L CPG driver
>> + *
>> + * Copyright (C) 2021-2023 Renesas Electronics Corp.
>> + */
>> +
>> +#include <common.h>
>> +#include <dm/device.h>
>> +#include <dt-bindings/clock/r9a07g044-cpg.h>
>> +#include <linux/clk-provider.h>
>> +
>> +#include "rzg2l-cpg.h"
>> +
>> +/* Divider tables */
>> +static const struct clk_div_table dtable_1_8[] =3D {
>> +	{0, 1},
>> +	{1, 2},
>> +	{2, 4},
>> +	{3, 8},
>> +	{0, 0},
>> +};
>> +
>> +static const struct clk_div_table dtable_1_32[] =3D {
>> +	{0, 1},
>> +	{1, 2},
>> +	{2, 4},
>> +	{3, 8},
>> +	{4, 32},
>> +	{0, 0},
>> +};
>> +
>> +static const struct clk_div_table dtable_16_128[] =3D {
>> +	{0, 16},
>> +	{1, 32},
>> +	{2, 64},
>> +	{3, 128},
>> +	{0, 0},
>> +};
>> +
>> +/* Mux clock tables */
>> +static const char * const sel_pll3_3[] =3D { ".pll3_533", ".pll3_400"=
 };
>> +static const char * const sel_pll5_4[] =3D { ".pll5_foutpostdiv", ".p=
ll5_fout1ph0" };
>> +static const char * const sel_pll6_2[]	=3D { ".pll6_250", ".pll5_250"=
 };
>=20
> Is this mixed tabs and spaces here ?
>=20
> (please fix this in Linux too)

I've tried to minimize changes between the u-boot and Linux drivers, so
this mixed tabs/spaces issue, parenthesis around numbers in defines,
etc, is an exact copy of what was accepted into the mainline kernel. The
hope is that we can more easily port fixes from Linux to u-boot if the
code remains as similar as possible.

>=20
>> +static const char * const sel_shdi[] =3D { ".clk_533", ".clk_400", ".=
clk_266" };
>> +static const char * const sel_gpu2[] =3D { ".pll6", ".pll3_div2_2" };=

>=20
> [...]
>=20
>> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg=
2l-cpg.c
>=20
> [...]
>=20
>> +static int rzg2l_cpg_clk_set(struct clk *clk, bool enable)
>> +{
>> +	struct rzg2l_cpg_data *data =3D
>> +		(struct rzg2l_cpg_data *)dev_get_driver_data(clk->dev);
>> +	unsigned int cpg_clk_id =3D CPG_CLK_ID(clk->id);
>> +	const struct rzg2l_mod_clk *mod_clk =3D NULL;
>> +	u32 value;
>> +	unsigned int i;
>> +
>> +	dev_dbg(clk->dev, "%s %s clock %u\n", enable ? "enable" : "disable",=

>> +		is_mod_clk(clk->id) ? "module" : "core", cpg_clk_id);
>> +	if (!is_mod_clk(clk->id)) {
>> +		dev_err(clk->dev, "ID %lu is not a module clock\n", clk->id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	for (i =3D 0; i < data->info->num_mod_clks; i++) {
>> +		if (data->info->mod_clks[i].id =3D=3D cpg_clk_id) {
>> +			mod_clk =3D &data->info->mod_clks[i];
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!mod_clk) {
>> +		dev_err(clk->dev, "Module clock %u not found\n", cpg_clk_id);
>> +		return -ENODEV;
>> +	}
>> +
>> +	value =3D (BIT(mod_clk->bit) << 16);
>=20
> Parenthesis not needed around this statement.

This one is my mistake - I forgot to remove the brackets when I
simplified this expression. Will fix in v2.

>=20
>> +	if (enable)
>> +		value |=3D BIT(mod_clk->bit);
>> +	writel(value, data->base + mod_clk->off);
>> +
>> +	if (enable && readl_poll_timeout(data->base + CLK_MON_R(mod_clk->off=
),
>> +					 value, (value & BIT(mod_clk->bit)),
>> +					 10)) {
>> +		dev_err(clk->dev, "Timeout\n");
>> +		return -ETIMEDOUT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rzg2l_cpg_clk_enable(struct clk *clk)
>> +{
>> +	return rzg2l_cpg_clk_set(clk, true);
>> +}
>> +
>> +static int rzg2l_cpg_clk_disable(struct clk *clk)
>> +{
>> +	return rzg2l_cpg_clk_set(clk, false);
>> +}
>> +
>> +static int rzg2l_cpg_clk_of_xlate(struct clk *clk,
>> +				  struct ofnode_phandle_args *args)
>> +{
>> +	struct rzg2l_cpg_data *data =3D
>> +		(struct rzg2l_cpg_data *)dev_get_driver_data(clk->dev);
>> +	u32 cpg_clk_type, cpg_clk_id;
>> +	bool found =3D false;
>> +	unsigned int i;
>> +
>> +	if (args->args_count !=3D 2) {
>> +		dev_dbg(clk->dev, "Invalid args_count: %d\n", args->args_count);
>> +		return -EINVAL;
>> +	}
>> +
>> +	cpg_clk_type =3D args->args[0];
>> +	cpg_clk_id =3D args->args[1];
>> +
>> +	switch (cpg_clk_type) {
>> +	case CPG_CORE:
>=20
> Is this copied from RCAR clock driver ?
>=20
> Can this be deduplicated someohw ?

This isn't copied from the RCAR driver. In Linux the RZ/G2L family CPG
drivers are separate to the RCAR clock drivers as there are too many
differences to easily combine them.

Thanks,
Paul
--------------DxY4js5ZhZmfNFUtA6Av1oOO
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------DxY4js5ZhZmfNFUtA6Av1oOO--

--------------no0ZNnhi4h14mW035iD3vrbw--

--------------5WKtDjUQ0wJDAJtmkKovObqK
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR0fLwUDAAAAAAAKCRDbaV4Vf/JGvcZC
AQCbabnz3oMUDx+u1M3Kk6mIreI7NYYqwe5cqUeG1w9ozwD+Mxh48L+RudeaC/+mgCvCm7756YNV
P8TQM5JrtKpPRwI=
=cml/
-----END PGP SIGNATURE-----

--------------5WKtDjUQ0wJDAJtmkKovObqK--
