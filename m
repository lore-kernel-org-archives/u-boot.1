Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04725C7115B
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 11:52:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32BEA82BCD;
	Wed, 18 Jun 2025 13:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J6iUrBZD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACBD882C55; Wed, 18 Jun 2025 13:52:49 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E313D82B20
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 13:52:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55IBqhaB099342;
 Wed, 18 Jun 2025 06:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750247563;
 bh=ECd5Oazd38GgBXdpNshuXzsPxXh9qHvMYTCCL2/HlHc=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=J6iUrBZDuUkdOzqEnAl1tcyB3rBdYLuYUFZNFliT2Y2vgtV5Mxva7YKq6w3g+nzak
 ENGWSt15Rmi06agFye70zhIT6081/zT8m2G+rOvModLpTQDkP3QPE+BprKw9+eiwMO
 tzbpGa6boGH3Nm96NZPfFG1UV5c9b8A3D4CfUE44=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55IBqhZa2713470
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 18 Jun 2025 06:52:43 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 18
 Jun 2025 06:52:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 18 Jun 2025 06:52:43 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55IBqg1S3652021;
 Wed, 18 Jun 2025 06:52:42 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 18 Jun 2025 17:22:02 +0530
Message-ID: <DAPMYRW1KA2N.15K3WJSU96ZS4@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>
Subject: Re: [PATCH v3 1/2] mach-k3: add runtime memory carveouts for MMU table
From: Anshul Dalal <anshuld@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250617135844.2873701-1-anshuld@ti.com>
 <a7454d8d-5715-46e5-95e1-544d1fbee197@ti.com>
In-Reply-To: <a7454d8d-5715-46e5-95e1-544d1fbee197@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed Jun 18, 2025 at 3:56 PM IST, Udit Kumar wrote:
>
> On 6/17/2025 7:28 PM, Anshul Dalal wrote:
>> In u-boot we only provide a single MMU table for all k3 platforms,
>> this does not scale for devices with reserved memory outside the range
>> 0x9e780000 - 0xa0000000 (eg j722s[1]) or for devices with < 2GiB of
>> memory (eg am62-SIP with 512MiB of RAM).
>
> please avoid giving reference to internal HACKs
>

Got it :)

>> To properly configure the MMU on various k3 platforms, the
>> reserved-memory regions need to be queried at runtime from the
>> device-tree and the MMU table should be updated accordingly.
>>
>> This patch adds the required fixups to the MMU table (during proper
>> U-boot stage) by marking the reserved regions as non cacheable and
>> keeping the remaining area as cacheable.
>>
>> For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
>> is marked as cacheable i.e 0x80080000 to 0x88080000.
>>
>> The 128MiB size is chosen to allow for future use cases such as falcon
>> boot from the A-Core SPL which would require loading kernel image from
>> the SPL stage. This change also ensures the reserved memory regions that
>> all exist past 0x88080000 are non cacheable preventing speculative
>> accesses to those addresses.
>>
>> [1]:
>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/tree/arch/arm/mach-k3/arm64/=
arm64-mmu.c?h=3Dti-u-boot-2025.01-next#n54
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>> Changes for v3:
>>   - Remove unused memory regions in SPL's map
>>   - Add runtime addition of MMU entry for the framebuffer in SPL
>>   - Refactor k3_mem_map_init to use standard u-boot APIs
>>   - Unmap reserved-memory regions instead of keeping them uncached
>> v2: https://lore.kernel.org/u-boot/20250610160833.1705534-1-anshuld@ti.c=
om/
>>
>> Changes in v2:
>> - Removed dependency to:
>>    https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com=
/
>>
>> v1: https://lore.kernel.org/u-boot/20250602120054.1466951-1-anshuld@ti.c=
om/
>> ---
>>   arch/arm/mach-k3/arm64/arm64-mmu.c     | 191 +++++++++++++++++++++++--
>>   arch/arm/mach-k3/include/mach/k3-ddr.h |   9 ++
>>   board/ti/common/k3-ddr.c               |  10 ++
>>   3 files changed, 197 insertions(+), 13 deletions(-)
>>

[snip]

>> +int k3_mem_map_init(void)
>> +{
>> +	fdt_addr_t mem_base;
>> +	fdt_size_t mem_size;
>> +	struct fdt_resource dt_reserved[K3_MMU_REGIONS_COUNT],
>> +		coalesced[K3_MMU_REGIONS_COUNT];
>> +	int k3_map_idx =3D -EINVAL, ret, nodeoffset, subnode;
>> +	void *blob =3D (void *)gd->fdt_blob;
>> +	unsigned int carveout_len, i, j;
>> +
>> +	ret =3D fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x800=
00);
>> +	if (ret) {
>> +		pr_err("%s: Failed to fixup reserved node for tfa [%d]\n",
>> +		       __func__, ret);
>> +		return ret;
>> +	}
>
> am62l3_fdt.c , needs more size.
>
> fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x200000)
>
>

The fdt_fixup_reserved actually handles these contingencies, if a
matching reserved region already exists it ignores the size we provided
and uses the size form the dt instead.

>> +
>> +	ret =3D fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR,
>> +				 0x1800000);
>> +	if (ret) {
>> +		pr_err("%s: Failed to fixup reserved node for optee [%d]\n",
>> +		       __func__, ret);
>> +		return ret;
>> +	}
>> +
>> +	nodeoffset =3D fdt_subnode_offset(blob, 0, "memory");
>> +	if (nodeoffset < 0) {
>> +		pr_err("%s: Failed to get memory data: %s\n", __func__,
>> +		       fdt_strerror(nodeoffset));
>> +		return nodeoffset;
>> +	}
>> +
>> +	mem_base =3D fdtdec_get_addr_size(blob, nodeoffset, "reg", &mem_size);
>> +	if (mem_base !=3D CFG_SYS_SDRAM_BASE)
>> +		return -EINVAL;
>> +
>> +	for (i =3D 0; i < K3_MMU_REGIONS_COUNT; i++) {
>> +		if (k3_mem_map[i].virt =3D=3D CONFIG_SPL_TEXT_BASE) {
>> +			k3_map_idx =3D i;
>> +			break;
>> +		}
>> +	}
>
> you can fix this entry at offset 0, instead of looping all over
>
>

We have to have some static nodes in the DT as well for peripherals,
flash etc. All the nodes that are added as part of this fixup append to
the table so as to not interfere with the already defined MMU entries.

If we move this entry to 0, appending to the table would overwrite the
existing entries that we do want.

>> +
>> +	if (k3_map_idx =3D=3D -EINVAL) {
>> +		pr_err("%s: Failed to find DDR region in MMU memory map\n",
>> +		       __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	i =3D 0;

[snip]

>> +	k3_mem_map[k3_map_idx].attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) |
>> +				       PTE_BLOCK_INNER_SHARE;
>> +	k3_map_idx++;
>> +
>> +	k3_mem_map[k3_map_idx] =3D (const struct mm_region){ 0 };
>
> I assume you are looping over reserved -memory and adding to map..
>
> what if , we need some reserved memory as non-cached.
>
>

Yes, here I loop over all the reserved regions and add the carveouts to
the map after coalescing. So far the reserved regions are kept unmapped
but that causes issues with remoteproc, I'll fix that in the next
revision by marking them as non-cacheable instead.

>> +
>> +	return 0;
>> +}
>> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/i=
nclude/mach/k3-ddr.h
>> index 39e6725bb9b..0b164ebf5e6 100644
>> --- a/arch/arm/mach-k3/include/mach/k3-ddr.h
>> +++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
>> @@ -8,10 +8,19 @@
>>  =20
>>   #include <spl.h>
>>  =20
>> +/* Number of mappable regions in the MMU page table */
>> +#define K3_MMU_REGIONS_COUNT 32
>> +
> why 32 ?

I just took it as a worst case scenario with assuming > 10
reserved-memory nodes with no coalescing and two entries per node (one
for the carveout and another for the non-cached entry as per above).
The table size is 1KiB at the moment and I think it's a reasonable
compromise.

>>   int dram_init(void);
>>   int dram_init_banksize(void);
>>  =20
>>   void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
>>   void fixup_memory_node(struct spl_image_info *spl_image);
>>  =20
>> +/*
>> + * Modifies the MMU memory map based on DDR size and reserved-memory
>> + * nodes in DT
>> + */
>> +int k3_mem_map_init(void);
>> +
>>   #endif /* _K3_DDR_H_ */
>> diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
>> index a8425da8de5..ee882f62109 100644
>> --- a/board/ti/common/k3-ddr.c
>> +++ b/board/ti/common/k3-ddr.c
>> @@ -7,6 +7,7 @@
>>   #include <dm/uclass.h>
>>   #include <k3-ddrss.h>
>>   #include <spl.h>
>> +#include <mach/k3-ddr.h>
>>  =20
>>   #include "k3-ddr.h"
>>  =20
>> @@ -14,6 +15,15 @@ int dram_init(void)
>>   {
>>   	s32 ret;
>>  =20
>> +	if (IS_ENABLED(CONFIG_ARM64) && xpl_phase() !=3D PHASE_SPL) {
>> +		ret =3D k3_mem_map_init();
>
>> +		if (ret) {
>> +			printf("%s: Error fixing up MMU memory map: %d\n",
>> +			       __func__, ret);
>> +			return ret;
> If can not set MMU table, then should be Hang , no ?

That I have deferred to the caller which is initcall in our case which
will hang the board if dram_init fails.

>> +		}
>> +	}
>> +
>>   	ret =3D fdtdec_setup_mem_size_base_lowest();
>>   	if (ret)
>>   		printf("Error setting up mem size and base. %d\n", ret);

