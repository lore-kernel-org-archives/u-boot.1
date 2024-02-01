Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464D6C47258
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 02:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D16F8760D;
	Thu,  1 Feb 2024 03:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KXrnQPF1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B9DF8760D; Thu,  1 Feb 2024 03:44:39 +0100 (CET)
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com
 [115.236.121.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B71E987BE9
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 03:44:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KXrnQPF1vFV7D3M4kVNyYjzm6dQWVLGy0ZoRhgPTi2BEPaF8JUTLyZa/EN2NRTPCzKbQP6RjUrTmHB687wmmrKhPMa0LcXqywPQ5u/k7qJK6pFkGAY9uQuAE/H+9pwrHwIP3bgHBn7D/9KlQxyozsaHGau4X88yZOB90rmmx2BA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=t/9hpiY9ozuKfDk5WOEeBaNEbqe2Z43bhtUAqD0it4I=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 6EDEE9001AC;
 Thu,  1 Feb 2024 10:43:56 +0800 (CST)
Message-ID: <5098c79e-95df-4a5f-8a34-ad58f80fa5d3@rock-chips.com>
Date: Thu, 1 Feb 2024 10:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] rockchip: rk3588: bind MMC controllers in U-Boot
 proper pre-reloc
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: heiko@sntech.de, u-boot@lists.denx.de
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-17-1eec1c34953c@theobroma-systems.com>
 <062d9519-f129-422c-89ed-3b009e222150@rock-chips.com>
 <5f4c826e-9ecf-4620-9430-b317e472cfd2@theobroma-systems.com>
 <928cfe56-1a7d-4024-aa9b-c14654b150e1@rock-chips.com>
 <f2ed9f73-97bb-446e-9396-9de3ab01b8d5@theobroma-systems.com>
 <8a101c97-cbd5-4e99-b89f-49fbe8fdd59b@rock-chips.com>
 <7b5cb03f-c2b2-4cf2-b06a-751d7cc978b9@theobroma-systems.com>
 <329e95d8-bedc-4a97-a651-13daab2c1cf8@rock-chips.com>
 <61d32ae7-689f-4f58-93a8-7e4f05967833@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <61d32ae7-689f-4f58-93a8-7e4f05967833@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8fSFYfQktLGRlOTU8fTElVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d628d342203a9kunm6edee9001ac
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kzo6GCo*QzMTHE0ZLh0oCgwM
 SRcaCSlVSlVKTEtNTE5OT0hDSU1KVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKT0xJSjcG
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


On 2024/2/1 01:55, Quentin Schulz wrote:
> Hi Kever,
>
> On 1/29/24 11:35, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/1/27 00:18, Quentin Schulz wrote:
>>> Hi Kever,
>>>
>>> On 1/26/24 11:56, Kever Yang wrote:
>>>> Hi Quentin,
>>>>
>>>> On 2024/1/26 17:32, Quentin Schulz wrote:
>>>>> Hi Kever,
>>>>>
>>>>> On 1/26/24 09:58, Kever Yang wrote:
>>>>>> Hi Quentin,
>>>>>>
>>>>>> On 2024/1/24 19:04, Quentin Schulz wrote:
>>>>>>> Hi Kever,
>>>>>>>
>>>>>>> On 1/24/24 11:35, Kever Yang wrote:
>>>>>>>> Hi Quentin,
>>>>>>>>
>>>>>>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>>>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>>>>>
>>>>>>>>> Since commit 9e644284ab81 ("dm: core: Report 
>>>>>>>>> bootph-pre-ram/sram node as
>>>>>>>>> pre-reloc after relocation"), bootph-pre-ram doesn't make 
>>>>>>>>> U-Boot proper
>>>>>>>>> bind the device before relocation.
>>>>>>>>>
>>>>>>>>> While this is usually not much of an issue, it is when there's 
>>>>>>>>> a lookup
>>>>>>>>> for devices by code running before the relocation. Such is the 
>>>>>>>>> case of
>>>>>>>>> env_init() which calls env_driver_lookup() which calls
>>>>>>>>> env_get_location() which is a weak symbol and may call
>>>>>>>>> arch_env_get_location() also a weak symbol. Those are two 
>>>>>>>>> functions that
>>>>>>>>> may traverse UCLASS to find some devices (e.g.
>>>>>>>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>>>>>>>
>>>>>>>> This sounds like we need to update arch_env_get_location() 
>>>>>>>> instead of enable mmc driver
>>>>>>>>
>>>>>>>> before relocate, because you we don't really need the mmc 
>>>>>>>> driver works here, there is no
>>>>>>>>
>>>>>>>> access requirement to mmc at this point, right?
>>>>>>>>
>>>>>>>
>>>>>>> All Rockchip SoCs except RK3588(S) and RK356x have it done this 
>>>>>>> way, a little bit of consistency wouldn't hurt :)
>>>>>>
>>>>>> My point is not about you can not enabe the emmc before relocate, 
>>>>>> maybe I'm not clear enough for the reason.
>>>>>>
>>>>>> All the driver bind/probed before the relocation will have to do 
>>>>>> the init sequence again later after relocation.
>>>>>>
>>>>>> The emmc driver cost pretty much time at init, we should avoid to 
>>>>>> duplicate the init process if possible.
>>>>>>
>>>>>> For this patch, you want to make it pre-relocate because you want 
>>>>>> to make sure the emmc is available for ENVL_MMC,
>>>>>>
>>>>>> but there is no read or write requirement to the emmc at this 
>>>>>> point, which means we don't have to init the emmc at this point,
>>>>>>
>>>>>> maybe we can check if the driver is enable if enough.
>>>>>>
>>>>>
>>>>> Now I need to know which SoC we are booting at build time so I can 
>>>>> check which drivers are supposed to be built, check those symbols 
>>>>> are enabled, then traverse the Device Tree with hardcoded DT node 
>>>>> to locations of MMC, SPI flash controllers, check if those are 
>>>>> enabled and finger-cross that those drivers will actually 
>>>>> bind/probe properly later on. That's A LOT of checks to be made.
>>>>
>>>> This is not what I want to say.
>>>>
>>>> What I mean is something  like this for arch_env_get_location() is 
>>>> enough, you don't have to bind/probe the emmc for env.
>>>>
>>>> 1623                 if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) && 
>>>> IS_ENABLED(CONFIG_MMC))
>>>> 1624                         return ENVL_MMC;
>>>>
>>>
>>> I do need to know if the device we loaded U-Boot proper from is an 
>>> MMC device or a SPI flash, so this is not enough for 
>>> arch_env_get_location().
>>>
>>> I could do it in a hack-ish way though and check if the U-Boot 
>>> proper load medium DT node name starts with /mmc, or /spi and if 
>>> neither, then return NOWHERE, but then we lose the ability of 
>>> returning NOWHERE if the driver wasn't compiled in or the device 
>>> didn't bind in pre-reloc, we're missing some failsafe mechanism I 
>>> could have with this patch :)
>>>
>>> [...]
>>>
>>>>>> For the feature record "spl-boot-device" in SPL and read in out 
>>>>>> in U-Boot proper, and then Swap mmc0 and mmc1 in boot_targets if 
>>>>>> booted from SD-Card.
>>>>>>
>>>>>> It's OK for Theobroma-Systems's board to enable it, but seems not 
>>>>>> also required by other boards.
>>>>>>
>>>>>> Usually we consider the system in two stage: bootloader/BIOS 
>>>>>> stage(including all firmware before kernel) and OS 
>>>>>> stage(including kernel and Linux/Android OS),
>>>>>>
>>>>>> and for those boards(eg. PC like) do have two different storage 
>>>>>> medium, they put bootloader in SPI flash and put OS firmware in 
>>>>>> other storage like emmc/SSD/SDcard.
>>>>>>
>>>>>> In this case the U-Boot boot target does not need to know where 
>>>>>> it's from;
>>>>>>
>>>>>> in another case which supports firmware update from SD card, the 
>>>>>> U-Boot boot target needs to set SDCard as highest priority, also 
>>>>>> no need to know where the U-Boot from.
>>>>>>
>>>>>
>>>>> So... this means we need a different U-Boot if we're booting from 
>>>>> SD card so it can know which boot target to use by default? Or a 
>>>>> different environment for SD card? or requiring the user to stop 
>>>>> the boot process and manually change the priority? Or what are you 
>>>>> suggesting?
>>>>
>>>> No, we don't need a different U-Boot, we can always set SD card 
>>>> boot first in boot target in all case, if SD card don't have an 
>>>> available firmware it will fall back to use eMMC, this works for 
>>>> the board I have.
>>>>
>>>> Maybe I didn't understand correctly why you have to do "Swap mmc0 
>>>> and mmc1 in boot_targets if booted from SD-Card"?
>>>>
>>>
>>> I think I got things mixed up and this was not a necessary 
>>> discussion. But since we're here, I will try to explain what we want 
>>> to do with the whole process on Theobroma's boards.
>>>
>>> arch_env_get_location() is the only one impacted by this patch (as 
>>> far as I could tell). setup_boottargets() from 
>>> board/theobroma-systems/common/common.c is a vendor-specific 
>>> implementation I do not see worthy of being merged to a code section 
>>> used by all Rockchip boards, it's basically just a design/policy 
>>> choice we made, but there's nothing interesting to make it the 
>>> default (though it should be generic enough that one could simply 
>>> call those functions from their board file and it should just work 
>>> (tm)).
>>>
>>> So the whole thing is basically about wanting a fallback mechanism.
>>
>> I can understand this purpose, but it seems you make it a little bit 
>> complicate, does your customers understand this? Or maybe you don't 
>> need customer to understand all these rules?
>>
>
> I haven't received any complaint so far.
>
> If our customers want to do something differently, they can always 
> change the code so that it works for them the way they want it to 
> work, or even simply just change boot_targets in their environment if 
> only the kernel+dtb image storage medium is what they care about. For 
> our three SoMs, I see U-Boot as supported for our SoMs with our 
> devkit, with other carrierboards a different U-Boot is likely required 
> anyway.
>
>> This rule is simple for rk3588 vendor SDK:
>>
>> Bootrom default order is: SPI -> eMMC-> SDcard ->USB(can chose only 
>> one of it now for rk3588)
>>
>> SPL default order is: SDcard ->SPI-> eMMC (SDcard is set to higher 
>> priority, only if there is a uboot partition and available firmware)
>>
>> U-Boot default order is: SDcard -> eMMC (usually not using SPI for 
>> system)
>>
>> If SDcard has no firmware, then it don't affect the boot flow; if the 
>> SDcard has available firmware, it means a firmware update need for 
>> eMMC/SPI. Since the SDcard is removal, we can make and replace it 
>> again which always fallback available if SPI/eMMC has something wring 
>> in U-Boot/System.
>>
>
> I know, and I've received multiple complaints from colleagues about 
> this already. There's a LOT of benefits from knowing that in the 
> scenario in which everything is properly flashed, everything is loaded 
> from the same medium. I myself have been surprised a few times as to 
> why when I flashed the eMMC and have an old SD card connected it boots 
> the U-Boot proper from the SD card and not from the eMMC.
>
> I appreciate what we're doing is not everyone's cup of tea, but it 
> works for us for now, so I don't see a need to revisit this logic.
>
> [...]
>
>>> > No, we don't need a different U-Boot, we can always set SD card boot
>>> > first in boot target in all case, if SD card don't have an available
>>> > firmware it will fall back to use eMMC, this works for the board I 
>>> have.
>>>
>>> If we do this, simply having an SD card with a partition with an 
>>> Image/dtb/fit/extlinux.conf will be taken by default instead of the 
>>> ones on the eMMC, even if we booted from the eMMC. I want to make 
>>> sure that if I'm booting from the eMMC, I'm booting everything from 
>>> the eMMC and not "if you have an SD card, maybe from the SD card". 
>>
>> In this case if U-Boot/kernel get panic in eMMC image, the system not 
>> able to recovery?
>>
>
> What happens if the SD card image is the one that panics? You also 
> won't be able to recover... except if you remove the SD card entirely.

If SD card image get panic, we can easily remove and make it again.

I know why you do this now, because the removal of SD card is not so 
"easy" in your system, and you are not using SD card as external storage 
like tablet/SBCs.

>
> For us, if the eMMC U-Boot proper/kernel image is found but panics, 
> you insert an SD card and you hold the BIOS button when booting, then 
> everything will be booted from the SD card, otherwise it's booting 
> from the eMMC.
>
> In both cases a human is required to intervene, either to insert and 
> remove the SD card to start a recovery, or to press the BIOS button. 
> For Jaguar specifically, inserting and removing the SD card is not fun 
> (it may also be hidden below an adapter (commonly called "hat" I 
> think?) making its access even more difficult).
>
> And again, this is the **default**, if a user changes it in the 
> environment (to e.g. match the Rockchip SDK behavior), we will not 
> change it automatically.
>
>> Anyway, you have your choice, since all these are stay in your board 
>> and not affect other boards, it's OK to be accept(the little addition 
>> -u-boot-dtsi  is fine).
>>
>
> I am a bit confused.
>
> Where do you want the sdmmc/sdhci controllers bootph-all property be put:
> 1) rk3588s-u-boot.dtsi

It's OK to put it here.


Thanks,

- Kever

> 2) rk3588-jaguar-u-boot.dtsi
>
> ?
>
> Cheers,
> Quentin
