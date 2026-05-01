Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 321AFCD3425
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 12:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F0F884099;
	Fri,  1 May 2026 14:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IBuvNqpn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B91180F0E; Fri,  1 May 2026 09:31:38 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9E7380086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:31:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C86141794;
 Fri,  1 May 2026 07:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6285FC2BCB4;
 Fri,  1 May 2026 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777620693;
 bh=YhNghSMov3/hPQyij+pZ9ktXfFdoUKqxHxjfQQrrBWg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IBuvNqpnjcAkqB9d41+fcRpxn6mAGlAOTXRUaPvphUe47FS8/wCc7nMpAR0WRqkWF
 bW9D2/2uzzjeeF2yIirLZrI6Eyn2UzXuCjKhtFBYOifdbaiiTgZUQcT9tqG5te3VLB
 9Fm0uQTaoztwer/CSEUPEIGw7Fyjci45JNoFKKbahK03jVd1rzAl8osseMEd+XIzkJ
 HQkUbdnCHtlxZbuhQ/5FT+jKO2Ko7H/x3YGi32uPuLTVj8cpAHSdt1s0OcHeXk2Q6i
 qK2YDEZqNh6nyc00P20/tzOUkFGjmAIyOnKiiDX2I/2n7Scs9Ybw+Z9QxEXmoxwi93
 isvCA+fCTA66A==
Date: Fri, 1 May 2026 13:01:17 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: michael.srba@seznam.cz
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v4 07/11] mach-snapdragon: Kconfig: changes / additions
 to support SPL
Message-ID: <afRWxQuPPQBjVdPw@sumit-xelite>
References: <20260426-qcom_spl-v4-0-8cf4133ff883@seznam.cz>
 <20260426-qcom_spl-v4-7-8cf4133ff883@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-qcom_spl-v4-7-8cf4133ff883@seznam.cz>
X-Mailman-Approved-At: Fri, 01 May 2026 14:38:15 +0200
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

On Sun, Apr 26, 2026 at 01:26:09AM +0200, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> An SoC to target has to be selected, e.g. TARGET_SDM845.
> This will enable the per-SoC boot0.h.
> 
> Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> ---
>  arch/arm/Kconfig                 | 34 +++++++++++++++++++++++++++++++++-
>  arch/arm/mach-snapdragon/Kconfig | 31 ++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 03416c55265..ddabc23fc9e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1124,6 +1124,7 @@ config ARCH_SNAPDRAGON
>  	bool "Qualcomm Snapdragon SoCs"
>  	select ARM64
>  	select DM
> +	select DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC
>  	select DM_GPIO
>  	select DM_SERIAL
>  	select DM_RESET
> @@ -1138,9 +1139,40 @@ config ARCH_SNAPDRAGON
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
> +	select SPL_OF_REAL if SPL
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
> index f82cd0d3291..3b5ae6d98fb 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -17,9 +17,6 @@ config SYS_MALLOC_F_LEN
>  config SPL_SYS_MALLOC_F
>  	default y
>  
> -config SPL_SYS_MALLOC_F_LEN
> -	default 0x2000
> -
>  config SYS_MALLOC_LEN
>  	default 0x800000
>  
> @@ -42,4 +39,32 @@ config SYS_CONFIG_NAME
>  	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
>  	  will be used for board configuration.
>  
> +config SPL_SHARES_INIT_SP_ADDR
> +	default n
> +
> +config SPL_HAVE_INIT_STACK
> +	default y
> +
> +choice
> +	prompt "Qualcomm SoC select"
> +	default TARGET_NONE if !SPL
> +	help
> +	  While U-Boot on Qualcomm platforms doesn't generally need compile-time
> +	  adjustment based on the target SoC, there are a few exceptions to this.
> +	  Currently this concerns boot0.h discrimination.
> +
> +config TARGET_NONE
> +	bool "Generic build"
> +	help
> +	  Select this if you're not building SPL. U-Boot proper builds are currently
> +	  generic across all SoCs.
> +
> +config TARGET_SDM845
> +	bool "SPL targeting the sdm845 SoC"
> +	help
> +	  Select this if you are building u-boot SPL for sdm845.
> +	  Currently this gates sdm845-specific boot0.h (only used in SPL).

In Qualcomm ecosystem, we have been avoiding any SoC or board specific
config options in an effort to try people migrate to use generic platform
code only.

I think this boot0.h hook code is going to be one exception. Can you
rather define a special Kconfig option for this saying?

	BOOT0_SDM845_WORKAROUND

which can then be enabled in your special defconfig.

-Sumit
