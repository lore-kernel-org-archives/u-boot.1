Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405FFC48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 04:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655AA8795D;
	Thu, 29 Feb 2024 05:45:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QN0oq2vj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8458487811; Thu, 29 Feb 2024 05:45:25 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F05B787811
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 05:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41T4jFcG014304;
 Wed, 28 Feb 2024 22:45:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709181915;
 bh=hDPkQt9zbwoMXuBWsa6IxZTIQibm7QQ2GCIvDQGIC+E=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=QN0oq2vjLPRdSsNaOgkKtuKwl//DPurkqtVIj3vk1xjNIRC0Kee0wGCODKt7Ynery
 1lWMaaFdq0rX47R8/5GVlqEjSYHNv7m2zKQTFDxS3t84xJZLcA1Mgrk/LTB32ncdWT
 ihGfhtG5D2g8nw67uZsVKn8xSa7K5MXtGXpiJqiw=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41T4jFqx011823
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Feb 2024 22:45:15 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 22:45:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 22:45:14 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41T4j961021027;
 Wed, 28 Feb 2024 22:45:10 -0600
Message-ID: <279929c8-3c5b-4a69-b291-884732d06d69@ti.com>
Date: Thu, 29 Feb 2024 10:15:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] configs: j721e_sk: Move to separate defconfig for
 J721E SK board
To: Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, <trini@konsulko.com>,
 <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <bb@ti.com>,
 <nm@ti.com>, <sumit.garg@linaro.org>
CC: <michal.simek@amd.com>, <marex@denx.de>, <neil.armstrong@linaro.org>,
 <vigneshr@ti.com>, <kamlesh@ti.com>, <m-chawdhry@ti.com>, <u-kumar1@ti.com>
References: <20240228112042.3437691-1-n-francis@ti.com>
 <20240228112042.3437691-2-n-francis@ti.com>
 <5de538d9-76d4-480f-9381-9a39d629ac3f@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <5de538d9-76d4-480f-9381-9a39d629ac3f@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Andrew

On 28/02/24 20:41, Andrew Davis wrote:
> On 2/28/24 5:20 AM, Neha Malcom Francis wrote:
>> Add defconfig for J721E SK R5 and A72 configuration.
>>
>> This includes and modifies the J721E EVM defconfigs:
>> j721e_evm_r5_defconfig -> j721e_sk_r5_defconfig
>> j721e_evm_a72_defconfig -> j721e_sk_a72_defconfig
>>
>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
>> ---
>>   board/ti/j721e/MAINTAINERS      | 2 ++
>>   configs/j721e_evm_a72_defconfig | 2 +-
>>   configs/j721e_evm_r5_defconfig  | 2 +-
>>   configs/j721e_sk_a72_defconfig  | 4 ++++
>>   configs/j721e_sk_r5_defconfig   | 5 +++++
>>   5 files changed, 13 insertions(+), 2 deletions(-)
>>   create mode 100644 configs/j721e_sk_a72_defconfig
>>   create mode 100644 configs/j721e_sk_r5_defconfig
>>
>> diff --git a/board/ti/j721e/MAINTAINERS b/board/ti/j721e/MAINTAINERS
>> index f5ca7d06a34..06aba53d9b0 100644
>> --- a/board/ti/j721e/MAINTAINERS
>> +++ b/board/ti/j721e/MAINTAINERS
>> @@ -5,5 +5,7 @@ F:    board/ti/j721e
>>   F:    include/configs/j721e_evm.h
>>   F:    configs/j721e_evm_r5_defconfig
>>   F:    configs/j721e_evm_a72_defconfig
>> +F:    configs/j721e_sk_r5_defconfig
>> +F:    configs/j721e_sk_a72_defconfig
>>   F:    configs/j7200_evm_r5_defconfig
>>   F:    configs/j7200_evm_a72_defconfig
>> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
>> index 74af5bebb51..21081a2a684 100644
>> --- a/configs/j721e_evm_a72_defconfig
>> +++ b/configs/j721e_evm_a72_defconfig
>> @@ -86,7 +86,7 @@ CONFIG_MMC_SPEED_MODE_SET=y
>>   # CONFIG_SPL_EFI_PARTITION is not set
>>   CONFIG_OF_CONTROL=y
>>   CONFIG_SPL_OF_CONTROL=y
>> -CONFIG_OF_LIST="k3-j721e-common-proc-board k3-j721e-sk"
>> +CONFIG_OF_LIST="k3-j721e-common-proc-board"
>>   CONFIG_MULTI_DTB_FIT=y
>>   CONFIG_SPL_MULTI_DTB_FIT=y
>>   CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>> diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
>> index bc4f35cce11..ce2b7df58cf 100644
>> --- a/configs/j721e_evm_r5_defconfig
>> +++ b/configs/j721e_evm_r5_defconfig
>> @@ -81,7 +81,7 @@ CONFIG_CMD_MTDPARTS=y
>>   CONFIG_OF_CONTROL=y
>>   CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_SPL_MULTI_DTB_FIT=y
>> -CONFIG_SPL_OF_LIST="k3-j721e-r5-common-proc-board k3-j721e-r5-sk"
>> +CONFIG_SPL_OF_LIST="k3-j721e-r5-common-proc-board"
>>   CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
>>   CONFIG_ENV_OVERWRITE=y
>>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> diff --git a/configs/j721e_sk_a72_defconfig b/configs/j721e_sk_a72_defconfig
>> new file mode 100644
>> index 00000000000..c47ad4a7616
>> --- /dev/null
>> +++ b/configs/j721e_sk_a72_defconfig
>> @@ -0,0 +1,4 @@
>> +#include <configs/j721e_evm_a72_defconfig>
>> +
>> +CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-sk"
>> +CONFIG_OF_LIST="k3-j721e-sk"
> 
> These two overrides should be all that is needed, but currently the `buildman`
> tool parses the *_defconfigs directly to determine what arch to build every
> defconfig  for when doing testing. So you also for now need to re-define the
> ARCH, even though it comes in from the include. See how it was done here[0].
> 
> Basically just add here:
> 
> CONFIG_ARM=y
> CONFIG_ARCH_K3=y
> CONFIG_SOC_K3_J721E=y
> CONFIG_TARGET_J721E_A72_EVM=y
> 
> Andrew
> 
> [0] https://lore.kernel.org/u-boot/20240223202153.3756094-15-a-nandan@ti.com/
> 

Ah didn't realise that thanks!

>> diff --git a/configs/j721e_sk_r5_defconfig b/configs/j721e_sk_r5_defconfig
>> new file mode 100644
>> index 00000000000..077e8606d57
>> --- /dev/null
>> +++ b/configs/j721e_sk_r5_defconfig
>> @@ -0,0 +1,5 @@
>> +#include <configs/j721e_evm_r5_defconfig>
>> +
>> +CONFIG_DEFAULT_DEVICE_TREE="k3-j721e-r5-sk"
>> +CONFIG_SPL_OF_LIST="k3-j721e-r5-sk"
>> +CONFIG_OF_LIST="k3-j721e-r5-sk"

-- 
Thanking You
Neha Malcom Francis
