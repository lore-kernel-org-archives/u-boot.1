Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC3ACF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 06:53:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB73688F6B;
	Mon, 14 Oct 2024 08:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g4KhJt4T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32ED688F57; Mon, 14 Oct 2024 08:53:33 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43DF288F6B
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43115887867so25867655e9.0
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 23:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728888809; x=1729493609; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OJiAOCR8nMScMEHJI3XnJD1+DdBzHX7Fp8hNY+CJ6PU=;
 b=g4KhJt4TTVCb5uuX4otCqjPXq2BbkFuK2DQS2x1yt90EygCfpSLhnFdC68jAGxBljI
 qeBVqh0cyn/H5dh+Y+lug2f/MqX1J292+DkiWVzWuCRPyveByKwFKGvoBpOT0Lxp6ANO
 3iLhl5zott07rmAB7omtRyE3YhOBFga7nISfPkiLDl9F7sxK++oi6wgXLWGPMxjSjvq+
 7zMzniYEOD7rQXA+oauaYbJITT0pE+fnmbZZbIpl9mK0pZYhcLwGOUnOLTUdpoxzGAzU
 8UQrgzLj8zAFjXgTy1TEIAGf4O4xI7dQ5a2NsLxfONPdsg4g3t7tOfP2dgrp172t2RFB
 ly/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728888809; x=1729493609;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OJiAOCR8nMScMEHJI3XnJD1+DdBzHX7Fp8hNY+CJ6PU=;
 b=J2m/wn97ymhf+yeQZd+WqldD/olQmWCC+YI61xG1Q6OxuNG2h1NbuGKUQonah3lsnj
 z0veGQbBrSEWREakxNIr34aIa9Wu/+5kLLGJNSkYakKsg1uTzZd5oI6m0V6wE0U09pck
 O4Mak9napG9lzwl6LjQzkRTZrn/rhUrm3bHy3Xxnrd6TIWqibeDqyVscon1lWLcCloUk
 DiQGgeOxylLnqot1LhTo2GcCRz3fpCQgMylEoVEC2aJkP2consL5wO9FnPFwZtjq0mGS
 yuWKc8V7jqz+o5sEIh5xeLRVrmmi6tt76LECxyovihMWE75aM4eX+fJvSZqfQf3PScyb
 KptQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4/38/ExoONINJOZoSa1r0XBezOBmmpvWBL4g7tt6N4sz5a4lwY9AjM3nPuqy4r+CEau0/1YM=@lists.denx.de
X-Gm-Message-State: AOJu0YzbFTqt1Mu/eBh8cf6YyZkf4GsKm+viCNbROL+mQjTUdQZ3Vrvl
 /fkyz/P3OnNVbXvIdqEAxaM7bNk32x4o/KNr+UT8ApMBZw0gMqZoj9bLHWm1vPs=
X-Google-Smtp-Source: AGHT+IEEV8IgaIrHBd2HZ/btImjo2UoDYmRmSc8S2GKJPHt4L3mpKI9exWOCwBemJaInX9pY7fo/zg==
X-Received: by 2002:a05:600c:1e18:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-4311d710e52mr82281945e9.0.1728888809134; 
 Sun, 13 Oct 2024 23:53:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6bf3:bb7:467:a56f?
 ([2a01:e0a:982:cbb0:6bf3:bb7:467:a56f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d61b83cc4sm6001808f8f.89.2024.10.13.23.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 23:53:28 -0700 (PDT)
Message-ID: <de283020-8286-4910-8b15-d0e86d60ed17@linaro.org>
Date: Mon, 14 Oct 2024 08:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/4] qcom_defconfig: enable capsule update support
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
 <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 12/10/2024 15:57, Caleb Connolly wrote:
> Enable all the necessary options for capsule updates to work, as well as
> a few additional EFI features.
> 
> Capsule updates themselves are only enabled for the RB3 Gen 2, since the
> exact details on where to flash U-Boot (or how to handle multiple boot
> methods) has not been finalised for other boards.

-----------------------/\ finalized

> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcm6490_defconfig | 6 ++++++
>   configs/qcom_defconfig    | 8 +++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 5ddc5ab3ef8c..ba26924da161 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -18,4 +18,10 @@ CONFIG_DEBUG_UART_CLOCK=14745600
>   CONFIG_TEXT_BASE=0x9fc00000
>   CONFIG_REMAKE_ELF=y
>   
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +# Enable capsule updates
> +CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
> +CONFIG_EFI_CAPSULE_ON_DISK=y
> +CONFIG_EFI_IGNORE_OSINDICATIONS=y
> +CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index e7ed03ff0f24..4c8ff0e84372 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -20,21 +20,24 @@ CONFIG_LOG_MAX_LEVEL=9
>   CONFIG_LOG_DEFAULT_LEVEL=4
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_CMD_BOOTMENU=y
> +CONFIG_CMD_NVEDIT_EFI=y
>   CONFIG_CMD_EEPROM=y
>   CONFIG_SYS_I2C_EEPROM_BUS=2
>   CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>   CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>   # CONFIG_CMD_BIND is not set
>   CONFIG_CMD_CLK=y
> +CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_CAT=y
>   CONFIG_CMD_BMP=y
> +CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_LOG=y
>   CONFIG_OF_LIVE=y
>   CONFIG_USE_DEFAULT_ENV_FILE=y
> @@ -44,15 +47,18 @@ CONFIG_CLK=y
>   CONFIG_CLK_QCOM_APQ8016=y
>   CONFIG_CLK_QCOM_APQ8096=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
> -CONFIG_CLK_QCOM_SC7280=y
>   CONFIG_CLK_QCOM_SDM845=y
>   CONFIG_CLK_QCOM_SM6115=y
>   CONFIG_CLK_QCOM_SM8150=y
>   CONFIG_CLK_QCOM_SM8250=y
>   CONFIG_CLK_QCOM_SM8550=y
>   CONFIG_CLK_QCOM_SM8650=y
> +CONFIG_CLK_QCOM_SC7280=y
> +CONFIG_DFU_MMC=y
> +CONFIG_DFU_SCSI=y
> +CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
>   CONFIG_MSM_GPIO=y
>   CONFIG_QCOM_PMIC_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_QUP=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
