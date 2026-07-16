Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12DFC4450E
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 11:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61CD084CBA;
	Thu, 16 Jul 2026 13:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X83jx8l8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06FCD84CA3; Thu, 16 Jul 2026 13:20:52 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129DC84CBC
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 13:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15c42a45adso27706066b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784200848; x=1784805648; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fPqdLwJtNhL7Cfhu68zGODUvXN1tPYWCT5NQloz2odw=;
 b=X83jx8l81ox+uPO43YL8fK6pWoxy8vQh5Fy4Bv2onT1ExJ31oQFRDFfTJMXMUvjEWq
 NnA3bVYlfhVi2ANN50KPoKeS4AyBeIJgDOCDYQxd9oYh//AdZoWWgxvr5C5p/6+l4gGW
 +SiNweuVYHwW4TQFjmIEbniSav0nU/Zgkk15H7Fv+sLNq+Z/feRzgQ0F5zJW7FF/zZ/I
 DN2wllX6xvVEywTUOUvje1RZKCZG8VWAiovnNMPE8v+zcJaAsLTM7B8aGJjneQeHgK+X
 sdhnkhYuaQUT0pOXq13evlES3nzlIadisNrj5kz+imHStdfoEy4bUQO/Ez3UPOvnBaaE
 NpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784200848; x=1784805648;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fPqdLwJtNhL7Cfhu68zGODUvXN1tPYWCT5NQloz2odw=;
 b=AC9a4LFe6S1iWrDTIupmPrs9LKxM3a0348sei/49MkjA54uuQWKU3HW26JlEtE3uKH
 k0PtY/fdR60XSJi7QJyoRrClNv/cgzhbuBko2N3qnyS/L0YSr6/xTX09QDG6nVXHRu4o
 njtHyTwhDTMO9zVcs2bh4/gWK35Jt7j9FsN46AueekArQzR1SC9yPfQpZvRZyoRSwPXJ
 PZy3YhRe4AHsLuSfwOy4ci047nC7V/f0n/DVCWhtWehvaCydlDr5bbsAoa5PVzhysVu4
 +evzb76SNX3mNTjnLQYIA1+AxgT6ZITtmUvvW1xkz+l5OBxkGlEVi7VOWO8n2rj6naGt
 rEUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRxShRKvygqFb2eBHFC/kJZaf3WkxNc1qYaQgefhBBj/CzWcL8RO5bTn5bkCgFmqW2c/kfU+A=@lists.denx.de
X-Gm-Message-State: AOJu0YwbFtxESWJwzrKQ4nLpMcTcOcWhIaDdx7LIRW6MnMJhxIxKZd+R
 tLd8BKq25LPpYQ5RUR8PuPfOpxT+kNDItXCc2Rokn1bK+FUMIbj6i0ROmSQxOpwpjHc=
X-Gm-Gg: AfdE7clKun5bYTdJhm9kOZxA0OS1Xo58nRIemIvvWmDi07vCQ7hUm+wWVUXwEoTaQ7S
 EYsbMMk4leq3T/WUo/sCdpJkL/BtLJABHArc6XToyilDbkOk4+bAL0Z2Luv9WLxphUQ0VHC6w0y
 Q7qiRJZWo/W2oxuDF14uDSRS1KCzZW2AAPuWWeS7TQqge2+CQCSnTzBhB7bMLoFnsodRn/VT1/2
 ECr1ZZG3yN8iti+Fp9Rt1Ak5BOMLQ/CveJpuCu2pMrKitBedkud7JQbfAZFuNbJMJE/s40ungh2
 +NnX2ySkbJECt5snI7i+EfZj+Ap5PMzckgKCjkTZHb1iPACQJJuHLO+jOygJDCMLdquDQWlle9c
 j/6u2phYIBZ2EfA0RpM7QqWTDSWIYcsCJ9cx5wbg8gK3RUJO2bqpr5RImRmj9aB4o2dLwe11oQ9
 7juucacsbS1dCUCluSQfWjN+LgMhp+A5j/ZSOlsfbtDqBzO+ZJyVKt9WdR
X-Received: by 2002:a17:907:980f:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c1692083c5fmr116391266b.6.1784200848460; 
 Thu, 16 Jul 2026 04:20:48 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:1101:38d6:d9a8:b75:f345?
 ([2a0a:ef40:1d11:1101:38d6:d9a8:b75:f345])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16874a2453sm189824766b.56.2026.07.16.04.20.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 04:20:47 -0700 (PDT)
Message-ID: <f1900b5d-5701-41aa-94bc-8145a337dd91@linaro.org>
Date: Thu, 16 Jul 2026 12:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] configs: Add defconfig for ipq9650 RDP488
To: Badhrinath S <badhrinath.s@oss.qualcomm.com>, trini@konsulko.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, michal.simek@amd.com,
 adrian@mainlining.org, danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 david.wronek@mainlining.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20260716062318.4121929-1-badhrina@qti.qualcomm.com>
 <20260716062318.4121929-5-badhrina@qti.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260716062318.4121929-5-badhrina@qti.qualcomm.com>
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

Hi Badhrinath,

On 7/16/26 07:23, Badhrinath S wrote:
> From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
> 
> Add default configuration for the IPQ9650 RDP488 board with eMMC boot
> support.
> 
> Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
> ---
>   configs/qcom_ipq9650_mmc_defconfig | 21 +++++++++++++++++
>   configs/qcom_ipqdefconfig          | 37 ++++++++++++++++++++++++++++++
>   2 files changed, 58 insertions(+)
>   create mode 100644 configs/qcom_ipq9650_mmc_defconfig
>   create mode 100644 configs/qcom_ipqdefconfig
> 
> diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
> new file mode 100644
> index 000000000000..de730067359c
> --- /dev/null
> +++ b/configs/qcom_ipq9650_mmc_defconfig
> @@ -0,0 +1,21 @@
> +#include "qcom_ipqdefconfig"
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
> +CONFIG_TEXT_BASE=0x8a280000
> +CONFIG_NR_DRAM_BANKS=24
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_ENV_OFFSET=0
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
> +CONFIG_SYS_LOAD_ADDR=0x90000000
> +CONFIG_DEBUG_UART_BASE=0x1a98000
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +CONFIG_SYS_PBSIZE=1024
> +CONFIG_CLK_QCOM_IPQ9650=y
> +CONFIG_CMD_MMC=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_ADMA=y
> +CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_PINCTRL_QCOM_IPQ9650=y
> +CONFIG_DEBUG_UART_MSM_GENI=y

Do we really need debug uart in here?

> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_SYS_MALLOC_LEN=0xC0000
> diff --git a/configs/qcom_ipqdefconfig b/configs/qcom_ipqdefconfig
> new file mode 100644
> index 000000000000..6a7f3c1b4ac6
> --- /dev/null
> +++ b/configs/qcom_ipqdefconfig


Does this defconfig build a functional image? Or is it only ever meant 
to be included by board specific defconfigs? If it's the latter case 
then this should be a config fragment instead (just rename the file to 
qcom-ipq.config or something).


> @@ -0,0 +1,37 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_ARCH_SNAPDRAGON=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_REMAKE_ELF=y
> +# CONFIG_EFI_LOADER is not set
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +# CONFIG_BOOTSTD is not set
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_USE_PREBOOT=y
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_HUSH_PARSER=y
> +CONFIG_CMD_PART=y
> +CONFIG_OF_LIVE=y
> +CONFIG_CLK=y
> +CONFIG_MSM_GPIO=y
> +# CONFIG_I2C is not set
> +# CONFIG_INPUT is not set
> +CONFIG_MISC=y
> +CONFIG_QCOM_GENI=y
> +CONFIG_MTD=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_RGMII=y
> +CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QMP_UFS=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_PINCTRL=y
> +CONFIG_PINCONF=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_MSM_GENI_SERIAL=y
> +CONFIG_SOC_QCOM=y

