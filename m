Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7539DC4828D
	for <u-boot@archiver.kernel.org>; Sat,  3 Feb 2024 14:19:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8F948746C;
	Sat,  3 Feb 2024 15:19:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h+qtUyLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB8187873; Sat,  3 Feb 2024 15:19:24 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20EE886C72
 for <u-boot@lists.denx.de>; Sat,  3 Feb 2024 15:19:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=eede=JN=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1706969930;
 bh=dDD1KMI0T4JUwvPLfkqCgIxBnbvBq9WtUV5HHzv+Qsw=;
 b=h+qtUyLkFqzvqlFLpNgAwfwyK5XIoZIo69pqdeuisFf4ZPa32MVKD8OK+mxAkwtEAdrUCsQsJ
 /sejLgXaFyMG6/pnTzmZaR8WEEaONMan7zD1OpqND+bAwqTN1tLHMo/az5wlUZ1zhdcGZqiynTt
 8Nf/GxG17B0U68gF/MAY+S6qUmcR0FvnNmvRnyBz+Vj9//WcHlS+yhmOXnofcSstCiQsRe26Yan
 rbETvQGbAfD/VURkq60NIGfQFjXTALuouMCQ80YHouquZGAqM2bDU/536UXgxV0rjVLy0oZcnM/
 Hx100I/WkEk0QX0coytNfLEDKL4fSq+3IwnQDtEQhm5g==
Message-ID: <be58f85e-5564-4b10-aa24-cb4d794cc09b@kwiboo.se>
Date: Sat, 3 Feb 2024 15:18:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
To: Dragan Simic <dsimic@manjaro.org>, Quentin Schulz
 <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>, Tom
 Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>,
 Andy Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
 <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65be4b496744f7a86928186f
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

Hi Dragan,

On 2024-02-03 14:19, Dragan Simic wrote:
> Hello Quentin,
> 
> Please see my comments below.
> 
> On 2024-01-23 15:49, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> Only setup_iodomain() differs from the original misc_init_r from
>> Rockchip mach code, so let's use rockchip_early_misc_init_r instead of
>> reimplementing the whole misc_init_r from Rockchip.
> 
> Your patches from this series are fine, but the trouble is that
> we end up executing rockchip_setup_macaddr() for the devices
> that don't use the RK3339's built-in Gigabit Ethernet interface,
> which includes the Pinebook Pro and the Pinephone Pro.

The rockchip_setup_macaddr() is not just for integrated ethernet
interface. The main purpose is to have a reliably mac address assigned
to any device assigned to the ethernet0/ethernet1 alias in the device
tree, see fdt_fixup_ethernet().

> 
> We should add more ifdef guards to rockchip_setup_macaddr(),
> to prevent the execution of its body for devices such as the
> ones listed above, which eliminates the unneeded code from the
> resulting U-Boot images, making them a bit smaller, and saves
> some CPU cycles and a bit of time on boot.  It also prevents
> the unneeded "ethaddr" and "eth1addr" variables from being
> added to the environment.

Adding the ethernet addresses only adds a few ms to boot, if you care
about boot speed, please look into if we can disable CONFIG_USE_PREBOOT
for these boards, running "usb start" as preboot adds several seconds to
the boot.

> 
> The patch below should do the trick, which also performs a few
> small code cleanups for additional file-level consistency:
> 
> diff --git a/arch/arm/mach-rockchip/misc.c 
> b/arch/arm/mach-rockchip/misc.c
> index 7d03f0c2b679..ed5bdab5a648 100644
> --- a/arch/arm/mach-rockchip/misc.c
> +++ b/arch/arm/mach-rockchip/misc.c
> @@ -23,7 +23,8 @@
> 
>   int rockchip_setup_macaddr(void)
>   {
> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
> +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)

This would exclude any board not enabling GMAC_ROCKCHIP in U-Boot but
want a mac-address being set in DT fixup. And for newer RK35xx SoCs the
GMAC_ROCKCHIP driver is not used.

A new Kconfig option should be introduced if there is a need for some
boards to disable this.

>   	int ret;
>   	const char *cpuid = env_get("cpuid#");
>   	u8 hash[SHA256_SUM_LEN];
> @@ -64,15 +65,15 @@ int rockchip_cpuid_from_efuse(const u32 
> cpuid_offset,
>   			      const u32 cpuid_length,
>   			      u8 *cpuid)
>   {
> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) || 
> IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> +#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE) || 

This changes behavior and is wrong. IS_ENABLED check for specific config
flag, CONFIG_IS_ENABLED would check for e.g. CONFIG_SPL_ROCKCHIP_EFUSE
or similar.

> CONFIG_IS_ENABLED(ROCKCHIP_OTP)
>   	struct udevice *dev;
>   	int ret;
> 
>   	/* retrieve the device */
> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
> +#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE)

Same as above.

>   	ret = uclass_get_device_by_driver(UCLASS_MISC,
>   					  DM_DRIVER_GET(rockchip_efuse), &dev);
> -#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
> +#elif CONFIG_IS_ENABLED(ROCKCHIP_OTP)

Same as above.

Regards,
Jonas

>   	ret = uclass_get_device_by_driver(UCLASS_MISC,
>   					  DM_DRIVER_GET(rockchip_otp), &dev);
>   #endif
> 
>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>> ---
>>  board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20 
>> ++------------------
>>  1 file changed, 2 insertions(+), 18 deletions(-)
>>
>> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>> b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>> index d79084614f1..d0a694ead1d 100644
>> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>> +++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>> @@ -11,7 +11,6 @@
>>  #include <asm/arch-rockchip/clock.h>
>>  #include <asm/arch-rockchip/grf_rk3399.h>
>>  #include <asm/arch-rockchip/hardware.h>
>> -#include <asm/arch-rockchip/misc.h>
>>
>>  #define GRF_IO_VSEL_BT565_SHIFT 0
>>  #define PMUGRF_CON0_VSEL_SHIFT 8
>> @@ -31,26 +30,11 @@ static void setup_iodomain(void)
>>  	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>>  }
>>
>> -int misc_init_r(void)
>> +int rockchip_early_misc_init_r(void)
>>  {
>> -	const u32 cpuid_offset = 0x7;
>> -	const u32 cpuid_length = 0x10;
>> -	u8 cpuid[cpuid_length];
>> -	int ret;
>> -
>>  	setup_iodomain();
>>
>> -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
>> -	if (ret)
>> -		return ret;
>> -
>> -	ret = rockchip_setup_macaddr();
>> -
>> -	return ret;
>> +	return 0;
>>  }
>>
>>  #endif

