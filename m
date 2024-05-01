Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF7DC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 12:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A9888AAF;
	Wed,  1 May 2024 14:17:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="jcasFNrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F51B88AB4; Wed,  1 May 2024 14:17:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B41988AA6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 14:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=373c=MF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1714565832;
 bh=0Ukb82Rfnkm/RfFDpPxi4+HhArDMLQ0CqBT9cbzo/z4=;
 b=jcasFNrhiE2k96u4+6rDw+0YGzBWu67gc1LVCFR4obOUYHGEct0Y214OsJS1HPcNarEzhQLuR
 rzFUJNcBTZU1CcK5PkMqCRGuPyEa/xDylwqn34s6ykFwaz4yUbxj+G4yGeapL1PVyDgJQ0WD/Jy
 +EuNx61WVReM3vrUG442iebQMsfEgXkdH/nj82NBEQfX35oh9YJ2PsRswOd7ORU9zpBCDnaU+ql
 6le5Zd/e1m9N/M0H2/+kflsApvnJlxTEOstaZwe0/MyqrKtxwJJ/Eh6YVoAtUvUAzxSp1eAXwfd
 UtlfxD67T4+rZpz1YA+oy4sCE23DOcD/aDh/HnWF+EWw==
Message-ID: <5d07f93b-1e19-4a86-9afa-23dc3ef667ce@kwiboo.se>
Date: Wed, 1 May 2024 14:06:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/31] rockchip: rk3399: Sync soc device tree from linux
 v6.8
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-16-jonas@kwiboo.se>
 <e146aa22-425a-4aaa-9a64-772ec00d5d7f@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e146aa22-425a-4aaa-9a64-772ec00d5d7f@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66323053ab9e3c23aeb90423
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

On 2024-04-02 17:02, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/31/24 22:28, Jonas Karlman wrote:
>> Sync RK3399 SoC common .dtsi-files from linux v6.8.
>>
>> The ethernet0 alias is removed from rk3399.dtsi in this patch, it will
>> be restored in board specific .dts-files. There is no other intended
> 
> Please add ethernet0 alias to rk3399-u-boot.dtsi and remove it in the 
> patch that moves it to board-specific dts files so that this is not a 
> breaking change and we can bisect through this patch if we need to :)

Agree, will add ethernet0 alias to rk3399-u-boot.dtsi in v2. And then
drop it in a patch after all board files have been updated to v6.8.

> 
>> change with this patch.
>>
> 
> Could you please mention that rng node is named crypto1 in Linux DT? The 
> diff here was a bit surprising since rng node is entirely removed.

Agree, will include a note about it in v2.

> 
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3399-op1-opp.dtsi              |  31 +-
>>   arch/arm/dts/rk3399-opp.dtsi                  |   6 +-
>>   arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi |   4 -
>>   arch/arm/dts/rk3399-u-boot.dtsi               |  52 ++--
>>   arch/arm/dts/rk3399.dtsi                      | 289 ++++++++++++++++--
>>   5 files changed, 308 insertions(+), 74 deletions(-)
>>
>> diff --git a/arch/arm/dts/rk3399-op1-opp.dtsi b/arch/arm/dts/rk3399-op1-opp.dtsi
>> index 69cc9b05baa5..783120e9cebe 100644
>> --- a/arch/arm/dts/rk3399-op1-opp.dtsi
>> +++ b/arch/arm/dts/rk3399-op1-opp.dtsi
>> @@ -4,7 +4,7 @@
>>    */
>>   
>>   / {
>> -	cluster0_opp: opp-table0 {
>> +	cluster0_opp: opp-table-0 {
>>   		compatible = "operating-points-v2";
>>   		opp-shared;
>>   
>> @@ -39,7 +39,7 @@
>>   		};
>>   	};
>>   
>> -	cluster1_opp: opp-table1 {
>> +	cluster1_opp: opp-table-1 {
>>   		compatible = "operating-points-v2";
>>   		opp-shared;
>>   
>> @@ -82,7 +82,7 @@
>>   		};
>>   	};
>>   
>> -	gpu_opp_table: opp-table2 {
>> +	gpu_opp_table: opp-table-2 {
>>   		compatible = "operating-points-v2";
>>   
>>   		opp00 {
>> @@ -110,6 +110,27 @@
>>   			opp-microvolt = <1075000>;
>>   		};
>>   	};
>> +
>> +	dmc_opp_table: opp-table-3 {
>> +		compatible = "operating-points-v2";
>> +
>> +		opp00 {
>> +			opp-hz = /bits/ 64 <400000000>;
>> +			opp-microvolt = <900000>;
>> +		};
>> +		opp01 {
>> +			opp-hz = /bits/ 64 <666000000>;
>> +			opp-microvolt = <900000>;
>> +		};
>> +		opp02 {
>> +			opp-hz = /bits/ 64 <800000000>;
>> +			opp-microvolt = <900000>;
>> +		};
>> +		opp03 {
>> +			opp-hz = /bits/ 64 <928000000>;
>> +			opp-microvolt = <925000>;
>> +		};
>> +	};
>>   };
>>   
>>   &cpu_l0 {
>> @@ -136,6 +157,10 @@
>>   	operating-points-v2 = <&cluster1_opp>;
>>   };
>>   
>> +&dmc {
>> +	operating-points-v2 = <&dmc_opp_table>;
>> +};
>> +
>>   &gpu {
>>   	operating-points-v2 = <&gpu_opp_table>;
>>   };
>> diff --git a/arch/arm/dts/rk3399-opp.dtsi b/arch/arm/dts/rk3399-opp.dtsi
>> index da41cd81ebb7..fee5e7111279 100644
>> --- a/arch/arm/dts/rk3399-opp.dtsi
>> +++ b/arch/arm/dts/rk3399-opp.dtsi
>> @@ -4,7 +4,7 @@
>>    */
>>   
>>   / {
>> -	cluster0_opp: opp-table0 {
>> +	cluster0_opp: opp-table-0 {
>>   		compatible = "operating-points-v2";
>>   		opp-shared;
>>   
>> @@ -35,7 +35,7 @@
>>   		};
>>   	};
>>   
>> -	cluster1_opp: opp-table1 {
>> +	cluster1_opp: opp-table-1 {
>>   		compatible = "operating-points-v2";
>>   		opp-shared;
>>   
>> @@ -74,7 +74,7 @@
>>   		};
>>   	};
>>   
>> -	gpu_opp_table: opp-table2 {
>> +	gpu_opp_table: opp-table-2 {
>>   		compatible = "operating-points-v2";
>>   
>>   		opp00 {
>> diff --git a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
>> index b8f95b86d86b..dcfcec4f3072 100644
>> --- a/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-pinephone-pro-u-boot.dtsi
>> @@ -6,10 +6,6 @@
>>   #include "rk3399-u-boot.dtsi"
>>   #include "rk3399-sdram-lpddr4-100.dtsi"
>>   
>> -&rng {
>> -	status = "okay";
>> -};
>> -
>>   &sdhci {
>>   	max-frequency = <25000000>;
>>   };
>> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
>> index adb64d17e040..d2648abd0a44 100644
>> --- a/arch/arm/dts/rk3399-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
>> @@ -2,8 +2,6 @@
>>   /*
>>    * Copyright (C) 2019 Jagan Teki <jagan@amarulasolutions.com>
>>    */
>> -#define USB_CLASS_HUB			9
>> -
>>   #include "rockchip-u-boot.dtsi"
>>   
>>   / {
>> @@ -24,44 +22,11 @@
>>   		reg = <0x0 0xff620000 0x0 0x100>;
>>   	};
>>   
>> -	dfi: dfi@ff630000 {
>> -		bootph-all;
>> -		reg = <0x00 0xff630000 0x00 0x4000>;
>> -		compatible = "rockchip,rk3399-dfi";
>> -		rockchip,pmu = <&pmugrf>;
>> -		clocks = <&cru PCLK_DDR_MON>;
>> -		clock-names = "pclk_ddr_mon";
>> -	};
>> -
>> -	rng: rng@ff8b8000 {
>> -		compatible = "rockchip,rk3399-crypto";
>> -		reg = <0x0 0xff8b8000 0x0 0x1000>;
>> -		status = "okay";
>> -	};
>> -
>> -	dmc: dmc {
>> -		bootph-all;
>> -		compatible = "rockchip,rk3399-dmc";
>> -		devfreq-events = <&dfi>;
>> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH 0>;
>> -		clocks = <&cru SCLK_DDRC>;
>> -		clock-names = "dmc_clk";
>> -		reg = <0x0 0xffa80000 0x0 0x0800
>> -		       0x0 0xffa80800 0x0 0x1800
>> -		       0x0 0xffa82000 0x0 0x2000
>> -		       0x0 0xffa84000 0x0 0x1000
>> -		       0x0 0xffa88000 0x0 0x0800
>> -		       0x0 0xffa88800 0x0 0x1800
>> -		       0x0 0xffa8a000 0x0 0x2000
>> -		       0x0 0xffa8c000 0x0 0x1000>;
>> -	};
>> -
>>   	pmusgrf: syscon@ff330000 {
>>   		bootph-all;
> 
> I have my doubts the PMU SGRF is accessible from U-Boot proper if TF-A 
> loads it into normal world. Maybe this should rather be 
> bootph-pre-sram+bootph-pre-ram?

That is probably true, and as you mention below, nothing I will address
in this series :-)

> 
> Nothing to fix in this series though.
> 
>>   		compatible = "rockchip,rk3399-pmusgrf", "syscon";
>>   		reg = <0x0 0xff330000 0x0 0xe3d4>;
>>   	};
>> -
>>   };
>>   
>>   #if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
>> @@ -93,6 +58,19 @@
>>   	bootph-all;
>>   };
>>   
>> +&dmc {
>> +	bootph-all;
>> +	reg = <0x0 0xffa80000 0x0 0x0800
>> +	       0x0 0xffa80800 0x0 0x1800
>> +	       0x0 0xffa82000 0x0 0x2000
>> +	       0x0 0xffa84000 0x0 0x1000
>> +	       0x0 0xffa88000 0x0 0x0800
>> +	       0x0 0xffa88800 0x0 0x1800
>> +	       0x0 0xffa8a000 0x0 0x2000
>> +	       0x0 0xffa8c000 0x0 0x1000>;
>> +	status = "okay";
>> +};
>> +
> 
> Missing bootph-all for dfi?

Thanks, will restore/include in v2.

I do not think the dfi node is really required at TPL/SPL phase, but
lets care about boot/size optimization in a future series :-)

Regards,
Jonas

> 
> [...]
> 
> Cheers,
> Quentin

