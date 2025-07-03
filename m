Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC0BC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:31:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E924B82063;
	Thu,  3 Jul 2025 09:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gDsS+WEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE6082A76; Thu,  3 Jul 2025 09:31:25 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DD3681FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 09:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a51481a598so2996519f8f.3
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 00:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751527883; x=1752132683; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=YV4dBYfGjpkz6tKNz53jBVXe0LYJfj51tE8g0/9W8sM=;
 b=gDsS+WEQu37DcnR6cKc8We1A05mOOanAAfXwHsRxJMrclAAjKcS31boOIcVa05tyTQ
 CAQsd8urk+gXtKiH8jp0+I7PEHUqbHQGvkwao4XUFjKT3n/XDFa/yP9t/ifOFKpGOEQj
 0o7BAzGAq8yiCEOzacCIUtojoJF/TTEkEXiM54PT7Msq+0kX9JpU1YoLAcg0rn/6OKHs
 +aKXTz7T/cPN+NnliX8NtrZcWZotEgJsEnqAwPAocWLP1tCWkaJo77sd7vuTupXg1w5I
 xpL+lL7OkeEkXdVt2k6I8X+xJdn7ow1tT6YnrsHgLSziyYDY3JOERjQNa0y5FgO66mrx
 99Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751527883; x=1752132683;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YV4dBYfGjpkz6tKNz53jBVXe0LYJfj51tE8g0/9W8sM=;
 b=V2p+HxA7ekylm9KSylzhOVxcciGG0twgfz8MTqvqybDqlTeVQSTpkLJ4oEOqf7gf38
 DQJTwGoVgG9jIs2lhcx+sEGplqZQij1KmIiOtkKUvT8a8cG0/Ke7O7GcKt89bzu40l6G
 ehDmTo8QFi4AK6CVh84BoGwVsAHOcwjSjFXojQ3nIbWe0uXzW99CtU8F5WQhNlEnDlGD
 QtucxJ3aioV8iqwxZ4LM6/kvVcqZg3FtOS96vTFRV53ol8g/1B9crdgXapB42N/DgP4+
 wImvg0MX5NeDqJ7oRatQzCVf25BLHwtVGdEA9T3g70VkY8St5a1/O6rivVkmkaDc6xVQ
 xgFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9JRGN6YuC1Zt4lvZktig4IjMVh71TZxrC2VPbqZvng1VFfNyKP3QeAsi/ogB04iLAoKPBH2Q=@lists.denx.de
X-Gm-Message-State: AOJu0YxjojRGM3hf36FMLiZNsOk3rV9996LNO93CaHHGbZUkE8aawaBP
 JfGyII9d5fC65h1QnudyoDssjWRAk62hgxaXJwoMcMaS/vvSYJCJ1jNuiYmB+IElQCc=
X-Gm-Gg: ASbGnculUDFRJvMJkmMcfiYAb2CuLUmLklvbFPgW1Tb+Rs00ZvNc4msa5i8JPZJBacT
 LRKWImW+IOgpw1Fyy6mGlQwamooMyy9Mellr0ysey4vR/kS6baUYs5jXSOrd9eqLYdoYK1vIwpf
 6u2hFn9oJSv8iso3iW0i0EwF6yIcjjAVeunwpCUiM9+AqcND9N78zlrpPQj9ibFzSywQPm52hA2
 2dlIIZOVS5GKNYYCN8bm+TsbkxVxplvaICQKobaOZkJHxSPUsV3pvHI7hW0JgdtzRw8L0xI7n9E
 yfCovIEDAtTO1EzpXBUAZ3ksffQVc/cnMhTux/nr5qTFlG/GTtE30kJ9r49cZ2oXZqrwZZ+Icls
 56aSf6yAbBWWJTDjvh7cTz/NDUmVWRKU38SGz8lc=
X-Google-Smtp-Source: AGHT+IFBaXctdD6i8go+c1idGsuVozyiNiet6vIiqDG5QYZM+Fax0TeHlphv1uez06yAeZf1yFZ5Ng==
X-Received: by 2002:a05:6000:4807:b0:3a6:d579:ec21 with SMTP id
 ffacd0b85a97d-3b1fe5beeeemr4899739f8f.12.1751527882870; 
 Thu, 03 Jul 2025 00:31:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4232:f5b9:37fe:c24f?
 ([2a01:e0a:3d9:2080:4232:f5b9:37fe:c24f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e598d2sm17752616f8f.76.2025.07.03.00.31.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 00:31:22 -0700 (PDT)
Message-ID: <538f56eb-1196-4fdd-a154-4cb9b6724ba0@linaro.org>
Date: Thu, 3 Jul 2025 09:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 3/4] mach-snapdragon: fixup power-domains
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 miquel.raynal@bootlin.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
 <20250702180133.1889709-4-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20250702180133.1889709-4-aswin.murugan@oss.qualcomm.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 02/07/2025 20:01, Aswin Murugan wrote:
> RPMH power domain properties were initially removed from the
> device tree due to the absence of driver support. Support for
> SA8775P_MMCX and SA8775P_MMCX_AO has now been added in the RPMH
> Power Domain Driver for the SA8775P platform.

Well this affects all SoCs, so please all SoC entries in the RPMH Power domain driver!

Neil

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775P specific fixups are done
> 
> v2:
> - Removed the power domain fixups, since the power domains are handled in qcom-rpmhpd driver
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 32 +----------------------------
>   1 file changed, 1 insertion(+), 31 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index b398c6b7b9f..e36c541ac42 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -19,6 +19,7 @@
>   #define pr_fmt(fmt) "of_fixup: " fmt
>   
>   #include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/power/qcom-rpmpd.h>
>   #include <dm/of_access.h>
>   #include <dm/of.h>
>   #include <event.h>
> @@ -129,36 +130,6 @@ static void fixup_usb_nodes(struct device_node *root)
>   	}
>   }
>   
> -/* Remove all references to the rpmhpd device */
> -static void fixup_power_domains(struct device_node *root)
> -{
> -	struct device_node *pd = NULL, *np = NULL;
> -	struct property *prop;
> -	const __be32 *val;
> -
> -	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
> -	for_each_of_allnodes_from(root, pd) {
> -		if (pd->name && !strcmp("power-controller", pd->name))
> -			break;
> -	}
> -
> -	/* Sanity check that this is indeed a power domain controller */
> -	if (!of_find_property(pd, "#power-domain-cells", NULL)) {
> -		log_err("Found power-controller but it doesn't have #power-domain-cells\n");
> -		return;
> -	}
> -
> -	/* Remove all references to the power domain controller */
> -	for_each_of_allnodes_from(root, np) {
> -		if (!(prop = of_find_property(np, "power-domains", NULL)))
> -			continue;
> -
> -		val = prop->value;
> -		if (val[0] == cpu_to_fdt32(pd->phandle))
> -			of_remove_property(np, prop);
> -	}
> -}
> -
>   #define time_call(func, ...) \
>   	do { \
>   		u64 start = timer_get_us(); \
> @@ -171,7 +142,6 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>   	struct device_node *root = event->data.of_live_built.root;
>   
>   	time_call(fixup_usb_nodes, root);
> -	time_call(fixup_power_domains, root);
>   
>   	return 0;
>   }

