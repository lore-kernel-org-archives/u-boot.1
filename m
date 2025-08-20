Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2A4CA0EE6
	for <u-boot@archiver.kernel.org>; Wed, 20 Aug 2025 02:45:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FA2801DD;
	Wed, 20 Aug 2025 04:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE0F802C1; Wed, 20 Aug 2025 04:45:04 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF96780107
 for <u-boot@lists.denx.de>; Wed, 20 Aug 2025 04:45:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.63.12]) (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 2A48EB4E0001;
 Wed, 20 Aug 2025 04:44:58 +0200 (CEST)
Message-ID: <84cd3c89-5f82-468c-a63f-9815909ad110@freeshell.de>
Date: Tue, 19 Aug 2025 19:44:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] riscv: dts: starfive: prune redundant jh7110-common
 overrides
To: Hal Feng <hal.feng@starfivetech.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250815050315.62956-1-e@freeshell.de>
 <ZQ2PR01MB1307043F4B7527EA41FF1754E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307043F4B7527EA41FF1754E6312@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
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


On 8/17/25 23:45, Hal Feng wrote:
>> On 15.08.25 13:03, E Shattow wrote: 
>> Prune jh7110-common-u-boot.dtsi (clocks, qspi flash, eeprom, and bootph-
>> pre-ram hints now upstream since devicetree-rebasing v6.16) and replace by
>> remaining dependency jh7110-u-boot.dtsi (not yet upstream).
>>
>> Signed-off-by: E Shattow <e@freeshell.de>
>> ---
>>  arch/riscv/dts/jh7110-common-u-boot.dtsi      | 99 -------------------
>>  .../jh7110-deepcomputing-fml13v01-u-boot.dtsi |  2 +-
>> arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  2 +-
>>  .../dts/jh7110-pine64-star64-u-boot.dtsi      |  2 +-
>>  ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |  2 +-  ...10-starfive-visionfive-
>> 2-v1.3b-u-boot.dtsi |  2 +-
>>  6 files changed, 5 insertions(+), 104 deletions(-)  delete mode 100644
>> arch/riscv/dts/jh7110-common-u-boot.dtsi
>>
>> diff --git a/arch/riscv/dts/jh7110-common-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-common-u-boot.dtsi
>> deleted file mode 100644
>> index 049b0a7ce28..00000000000
>> --- a/arch/riscv/dts/jh7110-common-u-boot.dtsi
>> +++ /dev/null
>> @@ -1,99 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0 OR MIT
>> -/*
>> - * Copyright (C) 2023 StarFive Technology Co., Ltd.
>> - */
>> -
>> -#include "jh7110-u-boot.dtsi"
>> -/ {
>> -	aliases {
>> -		spi0 = &qspi;
>> -	};
>> -
>> -	chosen {
>> -		bootph-pre-ram;
>> -	};
>> -
>> -	firmware {
>> -		spi0 = &qspi;
>> -		bootph-pre-ram;
>> -	};
>> -
>> -	memory@40000000 {
>> -		bootph-pre-ram;
>> -	};
>> -};
>> -
>> -&uart0 {
>> -	bootph-pre-ram;
>> -	reg-offset = <0>;
>> -	current-speed = <115200>;
>> -};
>> -
>> -&mmc0 {
>> -	bootph-pre-ram;
>> -};
>> -
>> -&mmc1 {
>> -	bootph-pre-ram;
>> -};
>> -
>> -&qspi {
>> -	bootph-pre-ram;
>> -
>> -	flash@0 {
>> -		bootph-pre-ram;
>> -		cdns,read-delay = <2>;
>> -		spi-max-frequency = <100000000>;
>> -	};
>> -};
>> -
>> -&syscrg {
>> -	assigned-clocks = <&syscrg JH7110_SYSCLK_CPU_ROOT>,
>> -			  <&syscrg JH7110_SYSCLK_BUS_ROOT>,
>> -			  <&syscrg JH7110_SYSCLK_PERH_ROOT>,
>> -			  <&syscrg JH7110_SYSCLK_QSPI_REF>;
>> -	assigned-clock-parents = <&pllclk JH7110_PLLCLK_PLL0_OUT>,
>> -				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
>> -				 <&pllclk JH7110_PLLCLK_PLL2_OUT>,
>> -				 <&syscrg JH7110_SYSCLK_QSPI_REF_SRC>;
>> -	assigned-clock-rates = <0>, <0>, <0>, <0>;
>> -};
>> -
>> -&sysgpio {
>> -	bootph-pre-ram;
>> -};
>> -
>> -&mmc0_pins {
>> -	bootph-pre-ram;
>> -	rst-pins {
>> -		bootph-pre-ram;
>> -	};
>> -};
>> -
>> -&mmc1_pins {
>> -	bootph-pre-ram;
>> -	clk-pins {
>> -		bootph-pre-ram;
>> -	};
>> -
>> -	mmc-pins {
>> -		bootph-pre-ram;
>> -	};
>> -};
>> -
>> -&i2c5_pins {
>> -	bootph-pre-ram;
>> -	i2c-pins {
>> -		bootph-pre-ram;
>> -	};
>> -};
>> -
>> -&i2c5 {
>> -	bootph-pre-ram;
>> -	eeprom@50 {
>> -		bootph-pre-ram;
>> -		compatible = "atmel,24c04";
>> -		reg = <0x50>;
>> -		pagesize = <16>;
>> -	};
>> -};
>> diff --git a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>> index ab882d07f6f..b9202f2acce 100644
>> --- a/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-deepcomputing-fml13v01-u-boot.dtsi
>> @@ -3,5 +3,5 @@
>>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>>   */
>>
>> -#include "jh7110-common-u-boot.dtsi"
>> +#include "jh7110-u-boot.dtsi"
>>  #include "starfive-visionfive2-binman.dtsi"
>> diff --git a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>> index ab882d07f6f..b9202f2acce 100644
>> --- a/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
>> @@ -3,5 +3,5 @@
>>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>>   */
>>
>> -#include "jh7110-common-u-boot.dtsi"
>> +#include "jh7110-u-boot.dtsi"
>>  #include "starfive-visionfive2-binman.dtsi"
>> diff --git a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>> index ab882d07f6f..b9202f2acce 100644
>> --- a/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
>> @@ -3,5 +3,5 @@
>>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>>   */
>>
>> -#include "jh7110-common-u-boot.dtsi"
>> +#include "jh7110-u-boot.dtsi"
>>  #include "starfive-visionfive2-binman.dtsi"
>> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>> index ab882d07f6f..b9202f2acce 100644
>> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
>> @@ -3,5 +3,5 @@
>>   * Copyright (C) 2024 StarFive Technology Co., Ltd.
>>   */
>>
>> -#include "jh7110-common-u-boot.dtsi"
>> +#include "jh7110-u-boot.dtsi"
>>  #include "starfive-visionfive2-binman.dtsi"
>> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>> b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>> index 874074174ff..848ed8225ac 100644
>> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
>> @@ -3,5 +3,5 @@
>>   * Copyright (C) 2023 StarFive Technology Co., Ltd.
>>   */
>>
>> -#include "jh7110-common-u-boot.dtsi"
>> +#include "jh7110-u-boot.dtsi"
>>  #include "starfive-visionfive2-binman.dtsi"
>>
>> base-commit: 0c558bbad9e7581808b358091d1fd979f860e8ac
> 
> I find that there are no ''bootph-pre-ram'' in mmc0_pins and mmc1_pins in
> dts/upstream/src/riscv/starfive/jh7110-common.dtsi.
> 
> Is it ready now to drop jh7110-common-u-boot.dtsi?
> 
> Best regards,
> Hal

Yes, thank you for your review.

Currently the U-Boot SPL code path that requires eMMC and SD Card
functionality is with these deprecated JH7110 loader modes, or some
unlikely runtime change in RGPIO0 / RGPIO1 state before U-Boot SPL
following the JH7110 loader.

I will consider seriously to support the deprecated functionality if
there is sufficient documentation in the form of a full source code
listing for the JH7110 mask ROM loader. Otherwise I do not have time or
interest to reverse-engineer these things lacking in documentation from
StarFive.

-E
