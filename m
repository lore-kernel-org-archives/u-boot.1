Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A08FC4828F
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 04:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6607587B7F;
	Sun,  4 Feb 2024 05:22:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="dTeBkJp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC55C87B8E; Sun,  4 Feb 2024 05:21:58 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B1F87B7F
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 05:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707020515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VV27no8TbV+KZb7wWUE3yWfzaKwm1hkMiO9fIZArBkQ=;
 b=dTeBkJp3NTEnEAFSHm3PEmJq5F2DzfELb7+Jqe8i/mTFfDU0OjRyxkLKF/dZ/n4tMKpwNz
 losGtKEEFCDz5ZSs9PAj4f4jubVjQJOgZ3QecOFnkXD0dsNeoU5+doEFRHmBZRbLC5fhoe
 ouBrsl7x/OsU0PXQUXidPhNmeEeVxszvx6xXBeFwEjixX4MHDlIu/YT3i1m7xgfRW3ESza
 F2Sgtl7O5R3sGr8HKe9ew7H0+oqngxatcUjXiFY3hYHK1Xfc7r9lTYsiMJ0xEN7XaJTdsq
 Z7m0fhoSONS1vLY+jBBgAtLiwQjG3vX1dRfGM6gotVBFjW+m76Wit+7kSP4FHQ==
Date: Sun, 04 Feb 2024 05:21:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, Jagan
 Teki <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 08/18] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <30c40f7596affef5899099ce68eb96c1@manjaro.org>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
 <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
 <be58f85e-5564-4b10-aa24-cb4d794cc09b@kwiboo.se>
 <30c40f7596affef5899099ce68eb96c1@manjaro.org>
Message-ID: <a6a4a7c3060542f030c9fed2f253400e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
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

On 2024-02-03 16:18, Dragan Simic wrote:
> On 2024-02-03 15:18, Jonas Karlman wrote:
>> On 2024-02-03 14:19, Dragan Simic wrote:
>>> Please see my comments below.
>>> 
>>> On 2024-01-23 15:49, Quentin Schulz wrote:
>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> 
>>>> Only setup_iodomain() differs from the original misc_init_r from
>>>> Rockchip mach code, so let's use rockchip_early_misc_init_r instead 
>>>> of
>>>> reimplementing the whole misc_init_r from Rockchip.
>>> 
>>> Your patches from this series are fine, but the trouble is that
>>> we end up executing rockchip_setup_macaddr() for the devices
>>> that don't use the RK3339's built-in Gigabit Ethernet interface,
>>> which includes the Pinebook Pro and the Pinephone Pro.
>> 
>> The rockchip_setup_macaddr() is not just for integrated ethernet
>> interface. The main purpose is to have a reliably mac address assigned
>> to any device assigned to the ethernet0/ethernet1 alias in the device
>> tree, see fdt_fixup_ethernet().
> 
> Sure, I had already checked fdt_fixup_ethernet() before commenting.
> 
> As a note, there are no ethernetX aliases in the Pinebook Pro and
> Pinephone Pro dts files, or at least there will be none eventually,
> as the redundant aliases have already been removed in the Linux
> kernel. [1]  No such aliases means that fdt_fixup_ethernet() should
> end up doing nothing.
> 
>>> We should add more ifdef guards to rockchip_setup_macaddr(),
>>> to prevent the execution of its body for devices such as the
>>> ones listed above, which eliminates the unneeded code from the
>>> resulting U-Boot images, making them a bit smaller, and saves
>>> some CPU cycles and a bit of time on boot.  It also prevents
>>> the unneeded "ethaddr" and "eth1addr" variables from being
>>> added to the environment.
>> 
>> Adding the ethernet addresses only adds a few ms to boot, if you care
>> about boot speed, please look into if we can disable 
>> CONFIG_USE_PREBOOT
>> for these boards, running "usb start" as preboot adds several seconds 
>> to
>> the boot.
> 
> I see, but I personally don't care that much about how long the
> U-Boot takes to execute;  a couple of seconds more don't bother me
> much.  I care more about excluding the unneded code.
> 
>>> The patch below should do the trick, which also performs a few
>>> small code cleanups for additional file-level consistency:
>>> 
>>> diff --git a/arch/arm/mach-rockchip/misc.c
>>> b/arch/arm/mach-rockchip/misc.c
>>> index 7d03f0c2b679..ed5bdab5a648 100644
>>> --- a/arch/arm/mach-rockchip/misc.c
>>> +++ b/arch/arm/mach-rockchip/misc.c
>>> @@ -23,7 +23,8 @@
>>> 
>>>   int rockchip_setup_macaddr(void)
>>>   {
>>> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
>>> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
>>> +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)
>> 
>> This would exclude any board not enabling GMAC_ROCKCHIP in U-Boot but
>> want a mac-address being set in DT fixup. And for newer RK35xx SoCs 
>> the
>> GMAC_ROCKCHIP driver is not used.
> 
> Thanks for pointing that out.  Not good.
> 
>> A new Kconfig option should be introduced if there is a need for some
>> boards to disable this.
> 
> Is there any simpler way to achieve that?  If there isn't, perhaps
> we could leave rockchip_setup_macaddr() generate the MAC address
> and rely on fdt_fixup_ethernet() ending up doing nothing when no
> ethernetX aliases exist.

After going through the source code once again, I think that adding
new configuration option would be warranted, because it would exclude
two sizable chunks of code from the resulting U-Boot images, and
because it would avoid polluting the environment with a couple of
unneeded variables.

I'll go ahead and implement this, and I hope that the patch will be
received well.

>>>   	int ret;
>>>   	const char *cpuid = env_get("cpuid#");
>>>   	u8 hash[SHA256_SUM_LEN];
>>> @@ -64,15 +65,15 @@ int rockchip_cpuid_from_efuse(const u32
>>> cpuid_offset,
>>>   			      const u32 cpuid_length,
>>>   			      u8 *cpuid)
>>>   {
>>> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) ||
>>> IS_ENABLED(CONFIG_ROCKCHIP_OTP)
>>> +#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE) ||
>> 
>> This changes behavior and is wrong. IS_ENABLED check for specific 
>> config
>> flag, CONFIG_IS_ENABLED would check for e.g. CONFIG_SPL_ROCKCHIP_EFUSE
>> or similar.
> 
> Sorry, my bad, somehow I managed to forget that.  Thanks for
> pointing that out.
> 
>>> CONFIG_IS_ENABLED(ROCKCHIP_OTP)
>>>   	struct udevice *dev;
>>>   	int ret;
>>> 
>>>   	/* retrieve the device */
>>> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
>>> +#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE)
>> 
>> Same as above.
>> 
>>>   	ret = uclass_get_device_by_driver(UCLASS_MISC,
>>>   					  DM_DRIVER_GET(rockchip_efuse), &dev);
>>> -#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
>>> +#elif CONFIG_IS_ENABLED(ROCKCHIP_OTP)
>> 
>> Same as above.
>> 
>> Regards,
>> Jonas
>> 
>>>   	ret = uclass_get_device_by_driver(UCLASS_MISC,
>>>   					  DM_DRIVER_GET(rockchip_otp), &dev);
>>>   #endif
>>> 
>>>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>> ---
>>>>  board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20
>>>> ++------------------
>>>>  1 file changed, 2 insertions(+), 18 deletions(-)
>>>> 
>>>> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>> b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>> index d79084614f1..d0a694ead1d 100644
>>>> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>> +++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>> @@ -11,7 +11,6 @@
>>>>  #include <asm/arch-rockchip/clock.h>
>>>>  #include <asm/arch-rockchip/grf_rk3399.h>
>>>>  #include <asm/arch-rockchip/hardware.h>
>>>> -#include <asm/arch-rockchip/misc.h>
>>>> 
>>>>  #define GRF_IO_VSEL_BT565_SHIFT 0
>>>>  #define PMUGRF_CON0_VSEL_SHIFT 8
>>>> @@ -31,26 +30,11 @@ static void setup_iodomain(void)
>>>>  	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>>>>  }
>>>> 
>>>> -int misc_init_r(void)
>>>> +int rockchip_early_misc_init_r(void)
>>>>  {
>>>> -	const u32 cpuid_offset = 0x7;
>>>> -	const u32 cpuid_length = 0x10;
>>>> -	u8 cpuid[cpuid_length];
>>>> -	int ret;
>>>> -
>>>>  	setup_iodomain();
>>>> 
>>>> -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, 
>>>> cpuid);
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>> -	ret = rockchip_setup_macaddr();
>>>> -
>>>> -	return ret;
>>>> +	return 0;
>>>>  }
>>>> 
>>>>  #endif
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d90cb1edcf7c1854e4cecb52871421f29d3d849
