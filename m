Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30B3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:46:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD17839F0;
	Thu, 10 Apr 2025 09:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QTlXlnGS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E33839F3; Thu, 10 Apr 2025 09:46:10 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD04683995
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:46:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso5723015e9.3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744271168; x=1744875968; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=9SGL2YJJiRxRHDzTRhf5bozpgbAjrP2ZmnCgmBhHcjk=;
 b=QTlXlnGSY+4Afo/7L1FwHC7LiQ9NSp480bPdocChJd/cKFdrIrELPBi6ERCAILpZF7
 fkvw8Z/+uGycJWqpRT0HENlWispJoOjhincLYowJbYaERg9HuVM2vARBf1YyxmyTzfZk
 Q70WN+JOO2jgl7ke926yO24fOMOPpKcnErsm+MAe7/H0Ro+otfgR7TzbL26Xptfa8RsR
 nATnvhBh3FGRATXknQMKVEC2eV13yGHV8tZB/A3HbTJhBQI5mwtXn+REoZIJexuDOX+c
 hlm6I5pyQsBdg3OVfuV9NpFJIutzfGOx2r2bkElZoA6Yws+d2opoJBhabmzH3oNjYGwl
 C8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271168; x=1744875968;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9SGL2YJJiRxRHDzTRhf5bozpgbAjrP2ZmnCgmBhHcjk=;
 b=G1YVYWPB70FXe9rm5hBL2lhjQkofr/SYgDAwKvwJm8o3pFEP1wlmnsvv6XZ7jXuhDy
 Lc14SHQDoZZEpo0sTJiRsi4pnBSDSn8sy2YY7RANdAu2w9K2iBro19WRkmNpqMK/J3p/
 9wGA9Pn0tlMDIA/X00yh2ctJEViNJwrHtvPt1y2RTmWSO3E115cCBc268BUBa3EkLx+Q
 vOQAppnlDRVz1tUPuVSJVgQfLYYRQg7hsPSzbKypmxVkrC6J2aYy/mTF8BSVrENoZFDe
 lph1CN1oD1Xo6x+9xqhtDRLxXvvQpfRbN68MEEDNmQMQ1i/SpImXLirYIaCcam7eDr/B
 cwag==
X-Gm-Message-State: AOJu0Yy72FQ/ImFKqjKAr72yOEGhzmq2fdjmfiNeUN3gUiQrn286i39t
 gxmKGbfRV5KpBi47TjsCJHb/7aSdKeYUlVXTlF7PghSN6IiOCEWd//ZqUNz4VkQ=
X-Gm-Gg: ASbGncvW+xFv+b5htgeHM3dUmImVeCVdlS41VKEjE+sx0bWr8sHrpWAA8cvVnMgJGiO
 Ps6MYvZ9c/2ZTFYSD1b3Q4iZJek0GKkgQLSC7rjp3sJcpie0sphlDL1+XZRk8TzcrP7abH4YWVg
 nLS+EopnutLs+SvUMd0gqutaw/djAVHNTSClPEgeijtpdSbkBnkJtQhbfFrUCQf04wb6CuPdGkh
 W5f5It3Css5X+BaKWaCWF7x+LKFB8GWKlAVtYwXKVFk8TZ7UvmeSqinV1u74gibJMjD7gX0mG0N
 R+Bqd1ynEquJpM9Bv3qz3b5wYskNEMzsMx2a8Fc+PW0hIVMjzVkgHM7T/Fhoz77xV6aiF1NrNaz
 EVSaPsY40UJk8kOJPdQ==
X-Google-Smtp-Source: AGHT+IGSzMSrbXrC7jIjRCLoeJaGS45xVqlEF5MYndAxZp6yX/MuFE6x0eIyPl0nH9d5ji6/MvC8Zw==
X-Received: by 2002:a05:600c:510f:b0:43d:45a:8fbb with SMTP id
 5b1f17b1804b1-43f2ff9bf72mr8577395e9.22.1744271168142; 
 Thu, 10 Apr 2025 00:46:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f207c8fb4sm45292385e9.35.2025.04.10.00.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:46:07 -0700 (PDT)
Message-ID: <ef57a2f0-0b76-4eda-a26c-5a21873673ae@linaro.org>
Date: Thu, 10 Apr 2025 09:46:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/6] mach-snapdragon: of_fixup: set dr_mode for RB1/2
 boards
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-5-76dfea80b07f@linaro.org>
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
In-Reply-To: <20250409-livetree-fixup-v1-5-76dfea80b07f@linaro.org>
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

On 09/04/2025 19:17, Caleb Connolly wrote:
> The RB1 and RB2 have a single USB controller which is manually muxed
> between a type-c port and an internal USB hub via a DIP switch. OTG is
> supported in Linux, but the DWC3 driver in U-Boot can only handle a
> single mode, and defaults to peripheral mode.
> 
> We did hack around this on the RB2, but the RB1 got left out.
> 
> Now that we can fix up the live tree before devices are bound, drop the
> DTS hacks and do the fixup at runtime instead.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/qrb4210-rb2-u-boot.dtsi |  6 ------
>   arch/arm/mach-snapdragon/of_fixup.c  | 28 ++++++++++++++--------------
>   2 files changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi b/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
> deleted file mode 100644
> index 7d1375f38c44d7bd54c022fa3d390f666a35d6ee..0000000000000000000000000000000000000000
> --- a/arch/arm/dts/qrb4210-rb2-u-boot.dtsi
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -
> -/* This is usually OTG but U-Boot doesn't support that properly */
> -&usb_dwc3 {
> -	dr_mode = "host";
> -};
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index b39036e8e0890fdf834a0dfe6966ef3dd365f3d2..62b329e2c90d7e0a374838968ab5707333edbf03 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -98,8 +98,21 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>   		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
>   		return ret;
>   	}
>   
> +	/*
> +	 * The RB1/2 boards only have a single USB controller and it's muxed between the type-C port
> +	 * and a USB hub. Since we can't do OTG in U-Boot properly we prefer to put it into host mode.
> +	 */
> +	if (of_device_is_compatible(gd->of_root, "qcom,qrb4210-rb2", NULL, NULL) ||
> +	    of_device_is_compatible(gd->of_root, "qcom,qrb2210-rb1", NULL, NULL)) {
> +		ret = of_write_prop(dwc3, "dr_mode", sizeof("host"), "host");
> +		if (ret) {
> +			log_err("Failed to set 'dr_mode' property: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>   	return 0;
>   }
>   
>   static void fixup_usb_nodes(void)
> @@ -162,21 +175,8 @@ static int qcom_of_fixup_nodes(void)
>   }
>   
>   EVENT_SPY_SIMPLE(EVT_OF_LIVE_INIT, qcom_of_fixup_nodes);
>   
> -int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
> +int ft_board_setup(void __maybe_unused *blob, struct bd_info __maybe_unused *bd)
>   {
> -	struct fdt_header *fdt = blob;
> -	int node;
> -
> -	/* On RB1/2 we need to fix-up the dr_mode */
> -	if (!fdt_node_check_compatible(fdt, 0, "qcom,qrb4210-rb2") ||
> -	    !fdt_node_check_compatible(fdt, 0, "qcom,qrb2210-rb1")) {
> -		fdt_for_each_node_by_compatible(node, blob, 0, "snps,dwc3") {
> -			log_debug("%s: Setting 'dr_mode' to OTG\n", fdt_get_name(blob, node, NULL));
> -			fdt_setprop_string(fdt, node, "dr_mode", "otg");
> -			break;
> -		}
> -	}
> -
>   	return 0;
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
