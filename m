Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598B9C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 06:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80011831D3;
	Tue, 12 Aug 2025 08:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RMwnbSTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE013831E1; Tue, 12 Aug 2025 08:22:43 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83174831C2
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 08:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57C6McvZ1368277;
 Tue, 12 Aug 2025 01:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1754979758;
 bh=qnaEquV3+FBTsjnWTQNkYP31uG0iXwRpYclHL1mCVzo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RMwnbSTdkJ6w9RGbQlYkKn9sAZCgw26FFa1hPtBA2V8A+xcxMkoMmc3bIdIwFDzmE
 2pZEkvG9O2551/EYoPkRacFqqX6QVEvvEixpZ+VwhjOGg/at2s6LbvhdjgBvjrx/dr
 Mv8vcrtnMvtPO2eZfgo6T5+pl8AaMllyU3stcVJA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57C6McJg032620
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 12 Aug 2025 01:22:38 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 12
 Aug 2025 01:22:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 12 Aug 2025 01:22:38 -0500
Received: from [172.24.235.200]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.235.200])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57C6MZwr4094538;
 Tue, 12 Aug 2025 01:22:36 -0500
Message-ID: <e6659d0c-7c6a-4781-b943-3042abf509b3@ti.com>
Date: Tue, 12 Aug 2025 11:52:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] ram: k3-ddrss: Add support for a partial inline
 ECC region
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <bb@ti.com>,
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>
References: <20250730133720.3315478-1-n-francis@ti.com>
 <20250730133720.3315478-5-n-francis@ti.com>
 <18c2739f-f8ce-47d1-b44b-283f9177f90b@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <18c2739f-f8ce-47d1-b44b-283f9177f90b@ti.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Udit,

On 07/08/25 10:16, Kumar, Udit wrote:
> 
> On 7/30/2025 7:07 PM, Neha Malcom Francis wrote:
>> Instead of defaulting to choosing the entire DDR region when enabling
>> inline ECC, allow picking of a range within the DDR space using DT to
>> enable.
>>
>> It expects such a node within the memory node, in the absence of which
>> we resort to enabling inline ECC for the entire DDR region:
>>
>> inline_ecc: protected@9e780000 {
>>          device_type = "ecc";
>>          reg = <0x9e780000 0x0080000>;
>>          bootph-all;
>> };
> 
> Please mention , where you expect this node to available in all
> controller nodes or just one controller (in case of multiple controllers)
> 

This is not part of the memorycontroller node; it is a subnode of the
memory/ node.

> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   drivers/ram/k3-ddrss/k3-ddrss.c | 55 +++++++++++++++++++++++++++++++--
>>   1 file changed, 52 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c
>> b/drivers/ram/k3-ddrss/k3-ddrss.c
>> index a94755c3542..cd117d7eba7 100644
>> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
>> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>> @@ -155,6 +155,7 @@ struct k3_ddrss_desc {
>>       lpddr4_obj *driverdt;
>>       lpddr4_config config;
>>       lpddr4_privatedata pd;
>> +    struct k3_ddrss_ecc_region ecc_range;
>>       struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REG];
>>       u64 ecc_reserved_space;
>>       u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
>> @@ -733,6 +734,30 @@ static void k3_ddrss_ddr_reg_init(struct
>> k3_ddrss_desc *ddrss)
>>       writel(DDRSS_ECC_CTRL_REG_DEFAULT, ddrss->ddrss_ss_cfg +
>> DDRSS_ECC_CTRL_REG);
>>   }
>>   +static void k3_ddrss_ddr_inline_ecc_base_size_calc(struct
>> k3_ddrss_ecc_region *range)
>> +{
>> +    fdt_addr_t base;
>> +    fdt_size_t size;
>> +    ofnode node1;
>> +
>> +    node1 = ofnode_null();
>> +
>> +    do {
>> +        node1 = ofnode_by_prop_value(node1, "device_type", "ecc", 4);
>> +    } while (!ofnode_is_enabled(node1));
>> +
> 
> Depending where you expect node to available, parsing logic may change a
> little

As mentioned above, it will always be in a single place i.e. memory/
node. The distribution to the different memory controllers is handled by
the driver.

> 
> 
>> +    base = ofnode_get_addr_size(node1, "reg", &size);
>> +
>> +    if (base == FDT_ADDR_T_NONE) {
>> +        debug("%s: Failed to get ECC node reg and size\n", __func__);
>> +        range->start = 0;
>> +        range->range = 0;
>> +    } else {
>> +        range->start = base;
>> +        range->range = size;
>> +    }
>> +}
>> +
>>   static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct
>> k3_ddrss_desc *ddrss)
>>   {
>>       fdtdec_setup_mem_size_base_lowest();
>> @@ -782,8 +807,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct
>> k3_ddrss_desc *ddrss)
>>     static int k3_ddrss_probe(struct udevice *dev)
>>   {
>> +    u64 end;
>>       int ret;
>>       struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
>> +    __maybe_unused u32 ddr_ram_size, ecc_res;
> 
> ddr_ram_size may go above u32
> 
>> +    __maybe_unused struct k3_ddrss_ecc_region *range =
>> &ddrss->ecc_range;
>>         debug("%s(dev=%p)\n", __func__, dev);
>>   @@ -821,9 +849,30 @@ static int k3_ddrss_probe(struct udevice *dev)
>>             k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
>>   -        /* Always configure one region that covers full DDR space */
>> -        ddrss->ecc_regions[0].start = 0;
>> -        ddrss->ecc_regions[0].range = ddrss->ddr_ram_size -
>> ddrss->ecc_reserved_space;
> 
> patch 1/8 is remove here, please check if you really need 1/8 ?
> 

1/8 still changes what ddrss->ecc_regions[0].start implies. So the call
to k3_ddrss_set_ecc_range_r0 is also changed there.
> 
>> +        k3_ddrss_ddr_inline_ecc_base_size_calc(range);
>> +
>> +        end = ddrss->ecc_range.start + ddrss->ecc_range.range;
>> +        ddr_ram_size = ddrss->ddr_ram_size;
>> +        ecc_res = ddrss->ecc_reserved_space;
>> +
>> +        if (!range->range) {
>> +            /* Configure entire DDR space by default */
>> +            debug("%s: Defaulting to protecting entire DDR space
>> using inline ECC\n",
>> +                  __func__);
>> +            ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
>> +            ddrss->ecc_range.range = ddr_ram_size - ecc_res;
>> +        } else {
>> +            ddrss->ecc_range.start = range->start;
>> +            ddrss->ecc_range.range = range->range;
>> +        }
>> +
> 
> Please add comment here for below code .
> 
> I think you are trying to fix, if end goes above one ddr

Yes will add comments here, thanks for the review!

> 
>> +        if (end > (ddr_ram_size - ecc_res))
>> +            ddrss->ecc_regions[0].range = ddr_ram_size - ecc_res;
>> +        else
>> +            ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
>> +
>> +        ddrss->ecc_regions[0].start = ddrss->ecc_range.start -
>> ddrss->ddr_bank_base[0];
>> +
>>           k3_ddrss_lpddr4_ecc_init(ddrss);
>>       }
>>   

-- 
Thanking You
Neha Malcom Francis
