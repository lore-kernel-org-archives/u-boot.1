Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1A3CE79CF
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 11:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C828D869F1;
	Wed, 20 Sep 2023 13:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695210648;
	bh=Cq30Hy/N9Fxi6tsUTyjhd8u89V81JAAsvwpBXlWU8g8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Uns/aA3UpagI0Lt39vbeusBObHh82SOlguG+XVKdlbdQbO0psALfjDCAgHgbiV/QO
	 H0WV7ZV0dTcci914DqajSKSpcdury2SEMMI0JSXf5h2RSSQ/ENK8VV6gs4OkGKl+3Y
	 lt6QuYuqM9JvOvu2gStqu301uxFM2dh7RGn/r6ofpyaRG+e17FDdNOKv64PfYUoitz
	 Du3gjEHc0jgSlInJ82xSTq2bdf0O4J9PlCNfKPItfrKF5ZQ5rd3XCksoH90KS1hDEY
	 boQWF5J6C5bL013CLBd5DUqfPTR11AgJFC08c5ih3wh2P/IUEZLLWEHzC8MOKRldhP
	 UjAYu7q8YrlMQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 43664869D8;
 Wed, 20 Sep 2023 13:50:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1695210647;
 bh=Cq30Hy/N9Fxi6tsUTyjhd8u89V81JAAsvwpBXlWU8g8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IVFlhNRHqm/4Y/BO3VduLNdVTiVNQO6aT3kYjNn99mBM/WHrv5Nnxm0gS1PxRGbo0
 rxgwEFpsxxa85Gl0BQnZSaFHeuN+bZ7Qh8DHNW4RsfuKKyGHgcAapYNIq5HkE7KWH5
 6D7JZ6/WuCfZzDouGdSFuphgC7xOBr05TYkwSxYFLEpUXTbn62aBs8Guql3VwLMMEK
 y7FnuMDBDgM5e1PcMXWQ7/F6GCvHgxbmXLe5BQ6mvUzZ7VGxtSC0sscLE/QuuuQ6Ai
 mC0cnRYuRlceuWpOHG9IfIz8tbbaSlVn2o7uB5itEpW7Ea/Gqa3CAFE4NjmKkA5Kg+
 vwt/An4o1Kgtw==
Message-ID: <e40d4f2f-7fdf-d565-eeba-ca27f1fa44d7@denx.de>
Date: Wed, 20 Sep 2023 13:50:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 08/20] x86: coreboot: Drop USB init on startup
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-9-sjg@chromium.org>
 <6c3f7c16-c67b-4c7d-9d91-0e214702fa88@gmx.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <6c3f7c16-c67b-4c7d-9d91-0e214702fa88@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 9/20/23 09:19, Heinrich Schuchardt wrote:
> On 9/20/23 05:00, Simon Glass wrote:
>> This is very annoying as it is quite slow on many machines. Also, U-Boot
>> has an existing 'preboot' mechanism to enable this feature if desired.
>>
>> Drop this code so that it is possible to choose whether to init USB or
>> not.
>>
>> Use the existing USE_PREBOOT mechanism instead.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> ---
>>
>> Changes in v5:
>> - Make use of the uSE_PREBOOT mechanism
>>
>>   arch/x86/cpu/coreboot/Kconfig    | 1 +
>>   arch/x86/cpu/coreboot/coreboot.c | 4 ----
>>   2 files changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/cpu/coreboot/Kconfig 
>> b/arch/x86/cpu/coreboot/Kconfig
>> index b97c27790419..178f8ad18162 100644
>> --- a/arch/x86/cpu/coreboot/Kconfig
>> +++ b/arch/x86/cpu/coreboot/Kconfig
>> @@ -25,6 +25,7 @@ config SYS_COREBOOT
>>       imply FS_CBFS
>>       imply CBMEM_CONSOLE
>>       imply X86_TSC_READ_BASE
>> +    imply USE_PREBOOT
> 
> For automatic initialization of the PCI bus we have CONFIG_PCI_INIT_R.
> Wouldn't it be preferable to also have a CONFIG_USB_INIT_R instead of
> relying on console commands in CONFIG_PREBOOT?

I'd much prefer 'preboot=usb init' or whatever console command, since 
this is not hard-coded into the U-Boot binary and can be overridden by 
user if the 'usb init' is inconvenient/unnecessary/... without replacing 
and/or rebuilding the U-Boot binary.
