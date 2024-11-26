Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B403FD5A6E2
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 05:26:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E0D089C08;
	Tue, 26 Nov 2024 06:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BC789246; Tue, 26 Nov 2024 06:26:30 +0100 (CET)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9365689C08
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 06:26:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip2t1732598741t6ld6ih
X-QQ-Originating-IP: YCxBmHud+zUsUkKopsOqlJCQwKXhjG69iGjqf7OUdBA=
Received: from [IPV6:240f:10b:7440:1:4b4e:609c ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 26 Nov 2024 13:25:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12239547996556703232
Message-ID: <C2F8685E6A88BF16+dabe18c4-bc74-4d46-82f4-91a02eaf6acc@radxa.com>
Date: Tue, 26 Nov 2024 14:25:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] rockchip: rk3588: Implement checkboard() to print
 SoC variant
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20241110005622.1515100-1-jonas@kwiboo.se>
 <20241110005622.1515100-3-jonas@kwiboo.se>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241110005622.1515100-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NrWo12kCQiBo5w6ocXRuBRWUJK3JMAkXVykCr2QXYW8DVUicweHEpb+i
 yu9Dr9QGqf4vkVShXTn7L9PAXaH0fzkiziN/+IBShV4n2Y7weVx72xboDVOY8DKSCgXLgvJ
 UMXyO/+ew85tgUTpK9sw9ik6bLxLJEpD0RcYTyGKW6NhCRg+JAOJlXFrZyzug0054FkQZLJ
 lcToaUCIm02fKgapqS+tdjLrL7yJcl95qhJvzo0x4SuXOHLc5tHbZgTEZ8wC5V/w5poxm+o
 6rf8H0YmCUGteMj8yzgSnvwDlwHEfLO/DDsgABFlp1Vd+JE1d4e71SjN5K4iijxOMXRRrC9
 aC36q+Mr4dJPVllkbWzOQi/rVUyIGpCpZMiAoZrEZ4qy7MOgFICZ7QqBlinZYK8Ysq6TIga
 iukzQ6kjz2gj9OROespOFupit6TkY+4yplZkueEy0RVUBoCitRS2skf3SbHiTSgCRcrhN33
 5b/vUqFFvAIeGjVW7uBuymGnkrbo/+zAx1wit27YIDTzPJ2NiA4drclHgbiFI+NH32N3Suw
 nZKkPb6WKuLecRFeuV5OGKEV2tlNvHo40SYGxlOMkIhw2/C0jt7/FnZkOu0FGiK+C9HHXsH
 qKAnvhYIslNe9QxARkky3IG4P5YTFm9o25mSwNuMdUD+jKal/0LILNIVL1bNBCyJoDvEuaW
 Ugxp8ZS5jl+4BMVq/NsNQqPaZQvii8SOa8W1ZXi7GeSYUHJRnXU/C0tc9RsCVg42UNl1ljO
 1UfCOK/rS94isMeac9Lezi9/0EwxWpo3CzixWIeqHCai5d+ON/bgidm89oYgfFt+5u4hBn0
 E7OegqPeMz3JYd0mX9y0nzvRHHzcW5tR1ea0yLEt/cBJJJqxZ3EEk8ebzdDc6kMwS0rPtyh
 dL906QdfdoOHfI6U90WYa2DpRQAUHeOSp6XwohATKkk+ICM+y4ioJtWQ0vyLfFUBaaRQhJt
 EjwkEnFJUIEWt4ZSF/TVejEe190Cpu/7MgvuCvlMCqj1nQtmf78ihdMERe1nmBTf3p3M=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

SoC:   RK3582
SoC:   RK3588
SoC:   RK3588S
SoC:   RK3588S2

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

