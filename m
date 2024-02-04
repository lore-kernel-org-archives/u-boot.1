Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711D8C48286
	for <u-boot@archiver.kernel.org>; Sun,  4 Feb 2024 10:39:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71ABB87AEC;
	Sun,  4 Feb 2024 11:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="aLeXIUoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5D5587B98; Sun,  4 Feb 2024 11:39:16 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4981987AEC
 for <u-boot@lists.denx.de>; Sun,  4 Feb 2024 11:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707043153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZG7pVxTJzjjuOJLLH2l58xGmUx587aXpvStGs/vS0Tk=;
 b=aLeXIUoyxJXXdDEs3h/OZ/8gSg/usagH95DJLS3WzZv7Fmu4UkllsPkjRlmLbGRaF9r6Qf
 z1Rp0QBXYGmLW8i6op6dhuoiyWRXnOs3qOsh5nNv5E+S0jeX6mxPC7WvifnnQgE1jmhNTy
 JnCnafRL8vE7dATwi/RxynZxEdNnmOhWTsSNzuJkqSVAj2FJFk8LEjqql6i1RIDv4ytEhj
 U4R3dCXA7pjk/RBCTPcB49KZhKHc9mBkELKle5aydXhpFk/OnZS0dnuh4RCAAwoFOCPBd7
 /NRUfGTTovGJKdxx0XTZBp9SjYcI3uHgh+sEaps5BWBRyqYzCwMoo2rDP7tl/w==
Date: Sun, 04 Feb 2024 11:39:11 +0100
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
In-Reply-To: <baa5cbee-dceb-4398-9b16-2c69473611d5@kwiboo.se>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
 <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
 <be58f85e-5564-4b10-aa24-cb4d794cc09b@kwiboo.se>
 <30c40f7596affef5899099ce68eb96c1@manjaro.org>
 <a6a4a7c3060542f030c9fed2f253400e@manjaro.org>
 <baa5cbee-dceb-4398-9b16-2c69473611d5@kwiboo.se>
Message-ID: <d031fbe4cca9d1c43a6a6dd9c0ae56eb@manjaro.org>
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

Hello Jonas,

On 2024-02-04 10:46, Jonas Karlman wrote:
> On 2024-02-04 05:21, Dragan Simic wrote:
>> On 2024-02-03 16:18, Dragan Simic wrote:
>>> On 2024-02-03 15:18, Jonas Karlman wrote:
>>>> On 2024-02-03 14:19, Dragan Simic wrote:
>>>>> We should add more ifdef guards to rockchip_setup_macaddr(),
>>>>> to prevent the execution of its body for devices such as the
>>>>> ones listed above, which eliminates the unneeded code from the
>>>>> resulting U-Boot images, making them a bit smaller, and saves
>>>>> some CPU cycles and a bit of time on boot.  It also prevents
>>>>> the unneeded "ethaddr" and "eth1addr" variables from being
>>>>> added to the environment.
>>>> 
>>>> Adding the ethernet addresses only adds a few ms to boot, if you 
>>>> care
>>>> about boot speed, please look into if we can disable 
>>>> CONFIG_USE_PREBOOT
>>>> for these boards, running "usb start" as preboot adds several 
>>>> seconds
>>>> to the boot.
>>> 
>>> I see, but I personally don't care that much about how long the
>>> U-Boot takes to execute;  a couple of seconds more don't bother me
>>> much.  I care more about excluding the unneded code.
>>> 
>>>>> The patch below should do the trick, which also performs a few
>>>>> small code cleanups for additional file-level consistency:
>>>>> 
>>>>> diff --git a/arch/arm/mach-rockchip/misc.c
>>>>> b/arch/arm/mach-rockchip/misc.c
>>>>> index 7d03f0c2b679..ed5bdab5a648 100644
>>>>> --- a/arch/arm/mach-rockchip/misc.c
>>>>> +++ b/arch/arm/mach-rockchip/misc.c
>>>>> @@ -23,7 +23,8 @@
>>>>> 
>>>>>   int rockchip_setup_macaddr(void)
>>>>>   {
>>>>> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
>>>>> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
>>>>> +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)
>>>> 
>>>> This would exclude any board not enabling GMAC_ROCKCHIP in U-Boot 
>>>> but
>>>> want a mac-address being set in DT fixup. And for newer RK35xx SoCs
>>>> the
>>>> GMAC_ROCKCHIP driver is not used.
>>> 
>>> Thanks for pointing that out.  Not good.
>>> 
>>>> A new Kconfig option should be introduced if there is a need for 
>>>> some
>>>> boards to disable this.
>>> 
>>> Is there any simpler way to achieve that?  If there isn't, perhaps
>>> we could leave rockchip_setup_macaddr() generate the MAC address
>>> and rely on fdt_fixup_ethernet() ending up doing nothing when no
>>> ethernetX aliases exist.
> 
> As Chen-Yu Tsai pointed out in one of my prior patches [2]:
> 
>  The user might be loading a custom FDT for the kernel, or have DT
>  overlays stacked on, either could have the "ethernet1" alias while
>  the U-boot DT doesn't.
> 
> So the common rockchip_setup_macaddr() cannot rely on checking for
> ethernetX alias, because the fixup may not run against the bundled DT.
> 
> [2] 
> https://lore.kernel.org/u-boot/CAGb2v66hR5e3nBPZ0C3=h29fS4Um7whfBu7XTAi1sRbzXRAPxg@mail.gmail.com/

I see, we unfortunately cannot know the final outcome in advance, to
be able to avoid polluting the environment by adding the "eth1addr"
variable if it actually isn't needed, for example.

Though, why can't the user supply an FDT that contains ethernetX
aliases 0 through 2, for example, in which case we wouldn't provide
a stable MAC address for ethernet2?  Am I missing something, i.e. is
there something preventing an ethernet2 alias from being present?

>> After going through the source code once again, I think that adding
>> new configuration option would be warranted, because it would exclude
>> two sizable chunks of code from the resulting U-Boot images, and
>> because it would avoid polluting the environment with a couple of
>> unneeded variables.
> 
> Yes a new Kconfig option would be preferred.
> 
>> I'll go ahead and implement this, and I hope that the patch will be
>> received well.
> 
> Great :-)

Thanks. :)  Got it implemented already and tested a bit.  I need to
write the patch and series summaries, and I'll send them over.

Regarding the above-described uncertainty about what ethernetX aliases
the final FDT containts, I'd say that ignoring the ethernetX aliases
completely for the Pinebook Pro and the Pinephone Pro is safe and valid,
because those are actual devices, instead of being development boards
for which the final hardware configuration is determined by the user.
I can hardly see anyone adding an Ethernet interface to them, except
by plugging in a USB Ethernet dongle.

I hope you agree.

>>>>>   	int ret;
>>>>>   	const char *cpuid = env_get("cpuid#");
>>>>>   	u8 hash[SHA256_SUM_LEN];
>>>>> @@ -64,15 +65,15 @@ int rockchip_cpuid_from_efuse(const u32
>>>>> cpuid_offset,
>>>>>   			      const u32 cpuid_length,
>>>>>   			      u8 *cpuid)
>>>>>   {
>>>>> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE) ||
>>>>> IS_ENABLED(CONFIG_ROCKCHIP_OTP)
>>>>> +#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE) ||
>>>> 
>>>> This changes behavior and is wrong. IS_ENABLED check for specific
>>>> config
>>>> flag, CONFIG_IS_ENABLED would check for e.g. 
>>>> CONFIG_SPL_ROCKCHIP_EFUSE
>>>> or similar.
>>> 
>>> Sorry, my bad, somehow I managed to forget that.  Thanks for
>>> pointing that out.
>>> 
>>>>> CONFIG_IS_ENABLED(ROCKCHIP_OTP)
>>>>>   	struct udevice *dev;
>>>>>   	int ret;
>>>>> 
>>>>>   	/* retrieve the device */
>>>>> -#if IS_ENABLED(CONFIG_ROCKCHIP_EFUSE)
>>>>> +#if CONFIG_IS_ENABLED(ROCKCHIP_EFUSE)
>>>> 
>>>> Same as above.
>>>> 
>>>>>   	ret = uclass_get_device_by_driver(UCLASS_MISC,
>>>>>   					  DM_DRIVER_GET(rockchip_efuse), &dev);
>>>>> -#elif IS_ENABLED(CONFIG_ROCKCHIP_OTP)
>>>>> +#elif CONFIG_IS_ENABLED(ROCKCHIP_OTP)
>>>> 
>>>> Same as above.
>>>> 
>>>> Regards,
>>>> Jonas
>>>> 
>>>>>   	ret = uclass_get_device_by_driver(UCLASS_MISC,
>>>>>   					  DM_DRIVER_GET(rockchip_otp), &dev);
>>>>>   #endif
>>>>> 
>>>>>> Cc: Quentin Schulz <foss+uboot@0leil.net>
>>>>>> Signed-off-by: Quentin Schulz 
>>>>>> <quentin.schulz@theobroma-systems.com>
>>>>>> ---
>>>>>>  board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20
>>>>>> ++------------------
>>>>>>  1 file changed, 2 insertions(+), 18 deletions(-)
>>>>>> 
>>>>>> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>>>> b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>>>> index d79084614f1..d0a694ead1d 100644
>>>>>> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>>>> +++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
>>>>>> @@ -11,7 +11,6 @@
>>>>>>  #include <asm/arch-rockchip/clock.h>
>>>>>>  #include <asm/arch-rockchip/grf_rk3399.h>
>>>>>>  #include <asm/arch-rockchip/hardware.h>
>>>>>> -#include <asm/arch-rockchip/misc.h>
>>>>>> 
>>>>>>  #define GRF_IO_VSEL_BT565_SHIFT 0
>>>>>>  #define PMUGRF_CON0_VSEL_SHIFT 8
>>>>>> @@ -31,26 +30,11 @@ static void setup_iodomain(void)
>>>>>>  	rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>>>>>>  }
>>>>>> 
>>>>>> -int misc_init_r(void)
>>>>>> +int rockchip_early_misc_init_r(void)
>>>>>>  {
>>>>>> -	const u32 cpuid_offset = 0x7;
>>>>>> -	const u32 cpuid_length = 0x10;
>>>>>> -	u8 cpuid[cpuid_length];
>>>>>> -	int ret;
>>>>>> -
>>>>>>  	setup_iodomain();
>>>>>> 
>>>>>> -	ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length,
>>>>>> cpuid);
>>>>>> -	if (ret)
>>>>>> -		return ret;
>>>>>> -
>>>>>> -	ret = rockchip_cpuid_set(cpuid, cpuid_length);
>>>>>> -	if (ret)
>>>>>> -		return ret;
>>>>>> -
>>>>>> -	ret = rockchip_setup_macaddr();
>>>>>> -
>>>>>> -	return ret;
>>>>>> +	return 0;
>>>>>>  }
>>>>>> 
>>>>>>  #endif
>>> 
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d90cb1edcf7c1854e4cecb52871421f29d3d849
