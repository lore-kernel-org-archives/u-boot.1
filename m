Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D340C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 13:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECECD87BF9;
	Fri, 19 Jan 2024 14:25:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="0CSmWksl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 190A087C00; Fri, 19 Jan 2024 14:25:38 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D4A87BBC
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 14:25:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JAn3YG005633; Fri, 19 Jan 2024 14:25:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=pg+TLZzW7eYdRK5gwHyF3WZD1pJmJqyVvxqzF2SBJbM=; b=0C
 SmWkslBhceVwP8A2KBqo8CVowgJxcSAxbGR2L8UmVZtxAhcjKZ5AhrMCEEZ4LDnK
 lpFxAw9tMgoNyDFtWKs+e57/NQSZG7MrzjLmRakBHQlyaOBHqipw3YVvHyvVcyfI
 cAEKwvLNZdnMDEav8eUmHt0oY/oJH1olmJ/5vMZ3ONHXuaSHc/I9Tpun7ms9EbMZ
 Z7NAk+2OMeKvHRMutvdC/h/jCoRmjGIAYskbEPCICNnbeVWS98oXbQREHaAROTrI
 BdelmLbR0BaADhgh6XSSKmPFUjenXpbD/k1PPx3w4i1rMyacGOT/UPuJseRxaGsn
 kpiARHkivuDX10ZcmdWw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vm4y5buck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 14:25:32 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C4666100081;
 Fri, 19 Jan 2024 14:25:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BC51E23D41E;
 Fri, 19 Jan 2024 14:25:30 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 14:25:29 +0100
Message-ID: <3d655b04-0b68-4804-b3b3-dcc2ede72cb8@foss.st.com>
Date: Fri, 19 Jan 2024 14:25:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] stm32mp: add soc.c file
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@foundries.io>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <u-boot@lists.denx.de>, Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.6.I175b5b047ccdb4198f1ae11bac19411617623518@changeid>
 <CAL6CDMESvLgGFrOb2767nCUiKPJcP9XLWkY1du+sKWamZf24Mw@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAL6CDMESvLgGFrOb2767nCUiKPJcP9XLWkY1du+sKWamZf24Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.4.250]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_08,2024-01-19_02,2023-05-22_02
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



On 1/15/24 17:26, Igor Opaniuk wrote:
> On Mon, Jan 15, 2024 at 3:07 PM Patrick Delaunay
> <patrick.delaunay@foss.st.com> wrote:
>>
>> Add a new file soc.c for common functions between stm32mp1 and stm32mp2
>> family and move print_cpuinfo() in this new file.
>>
>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>> (no changes since v1)
>>
>>  arch/arm/mach-stm32mp/Makefile       |  1 +
>>  arch/arm/mach-stm32mp/soc.c          | 17 +++++++++++++++++
>>  arch/arm/mach-stm32mp/stm32mp1/cpu.c | 11 -----------
>>  arch/arm/mach-stm32mp/stm32mp2/cpu.c | 11 -----------
>>  4 files changed, 18 insertions(+), 22 deletions(-)
>>  create mode 100644 arch/arm/mach-stm32mp/soc.c
>>
>> diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
>> index 00dc25bb275c..fdcbbf91dfd5 100644
>> --- a/arch/arm/mach-stm32mp/Makefile
>> +++ b/arch/arm/mach-stm32mp/Makefile
>> @@ -6,6 +6,7 @@
>>  obj-y += dram_init.o
>>  obj-y += syscon.o
>>  obj-y += bsec.o
>> +obj-y += soc.o
>>
>>  obj-$(CONFIG_STM32MP15x) += stm32mp1/
>>  obj-$(CONFIG_STM32MP13x) += stm32mp1/
>> diff --git a/arch/arm/mach-stm32mp/soc.c b/arch/arm/mach-stm32mp/soc.c
>> new file mode 100644
>> index 000000000000..8d5fa474ccaf
>> --- /dev/null
>> +++ b/arch/arm/mach-stm32mp/soc.c
>> @@ -0,0 +1,17 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
>> +/*
>> + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
>> + */
>> +
>> +#include <asm/arch/sys_proto.h>
>> +
>> +/* used when CONFIG_DISPLAY_CPUINFO is activated */
>> +int print_cpuinfo(void)
>> +{
>> +       char name[SOC_NAME_SIZE];
>> +
>> +       get_soc_name(name);
>> +       printf("CPU: %s\n", name);
>> +
>> +       return 0;
>> +}
>> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> index 55574fd4bebf..00fea7929b2f 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
>> @@ -158,17 +158,6 @@ void enable_caches(void)
>>         dcache_enable();
>>  }
>>
>> -/* used when CONFIG_DISPLAY_CPUINFO is activated */
>> -int print_cpuinfo(void)
>> -{
>> -       char name[SOC_NAME_SIZE];
>> -
>> -       get_soc_name(name);
>> -       printf("CPU: %s\n", name);
>> -
>> -       return 0;
>> -}
>> -
>>  static void setup_boot_mode(void)
>>  {
>>         const u32 serial_addr[] = {
>> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> index f43d1aaf72cc..c0f6519e8d7c 100644
>> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
>> @@ -67,17 +67,6 @@ void enable_caches(void)
>>         dcache_enable();
>>  }
>>
>> -/* used when CONFIG_DISPLAY_CPUINFO is activated */
>> -int print_cpuinfo(void)
>> -{
>> -       char name[SOC_NAME_SIZE];
>> -
>> -       get_soc_name(name);
>> -       printf("CPU: %s\n", name);
>> -
>> -       return 0;
>> -}
>> -
>>  int arch_misc_init(void)
>>  {
>>         return 0;
>> --
>> 2.25.1
>>
> 
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> 
Applied to u-boot-stm32/master

Thanks
Patrice
