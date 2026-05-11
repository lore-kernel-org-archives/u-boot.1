Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2710ECD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8024184659;
	Mon, 11 May 2026 15:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MYnwlNCf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2542381E18; Mon, 11 May 2026 15:05:11 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28D0C800AE
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6763cc8775cso9552430a12.0
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778504708; x=1779109508; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HeF3I9x/2KjRT12yjxYWVzMtKn/Xo5ZTMmFlH576UTI=;
 b=MYnwlNCf6YfmBBQgThCGTyZIAnKUjHCy6efQil77Nsy2YGuZaAiXgm1RNjMoDN1oWb
 xMQ7H9OvMXJ4DZGp2+elVkETVOrWC9fCOcs3uGEKLfnlFv59MqMLDH8NFTDxyOR+Hg3d
 iXdwCjnAnAT+vStIaDQv7mnyeT1Np/IhrY7vH6+Ze+qHCvFVUIRCFywWPFWowQrnsqmp
 s12L+J06tW4R6qoo3J5SCMeKQ+Tt0ANxGkQgJpqU4d6d8FbswhzTLYms6KrKowzbEMAU
 OVurhVXDi5RtXwd9ALKhy5Q7k7H2BZoj0F9DQGs7mgrgs9vHTbGF53EcJsu1vJXVsWeS
 Ki5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504708; x=1779109508;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HeF3I9x/2KjRT12yjxYWVzMtKn/Xo5ZTMmFlH576UTI=;
 b=iomhZPyFnAAqDwg/xo/reTpBcMEHcpAitCqyzOX0Ew8JyU8Oo2zbQ/3VLLeVlUA4Ea
 88CICKkmaihZ49TshoudJ8M8qCFCTwKuFM1iQQgON4IAouLFiwIfdiyP5LefZIOTz7Aq
 kMLVd9fGTib6oBq2ZBAy/jCFiyc4+63ISmDLgeNtyYmmYVfrvKGVcgD7UF9q8WdP3EPs
 /HRxRi9Mt0Hzsk/4P9HC0oK/Vdfkj26TY2ZpBMpKX3ZXHSQdHOgBadZHgcpCqyaXSdxz
 WwAu2itwtLNShiNXCBv68eWpWJzQB5mTOLha8MnPJHM1Vc4dFebKPtlmAv9gV4IwXPef
 n0SA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MiSgupS5Yltol33YT+fYlkU4YYy0H2Ja2zYwJ1m/hWVANKNjuF/7IdusB9gzthC9AcaCP0ao=@lists.denx.de
X-Gm-Message-State: AOJu0YwW9JcKW65wxspTSEYP3l0TRWYnW6RhljNCleEpG9DcRvSr6wna
 ++ZR/WxCXVtGeOzJLXuHRTUK3lodff1N10stWybxOmhq1pWB+79AFK9YwPRWBBmaLNs=
X-Gm-Gg: Acq92OFIpDIjOkQaOVUidZzmJEiKPR4A+PmJWx7UhomfnwtReolUuuAA30hR+tDGxww
 FKPCbo1nttTtkvzGay8iYgJnbgemwKjxq2LPZNxME9xWzGA2lIeBNc8H9lAeVH/n2efQxRCDKfk
 rWeoSFyZlPx9dKIEGE5V/Ze3GrADaa0wt++3o+jYLXYGCCFu4GVlePk9EzNdd8DnTe9rBpw523k
 0ps7aOPCqcaTm9bfDjJmbQoC4x7R4OIz62zl+UH2Mqbl5XU3RQr6LUezQ/GzclwZcPr4rMCszNU
 EuHTMUyXEK/LEyK7rKv9NXaWPslOKdZWeloHEa9RB8Iu+JNd9k3/n9CSgz3frNi3A4sllVpxo4Q
 AnjKEH47j3xJwGnZKHFXDLH5lZlAzXB9erwk+LdEOdtJJl1T1dC1Go7yrAVjE3nR0c5tItkvfE7
 p91ntYvALZFmdQuucwFckT6alEOjdXJaYiRbkltgzXiojXyOorWDUGW2OK2LYGbXtT7Q==
X-Received: by 2002:a17:907:2d11:b0:bd1:b97c:5c6e with SMTP id
 a640c23a62f3a-bd1b97c654amr68957266b.17.1778504708014; 
 Mon, 11 May 2026 06:05:08 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bcd60f726desm278217366b.25.2026.05.11.06.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 06:05:07 -0700 (PDT)
Message-ID: <fc28d41d-957e-41b2-95ec-85b328dd611e@linaro.org>
Date: Mon, 11 May 2026 15:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/11] mach-snapdragon: Kconfig: changes / additions to
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
References: <20260508-qcom_spl-v7-0-7d0e22aaaa8f@seznam.cz>
 <20260508-qcom_spl-v7-7-7d0e22aaaa8f@seznam.cz>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260508-qcom_spl-v7-7-7d0e22aaaa8f@seznam.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 11 May 2026 15:25:54 +0200
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

On 08/05/2026 23:45, michael.srba@seznam.cz wrote:
> From: Michael Srba <Michael.Srba@seznam.cz>
> 
> Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI in SPL.
> (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else will.)

I'm not sure if this was mentioned in a previous revision, but would it
be possible to introduce a SNAPDRAGON_SPL kconfig (mayyybe in the
mach-snapdragon kconfig?) to contain all the "if SPL" options and just
simplify the list here? It just feels wrong to have half the options in
the list be gated like this.

It seems quite likely that we will end up with a few different SPL
variants for snapdragon:

1. Your implementation for older SoCs doing many things from scratch
2. Qualcomms version for IoT more tightly integrated with TF-A
3. Another version I've seen where SPL is just used to chainload a full
U-Boot and provide an extra level of redundancy

These will all have slightly different requirements and code paths so
being able to express this via kconfig seems like a good way to try and
keep things manageable.

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
> index f624675eadf..8e818071df6 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1135,6 +1135,7 @@ config ARCH_SNAPDRAGON
>  	bool "Qualcomm Snapdragon SoCs"
>  	select ARM64
>  	select DM
> +	select DM_EVENT if USB_DWC3_GENERIC
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

