Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D38E7542D
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 07:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E28D48721A;
	Tue,  3 Oct 2023 09:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="u9Zohzoo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0810D87217; Tue,  3 Oct 2023 09:24:30 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2685286DD3
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 09:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32487efc319so633566f8f.1
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696317866; x=1696922666; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yqOarbBAHVYROdznDeCSbHW2kcf1Z7RIdFBA5ve+RkE=;
 b=u9ZohzooWqQuBmyB3U3K9SCqPNhKMhUOWUsNhLNrJK3qtimw7UTa84umFk0EsAqVG3
 9Q7iPXkmd14zJ+K8FIcS1f8QcSQr/e7v4/WA4To23/CYvqpkaGESknOYUk9lyYY6q9u2
 MNmQuEXjY5jB56EhKKSNwCzkTnrvk103VWhOcZ4Cfo4Rvu5zI300yr3WYqtUxFIlcQPn
 Z9HlnT6W2O2Sf0841CtCjjfDuA0Qx4U+aUIQrwNXvSiNjvDA00e3liMV2tREzO/v1GIN
 Odg4lK8NcPstVHm9i+7KHzUE64d/hZjSciKFX06HSEjpO0vbAJgZLpThzh+2wWoM9Nkf
 JG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696317866; x=1696922666;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yqOarbBAHVYROdznDeCSbHW2kcf1Z7RIdFBA5ve+RkE=;
 b=VEtfG72A5NLK88rRc5OaUQXd3VK9aCqkyXI4YYjacGbx1ETuLRG78oVqJhn/jEW4M4
 i/XuYBhvB43Gl3S4cCUt3xCuh4U89AU/DSSvk+yi8cChsazc2dxUkguxrpV1MvFO69Yd
 9yEoWPZVVt4MoHU9vFE9ueS+B1izoifuwZV6MJ2hwl1c+Ua8b3H6bKk063VZsQVO3PsI
 zQ416VHwVXwrFpQkrfD0NeSkMdf0ru2AGbGVzqlAu1rscC6xZSx7VOKtKTjNwj08l7u2
 Zd4R3ZsmRBEJwYd1usCW069LtCyZSvgLpUUi9e0P/QzL17IhVZyq6GPao4OtMl8lPlJO
 LKhw==
X-Gm-Message-State: AOJu0YzhTkkvPctmcW0hRLL8mUmFIzCxoTpe3/dJLicKRPls0mSKbmcJ
 P0kwF4Q4iGfHnO3owmfLhYtdtw==
X-Google-Smtp-Source: AGHT+IGyRd5AHHjyIvGk6khFMw4K/ZEg2ge2m4o4MVpWxCFct5rIWsiKNQRMHrMp0cbHvd9H73GQ5g==
X-Received: by 2002:a5d:654a:0:b0:316:efb9:ffa with SMTP id
 z10-20020a5d654a000000b00316efb90ffamr12103069wrv.35.1696317866618; 
 Tue, 03 Oct 2023 00:24:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e31a:fe1c:e925:9858?
 ([2a01:e0a:982:cbb0:e31a:fe1c:e925:9858])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d444f000000b0031c5e9c2ed7sm865579wrr.92.2023.10.03.00.24.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 00:24:26 -0700 (PDT)
Message-ID: <da5f0733-7a53-4878-9b68-01b3c3e040a6@linaro.org>
Date: Tue, 3 Oct 2023 09:24:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 8/8] arch: a1: introduce USB initialization
 functionality
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, lukma@denx.de, seanga2@gmail.com, marex@denx.de
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20231002165857.19512-1-avromanov@salutedevices.com>
 <20231002165857.19512-9-avromanov@salutedevices.com>
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
In-Reply-To: <20231002165857.19512-9-avromanov@salutedevices.com>
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

Hi,

On 02/10/2023 18:58, Alexey Romanov wrote:
> This is entrypoint for USB stack initialization. Function
> board_usb_init will be called from cmd/fastboot.c code.

This should not be needed anymore, using DM_USB_GADGET should work,
look how it was changed for G12A/SM1 and GXL/AXG:
https://lore.kernel.org/all/20221024-meson-dm-usb-v1-0-2ab077a503b9@baylibre.com
and
https://lore.kernel.org/all/20230117-u-boot-usb-gxl-otg-dm-v1-0-2853f6d75b06@linaro.org

Neil

> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   arch/arm/mach-meson/board-a1.c | 89 ++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)
> 
> diff --git a/arch/arm/mach-meson/board-a1.c b/arch/arm/mach-meson/board-a1.c
> index 967bb67182..781d5cfb33 100644
> --- a/arch/arm/mach-meson/board-a1.c
> +++ b/arch/arm/mach-meson/board-a1.c
> @@ -4,12 +4,17 @@
>    */
>   
>   #include <common.h>
> +#include <dm.h>
> +#include <usb.h>
>   #include <asm/arch/a1.h>
>   #include <asm/arch/boot.h>
>   #include <asm/armv8/mmu.h>
>   #include <asm/io.h>
>   #include <linux/compiler.h>
>   #include <linux/sizes.h>
> +#include <linux/usb/otg.h>
> +#include <asm/arch/usb.h>
> +#include <usb/dwc2_udc.h>
>   
>   phys_size_t get_effective_memsize(void)
>   {
> @@ -57,3 +62,87 @@ static struct mm_region a1_mem_map[] = {
>   };
>   
>   struct mm_region *mem_map = a1_mem_map;
> +
> +#if CONFIG_IS_ENABLED(USB_DWC3_MESON_G12A) && \
> +	CONFIG_IS_ENABLED(USB_GADGET_DWC2_OTG)
> +
> +static struct dwc2_plat_otg_data meson_a1_dwc2_data;
> +
> +int board_usb_init(int index, enum usb_init_type init)
> +{
> +	int node, dwc2_node;
> +	const void *blob = gd->fdt_blob;
> +	struct udevice *dev;
> +	int ret;
> +
> +	node = fdt_node_offset_by_compatible(blob, -1,
> +					     "amlogic,meson-a1-usb-ctrl");
> +	if (node < 0) {
> +		pr_err("not found usb-control node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!fdtdec_get_is_enabled(blob, node)) {
> +		pr_err("usb is disabled in the device tree\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = uclass_get_device_by_of_offset(UCLASS_SIMPLE_BUS, node, &dev);
> +	if (ret) {
> +		pr_err("not found usb-control device\n");
> +		return ret;
> +	}
> +
> +	dwc2_node = fdt_node_offset_by_compatible(blob, node,
> +						  "amlogic,meson-a1-usb");
> +	if (dwc2_node < 0) {
> +		pr_err("not found dwc2 node\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!fdtdec_get_is_enabled(blob, dwc2_node)) {
> +		pr_err("dwc2 is disabled in the device tree\n");
> +		return -ENODEV;
> +	}
> +
> +	meson_a1_dwc2_data.regs_otg = fdtdec_get_addr(blob, dwc2_node, "reg");
> +	if (meson_a1_dwc2_data.regs_otg == FDT_ADDR_T_NONE) {
> +		pr_err("can't get base address\n");
> +		return -ENODATA;
> +	}
> +
> +	meson_a1_dwc2_data.rx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> +						"g-rx-fifo-size", 0);
> +	if (meson_a1_dwc2_data.rx_fifo_sz < 0) {
> +		pr_err("failed to get g-rx-fifo-size value\n");
> +		return -ENODATA;
> +	}
> +
> +	meson_a1_dwc2_data.np_tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> +						"g-np-tx-fifo-size", 0);
> +	if (meson_a1_dwc2_data.np_tx_fifo_sz < 0) {
> +		pr_err("failed to get g-np-tx-fifo-size value\n");
> +		return -ENODATA;
> +	}
> +
> +	meson_a1_dwc2_data.tx_fifo_sz = fdtdec_get_int(blob, dwc2_node,
> +						"g-tx-fifo-size", 0);
> +	if (meson_a1_dwc2_data.tx_fifo_sz < 0) {
> +		pr_err("failed to get g-tx-fifo-size value\n");
> +		return -ENODATA;
> +	}
> +
> +	ret = dwc3_meson_g12a_force_mode(dev, USB_DR_MODE_PERIPHERAL);
> +	if (ret) {
> +		pr_err("failed to force usb mode to peripheral\n");
> +		return ret;
> +	}
> +
> +	return dwc2_udc_probe(&meson_a1_dwc2_data);
> +}
> +
> +int board_usb_cleanup(int index, enum usb_init_type init)
> +{
> +	return 0;
> +}
> +#endif

