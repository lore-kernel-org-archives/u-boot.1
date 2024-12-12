Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C118E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04967801BD;
	Thu, 12 Dec 2024 15:40:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KdGdUih4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEE07801EB; Thu, 12 Dec 2024 15:40:32 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84218801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:40:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEeS2M2786184
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Dec 2024 08:40:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734014428;
 bh=GBbvb+h0ZsKzLFPxIMK1C3AKLaDf70hVElSqtgRkCxQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=KdGdUih4sU4Bcxg7LgZB+VfifuuSkyLLnLGoC91oBvbkMpwMlmBzcgg8i8fzD2Bh2
 +5fi1p2nXsAGYxuo2ZRuuP6lL1kNu9cRaJgYcSKQZ5v+c8kxcvUg3aWL9ghuYXqRlZ
 1JAXCgkV3KP5/LSSkPD0GOOAfpP4ydl5ut8P++2Q=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEeSMw110704
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Dec 2024 08:40:28 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Dec 2024 08:40:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Dec 2024 08:40:27 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEeOYd028519; 
 Thu, 12 Dec 2024 08:40:25 -0600
Message-ID: <2798a6cb-0117-4a0b-a17a-1355c1c4c0c0@ti.com>
Date: Thu, 12 Dec 2024 20:10:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] board: ti: Pull redundant DDR functions to a
 common location and Fixup DDR size when ECC is enabled
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, <vigneshr@ti.com>,
 <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-8-s-k6@ti.com>
 <94cc6dcf-fe92-414f-b5f6-5797c8fa64ff@phytec.de>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <94cc6dcf-fe92-414f-b5f6-5797c8fa64ff@phytec.de>
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

Hi, Wadim,

On 22/10/24 15:34, Wadim Egorov wrote:
> Hi Santhosh,
> 
> Am 21.10.24 um 06:40 schrieb Santhosh Kumar K:
>> As there are few redundant functions in board/ti/*/evm.c files, pull
>> them to a common location of access to reuse and include the common file
>> to access the functions.
>>
>> Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
>> device tree and resize the available amount of DDR, if ECC is enabled.
>> Otherwise, fixup the device tree using the regular
>> fdt_fixup_memory_banks().
>>
>> Also call dram_init_banksize() after every call to
>> fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
>> correctly.
>>
>> Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
>> controllers present.
>>
>> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
> <snip>
> 
>> +obj-y += common.o security.o k3-ddr.o
>>   obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
>>   obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
>>   obj-$(CONFIG_SOC_K3_AM625) += am62x/
>> diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h 
>> b/arch/arm/mach-k3/include/mach/k3-ddr.h
>> new file mode 100644
>> index 000000000000..754e9ba29dac
>> --- /dev/null
> <snip>
> 
>> +#include <fdt_support.h>
>> +#include <dm/uclass.h>
>> +#include <k3-ddrss.h>
>> +#include <spl.h>
>> +
>> +#include <asm/arch/k3-ddr.h>
>> +
>> +int dram_init(void)
>> +{
>> +        s32 ret;
>> +
>> +        ret = fdtdec_setup_mem_size_base_lowest();
>> +        if (ret)
>> +                printf("Error setting up mem size and base. %d\n", ret);
>> +
>> +        return ret;
>> +}
>> +
>> +int dram_init_banksize(void)
>> +{
>> +        s32 ret;
>> +
>> +        ret = fdtdec_setup_memory_banksize();
>> +        if (ret)
>> +                printf("Error setting up memory banksize. %d\n", ret);
>> +
>> +        return ret;
>> +}
>> +Moving dram_init() and dram_init_banksize() into a generic part forces 
> every K3 based board to use your implementation.
> 
> This also breaks the builds for phycore_am62x, phycore_am64x and also 
> the verdin-am62,
> 
>    phycore-am62x.c:49: multiple definition of `dram_init'
>    phycore-am62x.c:97: multiple definition of `dram_init_banksize

Oops, that's bad. I'll fix this in the next version.

Regards,
Santhosh.

> 
> Regards,
> Wadim
