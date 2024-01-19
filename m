Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077A3C47DAF
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 14:08:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C46587B9D;
	Fri, 19 Jan 2024 15:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="JtUHh7Wd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01BB287BC9; Fri, 19 Jan 2024 15:08:12 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284358746C
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 15:08:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17487c629f=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40JDZZ2d009032; Fri, 19 Jan 2024 15:08:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=bv6q4GBBDLJqYJxbmIsPUkn9COX8xatJ8VpcfVnhqAk=; b=Jt
 UHh7Wd0arUwo+fEfpxPHAthRQ9E1DVa7vNeD5xXiD9c0V2MKN2RU+XcxKOaC1n4j
 IC5Io71oYuV70VtRnBZyZkDJ4FVYPGKU+3ap6A1WfbMaFBgJxUoEHUINEGfBGI+0
 m+dI0sOqTB1t4XCcbKj4IgxZ7ocgiha36WIUAfZFFtGIHBZfQBY85G7Thhzu2kKG
 UVOIzglVNW93MrStnP0LrPzfA+R25zpUycQsqWe2MEpcHmRKD9Fd4I5KFXWfMBlx
 WjYP8L6SlogYUuZX7Sp5vqgecz4vvCyQiRKdIYH5ETN95b0HACK2ethMHh2Gf7Pp
 jvmzV7z8jvg9SaIFKxTA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vnbqckjkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 19 Jan 2024 15:08:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9D3E100083;
 Fri, 19 Jan 2024 15:07:59 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CB72C257A83;
 Fri, 19 Jan 2024 15:07:59 +0100 (CET)
Received: from [10.252.4.250] (10.252.4.250) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Jan
 2024 15:07:59 +0100
Message-ID: <867f8edc-18c7-40d6-9cc9-7e0ac9e9e110@foss.st.com>
Date: Fri, 19 Jan 2024 15:07:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Set stdio to serial on DH STM32MP15xx DHSOM
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240113175811.157221-1-marex@denx.de>
 <42896f48-89e7-4d58-b06c-d54f27350eeb@foss.st.com>
In-Reply-To: <42896f48-89e7-4d58-b06c-d54f27350eeb@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 1/16/24 08:19, Patrice CHOTARD wrote:
> Hi Marek
> 
> On 1/13/24 18:57, Marek Vasut wrote:
>> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are enabled, the console
>> stdin, stdout, stderr must be defined in environment. Define the default
>> settings to fix the following warning on boot:
>>
>> "
>> In:    No input devices available!
>> Out:   No output devices available!
>> Err:   No error devices available!
>> "
>>
>> Sort the default environment as well.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  include/configs/stm32mp15_dh_dhsom.h | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
>> index 8ff882264f4..de39b19219d 100644
>> --- a/include/configs/stm32mp15_dh_dhsom.h
>> +++ b/include/configs/stm32mp15_dh_dhsom.h
>> @@ -12,14 +12,13 @@
>>  #define PHY_ANEG_TIMEOUT		20000
>>  
>>  #ifdef CONFIG_SPL_BUILD
>> -#define CFG_EXTRA_ENV_SETTINGS					\
>> +#define CFG_EXTRA_ENV_SETTINGS						\
>>  	"dfu_alt_info_ram=u-boot.itb ram "				\
>>  			__stringify(CONFIG_SPL_LOAD_FIT_ADDRESS)	\
>>  			" 0x800000\0"
>>  #endif
>>  
>> -#define STM32MP_BOARD_EXTRA_ENV \
>> -	"usb_pgood_delay=1000\0" \
>> +#define STM32MP_BOARD_EXTRA_ENV						\
>>  	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
>>  		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
>>  		"load mmc 0:4 ${loadaddr1} boot/u-boot-spl.stm32 && "	\
>> @@ -49,7 +48,11 @@
>>  		"sf update ${loadaddr1} 0x40000 ${filesize1} && "	\
>>  		"sf update ${loadaddr} 0x80000 ${filesize} && "		\
>>  		"env set filesize1 && env set loadaddr1\0"		\
>> -	"update_sf=run dh_update_sd_to_sf\0"
>> +	"stdin=serial\0"						\
>> +	"stdout=serial\0"						\
>> +	"stderr=serial\0"						\
>> +	"update_sf=run dh_update_sd_to_sf\0"				\
>> +	"usb_pgood_delay=1000\0"
>>  
>>  
>>  #include <configs/stm32mp15_common.h>
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Applied to u-boot-stm32/master

Thanks
Patrice
