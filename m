Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98D4C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF358406A;
	Fri, 11 Apr 2025 16:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bMW3kN9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD7C84073; Fri, 11 Apr 2025 16:10:49 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6963084003
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1673081f8f.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744380647; x=1744985447; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bl5S1byYeV59B44sZTxwzAU8/2U8Xl2uBvqFL77Vi+w=;
 b=bMW3kN9+6AoWlkHbyfSPmXRTrQgyAcQO1rWfSxGRtIbokjvMkcqCclUL39DtnUF92I
 8i86HYGmy7uPhm11wlff2EH/gwgvsQjmDAvBUXWTobbqmcr+TiykOXY8ozMpAIsP1a0W
 fobpw/8fDFZgDsbBFJSsdlEn59T4dc2sY7CBdnLLziiXhQNrtc2YjZXIpNOg2wlU8OtM
 XH2q7HQhF4DT6F3/ADmxmZgkvaQfJ6izAWPE3dNE7hOSQvFjx0P8Jv6I4DHspBirRK4b
 sJB5tiFuYPF5mHIXzDV31upr4sz7sLMj5UGe6E9yQFPMAD+ti+i/IyJIV4D3ouslSoIa
 kPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380647; x=1744985447;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bl5S1byYeV59B44sZTxwzAU8/2U8Xl2uBvqFL77Vi+w=;
 b=Ry8TSAnx4ssDc/EtRuW1+x+/ZkGItQ1mndzQY3pIP25hr+vrILjH+FsfjZmzs1v7kJ
 kEu1tIGPkBC+TU3WQOCRQi6T0WMnTxwTwwAmyW+kV7/FlkxX2ttOPbm/xCINRy95n400
 ojy0Ze3dXUx8nK1wzbCaKNU/K+4kPVtr4PY1PzWPyNRTezin0SzdHo8c3fcPkypv41GO
 gxEdJchBN1H0Ic2DHzDsHA9uWDvV7FVXEJtMrJYUbsx0ZhJEQBrLmkCLj46qknO3HlA+
 wOh7Onc/nvmBTNL82MFMofvRO6PDbMNZdCDDh9plEL5JjMQlzI+gKKzn+K/Se7rY3xQf
 w9+A==
X-Gm-Message-State: AOJu0Yz8sxi/TNIdwKsudm9vY6XyTUvBK6adoHnh1Q9nLCspWcud+QFU
 4GQMfreEaX395hd7d4UelfdCd31BxHdk8d89jS9NvhE8O8qdPhGprNUI8mNISq0=
X-Gm-Gg: ASbGnctDqrZqpXE31M9oNXxu+DBreuMBXZ8FU+iSz2t9ZW314ATLqVfBAQwyZIcYYpU
 ThRDFxVgwnCKgw24MKj0ScwWK6kcEltads7c6rY8T1+dveGONJQXMZD5zqElL1cyy5ibuXSJUX9
 LzlrBsJ4j30mAfRB9MCddGB8w/YdbKh91QbvJXeCygr622beW/cp2jYXYitQFEg9omTOgZdK9HD
 u7dwZR/Ju2f+NJYqALbZw0slnHdsFhGPPe2ekO9oOWW/dxxcVBzf2/JGFA00qzo9Au6OS5VvVCK
 BtDbVDZ9uXkcZ4i/5L7NfwpEKk5rDCItCIk/tPgYhjla0Vy/WF0gwmdwUv4X6QOy01VTIswYH2M
 pMhWjXs0NxNyeIjLncA==
X-Google-Smtp-Source: AGHT+IEo7b/zVpmSgzEPkSvdbQmU2LamrxPMr69nf5y/q4s5ae95SQOEqgjjI4psW0ra/uZ9H2aXOQ==
X-Received: by 2002:a5d:64e8:0:b0:390:f745:bbfb with SMTP id
 ffacd0b85a97d-39ea52171f7mr2611363f8f.26.1744380646683; 
 Fri, 11 Apr 2025 07:10:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f77b:949e:1d61:69a8?
 ([2a01:e0a:3d9:2080:f77b:949e:1d61:69a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445713sm2072690f8f.85.2025.04.11.07.10.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:10:46 -0700 (PDT)
Message-ID: <349ff29e-076a-46b6-a556-75cf72d5d5ac@linaro.org>
Date: Fri, 11 Apr 2025 16:10:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/8] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT
 fixups
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-2-1236823377bb@linaro.org>
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
In-Reply-To: <20250411-livetree-fixup-v2-2-1236823377bb@linaro.org>
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

On 11/04/2025 14:47, Caleb Connolly wrote:
> This will now apply fixups prior to devices being bound, which makes it
> possible to enable/disable devices and adjust more properties that might
> be read before devices probe.

Subject should be EVT_OF_LIVE_BUILT

Neil

> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c     |  1 -
>   arch/arm/mach-snapdragon/of_fixup.c  | 25 ++++++++++++++++---------
>   arch/arm/mach-snapdragon/qcom-priv.h | 14 --------------
>   3 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index deae4d323789eab75d5fe735159b4cd820c02c45..3ab75f0fce02ecffd476ebe2aa606b1a9024bbec 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -305,9 +305,8 @@ void __weak qcom_board_init(void)
>   
>   int board_init(void)
>   {
>   	show_psci_version();
> -	qcom_of_fixup_nodes();
>   	qcom_board_init();
>   	return 0;
>   }
>   
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 1ea0c18c2f2789a8aa054cd95bb9e4308d6b3384..70399307bcbda1e067230f00af6ba859a98c7ac0 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -21,8 +21,9 @@
>   
>   #include <dt-bindings/input/linux-event-codes.h>
>   #include <dm/of_access.h>
>   #include <dm/of.h>
> +#include <event.h>
>   #include <fdt_support.h>
>   #include <linux/errno.h>
>   #include <stdlib.h>
>   #include <time.h>
> @@ -31,9 +32,9 @@
>    * USB controllers. Rather than requiring source level DT changes, we fix up
>    * DT here. This improves compatibility with upstream DT and simplifies the
>    * porting process for new devices.
>    */
> -static int fixup_qcom_dwc3(struct device_node *glue_np)
> +static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
>   {
>   	struct device_node *dwc3;
>   	int ret, len, hsphy_idx = 1;
>   	const __be32 *phandles;
> @@ -100,11 +101,11 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>   
>   	return 0;
>   }
>   
> -static void fixup_usb_nodes(void)
> +static void fixup_usb_nodes(struct device_node *root)
>   {
> -	struct device_node *glue_np = NULL;
> +	struct device_node *glue_np = root;
>   	int ret;
>   
>   	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
>   		ret = fixup_qcom_dwc3(glue_np);
> @@ -113,16 +114,16 @@ static void fixup_usb_nodes(void)
>   	}
>   }
>   
>   /* Remove all references to the rpmhpd device */
> -static void fixup_power_domains(void)
> +static void fixup_power_domains(struct device_node *root)
>   {
>   	struct device_node *pd = NULL, *np = NULL;
>   	struct property *prop;
>   	const __be32 *val;
>   
>   	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> -	for_each_of_allnodes(pd) {
> +	for_each_of_allnodes_from(root, pd) {
>   		if (pd->name && !strcmp("power-controller", pd->name))
>   			break;
>   	}
>   
> @@ -132,9 +133,9 @@ static void fixup_power_domains(void)
>   		return;
>   	}
>   
>   	/* Remove all references to the power domain controller */
> -	for_each_of_allnodes(np) {
> +	for_each_of_allnodes_from(root, np) {
>   		if (!(prop = of_find_property(np, "power-domains", NULL)))
>   			continue;
>   
>   		val = prop->value;
> @@ -149,14 +150,20 @@ static void fixup_power_domains(void)
>   		func(__VA_ARGS__); \
>   		debug(#func " took %lluus\n", timer_get_us() - start); \
>   	} while (0)
>   
> -void qcom_of_fixup_nodes(void)
> +static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>   {
> -	time_call(fixup_usb_nodes);
> -	time_call(fixup_power_domains);
> +	struct device_node *root = event->data.of_live_built.root;
> +
> +	time_call(fixup_usb_nodes, root);
> +	time_call(fixup_power_domains, root);
> +
> +	return 0;
>   }
>   
> +EVENT_SPY_FULL(EVT_OF_LIVE_BUILT, qcom_of_fixup_nodes);
> +
>   int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
>   {
>   	struct fdt_header *fdt = blob;
>   	int node;
> diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
> index 74d39197b89f4e769299b06214c26ee829ecdce0..4f398e2ba374f27811afd2ccf6e72037d0f9ee7f 100644
> --- a/arch/arm/mach-snapdragon/qcom-priv.h
> +++ b/arch/arm/mach-snapdragon/qcom-priv.h
> @@ -8,19 +8,5 @@ void qcom_configure_capsule_updates(void);
>   #else
>   void qcom_configure_capsule_updates(void) {}
>   #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>   
> -#if CONFIG_IS_ENABLED(OF_LIVE)
> -/**
> - * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
> - *
> - * Adjusts nodes in the live tree to improve compatibility with U-Boot.
> - */
> -void qcom_of_fixup_nodes(void);
> -#else
> -static inline void qcom_of_fixup_nodes(void)
> -{
> -	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
> -}
> -#endif /* OF_LIVE */
> -
>   #endif /* __QCOM_PRIV_H__ */
> 

