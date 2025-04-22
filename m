Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4AFC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 06:18:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9375780FF7;
	Tue, 22 Apr 2025 08:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="cdd9zjcP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3D681026; Tue, 22 Apr 2025 08:18:40 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E11C580FEC
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 08:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6207ada5ad=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LNB84F027204;
 Tue, 22 Apr 2025 08:18:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 TLHNVGSQLI1nM96RtAYnOF5O1cqaTuD8ClKJrNAs0Ps=; b=cdd9zjcPSuhq6TtX
 wIDbmKwFP6+KO0bfY/KpPus5pUk/VujyQjTZrJ2D7lwUHSmiScQKt7IZ9RWULGKJ
 NWa1atZfnuWk3RGAFy34pX4HfjltuVWksYstcmKkvE/lbbRCM49j9SEak2lyjaRt
 A/nFNerl0Yb3njp4B7N87mNBsI3cawzs/ar9UlDPY2IOg3YEwG++fFE6JjMcY/Cw
 r7OrzxfUpgc2eGWxIy2138eykw+P+9gRlXJkw/Dvrj/j4JYGLA47+r/Iim5Stsuv
 PdxFey1BEI1j1EKY1ffBCFCBa5rjT++et6WzqBWMFra5egp0CTZXvwb0rDqy4lMQ
 g/tVaw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46418m8ud9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Apr 2025 08:18:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 11A784002D;
 Tue, 22 Apr 2025 08:17:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D8AC8D0E0E;
 Tue, 22 Apr 2025 08:17:19 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Apr
 2025 08:17:19 +0200
Message-ID: <e6b23032-85d3-4c53-a267-b1d17b479fc4@foss.st.com>
Date: Tue, 22 Apr 2025 08:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stm32mp: Add nvram driver
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Simeon Marijon
 <simeon.marijon@foss.st.com>, Cheick Traore <cheick.traore@foss.st.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250411160326.4113545-1-patrice.chotard@foss.st.com>
 <50fc39f9-8b4d-4620-a5df-3a4fa7253415@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <50fc39f9-8b4d-4620-a5df-3a4fa7253415@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
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



On 4/18/25 18:44, Patrick DELAUNAY wrote:
> Hi,
> 
> On 4/11/25 18:03, Patrice Chotard wrote:
>> From: Simeon Marijon <simeon.marijon@foss.st.com>
>>
>> TAMP backup registers will be exposed as nvmem cells.
>>
>> Each registers ([0..127] for STM32MP2, [0..31] for STM32MP1) could be
>> exposed as nvmem cells under the nvram node in device tree
>>
>> Signed-off-by: Simeon Marijon <simeon.marijon@foss.st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   arch/arm/mach-stm32mp/Kconfig  |   9 +
>>   arch/arm/mach-stm32mp/Makefile |   2 +
>>   arch/arm/mach-stm32mp/nvram.c  | 664 +++++++++++++++++++++++++++++++++
>>   3 files changed, 675 insertions(+)
>>   create mode 100644 arch/arm/mach-stm32mp/nvram.c
>>
>> diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
>> index 002da2e3d3b..d7323659811 100644
>> --- a/arch/arm/mach-stm32mp/Kconfig
>> +++ b/arch/arm/mach-stm32mp/Kconfig
>> @@ -144,6 +144,15 @@ config STM32_ECDSA_VERIFY
>>         ROM API provided on STM32MP.
>>         The ROM API is only available during SPL for now.
>>   +config STM32MP_TAMP_NVMEM
>> +    bool "STM32 TAMP backup registers via NVMEM API"
>> +    select NVMEM
>> +    default y
>> +    help
>> +      Say y to enable the uclass driver for TAMP Backup registers using the
>> +      NVMEM API. It allows to access to boot mode or others shared information
>> +      between software components/execution levels.
>> +
>>   config CMD_STM32KEY
>>       bool "command stm32key to fuse public key hash"
>>       depends on CMDLINE
>> diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makefile
>> index 103e3410ad9..bc0fe9e2225 100644
>> --- a/arch/arm/mach-stm32mp/Makefile
>> +++ b/arch/arm/mach-stm32mp/Makefile
>> @@ -13,6 +13,8 @@ obj-$(CONFIG_STM32MP13X) += stm32mp1/
>>   obj-$(CONFIG_STM32MP25X) += stm32mp2/
>>     obj-$(CONFIG_MFD_STM32_TIMERS) += timers.o
>> +obj-$(CONFIG_STM32MP_TAMP_NVMEM) += nvram.o
> 
> 
> I don't see  reason to have reduce file name her ?
> 
> filename indicate only the type nvram for nvmem used for TAMP backup register.
> 
> 
> I prefer fine name with indication of the device used, here TAMP ,
> 
> and aligned with driver name "stm32_tamp_nvram"
> 
> so rename nvram.c => tamp_nvram.c
> 
> and
> 
> +obj-$(CONFIG_STM32MP_TAMP_NVMEM) += tamp_nvram.o

Hi Patrick

Right, i will rename it as you suggested.

Thanks
Patrice



> 
> 
> thanks
> 
> 
> With this minor remark
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
> 
> 
> 
> 
