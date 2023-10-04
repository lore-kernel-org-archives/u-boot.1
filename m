Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DAFE7B5E1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:36:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286F687480;
	Wed,  4 Oct 2023 11:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEC387436; Wed,  4 Oct 2023 11:36:19 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id E7FE787445
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:36:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,199,1694703600"; 
 d="asc'?scan'208";a="181893019"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 04 Oct 2023 18:36:13 +0900
Received: from [10.226.93.90] (unknown [10.226.93.90])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 195F241C3C0A;
 Wed,  4 Oct 2023 18:36:10 +0900 (JST)
Message-ID: <52c1d2c3-9b43-9519-b014-02a107a4cc28@bp.renesas.com>
Date: Wed, 4 Oct 2023 10:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
 <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
In-Reply-To: <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------re0sOIhkTArtPGG9PaxZdvEl"
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
--------------re0sOIhkTArtPGG9PaxZdvEl
Content-Type: multipart/mixed; boundary="------------bHeq3MNh8aETCi2LCIkQPbnW";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <52c1d2c3-9b43-9519-b014-02a107a4cc28@bp.renesas.com>
Subject: Re: [PATCH 16/16] board: rzg2l: Add RZ/G2L SMARC EVK board
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-17-paul.barker.ct@bp.renesas.com>
 <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>
In-Reply-To: <37900365-9d1c-6248-635c-5f6566a08bfb@mailbox.org>

--------------bHeq3MNh8aETCi2LCIkQPbnW
Content-Type: multipart/mixed; boundary="------------VDfWUrnPbAiC570jHkgK9a0t"

--------------VDfWUrnPbAiC570jHkgK9a0t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2023 14:36, Marek Vasut wrote:
> On 9/20/23 14:42, Paul Barker wrote:
>> The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
>> System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common SMAR=
C
>> carrier board.
>>
>> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes =
a
>> devicetree blob to the bootloader as an argument in the same was
>> previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
>> which can be used to identify the particular SoC we are running on and=

>> this is used to select the appropriate device tree to load.
>>
>> The configuration renesas_rzg2l_smarc_defconfig is added to support
>> building for this target. In the future this defconfig will be extende=
d
>> to support other SoCs and evaluation boards from the RZ/G2L family.
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>   arch/arm/mach-rmobile/Kconfig.rzg2l   | 14 +++++
>>   board/renesas/rzg2l/Kconfig           | 18 +++++++
>>   board/renesas/rzg2l/MAINTAINERS       |  6 +++
>>   board/renesas/rzg2l/Makefile          |  4 ++
>>   board/renesas/rzg2l/rzg2l.c           | 76 +++++++++++++++++++++++++=
++
>>   configs/renesas_rzg2l_smarc_defconfig | 52 ++++++++++++++++++
>>   include/configs/rzg2l-smarc.h         | 14 +++++
>>   7 files changed, 184 insertions(+)
>>   create mode 100644 board/renesas/rzg2l/Kconfig
>>   create mode 100644 board/renesas/rzg2l/MAINTAINERS
>>   create mode 100644 board/renesas/rzg2l/Makefile
>>   create mode 100644 board/renesas/rzg2l/rzg2l.c
>>   create mode 100644 configs/renesas_rzg2l_smarc_defconfig
>>   create mode 100644 include/configs/rzg2l-smarc.h
>>
>> diff --git a/arch/arm/mach-rmobile/Kconfig.rzg2l b/arch/arm/mach-rmobi=
le/Kconfig.rzg2l
>> index 7d268e8c366a..1fe49e323300 100644
>> --- a/arch/arm/mach-rmobile/Kconfig.rzg2l
>> +++ b/arch/arm/mach-rmobile/Kconfig.rzg2l
>> @@ -9,6 +9,20 @@ config R9A07G044L
>>   	help
>>   	  Enable support for the R9A07G044L SoC used in the RZ/G2L.
>>  =20
>> +choice
>> +	prompt "Renesas RZ/G2L Family Board selection"
>> +	default TARGET_RZG2L_SMARC_EVK
>> +
>> +config TARGET_RZG2L_SMARC_EVK
>> +	bool "Renesas RZ/G2L SMARC EVK"
>> +	imply R9A07G044L
>> +	help
>> +	  Enable support for the RZ/G2L SMARC evaluation board.
>> +
>> +source "board/renesas/rzg2l/Kconfig"
>> +
>> +endchoice
>> +
>>   config MULTI_DTB_FIT_UNCOMPRESS_SZ
>>   	default 0x80000 if TARGET_RZG2L_SMARC_EVK
>>  =20
>> diff --git a/board/renesas/rzg2l/Kconfig b/board/renesas/rzg2l/Kconfig=

>> new file mode 100644
>> index 000000000000..1335fc7ae806
>> --- /dev/null
>> +++ b/board/renesas/rzg2l/Kconfig
>> @@ -0,0 +1,18 @@
>> +# Copyright (C) 2023 Renesas Electronics Corporation
>> +# SPDX-License-Identifier: GPL-2.0+
>> +
>> +if TARGET_RZG2L_SMARC_EVK
>> +
>> +config SYS_SOC
>> +	default "rmobile"
>> +
>> +config SYS_BOARD
>> +	default "rzg2l"
>> +
>> +config SYS_VENDOR
>> +	default "renesas"
>> +
>> +config SYS_CONFIG_NAME
>> +	default "rzg2l-smarc"
>> +
>> +endif
>> diff --git a/board/renesas/rzg2l/MAINTAINERS b/board/renesas/rzg2l/MAI=
NTAINERS
>> new file mode 100644
>> index 000000000000..0a51391c1fc9
>> --- /dev/null
>> +++ b/board/renesas/rzg2l/MAINTAINERS
>> @@ -0,0 +1,6 @@
>> +RENESAS RZG2L BOARD FAMILY
>> +M:	Paul Barker <paul.barker.ct@bp.renesas.com>
>> +S:	Supported
>> +F:	arch/arm/dts/rz-smarc-common.dtsi
>=20
> I suspect there should be more files here, right ?
> You likely want to be CCed on things like rzg2l clock, scif, and so on.=


The `N:` lines after this are regexps. Checking these after applying
this patch gives the expected behaviour, e.g.

=2E/scripts/get_maintainer.pl drivers/clk/renesas/rzg2l-cpg.c
Nobuhiro Iwamatsu <iwamatsu@nigauri.org> (maintainer:ARM RENESAS
RMOBILE/R-CAR)
Marek Vasut <marek.vasut+renesas@mailbox.org> (maintainer:ARM RENESAS
RMOBILE/R-CAR)
Lukasz Majewski <lukma@denx.de> (maintainer:CLOCK)
Sean Anderson <seanga2@gmail.com> (maintainer:CLOCK)
Paul Barker <paul.barker.ct@bp.renesas.com> (supporter:RENESAS RZG2L
BOARD FAMILY)
u-boot@lists.denx.de (open list)

>=20
>> +N:	rzg2l
>> +N:	r9a07g044
>> diff --git a/board/renesas/rzg2l/Makefile b/board/renesas/rzg2l/Makefi=
le
>> new file mode 100644
>> index 000000000000..466935fc8158
>> --- /dev/null
>> +++ b/board/renesas/rzg2l/Makefile
>> @@ -0,0 +1,4 @@
>> +# Copyright (C) 2023 Renesas Electronics Corporation
>> +# SPDX-License-Identifier: GPL-2.0+
>> +
>> +obj-y	:=3D rzg2l.o
>=20
>> diff --git a/board/renesas/rzg2l/rzg2l.c b/board/renesas/rzg2l/rzg2l.c=

>> new file mode 100644
>> index 000000000000..2b1bb3546c26
>> --- /dev/null
>> +++ b/board/renesas/rzg2l/rzg2l.c
>> @@ -0,0 +1,76 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * RZ/G2L board support.
>> + * Copyright (C) 2023 Renesas Electronics Corporation
>> + */
>> +
>> +#include <common.h>
>> +#include <fdtdec.h>
>> +#include <linux/libfdt.h>
>> +
>> +#if IS_ENABLED(CONFIG_MULTI_DTB_FIT)
>> +/* If the firmware passed a device tree, use it for board identificat=
ion. */
>> +extern u64 rcar_atf_boot_args[];
>> +
>> +static bool is_rzg2l_board(const char *board_name)
>> +{
>> +	void *atf_fdt_blob =3D (void *)(rcar_atf_boot_args[1]);
>> +
>> +	return fdt_node_check_compatible(atf_fdt_blob, 0, board_name) =3D=3D=
 0;
>> +}
>> +
>> +int board_fit_config_name_match(const char *name)
>> +{
>> +	void *atf_fdt_blob =3D (void *)(rcar_atf_boot_args[1]);
>> +
>> +	if (fdt_magic(atf_fdt_blob) !=3D FDT_MAGIC)
>> +		return -1;
>> +
>> +	if (is_rzg2l_board("renesas,r9a07g044l2"))
>> +		return strcmp(name, "r9a07g044l2-smarc");
>> +
>> +	return -1;
>> +}
>> +#endif
>> +
>> +static void apply_atf_overlay(void *fdt_blob)
>> +{
>> +	void *atf_fdt_blob =3D (void *)(rcar_atf_boot_args[1]);
>> +
>> +	if (fdt_magic(atf_fdt_blob) =3D=3D FDT_MAGIC)
>> +		fdt_overlay_apply_node(fdt_blob, 0, atf_fdt_blob, 0);
>> +}
>> +
>> +int fdtdec_board_setup(const void *fdt_blob)
>> +{
>> +	apply_atf_overlay((void *)fdt_blob);
>> +
>> +	return 0;
>> +}
>> +
>> +int ft_board_setup(void *blob, struct bd_info *bd)
>> +{
>> +	return 0;
>=20
> Are all these stub functions really needed or can they be removed=20
> (possibly also with removal of unnecessary config options) ?

ft_board_setup() could possibly be dropped - I had a line in here to
call apply_atf_overlay() but dropped it as further work is needed in
TrustedFirmware first.

The empty board_init() function is the same as in
board/renesas/rcar-common/common.c.

>=20
>> +}
>> +
>> +int __weak board_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +int dram_init(void)
>> +{
>> +	return fdtdec_setup_mem_size_base();
>> +}
>> +
>> +int dram_init_banksize(void)
>> +{
>> +	fdtdec_setup_memory_banksize();
>=20
> This and the one function above can likely go into arch/mach-rmobile/

We're not able to test every supported mach-rmobile board so we've
preferred to keep changes to RZ/G2L specific code where possible. I'm
happy to merge this into mach-rmobile (along with the similar code in
board/renesas/rcar-common/common.c), but it will only be tested on the
boards we have in our team.

>=20
>> +	return 0;
>> +}
>> +
>> +void __weak reset_cpu(void)
>> +{
>=20
> Is this platform missing a way to reset the system ?
> Please fix.

Adding reset support is on my todo list. I'm prioritising Ethernet
support above this right now, but we don't mind too much what order we
do things. Let me know if you'd prefer us to prioritise reset support.

Thanks,
Paul
--------------VDfWUrnPbAiC570jHkgK9a0t
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------VDfWUrnPbAiC570jHkgK9a0t--

--------------bHeq3MNh8aETCi2LCIkQPbnW--

--------------re0sOIhkTArtPGG9PaxZdvEl
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR0yCQUDAAAAAAAKCRDbaV4Vf/JGvR2a
AQDTxvMDjnTvEMs6Z2h5RN+iyvPuHpJFdqgTVJgVPlJj+AD+J05G0pn84M8gBYhw4FKBSXirl+Yo
7OhJ+5coAW+4Dwk=
=n/tH
-----END PGP SIGNATURE-----

--------------re0sOIhkTArtPGG9PaxZdvEl--
