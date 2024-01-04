Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5E4C47074
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 12:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8F3A8796A;
	Thu,  4 Jan 2024 13:30:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hgHvboP1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C68F8796A; Thu,  4 Jan 2024 13:30:53 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B1FF87961
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 13:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d60c49ee7so4361925e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 04:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704371449; x=1704976249; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KZydaii6YsJDa/tU99qAswg3PNFADMxwF3tvqVulQGQ=;
 b=hgHvboP1hqp1EwOnqDL6Evgjdi5e5WX9VZAInbovQVfOa4DD+4570cejBtNvhfpnBD
 UFFYmTGG0kIktw6u++NDj+244RB7Ocu7PVXGBVrdMsqNxp3F6sUJsvNYYzheX2BgGjc7
 2+ldNrkhOsEI7Ry1B27brP2/HadlgJ43btzBO/4CV7W8WTvS63irxByEwUSLpnovzMfs
 MHX0dxuCcbM9Me0Ficpm244eJsjF7kw7YYMwZWpoHezl7yYmxVGeTfdv5CQusCaYZ8sR
 rlHffnXwf4L0xMlW7I3+qVK+GC8P+ZqVIxgK94jKH293snE7/thnBJe/mgzXdbB+EaPV
 TV/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704371449; x=1704976249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZydaii6YsJDa/tU99qAswg3PNFADMxwF3tvqVulQGQ=;
 b=Ae6q4qjQB7ztJ1S7CQdGEMNUIMCwCde0N0KOfPxN16EUYylhrKJN2ojE1nPkArO3P2
 IVAG1+22uKADwzRoJGP8b+29eEvRkbRp1skw6a+ueewRRtSGk9FupsBUg1rFNfDjcC5Y
 b3e9tC/fPoyZx9FcD0TRHFEJNQtwta/bkLlE/2Q5iIaxYqUoOLJLkLr66akM/Qg2XMI7
 STeSCJIjQW6ARw4jmRg6RUIZtvscm2UTTeLv3u4ENP+Mgp23qgBfXhd73sndh3J1OfAS
 CBRGiRPZxGf+c8BieK6BykR6e40rLf3fdXic26prywRZarLcYeDCZx38XzCkeCy9rJvA
 2X5Q==
X-Gm-Message-State: AOJu0YwPyNXCdWn124XRIjg94gdVwA8h9ZO+3sXbvVVJu9YTDCLqai+x
 NwXfvxj6negJNHx1Bl4Az5axVVjeZ6AIMw==
X-Google-Smtp-Source: AGHT+IGKZsKH2ljjQPhnxA7rSaYxJIlHjbSyeIKAM/AWtmDwzUR8bJr8nK8eeYPG226RprzUPkujfg==
X-Received: by 2002:a7b:cd08:0:b0:40d:62fe:a160 with SMTP id
 f8-20020a7bcd08000000b0040d62fea160mr314795wmj.93.1704371448305; 
 Thu, 04 Jan 2024 04:30:48 -0800 (PST)
Received: from [192.168.1.83] (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 bd9-20020a05600c1f0900b0040d8390b199sm5699922wmb.12.2024.01.04.04.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 04:30:47 -0800 (PST)
Message-ID: <54d8ea1e-546a-4915-af77-b7c4e4954a8a@linaro.org>
Date: Thu, 4 Jan 2024 12:30:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: Move APQ8016 SoC derived board code
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, trini@konsulko.com, sjg@chromium.org
Cc: neil.armstrong@linaro.org, rfried.dev@gmail.com, dsankouski@gmail.com,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org, u-boot@lists.denx.de
References: <20240103130716.4144892-1-sumit.garg@linaro.org>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240103130716.4144892-1-sumit.garg@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Sumit,

On 03/01/2024 13:07, Sumit Garg wrote:
> In order to avoid duplication of APQ8016 derived boards specific code,
> move common bits like USB pinctrl and fastboot to board-apq8016.c file.
> This will allow future board support like SE HMIBSC board etc to reuse it.

You still haven't demonstrated a justification for having the HMIBSD
board NOT simply point to board/qualcomm/dragonboard410c. Do you have a
branch with additional features where it clearly makes sense to have a
separate board directory?
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
> 
> This patch is based on Caleb's Qcom common target branch [1]. As per
> Caleb's comments here [2], there is no scope for people to add board
> code for new board support. And even people can't reuse existing board
> code like for db410c for further new board support but rather they have
> to make db410c generic first.
> 
> I fear this would be couter productive and motivate OEM vendors (which
> aren't Qcom reference designs) to keep their board support code
> downstream. 

This is the same argument made by those defending mach-* code in Linux.
What I'm advocating for here is that we spend just a little more time
doing things right, so that when the next vendor, or next gen board
comes along we aren't copy/pasting board files.

> IMO, the approach should be to allow board code reuse which
> this patch is all about. 

Board code reuse is exactly what I want, just that we do our due
diligence in not blindly putting code behind arbitrary compile-time
configuration.

> The next steps should be to make the underlying
> board features to rather come from DT but that as you know requires
> bindings to be accepted first.

We can have non-standard DT if we *need* to, I would prefer that over
this board code because then there's at least an obvious path forwards.
In fact this is exactly what the below USB role switching code does, I
already put the work in to make it generic (before it literally found
the GPIO device and set specific GPIO pins).

Below I have outlined the changes that would be necessary to have the
functionality here built in for all mach-snapdragon boards, so this
whole SOC_APQ8016 thing can be dropped. It's ridiculous to gate this
code behind a particular SoC when none of it is SoC specific.

> 
> Tom, Simon,
> 
> Is there any U-Boot policy in regards to board code going forward? Are
> we moving in a direction to get rid of most board specific stubs from
> generic U-Boot code?
> 
> [1] https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/b4%2Fqcom-common-target
> [2] https://lore.kernel.org/all/824be245-60c9-4a1a-a386-be765e8eba91@linaro.org/
> 
>  arch/arm/mach-snapdragon/Kconfig              |  5 ++
>  arch/arm/mach-snapdragon/Makefile             |  1 +
>  arch/arm/mach-snapdragon/board-apq8016.c      | 64 +++++++++++++++++++
>  .../dragonboard410c/dragonboard410c.c         | 62 ------------------
>  configs/dragonboard410c_defconfig             |  1 +
>  5 files changed, 71 insertions(+), 62 deletions(-)
>  create mode 100644 arch/arm/mach-snapdragon/board-apq8016.c
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 96e44e2c549..8069a89bf78 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -3,6 +3,11 @@ if ARCH_SNAPDRAGON
>  config SYS_SOC
>  	default "snapdragon"
>  
> +config SOC_APQ8016
> +	bool "APQ8016"
> +	help
> +	  Select this if your SoC is an APQ8016
> +
>  config SYS_VENDOR
>  	default "qualcomm"
>  
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 857171e593d..7d210e6d872 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -3,3 +3,4 @@
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>  
>  obj-y += board.o
> +obj-$(CONFIG_SOC_APQ8016) += board-apq8016.o
> diff --git a/arch/arm/mach-snapdragon/board-apq8016.c b/arch/arm/mach-snapdragon/board-apq8016.c
> new file mode 100644
> index 00000000000..bb9a3a9f0fb
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/board-apq8016.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Board init file for APQ8016 SoC derived boards
> + *
> + * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> + */
> +
> +#include <button.h>
> +#include <dm.h>
> +#include <dm/pinctrl.h>
> +#include <env.h>
> +#include <init.h>
> +#include <usb.h>
> +#include <fdt_support.h>
> +
> +int board_usb_init(int index, enum usb_init_type init)

This function can trivially be made generic, in such a way that it could
be done for all mach-snapdragon devices:
> +{
> +	struct udevice *usb;
> +	int ret = 0;
> +
> +	/* USB device */
> +	ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);

Instead do:
	ret = uclass_find_device_by_seq(UCLASS_USB, index, &usb);
> +	if (ret) {
> +		printf("Cannot find USB device\n");
> +		return ret;
> +	}

Here we must check to see if the "device" pinctrl exists, use this as a
litmus test to see if this board needs pinctrl state changes

	ret = dev_read_stringlist_search(usb, "pinctrl-names",
					 "device");
	/* No "device" pinctrl state, so just bail */
	if (ret < 0)
		return 0;
> +
> +	/* Select "default" or "device" pinctrl */
> +	switch (init) {
> +	case USB_INIT_HOST:
> +		pinctrl_select_state(usb, "default");
> +		break;
> +	case USB_INIT_DEVICE:
> +		pinctrl_select_state(usb, "device");
> +		break;
> +	default:
> +		debug("Unknown usb_init_type %d\n", init);
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Check for vol- button - if pressed - stop autoboot */
> +int misc_init_r(void)

As I said before, this code only exists because U-Boot's "autoboot"
implementation hasn't been updated with good button support, this is
also a fairly simple fix and would benefit all the boards, not just
Qualcomm.

If you really don't have the time of experience to implement such a
feature, and this is really such a blocker for your board support, then
that is a totally different class of issue which we can find a solution to.
> +{
> +	struct udevice *btn;
> +	int ret;
> +	enum button_state_t state;
> +
> +	ret = button_get_by_label("vol_down", &btn);
> +	if (ret < 0) {
> +		printf("Couldn't find power button!\n");
> +		return ret;
> +	}
> +
> +	state = button_get_state(btn);
> +	if (state == BUTTON_ON) {
> +		env_set("preboot", "setenv preboot; fastboot 0");
> +		printf("vol_down pressed - Starting fastboot.\n");
> +	}
> +
> +	return 0;
> +}
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index 2a502c7c284..f7c6a6cbc0a 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -5,78 +5,16 @@
>   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   */
>  
> -#include <button.h>
>  #include <common.h>
> -#include <cpu_func.h>
>  #include <dm.h>
> -#include <dm/pinctrl.h>
>  #include <env.h>
>  #include <init.h>
>  #include <net.h>
> -#include <usb.h>
> -#include <asm/cache.h>
> -#include <asm/global_data.h>
> -#include <asm/gpio.h>
>  #include <fdt_support.h>
>  #include <linux/delay.h>
>  
>  #include "misc.h"
>  
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -#define USB_HUB_RESET_GPIO 2
> -#define USB_SW_SELECT_GPIO 3
> -
> -int board_usb_init(int index, enum usb_init_type init)
> -{
> -	struct udevice *usb;
> -	int ret = 0;
> -
> -	/* USB device */
> -	ret = device_find_global_by_ofnode(ofnode_path("/soc/usb"), &usb);
> -	if (ret) {
> -		printf("Cannot find USB device\n");
> -		return ret;
> -	}
> -
> -	/* Select "default" or "device" pinctrl */
> -	switch (init) {
> -	case USB_INIT_HOST:
> -		pinctrl_select_state(usb, "default");
> -		break;
> -	case USB_INIT_DEVICE:
> -		pinctrl_select_state(usb, "device");
> -		break;
> -	default:
> -		debug("Unknown usb_init_type %d\n", init);
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
> -/* Check for vol- button - if pressed - stop autoboot */
> -int misc_init_r(void)
> -{
> -	struct udevice *btn;
> -	int ret;
> -	enum button_state_t state;
> -
> -	ret = button_get_by_label("vol_down", &btn);
> -	if (ret < 0) {
> -		printf("Couldn't find power button!\n");
> -		return ret;
> -	}
> -
> -	state = button_get_state(btn);
> -	if (state == BUTTON_ON) {
> -		env_set("preboot", "setenv preboot; fastboot 0");
> -		printf("vol_down pressed - Starting fastboot.\n");
> -	}
> -
> -	return 0;
> -}
> -
>  int qcom_late_init(void)
>  {
>  	char serial[16];
> diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
> index 453cb9d04c7..23024066f82 100644
> --- a/configs/dragonboard410c_defconfig
> +++ b/configs/dragonboard410c_defconfig
> @@ -3,6 +3,7 @@ CONFIG_SYS_BOARD="dragonboard410c"
>  CONFIG_COUNTER_FREQUENCY=19000000
>  CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
>  CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_SOC_APQ8016=y
>  CONFIG_TEXT_BASE=0x8f600000
>  CONFIG_SYS_MALLOC_LEN=0x802000
>  CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y

-- 
// Caleb (they/them)
