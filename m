Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCEDE77188
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 10:35:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1593D80351;
	Wed, 18 Dec 2024 11:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Nug4+n5e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295EE80377; Wed, 18 Dec 2024 11:34:48 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218378027E
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 11:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2082afbf55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BI60NIU011765;
 Wed, 18 Dec 2024 11:34:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 RDivLlJqgzZlO4mJlPGmhRPAw3cyRofedkPRuEfIMR4=; b=Nug4+n5eauWdJY5i
 8sZGW+VYLDYsHe/RbfmdEhk2+FEqZgTe1AV93rPZw1cepeteJ1I+u78ecMZamxpT
 8dzJeiXxYF0r4pEPYnc4mbvvLi5Ot94FNdtmKOTVeT4FVeXj1YUk5+vbQsdtrkml
 KW2y54NWym6MGPRInpcWmRmyw3CE+8a7CwjfA5QIhshxmG8XfrjbFvxDQc+meNQo
 ihM+3lG/Y83aTJy5bJueh9FNf6C/EEd9yZQhsnTHw5XODyL6lciVxbanNoCnth6y
 AQSJEt0H8+6dXSF5l1pO0PV5MqaBiH1r3b3siTJIwugNDYSgwyT8+YjaQ0MYwS++
 2HWBzQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 43krrcs3jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Dec 2024 11:34:35 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E447440063;
 Wed, 18 Dec 2024 11:33:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08687267F4D;
 Wed, 18 Dec 2024 11:32:50 +0100 (CET)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 18 Dec
 2024 11:32:49 +0100
Message-ID: <3b50d9e8-89d7-4b2b-8187-17c69d6aa494@foss.st.com>
Date: Wed, 18 Dec 2024 11:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ARM: dts: stm32: Drop access-controllers from SPL DT
 on DH STM32MP15xx DHSOM
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Igor Opaniuk <igor.opaniuk@gmail.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20241215233011.569287-1-marex@denx.de>
 <20241215233011.569287-3-marex@denx.de>
 <e88ac210-9f46-41c1-b007-494740603d07@foss.st.com>
Content-Language: en-US
In-Reply-To: <e88ac210-9f46-41c1-b007-494740603d07@foss.st.com>
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
>> The access-controllers DT property is not useful in STM32MP15xx SPL,
>> remove it to reduce SPL control DT size. No functional change.
>>
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
>>  configs/stm32mp15_dhcom_basic_defconfig | 2 +-
>>  configs/stm32mp15_dhcor_basic_defconfig | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
>> index b730bf76dca..5add66fb2f4 100644
>> --- a/configs/stm32mp15_dhcom_basic_defconfig
>> +++ b/configs/stm32mp15_dhcom_basic_defconfig
>> @@ -7,5 +7,5 @@ CONFIG_SYS_MEMTEST_START=0xc0000000
>>  CONFIG_SYS_MEMTEST_END=0xc4000000
>>  CONFIG_SYS_I2C_EEPROM_BUS=3
>>  CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
>> -CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
>> +CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
>>  CONFIG_SYS_I2C_EEPROM_ADDR=0x50
>> diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
>> index 42a596505ca..dd14db3b4c5 100644
>> --- a/configs/stm32mp15_dhcor_basic_defconfig
>> +++ b/configs/stm32mp15_dhcor_basic_defconfig
>> @@ -5,7 +5,7 @@ CONFIG_ARCH_STM32MP=y
>>  CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp157a-dhcor-avenger96"
>>  CONFIG_SYS_I2C_EEPROM_BUS=2
>>  CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st/stm32mp153c-dhcor-drc-compact"
>> -CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks"
>> +CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-names interrupts-extended interrupt-controller \\\#interrupt-cells interrupt-parent dmas dma-names assigned-clocks assigned-clock-rates assigned-clock-parents hwlocks access-controllers"
>>  CONFIG_SYS_I2C_EEPROM_ADDR=0x53
>>  CONFIG_PHY_MICREL=y
>>  CONFIG_PHY_MICREL_KSZ90X1=y
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Thanks
> Patrice
Applied to u-boot-stm32/next

Thanks
Patrice
