Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1620BCCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 15:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DD983857;
	Sun, 26 Oct 2025 16:41:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="AO8rRdAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CC628384E; Sun, 26 Oct 2025 16:40:59 +0100 (CET)
Received: from mail-m3285.qiye.163.com (mail-m3285.qiye.163.com
 [220.197.32.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C3CC82E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 16:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.1.64] (unknown [124.72.36.208])
 by smtp.qiye.163.com (Hmail) with ESMTP id 273748f0c;
 Sun, 26 Oct 2025 23:40:53 +0800 (GMT+08:00)
Message-ID: <0ec672c9-19c5-4990-b98e-cddd0dd3b471@rock-chips.com>
Date: Sun, 26 Oct 2025 23:40:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] rockchip: rk3576: Add SPI Flash boot support
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20251019154728.846096-1-jonas@kwiboo.se>
 <20251019154728.846096-5-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20251019154728.846096-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a212dfbc703afkunmf5d37c8d4d224f
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGh8ZVk5MQh4fTk4eGBhISFYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKSU9VTElVSE1VSUtDWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
 b=AO8rRdAnw8+Mo7ezRyj7y3eUa6Emp6KTV+cRyxwdZ/IX2mcoDWdQUkAp3PxL8EMUkTsEmJuDKBcZXyvz+Q4LsbFo9Dct+zIuxfIwJcvyZu6kBJElWsZaLJ0MDMlD3QIBbJrTnI1bLz1TyhPalXoKQsWQPHFj5RyQvupEYj9vlDI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=1NxOFQVlx29qRYdyPv87mO4xBDbtegxaeLCmup0TI2Y=;
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


On 2025/10/19 23:47, Jonas Karlman wrote:
> The bootsource ids reported by BootROM of RK3576 for SPI NOR and USB
> differs slightly compared to prior SoCs:
>
> - Booting from sfc0 (ROCK 4D) report the normal bootsource id 0x3.
> - Booting from sfc1 M1 (NanoPi M5) report a new bootsource id 0x23.
> - Booting from sfc1 M0 has not been tested (no board using this config).
> - Booting from USB report a new bootsource id 0x81.
>
> Add a RK3576 specific read_brom_bootsource_id() function to help decode
> the new bootsource id values and the required boot_devices mapping of
> sfc0 and sfc1 to help support booting from SPI flash on RK3576.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v4: No change
>
> Changes in v3:
> - Add fspi1m1 pinctrl bootph- props to SoC u-boot.dtsi
> - Drop the incomplete support for FSPI1_M0
> - Add a short code comment about the re-mapping of bootsource id
>
> v2: No change
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi        | 46 ++++++++++++++++++++++++++
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 25 ++++++++++++++
>   2 files changed, 71 insertions(+)
>
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index fb5a107f47d9..dc3771b556a3 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -6,6 +6,11 @@
>   #include "rockchip-u-boot.dtsi"
>   
>   / {
> +	aliases {
> +		spi5 = &sfc0;
> +		spi6 = &sfc1;
> +	};
> +
>   	chosen {
>   		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &sdhci;
>   	};
> @@ -16,6 +21,17 @@
>   	};
>   };
>   
> +#ifdef CONFIG_ROCKCHIP_SPI_IMAGE
> +&binman {
> +	simple-bin-spi {
> +		mkimage {
> +			args = "-n", CONFIG_SYS_SOC, "-T", "rksd";
> +			offset = <0x8000>;
> +		};
> +	};
> +};
> +#endif
> +
>   &cru {
>   	bootph-all;
>   };
> @@ -45,6 +61,26 @@
>   	bootph-some-ram;
>   };
>   
> +&fspi0_csn0 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&fspi0_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&fspi1m1_csn0 {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&fspi1m1_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
>   &ioc_grf {
>   	bootph-all;
>   };
> @@ -116,6 +152,16 @@
>   	bootph-some-ram;
>   };
>   
> +&sfc0 {
> +	bootph-some-ram;
> +	u-boot,spl-sfc-no-dma;
> +};
> +
> +&sfc1 {
> +	bootph-some-ram;
> +	u-boot,spl-sfc-no-dma;
> +};
> +
>   &sys_grf {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index a6c2fbdc4840..a1e8a7572fa4 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -36,8 +36,15 @@
>   #define USB_GRF_BASE		0x2601E000
>   #define USB3OTG0_CON1		0x0030
>   
> +enum {
> +	BROM_BOOTSOURCE_FSPI0 = 3,
> +	BROM_BOOTSOURCE_FSPI1_M1 = 6,
> +};
> +
>   const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
>   	[BROM_BOOTSOURCE_EMMC] = "/soc/mmc@2a330000",
> +	[BROM_BOOTSOURCE_FSPI0] = "/soc/spi@2a340000/flash@0",
> +	[BROM_BOOTSOURCE_FSPI1_M1] = "/soc/spi@2a300000/flash@0",
>   	[BROM_BOOTSOURCE_SD] = "/soc/mmc@2a310000",
>   };
>   
> @@ -85,6 +92,24 @@ void board_debug_uart_init(void)
>   {
>   }
>   
> +u32 read_brom_bootsource_id(void)
> +{
> +	u32 bootsource_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> +
> +	/* Re-map the raw value read from reg to a redefined or existing
> +	 * BROM_BOOTSOURCE enum value to avoid having to create a larger
> +	 * boot_devices table.
> +	 */
> +	if (bootsource_id == 0x23)
> +		return BROM_BOOTSOURCE_FSPI1_M1;
> +	else if (bootsource_id == 0x81)
> +		return BROM_BOOTSOURCE_USB;
> +	else if (bootsource_id > BROM_LAST_BOOTSOURCE)
> +		log_debug("Unknown bootsource %x\n", bootsource_id);
> +
> +	return bootsource_id;
> +}
> +
>   #define HP_TIMER_BASE			CONFIG_ROCKCHIP_STIMER_BASE
>   #define HP_CTRL_REG			0x04
>   #define TIMER_EN			BIT(0)

-- 
Thanks & Best regards,
   Kever Yang
**************************************************************************************************
杨凯  市场部             Kever Yang      Marketing Department
瑞芯微电子股份有限公司                Rockchip Electronics Co.，Ltd。
地址：福建省福州市铜盘路软件大道89号软件园A区18号楼 (350003)
Addr : No.18 Building，A District，No.89，Fuzhou Software Boulevard，Fuzhou，Fujian，PRC

