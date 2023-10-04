Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5790DE7B5E1
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 09:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A747487236;
	Wed,  4 Oct 2023 11:45:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="3dtmFnai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA73287436; Wed,  4 Oct 2023 11:45:04 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD1587206
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 11:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=864180acd4=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3945OsGl024386; Wed, 4 Oct 2023 11:44:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:from:to:cc:references
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=GX2cKhPtNZavUKn0mH70UnsfI7P1mMgZOhThoMZ70jc=; b=3d
 tmFnaiNSXAGzGHW7Da2TvgD04HMFcdiYbC4jwYQe6mxiL+1C+PS7jJKKtbgmlyMP
 PeeZeGC+oHvCbqtkOSk1mIpuV9uBTGh5oHLTpDmesDaETGcFbIcsyLsHX3URQLjk
 d4THaATVAPWfEoGaOB5YpZLpKgjiIo+gyKczWA98jWieVrITrjZom8IfrSuA2Pak
 ZgMjeNC4VY33iIUdwPibNuHBgKDBL/H6n323phZyfe0j8Jzv10aVWHPyQco80iIO
 0DSVaxxEdVWvwXr+k7N0QvupvfBsGzVY4kNZkyvyBjUwSfl+UY6ytG6Tu4rJJzok
 x11iDFLoNOKEtxbd6T3w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3te8t50gss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 11:44:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EE0A100053;
 Wed,  4 Oct 2023 11:44:52 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 577BC22D177;
 Wed,  4 Oct 2023 11:44:52 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 11:44:51 +0200
Message-ID: <77f3c26f-8f1c-fa5e-0eca-fcea0a7a4d97@foss.st.com>
Date: Wed, 4 Oct 2023 11:44:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] ARM: stm32: Add dh_update_sd_to_emmc to STM32MP15xx
 DHCOR
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marex@denx.de>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@dh-electronics.com>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20231002155234.138630-1-marex@denx.de>
 <20231002155234.138630-2-marex@denx.de>
 <f07ff3b9-52ca-e696-52eb-0c7aad665eeb@foss.st.com>
In-Reply-To: <f07ff3b9-52ca-e696-52eb-0c7aad665eeb@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_01,2023-10-02_01,2023-05-22_02
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



On 10/4/23 11:36, Patrice CHOTARD wrote:
> 
> 
> On 10/2/23 17:52, Marek Vasut wrote:
>> Add script which installs U-Boot binaries from SD card to eMMC
>> and makes the eMMC bootable.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  include/configs/stm32mp15_dh_dhsom.h | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/include/configs/stm32mp15_dh_dhsom.h b/include/configs/stm32mp15_dh_dhsom.h
>> index c7ebf5cd180..8ff882264f4 100644
>> --- a/include/configs/stm32mp15_dh_dhsom.h
>> +++ b/include/configs/stm32mp15_dh_dhsom.h
>> @@ -20,6 +20,25 @@
>>  
>>  #define STM32MP_BOARD_EXTRA_ENV \
>>  	"usb_pgood_delay=1000\0" \
>> +	"dh_update_sd_to_emmc=" /* Install U-Boot from SD to eMMC */	\
>> +		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
>> +		"load mmc 0:4 ${loadaddr1} boot/u-boot-spl.stm32 && "	\
>> +		"setexpr sblkcnt ${filesize} + 0x1ff && "		\
>> +		"setexpr sblkcnt ${sblkcnt} / 0x200 && "		\
>> +		"load mmc 0:4 ${loadaddr} boot/u-boot.itb && "		\
>> +		"setexpr ublkcnt ${filesize} + 0x1ff && "		\
>> +		"setexpr ublkcnt ${ublkcnt} / 0x200 && "		\
>> +		"mmc partconf 1 1 1 1 && mmc dev 1 1 && "		\
>> +		"mmc write ${loadaddr1} 0 ${sblkcnt} && "		\
>> +		"mmc dev 1 2 && "					\
>> +		"mmc write ${loadaddr1} 0 ${sblkcnt} && "		\
>> +		"mmc dev 1 && "						\
>> +		"gpt write mmc 1 'name=ssbl,size=2MiB' && "		\
>> +		"mmc write ${loadaddr} 0x22 ${ublkcnt} && "		\
>> +		"mmc partconf 1 1 1 0 && "				\
>> +		"setenv loadaddr1 && "					\
>> +		"setenv sblkcnt && "					\
>> +		"setenv ublkcnt\0"					\
>>  	"dh_update_sd_to_sf=" /* Erase SPI NOR and install U-Boot from SD */ \
>>  		"setexpr loadaddr1 ${loadaddr} + 0x1000000 && "		\
>>  		"load mmc 0:4 ${loadaddr1} /boot/u-boot-spl.stm32 && "	\
> Hi Marek
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice

Apply on stm32/next

Thanks
Patrice
