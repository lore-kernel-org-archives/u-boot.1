Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B84D3C927
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 05:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2BA889256;
	Sun, 20 Oct 2024 07:02:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729400570;
	bh=hOGtH+JzTlwbddmG61HVJBZhAYR717/XYwWBf/zs4nU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IZ2PXfL6bPyVLCs37M8EzAUbG780e1jLrAOOTNFmCf1bUqiaA3z+sfLC60IGddJKf
	 sXohi7t66ItXDZfHzSZ7nj3CFr35JCEuMgdxoxtv05TsuXFlo4oFqivElB6AOs/6aU
	 mAYhP7hEWthfE3xL03pLxIpxb9HckNPXvQEld8bayIBwYuBrP2/0tHYDVky3RXPCB/
	 g0CaUDiCcxpTdnYHgY3VyLbw12AhIxBz+TssTOiS1Sc5MmmCJCdipxeBc1FwM5q6YV
	 +vbMARS7ADdNuhOFiDE3UL0mCXl1UkXpvvvTMfHHUyZj+8K+O6VG9kOWN4G+c9DRGR
	 q8tEloSAlSdyw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D09C5891E7;
 Sun, 20 Oct 2024 07:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729400569;
 bh=hOGtH+JzTlwbddmG61HVJBZhAYR717/XYwWBf/zs4nU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FW8u1QS/caDyfSiRWpOvsM1fnRLjgmStys0USEYJdesJ5iv+VnKkJS4Fe+TDuN8Tt
 G2NEqcyuPQhrXkD8MiXF/p7nLv/DZXkdZZqk9awfEHimCrfDK9Sdkxpbn+Zp696PrB
 Law1p5E+0wQRa75ynUMJI42CTri9xQcCkTa5HrCfZlDTLS5mynQSbQ9PAYKFLmK8pV
 AsWikIn2CzIk0nt1fTV3KnSbK6uaIuJIUlmJLhJ4Vdp6fJPc88gr+/SkNwH136Vvzf
 Y8RoU+UoFh+CFuHVVl3WEtl7OjfPuQ7t/neMSjXaphqtj4z6yB/TK2E2/WB0AB0a/z
 wRZiKjX6jJBRQ==
Message-ID: <ab382b09-8e74-4c74-99e2-4188a5b16117@denx.de>
Date: Sun, 20 Oct 2024 06:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: imx: soc: Select default TEXT_BASE for i.MX6
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>,
 Breno Lima <breno.lima@nxp.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@dh-electronics.com, Fabio Estevam <festevam@gmail.com>
References: <20241019220938.365256-1-marex@denx.de>
 <20241020002701.GC4959@bill-the-cat>
 <403105c3-e432-4d1d-a986-b81ca786b6d5@denx.de>
 <20241020025526.GD4959@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241020025526.GD4959@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 10/20/24 4:55 AM, Tom Rini wrote:
> On Sun, Oct 20, 2024 at 04:25:38AM +0200, Marek Vasut wrote:
>> On 10/20/24 2:27 AM, Tom Rini wrote:
>>> On Sun, Oct 20, 2024 at 12:09:03AM +0200, Marek Vasut wrote:
>>>
>>>> Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
>>>> and SPL text base is picked as the one used by various i.MX6 boards.
>>>> Update all the boards.
>>>>
>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>> [snip]
>>>> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
>>>> index 1f8022ee685..10b19984143 100644
>>>> --- a/arch/arm/mach-imx/mx6/Kconfig
>>>> +++ b/arch/arm/mach-imx/mx6/Kconfig
>>>> @@ -15,6 +15,13 @@ config MX6
>>>>    	select GPT_TIMER if !MX6UL && !MX6ULL
>>>>    	imply CMD_FUSE
>>>> +config TEXT_BASE
>>>> +	default 0x17800000
>>>> +
>>>> +config SPL_TEXT_BASE
>>>> +	depends on SPL
>>>> +	default 0x00908000
>>>
>>> Please do these in Kconfig and common/spl/Kconfig with the other
>>> SoC-wide default values, thanks.
>> There are many examples which do it in arch/$ARCH/$SOC , imx7 does it
>> already, so ... why Kconfig instead ?
>>
>> $ git grep config.TEXT_BASE
>> Kconfig:config TEXT_BASE
>> arch/arm/mach-apple/Kconfig:config TEXT_BASE
>> arch/arm/mach-aspeed/Kconfig:config TEXT_BASE
>> arch/arm/mach-imx/mx7/Kconfig:config TEXT_BASE
>> arch/arm/mach-ipq40xx/Kconfig:config TEXT_BASE
>> arch/arm/mach-npcm/Kconfig:config TEXT_BASE
>> arch/arm/mach-owl/Kconfig:config TEXT_BASE
>> arch/arm/mach-rockchip/Kconfig:config TEXT_BASE
>> arch/arm/mach-rockchip/rk3308/Kconfig:config TEXT_BASE
>> arch/arm/mach-rockchip/rk3568/Kconfig:config TEXT_BASE
>> arch/arm/mach-rockchip/rk3588/Kconfig:config TEXT_BASE
>> arch/arm/mach-rockchip/rv1126/Kconfig:config TEXT_BASE
>> arch/arm/mach-socfpga/Kconfig:config TEXT_BASE
>> arch/arm/mach-stm32mp/Kconfig.13x:config TEXT_BASE
>> arch/arm/mach-stm32mp/Kconfig.15x:config TEXT_BASE
>> arch/arm/mach-stm32mp/Kconfig.25x:config TEXT_BASE
> 
> There are many bad examples. In general (and excluding shoving stuff
> under board/.../Kconfig) I prefer those values to be in the top-level
> Kconfig that asks them rather than per-arch so that it's (a) hopefully
> clear that yes, SoCs can and should add a default when it's known and
> (b) because perhaps this will lead to someone thinking on the problem of
> how ugly it can be and what may be a better solution. Kconfig is
> certainly better than CML1 was/is, and better than our ad-hoc just
> define stuff in board.h files, but it's not perfect. OTOH, if someone
> wants to break down the options we've put (I've told people to put) in
> the top-level Kconfig and instead demonstrate and document a reasonable
> places to put them, OK.
> 
> And if you really want to say that this should just match mx7 for today
> and move on for now, alright.
I am happy to do it either way, but we should figure out the best 
practice ... which I was under the impression was to put architecture 
(or soc) specific default values into arch/ , while the Kconfig symbol 
itself should be in matching Kconfig somewhere else in the tree. Did 
this change recently ?
