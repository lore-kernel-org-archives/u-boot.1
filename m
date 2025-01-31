Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711E8C0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DB7E82153;
	Fri, 31 Jan 2025 09:00:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ay8oIPRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADAF380F5F; Fri, 31 Jan 2025 09:00:04 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8A680EB6
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7ox6c029612;
 Fri, 31 Jan 2025 08:59:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 SrqJbJ2FzgNlfPaMGutmohvsgEf0ZHxi/JVJcO6jMkc=; b=ay8oIPRBlaCrzFi/
 XA7U39gTNXVc90SBPkBHs++k7uGW/Md82qy0HNri2IX6CMxoobdhI/bNfv2z5BR0
 VhWaOgw5VQjbXww8hlvE3MHOu33k9k4fl6rHNtSH7a/wAsqiO3fOtWwQt1xmrlrk
 NH8NDBp1z2Pes3zZbSuasl80h+OdWeCmxV5/3IBVBkfEEZO0sxPRFvA3vnMgHD4M
 Q8hkCVSTjGNtnfV+F7rcrDFw/CBRrZ/GT2LKmEdbdXJBKAf6TStUxrVnR8NcjbQT
 g7CsN+Y2BK8CCrnBqRXgDMWP3CNCDVqMq+o/POuEPprCtvVg4CKJYP5vcd7QxHtm
 gyuGyw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7e1r22-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 08:59:58 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 83CA640046;
 Fri, 31 Jan 2025 08:59:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88E4A2B3612;
 Fri, 31 Jan 2025 08:57:11 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 08:57:11 +0100
Message-ID: <9840e776-5c24-4177-8acf-87f924181a7d@foss.st.com>
Date: Fri, 31 Jan 2025 08:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] configs: stm32mp15: enable CONFIG_SYS_64BIT_LBA
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-6-patrice.chotard@foss.st.com>
 <4660eb40-18c9-46e4-9305-420b486f01de@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <4660eb40-18c9-46e4-9305-420b486f01de@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.27.7]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_03,2025-01-30_01,2024-11-22_01
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



On 1/8/25 19:49, Patrick DELAUNAY wrote:
> Hi,
> 
> On 11/29/24 13:27, Patrice Chotard wrote:
>> In arch/arm/mach-stm32mp/cmd_stm32prog/stm32prog.c, in init_device(),
>> in case of RAW_IMAGE, part->size = block_dev->lba * block_dev->blksz.
>>
>>    _ part->size is declared as u64.
>>    _ block_dev->lba is declared as lbaint_t which is uint64_t
>>      if CONFIG_SYS_64BIT_LBA is enable, otherwise ulong.
>>    _ block_dev->blksz is declared as unsigned long.
>>
>> For example, in case block_dev->lba = 0x1dacc00, block_dev->blksz = 0x200
>> then part->size 0x5980000 which is incorrect as both are declared as ulong.
>>
>> To fix this overflow issue, enable CONFIG_SYS_64BIT_LBA, block_dev->lba is
>> then declared as uint64_t and part->size get the correct value 0x3b5980000.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32mp15_basic_defconfig   | 1 +
>>   configs/stm32mp15_defconfig         | 1 +
>>   configs/stm32mp15_trusted_defconfig | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/configs/stm32mp15_basic_defconfig b/configs/stm32mp15_basic_defconfig
>> index 1c0d0d0a073..a8861faab0e 100644
>> --- a/configs/stm32mp15_basic_defconfig
>> +++ b/configs/stm32mp15_basic_defconfig
>> @@ -95,6 +95,7 @@ CONFIG_TFTP_TSIZE=y
>>   CONFIG_USE_SERVERIP=y
>>   CONFIG_SERVERIP="192.168.1.1"
>>   CONFIG_STM32_ADC=y
>> +CONFIG_SYS_64BIT_LBA=y
>>   CONFIG_BUTTON=y
>>   CONFIG_BUTTON_GPIO=y
>>   CONFIG_SET_DFU_ALT_INFO=y
>> diff --git a/configs/stm32mp15_defconfig b/configs/stm32mp15_defconfig
>> index f58a514308b..d31349e3f2b 100644
>> --- a/configs/stm32mp15_defconfig
>> +++ b/configs/stm32mp15_defconfig
>> @@ -69,6 +69,7 @@ CONFIG_TFTP_TSIZE=y
>>   CONFIG_USE_SERVERIP=y
>>   CONFIG_SERVERIP="192.168.1.1"
>>   CONFIG_STM32_ADC=y
>> +CONFIG_SYS_64BIT_LBA=y
>>   CONFIG_BUTTON=y
>>   CONFIG_BUTTON_GPIO=y
>>   CONFIG_CLK_SCMI=y
>> diff --git a/configs/stm32mp15_trusted_defconfig b/configs/stm32mp15_trusted_defconfig
>> index 2e99b8e6a85..1f807f37c69 100644
>> --- a/configs/stm32mp15_trusted_defconfig
>> +++ b/configs/stm32mp15_trusted_defconfig
>> @@ -70,6 +70,7 @@ CONFIG_TFTP_TSIZE=y
>>   CONFIG_USE_SERVERIP=y
>>   CONFIG_SERVERIP="192.168.1.1"
>>   CONFIG_STM32_ADC=y
>> +CONFIG_SYS_64BIT_LBA=y
>>   CONFIG_BUTTON=y
>>   CONFIG_BUTTON_GPIO=y
>>   CONFIG_CLK_SCMI=y
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
