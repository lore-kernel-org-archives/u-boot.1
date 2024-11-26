Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58766D5A6DF
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80D988916D;
	Tue, 26 Nov 2024 06:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4201889229; Tue, 26 Nov 2024 06:24:35 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FC288F48
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:24:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1732598642tle5mca
X-QQ-Originating-IP: bTKN7QTfwgu4xYPZ56RgYm933hoHGxVys51XAF0DLLU=
Received: from [IPV6:240f:10b:7440:1:4b4e:609c ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Nov 2024 13:23:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1839713764897788090
Message-ID: <3DE1121FC064812D+0e03e5c7-0ac3-4849-8db5-c78871de6461@radxa.com>
Date: Tue, 26 Nov 2024 14:23:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] rockchip: rk356x: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241110005622.1515100-1-jonas@kwiboo.se>
 <20241110005622.1515100-2-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241110005622.1515100-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OSjQccS6YHkH2WwCnp2h2sLSjRsuOx8Q3TsTXq7iNxYlTsem4dQFVk6g
 4V58de96UAX45Z4f/3i57y0UyQSbKz6+N0ZlYjeIhNQX969RUMlwrbSWODzqnlomaQYpdm5
 lDnFgEIW6vnFE1VZnHrSN+uLh0m2foT8Y03oqKqUqyjvhGKFmoDsfiRDX2HSKjrDpgzK3bh
 gGgCQqmHtWpoQLGwPdwwJ/7CqeUVKki7qxm4V+KrPpUO7DJs7N0t74+0MkCBouqf1p/5Mbi
 KMgg78gngPTkLqyMYIFMoifAigdJJEzDf1GFlkpfvEeKLW/Iopft98WPZz7oPtGwaXN+DBm
 +XpnS9y6bYXdWeWymut0jfOJErZezzYA8LmSOrdTQ609Xozd9qW7azHwy9SXpPdV8fblRxu
 q33OjZggJv4dYrTISoA5PQ535MhZpOmLJfUIC341Wuhj4K1hhcrjAO877BmM/Cslud/5uAo
 FB7VGb1HoK+4vpUeOp6BGEFnyFU/DV2s1zyPWPrTmodRu7jnZlvWbSTwEnNnxIfQ8CoThHm
 PtNxY05wDqRcsNHW/IF5cKOahZ7AY81dh7i9UZOkZ9skfO6W6p68yYoa94gs7746U07b5Gx
 ExGW+MN/DJdU4RbQHSpC6YFvO08nQ/9Nbo3dLD3fPm5MXy8yxTZdGZ+L2kKWOygHCzwiXy6
 cesDJi51JqPanA3hqSVbITegnAp4ERp2u05hM62n0U9PjVRBejqkINO9E4vTYaEZJXqdScx
 vK1Lyqk/RGvDYvbNZ34Dc+KdNIXapXrZJJExiphcmyMQSCyCWmtcihWewa+xLPHN/TkzZct
 yKwIN9hpJ3qnW1l6RDSeZ4hlyb/2pKL7jEejaCS0BG4UHnr4pO6NpIOo4dkZA247OEL77qT
 dqF98Qv8ZHdxBIsZ7HWayTE+e3w/v9SKOcWmII3I4BXtmoRMj2FlXJu0t5sgb+KMaGnN/ee
 6j8+ARjxxmnp8OA==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

Hi,

On 11/10/24 09:56, Jonas Karlman wrote:
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

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

SoC:   RK3566
SoC:   RK3566T
SoC:   RK3568
SoC:   RK3568J

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

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


