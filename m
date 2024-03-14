Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3F1C5475B
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 07:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D33FC87F5E;
	Thu, 14 Mar 2024 08:33:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dreQJXq1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B4487F49; Thu, 14 Mar 2024 08:33:56 +0100 (CET)
Received: from mail-m21466.qiye.163.com (mail-m21466.qiye.163.com
 [117.135.214.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ADA387F5E
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 08:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=dreQJXq1UfodAroCpdh2Qj/oth10ZP9PDlDxUej62c1TLoMwMR4+OUKcTap3mcLbDjfKTnQjsNZKWRdOPEXfRL+TQ7R1GgJc6J9W7mho4sVFO1pwPU9sssArn54XWTt/6RyPsfhHJ4KgHWqyeBPk+gq5eMSBY6dpdWA+x6KZUb4=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=tN1jrFCRWWSfgYQ1zA3KsUpO88Gf4JnFyVzqe4nTWeQ=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 8005890031B;
 Thu, 14 Mar 2024 15:33:03 +0800 (CST)
Message-ID: <1853e819-67d1-4966-a4b8-8ba054fc5145@rock-chips.com>
Date: Thu, 14 Mar 2024 15:33:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: board: Add minimal generic RK3588S/RK3588 board
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240131220854.117650-1-jonas@kwiboo.se>
 <6d21147e-d420-47f4-acf2-131b0df89279@rock-chips.com>
 <58c4d615-d546-4544-a3d8-36879b66e129@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <58c4d615-d546-4544-a3d8-36879b66e129@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGklITFZCS08fTR0dH00YH09VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e3be0fa9f03a9kunm8005890031b
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6M0k6Nxw5HzMRMC8jGD1CKD4c
 AxgKCy5VSlVKTEpLT0tKTkNPSkhPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFISUtLNwY+
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

Hi Jonas,

On 2024/3/14 15:04, Jonas Karlman wrote:
> Hi Kever,
>
> On 2024-03-14 07:58, Kever Yang wrote:
>> On 2024/2/1 06:08, Jonas Karlman wrote:
>>> Add a minimal generic RK3588S/RK3588 board that only have eMMC and SDMMC
>>> enabled. This defconfig can be used to boot from eMMC or SD-card on most
>>> RK3588S/RK3588 boards that follow reference board design.
>>>
>>> Also fix the alphabetical order of RK3588 boards listed in Makefile and
>>> documentation.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> Since rk356x already have a generic board, rk3588 can also have one.
>>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Thanks, I will send a v2 with an updated defconfig to take advantage of
> the new ROCKCHIP_COMMON_STACK_ADDR bss and stack addresses.

I have fix this and also other new boards defconfig, so you don't need 
to do this.


Thanks,

- Kever

>
> Regards,
> Jonas
>
>> Thanks,
>> - Kever
>>
>>> ---
>>> This patch depend on the series "rockchip: rk35xx: Sync device tree
>>> with linux v6.8-rc1" [1].
>>>
>>> [1] https://patchwork.ozlabs.org/cover/1891669/
>>> ---
>>>    arch/arm/dts/Makefile                   |  5 +-
>>>    arch/arm/dts/rk3588-generic-u-boot.dtsi |  3 ++
>>>    arch/arm/dts/rk3588-generic.dts         | 44 ++++++++++++++++
>>>    board/rockchip/evb_rk3588/MAINTAINERS   |  7 +++
>>>    configs/generic-rk3588_defconfig        | 68 +++++++++++++++++++++++++
>>>    doc/board/rockchip/rockchip.rst         |  3 +-
>>>    6 files changed, 127 insertions(+), 3 deletions(-)
>>>    create mode 100644 arch/arm/dts/rk3588-generic-u-boot.dtsi
>>>    create mode 100644 arch/arm/dts/rk3588-generic.dts
>>>    create mode 100644 configs/generic-rk3588_defconfig
>>>
> [snip]
