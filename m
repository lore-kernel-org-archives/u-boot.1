Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9408C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 12:19:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B69800D7;
	Wed, 19 Feb 2025 13:19:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UXa5Itvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2085A801BE; Wed, 19 Feb 2025 13:19:03 +0100 (CET)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A10C8800B3
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 13:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-8641bc78952so1618055241.0
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 04:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739967539; x=1740572339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ugZdrJw/V/P0X+VGlOcFsdjjJ+rDOD6snVykd/ULHs=;
 b=UXa5Itvi+mvyyA+RZoNS4RbDATcNgINdFyvhUg0OVu1UoiS39TsIW2Q0budXwV5yEy
 IcePccEns6JduGZEv3uA2B/dSTkBsJmf3lPGTKmFHVuUsPdX8hPxnt80+KvifDHdYMQr
 KUaSEU+yV7RMdoz6SgZsHdFoQ3ijxPtvn+8JCVVLmfr3Yh0FHy6QwHjG9h17qakBhW6p
 7FF7uIBqCl6qzd7HWL+5Mj9tP519B5cexiyfZV8zwAudE01BwwzVjWxHEQMEkgm5CfTQ
 V0ANJZ8qUTYmWlgzHVY8rucfSwrwFjsSvdEUrrm2o0CW6g0+q4yXDhFAJW9lzgOApF4o
 1oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739967539; x=1740572339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ugZdrJw/V/P0X+VGlOcFsdjjJ+rDOD6snVykd/ULHs=;
 b=p7w+WjXLeiD9IF/V6XRxgKqN8ItjnrDoGzStFL+qkZICBQYz6FBhZwxOAI2yrDa0b9
 HbPGs9CpeZy6qcUnBQO9JTmAjKyWe/7x1/TzgIIxjPNj9h8QFBkvg+qDwdHH6fBOAAhL
 1LY5BOGKiyzH2KYlWanatCrFRwaXArvH1rFFsAo6KkbiTsW2WmghiTTns8Un7MYYhqL1
 wxeO/hSN4MWbsTnA2JDqHu43nxs+YRWNMO8ySCeK4uNitdvuyoHqd3608d8/wF4WYzn3
 6watEU0EXze8x6HKxae18nyzXOsUFziVZoe3Ys1ws5B/nuPBGSjmVPAtu+n2b2HhPXnR
 qKAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJx2x7MLkx7SinQLoJvxsaTTTZozWQ1ca9rWypLkXlVHOt/sD9CwV0gozpQua7vNY8LTTcB5Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9yNCbS7L0EKGEIFNbqD2QJrBnUxfh3atydJDhj6ENQahTLYMf
 BwNvIwao/NOEgm6jvPQUcI6Dp3QJCnRhPfpze9/4BthLZbkUf/48c2t4lfV+C3uacN6TOwqDugo
 uwL9vdY5q6I3m+CEpqrIDiUfFPrL+1xoldrg31Q==
X-Gm-Gg: ASbGncv1ZXcmLKGOyXhIWmR++5NV8HKVeTPw7y51y1peAJK/QOq+YqkqiINDhZoDBMY
 HduWp/WL1oZqSaJiI/MvrgbDZFyihzF2msu7NxyBgVxd8pPVwV2wcxqVQFEpJFV4PmCXhaKv85A
 ==
X-Google-Smtp-Source: AGHT+IHY5Le4xXLMzLKCsiJD35ZJPODVspDcrzr7AuQyUhQ8TBs2BcSxI4Tnt2nuDUSRaV+XLlfa+Lt5C5/VXBDjK74=
X-Received: by 2002:a05:6102:dc6:b0:4bb:5d61:1264 with SMTP id
 ada2fe7eead31-4bd3febfe58mr10372502137.24.1739967539411; Wed, 19 Feb 2025
 04:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
 <20250218085430.2422287-9-quic_varada@quicinc.com>
In-Reply-To: <20250218085430.2422287-9-quic_varada@quicinc.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 19 Feb 2025 17:48:48 +0530
X-Gm-Features: AWEUYZluYjVfIQeVTCvSKDP4Ivxu5QMFr7AwXR94sG8WtgC9Kc-poIgnlESWWx8
Message-ID: <CAFA6WYPitP9+8o9XRieiaZS7gXZo+DhaerFvpNJuzBCN0LKcpw@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] configs: add qcom_ipq9574_mmc_defconfig
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
 lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 robert.marko@sartura.hr, luka.perkov@sartura.hr, ilias.apalodimas@linaro.org, 
 sjg@chromium.org, lehmanju@devpi.de, Volodymyr_Babchuk@epam.com, 
 marek.vasut+renesas@mailbox.org, pbrobinson@gmail.com, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 18 Feb 2025 at 14:26, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> Introduce a defconfig for the Qualcomm IPQ9574 SoC based RDPs.
> Presently supports eMMC.
>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Removed unnecessary comment
> ---
>  configs/qcom_ipq9574_mmc_defconfig | 110 +++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 configs/qcom_ipq9574_mmc_defconfig
>
> diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
> new file mode 100644
> index 0000000000..13b47cb2b9
> --- /dev/null
> +++ b/configs/qcom_ipq9574_mmc_defconfig
> @@ -0,0 +1,110 @@
> +#include "qcom_defconfig"
> +
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x78b1000
> +CONFIG_DEBUG_UART_MSM=y
> +CONFIG_DEBUG_UART_CLOCK=1843200
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

Is this due to on-chip RAM memory constraints or flash memory layout
that the U-Boot binary shouldn't exceed 756KB? I suppose it's rather
better to be caught at compile time, we have something like
SPL_MAX_SIZE but I can't find any for the main U-Boot now. So it
should be fine to at least document it properly for now.

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

We should rather create a separate defconfig for this platform. It's
just redundant to include generic defconfig and then make it platform
specific.

-Sumit

> --
> 2.34.1
>
