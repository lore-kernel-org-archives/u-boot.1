Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1886CC25B75
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 12:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A02D880A7;
	Tue, 14 May 2024 14:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="N1LAPCVw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 883C287947; Tue, 14 May 2024 14:05:49 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BD0C880A7
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 14:05:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1715688344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Tu0crDVmIAIPezBd5kOYRUrE7X89WlqQD6bnBN8vM4=;
 b=N1LAPCVwkRrscNtGtsO7Fyg9XndYVp5Tf9FmQq5J4FgDC+jzOH1g3YL8kKhFwvS8CckU4W
 bR6nGd0cQNdyTSx/M9giDDaZWtCdVexofW+bRhOe19eUFhxr8gQt/ujnYkWx6ybI8/osCj
 Aeno7bxnEHC+MBiFLt7eNkV/g6yFyh4Z5m7jNR1/wKEyOWrv0pq+Z5+nMflwpGkv0rqf32
 P/zCxwKota8IT27frRj7n+tpJ/VQZE+nnBLKVajUvv03O2ul5rTljxr2cZLsaeTPLmibOz
 qUMcNpgJXmUsOknVWVOHSq2ZFftWt7+08SiqrzinN0tGPSnbUXxOqMIRmuisuA==
Date: Tue, 14 May 2024 14:05:41 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Marek Vasut <marex@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Fabio Estevam
 <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
In-Reply-To: <c0704b40-51e2-4f35-b062-ceeaee1b2986@denx.de>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
 <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
 <ef623aca-ead7-42dc-bacf-6cb51bdfba41@denx.de>
 <CAJ+vNU3bOrBHf4nQeb=1_EfrcsjcjYncQN3Od2=O93yuVQc2FA@mail.gmail.com>
 <c0704b40-51e2-4f35-b062-ceeaee1b2986@denx.de>
Message-ID: <3a1a4406d54e6cdc09f03e88f265e555@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

Hello all,

On 2024-05-14 01:02, Marek Vasut wrote:
> On 5/13/24 10:52 PM, Tim Harvey wrote:
>> On Mon, Apr 29, 2024 at 1:51 PM Marek Vasut <marex@denx.de> wrote:
>>> 
>>> On 4/29/24 6:48 PM, Tim Harvey wrote:
>>>> On Sat, Apr 27, 2024 at 4:20 PM Marek Vasut <marex@denx.de> wrote:
>>>>> 
>>>>> On 4/27/24 2:11 AM, Tim Harvey wrote:
>>>>> 
>>>>> [...]
>>>>> 
>>>>>> diff --git a/include/mmc.h b/include/mmc.h
>>>>>> index 4b8327f1f93b..7243bd761202 100644
>>>>>> --- a/include/mmc.h
>>>>>> +++ b/include/mmc.h
>>>>>> @@ -381,6 +381,21 @@ enum mmc_voltage {
>>>>>>     #define MMC_TIMING_MMC_HS200        9
>>>>>>     #define MMC_TIMING_MMC_HS400        10
>>>>>> 
>>>>>> +/* emmc hardware partition values */
>>>>>> +enum emmc_hwpart {
>>>>>> +     EMMC_HWPART_DEFAULT = 0,
>>>>> 
>>>>> One more thing ... eMMC hardware partition 0 and 7 are both 
>>>>> referring to
>>>>> USER HW partition. Have a look at the git log, there have been 
>>>>> patches
>>>>> which handled this case in the MMC subsystem from about a year ago.
>>>> 
>>>> I can't find what you are referring to. I assume you are talking 
>>>> about
>>>> calling the first name something other than 'user' as technically 
>>>> it's
>>>> not (but it gets treated as user).
>>>> 
>>>> Can you find the commit or discussion you are thinking about?
>>> 
>>> It seems this whole thing is much older:
>>> 
>>> 7dbe63bc950b ("SPL: Add CONFIG_SUPPORT_EMMC_BOOT support to
>>> CONFIG_SPL_FRAMEWORK")
>>> 
>>> +                * We need to check what the partition is configured 
>>> to.
>>> +                * 1 and 2 match up to boot0 / boot1 and 7 is user 
>>> data
>>> +                * which is the first physical partition (0).
>>> +                */
>>> +               int part = (mmc->part_config >> 3) & 
>>> PART_ACCESS_MASK;
>>> +
>>> +               if (part == 7)
>>> +                       part = 0;
>> Sorry, I haven't been able to work on U-Boot for the past week or so
>> and am just getting back to this.
> 
> No worries.
> 
>> I'm glad you pointed this out as it made me aware that there is a bit
>> of a mixing of eMMC PARTITION_CONFIG (Ext CSD 179) fields
>> BOOT_PARTITION_ENABLE and PARTITION_ACCESS in U-Boot currently.
>> 
>> I'm going to add an enumerated type for each and update the various
>> places where a 'conversion' as above is done but I'm still a bit torn
>> on naming conventions.
>> 
>> Consider the following:
>> - the eMMC spec refers to boot partitions and gp partitions as 1 based
>> - the Linux kernel device names for these are 0 based
>> - U-Boot does not currently refer to the boot devices by names but
>> does currently refer to the gp's by names using 1-based names (the
>> 'mmc hwpartition' command)
>> 
>> Personally I would like to name the boot partitions 'boot0' and
>> 'boot1' to match Linux but I think I should name the gp's
>> 'gp1'...'gp4' to be backward compatible with the 'mmc hwpartition'
>> command.
>> 
>> What do you think?
> 
> I agree.
> 
> Maybe you could also check this with Ulf (Linux MMC maintainer) and
> Avri (mmc-utils), both on To:, so we would be consistent and in sync ?

As I promised earlier, I went through a few JEDEC standards and some
publicly available JEDEC documents and presentations, and my conclusion
is that no official numbering scheme for the partitions seems to be
defined there.

However, I'd propose that we keep "boot0" and "boot1", because that's
pretty much become a de facto standard, and also switch to using "gp0"
through "gp3" for the general-purpose partitions.  That switch might
be some kind of a backward-incompatible change, but it would follow
the names of the corresponding GP_SIZE_MULT_GP0 ... GP_SIZE_MULT_GP3
fields in the EXT_CSD register, as defined by JEDEC, and it would also
be more consistent with the numbering of the boot partitions.

Though, general-purpose partitions are mentioned as GPP1 ... GPP4 in
one place in the JEDEC standard, which just confirms that no official
numbering scheme seems to be defined.  Moreover, the boot partitions
are more than once referred to as "boot partition 1" and "boot partition
2" in the JEDEC standard, which means we're already not following the
standard with "boot0" and "boot1".

Frankly, it's all a bit contradictory and confusing, but I think that
the increased consistency would outweigh the backward-incompatible
downside of the switch to "gp0" through "gp3".
