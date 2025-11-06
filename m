Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9638CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 03:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC3EF83B22;
	Thu,  6 Nov 2025 04:56:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ltgjERUD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292FD83B23; Thu,  6 Nov 2025 04:56:25 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEF4F83B4A
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 04:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5A63u41S2529118;
 Wed, 5 Nov 2025 21:56:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1762401364;
 bh=YkSWuuSS2bfAVeqB9C0DXYdpWUrVY+ePTvJyuco9Okw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ltgjERUDu6Vr2kFrV0JMgDiqvsdpaJ2i8lgNeHrNvT05bMX2LVbaVygFULd7KjAbB
 G2JJq5BHHc5pd1u/xMV0LDJpPJ31XIsr7b4+mF+zD6nlaU1vo6jR3JmdbLAXofK/1X
 L1Qo+3QfYhDdDJwEYVSDtmgGpFqDV/b8GUB0YbiU=
Received: from DLEE201.ent.ti.com (dlee201.ent.ti.com [157.170.170.76])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5A63u44Q2707347
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Nov 2025 21:56:04 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 21:56:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 5 Nov 2025 21:56:03 -0600
Received: from [172.24.233.20] (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A63txOt605883;
 Wed, 5 Nov 2025 21:56:00 -0600
Message-ID: <63a448a3-ca87-4df6-b34d-52ac21f366f0@ti.com>
Date: Thu, 6 Nov 2025 09:25:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 2/2] configs: am62x_evm_a53_defconfig: Enable
 A53 splashscreen at u-boot SPL
To: Andrew Davis <afd@ti.com>, <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, 
 <n-jain1@ti.com>, <tomi.valkeinen@ideasonboard.com>,
 <trini@konsulko.com>, <jd@denx.de>, <tl@denx.de>, <agust@denx.de>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <u-boot@lists.denx.de>
References: <20251105163040.4086273-1-s-jain1@ti.com>
 <20251105163040.4086273-3-s-jain1@ti.com>
 <e761adae-2a3c-42af-9dc6-b689e81ec746@ti.com>
Content-Language: en-US
From: Swamil Jain <s-jain1@ti.com>
In-Reply-To: <e761adae-2a3c-42af-9dc6-b689e81ec746@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Andrew,

On 11/6/25 02:30, Andrew Davis wrote:
> On 11/5/25 10:30 AM, Swamil Jain wrote:
>> From: Devarsh Thakkar <devarsht@ti.com>
>>
>> Enable A53 splashscreen at u-boot SPL stage. SPL_MAX_SIZE is bumped up
>> to 0x80000 to accommodate splash related code. Bloblist related macros
>> are enabled to preserve splash context till u-boot proper.  SPL Board
>> initialization Kconfig is set to dynamically update simple-framebuffer
>> and reserved-memory DT nodes before kernel bootup.
>>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> Signed-off-by: Swamil Jain <s-jain1@ti.com>
>> ---
>>   configs/am62x_a53_splashscreen.config | 16 ++++++++++++++++
>>   configs/am62x_evm_a53_defconfig       |  4 +++-
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>   create mode 100644 configs/am62x_a53_splashscreen.config
>>
>> diff --git a/configs/am62x_a53_splashscreen.config b/configs/ 
>> am62x_a53_splashscreen.config
>> new file mode 100644
>> index 00000000000..0419d60e281
>> --- /dev/null
>> +++ b/configs/am62x_a53_splashscreen.config
>> @@ -0,0 +1,16 @@
>> +CONFIG_FDT_SIMPLEFB=y
>> +CONFIG_VIDEO=y
>> +CONFIG_SYS_WHITE_ON_BLACK=y
>> +CONFIG_SPL_VIDEO_TIDSS=y
>> +CONFIG_BMP_24BPP=y
>> +CONFIG_BMP_32BPP=y
>> +CONFIG_SPL_VIDEO=y
>> +CONFIG_SPL_SPLASH_SCREEN=y
>> +CONFIG_SPL_SYS_WHITE_ON_BLACK=y
>> +CONFIG_SPL_SPLASH_SCREEN_ALIGN=y
>> +CONFIG_SPL_SPLASH_SOURCE=y
>> +CONFIG_SPL_BMP=y
>> +CONFIG_SPL_VIDEO_BMP_GZIP=y
>> +CONFIG_SPL_BMP_24BPP=y
>> +CONFIG_SPL_BMP_32BPP=y
>> +CONFIG_SPL_HIDE_LOGO_VERSION=y
>> diff --git a/configs/am62x_evm_a53_defconfig b/configs/ 
>> am62x_evm_a53_defconfig
>> index 4da668396d0..57d0cec2222 100644
>> --- a/configs/am62x_evm_a53_defconfig
>> +++ b/configs/am62x_evm_a53_defconfig
>> @@ -24,7 +24,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>   CONFIG_SPL_BSS_START_ADDR=0x80c80000
>>   CONFIG_SPL_BSS_MAX_SIZE=0x80000
>>   CONFIG_SPL_STACK_R=y
>> -CONFIG_SPL_SIZE_LIMIT=0x40000
>> +CONFIG_SPL_SIZE_LIMIT=0x80000
>>   CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x800
>>   CONFIG_SPL_FS_FAT=y
>>   CONFIG_SPL_LIBDISK_SUPPORT=y
>> @@ -88,6 +88,7 @@ CONFIG_DM_I2C=y
>>   CONFIG_SYS_I2C_OMAP24XX=y
>>   CONFIG_DM_MAILBOX=y
>>   CONFIG_K3_SEC_PROXY=y
>> +CONFIG_FS_LOADER=y
> 
> Why not put this in the config fragment?

Yeah, its better to put it in config fragment, will do in v4.

> 
>>   CONFIG_SUPPORT_EMMC_BOOT=y
>>   CONFIG_MMC_IO_VOLTAGE=y
>>   CONFIG_SPL_MMC_IO_VOLTAGE=y
>> @@ -143,3 +144,4 @@ CONFIG_EFI_SET_TIME=y
>>   #include <configs/k3_efi_capsule.config>
>>   #include <configs/am62x_a53_usbdfu.config>
>> +#include <configs/am62x_a53_splashscreen.config>
>> \ No newline at end of file
> 
> Fix this and your tools to not allow it.
>

Sure, Thanks!!

Regards,
Swamil

> Andrew

