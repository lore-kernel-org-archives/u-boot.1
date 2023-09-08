Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2BAEE14C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 03:35:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1700D8643D;
	Fri,  8 Sep 2023 05:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sKGrWQY+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABFF486907; Fri,  8 Sep 2023 05:35:37 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CE68477A
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 05:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3883ZVjE003040;
 Thu, 7 Sep 2023 22:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694144131;
 bh=SFjSK2FVvh4zTLA+UWRh7g+xy1SmmQjIxejmr8SA4Bg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=sKGrWQY+c0j7j8WCi6BGpweybCy8YnfAi3yk5LcqkKabLmKADs7z0cqdPxco1ZSVg
 egIOsMGE1nFVyoAaYw/tNk1hq+uNRrhSgeav96+6htfDekcVKeXYe+LszLqS1/fZOd
 hjEmugRQ3ba79FOJZ3TYiWDoT2xA+5lFR5ms2iiE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3883ZVKt008453
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 22:35:31 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 22:35:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 22:35:30 -0500
Received: from [10.24.68.114] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3883ZQ1N120617;
 Thu, 7 Sep 2023 22:35:27 -0500
Message-ID: <16d6f8a8-8b39-d8d2-c6de-b20347ad4486@ti.com>
Date: Fri, 8 Sep 2023 09:05:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2 5/7] configs: j721e: Remove HBMC_AM654 config
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-6-n-francis@ti.com>
 <20230907150700.jkt7drasgubtoab2@flagstone>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20230907150700.jkt7drasgubtoab2@flagstone>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth

On 07/09/23 20:37, Nishanth Menon wrote:
> On 19:44-20230907, Neha Malcom Francis wrote:
>> Remove config as kernel commit d93036b47f35 ("arm64: dts: ti:
>> k3-j721e-mcu-wakeup: Add HyperBus node") is impacting boot. Its
>> dependent patch [1] has not yet been merged to kernel, similar fix will
>> be needed in U-Boot.
>>
>> [1] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/
> 
> So, fix the kernel, why do this in u-boot? The rationale in the commit
> message should clearly state why we do in u-boot.
> 

Will explain better in the commit message.

>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   configs/j721e_evm_a72_defconfig | 1 -
>>   configs/j721e_evm_r5_defconfig  | 1 -
>>   2 files changed, 2 deletions(-)
>>
>> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
>> index 214fa8b2f3..beea948c4e 100644
>> --- a/configs/j721e_evm_a72_defconfig
>> +++ b/configs/j721e_evm_a72_defconfig
>> @@ -140,7 +140,6 @@ CONFIG_CFI_FLASH=y
>>   CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
>>   CONFIG_FLASH_CFI_MTD=y
>>   CONFIG_SYS_FLASH_CFI=y
>> -CONFIG_HBMC_AM654=y
>>   CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
>>   CONFIG_DM_SPI_FLASH=y
>>   CONFIG_SPI_FLASH_STMICRO=y
>> diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
>> index cf7bc872b5..d974be275f 100644
>> --- a/configs/j721e_evm_r5_defconfig
>> +++ b/configs/j721e_evm_r5_defconfig
>> @@ -127,7 +127,6 @@ CONFIG_CFI_FLASH=y
>>   CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
>>   CONFIG_FLASH_CFI_MTD=y
>>   CONFIG_SYS_FLASH_CFI=y
>> -CONFIG_HBMC_AM654=y
>>   CONFIG_DM_SPI_FLASH=y
>>   CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>   CONFIG_SPI_FLASH_STMICRO=y
>> -- 
>> 2.34.1
>>
> 

-- 
Thanking You
Neha Malcom Francis
