Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40F1CAC582
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 06:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E388334F;
	Fri, 12 Sep 2025 08:38:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A0DFBcDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2B5833EB; Fri, 12 Sep 2025 08:38:40 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1920983322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 08:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C6cX82913100;
 Fri, 12 Sep 2025 01:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757659113;
 bh=RGHNvRgigXYmas0m8iT1RV/WYN8DPC2vPQXj9zrxUgg=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=A0DFBcDlByr4qM0WlZH+46kPGIzf6n6U3nULT4SnjLL5i2Zk1YNYzl2/SNyfWyrTC
 TmyoPiFxA/W7DT36ta+wxQuMUgc2TjtTV0GU7ySb9erjZRB0kyGsG/DcNXLrz1LRsb
 pL5865lOz0aKFoSejMLyUHBUt3uXqstLs8jBz2Tw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C6cXND2569499
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 12 Sep 2025 01:38:33 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 01:38:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 01:38:32 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C6cVUx3474846;
 Fri, 12 Sep 2025 01:38:32 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Sep 2025 12:08:30 +0530
Message-ID: <DCQM5KG6M5Q1.3POA3UVZ1J563@ti.com>
CC: <u-boot@lists.denx.de>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <a-nandan@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>
Subject: Re: [PATCH -next v6 05/10] arm: armv8: mmu: add mem_map_fix_dram_banks
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-6-anshuld@ti.com>
 <CAC_iWjJos1Xu0LWK4aqJ9aq2UZhor8uvnGRVg1xKs69HmnhP6A@mail.gmail.com>
In-Reply-To: <CAC_iWjJos1Xu0LWK4aqJ9aq2UZhor8uvnGRVg1xKs69HmnhP6A@mail.gmail.com>
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

Hi Ilias,

On Fri Sep 12, 2025 at 12:03 PM IST, Ilias Apalodimas wrote:
> Hi Anshul,
>
> On Fri, 5 Sept 2025 at 11:19, Anshul Dalal <anshuld@ti.com> wrote:
>>
>> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
>> the MMU as part of mmu_setup.
>>
>> But since the exact configuration of memory banks might not be known at
>> build time, many platforms such as imx9, versal2 etc. utilize
>> gd->bd->bi_dram to configure the static map at runtime.
>>
>> Therefore this patch adds a new API mem_map_fix_dram_banks that modifies
>> the static map in a similar way. Allowing for anyone to map all dram
>> banks by just passing the index to last entry in their mem_map and it's
>> length.
>>
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>> ---
>>  arch/arm/cpu/armv8/cache_v8.c    | 27 +++++++++++++++++++++++++++
>>  arch/arm/include/asm/armv8/mmu.h | 10 ++++++++++
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8=
.c
>> index 6e662395a83..edb895da1f2 100644
>> --- a/arch/arm/cpu/armv8/cache_v8.c
>> +++ b/arch/arm/cpu/armv8/cache_v8.c
>> @@ -58,6 +58,33 @@ static int get_effective_el(void)
>>         return el;
>>  }
>>
>> +int mem_map_fix_dram_banks(unsigned int index, unsigned int len, u64 at=
trs)
>> +{
>> +       unsigned int i;
>> +       int ret =3D fdtdec_setup_memory_banksize();
>> +
>> +       if (ret) {
>> +               printf("%s: Failed to setup dram banks\n", __func__);
>> +               return ret;
>> +       }
>> +
>> +       if (index + CONFIG_NR_DRAM_BANKS >=3D len) {
>> +               printf("%s: Not sufficient space in memory map\n", __fun=
c__);
>> +               return -ENOMEM;
>> +       }
>
> The length of the mem_map array is configured at compile time.
> So this is going to fail for all existing boards unless someone
> explicitly changes the size of their struct mm_region.
> I think if we go down that path, we need to change the error message
> as well and point them to the right direction
>
>> +
>> +       for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
>> +               mem_map[index].virt =3D gd->bd->bi_dram[i].start;
>> +               mem_map[index].phys =3D gd->bd->bi_dram[i].start;
>> +               mem_map[index].size =3D gd->bd->bi_dram[i].size;
>> +               mem_map[index].attrs =3D attrs;
>> +               index++;
>> +       }
>> +
>> +       mem_map[index] =3D (const struct mm_region){ 0 };
>
> Why do you need the const?
> Can we do
> memset(&mem_map[index], 0, sizeof(mem_map[index]));
> instead?
>

Yeah, we could do that instead. But it essentially achieves the same
thing, right?

Regards,
Anshul
