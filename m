Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C72E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 07:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74508801F5;
	Fri, 10 Jan 2025 08:17:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="OrpCNnsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4864E80602; Fri, 10 Jan 2025 08:17:14 +0100 (CET)
Received: from mail-m118115.qiye.163.com (mail-m118115.qiye.163.com
 [115.236.118.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D949780027
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 08:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 85062da5;
 Fri, 10 Jan 2025 15:17:06 +0800 (GMT+08:00)
Message-ID: <711359a8-a5c9-4553-a35f-3a2054486818@rock-chips.com>
Date: Fri, 10 Jan 2025 15:17:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241110005622.1515100-1-jonas@kwiboo.se>
 <20241110005622.1515100-3-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241110005622.1515100-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEkZVhhKGk8ZGB1KTR5MS1YVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a944f12e6fb03afkunm85062da5
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBw6ITo*MDIVSA8xPggVFQk8
 GjgaCyhVSlVKTEhNT0JIT0lMQkhCVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUhNS0o3Bg++
DKIM-Signature: a=rsa-sha256;
 b=OrpCNnsMowUe7KZ3WtFAsqzKUQUt/EPV+uDuU1/DuDaT6LgMeC1eBD0obITq2XTgUTiCHDVfeI4xZ8igfjqGsEzTnPsopc1mbjMiMpuwhBkpswK6A5y1Kmu5AlDyH5KFlO0wayu/zt2BgTA6V7JLMFNUVjSP3bf/97tpe/gKTz0=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=KXtMClN1QVfF/i5RF8pPtSOp+YzNq+cpo4qFDCRZjBY=;
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
>    SoC:   RK3582
>    SoC:   RK3588
>    SoC:   RK3588J
>    SoC:   RK3588S
>    SoC:   RK3588S2
>
> when U-Boot proper is running.
>
>    U-Boot 2025.01-rc1 (Nov 10 2024 - 00:31:29 +0000)
>
>    Model: Generic RK3588S/RK3588
>    SoC:   RK3588S2
>    DRAM:  8 GiB
>
> Information about the SoC model and variant is read from OTP.
>
> Also update rk3588s-u-boot.dtsi to include OTP in U-Boot pre-reloc phase,
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
> - Drop generic-rk3588_defconfig change
> ---
>   arch/arm/dts/rk3588s-u-boot.dtsi       |  4 ++
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 52 ++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+)
>
> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index 09d8b311cec5..8880d162b11c 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -69,6 +69,10 @@
>   	bootph-all;
>   };
>   
> +&otp {
> +	bootph-some-ram;
> +};
> +
>   &pcfg_pull_down {
>   	bootph-all;
>   };
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index e2dac2a5b806..c1dce3ee3703 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -4,6 +4,10 @@
>    * Copyright (c) 2022 Edgeble AI Technologies Pvt. Ltd.
>    */
>   
> +#define LOG_CATEGORY LOGC_ARCH
> +
> +#include <dm.h>
> +#include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
> @@ -178,3 +182,51 @@ int arch_cpu_init(void)
>   	return 0;
>   }
>   #endif
> +
> +#define RK3588_OTP_CPU_CODE_OFFSET		0x02
> +#define RK3588_OTP_SPECIFICATION_OFFSET		0x06
> +
> +int checkboard(void)
> +{
> +	u8 cpu_code[2], specification, package;
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
> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return 0;
> +	}
> +
> +	/* specification: SoC variant, e.g. 0xA for RK3588J and 0x13 for RK3588S */
> +	ret = misc_read(dev, RK3588_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		log_debug("Could not read specification, ret=%d\n", ret);
> +		return 0;
> +	}
> +	/* package: likely SoC variant revision, 0x2 for RK3588S2 */
> +	package = specification >> 5;
> +	specification &= 0x1f;
> +
> +	/* for RK3588J i.e. '@' + 0xA = 'J' */
> +	suffix[0] = specification > 1 ? '@' + specification : '\0';
> +	/* for RK3588S2 i.e. '0' + 0x2 = '2' */
> +	suffix[1] = package > 1 ? '0' + package : '\0';
> +	suffix[2] = '\0';
> +
> +	printf("SoC:   RK%02x%02x%s\n", cpu_code[0], cpu_code[1], suffix);
> +
> +	return 0;
> +}
