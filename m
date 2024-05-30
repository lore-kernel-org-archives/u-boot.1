Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F685C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 04:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45B3886A0;
	Thu, 30 May 2024 06:46:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VDUBqr2U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D300886A0; Thu, 30 May 2024 06:46:12 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A338869E
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 06:46:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U4jx3F081751;
 Wed, 29 May 2024 23:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717044360;
 bh=BIOYVS0dMURYzKsjBvb3zVUdJ4vXoWARALCsHccDCCM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VDUBqr2UMAE9WcE6dFAYXLxCk4GLAxCowhhGawni2kFd94Rk8mPc/Oj0Dlvpo4f/6
 5DFLfTwWDH/xlyMRt6AGh2+fj6umGqXPRI5TKGEqoJolQsjKOVTbh1/D+TH6fkbNV5
 8eiw52Xwtv+xhRoIprPzaCQE56sILysWlDmK47Lc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U4jxYb042189
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 23:45:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 23:45:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 23:45:59 -0500
Received: from [172.24.227.102]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U4jtPc049932;
 Wed, 29 May 2024 23:45:55 -0500
Message-ID: <c7e8a141-fd00-4d76-9415-6ebad531ffec@ti.com>
Date: Thu, 30 May 2024 10:15:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] soc: add info to identify the J722S SoC family
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <jh80.chung@samsung.com>, <lukma@denx.de>, <seanga2@gmail.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-4-j-choudhary@ti.com>
 <15dc7e43-53c7-44ca-8cfc-e075e99d64e3@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <15dc7e43-53c7-44ca-8cfc-e075e99d64e3@ti.com>
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

On 29/05/24 20:36, Andrew Davis wrote:
> On 5/29/24 8:24 AM, Jayesh Choudhary wrote:
>> Include the part number for TI's j722s family of SoC
>> to identify it during boot.
>>
>> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/mach-k3/include/mach/hardware.h | 2 ++
>>   drivers/soc/soc_ti_k3.c                  | 3 +++
>>   2 files changed, 5 insertions(+)
>>
>> diff --git a/arch/arm/mach-k3/include/mach/hardware.h 
>> b/arch/arm/mach-k3/include/mach/hardware.h
>> index c3aaded8dc..26c5bfcf76 100644
>> --- a/arch/arm/mach-k3/include/mach/hardware.h
>> +++ b/arch/arm/mach-k3/include/mach/hardware.h
>> @@ -55,6 +55,7 @@
>>   #define JTAG_ID_PARTNO_J7200    0xbb6d
>>   #define JTAG_ID_PARTNO_J721E    0xbb64
>>   #define JTAG_ID_PARTNO_J721S2    0xbb75
>> +#define JTAG_ID_PARTNO_J722S    0xbba0
> 
> All the others use tab, you used spaces here. Personally I like spaces
> for alignment, but unless you fix all the others, stick with tab for now.

Okay! Will fix it in v2.

-Jayesh

> 
>>   #define JTAG_ID_PARTNO_J784S4    0xbb80
>>   #define K3_SOC_ID(id, ID) \
>> @@ -72,6 +73,7 @@ K3_SOC_ID(am65x, AM65X)
>>   K3_SOC_ID(j7200, J7200)
>>   K3_SOC_ID(j721e, J721E)
>>   K3_SOC_ID(j721s2, J721S2)
>> +K3_SOC_ID(j722s, J722S)
>>   #define K3_SEC_MGR_SYS_STATUS        0x44234100
>>   #define SYS_STATUS_DEV_TYPE_SHIFT    0
>> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
>> index 0838808515..f948914d21 100644
>> --- a/drivers/soc/soc_ti_k3.c
>> +++ b/drivers/soc/soc_ti_k3.c
>> @@ -47,6 +47,9 @@ static const char *get_family_string(u32 idreg)
>>       case JTAG_ID_PARTNO_J721S2:
>>           family = "J721S2";
>>           break;
>> +    case JTAG_ID_PARTNO_J722S:
>> +        family = "J722S";
>> +        break;
>>       case JTAG_ID_PARTNO_J784S4:
>>           family = "J784S4";
>>           break;
