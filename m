Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AECC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9EE782F49;
	Mon, 14 Jul 2025 15:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cSFo8GRR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E8B83020; Mon, 14 Jul 2025 15:12:09 +0200 (CEST)
Received: from mail-m15578.qiye.163.com (mail-m15578.qiye.163.com
 [101.71.155.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D3E82E52
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:12:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.33.147] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 1bf332877;
 Mon, 14 Jul 2025 21:12:02 +0800 (GMT+08:00)
Message-ID: <a217aa49-2437-4054-92ab-ad33edd220e8@rock-chips.com>
Date: Mon, 14 Jul 2025 21:12:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: px30/rk3326: Implement checkboard() to print
 SoC variant
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
References: <20250610-px30-identify-variant-v3-1-957d70a8df9e@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250610-px30-identify-variant-v3-1-957d70a8df9e@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgdS1ZLTR1MHUhNQkoaSxlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a98091054fa03afkunm34b6472e1cc5b5e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6OSo4TzErERciQhAwNzIL
 Fx4KFDBVSlVKTE5JT0JDTElITk5OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFMTUpNNwY+
DKIM-Signature: a=rsa-sha256;
 b=cSFo8GRR4IbTSsE/Ip60JnHLOqfCroo67j3+Dh3s/nMCawqqQotN6pn/gN2bGRMEqkBaxvrssosT/eCVNPu7n3OaonAshIOLXeQNXv4yVj8HvcXv+Fw0Ldl1DhuQAwORx0bRn/wRy+Wzxxkwrx9DXCdgpBYpA8S4HsoDhy7ju0k=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=tEtEL8Tgrk7ionwpGB3TPztVHkxn2fbRCbmUGUziiAI=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/6/10 17:42, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> This implements checkboard() to print the current SoC model used by a
> board, e.g. one of:
>
> SoC:   PX30
> SoC:   PX30S
> SoC:   PX30K
> SoC:   RK3326
> SoC:   RK3326S
>
> when U-Boot proper is running.
>
> The information is read from the OTP and also the DDR_GRF. There's no
> public information as far as I know about the layout and stored
> information on OTP but this was provided by Rockchip themselves through
> their support channel.
>
> The OTP stores the information of whether the SoC is PX30K or something
> else. To differentiate between PX30/RK3326 and PX30S/RK3326S, one needs
> to read some undocumented bitfield in a DDR_GRF register as done in
> vendor kernel,
> c.f. https://github.com/armbian/linux-rockchip/blob/rk-6.1-rkr5.1/drivers/soc/rockchip/rockchip-cpuinfo.c#L118-L133.
>
> I do not own a PX30S, nor RK3326/RK3326S so cannot test it works
> properly.
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Tested on a PX30 Ringneck and PX30K Ringneck. Would be nice if anyone
> had a device with a PX30S, RK3326 or RK3326S so we could verify it
> prints what it should :)
> ---
> Changes in v3:
> - added (theoretical, untested) support for RK3326/RK3326S based on
>    feedback from Jonas,
> - Link to v2: https://lore.kernel.org/r/20250606-px30-identify-variant-v2-1-624d34ccc381@cherry.de
>
> Changes in v2:
> - added (theoretical, untested) support for PX30S based on feedback from
>    Kever,
> - Link to v1: https://lore.kernel.org/r/20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de
> ---
>   arch/arm/dts/px30-u-boot.dtsi      |  4 +++
>   arch/arm/mach-rockchip/px30/px30.c | 61 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
>
> diff --git a/arch/arm/dts/px30-u-boot.dtsi b/arch/arm/dts/px30-u-boot.dtsi
> index 157d0ea6930c55cc067560bd795249a39c3249ab..2f726b0aaba358c8fb3bf6f8ed2f9afca416aabe 100644
> --- a/arch/arm/dts/px30-u-boot.dtsi
> +++ b/arch/arm/dts/px30-u-boot.dtsi
> @@ -27,6 +27,10 @@
>   	};
>   };
>   
> +&otp {
> +	bootph-some-ram;
> +};
> +
>   &uart2 {
>   	clock-frequency = <24000000>;
>   	bootph-all;
> diff --git a/arch/arm/mach-rockchip/px30/px30.c b/arch/arm/mach-rockchip/px30/px30.c
> index 8ce9ac561f0213fd4db933fdb9e1edde61ac39ca..5a5c119328fb3912af4276b1e1b12640349a7c47 100644
> --- a/arch/arm/mach-rockchip/px30/px30.c
> +++ b/arch/arm/mach-rockchip/px30/px30.c
> @@ -2,10 +2,14 @@
>   /*
>    * Copyright (c) 2017 Rockchip Electronics Co., Ltd
>    */
> +
> +#define LOG_CATEGORY LOGC_ARCH
> +
>   #include <clk.h>
>   #include <dm.h>
>   #include <fdt_support.h>
>   #include <init.h>
> +#include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
> @@ -15,6 +19,7 @@
>   #include <asm/arch-rockchip/clock.h>
>   #include <asm/arch-rockchip/cru_px30.h>
>   #include <dt-bindings/clock/px30-cru.h>
> +#include <linux/bitfield.h>
>   
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff390000",
> @@ -442,3 +447,59 @@ void board_debug_uart_init(void)
>   #endif /* CONFIG_DEBUG_UART_BASE && CONFIG_DEBUG_UART_BASE == ... */
>   }
>   #endif /* CONFIG_DEBUG_UART_BOARD_INIT */
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
> +	u32 base_soc;
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
> +	/* base SoC: 0x26334b52 for RK3326; 0x30335850 for PX30 */
> +	ret = misc_read(dev, 0, &base_soc, 4);
> +	if (ret < 0) {
> +		log_debug("Could not read specification, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	if (base_soc != 0x26334b52 && base_soc != 0x30335850) {
> +		log_debug("Could not identify SoC, got 0x%04x in OTP\n", base_soc);
> +		return 0;
> +	}
> +
> +	/* SoC variant: 0x21 for PX30/PX30S/RK3326/RK3326S; 0x2b for PX30K */
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
> +	printf("SoC:   %s%s\n", base_soc == 0x26334b52 ? "RK3326" : "PX30",
> +	       specification == 0x3 ? "S" : "");
> +
> +	return 0;
> +}
>
> ---
> base-commit: 11b8bcd7005ff24b2114dcc4d1061e083e4c9e6c
> change-id: 20250528-px30-identify-variant-ae39c772155b
>
> Best regards,

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

