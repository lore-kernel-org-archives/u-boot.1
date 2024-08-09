Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F85FC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 10:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9C3A889F1;
	Fri,  9 Aug 2024 12:53:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DAD88A2F; Fri,  9 Aug 2024 12:53:16 +0200 (CEST)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEA2887EB
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 12:53:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtp88t1723200769trr8miuj
X-QQ-Originating-IP: PWqee5fxwVA5uVMe0UNPhoveWD/VEd8LYI49PMJ5qNc=
Received: from [192.168.159.131] ( [106.150.157.243])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 09 Aug 2024 18:52:46 +0800 (CST)
X-QQ-SSF: 01100000000000C0H000000A0000000
X-QQ-FEAT: 3noRBwZIihhH6z2ATA+FeST1KCtagS4Vs/PwA0BTXkCPXRUj4XwRdNiZVtdAe
 0Yrg0B7xhGGWWXVtCG9go4TcjkuWhJ2Ctzxqg+ZIfNaYJtJxY59zgO4coCPlF0oI8TpSqwW
 VuJLue38Qp8egztvOJ8iT6nRK8u4CNqWpheeP2M99zPCcZDLsLjMscGiE9icGQuMJvzDSXU
 fJ1VPvxWJ/KcsRP40SD/plc0bitZQ3kADuA35D8RJsnhks2bEKnBx+LM6z9eZdjY9Ex+n7A
 ut/OmUSios2KPpcPKQr0srny1iLNtZTltEyERBg76/MJjvMWRfpUcTNK0PcgOPF7lM0hvYU
 HDZBcKKERf8xkBrwOKuflJL3wuYri99S3YB/+IHllY37Ep+tpQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6576178683978542876
Message-ID: <B79155DA370A80B0+9fbe189c-1b5e-4454-a60a-75043b8f9831@radxa.com>
Date: Fri, 9 Aug 2024 19:52:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: rockchip: fix dts for Radxa ROCK 4C+
To: Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu,
 dsimic@manjaro.org
References: <20240808221902.2006-1-naoki@radxa.com>
 <ea8287b6-352d-48cf-b370-0d90d2990f08@rock-chips.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <ea8287b6-352d-48cf-b370-0d90d2990f08@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
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

Hi,

On 8/9/24 18:16, Kever Yang wrote:
> 
> On 2024/8/9 06:19, FUKAUMI Naoki wrote:
>> Radxa ROCK Pi 4 series and Radxa ROCK 4C+ are not compatible.
> 
> A little bit more detail about why not compatible?
> 
> The eMMC is different?

I should say "ROCK Pi 4 series and ROCK 4C+ cannot share dts file."

$ grep rk3399-rock-pi-4.dtsi dts/upstream/src/arm64/rockchip/*
dts/upstream/src/arm64/rockchip/rk3399-rock-4se.dts:#include 
"rk3399-rock-pi-4.dtsi"
dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4a-plus.dts:#include 
"rk3399-rock-pi-4.dtsi"
dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4a.dts:#include 
"rk3399-rock-pi-4.dtsi"
dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b-plus.dts:#include 
"rk3399-rock-pi-4.dtsi"
dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4b.dts:#include 
"rk3399-rock-pi-4.dtsi"
dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4c.dts:#include 
"rk3399-rock-pi-4.dtsi"

4C+ is different board.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Thanks,
> 
> - Kever
> 
>> add
>> rk3399-rock-pi-4-u-boot.dtsi contents and remove dependency of it.
>>
>> no functional change is intended.
>>
>> Fixes: 71a95e2efd30 ("arm: dts: rockchip: add Radxa ROCK 4C+")
>> Suggested-by: Dragan Simic <dsimic@manjaro.org>
>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>> ---
>>   arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi 
>> b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
>> index 5ec15a845c1..50dae5cb5ef 100644
>> --- a/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-rock-4c-plus-u-boot.dtsi
>> @@ -1,8 +1,10 @@
>> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +// SPDX-License-Identifier: GPL-2.0+
>>   /*
>> + * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
>>    * Copyright (c) 2023 Radxa Limited
>>    */
>> -#include "rk3399-rock-pi-4-u-boot.dtsi"
>> +#include "rk3399-u-boot.dtsi"
>> +#include "rk3399-sdram-lpddr4-100.dtsi"
>>   &pcfg_pull_none_18ma {
>>       bootph-pre-ram;
>> @@ -14,6 +16,12 @@
>>       bootph-some-ram;
>>   };
>> +&sdhci {
>> +    cap-mmc-highspeed;
>> +    mmc-ddr-1_8v;
>> +    mmc-hs200-1_8v;
>> +};
>> +
>>   &spi1 {
>>       status = "okay";
>> @@ -25,3 +33,7 @@
>>           spi-max-frequency = <10000000>;
>>       };
>>   };
>> +
>> +&vdd_log {
>> +    regulator-init-microvolt = <950000>;
>> +};
> 
