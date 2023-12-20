Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99830C46CCD
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 10:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03DF48750C;
	Wed, 20 Dec 2023 11:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Wed4RTep";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C693876D7; Wed, 20 Dec 2023 11:53:35 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC178870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 11:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40d38f03712so1353645e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 02:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703069612; x=1703674412; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BjL8Y5GB4vvAzzD+haYNrqpHCgQQ0fbZhXFQBsAvBdY=;
 b=Wed4RTepRAGdD33CYfDjRV2Rzgdj9QtfVrxQaIgXGsjOqNaHi8czXQ19MG5RBUW4LB
 70K5IK2iq+KLgiifC19LOmAqpXhrm6Dhms89Vj92TzyOdqHm4eBf7WYxl7xaMdYZLP2N
 i35wFlfMO8leNtnOTjgdE8dXDhKVPYbAhhmD0657XoPTgGzDdAeIxqd/OWLPVs1CWUgc
 pQ4rRpk9QXlPA6lIsZCXdaSRiHvwN50Rm7Lqt6iHqx8Os2b57NuJp00iOEsteDDNp58G
 0pdTQpXeJrtHUTzphZsYp0Zq088NhZbFepB6/bXxj0C3cXFsuWiL3SdGAdUfk7iQ91nZ
 EkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703069612; x=1703674412;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BjL8Y5GB4vvAzzD+haYNrqpHCgQQ0fbZhXFQBsAvBdY=;
 b=tRWjA6a6oXIjZ9x53rjk29DNR7+lfmUKbcSAvZYLLzfb93JE/qnufVwBdPzts9fOij
 9VNx4QutcYyTt5iAsgfag/Y0gx6nRKq4D/+B2g78g443KkEYC+C8mo8OE7bsDoaMSs4t
 wDRfuPX+iq9TImdoEdqmpMz/BK6hkqv34BqiYBjqU9euFu3RHoL+zgByR26pWP+PdjN5
 GlzrPC4VufrAHB83xXHFpwulwFOwF23YOSlL1l2v8Q82HN8oiCwaPwpG81zXdhbICRdQ
 fjSfpMsaN9Eo3rQS863aldu+JExievtIm/bhv7TX4sh8X7Us8FHeVHdmFTDKwz+7Rrxm
 i8Jg==
X-Gm-Message-State: AOJu0Yxdp4RNpfOst2Ylnves5uWTZ0/HEsoZD0Sj9qlTBXeWzechmTsQ
 fS4umrTZfmDPYJfF79ee9YE+ZQ==
X-Google-Smtp-Source: AGHT+IGqoWxWBmwb/eAXy+2H4/bDRmeVA5VNPnwR6GtBhCYiIvR4rMHbhoXUKPFeG4+Tpm8YIDxf3g==
X-Received: by 2002:a05:600c:a06:b0:40d:22b9:ea89 with SMTP id
 z6-20020a05600c0a0600b0040d22b9ea89mr1464230wmp.163.1703069612307; 
 Wed, 20 Dec 2023 02:53:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:459:bfad:2ed9:2cb3?
 ([2a01:e0a:982:cbb0:459:bfad:2ed9:2cb3])
 by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c459300b0040d128e9c62sm6924436wmo.18.2023.12.20.02.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 02:53:31 -0800 (PST)
Message-ID: <a269fb79-8374-443a-a077-6477a97d6aba@linaro.org>
Date: Wed, 20 Dec 2023 11:53:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 7/8] dts: meson-gxbb: Switch to using upstream DT
Content-Language: en-US, fr
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 caleb.connolly@linaro.org, ff@shokubai.tech, daniel.thompson@linaro.org,
 dgilmore@fedoraproject.org, pbrobinson@gmail.com,
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com,
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com,
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com,
 rfried.dev@gmail.com, marex@denx.de
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-8-sumit.garg@linaro.org>
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
In-Reply-To: <20231214135103.1606605-8-sumit.garg@linaro.org>
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

On 14/12/2023 14:51, Sumit Garg wrote:
> Although there were still some variations in board DTS files based on
> meson-gxbb SoC but I think those were minor differences from upstream
> and shouldn't impact boot on these devices.
> 
> So switch to upstream DT via mirroring amlogic/ directory from
> devicetree-rebasing/src/arm64/amlogic/ directory. And thereby directly
> building DTB from there including *-u-boot.dtsi files from
> arch/$(ARCH)/dts/ directory.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>   configs/nanopi-k2_defconfig           | 3 ++-
>   configs/odroid-c2_defconfig           | 3 ++-
>   configs/p200_defconfig                | 3 ++-
>   configs/p201_defconfig                | 3 ++-
>   configs/videostrong-kii-pro_defconfig | 3 ++-
>   configs/wetek-hub_defconfig           | 3 ++-
>   configs/wetek-play2_defconfig         | 3 ++-
>   dts/arch/arm64/Makefile               | 9 +++++++++
>   dts/arch/arm64/amlogic                | 1 +
>   9 files changed, 24 insertions(+), 7 deletions(-)
>   create mode 120000 dts/arch/arm64/amlogic
> 
> diff --git a/configs/nanopi-k2_defconfig b/configs/nanopi-k2_defconfig
> index 41dbf7981f8..3db296916e9 100644
> --- a/configs/nanopi-k2_defconfig
> +++ b/configs/nanopi-k2_defconfig
> @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-nanopi-k2"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-nanopi-k2"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/odroid-c2_defconfig b/configs/odroid-c2_defconfig
> index 5f9f323e06e..65857ff478c 100644
> --- a/configs/odroid-c2_defconfig
> +++ b/configs/odroid-c2_defconfig
> @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-odroidc2"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-odroidc2"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/p200_defconfig b/configs/p200_defconfig
> index cd579ef5f14..c1792db51fd 100644
> --- a/configs/p200_defconfig
> +++ b/configs/p200_defconfig
> @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p200"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p200"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/p201_defconfig b/configs/p201_defconfig
> index b2f0a0ccdb4..202e1da5bcc 100644
> --- a/configs/p201_defconfig
> +++ b/configs/p201_defconfig
> @@ -7,7 +7,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-p201"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-p201"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/videostrong-kii-pro_defconfig b/configs/videostrong-kii-pro_defconfig
> index 3eda8f14a21..d09333d3b96 100644
> --- a/configs/videostrong-kii-pro_defconfig
> +++ b/configs/videostrong-kii-pro_defconfig
> @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-kii-pro"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-kii-pro"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/wetek-hub_defconfig b/configs/wetek-hub_defconfig
> index fd92b041e73..73f3d4aad5d 100644
> --- a/configs/wetek-hub_defconfig
> +++ b/configs/wetek-hub_defconfig
> @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-hub"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-hub"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/configs/wetek-play2_defconfig b/configs/wetek-play2_defconfig
> index b887419a6ba..26f57b4214a 100644
> --- a/configs/wetek-play2_defconfig
> +++ b/configs/wetek-play2_defconfig
> @@ -6,7 +6,8 @@ CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000
>   CONFIG_ENV_SIZE=0x2000
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="meson-gxbb-wetek-play2"
> +CONFIG_OF_UPSTREAM=y
> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxbb-wetek-play2"
>   CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_DEBUG_UART_BASE=0xc81004c0
> diff --git a/dts/arch/arm64/Makefile b/dts/arch/arm64/Makefile
> index 16e9fea622d..d548584cf5c 100644
> --- a/dts/arch/arm64/Makefile
> +++ b/dts/arch/arm64/Makefile
> @@ -1,5 +1,14 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
> +dtb-$(CONFIG_ARCH_MESON) += \
> +	amlogic/meson-gxbb-kii-pro.dtb \
> +	amlogic/meson-gxbb-nanopi-k2.dtb \
> +	amlogic/meson-gxbb-odroidc2.dtb \
> +	amlogic/meson-gxbb-p200.dtb \
> +	amlogic/meson-gxbb-p201.dtb \
> +	amlogic/meson-gxbb-wetek-hub.dtb \
> +	amlogic/meson-gxbb-wetek-play2.dtb
> +
>   include $(srctree)/scripts/Makefile.dts
>   
>   targets += $(dtb-y)
> diff --git a/dts/arch/arm64/amlogic b/dts/arch/arm64/amlogic
> new file mode 120000
> index 00000000000..73f7c3e7bd0
> --- /dev/null
> +++ b/dts/arch/arm64/amlogic
> @@ -0,0 +1 @@
> +../../../devicetree-rebasing/src/arm64/amlogic/
> \ No newline at end of file

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Note: with https://lore.kernel.org/all/8c32e92f-810f-434b-ba77-3074490458bd@linaro.org/ merged it could be be extended to GXL/GXM aswell

Thanks,
Neil
