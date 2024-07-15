Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B81C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 12:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F009887E6;
	Mon, 15 Jul 2024 14:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R9YVmBwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58CAA8881B; Mon, 15 Jul 2024 14:29:06 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E8C887E6
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 14:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ea5765e75so5104029e87.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721046543; x=1721651343; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=H4o/+tP8kRN7Mr/sYBzp9ZVzYC6IfQf66TypWKcN6UI=;
 b=R9YVmBwQMJpP+umdOouCBVDZZv3lWXjdClrBpwL5IL00ZGJaF9Gf5kyZAFjpvfUj/9
 DqVCaO9X+8J4VzTkd8nVZxAT5wwVsBSHzW8XkA/De1lS8QGeSsjgXUTzhfIu+5pjhaZY
 v2EWwyZDV9bIKqtblF+VNle3wmYVraO+ktM1IDGPFdBG/BWXfyuJu4Uf3+x/cVfpHeDd
 E6x+SNuPj7Bua1kH/nGg/FIcQIAlqU240O4xE09NkiadSRy+owgn2YPb5JZK97at+Hsj
 jjXC4foOUvVamXBwnfPPYtoZWn0ynHwMEvKsXXCZARAX7p3EyzgnJBqtOkEuZbBpfV22
 ckyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721046543; x=1721651343;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=H4o/+tP8kRN7Mr/sYBzp9ZVzYC6IfQf66TypWKcN6UI=;
 b=EebQkV+KLO/BoeM/9pddpm3r3YX7D4esDWnRp730Zke+cwk6yyMhxaF2s2fZ8TRQvg
 QHiya+5rWe7/bplcanxOOHeMQSxyuh9IcHn0nPlmsz9z8csiL4jPLZLfV6pbEFY1tRrv
 9/UNF/wpBFRvAFndYdJpQox3FF3i64tx8RWJcTyBP2obQq63+E6T2E6Wqx8goKMHEMkZ
 dYkTF6TpKMye0RGFjU0tq4GajDBN72DOCb8i8OQEJt8OKKPDvbk44sXc2Zdya/8zGEhF
 evSN8zXYFoACfS+nHaGX3K8SNBWBYec5uweHlty7apjrIuKaRINFhtey4dKVQUMFIEDb
 aURw==
X-Gm-Message-State: AOJu0YzD+gx8gfQalqku4sJO9e5zzwtrGPOlUAYo6KiPAo0vkhAVbuvK
 SnWXFXpVDQHN99I65x0uIdFbjLuevsyJyjZlS31RSJwL4ftTSHXFLlfc6Gopsh4=
X-Google-Smtp-Source: AGHT+IE2UNPuQCXsaXqIDL/JWP8LG+8dr4OwsOexGrGkLSrWWRjDfPDcobzq/yyGnWzCEF7XrafxLQ==
X-Received: by 2002:a05:6512:3b1f:b0:520:36bb:a6e1 with SMTP id
 2adb3069b0e04-52eb99a2c80mr14300852e87.29.1721046543131; 
 Mon, 15 Jul 2024 05:29:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79bb:5f59:8e51:52d4?
 ([2a01:e0a:982:cbb0:79bb:5f59:8e51:52d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2d7348sm120836455e9.42.2024.07.15.05.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 05:29:02 -0700 (PDT)
Message-ID: <f2fd1f99-acfe-42e8-aad8-66f7cb21950a@linaro.org>
Date: Mon, 15 Jul 2024 14:29:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v6 15/24] soc: qcom: add build infrastructure
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-15-0c948a25d018@linaro.org>
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
In-Reply-To: <20240715-b4-qcom-rpmh-v6-15-0c948a25d018@linaro.org>
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

On 15/07/2024 12:08, Caleb Connolly wrote:
> Add Kconfig / Makefiles to build rpmh and cmd-db drivers.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/soc/Kconfig       |  1 +
>   drivers/soc/Makefile      |  1 +
>   drivers/soc/qcom/Kconfig  | 27 +++++++++++++++++++++++++++
>   drivers/soc/qcom/Makefile |  4 ++++
>   4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index cee506fe4747..8ef408d9ba1b 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -47,8 +47,9 @@ config SOC_XILINX_VERSAL_NET
>   	  Enable this option to select SoC device id driver for Xilinx Versal NET.
>   	  This allows other drivers to verify the SoC familiy & revision using
>   	  matching SoC attributes.
>   
> +source "drivers/soc/qcom/Kconfig"
>   source "drivers/soc/samsung/Kconfig"
>   source "drivers/soc/ti/Kconfig"
>   
>   endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 5ec89a053165..00e6a5ac8e2b 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -2,8 +2,9 @@
>   #
>   # Makefile for the U-Boot SOC specific device drivers.
>   
>   obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
> +obj-$(CONFIG_SOC_QCOM) += qcom/
>   obj-$(CONFIG_SOC_SAMSUNG) += samsung/
>   obj-$(CONFIG_SOC_TI) += ti/
>   obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
>   obj-$(CONFIG_SOC_DEVICE_TI_K3) += soc_ti_k3.o
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> new file mode 100644
> index 000000000000..4aa7833930c7
> --- /dev/null
> +++ b/drivers/soc/qcom/Kconfig
> @@ -0,0 +1,27 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# QCOM Soc drivers
> +#
> +menuconfig SOC_QCOM
> +	bool "Qualcomm SOC drivers support"
> +	help
> +	  Say Y here if you want to enable Qualcomm SOC drivers support.
> +
> +if SOC_QCOM
> +
> +config QCOM_COMMAND_DB
> +	bool "Qualcomm Command DB"
> +	help
> +	  Command DB queries shared memory by key string for shared system
> +	  resources. Platform drivers that require to set state of a shared
> +	  resource on a RPM-hardened platform must use this database to get
> +	  SoC specific identifier and information for the shared resources.
> +
> +config QCOM_RPMH
> +	bool "Qualcomm RPMh support"
> +	depends on QCOM_COMMAND_DB
> +	help
> +	  Say y here to support the Qualcomm RPMh (resource peripheral manager)
> +	  if you need to control regulators on Qualcomm platforms, say y here.
> +
> +endif # SOC_QCOM
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> new file mode 100644
> index 000000000000..78fae8bbfa16
> --- /dev/null
> +++ b/drivers/soc/qcom/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
> +obj-$(CONFIG_QCOM_RPMH) += rpmh-rsc.o rpmh.o
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
