Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4D2E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 13:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 288F880104;
	Mon, 16 Dec 2024 14:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23B4880141; Mon, 16 Dec 2024 14:26:07 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1743D8003E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 14:26:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1734355525t4wo8pm
X-QQ-Originating-IP: 1mqSAuRcRxrHZ2l8eT1va35wUbB0A1EnWsFnJbvkSRw=
Received: from [IPV6:240f:10b:7440:1:f7da:fd82 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 16 Dec 2024 21:25:21 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5865343408110875267
Message-ID: <9FA439F060A2D933+5da96a32-8647-4949-b4e3-fc23fab19ace@radxa.com>
Date: Mon, 16 Dec 2024 22:25:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] rockchip: Add support for Radxa ROCK 5C
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 sumit.garg@linaro.org, jonas@kwiboo.se
References: <20241211033934.23044-1-naoki@radxa.com>
 <20241211033934.23044-6-naoki@radxa.com>
 <2600bdcb-3c57-4d52-97d1-c63758b25ed2@cherry.de>
 <115020791DA19920+c09c7adb-9fe7-47f4-99cb-2c8c862fe1c5@radxa.com>
 <6b93f3d7-c0bf-4517-9523-3c1a6a1e23dd@cherry.de>
 <445A20D66F127770+f902f36a-5648-4850-8dd9-99b7f36380a8@radxa.com>
 <e4a637ff-853e-4072-821a-8f79230913f5@cherry.de>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
Organization: Radxa Computer (Shenzhen) Co., Ltd.
In-Reply-To: <e4a637ff-853e-4072-821a-8f79230913f5@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NggtViPIjqV6/CpXeSgNKazr96T7OYnhLSerEr+JhzrbHWML4HUXGmH2
 kiUkTNQb4zvLhU2jrSqFuUhRHBu8BYNIrrfsyC3CsNFgnUxlTZwv06o6GKzF1EnkNmMzQ3m
 v+Xqdb0MORVF3eGdlrlxJoku71k7jVfs9a+PDw4q+MqCLZYR7VATzEf2N8e34RxLWdRQutb
 /og7101VFPL6+8pRXlIxyMUDYZGJ2xgDpFLHmhCx78EkLqxPix0H1bAyk042jWAyC6m5B0B
 F86VQuRe9DYuEvdpuz2ZGycIvPiX1a9Nb1RQLl2iPGe9hoDDKbJN3BcGBzTy4RsEnejvrtY
 ylVcOe2u5nAGGqFZLV9Ae7JcZj+Tw0fr/nPs0IMqnn3XeeRHk16RMaq/aBBPssQNpGYQcBU
 Izo1GmSnDqqo94lzR6P1P3C2j7ioqi1JPoFB0t9XXROlauwLuCP4OlFQn/m01orkXOLQVHn
 LWU1UTlkbPjmLASzAIAG5YSRoMdHLRHILDPuhn4NJx8vSijb1XSd4TKUH/OCjz+F3ORUF0q
 7Y1MuKDmWsOH16JxrFC4yhil7bxpQaKzghKKxmYyKTMvfSY0AChiYOm9ygCFWR59dTymqrI
 /zYJaEqEJLFNxzwZxxEF0tfpKtZi0RxeOX3Xvd+yZX2CgZ4Gqg4bI0ChOP1f94V9IxYMDhx
 EtFmmmef8f0uwoNwnM3pQOh9KB5qjxIsrzmGxQmw6qSpKMKmnuLCzwjXAeq1RBxEXC9JaYU
 sLEZPz9dnQXdabTZuPn7g+hWVvt7wzOjOsClIHoxW0L9Yhrwwqa0zijtgGudTBx7BLL/zu0
 VWp/yDqffYbGPsHmoSn6Bo/UEVzsFOJVU+0MGetbQn5FmXahIORH3dSxQURkgu76YYbdI3Q
 EDDSEPBoL8YZA+KZptR8qbKtBVeF1Td6KuXkWTx4sWMltBqems78bgy/s2azviTouSzMCMw
 9pRKeK/tmHKJKCw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
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

Hi Quentin,

On 12/16/24 21:47, Quentin Schulz wrote:
> Hi Naoki,
> 
> On 12/16/24 1:39 PM, FUKAUMI Naoki wrote:
>> Hi Quentin,
>>
>> On 12/16/24 18:57, Quentin Schulz wrote:
>>> Hi Naoki,
>>>
>>> On 12/15/24 2:37 AM, FUKAUMI Naoki wrote:
>>>> Hi Quentin,
>>>>
>>>> Thank you very much for your review!
>>>>
>>>> On 12/13/24 22:11, Quentin Schulz wrote:
>>>>> Hi Naoki,
>>>>>
>>>>> On 12/11/24 4:39 AM, FUKAUMI Naoki wrote:
>>>>>> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>>>>>>
>>>>>> [1] https://eur02.safelinks.protection.outlook.com/? 
>>>>>> url=https%3A%2F%2Fradxa.com%2Fproducts%2Frock5%2F5c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cbe7d810ae88f4203af8208dd1ca921c6%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638698234938145886%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=8TcHBC2dV1LzouPSR8%2FICOBVshq9RndgMQS3m3XLwFs%3D&reserved=0
>>>>>>
>>>>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>>>>> ---
>>>>>> Changes in v3:
>>>>>> - fix compile error
>>>>>> Changes in v2:
>>>>>> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
>>>>>> - include/configs/rock-5-rk3588s.h: fix include order
>>>>>> ---
>>>>>>   arch/arm/dts/rk3588s-rock-5-u-boot.dtsi     | 16 ++++
>>>>>>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi    |  6 ++
>>>>>>   arch/arm/mach-rockchip/rk3588/Kconfig       |  7 ++
>>>>>>   board/radxa/rock-5-rk3588s/Kconfig          | 12 +++
>>>>>>   board/radxa/rock-5-rk3588s/MAINTAINERS      |  8 ++
>>>>>>   board/radxa/rock-5-rk3588s/Makefile         |  3 +
>>>>>>   board/radxa/rock-5-rk3588s/rock-5-rk3588s.c | 77 +++++++++++++++++
>>>>>>   configs/rock-5-rk3588s_defconfig            | 94 +++++++++++++++ 
>>>>>> + + ++++
>>>>>>   doc/board/rockchip/rockchip.rst             |  1 +
>>>>>>   include/configs/rock-5-rk3588s.h            | 15 ++++
>>>>>>   10 files changed, 239 insertions(+)
>>>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/Kconfig
>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/MAINTAINERS
>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/Makefile
>>>>>>   create mode 100644 board/radxa/rock-5-rk3588s/rock-5-rk3588s.c
>>>>>>   create mode 100644 configs/rock-5-rk3588s_defconfig
>>>>>>   create mode 100644 include/configs/rock-5-rk3588s.h
>>>>>>
>>>>>> diff --git a/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi b/arch/arm/ 
>>>>>> dts/ rk3588s-rock-5-u-boot.dtsi
>>>>>> new file mode 100644
>>>>>> index 000000000000..be1a2f9ae7bb
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm/dts/rk3588s-rock-5-u-boot.dtsi
>>>>>> @@ -0,0 +1,16 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>> +/*
>>>>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>>>>> + */
>>>>>> +
>>>>>> +#include "rk3588s-u-boot.dtsi"
>>>>>> +
>>>>>> +&saradc {
>>>>>> +    bootph-pre-ram;
>>>>>> +    vdd-microvolts = <1800000>;
>>>>>> +};
>>>>>> +
>>>>>> +&sdhci {
>>>>>> +    cap-mmc-highspeed;
>>>>>> +    mmc-hs200-1_8v;
>>>>>> +};
>>>>>> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/ 
>>>>>> dts/ rk3588s-rock-5c-u-boot.dtsi
>>>>>> new file mode 100644
>>>>>> index 000000000000..bb1cc9e4a279
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>>>>>> @@ -0,0 +1,6 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>> +/*
>>>>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>>>>> + */
>>>>>> +
>>>>>> +#include "rk3588s-rock-5-u-boot.dtsi"
>>>>>> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/ 
>>>>>> mach- rockchip/rk3588/Kconfig
>>>>>> index b5a0e624a532..e1487ecb0464 100644
>>>>>> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
>>>>>> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
>>>>>> @@ -260,6 +260,12 @@ config TARGET_ROCK_5_ITX_RK3588
>>>>>>         Front-panel connectors for audio and case-power, -leds
>>>>>>         Powered by either 12V, ATX power-supply or PoE
>>>>>> +config TARGET_ROCK_5_RK3588S
>>>>>
>>>>> This should be TARGET_ROCK_5C_RK3588S?
>>>>
>>>> rock-pi-4-rk3399_defconfig uses CONFIG_TARGET_ROCKPI4_RK3399.
>>>> I'm doing same thing.
>>>>
>>>
>>> config TARGET_ROCKPI4_RK3399
>>>     help
>>>       Support for ROCK Pi 4 board family by Radxa.
>>>
>>> Here you say this option is for ROCK 5C only.
>>
>> Because this is first patch which adds support for ROCK 5C.
>>
> 
> That's fine, you could say something like:
> 
> Support for ROCK 5 board family by Radxa.

More accurately, "RK3588S based ROCK 5" for now. I'm not sure both 
RK3588 and RK3588S based boards can be supported.

> Currently supports: ROCK 5C
> 
> And then we can extend this list whenever someone adds support for a new 
> board of that family, which would make it easy to find with a grep if 
> the board is supported and via which target option.
> 
>>> While this could be a good idea, anything odd needs to be justified 
>>> in the commit log so that we can follow your train of thoughts.
>>>
>>> This patch series only adds support for the ROCK 5C so nothing hints 
>>> at this being usable/used for other boards from Radxa. Which boards 
>>> are you planning to support with this option? If the ROCK 5B/ROCK 5 
>>> ITX aren't going to be part of it, why and how do I know which of the 
>>> ROCK 5 is supported by this option?
>>
>> It's possible to add support for ROCK 5A (RK3588S).
>>
> 
> Since it seems you're planning on supporting ROCK 5A with the same 
> target option and we already support ROCK 5A, maybe start this way 
> instead of adding support for ROCK 5C and then migrate ROCK 5A to that?
> 
> i.e. adapt ROCK 5A so that it can be reused for ROCK 5C easily, and then 
> add ROCK 5C using the mechanism you would introduce in the ROCK 5A 
> adaptation commit(s)?
> 
> What do you think?

I just wanted to add ROCK 5C because dts was added in upstream. But it's 
okay to do "Adapt ROCK 5A then add ROCK 5C".

> Is the ROCK 5T going to be supported by that common target, defconfig 
> and board file as well? What are your plans :)?

I'm thinking to add support for 5B+ and 5T too. But for making single 
target, it needs "check SoC variant" code in addition to check "Board 
ID". I guess following code may be used:

  https://patchwork.ozlabs.org/project/uboot/patch/20241110005622.1515100-3-jonas@kwiboo.se/

BTW, unfortunately, Board ID (ADC value) for ROCK 5B is not fixed...

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Cheers,
> Quentin
> 

