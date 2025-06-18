Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8460CC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 13:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1337580E9A;
	Wed, 18 Jun 2025 15:51:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HIujQEM+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BC6D82CF4; Wed, 18 Jun 2025 15:51:51 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AD68006D
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 15:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55IDpkq5313639;
 Wed, 18 Jun 2025 08:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1750254706;
 bh=8Z2Vzn4f9emU90vD6qIBWNUbnbLZXV7oOdYiswnjjos=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=HIujQEM+MVq2pCJEa09e6pCeex8wEbO8A3RG/ZxEoaLAxsSSaOWfM6Axh+TNkIGXU
 CuycUBt3Srhldp5QFR2iTYe3ISbB/zutehia1uvVyaGJCOE8d17Pa8D+XCl5wGcKIr
 uJ9Cz8EqClfBUsgWfrBzv2/FtwLKh0QM0QltJNJo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55IDpk3c2796465
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 18 Jun 2025 08:51:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 18
 Jun 2025 08:51:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 18 Jun 2025 08:51:46 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55IDpgpo3808431;
 Wed, 18 Jun 2025 08:51:43 -0500
Message-ID: <4d0fe3dd-f7d8-47ea-9253-5b836a32e926@ti.com>
Date: Wed, 18 Jun 2025 19:21:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] mach-k3: add runtime memory carveouts for MMU table
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <afd@ti.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <b-liu@ti.com>, <nm@ti.com>, <bb@ti.com>
References: <20250617135844.2873701-1-anshuld@ti.com>
 <a7454d8d-5715-46e5-95e1-544d1fbee197@ti.com>
 <DAPMYRW1KA2N.15K3WJSU96ZS4@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <DAPMYRW1KA2N.15K3WJSU96ZS4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 6/18/2025 5:22 PM, Anshul Dalal wrote:
> On Wed Jun 18, 2025 at 3:56 PM IST, Udit Kumar wrote:
>> On 6/17/2025 7:28 PM, Anshul Dalal wrote:
>>> In u-boot we only provide a single MMU table for all k3 platforms,
>>> this does not scale for devices with reserved memory outside the range
>>> 0x9e780000 - 0xa0000000 (eg j722s[1]) or for devices with < 2GiB of
>>> memory (eg am62-SIP with 512MiB of RAM).
>> please avoid giving reference to internal HACKs
>>
> Got it :)
>
>>> To properly configure the MMU on various k3 platforms, the
>>> reserved-memory regions need to be queried at runtime from the
>>> device-tree and the MMU table should be updated accordingly.
>>>
>>> This patch adds the required fixups to the MMU table (during proper
>>> U-boot stage) by marking the reserved regions as non cacheable and
>>> keeping the remaining area as cacheable.
>>>
>>> For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
>>> is marked as cacheable i.e 0x80080000 to 0x88080000.
>>>
>>> The 128MiB size is chosen to allow for future use cases such as falcon
>>> boot from the A-Core SPL which would require loading kernel image from
>>> the SPL stage. This change also ensures the reserved memory regions that
>>> all exist past 0x88080000 are non cacheable preventing speculative
>>> accesses to those addresses.
>>>
>>> [1]:
>>> https://git.ti.com/cgit/ti-u-boot/ti-u-boot/tree/arch/arm/mach-k3/arm64/arm64-mmu.c?h=ti-u-boot-2025.01-next#n54
>>>
>>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>>> ---
>>> Changes for v3:
>>>    - Remove unused memory regions in SPL's map
>>>    - Add runtime addition of MMU entry for the framebuffer in SPL
>>>    - Refactor k3_mem_map_init to use standard u-boot APIs
>>>    - Unmap reserved-memory regions instead of keeping them uncached
>>> v2: https://lore.kernel.org/u-boot/20250610160833.1705534-1-anshuld@ti.com/
>>>
>>> Changes in v2:
>>> - Removed dependency to:
>>>     https://lore.kernel.org/u-boot/20250522150941.563959-1-anshuld@ti.com/
>>>
>>> v1: https://lore.kernel.org/u-boot/20250602120054.1466951-1-anshuld@ti.com/
>>> ---
>>>    arch/arm/mach-k3/arm64/arm64-mmu.c     | 191 +++++++++++++++++++++++--
>>>    arch/arm/mach-k3/include/mach/k3-ddr.h |   9 ++
>>>    board/ti/common/k3-ddr.c               |  10 ++
>>>    3 files changed, 197 insertions(+), 13 deletions(-)
>>>
> [snip]
>
>>> +int k3_mem_map_init(void)
>>> +{
>>> +	fdt_addr_t mem_base;
>>> +	fdt_size_t mem_size;
>>> +	struct fdt_resource dt_reserved[K3_MMU_REGIONS_COUNT],
>>> +		coalesced[K3_MMU_REGIONS_COUNT];
>>> +	int k3_map_idx = -EINVAL, ret, nodeoffset, subnode;
>>> +	void *blob = (void *)gd->fdt_blob;
>>> +	unsigned int carveout_len, i, j;
>>> +
>>> +	ret = fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
>>> +	if (ret) {
>>> +		pr_err("%s: Failed to fixup reserved node for tfa [%d]\n",
>>> +		       __func__, ret);
>>> +		return ret;
>>> +	}
>> [..]+
>> +	k3_mem_map[k3_map_idx] = (const struct mm_region){ 0 };
>> I assume you are looping over reserved -memory and adding to map..
>>
>> what if , we need some reserved memory as non-cached.
>>
>>
> Yes, here I loop over all the reserved regions and add the carveouts to
> the map after coalescing. So far the reserved regions are kept unmapped
> but that causes issues with remoteproc, I'll fix that in the next
> revision by marking them as non-cacheable instead.

you should check wrt device capability, If device is coherent then it 
can be as is

If device is non-coherent (we observed in J722s, still to confirm this) 
    then node should be

non-cacheable


>
>>> +
>>> +	return 0;
>>> +}
>>> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
>>> index 39e6725bb9b..0b164ebf5e6 100644
>>> --- a/arch/arm/mach-k3/include/mach/k3-ddr.h
>>> +++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
>>> @@ -8,10 +8,19 @@
>>>    
>>>    #include <spl.h>
>>>    
>>> +/* Number of mappable regions in the MMU page table */
>>> +#define K3_MMU_REGIONS_COUNT 32
>>> +
>> why 32 ?
> I just took it as a worst case scenario with assuming > 10
> reserved-memory nodes with no coalescing and two entries per node (one
> for the carveout and another for the non-cached entry as per above).
> The table size is 1KiB at the moment and I think it's a reasonable
> compromise.
>
>>>    int dram_init(void);
>>>    int dram_init_banksize(void);
>>>    
>>>    void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
>>>    void fixup_memory_node(struct spl_image_info *spl_image);
>>>    
>>> +/*
>>> + * Modifies the MMU memory map based on DDR size and reserved-memory
>>> + * nodes in DT
>>> + */
>>> +int k3_mem_map_init(void);
>>> +
>>>    #endif /* _K3_DDR_H_ */
>>> diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
>>> index a8425da8de5..ee882f62109 100644
>>> --- a/board/ti/common/k3-ddr.c
>>> +++ b/board/ti/common/k3-ddr.c
>>> @@ -7,6 +7,7 @@
>>>    #include <dm/uclass.h>
>>>    #include <k3-ddrss.h>
>>>    #include <spl.h>
>>> +#include <mach/k3-ddr.h>
>>>    
>>>    #include "k3-ddr.h"
>>>    
>>> @@ -14,6 +15,15 @@ int dram_init(void)
>>>    {
>>>    	s32 ret;
>>>    
>>> +	if (IS_ENABLED(CONFIG_ARM64) && xpl_phase() != PHASE_SPL) {
>>> +		ret = k3_mem_map_init();
>>> +		if (ret) {
>>> +			printf("%s: Error fixing up MMU memory map: %d\n",
>>> +			       __func__, ret);
>>> +			return ret;
>> If can not set MMU table, then should be Hang , no ?
> That I have deferred to the caller which is initcall in our case which
> will hang the board if dram_init fails.

ok


>
>>> +		}
>>> +	}
>>> +
>>>    	ret = fdtdec_setup_mem_size_base_lowest();
>>>    	if (ret)
>>>    		printf("Error setting up mem size and base. %d\n", ret);
