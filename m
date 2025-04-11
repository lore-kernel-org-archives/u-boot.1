Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC97C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:12:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81BD84088;
	Fri, 11 Apr 2025 16:12:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jcbWrfTY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39F78408D; Fri, 11 Apr 2025 16:12:02 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B514584085
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso15464145e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744380720; x=1744985520; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gNrdQjVAH8F7gui5uldcF/iWpOGZMqWU7x2yPGf7yG8=;
 b=jcbWrfTYIUYihl0fWNMjT8/1mOFmuHMecRq6jmvMNzbWXahNMK4i5tfbSjEj+sXPoz
 ap7Fl+QZl8EET0uo+Je7f2o9ocG6xwljXVecbVASDD1fLEMJoE5vR4QFTGXtaOmGj8W5
 tcknRuphPN3EwvTgPtm6MMtlm6DMzQrjTE6ONZDRuKz7FJ1rdDI6yI4FHXEJrzobNN7T
 RtzkOugXmXabI8EegFfwgTfbuSgrGPKE3SdGmQxYne5XnMZkOS/Ama2H+08C3vTfOyir
 13EbR9NP++9MUQcB50cZlj96Y/9Rl3gsFBpj70MlG2dXWPkAPBJlNdk5bV+k8T0PtqAC
 vbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380720; x=1744985520;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gNrdQjVAH8F7gui5uldcF/iWpOGZMqWU7x2yPGf7yG8=;
 b=G3rl/QOTlIi1re3RqUXF+tTE9Lq0FHFx6Cu0vzPONkVJ7Nnt4Cdm32rxy2q1lMvpET
 38p5OJjipCCS+u7Ius0JFr0iFCGSKgSU5mgsmYQb48C6vPeBMVAZzS9bqPbBlrexC2rE
 n6Bvfyk1x5b1Yrw0l+wiZZP5/GeZL0/cAeErepx0ecqrgLrRJLcqByumXL4XFwYzaQUF
 J6Jl1d6sLArRMeJTgvRr1elDbk6Q6aRBVS51FyDktJotbGgr+RvwU2I81eXSEYJBcpl9
 adx4uMEpXGNLZSwW3DqAtF7hRefhqkTdjJEBcK7aK4CcQmNMydKqnu4I9iDSiuFHci2s
 6Yzg==
X-Gm-Message-State: AOJu0Yx2qU7CERI8P8uexWX8hMU7Ty6Trawf/ItxLYOC2SY6UxiyAQDD
 XMbu13cmFtglcpQAFR0hzoZ9TtVLrRi4QKfDWVPD79n27Fcp2FvEF1qgVQ9MmWU=
X-Gm-Gg: ASbGncuxeoGrozeIKoM/LWllZvPlwn+0+TCrPKzQzfpbVVnTfxzIccVsKAWypXvKxk3
 RvG9dMyVYeOYQ8/k4v8UCCwz3O8X/E2IEEPYzH+tVbeOjCRiYRU5vRpZJLGwg9Ec5W4Po9uU022
 lR5Z964Nx3/MbCuZYuo5uoR0C7At5QxE3tTQjzlefGU3fiXntSwcZIlfF0epQyBfcNlnRz3nwoe
 i4V32NAR9yq7E5pPQRp/fYw2JrFFfNDtBiQA88YhrVoDgApMNorAlWA0QXMRcd1EYj8u9WLOiUt
 zrhMLgVJc/nPSha5zAyi9q7N5AT9aHugRebQAnhRz2C0Ga8L0ZuA5qjreq/r4ScGbdtixmJKjZt
 AQMykosLiKfxVtxomSg==
X-Google-Smtp-Source: AGHT+IFp/z4ppEou4dP6HuDlsWtcBmXdpBvBCjgUaN9sqDYswmswE/cPOIW2uEDEFt3WE8azwHInxg==
X-Received: by 2002:a7b:c8d0:0:b0:43b:ce36:7574 with SMTP id
 5b1f17b1804b1-43f3b530d98mr19977215e9.11.1744380720019; 
 Fri, 11 Apr 2025 07:12:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f77b:949e:1d61:69a8?
 ([2a01:e0a:3d9:2080:f77b:949e:1d61:69a8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207cb88asm86927955e9.37.2025.04.11.07.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:11:59 -0700 (PDT)
Message-ID: <31f7c87d-cc4e-4035-940c-7e9641b498d0@linaro.org>
Date: Fri, 11 Apr 2025 16:11:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 4/8] mach-snapdragon: of_fixup: remove confusing log
 message
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-4-1236823377bb@linaro.org>
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
In-Reply-To: <20250411-livetree-fixup-v2-4-1236823377bb@linaro.org>
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

On 11/04/2025 14:47, Caleb Connolly wrote:
> The debug log here had the logic completely backwards, even though the
> code is actually correct. Remove it since it's extraneous anyway.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index dcd09ee7cac3e02287647c9e6df5575651e18e85..a5515c02d3de05944dfb7c1b2a5542631b517497 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -72,13 +72,14 @@ static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np
>   		log_err("Failed to read second phy name: %d\n", ret);
>   		return ret;
>   	}
>   
> -	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
> -		log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
> -			  second_phy_name);
> +	/*
> +	 * Determine which phy is the superspeed phy by checking the name of the second phy
> +	 * since it is typically the superspeed one.
> +	 */
> +	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy")))
>   		hsphy_idx = 0;
> -	}
>   
>   	/* Overwrite the "phys" property to only contain the high-speed phy */
>   	ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
>   	if (ret) {
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
