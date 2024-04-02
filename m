Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E8DCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E4A8810E;
	Tue,  2 Apr 2024 15:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pdtG90cS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C155B88123; Tue,  2 Apr 2024 15:01:06 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92C8687EB4
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=d8ab=LI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1712062822;
 bh=/Z+cTId5UPMMJy8CSRXUHUm33ADQZpa+kNGUoPE0pho=;
 b=pdtG90cSWFaCE/OETEnwshajGxmdN00ulG6dm6FGi08pB9zzBp0q6DYk4LQ4RRemXkphJeeG0
 KrjRx72fOHukkf+/C1P17si+IUAXKiq0MgnjYwIeZw8wh+57hkRcaa1UU8ikbxAgwI1xIlP3UIF
 s9Dg43qBYgVTl+nRzz8YsaNtYNopITYuTm1FyemvTvwa1ydPncRXwLSvt6I92Uk02HEvusdceXD
 692Dm+dxy1LFv/r3VHKAOqBGBSMy96glJkWc97u7oq6E+mhv2Wcraa1hs7CtC74WjzVSmS0LB8z
 vhShpmaymbLrRV+UaXYSKXxnA4fIeezhPPE+nv8xrIDg==
Message-ID: <021954a9-0047-4c7c-8cbc-734dd85014bd@kwiboo.se>
Date: Tue, 2 Apr 2024 14:37:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] rockchip: rk356x-generic: Add support for SPI flash
 and USB OTG
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-19-jonas@kwiboo.se>
 <d10bd351-5005-427f-bc41-ebe547e5bda6@theobroma-systems.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d10bd351-5005-427f-bc41-ebe547e5bda6@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 660bfbff2c47d571a6f1244c
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

On 2024-04-02 12:38, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 3/29/24 20:01, Jonas Karlman wrote:
>> Extend the Generic RK3566/RK3568 target to also include support for SPI
>> flash, USB OTG, RockUSB and UMS.
>>
>> Also fix sdmmc alias, include missing pinctrl and add broken-cd prop to
>> fix use of SD-card in linux.
>>
> 
> I think we would have benefit with more and smaller commits there, but 
> since you're the one mainly maintaining those generic devices, up to you.

I can try to split it in a v2.

> 
> [...]
> 
>>   &sdmmc0 {
>> +	broken-cd;
>>   	bus-width = <4>;
>>   	cap-sd-highspeed;
>>   	disable-wp;
>>   	no-mmc;
>>   	no-sdio;
>>   	pinctrl-names = "default";
>> -	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
>> +	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
> 
> This is... surprising.
> 
> `broken-cd` but we still mux the SDMMC_DET pin in the SD card detect 
> function?
> 
> According to the dt binding, if broken-cd is provided, we should do 
> polling. If neither cd-gpios nor broken-cd is passed, host native card 
> detect will be used (which I assume means the SD card controller handles 
> this internally).
> 
> c.f. 
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/mmc/mmc-controller.yaml#L33
> 
> What are we supposed to do there actually, because this seems to be 
> contradicting itself?

The generic DTs is intended to be able to be use as control FDT in
U-Boot with any board that mostly follows reference hw dedign as close
as possible.

broken-cd was added to fool U-Boot (and possible Linux) into thinking a
card is present. And the sdmmc0_det pinctrl was added to satisfy the
controller logic and auto jtag.

When I tried to boot into linux with the control FDT prior to this, only
eMMC was detected and working, after these changes SD-card was working.

Will re-try without broken-cd for v2.

> 
>>   	status = "okay";
>>   };
>>   
>> +&sfc {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0>;
>> +		spi-max-frequency = <24000000>;
> 
> Random thought, but shouldn't we update common/spl/spl_spi.c to read 
> this value instead of using CONFIG_SF_DEFAULT_SPEED? (Nothing to do in 
> this patch series though :) ).

For U-Boot proper the value from this prop is used, SF_DEFAULT_SPEED is
only used in SPL.

> 
> [...]
> 
>> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
>> index e7d5e55bbfd8..b458080cd539 100644
>> --- a/configs/generic-rk3568_defconfig
>> +++ b/configs/generic-rk3568_defconfig
>> @@ -3,17 +3,22 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>>   CONFIG_COUNTER_FREQUENCY=24000000
>>   CONFIG_ARCH_ROCKCHIP=y
>>   CONFIG_NR_DRAM_BANKS=2
>> +CONFIG_SF_DEFAULT_SPEED=24000000
>>   CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
>>   CONFIG_ROCKCHIP_RK3568=y
>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>   CONFIG_SPL_SERIAL=y
>>   CONFIG_DEBUG_UART_BASE=0xFE660000
>>   CONFIG_DEBUG_UART_CLOCK=24000000
>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>> +CONFIG_SPL_SPI=y
>>   CONFIG_SYS_LOAD_ADDR=0xc00800
>>   CONFIG_DEBUG_UART=y
>>   CONFIG_FIT=y
>>   CONFIG_FIT_VERBOSE=y
>>   CONFIG_SPL_FIT_SIGNATURE=y
>>   CONFIG_SPL_LOAD_FIT=y
>> +# CONFIG_BOOTMETH_VBE is not set
>>   CONFIG_LEGACY_IMAGE_FORMAT=y
>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> @@ -21,32 +26,58 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
>>   CONFIG_SPL_MAX_SIZE=0x40000
>>   CONFIG_SPL_PAD_TO=0x7f8000
>>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_SPL_SPI_LOAD=y
>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>   CONFIG_SPL_ATF=y
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_MMC=y
>> +CONFIG_CMD_ROCKUSB=y
>> +CONFIG_CMD_USB_MASS_STORAGE=y
>>   # CONFIG_CMD_SETEXPR is not set
>>   # CONFIG_SPL_DOS_PARTITION is not set
>>   CONFIG_SPL_OF_CONTROL=y
>>   CONFIG_OF_LIVE=y
>>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>> +# CONFIG_NET is not set
> 
> This seems surprising, do you really want to get rid of network support 
> for the generic board defconfig?

My intention with the generic targets is that they only contain bare
minimum to boot from emmc/sd-card/spi flash. And a future possible use
could be to replace vendor usbplug blob and/or for other flashing or
recovery purposes. So network support should not be needed, also saves
a little on binary size and boot speed.

Regards,
Jonas

> 
> Cheers,
> Quentin

