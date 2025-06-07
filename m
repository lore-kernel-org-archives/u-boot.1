Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829E6C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 20:29:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1189807B1;
	Sat,  7 Jun 2025 22:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="y/8DLsbr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC22811AC; Sat,  7 Jun 2025 22:29:28 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0988059D
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 22:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e58b=YX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: References: Cc:
 To: Subject: From: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1749328164;
 bh=wNUgNuu4EUw921hSwFzQiHB+oAJzQzat0b0zOu5jsKs=;
 b=y/8DLsbr/0/+UX2xe1gwy2EfVPKWi1FIGXQRzmATZ/lAwC80H4OhzCXenvPhPHOiHMuyoeRTe
 nXF0oK6EvDrKs2SbFvt2EFd7K6kFFvNta0VgHSBwtccawUJtzigxOsc1y1p4C4a0JgeWuXwGCys
 LXA4cHvNPGQC+D5CK06tuU1vV0Qo4mHZlOSgSWUZk5rp/VlnVphTsyUfu3aBaBWltGPL69hEDmX
 zO5HEh6pNUVbkigzjV1GIX46h8DTA3RxkfEnS3mbvz6xpbDZuezIRshhwRTNLp0JNgAXu0t76Jx
 MHgDFaHKaBQR+QE196htPBYF/r2wxhYiqmqNSpokvjmw==
X-Forward-Email-ID: 6844a11af98500a27c5028b5
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.3
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <205074ef-0cea-44a0-beb5-8e5f8f435ee7@kwiboo.se>
Date: Sat, 7 Jun 2025 22:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v2] rockchip: px30: Implement checkboard() to print SoC
 variant
To: Quentin Schulz <foss+uboot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Heiko Stuebner <heiko@sntech.de>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20250606-px30-identify-variant-v2-1-624d34ccc381@cherry.de>
Content-Language: en-US
In-Reply-To: <20250606-px30-identify-variant-v2-1-624d34ccc381@cherry.de>
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

On 2025-06-06 12:21, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> This implements checkboard() to print the current SoC model used by a
> board, e.g. one of:
> 
> SoC: PX30
> SoC: PX30S
> SoC: PX30K
> 
> when U-Boot proper is running.
> 
> The information is read from the OTP and also the DDR_GRF. There's no
> public information as far as I know about the layout and stored
> information on OTP but this was provided by Rockchip themselves through
> their support channel.
> 
> The OTP stores the information of whether the SoC is PX30/PX30S or
> PX30K. To differentiate between PX30 and PX30S, one needs to read some
> undocumented bitfield in a DDR_GRF register as done in vendor kernel,
> c.f. https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr5.1/drivers/soc/rockchip/rockchip-cpuinfo.c#L118-L133
> 
> I do not own a PX30S so cannot test it works properly.
> 
> Also add the OTP node to the pre-relocation phase of U-Boot proper so
> that the SoC variant can be printed when DISPLAY_BOARDINFO is enabled.
> This is not required if DISPLAY_BOARDINFO_LATE is enabled because this
> happens after relocation. If both are enabled, then the SoC variant will
> be printed twice in the boot log, e.g.:
> 
> U-Boot 2025.07-rc3-00014-g7cb731574ae6-dirty (May 28 2025 - 13:52:47 +0200)
> 
> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
> SoC:   PX30  <---- due to DISPLAY_BOARDINFO
> DRAM:  2 GiB
> PMIC:  RK809 (on=0x40, off=0x00)
> Core:  293 devices, 27 uclasses, devicetree: separate
> MMC:   mmc@ff370000: 1, mmc@ff390000: 0
> Loading Environment from MMC... Reading from MMC(1)... OK
> 
> In:    serial@ff030000
> Out:   serial@ff030000
> Err:   serial@ff030000
> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
> SoC:   PX30  <----- due to DISPLAY_BOARDINFO_LATE
> Net:   eth0: ethernet@ff360000
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> Tested on a PX30 Ringneck and PX30K Ringneck. Would be nice if anyone
> had a device with a PX30S so we could verify it prints what it should :)
> ---
> Changes in v2:
> - added (theoretical, untested) support for PX30S based on feedback from
>   Kever,
> - Link to v1: https://lore.kernel.org/r/20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de
> ---
>  arch/arm/dts/px30-u-boot.dtsi      |  4 +++
>  arch/arm/mach-rockchip/px30/px30.c | 50 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
> 
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index 157d0ea6930c55cc067560bd795249a39c3249ab..2f726b0aaba358c8fb3bf6f8ed2f9afca416aabe 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -27,6 +27,10 @@
>  	};
>  };
>  
> +&otp {
> +	bootph-some-ram;
> +};
> +
>  &uart2 {
>  	clock-frequency = <24000000>;
>  	bootph-all;
> diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
> index 8ce9ac561f0213fd4db933fdb9e1edde61ac39ca..ee0f788a21063a0c36259ac4ce95f809e164e9cd 100644
> --- a/arch/arm/mach-rockchip/px30/px30.c
> +++ b/arch/arm/mach-rockchip/px30/px30.c
> @@ -2,10 +2,14 @@
>  /*
>   * Copyright (c) 2017 Rockchip Electronics Co., Ltd
>   */
> +
> +#define LOG_CATEGORY LOGC_ARCH
> +
>  #include <clk.h>
>  #include <dm.h>
>  #include <fdt_support.h>
>  #include <init.h>
> +#include <misc.h>
>  #include <spl.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/arch-rockchip/bootrom.h>
> @@ -15,6 +19,7 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/cru_px30.h>
>  #include <dt-bindings/clock/px30-cru.h>
> +#include <linux/bitfield.h>
>  
>  const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>  	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff390000",
> @@ -442,3 +447,48 @@ void board_debug_uart_init(void)
>  #endif /* CONFIG_DEBUG_UART_BASE && CONFIG_DEBUG_UART_BASE == ... */
>  }
>  #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
> +
> +#define PX30_OTP_SPECIFICATION_OFFSET		0x06
> +
> +#define DDR_GRF_BASE_ADDR               0xff630000
> +#define DDR_GRF_CON(n)                  (0 + (n) * 4)
> +
> +int checkboard(void)
> +{
> +	struct udevice *dev;
> +	u8 specification;
> +	int ret;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
> +		return 0;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		log_debug("Could not find otp device, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	/* SoC variant, e.g. 0x21 for PX30/PX30S and 0x2b for PX30K */
> +	ret = misc_read(dev, PX30_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		log_debug("Could not read specification, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	if (specification == 0x2b) {
> +		printf("SoC:   PX30K\n");
> +		return 0;
> +	}
> +
> +	/* From vendor kernel: drivers/soc/rockchip/rockchip-cpuinfo.c */
> +	specification = FIELD_GET(GENMASK(15, 14),
> +				  readl(DDR_GRF_BASE_ADDR + DDR_GRF_CON(1)));
> +	log_debug("DDR specification is %d\n", specification);
> +	if (specification == 0x3)
> +		printf("SoC:   PX30S\n");
> +	else
> +		printf("SoC:   PX30\n");

ROCKCHIP_PX30 is also used for RK3326, so that is probably something to
take into consideration here.

Typically the cpu-code is located at 0x02 or the first 4 bytes of OTP,
that could possible be used to determine if it is a PX30 or RK3326.

Here is a dump of OTP from my RK3326 board:

=> dump_otp
00000000: 52 4b 33 26  RK3&
00000004: 91 fe 21 55  ..!U
00000008: 52 4b 56 33  RKV3
0000000c: 32 30 31 34  2014
00000010: 00 00 00 00  ....
00000014: 12 28 1f 0d  .(..
00000018: 08 00 00 00  ....
0000001c: 00 00 00 00  ....
00000020: 00 01 00 00  ....
00000024: 00 00 00 00  ....
00000028: 00 00 00 00  ....
0000002c: 00 00 00 00  ....
00000030: 00 00 00 00  ....
00000034: 00 00 00 00  ....
00000038: 00 00 00 00  ....
0000003c: 00 00 00 00  ....

Regards,
Jonas

> +
> +	return 0;
> +}
> 
> ---
> base-commit: 11b8bcd7005ff24b2114dcc4d1061e083e4c9e6c
> change-id: 20250528-px30-identify-variant-ae39c772155b
> 
> Best regards,


