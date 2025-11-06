Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684EBCCFA05
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 14:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF02D83B9B;
	Thu,  6 Nov 2025 15:34:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=freeshell.de header.i=@freeshell.de header.b="Ru6fmZ9I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B64783B96; Thu,  6 Nov 2025 15:34:42 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A141683942
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 15:34:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
 s=s2025; t=1762439674;
 bh=kGdUcT0SGszEf3FTCawEVrwiCozrbxTc92FISK4XO2A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Ru6fmZ9IUKn8jq/5k6eTwYshTGD+bWh/f09xJfb1aSHDeR7D3U5o2nb8/YIkObBrs
 0JWmANAm4H6wI/QuhECL+vba6d2sQ+TVHzOnVsZL1ulb9C9uEpIp2g75ejwX3gd9da
 YXfBhnqkbn/ydnq8dtuAzgL0PcmlsIgBGGXhTYWM74IVKCb7TBKGeauTKeqA1F1nms
 MjvLBI/OQ26CMiAO8dtbc4o9SfL2ASUseiFCkmIOY/cvF63quBxSg+Rs46nP3gJ+SM
 d8hNT/075SMiPLyscU3EIwX09F9Wo3BeK+4sIiHbNTVSkw5SmGpCPwfpzl8vLv99eM
 K9M67s2K3eMBA==
Received: from [192.168.2.54] (unknown [143.105.119.212])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id C054FB2203BE;
 Thu,  6 Nov 2025 15:34:33 +0100 (CET)
Message-ID: <a6e303e2-1dc8-4a68-b7bd-63a8e4e85a2e@freeshell.de>
Date: Thu, 6 Nov 2025 06:34:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: starfive: update jh7110 common description
To: Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20251024083351.237033-1-e@freeshell.de>
 <5587839a-6d4c-4c0e-ab2b-fe8249463198@gmx.de>
 <25d1e81a-450c-4e44-a57b-6eb7f30879ea@freeshell.de>
 <65456B09-0D88-48D7-A74B-F06211DC0BFF@gmx.de>
 <ZQ2PR01MB1307E9F46803F18B2B9D5394E6C22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307E9F46803F18B2B9D5394E6C22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8
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


On 11/6/25 00:33, Hal Feng wrote:
>> On 27.10.25 03:53, Heinrich Schuchardt wrote:
>> Am 26. Oktober 2025 20:07:28 MEZ schrieb E Shattow <e@freeshell.de>:
>>> Hi Heinrich, thanks for the review.
>>>
>>> On 10/26/25 02:56, Heinrich Schuchardt wrote:
>>>> On 10/24/25 09:33, E Shattow wrote:
>>>>> Updates to the JH7110 common descripton:
>>>>> - add detailed overview of JH-7110 SoC and boot process
>>>>> - drop descriptions of deprecated StarFive loader modes
>>>>> - refresh build directions grouped with SPL debug advice
>>>>> - reduce usage instructions into common methods shared by supported
>>>>> boards
>>>>>
>>>>> Redundant/deprecated sections of each board doc are dropped
>> accordingly:
>>>>> - deepcomputing fml13v01
>>>>> - milk-v mars
>>>>> - pine64 star64 (also add inclusion of JH7110 common description)
>>>>> - visionfive2
>>>>>
>>>>> Signed-off-by: E Shattow <e@freeshell.de>
>>>>> ---
>>>>> Preface to reviewers: SD Card / eMMC modes are officially deprecated
>>>>> in the published StarFive JH-7110 Technical Reference Manual. The
>>>>> request for supporting documentation was not answered in the
>>>>> upstream review
>>>>
>>>> The boot ROM was not changed. Ubuntu preinstalled images boot fine
>>>> with U-Boot on SD-card. Booting from eMMC works fine too with a bit
>>>> of patching of the first partition.
>>>>
>>>> It is unfortunate that StarFive is not inclined to document how
>>>> booting from eMMC or SD-card works but this does not mean that it is
>>>> irrelevant to U-Boot users and developers.
>>>>
>>>> Please, keep the existing information.
>>>>
>>>
>>> There is opportunity to do the work ourselves if we choose to[1] do or
>>> otherwise I'm not convinced this information can stay. I will expand on
>>> this, below.
>>>
>>>>> process and accordingly was rejected from the upstream process. This
>>>>> does not function anymore in U-Boot SPL to be loaded by BootROM with
>>>>> the
>>>>> [RGPIO1:RGPIO0]=1 and [RGPIO1:RGPIO0]=2 configurations. Use of SD
>>>>> Card / eMMC within U-Boot Main is not affected and functions
>>>>> normally. Aside, the effort is begun to reverse-engineer the BootROM
>>>>> and gain an understanding about what we would be supporting; for
>>>>> example the specific circumstance of the XMODEM too-man-NAK bug in
>>>>> StarFive loader code, or introducing a patch upstream to accommodate
>>>>> users that continue using deprecated modes.
>>>>> Meanwhile the documentation needs to be updated to reflect what is
>>>>> true and verifiable now.
>>>>>
>>>>> The support enabled in starfive_visionfive2_defconfig for many
>>>>> methods of data transfer is well-documented elsewhere and does not
>>>>> vary enough to be repeated in the JH-7110 common description or that
>>>>> of the supported board documents. This will be deserving of a brief
>>>>> mention in a future update so that users may easily ref link to the
>>>>> enabled methods in sections where they are documented. It is not
>>>>> clear if this will belong in the common description or per-board so
>>>>> it is omitted here.
>>>>>
>>>>> There's some plainly wrong information remaining for the supported
>>>>> boards also deserving of correction in a future update.
>>>>>
>>>>> -E
>>>>> ---
>>>>>   doc/board/starfive/deepcomputing_fml13v01.rst |  32 -
>>>>>   doc/board/starfive/jh7110_common.rst          | 597
>>>>> +++++++++++++++---
>>>>>   doc/board/starfive/milk-v_mars.rst            |  73 ---
>>>>>   doc/board/starfive/pine64_star64.rst          |  77 +--
>>>>>   doc/board/starfive/visionfive2.rst            | 449 -------------
>>>>>   5 files changed, 511 insertions(+), 717 deletions(-)
>>>>>
>>>>> diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/
>>>>> board/starfive/deepcomputing_fml13v01.rst
>>>>> index 5d9612483b4..9777f4c6303 100644
>>>>> --- a/doc/board/starfive/deepcomputing_fml13v01.rst
>>>>> +++ b/doc/board/starfive/deepcomputing_fml13v01.rst
>>>>> @@ -9,38 +9,6 @@ The DeepComputing Framework motherboard
>> (FLM13V01)
>>>>> can be combined with a
>>>>>   U-Boot for the board uses the same binaries as the VisionFive 2 board.
>>>>>   Currently only serial console output is supported by mainline U-Boot.
>>>>>   -Building
>>>>> ---------
>>>>> -
>>>>> -Setup the cross compilation environment variable:
>>> ...snip...
>>>>> +Zero Stage BootLoader
>>>>> +^^^^^^^^^^^^^^^^^^^^^
>>>>> +
>>>>> +JH-7110 ZSBL is typically StarFive loader code in BootROM selected
>>>>> +by
>>>>> RGPIO2
>>>>> +pull-down.
>>>>> +
>>>>> +====== ====== ======================================
>>>>> +RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000 ====== ======
>>>>> +======================================
>>>>> +0      0      1-bit QSPI Flash offset 0x0
>>>>> +0      1      SDIO3.0 *(deprecated)*
>>>>> +1      0      eMMC5.0 *(deprecated)*
>>>>
>>>> I think we should replace "deprecated" by "not recommended by StarFive".
>>>
>>> The deprecated loader functions are not reliable and new designs
>>> substitute transistor logic that omits these modes. I did consider some
>>> alternative word choices and "deprecated" gets the point across
>>> quickly.>
>>>>> +1      1      UART Serial XMODEM loader ====== ======
>>>>> +======================================
>>>>> +
>>>>> +StarFive loader code is assumed to copy content to SRAM @
>>>>> +0x0800_0000
>>>>> and test
>>>>> +for StarFive SPL header followed by a jump to SRAM.
>>>>
>>>> "is assumed" means what here? Is it "We don't know?" or "It is the
>>>> BootROM's duty"? Please, provide an unambiguous description.
>>>>
>>> I agree, I don't like this word choice "is assumed", with the meaning
>>> of "We don't know?"
>>>
>>> Do you know what BootROM code does ? I think it looks like it does at
>>> least what is described here, but there is some OTP and checksum action
>>> that I don't understand myself.
>>>
>>> What do you suggest to say here?
>>>
>>>>> +
>>>>> +First Stage BootLoader
>>>>> +^^^^^^^^^^^^^^^^^^^^^^
>>>>> +
>>> ...snip...
>>>>> -
>>>>> -Booting from SD-Card
>>>>> ---------------------
>>>>> -
>>>>> -The device boot ROM loads U-Boot SPL (u-boot-spl.bin.normal.out)
>>>>> from the -partition with type GUID
>>>>> 2E54B353-1271-4842-806F-E436D6AF6985. You are free -to choose any
>>>>> partition number.
>>>>> -
>>>>> -With the default configuration U-Boot SPL loads the U-Boot FIT
>>>>> image
>>>>> -(u-boot.itb) from partition 2
>>>>> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x2).
>>>>> -When formatting it is recommended to use GUID
>>>>> -BC13C2FF-59E6-4262-A352-B275FD6F7172 for this partition.
>>>>> -
>>>>> -Booting from eMMC
>>>>> ------------------
>>>>> -
>>>>> -The device boot ROM tries to load U-Boot SPL (u-boot-
>>>>> spl.bin.normal.out) from
>>>>> -sector 0 of the eMMC's main hardware partition. But this conflicts
>>>>> with GPT -partitioning. Fortunately eMMC can alternatively load
>>>>> U-Boot SPL from a backup -position.
>>>>> -
>>>>> -For U-Boot SPL (u-boot-spl.bin.normal.out) starting at sector 2048
>>>>> (position
>>>>> -0x100000) write the following bytes to the eMMC device after GPT
>>>>> partitioning:
>>>>> -
>>>>> -======= ========================
>>>>> -Address Bytes
>>>>> -======= ========================
>>>>> -0x0000  40 02 00 00  00 00 10 00
>>>>> -0x0290  40 02 00 00  00 00 10 00
>>>>> -======= ========================
>>>>
>>>> Please, don't drop this information about booting from eMMC.
>>>>
>>>> Best regards
>>>>
>>>> Heinrich
>>>>
>>>
>>> If you have a code listing for BootROM instead which details these
>>> address and byte references then I will be excited to learn more and
>>> expand on our description with citations.
>>>
>>> I do not, however, wish to continue with this booting from eMMC
>>> information as it is. No matter how much time we both have sunk trying
>>> to compare vendor BSP OS images, etc.:
>>>
>>> - it is not a feature that is supported today in U-Boot SPL
>>>
>>> - suggestion violates GUID Partition Table published standard
>>>
>>> - what I do understand now about JH-7110 BootROM[1] is I have no
>>> confidence in this information anymore about StarFive loader booting
>>> U-Boot SPL from SD Card / eMMC
>>>
>>> At our discretion we may contribute to this public document[1] and
>>> there will be no hesitation from me to introduce - on the basis of
>>> verifiable fact - upstream support and summary here for **what the
>>> immutable StarFive loader in JH-7110 SoC is doing**. Going the other
>>> way around looking at vendor BSP OS images is not acceptable to me
>>> after having sunk multiple days into that effort and discussing with
>>> you briefly in the past, there are too many unknowns and unexplained
>>> errors and the result violates actually published standards.
>>>
>>> 1: https://codeberg.org/hrv/jhre
>>>
>>> ... snip
>>>
>>> -E
>>
>> Hello Hal and Minda,
>>
>> Could you, please , chime in. As board maintainers and working for StarFive I
>> would like to hear your view.
> 
> Actually I was not clear about this problem before and it took me some days to investigate.
> 
> Now Iet me explain why we did not recommend booting from SD card and eMMC.
> 
> The SD card boot mode is supported but the mmc driver of BootROM is not compatible
> with a few SD cards. If you can't boot from a SD card, you can change another card for a try.
> 
> The eMMC boot mode loads SPL from sector 0, while the SD card boot mode loads GPT
> header from sector 1 and then finds the partition whose GUID is
> 2E54B353-1271-4842-806F-E436D6AF6985 to load SPL. So if we try to use GPT partition in
> eMMC, it will fail to boot and report CRC (stored at 0x290) failure. The workaround is using
> the backup load address. After the CRC failure happens, it will try to load the SPL from the
> backup address (stored at 0x4~0x7). That is why we write 0x00100000 to 0x4~0x7. But this
> workaround is not a standard process and may destroy the partition information stored in
> sector 0.
> 
> I suggest to keep the description of SD card / eMMC boot mode because the SD card boot
> mode actually works for most types of SD cards and the workaround eMMC boot mode may
> be useful to some developers.
> 
> Best regards,
> Hal

Hi Hal,

Your description is not complete as in the BootROM:

@2a006d00 {
 {0x53, 0xb3, 0x54, 0x2e},
 {0x71, 0x12, 0x42, 0x48},
 {0x80, 0x6f, 0xe4, 0x36},
 {0xd6, 0xaf, 0x69, 0x84},
}

@2a006d10 {
 {0x53, 0xb3, 0x54, 0x2e},
 {0x71, 0x12, 0x42, 0x48},
 {0x80, 0x6f, 0xe4, 0x36},
 {0xd6, 0xaf, 0x69, 0x85},
}

with three XREFs at: 2a0004a2, 2a0004aa, 2a0004b8 from function at
2a000418. This is just a quick look and I have not yet identified the
location in BootROM of eMMC SPL loader functionality.

The JH-7110 Boot User Guide at
https://doc-en.rvspace.org/VisionFive2/Boot_UG/JH7110_SDK/bootrom.html

does explicitly state that BootROM ... "reading SPL to SRAM (0x8000000)"
so I can update that "is assumed to be" with a reference I overlooked
previously.

-E
