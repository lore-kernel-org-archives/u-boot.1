Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B01AE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 07:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF3A6800C2;
	Fri, 10 Jan 2025 08:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="WgrmXsj6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE8A580027; Fri, 10 Jan 2025 08:16:57 +0100 (CET)
Received: from mail-m127162.xmail.ntesmail.com
 (mail-m127162.xmail.ntesmail.com [115.236.127.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC96280027
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:16:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 85062d33;
 Fri, 10 Jan 2025 15:16:49 +0800 (GMT+08:00)
Message-ID: <5d034cca-1d2b-44e1-849d-de251e6025da@rock-chips.com>
Date: Fri, 10 Jan 2025 15:16:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: rk356x: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241110005622.1515100-1-jonas@kwiboo.se>
 <20241110005622.1515100-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241110005622.1515100-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGEJJVksYGk9NTUNLHx9OSlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a944f12a44c03afkunm85062d33
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6CBw5MDILAw9PPggvFSpC
 OBQKCQhVSlVKTEhNT0JIT0pLTElKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9LSk03Bg++
DKIM-Signature: a=rsa-sha256;
 b=WgrmXsj6XK908hz2SoAOn9JX8zK2aM/eolvk2can2b+OvmQwAHdkkmOzG6pi/vZroWiJAjQ9very4yGiJptQQBX3zeHkYGzu718a1uLnX2AeyLXnr8YgFufuaoGhk8ru/hgm50Sh/ymxcLEgey88XIJtM317bKDjZiftwXv/Ofw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=BDSyb8bbFnvbiodA1ROcDIRWw6netTwEz2qZd6zG7AM=;
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


On 2024/11/10 08:56, Jonas Karlman wrote:
> Implement checkboard() to print current SoC model used by a board,
> e.g. one of:
>
>    SoC:   RK3566
>    SoC:   RK3566T
>    SoC:   RK3568
>    SoC:   RK3568B2
>    SoC:   RK3568J
>
> when U-Boot proper is running.
>
>    U-Boot 2025.01-rc1 (Nov 10 2024 - 00:39:37 +0000)
>
>    Model: Generic RK3566/RK3568
>    SoC:   RK3568J
>    DRAM:  8 GiB (effective 7.7 GiB)
>
> Information about the SoC model and variant is read from OTP.
>
> Also update rk356x-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
> where checkboard() is called.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> v3:
> - Fix build issue with MISC=n or ROCKCHIP_OTP=n
> - Remove use of cpu-version
> - Use log_debug() instead of debug()
> v2:
> - Update commit message
> - Update code comments
> - Drop generic-rk3568_defconfig change
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
>   arch/arm/mach-rockchip/rk3568/rk3568.c | 61 ++++++++++++++++++++++++++
>   2 files changed, 65 insertions(+)
>
> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 0a0943b462a9..24a976cf7e21 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -87,6 +87,10 @@
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
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index c9a32287e924..c2b96902d2dd 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -3,7 +3,10 @@
>    * (C) Copyright 2021 Rockchip Electronics Co., Ltd
>    */
>   
> +#define LOG_CATEGORY LOGC_ARCH
> +
>   #include <dm.h>
> +#include <misc.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/grf_rk3568.h>
> @@ -139,3 +142,61 @@ int arch_cpu_init(void)
>   #endif
>   	return 0;
>   }
> +
> +#define RK3568_OTP_CPU_CODE_OFFSET		0x02
> +#define RK3568_OTP_SPECIFICATION_OFFSET		0x07
> +#define RK3568_OTP_PERFORMANCE_OFFSET		0x22
> +
> +int checkboard(void)
> +{
> +	u8 cpu_code[2], specification, package, performance;
> +	struct udevice *dev;
> +	char suffix[3];
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
> +	/* cpu-code: SoC model, e.g. 0x35 0x66 or 0x35 0x68 */
> +	ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	/* specification: SoC variant, e.g. 0x2 for RK3568B2 and 0xA for RK3568J */
> +	ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		log_debug("Could not read specification, ret=%d\n", ret);
> +		return 0;
> +	}
> +	/* package: likely SoC variant revision, 0x2 for RK3568B2 */
> +	package = specification >> 5;
> +	specification &= 0x1f;
> +
> +	/* performance: used to identify RK3566T SoC variant */
> +	ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
> +	if (ret < 0) {
> +		log_debug("Could not read performance, ret=%d\n", ret);
> +		return 0;
> +	}
> +	if (performance & 0x0f)
> +		specification = 0x14; /* T-variant */
> +
> +	/* for RK3568J i.e. '@' + 0xA = 'J' */
> +	suffix[0] = specification > 1 ? '@' + specification : '\0';
> +	/* for RK3568B2 i.e. '0' + 0x2 = '2' */
> +	suffix[1] = package > 1 ? '0' + package : '\0';
> +	suffix[2] = '\0';
> +
> +	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
> +
> +	return 0;
> +}
