Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D82A3C48297
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 12:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4221B87C77;
	Tue,  6 Feb 2024 13:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="oi8r/LpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BABBD87C56; Tue,  6 Feb 2024 13:42:41 +0100 (CET)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E17887CB5
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 13:42:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1707223358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cCfe44feBIbDX5hugX28hbnLaUwL9e+1px3XoxO6E0=;
 b=oi8r/LpEu7f9yku+mj2V7/5uXRaPZgN4N4u7HWdiha3uwKwY8DLH77FjjrV1T2quFNbJZ5
 JZv99NGl9SZX09RiUGFml4dVKNcGl2XDji5a9ssPjysKjKh8XVTxMZJkdp4VgVw3NLifNs
 h6xmkZcOOkMKpIRIyk8AfoOcBGP+CMwYQNVjn3x+/dI2323nXLm8awo8znFDj+2Mv9aCth
 oUemPda1h/ZM3AHGjmIFCH1r/vqZK3Xwv6Qb8MIljfYKOJO3jFNpr8gqk6k9xFAXdhT9d8
 VARNcpV7p7zPvkTFsm0oj6tdEUr2QUselqGzS+yvp7tqUsHTbgMeI96asXtLxQ==
Date: Tue, 06 Feb 2024 13:42:38 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>, Klaus Goger
 <klaus.goger@theobroma-systems.com>, Heiko Stuebner
 <heiko.stuebner@cherry.de>, Otavio Salvador <otavio@ossystems.com.br>, Andy
 Yan <andy.yan@rock-chips.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin
 <agust@denx.de>, heiko@sntech.de, u-boot@lists.denx.de
Subject: Re: [PATCH 08/18] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
In-Reply-To: <90ff670b-7b77-4d7b-89b4-9a05d68b79bc@theobroma-systems.com>
References: <20240123-jaguar-v1-0-1eec1c34953c@theobroma-systems.com>
 <20240123-jaguar-v1-8-1eec1c34953c@theobroma-systems.com>
 <0d74e5e5482cd32d7cad714e731d4fb8@manjaro.org>
 <be58f85e-5564-4b10-aa24-cb4d794cc09b@kwiboo.se>
 <30c40f7596affef5899099ce68eb96c1@manjaro.org>
 <a6a4a7c3060542f030c9fed2f253400e@manjaro.org>
 <baa5cbee-dceb-4398-9b16-2c69473611d5@kwiboo.se>
 <d031fbe4cca9d1c43a6a6dd9c0ae56eb@manjaro.org>
 <22c1f0e5-58d5-46c5-865e-0e1be7f84c55@theobroma-systems.com>
 <2871f780d35019772d1a3ffa0abd16e7@manjaro.org>
 <90ff670b-7b77-4d7b-89b4-9a05d68b79bc@theobroma-systems.com>
Message-ID: <d65b0fe6ddee07b0c2dac006fe06cc17@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
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

On 2024-02-06 13:37, Quentin Schulz wrote:
> On 2/6/24 13:33, Dragan Simic wrote:
>> On 2024-02-06 13:26, Quentin Schulz wrote:
>>> On 2/4/24 11:39, Dragan Simic wrote:
>>>> On 2024-02-04 10:46, Jonas Karlman wrote:
>>>>> On 2024-02-04 05:21, Dragan Simic wrote:
>>>>>> On 2024-02-03 16:18, Dragan Simic wrote:
>>>>>>> On 2024-02-03 15:18, Jonas Karlman wrote:
>>>>>>>> On 2024-02-03 14:19, Dragan Simic wrote:
>>>>>>>>> We should add more ifdef guards to rockchip_setup_macaddr(),
>>>>>>>>> to prevent the execution of its body for devices such as the
>>>>>>>>> ones listed above, which eliminates the unneeded code from the
>>>>>>>>> resulting U-Boot images, making them a bit smaller, and saves
>>>>>>>>> some CPU cycles and a bit of time on boot.  It also prevents
>>>>>>>>> the unneeded "ethaddr" and "eth1addr" variables from being
>>>>>>>>> added to the environment.
>>>>>>>> 
>>>>>>>> Adding the ethernet addresses only adds a few ms to boot, if you
>>>>>>>> care
>>>>>>>> about boot speed, please look into if we can disable
>>>>>>>> CONFIG_USE_PREBOOT
>>>>>>>> for these boards, running "usb start" as preboot adds several
>>>>>>>> seconds
>>>>>>>> to the boot.
>>>>>>> 
>>>>>>> I see, but I personally don't care that much about how long the
>>>>>>> U-Boot takes to execute;  a couple of seconds more don't bother 
>>>>>>> me
>>>>>>> much.  I care more about excluding the unneded code.
>>>>>>> 
>>>>>>>>> The patch below should do the trick, which also performs a few
>>>>>>>>> small code cleanups for additional file-level consistency:
>>>>>>>>> 
>>>>>>>>> diff --git a/arch/arm/mach-rockchip/misc.c
>>>>>>>>> b/arch/arm/mach-rockchip/misc.c
>>>>>>>>> index 7d03f0c2b679..ed5bdab5a648 100644
>>>>>>>>> --- a/arch/arm/mach-rockchip/misc.c
>>>>>>>>> +++ b/arch/arm/mach-rockchip/misc.c
>>>>>>>>> @@ -23,7 +23,8 @@
>>>>>>>>> 
>>>>>>>>>   int rockchip_setup_macaddr(void)
>>>>>>>>>   {
>>>>>>>>> -#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256)
>>>>>>>>> +#if CONFIG_IS_ENABLED(HASH) && CONFIG_IS_ENABLED(SHA256) && \
>>>>>>>>> +    CONFIG_IS_ENABLED(GMAC_ROCKCHIP)
>>>>>>>> 
>>>>>>>> This would exclude any board not enabling GMAC_ROCKCHIP in 
>>>>>>>> U-Boot
>>>>>>>> but
>>>>>>>> want a mac-address being set in DT fixup. And for newer RK35xx
>>>>>>>> SoCs
>>>>>>>> the
>>>>>>>> GMAC_ROCKCHIP driver is not used.
>>>>>>> 
>>>>>>> Thanks for pointing that out.  Not good.
>>>>>>> 
>>>>>>>> A new Kconfig option should be introduced if there is a need for
>>>>>>>> some
>>>>>>>> boards to disable this.
>>>>>>> 
>>>>>>> Is there any simpler way to achieve that?  If there isn't, 
>>>>>>> perhaps
>>>>>>> we could leave rockchip_setup_macaddr() generate the MAC address
>>>>>>> and rely on fdt_fixup_ethernet() ending up doing nothing when no
>>>>>>> ethernetX aliases exist.
>>>>> 
>>>>> As Chen-Yu Tsai pointed out in one of my prior patches [2]:
>>>>> 
>>>>>  The user might be loading a custom FDT for the kernel, or have DT
>>>>>  overlays stacked on, either could have the "ethernet1" alias while
>>>>>  the U-boot DT doesn't.
>>>>> 
>>>>> So the common rockchip_setup_macaddr() cannot rely on checking for
>>>>> ethernetX alias, because the fixup may not run against the bundled
>>>>> DT.
>>>>> 
>>>>> [2]
>>>>> https://lore.kernel.org/u-boot/CAGb2v66hR5e3nBPZ0C3=h29fS4Um7whfBu7XTAi1sRbzXRAPxg@mail.gmail.com/
>>>> 
>>>> I see, we unfortunately cannot know the final outcome in advance, to
>>>> be able to avoid polluting the environment by adding the "eth1addr"
>>>> variable if it actually isn't needed, for example.
>>>> 
>>>> Though, why can't the user supply an FDT that contains ethernetX
>>>> aliases 0 through 2, for example, in which case we wouldn't provide
>>>> a stable MAC address for ethernet2?  Am I missing something, i.e. is
>>>> there something preventing an ethernet2 alias from being present?
>>>> 
>>>>>> After going through the source code once again, I think that 
>>>>>> adding
>>>>>> new configuration option would be warranted, because it would
>>>>>> exclude
>>>>>> two sizable chunks of code from the resulting U-Boot images, and
>>>>>> because it would avoid polluting the environment with a couple of
>>>>>> unneeded variables.
>>>>> 
>>>>> Yes a new Kconfig option would be preferred.
>>>>> 
>>>>>> I'll go ahead and implement this, and I hope that the patch will 
>>>>>> be
>>>>>> received well.
>>>>> 
>>>>> Great :-)
>>>> 
>>>> Thanks. :)  Got it implemented already and tested a bit.  I need to
>>>> write the patch and series summaries, and I'll send them over.
>>>> 
>>>> Regarding the above-described uncertainty about what ethernetX 
>>>> aliases
>>>> the final FDT containts, I'd say that ignoring the ethernetX aliases
>>>> completely for the Pinebook Pro and the Pinephone Pro is safe and
>>>> valid,
>>>> because those are actual devices, instead of being development 
>>>> boards
>>>> for which the final hardware configuration is determined by the 
>>>> user.
>>>> I can hardly see anyone adding an Ethernet interface to them, except
>>>> by plugging in a USB Ethernet dongle.
>>>> 
>>>> I hope you agree.
>>> 
>>> What should be done with the patches for Pinephone/Pinebook Pro then?
>>> Since I was asked to wait on your answer/patches before respinning 
>>> the
>>> patch series, I would like to know what to do with them :) Drop the
>>> patches for now or keep them as is?
>> 
>> Your patches are fine, just please update their subjects as I already
>> suggested.  The patches I'll send a bit later will resolve the issues
>> I raised previously for your patches, together with doing a bit more,
>> so there's no need to change your patches further.
> 
> I would rather not break devices if I have a choice. Is merging those
> patches without yours going to break those devices?

Don't worry, I don't see how they could end up broken that way.  There
should only be some redundant code built into the resulting U-Boot 
images,
and some redundant variables added to the environment at runtime.
