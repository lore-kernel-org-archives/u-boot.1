Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE5ACD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:20:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A08B83EF9;
	Mon, 18 May 2026 10:20:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="REJNLAEf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6576183FEE; Mon, 18 May 2026 10:20:29 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE238839D9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso10928675e9.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779092425; x=1779697225; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8xW2NyMIlyLl6WNC3+rQx+P5obOFNiEroI1Da5p0tdU=;
 b=REJNLAEfzCgvaUPadnqRffQvgjbYB8zoz1V1GsE4XzTn5gvIoHsIoICL++Fij5OLVH
 UL82io0xOUda+kukBIJQF6/xSrFQE1oSAn2j9YimhYbtExlT9zEXIREYPDHxDGL6BDHr
 +P4+vtOaKkOGPhj+Yj1zLtTd1ZhFjVrFd2epnWKP9O23YNG3oxraNXODGjiHGPbNfzc2
 qDq8nRE3YiwtKqwYKdT9RNFyF5nOnBvIuH7V1r9PCRsOCxB2QSMgIxISJ79zl7Q977AK
 dF4+sgG2dY3GMSyMS9pqk/m2/Js3qizIQmxhKidXIXqUYo8MvWXKZSCnxjkEr3am68lV
 zIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779092425; x=1779697225;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xW2NyMIlyLl6WNC3+rQx+P5obOFNiEroI1Da5p0tdU=;
 b=kuEmfU5taDi729qi5brsenC4ah9MUPbQ0fpF76IiAQjxNM2TQQilHzo9ChVVMJ5sTh
 n0Z3gQwXFqKctB2AqxPCQdTSlnqIkRhfTB4sWkipL5gS1bnhSTV0JtdMOi+8HlXCmXmK
 I3irhi3kdsSTBe3rC04R4oUOgLvYkeNIKZnIQ3iHU0xEEduF2Wuo7Ns6qDWxfcTRrki0
 A535+1OufaRejfNfnnOPNU3eP2ZbfXTjYmC8jPhE/Kn6PQHrH4PkOkOXCGT7BYSwCbwv
 R2jWIXfYS9RUnFoyfCnvs0E7AfB/b0/vA5jumpKxU5l7rXM5Ax4TvDDUVNVNcnxOyAJF
 8AZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+pwgt4X+QyKlBgKxTI57sRjO7KL0KB9hHOmg8WyNQqCX3GbYyp26XlB4zCT6a/C7YY8MxZCjs=@lists.denx.de
X-Gm-Message-State: AOJu0YyED3glfbtRVO4tUvtEco8PM24s/gX6g5VZ03OjVt0Js+g4iA4g
 F93hcuccECmv0YNYd0RxkS7d85r66xL7F60V3m2Z4dAPRnW2iK/lNHAOHhLGJRox/3c=
X-Gm-Gg: Acq92OEICpxCK60P/Xh0Iv2cMfUfdK/wpv88cgLAmKGTzAmGwQFkv2OmPihOX80Y3GX
 PIMkTAWuHY/q+XXeauYN2kUnkP6SyfqjRkTtmeybOOn6DnaYEVCh96jXji60t2Wk07Oo7WQywx+
 vzgr33Wtqv+SU46hPrfujWKpSW1itwFhrnNN23Bk6q+uc8MfgNg7IMsNxfOM5BpZHQkvXkNYbBN
 Vmi+yWLcoUf/GpjPICzxej5rfmj6kADZCIlcM4LtXWdB896+gNEzXFE62fKEEkfuoUWvrSe/3ts
 wmIWMiwhF7AeOEr6mik/r7NxS+329nJVDu8HHC0WeSWsSubnOmnPPojiEOvjZUY8pWz080Z1Dyr
 hTC/Qm0MIs3LSG/l9df6y3BxzDH9mdc6IlwCBpzSg2OGUu0AHohXhI0V7jPy64oUKnpSx1sIBsg
 nAHp8XYxXfxrI1nOzIwD6Bs0PqCFJSbY/zfuoIEVaBFI6nNYLAPqMOejLgcswFfCEC7a61gerPS
 1Ox
X-Received: by 2002:a05:600c:2d09:b0:48f:e1ac:c96d with SMTP id
 5b1f17b1804b1-48fe61f2bcemr118651465e9.20.1779092424989; 
 Mon, 18 May 2026 01:20:24 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb029180sm111969315e9.4.2026.05.18.01.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:20:24 -0700 (PDT)
Message-ID: <71d9b0d0-e204-4efc-915c-55f242363a95@linaro.org>
Date: Mon, 18 May 2026 10:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Content-Language: en-US
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, sjg@chromium.org,
 Michael.Srba@seznam.cz, u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260515130934.388894-1-aswin.murugan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260515130934.388894-1-aswin.murugan@oss.qualcomm.com>
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

Hi Aswin,

On 15/05/2026 15:09, Aswin Murugan wrote:
> Add support for exiting Gunyah hypervisor and switching to EL2 during
> early boot. This is required for platforms that boot U-Boot in a
> hypervisor guest environment where U-Boot needs to run at EL2 to
> enable other hypervisors like KVM.
> 
> The switch is performed via TrustZone SMC call before EL register
> configuration in start.S. The implementation:
> 
> - Checks current exception level and only executes at EL1
> - Uses TrustZone SMC to exit Gunyah and transition to EL2
> - Integrates with existing boot0.h workaround infrastructure

This is a lot of words that don't seem to really explain what this
change does or why it makes sense. Please rewrite this to be a bit more
concise.

Could you also describe in the comment at the top of the header file
(and maybe briefly in the kconfig) which platforms this is supported on?
Is it just QCS6490? All "Dragonwing" platforms? what's the story here?

Lastly, this should actually be enabled on at least one platform so we
don't merge dead code. I think this will "just work" on qcs6490 without
other patches.

Kind regards,

> 
> A new Kconfig option CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT enables this
> functionality.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Change in v3:
> - Corrected the logic to accurately detect the current Exception Level (EL)
>   and fuction properly when U-Boot enters either EL2 or EL1.
> 
> Link to v2: https://lore.kernel.org/u-boot/20260515065632.90772-1-aswin.murugan@oss.qualcomm.com/
> 
> Change in v2:
> - EL2 switch is made at early stage instead of doing at the very last stage in
>   the previous version
> - This change is based on the patch [1]
> 
> [1] https://lore.kernel.org/all/20260508-qcom_spl-v7-4-7d0e22aaaa8f@seznam.cz/
> 
> Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/
> ---
>  arch/arm/mach-snapdragon/Kconfig              |  7 ++++
>  arch/arm/mach-snapdragon/include/mach/boot0.h |  3 ++
>  .../include/mach/gunyah_exit_boot0.h          | 35 +++++++++++++++++++
>  3 files changed, 45 insertions(+)
>  create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index f863daf6bb9..931d25c1023 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -56,6 +56,13 @@ config BOOT0_MSM8916_PSCI_WORKAROUND
>  	help
>  	  Select this if you are building U-Boot proper for an msm8916 board that
>  	  uses the buggy PSCI implementation.
> +
> +config QCOM_EL2_GUNYAH_EXIT_SUPPORT
> +	bool "Enable early EL2 switch by exiting Gunyah"
> +	help
> +	  Exit Gunyah hypervisor and switch to EL2 during early boot. This must
> +	  happen before EL register configuration in start.S so that U-Boot can
> +	  run properly at EL2.
>  endchoice
>  
>  endif
> diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
> index b3c76d6d97d..032a9fbdb12 100644
> --- a/arch/arm/mach-snapdragon/include/mach/boot0.h
> +++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
> @@ -1,9 +1,12 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
> +
>  #if defined(CONFIG_SPL_BUILD)
>  	b	reset
>  #else
>  #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
>  #include "msm8916_boot0.h"
> +#elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
> +#include "gunyah_exit_boot0.h"
>  #else
>  	b	reset
>  #endif
> diff --git a/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
> new file mode 100644
> index 00000000000..5c5bd3b6691
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Early Gunyah Hypervisor Exit
> + *
> + * Exit Gunyah hypervisor and switch to EL2 during early boot. This must
> + * happen before EL register configuration in start.S so that U-Boot can
> + * run properly at EL2.
> + */
> +
> +#include <asm/macro.h>
> +#include <linux/arm-smccc.h>
> +
> +/* TrustZone SMC IDs for hypervisor configuration */
> +#define TZ_EL2_SWITCH_SMC_ID			0x02000121
> +#define TZ_EL2_SWITCH_PARAM_ID			0x00000023
> +#define TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH	0x1
> +
> +	/* Only perform hypervisor switch if we're at EL1 */
> +	switch_el x9, 3f, 2f, 1f
> +
> +	/* Save FDT address before we modify x0 */
> +1:	mov	x9, x0
> +
> +	/* Switch to EL2 (exit Gunyah) */
> +	ldr	w0, =TZ_EL2_SWITCH_SMC_ID
> +	ldr	w1, =TZ_EL2_SWITCH_PARAM_ID
> +	mov	w2, wzr
> +	mov	w3, wzr
> +	ldr	w4, =TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH
> +	smc	#0
> +
> +	/* Restore FDT address */
> +	mov	x0, x9
> +2:
> +3:	b	reset

-- 
// Casey (she/her)

