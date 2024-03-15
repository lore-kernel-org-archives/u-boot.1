Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0512AC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B84587FBF;
	Fri, 15 Mar 2024 18:26:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pZqpqmNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7B6687FBF; Fri, 15 Mar 2024 18:26:03 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 273B1870D2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-513c982a619so3204855e87.2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710523560; x=1711128360; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PS+3vkfNQAzrd5dTab+r4Cb0hj8JMCwO5MLmh8RPs0U=;
 b=pZqpqmNCoT/Q7My/W4vXHlYwDBAtm3/VbP7CkH9YEWKwx3mcU2T/55jRs+k5CnFW7E
 DR76pTY215D0ac0ad5e4wES2kQGDbWtnz2NyH0LttD/SDooDkapgZIvqguz6j92Y1AC4
 ERD00ZNiluddxxJOAINYrJyBbVRki/igvKil6Kvy/lwshk2lT2QsB/eUon98iHkETxcA
 AtLWSFUbixLSJ3siC3W3pH3x+RS5dXS4wHn6uk+cN1X4yxbjwP/paz5LGJGGRNvU9Rqk
 ebaiIemQnA/U8oUW3jwPj05WTaGGrKBcbxwmOqUmmOEHxrX2Y6x5iowsFt/e/15N5fFW
 b7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710523560; x=1711128360;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PS+3vkfNQAzrd5dTab+r4Cb0hj8JMCwO5MLmh8RPs0U=;
 b=LVWtj2ig3hNM/bSVO1VDFn9xqRPURnshxLprKZEAtCqJfOopBwzvm3PYuK17Ly0u9I
 3xHw5tQPYvwja5QE8mmD8ZxVnscb0rqs/Z9fq92270j/m2rjcs5+V4VjgyMChHuutUaR
 lfq+ERBmG4Ww0VhWSj59cKSmh04i7tyoW0dsQEoG6gB9rdErFSYql1qgKAnM22jEagd4
 YiVrjU349zlswR+1t6XSW/1kgx8l16sRBsgZRxqKigZFPUALn7x+hWDliBFcL+GM/xNg
 gby+Mmun5pk82IwhCBxv2pnwQlOyWOdyKBZIFW4BiSakMvddB+BOPUwM3pluuwtTq5U6
 V0MQ==
X-Gm-Message-State: AOJu0Yyc+uZtCbDSKSyvG9aBLAT82mjqSmOX05U4zuiYI/rHmzd0WuGz
 XDMbfv9KMkHFhi7IayVcA60JBZkMfzjGOUOtbJ/XIwV6FzJv5OYUlNlgNVk3/TU=
X-Google-Smtp-Source: AGHT+IFeiNnM4l3lQb/urZ0bxZdUI97QyJSt8Gj36u+QPDfCbnF3k3bvbkSZGbOGfAyzd2Bp1fxLkw==
X-Received: by 2002:a19:5e5c:0:b0:513:dd59:bb3d with SMTP id
 z28-20020a195e5c000000b00513dd59bb3dmr782340lfi.20.1710523560218; 
 Fri, 15 Mar 2024 10:26:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3?
 ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b0041312d21a35sm9684010wmo.7.2024.03.15.10.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:25:59 -0700 (PDT)
Message-ID: <77b1ea4c-a66e-44ce-aea7-a5bf303d2a6b@linaro.org>
Date: Fri, 15 Mar 2024 18:25:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 14/14] qcom_defconfig: enable USB
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
 <20240315-b4-qcom-livetree-v2-14-ab635774b2dc@linaro.org>
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
Organization: Linaro Developer Services
In-Reply-To: <20240315-b4-qcom-livetree-v2-14-ab635774b2dc@linaro.org>
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

On 15/03/2024 16:10, Caleb Connolly wrote:
> Enable support for the DWC3 USB controller and required dependencies for
> Qualcomm boards, specifically the DB845c:
> * IOMMU / SMMU
> * USB high-speed PHYs
> * Mass storage and ACM gadgets

I don't see configs for ACM ?

Neil

> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index eebd0d74bd51..3979c19052db 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -12,8 +12,9 @@ CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=1
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
>   CONFIG_SYS_CBSIZE=512
> +# CONFIG_SYS_DEVICE_NULLDEV is not set
>   CONFIG_LOG_MAX_LEVEL=9
>   CONFIG_LOG_DEFAULT_LEVEL=4
>   # CONFIG_DISPLAY_CPUINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> @@ -22,14 +23,17 @@ CONFIG_CMD_CLK=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_UMS_ABORT_KEYED=y
>   CONFIG_CMD_CAT=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_LOG=y
>   CONFIG_OF_LIVE=y
>   # CONFIG_NET is not set
>   # CONFIG_OFNODE_MULTI_TREE is not set
> +CONFIG_DM_WARN=y
>   CONFIG_BUTTON_QCOM_PMIC=y
>   CONFIG_CLK=y
>   CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SDM845=y
> @@ -37,17 +41,24 @@ CONFIG_MSM_GPIO=y
>   CONFIG_QCOM_PMIC_GPIO=y
>   CONFIG_DM_KEYBOARD=y
>   CONFIG_BUTTON_KEYBOARD=y
>   CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_IOMMU=y
> +CONFIG_QCOM_HYP_SMMU=y
> +CONFIG_MISC=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_MMC_SDHCI_MSM=y
>   CONFIG_PHY=y
> +CONFIG_PHY_QCOM_QUSB2=y
> +CONFIG_PHY_QCOM_USB_HS_7NM=y
>   CONFIG_PINCTRL=y
>   CONFIG_PINCTRL_QCOM_QCS404=y
>   CONFIG_PINCTRL_QCOM_SDM845=y
>   CONFIG_DM_PMIC=y
>   CONFIG_PMIC_QCOM=y
> +CONFIG_DM_REGULATOR=y
> +CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_SCSI=y
>   CONFIG_MSM_SERIAL=y
>   CONFIG_MSM_GENI_SERIAL=y
>   CONFIG_SPMI_MSM=y
> @@ -56,8 +67,9 @@ CONFIG_SYSINFO_SMBIOS=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_XHCI_DWC3=y
>   CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
>   CONFIG_UFS=y
>   CONFIG_VIDEO=y
>   # CONFIG_VIDEO_FONT_8X16 is not set
>   CONFIG_VIDEO_FONT_16X32=y
> 

