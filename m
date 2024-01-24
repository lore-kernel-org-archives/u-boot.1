Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCB1C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 07:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E7C87BF0;
	Wed, 24 Jan 2024 08:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="P3+FgGuW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E0A87BFC; Wed, 24 Jan 2024 08:51:04 +0100 (CET)
Received: from mail-m24121.xmail.ntesmail.com (mail-m24121.xmail.ntesmail.com
 [45.195.24.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259B287BB9
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 08:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=P3+FgGuWIkp9wWs4hka0OpK4JE7k7uwSSBw4oI/2WZ13Mxuzt59HNqZoPVWb9/ZfHnra+kMxCINsGnycEXzP1tiDLco/Pcnl6eTUr5if0M4BURirdq+WetIUZZA1jI/x/8yRIPdD3sWXwfGAJVuF+lVKlw/Gkrlzh9K2Ustk2Lk=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=vkuOuFXcho9rv78Zt8m/g4gsVSGK9a7KfxDGzVe5qcM=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 0BAA9400466;
 Wed, 24 Jan 2024 15:50:56 +0800 (CST)
Message-ID: <2d35dec8-d1d0-42b6-9da7-88f8dba055d4@rock-chips.com>
Date: Wed, 24 Jan 2024 15:50:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] Convert CONFIG_SPL_STACK to Kconfig
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20220529165521.912054-1-trini@konsulko.com>
 <CAKUh=RyhSZKzh+ab6kq1ZLYqEonhbjikJcaDASqhbdo6kQ+-Lg@mail.gmail.com>
 <20240123175847.GT3652023@bill-the-cat>
 <028260b9-255d-4630-b793-1f065ffb1e7f@rock-chips.com>
 <20240124013402.GZ3652023@bill-the-cat>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240124013402.GZ3652023@bill-the-cat>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQk4fHVYZH0NKS0sYGEpLSxpVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d3a735f582eb3kusn0baa9400466
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PxQ6LQw4GDwiCAEREilKDAgX
 GigaFC9VSlVKTEtNS0NJTU5NTkhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTExKNwY+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Tom,

On 2024/1/24 09:34, Tom Rini wrote:
> On Wed, Jan 24, 2024 at 09:15:07AM +0800, Kever Yang wrote:
>> Hi Tom,
>>
>> On 2024/1/24 01:58, Tom Rini wrote:
>>> On Tue, Jan 23, 2024 at 11:53:18AM +0800, Kever Yang wrote:
>>>
>>>> Hi Tom,
>>>>
>>>> rk3036 only has small size internal sram, so it can only use very
>>>> simple SPL which only including dram init, and no SPL_FRAMEWORK
>>>> support.
>>>> In this convert, the CONFIG_SPL_STACK is lost for this SoC, any
>>>> suggestions on this kind of issue?
>>> Does this work?
>>>
>>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>>> index e7b84fc1fa68..9deee0fdbea8 100644
>>> --- a/common/spl/Kconfig
>>> +++ b/common/spl/Kconfig
>>> @@ -372,7 +372,8 @@ config SPL_SHARES_INIT_SP_ADDR
>>>    config SPL_STACK
>>>    	hex "Initial stack pointer location"
>>> -	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && SPL_FRAMEWORK
>>> +	depends on (ARM || ARCH_JZ47XX || MICROBLAZE || RISCV) && \
>>> +		SPL_FRAMEWORK || ROCKCHIP_RK3036
>> This works with adding CONFIG_SPL_STACK in rk3036 board defconfig.
>>>    	depends on !SPL_SHARES_INIT_SP_ADDR
>>>    	default 0x946bb8 if ARCH_MX7
>>>    	default 0x93ffb8 if ARCH_MX6 && MX6_OCRAM_256KB
>>>
>>> You will have to update the ROCKCHIP_RK3036 platforms otherwise the
>>> build will hang now.
>> What do you mean to update the platform?
>>
>> The rk3036 case should be one of the available option for those "small"/low
>> end SoCs has very limit
>>
>> size of internal dram, only need minimal SPL+ U-Boot,  and no requirement
>> for ATF/OPTEEwhich will have to use TPL+SPL+U-Boot.
>>
>>
>> The CONFIG_SPL_STACK is used in assemble init code, it doesn't need to
>> depends on SPL_FRAMEWORK, isn't it?
> I just mean that with the above Kconfig change, all RK3036 platforms
> must set a value for CONFIG_SPL_STACK at the same time, or they will
> fail to build (and CI will get hung).

It doesn't hang because the build goes to another branch which not 
defined CONFIG_SPL_STACK,

the board get panic when it run the firmware.

> It sounds like all RK3036
> platforms need to set the value in order to work,

Yes, this is correct.

The init code doesn't define a correct SP, that should be a bug.


Thanks,
- Kever
> so this isn't a bug,
> just a feature. Is that clearer?
>
