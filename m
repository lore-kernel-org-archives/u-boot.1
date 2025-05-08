Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97C5C3ABC3
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 02:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459F7820EB;
	Thu,  8 May 2025 04:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="k2aV1tpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDAF58211F; Thu,  8 May 2025 04:26:34 +0200 (CEST)
Received: from mail-m8148.xmail.ntesmail.com (mail-m8148.xmail.ntesmail.com
 [156.224.81.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E07BA81FAB
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 04:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.223] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 145060a22;
 Thu, 8 May 2025 10:26:26 +0800 (GMT+08:00)
Message-ID: <0995dc92-954e-4cac-ad93-4816ff69f06b@rock-chips.com>
Date: Thu, 8 May 2025 10:26:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] rockchip: rk3576: Implement checkboard() to print SoC
 variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
References: <20250422211216.3727559-1-jonas@kwiboo.se>
 <20250422211216.3727559-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250422211216.3727559-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0hJQlZJTBlCTBhLGhgeTBlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a96adb7327803afkunm145060a22
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OQg6TQw4GDIMTggBLU4CEhgM
 GE0wFBFVSlVKTE9NTUxKSkNMTU1OVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFIQ0pLNwY+
DKIM-Signature: a=rsa-sha256;
 b=k2aV1tppP1j2MIPW5qpu2yZhlcmPhIr+PWUBnuHzep9FgXgmTgV/9+5R70u/WQEN0mQpzy5gI7LqP1vGk/ncyET/7lQLvzCO3xYqCKpin2yZ67onixGzggaS/+kCzfdoYDL+XCTahr2Et97rFRktq2uQuEJgD+B4AAZD3w8XdfU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=7Ybzu+DHeVHvkjgqEGsO+nShA9yXXeWgKNaGjORYFlc=;
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


On 2025/4/23 05:12, Jonas Karlman wrote:
> Implement checkboard() to print current SoC model used by a board when
> U-Boot proper is running.
>
>    U-Boot 2025.04 (Apr 22 2025 - 20:43:17 +0000)
>
>    Model: Generic RK3576
>    SoC:   RK3576
>    DRAM:  8 GiB
>
> Information about the SoC model and variant is read from OTP.
>
> Also update rk3576-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
> where checkboard() is called.

The dts change should be separate from the driver code.


Thanks,

- Kever

>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk3576-u-boot.dtsi        |  4 +++
>   arch/arm/mach-rockchip/rk3576/rk3576.c | 48 ++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
>
> diff --git a/arch/arm/dts/rk3576-u-boot.dtsi b/arch/arm/dts/rk3576-u-boot.dtsi
> index 928960862597..c623bf544688 100644
> --- a/arch/arm/dts/rk3576-u-boot.dtsi
> +++ b/arch/arm/dts/rk3576-u-boot.dtsi
> @@ -56,6 +56,10 @@
>   	bootph-all;
>   };
>   
> +&otp {
> +	bootph-some-ram;
> +};
> +
>   &pcfg_pull_none {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-rockchip/rk3576/rk3576.c
> index ba5c94b4b3dd..2b1318f9532f 100644
> --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> @@ -3,6 +3,10 @@
>    * Copyright (c) 2024 Rockchip Electronics Co., Ltd
>    */
>   
> +#define LOG_CATEGORY LOGC_ARCH
> +
> +#include <dm.h>
> +#include <misc.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/hardware.h>
> @@ -153,3 +157,47 @@ int arch_cpu_init(void)
>   
>   	return 0;
>   }
> +
> +#define RK3576_OTP_CPU_CODE_OFFSET		0x02
> +#define RK3576_OTP_SPECIFICATION_OFFSET		0x08
> +
> +int checkboard(void)
> +{
> +	u8 cpu_code[2], specification;
> +	struct udevice *dev;
> +	char suffix[2];
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
> +	/* cpu-code: SoC model, e.g. 0x35 0x76 */
> +	ret = misc_read(dev, RK3576_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	/* specification: SoC variant, e.g. 0xA for RK3576J */
> +	ret = misc_read(dev, RK3576_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		log_debug("Could not read specification, ret=%d\n", ret);
> +		return 0;
> +	}
> +	specification &= 0x1f;
> +
> +	/* for RK3576J i.e. '@' + 0xA = 'J' */
> +	suffix[0] = specification > 1 ? '@' + specification : '\0';
> +	suffix[1] = '\0';
> +
> +	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
> +
> +	return 0;
> +}
