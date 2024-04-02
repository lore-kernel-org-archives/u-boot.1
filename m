Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3066BCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9561C87F36;
	Tue,  2 Apr 2024 10:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WDw1uzqh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E3CB880DD; Tue,  2 Apr 2024 10:31:37 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6AF188099
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4156e0cffdaso8503755e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712046693; x=1712651493; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=m+HZghrKHbdFiWPbsCuIk9sgBEi9dxQ/ZTwJAYc3acA=;
 b=WDw1uzqhR6Zb0HScz9Ti1byuyOsROBVZXsUxTFMf6rPTh5UBdFpQeKr7WgtNFhKFNs
 B5AwtR9r/pyiUFIEKYUEkX6FCXjpS2FLUH43jBG29Vj0cn7VUyf507zvigC4Do37LTSq
 WAdMpwJHdQfp5S+CxQtb/Xjb28xTb43wWPPwmjBJ1S34zTz7RquoMLwvAFF1E4kGMbjg
 vDCjhsTrvNa2oTm/XT/+Mejp+QvDAb+QLL4Vli6XM65D5StBqjvRi8I/5mMiXcT9F7wQ
 Nr8qTUKVofAkhCe1LLPgKGCuhnn7MgfGxCEx9n3pTXK9d03B1igNCx6656yUGtYenZvv
 8npA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712046693; x=1712651493;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=m+HZghrKHbdFiWPbsCuIk9sgBEi9dxQ/ZTwJAYc3acA=;
 b=gS3ReH3Y5RoBwHIvwcynudgb65txt5FNzTL89krLExFDTwLonjs39yGkCZMwAmwvws
 AoQySyWGZe8S+ronvrAu+iWSS5CrilBAfYLCSOdLydeX5kxAfjNY6qbqzZ+6Sj8U+LrE
 E4sEz1Vqz9zl1ZD3j1ffCn2hThpsMNXa5Q6hr/7NCkH5V5dyCXBtWC7fz2oYv7r1O1RX
 aNvYvI1ojDCyHhugM0+MKEaKKvcjn0IZMUZ/uLhfeTxNa+EN1T/wjzMumzIaCARqgvS/
 P6VerFTCLqrr64aTycx/grkaLXLyrXXleMibn9Cu2CE5tSGhIP1Q2K+JFKPE6goNTVCn
 1tWg==
X-Gm-Message-State: AOJu0Yzjew0e3wmZCqBIgJw52zCSkavs5qdqp9NGRgmKspl0lzsNrNt0
 x2DnbC4UbvCFvqF8+Wf05Eg7od9y5XUPLJR4tYuiBE/sNBoYF/TWCrb2+xlszfQ=
X-Google-Smtp-Source: AGHT+IFLNMJMuJfwXgE4eWbnpLD4IxcA5clnSaOOmHvjhsgpoypYLmk/iZcNJgOZubZg3yEM454fgg==
X-Received: by 2002:a05:600c:1386:b0:414:22b5:c32c with SMTP id
 u6-20020a05600c138600b0041422b5c32cmr10025479wmf.37.1712046693022; 
 Tue, 02 Apr 2024 01:31:33 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05600c4fcf00b0041488895a37sm20254162wmq.33.2024.04.02.01.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:31:32 -0700 (PDT)
Message-ID: <3b26ec50-fc94-4933-9e96-99f9729d4d70@linaro.org>
Date: Tue, 2 Apr 2024 10:31:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 10/16] mach-snapdragon: fixup USB nodes
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-10-4e98228b3d03@linaro.org>
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
In-Reply-To: <20240328-b4-qcom-livetree-v5-10-4e98228b3d03@linaro.org>
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

On 28/03/2024 18:59, Caleb Connolly wrote:
> We don't support USB super-speed in U-Boot yet, we lack the SS PHY
> drivers, however from my testing even with a PHY driver there seem to be
> other issues when talking to super-speed peripherals.
> 
> In pursuit of maintaining upstream DT compatibility, and simplifying
> porting for new devices, let's implement the DT fixups necessary to
> configure USB in high-speed only mode at runtime. The pattern is
> identical for all Qualcomm boards that use the Synaptics DWC3
> controller:
> 
> * Add an additional property on the Qualcomm wrapper node
> * Remove the super-speed phy phandle and phy-name entries.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/Makefile    |   1 +
>   arch/arm/mach-snapdragon/board.c     |   3 +
>   arch/arm/mach-snapdragon/of_fixup.c  | 123 +++++++++++++++++++++++++++++++++++
>   arch/arm/mach-snapdragon/qcom-priv.h |  20 ++++++
>   4 files changed, 147 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index 857171e593da..7a4495c8108f 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,4 +2,5 @@
>   #
>   # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>   
>   obj-y += board.o
> +obj-$(CONFIG_OF_LIVE) += of_fixup.o
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 6f762fc948bf..65e4c61e866a 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -27,8 +27,10 @@
>   #include <fdt_support.h>
>   #include <usb.h>
>   #include <sort.h>
>   
> +#include "qcom-priv.h"
> +
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
>   
> @@ -159,8 +161,9 @@ void __weak qcom_board_init(void)
>   
>   int board_init(void)
>   {
>   	show_psci_version();
> +	qcom_of_fixup_nodes();
>   	qcom_board_init();
>   	return 0;
>   }
>   
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> new file mode 100644
> index 000000000000..4fdfed2dff16
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * OF_LIVE devicetree fixup.
> + *
> + * This file implements runtime fixups for Qualcomm DT to improve
> + * compatibility with U-Boot. This includes adjusting the USB nodes
> + * to only use USB high-speed, as well as remapping volume buttons
> + * to behave as up/down for navigating U-Boot.
> + *
> + * We use OF_LIVE for this rather than early FDT fixup for a couple
> + * of reasons: it has a much nicer API, is most likely more efficient,
> + * and our changes are only applied to U-Boot. This allows us to use a
> + * DT designed for Linux, run U-Boot with a modified version, and then
> + * boot Linux with the original FDT.
> + *
> + * Copyright (c) 2024 Linaro Ltd.
> + *   Author: Caleb Connolly <caleb.connolly@linaro.org>
> + */
> +
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dm/of_access.h>
> +#include <dm/of.h>
> +#include <fdt_support.h>
> +#include <linux/errno.h>
> +#include <time.h>
> +
> +/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> + * USB controllers. Rather than requiring source level DT changes, we fix up
> + * DT here. This improves compatibility with upstream DT and simplifies the
> + * porting process for new devices.
> + */
> +static int fixup_qcom_dwc3(struct device_node *glue_np)
> +{
> +	struct device_node *dwc3;
> +	int ret, len, hsphy_idx = 1;
> +	const __be32 *phandles;
> +	const char *second_phy_name;
> +
> +	debug("Fixing up %s\n", glue_np->name);
> +
> +	/* Tell the glue driver to configure the wrapper for high-speed only operation */
> +	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
> +	if (ret) {
> +		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Find the DWC3 node itself */
> +	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
> +	if (!dwc3) {
> +		log_err("Failed to find dwc3 node\n");
> +		return -ENOENT;
> +	}
> +
> +	phandles = of_get_property(dwc3, "phys", &len);
> +	len /= sizeof(*phandles);
> +	if (len == 1) {
> +		log_debug("Only one phy, not a superspeed controller\n");
> +		return 0;
> +	}
> +
> +	/* Figure out if the superspeed phy is present and if so then which phy is it? */
> +	ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
> +	if (ret == -ENODATA) {
> +		log_debug("Only one phy, not a super-speed controller\n");
> +		return 0;
> +	} else if (ret) {
> +		log_err("Failed to read second phy name: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
> +		log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
> +			  second_phy_name);
> +		hsphy_idx = 0;
> +	}
> +
> +	/* Overwrite the "phys" property to only contain the high-speed phy */
> +	ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
> +	if (ret) {
> +		log_err("Failed to overwrite 'phys' property: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Overwrite "phy-names" to only contain a single entry */
> +	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
> +	if (ret) {
> +		log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
> +	if (ret) {
> +		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void fixup_usb_nodes(void)
> +{
> +	struct device_node *glue_np = NULL;
> +	int ret;
> +
> +	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
> +		ret = fixup_qcom_dwc3(glue_np);
> +		if (ret)
> +			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
> +	}
> +}
> +
> +#define time_call(func, ...) \
> +	do { \
> +		u64 start = timer_get_us(); \
> +		func(__VA_ARGS__); \
> +		debug(#func " took %lluus\n", timer_get_us() - start); \
> +	} while (0)
> +
> +void qcom_of_fixup_nodes(void)
> +{
> +	time_call(fixup_usb_nodes);
> +}
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> new file mode 100644
> index 000000000000..0a7ed5eff8b8
> --- /dev/null
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#ifndef __QCOM_PRIV_H__
> +#define __QCOM_PRIV_H__
> +
> +#if CONFIG_IS_ENABLED(OF_LIVE)
> +/**
> + * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
> + *
> + * Adjusts nodes in the live tree to improve compatibility with U-Boot.
> + */
> +void qcom_of_fixup_nodes(void);
> +#else
> +static inline void qcom_of_fixup_nodes(void)
> +{
> +	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
> +}
> +#endif /* OF_LIVE */
> +
> +#endif /* __QCOM_PRIV_H__ */
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Also tested on SM8550 & SM8650, so:
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
