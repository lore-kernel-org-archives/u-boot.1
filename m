Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40C6CD4F47
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 09:57:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0365386784;
	Fri, 22 Sep 2023 11:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="nAPABrLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26795864E9; Fri, 22 Sep 2023 11:57:15 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A67B86784
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 11:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
Received: from [192.168.0.115] (unknown [86.120.192.236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: ehristev)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 4163166071C9;
 Fri, 22 Sep 2023 10:57:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1695376631;
 bh=xLfnOlNxJKngKZdbkQ66JOVUXOB8KFlVBJtI6JERWgg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nAPABrLmirqy6AgJ/X1PJ5ORhsErJ4JEsxjlA7udhSBaO9CdY8NiXCkRfdtYAqecy
 R+OQUV1GuOheLMaQWiI/PX/o6WvlZO4rd+yawLAOiD6Lqu40RBNPoaPW7G9EZp4k9R
 lfbv3R3/GIgDiMtJudtLhyRaqtJAdktFPj3U/g/FQ2yu2RamD2CFeh/oIxvZykhQME
 mtJ9mdvgR+kRpZu8rx6ilvbfaM7Ceg94I45z4ZR31orqI/hNSik2ysO3HZFfuUqX/y
 uCoPOxKkok+vl7txGqRduTYn4k/UuXzO9TYW8MPSq6OE57GyOuX9OmAk3mVU0k5iRj
 E6EbZCfXUSa4w==
Message-ID: <291705ab-924d-f10c-2f60-e870e45d3beb@collabora.com>
Date: Fri, 22 Sep 2023 12:57:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 00/10] rockchip: rk3588: add support for DFU in SPL
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: marex@denx.de, jonas@kwiboo.se, jagan@edgeble.ai, kernel@collabora.com
References: <20230801072811.10354-1-eugen.hristev@collabora.com>
 <1800682c-9c1b-c242-b15e-4cc9126e4619@collabora.com>
 <259c11ad-3957-f6ad-a001-c73d8f91fdac@rock-chips.com>
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <259c11ad-3957-f6ad-a001-c73d8f91fdac@rock-chips.com>
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

On 9/22/23 03:48, Kever Yang wrote:
> 
> On 2023/9/21 22:47, Eugen Hristev wrote:
>> On 8/1/23 10:28, Eugen Hristev wrote:
>>> This series adds support for DFU in SPL for rockchip rk3588 on rock5b
>>> board.
>>>
>>> Namely, when SPL is loaded via rockusb (thus via USB), having the
>>> `same-as-spl` boot order item, after having detected that it was loaded
>>> from USB, it will lookup the gadget USB node in DT and boot via DFU.
>>>
>>> Some changes were required namely:
>>> - DFU needs environment, hence adding environment variables into DFU
>>> - added bootph-all to nodes such that they are available in SPL
>>> - insert gadget into boot order
>>>
>>> I had to port one patch for DWC3 from Linux, and include in this series
>>> the patches that are floating from Venkatesh that fixup the DWC3
>>> (https://marc.info/?l=u-boot&m=168351919807081&w=2 )
>>>
>>> I know that Marek NAKed them and I am fine with it, I am not trying to
>>> sneak in any patches, they are not to be merged, also this patch
>>> `usb: dwc3: Increase DWC3 controller halt timeout` is in the same bucket
>>> so Marek you can NAK this one as well, no problem, I am just sending out
>>> all the series so maybe the rockchip part for the gadget can be 
>>> picked up
>>> and if people want to use the DFU SPL gadget can also manually pick the
>>> DWC3 patches. The branch with all the patches is available here :
>>>
>>> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot
>>>
>>> Thanks!
>>>
>>> Changes in v2:
>>> - rebased on latest upstream which caused a change in the config patch.
>>>
>>>
>>> Eugen Hristev (7):
>>>    rockchip: allow env defines for SPL build
>>>    usb: dwc3: Increase DWC3 controller halt timeout
>>>    ARM: dts: rockchip: rk3588-rock-5b-u-boot: add bootph-all to gadget
>>>      nodes
>>>    ARM: mach-rockchip: spl-boot-order: add possibility to DFU
>>>    ARM: mach-rockchip: rk3588: add gadget device to the boot order
>>>    rockchip: rk3588: prepare env for DFU
>>>    configs: rockchip: rock5b-rk3588: enable DFU and related configs
>>>
>>> Venkatesh Yadav Abbarapu (3):
>>>    usb: dwc3: core: improve reset sequence
>>>    usb: dwc3: gadget: Don't send unintended link state change
>>>    usb: dwc3: core: Only handle soft-reset in DCTL
>>>
>>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi |  6 +++++
>>>   arch/arm/mach-rockchip/rk3588/rk3588.c  |  1 +
>>>   arch/arm/mach-rockchip/spl-boot-order.c |  3 +++
>>>   configs/rock5b-rk3588_defconfig         | 18 +++++++++++---
>>>   drivers/usb/dwc3/core.c                 | 32 +++++++++++++++----------
>>>   drivers/usb/dwc3/gadget.c               | 20 +++++++---------
>>>   drivers/usb/dwc3/gadget.h               | 14 +++++++++++
>>>   include/configs/rk3588_common.h         |  9 ++++++-
>>>   include/configs/rockchip-common.h       |  4 ----
>>>   9 files changed, 76 insertions(+), 31 deletions(-)
>>>
>>
>>
>> Hello Kever,
>>
>> I see in patchwork this series is marked as 'Changes requested'.
>> Do you wish to tell me which are the changes you requested, as I did 
>> not see anything in your replies.
>> I am interested to see the patches related to rockchip (not the DWC3), 
>> if it's fine for you to merge them.
> 
> Hi Eugen,
> 
>      For rockchip platform part is fine to me, but as a patchset, the 
> dwc3 part is NAKed by Marek, so patch set
> 
> not able to merge.
> 
>      If rockchip part can work without dwc3 change, you can send a 
> separate patch set for it, so that I can merge it.

Hi Kever,

The rockchip part works except the fact that sometimes the dwc3 gadget 
does not power up correctly (hence the three patches that fix the problem).
If you are fine to take the rockchip part I can resend it as a separate 
series. It would be useful for people to have the gadget devicetree and 
configs in upstream, and only the DWC3 part missing. Otherwise, this 
series will float until someone brings DWC3 up to date in U-boot as 
Marek requested. Let me know what do you think.

Thanks,
Eugen

> 
> 
> Thanks,
> 
> - Kever
> 
>>
>> Thanks,
>> Eugen

