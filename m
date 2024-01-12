Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27F1C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 12:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B76E878B1;
	Fri, 12 Jan 2024 13:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HdpWWSKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64FF87947; Fri, 12 Jan 2024 13:39:11 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A3758785F
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 13:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CCd6jq049360;
 Fri, 12 Jan 2024 06:39:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705063146;
 bh=dTo3huT6hx346QDFQrsLRmxEswM1BiRJlMaoD2pER1k=;
 h=Date:CC:Subject:To:References:From:In-Reply-To;
 b=HdpWWSKjutPoeCHJxcw7MpTeM9LlqaCCXfXDsJjxqNnpu2FbKkE0Ty/bBo8pogShK
 F3wOKtZn3e04rlRgY61lKPf7CREsxrwC/dtusT8c4p/Ks7LZYskB2YAXcdQDCAyj+e
 dj/39UpcwLtlUuZMQoYdp/oju3WTq8ksQ9XWbEJw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CCd6Gh005655
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 06:39:06 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 06:39:06 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 06:39:06 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CCcO1L036207;
 Fri, 12 Jan 2024 06:39:03 -0600
Message-ID: <10d59b67-dbf6-46aa-ad6a-f3a196c5f21f@ti.com>
Date: Fri, 12 Jan 2024 18:09:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>, 
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH 09/10] configs: am62x_evm_a53_defconfig: Enable configs
 required for Ethboot
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-10-s-vadapalli@ti.com>
 <20240112123300.q67iox5pdzdobhrp@squad>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240112123300.q67iox5pdzdobhrp@squad>
Content-Type: text/plain; charset="UTF-8"
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



On 12/01/24 18:03, Nishanth Menon wrote:
> On 12:17-20240112, Siddharth Vadapalli wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Enable config options needed to support Ethernet boot on AM62x SK.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>  configs/am62x_evm_a53_defconfig | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
>> index aa96c1b312..5c56b17a3e 100644
>> --- a/configs/am62x_evm_a53_defconfig
>> +++ b/configs/am62x_evm_a53_defconfig
>> @@ -17,6 +17,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
>>  CONFIG_DM_RESET=y
>>  CONFIG_SPL_MMC=y
>>  CONFIG_SPL_SERIAL=y
>> +CONFIG_SPL_DRIVERS_MISC=y
>>  CONFIG_SPL_STACK_R_ADDR=0x82000000
>>  CONFIG_SPL_SIZE_LIMIT=0x40000
>>  CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
>> @@ -37,13 +38,19 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>  CONFIG_SPL_BSS_START_ADDR=0x80c80000
>>  CONFIG_SPL_BSS_MAX_SIZE=0x80000
>>  CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
>> +CONFIG_SPL_BOARD_INIT=y
>>  CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>>  CONFIG_SPL_STACK_R=y
>>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
>>  CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
>> +CONFIG_SPL_DMA=y
>> +CONFIG_SPL_ENV_SUPPORT=y
>> +CONFIG_SPL_ETH=y
>>  CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
>>  CONFIG_SPL_DM_MAILBOX=y
>>  CONFIG_SPL_DM_SPI_FLASH=y
>> +CONFIG_SPL_NET=y
>> +CONFIG_SPL_NET_VCI_STRING="AM62X U-Boot A53 SPL"
>>  CONFIG_SPL_POWER_DOMAIN=y
>>  # CONFIG_SPL_SPI_FLASH_TINY is not set
>>  CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
>> @@ -61,6 +68,7 @@ CONFIG_SPL_DM=y
>>  CONFIG_SPL_DM_SEQ_ALIAS=y
>>  CONFIG_REGMAP=y
>>  CONFIG_SPL_REGMAP=y
>> +CONFIG_SPL_SYSCON=y
>>  CONFIG_SPL_OF_TRANSLATE=y
>>  CONFIG_CLK=y
>>  CONFIG_SPL_CLK=y
>> -- 
>> 2.34.1
>>
> 
> NAK again - why cant we use config fragments?

Ok. I will use config fragments.

> 

-- 
Regards,
Siddharth.
