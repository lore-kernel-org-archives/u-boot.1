Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA1FC25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 11:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DADAD886E1;
	Thu, 30 May 2024 13:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Nf+dRA3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE771886E4; Thu, 30 May 2024 13:52:20 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3971E8864C
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 13:52:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UBqDhb026321;
 Thu, 30 May 2024 06:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717069933;
 bh=pWQiIQ9b0mVhRJvMoWof1hhETtFIuOa8er4OR+xP+aY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Nf+dRA3h2Jfiipri+JyzGmE/pJeB4cC3Q7g3N6Zwjt3P7PEWpac6WiRLXgpcUr2yl
 JCypxRfHLgQ3N/rF5gt6qnj0sNuREXP8gG8wO/7mtVUU3OUPMc0Ggpaj7uKlgB/w1g
 l/bMvFkHDUYPJgDXC6sZ7DtNjXlYinVT6HsEak8s=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UBqCff010432
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 May 2024 06:52:12 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 06:52:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 06:52:12 -0500
Received: from [172.24.227.102]
 (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UBq6bR022199;
 Thu, 30 May 2024 06:52:07 -0500
Message-ID: <5795080b-6ebc-477d-abd3-1935668a067b@ti.com>
Date: Thu, 30 May 2024 17:22:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] arm: mach-k3: j721e: Enable QoS for DSS
To: Andrew Davis <afd@ti.com>, <trini@konsulko.com>
CC: <a-bhatia1@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <joao.goncalves@toradex.com>, <j-humphreys@ti.com>,
 <d.haller@phytec.de>, <hnagalla@ti.com>, <bb@ti.com>,
 <seanga2@gmail.com>, <sjg@chromium.org>, <clamor95@gmail.com>,
 <martyn.welch@collabora.com>, <m-chawdhry@ti.com>, <a-limaye@ti.com>,
 <sebin.francis@ti.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>
References: <20240522113726.302908-1-j-choudhary@ti.com>
 <20240522113726.302908-3-j-choudhary@ti.com>
 <e5ef2268-a992-4ef6-8447-7d2d94580104@ti.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <e5ef2268-a992-4ef6-8447-7d2d94580104@ti.com>
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

On 22/05/24 21:14, Andrew Davis wrote:
> On 5/22/24 6:37 AM, Jayesh Choudhary wrote:
>> Enable Quality of Service (QoS) blocks for Display SubSystem (DSS), by
>> servicing the DSS - DDR traffic from the Real-Time (RT) queue. This is
>> done by setting the DSS DMA orderID to greater than 7.
>> ATYPE 3 is selected so that the traffic takes non-coherent path and does
> 
> So this is the part I'm not sure about, this change is not just a 
> performance
> adjustment, it can and does break things. The ORDERID setting is fine 
> with me,
> but changing ATYPE should be done in a separate patch so it can be 
> debated on
> its own.
>
>> not have a conflict with coherent traffic from C7x (deep-learning
>> applications).
>> Before setting up the QoS, the ORDERID needs to be mapped to VBUSM 
>> sources
>> using setup_navss_nb() function call that sets the threadmap for NBSS
>> registers. (Section 10.2.10.1.2 "NB Parameters" in TRM[0])
>>
>> Section 3.3.2 "Quality of Service (QoS)" in the TRM[0] provide more
>> details.
>>
>> [0]: https://www.ti.com/lit/zip/spruil1
>>
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>   arch/arm/mach-k3/j721e/j721e_init.c         |  28 +++++
>>   arch/arm/mach-k3/r5/j721e/Makefile          |   1 +
>>   arch/arm/mach-k3/r5/j721e/j721e_qos.h       |  96 +++++++++++++++
>>   arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c | 125 ++++++++++++++++++++
>>   4 files changed, 250 insertions(+)
>>   create mode 100644 arch/arm/mach-k3/r5/j721e/j721e_qos.h
>>   create mode 100644 arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c
>>
>> diff --git a/arch/arm/mach-k3/j721e/j721e_init.c 
>> b/arch/arm/mach-k3/j721e/j721e_init.c
>> index c2024f2500..e9ed8cb267 100644
>> --- a/arch/arm/mach-k3/j721e/j721e_init.c
>> +++ b/arch/arm/mach-k3/j721e/j721e_init.c


[...]

>> diff --git a/arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c 
>> b/arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c
>> new file mode 100644
>> index 0000000000..c829057200
>> --- /dev/null
>> +++ b/arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c
>> @@ -0,0 +1,125 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * j721e Quality of Service (QoS) Configuration Data
>> + * Auto generated from K3 Resource Partitioning tool
>> + */
>> +
>> +#include <asm/arch/k3-qos.h>
>> +#include "j721e_qos.h"
>> +
>> +struct k3_qos_data qos_data[] = {
>> +    /* DSS_PIPE_VID1 - 2 endpoints, 2 channels */
>> +    {
>> +        .reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 0,
> 
> 0x100 being the instance, and 0x4 * x being the specific device register 
> right?
> That could be encoded in a macro (the "Resource Partitioning tool" would
> be updated to generate that too).
> 
> Andrew
> 

Okay both val and reg could be updated.

>> +        .val = ATYPE_3 | ORDERID_15,
>> +    },
>> +    {
>> +        .reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0x100 + 0x4 * 1,
>> +        .val = ATYPE_3 | ORDERID_15,
>> +    },

[...]

>> +
>> +    /* Following registers set 1:1 mapping for orderID MAP1/MAP2
>> +     * remap registers. orderID x is remapped to orderID x again
>> +     * This is to ensure orderID from MAP register is unchanged
>> +     */
>> +
>> +    /* K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA - 2 groups */
>> +    {
>> +        .reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 0,
>> +        .val = 0x76543210,
>> +    },
>> +    {
>> +        .reg = K3_DSS_MAIN_0_DSS_INST0_VBUSM_DMA + 4,
>> +        .val = 0xfedcba98,
>> +    },

 From the looks of it, these register and val can also be encoded as
K3_QOS_GROUP_REG and K3_QOS_GROUP_VAL_HIGH (0xfedcba98) and
K3_QOS_GROUP_VAL_LOW (0x76543210)????

[...]

>> +
>> +u32 qos_count = ARRAY_SIZE(qos_data);
