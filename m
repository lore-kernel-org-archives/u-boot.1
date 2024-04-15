Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFC3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 08:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED27388155;
	Mon, 15 Apr 2024 10:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=manjaro.org header.i=@manjaro.org header.b="Rjy8R+1r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5FEF881FB; Mon, 15 Apr 2024 10:21:18 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95E5878ED
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 10:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=manjaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dsimic@manjaro.org
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1713169276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HfXEBvkESfa58U+mQ6VLYmi9GVBUYg1+xyZYGzJED1w=;
 b=Rjy8R+1rd4ELWt+ZHZCX6FZQ5Y1L1p9ZZRe70KR7T2tRk6gMMT6j83t+Jg499x4V3/JcyP
 c6KPtgCFRKXWiukmeorjefyUtI6IYQO5GHxA17i76J3EO8SMwIPgAJGRBkx/nbhkT3DrI1
 wGFxVbhkwOz8HbRmDgLzzfNTpNg1cPnRhXf7mYjgRR+IAMRqrZy0vbEMmxbEUTn2bb9Wd+
 I3eWz7Ol0YBzJmvDORDDLnxj+ltr+796Qvcug2ikCa3DHqnlV8oJV9eSicWmDi5hDARj4m
 4TDpUz8Ux/BbG9QvjkOQxkCKn02y5eZf2a9vMwPJ/xqvsNPsXWFpSF+LT2YHoQ==
Date: Mon, 15 Apr 2024 10:21:14 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Chris Morgan
 <macromorgan@hotmail.com>, Tom Rini <trini@konsulko.com>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 07/23] rockchip: rk35xx: Enable random generator
In-Reply-To: <f4f5d6c8-4d24-420b-a23e-af2ea9629628@kwiboo.se>
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-8-jonas@kwiboo.se>
 <48db0e7566575249499c738bdfc0961c@manjaro.org>
 <f4f5d6c8-4d24-420b-a23e-af2ea9629628@kwiboo.se>
Message-ID: <b56ecf1050aba369c9ebbb8d50effe0e@manjaro.org>
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

On 2024-04-15 10:03, Jonas Karlman wrote:
> On 2024-04-15 08:37, Dragan Simic wrote:
>> Please see a couple of comments below.
>> 
>> On 2024-04-13 20:13, Jonas Karlman wrote:
>>> The RK35xx SoCs contain a crypto engine block that can generate 
>>> random
>>> numbers.
>>> 
>>> Enable rng node in soc u-boot.dtsi and enable Kconfig options to take
>>> advantage of the random generator.
>>> 
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> v2: No change
>>> ---
>>>  arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 6 ------
>>>  arch/arm/dts/rk356x-u-boot.dtsi                | 5 +++++
>>>  arch/arm/dts/rk3588s-u-boot.dtsi               | 1 -
>>>  arch/arm/mach-rockchip/Kconfig                 | 4 ++++
>>>  configs/anbernic-rgxx3-rk3566_defconfig        | 2 --
>>>  5 files changed, 9 insertions(+), 9 deletions(-)
>>> 
>>> diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
>>> b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
>>> index 791f16b206f2..793ed4ae8ae0 100644
>>> --- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
>>> @@ -6,12 +6,6 @@
>>>  	chosen {
>>>  		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
>>>  	};
>>> -
>>> -	rng: rng@fe388000 {
>>> -		compatible = "rockchip,cryptov2-rng";
>>> -		reg = <0x0 0xfe388000 0x0 0x2000>;
>>> -		status = "okay";
>>> -	};
>>>  };
>>> 
>>>  &dsi_dphy0 {
>>> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi
>>> b/arch/arm/dts/rk356x-u-boot.dtsi
>>> index d347080577d9..05367216e118 100644
>>> --- a/arch/arm/dts/rk356x-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
>>> @@ -21,6 +21,11 @@
>>>  		bootph-all;
>>>  	};
>>> 
>>> +	rng: rng@fe388000 {
>>> +		compatible = "rockchip,cryptov2-rng";
>>> +		reg = <0x0 0xfe388000 0x0 0x2000>;
>> 
>> Shouldn't
>> 
>>   +		status = "okay";
>> 
>> also be specified here?
> 
> It is not needed as "okay" is the implied status when status prop is
> undefined, and my understanding is that DT maintainers prefer not to
> include status = "okay" where the initial node is defined.
> 
> More correctly if status prop is defined it must explicitly have "okay"
> anything else result in a disabled node, removing the status prop
> entirely has the same effect as status = "okay" in a board file.

I see, thanks for the clarification.  In that case, there seem to be
a few redundant instances of 'status = "okay";' in various U-Boot dtsi
files, which should probably be deleted.

>>> +	};
>>> +
>>>  	otp: nvmem@fe38c000 {
>>>  		compatible = "rockchip,rk3568-otp";
>>>  		reg = <0x0 0xfe38c000 0x0 0x4000>;
>>> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi
>>> b/arch/arm/dts/rk3588s-u-boot.dtsi
>>> index ac67c777adea..233eb79d9ba2 100644
>>> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
>>> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
>>> @@ -91,7 +91,6 @@
>>>  	rng: rng@fe378000 {
>>>  		compatible = "rockchip,trngv1";
>>>  		reg = <0x0 0xfe378000 0x0 0x200>;
>>> -		status = "disabled";
>> 
>> Shouldn't it be enabled instead?
> 
> Same as above, not defining any status prop result in node being 
> enabled.
> 
> Board u-boot.dtsi-files could disable the node with status = "disabled"
> if they absolutely do not want to have the rng node in U-Boot.

Thanks once again for the clarification.  Please include this tag:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

>> 
>>>  	};
>>> 
>>>  	usbdp_phy0: phy@fed80000 {
>>> diff --git a/arch/arm/mach-rockchip/Kconfig
>>> b/arch/arm/mach-rockchip/Kconfig
>>> index 649c22618f36..247b9a3146c2 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -305,9 +305,11 @@ config ROCKCHIP_RK3568
>>>  	select BOARD_LATE_INIT
>>>  	select DM_REGULATOR_FIXED
>>>  	select DM_RESET
>>> +	imply DM_RNG
>>>  	imply MISC_INIT_R
>>>  	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>>>  	imply OF_LIBFDT_OVERLAY
>>> +	imply RNG_ROCKCHIP
>>>  	imply ROCKCHIP_COMMON_BOARD
>>>  	imply ROCKCHIP_OTP
>>>  	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
>>> @@ -334,9 +336,11 @@ config ROCKCHIP_RK3588
>>>  	select DM_RESET
>>>  	imply BOOTSTD_FULL
>>>  	imply CLK_SCMI
>>> +	imply DM_RNG
>>>  	imply MISC_INIT_R
>>>  	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>>>  	imply OF_LIBFDT_OVERLAY
>>> +	imply RNG_ROCKCHIP
>>>  	imply ROCKCHIP_COMMON_BOARD
>>>  	imply ROCKCHIP_OTP
>>>  	imply SCMI_FIRMWARE
>>> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig
>>> b/configs/anbernic-rgxx3-rk3566_defconfig
>>> index 24b050c59b53..110237e798f9 100644
>>> --- a/configs/anbernic-rgxx3-rk3566_defconfig
>>> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
>>> @@ -68,8 +68,6 @@ CONFIG_REGULATOR_RK8XX=y
>>>  CONFIG_PWM_ROCKCHIP=y
>>>  CONFIG_SPL_RAM=y
>>>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
>>> -CONFIG_DM_RNG=y
>>> -CONFIG_RNG_ROCKCHIP=y
>>>  # CONFIG_RNG_SMCCC_TRNG is not set
>>>  CONFIG_BAUDRATE=1500000
>>>  CONFIG_DEBUG_UART_SHIFT=2
