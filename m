Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D409C021A4
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B16809D0;
	Wed, 12 Feb 2025 16:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tIp436pj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C8380C69; Wed, 12 Feb 2025 16:57:46 +0100 (CET)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C90807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:57:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-54508b026d1so3558904e87.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739375864; x=1739980664; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F5c2EBfKF/xumbrZ0ktVeadtFwmnv31IdMNu5Fo+Jm4=;
 b=tIp436pjWo2wMucf/LRbvCrDswqJUIq7Jx7CiRiElYay0QXgrKo3ctNw3EXysm/5F6
 3ADYh4jjLyzweiCAKE3EqxyK12dX8/nhepDoMii8P2QjCKlC+7N2g+s5IB/8vlNnuOmb
 BS72+pekOBLqW6tgDKBAzYddOePEvP7uenGl3s3R4dtel27twpBtI2L90qILWw+ZnLhL
 DiPZCrc5E9RyOFFvgMf5OwM4C9bgolyUz8bxhpDxxDdUROuQg+l1yTaz1Y9MNyMcRORi
 uAF8BwxBt0JAm6N/gY4Cyu4jv+VRhO6gfsRDGhak55NgjJfWelnZUDMlnOruKlLojR0Y
 AEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739375864; x=1739980664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F5c2EBfKF/xumbrZ0ktVeadtFwmnv31IdMNu5Fo+Jm4=;
 b=A1wIneXZHyf/U+T1I/cyACQP6VTUBvl8vRY5dlvxIA4QsJuG4IndDhpWJZyNLvxKpf
 dy5xO8rH+JAH/tdHAUjp2gcibvE6htyP17OM5HejsW0Sz/TIbaM9AueDV8Mz8e/A+Z+V
 2H3gwMwhI11TGE9GYnJ8IjLmwIUzyWOXKMoX6hZq1pcl8HyJqGoX2wHOaZ+H01cUX8bU
 SKlyA8BC74I+T24OoGatxxVI6pxxbpEC3KDGxtKfCNX0vrcfT0dgBAo6HZzr0L1TasJl
 2jNPwsXzYo8WUxxSE9yzGMlDce6RCp+rtJwJSOmYXJE0ykWvZMCIQgnoECuGOiAe/BdK
 n+uw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu+L6v/IO3CUeUZIEABdz7DERe9MVuuLw4zz2D3vk0fKKjaiCA9lGyp07/8cTy8JbPdt4+ZUI=@lists.denx.de
X-Gm-Message-State: AOJu0YzZYzdMvaiFBfm9BGmIec0dyiZL48b1guVJ4XdyWe7HZhFhI3bd
 LJvynDi3SsyEd02Mvmf4wkHgLU7t+tzlEkLUAN6mRFSbFnQK9YmHPwe4y+Fp7uY=
X-Gm-Gg: ASbGncvTBDIylV72mm0XYpFN+B9gnERgXcwflDzpXOnnMes+PZ1WSNwvPpPeAlIc6eI
 0KQNlWE7tgHr5JIh17dYPN4T+nHgq+KoqqH5i9cHmRuD/AGn0haFPn5WrvJ3xVpv1NQI1S8vVTv
 NZeL2gkEPR8AybkngBCuSmlEKU5j2KMEi9IQMHu//28cjb+6gVO3lvmv/tvNEOjexLH7QYFZnrs
 hmVJTdqIhH2w4sO54TUHm4/MDKFP0k/KiNOHcGXZh6cgsCEJeiJS7JklpCGClwh9UQQ2ZCWnytc
 w4cJ4Dq1qw0vUYw5eTj69aAwIfJr1aIs5O9ULEVO1avc11RF2QEvkWxoqdE19BZJd/IKVw==
X-Google-Smtp-Source: AGHT+IGgbjjRYT3nfRK9CYKE3x8DitGVBj1Tn6/v+wB+AauwXBQK5sW2AqlGCVPYLPFhHPYnag2dYw==
X-Received: by 2002:ac2:4c4d:0:b0:545:ee3:f3b8 with SMTP id
 2adb3069b0e04-54518122d65mr1206580e87.28.1739375863690; 
 Wed, 12 Feb 2025 07:57:43 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-54506b8a20fsm1339098e87.31.2025.02.12.07.57.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:57:41 -0800 (PST)
Message-ID: <f0c50d9c-c50d-44b7-add0-e0c2ca83873f@linaro.org>
Date: Wed, 12 Feb 2025 15:57:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] configs: add ipq9574_mmc_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
 <20250130053751.3148614-7-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250130053751.3148614-7-quic_varada@quicinc.com>
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

Hi Varadarajan,

On 1/30/25 05:37, Varadarajan Narayanan wrote:
> Introduce a defconfig for the Qualcomm IPQ9574 SoC based RDPs.
> Presently supports eMMC.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   configs/ipq9574_mmc_defconfig | 111 ++++++++++++++++++++++++++++++++++
>   1 file changed, 111 insertions(+)
>   create mode 100644 configs/ipq9574_mmc_defconfig
> 
> diff --git a/configs/ipq9574_mmc_defconfig b/configs/ipq9574_mmc_defconfig

Please name this qcom_ipq9574_mmc_defconfig

> new file mode 100644
> index 0000000000..62201d7948
> --- /dev/null
> +++ b/configs/ipq9574_mmc_defconfig
> @@ -0,0 +1,111 @@
> +#include "qcom_defconfig"
> +
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x78b1000
> +CONFIG_DEBUG_UART_MSM=y
> +CONFIG_DEBUG_UART_CLOCK=1843200
> +# Address where U-Boot will be loaded

This comment is redundant, please remove it.

With that

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>

Kind regards,
> +CONFIG_TEXT_BASE=0x4A240000
> +CONFIG_REMAKE_ELF=y
> +CONFIG_SYS_LOAD_ADDR=0x50000000
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTDELAY=2
> +CONFIG_OF_BOARD_SETUP=y
> +CONFIG_SYS_CBSIZE=1024
> +CONFIG_SYS_PBSIZE=1024
> +CONFIG_OF_LIVE=y
> +CONFIG_MSM_GPIO=y
> +CONFIG_CLK_QCOM_IPQ9574=y
> +CONFIG_PINCTRL_QCOM_IPQ9574=y
> +CONFIG_MSM_SERIAL=y
> +CONFIG_DM_EVENT=y
> +CONFIG_ENV_IS_IN_MMC=y
> +CONFIG_ENV_SIZE=0x40000
> +CONFIG_ENV_OFFSET=0
> +CONFIG_PARTITIONS=y
> +CONFIG_PARTITION_UUIDS=y
> +CONFIG_MTD=y
> +CONFIG_MTD_PARTS=y
> +
> +#
> +# Turning off many options so that u-boot size is less
> +# than 756KB.
> +#
> +# CONFIG_BOOTP_PXE is not set
> +# CONFIG_BUTTON_KEYBOARD is not set
> +# CONFIG_CLK_QCOM_APQ8016 is not set
> +# CONFIG_CLK_QCOM_APQ8096 is not set
> +# CONFIG_CLK_QCOM_QCM2290 is not set
> +# CONFIG_CLK_QCOM_QCS404 is not set
> +# CONFIG_CLK_QCOM_SC7280 is not set
> +# CONFIG_CLK_QCOM_SDM845 is not set
> +# CONFIG_CLK_QCOM_SM6115 is not set
> +# CONFIG_CLK_QCOM_SM8150 is not set
> +# CONFIG_CLK_QCOM_SM8250 is not set
> +# CONFIG_CLK_QCOM_SM8550 is not set
> +# CONFIG_CLK_QCOM_SM8650 is not set
> +# CONFIG_CMD_BOOTP is not set
> +# CONFIG_CMD_GPIO is not set
> +# CONFIG_CMD_I2C is not set
> +# CONFIG_CMD_MII is not set
> +# CONFIG_CMD_NET is not set
> +# CONFIG_CMD_PING is not set
> +# CONFIG_CMD_PINMUX is not set
> +# CONFIG_CMD_PXE is not set
> +# CONFIG_CMD_RNG is not set
> +# CONFIG_CMD_TFTPBOOT is not set
> +# CONFIG_DISPLAY_CPUINFO is not set
> +# CONFIG_DM_ETH is not set
> +# CONFIG_DM_I2C is not set
> +# CONFIG_DM_KEYBOARD is not set
> +# CONFIG_DM_MDIO is not set
> +# CONFIG_DM_PMIC is not set
> +# CONFIG_DM_REGULATOR_COMMON is not set
> +# CONFIG_DM_REGULATOR_FIXED is not set
> +# CONFIG_DM_REGULATOR is not set
> +# CONFIG_DM_REGULATOR_QCOM_RPMH is not set
> +# CONFIG_DM_USB is not set
> +# CONFIG_ETH is not set
> +# CONFIG_FS_EXT4 is not set
> +# CONFIG_FS_FAT is not set
> +# CONFIG_I2C is not set
> +# CONFIG_INPUT is not set
> +# CONFIG_IOMMU is not set
> +# CONFIG_LEGACY_CRYPTO_BASIC is not set
> +# CONFIG_LEGACY_CRYPTO_CERT is not set
> +# CONFIG_LEGACY_CRYPTO is not set
> +# CONFIG_LIB_RAND is not set
> +# CONFIG_MD5_LEGACY is not set
> +# CONFIG_MISC is not set
> +# CONFIG_MMC_HS200_SUPPORT is not set
> +# CONFIG_NETDEVICES is not set
> +# CONFIG_NVMEM is not set
> +# CONFIG_PHY_GIGE is not set
> +# CONFIG_PHYLIB is not set
> +# CONFIG_PINCTRL_QCOM_APQ8016 is not set
> +# CONFIG_PINCTRL_QCOM_APQ8096 is not set
> +# CONFIG_PINCTRL_QCOM_IPQ4019 is not set
> +# CONFIG_PINCTRL_QCOM_QCM2290 is not set
> +# CONFIG_PINCTRL_QCOM_QCS404 is not set
> +# CONFIG_PINCTRL_QCOM_SDM845 is not set
> +# CONFIG_PINCTRL_QCOM_SM6115 is not set
> +# CONFIG_PINCTRL_QCOM_SM8150 is not set
> +# CONFIG_PINCTRL_QCOM_SM8250 is not set
> +# CONFIG_PINCTRL_QCOM_SM8550 is not set
> +# CONFIG_PINCTRL_QCOM_SM8650 is not set
> +# CONFIG_PMIC_CHILDREN is not set
> +# CONFIG_PMIC_QCOM is not set
> +# CONFIG_POWER_DOMAIN is not set
> +# CONFIG_PXE_UTILS is not set
> +# CONFIG_QCOM_HYP_SMMU is not set
> +# CONFIG_REGEX is not set
> +# CONFIG_RGMII is not set
> +# CONFIG_SHA1_LEGACY is not set
> +# CONFIG_SHA256_LEGACY is not set
> +# CONFIG_UFS is not set
> +# CONFIG_USB is not set
> +# CONFIG_VIDEO is not set

-- 
Caleb (they/them)

