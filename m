Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C27CC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 10:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65CF087B8C;
	Fri, 26 Jan 2024 11:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Y/5BrCBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0586787B98; Fri, 26 Jan 2024 11:56:51 +0100 (CET)
Received: from mail-m15571.qiye.163.com (mail-m15571.qiye.163.com
 [101.71.155.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F46E878AA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 11:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Y/5BrCBMwxwgzNpuK+A/560ZgT9unNfNYyZVyZRYLxQWn+vs/3cNABFdKxOfXYXfkJwEJbGhFZR8MntPhfv+3ETVz8MhTPj2RrpKr0KVXkTi21RnuUOVUiRo1IRZfoJ/wh0IRDWq9h2ZPWc17N3EbOJcZFgj3MBze/17mHeBmi8=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=qB9Ska2UVsz+TJ4fvN6dtUY0PfVa4YxCftFdrj5ZsH8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 84B769002B5;
 Fri, 26 Jan 2024 18:56:31 +0800 (CST)
Message-ID: <8a101c97-cbd5-4e99-b89f-49fbe8fdd59b@rock-chips.com>
Date: Fri, 26 Jan 2024 18:56:31 +0800
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
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <f2ed9f73-97bb-446e-9396-9de3ab01b8d5@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhlCSlZOHxgZGR4ZGE0aGktVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d456a058f03a9kunm84b769002b5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6CAw*ODMQSQ1NKSM5GT0R
 NFYKCT5VSlVKTEtNSU1NTkJIS09CVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKSk9OQjcG
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

On 2024/1/26 17:32, Quentin Schulz wrote:
> Hi Kever,
>
> On 1/26/24 09:58, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/1/24 19:04, Quentin Schulz wrote:
>>> Hi Kever,
>>>
>>> On 1/24/24 11:35, Kever Yang wrote:
>>>> Hi Quentin,
>>>>
>>>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>
>>>>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram 
>>>>> node as
>>>>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot 
>>>>> proper
>>>>> bind the device before relocation.
>>>>>
>>>>> While this is usually not much of an issue, it is when there's a 
>>>>> lookup
>>>>> for devices by code running before the relocation. Such is the 
>>>>> case of
>>>>> env_init() which calls env_driver_lookup() which calls
>>>>> env_get_location() which is a weak symbol and may call
>>>>> arch_env_get_location() also a weak symbol. Those are two 
>>>>> functions that
>>>>> may traverse UCLASS to find some devices (e.g.
>>>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>>>
>>>> This sounds like we need to update arch_env_get_location() instead 
>>>> of enable mmc driver
>>>>
>>>> before relocate, because you we don't really need the mmc driver 
>>>> works here, there is no
>>>>
>>>> access requirement to mmc at this point, right?
>>>>
>>>
>>> All Rockchip SoCs except RK3588(S) and RK356x have it done this way, 
>>> a little bit of consistency wouldn't hurt :)
>>
>> My point is not about you can not enabe the emmc before relocate, 
>> maybe I'm not clear enough for the reason.
>>
>> All the driver bind/probed before the relocation will have to do the 
>> init sequence again later after relocation.
>>
>> The emmc driver cost pretty much time at init, we should avoid to 
>> duplicate the init process if possible.
>>
>> For this patch, you want to make it pre-relocate because you want to 
>> make sure the emmc is available for ENVL_MMC,
>>
>> but there is no read or write requirement to the emmc at this point, 
>> which means we don't have to init the emmc at this point,
>>
>> maybe we can check if the driver is enable if enough.
>>
>
> Now I need to know which SoC we are booting at build time so I can 
> check which drivers are supposed to be built, check those symbols are 
> enabled, then traverse the Device Tree with hardcoded DT node to 
> locations of MMC, SPI flash controllers, check if those are enabled 
> and finger-cross that those drivers will actually bind/probe properly 
> later on. That's A LOT of checks to be made.

This is not what I want to say.

What I mean is something  like this for arch_env_get_location() is 
enough, you don't have to bind/probe the emmc for env.

1623                 if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC) && 
IS_ENABLED(CONFIG_MMC))
1624                         return ENVL_MMC;

>
>>> I need to be able to find out if the device that was used to load 
>>> U-Boot proper is an MMC device so that I can tell 
>>> arch_env_get_location() to return ENVL_MMC; in that case.
>>>
>>> For that, I've used uclass_find_device_by_ofnode() which parses the 
>>> list of devices registered in the UCLASS_MMC (for that scenario). I 
>>> assume the only requirement is that the device needs to be bound, 
>>> not probed (haven't checked). If there's another way to do this 
>>> **properly**, I'm all ears. I would likely need to do the same for 
>>> the SPI controllers but since none of our RK3588-based products have 
>>> SPI-NOR, I don't need those (but it works on RK3399 just fine).
>>>
>>> I still think there's value in having consistency between all 
>>> Rockchip SoCs (and if applicable to other SoC vendors, then those as 
>>> well). 
>>
>>
>> This is the point I do care, because I don't want the boot loader too 
>> heavy, especially the SPL and the U-Boot proper before relocate, 
>> although we can enable all the feature in it in technically.
>>
>> Even for the rk3588 which is kind of powerful soc, still many project 
>> need it to boot fast, which require to remove all the redundant 
>> operation in the boot process.
>>
>
> It's a bit surprising to start caring about boot speed to justify not 
> binding some drivers on the fastest (to date) Rockchip SoC while all 
> much slower SoCs have this enabled :)
>
>>
>> For the feature record "spl-boot-device" in SPL and read in out in 
>> U-Boot proper,  and then Swap mmc0 and mmc1 in boot_targets if booted 
>> from SD-Card.
>>
>> It's OK for Theobroma-Systems's board to enable it, but seems not 
>> also required by other boards.
>>
>> Usually we consider the system in two stage: bootloader/BIOS 
>> stage(including all firmware before kernel) and OS stage(including 
>> kernel and Linux/Android OS),
>>
>> and for those boards(eg. PC like) do have two different storage 
>> medium, they put bootloader in SPI flash and put OS firmware in other 
>> storage like emmc/SSD/SDcard.
>>
>> In this case the U-Boot boot target does not need to know where it's 
>> from;
>>
>> in another case which supports firmware update from SD card, the 
>> U-Boot boot target needs to set SDCard as highest priority, also no 
>> need to know where the U-Boot from.
>>
>
> So... this means we need a different U-Boot if we're booting from SD 
> card so it can know which boot target to use by default? Or a 
> different environment for SD card? or requiring the user to stop the 
> boot process and manually change the priority? Or what are you 
> suggesting?

No, we don't need a different U-Boot, we can always set SD card boot 
first in boot target in all case, if SD card don't have an available 
firmware it will fall back to use eMMC, this works for the board I have.

Maybe I didn't understand correctly why you have to do "Swap mmc0 and 
mmc1 in boot_targets if booted from SD-Card"?

>
> It all boils down to sane defaults. If I understand correctly, you 
> want people to have systems which can boot really fast by default but 
> don't mind if people need to tinker to get things working properly. I 
> would prefer to have most things working by default and let people 
> tinker to make things faster.

:(

Then I would say you didin't understand correctly.

I agree to let people tinker to make things faster and most things work 
by default, but don't make too many troubles for tinker if possible.

>
> There are a couple of drivers that are selected when using Rockchip 
> boards that shouldn't be necessary, e.g. ADC support, SPI flash 
> controller (to name the few that we have on RK3588 that we don't need 
> for Jaguar now), there are also DT nodes that are enabled by default 
> in rk3588(s)-u-boot.dtsi that aren't necessary for my use case, this 
> also increases the size of the DTB. I don't really get where you want 
> the line between convenience and speed be right now. It'd be nice to 
> have some kind of consensus/guideline if you already have one in mind, 
> at least I'd know where we want to go with this :)

I never said we can't enable pre-reloc the emmc in rk3588 u-boot dt, 
that's not the key point.

You add this patch to make arch_env_get_location() work, I suggest that 
if we don't really access to emmc,

then update arch_env_get_location() might be better.

If it's not able to update arch_env_get_location because it doesn't 
work, then this patch is able to accept,

and I would suggest arch_env_get_location() to leave in 
board/theobroma-systems/common/common.c.


Thanks,
- Kever
>
> Reminder that if people want to make things faster, they can still 
> override this in their own -u-boot.dtsi by deleting bootph-all and 
> adding bootph-pre-ream instead.
>
> I can keep this in rk3588-jaguar-u-boot.dtsi sure, I'll have to do the 
> same for another RK3588 board soon as well.
>
> So, up to you. I gather you'd prefer we have this in 
> rk3588-jaguar-u-boot.dtsi so will do this for v2 except if you're 
> saying otherwise.
>
> Cheers,
> Quentin
