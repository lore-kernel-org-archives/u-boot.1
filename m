Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B800E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 14:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92786801B6;
	Thu, 12 Dec 2024 15:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B8N/6+bb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC1D801B6; Thu, 12 Dec 2024 15:40:13 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD1F801A0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 15:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEe8eb032913;
 Thu, 12 Dec 2024 08:40:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734014408;
 bh=zvEHM7vaIcD1dqU4EoEDWTdaYiJ47Ipb/IIR5t7+fJk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=B8N/6+bbkEToGKdvZb7r0jR/cbSGtjoFib33rpjvzaTwEFrZP3IgMNuIMlo8s4xVW
 6Cgov8dYOvfzt2HD/NtdRoCSk09N/HTlPOjhdECWg+2JngKxGtqzJF2+55jGhIW1Ia
 04840A0mZ9eNv9LTxIDEVlfsGZOckD1KtTI/eoBs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BCEe8kM020707
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Dec 2024 08:40:08 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Dec 2024 08:40:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Dec 2024 08:40:08 -0600
Received: from [172.24.227.241] (santhoshkumark.dhcp.ti.com [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BCEe5Lp028199; 
 Thu, 12 Dec 2024 08:40:05 -0600
Message-ID: <71d0df39-771c-49b2-aff9-78764d092157@ti.com>
Date: Thu, 12 Dec 2024 20:10:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] configs: j7*_evm_r5_defconfig: Set NR_DRAM_BANKS
 to 2
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, <w.egorov@phytec.de>,
 <n-francis@ti.com>, <s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
 <20241021044024.835846-7-s-k6@ti.com>
 <20241023144800.7vt4w24nllian4zv@bryanbrattlof.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20241023144800.7vt4w24nllian4zv@bryanbrattlof.com>
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

Hi, Bryan,

On 23/10/24 20:18, Bryan Brattlof wrote:
> On October 21, 2024 thus sayeth Santhosh Kumar K:
>> From: Neha Malcom Francis <n-francis@ti.com>
>>
>> Set CONFIG_NR_DRAM_BANKS to 2 as we have two banks described in the
>> memory/ node for lower and higher addressible DDR regions.
>>
>> This allows use of FDT functions from fdt_support.c to set up and fixup
>> the memory/ node correctly.
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   configs/j7200_evm_r5_defconfig  | 1 +
>>   configs/j721e_evm_r5_defconfig  | 1 +
>>   configs/j721s2_evm_r5_defconfig | 1 +
>>   configs/j784s4_evm_r5_defconfig | 1 +
>>   4 files changed, 4 insertions(+)
>>
>> diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
>> index 774a9eff439d..78dbd44f845f 100644
>> --- a/configs/j7200_evm_r5_defconfig
>> +++ b/configs/j7200_evm_r5_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
>>   CONFIG_SPL_GPIO=y
>>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
> 
> Should these go into Kconfig somewhere? These boards will always have 2
> DRAAM banks unless someone is artificially limiting DDR sizes.

Thanks for the suggestion. We can make it default at Kconfig.

Regards,
Santhosh.

> 
> 
>>   CONFIG_SOC_K3_J721E=y
>>   CONFIG_K3_EARLY_CONS=y
>>   CONFIG_TARGET_J7200_R5_EVM=y
>> diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
>> index 3b4a7c3c0eeb..dc391f14b193 100644
>> --- a/configs/j721e_evm_r5_defconfig
>> +++ b/configs/j721e_evm_r5_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x70000
>>   CONFIG_SPL_GPIO=y
>>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
>>   CONFIG_SOC_K3_J721E=y
>>   CONFIG_K3_EARLY_CONS=y
>>   CONFIG_K3_QOS=y
>> diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
>> index b6adb6a77d7e..374bc283be2d 100644
>> --- a/configs/j721s2_evm_r5_defconfig
>> +++ b/configs/j721s2_evm_r5_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x10000
>>   CONFIG_SPL_GPIO=y
>>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
>>   CONFIG_SOC_K3_J721S2=y
>>   CONFIG_K3_EARLY_CONS=y
>>   CONFIG_K3_QOS=y
>> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
>> index a11688194977..6fe36ab38f02 100644
>> --- a/configs/j784s4_evm_r5_defconfig
>> +++ b/configs/j784s4_evm_r5_defconfig
>> @@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x10000
>>   CONFIG_SPL_GPIO=y
>>   CONFIG_SPL_LIBCOMMON_SUPPORT=y
>>   CONFIG_SPL_LIBGENERIC_SUPPORT=y
>> +CONFIG_NR_DRAM_BANKS=2
>>   CONFIG_SOC_K3_J784S4=y
>>   CONFIG_K3_EARLY_CONS=y
>>   CONFIG_K3_QOS=y
>> -- 
>> 2.34.1
>>
