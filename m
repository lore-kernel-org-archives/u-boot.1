Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48208CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 14:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAE9D84664;
	Mon, 18 May 2026 16:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ak87AIRu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B316484150; Mon, 18 May 2026 10:40:39 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D763983EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso20587095e9.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779093636; x=1779698436; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J2w/DRI3haDU+wQntryn7NTzzI96c0YqBdZy0X3/uzA=;
 b=ak87AIRuKn/lzqRQTKknXjw3dCYcIHeP79k+50zR1PDqDp19kxbFZiAVvRgzOCDvZb
 ROHl0ZHdwXW6x3d31aIQoLASbsW8Yme1ihetOSxeSqG9y8MeFn3kPUgB6J5TyK12hl7e
 EV9JYNO09iV9Zn4UigzoaBkvM8IKsmJZGjUGiiyjZepKAUhkMViVHjuSzOQLqKO3kgZm
 zVdYQcagzzUUyEYg6S6Jw7Odd1nhy2MvvxII7ikRdCOhbzSPThGgJK5NwC5dS70CL870
 El0LYPhJCwEAbbRtl3CmPCKAS7Ka72iPrZLvItHQaLqN+3t+iRi83NM6RjUTweWZIISR
 JElw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779093636; x=1779698436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J2w/DRI3haDU+wQntryn7NTzzI96c0YqBdZy0X3/uzA=;
 b=l325crMeQRmNWWEodLQGn9Bo66xoNTuQMlLbMKbSkGjgwEK0ZfrO8NwJ5lPUayIZtM
 SYUmmo8wobeAlYfbvJGU4Z8JewjYn6YYlU6xy0VJ53v8HSZCn2z0O78kdl3+20D6t7zM
 4RmjzfbUtGtDA7wtiwHyaxPOxxfSqgnHPfBOeK61FItybaD0R64tDJDhw5sPCHalTKGr
 QM5NL70zUpKDURrI8I3tDM8uLR7kqk21oORJX0CdzwjKLwhPMsO6CIXvmmZ4KB2Lpa+5
 uVahY4HNlHY+gsahtfVZqJZ4hsU13f12tD20Ij4Crt73VMXOHPOLC8bZOCQD8M0Ua4hl
 uqQQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4RAu8VmJsVm4YwlbNZCLdpJuPSZALu1nITIE8/DIBppcLalZEmkbRBDcsj2KoF5JvqTNytOM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz03VrUB6CbGTfnxYRPUWZdVejT0A/SJali21/VQjktv7o0r8hs
 GhzPpnM7ro9PP1sg6YcsFqwR11f2jDYzyV+90w0ceYEGoIQD5YUclHcrJdZ4hx+Jo4g=
X-Gm-Gg: Acq92OE2HeC5bRgeUKYyv/hdscBgDt19ZshYIufNUN/yaK2/V6q06ByNHmBLiB6fAAt
 cz0tY3C8o5kK/f4QvInk3wDNY5ksvA3AJG3dWknozBUk9EIQx9gxJEs7ASepOmaytGhfWiaN78G
 DG3SsuBxVKmjKHtYLnZp83KgkfrOZuz9kcl2tsVqC3qurKaKKLqAcJxoTcpyK0e6DzBNfTkiSx/
 9grKQkgoPdBwt6rAK4ToJm98a9umketLWLj4PU+GUFNVwmJDhDD5gTSOdO2FpmWb/WI3BRhUHWz
 lBpacyJWVqU9jckMcUPkBDp+2qHQkK2lNerwmv1Cn8ciBjbenbN8O/dLulv+VOlWj5ZPxWNr+6H
 0zqEXI2jeVcRLZXFNH7LEL6f/nRmJXO7CPMEbJtUWBl1X1mhrxP//ZOQeGxiRF5dKcjTyXHQ+La
 U8jgkIKpkIcLePZXIoz08i9ysJrMUlHcT3F3RpgC3Erc+lLhFZUGqWYQ+wO8WtMBndtsnSaMaXF
 G6T
X-Received: by 2002:a05:600c:4e53:b0:490:1640:8269 with SMTP id
 5b1f17b1804b1-490164089c7mr9819995e9.18.1779093636288; 
 Mon, 18 May 2026 01:40:36 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm34605015f8f.19.2026.05.18.01.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:40:35 -0700 (PDT)
Message-ID: <1f639a99-7d32-4f3b-bd0b-8936cb56ea0d@linaro.org>
Date: Mon, 18 May 2026 10:40:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions to
 support SPL
Content-Language: en-US
To: michael.srba@seznam.cz, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>, Heiko Schocher
 <hs@nabladev.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 18 May 2026 16:52:36 +0200
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

Hi Michael,

On 16/05/2026 20:19, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)
> 
> Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to fix up
> upstream dt to make usb work.
> 
> Mirror u-boot proper selections like GPIO and pinctrl to ensure consistent
> behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for similar
> reasons.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  arch/arm/Kconfig                 | 33 ++++++++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 850768282ce..255d2035cdc 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
>  	bool "Qualcomm Snapdragon SoCs"
>  	select ARM64
>  	select DM
> +	select DM_EVENT if USB_DWC3_GENERIC

Is there any reason not to make this uncoditional?

>  	select DM_GPIO
>  	select DM_SERIAL
>  	select DM_RESET
> @@ -1149,9 +1150,39 @@ config ARCH_SNAPDRAGON
>  	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
>  	select SYSRESET
> -	select SYSRESET_PSCI
> +	select SYSRESET_PSCI if !SPL
>  	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
>  	select MMU_PGPROT
> +	select SUPPORT_SPL
> +
> +	select OF_LIVE if USB_DWC3_GENERIC

Same here, OF_LIVE carries performance benefits too besides the fixup stuff.

> +	select SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
> +	select ARMV8_SPL_EXCEPTION_VECTORS if SPL
> +	select ENABLE_ARM_SOC_BOOT0_HOOK if SPL
> +	select SPL_DM if SPL
> +	select SPL_DM_GPIO if SPL
> +	select SPL_DM_PMIC if SPL
> +	select SPL_DM_USB_GADGET if SPL
> +	select SPL_ENV_SUPPORT if SPL
> +	select SPL_EVENT if SPL_USB_DWC3_GENERIC
> +	select SPL_GPIO if SPL
> +	select SPL_HAS_BSS_LINKER_SECTION if SPL
> +	select SPL_LIBCOMMON_SUPPORT if SPL
> +	select SPL_LIBDISK_SUPPORT if SPL
> +	select SPL_LIBGENERIC_SUPPORT if SPL
> +	select SPL_OF_CONTROL if SPL
> +	select SPL_PINCONF if SPL
> +	select SPL_PINCTRL if SPL
> +	select SPL_PINCTRL_FULL if SPL
> +	select SPL_PINCTRL_GENERIC if SPL
> +	select SPL_PINCONF_RECURSIVE if SPL
> +	select SPL_PINMUX if SPL
> +	select SPL_SPMI if SPL
> +	select SPL_SPMI_MSM if SPL
> +	select SPL_SPRINTF if SPL
> +	select SPL_STRTO if SPL
> +	select SPL_USB_GADGET if SPL
> +	imply SPL_MMC if SPL
>  	imply OF_UPSTREAM
>  	imply CMD_DM
>  	imply DM_USB_GADGET
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index c195d478512..a2228e217af 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -14,6 +14,9 @@ config SYS_VENDOR
>  config SYS_MALLOC_F_LEN
>  	default 0x2000
>  
> +config SPL_SYS_MALLOC_F
> +	default y
> +
>  config SPL_SYS_MALLOC_F_LEN
>  	default 0x2000
>  
> @@ -39,6 +42,13 @@ config SYS_CONFIG_NAME
>  	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>  	  will be used for board configuration.
>  
> +config SPL_SHARES_INIT_SP_ADDR
> +	# override the default from common/spl/Kconfig
> +	default n
> +
> +config SPL_HAVE_INIT_STACK
> +	default y
> +
>  choice
>  	prompt "Qualcomm boot0.h workaround"
>  	optional
> 

-- 
// Casey (she/her)

