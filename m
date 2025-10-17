Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA55CCD195
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 12:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2199683710;
	Fri, 17 Oct 2025 14:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sLK3RUxy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA00837E4; Fri, 17 Oct 2025 14:47:21 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC3583655
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 14:47:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59HClBXM270462;
 Fri, 17 Oct 2025 07:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760705231;
 bh=2J7t25cuMoiJkFyYjzFtK4u/gewrsTmgDxGlU/fpLy4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sLK3RUxyaseT1R9Bg6zk/BFiSQ1Z6XUAikSMKX/CGAIm2Q8TMzPNIT+eqjWNkbhuT
 AhMn9aVfxn00559Bbm4xZ5L4eFtCpQqdeePz9L0kv2f8v0vmtXeHZRoDz1mSk0TDJI
 C0XhYJo5EmZR7yVUC7mZtK+FiN85dajO3ZwcQgfQ=
Received: from DFLE203.ent.ti.com (dfle203.ent.ti.com [10.64.6.61])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59HClBQV2001396
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 17 Oct 2025 07:47:11 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 17 Oct
 2025 07:47:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 17 Oct 2025 07:47:10 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59HCl9HC1314224;
 Fri, 17 Oct 2025 07:47:10 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Oct 2025 18:17:09 +0530
Message-ID: <DDKLWVUX1CPJ.3EMPE1DELU070@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal
 <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <xypron.glpk@gmx.de>
Subject: Re: [PATCH v10 05/11] arm: armv8: mmu: add mem_map_from_dram_banks
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251010134424.3835757-1-anshuld@ti.com>
 <20251010134424.3835757-6-anshuld@ti.com>
 <CAC_iWj+pyDhYnaJE+eX8LP+Czu13+oH+H1XfMbH4wWgVqY6k2w@mail.gmail.com>
In-Reply-To: <CAC_iWj+pyDhYnaJE+eX8LP+Czu13+oH+H1XfMbH4wWgVqY6k2w@mail.gmail.com>
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

Hello Ilias,

On Fri Oct 17, 2025 at 5:39 PM IST, Ilias Apalodimas wrote:
> Hi Anshul,
>
> On Fri, 10 Oct 2025 at 16:44, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
>> the MMU as part of mmu_setup.
>>
>> But since the exact configuration of memory banks might not be known at
>> build time, many platforms such as imx9, versal2 etc. utilize
>> gd->bd->bi_dram to configure the static map at runtime.
>>
>> Therefore this patch adds a new API mem_map_from_dram_banks that
>> modifies the static map in a similar way. Allowing the caller to map all
>> dram banks by just passing the index to last entry in their mem_map and
>> it's length.
>>
>> Reviewed-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> Tested-by: Wadim Egorov <w.egorov@phytec.de>
>> ---
>>  arch/arm/cpu/armv8/cache_v8.c    | 28 ++++++++++++++++++++++++++++
>>  arch/arm/include/asm/armv8/mmu.h | 11 +++++++++++
>>  2 files changed, 39 insertions(+)
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
>> index 74c78cb2fb0..9b3c37dae82 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -58,6 +58,34 @@ static int get_effective_el(void)
>>         return el;
>>  }
>>
>> +int mem_map_from_dram_banks(unsigned int index, unsigned int len, u64 a=
ttrs)
>> +{
>> +       unsigned int i;
>> +       int ret =3D fdtdec_setup_memory_banksize();
>> +
>> +       if (ret) {
>> +               log_err("%s: Failed to setup dram banks\n", __func__);
>> +               return ret;
>> +       }
>> +
>> +       if (index + CONFIG_NR_DRAM_BANKS >=3D len) {
>> +               log_err("%s: Provided mem_map array has insufficient siz=
e for DRAM entries\n",
>> +                       __func__);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> +               mem_map[index].virt =3D gd->bd->bi_dram[i].start;
>> +               mem_map[index].phys =3D gd->bd->bi_dram[i].start;
>> +               mem_map[index].size =3D gd->bd->bi_dram[i].size;
>> +               mem_map[index].attrs =3D attrs;
>> +               index++;
>> +       }
>> +
>> +       memset(&mem_map[index], 0, sizeof(mem_map[index]));
>> +
>> +       return 0;
>> +}
>
> Is there a reason we add all the memory maps now and remove them later
> with mmu_unmap_reserved_mem(). IOW we could add the DT parsing in this
> function and not map the 'no-map' addresses to begin with.
> Unless someone changes the DTB on the fly ?
>

There are two reasons for doing it this way:

1. Modifying mem_map directly makes creating multiple carveouts quite
complex with the logic for handling all the edge cases, for example see
v4[1] of this series. It's much simpler to use the MMU APIs instead
after calling mmu_setup with everything mapped in mem_map.

2. We can't blindly unmap all 'no-map' regions since some regions that
would be 'no-map' in the kernel's context are required at U-Boot, like
the memory pools for remote cores that rely on U-Boot to load their
firmware.

Regards,
Anshul
