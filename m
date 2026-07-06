Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C83C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA5ED8488D;
	Mon,  6 Jul 2026 14:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rVL/aJiB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B29C8848D2; Mon,  6 Jul 2026 14:30:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65412846FD
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c125fbfbae0so283944966b.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783341039; x=1783945839; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dYIB5mxtWam9RaJo92bvyID3LFZEEksYkhZiam2+PIY=;
 b=rVL/aJiB5QtXEKcVis63gR/GI7r95wkv13ScLFNSBW/E8CSqOlyRVJw1hssCBX7gVv
 UPnVO+/ST8k36lZIlkLHpfoanNyzdvKwaKxigrgLhqE7DBYk6MzJ+f5fE6u448r8YTBT
 B4yQ/89gZ3qnPaz2lhhRDwpkgLe1053SSRFAubDvxRwZf5kexsmjJY9oA39cLltnEVNt
 E5EdRMLZ5xIFZHgdAMRLF4CJ4yPQ+EFc7ThPvPVWndf54l5/DTelTm5x8R2eBAjnzLKA
 Md6hvujyssBOA1GVOTbm8k7K6E2ssh9HqBAA+OPgHJoLqTUSxYxHklV8FPMBg7EvP6cf
 MP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783341039; x=1783945839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dYIB5mxtWam9RaJo92bvyID3LFZEEksYkhZiam2+PIY=;
 b=cI/IN/JONAHusKtOZlA9G8R34D1sqOwzbR2UwiDdX5ru2P+xBiI4/4IoSR2GJWM41V
 Nf8OFuH441b6cjR461/m6JsXfe2f3irf9sVKQpIN2Q89LomkIev9FuP01E48v2bkxr9T
 BL0AUSjXDWTIrpqevOo0N/uE3myM0m/gSPcINyDwIg48kX9fFDvrLV5rIfG+bKd3x0uV
 3QlJNGVXEA38HH1a2dsVXSPrXGYnbztvn7jKQtXZ3uZf/ZIaPSqshZxWJGmucHF2R4rj
 YElpuPpn2VKaZwmmuX4r7FqVe36WiZZ5BQ66br+jgMFvc7qPzP1ZEoqEmdjkmIv5NNQw
 tTIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVJfYru5zRvTmxCq3NfqmKnMD6JESZZrPjeslg4wUnUp35N2n105XBAP1AACIAFQEyy1JPt2c=@lists.denx.de
X-Gm-Message-State: AOJu0YzzlspdMu/XEfzE9YgQE8KhkHLwGse0ob05UXEWoe5HF5YwGMEa
 9zX83B/AlqahXBkyLPMhIsbnl7+KPu0kfXCnJG1fj+FbBHaLLnWw+xX5tkLCXElczMQna/zOXuA
 S9kec
X-Gm-Gg: AfdE7cnhAQaR6HP/Uqb20YpxJ1ZiXNhhw0S6GB294Y9MMwoi3zOQ/N4Sw88vTkrFuTh
 HC+7EXc1ASvId4McTEcX4eWYE/NBWmkCPGEtkpQv3ZT0QkzVAmXB/B28km7lS+zdDMPEyxZPOSO
 XUT3mykKzKiUCNC8/PkHEux/y9mHHfI7heZetguYGmVpOduPEvqgVBMefk4l2xWlS8TqB6AIEk/
 qPU5VYJVrLJl3BbjIrPzkAWov4kC88REgzla8Rr58yJUsFebxrCBh7maPdHA3OeXJVJPsT21Z50
 61HYRDLpOhWZdVtxp13EnwxnEaPITXDk4nnYc4+rsSkpYi61I94xdUUij1BPSEAFf9RBYWTD5O3
 oIYWaGXss88GWQrI9aJPMK5FhK0zViWymGMUjW5nE1cyrwIVMmM9GstpbIPcAdDy6Vp9wNidn9q
 UWSX86n1mvnTnVlTHX2wM92xAo0r251mpoYM65LUWsB34IXW4jO2lbSrSZ/54IUpo=
X-Received: by 2002:a17:906:e20a:b0:bf0:550:d9f with SMTP id
 a640c23a62f3a-c15a67bc8ffmr15749266b.31.1783341038769; 
 Mon, 06 Jul 2026 05:30:38 -0700 (PDT)
Received: from [172.18.183.38] (ip-185-104-138-126.ptr.icomera.net.
 [185.104.138.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c12b62c552esm739470066b.49.2026.07.06.05.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 05:30:37 -0700 (PDT)
Message-ID: <232ce0c8-fec2-4cb3-9b3c-732e35a1525d@linaro.org>
Date: Mon, 6 Jul 2026 14:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] arm: snapdragon: Add CONFIG_QCOM_SNAGBOOT_MODE
 option
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Michael Srba <Michael.Srba@seznam.cz>,
 Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
 <20260619-snagboot-v4-1-385497442db2@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260619-snagboot-v4-1-385497442db2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Balaji,

On 6/19/26 13:10, Balaji Selvanathan wrote:
> Add CONFIG_QCOM_SNAGBOOT_MODE to enable snagboot mode on Qualcomm
> platforms. This config automatically selects the required dependencies.
> 
> Add QCOM_BOOT0_SNAGBOOT_MODE as boot0.h config for automatic selection
> by QCOM_SNAGBOOT_MODE. Document the platform-specific requirements and
> configs that must be disabled in snagboot mode.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v4:
> - Renamed QCOM_SNAGBOOT_SUPPORT to QCOM_SNAGBOOT_MODE
> - Added QCOM_BOOT0_SNAGBOOT_MODE for boot0.h which gets selected by
>    QCOM_SNAGBOOT_MODE
> - Document the platform-specific requirements and configs that must be
>    disabled in snagboot mode.
> 
> Changes in v3:
> - Newly introduced in v3
> ---
>   arch/arm/mach-snapdragon/Kconfig | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 931d25c1023..5c7dbe0dcc4 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -65,4 +65,32 @@ config QCOM_EL2_GUNYAH_EXIT_SUPPORT
>   	  run properly at EL2.
>   endchoice
>   
> +config QCOM_BOOT0_SNAGBOOT_MODE
> +	bool "boot0.h initialization for Snagboot mode"

I don't think this should be visible in menuconfig, it should be internal.

The config should be inside the choice block though I think? not sure if 
that's possible if it's not selectable> +	help
> +	  Enable boot0.h early initialization required when U-Boot
> +	  is loaded in Snagboot mode by XBL.> +
> +config QCOM_SNAGBOOT_MODE
> +	bool "Build U-Boot for Snagboot mode loading"
> +	select QCOM_BOOT0_SNAGBOOT_MODE
> +	select ENABLE_ARM_SOC_BOOT0_HOOK

> +	select SKIP_RELOCATE
> +	help
> +	  Build U-Boot to be loaded in Snagboot mode on Qualcomm platforms
> +	  for device/factory provisioning using fastboot.
> +
> +	  Snagboot mode requires disabling several configs in your defconfig:
> +	  - PSCI_RESET: Not available in Snagboot mode
> +	  - IOMMU: Not initialized by XBL in Snagboot mode
> +	  - SAVE_PREV_BL_INITRAMFS_START_ADDR: Previous bootloader context
> +	    is not preserved in snagboot mode
> +	  - REBOOT_MODE_ENV_UPDATE: Not applicable in device/factory provisioning mode

this isn't how kconfig works, use depends> +
> +	  Additionally, use CONFIG_ENV_IS_NOWHERE to ensure recovery works
> +	  even with corrupted environment storage.

select ENV_IS_NOWHERE
depends on !ENV_IS_IN_SCSI

> +
> +	  Platform-specific requirements:
> +	  - Set CONFIG_COUNTER_FREQUENCY to match your platform's timer
> +	  - Configure CONFIG_TEXT_BASE for U-Boot load address

you can probably depend on these being non-zero too

Thanks,
// Casey

>   endif
> 

