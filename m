Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F9C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 12:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD43F82161;
	Mon,  5 May 2025 14:44:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="UJr0xOQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFCD82162; Mon,  5 May 2025 14:44:43 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC04580F03
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 14:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=7220064b2c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5459Xafo017302;
 Mon, 5 May 2025 14:44:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 VmuhwRRZ9eb9yaErv/uSoNIdUM/rhH5VXIHJm7N3AiA=; b=UJr0xOQ4gzI2nuy9
 qbJQAhbVg1i5mzSvjt1ApYcaUsNN23lFI5G8LGCYZ6YxALOg8y7om9ClFk7Y2R8u
 Bb2oTSN8hjNdXFvFcg7xTKC75BREwYNiOup9eL3JahMi2G++6BxS5m9dAt5uQpNL
 HndoekEZ/JsQSk5KNIqt53B890c2kMkY2dJWL8G/7/ksvnQN/4smQbWLcIfn+HJy
 cy0VCUOHXL43mnH+3wJA0jPA5/r8FdNGCeoYkkZiWo7vbAWB9ryDYGTI+unVNkmQ
 cYUxRcGnykgxxbXsPFbKl/ZxKA/l4tqUOkHEPlISsuLd0D4cjA34g6F7K5t6B5m/
 mdpmSQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46dbenpqpc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 May 2025 14:44:29 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0A1BD40086;
 Mon,  5 May 2025 14:43:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A1A5ABCCCE;
 Mon,  5 May 2025 14:43:14 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 14:43:13 +0200
Message-ID: <6021e6eb-5758-4930-a544-e5ffbe2d319c@foss.st.com>
Date: Mon, 5 May 2025 14:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] ARM: stm32: env: Enable scan and start for AB
 schema on STM32MP15 DHSOM
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Pascal Zimmermann <pzimmermann@dh-electronics.com>, <u-boot@lists.denx.de>
CC: Marek Vasut <marex@denx.de>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@chromium.org>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250327143843.19358-1-pzimmermann@dh-electronics.com>
 <20250327143843.19358-3-pzimmermann@dh-electronics.com>
 <fa360159-299f-4083-bcef-96df4915d0c3@foss.st.com>
Content-Language: en-US
In-Reply-To: <fa360159-299f-4083-bcef-96df4915d0c3@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_05,2025-05-05_01,2025-02-21_01
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



On 4/11/25 09:24, Patrice CHOTARD wrote:
> 
> 
> On 3/27/25 15:38, Pascal Zimmermann wrote:
>> For the STM32MP15 DHSOM, change the default environment so an AB schema
>> on a device can be detected.
>>
>> For this the define "SCAN_DEV_FOR_BOOT_PARTS" is overwritten and
>> appended.
>>
>> The detection works by looking for the partitions with specific lables.
>> The name of those partitions are in the variables and its defaults:
>> * dh_ab_partname_primary=rootfs-a
>> * dh_ab_partname_secondary=rootfs-b
>>
>> To prevent being hanging at bootcmd, enable "CONFIG_BOOT_RETRY" and
>> "CONFIG_RESET_TO_RETRY", but the timer will only be activated, if the AB
>> partitions are detected.
>>
>> Signed-off-by: Pascal Zimmermann <pzimmermann@dh-electronics.com>
>> ---
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> Cc: u-boot@lists.denx.de
>> ---
>>  configs/stm32mp15_dhsom.config       |  3 +++
>>  include/configs/stm32mp15_dh_dhsom.h | 33 ++++++++++++++++++++++++++++
>>  2 files changed, 36 insertions(+)
>>
>> diff --git a/configs/stm32mp15_dhsom.config b/configs/stm32mp15_dhsom.config
>> index 7e5b5aa67ef..c84116482f6 100644
>> --- a/configs/stm32mp15_dhsom.config
>> +++ b/configs/stm32mp15_dhsom.config
>> @@ -10,6 +10,9 @@ CONFIG_BOARD_EARLY_INIT_F=y
>>  CONFIG_BOARD_SIZE_LIMIT=1441792
>>  CONFIG_BOOTCOUNT_BOOTLIMIT=3
>>  CONFIG_BOOTDELAY=1
>> +CONFIG_BOOTRETRY=y
>> +CONFIG_RESET_TO_RETRY=y
>> +CONFIG_BOOT_RETRY_TIME=-1
>>  CONFIG_CMD_ADC=y
>>  CONFIG_CMD_REMOTEPROC=y
>>  CONFIG_CMD_STBOARD=y
>> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
>> index c004a8cec82..267e3446779 100644
>> --- a/include/configs/stm32mp15_dh_dhsom.h
>> +++ b/include/configs/stm32mp15_dh_dhsom.h
>> @@ -17,7 +17,40 @@
>>  			" 0x800000\0"
>>  #endif
>>  
>> +/* Add the search for AB partitons */
>> +#define SCAN_DEV_FOR_BOOT_PARTS						\
>> +	"run dh_check_if_ab; "						\
>> +	"if test -z \"${devplist}\"; "					\
>> +		"then "							\
>> +		"part list ${devtype} ${devnum} -bootable devplist; "	\
>> +	"fi; "
>> +
>>  #define STM32MP_BOARD_EXTRA_ENV						\
>> +	"altbootcmd= "							\
>> +	"setenv dh_ab_get_partnames "					\
>> +		"'setenv dh_ab_partnames ${dh_ab_partname_secondary} "	\
>> +			"${dh_ab_partname_primary}' && "		\
>> +		"run bootcmd\0"						\
>> +	"dh_check_if_ab= " /* Sets devplist if AB partitions*/		\
>> +		"echo test for AB on ${devtype} ${devnum} && "		\
>> +		"run dh_ab_get_partnames && "				\
>> +		"setenv devplist && "					\
>> +		"for partname in ${dh_ab_partnames}; do "		\
>> +			"setenv partnum && "				\
>> +			"if part number ${devtype} ${devnum} ${partname} partnum; "\
>> +				"then "					\
>> +				"setenv devplist \"${devplist} ${partnum}\" && "\
>> +				"setenv bootretry 60 ;"			\
>> +			"fi; "						\
>> +		"done ; "						\
>> +		"if test -n \"${devplist}\"; "				\
>> +			"then echo AB partitions found! ; "		\
>> +		"fi\0"							\
>> +	"dh_ab_get_partnames= " /* Sets dh_ab_partnames */		\
>> +		"setenv dh_ab_partnames ${dh_ab_partname_primary} "	\
>> +			"${dh_ab_partname_secondary}\0"			\
>> +	"dh_ab_partname_primary=rootfs-a\0" /* Names of AB partitions */\
>> +	"dh_ab_partname_secondary=rootfs-b\0"				\
>>  	"dh_preboot="							\
>>  		"run dh_testbench_backward_compat\0"			\
>>  	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Applied to u-boot-stm32/master

Thanks
Patrice

> 
> Thanks
> Patrice
