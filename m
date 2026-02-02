Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB26D172CD
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 05:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DCD683CDF;
	Mon,  2 Feb 2026 06:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="JW4U7rmP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF88683CE3; Mon,  2 Feb 2026 06:12:41 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C79583C51
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 06:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id F139210D85A; Mon,  2 Feb 2026 06:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770009157;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=CYNusFAagqVZYBFMSjmAkyce5aD9OXliGVUOBOt2ttg=;
 b=JW4U7rmP9rORcBH5F3632YX3npyfFMampgv023hKsJL4joPiulpp0qHss+cRYBbhtUKaDm
 i+SBY4WuSf7jqhh0L/tG5coaZogYHCkzU5f3QbcymqA5Hd/ORPhPfwL5EAxHV3MUxqAaN9
 Lm3mPRfXkfmsqWURLp18SYvi3TwkPwDiXnAnVE+M8eTqNVdhpN5RC5/UPwy7037DfIzsju
 k6WKjb7aJAGbqVAme75mIaKkppJQqPaTrDx657BWqp/edSUKM0rbxX0JPIyli6fgy/C5av
 to6yQRTuO62ohg9Cm8E4wT49iRGKb8AzgLVEIoyfVCrROkJB8Dpfp4tkKSN1KA==
Message-ID: <993992ca-2c6e-ad7a-f9cb-653ef2ca7878@nabladev.com>
Date: Mon, 2 Feb 2026 06:12:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 0/2] fastboot: mmc: fix bootloader offset
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
References: <20260124054712.7939-1-hs@nabladev.com> <87y0lkogbt.fsf@kernel.org>
 <e7917bc9-11b1-18d0-1f04-9d6af003c1cd@nabladev.com>
 <875x8kohmf.fsf@kernel.org>
 <7d9a3b43-7a6c-dc97-69ad-b71acd062538@nabladev.com>
 <87zf5wmrxk.fsf@kernel.org> <877bszm526.fsf@kernel.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <877bszm526.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Mattjis!

On 30.01.26 17:35, Mattijs Korpershoek wrote:
> Hey Heiko,
> 
> On Thu, Jan 29, 2026 at 15:09, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> 
>> On Thu, Jan 29, 2026 at 11:41, Heiko Schocher <hs@nabladev.com> wrote:
>>
>>> Hello Mattijs,
>>>
>>> On 29.01.26 11:09, Mattijs Korpershoek wrote:
>>>> On Mon, Jan 26, 2026 at 16:46, Heiko Schocher <hs@nabladev.com> wrote:
>>>>
>>>>> Hello Mattijs,
>>>>>
>>>>> On 26.01.26 10:48, Mattijs Korpershoek wrote:
>>>>>> Hi Heiko,
>>>>>>
>>>>>> Thank you for the patch.
>>>>>
>>>>> You are welcome!
>>>>>
>>>>>>
>>>>>> On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:
>>>>>>
>>>>>>> Not for all SoCs the bootloader start at offset 0x0,
>>>>>>> in a hardware partition of an emmc. So we need the possibility to
>>>>>>> set the correct offset, where bootloader starts.
>>>>>>>
>>>>>>> Example:
>>>>>>>
>>>>>>> imx8qxp revision C0 emmc Partition layout
>>>>>>>
>>>>>>> | eMMC block / partition | Offset     | Size  | Purpose                        |
>>>>>>> | ---------------------- | ---------- | ----- | ------------------------------ |
>>>>>>> | /dev/mmcblk0boot0      | 0x0        | 2MB   | imx-boot-container A           |
>>>>>>> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
>>>>>>> | /dev/mmcblk0boot1      | 0x0        | 2MB   | imx-boot-container B           |
>>>>>>> |                        | 0x00200000 | 8kB   | U-Boot env 0                   |
>>>>>>> |                        | 0x00202000 | 8kB   | U-Boot env 1                   |
>>>>>>> |                        | 0x00220000 | 128kB | secure boot signature rootfs B |
>>>>>>>
>>>>>>> imx8qxp rev B0 emmc Partition layout
>>>>>>>
>>>>>>> | eMMC block / partition | Offset     | Size  | Purpose                        |
>>>>>>> | ---------------------- | ---------- | ----- | ------------------------------ |
>>>>>>> | /dev/mmcblk0boot0      | 0x00008000 | 2MB   | imx-boot-container A           |
>>>>>>> |                        | 0x00220000 | 128kB | secure boot signature rootfs A |
>>>>>>> | /dev/mmcblk0boot1      | 0x0        | 8kB   | U-Boot env 0                   |
>>>>>>> |                        | 0x00002000 | 8kB   | U-Boot env 1                   |
>>>>>>> |                        | 0x00008000 | 2MB   | imx-boot-container B           |
>>>>>>>
>>>>>>
>>>>>> Why can't we use raw partition descriptors for this?
>>>>>>
>>>>>> See:
>>>>>> https://docs.u-boot.org/en/latest/android/fastboot.html#raw-partition-descriptors
>>>>>
>>>>> Thanks for this hint!
>>>>>
>>>>> Possible yes ( I must try)... but this will lead in adding
>>>>> complexity to scripts people use all over there and needs
>>>>> to adapt CI setups, as siemens has B0 and C0 variants.
>>>>
>>>> If you try, please let me know.
>>>
>>> I am sorry, did not find time yet... sorry.
>>>
>>>> Do the same boards (as in U-Boot board definition) have multiple SoC
>>>> variants (B0 and C0) ?
>>>
>>> Yes there is the capricorn board in U-Boot and it have different
>>> variants (not all mainlined yet) with B0 and C0 variants...
>>> number of boardvariants grown over the years, started even with A0 SoCs
>>> (IIRC)...
>>>
>>>> In that case I understand it's a pain to add more script complexity.
>>>
>>> It is. and U-Boot could easily detect the SoC revision... and it is
>>> fix ... so no need for having this configurable and making mistakes...
>>
>> I agree.
>>
>>>
>>>>> If we introduce this series, user has nothing to know about
>>>>> offsets for different CPU modules as no change in API for
>>>>> them...
>>>>
>>>> I understand, and I do like this approach as well. I just don't like
>>>> having 2 code paths/approaches for the "same thing".
>>>
>>> Hmm... understandable...
>>>
>>>>
>>>> I am not saying that this is a NAK, but i'd like to iterate a bit to see
>>>> if we can either deprecated raw partition descriptors (and migrate
>>>> existing boards) or use that everywhere.
>>>
>>> No idea if this is possible for all boards?
>>>
>>> May user want to write "some data" to an offset... which is not
>>> SoC/board dependent...
>>>
>>> "flash bootloader" is well defined -> flash the bootloader, so I argue
>>> that this should simply burn the bootloader to the correct offset...
>>>
>>> "raw" interface -> do what you think you need write to wherever you want...
>>>
>>>> I will try to use this series on VIM3 to see how it behaves. It will
>>>> take some time though.
>>>
>>> VIM3 ? Is this a imx8qxp based hardware?
>>
>> No VIM3 is a board made by Khadas that has an Amlogic SoC. But they use
>> the raw partition description for bootloader offset:
>>
>> include/configs/khadas-vim3_android.h
>> 52:     "fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
>> 53:     "fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
>>
>> So i'm wondering if this series can be useful to the VIM3 (so that we
>> could drop the fastboot_raw_partition_* from khadas-vim3_android.h)
> 
> With some hacking around, I could drop both above fastboot_raw_* from
> the vim3 environment and use fb_mmc_get_boot_offset() instead.

Cool, thanks!

> 
> The issue I have is that fb_mmc_get_boot_offset() will return the same
> offset for both BOOT1 and BOOT2. I'd like to pass a struct blk_desc* to
> fb_mmc_get_boot_offset() so that I can specify the offset based on
> desc->hwpart.
> 
> Do you think that's reasonable?

Of course!

But I wonder, does this hardware boot from different offsets from
different hardwarepartitions? Sorry, if dummy question...

> I won't ask you to do this in this series. This will be work I'll do
> after this is merged.

Fine for me.

Thanks!

bye,
Heiko
> 
>>
>>
>>>
>>> Thanks for your time!
>>>
>>> bye,
>>> Heiko
>>>>
>>>> Thanks
>>>> Mattijs
>>>>
>>>>>
>>>>> bye,
>>>>> Heiko
>>>>> -- 
>>>>> Nabla Software Engineering
>>>>> HRB 40522 Augsburg
>>>>> Phone: +49 821 45592596
>>>>> E-Mail: office@nabladev.com
>>>>> Geschäftsführer : Stefano Babic
>>>
>>> -- 
>>> Nabla Software Engineering
>>> HRB 40522 Augsburg
>>> Phone: +49 821 45592596
>>> E-Mail: office@nabladev.com
>>> Geschäftsführer : Stefano Babic

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
