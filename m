Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784B1C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0932B878DA;
	Thu, 21 Dec 2023 17:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KrtoU9ZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBE48786E; Thu, 21 Dec 2023 17:40:21 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 711F4878E6
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:40:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-336788cb261so771484f8f.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176817; x=1703781617; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=YPCoPyvPe0APpfuZ6v2vWlzUKFKBumj+was/+up0zno=;
 b=KrtoU9ZVU02pQoT4xJKBMFZDCHvQV7sX8x3eMgOOQ6CJNrogf4N0mpEnMGeoGfMiYu
 u/GK6vA5z8v0v1QVbi1ZOh1F5AiOzsc5hmyftuaBSnT5ps7gwgldecZfSzsp5kixbs77
 guqPWS6HAYcOn+CbWyKBT/C5lhbyUP819HGKg5vBdyp9UFIEtL7aJPvSYRmFEhpBhJp+
 9Mg7Wln4S1OlEUfoM5oq60aeJ1QKHO2Y21MR9j+ETi0IJnTEwtGgCjU1wtH7krWLa3rc
 2wLw3b7+ecAhGvKk6Ja/keQnSprIaFYbOuuiKJEs08nOLAyK97m+uPnfLVD3vbQNUB16
 PCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176817; x=1703781617;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YPCoPyvPe0APpfuZ6v2vWlzUKFKBumj+was/+up0zno=;
 b=wetulc37+8x8c26YsEJevh2R23poaqb2wIxOgltqzUBaDvTkSHUq+tjMhUZMtQTGd5
 he59V415Q3e5y2HPgmejKe9wgmkdl4L6+rSkXQ2NthBLUq7t/FY6Vve91HUsUvz/cJDk
 qLic3mnigPKpLA8LdYeWTSm1lnGPG1d0JdcqtEnAgjXTpLqvNKlSsnSE6AMi2y7azu1a
 Md7hhB2JWSryxIsIbX0qLjylx4AW/Y/L46IVu42lwL6hefT/6LvkdZzmC+gS8YF4yS5h
 VP7aiUqTEhaIdSi+e4Cwq+S/fjXIrquzvqRy5gm0wgShWJCp9mshsLusOY3+WjzY9nw7
 eOTA==
X-Gm-Message-State: AOJu0YwGI8DHKzqBo3zQ/wEOdFOrT2YxGbkCkRciwlX4wlaVQ6wjZvkY
 EfBafiad4dF/IhsugRqijO5QOO9lG1EhwA==
X-Google-Smtp-Source: AGHT+IGdMuEDMk5Ec1CG07UpFBuanOhrej0P+RB60KEY845isGNeCe4AAdDux42c+Uh8sZn4rFn//w==
X-Received: by 2002:adf:fc47:0:b0:333:4255:7aec with SMTP id
 e7-20020adffc47000000b0033342557aecmr26379wrs.43.1703176816889; 
 Thu, 21 Dec 2023 08:40:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 d17-20020adfe2d1000000b0033673ddd81csm2372633wrj.112.2023.12.21.08.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:40:16 -0800 (PST)
Message-ID: <f635dd25-c624-47ae-b5b2-1786a58eeda2@linaro.org>
Date: Thu, 21 Dec 2023 17:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 31/32] board: qcs404-evb: drop board code
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-31-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-31-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> This board is entirely supported by the generic arch code and DTS. The
> board code used to handle turning on the vbus regulator, however this is
> now handled via DT.
> 
> With this, the board specific defconfig is also no longer needed, so
> drop it as well.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   board/qualcomm/qcs404-evb/Makefile     |  6 ----
>   board/qualcomm/qcs404-evb/qcs404-evb.c | 49 -----------------------------
>   configs/qcs404evb_defconfig            | 56 ----------------------------------
>   3 files changed, 111 deletions(-)
> 
> diff --git a/board/qualcomm/qcs404-evb/Makefile b/board/qualcomm/qcs404-evb/Makefile
> deleted file mode 100644
> index 4665827e0859..000000000000
> --- a/board/qualcomm/qcs404-evb/Makefile
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0+
> -#
> -# (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> -#
> -
> -obj-y += qcs404-evb.o
> diff --git a/board/qualcomm/qcs404-evb/qcs404-evb.c b/board/qualcomm/qcs404-evb/qcs404-evb.c
> deleted file mode 100644
> index 1a4b1f97a3ae..000000000000
> --- a/board/qualcomm/qcs404-evb/qcs404-evb.c
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0+
> -/*
> - * Board init file for QCS404-EVB
> - *
> - * (C) Copyright 2022 Sumit Garg <sumit.garg@linaro.org>
> - */
> -
> -#include <common.h>
> -#include <cpu_func.h>
> -#include <dm.h>
> -#include <env.h>
> -#include <init.h>
> -#include <asm/cache.h>
> -#include <asm/gpio.h>
> -#include <asm/global_data.h>
> -#include <fdt_support.h>
> -
> -DECLARE_GLOBAL_DATA_PTR;
> -
> -void qcom_board_init(void)
> -{
> -	struct udevice *pmic_gpio;
> -	struct gpio_desc usb_vbus_boost_pin;
> -	int ret, node;
> -
> -	ret = uclass_get_device_by_name(UCLASS_GPIO,
> -					"pms405_gpios@c000",
> -					&pmic_gpio);
> -	if (ret < 0) {
> -		printf("Failed to find pms405_gpios@c000 node.\n");
> -		return;
> -	}
> -
> -	node = fdt_subnode_offset(gd->fdt_blob, dev_of_offset(pmic_gpio),
> -				  "usb_vbus_boost_pin");
> -	if (node < 0) {
> -		printf("Failed to find usb_hub_reset_pm dt node.\n");
> -		return;
> -	}
> -	ret = gpio_request_by_name_nodev(offset_to_ofnode(node), "gpios", 0,
> -					 &usb_vbus_boost_pin, 0);
> -	if (ret < 0) {
> -		printf("Failed to request usb_hub_reset_pm gpio.\n");
> -		return;
> -	}
> -
> -	dm_gpio_set_dir_flags(&usb_vbus_boost_pin,
> -			      GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
> -}
> diff --git a/configs/qcs404evb_defconfig b/configs/qcs404evb_defconfig
> deleted file mode 100644
> index 7daaa449ffbd..000000000000
> --- a/configs/qcs404evb_defconfig
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -CONFIG_ARM=y
> -CONFIG_SYS_BOARD="qcs404-evb"
> -CONFIG_SKIP_LOWLEVEL_INIT=y
> -CONFIG_COUNTER_FREQUENCY=19000000
> -CONFIG_POSITION_INDEPENDENT=y
> -CONFIG_ARCH_SNAPDRAGON=y
> -CONFIG_DEFAULT_DEVICE_TREE="qcs404-evb"
> -CONFIG_IDENT_STRING="\nQualcomm QCS404-EVB"
> -CONFIG_SYS_LOAD_ADDR=0x80000000
> -CONFIG_FIT=y
> -CONFIG_FIT_VERBOSE=y
> -CONFIG_BOOTDELAY=5
> -CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="earlycon ignore_loglevel root= clk_ignore_unused"
> -CONFIG_SAVE_PREV_BL_FDT_ADDR=y
> -CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
> -# CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_HUSH_PARSER=y
> -CONFIG_SYS_MAXARGS=64
> -CONFIG_SYS_CBSIZE=512
> -CONFIG_CMD_GPIO=y
> -CONFIG_CMD_GPT=y
> -CONFIG_CMD_MMC=y
> -CONFIG_CMD_PART=y
> -CONFIG_CMD_USB=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_EXT4_WRITE=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -# CONFIG_NET is not set
> -CONFIG_CLK=y
> -CONFIG_CLK_QCOM_QCS404=y
> -CONFIG_MSM_GPIO=y
> -CONFIG_QCOM_PMIC_GPIO=y
> -CONFIG_MISC=y
> -CONFIG_MMC_HS400_SUPPORT=y
> -CONFIG_MMC_SDHCI=y
> -CONFIG_MMC_SDHCI_ADMA=y
> -CONFIG_MMC_SDHCI_MSM=y
> -CONFIG_PHY=y
> -CONFIG_PHY_QCOM_USB_HS_28NM=y
> -CONFIG_PHY_QCOM_USB_SS=y
> -CONFIG_PINCTRL=y
> -CONFIG_PINCTRL_QCOM_QCS404=y
> -CONFIG_DM_PMIC=y
> -CONFIG_PMIC_QCOM=y
> -CONFIG_MSM_SERIAL=y
> -CONFIG_SPMI_MSM=y
> -CONFIG_USB=y
> -CONFIG_USB_XHCI_HCD=y
> -CONFIG_USB_XHCI_DWC3=y
> -CONFIG_USB_DWC3=y
> -CONFIG_USB_DWC3_GENERIC=y
> -CONFIG_USB_STORAGE=y
> -CONFIG_LMB_MAX_REGIONS=64
> 

Yeah ! code removal !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
