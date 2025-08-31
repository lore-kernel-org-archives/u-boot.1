Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 231CECA0FE8
	for <u-boot@archiver.kernel.org>; Sun, 31 Aug 2025 16:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48ED9833AD;
	Sun, 31 Aug 2025 18:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="o1I9Eoq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7286B83447; Sun, 31 Aug 2025 18:17:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C1D82FC7
 for <u-boot@lists.denx.de>; Sun, 31 Aug 2025 18:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=b2fe=3M=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1756657063;
 bh=2VKpYV5AoHA/PQ9laB35T4eRmNITMxy43RRFYVS5ZW4=;
 b=o1I9Eoq+6qZJxzgIn3fw04fFznnGrYfu7n+kj6iH878jMzBGsQf/BjzRhcAX3RxlPUMdqrM1w
 u5zDXONEak63WF7qd8xISKKuAIQb6ND5LKpLM3JfqIg/bKqxYnvUKHH77nCQPP1FElE2MCsL4xh
 HYRvKuVbmNKsat3dEz/ZGuZYlIjSIeraGfBDFZtJ8ycVpbNepQ2OqhqnrFP2YroxDvXmzVhKzyl
 Yci7OwWf4BXEiDXUnnnn0iz3TlFhAGMQIvt+K+rQ851vDnZdMjIrjDqBcmJiEoJ8pamtpAqNBJq
 cVPRtrV4sehMDpUNuN7YM+XADgILQVxrb/9xgFdKk+4A==
X-Forward-Email-ID: 68b475a17f68b507ca9c2f23
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.11
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5e0bff5d-b5f9-4772-9859-b6f3d899c47a@kwiboo.se>
Date: Sun, 31 Aug 2025 18:17:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] rockchip: odroid-go2: Include pinctrl for sdmmc,
 sfc and uart in SPL
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-9-jonas@kwiboo.se>
 <16931794-9556-476d-9143-f396e4e7c678@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <16931794-9556-476d-9143-f396e4e7c678@rock-chips.com>
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

On 8/31/2025 10:46 AM, Kever Yang wrote:
> Hi Jonas,
> 
> On 2025/7/14 07:33, Jonas Karlman wrote:
>> Include pinctrl nodes and props for sdmmc, sfc and uart in SPL to ensure
>> pins are configured according to the device tree.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 10 ++++
>>   arch/arm/dts/rk3326-u-boot.dtsi            | 58 ++++++++++++++++++++++
>>   configs/odroid-go2_defconfig               |  2 +-
> 
> 
> In this Series, you update the dtsi and defconfig.
> 
> For board level dtsi update with the board defconfig, it's OK to go 
> together for me,
> 
> but for soc level dtsi, it would be better not go with defconfig because 
> it may affect other boards.

In normal circumstances with an existing soc u-boot.dtsi I fully agree
on such split.

The soc rk3326-u-boot.dtsi is added/extracted from the rk3326-odroid-go2
-u-boot.dtsi as part of this series, so there is no other board that can
be affected by changes in soc rk3326-u-boot.dtsi.

Because of this I have tried to keep all related changes together in
single patches to make it easier to review. I have also runtime tested
each step in this series to ensure bisect-ability.

> 
> You can update dtsi first, and then update/cleanup the board level 
> defconfig with correct commit message.
> 

I truly fail to see any benefit of this because of above, so I will
chose to ignore this request in v2, and will only address the remark
from Quentin on the patch "rockchip: odroid-go2: Remove u-boot.dtsi
props already defined".

Regards,
Jonas

> 
> Thanks,
> 
> - Kever
> 
>>   3 files changed, 69 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
>> index 06e2c190b1f9..6f40654d5e84 100644
>> --- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
>> @@ -35,3 +35,13 @@
>>   	bootph-all;
>>   	clock-frequency = <24000000>;
>>   };
>> +
>> +&uart1_cts {
>> +	bootph-pre-sram;
>> +	bootph-pre-ram;
>> +};
>> +
>> +&uart1_xfer {
>> +	bootph-pre-sram;
>> +	bootph-pre-ram;
>> +};
>> diff --git a/arch/arm/dts/rk3326-u-boot.dtsi b/arch/arm/dts/rk3326-u-boot.dtsi
>> index 2894133cfe6d..196604a9987c 100644
>> --- a/arch/arm/dts/rk3326-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3326-u-boot.dtsi
>> @@ -46,6 +46,24 @@
>>   	bootph-all;
>>   };
>>   
>> +&pcfg_pull_none {
>> +	bootph-all;
>> +};
>> +
>> +&pcfg_pull_none_8ma {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&pcfg_pull_up {
>> +	bootph-all;
>> +};
>> +
>> +&pcfg_pull_up_8ma {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>>   &pmucru {
>>   	bootph-all;
>>   };
>> @@ -62,15 +80,55 @@
>>   	u-boot,spl-fifo-mode;
>>   };
>>   
>> +&sdmmc_bus4 {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&sdmmc_clk {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&sdmmc_cmd {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&sdmmc_det {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>>   &sfc {
>>   	bootph-some-ram;
>>   };
>>   
>> +&sfc_bus2 {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&sfc_clk {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&sfc_cs0 {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>>   &uart2 {
>>   	bootph-all;
>>   	clock-frequency = <24000000>;
>>   };
>>   
>> +&uart2m1_xfer {
>> +	bootph-pre-sram;
>> +	bootph-pre-ram;
>> +};
>> +
>>   &xin24m {
>>   	bootph-all;
>>   };
>> diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
>> index 6bc0d12440c9..b0947fe2c8b2 100644
>> --- a/configs/odroid-go2_defconfig
>> +++ b/configs/odroid-go2_defconfig
>> @@ -51,7 +51,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>>   CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
>>   CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_OF_LIVE=y
>> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_OF_SPL_REMOVE_PROPS="interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>   CONFIG_ENV_IS_IN_MMC=y
>>   CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_REGMAP=y

