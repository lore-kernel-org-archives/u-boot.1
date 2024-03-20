Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC77C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD11E880C0;
	Wed, 20 Mar 2024 06:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FfWyEb0L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63CD3880C5; Wed, 20 Mar 2024 06:41:05 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA7A1880BE
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:41:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47651248841so2202370137.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710913262; x=1711518062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GFxK6yO4HPJ/bAhrJa0kCZLTehEpd9WEKEFvWXjD8FA=;
 b=FfWyEb0LS7/UuMWI5uCYX6XPjD+sqs6p4vHImpJA8elg1UWdOlNLXRNutkA+pw7XfO
 BO3vethhOnVPHBRfXbBCT07tin6E/PGWFXc0NiSWLhkIkLBvNoTYHDa+6gEueAPIWPhU
 4YVx4DoZbUntcrtCNFuIpffdekbVbNePZiPSGH03tZMqb9nHly0Ydb+cDMTDnXqE4pvd
 jtYv9D+rZdVGEmO6M0bYNAlHg4dBdf2l6aqgK33TXINjgXVvDmXB3kE6SBtPQhVYjZEM
 jBvL3OPdGIGgsnH1DjmoEEXx441vMwSF+nzuGKxvvcAoOV/ILHOj8NodlwuIMd+WuWO/
 cW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710913262; x=1711518062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GFxK6yO4HPJ/bAhrJa0kCZLTehEpd9WEKEFvWXjD8FA=;
 b=X7F47LkloyWzinodlVFY3K1BlKEBKLYBSQhOpXnWbiMnnQrEIZVnPxs6v+PqsDljhZ
 HeixTN69RD40MHbdz4yYQimr7BGK7pXi3vd1DPbQ0cnNozgNpFcsD4XeL0wWsjrdFQTx
 39zFkv4+OKY0DuaDJHSUr7RFMd1gJl3yHLO035cVD1786bHO05fb2rOSgx/sbp4LPi6x
 w7Y3KudxPIpjG36ARBpldowKy92y6IO7K41rbQ8Ag3hSEiU60L0EsX2p1ZfCbNUbtXes
 F6nKIGPpDObbEjWicH0YsKWLBTFbDpBZK4W/RPjErVEc/LxglDeTYRdEPbrHu4jRXSTO
 IVyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgNumIeJJ3RqBCMdR5d8Rq5fnuluROrqYb4h8CB5OaHIQslX7ViCB3cuPSKqOgkG1TB6owhSYSkucWkwWIvn3w80K4fA==
X-Gm-Message-State: AOJu0Yxwu/c6Qij8M3Mv5YA+5uKonU1PD4FmAwSr/rtbjHKAgaKGflHN
 C8G8+DKURY+faePAyDvMa7/rosY2R2hTX7K2N6M/TwKviNiw0h7rPmsXU19wYwxJWG/aH3X3nPf
 9/wjEMYtSrcnXzini81+iWPJ3uZSaiA0KBU49xw==
X-Google-Smtp-Source: AGHT+IEQZgkif3bx1I+mrru8q2g/odmqq51BiJc3USnif/CNBCHuloj24xotLG1C1nZw4NMDtm1LaL8k1/Y+IUAmd+s=
X-Received: by 2002:a67:eb48:0:b0:472:a248:743 with SMTP id
 x8-20020a67eb48000000b00472a2480743mr11701588vso.33.1710913261696; Tue, 19
 Mar 2024 22:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-14-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-14-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 11:10:50 +0530
Message-ID: <CAFA6WYP2rdeESRFtWfiD-zVRwAY7jEstw-UvWQbWMTG+MbmLvQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/14] qcom_defconfig: enable USB
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Enable support for the DWC3 USB controller and required dependencies for
> Qualcomm boards, specifically the DB845c:
> * IOMMU / SMMU
> * USB high-speed PHYs
> * Mass storage and ACM gadgets
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 49 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 23 deletions(-)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index eebd0d74bd51..156c205284dd 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -12,42 +12,63 @@ CONFIG_BOOTSTD_FULL=y
>  CONFIG_BOOTDELAY=1
>  CONFIG_USE_PREBOOT=y
>  CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
>  CONFIG_SYS_CBSIZE=512
> +# CONFIG_SYS_DEVICE_NULLDEV is not set
>  CONFIG_LOG_MAX_LEVEL=9
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
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
>  # CONFIG_NET is not set
> +CONFIG_DM_WARN=y
>  # CONFIG_OFNODE_MULTI_TREE is not set
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
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
> +CONFIG_DM_ETH_PHY=y
>  CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_PHY_QCOM_USB_HS_7NM=y
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
> @@ -56,8 +77,13 @@ CONFIG_SYSINFO_SMBIOS=y
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_DWC3=y
>  CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_MASS_STORAGE=y
> +CONFIG_USB_FUNCTION_ACM=y
>  CONFIG_UFS=y
>  CONFIG_VIDEO=y
>  # CONFIG_VIDEO_FONT_8X16 is not set
>  CONFIG_VIDEO_FONT_16X32=y
> @@ -66,27 +92,4 @@ CONFIG_NO_FB_CLEAR=y
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

Any particular reason to drop these?

-Sumit

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
