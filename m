Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A354AC0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:00:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECDA807E4;
	Fri, 24 Jan 2025 14:00:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CjDGMme3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60688807FE; Fri, 24 Jan 2025 14:00:48 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFDA780780
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=804b=UR=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1737723644;
 bh=O2hQ85bPgDKzkU65+8HJUoTXEAY0zSDO4qRwa1yLevc=;
 b=CjDGMme3lRxFlKiz/eZmPvVvA3fdLPHtMcH1g5eMHbqzq419nn2N0DSMSwimYpPEr2H1mB6ln
 a+9CTx6bLJWq1Y/QXqDLmm9nEO+99yr1UEG290UU0Pjc/+Dzk6dNfC51WSQchLEpRjbm7QhH63x
 4iKdgxQAfnZM26Jfgi1FdZEaUre4ixTReNYKg83PgO83sT7+XM1R1enXb4nJMXhCH/vpiKHBRs2
 iMHvVoUS0cFaPD8Soc0bSWlS17BdtisZlxYUBIfDW39FIhjwx+9DXdBhqP4Nk2E/6rht9IMqA5Y
 l+qnlI9+0R/63soS5jsQvyMtvJpgjKEx6xxR9P3Ys15Q==
X-Forward-Email-ID: 67938ef23e07d3fa85052231
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c391cbc9-dbaf-4c29-9da6-41e241f8547d@kwiboo.se>
Date: Fri, 24 Jan 2025 14:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/13] arm: dts: rockchip: Add rk3528-pinctrl.dtsi
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Joseph Chen <chenjh@rock-chips.com>
References: <20250123224844.3104592-1-jonas@kwiboo.se>
 <20250123224844.3104592-11-jonas@kwiboo.se>
 <bb30c2bd-c003-45e7-a712-534790b744cf@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <bb30c2bd-c003-45e7-a712-534790b744cf@rock-chips.com>
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

On 2025-01-24 12:25, Kever Yang wrote:
> Hi Jonas,
> 
> On 2025/1/24 06:48, Jonas Karlman wrote:
>> From: Joseph Chen <chenjh@rock-chips.com>
>>
>> Import rk3528-pinctrl.dtsi from vendor U-Boot and Linux tag
>> linux-6.1-stan-rkr5 with the hdmi-pins-idle node removed due to missing
>> label reference to pcfg_output_low_pull_down.
>>
>> Signed-off-by: Joseph Chen <chenjh@rock-chips.com>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3528-pinctrl.dtsi | 1397 ++++++++++++++++++++++++++++++
> 
> This should go to mainline kernel first with rk3528.dtsi for this new 
> chip support,
> 
> I don't understand why this need to send separately.

The rk3528.dtsi in upstream Linux v6.13-dts is very basic and only
contain cpu nodes and uart nodes. There is a pending series to add basic
CRU support.

This series is going a little bit ahead of upstream Linux and add bare
minimum to get working boot from eMMC and SD-card. Something that
require working CRU and pinctrl.

Guess we can always wait on full support of CRU, pinctrl, sdhci and
sdmmc to land in upstream Linux before we add support for the SoC in
U-Boot.

Regards,
Jonas

> 
> 
> Thanks,
> - Kever
>>   1 file changed, 1397 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3528-pinctrl.dtsi
>>
>> diff --git a/arch/arm/dts/rk3528-pinctrl.dtsi b/arch/arm/dts/rk3528-pinctrl.dtsi
>> new file mode 100644
>> index 000000000000..ea051362fb26
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3528-pinctrl.dtsi
>> @@ -0,0 +1,1397 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
>> + */
>> +
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +#include "rockchip-pinconf.dtsi"
>> +
>> +/*
>> + * This file is auto generated by pin2dts tool, please keep these code
>> + * by adding changes at end of this file.
>> + */
>> +&pinctrl {

[snip]

>> +};

