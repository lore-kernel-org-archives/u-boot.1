Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B5CC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 12:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 712198764E;
	Fri, 10 Nov 2023 13:24:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="54ZR23hz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8172D87692; Fri, 10 Nov 2023 13:24:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 884F08714C
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 13:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9678822151=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AAAIaDb010090; Fri, 10 Nov 2023 13:24:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=0QpsvifmgBfupRvysksUe588Y7KwIci5RG6rJ8BSAlc=; b=54
 ZR23hzet01oi8oC1ruwmgZlxdObY7O621FUBbCdn8w9fwrLN52/a9Ace2EA2VDER
 tYE9S+8detdPVmw2ZnyhoueAhavie37W+JmIW72esotAXqxYYpdgeUO92acbCr3a
 3GgD4rQtuHJEo0c+D260nSD6VLQkkSHBaLAKFuQUNl6/w2nE8heCoUdFIoloCgVh
 INmMaGJmD2VptvgE9c7WkW6N5qVU/LjD0GYW9ri0+nc//KocmQg3Qb5t2G0Y8niE
 BFNFrknWqBcFiJsllWnmRTPnMVjsAF2EDpaSHBrAnDO11FZzZ1G3g9p+Rl6YB8ri
 K6WKKVDd+ibukOQphDOw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w26p5g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 13:24:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BBC0D10005E;
 Fri, 10 Nov 2023 13:24:01 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B2E5E24C43F;
 Fri, 10 Nov 2023 13:24:01 +0100 (CET)
Received: from [10.201.20.54] (10.201.20.54) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 10 Nov
 2023 13:24:00 +0100
Message-ID: <c8511b1b-8331-45b4-b5ae-a65bfb372454@foss.st.com>
Date: Fri, 10 Nov 2023 13:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm: stm32: Limit u-boot.itb size to 0x160000 bytes
 on DH STM32MP15 DHSOM
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Andreas Geisreiter <ageisreiter@dh-electronics.de>, Christoph Niedermaier
 <cniedermaier@dh-electronics.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231104163203.117382-1-marex@denx.de>
 <20231104163203.117382-2-marex@denx.de>
 <30ad1990-03ad-4b57-9085-90f9e9376b33@foss.st.com>
In-Reply-To: <30ad1990-03ad-4b57-9085-90f9e9376b33@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.54]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_09,2023-11-09_01,2023-05-22_02
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



On 11/9/23 08:19, Patrice CHOTARD wrote:
> 
> 
> On 11/4/23 17:31, Marek Vasut wrote:
>> The maximum size of u-boot.itb in SPI NOR on DH STM32MP15 DHSOM is
>> 0x160000 . Define this size in U-Boot config to prevent misconfigured
>> builds from emitting larger u-boot.itb than the one which fits the
>> SPI NOR area reserved for the blob.
>>
>> The SPI NOR layout is as follows:
>> 0x00_0000..0x03_ffff ... SPL 1
>> 0x04_0000..0x07_ffff ... SPL 2
>> 0x08_0000..0x1d_ffff ... U-Boot
>> 0x1e_0000..0x1e_ffff ... Environment 1
>> 0x1f_0000..0x1f_ffff ... Environment 2
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
>> Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  configs/stm32mp15_dhcom_basic_defconfig | 2 ++
>>  configs/stm32mp15_dhcor_basic_defconfig | 2 ++
>>  2 files changed, 4 insertions(+)
>>
>> diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
>> index 08aac878f8e..1d241529be7 100644
>> --- a/configs/stm32mp15_dhcom_basic_defconfig
>> +++ b/configs/stm32mp15_dhcom_basic_defconfig
>> @@ -25,6 +25,8 @@ CONFIG_SPL_SPI=y
>>  CONFIG_SYS_LOAD_ADDR=0xc2000000
>>  CONFIG_SYS_MEMTEST_START=0xc0000000
>>  CONFIG_SYS_MEMTEST_END=0xc4000000
>> +CONFIG_HAS_BOARD_SIZE_LIMIT=y
>> +CONFIG_BOARD_SIZE_LIMIT=1441792
>>  CONFIG_FIT=y
>>  CONFIG_SPL_LOAD_FIT=y
>>  CONFIG_SPL_LOAD_FIT_ADDRESS=0xc1000000
>> diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
>> index 8cd6924b580..6e0c4a8cf9f 100644
>> --- a/configs/stm32mp15_dhcor_basic_defconfig
>> +++ b/configs/stm32mp15_dhcor_basic_defconfig
>> @@ -23,6 +23,8 @@ CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>  CONFIG_SPL_SPI=y
>>  # CONFIG_ARMV7_VIRT is not set
>>  CONFIG_SYS_LOAD_ADDR=0xc2000000
>> +CONFIG_HAS_BOARD_SIZE_LIMIT=y
>> +CONFIG_BOARD_SIZE_LIMIT=1441792
>>  CONFIG_FIT=y
>>  CONFIG_SPL_LOAD_FIT=y
>>  CONFIG_SPL_LOAD_FIT_ADDRESS=0xc1000000
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Applied to u-boot-stm32/master

Thanks
Patrice
