Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1738BCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 09:46:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3244838BB;
	Fri, 15 May 2026 11:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQNvggzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C932839D9; Fri, 15 May 2026 11:46:51 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C54DD8341A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B17260583;
 Fri, 15 May 2026 09:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F590C2BCB3;
 Fri, 15 May 2026 09:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778838407;
 bh=UtGM58ORuvUn7ot69pyNVwnqbLnm2/T3g8sooRWvwsM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AQNvggzzo581FrKhLCXDzEk2q0RX1qoqEMf3aDfA+zH55d4eSwImYG+3d+mwxuXO+
 92OwItnz9TavZHY30aprA1xKXbRu3QNjnlEr8vezrk0A/H+subZRyFoqyk0jJTkeH4
 sLq2AnxkU1Bmeq6DvbsGCbDKsuTNcH/oZUXp9wIMXOUr3b9Srdp02IfVqVobPIIa1T
 wlPfP8/BpZZg4v68ZU5KjXvDmsEF+GuOKq9jKz88DvPpmE+ygbuWqQ52ifg19yNoMX
 CxV0aKs9HwfSUXMOqwXhFyoY/JOQ85YchPyAOMurq4Q5DI6LvZH8BUgXXIn8n/FEHC
 yvk8kUQETxZfA==
Date: Fri, 15 May 2026 15:16:41 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, Michael.Srba@seznam.cz, sjg@chromium.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2] mach-snapdragon: Add early EL2 hypervisor switch
 support
Message-ID: <agbrgVbgBY7c3Sjf@sumit-xelite>
References: <20260515065632.90772-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515065632.90772-1-aswin.murugan@oss.qualcomm.com>
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

On Fri, May 15, 2026 at 12:26:32PM +0530, Aswin Murugan wrote:
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
> - Integrates with existing boot0.h infrastructure
> 
> A new Kconfig option CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT enables this
> functionality.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
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
>  .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
>  3 files changed, 46 insertions(+)
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
> index 00000000000..f69678018ea
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Early Gunyah Hypervisor Exit
> + *
> + * Exit Gunyah hypervisor and switch to EL2 during early boot. This must
> + * happen before EL register configuration in start.S so that U-Boot can
> + * run properly at EL2.
> + */
> +
> +#include <linux/arm-smccc.h>
> +
> +/* TrustZone SMC IDs for hypervisor configuration */
> +#define TZ_EL2_SWITCH_SMC_ID			0x02000121
> +#define TZ_EL2_SWITCH_PARAM_ID			0x00000023
> +#define TZ_EL2_SWITCH_PARAM2_EXIT_GUNYAH	0x1
> +
> +	/* Save FDT address before we modify x0 */
> +	mov	x9, x0
> +
> +	/* Only perform hypervisor switch if we're at EL1 */
> +	mrs	x0, CurrentEL
> +	cmp	x0, #(1 << 2)
> +	bne	1f

Above logic is somewhat broken when U-Boot enters in EL2 by default, see
corresponding fix here [1].

Please fold in this fix for v3.

[1] https://github.com/qualcomm-linux/u-boot/pull/64

-Sumit

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
> +1:
> +	b	reset
> -- 
> 2.34.1
> 
