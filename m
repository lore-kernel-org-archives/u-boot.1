Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD2EC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BC2388692;
	Thu, 18 Apr 2024 19:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713461584;
	bh=2t9ptt0+BA9Zhg5zLy4zc33XZHJI/o3JBu3FKvvwLq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=d9nVQEbQIGX4xlv7vIqOAm/1+pvpU/Yaiij3iFqwJAm+RbFVzz07SVaJlVxSBMjDK
	 vxNR8cdUszSOIxkW+l7lQ/JCHQ3jTmuOLGWaHsJ5lqgSrqP9DKn+1Ao7pu9Xad3imO
	 gVKZ0t8lxezt2dKeQ4QZERjRwSQ9DuDg78CqLrth4otTbEEcFsExTbGrfaIuz5JDih
	 wbkXFDTzm9A2jZFcDjT31Z30q0uDo5seyXO6te24F14APsvAzMUOtWehpoX+3bY76a
	 /eHgDeNqtLd1G9p1iBxC8MtJRZQtrnOwvkqnpOIVJyZpxB8QeL1SN+hSE8MkydprM1
	 S8YtqpDXZA+ng==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 62C888868B;
 Thu, 18 Apr 2024 19:33:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713461582;
 bh=2t9ptt0+BA9Zhg5zLy4zc33XZHJI/o3JBu3FKvvwLq8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tR1dcdt6GpF+8d9k/wx9q9k0jzU4iH1HFFo9adJowuJDh7ZMy61oZnphYq0UXPs1x
 tHEKhjCfFqJCwEeXgQHvn8pfGpmuJHpyUYQOJ/W7pljniSSohmgq/WLgUHj5rEze3/
 tb3Arr2yLm7G28n49oPGkyICoz9IpeA2PNCSF+Qiaq8BZhvEXbz3bZWAlZtlQgNXgS
 /2F1rVJbueaNCT9FoDj+vUASRyTyu1ulZrWy4pF8ualfm2mfKlyi6CJZwwNGHTQy2O
 FXnMuY1sEliHc0kjUVRaM+4wgrMm05Et7DY35QWzbE352eypH4+M9d8Sw1P9Ul36kl
 ooTlByloB3Rrw==
Message-ID: <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
Date: Thu, 18 Apr 2024 19:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
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

On 4/18/24 6:21 PM, Tim Harvey wrote:
> On Fri, Jan 19, 2024 at 4:36 PM Marek Vasut <marex@denx.de> wrote:
>>
>> Linux 6.6.y with KASLR enabled would print the following message on boot:
>> "
>> KASLR disabled due to lack of seed
>> "
>> Enable the 'kaslrseed' command so a random number seed can be pulled
>> from CAAM and inserted into the /chosen node 'kaslr-seed' property of
>> Linux kernel DT before boot, thus letting KASLR work properly.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Fabio Estevam <festevam@denx.de>
>> Cc: Stefano Babic <sbabic@denx.de>
>> Cc: u-boot@dh-electronics.com
>> ---
>>   configs/imx8mp_dhcom_pdk2_defconfig | 2 ++
>>   configs/imx8mp_dhcom_pdk3_defconfig | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
>> index 4f907ce00d0..23fb6272ad5 100644
>> --- a/configs/imx8mp_dhcom_pdk2_defconfig
>> +++ b/configs/imx8mp_dhcom_pdk2_defconfig
>> @@ -117,6 +117,7 @@ CONFIG_CMD_BOOTCOUNT=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_TIME=y
>>   CONFIG_CMD_GETTIME=y
>> +CONFIG_CMD_KASLRSEED=y
>>   CONFIG_CMD_SYSBOOT=y
>>   CONFIG_CMD_UUID=y
>>   CONFIG_CMD_PMIC=y
>> @@ -223,6 +224,7 @@ CONFIG_DM_REGULATOR_PCA9450=y
>>   CONFIG_SPL_DM_REGULATOR_PCA9450=y
>>   CONFIG_DM_REGULATOR_FIXED=y
>>   CONFIG_DM_REGULATOR_GPIO=y
>> +CONFIG_DM_RNG=y
>>   CONFIG_DM_RTC=y
>>   CONFIG_RTC_M41T62=y
>>   CONFIG_CONS_INDEX=2
>> diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
>> index 9972e2d96b6..0d47c12b1f9 100644
>> --- a/configs/imx8mp_dhcom_pdk3_defconfig
>> +++ b/configs/imx8mp_dhcom_pdk3_defconfig
>> @@ -119,6 +119,7 @@ CONFIG_CMD_BOOTCOUNT=y
>>   CONFIG_CMD_CACHE=y
>>   CONFIG_CMD_TIME=y
>>   CONFIG_CMD_GETTIME=y
>> +CONFIG_CMD_KASLRSEED=y
>>   CONFIG_CMD_SYSBOOT=y
>>   CONFIG_CMD_UUID=y
>>   CONFIG_CMD_PMIC=y
>> @@ -228,6 +229,7 @@ CONFIG_DM_REGULATOR_PCA9450=y
>>   CONFIG_SPL_DM_REGULATOR_PCA9450=y
>>   CONFIG_DM_REGULATOR_FIXED=y
>>   CONFIG_DM_REGULATOR_GPIO=y
>> +CONFIG_DM_RNG=y
>>   CONFIG_DM_RTC=y
>>   CONFIG_RTC_M41T62=y
>>   CONFIG_CONS_INDEX=2
>> --
>> 2.43.0
>>
> 
> Hi Marek,
> 
> Sorry to respond to an old thread but I ran across this when enabling
> KALSR on my boards.
> 
> I have noticed when you enable DM_RNG on IMX8M that SPL fails to bind
> the driver:
> Couldn't bind rng driver (-96)
> SEC0:  RNG instantiated
> 
> sec_init failed!

Did you enable CAAM and ARCH_MISC_INIT on your machine, to initialize 
CAAM in SPL ?

> Didn't you encounter this as well? It seems to me that we may need to
> add the ability to disable DM_RNG in the SPL unless I'm missing
> something.

No, but see above, I suspect that might be it, see also

1f908b1898bd ("ARM: imx8m: Deduplicate CAAM init with arch_misc_init() 
call")
