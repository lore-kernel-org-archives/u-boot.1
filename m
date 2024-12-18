Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B70BE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89CA180379;
	Wed, 18 Dec 2024 11:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="fejpCBYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2939D80374; Wed, 18 Dec 2024 11:45:33 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35BD980304
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI70vO7021816;
 Wed, 18 Dec 2024 11:45:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 QYrPaYdZuEZcHowW/wN1W05U4lryfLQM75POgRMawcs=; b=fejpCBYVaoDHg/BL
 /MWfgmKBfx+ixk3yiZ0n5xkiLk08LC9oT8AZ+0Kd+cc0ALyJIK4TRWWgElRCklLj
 2hTPZpMwqLPqSQvvjnCdRdXXFfB5JfDrxq5PFt2WHtfagCClzvDwpY/AaUaQ25KT
 kNbk4jF9CDKlMCdBpQc/MwZ8Rwv+Vmcud9LewJtq8WBAJLCM05+3pchT72Z/Fyz5
 /9f5hQPDapgXrSRr6ILo79pSjodW8XtFkpuK5QrY/LHTUPr1Z9UvyX4L1m6krC+W
 Ms+h+rHDSYvjgj93GP0adrrjsNTJP2zdv9tNTdjp45ppug2tSEg1OfSG3Tjzizmb
 XcNkww==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43kfu8am8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 11:45:17 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9DA7F40086;
 Wed, 18 Dec 2024 11:44:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 50BA02560C2;
 Wed, 18 Dec 2024 11:42:46 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 11:42:45 +0100
Message-ID: <5f677dfb-442e-4c47-ae37-dff648d008c8@foss.st.com>
Date: Wed, 18 Dec 2024 11:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] configs: stm32mp1: Restore boot SPL from sdcard for
 Engicam i.Core STM32MP1 C.TOUCH 2.0
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Matteo Lisi <matteo.lisi@engicam.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20241216102219.347725-1-patrice.chotard@foss.st.com>
 <20241216102219.347725-2-patrice.chotard@foss.st.com>
 <895daee1-23bc-4c37-8d81-5de08153cf4c@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <895daee1-23bc-4c37-8d81-5de08153cf4c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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



On 12/18/24 10:04, Patrick DELAUNAY wrote:
> Hi,
> 
> On 12/16/24 11:22, Patrice Chotard wrote:
>> Restore boot SPL from sdcard for Engicam i.Core STM32MP1 C.TOUCH 2.0.
>>
>> Fixes: 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>
>>   configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
>> index 4e171200ef2..00c475307c9 100644
>> --- a/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
>> +++ b/configs/stm32mp15-icore-stm32mp1-ctouch2_defconfig
>> @@ -27,6 +27,9 @@ CONFIG_SPL_SYS_MALLOC=y
>>   CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
>>   CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xc0300000
>>   CONFIG_SPL_SYS_MALLOC_SIZE=0x1d00000
>> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x3
>>   CONFIG_SPL_ENV_SUPPORT=y
>>   CONFIG_SPL_I2C=y
>>   CONFIG_SPL_POWER=y
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
