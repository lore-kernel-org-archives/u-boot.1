Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDDAC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 13:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E439987F87;
	Wed, 20 Mar 2024 14:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rcrre8P2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D908803E; Wed, 20 Mar 2024 14:16:26 +0100 (CET)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2827387F87
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 14:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d21cdbc85bso98314351fa.2
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710940583; x=1711545383; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WAn0xYCsfYUEqTdGr3bDBy0SbTUJYMiqscv/hOXGmbg=;
 b=Rcrre8P2TE+a54aySbh5gB4vDZeS2TZIYikTw4A4BVzv3w3Gc2VQX+adGttQQLz0ww
 j+NxpQPCKG0cjVzT11D/S/7Vx3BCj2cdasBacG/2eNq9cv/PXfK5GqAOwXFtNDk9Gk5q
 YwsAHDR/lLPyGVwSLQL4DKfJsMkaU+RhaYnQtM8oYSdBEOvgVDR9O16/9NTcdf4O1dj1
 DNsPP/GuchntApWO3Dv3A5hLUnlDIJv5Fp8a7JJ74SYn2sA9IDILA4koy4FMwm4ryPvv
 20dX+/pF5iuu7gWc4D2CFLyyJOegNw1u/X8eQoK1Dh1/mbfKS6PC5OVVcAPjRzopXp76
 Ao8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710940583; x=1711545383;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WAn0xYCsfYUEqTdGr3bDBy0SbTUJYMiqscv/hOXGmbg=;
 b=GVECtiWykF0vsuNM3j6Rg8WmkfziMQ6/+kO+qic/ueI47weBTIpkMbXEUgcvg2AKGl
 Gfdyx+HkBzqEeBkekGTIys5odAeGLzot0s4h/grcvvLLvEui8UHJOKbX1+m9rJUbHoHi
 izG60jm2ZWhgfZccSAkClRlSefK2SbEZxXWNu+JIDcw1Ya60sQG91+1hsHVYuzjaG7QF
 oVAXUbq49ts3QQ4IkTP6cQd4K6d1/26YRSMcRbXBAtFdgFGjulpzctQkuXGluncjL/EH
 QUaFxhc5hwFhGS6SI4ttwt45PY+vwYjsXpGabPI9SNKAHZHHuFu+4N9+a6dRVvo8UZoq
 o12g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUf2am+NZjAGkR4E5tqxbR+gV+eNP3b2NcQUMnzJKDaQvMVz4stMF6/lwrwqS5X6RhNExxFcAS0ta4NwwwaZvbMdH0fQ==
X-Gm-Message-State: AOJu0YwoVgQKOBcAI/FVxUlW4KfVlrEs9os0KIgvNcqES2YUHNWuT2+8
 +yRmROGumlIH+pHaoDhGUNj99s/phUT9rPesGfMAzzv2dCP4uZarYKqUUprWA/M=
X-Google-Smtp-Source: AGHT+IGYU9DBKCssYPBJpI4RQXC7OoPisclPmqKMWRlA/wypq30t8F2Lyr2CqU8+ZhQsyAE7AR8myw==
X-Received: by 2002:a05:651c:4ce:b0:2d2:a3bb:e319 with SMTP id
 e14-20020a05651c04ce00b002d2a3bbe319mr1872785lji.1.1710940583230; 
 Wed, 20 Mar 2024 06:16:23 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 j28-20020a05600c1c1c00b004146895086esm2256351wms.8.2024.03.20.06.16.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 06:16:22 -0700 (PDT)
Message-ID: <0403479b-8691-44b6-817f-45ce9127989c@linaro.org>
Date: Wed, 20 Mar 2024 13:16:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/14] qcom_defconfig: enable USB
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-14-e1b38d9b4fa4@linaro.org>
 <CAFA6WYP2rdeESRFtWfiD-zVRwAY7jEstw-UvWQbWMTG+MbmLvQ@mail.gmail.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYP2rdeESRFtWfiD-zVRwAY7jEstw-UvWQbWMTG+MbmLvQ@mail.gmail.com>
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



On 20/03/2024 05:40, Sumit Garg wrote:
> On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Enable support for the DWC3 USB controller and required dependencies for
>> Qualcomm boards, specifically the DB845c:
>> * IOMMU / SMMU
>> * USB high-speed PHYs
>> * Mass storage and ACM gadgets
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>  configs/qcom_defconfig | 49 ++++++++++++++++++++++++++-----------------------
>>  1 file changed, 26 insertions(+), 23 deletions(-)
>>
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index eebd0d74bd51..156c205284dd 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -12,42 +12,63 @@ CONFIG_BOOTSTD_FULL=y
>>  CONFIG_BOOTDELAY=1
>>  CONFIG_USE_PREBOOT=y
>>  CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
>>  CONFIG_SYS_CBSIZE=512
>> +# CONFIG_SYS_DEVICE_NULLDEV is not set
>>  CONFIG_LOG_MAX_LEVEL=9
>>  CONFIG_LOG_DEFAULT_LEVEL=4
>>  # CONFIG_DISPLAY_CPUINFO is not set
>>  CONFIG_DISPLAY_BOARDINFO_LATE=y
>>  CONFIG_CMD_BOOTMENU=y
>> +CONFIG_CMD_EEPROM=y
>> +CONFIG_SYS_I2C_EEPROM_BUS=2
>> +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>> +CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>> +# CONFIG_CMD_BIND is not set
>>  CONFIG_CMD_CLK=y
>>  CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_I2C=y
>>  CONFIG_CMD_MMC=y
>>  CONFIG_CMD_UFS=y
>>  CONFIG_CMD_USB=y
>>  CONFIG_CMD_CAT=y
>>  CONFIG_CMD_BMP=y
>>  CONFIG_CMD_LOG=y
>>  CONFIG_OF_LIVE=y
>>  # CONFIG_NET is not set
>> +CONFIG_DM_WARN=y
>>  # CONFIG_OFNODE_MULTI_TREE is not set
>>  CONFIG_BUTTON_QCOM_PMIC=y
>>  CONFIG_CLK=y
>>  CONFIG_CLK_QCOM_QCS404=y
>>  CONFIG_CLK_QCOM_SDM845=y
>>  CONFIG_MSM_GPIO=y
>>  CONFIG_QCOM_PMIC_GPIO=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_SYS_I2C_QUP=y
>> +CONFIG_I2C_MUX=y
>>  CONFIG_DM_KEYBOARD=y
>>  CONFIG_BUTTON_KEYBOARD=y
>> +CONFIG_IOMMU=y
>> +CONFIG_QCOM_HYP_SMMU=y
>> +CONFIG_MISC=y
>> +CONFIG_NVMEM=y
>> +CONFIG_I2C_EEPROM=y
>>  CONFIG_MMC_HS200_SUPPORT=y
>>  CONFIG_MMC_SDHCI=y
>>  CONFIG_MMC_SDHCI_ADMA=y
>>  CONFIG_MMC_SDHCI_MSM=y
>> +CONFIG_DM_ETH_PHY=y
>>  CONFIG_PHY=y
>> +CONFIG_PHY_QCOM_QUSB2=y
>> +CONFIG_PHY_QCOM_USB_HS_7NM=y
>>  CONFIG_PINCTRL=y
>>  CONFIG_PINCTRL_QCOM_QCS404=y
>>  CONFIG_PINCTRL_QCOM_SDM845=y
>>  CONFIG_DM_PMIC=y
>>  CONFIG_PMIC_QCOM=y
>> +CONFIG_DM_REGULATOR=y
>> +CONFIG_DM_REGULATOR_FIXED=y
>>  CONFIG_SCSI=y
>>  CONFIG_MSM_SERIAL=y
>>  CONFIG_MSM_GENI_SERIAL=y
>>  CONFIG_SPMI_MSM=y
>> @@ -56,8 +77,13 @@ CONFIG_SYSINFO_SMBIOS=y
>>  CONFIG_USB=y
>>  CONFIG_USB_XHCI_HCD=y
>>  CONFIG_USB_XHCI_DWC3=y
>>  CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_USB_GADGET_DOWNLOAD=y
>> +CONFIG_USB_FUNCTION_MASS_STORAGE=y
>> +CONFIG_USB_FUNCTION_ACM=y
>>  CONFIG_UFS=y
>>  CONFIG_VIDEO=y
>>  # CONFIG_VIDEO_FONT_8X16 is not set
>>  CONFIG_VIDEO_FONT_16X32=y
>> @@ -66,27 +92,4 @@ CONFIG_NO_FB_CLEAR=y
>>  CONFIG_VIDEO_SIMPLE=y
>>  CONFIG_HEXDUMP=y
>>  # CONFIG_GENERATE_SMBIOS_TABLE is not set
>>  CONFIG_LMB_MAX_REGIONS=64
>> -CONFIG_CMD_DHCP=y
>> -CONFIG_CMD_EEPROM=y
>> -CONFIG_CMD_I2C=y
>> -CONFIG_CMD_PING=y
>> -CONFIG_DM_ETH=y
>> -CONFIG_DM_ETH_PHY=y
>> -CONFIG_DM_MDIO=y
>> -CONFIG_DWC_ETH_QOS=y
>> -CONFIG_DWC_ETH_QOS_QCOM=y
> 
> Any particular reason to drop these?

No, this is weird, I must have screwed something up while regenerating
the defconfig. Thanks for catching this, I'll fix it for the next revision.
> 
> -Sumit
> 
>> -CONFIG_RGMII=y
>> -CONFIG_PHY_MICREL=y
>> -CONFIG_PHY_MICREL_KSZ90X1=y
>> -CONFIG_MISC=y
>> -CONFIG_NVMEM=y
>> -CONFIG_DM_I2C=y
>> -CONFIG_I2C_SUPPORT=y
>> -CONFIG_I2C_MUX=y
>> -CONFIG_I2C_EEPROM=y
>> -CONFIG_SYS_I2C=y
>> -CONFIG_SYS_I2C_QUP=y
>> -CONFIG_SYS_I2C_EEPROM_BUS=2
>> -CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>> -CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>>
>> --
>> 2.44.0
>>

-- 
// Caleb (they/them)
