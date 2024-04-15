Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FEFC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:40:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D9D787C82;
	Mon, 15 Apr 2024 14:40:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="j6wCJ/ut";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F5287B82; Mon, 15 Apr 2024 14:40:32 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60F187C82
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 14:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=123a=LV=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1713184814;
 bh=TL4u1qDxtUZCqYz7OmQB5uj3jsicv9aOfxyUzK7lXtY=;
 b=j6wCJ/utf9aJWdxaEv8y3XMJ8hdBhMD7IMmB7wWfy3duJgpMFYcsgAlyemCPbsu0bmNb5Togq
 kr+gnFoHit4auMgpxo+PAzIU9lvsErx5/MpdaRu+6uJmpZ74sejoPVx6lzkiRAsqkcXQ6kCMSyQ
 +2s3AsFtQ2Xu/WRU/ykf91LjJc4Pc+FW32A8XzE2MdLNvxXzRHfErPlRJO9P9HOhUeFtlWSvaw1
 43ekn1f0kvFLw0z5KefV1Zl2FeL4OKznjY5toU5OYUDKSIzofEiBcRG9X1Ng7gn7BWE5gJtToo8
 +suobb+vXMNcVdHm8UryfLsVa2MlU3smg2ETKkx3dliA==
Message-ID: <39998d20-45f8-44f2-a50b-31dadd9fb387@kwiboo.se>
Date: Mon, 15 Apr 2024 14:40:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/23] rockchip: rk3588: Update bootph props
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Andy Yan <andyshrk@163.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, John Clark <inindev@gmail.com>, Eugen
 Hristev <eugen.hristev@collabora.com>, Joshua Riek <jjriek@verizon.net>,
 u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-13-jonas@kwiboo.se>
 <7a662cf8-a75f-4202-8cbc-851afe22d093@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <7a662cf8-a75f-4202-8cbc-851afe22d093@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 661d202d394cb9e911dff83c
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

On 2024-04-15 10:55, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 4/13/24 20:13, Jonas Karlman wrote:
>> After the commit aca95282c1b7 ("Makefile: Use the fdtgrep -u flag")
>> bootph props is propagating to parent nodes.
>>
>> Update bootph props to ensure eMMC, SD-card and SPI flash is available
>> in SPL and U-Boot proper pre-reloc phase also remove unneeded bootph
>> props that automatically is propagated to parent nodes.
>>
>> Also adjust pinctrl nodes to only be included in boot phases where they
>> are needed and add any missing pinctrl node needed in SPL.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: Add bootph-some-ram props and follow kernel sort order
>>
>> Following bootph props have been applied:
>>
>> CRU, GRF and UART nodes:
>> - bootph-all - needed at all or most stages
>>
>> SD-card regulator related nodes:
>> - bootph-pre-ram (SPL) - regulator pinctrl may be needed to read FIT
>>    from SD-card on some boards
>>
>> eMMC/SD-card/SPI flash related nodes:
>> - bootph-pre-ram (SPL)
>> - bootph-some-ram (U-Boot proper pre-reloc)
>> ---
>>   .../arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi |  8 +--
>>   arch/arm/dts/rk3588-generic.dts               |  1 +
>>   arch/arm/dts/rk3588-nanopc-t6-u-boot.dtsi     | 12 ++---
>>   .../dts/rk3588-orangepi-5-plus-u-boot.dtsi    |  7 ++-
>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi       |  8 +--
>>   arch/arm/dts/rk3588-turing-rk1-u-boot.dtsi    |  6 ++-
>>   arch/arm/dts/rk3588s-coolpi-4b-u-boot.dtsi    |  8 +--
>>   arch/arm/dts/rk3588s-orangepi-5-u-boot.dtsi   |  9 ++--
>>   arch/arm/dts/rk3588s-u-boot.dtsi              | 50 ++++++++++++++-----
>>   configs/evb-rk3588_defconfig                  |  4 +-
>>   10 files changed, 71 insertions(+), 42 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
>> index ed15b14ea0ee..f0ef0164664e 100644
>> --- a/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3588-coolpi-cm5-evb-u-boot.dtsi
>> @@ -3,7 +3,8 @@
>>   #include "rk3588-u-boot.dtsi"
>>   
>>   &fspim2_pins {
>> -	bootph-all;
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>>   };
>>   
>>   &sdhci {
>> @@ -12,16 +13,15 @@
>>   };
>>   
>>   &sfc {
>> -	bootph-pre-ram;
>> -	u-boot,spl-sfc-no-dma;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&fspim2_pins>;
>>   	status = "okay";
>>   
>>   	flash@0 {
>> -		bootph-pre-ram;
>>   		compatible = "jedec,spi-nor";
>>   		reg = <0>;
>> +		bootph-pre-ram;
>> +		bootph-some-ram;
>>   		spi-max-frequency = <24000000>;
>>   		spi-rx-bus-width = <4>;
>>   		spi-tx-bus-width = <1>;
>> diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
>> index e4721d97a87d..baafe7463f1b 100644
>> --- a/arch/arm/dts/rk3588-generic.dts
>> +++ b/arch/arm/dts/rk3588-generic.dts
>> @@ -40,5 +40,6 @@
>>   };
>>   
>>   &uart2 {
>> +	pinctrl-0 = <&uart2m0_xfer>;
> 
> I think this should be its own patch.

Sure, will move this to its own patch in v3.

> 
> [...]
>> diff --git a/configs/evb-rk3588_defconfig b/configs/evb-rk3588_defconfig
>> index 68ecbc54b807..610a8d740fbb 100644
>> --- a/configs/evb-rk3588_defconfig
>> +++ b/configs/evb-rk3588_defconfig
>> @@ -33,7 +33,8 @@ CONFIG_CMD_REGULATOR=y
>>   # CONFIG_SPL_DOS_PARTITION is not set
>>   CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_OF_LIVE=y
>> -CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>   CONFIG_SPL_REGMAP=y
>>   CONFIG_SPL_SYSCON=y
>>   CONFIG_SPL_CLK=y
>> @@ -52,6 +53,7 @@ CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>>   CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>>   CONFIG_PHY_ROCKCHIP_USBDP=y
>> +CONFIG_SPL_PINCTRL=y
> 
> I have a feeling the changes to the defconfig aren't entirely related to 
> this patch? Specifically, I think at least CONFIG_SPL_DM_SEQ_ALIAS isn't 
> related?

My original intent of this entire series was to fix/align bootph props
and pinctrl use across boards, but after more and more testing it has
grown a little bit out of control ;-)

For proper handling in SPL we also need the SPL_DM_SEQ_ALIAS enabled.

In the future I would like to see a ROCKCHIP_COMMON_OPTIONS or similar
that imply all these common options, for now this and my other series
just tries to get more boards to using all these common options.

Will split out to a evb specific patch in v3.

Regards,
Jonas

> 
> Otherwise,
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> Thanks,
> Quentin

