Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AC2C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:05:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8359D87641;
	Wed,  1 Nov 2023 12:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="MV1W5m20";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7121A876F2; Wed,  1 Nov 2023 12:05:14 +0100 (CET)
Received: from mail-m127230.xmail.ntesmail.com
 (mail-m127230.xmail.ntesmail.com [115.236.127.230])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E86F875A8
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=MV1W5m20N+1Z+PWWNdN3mPFAhk036sW6qKxmoARk5fnbLi46b8uAEaj7OrEyKVFG6bWfBuuYdQHnhdblFXwAjUD8QbYw6mgwfYKSkZJOJFD9IX9PxdgMDuLO+CkFyVOI5WPk1QW6ORuiMjMJAQqlpUZ51c4hv765dVglb+xnkRw=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=YfVDc47dmn343FsBDuiQe4wjJB2H6QBXiXCALi4Roww=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 727C0400424;
 Wed,  1 Nov 2023 19:04:58 +0800 (CST)
Message-ID: <1c6b6cc9-840c-4608-b15b-fdde4ac24b9f@rock-chips.com>
Date: Wed, 1 Nov 2023 19:04:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: add FriendlyElec NanoPC-T6 rk3588 board
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, John Clark <inindev@gmail.com>,
 sst@poczta.fm
Cc: Eugen Hristev <eugen.hristev@collabora.com>, Jagan Teki
 <jagan@edgeble.ai>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 chenfen <chenfen@rock-chips.com>, =?UTF-8?B?6LW15Luq5bOw?=
 <zyf@rock-chips.com>
References: <20231007212552.11109-1-inindev@gmail.com>
 <3145ccc9-d6d6-ee81-4158-9ac576f1a236@rock-chips.com>
 <b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <b82c02c0-0a37-8553-f498-b03f85394d59@kwiboo.se>
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGhhIQ1ZOTUoYTBkfQhhMSkhVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5MSUpJVUpLS1VKQl
 kG
X-HM-Tid: 0a8b8a8ed62e2eb3kusn727c0400424
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDY6Txw*Ijw8ExojCw8oEhQ0
 LR0KCTJVSlVKTUJDQ0hNTUJCSkxPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDTUlNNwY+
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

Add Slawomir Stepien;

Hi Jonas,  John, Slawomir:


On 2023/10/18 04:47, Jonas Karlman wrote:
> Hi Kever,
>
> On 2023-10-08 11:09, Kever Yang wrote:
>> On 2023/10/8 05:25, John Clark wrote:
>>> NanoPC-T6 is a Rockchip RK3588 based SBC by FriendlyElec.
>>>
>>> There are four variants depending on the DRAM size: 4G/32GB eMMC, 8G/64GB eMMC,
>>> 16G/16MB SPI NOR, and 16G/256GB eMMC/16MB SPI NOR
>> So the board is using SPI NOR flash.
>>
>>
>> [...]
>>
>>> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> index b1f535fad5..e08ebfa39b 100644
>>> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
>>> @@ -40,6 +40,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>>    const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>>    	[BROM_BOOTSOURCE_EMMC] = "/mmc@fe2e0000",
>>>    	[BROM_BOOTSOURCE_SPINOR] = "/spi@fe2b0000/flash@0",
>>> +	[BROM_BOOTSOURCE_SPINAND] = "/spi@fe2b0000/flash@0",
>> Why need a SPI NAND?
>>
>> If this is really needed, will be a separate patch to support a new boot
>> source from bootrom.
> I have done spi boot testing on a few rk3588 boards with SPI NOR flash,
> and there seem to be a correlation between the bootsource/bootdevice id
> written to reg by the bootrom and the fspi iomux used by the board.
>
> Following bootsource/bootdevice value can be read from reg,
>
> - FSPI (M0): 3
> - FSPI (M1): 4
> - FSPI (M2): 6
>
> based on testing on the following boards:
>
> - Radxa ROCK 5 Model A - fspim0_pins - rk3588s
> - Xunlong Orange Pi 5 - fspim0_pins - rk3588s
>      brom_bootdevice_id: 3
>
> - FriendlyElec NanoPC-T6 - fspim1_pins - rk3588
> - Xunlong Orange Pi 5 Plus - fspim1_pins - rk3588
>      brom_bootdevice_id: 4
>
> - Radxa ROCK 5 Model B - fspim2_pins - rk3588
>      brom_bootdevice_id: 6
>
> Can these observations be correct? And if so, maybe we should use
> following constants for RK3588?
>
>    BROM_BOOTSOURCE_FSPI_M0 = 3
>    BROM_BOOTSOURCE_FSPI_M1 = 4
>    BROM_BOOTSOURCE_FSPI_M2 = 6

Very good finding, I have check internally with bootrom owner, the 
definition is exactly same as

these three option for SPI M0 to M2.

>
> Any insights into what values bootrom will write to reg would be very
> helpful.

After add FSPI M0-M2, the spi NAND/NOR source has complete support, 
there is no separate definition

for SPI NAND and SPI NOR for now until RK3588, all three ports can 
support both SPI NAND and spi NOR.


Thanks,

- Kever

>
> Regards,
> Jonas
>
>>
>> Thanks,
>> - Kever
>>
