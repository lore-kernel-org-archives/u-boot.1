Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFADDC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 05:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01739886B3;
	Thu, 30 May 2024 07:01:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="zNTVarAp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC1D886B9; Thu, 30 May 2024 07:01:12 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9152C886A0
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 07:01:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U50xDC025740;
 Thu, 30 May 2024 00:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717045259;
 bh=lre3IBifVt+JBAkwl0FJy0QRKLJ/EdAYs59H+NB6EBY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=zNTVarApYSPxLRbG2Gkaf+pG/tVLTC2BRuexvmFw9PMYE563IAkZvBAyRQoEoVTis
 JTVZ0LUo6sz5UIBNtSDEpQCvkGjsL38rWtVXBN8jJg9a9Lu/ozZBqy8YmXXzDRiZdc
 fhSPx/5h6D1/CtJYaL4gk2q4vf3XZWsuwNPtMJyQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U50xOY073831
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 May 2024 00:00:59 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 00:00:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 00:00:59 -0500
Received: from [172.24.227.102]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U50snv073502;
 Thu, 30 May 2024 00:00:55 -0500
Message-ID: <0991620b-4c68-416f-aaf2-fb773a0e5779@ti.com>
Date: Thu, 30 May 2024 10:30:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arch: mach-k3: Introduce basic files to support
 J722S SoC family
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-10-j-choudhary@ti.com>
 <b2ce04a2-a50b-42bb-8421-b6bf4c426218@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <b2ce04a2-a50b-42bb-8421-b6bf4c426218@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello Andrew,

Thanks for the review.

On 29/05/24 20:47, Andrew Davis wrote:
> On 5/29/24 8:24 AM, Jayesh Choudhary wrote:
>> Introduce the basic functions and definitions needed to properly
>> initialize TI J722S family of SoCs.
>>
>> Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/mach-k3/Kconfig                      |   7 +-
>>   arch/arm/mach-k3/Makefile                     |   1 +
>>   arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>>   .../arm/mach-k3/include/mach/j722s_hardware.h |  83 ++++++
>>   arch/arm/mach-k3/include/mach/j722s_spl.h     |  49 ++++
>>   arch/arm/mach-k3/include/mach/spl.h           |   4 +
>>   arch/arm/mach-k3/j722s/Kconfig                |  32 ++
>>   arch/arm/mach-k3/j722s/Makefile               |   6 +
>>   arch/arm/mach-k3/j722s/j722s_init.c           | 277 ++++++++++++++++++
>>   9 files changed, 462 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm/mach-k3/include/mach/j722s_hardware.h
>>   create mode 100644 arch/arm/mach-k3/include/mach/j722s_spl.h
>>   create mode 100644 arch/arm/mach-k3/j722s/Kconfig
>>   create mode 100644 arch/arm/mach-k3/j722s/Makefile
>>   create mode 100644 arch/arm/mach-k3/j722s/j722s_init.c
>>
>> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
>> index 2bb970c2d4..f3f42b3921 100644
>> --- a/arch/arm/mach-k3/Kconfig
>> +++ b/arch/arm/mach-k3/Kconfig
>> @@ -25,6 +25,9 @@ config SOC_K3_J721E
>>   config SOC_K3_J721S2
>>       bool "TI's K3 based J721S2 SoC Family Support"
>> +config SOC_K3_J722S
>> +    bool "TI's K3 based J722S SoC Family Support"
>> +
>>   config SOC_K3_J784S4
>>       bool "TI's K3 based J784S4 SoC Family Support"
>> @@ -84,6 +87,7 @@ config SYS_K3_BOOT_PARAM_TABLE_INDEX
>>       default 0x43c3f290 if SOC_K3_AM62A7 && CPU_V7R
>>       default 0x7000f290 if SOC_K3_AM62A7 && ARM64
>>       default 0x43c4f290 if SOC_K3_AM62P5
>> +    default 0x43c7f290 if SOC_K3_J722S
>>       help
>>         Address at which ROM stores the value which determines if SPL
>>         is booted up by primary boot media or secondary boot media.
>> @@ -122,7 +126,7 @@ config K3_EARLY_CONS_IDX
>>   config K3_ATF_LOAD_ADDR
>>       hex "Load address of ATF image"
>> -    default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || 
>> SOC_K3_AM62P5)
>> +    default 0x80000000 if (SOC_K3_AM625 || SOC_K3_AM62A7 || 
>> SOC_K3_AM62P5 || SOC_K3_J722S)
> 
> You may need to fixup the DT if it uses the old address. You'll
> need to do the same as done for AM62p here:
> 
> https://patchwork.ozlabs.org/project/uboot/patch/20240520-am62p-fdt-fix-v1-1-49845dcb3667@ti.com/
> 
> Andrew

Will add this fixup in v2 series!

Warm Regards,
-Jayesh


[...]
