Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE67C36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 04:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8707D8129B;
	Mon, 31 Mar 2025 06:37:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Q/9RPl0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AA92812BC; Mon, 31 Mar 2025 06:37:12 +0200 (CEST)
Received: from mail-m1973171.qiye.163.com (mail-m1973171.qiye.163.com
 [220.197.31.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5781380F9C
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 06:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 101fd87e9;
 Mon, 31 Mar 2025 12:37:02 +0800 (GMT+08:00)
Message-ID: <42bcb9c6-7196-4b35-a427-3d8e1bb9ae7c@rock-chips.com>
Date: Mon, 31 Mar 2025 12:37:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] arm: dts: rockchip: Add rk3528-pinctrl.dtsi
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Joseph Chen <chenjh@rock-chips.com>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
 <20250123224844.3104592-11-jonas@kwiboo.se>
 <bb30c2bd-c003-45e7-a712-534790b744cf@rock-chips.com>
 <c391cbc9-dbaf-4c29-9da6-41e241f8547d@kwiboo.se>
 <bf1f6d6f-9759-4eb0-9641-cf52668974be@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <bf1f6d6f-9759-4eb0-9641-cf52668974be@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRgfSVZNSh0dTh4dT0tLTh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a95ea7d1c5803afkunm101fd87e9
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OC46STo6QzIDFxERHRlLCkgj
 TDpPCg9VSlVKTE9ISEJOQ0lITkxLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITkxNNwY+
DKIM-Signature: a=rsa-sha256;
 b=Q/9RPl0n6DoyRlvpynr2IBN7RK/nTdDlDAMCro/0rqfA0T7LPiY9Tvwzj2kYWh3llAE2lOe853bnXhIRvmoBItmxwQCHDemc2N8fpt/bXyFU+6xDGPY49mMm9MhUXlO1EKwOzFx6CLeER23VZ7cQFqtG53tOVT2BaThSQAGG6QM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=cOGdm7TXmrbi8/C465Fq+Lx864APrrvvSs11WfLAk70=;
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

Hi Jonas,

On 2025/3/31 00:20, Jonas Karlman wrote:
> Hi Kever,
>
> On 2025-01-24 14:00, Jonas Karlman wrote:
>> Hi Kever,
>>
>> On 2025-01-24 12:25, Kever Yang wrote:
>>> Hi Jonas,
>>>
>>> On 2025/1/24 06:48, Jonas Karlman wrote:
>>>> From: Joseph Chen <chenjh@rock-chips.com>
>>>>
>>>> Import rk3528-pinctrl.dtsi from vendor U-Boot and Linux tag
>>>> linux-6.1-stan-rkr5 with the hdmi-pins-idle node removed due to missing
>>>> label reference to pcfg_output_low_pull_down.
>>>>
>>>> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>    arch/arm/dts/rk3528-pinctrl.dtsi | 1397 ++++++++++++++++++++++++++++++
>>> This should go to mainline kernel first with rk3528.dtsi for this new
>>> chip support,
>>>
>>> I don't understand why this need to send separately.
>> The rk3528.dtsi in upstream Linux v6.13-dts is very basic and only
>> contain cpu nodes and uart nodes. There is a pending series to add basic
>> CRU support.
>>
>> This series is going a little bit ahead of upstream Linux and add bare
>> minimum to get working boot from eMMC and SD-card. Something that
>> require working CRU and pinctrl.
>>
>> Guess we can always wait on full support of CRU, pinctrl, sdhci and
>> sdmmc to land in upstream Linux before we add support for the SoC in
>> U-Boot.
> More features including rk3528-pinctrl.dtsi have now landed in torvalds
> Linux tree.
>
> I will send a v2 of this series once a v6.15-rc1-dts tag is pushed to
> devicetree-rebasing. Until then I keep a work-in-progress branch at [1].

Good to know, I will try to merge patches this week for this merge window.


Thanks,

- Kever

>
> [1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528
>
> Regards,
> Jonas
>
>> Regards,
>> Jonas
>>
>>>
>>> Thanks,
>>> - Kever
>>>>    1 file changed, 1397 insertions(+)
>>>>    create mode 100644 arch/arm/dts/rk3528-pinctrl.dtsi
>>>>
>>>> diff --git a/arch/arm/dts/rk3528-pinctrl.dtsi b/arch/arm/dts/rk3528-pinctrl.dtsi
>>>> new file mode 100644
>>>> index 000000000000..ea051362fb26
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/rk3528-pinctrl.dtsi
>>>> @@ -0,0 +1,1397 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>>> +#include "rockchip-pinconf.dtsi"
>>>> +
>>>> +/*
>>>> + * This file is auto generated by pin2dts tool, please keep these code
>>>> + * by adding changes at end of this file.
>>>> + */
>>>> +&pinctrl {
>> [snip]
>>
>>>> +};
>
