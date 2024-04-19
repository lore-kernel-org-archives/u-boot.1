Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F95C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 18:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E531881BB;
	Fri, 19 Apr 2024 20:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VLJtXrc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD2D88763; Fri, 19 Apr 2024 20:16:15 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E25D788134
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 20:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6f103b541aeso183007b3a.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713550571; x=1714155371; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=HT6nVK3iW4RZ54gfoUmMzi0B+Pzdi+U8j7S2Z/BB3FQ=;
 b=VLJtXrc1872w1hoSl/R65/nNxes8IoM0e6KHZLFWWYRY03CyjXsgc9MtTpHx4JtlNI
 pLgP4TWNJy/TLB8Wwjs+WrsV02R78noaQDXBnEPzHDV8d8ABtiUtkQcpG17eowillX0a
 sybjcv/Mn3VQqSqGPl8NGcE2NvJPXHHgqn19Q5gl6+lEanAqwJ0SiK07pBWhtIjif6pg
 Hu+NIeDgpjnkwaf5NRoOC1d3xRD/KSNubrPXEOdn81cL+wcmgY1FcmG79rnUWs9MkmGG
 ol7TxsyeZLU/IfziI1z8VuYOW/OTdbo/gKI4jinRr+KXToYxxIXdIa/CDZxrjycNDa4v
 EoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713550571; x=1714155371;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HT6nVK3iW4RZ54gfoUmMzi0B+Pzdi+U8j7S2Z/BB3FQ=;
 b=UaKq7rneO5JMtKNdJzlVb7n5Rxm532zqvkG+aGXkDnSmMwKwUpDwqnpJPo6ORXZHXO
 zvu0yxBcnzkle/xXbmqqI3GVi+Le2dHJnvBLjDfuG8Upw8k6v97XvmmWAzpbd8hF+d3Q
 4w5ntA7b4SGm/tNXpGhNI3VCScZVpDQzw0R8bfOQd2DQ61b3JabScJv4D8B0BTna9M5C
 A2TsHPASdQlbiY+APxREVI43z+rVbtu2wJ4anxALTNrrIF5WcMLHRvAQJQ/KasPoF2jQ
 Eu93N+lggJDdfZzOxo0IV/AWYjAnG+eIZsrjkDudpdhIh8ys10+5+Y9t3XdWkJPFXtnA
 9peg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/v0stjQli3A+iR/Qxd8uAkn2BU5dEP5FoVn2iIHdb3+IVPHrYFRhuAlfKz+e2sOkJNrCw/9rHfo4jNpvg9vEApR6zFQ==
X-Gm-Message-State: AOJu0YzUBioyeKYrXUjthcqx93WNAIPq6/H6k/jD77GpXWDhin/sgca6
 f42QA/Rb6b5uliKRljaMd+okETdzPH6K35i1aUpPjpEy4VS3me6toOvV7R/s5Zk=
X-Google-Smtp-Source: AGHT+IEjCiGPAo+1bfe6FwbdUsXiscxZ2ujMuqFBlwf5I6nUlWdE60abVukAHoYhIDfeWDWkIYwWgw==
X-Received: by 2002:a05:6a20:3ca0:b0:1a9:7ad8:79f with SMTP id
 b32-20020a056a203ca000b001a97ad8079fmr3903227pzj.13.1713550571213; 
 Fri, 19 Apr 2024 11:16:11 -0700 (PDT)
Received: from [172.20.19.49] ([209.37.221.130])
 by smtp.gmail.com with ESMTPSA id
 bx33-20020a056a02052100b005f7fed76e59sm1409750pgb.78.2024.04.19.11.16.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 11:16:10 -0700 (PDT)
Message-ID: <91b199be-3ed2-4ef2-bf74-189cd2b45f5e@linaro.org>
Date: Fri, 19 Apr 2024 20:16:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/3] dts: support building all dtb files for a specific
 vendor
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20240418-b4-of-upstream-build-vendor-v4-0-d404deff386e@linaro.org>
 <20240418-b4-of-upstream-build-vendor-v4-3-d404deff386e@linaro.org>
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
In-Reply-To: <20240418-b4-of-upstream-build-vendor-v4-3-d404deff386e@linaro.org>
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

On 18/04/2024 20:39, Caleb Connolly wrote:
> This adjusts OF_UPSTREAM to behave more like the kernel by allowing for
> all the devicetree files for a given vendor to be compiled. This is
> useful for Qualcomm in particular as most boards are supported by a
> single U-Boot build just provided with a different DT.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   dts/Kconfig          | 24 ++++++++++++++++++++++++
>   scripts/Makefile.dts | 13 +++++++++++++
>   2 files changed, 37 insertions(+)
> 
> diff --git a/dts/Kconfig b/dts/Kconfig
> index b9b6367154ef..6883a000a052 100644
> --- a/dts/Kconfig
> +++ b/dts/Kconfig
> @@ -100,8 +100,32 @@ config OF_UPSTREAM
>   	  However, newer boards whose devicetree source files haven't landed in
>   	  the dts/upstream subtree, they can override this option to have the
>   	  DT build from existing U-Boot tree location instead.
>   
> +config OF_UPSTREAM_BUILD_VENDOR
> +	bool "Build all devicetree files for a particular vendor"
> +	depends on OF_UPSTREAM
> +	help
> +	  Enable building all devicetree files for a particular vendor. This
> +	  is useful for generic U-Boot configurations where many boards can
> +	  be supported with a single binary.
> +
> +	  This is only available for platforms using upstream devicetree.
> +
> +config OF_UPSTREAM_VENDOR
> +	string "Vendor to build all upstream devicetree files for"
> +	depends on OF_UPSTREAM_BUILD_VENDOR
> +	default "qcom" if ARCH_SNAPDRAGON
> +	default "rockchip" if ARCH_ROCKCHIP
> +	default "amlogic" if ARCH_MESON
> +	default "allwinner" if ARCH_SUNXI
> +	default "mediatek" if ARCH_MEDIATEK
> +	default "marvell" if ARCH_MVEBU || ARCH_KIRKWOOD
> +	default "xilinx" if ARCH_VERSAL || ARCH_ZYNQ
> +	default "nvidia" if ARCH_TEGRA
> +	help
> +	  Select the vendor to build all devicetree files for.
> +
>   choice
>   	prompt "Provider of DTB for DT control"
>   	depends on OF_CONTROL
>   
> diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
> index 5e2429c6170c..790f3c508f19 100644
> --- a/scripts/Makefile.dts
> +++ b/scripts/Makefile.dts
> @@ -1,3 +1,16 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   
>   dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
> +
> +ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
> +ifeq ($(CONFIG_ARM64),y)
> +dt_dir := $(srctree)/dts/upstream/src/arm64
> +else
> +dt_dir := $(srctree)/dts/upstream/src/$(ARCH)
> +endif
> +
> +dtb-vendor_dts := $(patsubst %.dts,%.dtb,$(wildcard $(dt_dir)/$(subst ",,$(CONFIG_OF_UPSTREAM_VENDOR))/*.dts))
> +
> +dtb-y += $(subst $(dt_dir)/,,$(dtb-vendor_dts))
> +
> +endif
> 


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on Amlogic boards builds

Reduced the whole Amlogic buildman build from 4.50 minutes to 2.30minutes!

Thanks,
Neil
