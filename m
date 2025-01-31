Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25932C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 08:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B912882721;
	Fri, 31 Jan 2025 09:00:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="rzjCnbgx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A760080F88; Fri, 31 Jan 2025 09:00:04 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92A1482153
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 09:00:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=41261629dd=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V7otXC025285;
 Fri, 31 Jan 2025 08:59:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 nLd+na0TSkeDw43BryuAcPMlu+Qedpiuoli6D1UOx64=; b=rzjCnbgxW29BUeTr
 PbUWVIgM0KPMne8Jeg27P5ctTfR1H5tApes6kDVqE7k65MkSC7jxD/ynbsvT6wWL
 5LTlu+6KhPBK4ERkF8IjPdYDdK8/liCTkBS0OWODpS61km+1kXDGaFgQjFPw3vto
 /FamhWYTSI4w6VI9irp3oAnj0wDOYJwHK9zIU8vrC6i5lBg3aIvGiM7L4a6CVVY1
 zKjG3ICRrFkWnL8wIbbBuJsL0I7lALkxnQ+nopwuKuuJ5glefdLxkTLQS8gcp+GX
 pDzsmQkdSHzHXES7qxcLGznF2qXr37vEFspMviIAYDeDkuFYmIw+FohdNwtUOQVI
 AA7m8g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44gf7m9r1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 31 Jan 2025 08:59:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8324A40045;
 Fri, 31 Jan 2025 08:59:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8F7032A73F2;
 Fri, 31 Jan 2025 08:57:02 +0100 (CET)
Received: from [10.252.27.7] (10.252.27.7) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Fri, 31 Jan
 2025 08:57:02 +0100
Message-ID: <003a4c87-6780-4735-bf2d-8835380f9e5f@foss.st.com>
Date: Fri, 31 Jan 2025 08:57:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/6] configs: stm32mp13: enable CONFIG_SYS_64BIT_LBA
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Igor Opaniuk
 <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20241129122711.411917-1-patrice.chotard@foss.st.com>
 <20241129122711.411917-5-patrice.chotard@foss.st.com>
 <e77fc839-c13a-4c66-89d0-3d4de158b3db@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <e77fc839-c13a-4c66-89d0-3d4de158b3db@foss.st.com>
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
>>   configs/stm32mp13_defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>> index 7f705808089..e4c92e851e1 100644
>> --- a/configs/stm32mp13_defconfig
>> +++ b/configs/stm32mp13_defconfig
>> @@ -54,6 +54,7 @@ CONFIG_SYS_MMC_ENV_DEV=-1
>>   CONFIG_ENV_MMC_USE_DT=y
>>   CONFIG_BUTTON=y
>>   CONFIG_BUTTON_GPIO=y
>> +CONFIG_SYS_64BIT_LBA=y
>>   CONFIG_CLK_SCMI=y
>>   CONFIG_SET_DFU_ALT_INFO=y
>>   CONFIG_USB_FUNCTION_FASTBOOT=y
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
