Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365A0C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 15:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B8AB83043;
	Tue, 15 Jul 2025 17:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JYCCtoeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CBB783071; Tue, 15 Jul 2025 17:22:42 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C957E83010
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 17:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5605=Z5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1752592958;
 bh=hdTgNqsIo69b3PjPZbhDf9DTl6nr8jLiDbITTYpfwis=;
 b=JYCCtoeODXuGaD1lWkQujvAj/fAOIBhQv6DT/yKliFIC7Iy9K+SEIXptAtLHgW7f/u3d7zqJM
 rifLznH4sYojBqOzLA9Kck8Gwgan/KZxDWde7rLIZNDV3Tk5ij2at5/ZdFt1+M4/wjFbWREQsi0
 RLsgF5sVjxDlwmxWBHMMi0QJKyGILVeLCKHMm605I6eLXrm24FRYC5KKq/QSaAkpVWegbb9W8AK
 g9ayyPn6rQV474e7KMa9rdfo8/YNa4PTxoAw6dbSWFGpjD7mc8pr3aQr+e1M8zkGfdJ8IEMcpEP
 NoJ/91ZZBeM97S5KBasiD7vfF0XbyZkBnnKunMWoQGtg==
X-Forward-Email-ID: 687672364f06c51bcf025161
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <00bc1039-5163-451b-b3e0-81abb4a9185f@kwiboo.se>
Date: Tue, 15 Jul 2025 17:22:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: spl-boot-order: Defer probe of boot device
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250712211232.680047-1-jonas@kwiboo.se>
 <0df75337-a0e0-4076-93db-aa8632e23c8e@cherry.de>
 <13913124-c2b9-4072-b57e-7012b2a222ec@kwiboo.se>
 <9390c906-4462-4e02-83f5-5e7d05dd956f@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <9390c906-4462-4e02-83f5-5e7d05dd956f@cherry.de>
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

Hi Quentin,

On 7/15/2025 3:11 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 7/15/25 11:36 AM, Jonas Karlman wrote:
>> Hi Quentin,
>>
>> On 7/15/2025 11:07 AM, Quentin Schulz wrote:
>>> Hi Jonas,
>>>
>>> On 7/12/25 11:12 PM, Jonas Karlman wrote:
>>>> Boot devices are being probed when SPL boot order is determined. This
>>>> may delay boot slightly and can prevent booting from SPI Flash on boards
>>>> that use same pins for SPI Flash and eMMC due to pinctrl being applied
>>>> prior to booting.
>>>>
>>>
>>> How would that be possible? One cannot have the same pins used for SPI
>>> flash and eMMC at the same time? So that would be an issue in the DT or
>>> a misconfigured DT for the board?
>>
>> Correct, basically there are SoCs, RK3576 and RK3588S comes to mind,
>> that share/mux pins for FSPI and EMMC. And some devices with those SoCs
>> have options to mount a SPI flash or eMMC module using same connector.
>>
>> E.g. Radxa has a SPI flash module for ROCK 5A/5C that can be mounted on
>> the eMMC connector. And ROCK 4D has a shared eMMC/UFS connector with a
>> SPI flash mounted onboard (in some configurations).
>>
>> When I tried to boot from SPI flash on my ROCK 4D and was trying to
>> describe the eMMC module, SPL would instead first probe the SPI flash
>> module and apply the pinctrl for FSPI func, and then when it tries to
>> lookup more boot options, it instead probed the sdhci controller and
>> applied pinctrl for emmc so loading FIT from SPI flash then failed.
>>
> 
> Yeah... but that's an invalid DT you just used, no? SPI flash AND eMMC 
> cannot be used at the same time? So we should either have SPI flash or 
> eMMC enabled in the DT and not both? Or are you planning on supporting 
> booting from SPI flash entirely and then somehow have proper load stuff 
> from the eMMC and not SPI flash or something?

Something like that, some scenarios I envision for future:
a) an eMMC module is mounted and BROM report eMMC as bootsource.
b) a SPI flash module is mounted and BROM report SPINOR as bootsource.

For now only scenario a) is possible on ROCK 5A/5C, because the sdhci is
currently enabled in the FDT that would be loaded in next boot phase.

For scenario b) a DTBO or an alternative FDT config in FIT can be
selected that disabled sdhci and instead enable SPI flash controller.

Main reason to support something like this will be to use the cheap SPI
flash module for bootloader and use NVMe for storage without requiring
a special DT or build of U-Boot.

> 
>> With probe and thus apply of pinctrl happening later when images are
>> loaded we should be able to create a single boot image that dynamically
>> can apply correct FDT/DTBO depending if it was booted from SPI flash or
>> eMMC. Or for the ROCK 4D case (can only boot from FSPI->UFS->USB) being
>> able to boot from SPI flash and then switch to use eMMC for storage.
>>
> 
> I see... So the point would be to have a DTBO with pluggable eMMC which 
> disables the SPI flash and another one with pluggable UFS flash and load 
> the appropriate one based on the boot medium used by the BootROM to load 
> the TPL? This however makes a fallback impossible (e.g. booting from 
> SD/SPI flash so we don't know whether UFS, eMMC or no pluggable storage 
> medium is provided, no or corrupted proper on SD/SPI flash, how to know 
> which next storage to try?).

Correct, for the ROCK 5A/5C their DT currently enable sdhci controller
because this is the most likely use-case. However if the user use a SPI
flash module instead of the eMMC module (same connector), runtime could
determine this and use special FDT or apply an DTBO as you cannot mount
both a SPI flash and eMMC module at the same time.

If I am not mistaken vendor u-boot may already do something to this
effect, try to identify SPI flash and load a special FDT in such case.

Such feature would only be board specific, and possible may require a
special boot only DT for SPL, something to investigate in future.

> 
> Maybe we would need to tentatively apply pluggable eMMC DTBO, try to 
> probe, remove the drivers, apply pluggable UFS DTBO, try to probe, 
> remove the drivers, etc... Seems very complex though :/
> 
>> Something to investigate more in a follow up series.
>>
> 
> Have fun :)

Hehe, I do not think it needs to be that complex, but this idea could
very likely also never amount to anything :-)

> 
> Don't we need to describe the eMMC (sdhci) controller with the pinmux 
> for SPL to be able to load proper from it? Which would conflict with the 
> one from the eMMC controller's? This all seems to be due to some WIP 
> state, bring-up of Rock 4D and odd HW configurations rather than stuff 
> we should support in the long run?

The ROCK 4D variant I have come with onboard SPI flash and a UFS module
mount. I think there may be future variants without SPI flash that
instead can support use of an eMMC module.

Current board variant that have an onboard SPI flash also configure BROM
to use FSPI->UFS->USB boot order (or USB when MSAK-button is pressed).
These models cannot be booted directly from a SD-card (or eMMC).

> 
> I'm still a bit confused by what the plan for 4D and the additional 
> pluggable storage medium are, do you have anything in mind?

With my current ROCK 4D series only SPI flash boot is supported. UFS
boot support would be interesting but I have no current plans to look
into that. Fallback to read FIT from SD-card should also be supported.

Trying to boot from SPI flash and then later switch to eMMC was just
something I was entertaining as an interesting idea, mostly because I
had no UFS module until one was delivered earlier today ;-)

> 
> With my current understanding, I would say that we simply should remove 
> the part about preventing to boot from other storage medium as that is 
> the result of some WIP state that shouldn't make it to upstream U-Boot? 
> We can describe the current limitations in the documentation if you want.

I can try to simplify the commit message in a v2.

> 
> Not wanting to probe devices before they are used is valid though, so 
> the code part of this patch seems reasonable to me.

Yes, this is why I sent this patch standalone, everything else mentioned
above is more about possible future endeavors that this also may help
enable.

Regards,
Jonas

> 
> Cheers,
> Quentin

