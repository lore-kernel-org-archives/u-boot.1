Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F3FC54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 09:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2802187EF5;
	Mon, 11 Mar 2024 10:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gvaRKVW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64B1487EF5; Mon, 11 Mar 2024 10:07:27 +0100 (CET)
Received: from mail-m49211.qiye.163.com (mail-m49211.qiye.163.com
 [45.254.49.211])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E49B8786A
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 10:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=gvaRKVW3UZF73fekFhIeOsn0aT/s3Wdd7G4CoS4ACHlZtzqxaDcgcb64Tq7HVS04FGCnbciBGR6zaTTbA84Nt5dSl3cQ47WMomO4uiL33AebTJ2ZtRjKC0QvXoyymQxIjvxwMszeMqK4MalBzcfn2MEdSW2YrCPPaWgNG1Fe8eA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=7+v8tVehVxY5YhqT2rUvbvuNA7YxtYFXePRl5KcZ+eU=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 757E590035C;
 Mon, 11 Mar 2024 17:07:02 +0800 (CST)
Message-ID: <86148f4a-71f7-4838-be44-11dd2e26c6d0@rock-chips.com>
Date: Mon, 11 Mar 2024 17:07:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/20] rockchip: rk3588: fix non-working SD controller
 if booting from other media
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, Andy Yan
 <andy.yan@rock-chips.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>
Cc: Dragan Simic <dsimic@manjaro.org>, u-boot@lists.denx.de
References: <20240221-jaguar-v3-0-1f256a82201b@theobroma-systems.com>
 <20240221-jaguar-v3-11-1f256a82201b@theobroma-systems.com>
 <343de261-41af-47e1-8434-ae0841757280@rock-chips.com>
 <5336cf3b-96a8-4b89-a914-9bcb7e489f9c@theobroma-systems.com>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <5336cf3b-96a8-4b89-a914-9bcb7e489f9c@theobroma-systems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlOGlZJTksZGBoYGkxNHU5VEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8e2cc3f52003a9kunm757e590035c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Kxw4DzMRFjALPgIIKT49
 SUtPCkxVSlVKTEpLSk9DS0lPS09MVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFNTENDNwY+
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

Hi Quentin,

On 2024/3/9 01:55, Quentin Schulz wrote:
> Hi Kever,
>
> On 3/8/24 11:05, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2024/2/21 18:37, Quentin Schulz wrote:
>>> From: Quentin Schulz<quentin.schulz@theobroma-systems.com>
>>>
>>> Rockchip SoCs have some jtag/sdmmc autoswitching that simply doesn't
>>> work really well.[00] The Linux kernel disables it for all SoCs[01], so
>>> U-Boot needs to do the same in order to fix issues related to SD 
>>> card on
>>> RK3588. This autoswitching is enabled (by default) via the force_jtag
>>> bitfield in SYS_GRF_SOC_CON6 in the TRM part1.
>>>
>>> The conditions to enter forced JTAG mode are the following:
>>> - force_jtag is 1
>>> - GPIO4_D2 is muxed for SDMMC function
>>> - GPIO3_D3 is muxed for SDMMC function
>>> - SDMMC_DET is inactive
>>
>> I have explain the reason and send fix for other boards  in kernel 
>> for why the force jtag
>>
>> function not working correctly, see patch [1] and I copy the commit 
>> message here:
>>
>> RK3588 has force_jtage feature which is enable JTAG function via sdmmc
>> pins automatically when there is no SD card insert, this feature will
>> need the GPIO0A4 works in sdmmc_det function like other mmc signal 
>> instead
>> of GPIO function, or else the force_jtag can not auto be disabled when
>> SD card insert.
>>
>> For the rk3588 boards available on mainline kernel, 10 boards enable 
>> SD card function
>> and 9 of then use GPIO0A4 as sdmmc_det, they should all able to use 
>> the force_jtag after
>> my patch apply.
>> The jaguar-rk3588 still have the issue because there is no sdmmc_det 
>> used.
>> The condition of force JTAG mode work correctly is :
>> - force_jtag in grf is 1;
>> - all the SDMMC signal including SDMMC_DET set as SDMMC function in 
>> GRF IOC/IOMUX reg;
>>
>> So please update the commit message and it would be better to move 
>> this setting in jaguar-rk3588 board
>
> Thanks, it's a tiny bit clearer to me now. We never exit this JTAG 
> mode on Jaguar because we have GPIO0A4 floating (with internal 
> pull-down). On Tiger (patches coming this month I hope), it's 
> hardwired to ground but we use a different GPIO as card detect, so 
> we'll have a similar issue. In any case, thanks for the explanation.
>
> Though, I do not understand why you absolutely want this force_jtag to 
> be always enabled. It is a debug feature.

You are right, it's not correct to always enabled for this debug 
feature. Let's leave this as rk3588 common code.

I will add some document in rockchip.rst for people to enable this 
feature easier, this feature also important for some project during develop.


Thanks,
- Kever


>
> Even more so, this is a security issue. I don't think anyone wants to 
> have the JTAG enabled if the user plays with the card detect pin or 
> boot without an SD card connected. I really insist this should be 
> enabled on the SoC level, the same way that the Linux kernel does it.
>
> We could compromise on a Kconfig symbol to enable force_jtag for 
> people who want it but still default to disabled on the SoC level, but 
> I'm not really seeing a reason for it.
>
>> so that other board can enable force_jtag with only modify kernel but 
>> not both kernel and U-Boot.
>>
> If you want JTAG support in U-Boot, you would patch U-Boot. If you 
> want JTAG support in the kernel, you would patch the kernel. If you 
> want it in both, you'd patch both. I'm not sure to understand what 
> disabling force_jtag in U-Boot has to do with force_jtag enabled from 
> the Linux kernel, what am I missing here?
>
> Cheers,
> Quentin
