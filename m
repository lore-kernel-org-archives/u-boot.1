Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57D2C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28BEA833D1;
	Wed, 28 May 2025 17:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mE/FyWNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EACA8384E; Wed, 28 May 2025 17:39:09 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F0198334F
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54SFd47x3292039;
 Wed, 28 May 2025 10:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748446744;
 bh=4Ge60MbfZHaQKkZE7UPjusoVk+HlMCT7YE9Qx/S9kyY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mE/FyWNW6fK5CTlm9MOPVmNEBprMl1/ixhls1fONGydvYjkGomjevYBF8YzGs1bMU
 o1Z7Hn0UR6NYrIxd22MpimRjbKT76gu1VUd90dRBZDPYcLv7PWUKONsY/4giPUWNjg
 54kb02uE0msYU0+B05l7xT4GrTfYohWGCNNGhUyc=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54SFd4Vi3541832
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 28 May 2025 10:39:04 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 May 2025 10:39:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 May 2025 10:39:03 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54SFd2m4243058;
 Wed, 28 May 2025 10:39:03 -0500
Message-ID: <9183b5da-e8fb-4697-b0ba-da49e185c378@ti.com>
Date: Wed, 28 May 2025 10:39:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/9] spl: Kconfig: allow K3 devices to use falcon mode
To: Anshul Dalal <anshuld@ti.com>, "Raghavendra, Vignesh" <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <b-liu@ti.com>
References: <20250428141235.1734014-1-anshuld@ti.com>
 <20250428141235.1734014-2-anshuld@ti.com>
 <b3cc74a0-3903-4970-89b3-eceb973a791c@ti.com>
 <D9PM26J8COAY.1ACTT0I6VHQJH@ti.com>
 <3741d859-2048-4b32-9c1e-f551ec62d377@ti.com>
 <D9QG8DY630MX.1OV8MBZIM4R8S@ti.com>
 <d42967c8-925d-4731-85e1-5962c9befbfa@ti.com>
 <D9QQZM1V6ZV1.2Q7C9F387H6P7@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <D9QQZM1V6ZV1.2Q7C9F387H6P7@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/8/25 6:37 AM, Anshul Dalal wrote:
> On Thu May 8, 2025 at 9:32 AM IST, Vignesh Raghavendra wrote:
>>
>>
>> On 5/8/2025 8:42 AM, Anshul Dalal wrote:
>>> On Wed May 7, 2025 at 11:36 PM IST, Andrew Davis wrote:
>>>> On 5/6/25 10:33 PM, Anshul Dalal wrote:
>>>>> On Tue May 6, 2025 at 8:03 PM IST, Andrew Davis wrote:
>>>>>> On 4/28/25 9:12 AM, Anshul Dalal wrote:
>>>>>>> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
>>>>>>> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
>>>>>>> HS devices and can be enabled on K3 devices.
>>>>>>>
>>>>>>> For secure boot, the kernel with x509 headers can be packaged in a fit
>>>>>> "can be", this is the issue. Security is not just allowing methods that
>>>>>> are security checked, but forcing the use of such methods. Setting
>>>>>> OS_BOOT opens up several paths that look for non-FIT images. These
>>>>>> images do not enforce authentication like FIT does. This means one can
>>>>>> bypass secure boot when OS_BOOT is enabled by simply placing a non-FIT
>>>>>> boot image on the boot media.
>>>>>>
>>>>> As per spl_load_image_ext_os, the SPL first tries to load the file set
>>>>> in falcon_args_file env variable but since it's not set in our case. And
>>>>> the only way to set them is by rebuilding u-boot as uEnv.txt is not
>>>>> supported at SPL stage.
>>>>>
>>>>> This means the SPL only loads CONFIG_SPL_FS_LOAD_ARGS_NAME and
>>>>> CONFIG_SPL_FS_LOAD_KERNEL_NAME which are set as the DTB and fitImage
>>>> What is stopping me from replacing the content of the file "fitImage"
>>>> with a normal kernel image? When loading that image the file type
>>>> will be detected as a normal kernel image and all FIT logic bypassed,
>>>> including authentication, breaking our secure chain of trust.
>>>>
>>>> Andrew
>>> That would require booti_setup to be executed in spl_parse_image_header,
>>> which is not possible on the R5 SPL since the required config symbol
>>> CMD_BOOTI is only available for ARM64 platforms.
>>>
>>> In the worst case we end up loading a 32-bit zImage which wouldn't
>>> boot on the Cortex-A cores anyway and would additionally require
>>> enabling CMD_BOOTZ (currently disabled) at build time.
>>
>> Is there any path where R5 SPL can be tricked to load and jump to
>> arbitrary binary? zImage, Image, elf, bin whatever?
>>
>> IOW, does SPL_OS_BOOT always check for some sort of header for the image
>> that it loads and the only type of header we have enabled here is fitImage?
> 
> It does check for the header and proceeds only with the desired security
> enforced execution flow if the loaded image is FIT. For all other image
> types, they are guarded by config symbols that are set unset in our case

Are you sure?

The only thing preventing this from continuing in spl_parse_image_header()
is a check for CONFIG_SPL_PANIC_ON_RAW_IMAGE. Which is not set for us.

After that we check if OS_BOOT is enabled and if so allow for kernel
images to also pass[0]. What stops this from functioning?

Andrew

[0] https://github.com/u-boot/u-boot/blob/master/common/spl/spl.c#L338

> except for spl_parse_legacy_header which could be triggered but would
> just lead to a boot failure as we don't override the default weak
> definition.
> 
> Regards,
> Anshul
> 
