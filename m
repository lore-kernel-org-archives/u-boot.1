Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892D1D2A538
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 18:01:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0665B88D97;
	Wed, 16 Oct 2024 20:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="zciDodFe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 550A988DBA; Wed, 16 Oct 2024 20:01:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1DF88DA0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0019cf4dfa=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GFkeMp018446;
 Wed, 16 Oct 2024 20:01:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 nP/NXHa1Jev1Wz+CKtfdQVZGqpDBk2jPpwmnxag2jc0=; b=zciDodFe4sPkrB/j
 HrdbRDuejkJLkaxvf3h9Z7pfCzfacKxV9/XU/Pbxgm5NDpSpvFkOJ9B3+lGyGzFL
 FXCr6EZeLgx4bZSRJ2zDXy3ukRNm1OuNyQ+8YLUZhwFkTMGA6oA1LjWHFY/rERx6
 a3fJxmPhrVwreRm0uhJjKNgEz1Uz64+wl1Q0J0ckN1BMrOo1NbjCs+pUv52xHaaA
 vc9QHM+NpjfAlYTNgoZ0gD00hxqpoccbHRO9tShLOcj5LWbzp+bXblmu4U/70X6d
 8wI83G70XqLvpj7U8HH9uaGx5wO42B+XkIlk4PfQTD9FhZoC6D+Kr3HCiVYaGA9f
 XVPG1g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42a8mvb675-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Oct 2024 20:01:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0D00B40044;
 Wed, 16 Oct 2024 20:00:19 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5E3E8267806;
 Wed, 16 Oct 2024 19:59:58 +0200 (CEST)
Received: from [10.48.86.243] (10.48.86.243) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 16 Oct
 2024 19:59:57 +0200
Message-ID: <81cabd9f-2c4b-4b1f-a15b-0830b75a3df8@foss.st.com>
Date: Wed, 16 Oct 2024 19:59:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Add script to install U-Boot from SD/eMMC to
 SPI NOR on DH STM32MP15xx DHSOM
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20240930192343.59359-1-marex@denx.de>
 <dc0a0638-0724-46d1-99c7-ee8b84e5541b@foss.st.com>
 <92a9153c-c948-43bb-8542-163ec245c74d@denx.de>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <92a9153c-c948-43bb-8542-163ec245c74d@denx.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.86.243]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
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

Hi,

On 10/12/24 05:01, Marek Vasut wrote:
> On 10/11/24 5:30 PM, Patrick DELAUNAY wrote:
>> Hi,
>
> Hi,
>
>> On 9/30/24 21:23, Marek Vasut wrote:
>>> Make the dh_update_sd_to_sf script generic, rename it to 
>>> dh_update_sdmmc_to_sf
>>> and implement two specific dh_update_sd_to_sf and 
>>> dh_update_emmc_to_sf scripts
>>> which load U-Boot from either SD or eMMC and install it into SPI NOR.
>>>
>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> ---
>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>>> Cc: Tom Rini <trini@konsulko.com>
>>> Cc: u-boot@dh-electronics.com
>>> Cc: u-boot@lists.denx.de
>>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>>> ---
>>>   include/configs/stm32mp15_dh_dhsom.h | 16 +++++++++++++---
>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/ 
>>> stm32mp15_dh_dhsom.h
>>> index de39b19219d..fa759c938b3 100644
>>> --- a/include/configs/stm32mp15_dh_dhsom.h
>>> +++ b/include/configs/stm32mp15_dh_dhsom.h
>>> @@ -38,16 +38,26 @@
>>>           "setenv loadaddr1 && "                    \
>>>           "setenv sblkcnt && "                    \
>>>           "setenv ublkcnt\0"                    \
>>> -    "dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from 
>>> SD */ \
>>> +    "dh_update_sdmmc_to_sf=" /* Erase SPI NOR and install U-Boot 
>>> from SD/eMMC */ \
>>>           "setexpr loadaddr1 ${loadaddr} + 0x1000000 && "        \
>>> -        "load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "    \
>>> +        "load ${dh_update_iface} ${dh_update_dev} "        \
>>> +            "${loadaddr1} /boot/u-boot-spl.stm32 && "    \
>>>           "env set filesize1 ${filesize} && "            \
>>> -        "load mmc 0:4 ${loadaddr} /boot/u-boot.itb && "        \
>>> +        "load ${dh_update_iface} ${dh_update_dev} "        \
>>> +            "${loadaddr} /boot/u-boot.itb && " \
>>>           "sf probe && sf erase 0 0x200000 && "            \
>>>           "sf update ${loadaddr1} 0 ${filesize1} && "        \
>>>           "sf update ${loadaddr1} 0x40000 ${filesize1} && "    \
>>>           "sf update ${loadaddr} 0x80000 ${filesize} && "        \
>>>           "env set filesize1 && env set loadaddr1\0"        \
>>> +    "dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from 
>>> SD */ \
>>> +        "setenv dh_update_iface mmc && "            \
>>> +        "setenv dh_update_dev 0:4 && " \
>>> +        "run dh_update_sdmmc_to_sf\0"                \
>>> +    "dh_update_emmc_to_sf=" /* Erase SPI NOR and install U-Boot 
>>> from eMMC */ \
>>> +        "setenv dh_update_iface mmc && "            \
>>> +        "setenv dh_update_dev 1:4 && " \
>>> +        "run dh_update_sdmmc_to_sf\0"                \
>>>       "stdin=serial\0"                        \
>>>       "stdout=serial\0"                        \
>>>       "stderr=serial\0"                        \
>>>
>>
>> ok I will merge it as it
>>
>> with 2 minor question
>>
>> a)  it is strange to define interface variable for macro
>>      but use only with "mmc" device with
>>
>>> setenv dh_update_iface mmc
>>
>> it can be simplified with
>>
>> "load mmc ${dh_update_dev}
>>
>> or it is to prepare other device then "mmc" .....
>
> The later, I now also renamed the script in V2 to make it more obvious.


ok


>
>> b) you are using "sf" command and not "mtd" to udpate SPI NOR ?
>>
>>
>> the MTD command allows to use the MTD partition name, defined in DT,
>> so no need to know offset in script (and avoid "sf probe")
>>
>> mtd erase fsbl1; mtd write fsbl1 ${loadaddr1} 0 ${filesize1} \
>> mtd erase fsbl2; mtd write fsbl2 ${loadaddr1} 0 ${filesize1} \
>> mtd erase uboot; mtd write uboot ${loadaddr} 0 ${filesize}
> Can you also do 'sf update' alike operation with 'mtd' command? I 
> don't think you can. The 'sf update' often does significantly speed up 
> the SPI NOR update process, because SPI NOR erase operation is very 
> slow, while SPI NOR read operation is fast, so if the update can read 
> and then skip many blocks which are already in the SPI NOR and erase 
> and write only the changed blocks, the update is often very fast too.


Good point....

an improve place for MTD command

I will try to propose something for mtd command


and for the patch


Applied to u-boot-stm/master, thanks!

Regards
Patrick


