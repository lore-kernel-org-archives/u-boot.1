Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC6DC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 10:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E0B87895;
	Mon, 29 Jan 2024 11:35:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="JHRRUug1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7811A87895; Mon, 29 Jan 2024 11:35:42 +0100 (CET)
Received: from mail-m21472.qiye.163.com (mail-m21472.qiye.163.com
 [117.135.214.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F878785A
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 11:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=JHRRUug1heo6m+6ob0uoPbotFhIoK/JvUdQiWIlvlUBQAGO79lnkYhZ86ghbfp54jIB4feKdcNgZ0K3Bb5h+ZOiwkf4RhpQIzsExG1Syb8ca4/amooxdLbUcgzhaemaA5EDwirGImserRwgGeVBRUC2+ow7+0vsUH/YRD3cZ5vw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=Ac2Nel0eFVHKa+C2mc1scSke4aRPZ+Qhkepidw8jS5w=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C3567900225;
 Mon, 29 Jan 2024 18:35:11 +0800 (CST)
Message-ID: <329e95d8-bedc-4a97-a651-13daab2c1cf8@rock-chips.com>
Date: Mon, 29 Jan 2024 18:35:11 +0800
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
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <7b5cb03f-c2b2-4cf2-b06a-751d7cc978b9@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx4fTVYaThpOT0MdTx8dSkNVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d54c9929e03a9kunmc3567900225
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OVE6MTo5MjMIIlFISAJJHQJD
 TxQwCU1VSlVKTEtNTklPTkpISENNVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0tLSjcG
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

Hi Quentin,

On 2024/1/27 00:18, Quentin Schulz wrote:
> Hi Kever,
>
> On 1/26/24 11:56, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/1/26 17:32, Quentin Schulz wrote:
>>> Hi Kever,
>>>
>>> On 1/26/24 09:58, Kever Yang wrote:
>>>> Hi Quentin,
>>>>
>>>> On 2024/1/24 19:04, Quentin Schulz wrote:
>>>>> Hi Kever,
>>>>>
>>>>> On 1/24/24 11:35, Kever Yang wrote:
>>>>>> Hi Quentin,
>>>>>>
>>>>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>>>
>>>>>>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram 
>>>>>>> node as
>>>>>>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot 
>>>>>>> proper
>>>>>>> bind the device before relocation.
>>>>>>>
>>>>>>> While this is usually not much of an issue, it is when there's a 
>>>>>>> lookup
>>>>>>> for devices by code running before the relocation. Such is the 
>>>>>>> case of
>>>>>>> env_init() which calls env_driver_lookup() which calls
>>>>>>> env_get_location() which is a weak symbol and may call
>>>>>>> arch_env_get_location() also a weak symbol. Those are two 
>>>>>>> functions that
>>>>>>> may traverse UCLASS to find some devices (e.g.
>>>>>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>>>>>
>>>>>> This sounds like we need to update arch_env_get_location() 
>>>>>> instead of enable mmc driver
>>>>>>
>>>>>> before relocate, because you we don't really need the mmc driver 
>>>>>> works here, there is no
>>>>>>
>>>>>> access requirement to mmc at this point, right?
>>>>>>
>>>>>
>>>>> All Rockchip SoCs except RK3588(S) and RK356x have it done this 
>>>>> way, a little bit of consistency wouldn't hurt :)
>>>>
>>>> My point is not about you can not enabe the emmc before relocate, 
>>>> maybe I'm not clear enough for the reason.
>>>>
>>>> All the driver bind/probed before the relocation will have to do 
>>>> the init sequence again later after relocation.
>>>>
>>>> The emmc driver cost pretty much time at init, we should avoid to 
>>>> duplicate the init process if possible.
>>>>
>>>> For this patch, you want to make it pre-relocate because you want 
>>>> to make sure the emmc is available for ENVL_MMC,
>>>>
>>>> but there is no read or write requirement to the emmc at this 
>>>> point, which means we don't have to init the emmc at this point,
>>>>
>>>> maybe we can check if the driver is enable if enough.
>>>>
>>>
>>> Now I need to know which SoC we are booting at build time so I can 
>>> check which drivers are supposed to be built, check those symbols 
>>> are enabled, then traverse the Device Tree with hardcoded DT node to 
>>> locations of MMC, SPI flash controllers, check if those are enabled 
>>> and finger-cross that those drivers will actually bind/probe 
>>> properly later on. That's A LOT of checks to be made.
>>
>> This is not what I want to say.
>>
>> What I mean is something  like this for arch_env_get_location() is 
>> enough, you don't have to bind/probe the emmc for env.
>>
>> 1623                 if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) && 
>> IS_ENABLED(CONFIG_MMC))
>> 1624                         return ENVL_MMC;
>>
>
> I do need to know if the device we loaded U-Boot proper from is an MMC 
> device or a SPI flash, so this is not enough for arch_env_get_location().
>
> I could do it in a hack-ish way though and check if the U-Boot proper 
> load medium DT node name starts with /mmc, or /spi and if neither, 
> then return NOWHERE, but then we lose the ability of returning NOWHERE 
> if the driver wasn't compiled in or the device didn't bind in 
> pre-reloc, we're missing some failsafe mechanism I could have with 
> this patch :)
>
> [...]
>
>>>> For the feature record "spl-boot-device" in SPL and read in out in 
>>>> U-Boot proper, and then Swap mmc0 and mmc1 in boot_targets if 
>>>> booted from SD-Card.
>>>>
>>>> It's OK for Theobroma-Systems's board to enable it, but seems not 
>>>> also required by other boards.
>>>>
>>>> Usually we consider the system in two stage: bootloader/BIOS 
>>>> stage(including all firmware before kernel) and OS stage(including 
>>>> kernel and Linux/Android OS),
>>>>
>>>> and for those boards(eg. PC like) do have two different storage 
>>>> medium, they put bootloader in SPI flash and put OS firmware in 
>>>> other storage like emmc/SSD/SDcard.
>>>>
>>>> In this case the U-Boot boot target does not need to know where 
>>>> it's from;
>>>>
>>>> in another case which supports firmware update from SD card, the 
>>>> U-Boot boot target needs to set SDCard as highest priority, also no 
>>>> need to know where the U-Boot from.
>>>>
>>>
>>> So... this means we need a different U-Boot if we're booting from SD 
>>> card so it can know which boot target to use by default? Or a 
>>> different environment for SD card? or requiring the user to stop the 
>>> boot process and manually change the priority? Or what are you 
>>> suggesting?
>>
>> No, we don't need a different U-Boot, we can always set SD card boot 
>> first in boot target in all case, if SD card don't have an available 
>> firmware it will fall back to use eMMC, this works for the board I have.
>>
>> Maybe I didn't understand correctly why you have to do "Swap mmc0 and 
>> mmc1 in boot_targets if booted from SD-Card"?
>>
>
> I think I got things mixed up and this was not a necessary discussion. 
> But since we're here, I will try to explain what we want to do with 
> the whole process on Theobroma's boards.
>
> arch_env_get_location() is the only one impacted by this patch (as far 
> as I could tell). setup_boottargets() from 
> board/theobroma-systems/common/common.c is a vendor-specific 
> implementation I do not see worthy of being merged to a code section 
> used by all Rockchip boards, it's basically just a design/policy 
> choice we made, but there's nothing interesting to make it the default 
> (though it should be generic enough that one could simply call those 
> functions from their board file and it should just work (tm)).
>
> So the whole thing is basically about wanting a fallback mechanism.

I can understand this purpose, but it seems you make it a little bit 
complicate, does your customers understand this? Or maybe you don't need 
customer to understand all these rules?

This rule is simple for rk3588 vendor SDK:

Bootrom default order is: SPI -> eMMC-> SDcard ->USB(can chose only one 
of it now for rk3588)

SPL default order is: SDcard ->SPI-> eMMC (SDcard is set to higher 
priority, only if there is a uboot partition and available firmware)

U-Boot default order is: SDcard -> eMMC (usually not using SPI for system)

If SDcard has no firmware, then it don't affect the boot flow; if the 
SDcard has available firmware, it means a firmware update need for 
eMMC/SPI. Since the SDcard is removal, we can make and replace it again 
which always fallback available if SPI/eMMC has something wring in 
U-Boot/System.

>
> Boot from TPL+SPL from SD card, if U-Boot proper available on SD card, 
> load U-Boot proper from SD card, load environment from SD card (no 
> fallback for the environment), **preferably** (if the default 
> boot_target in default_environment is not different from the loaded 
> environment, i.e. the user has NOT already modified it) load from the 
> SD card the Image/dtb/fit and if not possible, then from eMMC, etc....
>
> Boot from TPL+SPL from eMMC, if U-Boot proper available on eMMC, load 
> U-Boot proper from eMMC, load environment from eMMC (no fallback for 
> the environment), **preferably** (if the default boot_target in 
> default_environment is not different from the loaded environment, i.e. 
> the user has NOT already modified it) load from the eMMC the 
> Image/dtb/fit and if not possible, then from SD card, etc....
>
> Boot from TPL+SPL from SPI flash, if U-Boot proper available on SPI 
> flash, load U-Boot proper from SPI flash, load environment from SPI 
> flash (no fallback for the environment), use boot_targets from the 
> environment (default or saved by user).
>
> Boot from TPL+SPL from SPI flash, if U-Boot proper NOT available on 
> SPI flash but eMMC, load U-Boot proper from eMMC, load environment 
> from eMMC (no fallback for the environment), **preferably** (if the 
> default boot_target in default_environment is not different from the 
> loaded environment, i.e. the user has NOT already modified it) load 
> from the eMMC the Image/dtb/fit and if not possible, then from SD 
> card, etc....
>
> Boot from TPL+SPL from SPI flash, if U-Boot proper NOT available on 
> SPI flash but SD card, load U-Boot proper from SD card, load 
> environment from SD card (no fallback for the environment), 
> **preferably** (if the default boot_target in default_environment is 
> not different from the loaded environment, i.e. the user has NOT 
> already modified it) load from the SD card the Image/dtb/fit and if 
> not possible, then from eMMC, etc....
>
> Boot from TPL+SPL from eMMC, if U-Boot proper NOT available on eMMC 
> but SPI flash, load U-Boot proper from SPI flash, load environment 
> from SPI flash (no fallback for the environment), use boot_targets 
> from the environment (default or saved by user).
>
> Boot from TPL+SPL from eMMC, if U-Boot proper NOT available on eMMC 
> but SD card, load U-Boot proper from SD card, load environment from SD 
> card (no fallback for the environment), **preferably** (if the default 
> boot_target in default_environment is not different from the loaded 
> environment, i.e. the user has NOT already modified it) load from the 
> SD card the Image/dtb/fit and if not possible, then from eMMC, etc....
>
> Boot from TPL+SPL from SD card, if U-Boot proper NOT available on SD 
> card but SPI flash, load U-Boot proper from SPI flash, load 
> environment from SPI flash (no fallback for the environment), use 
> boot_targets from the environment (default or saved by user).
>
> Boot from TPL+SPL from SD card, if U-Boot proper NOT available on SD 
> card but eMMC, load U-Boot proper from eMMC, load environment from 
> eMMC (no fallback for the environment), **preferably** (if the default 
> boot_target in default_environment is not different from the loaded 
> environment, i.e. the user has NOT already modified it) load from the 
> eMMC the Image/dtb/fit and if not possible, then from SD card, etc...
>
>
> > No, we don't need a different U-Boot, we can always set SD card boot
> > first in boot target in all case, if SD card don't have an available
> > firmware it will fall back to use eMMC, this works for the board I 
> have.
>
> If we do this, simply having an SD card with a partition with an 
> Image/dtb/fit/extlinux.conf will be taken by default instead of the 
> ones on the eMMC, even if we booted from the eMMC. I want to make sure 
> that if I'm booting from the eMMC, I'm booting everything from the 
> eMMC and not "if you have an SD card, maybe from the SD card". 

In this case if U-Boot/kernel get panic in eMMC image, the system not 
able to recovery?

Anyway, you have your choice, since all these are stay in your board and 
not affect other boards, it's OK to be accept(the little addition 
-u-boot-dtsi  is fine).


Thanks,

- Kever

> Why am I using U-Boot proper storage medium instead of the BootROM's? 
> In case the customer didn't design the carrierboard for our 
> System-on-Modules the same way we did for our devkit (Haikou) and 
> forgot to add a bypass for the eMMC, AND their eMMC has TPL+SPL 
> working but somehow got their U-Boot proper corrupted/not found. In 
> which case, we can insert an SD card and load U-Boot proper from it 
> for recovery. In which case, I want to boot stuff from the SD card and 
> not the eMMC. We could also imagine some kind of "built-in" recovery 
> mechanism for some admittedly very corner-case scenarios, where we 
> would have an SD card with everything needed to reflash the board 
> (e.g. swupdate/rauc/mender) that would only work if we cannot boot 
> TPL+SPL from eMMC or U-Boot proper from eMMC.
>
>>>
>>> It all boils down to sane defaults. If I understand correctly, you 
>>> want people to have systems which can boot really fast by default 
>>> but don't mind if people need to tinker to get things working 
>>> properly. I would prefer to have most things working by default and 
>>> let people tinker to make things faster.
>>
>> :(
>>
>> Then I would say you didin't understand correctly.
>>
>> I agree to let people tinker to make things faster and most things 
>> work by default, but don't make too many troubles for tinker if 
>> possible.
>>
>
> What is suggested here can be reverted with two lines in the 
> appropriate -u-boot.dtsi, I would find this acceptable for tinkerers 
> (but well... **I** would not need to do this with the current patch, 
> so maybe I'm biased :) ).
>
>>>
>>> There are a couple of drivers that are selected when using Rockchip 
>>> boards that shouldn't be necessary, e.g. ADC support, SPI flash 
>>> controller (to name the few that we have on RK3588 that we don't 
>>> need for Jaguar now), there are also DT nodes that are enabled by 
>>> default in rk3588(s)-u-boot.dtsi that aren't necessary for my use 
>>> case, this also increases the size of the DTB. I don't really get 
>>> where you want the line between convenience and speed be right now. 
>>> It'd be nice to have some kind of consensus/guideline if you already 
>>> have one in mind, at least I'd know where we want to go with this :)
>>
>> I never said we can't enable pre-reloc the emmc in rk3588 u-boot dt, 
>> that's not the key point.
>>
>> You add this patch to make arch_env_get_location() work, I suggest 
>> that if we don't really access to emmc,
>>
>> then update arch_env_get_location() might be better.
>>
>
> I cannot do what was suggested (see beginning of the mail) sadly.
>
> However, I started to look into having arch_env_get_location() behave 
> differently before and after relocation (since it's called multiple 
> times). I was able to have some proof-of-concept but I read more about 
> env_init() and.... it makes me very anxious to do it this way.
>
> 1) I would expect there's some kind of expectations that what 
> arch_env_get_location() doesn't change between calls with the same 
> prio, which I would be breaking. Even if there's maybe no such 
> expectation, this relies too much on the current state of env_init() 
> and later updates to that function may break stuff. Not great.
>
> 2) I do not understand what this env_init() is supposed to do. It 
> iterates over all possible env drivers and call their init callback, 
> which sets the gd->env_addr/gd->env_valid global variable structure... 
> but if the last env driver sets gd->env_addr to 0xbebe for example and 
> the env driver that the first (and ONLY!) env driver that successfully 
> can load (env_load()) should be using 0xcafe.... we may have some 
> issue there :) Though that point isn't really related to the 
> discussion we were having, rather what I found/didn't understand while 
> trying to implement your suggestion. I've started to discuss this with 
> Marek Vasut on IRC, maybe this will lead somewhere interesting :)
>
>> If it's not able to update arch_env_get_location because it doesn't 
>> work, then this patch is able to accept,
>>
>> and I would suggest arch_env_get_location() to leave in 
>> board/theobroma-systems/common/common.c.
>>
>
> Yes, I agree. I do not think it is a good idea to have 
> arch_env_get_location() currently in 
> board/theobroma-systems/common/common.c for all Rockchip boards. It's 
> just that I need this patch (or a version of it) so that 
> arch_env_get_location() in board/theobroma-systems/common/common.c works.
>
> Why I am advocating for having this in rk3588s-u-boot.dtsi is because:
> - I think that anything that is done with the environment before 
> relocation may need this? So if something calls e.g. env_load before 
> relocation, it would need the mmc controllers to be available before 
> relocation as well?
> - being consistent between all Rockchip SoCs,
>
> Lemme know if you have any question/remark.
>
> Cheers,
> Quentin
