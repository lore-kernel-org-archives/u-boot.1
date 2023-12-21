Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E26C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F708789A;
	Thu, 21 Dec 2023 17:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FHOO9rKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10948789A; Thu, 21 Dec 2023 17:34:28 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F09D8784B
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:34:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40d22d3e751so12867695e9.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176465; x=1703781265; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=cRDHo23kW9ipm1akkDXooQU4AK3mQcomdrSrj2x2mMQ=;
 b=FHOO9rKCofxNIZuDZahzlPFSNESphHLD9KdqCO1vA+bm5IDUPrORbuBnOitAK5uFE2
 uic739tUmtBjj1P7PzaoX/9eGlQqD1lu0HYfl+9Sl1+rQHs/cQ90PeZ51xytEnsIfAGX
 Eaf/9n4rSVkfI7E9xo9hsjsgyXKnMEUK5fdzvRtVwZP+ZZh66SUWgqw1E1CFSJuuiMY8
 x7lz/Ki3jcxQnrtl+W0uGARfjnY1n9uDVXWaremSZGU9Zm+m6mEcRns5lpiErUvuJsi0
 qD5+ebSJJKfuxs4SgurIDAZZr0QgMtFoB1jvb6eDSQNiyyccAqvkDTtGb2L6/o69H3BH
 2c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176465; x=1703781265;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cRDHo23kW9ipm1akkDXooQU4AK3mQcomdrSrj2x2mMQ=;
 b=Gfi9ye1vqYUTh+AYKrPiRSBTxECDmpilBgaxLy+PRzA/O+YOS3UOe+eRL9bHPnn5Cz
 NItwAjGmf4zRlip/bZmhGzr3NdK4H1b9vEgHxfCWggtoH7lFmRzsRBf0MHYTbCtbmSdn
 9oq3Cj3CV0zrWefp+GyFJO9y8VLlQ7MtUH8SVwRXl8mWumGy2jBFUuQAeMQunIMWBjIH
 MJVBhmbmvg8CB1g8Q8xtq3PMUdgHq1lQbfZoroJQs55gfigub5AQRds/CDnj4lVWM4/i
 HoUwBihm8B1o9jpF1i3yssnkWV6FfxIY/tY2s9DFd9/tVgQ983qzHZbPwR6PodZVVT9i
 vUYQ==
X-Gm-Message-State: AOJu0YywewgOeB7hf5SuOzLuFcOgn62JY4A+bK+WKdbmetcYJZoxH4Yr
 flIaVn5uTmhi+LLUYKRdzPeFXw==
X-Google-Smtp-Source: AGHT+IHHnocWdIXRiojnGezHS27eYC9ZOa8Rco09R17lep7DQJfQONjEImLyiCj7lDnwgoGMIFAkkQ==
X-Received: by 2002:a05:600c:1ca6:b0:40c:415f:cc48 with SMTP id
 k38-20020a05600c1ca600b0040c415fcc48mr685136wms.40.1703176465321; 
 Thu, 21 Dec 2023 08:34:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 bd7-20020a05600c1f0700b0040c420eda48sm12216169wmb.22.2023.12.21.08.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:34:24 -0800 (PST)
Message-ID: <96d1ade6-f617-4ad2-a5fe-e5a46fb85806@linaro.org>
Date: Thu, 21 Dec 2023 17:34:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 18/32] doc: board/qualcomm: document generic targets
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
 <20231219-b4-qcom-common-target-v2-18-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-18-b6dd9704219e@linaro.org>
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
> Replace the board specific docs with a generic board.rst file which
> documents the build/boot process for the sdm845 and qcs404 boards now
> that the only differences are the DTB in use.
> 
> At the same time, create a debugging page to document some useful
> snippets and tips for working with Qualcomm platforms.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   doc/board/qualcomm/board.rst     | 119 ++++++++++++++++++++++++++++
>   doc/board/qualcomm/debugging.rst |  61 +++++++++++++++
>   doc/board/qualcomm/index.rst     |   4 +-
>   doc/board/qualcomm/qcs404.rst    |  79 -------------------
>   doc/board/qualcomm/sdm845.rst    | 162 ---------------------------------------
>   5 files changed, 182 insertions(+), 243 deletions(-)
> 
> diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
> new file mode 100644
> index 000000000000..093048eee0a6
> --- /dev/null
> +++ b/doc/board/qualcomm/board.rst
> @@ -0,0 +1,119 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
> +
> +Qualcomm generic boards
> +=======================
> +
> +About this
> +----------
> +This document describes how to build and run U-Boot for Qualcomm generic
> +boards. Right now the generic target supports the Snapdragon 845 SoC, however
> +it's expected to support more SoCs going forward.
> +
> +SDM845 - hi-end qualcomm chip, introduced in late 2017.
> +Mostly used in flagship phones and tablets of 2018.
> +
> +The current boot flow support loading u-boot as an Android boot image via
> +Qualcomm's UEFI-based ABL (Android) Bootloader. The DTB used by U-Boot will
> +be appended to the U-Boot image the same way as when booting Linux. U-Boot
> +will then retrieve the DTB during init. This way the memory layout and KASLR
> +offset will be populated by ABL.
> +
> +Installation
> +------------
> +Build
> +^^^^^
> +Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> +
> +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +	$ make <your board name here, see Boards section>_defconfig
> +	$ make

Perhaps you could also refer to buildman aswell as alternative to bare make

> +
> +This will build ``u-boot-nodtb.bin`` in the configured output directory.
> +
> +Generate FIT image
> +^^^^^^^^^^^^^^^^^^
> +See doc/uImage.FIT for more details
> +
> +Pack android boot image
> +^^^^^^^^^^^^^^^^^^^^^^^
> +We'll assemble android boot image with ``u-boot-nodtb.bin`` instead of linux kernel,
> +and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> +with appended dtb, so let's mimic linux to satisfy stock bootloader.
> +
> +Boards
> +------
> +
> +starqlte
> +^^^^^^^^
> +
> +The starqltechn is a production board for Samsung S9 (SM-G9600) phone,
> +based on the Qualcomm SDM845 SoC.
> +
> +This device is supported by the common qcom_defconfig.
> +
> +The DTB is called "sdm845-samsung-starqltechn.dtb"
> +
> +More information can be found on the `Samsung S9 page`_.
> +
> +dragonboard845c
> +^^^^^^^^^^^^^^^
> +
> +The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> +the Qualcomm SDM845 SoC.
> +
> +This device is supported by the common qcom_defconfig
> +
> +The DTB is called "sdm845-db845c.dtb"
> +
> +More information can be found on the `DragonBoard 845c page`_.
> +
> +qcs404-evb
> +^^^^^^^^^^
> +
> +The QCS404 EvB is a Qualcomm Development Platform, based on the Qualcomm QCS404 SoC.
> +
> +This device is supported by the common qcom_defconfig
> +
> +The DTB is called "qcs404-evb-4000.dtb"
> +
> +Building steps
> +--------------
> +
> +Steps:
> +
> +- Build u-boot::
> +
> +	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> +	$ make qcom_defconfig
> +	$ make
> +
> +- gzip u-boot::
> +
> +	gzip u-boot-nodtb.bin
> +
> +- Append dtb to gzipped u-boot::
> +
> +	 cat u-boot-nodtb.bin.gz arch/arm/dts/your-board.dtb > u-boot-nodtb.bin.gz-dtb
> +
> +- A ``qcom.its`` file can be found in ``board/qualcomm/generic/``
> +  directory. It expects a folder as ``qcom_imgs/`` in the main directory
> +  containing pre-built kernel, dts and ramdisk images. See ``qcom.its``
> +  for full path to images::
> +
> +	mkimage -f qcom.its qcom.itb
> +
> +- Now we've got everything to build android boot image::
> +
> +	mkbootimg --kernel u-boot-nodtb.bin.gz-dtb --ramdisk db845c.itb \
> +	--output boot.img --pagesize 4096 --base 0x80000000
> +
> +- Flash boot.img using fastboot and erase dtbo to avoid conflicts with our DTB:
> +
> +  .. code-block:: bash
> +
> +      fastboot flash boot boot.img
> +      fastboot erase dtbo
> +
> +.. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
> +.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> diff --git a/doc/board/qualcomm/debugging.rst b/doc/board/qualcomm/debugging.rst
> new file mode 100644
> index 000000000000..1c35d1909d12
> --- /dev/null
> +++ b/doc/board/qualcomm/debugging.rst
> @@ -0,0 +1,61 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. sectionauthor:: Caleb Connolly <caleb.connolly@linaro.org>
> +
> +Qualcomm debugging
> +==================
> +
> +About this
> +----------
> +
> +This page describes how to enable early UART and other debugging techniques
> +for Qualcomm boards.
> +
> +Enable debug UART
> +-----------------
> +
> +Newer boards (SDM845 and newer, those with GENI SE UART)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Open ``configs/qcom_defconfig`` and add the following snippet to the bottom:
> +
> +	CONFIG_BAUDRATE=115200
> +
> +	# Uncomment to enable UART pre-relocation
> +	CONFIG_DEBUG_UART=y
> +	CONFIG_DEBUG_UART_ANNOUNCE=y
> +	# This is the address of the debug-uart peripheral
> +	# The value here is for SDM845, other platforms will vary
> +	CONFIG_DEBUG_UART_BASE=0xa84000
> +	# Boards older than ~2018 pre-date the GENI driver and unfortunately
> +	# aren't supported here
> +	CONFIG_DEBUG_UART_MSM_GENI=y
> +	# For sdm845 this is the UART clock rate
> +	CONFIG_DEBUG_UART_CLOCK=7372800
> +	# Most newer boards have an oversampling value of 16 instead
> +	# of 32, they need the clock rate to be doubled
> +	#CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +Then build as normal (don't forget to ``make qcom_defconfig``` again).
> +
> +Older boards (db410c and db820c)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Open ``configs/dragonboard<BOARD>_defconfig``
> +
> +	CONFIG_BAUDRATE=115200
> +	CONFIG_DEBUG_UART=y
> +	CONFIG_DEBUG_UART_ANNOUNCE=y
> +	# db410c - 0x78b0000
> +	# db820c - 0x75b0000
> +	CONFIG_DEBUG_UART_BASE=0x75b0000
> +	CONFIG_DEBUG_UART_MSM=y
> +	CONFIG_DEBUG_UART_CLOCK=7372800
> +	#CONFIG_DEBUG_UART_SKIP_INIT=y
> +
> +	CONFIG_LOG=y
> +	CONFIG_HEXDUMP=y
> +	CONFIG_CMD_LOG=y
> +	CONFIG_LOG_MAX_LEVEL=9
> +	CONFIG_LOG_DEFAULT_LEVEL=9
> +	CONFIG_LOGLEVEL=9
> +
> diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
> index 0f9c4299569a..4955274a39bc 100644
> --- a/doc/board/qualcomm/index.rst
> +++ b/doc/board/qualcomm/index.rst
> @@ -7,5 +7,5 @@ Qualcomm
>      :maxdepth: 2
>   
>      dragonboard410c
> -   sdm845
> -   qcs404
> +   board
> +   debugging
> diff --git a/doc/board/qualcomm/qcs404.rst b/doc/board/qualcomm/qcs404.rst
> deleted file mode 100644
> index 0cb71d97c987..000000000000
> --- a/doc/board/qualcomm/qcs404.rst
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> -.. sectionauthor:: Sumit Garg <sumit.garg@linaro.org>
> -
> -QCS404 EVB
> -==========
> -
> -About this
> -----------
> -This document describes the information about Qualcomm QCS404 evaluation board
> -and it's usage steps.
> -
> -The current boot flow support loading u-boot as an Android boot image via
> -Qualcomm's UEFI-based ABL (Android) Bootloader.
> -
> -Installation
> -------------
> -Build
> -^^^^^
> -Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> -
> -	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -	$ make qcs404evb_defconfig
> -	$ make
> -
> -This will build ``u-boot.bin`` in the configured output directory.
> -
> -Generate FIT image
> -^^^^^^^^^^^^^^^^^^
> -A ``qcs404.its`` file can be found in ``board/qualcomm/qcs404-evb/`` directory.
> -It expects a folder as ``qcs404_imgs/`` in the main directory containing
> -pre-built kernel, dts and ramdisk images. See ``qcs404.its`` for full path to
> -images.
> -
> -- Build FIT image::
> -
> -	mkimage -f qcs404-evb.its qcs404-evb.itb
> -
> -Pack android boot image
> -^^^^^^^^^^^^^^^^^^^^^^^
> -We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
> -and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> -with appended dtb, so let's mimic linux to satisfy stock bootloader:
> -
> -- create dump dtb::
> -
> -	workdir=/tmp/prepare_payload
> -	mkdir -p "$workdir"
> -	cd "$workdir"
> -	mock_dtb="$workdir"/payload_mock.dtb
> -
> -	dtc -I dts -O dtb -o "$mock_dtb" << EOF
> -	/dts-v1/;
> -	/ {
> -		model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
> -		compatible = "qcom,qcs404-evb-4000", "qcom,qcs404-evb", "qcom,qcs404";
> -
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -
> -		memory@80000000 {
> -			device_type = "memory";
> -			/* We expect the bootloader to fill in the size */
> -			reg = <0 0x80000000 0 0>;
> -		};
> -
> -		chosen { };
> -	};
> -	EOF
> -
> -- gzip u-boot ``gzip u-boot.bin``
> -- append dtb to gzipped u-boot: ``cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb``
> -
> -Now we've got everything to build android boot image:::
> -
> -	mkbootimg --kernel u-boot.bin.gz-dtb \
> -	--ramdisk qcs404-evb.itb --pagesize 4096 \
> -	--base 0x80000000 --output boot.img
> -
> -Flash image on qcs404-evb using fastboot method.
> diff --git a/doc/board/qualcomm/sdm845.rst b/doc/board/qualcomm/sdm845.rst
> deleted file mode 100644
> index d3f218e835e0..000000000000
> --- a/doc/board/qualcomm/sdm845.rst
> +++ /dev/null
> @@ -1,162 +0,0 @@
> -.. SPDX-License-Identifier: GPL-2.0+
> -.. sectionauthor:: Dzmitry Sankouski <dsankouski@gmail.com>
> -
> -Snapdragon 845
> -================
> -
> -About this
> -----------
> -This document describes the information about Qualcomm Snapdragon 845
> -supported boards and it's usage steps.
> -
> -SDM845 - hi-end qualcomm chip, introduced in late 2017.
> -Mostly used in flagship phones and tablets of 2018.
> -
> -The current boot flow support loading u-boot as an Android boot image via
> -Qualcomm's UEFI-based ABL (Android) Bootloader.
> -
> -Installation
> -------------
> -Build
> -^^^^^
> -Setup ``CROSS_COMPILE`` for aarch64 and build U-Boot for your board::
> -
> -	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -	$ make <your board name here, see Boards section>_defconfig
> -	$ make
> -
> -This will build ``u-boot.bin`` in the configured output directory.
> -
> -Generate FIT image
> -^^^^^^^^^^^^^^^^^^
> -See doc/uImage.FIT for more details
> -
> -Pack android boot image
> -^^^^^^^^^^^^^^^^^^^^^^^
> -We'll assemble android boot image with ``u-boot.bin`` instead of linux kernel,
> -and FIT image instead of ``initramfs``. Android bootloader expect gzipped kernel
> -with appended dtb, so let's mimic linux to satisfy stock bootloader.
> -
> -Boards
> -------
> -
> -starqlte
> -^^^^^^^^
> -
> -The starqltechn is a production board for Samsung S9 (SM-G9600) phone,
> -based on the Qualcomm SDM845 SoC.
> -
> -Steps:
> -
> -- Build u-boot::
> -
> -	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -	$ make starqltechn_defconfig
> -	$ make
> -
> -- Create dump dtb::
> -
> -	workdir=/tmp/prepare_payload
> -	mkdir -p "$workdir"
> -	cd "$workdir"
> -	mock_dtb="$workdir"/payload_mock.dtb
> -
> -	dtc -I dts -O dtb -o "$mock_dtb" << EOF
> -	/dts-v1/;
> -	/ {
> -		memory {
> -			/* We expect the bootloader to fill in the size */
> -			reg = <0 0 0 0>;
> -		};
> -
> -		chosen { };
> -	};
> -	EOF
> -
> -- gzip u-boot::
> -
> -	gzip u-boot.bin
> -
> -- Append dtb to gzipped u-boot::
> -
> -	cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> -
> -- Now we've got everything to build android boot image::
> -
> -	mkbootimg --base 0x0 --kernel_offset 0x00008000 \
> -	--ramdisk_offset 0x02000000 --tags_offset 0x01e00000 \
> -	--pagesize 4096 --second_offset 0x00f00000 \
> -	--ramdisk "$fit_image" \
> -	--kernel u-boot.bin.gz-dtb \
> -	-o boot.img
> -
> -- Flash image with your phone's flashing method.
> -
> -More information can be found on the `Samsung S9 page`_.
> -
> -dragonboard845c
> -^^^^^^^^^^^^^^^
> -
> -The dragonboard845c is a Qualcomm Robotics RB3 Development Platform, based on
> -the Qualcomm SDM845 SoC.
> -
> -Steps:
> -
> -- Build u-boot::
> -
> -	$ export CROSS_COMPILE=<aarch64 toolchain prefix>
> -	$ make dragonboard845c_defconfig
> -	$ make
> -
> -- Create dummy dtb::
> -
> -	workdir=/tmp/prepare_payload
> -	mkdir -p "$workdir"
> -	mock_dtb="$workdir"/payload_mock.dtb
> -
> -	dtc -I dts -O dtb -o "$mock_dtb" << EOF
> -	/dts-v1/;
> -	/ {
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -
> -		memory@80000000 {
> -			device_type = "memory";
> -			/* We expect the bootloader to fill in the size */
> -			reg = <0 0x80000000 0 0>;
> -		};
> -
> -		chosen { };
> -	};
> -	EOF
> -
> -- gzip u-boot::
> -
> -	gzip u-boot.bin
> -
> -- Append dtb to gzipped u-boot::
> -
> -	 cat u-boot.bin.gz "$mock_dtb" > u-boot.bin.gz-dtb
> -
> -- A ``db845c.its`` file can be found in ``board/qualcomm/dragonboard845c/``
> -  directory. It expects a folder as ``db845c_imgs/`` in the main directory
> -  containing pre-built kernel, dts and ramdisk images. See ``db845c.its``
> -  for full path to images::
> -
> -	mkimage -f db845c.its db845c.itb
> -
> -- Now we've got everything to build android boot image::
> -
> -	mkbootimg --kernel u-boot.bin.gz-dtb --ramdisk db845c.itb \
> -	--output boot.img --pagesize 4096 --base 0x80000000
> -
> -- Flash boot.img using db845c fastboot method:
> -
> -  .. code-block:: bash
> -
> -      sudo fastboot flash boot boot.img
> -
> -More information can be found on the `DragonBoard 845c page`_.
> -
> -.. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
> -.. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> 

Overall looks good, the debug hints are nice!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
