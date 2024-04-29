Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193A1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 20:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EA858894E;
	Mon, 29 Apr 2024 22:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714423865;
	bh=rOUXJTPseS9tSll1Icnf79i5aQ4OIXftRldr0VlU1DM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sfxXR7KQ6kARy/XY1pBDUYdlUMA+aa1bySJZ7+ZxnksxiXoEN9Uf7IIhE8Tsy7Mdt
	 vaTAJGZxp6yJT+Fmr/tpOJUveqi19lfr6LrTwyuftYrfyaytZejzr4Y+pmbXEmh7N5
	 RTW0CshAke7wYg6fVSGd2bnrZlnUIJvbnH5Tz8HBX/BdRFetRHTkLc4bqZI1hV9oUw
	 wCkx3r/Lme2QbthR3lbs/oWaj6lX2cqasjFqZF0YkFzT38+MkQz/utieq1HZjYzwkT
	 JEZVSKyeyMK1pU3qP5iH7xcbldsmuSeVrLCtcfFVxdI9Rg7UFCiLPVDiaTUFKH/055
	 pfryTBnwy1+Sw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 75CE788827;
 Mon, 29 Apr 2024 22:51:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714423865;
 bh=rOUXJTPseS9tSll1Icnf79i5aQ4OIXftRldr0VlU1DM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=t8agNdVLOnokSrimggxRmShYldnqAEjH3LI+MMCJp3K3rFt7TB04kwjru48+d8/np
 +ER0B/5kcKebZ6g8e0uZI6f0pJA6B+RuiAtVBMrfrXIuBX50eK/UfZC04N3im251J8
 4GcSJ6IGjBHgDnxrgn6Nr1t5XsiPUmgejPKOCnS5r8pYqXm2RXmrCptrcYCflag0bP
 rOk7KenKOQS7UV/7niB8RG5WCWSkDYNA5/8iF3IMUeCMdP7J99OT8FknyH3NLiBspl
 Olpg1q6LsN2G2427ZqOWWGLRJhzgo9uITPcrD+NQtqQ7hwsqNY2+H1cbi/XOpizni5
 RCLldyO1NMGyw==
Message-ID: <771fb037-0f69-4fc2-b4cf-4bbe41d6f9e9@denx.de>
Date: Mon, 29 Apr 2024 22:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: Enable kaslrseed command on DH i.MX8M Plus DHCOM
To: Tim Harvey <tharvey@gateworks.com>
Cc: Fabio Estevam <festevam@gmail.com>, Fabio Estevam <festevam@denx.de>,
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com, Claudius Heine <ch@denx.de>
References: <20240120003610.124981-1-marex@denx.de>
 <CAJ+vNU31BNnThbDDrvaThPy01roPTGXYWJbp4wbJeD-K0gjpzQ@mail.gmail.com>
 <2e4997d2-1f10-46f8-b2f2-6ac641368f04@denx.de>
 <CAJ+vNU0Og=g-xxjgWdu9g4U=DR6fuKoDWNUr9PB0VnL99bcu2Q@mail.gmail.com>
 <CAOMZO5DL683849BczPa9aJvMJxZm536vp-wE5P+jcCK1KLkGEg@mail.gmail.com>
 <6783be1a-ade0-4cf2-89d6-b6ec29df5ce0@denx.de>
 <CAJ+vNU13yh8K4UbK2xLCwS74gn25NGFUFHd_n_EqbknyVmAdSg@mail.gmail.com>
 <47bfd824-d4e1-41d3-b236-b488edd67504@denx.de>
 <CAJ+vNU05SGZbFMWdzo=5Q0438rW2aRhRBZS4WQnqUMe89-9rZg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU05SGZbFMWdzo=5Q0438rW2aRhRBZS4WQnqUMe89-9rZg@mail.gmail.com>
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

On 4/29/24 9:10 PM, Tim Harvey wrote:
> On Tue, Apr 23, 2024 at 4:18 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/19/24 5:24 PM, Tim Harvey wrote:
>>> On Thu, Apr 18, 2024 at 11:42 AM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 4/18/24 8:02 PM, Fabio Estevam wrote:
>>>>> Hi Tim,
>>>>>
>>>>> On Thu, Apr 18, 2024 at 2:54 PM Tim Harvey <tharvey@gateworks.com> wrote:
>>>>>
>>>>>> Fabio, if you enable CONFIG_DM_RNG on an imx8m{m,p}_evk do you get the
>>>>>> following in the SPL?
>>>>>> Couldn't bind rng driver (-96)
>>>>>> SEC0:  RNG instantiated
>>>>>>
>>>>>> sec_init failed!
>>>>>
>>>>> Yes, if I add CONFIG_DM_RNG=y to imx8mm_evk_defconfig I get:
>>>>>
>>>>> U-Boot SPL 2024.04-00793-g3434b88d2c2f-dirty (Apr 18 2024 - 14:58:57 -0300)
>>>>> No pmic
>>>>> Couldn't bind rng driver (-96)
>>>>> SEC0:  RNG instantiated
>>>>>
>>>>> sec_init failed!
>>>>
>>>> Interesting. Which TFA blob version do you use ? I used the mainline
>>>> 2.10 for my tests.
>>>
>>> Marek,
>>>
>>> Were you able to reproduce this as well with the board you enabled
>>> DM_RNG for? If it does work fine what dtb were you using... perhaps
>>> there is something in its u-boot.dtsi that we need?
>>
>> This one arch/arm/dts/imx8mp-dhcom-pdk3.dts , see log below. The build
>> has a few extra patches in it, but nothing which affects the KASLR:
>>
>> $ export SOURCE_DATE_EPOCH=1672531200 ; echo tst > .scmversion
>> $ make imx8mp_dhcom_pdk3_defconfig ; make
>>
>> U-Boot SPL 2024.07-rc1tst (Jan 01 2023 - 00:00:00 +0000)
>> DDR:   4096 MiB [0x5]
>> DDR:   Inline ECC enabled
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
>> Trying to boot from BOOTROM
>> Boot Stage: Primary boot
>> image offset 0x1000, pagesize 0x1, ivt offset 0x0
>> NOTICE:  Do not release JR0 to NS as it can be used by HAB
>> NOTICE:  BL31: v2.10.0  (release):v2.10.0-5-gfb51ca229
>> NOTICE:  BL31: Built : 20:30:36, Apr 23 2024
>>
>>
>> U-Boot 2024.07-rc1tst (Jan 01 2023 - 00:00:00 +0000)
>>
>> CPU:   Freescale i.MX8MP[8] rev1.1 1600 MHz (running at 1200 MHz)
>> CPU:   Industrial temperature grade (-40C to 105C) at 70C
>> Reset cause: POR
>> Model: DH electronics i.MX8M Plus DHCOM Premium Developer Kit (3)
>> DRAM:  3.5 GiB
>> Core:  183 devices, 34 uclasses, devicetree: separate
>> WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
>> MMC:   FSL_SDHC: 0, FSL_SDHC: 1
>> Loading Environment from SPIFlash... SF: Detected w25q128jw with page
>> size 256 Bytes, erase size 4 KiB, total 16 MiB
>> OK
>> In:    serial
>> Out:   serial
>> Err:   serial
>> SEC0:  RNG instantiated
>> Net:   eth1: ethernet@30be0000, eth0: ethernet@30bf0000
>> ...
>>
>>> The error -EPFNOSUPPORT is interesting and helps point to the only
>>> place it can be where the comment says the strange errno is to make
>>> this easier to find:
>>> https://elixir.bootlin.com/u-boot/latest/source/drivers/core/uclass.c#L70:
>>>           if (!uc_drv) {
>>>                   debug("Cannot find uclass for id %d: please add the
>>> UCLASS_DRIVER() declaration for this UCLASS_... id\n",
>>>                         id);
>>>                   /*
>>>                    * Use a strange error to make this case easier to find. When
>>>                    * a uclass is not available it can prevent driver model from
>>>                    * starting up and this failure is otherwise hard to debug.
>>>                    */
>>>                   return -EPFNOSUPPORT;
>>>           }
>>>
>>> I'm not very familiar with the dm driver binding - does the
>>> U-BOOT_DRIVER usage in drivers/crypto/fsl/rng.c need to be refactored
>>> to use UCLASS_DRIVER for it to be usable in both SPL and U-Boot?
>>
>> I don't think you need the CAAM RNG in SPL in the first place, or do you ?
>>
>>> Honestly I don't know why we need DM_RNG in SPL anyway and we could
>>> just add support for disabling it there to avoid unwanted bloat.
>>
>> I think you can disable it , yes.
> 
> Marek,
> 
> Would it be advantageous for the kaslr-seed to be added automatically
> from image_setup_libfdt?

Yes, can you prepare a patch ? (I wanted to do this, just haven't had 
the time)

> I notice arch/arm/cpu/armv8/fsl-layerscape/fdt.c:ft_cpu_setup does
> this and board/raspberrypi/rpi/rpi.c looks like it copies kaslr-seed
> from the control fdt which I assume was added by an earlier layer for
> that target.

Right, exactly, this .

> I'm not clear if there is a disadvantage to automatically adding this
> node if DM_RNG is enabled.

I would say, add it.
