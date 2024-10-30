Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E72D74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1174891F4;
	Wed, 30 Oct 2024 07:40:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="RRHzDUEO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08C9A891F5; Wed, 30 Oct 2024 07:40:39 +0100 (CET)
Received: from mail-m12765.qiye.163.com (mail-m12765.qiye.163.com
 [115.236.127.65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67A2F891E1
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 14655246;
 Wed, 30 Oct 2024 14:40:30 +0800 (GMT+08:00)
Message-ID: <424c80ea-3dbc-46eb-8558-ac20e7c34b85@rock-chips.com>
Date: Wed, 30 Oct 2024 14:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: rk356x: Implement checkboard() to print SoC
 variant
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Dragan Simic <dsimic@manjaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20241018163423.1562287-1-jonas@kwiboo.se>
 <20241018163423.1562287-2-jonas@kwiboo.se>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241018163423.1562287-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0IZS1ZKGEoeTh1OSB9JHRlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92dc27862703afkunm14655246
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDY6Ojo6PzIjTAI9HFYOL0gY
 DR5PCTJVSlVKTEhLSUxLT0hKTExIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTUNONwY+
DKIM-Signature: a=rsa-sha256;
 b=RRHzDUEONA4/L4SC19Bv2ez7l0ApIzC36V7bHbGfWquIDso9DGpuEZjTJ8mqO8/XbCkp3P/5lwFVN5nfweaK7rZE5U3Amtak7MCebN/eCqgO+Sy26AJvFuzZW5FaieHikcp/BxZ1k8Qu3/YcI00yVnDV1XjRPRMUnRdKfyvTOGY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=gvm3cUKa/2Ag51SETeEh249XkLzb4XRSnniBno7DkYo=;
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

Hi Jonas,


On 2024/10/19 00:34, Jonas Karlman wrote:
> Implement checkboard() to print current SoC model, e.g. one of:
>
>    SoC:   RK3566 v1
>    SoC:   RK3566 v2
>    SoC:   RK3566T v2
>    SoC:   RK3568 v2
>    SoC:   RK3568B2 v2
>    SoC:   RK3568J v2

Did you get these types from different board, or is  there a document 
for this?

I didn't see this kind of document :(


>
> when U-Boot proper is started.
>
> Information about what SoC model, variant and version is read from OTP.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
>   arch/arm/mach-rockchip/rk3568/rk3568.c | 65 ++++++++++++++++++++++++++
>   configs/generic-rk3568_defconfig       |  2 +-

Please split the driver change and config/dts change in different patch.


Thanks,
- Kever
>   3 files changed, 70 insertions(+), 1 deletion(-)
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
> index 768a37393290..fc4c140ab970 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -4,6 +4,7 @@
>    */
>   
>   #include <dm.h>
> +#include <misc.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/arch-rockchip/bootrom.h>
>   #include <asm/arch-rockchip/grf_rk3568.h>
> @@ -133,3 +134,67 @@ int arch_cpu_init(void)
>   #endif
>   	return 0;
>   }
> +
> +#define RK3568_OTP_CPU_CODE_OFFSET		0x02
> +#define RK3568_OTP_SPECIFICATION_OFFSET		0x07
> +#define RK3568_OTP_CPU_VERSION_OFFSET		0x08
> +#define RK3568_OTP_PERFORMANCE_OFFSET		0x22
> +
> +int checkboard(void)
> +{
> +	u8 cpu_code[2], specification, package, cpu_version, performance;
> +	struct udevice *dev;
> +	char suffix[3];
> +	int ret;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		debug("%s: could not find otp device, ret=%d\n", __func__, ret);
> +		return 0;
> +	}
> +
> +	/* cpu-code: SoC model, 0x35 0x66 or 0x35 0x68 */
> +	ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		debug("%s: could not read cpu-code, ret=%d\n", __func__, ret);
> +		return 0;
> +	}
> +
> +	/* specification: SoC variant, 0x2 for RK3568B2 and 0xA for RK3568J */
> +	ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +	if (ret < 0) {
> +		debug("%s: could not read specification, ret=%d\n", __func__, ret);
> +		return 0;
> +	}
> +	/* package: likely SoC variant revision, 0x2 for RK3568B2 */
> +	package = specification >> 5;
> +	specification &= 0x1f;
> +
> +	/* cpu-version: chip version, e.g. second letter of lot number */
> +	ret = misc_read(dev, RK3568_OTP_CPU_VERSION_OFFSET, &cpu_version, 1);
> +	if (ret < 0) {
> +		debug("%s: could not read cpu-version, ret=%d\n", __func__, ret);
> +		return 0;
> +	}
> +	cpu_version >>= 3;
> +	cpu_version &= 0x7;
> +
> +	/* performance: used to identify RK3566T SoC variant */
> +	ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
> +	if (ret < 0) {
> +		debug("%s: could not read performance, ret=%d\n", __func__, ret);
> +		return 0;
> +	}
> +	if (performance & 0x0f)
> +		specification = 0x14; /* T-variant */
> +
> +	suffix[0] = specification > 1 ? '@' + specification : 0;
> +	suffix[1] = package > 1 ? '0' + package : 0;
> +	suffix[2] = 0;
> +
> +	printf("SoC:   RK%02x%02x%s v%u\n",
> +	       cpu_code[0], cpu_code[1], suffix, cpu_version);
> +
> +	return 0;
> +}
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index 1d06f3411fe0..f79f0e84400b 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
>   CONFIG_LEGACY_IMAGE_FORMAT=y
>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>   # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x40000
>   CONFIG_SPL_PAD_TO=0x7f8000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> @@ -31,6 +30,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>   CONFIG_SPL_ATF=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_ROCKUSB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
