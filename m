Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE74D37E37
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4381F808AF;
	Wed, 14 Jan 2026 15:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="webth8/x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E0A080C93; Wed, 14 Jan 2026 15:11:02 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A7C8063E
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47796a837c7so59789185e9.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768399858; x=1769004658; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Sx+Wp5oaaX0WNWEKY+I8oMKXic/KPEDviA98FYItsA=;
 b=webth8/xBEqC8AVT6ZW6GMZVsQJK3gp9pX5sKiulhDur+Sw0RXmsnSSz6QgyZNGADf
 OBJX0wKH+HU5HB3tOVjObMfqRgiLkIbRwKROQVnXYNnfEQ4T9g+6zNcfNVtPgsDTKpiU
 D8jOx9OrLN15hD6h0tYXhP0lEaNrMG/9isBRVWT4F50FxphosRHbrBqKipq7AfZfZIoL
 LIFVnQfuiV5vQWU6+aiAemzNfR7/G5q1VtYUbi6qwFH/iseEhfmpVcxgpbUNYOaKfjaR
 hwk2MiBBAYTxcQFHSf9mw8gfiwnHq7an4PTtrpPIikquEnFcRHRUy2YohkbCYkFrzfR0
 Nelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768399858; x=1769004658;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Sx+Wp5oaaX0WNWEKY+I8oMKXic/KPEDviA98FYItsA=;
 b=qWSc4+xUa8m+mm/O2wqE+xvTb2of+iWJypAlqf/zGD7xDUXz1w3Qqs5q+Kvd6Cm9OJ
 XlL7nrJrhe7OTNXNyVRUu4ixLVm/c6o4jOsCWPFk+v3GTp1Z9izTKVoFY6qCEf57SJut
 vpSWtHP8ZgCY5P0SAGaDb9ig3uY5UFab7mDW98iynH+o/WOaUk4BLjdY6vU/O/A9wRUF
 +KbsdzEqGgu9l7jW3VcwN8GcXf2HnxGR3ZZ+01YeMCwJxzyHQEMwV4trWrB7+UWQK4zb
 //uJzwcD6xpclh3pOgHlOf3EZdSYIs1ui39B95pjMQCdJ5UTq4FL61+fdiHrg91NtNE+
 6RIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Qwr5iPi0hjXHvO5yBZmawN5D7wYYzG9zkKSANCItmRQJMcpu45H1n4vZJPaCyuHXb7WNzV0=@lists.denx.de
X-Gm-Message-State: AOJu0YxPwIW+rE/C9KrRaCtbeVZGrTLxKBnxEIc39yIqa8sz54cOfFiU
 7OWCBt8n4UrYvlpIiOJ8ur16kqAA3SEZOQd+JZZqzedIq6vn2s9RbkdykHVDvDHPmcg=
X-Gm-Gg: AY/fxX7tGyAi5Die4gzQzQVhcjIgaPOr3afSUjanvMDn0Qqg+346wvt6J+pYEgKgUOw
 vJeaklywrWzeHfMtolJ2moP/49hThYXPmKrYoqwsZUw02fVVTA5+Dz0TW2PC0HofwgjAn3lhzJa
 psJ8ev7STOXl8wXOhyO/lWV3IFee/m9fIDCbAWKRGXj9uXVtOEEFYX5tXB34Zg8VvRmj/NjSJUk
 hu+BHWOKmDxjkrKz3HX/rvrSs5BIvL5PsELTkCcb8SVMlIS3wLBuOJbr64FvtFHsjQEQ2YrgpaO
 BW0qr7ZU/TjU4344McVKJ96BPHQFzI2mEw1vAJ7vlZiHCfkjX3MDOFMdBfVimz4jeffthPrMC0F
 rFkvnJkPDVaElHQQ8pvFFH6JAjB6/NmX1TSSFJTelBdiejQ7/dxeKY4iFc8r7fosSkroOnYjKwD
 qFVNA+kCwItGh50Jg9dfW3CwrCrB9LSyZHva/3XsNaYWAeN9GNAwY=
X-Received: by 2002:a05:600c:8b22:b0:477:63dc:be00 with SMTP id
 5b1f17b1804b1-47ee33a1294mr32001015e9.25.1768399858428; 
 Wed, 14 Jan 2026 06:10:58 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee54b8c5asm30315295e9.1.2026.01.14.06.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:10:57 -0800 (PST)
Message-ID: <c471c029-3623-400e-98d0-847ef891fe8e@linaro.org>
Date: Wed, 14 Jan 2026 15:10:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] firmware: psci: Refactor EFI runtime PSCI reset
 handling
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sajattack@postmarketos.org,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com, me@samcday.com,
 michal.simek@amd.com, sjg@chromium.org, j-humphreys@ti.com,
 paul.liu@linaro.org, raymondmaoca@gmail.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com>
 <20260114111624.2321852-2-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260114111624.2321852-2-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Aswin,

On 14/01/2026 12:16, Aswin Murugan wrote:
> Previously, U-Boot’s PSCI-based implementation of `efi_reset_system()`
> was always enabled when `CONFIG_PSCI_RESET` was set, but it did not
> handle additional arguments required for specialized reset modes. This
> caused issues where special reboot requests (e.g., bootloader, EDL)
> were ignored, resulting in a normal reboot.
> 
> This change introduces a new configuration option,

Be imperative rather than descriptive: "Introduce a new configuration
option". See
https://docs.kernel.org/process/submitting-patches.html#describe-your-changes

> `CONFIG_EFI_PSCI_RESET_RUNTIME`, to explicitly control whether the
> runtime PSCI-specific EFI reset implementation is enabled. By default,
> the PSCI EFI reset is enabled, it can be disabled at platform defconfig
> allowing the kernel to handle the reset logic and pass the necessary
> arguments for the intended reset mode correctly.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
> ---
>  drivers/firmware/psci.c |  4 ++--
>  lib/efi_loader/Kconfig  | 11 +++++++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
> index 2e3223e1c32..009c6153d0c 100644
> --- a/drivers/firmware/psci.c
> +++ b/drivers/firmware/psci.c
> @@ -244,7 +244,7 @@ static void __maybe_unused do_psci_probe(void)
>  	uclass_get_device_by_name(UCLASS_FIRMWARE, DRIVER_NAME, &dev);
>  }
>  
> -#if IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET)
> +#if IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME)
>  efi_status_t efi_reset_system_init(void)
>  {
>  	do_psci_probe();
> @@ -266,7 +266,7 @@ void __efi_runtime EFIAPI efi_reset_system(enum efi_reset_type reset_type,
>  	while (1)
>  		;
>  }
> -#endif /* IS_ENABLED(CONFIG_EFI_LOADER) && IS_ENABLED(CONFIG_PSCI_RESET) */
> +#endif /* IS_ENABLED(CONFIG_EFI_PSCI_RESET_RUNTIME) */
>  
>  #ifdef CONFIG_PSCI_RESET
>  void reset_misc(void)
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 13e44be1d06..712905a56eb 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -106,6 +106,17 @@ config EFI_HAVE_RUNTIME_RESET
>  	depends on ARCH_BCM283X || FSL_LAYERSCAPE || PSCI_RESET || \
>  		   SANDBOX || SYSRESET_SBI || SYSRESET_X86
>  
> +config EFI_PSCI_RESET_RUNTIME
> +	bool "EFI Runtime PSCI Reset Support"
> +	default y if EFI_LOADER && PSCI_RESET
> +	depends on ARM_PSCI_FW
> +	help
> +	  Enable PSCI-based reset implementation for EFI runtime services.
> +	  This allows the EFI runtime to perform system resets and power-off
> +	  operations using the ARM Power State Coordination Interface (PSCI)
> +	  firmware interface, providing a standardized method for system
> +	  power management across different ARM platforms.

The last 4 lines could be simplified to something like "This allows the
OS to reset the system through EFI runtime calls"

Kind regards,> +
>  endmenu
>  
>  menu "UEFI Variables"

-- 
// Casey (she/her)

