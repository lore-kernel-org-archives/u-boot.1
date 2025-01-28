Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A4DC0218D
	for <u-boot@archiver.kernel.org>; Tue, 28 Jan 2025 06:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F402B8197D;
	Tue, 28 Jan 2025 07:35:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Z61FqleH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B68819B1; Tue, 28 Jan 2025 07:35:12 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B212A81727
 for <u-boot@lists.denx.de>; Tue, 28 Jan 2025 07:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50S6Z70e1140100
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 28 Jan 2025 00:35:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738046107;
 bh=XtWJBUq0K7+o5OztrY64v4Y9Z/Q2PFVh82vpRy4m2iw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Z61FqleHD8on2nwEGSf5jWHZKY1WEL2jLpKi1I7NL/vPbcoMMm+ZHF2KIy+D/cu48
 PyH2ijYZXIzB2V1ORGhTk4crL5+58v4uY4fp8OLO7V/qjS/YuME/bDpm+CHN66xeSv
 ZMWTLyfKlRLA4eQ5RoqaRF6/B3RZr8Dt8W0L343o=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S6Z7q0069748;
 Tue, 28 Jan 2025 00:35:07 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Jan 2025 00:35:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Jan 2025 00:35:07 -0600
Received: from [10.249.140.248] ([10.249.140.248])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50S6Z3m4096329;
 Tue, 28 Jan 2025 00:35:04 -0600
Message-ID: <00c46e51-0ce1-439d-8499-858ecc97f4ad@ti.com>
Date: Tue, 28 Jan 2025 12:05:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] ram: k3-ddrss: Add support for a partial inline ECC
 region
To: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>, <bb@ti.com>,
 <w.egorov@phytec.de>, <s-k6@ti.com>, <marek.vasut+renesas@mailbox.org>
CC: <u-boot@lists.denx.de>
References: <20250127142217.1757300-1-n-francis@ti.com>
 <20250127142217.1757300-5-n-francis@ti.com>
 <56685ea7-23da-49d5-88ec-2ee4c2bffc04@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <56685ea7-23da-49d5-88ec-2ee4c2bffc04@ti.com>
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

Hi Udit

On 28-Jan-25 11:23 AM, Kumar, Udit wrote:
> 
> On 1/27/2025 7:52 PM, Neha Malcom Francis wrote:
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
> is this possible to have ECC on different part of memory ?
> 
> i mean, protect 0x9e780000 + 0x0080000
> 
> and then 0xa000_0000 + 0x0080000

This hasn't been tested, and it won't work with this series presently. I 
can take it up later once the base functionality is taken in.

> 
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
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
> Do you really need ecc_range variable ? if not please thing of using 
> ddrss->ecc_regions[0]
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

-- 
Thanking You
Neha Malcom Francis
