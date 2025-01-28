Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F0DC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 05:21:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F09EB81870;
	Tue, 28 Jan 2025 06:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sYShc+dA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A21381875; Tue, 28 Jan 2025 06:21:12 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EC3F812BB
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 06:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5L8Xn1131425
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2025 23:21:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738041668;
 bh=GkV9aVrP6sy1BEmRKI8tIaXFEDnYpz10gbV0JsuaHvY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sYShc+dAbmJ2OYYvhmBLF/+aLADe1LuyQJjbJAgy1cZWU1TxMuucTAsQHYHMjH3o4
 sonGb0ENwgDnkKU8Ef0TYmRL8NXWelQCnSV62mMX4aXK0bp7BEMfIo0jedfsXuca8O
 Btx0XoLTrgS6wQaKoM3wxE++dM7xJMz4ja57ucvo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50S5L8BZ041866
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Jan 2025 23:21:08 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Jan 2025 23:21:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Jan 2025 23:21:08 -0600
Received: from [10.249.140.248] ([10.249.140.248])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S5L4XE117271;
 Mon, 27 Jan 2025 23:21:05 -0600
Message-ID: <4427c7cf-2875-4255-95b4-14eb06cb9276@ti.com>
Date: Tue, 28 Jan 2025 10:51:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ram: k3-ddrss: Add support for a partial inline ECC
 region
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>, <bb@ti.com>,
 <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>, <sabiya.d@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-5-n-francis@ti.com>
 <23a92c96-106c-45d1-99a5-c74138016517@phytec.de>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <23a92c96-106c-45d1-99a5-c74138016517@phytec.de>
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

Hi Wadim

On 28-Jan-25 10:43 AM, Wadim Egorov wrote:
> Am 27.01.25 um 21:22 schrieb Neha Malcom Francis:
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
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> 
> I'm not sure what went wrong, but I had difficulties applying this 
> patch. I had to use git am --reject and manually resolve a few blocks.
> 

This shouldn't have been the case, sorry about that; probably I didn't 
base it on the latest tip; will rebase and send again.
> 
>> ---
>>   drivers/ram/k3-ddrss/k3-ddrss.c | 52 +++++++++++++++++++++++++++++++--
>>   1 file changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c 
>> b/drivers/ram/k3-ddrss/k3-ddrss.c
>> index ab46098adbf..ea2578cda58 100644
>> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
>> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
>> @@ -149,6 +149,7 @@ struct k3_ddrss_desc {
>>       lpddr4_obj *driverdt;
>>       lpddr4_config config;
>>       lpddr4_privatedata pd;
>> +    struct k3_ddrss_ecc_region ecc_range;
>>       struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
>>       u64 ecc_reserved_space;
>>       u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
>> @@ -711,6 +712,30 @@ static void 
>> k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
>>           ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
>>   }
>> +static void k3_ddrss_ddr_inline_ecc_base_size_calc(struct 
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
>> @@ -759,8 +784,11 @@ static void k3_ddrss_lpddr4_ecc_init(struct 
>> k3_ddrss_desc *ddrss)
>>   static int k3_ddrss_probe(struct udevice *dev)
>>   {
>> +    u64 end;
>>       int ret;
>>       struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
>> +    __maybe_unused struct k3_ddrss_data *ddrss_data = (struct 
>> k3_ddrss_data *)dev_get_driver_data(dev);
>> +    __maybe_unused struct k3_ddrss_ecc_region *range = 
>> &ddrss->ecc_range;
>>       debug("%s(dev=%p)\n", __func__, dev);
>> @@ -802,9 +830,27 @@ static int k3_ddrss_probe(struct udevice *dev)
>>           k3_ddrss_lpddr4_ecc_calc_reserved_mem(ddrss);
>> -        /* Always configure one region that covers full DDR space */
>> -        ddrss->ecc_regions[0].start = ddrss->ddr_bank_base[0] - 
>> ddrss->ddr_bank_base[0];
>> -        ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - 
>> ddrss->ecc_reserved_space;
>> +        k3_ddrss_ddr_inline_ecc_base_size_calc(range);
>> +        if (!range->range) {
>> +            /* Configure entire DDR space by default */
>> +            debug("%s: Defaulting to protecting entire DDR space 
>> using inline ECC\n",
>> +                  __func__);
>> +            ddrss->ecc_range.start = ddrss->ddr_bank_base[0];
>> +            ddrss->ecc_range.range = ddrss->ddr_ram_size - 
>> ddrss->ecc_reserved_space;
>> +        } else {
>> +            ddrss->ecc_range.start = range->start;
>> +            ddrss->ecc_range.range = range->range;
>> +        }
>> +
>> +        end = ddrss->ecc_range.start + ddrss->ecc_range.range;
>> +
>> +        if (end > (ddrss->ddr_ram_size - ddrss->ecc_reserved_space))
>> +            ddrss->ecc_regions[0].range = ddrss->ddr_ram_size - 
>> ddrss->ecc_reserved_space;
>> +        else
>> +            ddrss->ecc_regions[0].range = ddrss->ecc_range.range;
>> +
>> +        ddrss->ecc_regions[0].start = ddrss->ecc_range.start - 
>> ddrss->ddr_bank_base[0];
>> +
>>           k3_ddrss_lpddr4_ecc_init(ddrss);
>>       }
> 

-- 
Thanking You
Neha Malcom Francis
