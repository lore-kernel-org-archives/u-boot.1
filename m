Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAFFE73151
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 09:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6FB83DCA;
	Mon,  2 Feb 2026 10:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uiWD3l4d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E61E283DEA; Mon,  2 Feb 2026 10:34:37 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3F783DA7
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 10:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B5C3442A0;
 Mon,  2 Feb 2026 09:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD227C2BCB0;
 Mon,  2 Feb 2026 09:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770024873;
 bh=Mm4Wn4tLy0mri3ioKYQ5lpXG38o0jn2/rlnBaVYkopA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=uiWD3l4dUqD2T1fof314RUJCwTwFzrE2KME4rimbPTmormL1ibcP+P9du5G9IwKeW
 Z9xz3A64endG0dQ0OsJojP7QMf8ON9TRXHH+2bctmcuy89MMGQe2rLHiTagXkNws+5
 TT0xzw5n9sVJu0tlC1Y6hSsxOG/to3POT8AJCwBRwQwQUgvb5VOhZfzfRlv83HLFWE
 5OEI3ljvtCCpLGPYHPt3Vkomo3RytYk/09zQC4DwnUvcugRrkM715iZQfPVRh7UrYr
 1HuD3u2MFCCWic9dB2VkbcrrJY1ai5nPMXECC5JyJFZycoEhIUw6qfKLluedm+qYji
 FtsvGGvcSsgwg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Dmitrii Merkurev
 <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>, Stefano
 Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
In-Reply-To: <993992ca-2c6e-ad7a-f9cb-653ef2ca7878@nabladev.com>
References: <20260124054712.7939-1-hs@nabladev.com> <87y0lkogbt.fsf@kernel.org>
 <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
 <875x8kohmf.fsf@kernel.org>
 <7d9a3b43-7a6c-dc97-69ad-b71acd062538@nabladev.com>
 <87zf5wmrxk.fsf@kernel.org> <877bszm526.fsf@kernel.org>
 <993992ca-2c6e-ad7a-f9cb-653ef2ca7878@nabladev.com>
Date: Mon, 02 Feb 2026 10:34:30 +0100
Message-ID: <87v7gflc9l.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Mon, Feb 02, 2026 at 06:12, Heiko Schocher <hs@nabladev.com> wrote:

> Hello Mattjis!
>
> On 30.01.26 17:35, Mattijs Korpershoek wrote:
>> Hey Heiko,
>>=20
>> On Thu, Jan 29, 2026 at 15:09, Mattijs Korpershoek <mkorpershoek@kernel.=
org> wrote:
>>=20
>>> On Thu, Jan 29, 2026 at 11:41, Heiko Schocher <hs@nabladev.com> wrote:
>>>
>>>> Hello Mattijs,
>>>>
>>>> On 29.01.26 11:09, Mattijs Korpershoek wrote:
>>>>> On Mon, Jan 26, 2026 at 16:46, Heiko Schocher <hs@nabladev.com> wrote:
>>>>>
>>>>>> Hello Mattijs,
>>>>>>
>>>>>> On 26.01.26 10:48, Mattijs Korpershoek wrote:
>>>>>>> Hi Heiko,
>>>>>>>
>>>>>>> Thank you for the patch.
>>>>>>
>>>>>> You are welcome!
>>>>>>
>>>>>>>
>>>>>>> On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wro=
te:
>>>>>>>
>>>>>>>> Not for all SoCs the bootloader start at offset 0x0,
>>>>>>>> in a hardware partition of an emmc. So we need the possibility to
>>>>>>>> set the correct offset, where bootloader starts.
>>>>>>>>
>>>>>>>> Example:
>>>>>>>>
>>>>>>>> imx8qxp revision C0 emmc Partition layout
>>>>>>>>
>>>>>>>> | eMMC block / partition | Offset     | Size  | Purpose           =
             |
>>>>>>>> | ---------------------- | ---------- | ----- | ------------------=
------------ |
>>>>>>>> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container=
 A           |
>>>>>>>> |                        | 0x00220000 | 128kB | secure boot signat=
ure rootfs A |
>>>>>>>> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container=
 B           |
>>>>>>>> |                        | 0x00200000 | 8kB   | U-Boot env 0      =
             |
>>>>>>>> |                        | 0x00202000 | 8kB   | U-Boot env 1      =
             |
>>>>>>>> |                        | 0x00220000 | 128kB | secure boot signat=
ure rootfs B |
>>>>>>>>
>>>>>>>> imx8qxp rev B0 emmc Partition layout
>>>>>>>>
>>>>>>>> | eMMC block / partition | Offset     | Size  | Purpose           =
             |
>>>>>>>> | ---------------------- | ---------- | ----- | ------------------=
------------ |
>>>>>>>> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container=
 A           |
>>>>>>>> |                        | 0x00220000 | 128kB | secure boot signat=
ure rootfs A |
>>>>>>>> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0      =
             |
>>>>>>>> |                        | 0x00002000 | 8kB   | U-Boot env 1      =
             |
>>>>>>>> |                        | 0x00008000 | 2MB   | imx-boot-container=
 B           |
>>>>>>>>
>>>>>>>
>>>>>>> Why can't we use raw partition descriptors for this?
>>>>>>>
>>>>>>> See:
>>>>>>> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partiti=
on-descriptors
>>>>>>
>>>>>> Thanks for this hint!
>>>>>>
>>>>>> Possible yes ( I must try)... but this will lead in adding
>>>>>> complexity to scripts people use all over there and needs
>>>>>> to adapt CI setups, as siemens has B0 and C0 variants.
>>>>>
>>>>> If you try, please let me know.
>>>>
>>>> I am sorry, did not find time yet... sorry.
>>>>
>>>>> Do the same boards (as in U-Boot board definition) have multiple SoC
>>>>> variants (B0 and C0) ?
>>>>
>>>> Yes there is the capricorn board in U-Boot and it have different
>>>> variants (not all mainlined yet) with B0 and C0 variants...
>>>> number of boardvariants grown over the years, started even with A0 SoCs
>>>> (IIRC)...
>>>>
>>>>> In that case I understand it's a pain to add more script complexity.
>>>>
>>>> It is. and U-Boot could easily detect the SoC revision... and it is
>>>> fix ... so no need for having this configurable and making mistakes...
>>>
>>> I agree.
>>>
>>>>
>>>>>> If we introduce this series, user has nothing to know about
>>>>>> offsets for different CPU modules as no change in API for
>>>>>> them...
>>>>>
>>>>> I understand, and I do like this approach as well. I just don't like
>>>>> having 2 code paths/approaches for the "same thing".
>>>>
>>>> Hmm... understandable...
>>>>
>>>>>
>>>>> I am not saying that this is a NAK, but i'd like to iterate a bit to =
see
>>>>> if we can either deprecated raw partition descriptors (and migrate
>>>>> existing boards) or use that everywhere.
>>>>
>>>> No idea if this is possible for all boards?
>>>>
>>>> May user want to write "some data" to an offset... which is not
>>>> SoC/board dependent...
>>>>
>>>> "flash bootloader" is well defined -> flash the bootloader, so I argue
>>>> that this should simply burn the bootloader to the correct offset...
>>>>
>>>> "raw" interface -> do what you think you need write to wherever you wa=
nt...
>>>>
>>>>> I will try to use this series on VIM3 to see how it behaves. It will
>>>>> take some time though.
>>>>
>>>> VIM3 ? Is this a imx8qxp based hardware?
>>>
>>> No VIM3 is a board made by Khadas that has an Amlogic SoC. But they use
>>> the raw partition description for bootloader offset:
>>>
>>> include/configs/khadas-vim3_android.h
>>> 52:     "fastboot_raw_partition_bootloader=3D0x1 0xfff mmcpart 1\0"    =
 \
>>> 53:     "fastboot_raw_partition_bootenv=3D0x0 0xfff mmcpart 2\0"       =
 \
>>>
>>> So i'm wondering if this series can be useful to the VIM3 (so that we
>>> could drop the fastboot_raw_partition_* from khadas-vim3_android.h)
>>=20
>> With some hacking around, I could drop both above fastboot_raw_* from
>> the vim3 environment and use fb_mmc_get_boot_offset() instead.
>
> Cool, thanks!
>
>>=20
>> The issue I have is that fb_mmc_get_boot_offset() will return the same
>> offset for both BOOT1 and BOOT2. I'd like to pass a struct blk_desc* to
>> fb_mmc_get_boot_offset() so that I can specify the offset based on
>> desc->hwpart.
>>=20
>> Do you think that's reasonable?
>
> Of course!

Great, thank you. I'll go ahead and do a more formal review of your
series and will build on top once this is merged.

>
> But I wonder, does this hardware boot from different offsets from
> different hardwarepartitions? Sorry, if dummy question...

It's not a dumb question.

Yes, the boot rom expects the bootloader to be at an offset.
To quote the docs:

"""
On GXL and newer boards it expects to find the FIP binary in sector 1, 512 =
bytes offset from the start.
"""

Also see:
https://docs.u-boot.org/en/latest/board/amlogic/boot-flow.html#boot-modes
https://github.com/LibreELEC/amlogic-boot-fip/pull/8

>
>> I won't ask you to do this in this series. This will be work I'll do
>> after this is merged.
>
> Fine for me.
>
> Thanks!
>
> bye,
> Heiko
>>=20
>>>
>>>
>>>>
>>>> Thanks for your time!
>>>>
>>>> bye,
>>>> Heiko
>>>>>
>>>>> Thanks
>>>>> Mattijs
>>>>>
>>>>>>
>>>>>> bye,
>>>>>> Heiko
>>>>>> --=20
>>>>>> Nabla Software Engineering
>>>>>> HRB 40522 Augsburg
>>>>>> Phone: +49 821 45592596
>>>>>> E-Mail: office@nabladev.com
>>>>>> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
>>>>
>>>> --=20
>>>> Nabla Software Engineering
>>>> HRB 40522 Augsburg
>>>> Phone: +49 821 45592596
>>>> E-Mail: office@nabladev.com
>>>> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
>
> --=20
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
