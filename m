Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037F8E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:34:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE46980288;
	Wed, 18 Dec 2024 11:34:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="rHc3uiza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81E6F80288; Wed, 18 Dec 2024 11:34:36 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AF2680288
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:34:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI6oGPA032714;
 Wed, 18 Dec 2024 11:34:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 RKdsRGF8pP0qGncIsoGfUxt3Idd731pOhf6AG5iLTtU=; b=rHc3uizaUyg/FviK
 cInMLv4OlMvkhQAd77LtHMqNqUDf5mPEDFcjhoiufSuT57EDnDtf08CveWh0ztTy
 ecZbCaGT8v8SgcjGZl7BZH+byuA0vf30x8Mg8jZRvv4IURQwhqrA9iOvpTd6gQaU
 ERxnZ7AI5bS8JzSFXSC+0zDfnw3xcnILzElKIj20ShQnchT5Ize0zCOH1tsFFmLk
 fkxuxMdbJLTqlPz4T/mA918xNx4uKdXYbHFLPWUPbHhAhpoU6PbfHZu2N5pPlv1I
 iCjNq4H3FmOR3Vt6fzB5W87mkr6j6ob/EU+rJQyJ3QzI7PCzLUMzc2iVeWOS/Ick
 //8b7Q==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43ksfrgy2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 11:34:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D637540061;
 Wed, 18 Dec 2024 11:33:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B5400267CD3;
 Wed, 18 Dec 2024 11:32:38 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 11:32:38 +0100
Message-ID: <4dc85e80-3c73-4db0-8c47-2aaf7c35373a@foss.st.com>
Date: Wed, 18 Dec 2024 11:32:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ARM: dts: stm32: Reinstate SPL_SYS_MMCSD_RAW_MODE on
 DH STM32MP15xx DHSOM
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241215233011.569287-1-marex@denx.de>
 <20241215233011.569287-2-marex@denx.de>
 <c78cd5dd-1e98-4c63-ba6a-dc97d4a91c7a@foss.st.com>
Content-Language: en-US
In-Reply-To: <c78cd5dd-1e98-4c63-ba6a-dc97d4a91c7a@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
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



On 12/16/24 09:54, Patrice CHOTARD wrote:
> 
> 
> On 12/16/24 00:29, Marek Vasut wrote:
>> Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>> broke booting from SD card on STM32MP15xx , reinstate raw mode SD
>> boot configuration options and select the correct raw mode partition
>> for STM32MP15xx to fix SD boot on STM32MP15xx DHSOM.
>>
>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>> Reported-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> NOTE: For 2025.01
>> ---
>> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  configs/stm32mp15_dhsom.config | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
>> index efc149577ea..04ee9bfc444 100644
>> --- a/configs/stm32mp15_dhsom.config
>> +++ b/configs/stm32mp15_dhsom.config
>> @@ -57,11 +57,14 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>  CONFIG_SPL_STACK=0x30000000
>>  CONFIG_SPL_SYS_MALLOC=y
>>  CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
>> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>>  CONFIG_SPL_TEXT_BASE=0x2FFC2500
>>  CONFIG_SPL_USB_GADGET=y
>>  CONFIG_STM32_ADC=y
>>  CONFIG_SYSRESET_SYSCON=y
>>  CONFIG_SYS_BOOTCOUNT_ADDR=0x5C00A14C
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
>>  CONFIG_SYS_MALLOC_F_LEN=0x3000
>>  CONFIG_SYS_PBSIZE=1050
>>  CONFIG_PREBOOT="run dh_preboot"
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Thanks
> Patrice
Applied to u-boot-stm32/next

Thanks
Patrice
