Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661FC54E41
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 17:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A02A087C48;
	Tue,  5 Mar 2024 18:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RG6OKeyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8758D880AF; Tue,  5 Mar 2024 18:02:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA1A986FC9
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 18:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d1bf=KM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1709658120;
 bh=9xxe/Pr322sHMXpLQjsXwtwH3+G4l8hgPGUQkWrvgjY=;
 b=RG6OKeyHNc4cnkJXkljbMT50EZY3a4cWIOlb8pwkBoWxw2D3Bfo0Fdw2os69A4Jk84B+q73rI
 BEtl5+cHuCWcxVbaLlPqWGodZUgNRMACBwkgmtMrqdv8Mwk3Dftv6uYri97CKqjme55iiZpQoGX
 RyX3BUyYcuYIKpwfy1IQuhhoDLRtyTjyx2ZBW2/KxVUBoxT8eZIn/BuZyRui12mLD9vtCDqnPbq
 0wMD96ZGnsod5RIAy6pcq2MELNut5d9gPwvy1i+6xxV08PPUHNhUeMbogihBk45lKUGAD5+dsRC
 xA5NqGsnUJn3o6gULJUc6RTrjquaE32JK7PAjXFEzBqA==
Message-ID: <a4483ad2-2358-4c70-aab7-82e7848a87cd@kwiboo.se>
Date: Tue, 5 Mar 2024 18:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: rockchip: rock5a: enable environment
Content-Language: en-US
To: Trevor Woerner <twoerner@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Kever Yang
 <kever.yang@rock-chips.com>, Weizhao Ouyang <o451686892@gmail.com>, Jagan
 Teki <jagan@edgeble.ai>
References: <20240305021051.22405-1-twoerner@gmail.com>
 <20240305021051.22405-3-twoerner@gmail.com>
 <cbe1b045-b8f1-4ea2-b831-2dbb52aade35@collabora.com>
 <78c8c8d1-ecff-4d48-a6f7-da433254e4ab@kwiboo.se>
 <20240305134558.GB2252@localhost>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240305134558.GB2252@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65e750076269b0da33ca4a52
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

On 2024-03-05 14:45, Trevor Woerner wrote:
> On Tue 2024-03-05 @ 10:17:10 AM, Jonas Karlman wrote:
>> Hi,
>>
>> On 2024-03-05 06:40, Eugen Hristev wrote:
>>> On 3/5/24 04:10, Trevor Woerner wrote:
>>>> Following the pattern of other Rockchip devices, enable the U-Boot
>>>> environment to be stored in MMC. This patch specifically assumes the
>>>> environment will be stored on the SDcard.
>>>>
>>>> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
>>>> ---
>>>>  configs/rock5a-rk3588s_defconfig | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
>>>> index a6471a519514..ac6411667d9a 100644
>>>> --- a/configs/rock5a-rk3588s_defconfig
>>>> +++ b/configs/rock5a-rk3588s_defconfig
>>>> @@ -8,6 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
>>>>  CONFIG_NR_DRAM_BANKS=2
>>>>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>>>>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
>>>> +CONFIG_ENV_SIZE=0x8000
>>>>  CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a"
>>>>  CONFIG_ROCKCHIP_RK3588=y
>>>>  CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
>>>> @@ -48,6 +49,8 @@ CONFIG_CMD_REGULATOR=y
>>>>  CONFIG_SPL_OF_CONTROL=y
>>>>  CONFIG_OF_LIVE=y
>>>>  CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>>> +CONFIG_ENV_IS_IN_MMC=y
>>>> +CONFIG_SYS_MMC_ENV_DEV=1
>>>>  CONFIG_SPL_DM_SEQ_ALIAS=y
>>>>  CONFIG_SPL_REGMAP=y
>>>>  CONFIG_SPL_SYSCON=y
>>>
>>>
>>> Hi Trevor,
>>>
>>> What will happen if there is no Sd-Card, and we boot from eMMC or SPI flash ?
>>
>> Agree, we should not blindly enable env and expect that it can be stored
>> on sd-card. If anything, it should preferably be saved/loaded from the
>> device where TPL/SPL was booted from.
>>
>> Personally I always run my devices with ENV_IS_NOWHERE, with standard
>> boot and extlinux or efi as the preferred way to boot, I do not see why
>> normal end-users with a single OS really have a need for a saved env,
>> please educate me :-)
> 
> I am the maintainer of the meta-rockchip Yocto layer[1]. Yocto uses a
> nifty tool called 'wic' to layout images (dos/gpt partitioning, optionally
> formatting partitions, optionally installing things into those partitions)[2].
> The partitioning layout that we follow is the one that is recommended by
> Rockchip itself[3] with 2 exceptions:
> - we don't hide any of the partitions from the partition table
> - we've combined /boot into the root partition (for reasons I'll explain
>   later)
> 
> Under the Rockchip partitioning, the U-Boot environment is stored in partition
> 5, at offset 0x0003.f800, and has a size of 0x0000.8000.

Not sure you should look too much at the Rockchip partitioning, not sure
it is something to promote for mainline Linux and U-Boot usage. The
partitions is not correct/relevant, especially for aarch64. For mainline
the following offsets are typically only used:

- 0x00008000: TPL+SPL - up to around 256+256 KiB
- 0x003F8000: optional U-Boot env
- 0x00800000: FIT with U-Boot proper + TF-A and/or OPTEE,
              or U-Boot proper in legacy image format
- 0x01000000+: free use

It is highly recommended to write the generated u-boot-rockchip.bin to
sector 0x40 of mmc to get all the U-Boot related offsets correct as
defined in board defconfig.

To me the traditional Rockchip partitioning scheme does not really fill
any purpose with mainline Linux and U-Boot, please enlighten me :-)

One thing that vendor U-Boot does that possible could be adopted for
mainline U-Boot is that it will locate FIT based on a GPT partition
named "uboot" and fallback to traditional sector 0x4000.
The offsets and size of traditional Rockchip partitioning scheme is no
longer that important for vendor U-Boot/Linux.

It is also possible to reclaim some of the wasted space by putting FIT
at a different location, e.g:

- 0x00008000: TPL+SPL - up to around 256+256 KiB
- 0x00088000: FIT with U-Boot proper + TF-A - up to 3520 KiB
- 0x003F8000: optional U-Boot env
- 0x00400000+: free use

> 
> I don't own every Rockchip board, but I have a bunch of them (thanks to some
> generous donations!). I've created a spreadsheet that lists the ones supported
> by meta-rockchip and their environment variable U-Boot configurations
> (locations, offsets, sizes). Most of them follow the Rockchip recommended
> partitioning layout with regards to storing the environment. This set of
> patches closes that gap, at least for the ones supported by meta-rockchip.
> 
> One of the things that I want to do next with meta-rockchip is to provide
> an easy way for users to enable some sort of A/B OTA update strategy.
> Currently, enabling an A/B update mechanism for any board (Rockchip or not)
> is a non-trivial exercise. Every A/B update mechanism that I've looked at
> requires (among other things) the bootloader to be able to store/retrieve
> its environment from U-Boot itself (obviously) and also from Linux userspace
> since it is the bootloader that ultimately boots from either the A or the B
> partition. I'm specifically focused on rauc, but all the A/B update mechanisms
> I've looked at have this same requirement.

The Boot Loader Specification [a] and Automatic Boot Assessment [b]
describe one alternative way that would not involve U-Boot env,
unfortunately U-Boot does not follow the Boot Loader Specification,
a bootflow I would like to see being implemented :-)

[a] https://uapi-group.org/specifications/specs/boot_loader_specification/
[b] https://systemd.io/AUTOMATIC_BOOT_ASSESSMENT/

Also are you only focusing on A/B for the kernel/OS or or does that also
include a strategy for how to A/B update the bootloader itself?

For bootloader A/B the Rockchip BROM typically will try to find the IDB
from multiple locations, e.g. sector 0x40, 0x240, 0x440, 0x640 if I am
not mistaken. This could potentially be used to create two pairs of
TPL+SPL/env/FIT combo.

> 
> Users who don't care for A/B updates can simply use meta-rockchip as-is, those
> who want an A/B strategy would simply enable a setting or two in their Yocto
> config and meta-rockchip would take care of the details, regardless of which
> Rockchip board they're using.
> 
> I've combined /boot into the root partition since it makes A/B updates easier.
> Otherwise in order to work it would actually be an Aboot+Aroot/Bboot+Broot
> mechanism, which is clumsy. Also since U-Boot is stored in partition by
> itself, the only thing in the /boot partition is the U-Boot boot mechanism
> (boot script, extlinux, etc), the Linux kernel, and the DTB (or fitImage). In
> general it's better to keep the kernel and the root filesystem in sync, so
> having a separate /boot partition is clumsy for no gain.
> 
> The other nice thing about wic is that it allows us to store random data
> (or filesystems) in the image as we're creating it for the first time. In
> other words, I have a mechanism that allows me to create the initial/default
> U-Boot environment during the build, I can add or remove variables from it
> dynamically as part of my build process, generate the proper binary blob of
> that environment (i.e. with checksum), and lay it out into partition 5 of the
> generated image so that on first boot the environment is already setup with
> whatever U-Boot needs plus any custom tweaks the user adds.
> 
>>
>>>
>>> The rockchip pattern is usually to have a standard config for all boards and it is
>>> not stored anywhere.
>>
>> Unfortunately lots of rockchip boards have blindly enabled ENV_IN_MMC
>> and force it to use sd-card. However, before enabling same forced
>> behavior on new boards I would recommend ensuring adding support for
>> allowing env to follow same load order as FIT (spl-boot-order).
> 
> I was pretty certain the "forcing it to SDcard" was going to cause push back,
> which is why I highlighted it in my commit message since I didn't want it to
> sneak in accidentally. The feedback is exactly what I was hoping. I wasn't
> aware there might be a way to dynamically store the environment based on the
> wishes of the user, that would be great!
> 
> But ultimately I want to keep the environment on the boot device and make
> sure they're not separated. I could have 2 SDcards on my desk: one could be a
> regular non-A/B layout, and the other would have an A/B layout. Technically I
> wouldn't really need an environment on the non-A/B card, but if it did have
> one, it would need to be different from the environment of the SDcard that had
> the A/B update layout.
> 
> On many Rockchip-based boards the eMMC board is every bit as optional as the
> SDcard, so keeping the environment on the same medium as the boot is
> necessary.

I fully agree, keeping TPL+SPL/FIT/env on same media would be preferably,
with some code it should be possible. For emmc we could even get more
crazy and potentially store FIT+env in one of the two hw boot partitions.
BROM does not support booting from the boot partitions but we can make
SPL/U-Boot proper read from it.

> 
> For the user-case of a single OS I agree that an environment is not required
> to be stored. But more and more we're seeing users want an OTA strategy
> (especially in commercial/production environments), and if the one they want
> is A/B-based, then storing the environment is something that needs to work.
> Even in a non-production environment, having an A/B update mechanism could be
> useful in a board-farm testing environment: take last night's build, update
> the board's "other" partition, reboot, and see if it works. If it doesn't,
> fall back to the working one and try again.
> 
> Currently meta-rockchip assumes SDcard usage. I know that's a limitation and
> is on my TODO list to address someday so users could easily choose between
> one or the other.
> 
> In order to get A/B working out of the box for meta-rockchip, I could carry
> all these patches locally and still make everything work the way I would like.
> But most Rockchip-based boards seem to already support storing an environment
> in CONFIG_ENV_IS_IN_MMC, it's just the default device CONFIG_SYS_MMC_ENV_DEV
> that we're disagreeing on.

Most devices that has onboard SPI flash typically have ENV_IS_IN_SPI,
and two of the four boards affected by your patches comes with onboard
SPI flash. For those, 3A and 5B, it make more sense to enable env in SPI
if it is needed until automatic location selection have been implemented.

Regards,
Jonas

> 
>> Regards,
>> Jonas
>>
>>>
>>> Kever, Jonas, please correct me if I am wrong.
>>>
>>> Eugen
>>
> 
> [1] https://layers.openembedded.org/layerindex/branch/master/layer/meta-rockchip/
> [2] https://git.yoctoproject.org/meta-rockchip/tree/wic/rockchip.wks
> [3] https://opensource.rock-chips.com/wiki_Partitions

