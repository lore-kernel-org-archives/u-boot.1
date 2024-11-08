Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2DCD5D69F
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 00:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CFBC88C66;
	Fri,  8 Nov 2024 01:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ThDZHRwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B7388C66; Fri,  8 Nov 2024 01:50:51 +0100 (CET)
Received: from mail-m19731102.qiye.163.com (mail-m19731102.qiye.163.com
 [220.197.31.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9892F88B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 01:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 22250aef;
 Fri, 8 Nov 2024 08:50:39 +0800 (GMT+08:00)
Message-ID: <33edc0c5-29ea-4857-ac60-569c39102f57@rock-chips.com>
Date: Fri, 8 Nov 2024 08:50:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next v2 4/4] rockchip: rk3399: move sysreset-gpio logic to
 TPL
To: Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@cherry.de>, u-boot@lists.denx.de,
 Paul Kocialkowski <contact@paulk.fr>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
 <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
 <149361d4-4cbb-4007-b00f-6b4efbd7978f@rock-chips.com>
 <5cfa0fbe-5003-4da1-9933-7664da07cd4d@cherry.de> <ZyyyNttkdcdQmmCw@collins>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <ZyyyNttkdcdQmmCw@collins>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR4eGFYYHUIeT05KTRpDThlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
 JVSktLVUpCS0tZBg++
X-HM-Tid: 0a930940759803afkunm22250aef
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTY6KBw6TjIYTzQ#C0ovAwhW
 AR8KCjhVSlVKTEhKS0lMS09LTE5PVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISEpINwY+
DKIM-Signature: a=rsa-sha256;
 b=ThDZHRwHBBfDDJQguj378ApAhGw0ySAyWxfewTJ7souGrV7A1MDgXBedCGpyU69KXIx317sXd0wXW8lxQJlTv1FBJBUjGC6NqTfQxkZcA/ueDPBdeQNEOjKIswg6XKZNB8MOLy5LXo+YFRxk6xSBXcFVAvDJrOHryIQ9/mbwQ9A=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=9jsWpW2dfszbluut69i11s6fqbMsceVNN2vxFF5AZq4=;
 h=date:mime-version:subject:message-id:from;
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

Hi Paul,

On 2024/11/7 20:27, Paul Kocialkowski wrote:
> Hi,
>
> Le Thu 07 Nov 24, 12:04, Quentin Schulz a écrit :
>> On 11/7/24 8:14 AM, Kever Yang wrote:
>>> Yes, this movement is reasonable and needed for this workaround,
>>> although still not
>>>
>>> understand why puma board need this.
>> Me neither, this predates me joining the company, c.f.:
>> https://source.denx.de/u-boot/u-boot/-/commit/ae0d33a7291a164a11ae034bcf4f71226b2bef48
>> https://source.denx.de/u-boot/u-boot/-/commit/5f104178bf713615dc404fdfcf0fb53d89c66a07
>> https://source.denx.de/u-boot/u-boot/-/commit/07586ee4322abca01db52624b925e5218538f259
>>
>> What I can tell you is that it seems this is required as Paul (in Cc) is
>> trying to add support for it for the Firefly ROC-RK3399-PC[1] and the
>> ROCKPro64[2], so it seems it's useful for **some** purpose.
> The initial issue I was seeing was that one of the MMC controllers showed some
> errors and failed to read data after reboot, while it always worked on cold
> boot. With this feature enabled, it worked reliably after reboot.
>
> I didn't investigate exactly which component (maybe clocks, maybe regulators)
> caused the problem, but it clearly wasn't correctly reset.

Are you able to check, how is the 'reboot' happen, does it use the 
system_reset API from the ATF?

Because there are some operations for clock and PD before trigger the 
global reset in ATF driver

and the code is very stable and used for millions of devices.


Thanks,
- Kever
>
> Cheers,
>
> Paul
>
>> [1]
>> https://lore.kernel.org/u-boot/20240926183111.1324284-1-paulk@sys-base.io/
>> [2]
>> https://lore.kernel.org/u-boot/20240926183111.1324284-2-paulk@sys-base.io/
>>
>>>> - faster boot time as we don't need to reach SPL to be able to reset the
>>>>     system on a condition we know is already met in TPL,
>>>> - have less code to be impacted by the issue this system reset works
>>>>     around (that is, "unclean" SoC registers after a reboot),
>>>> - less confusion around the reason for restarting. Indeed when done from
>>>>     SPL, the following log can be observed:
>>>>
>>>> """
>>>> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
>>>> Channel 0: DDR3, 666MHz
>>>> BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>>>> Channel 1: DDR3, 666MHz
>>>> BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
>>>> 256B stride
>>>> Trying to boot from BOOTROM
>>>> Returning to boot ROM...
>>>>
>>>> U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 -
>>>> 15:31:45 +0100)
>>>> Trying to boot from MMC2
>>>>
>>>> U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
>>>> """
>>> So with this patch set, we can see the TPL banner twice ?
>>>
>>>
>>> PS: We are able to merge to master instead of next before next branch is
>>> open, because we still have
>>>
>>> enough time to debug before next release.
>>>
>> My understanding is that once -rc1 is out, we should only do bug fixing in
>> master. BUT at the same time, next branch isn't actually open until -rc2.
>>
>> Up to you! It's not really urgent, Puma was migrated to TPL only in v2023.01
>> and we've lived without sysreset-gpio in TPL since then :)
>>
>> Cheers,
>> Quentin
