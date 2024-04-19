Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34597C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 12:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B37D8887CE;
	Fri, 19 Apr 2024 14:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="StTCGQfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CA22887CF; Fri, 19 Apr 2024 14:16:50 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF91887C9
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=4839221eac=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 43J9iFPS031727; Fri, 19 Apr 2024 14:16:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=uCGdQVfV7ltRXdJoI9mBMelowAjDmaNDDND7DS9trXk=; b=St
 TCGQfgMD9rQohbVgqcNWGs+eKeZXlT8GZxvu4Uc75hE/G55+8bu1PkqzrtQKX+dC
 VViA9nnT4C+8pX3kKKB4nfYNXAAzljHczNf6jWqlVh8q5stzbf6HGTgCsG1//8XJ
 McxQTnz9O60pwMVZd57CwoA+1ZeFP2DZXj9XEv0SlzAOD1EoQ2bnx+/XXwKdTik8
 8nf0u2btdv00xmaxxexy06p8HU3Ro0hvCjl4sPChKqHzT9EN3DDDStldnmyKaWYE
 DHHPDKg0Ut9EJuIrIUdrGasn85WqSeZRw0LyMi+R557ld9b2YPajVFaIX4Y5BosE
 /nclEvs7pF67bXEn6YoQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xgecyrbf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Apr 2024 14:16:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6FF414002D;
 Fri, 19 Apr 2024 14:16:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8955B2194FA;
 Fri, 19 Apr 2024 14:16:15 +0200 (CEST)
Received: from [10.252.13.94] (10.252.13.94) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 14:16:14 +0200
Message-ID: <859f32b1-206d-4f75-9f8b-4725cad509da@foss.st.com>
Date: Fri, 19 Apr 2024 14:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/25] configs: stm32mp13: Enable FASTBOOT
Content-Language: en-US
To: Igor Opaniuk <igor.opaniuk@gmail.com>
CC: <u-boot@lists.denx.de>, Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Gatien Chevallier
 <gatien.chevallier@foss.st.com>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240409150215.2497778-1-patrice.chotard@foss.st.com>
 <20240409150215.2497778-2-patrice.chotard@foss.st.com>
 <CAByghJa_3MwcY74oNR0cKA2+XOA6R6J8LGhnecvZoJr_ONxTXw@mail.gmail.com>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <CAByghJa_3MwcY74oNR0cKA2+XOA6R6J8LGhnecvZoJr_ONxTXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.13.94]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-19_08,2024-04-19_01,2023-05-22_02
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



On 4/18/24 13:48, Igor Opaniuk wrote:
> On Tue, Apr 9, 2024 at 5:19 PM Patrice Chotard
> <patrice.chotard@foss.st.com> wrote:
>>
>> Enable FASTBOOT relative flags for stm32mp13_defconfig.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> ---
>>
>>  configs/stm32mp13_defconfig | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/configs/stm32mp13_defconfig b/configs/stm32mp13_defconfig
>> index c893e272db9..db09e63100e 100644
>> --- a/configs/stm32mp13_defconfig
>> +++ b/configs/stm32mp13_defconfig
>> @@ -15,6 +15,7 @@ CONFIG_CMD_STM32PROG=y
>>  CONFIG_SYS_LOAD_ADDR=0xc2000000
>>  CONFIG_SYS_MEMTEST_START=0xc0000000
>>  CONFIG_SYS_MEMTEST_END=0xc4000000
>> +# CONFIG_ANDROID_BOOT_IMAGE is not set
>>  CONFIG_FIT=y
>>  CONFIG_SYS_BOOTM_LEN=0x2000000
>>  CONFIG_DISTRO_DEFAULTS=y
>> @@ -53,6 +54,13 @@ CONFIG_SYS_MMC_ENV_DEV=-1
>>  CONFIG_ENV_MMC_USE_DT=y
>>  CONFIG_CLK_SCMI=y
>>  CONFIG_SET_DFU_ALT_INFO=y
>> +CONFIG_USB_FUNCTION_FASTBOOT=y
>> +CONFIG_FASTBOOT_BUF_ADDR=0xc0000000
>> +CONFIG_FASTBOOT_BUF_SIZE=0x02000000
>> +CONFIG_FASTBOOT_FLASH=y
>> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>> +CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>> +CONFIG_FASTBOOT_CMD_OEM_PARTCONF=y
>>  CONFIG_GPIO_HOG=y
>>  CONFIG_DM_I2C=y
>>  CONFIG_SYS_I2C_STM32F7=y
>> @@ -92,7 +100,6 @@ CONFIG_USB_GADGET_MANUFACTURER="STMicroelectronics"
>>  CONFIG_USB_GADGET_VENDOR_NUM=0x0483
>>  CONFIG_USB_GADGET_PRODUCT_NUM=0x5720
>>  CONFIG_USB_GADGET_DWC2_OTG=y
>> -CONFIG_USB_GADGET_DOWNLOAD=y
>>  CONFIG_ERRNO_STR=y
>>  # CONFIG_LMB_USE_MAX_REGIONS is not set
>>  CONFIG_LMB_MEMORY_REGIONS=2
>> --
>> 2.25.1
>>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> 

Applied on u-boot-stm32/master 
