Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B13FCC9A5
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 23:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D405F839DF;
	Tue, 10 Mar 2026 00:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ezHRNNgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D64B83BC8; Tue, 10 Mar 2026 00:49:19 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11B7683981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 00:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1773100156;
 bh=MN8cyK24mvLkqh9Eh8hbnvYXLYFRMDCap63nqYQh7Wo=;
 b=ezHRNNgq7JYxEoI3r5PjmnrxdRow0jwrdh+IZcU+X8Ilrx3e7FCnPGVvdb9sm+c1NTHgwmDtQ
 1+PmFG38jC+Ij7mkrAEcoVVg9OA7Xwu+iKaVPfgZKaoeZRPggphKqJjBcF0cN8ksU+e6ESVLwRR
 ec9XjhXdVESFO7HMwALrfGtX8c0zwtk6CYCVJ6fkuDV+wJPKUrxgsboQ2jBdehSeb7W8OReQzXh
 f+Qond9XTXc2mkZtae8v8QqQMnJIy6OJm0d5iBTCD+0bHDOxjb9s5iOixWreXy9tX20lfg3W4l4
 09q9M9GhI/V+piaLKtQehT+vxK0C8EuQmh9HtBIiyN+A==
X-Forward-Email-ID: 69af5c78dfcb1badc6a63b35
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <5817be80-5f5e-4cde-a6d5-006f2d711ef1@kwiboo.se>
Date: Tue, 10 Mar 2026 00:49:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi R76S
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Tianling Shen <cnsztl@gmail.com>, u-boot@lists.denx.de
References: <20260108143551.4017839-1-jonas@kwiboo.se>
 <20260108143551.4017839-3-jonas@kwiboo.se>
 <d4e17b2d-ab26-400a-b49a-e054f54067d5@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d4e17b2d-ab26-400a-b49a-e054f54067d5@cherry.de>
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

On 1/14/2026 5:52 PM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 1/8/26 3:35 PM, Jonas Karlman wrote:
>> The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
>> device with two 2.5G, designed and developed by FriendlyElec.
>>
>> Features tested on a NanoPi R76S 2411:
>> - SD-card boot
>> - eMMC boot
>> - LEDs and button
>> - PCIe/Ethernet
>> - USB host
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>>   arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi |  3 ++
>>   arch/arm/mach-rockchip/rk3576/MAINTAINERS   |  6 +++
>>   configs/nanopi-r76s-rk3576_defconfig        | 60 +++++++++++++++++++++
>>   doc/board/rockchip/rockchip.rst             |  1 +
>>   4 files changed, 70 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
>>   create mode 100644 configs/nanopi-r76s-rk3576_defconfig
>>
>> diff --git a/arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi b/arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..632fabb6af56
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3576-nanopi-r76s-u-boot.dtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3576-u-boot.dtsi"
> 
> I don't think that should be necessary?

You are correct, I have removed this file in v2.

> U-Boot should fallback to rj3576-u-boot.dtsi if there's no 
> rk3576-nanopi-r76s-u-boot.dtsi, because SYS_SOC is rk3576 in 
> arch/arm/mach-rockchip/rk3576/Kconfig and the wildcard list in 
> u_boot_dtsi_options in scripts/Makefile.lib.
> 
> More comments below but they are definitely not blocker for merging this.
> 
>> diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> index 393edd3984ce..79cf9e97f70b 100644
>> --- a/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> +++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
>> @@ -10,6 +10,12 @@ S:	Maintained
>>   F:	arch/arm/dts/rk3576-nanopi-m5*
>>   F:	configs/nanopi-m5-rk3576_defconfig
>>   
>> +NANOPI-R76S-RK3576
>> +M:	Jonas Karlman <jonas@kwiboo.se>
>> +S:	Maintained
>> +F:	arch/arm/dts/rk3576-nanopi-r76s*
>> +F:	configs/nanopi-r76s-rk3576_defconfig
>> +
>>   OMNI3576-RK3576
>>   M:	Jonas Karlman <jonas@kwiboo.se>
>>   S:	Maintained
>> diff --git a/configs/nanopi-r76s-rk3576_defconfig b/configs/nanopi-r76s-rk3576_defconfig
>> new file mode 100644
>> index 000000000000..af149dc4ba56
>> --- /dev/null
>> +++ b/configs/nanopi-r76s-rk3576_defconfig
>> @@ -0,0 +1,60 @@
>> +CONFIG_ARM=y
>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
>> +CONFIG_COUNTER_FREQUENCY=24000000
>> +CONFIG_ARCH_ROCKCHIP=y
>> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3576-nanopi-r76s"
>> +CONFIG_ROCKCHIP_RK3576=y
>> +CONFIG_SYS_LOAD_ADDR=0x40c00800
> 
> Should we think about adding a default value for various Rockchip SoCs 
> in root Kconfig for SYS_LOAD_ADDR?

Possible, I do not even know if this is a fully safe default for
SYS_LOAD_ADDR or what will really use this addr, but it matches what is
used by many other Rockchip boards.

> 
>> +CONFIG_DEBUG_UART_BASE=0x2AD40000
>> +CONFIG_DEBUG_UART_CLOCK=24000000
> 
> Same here. I'm assuming there's a reference design most people are 
> basing their HW on, so having a default DEBUG_UART_BASE common for the 
> SoC makes sense (and we could even then have a comment specifying which 
> UART controller that is). As for the clock speed, I'm wondering if we 
> ever had something different than that. And also wondering if it's 
> related (should be in sync?) with &uart0/clock-frequency?

Agree, there are some defaults that we could and probably should set on
SoC level. And yes, there are multiple possible duplicated 24 MHz ref
clocks in use for UART, e.g.: DEBUG_UART_CLOCK, &uart0/clock-frequency
and CFG_SYS_NS16550_CLK. To my knowledge all Rockchip SoCs use a 24 MHz
ref clock.

> 
>> +CONFIG_PCI=y
>> +CONFIG_DEBUG_UART=y
>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-nanopi-r76s.dtb"
>> +# CONFIG_DISPLAY_CPUINFO is not set
> 
> Why not :)?

It requires asm/arch-rockchip/cru.h to have a soc specific #ifdef to
make it work to print out and set a reset reason. Something I rather see
being reworked to use sysresed uclass or similar than enable for "new"
SoCs.

> 
>> +CONFIG_SPL_MAX_SIZE=0x40000
>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>> +CONFIG_CMD_MEMINFO=y
>> +CONFIG_CMD_MEMINFO_MAP=y
>> +CONFIG_CMD_ADC=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +CONFIG_CMD_MISC=y
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PCI=y
>> +CONFIG_CMD_USB=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_RNG=y
>> +CONFIG_CMD_REGULATOR=y
>> +# CONFIG_SPL_DOS_PARTITION is not set
>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>> +CONFIG_BUTTON=y
>> +CONFIG_BUTTON_GPIO=y
>> +CONFIG_ROCKCHIP_GPIO=y
>> +CONFIG_SYS_I2C_ROCKCHIP=y
>> +CONFIG_LED=y
>> +CONFIG_LED_GPIO=y
>> +CONFIG_SUPPORT_EMMC_RPMB=y
>> +CONFIG_MMC_DW=y
>> +CONFIG_MMC_DW_ROCKCHIP=y
>> +CONFIG_MMC_SDHCI=y
>> +CONFIG_MMC_SDHCI_SDMA=y
>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>> +CONFIG_RTL8169=y
>> +CONFIG_PCIE_DW_ROCKCHIP=y
>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>> +CONFIG_DM_PMIC=y
>> +CONFIG_PMIC_RK8XX=y
>> +CONFIG_REGULATOR_RK8XX=y
>> +CONFIG_BAUDRATE=1500000
>> +CONFIG_DEBUG_UART_SHIFT=2
>> +CONFIG_SYS_NS16550_MEM32=y
> 
> The two above also are always the same on Rockchip no?

Yes, to my knowledge most reg access on RK is 32-bit based and should
use readl/writel instead of readb/writeb.

> 
> By default, the expected baudrate is probably 1500000 on Rockchip, 
> wondering if we shouldn't make that the default either?

Agree, there are only a few SoCs/boards that 

> 
>> +CONFIG_SYSRESET_PSCI=y
>> +CONFIG_USB=y
>> +CONFIG_USB_XHCI_HCD=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_ERRNO_STR=y
> 
> I'm wondering whether we should think about setting WERROR on by default 
> for new boards? What do you think?

Sounds like a good idea but no other board in-tree seem to enable it.
My local build script always injected -Werror using CFLAGS, but maybe
better to enable CONFIG_WERROR.

Regards,
Jonas

> 
> Cheers,
> Quentin

