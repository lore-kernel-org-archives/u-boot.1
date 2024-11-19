Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE18D60D03
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FE7388DDD;
	Tue, 19 Nov 2024 01:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tO1VxaTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F8A89417; Tue, 19 Nov 2024 01:43:48 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8136088DC6
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0hjaR002690;
 Mon, 18 Nov 2024 18:43:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731977025;
 bh=i1fofp7Ei5lR3a+3IDJYDKcVXBVLx89pb5hBqo/eXDI=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=tO1VxaTkpWK12SCFSZVw5vKYdXTxfKaibA+dQ/X3nY7x2X7VlvCSY86ZxV9JOfZFa
 nTnIrhcOnxau3Nu4jJTCdpdCQ8WFJpiKOJD92toZKZ3HNmj1If+IJ3LgVzpcsDeuOp
 IzQ2XnvZsUy6YjB+wFcGTRzpcClR3gqdg1i6m/Og=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0hjsg034804
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 18:43:45 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 18:43:44 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 18:43:44 -0600
Received: from [10.249.132.3] ([10.249.132.3])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0hf5o126192;
 Mon, 18 Nov 2024 18:43:42 -0600
Message-ID: <ce44875d-1e62-429a-8331-a08f6f28bf2b@ti.com>
Date: Tue, 19 Nov 2024 06:13:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <nm@ti.com>, <n-francis@ti.com>
References: <20241116071615.839623-1-a-limaye@ti.com>
 <20241116071615.839623-6-a-limaye@ti.com>
 <20241118052450.ugme7qqbuyashqqf@uda0497581>
Content-Language: en-US
From: "Limaye, Aniket" <a-limaye@ti.com>
In-Reply-To: <20241118052450.ugme7qqbuyashqqf@uda0497581>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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



On 11/18/2024 10:54 AM, Manorit Chawdhry wrote:
> Hi Aniket,
> 
> On 12:45-20241116, Aniket Limaye wrote:
>> From: Reid Tonking <reidt@ti.com>
>>
>> Define new CONFIG_K3_OPP_LOW under arm/mach-k3/Kconfig and add default
>> value to j7200_evm_r5_defconfig
>>
>> Signed-off-by: Reid Tonking <reidt@ti.com>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>>
>> ---
>> v3:
>> - Add Kconfig dependency on K3_AVS0
>> - Update commit msg to make it more clear
>> - Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-6-a-limaye@ti.com/
>>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig       | 7 +++++++
> 
> Should this be in mach-k3/r5/Kconfig?
> 

Yeah makes sense to have it under mach-k3/r5/

>>   configs/j7200_evm_r5_defconfig | 1 +
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index f3f42b39213..c73396bfbf3 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -103,6 +103,13 @@ config SYS_K3_BOOT_CORE_ID
>>   	int
>>   	default 16
>>   
>> +config K3_OPP_LOW
>> +	depends on ARCH_K3 && K3_AVS0
>> +	bool "Enable OPP_LOW on supported TI K3 SoCs"
>> +	help
>> +	  Enabling this will allow Socs with the proper efuse to run at a lower
>> +	  MPU core voltage and adjust frequency according to SoC trm
> 
> nit: s/trm/TRM

Noted

Thanks for the detailed reviews!

Regards,
Aniket

> 
>> +
>>   config K3_EARLY_CONS
>>   	bool "Activate to allow for an early console during SPL"
>>   	depends on SPL
>> diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
>> index f036a6fd46b..217759e5d1b 100644
>> --- a/configs/j7200_evm_r5_defconfig
>> +++ b/configs/j7200_evm_r5_defconfig
>> @@ -102,6 +102,7 @@ CONFIG_K3_SEC_PROXY=y
>>   CONFIG_FS_LOADER=y
>>   CONFIG_SPL_FS_LOADER=y
>>   CONFIG_K3_AVS0=y
>> +# CONFIG_K3_OPP_LOW is not set
>>   CONFIG_SUPPORT_EMMC_BOOT=y
>>   CONFIG_SPL_MMC_HS400_SUPPORT=y
>>   CONFIG_MMC_SDHCI=y
>> -- 
>> 2.47.0
>>

