Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B8CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 21:38:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131AA83013;
	Mon, 11 Aug 2025 23:38:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fJm1K8a4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C1D183211; Mon, 11 Aug 2025 23:38:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A76831D8
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cf87=2Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754948296;
 bh=mZnvzpgthaSVV9noz7kAAyJ3xs2dRO957F0mrXaJseI=;
 b=fJm1K8a4td7/NoxhtwYn5wYYUNm7aoF3ngNHD/5pnWjfEUYnDXZXQp4L5DKeZzuHlokE98YvO
 23vVIyBoTMgbAPj0FWB3lNg2L5YYl0trTd/kbDbIlxOdgTqNXmXSHvQBFxo4AcTNSGaK8DqaN/z
 awcS01YVRrYs6JrYw0VoZ0zpK0Hqy5c9FupsKBi8mnXu19eZXj6yIi9ksWGh0VjgSOBRHkbvNpq
 dUTQBdgQctjGUWl8cReuefvjihIu65s/sKkc/ymmiu+3OGzD6GUNPx0tkz0a39pg23SyaL9Z3b3
 XGWDJN+9295OQnvSNWh+FlZjyb98S67FuHNwpEIZboUw==
X-Forward-Email-ID: 689a6282de615f3104e07448
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <f4771c75-ce06-4ce4-87a1-fed7ee143dc5@kwiboo.se>
Date: Mon, 11 Aug 2025 23:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] rockchip: rk3576: Add SPI Flash boot support
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250801210619.2618622-1-jonas@kwiboo.se>
 <20250801210619.2618622-4-jonas@kwiboo.se>
 <ae2e5a9c-ce3c-48db-ad6b-1ce4033e3816@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <ae2e5a9c-ce3c-48db-ad6b-1ce4033e3816@cherry.de>
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

Hi Quentin,

On 8/11/2025 11:49 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/1/25 11:06 PM, Jonas Karlman wrote:
>> The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
>> differs slightly compared to prior SoCs:
>>
>> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
>> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
>> - Booting from sfc1 M0 has not been tested (no board using this config).
> 
> I would refrain from adding partial support for it then.

Sure, I will remove anything related to sfc1 M0 in v3.

> 
>> - Booting from USB report a new bootsource id 0x81.
>>
>> Add a RK3576 specific read_brom_bootsource_id() function to help decode
>> the new bootsource id values and the required boot_devices mapping of
>> sfc0 and sfc1 to help support booting from SPI flash on RK3576.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: No change
>> ---
>>   arch/arm/dts/rk3576-u-boot.dtsi        | 36 ++++++++++++++++++++++++++
>>   arch/arm/mach-rockchip/rk3576/rk3576.c | 23 ++++++++++++++++
>>   2 files changed, 59 insertions(+)
>>
>> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
>> index fb5a107f47d9..c7ed09e03eec 100644
>> --- a/arch/arm/dts/rk3576-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
>> @@ -6,6 +6,11 @@
>>   #include "rockchip-u-boot.dtsi"
>>   
>>   / {
>> +	aliases {
>> +		spi5 = &sfc0;
>> +		spi6 = &sfc1;
>> +	};
>> +
>>   	chosen {
>>   		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>>   	};
>> @@ -16,6 +21,17 @@
>>   	};
>>   };
>>   
>> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
>> +&binman {
>> +	simple-bin-spi {
>> +		mkimage {
>> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
>> +			offset = <0x8000>;
>> +		};
>> +	};
>> +};
>> +#endif
>> +
>>   &cru {
>>   	bootph-all;
>>   };
>> @@ -45,6 +61,16 @@
>>   	bootph-some-ram;
>>   };
>>   
>> +&fspi0_csn0 {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>> +&fspi0_pins {
>> +	bootph-pre-ram;
>> +	bootph-some-ram;
>> +};
>> +
>>   &ioc_grf {
>>   	bootph-all;
>>   };
>> @@ -116,6 +142,16 @@
>>   	bootph-some-ram;
>>   };
>>   
>> +&sfc0 {
>> +	bootph-some-ram;
>> +	u-boot,spl-sfc-no-dma;
>> +};
>> +
>> +&sfc1 {
>> +	bootph-some-ram;
>> +	u-boot,spl-sfc-no-dma;
>> +};
>> +
>>   &sys_grf {
>>   	bootph-all;
>>   };
>> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
>> index a6c2fbdc4840..3d5bdeeeb846 100644
>> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
>> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
>> @@ -36,8 +36,17 @@
>>   #define USB_GRF_BASE		0x2601E000
>>   #define USB3OTG0_CON1		0x0030
>>   
>> +enum {
>> +	BROM_BOOTSOURCE_FSPI0 = 3,
>> +	BROM_BOOTSOURCE_FSPI1_M0 = 4,
>> +	BROM_BOOTSOURCE_FSPI1_M1 = 6,
>> +};
>> +
>>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>>   	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
>> +	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
>> +	[BROM_BOOTSOURCE_FSPI1_M0] = "/soc/spi@2a300000/flash@0",
> 
> This in addition to BROM_BOOTSOURCE_FSPI1_M0 in the enum may mislead the 
> user into believing it is supported whereas we most likely need to do 
> another mapping in read_brom_bootsource_id() below, so I would just not 
> add either to this patch.

You are correct, this will most likely not work as-is, I re-used the SPI
NAND value for fspi1 M0, as it may not be used for anything. 6 is the
only unused/unknown value, 7 is used for UFS as indicated by vendor tree.

Will drop FSPI1_M0 from v3.

> 
>> +	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
>>   	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
>>   };
>>   
>> @@ -85,6 +94,20 @@ void board_debug_uart_init(void)
>>   {
>>   }
>>   
>> +u32 read_brom_bootsource_id(void)
>> +{
>> +	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
>> +
>> +	if (bootsource_id == 0x23)
>> +		return BROM_BOOTSOURCE_FSPI1_M1;
>> +	else if (bootsource_id == 0x81)
>> +		return BROM_BOOTSOURCE_USB;
> 
> I believe this differs from what we've done for all other SoCs where we 
> have an entry at the offset bootsource_id in the boot_devices array.
> 
> On RK3588 it seems we're doing something similar of defining new 
> BROM_BOOTSOURCE_ values in another enum and using them in the 
> boot_devices array as indices. However, it seems we're using them 
> verbatim instead of doing the mapping like we do here in rk3576.c. The 
> only reason I could think of that is that 0x81 would create a pretty big 
> array for no specific reason. Considering we already have an entry for 
> the exact same scenario with a different number, I feel like it's fair 
> to do the mapping.
> 
> It would be nice at least to provide some information on why it's done 
> this way since it differs from what we've done until now. Especially 
> that the enum doesn't match the raw value from the register anymore.

Yes, the table size was the only reason for using a different type
re-mapping here, for rk3588 the actual raw values changed meaning so
using a new enum worked fine. For rk3576 the values changes completely,
and vendor U-Boot does not give any hint, so re-mapping known values
seem least intrusive until more details are uncovered.

I will add comment about reson for re-mapping in v3.

Maybe @Kever have some insights in how boot source id is encoded by the
boot-rom for rk3576?

Regards,
Jonas

> 
> Cheers,
> Quentin

