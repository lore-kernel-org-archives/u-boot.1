Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8957C28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 16:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0B5880FDA;
	Sun, 30 Mar 2025 18:21:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Oz3f3vC7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241B28171B; Sun, 30 Mar 2025 18:21:05 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46CF4800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 18:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: From: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1743351659;
 bh=YGVlZ63gC0Ap06eukCZQOJL5WdLdNjF5jW73vG6WDNY=;
 b=Oz3f3vC7HIiBHtdFAh3fEgFbZqoY9OrrGcvLqEe8/5w1sKXCzn+34LuOO7aLVQlhnIiyQDGZc
 KdJrMpqzYxyJGixauxLA60Xuzht7aef3SIVi/guKbeHdH9VFfTJgfVv7lD2OnUhX7k+ZfwbKOvZ
 GREWdDM2i4O4x8EVMzNbJ/VgsLOeb+PEtlPdiYbKVSOJb6kusF3YWLW74hzCYTSN5EeH+ndmfrR
 zzUEzVGEx53cFeB8fwUOA5+asDV4r9Zxm5HvCriH3hne91FJz1kWUibZUG4rFw5fBybIwY4OOC/
 N0vOmp/Kq0cTWccy+WKFG+BW06vk+7+YEgZOnzaWgoWQ==
X-Forward-Email-ID: 67e96f66b53fbafc9c394f41
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <bf1f6d6f-9759-4eb0-9641-cf52668974be@kwiboo.se>
Date: Sun, 30 Mar 2025 18:20:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] arm: dts: rockchip: Add rk3528-pinctrl.dtsi
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Joseph Chen <chenjh@rock-chips.com>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
 <20250123224844.3104592-11-jonas@kwiboo.se>
 <bb30c2bd-c003-45e7-a712-534790b744cf@rock-chips.com>
 <c391cbc9-dbaf-4c29-9da6-41e241f8547d@kwiboo.se>
Content-Language: en-US
In-Reply-To: <c391cbc9-dbaf-4c29-9da6-41e241f8547d@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
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

Hi Kever,

On 2025-01-24 14:00, Jonas Karlman wrote:
> Hi Kever,
> 
> On 2025-01-24 12:25, Kever Yang wrote:
>> Hi Jonas,
>>
>> On 2025/1/24 06:48, Jonas Karlman wrote:
>>> From: Joseph Chen <chenjh@rock-chips.com>
>>>
>>> Import rk3528-pinctrl.dtsi from vendor U-Boot and Linux tag
>>> linux-6.1-stan-rkr5 with the hdmi-pins-idle node removed due to missing
>>> label reference to pcfg_output_low_pull_down.
>>>
>>> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>   arch/arm/dts/rk3528-pinctrl.dtsi | 1397 ++++++++++++++++++++++++++++++
>>
>> This should go to mainline kernel first with rk3528.dtsi for this new 
>> chip support,
>>
>> I don't understand why this need to send separately.
> 
> The rk3528.dtsi in upstream Linux v6.13-dts is very basic and only
> contain cpu nodes and uart nodes. There is a pending series to add basic
> CRU support.
> 
> This series is going a little bit ahead of upstream Linux and add bare
> minimum to get working boot from eMMC and SD-card. Something that
> require working CRU and pinctrl.
> 
> Guess we can always wait on full support of CRU, pinctrl, sdhci and
> sdmmc to land in upstream Linux before we add support for the SoC in
> U-Boot.

More features including rk3528-pinctrl.dtsi have now landed in torvalds
Linux tree.

I will send a v2 of this series once a v6.15-rc1-dts tag is pushed to
devicetree-rebasing. Until then I keep a work-in-progress branch at [1].

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commits/rk3528

Regards,
Jonas

> 
> Regards,
> Jonas
> 
>>
>>
>> Thanks,
>> - Kever
>>>   1 file changed, 1397 insertions(+)
>>>   create mode 100644 arch/arm/dts/rk3528-pinctrl.dtsi
>>>
>>> diff --git a/arch/arm/dts/rk3528-pinctrl.dtsi b/arch/arm/dts/rk3528-pinctrl.dtsi
>>> new file mode 100644
>>> index 000000000000..ea051362fb26
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3528-pinctrl.dtsi
>>> @@ -0,0 +1,1397 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
>>> + */
>>> +
>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>> +#include "rockchip-pinconf.dtsi"
>>> +
>>> +/*
>>> + * This file is auto generated by pin2dts tool, please keep these code
>>> + * by adding changes at end of this file.
>>> + */
>>> +&pinctrl {
> 
> [snip]
> 
>>> +};
> 

