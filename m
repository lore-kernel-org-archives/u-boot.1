Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3DCE8FDDB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E5686E79;
	Wed,  4 Oct 2023 11:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A7986DB5; Wed,  4 Oct 2023 11:18:49 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id C983286B03
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,199,1694703600"; 
 d="asc'?scan'208";a="178147591"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 04 Oct 2023 18:18:44 +0900
Received: from [10.226.93.90] (unknown [10.226.93.90])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 69A9941B4B69;
 Wed,  4 Oct 2023 18:18:42 +0900 (JST)
Message-ID: <4ee54918-cb7f-b6e1-a712-31b613c4f8ea@bp.renesas.com>
Date: Wed, 4 Oct 2023 10:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 14/16] arm: rmobile: Support RZ/G2L memory map
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
 <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
From: Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------070J2AtVHcTUvWevjPEPgxiy"
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
--------------070J2AtVHcTUvWevjPEPgxiy
Content-Type: multipart/mixed; boundary="------------NTn0oeAeG4UHBwC8FT06zfe3";
 protected-headers="v1"
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <4ee54918-cb7f-b6e1-a712-31b613c4f8ea@bp.renesas.com>
Subject: Re: [PATCH 14/16] arm: rmobile: Support RZ/G2L memory map
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-15-paul.barker.ct@bp.renesas.com>
 <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>
In-Reply-To: <78e94ddb-3708-12f8-9466-31a8a912d607@mailbox.org>

--------------NTn0oeAeG4UHBwC8FT06zfe3
Content-Type: multipart/mixed; boundary="------------fp0tL5R8mfV6DcsMrW1uonMG"

--------------fp0tL5R8mfV6DcsMrW1uonMG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/10/2023 14:32, Marek Vasut wrote:
> On 9/20/23 14:42, Paul Barker wrote:
>> The memory map for the RZ/G2L family differs from that of previous R-C=
ar
>> gen3/gen4 SoCs.
>=20
> Gen3 / Gen4
>=20
>> A high level memory map can be seen in figure 5.2 (section 5.2.1) of t=
he
>> RZ/G2L data sheet rev 1.30 published May 12, 2023. A summary is includ=
ed
>> here (note that this is a 34-bit address space):
>>    * 0x0_0000_0000 - 0x0_0002_FFFF SRAM area
>>    * 0x0_0003_0000 - 0x0_0FFF_FFFF Reserved area
>>    * 0x0_1000_0000 - 0x0_1FFF_FFFF I/O register area
>>    * 0x0_2000_0000 - 0x0_2FFF_FFFF SPI Multi area
>>    * 0x0_3000_0000 - 0x0_3FFF_FFFF Reserved area
>>    * 0x0_4000_0000 - 0x1_3FFF_FFFF DDR area (4 GiB)
>>    * 0x1_4000_0000 - 0x3_FFFF_FFFF Reserved area
>>
>> Within the DDR area, the first 128 MiB are reserved by TrustedFirmware=
=2E
>>
>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> ---
>>   arch/arm/mach-rmobile/Makefile       |   8 +-
>>   arch/arm/mach-rmobile/memmap-rzg2l.c | 115 +++++++++++++++++++++++++=
++
>>   2 files changed, 119 insertions(+), 4 deletions(-)
>>   create mode 100644 arch/arm/mach-rmobile/memmap-rzg2l.c
>>
>> diff --git a/arch/arm/mach-rmobile/Makefile b/arch/arm/mach-rmobile/Ma=
kefile
>> index 45d6a0e2a28a..ff8b0c7bae25 100644
>> --- a/arch/arm/mach-rmobile/Makefile
>> +++ b/arch/arm/mach-rmobile/Makefile
>> @@ -10,11 +10,11 @@ obj-$(CONFIG_DISPLAY_BOARDINFO) +=3D board.o
>>   obj-$(CONFIG_TMU_TIMER) +=3D ../../sh/lib/time.o
>>   obj-$(CONFIG_R8A7740) +=3D lowlevel_init.o cpu_info-r8a7740.o pfc-r8=
a7740.o
>>   obj-$(CONFIG_RCAR_GEN2) +=3D lowlevel_init_ca15.o cpu_info-rcar.o
>> -obj-$(CONFIG_RCAR_64) +=3D lowlevel_init_gen3.o memmap-gen3.o
>> -obj-$(CONFIG_RCAR_GEN3) +=3D cpu_info-rcar.o
>> -obj-$(CONFIG_RCAR_GEN4) +=3D cpu_info-rcar.o
>> +obj-$(CONFIG_RCAR_64) +=3D lowlevel_init_gen3.o
>> +obj-$(CONFIG_RCAR_GEN3) +=3D cpu_info-rcar.o memmap-gen3.o
>> +obj-$(CONFIG_RCAR_GEN4) +=3D cpu_info-rcar.o memmap-gen3.o
>>   obj-$(CONFIG_RZ_G2) +=3D cpu_info-rzg.o
>> -obj-$(CONFIG_RZG2L) +=3D cpu_info-rzg2l.o
>> +obj-$(CONFIG_RZG2L) +=3D cpu_info-rzg2l.o memmap-rzg2l.o
>>  =20
>>   ifneq ($(CONFIG_R8A779A0),)
>>   obj-$(CONFIG_ARMV8_PSCI) +=3D psci-r8a779a0.o
>> diff --git a/arch/arm/mach-rmobile/memmap-rzg2l.c b/arch/arm/mach-rmob=
ile/memmap-rzg2l.c
>> new file mode 100644
>> index 000000000000..d0509424fb73
>> --- /dev/null
>> +++ b/arch/arm/mach-rmobile/memmap-rzg2l.c
>> @@ -0,0 +1,115 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Renesas RZ/G2L family memory map tables
>> + *
>> + * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
>> + * Copyright (C) 2023 Renesas Electronics Corp.
>> + */
>> +
>> +#include <common.h>
>> +#include <asm/armv8/mmu.h>
>> +#include <asm/global_data.h>
>> +#include <cpu_func.h>
>> +
>> +#define RZG2L_NR_REGIONS 16
>> +
>> +/*
>> + * RZ/G2L supports up to 4 GiB RAM starting at 0x40000000, of
>> + * which the first 128 MiB is reserved by TF-A.
>> + */
>=20
> Are those 4 GiB continuous , or is there some "low" mem alias and then =

> full "high" mem above the 32bit barrier ?

This is a contiguous 4GB region, there's no aliased region on these SoCs.=


>=20
>> +static struct mm_region rzg2l_mem_map[RZG2L_NR_REGIONS] =3D {
>> +	{
>> +		.virt =3D 0x0UL,
>> +		.phys =3D 0x0UL,
>> +		.size =3D 0x40000000UL,
>> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +			 PTE_BLOCK_NON_SHARE |
>> +			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>> +	}, {
>> +		.virt =3D 0x40000000UL,
>> +		.phys =3D 0x40000000UL,
>> +		.size =3D 0x03F00000UL,
>> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +			 PTE_BLOCK_INNER_SHARE
>> +	}, {
>> +		.virt =3D 0x47E00000UL,
>=20
> What's this part about ?

This is copied from the RCar Gen3 memory map.

>=20
>> +		.phys =3D 0x47E00000UL,
>> +		.size =3D 0xF8200000UL,
>> +		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +			 PTE_BLOCK_INNER_SHARE
>> +	}, {
>> +		/* List terminator */
>> +		0,
>> +	}
>> +};
>> +
>> +struct mm_region *mem_map =3D rzg2l_mem_map;
>> +
>> +DECLARE_GLOBAL_DATA_PTR;
>> +
>> +#define debug_memmap(i, map) \
>> +	debug("memmap %d: virt 0x%llx -> phys 0x%llx, size=3D0x%llx, attrs=3D=
0x%llx\n", \
>> +	      i, map[i].virt, map[i].phys, map[i].size, map[i].attrs)
>> +
>> +void enable_caches(void)
>> +{
>> +	unsigned int bank, i =3D 0;
>> +	u64 start, size;
>> +
>> +	/* Create map for register access */
>> +	rzg2l_mem_map[i].virt =3D 0x0ULL;
>> +	rzg2l_mem_map[i].phys =3D 0x0ULL;
>> +	rzg2l_mem_map[i].size =3D 0x40000000ULL;
>> +	rzg2l_mem_map[i].attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>> +				 PTE_BLOCK_NON_SHARE |
>> +				 PTE_BLOCK_PXN | PTE_BLOCK_UXN;
>> +	debug_memmap(i, rzg2l_mem_map);
>> +	i++;
>> +
>> +	/* Generate entries for DRAM in 32bit address space */
>> +	for (bank =3D 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
>> +		start =3D gd->bd->bi_dram[bank].start;
>> +		size =3D gd->bd->bi_dram[bank].size;
>> +
>> +		/* Skip empty DRAM banks */
>> +		if (!size)
>> +			continue;
>> +
>> +		/* Mark memory reserved by ATF as cacheable too. */
>> +		if (start =3D=3D 0x48000000) {
>> +			/* Unmark protection area (0x43F00000 to 0x47DFFFFF) */
>> +			rzg2l_mem_map[i].virt =3D 0x40000000ULL;
>> +			rzg2l_mem_map[i].phys =3D 0x40000000ULL;
>> +			rzg2l_mem_map[i].size =3D 0x03F00000ULL;
>> +			rzg2l_mem_map[i].attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +						 PTE_BLOCK_INNER_SHARE;
>> +			debug_memmap(i, rzg2l_mem_map);
>> +			i++;
>> +
>> +			start =3D 0x47E00000ULL;
>> +			size +=3D 0x00200000ULL;
>> +		}
>> +
>> +		rzg2l_mem_map[i].virt =3D start;
>> +		rzg2l_mem_map[i].phys =3D start;
>> +		rzg2l_mem_map[i].size =3D size;
>> +		rzg2l_mem_map[i].attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +					 PTE_BLOCK_INNER_SHARE;
>> +		debug_memmap(i, rzg2l_mem_map);
>> +		i++;
>> +	}
>=20
> Is this somehow copied from R-Car ? Can this be deduplicated ?

This is based on the R-Car memory map. We discussed internally whether
to modify memmap-gen3.c or create a separate memmap-rzg2l.c and decided
that it was safer not to change the known working code for R-Car systems.=


To merge the two, we'll need to add a few if(IS_ENABLED(CONFIG_RZG2L))
conditionals to memmap-gen3.c. I'm happy to do that if that's the
approach you'd prefer.

Thanks,
Paul
--------------fp0tL5R8mfV6DcsMrW1uonMG
Content-Type: application/pgp-keys; name="OpenPGP_0x27F4B3459F002257.asc"
Content-Disposition: attachment; filename="OpenPGP_0x27F4B3459F002257.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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3D
=3DsIIN
-----END PGP PUBLIC KEY BLOCK-----

--------------fp0tL5R8mfV6DcsMrW1uonMG--

--------------NTn0oeAeG4UHBwC8FT06zfe3--

--------------070J2AtVHcTUvWevjPEPgxiy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQSiu8gv1Xr0fIw/aoLbaV4Vf/JGvQUCZR0t8AUDAAAAAAAKCRDbaV4Vf/JGvQsC
AP4zgVX/ZVEihDvoj7G+2rd5kc5EpT+PuND7DPyfZ9W96AEAzYejvyXRs+KJho6GcwOLb3dwmfiA
UwE9huA109RncAY=
=i9S/
-----END PGP SIGNATURE-----

--------------070J2AtVHcTUvWevjPEPgxiy--
