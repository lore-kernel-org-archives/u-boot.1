Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DACCC47422
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 08:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E3AA878AC;
	Fri, 26 Jan 2024 09:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="FYo+D3j2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60DC87B8C; Fri, 26 Jan 2024 09:58:59 +0100 (CET)
Received: from mail-m12785.qiye.163.com (mail-m12785.qiye.163.com
 [115.236.127.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8395878AA
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 09:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=FYo+D3j20mw1AW4YpGm68xX0kSZ5qS9NCZIDAn6o3PHqBu4pqzMztWtgJnedNaWd4SvepNjeU9ipm2Z/n/iRTib3fywaWPdkoU8z3nucHXsWKY2c+nYCz8HRjDqvGWJjPl4FNMhpmUfrF7OOqYv2W0RzqD5auezYBscW2lHMVsI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=gR4+7JnjIpzj+PRl0gP39UKMKaF8Hr/E0Sn6084nsp8=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 95479900285;
 Fri, 26 Jan 2024 16:58:35 +0800 (CST)
Message-ID: <928cfe56-1a7d-4024-aa9b-c14654b150e1@rock-chips.com>
Date: Fri, 26 Jan 2024 16:58:35 +0800
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
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <5f4c826e-9ecf-4620-9430-b317e472cfd2@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpPGVZDGhhNT0xNHxlMHUpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d44fe0daa03a9kunm95479900285
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46Vio6MzMTGA4VCTgXMB5D
 HjkaCi9VSlVKTEtNSU5CTkpMSU1JVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMT0pKNwY+
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

On 2024/1/24 19:04, Quentin Schulz wrote:
> Hi Kever,
>
> On 1/24/24 11:35, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/1/23 22:49, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram 
>>> node as
>>> pre-reloc after relocation"), bootph-pre-ram doesn't make U-Boot proper
>>> bind the device before relocation.
>>>
>>> While this is usually not much of an issue, it is when there's a lookup
>>> for devices by code running before the relocation. Such is the case of
>>> env_init() which calls env_driver_lookup() which calls
>>> env_get_location() which is a weak symbol and may call
>>> arch_env_get_location() also a weak symbol. Those are two functions 
>>> that
>>> may traverse UCLASS to find some devices (e.g.
>>> board/theobroma-systems/common/common.c:arch_env_get_location()).
>>
>> This sounds like we need to update arch_env_get_location() instead of 
>> enable mmc driver
>>
>> before relocate, because you we don't really need the mmc driver 
>> works here, there is no
>>
>> access requirement to mmc at this point, right?
>>
>
> All Rockchip SoCs except RK3588(S) and RK356x have it done this way, a 
> little bit of consistency wouldn't hurt :)

My point is not about you can not enabe the emmc before relocate, maybe 
I'm not clear enough for the reason.

All the driver bind/probed before the relocation will have to do the 
init sequence again later after relocation.

The emmc driver cost pretty much time at init, we should avoid to 
duplicate the init process if possible.

For this patch, you want to make it pre-relocate because you want to 
make sure the emmc is available for ENVL_MMC,

but there is no read or write requirement to the emmc at this point, 
which means we don't have to init the emmc at this point,

maybe we can check if the driver is enable if enough.

> I need to be able to find out if the device that was used to load 
> U-Boot proper is an MMC device so that I can tell 
> arch_env_get_location() to return ENVL_MMC; in that case.
>
> For that, I've used uclass_find_device_by_ofnode() which parses the 
> list of devices registered in the UCLASS_MMC (for that scenario). I 
> assume the only requirement is that the device needs to be bound, not 
> probed (haven't checked). If there's another way to do this 
> **properly**, I'm all ears. I would likely need to do the same for the 
> SPI controllers but since none of our RK3588-based products have 
> SPI-NOR, I don't need those (but it works on RK3399 just fine).
>
> I still think there's value in having consistency between all Rockchip 
> SoCs (and if applicable to other SoC vendors, then those as well). 


This is the point I do care, because I don't want the boot loader too 
heavy, especially the SPL and the U-Boot proper before relocate, 
although we can enable all the feature in it in technically.

Even for the rk3588 which is kind of powerful soc, still many project 
need it to boot fast, which require to remove all the redundant 
operation in the boot process.


For the feature record "spl-boot-device" in SPL and read in out in 
U-Boot proper,  and then Swap mmc0 and mmc1 in boot_targets if booted 
from SD-Card.

It's OK for Theobroma-Systems's board to enable it, but seems not also 
required by other boards.

Usually we consider the system in two stage: bootloader/BIOS 
stage(including all firmware before kernel) and OS stage(including 
kernel and Linux/Android OS),

and for those boards(eg. PC like) do have two different storage medium, 
they put bootloader in SPI flash and put OS firmware in other storage 
like emmc/SSD/SDcard.

In this case the U-Boot boot target does not need to know where it's from;

in another case which supports firmware update from SD card, the U-Boot 
boot target needs to set SDCard as highest priority, also no need to 
know where the U-Boot from.


Thanks,
- Kever
> We could still do both though, have this and then fix the need for 
> requiring sdmmc/sdhci devices to be bound/probed for env_init() 
> (arch_env_get_location()) to work.
>
> What is bothering you in enabling those drivers in U-Boot proper 
> before relocation?
>
> Cheers,
> Quentin
