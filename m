Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17164C369D7
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 09:34:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8724A81026;
	Tue, 22 Apr 2025 11:34:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="X+sSgAv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F186810E8; Tue, 22 Apr 2025 11:34:33 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 119AC80FF7
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 11:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6207ada5ad=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M64XMS030077;
 Tue, 22 Apr 2025 11:34:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 i0MG8/SwXZQvqYJeYjYaxE0bnIBTLYiQnLo2u/pfJ/8=; b=X+sSgAv+BqCjqWCX
 sPL11kRaouZIm5Ui7whsZKmFD2XAiIPJrQthpR8iQj04FfBM3u5xplsebppIgER/
 vaF2JJtAtjO0cdQTywNloTdQTTZx8k8bI2QPI1D9XtvMROmmKyIF6YnZ5xYdpIy4
 5lB901aw4I2FerzLU657jAlxb5n6AmOckSG5qMCKydamv1Sll//HY+oyP9OF06wE
 vA01vDnKUbM2lC2Ssz3A7W1Cesn8vhlYfhKKtn82F7FBnVh7S3xW47jlSlUqLboy
 hWx7vMfbq7PtT7wzmYHnCxrhM1TSLGYDMcafdC/u3Z9E8ffbXl/HDqrBefHjVULs
 7XYhXw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 464psp70yq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 11:34:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 06EB940047;
 Tue, 22 Apr 2025 11:33:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4E0689EB084;
 Tue, 22 Apr 2025 11:33:18 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 11:33:17 +0200
Message-ID: <e6452d26-75a6-4d90-90f0-21376adca0ee@foss.st.com>
Date: Tue, 22 Apr 2025 11:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ARM: stm32mp: add ETZPC system bus driver for
 STM32MP1
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Lionel Debieve
 <lionel.debieve@foss.st.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Marek Vasut <marex@denx.de>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250401131413.387139-1-patrice.chotard@foss.st.com>
 <20250401131413.387139-10-patrice.chotard@foss.st.com>
 <a7491caf-a8a1-427d-a4e3-fe70add98218@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <a7491caf-a8a1-427d-a4e3-fe70add98218@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_04,2025-04-21_02,2024-11-22_01
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



On 4/22/25 10:31, Patrick DELAUNAY wrote:
> Hi,
> 
> 
> On 4/1/25 15:14, Patrice Chotard wrote:
>> From: Lionel Debieve <lionel.debieve@foss.st.com>
>>
>> This driver is checking the access rights of the different
>> peripherals connected to the ETZPC bus. If access is denied,
>> the associated device is not bound.
>>
>> Signed-off-by: Lionel Debieve <lionel.debieve@foss.st.com>
>> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/include/mach/etzpc.h |  32 ++++
>>   arch/arm/mach-stm32mp/stm32mp1/Makefile    |   1 +
>>   arch/arm/mach-stm32mp/stm32mp1/etzpc.c     | 194 +++++++++++++++++++++
>>   3 files changed, 227 insertions(+)
>>   create mode 100644 arch/arm/mach-stm32mp/include/mach/etzpc.h
>>   create mode 100644 arch/arm/mach-stm32mp/stm32mp1/etzpc.c
>>
> ...
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/etzpc.c b/arch/arm/mach-stm32mp/stm32mp1/etzpc.c
>> new file mode 100644
>> index 00000000000..b7aefb84069
>> --- /dev/null
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/etzpc.c
>> @@ -0,0 +1,194 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>> +/*
>> + * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
>> + */
>> +
>> +#define LOG_CATEGORY UCLASS_SIMPLE_BUS
> 
> 
> minor  => why SIMPLE_BUS here ?
> 
> 
> #define LOG_CATEGORY UCLASS_NOP

Ok will update it

Thanks

> 
> 
>> +
>> +#include <dm.h>
>> +#include <asm/io.h>
>> +#include <dm/device.h>
>> +#include <dm/device_compat.h>
>> +#include <dm/lists.h>
>> +#include <linux/bitfield.h>
>> +#include <mach/etzpc.h>
>> +
> ...
>> +
>> +U_BOOT_DRIVER(stm32_etzpc) = {
>> +    .name = "stm32_etzpc",
>> +    .id = UCLASS_NOP,
>> +    .of_match = stm32_etzpc_ids,
>> +    .bind = stm32_etzpc_bind,
>> +    .plat_auto = sizeof(struct stm32_etzpc_plat),
>> +};
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 
