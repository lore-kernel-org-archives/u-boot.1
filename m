Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9B37C25B78
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 23:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0328987B35;
	Tue, 14 May 2024 01:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715642138;
	bh=S2yZDNrp6AJXXdKEmou2ws69uome7ZJYqyupIsgXriM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vA0cnuTvuMkZCxmcymNufU4mpm+Qpp8JCKrsqq8H2lBvOTrLnN7VPJe0XH4hyf8YR
	 1TjeCZLglcCZWbh51iyKuMADgaIDrqDmwjVntFkWtK/pseeg2k3hxWFkMJcuHq443Q
	 cqPU81gNbyAJAfNQzWxa+TWZcYa/kL0nCNxBC1tKGtjrVzt/QEoucAL9xrg27YwwWo
	 mKaVA0DUOpl1ju8heC15REMvSeFie8kRbO96tPYWj5yNt6L3LRRu97zWOnedtHjjDK
	 NmBl5oWLL/K9buY3igaq3sCZejB4NIvO4TfhedRJwDtv40mNqzllAM7EvPMsA+R1Zc
	 lK0YfH4Fk8UUg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1976587D33;
 Tue, 14 May 2024 01:15:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715642137;
 bh=S2yZDNrp6AJXXdKEmou2ws69uome7ZJYqyupIsgXriM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=edm0doT2Xq68SqJpBDqN/GrA4c/l7MYoApn2G9gQhR/yqsBupxUhM7qXsjVy4jQHx
 qc54kw/2ECfSQ/foENFRLUWpR0dc+SAq9SZ8fTc8Oeie//uIou+hwSmj6gVwZ2D8cw
 BH5N9RD3G7ZufjPIcKdId75nZMJJUS8vmVBZXYogpvdbgGbhSbxtSgVfUiHvDStARH
 URszCCkyO2r1IwdxurXPmvFoQqTYpCHy7kZ6GIVmqrHqeXAewdMdw7wWDRz0NTCURY
 ORGB6mtdpkk1eC8JXLftW8Tkk2cSWHoEGWIalEtl/W/eYThNeOiMShtysL0dWDoxjp
 jizcWzvZSPp0A==
Message-ID: <c0704b40-51e2-4f35-b062-ceeaee1b2986@denx.de>
Date: Tue, 14 May 2024 01:02:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Avri Altman <avri.altman@wdc.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Fabio Estevam <festevam@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
 <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
 <CAJ+vNU0R5iTgS2_C_OV2VYh5fQnyPV-Lw003CTJAkp1Q6Qdedg@mail.gmail.com>
 <ef623aca-ead7-42dc-bacf-6cb51bdfba41@denx.de>
 <CAJ+vNU3bOrBHf4nQeb=1_EfrcsjcjYncQN3Od2=O93yuVQc2FA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU3bOrBHf4nQeb=1_EfrcsjcjYncQN3Od2=O93yuVQc2FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/13/24 10:52 PM, Tim Harvey wrote:
> On Mon, Apr 29, 2024 at 1:51 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 4/29/24 6:48 PM, Tim Harvey wrote:
>>> On Sat, Apr 27, 2024 at 4:20 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> On 4/27/24 2:11 AM, Tim Harvey wrote:
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/include/mmc.h b/include/mmc.h
>>>>> index 4b8327f1f93b..7243bd761202 100644
>>>>> --- a/include/mmc.h
>>>>> +++ b/include/mmc.h
>>>>> @@ -381,6 +381,21 @@ enum mmc_voltage {
>>>>>     #define MMC_TIMING_MMC_HS200        9
>>>>>     #define MMC_TIMING_MMC_HS400        10
>>>>>
>>>>> +/* emmc hardware partition values */
>>>>> +enum emmc_hwpart {
>>>>> +     EMMC_HWPART_DEFAULT = 0,
>>>>
>>>> One more thing ... eMMC hardware partition 0 and 7 are both referring to
>>>> USER HW partition. Have a look at the git log, there have been patches
>>>> which handled this case in the MMC subsystem from about a year ago.
>>>
>>> Hi Marek,
>>>
>>> I can't find what you are referring to. I assume you are talking about
>>> calling the first name something other than 'user' as technically it's
>>> not (but it gets treated as user).
>>>
>>> Can you find the commit or discussion you are thinking about?
>>
>> It seems this whole thing is much older:
>>
>> 7dbe63bc950b ("SPL: Add CONFIG_SUPPORT_EMMC_BOOT support to
>> CONFIG_SPL_FRAMEWORK")
>>
>> +                * We need to check what the partition is configured to.
>> +                * 1 and 2 match up to boot0 / boot1 and 7 is user data
>> +                * which is the first physical partition (0).
>> +                */
>> +               int part = (mmc->part_config >> 3) & PART_ACCESS_MASK;
>> +
>> +               if (part == 7)
>> +                       part = 0;
> 
> Hi Marek,

Hello Tim,

> Sorry, I haven't been able to work on U-Boot for the past week or so
> and am just getting back to this.

No worries.

> I'm glad you pointed this out as it made me aware that there is a bit
> of a mixing of eMMC PARTITION_CONFIG (Ext CSD 179) fields
> BOOT_PARTITION_ENABLE and PARTITION_ACCESS in U-Boot currently.
> 
> I'm going to add an enumerated type for each and update the various
> places where a 'conversion' as above is done but I'm still a bit torn
> on naming conventions.
> 
> Consider the following:
> - the eMMC spec refers to boot partitions and gp partitions as 1 based
> - the Linux kernel device names for these are 0 based
> - U-Boot does not currently refer to the boot devices by names but
> does currently refer to the gp's by names using 1-based names (the
> 'mmc hwpartition' command)
> 
> Personally I would like to name the boot partitions 'boot0' and
> 'boot1' to match Linux but I think I should name the gp's
> 'gp1'...'gp4' to be backward compatible with the 'mmc hwpartition'
> command.
> 
> What do you think?

I agree.

Maybe you could also check this with Ulf (Linux MMC maintainer) and Avri 
(mmc-utils), both on To:, so we would be consistent and in sync ?
