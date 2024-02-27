Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC05C54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 03:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8331487F9E;
	Tue, 27 Feb 2024 04:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qNOfmDGP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D812A87FA4; Tue, 27 Feb 2024 04:17:04 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE6F87F7C
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 04:17:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412a3903586so13631615e9.3
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 19:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709003822; x=1709608622; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7IOdanBMfIR67R+XMYwQPx0x6QpgFcFNg6mPijt0+AY=;
 b=qNOfmDGP35PQ6xyQ75DaQEd7OmeoB3TO3FxVmdGURuoyxKIAVKAV0YoeAYi6JbQioF
 vYzijC0jpYYGBKV4YosgOZ7OMh2dr5R+7cZxj2vDRBoS5/jfB67EqSn5pf0GVo5oqtDH
 Ro9KpAl9n/p/3yGIhiqSiQM435n1usHoj3a7vZOLWqH0dg8SR3nNk0wbMbPmC8u275uR
 guRCr9TfpMiIhjR6q7u1fPZlWTTMjdWhWbWMDlkLkvUIui3Ql26098I7oWoLcBfhkSgG
 XwzTzHksoWHcbHqNdXZlBgwSebAKKxuhVy7ThhMhWH/FJHBKwqvA1ZnTnwuxUQViPgUn
 eLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709003822; x=1709608622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7IOdanBMfIR67R+XMYwQPx0x6QpgFcFNg6mPijt0+AY=;
 b=HyY8s5aaHoOiXZx3kmNdBF3tM5a7KcMTGjd6fin91tfB23369/BBmnfFsnMNUydjLv
 oXLt9EqrhcFrlQ95cD16uBtbMh/+IniyCYJAz4PXW+dqkn3yduCBI3tk93DMe6OLRtXd
 oBP0Upuwy7gcINl5SoPaI34zK9hbcTMAUf9rjlq15/jlUBx6mg+wyO1nFMC3LdeRwvDq
 XBLYgmfQW7OMDRydU5JlfE10rjNY8b/Jl56ArTKVI6mIy0mSFgLvP+SlpaxD53iIeNf/
 mByMOSoEGz6Yd/4gfqSRPeCT6naJDHK744pCFubIgWjyDVXCHYSlFxURtxWUN0YJHI9l
 KTIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVltfVUhCRwWlPDPS7g9+7PnS45XjdvxUilvZHLTFr8Th9VNzyn2irxGu0MRaKzn8wWAtJt2gYjOA4JGqLHNBeLbgDfHA==
X-Gm-Message-State: AOJu0Yy0VOCfQB9a1mZSKXqJJDTeu30UXAekkk09oFtDFHRZpRjTV8zZ
 17ax4I08fngopOoZMzGQ3W40gkge/ewmB+mv5+cVv8tOGmYxeYgwXIEgaiIXgqGHtzQGSrtiZwy
 I
X-Google-Smtp-Source: AGHT+IGfG0x4zni4Mz90DF8Sm+m4EvrYXxaGoPP3tThgzb98a5y9d1BIDGXYyUOxleAdkN7hEPS8Qg==
X-Received: by 2002:a05:600c:4f0c:b0:412:a123:492f with SMTP id
 l12-20020a05600c4f0c00b00412a123492fmr4555652wmq.35.1709003822142; 
 Mon, 26 Feb 2024 19:17:02 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g7-20020adfe407000000b0033d2ae84fafsm9842105wrm.52.2024.02.26.19.17.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 19:17:01 -0800 (PST)
Message-ID: <c35e5561-0285-4ff2-867b-1faa33a9a174@linaro.org>
Date: Tue, 27 Feb 2024 03:17:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] board: qualcomm: Add support for IPQ9574 RDP433
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-11-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-11-quic_varada@quicinc.com>
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



On 26/02/2024 10:08, Varadarajan Narayanan wrote:
> Provide the defconfig and include IPQ9574/RDP433 into the build
> framework.

Please squash this into a common patch along with the other board code
in your next revision.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> 
>  arch/arm/mach-snapdragon/Kconfig  |  15 ++++
>  arch/arm/mach-snapdragon/Makefile |   1 +
>  configs/ipq9574_mmc_defconfig     | 118 ++++++++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 configs/ipq9574_mmc_defconfig
> 
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index ad66710819..a4552028c1 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -90,6 +90,20 @@ config TARGET_QCS404EVB
>  	  - 1GiB RAM
>  	  - 8GiB eMMC, uSD slot
>  
> +config TARGET_IPQ9574
> +	bool "QTI IPQ9574 SOC"
> +	select OF_BOARD_SETUP
> +	select CLK_QCOM_IPQ9574
> +	select PINCTRL_QCOM_IPQ9574
> +	help
> +	  Support for IPQ95xx SoC.
> +	  - Board Open Platform Specifications.
> +	  - Quad Cores A73, max@2.2G, L1@32KB L2@512KB
> +	  - DDR3L/DDR4
> +	  - QSPI NAND / NOR / eMMC
> +	  - USB 3.0/I2C/UART/PCIe Gen3 2Lane
> +	  - 1G/2.5G/10G Ethernet Ports
> +
>  endchoice
>  
>  source "board/qualcomm/dragonboard410c/Kconfig"
> @@ -97,5 +111,6 @@ source "board/qualcomm/dragonboard820c/Kconfig"
>  source "board/qualcomm/dragonboard845c/Kconfig"
>  source "board/samsung/starqltechn/Kconfig"
>  source "board/qualcomm/qcs404-evb/Kconfig"
> +source "board/qualcomm/ipq9574/Kconfig"
>  
>  endif
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 3a3a297c17..a9af8d9ee0 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -4,6 +4,7 @@
>  
>  obj-$(CONFIG_SDM845) += sysmap-sdm845.o
>  obj-$(CONFIG_SDM845) += init_sdm845.o
> +obj-$(CONFIG_TARGET_IPQ9574) += init_ipq9574.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
>  obj-y += misc.o
> diff --git a/configs/ipq9574_mmc_defconfig b/configs/ipq9574_mmc_defconfig
> new file mode 100644
> index 0000000000..0001bd8eae
> --- /dev/null
> +++ b/configs/ipq9574_mmc_defconfig
> @@ -0,0 +1,118 @@
> +CONFIG_ARM=y
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_ARCH_64BIT_SUPPORT=y
> +# CONFIG_ARM64_SUPPORT_AARCH32 is not set
> +CONFIG_ARM_SMCCC=y
> +CONFIG_HAS_VBAR=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_IPQ9574=y
> +CONFIG_TARGET_IPQ9574=y
> +CONFIG_SYS_MALLOC_F_LEN=0x1000
> +CONFIG_SYS_MALLOC_F=y
> +CONFIG_SYS_LOAD_ADDR=0x50000000
> +CONFIG_TEXT_BASE=0x4A240000
> +CONFIG_SMEM_BASE_ADDR=0x4AA00000
> +CONFIG_NR_DRAM_BANKS=1
> +CONFIG_SMEM=y
> +CONFIG_SYS_MALLOC_LEN=0x180000
> +CONFIG_DM_SERIAL=y
> +CONFIG_DEFAULT_DEVICE_TREE="ipq9574-rdp433-mht-phy"
> +CONFIG_LOCALVERSION=""
> +CONFIG_LOCALVERSION_AUTO=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_EXPERT=y
> +CONFIG_SYS_MALLOC_CLEAR_ON_INIT=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_OF_LIBFDT=y
> +CONFIG_OF_LIBFDT_OVERLAY=y
> +# CONFIG_BOOTSTD_BOOTCOMMAND is not set
> +# CONFIG_PSCI_RESET is not set
> +CONFIG_FIRMWARE=y
> +CONFIG_DM=y
> +CONFIG_OF_CONTROL=y
> +CONFIG_FIT_SIGNATURE=n
> +CONFIG_TOOLS_LIBCRYPTO=y
> +CONFIG_TOOLS_FIT_RSASSA_PSS=n
> +CONFIG_TOOLS_FIT_SIGNATURE=n
> +CONFIG_TOOLS_SHA1=n
> +CONFIG_TOOLS_SHA256=n
> +CONFIG_TOOLS_SHA384=n
> +CONFIG_TOOLS_SHA512=n
> +CONFIG_SYS_EXTRA_OPTIONS=""
> +CONFIG_SYS_PROMPT="IPQ9574# "
> +# CONFIG_USE_PREBOOT is not set
> +CONFIG_BOOTDELAY=5
> +CONFIG_USE_BOOTARGS=y
> +CONFIG_USE_BOOTCOMMAND=y
> +CONFIG_BOOTCOMMAND=""
> +CONFIG_BOOTARGS="console=ttyMSM0,115200n8"
> +# CONFIG_BOOTSTD is not set
> +CONFIG_HUSH_PARSER=y
> +CONFIG_SYS_MAXARGS=64
> +CONFIG_OF_BOARD_FIXUP=y
> +CONFIG_STACKPROTECTOR=y
> +CONFIG_MSM_SMEM=y
> +CONFIG_SYS_CUSTOM_LDSCRIPT=y
> +CONFIG_SYS_LDSCRIPT="board/qualcomm/ipq9574/u-boot-x64.lds"
> +CONFIG_OF_LIST="ipq9574-rdp433-mht-phy"
> +CONFIG_DTB_RESELECT=y
> +CONFIG_MULTI_DTB_FIT=y
> +CONFIG_MULTI_DTB_FIT_LZO=y
> +CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
> +CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR=0x4A400000
> +CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x100000
> +# CONFIG_CMD_BOOTI is not set
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_CLK=y
> +CONFIG_CLK_QCOM=y
> +CONFIG_CLK_IPQ9574=y
> +# CONFIG_OF_EMBED is not set
> +CONFIG_PINCTRL=y
> +CONFIG_PINCTRL_QCOM=y
> +CONFIG_PINCTRL_QCOM_IPQ9574=y
> +CONFIG_IPQ_MMC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_GPIO=y
> +# CONFIG_CONFIG_GPIO_EXTRA_HEADER is not set
> +CONFIG_DM_GPIO=y
> +CONFIG_MMC_SDHCI_MSM=y
> +# CONFIG_EFI_LOADER is not set
> +# CONFIG_MMC_HS200_SUPPORT is not set
> +CONFIG_EFI_PARTITION=y
> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> +CONFIG_MSM_GPIO=y
> +CONFIG_PINCONF=y
> +# CONFIG_CMD_GPIO is not set
> +CONFIG_MSM_SERIAL=y
> +CONFIG_STACK_SIZE=0x80000
> +CONFIG_SYS_BOOTM_LEN=0x4000000
> +CONFIG_DM_RESET=y
> +CONFIG_RAM_NUM_PART_ENTRIES=32
> +CONFIG_RAM_PART_NAME_LENGTH=16
> +CONFIG_RESET_QCOM=y
> +CONFIG_NUM_ALT_PARTITION=16
> +CONFIG_BOARD_TYPES=y
> +CONFIG_BOARD_EARLY_INIT_F=y
> +CONFIG_IPQ_USB=y
> +CONFIG_IPQ_SPI_NOR=y
> +# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_SYS_MMC_ENV_PART=0
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_ENV_RANGE=0x40000
> +CONFIG_ENV_OFFSET=0
> +CONFIG_SF_DEFAULT_BUS=0
> +CONFIG_SF_DEFAULT_CS=0
> +CONFIG_SF_DEFAULT_MODE=0x0
> +CONFIG_SF_DEFAULT_SPEED=50000000
> +CONFIG_SYS_RX_ETH_BUFFER=128
> +CONFIG_ETH_MAX_MAC=6
> +CONFIG_ETH_MAX_UNIPHY=3
> +CONFIG_TFTP_BLOCKSIZE=1280
> +# CONFIG_CMD_FLASH is not set
> +CONFIG_CMD_MMC=y
> +CONFIG_IPQ_FDT_FIXUP=y
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4a077e60

-- 
// Caleb (they/them)
