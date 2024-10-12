Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC7D1A42F
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E50088B8F;
	Sat, 12 Oct 2024 05:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728703878;
	bh=34RukWzKzNdXJ0reXpzwSqvdcfkqcTf+FasjOxG7pm8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GBDUY7ITEyCiqpX+jReLpqGlL5vCeJu8qMzEUMYXkC0Hb4vTjnTMNhtzv4y8twSMh
	 vmF0WwPB0MWF776guqDxXS5jWu1WsQdmUbDo96iIlvmA8Xu+va8PcyRYrQxTLfci9z
	 QGqeUx6roRTfObhu7jWgcZSdniPyUDI1h54A5nvPBnK+FsHQnHTUSJ6pxptJ+fxmti
	 smy/vLjZUN2RaWpnF0yGEDqPqTGAOUnGpJMfDAZaeJpzBmahhsCj2OHhIo/sW7fFS1
	 VUvB3PEkVZpR3QHV2KC9oIBUXtuLRYuedGrJaF4PAouQjQcvQLlyQKqiFlCgcPj5hE
	 42wgeElPS0iKA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 497DB88B4B;
 Sat, 12 Oct 2024 05:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728703877;
 bh=34RukWzKzNdXJ0reXpzwSqvdcfkqcTf+FasjOxG7pm8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rCJ2NqDxV5ItjhuDGvpy+fMod5swoTeudYtyJr8CP5KBgtWkINO2s6ZKq6xxJ4gMH
 bA9RLzeFu+uDf1DGpmoEUOTKQck+EhOEzhBUdRQZm/v8EXLIwmaBQhpiykuqddtbpS
 zPaRnXioUEyyO3wR24t4BlkewfBqS5bZ0cWsfUYTG/GTYMGxKCVxT3iaWAUDDJrH+V
 +iUyqhCXSfSFqYV8m5MQn2CeyF86homOMgIbFLY07JMWlxO9mJO5QQcKAyYCcIH4uy
 2hEaLI6t9S20UM/fq199uy0KlxiBnM4SQJ2ZwwAQq+87PEEsqtUjAv5AdwQrljHalK
 NAlImK7kpnVRA==
Message-ID: <92a9153c-c948-43bb-8542-163ec245c74d@denx.de>
Date: Sat, 12 Oct 2024 05:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Add script to install U-Boot from SD/eMMC to
 SPI NOR on DH STM32MP15xx DHSOM
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20240930192343.59359-1-marex@denx.de>
 <dc0a0638-0724-46d1-99c7-ee8b84e5541b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <dc0a0638-0724-46d1-99c7-ee8b84e5541b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/11/24 5:30 PM, Patrick DELAUNAY wrote:
> Hi,

Hi,

> On 9/30/24 21:23, Marek Vasut wrote:
>> Make the dh_update_sd_to_sf script generic, rename it to 
>> dh_update_sdmmc_to_sf
>> and implement two specific dh_update_sd_to_sf and dh_update_emmc_to_sf 
>> scripts
>> which load U-Boot from either SD or eMMC and install it into SPI NOR.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>   include/configs/stm32mp15_dh_dhsom.h | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/ 
>> stm32mp15_dh_dhsom.h
>> index de39b19219d..fa759c938b3 100644
>> --- a/include/configs/stm32mp15_dh_dhsom.h
>> +++ b/include/configs/stm32mp15_dh_dhsom.h
>> @@ -38,16 +38,26 @@
>>           "setenv loadaddr1 && "                    \
>>           "setenv sblkcnt && "                    \
>>           "setenv ublkcnt\0"                    \
>> -    "dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD 
>> */ \
>> +    "dh_update_sdmmc_to_sf=" /* Erase SPI NOR and install U-Boot from 
>> SD/eMMC */ \
>>           "setexpr loadaddr1 ${loadaddr} + 0x1000000 && "        \
>> -        "load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "    \
>> +        "load ${dh_update_iface} ${dh_update_dev} "        \
>> +            "${loadaddr1} /boot/u-boot-spl.stm32 && "    \
>>           "env set filesize1 ${filesize} && "            \
>> -        "load mmc 0:4 ${loadaddr} /boot/u-boot.itb && "        \
>> +        "load ${dh_update_iface} ${dh_update_dev} "        \
>> +            "${loadaddr} /boot/u-boot.itb && "        \
>>           "sf probe && sf erase 0 0x200000 && "            \
>>           "sf update ${loadaddr1} 0 ${filesize1} && "        \
>>           "sf update ${loadaddr1} 0x40000 ${filesize1} && "    \
>>           "sf update ${loadaddr} 0x80000 ${filesize} && "        \
>>           "env set filesize1 && env set loadaddr1\0"        \
>> +    "dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD 
>> */ \
>> +        "setenv dh_update_iface mmc && "            \
>> +        "setenv dh_update_dev 0:4 && "                \
>> +        "run dh_update_sdmmc_to_sf\0"                \
>> +    "dh_update_emmc_to_sf=" /* Erase SPI NOR and install U-Boot from 
>> eMMC */ \
>> +        "setenv dh_update_iface mmc && "            \
>> +        "setenv dh_update_dev 1:4 && "                \
>> +        "run dh_update_sdmmc_to_sf\0"                \
>>       "stdin=serial\0"                        \
>>       "stdout=serial\0"                        \
>>       "stderr=serial\0"                        \
>>
> 
> ok I will merge it as it
> 
> with 2 minor question
> 
> a)  it is strange to define interface variable for macro
>      but use only with "mmc" device with
> 
>> setenv dh_update_iface mmc
> 
> it can be simplified with
> 
> "load mmc ${dh_update_dev}
> 
> or it is to prepare other device then "mmc" .....

The later, I now also renamed the script in V2 to make it more obvious.

> b) you are using "sf" command and not "mtd" to udpate SPI NOR ?
> 
> 
> the MTD command allows to use the MTD partition name, defined in DT,
> so no need to know offset in script (and avoid "sf probe")
> 
> mtd erase fsbl1; mtd write fsbl1 ${loadaddr1} 0 ${filesize1} \
> mtd erase fsbl2; mtd write fsbl2 ${loadaddr1} 0 ${filesize1} \
> mtd erase uboot; mtd write uboot ${loadaddr} 0 ${filesize}
Can you also do 'sf update' alike operation with 'mtd' command? I don't 
think you can. The 'sf update' often does significantly speed up the SPI 
NOR update process, because SPI NOR erase operation is very slow, while 
SPI NOR read operation is fast, so if the update can read and then skip 
many blocks which are already in the SPI NOR and erase and write only 
the changed blocks, the update is often very fast too.
