Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8398DC0219D
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 21:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBA6807AE;
	Fri,  7 Feb 2025 22:57:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LBtkfdup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23381807D7; Fri,  7 Feb 2025 22:57:57 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D42B80756
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 22:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 517LvqRk3000562
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 7 Feb 2025 15:57:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738965472;
 bh=ihJx7vOpuH35JsvsXKMgRbsd60JYpdg/JANEM9yUfFQ=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=LBtkfdupp3OTV7/KjY6TQhKS8b9Z2jsSME+Sfrpk1VFncIBNnhjEMFdR81M7pdUqY
 c8qR1aDKE7fHTIRYyML6N2tPiO5QholiA686iN+dZvELC1lcYdkPxVMchhP0mdW0d7
 /44/xolPWL9uNRqe5XNAKPoxOwfVJGnbs6FXfKAw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 517LvpKd036909
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 7 Feb 2025 15:57:51 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Feb 2025 15:57:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Feb 2025 15:57:51 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 517LvpMb030439;
 Fri, 7 Feb 2025 15:57:51 -0600
Message-ID: <4016842e-b82f-4214-a8ab-cc52d81ef454@ti.com>
Date: Fri, 7 Feb 2025 15:57:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] configs: am6*_evm_a53_defconfig: Enable remoteproc
 support
To: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
References: <20250206015406.2702944-1-jm@ti.com>
 <20250206015406.2702944-7-jm@ti.com>
 <90090081-09d3-4c02-937b-f35e1594f434@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <90090081-09d3-4c02-937b-f35e1594f434@ti.com>
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

On 2/6/25 5:07 PM, Andrew Davis wrote:
> On 2/5/25 7:54 PM, Judith Mendez wrote:
>> From: Hari Nagalla <hnagalla@ti.com>
>>
>> Enable configs needed to enable remoteproc drivers for AM62
>> and AM64 devices.
>>
>> While we are here, cleanup some remoteproc configs, there
>> is no DSP subsystem for am62px device.
>>
>> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v3:
>> - Add remoteproc support configs for am62x
>> - Cleanup remoteproc configs for am62p and am64x.
>> ---
>>   configs/am62px_evm_a53_defconfig | 1 -
>>   configs/am62x_evm_a53_defconfig  | 2 ++
>>   configs/am64x_evm_a53_defconfig  | 4 +++-
>>   3 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/configs/am62px_evm_a53_defconfig 
>> b/configs/am62px_evm_a53_defconfig
>> index 30b4a24ee9a..10e00519bc1 100644
>> --- a/configs/am62px_evm_a53_defconfig
>> +++ b/configs/am62px_evm_a53_defconfig
>> @@ -147,7 +147,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>>   CONFIG_SPL_DM_REGULATOR_GPIO=y
>>   CONFIG_K3_SYSTEM_CONTROLLER=y
>>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
>> -CONFIG_REMOTEPROC_TI_K3_DSP=y
>>   CONFIG_REMOTEPROC_TI_K3_R5F=y
>>   CONFIG_RESET_TI_SCI=y
>>   CONFIG_DM_RTC=y
>> diff --git a/configs/am62x_evm_a53_defconfig 
>> b/configs/am62x_evm_a53_defconfig
>> index c77e09db156..51b8c0ae3fb 100644
>> --- a/configs/am62x_evm_a53_defconfig
>> +++ b/configs/am62x_evm_a53_defconfig
>> @@ -56,6 +56,7 @@ CONFIG_SPL_YMODEM_SUPPORT=y
>>   CONFIG_CMD_BOOTEFI_SELFTEST=y
>>   CONFIG_CMD_NVEDIT_EFI=y
>>   CONFIG_CMD_MMC=y
>> +CONFIG_CMD_REMOTEPROC=y
>>   CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_MMC_SPEED_MODE_SET=y
>>   CONFIG_OF_CONTROL=y
>> @@ -121,6 +122,7 @@ CONFIG_DM_REGULATOR_GPIO=y
>>   CONFIG_SPL_DM_REGULATOR_GPIO=y
>>   CONFIG_K3_SYSTEM_CONTROLLER=y
>>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
>> +CONFIG_REMOTEPROC_TI_K3_M4F=y
>>   CONFIG_RESET_TI_SCI=y
>>   CONFIG_DM_RTC=y
>>   CONFIG_RTC_EMULATION=y
>> diff --git a/configs/am64x_evm_a53_defconfig 
>> b/configs/am64x_evm_a53_defconfig
>> index a501f3f567e..5528f54549d 100644
>> --- a/configs/am64x_evm_a53_defconfig
>> +++ b/configs/am64x_evm_a53_defconfig
>> @@ -70,6 +70,7 @@ CONFIG_CMD_DFU=y
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_I2C=y
>>   CONFIG_CMD_MMC=y
>> +CONFIG_CMD_REMOTEPROC=y
>>   CONFIG_CMD_USB=y
>>   CONFIG_CMD_EFIDEBUG=y
>>   CONFIG_CMD_TIME=y
>> @@ -149,8 +150,9 @@ CONFIG_DM_REGULATOR=y
>>   CONFIG_DM_REGULATOR_TPS65219=y
>>   CONFIG_K3_SYSTEM_CONTROLLER=y
>>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
>> +CONFIG_REMOTEPROC_TI_K3_M4F=y
>> +CONFIG_REMOTEPROC_TI_K3_R5F=y
> 
> Would it work better to add these to the kconfig for AM64 so
> other boards get this without needing to add to each defconfig?

I can do that.

It would also be nice to do the same for other Sitara devices
so will do that as well.

Will respin the series with this change.

Thanks Andrew,

Judith

> 
> Otherwise whole series looks fine to me,
> 
> Reviewed-by: Andrew Davis <afd@ti.com>
> 
>>   CONFIG_REMOTEPROC_TI_PRU=y
>> -CONFIG_CMD_REMOTEPROC=y
>>   CONFIG_RESET_TI_SCI=y
>>   CONFIG_DM_RTC=y
>>   CONFIG_RTC_EMULATION=y

