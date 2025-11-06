Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D691CCFA03
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 13:49:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4CF583B8C;
	Thu,  6 Nov 2025 14:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XgcAiRbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7710383B91; Thu,  6 Nov 2025 14:49:54 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC0C83B87
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 14:49:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1762436990; x=1763041790; i=xypron.glpk@gmx.de;
 bh=0emw0xDKeBkc7gH4H8SNH3mLbJbGgWgcCST1nMPP3pA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XgcAiRbUgULfBb4JHqITfeK7exVgyMu4B6iPHdFIozCS6RLhA6Z8wtqtXuGOPVYV
 bCXnGiur/3faQtzY6bhylfAPXEOpxxXsw4k0vtMBBDoyCphy1zY8I+zWxRlWzmxJ7
 zgFUyOk/oClTrYfnfSH1g55vWA0aKiQjc8Vu7ovNulGCk0C+5LpPfhTQwfV9VfhBG
 uDPZgtKpKYeMJBbAdTEOgMtLxUR4xaA3BoF5rojMMWr4K+L5WrfabiAdasb7gGSlA
 JcTCUG6brabDr+zKwBcYui74/JaLlzaHeXPNLd4TbCa82nX93mSY1428fHyGEk7EW
 K3w5SbW1KpW+EphWqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.25.183.149] ([93.94.208.154]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzhnN-1wCQLH3DZx-015k3s; Thu, 06
 Nov 2025 14:49:50 +0100
Message-ID: <cb0bb99e-0444-410d-be72-d685bc65a73a@gmx.de>
Date: Thu, 6 Nov 2025 14:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: board: starfive: update jh7110 common description
To: Hal Feng <hal.feng@starfivetech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>
References: <20251024083351.237033-1-e@freeshell.de>
 <5587839a-6d4c-4c0e-ab2b-fe8249463198@gmx.de>
 <25d1e81a-450c-4e44-a57b-6eb7f30879ea@freeshell.de>
 <65456B09-0D88-48D7-A74B-F06211DC0BFF@gmx.de>
 <ZQ2PR01MB1307E9F46803F18B2B9D5394E6C22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZQ2PR01MB1307E9F46803F18B2B9D5394E6C22@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l9QYuFPX969VE6OcAYuTTMVtXdtGA+t9R4QfPtaZQ/AGYGlA/IH
 yHVdRPembkbn0RaLoKEYm/E7x/cA6E3ODXKr+dZhfabdh3d2xlLrARkoevawQZyXQJlQBt0
 PmLUltycn/xeiwGaYmkp9H2bitMeCzM9+z2Fg7/QcwJq0+zSdviMPWS7LutmyEmAl3vEil0
 OK2OjzPuTuoeBrVSOoJlA==
UI-OutboundReport: notjunk:1;M01:P0:rKNLw42NiNk=;mXR7ZGVI8wzu0TBsqW5GqMqxxyr
 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
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

On 11/6/25 09:33, Hal Feng wrote:
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
>>> otherwise I'm not convinced this information can stay. I will expand o=
n
>>> this, below.
>>>
>>>>> process and accordingly was rejected from the upstream process. This
>>>>> does not function anymore in U-Boot SPL to be loaded by BootROM with
>>>>> the
>>>>> [RGPIO1:RGPIO0]=3D1 and [RGPIO1:RGPIO0]=3D2 configurations. Use of S=
D
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
>>>>>  =C2=A0 doc/board/starfive/deepcomputing_fml13v01.rst |=C2=A0 32 -
>>>>>  =C2=A0 doc/board/starfive/jh7110_common.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 597
>>>>> +++++++++++++++---
>>>>>  =C2=A0 doc/board/starfive/milk-v_mars.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 73 ---
>>>>>  =C2=A0 doc/board/starfive/pine64_star64.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 77 +--
>>>>>  =C2=A0 doc/board/starfive/visionfive2.rst=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 449 -------------
>>>>>  =C2=A0 5 files changed, 511 insertions(+), 717 deletions(-)
>>>>>
>>>>> diff --git a/doc/board/starfive/deepcomputing_fml13v01.rst b/doc/
>>>>> board/starfive/deepcomputing_fml13v01.rst
>>>>> index 5d9612483b4..9777f4c6303 100644
>>>>> --- a/doc/board/starfive/deepcomputing_fml13v01.rst
>>>>> +++ b/doc/board/starfive/deepcomputing_fml13v01.rst
>>>>> @@ -9,38 +9,6 @@ The DeepComputing Framework motherboard
>> (FLM13V01)
>>>>> can be combined with a
>>>>>  =C2=A0 U-Boot for the board uses the same binaries as the VisionFiv=
e 2 board.
>>>>>  =C2=A0 Currently only serial console output is supported by mainlin=
e U-Boot.
>>>>>  =C2=A0 -Building
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
>>>>> +=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>>>>> +RGPIO1 RGPIO0 StarFive loader function @ 0x2A00_0000 =3D=3D=3D=3D=
=3D=3D =3D=3D=3D=3D=3D=3D
>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> +0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1-b=
it QSPI Flash offset 0x0
>>>>> +0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SDI=
O3.0 *(deprecated)*
>>>>> +1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eMM=
C5.0 *(deprecated)*
>>>>
>>>> I think we should replace "deprecated" by "not recommended by StarFiv=
e".
>>>
>>> The deprecated loader functions are not reliable and new designs
>>> substitute transistor logic that omits these modes. I did consider som=
e
>>> alternative word choices and "deprecated" gets the point across
>>> quickly.>
>>>>> +1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UAR=
T Serial XMODEM loader =3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D
>>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>>> least what is described here, but there is some OTP and checksum actio=
n
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
>>>>> (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3D0x2).
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
>>>>> -=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> -Address Bytes
>>>>> -=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>> -0x0000=C2=A0 40 02 00 00=C2=A0 00 00 10 00
>>>>> -0x0290=C2=A0 40 02 00 00=C2=A0 00 00 10 00
>>>>> -=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
>> Could you, please , chime in. As board maintainers and working for Star=
Five I
>> would like to hear your view.
>=20
> Actually I was not clear about this problem before and it took me some d=
ays to investigate.
>=20
> Now Iet me explain why we did not recommend booting from SD card and eMM=
C.
>=20
> The SD card boot mode is supported but the mmc driver of BootROM is not =
compatible
> with a few SD cards. If you can't boot from a SD card, you can change an=
other card for a try.
>=20
> The eMMC boot mode loads SPL from sector 0, while the SD card boot mode =
loads GPT
> header from sector 1 and then finds the partition whose GUID is
> 2E54B353-1271-4842-806F-E436D6AF6985 to load SPL. So if we try to use GP=
T partition in
> eMMC, it will fail to boot and report CRC (stored at 0x290) failure. The=
 workaround is using
> the backup load address. After the CRC failure happens, it will try to l=
oad the SPL from the
> backup address (stored at 0x4~0x7). That is why we write 0x00100000 to 0=
x4~0x7. But this
> workaround is not a standard process and may destroy the partition infor=
mation stored in
> sector 0.
>=20
> I suggest to keep the description of SD card / eMMC boot mode because th=
e SD card boot
> mode actually works for most types of SD cards and the workaround eMMC b=
oot mode may
> be useful to some developers.
>=20
> Best regards,
> Hal

How the CRC32 is calculated can be seen in tools/sfspl.c.

/**
  * struct spl_hdr - header for SPL on JH7110
  *
  * All fields are low-endian.
  */
struct spl_hdr {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @offset:=C2=A0=C2=A0=
=C2=A0=C2=A0offset to SPL header (0x240) */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int offset;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @bkp_offs:=C2=A0=C2=
=A0address of backup SPL, defaults to=20
DEFAULT_BACKUP */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int bkp_offs;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @zero1:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0set to zero */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int zero1[159];
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @version:=C2=A0=C2=A0=
=C2=A0header version, defaults to DEFAULT_VERSION */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int version;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @file_size:=C2=A0file=
 size */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int file_size;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @hdr_size:=C2=A0=C2=
=A0size of the file header (0x400) */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int hdr_size;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @crc32:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0CRC32 */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int crc32;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/** @zero2:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0set to zero */
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int zero2[91];
};

crc_check =3D crc32(0, &buf[hdr_size], file_size);

To not depend on any chance probably we should set filesize to 0 in=20
sector 0.

Best regards

Heinrich
