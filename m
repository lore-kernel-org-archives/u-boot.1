Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29921C54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 14:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAB5787D4B;
	Thu, 14 Mar 2024 15:35:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mEs59ncT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8867187D6B; Thu, 14 Mar 2024 15:35:37 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F7387CF9
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 15:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42EEZQKE062306;
 Thu, 14 Mar 2024 09:35:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710426926;
 bh=mIHeZSVlrVkDx9szQ8TjQrOdUJ6LbQwArUE1VOdquKA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=mEs59ncTnOqKmJJBEkK1xstMfsofnYlHT1oCAap9WqEkdatOKMMRWRuUQkaEWAqGZ
 L/CYRpbHRg5LbXO7rgL4HtnxJkho5rsi7pwJUTHgBW8rmCItkilS/UJPfecs+wBDED
 FjHUZek3ORcP9UNzYkAsFzNGsuqfRFZrtejGWT+Q=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42EEZQvp017886
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 14 Mar 2024 09:35:26 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Mar 2024 09:35:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Mar 2024 09:35:26 -0500
Received: from [10.249.135.225] ([10.249.135.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42EEZMeU011875;
 Thu, 14 Mar 2024 09:35:22 -0500
Message-ID: <8ccbd336-dfb5-4885-a7ad-052b390de07c@ti.com>
Date: Thu, 14 Mar 2024 20:05:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, MD Danish Anwar <danishanwar@ti.com>
CC: Roger Quadros <rogerq@kernel.org>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <20240307124612.GA4110939@bill-the-cat>
 <af15ffae-fbf1-4b14-8035-1f95beb440e1@ti.com>
 <dc9cb18e-e7a0-4389-abc7-fbeda907bd56@ti.com>
 <20240314124652.GV3442575@bill-the-cat>
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240314124652.GV3442575@bill-the-cat>
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



On 3/14/2024 6:16 PM, Tom Rini wrote:
> On Tue, Mar 12, 2024 at 02:02:08PM +0530, MD Danish Anwar wrote:
>>
>>
>> On 11/03/24 10:34 am, Anwar, Md Danish wrote:
>>>
>>>
>>> On 3/7/2024 6:16 PM, Tom Rini wrote:
>>>> On Wed, Feb 28, 2024 at 05:36:45PM +0530, MD Danish Anwar wrote:
>>>>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>>>>
>>>>> same firmware.
>>>>>
>>>>> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
>>>>> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
>>>>> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
>>>>> load the firmware file to the remote processor and start the remote
>>>>> processor.
>>>>>
>>>>> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
>>>>> Kconfig so that we can call request_firmware_into_buf() from remoteproc
>>>>> driver.
>>>>>
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>>>>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>>>>
>>>> This breaks building on am64x_evm_r5 am65x_evm_r5_usbdfu
>>>> am65x_evm_r5_usbmsc in next currently, thanks.
>>>>
>>> I will work on fixing this build error and re-spin the patch.
>>>
>>
>> Hi Tom, Roger,
>>
>> This patch adds "request_firmware_into_buf()" in the rproc driver. To
>> use this API, FS_LOADER is needed. So I am adding "select FS_LOADER" in
>> REMOTEPROC Kconfig option. As a result whenever REMOTEPROC is enabled,
>> FS_LOADER also gets enabled.
>>
>> Now arch/arm/mach-k3/common.c [1] and arch/arm/mach-omap2/boot-common.c
>> [2] has a "load_firmware()" API which calls fs-loader APIs and they have
>> below if condition before calling fs-loader APIs.
>>
>> if (!IS_ENABLED(CONFIG_FS_LOADER))
>> 		return 0;
>>
>> Till now, CONFIG_FS_LOADER was not set as a result the load_firmware()
>> API in above mentioned files, was returning 0.
>>
>> Now as this patch enables CONFIG_FS_LOADER, as a result the code after
>> the if check starts getting executed and it tries to look for
>> get_fs_loader() and other fs-loader APIs but this is done at SPL and at
>> this time FS_LOADER is not built yet as a result we see below error.
>> The if checks only checks for CONFIG_FS_LOADER but not for
>> CONFIG_SPL_FS_LOADER.
>>
>>   AR      spl/boot/built-in.o
>>   LD      spl/u-boot-spl
>> arm-none-linux-gnueabihf-ld.bfd: arch/arm/mach-k3/common.o: in function
>> `load_firmware':
>> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:184: undefined
>> reference to `get_fs_loader'
>> arm-none-linux-gnueabihf-ld.bfd:
>> /home/danish/workspace/u-boot/arch/arm/mach-k3/common.c:185: undefined
>> reference to `request_firmware_into_buf'
>> make[2]: *** [/home/danish/workspace/u-boot/scripts/Makefile.spl:527:
>> spl/u-boot-spl] Error 1
>> make[1]: *** [/home/danish/workspace/u-boot/Makefile:2055:
>> spl/u-boot-spl] Error 2
>> make[1]: Leaving directory '/home/danish/uboot_images/am64x/r5'
>> make: *** [Makefile:177: sub-make] Error 2
>>
>> This bug has always been there but as CONFIG_FS_LOADER was never
>> enabled, this build error was never seen as the load_firmware() API will
>> return 0 without calling fs-loader APIs.
>>
>> Now that this patch enables CONFIG_FS_LOADER, the bug gets exposed and
>> build error is seen.
>>
>> My opinion here would be, to check for CONFIG_IS_ENABLED(FS_LOADER)
>> instead of IS_ENABLED(CONFIG_FS_LOADER) as the former will check for the
>> appropriate config option (CONFIG_SPL_FS_LOADER / CONFIG_FS_LOADER)
>> based on the build stage.
>>
>> I tested with the below diff and I don't see build errors with
>> am64x_evm_r5, am65x_evm_r5_usbdfu, am65x_evm_r5_usbmsc configs.
>>
>> diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
>> index f411366778..6792ff7467 100644
>> --- a/arch/arm/mach-k3/common.c
>> +++ b/arch/arm/mach-k3/common.c
>> @@ -162,7 +162,7 @@ int load_firmware(char *name_fw, char
>> *name_loadaddr, u32 *loadaddr)
>>         char *name = NULL;
>>         int size = 0;
>>
>> -       if (!IS_ENABLED(CONFIG_FS_LOADER))
>> +       if (!CONFIG_IS_ENABLED(FS_LOADER))
>>                 return 0;
>>
>>         *loadaddr = 0;
>> diff --git a/arch/arm/mach-omap2/boot-common.c
>> b/arch/arm/mach-omap2/boot-common.c
>> index 57917da25c..aa0ab13d5f 100644
>> --- a/arch/arm/mach-omap2/boot-common.c
>> +++ b/arch/arm/mach-omap2/boot-common.c
>> @@ -190,7 +190,7 @@ int load_firmware(char *name_fw, u32 *loadaddr)
>>         struct udevice *fsdev;
>>         int size = 0;
>>
>> -       if (!IS_ENABLED(CONFIG_FS_LOADER))
>> +       if (!CONFIG_IS_ENABLED(FS_LOADER))
>>                 return 0;
>>
>>         if (!*loadaddr)
>>
>>
>> Tom, Roger, Please let me know if this looks ok.
>> If it's ok, I will post this diff as a separate patch and once that is
>> merged Tom can merge this patch or I can send a v7 if needed.
> 
> Yes, this seems like the right path, thanks.
> 
Thanks Tom. Posted this diff as patch
https://lore.kernel.org/all/20240314143311.259568-1-danishanwar@ti.com/

-- 
Thanks and Regards,
Md Danish Anwar
