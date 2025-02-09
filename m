Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342A8C0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 22:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A164D8091A;
	Sun,  9 Feb 2025 23:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02A15809A4; Sun,  9 Feb 2025 23:04:29 +0100 (CET)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5D380834
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 23:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.35] (unknown [98.97.27.21]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C2FF9B4C06B6;
 Sun,  9 Feb 2025 23:04:23 +0100 (CET)
Message-ID: <baea7c81-0daf-4a4d-9f4a-1447d7d11a04@freeshell.de>
Date: Sun, 9 Feb 2025 14:04:22 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: starfive: default to
 jh7110-starfive-visionfive-2-v1.3b
From: E Shattow <e@freeshell.de>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Simon Glass <sjg@chromium.org>, Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 "Leon M . Busch-George" <leon@georgemail.eu>, H Bell
 <dmoo_dv@protonmail.com>, Lukas Funke <lukas.funke@weidmueller.com>,
 Andreas Schwab <schwab@suse.de>, Nam Cao <namcao@linutronix.de>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250209152329.187194-1-heinrich.schuchardt@canonical.com>
 <20250209152329.187194-5-heinrich.schuchardt@canonical.com>
 <2d6e34fa-f45e-4edd-8b6d-4911400b6b77@freeshell.de>
 <CAM=mAO=ft8w0-Zn9H-LQygPkxk1ZxFwW05N2sTuR7i3NEBNMaA@mail.gmail.com>
 <4de4b21c-c12b-40c8-942e-f73e53d27569@freeshell.de>
Content-Language: en-US
In-Reply-To: <4de4b21c-c12b-40c8-942e-f73e53d27569@freeshell.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Postscript of my reply below, with context from off-list discussion
xypron (Heinrich) and Shadow AI6FS (E Shattow)...

On 2/9/25 13:55, E Shattow wrote:
> Hi Heinrich, I re-send my reply w/ CC's as you ask off-list :)
> 
> On 2/9/25 12:52, Heinrich Schuchardt wrote:
>> E Shattow <e@freeshell.de> schrieb am So., 9. Feb. 2025, 21:43:
>>
>>>
>>> On 2/9/25 07:23, Heinrich Schuchardt wrote:
>>>> We use starfive_visionfive2_defconfig to generate a FIT image supporting
>>>> all JH7110 boards in U-Boot. Make jh7110-starfive-visionfive-2-v1.3b the
>>>> default configuration that is used if no other configuration fits.
>>>>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>  configs/starfive_visionfive2_defconfig | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/configs/starfive_visionfive2_defconfig
>>> b/configs/starfive_visionfive2_defconfig
>>>> index c3f2142ae1b..ed077886436 100644
>>>> --- a/configs/starfive_visionfive2_defconfig
>>>> +++ b/configs/starfive_visionfive2_defconfig
>>>> @@ -78,7 +78,7 @@ CONFIG_CMD_WDT=y
>>>>  CONFIG_CMD_TFTPPUT=y
>>>>  CONFIG_CMD_BOOTSTAGE=y
>>>>  CONFIG_OF_BOARD=y
>>>> -CONFIG_OF_LIST="starfive/jh7110-milkv-mars
>>> starfive/jh7110-pine64-star64 starfive/jh7110-starfive-visionfive-2-v1.2a
>>> starfive/jh7110-starfive-visionfive-2-v1.3b"
>>>> +CONFIG_OF_LIST="starfive/jh7110-starfive-visionfive-2-v1.3b
>>> starfive/jh7110-milkv-mars starfive/jh7110-pine64-star64
>>> starfive/jh7110-starfive-visionfive-2-v1.2a"
>>>>  CONFIG_MULTI_DTB_FIT=y
>>>>  CONFIG_ENV_OVERWRITE=y
>>>>  CONFIG_ENV_IS_IN_SPI_FLASH=y
>>>
>>> Please keep CONFIG_OF_LIST sorted. Fall-through case should instead be a
>>> failure to boot, or at least a warning to the user that something
>>> unexpected is happening and inform that an assumption of a generic set
>>> of parameters or arbitrary board Fdt is being substituted. Implicit
>>> fall-through selection that un-orders the list is NAK. -E
>>>
>>
>>
>> Binman always creates a default and it is always the first configuration.
>>
>> With current U-Boot you can not boot a Mars CM board which used to work in
>> v2025.01.
>>
>> What is good about a failure to boot?
>>
>> Best regards
>>
>> Heinrich
>>
> 
> Two topics here of my concern are:
> 
> 1. Silent and arbitrary selection of Fdt in fall-through case
> 
> Mars CM (and CM Lite) are known to have a production batch containing
> wrong EEPROM information from the factory. Booting some configurations
> of Mars CM Lite with the VisionFive 1.3b Fdt may lead to data corruption
> (and possibility of destroying hardware). Failure to boot would inform
> that situation, or at least boot with the very minimums to avoid such
> assumptions while yet able to select the intended Fdt search path. That
> is the practical reason why a fall-through to silently using VisionFive2
> 1.3b is arbitrary and not the ideal situation. In the fall-through case
> I would want to see a U-Boot specific target that has the very minimums
> to get to a serial console and inform the user what is wrong, with
> access only to things that are totally consistent over all known board
> configurations (excluding MMC and non-default CPU core clock speeds for
> example). Failure to boot may allow the user access to fix the failure
> (with EEPROM tools) or at least understand what has happened instead of
> silently proceeding with the wrong configuration.
> 
> 
> 2. Preserving ordered lists for easy to commit and follow git history
> 
> As for the ordering, is there not some way to explicitly write the
> fall-through case for OF_UPSTREAM as another config variable? I
> appreciate the historical context and it's naming and so on is the
> VisionFive2 1.3b but what we're really looking at is a generic board
> target for things that are JH7110 CPU users, which for the moment mostly
> derive from the VisionFive2 reference board(s). It happens to be named
> starfive visionfive2 and otherwise I already read that as "starfive
> jh7110 generic board target" in U-Boot.
> 
> Anyhow thanks for taking this on, I am glad that we can simplify this
> even further in U-Boot. I interact with people that are beyond-confused
> why their Mars CM Lite or Star64 is able to "almost boot Linux" but with
> weird timeout warnings and so on... it is usually that the "default" or
> visionfive2 1.3b U-Boot Fdt was selected from a fall-through condition.
> That really needs to be better handled in U-Boot with an actual failure
> and opportunity for the user to fix it.
> 
> -E


xypron: Somehow I lost the mailing list when answering you from my
phone. Could you, please, resend your reply with the missing CCs.
As of today wrong EEPROM data or an FML13V01 board leads to failure to
boot due to not having any serial console.

Shadow AI6FS: I think OF_UPSTREAM should have an explicit fall-through
case, and that fall-through Fdt must not necessarily be from dts-rebasing

xypron: Do you see that device-tree in Linux?

Shadow AI6FS: so using VisionFive2 1.3b as the fall-through is not
appropriate, that is my opinion on it... even though the U-Boot Board
target is literally named visionfive2

xypron: In upstream there are only Linux device-trees.

Shadow AI6FS: yes u-boot.git/dts/upstream/src/riscv/starfive

xypron: Maybe one can override the default config name by some invalid value
You just listed a directory with the Linux device-tree

Shadow AI6FS: I think it's these two topics... the fall-through case -
my opinion - needs to be some kind of generic (not just arbitrarily the
visionfive 1.3b) Fdt;   would Linux upstream accept a generic target if
we do that, or is that a legitimate situation for U-Boot to maintain a
generic board Fdt target
the second topic is making the code ordered so it is simply "yes you
will order your list when making commits" and your suggestion of an
invalid item in the list, is that the answer for it? maybe
I would want to know what Simon has in mind if we're asking:  Use
OF_UPSTREAM unless there is a fall-through case, and then we need to say
explicitly what Fdt is named for the fall-through
third topic might be: that fall-through Fdt may or may not be from Linux
upstream

xypron: Could you, please, copy this to a mail to the complete cc of the
patch

Shadow AI6FS: Yes, I'll re-send and postscript with that, thanks

-E
