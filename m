Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0298CD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B6888077;
	Mon,  1 Apr 2024 06:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J2eIv9I+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622C0882E7; Mon,  1 Apr 2024 06:50:57 +0200 (CEST)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DEBD88074
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:50:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-47832f13a82so1225171137.1
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711947054; x=1712551854; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XvonHNrGV8WNvKS5RpYOlXHk6xwvVgyePC+A1Id5Ri0=;
 b=J2eIv9I+8BDW164xtmJdhTBdVb5I8KG2/ktzoMkLFQg87JKPpgPmzL6syDBk1ERIIi
 md5QvazGLUKxBqopCfAlo9PQzKNqpqy7Zy3PNjCZSSpKdLA+H+78VVwLX5rgvjZEcI2l
 IA8A9PD0ZFm4JMr4BsBf4j10tHxc56n+plV5wdg0IZdTnR9R6MOkYZzAWBg+UcH3EWpd
 m7xtgEhDmT6csMd6m2MlKII9TvdA6CHfpXtKs27SUf6hYBNRK513/F+1CmuR7l7Zyhv/
 hFB0OaaD79MkOhMz1bVUtXKlG3TRthSK2qFQJbWBZbvlr4EKt2VRU8fdRkVQg7arJgWg
 X92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711947054; x=1712551854;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XvonHNrGV8WNvKS5RpYOlXHk6xwvVgyePC+A1Id5Ri0=;
 b=LywCOj8I4+ToeGktpa/HBuQfOhdEEd+ARAmDwMbBVu+KmVgqYd/X8gProqj/RFSKh7
 GXNxpJ388lOiFBqvqtQ78RXYPbgmufw6FfkpTKuT4Oaqgfr4WV6SGiXpd2xnZd2U6xxN
 ynlAvUHhr3QIeNmG3sxNvzaj87DDUgTIbgYh7FuGkuqqZQIdiCgDzj6b0sapBezU+Sbm
 6I3cx5qqFdMI04Eb3pfIPwe1kJonA8k1IRBnoP4B/mD/lqjGQPkdIfXG8f4KlSUY9T/L
 cOCH3GTR3hKfc7wizXskrVjY7KRgpp5ko0ixeHq5qD22+4cmb6k1UAQvLT/JtmMruCqn
 xjnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIF3GAoG32rFOtucc3Ff46p4PBh6WBPwIdcy+EAEjJc/4JCZRYaijLwRxzPAJVqBoP14IHXE+jl37kVh6j9xkq8kIaZg==
X-Gm-Message-State: AOJu0Yz/PrG/IGBmmuEYaELKIcxK2Bdz77tZy1C+dVQRzO+lkYcqp1PO
 fXiSTglrva70950ERc8etVKrrVLpV+61/P5gMvasuZuq4BQO5m4NkvxLEZLcqKuuRjFahHUOfZs
 HLQ04aB8qDWQcLHjnvjRf/d/kBg7wYI1SrMNvtQ==
X-Google-Smtp-Source: AGHT+IGCQhfmjlUeivxOJbWASSi9wlj2LVKgbzhzWjPZK4o7+snljyDoAMC7RNIbVUFoi79Ge3P4oXX7QKAxBMn13yg=
X-Received: by 2002:a67:f8c9:0:b0:476:d833:ef6d with SMTP id
 c9-20020a67f8c9000000b00476d833ef6dmr5915890vsp.19.1711947054222; Sun, 31 Mar
 2024 21:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-15-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-15-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:20:43 +0530
Message-ID: <CAFA6WYPqHHzKbuqrVHvrNVgsXqRjZfULoTf3yQZyLChfZcxc3g@mail.gmail.com>
Subject: Re: [PATCH v5 15/16] qcom_defconfig: enable USB
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Enable support for the DWC3 USB controller and required dependencies for
> Qualcomm boards, specifically the DB845c:
> * IOMMU / SMMU
> * USB high-speed PHYs
> * Mass storage and ACM gadgets
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 52 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 23 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 8c4402e8f780..1abb57345ff1 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -17,10 +17,16 @@ CONFIG_LOG_MAX_LEVEL=9
>  CONFIG_LOG_DEFAULT_LEVEL=4
>  # CONFIG_DISPLAY_CPUINFO is not set
>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_CMD_BOOTMENU=y
> +CONFIG_CMD_EEPROM=y
> +CONFIG_SYS_I2C_EEPROM_BUS=2
> +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> +CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
> +# CONFIG_CMD_BIND is not set
>  CONFIG_CMD_CLK=y
>  CONFIG_CMD_GPIO=y
> +CONFIG_CMD_I2C=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_UFS=y
>  CONFIG_CMD_USB=y
>  CONFIG_CMD_CAT=y
> @@ -32,20 +38,39 @@ CONFIG_CLK=y
>  CONFIG_CLK_QCOM_QCS404=y
>  CONFIG_CLK_QCOM_SDM845=y
>  CONFIG_MSM_GPIO=y
>  CONFIG_QCOM_PMIC_GPIO=y
> +CONFIG_DM_I2C=y
> +CONFIG_SYS_I2C_QUP=y
> +CONFIG_I2C_MUX=y
>  CONFIG_DM_KEYBOARD=y
>  CONFIG_BUTTON_KEYBOARD=y
> +CONFIG_IOMMU=y
> +CONFIG_QCOM_HYP_SMMU=y
> +CONFIG_MISC=y
> +CONFIG_NVMEM=y
> +CONFIG_I2C_EEPROM=y
>  CONFIG_MMC_HS200_SUPPORT=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_ADMA=y
>  CONFIG_MMC_SDHCI_MSM=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_RGMII=y
>  CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
>  CONFIG_PINCTRL=y
>  CONFIG_PINCTRL_QCOM_QCS404=y
>  CONFIG_PINCTRL_QCOM_SDM845=y
>  CONFIG_DM_PMIC=y
>  CONFIG_PMIC_QCOM=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
>  CONFIG_SCSI=y
>  CONFIG_MSM_SERIAL=y
>  CONFIG_MSM_GENI_SERIAL=y
>  CONFIG_SPMI_MSM=y
> @@ -54,8 +79,12 @@ CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_MASS_STORAGE=y
>  CONFIG_UFS=y
>  CONFIG_VIDEO=y
>  # CONFIG_VIDEO_FONT_8X16 is not set
>  CONFIG_VIDEO_FONT_16X32=y
> @@ -64,27 +93,4 @@ CONFIG_NO_FB_CLEAR=y
>  CONFIG_VIDEO_SIMPLE=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_GENERATE_SMBIOS_TABLE is not set
>  CONFIG_LMB_MAX_REGIONS=64
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_EEPROM=y
> -CONFIG_CMD_I2C=y
> -CONFIG_CMD_PING=y
> -CONFIG_DM_ETH=y
> -CONFIG_DM_ETH_PHY=y
> -CONFIG_DM_MDIO=y
> -CONFIG_DWC_ETH_QOS=y
> -CONFIG_DWC_ETH_QOS_QCOM=y
> -CONFIG_RGMII=y
> -CONFIG_PHY_MICREL=y
> -CONFIG_PHY_MICREL_KSZ90X1=y
> -CONFIG_MISC=y
> -CONFIG_NVMEM=y
> -CONFIG_DM_I2C=y
> -CONFIG_I2C_SUPPORT=y
> -CONFIG_I2C_MUX=y
> -CONFIG_I2C_EEPROM=y
> -CONFIG_SYS_I2C=y
> -CONFIG_SYS_I2C_QUP=y
> -CONFIG_SYS_I2C_EEPROM_BUS=2
> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> -CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>
> --
> 2.44.0
>
