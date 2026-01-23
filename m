Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199EDD72369
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 10:11:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AA0383B03;
	Fri, 23 Jan 2026 11:11:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PU/VXeA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06E6F83B32; Fri, 23 Jan 2026 11:11:51 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B1FE839DF
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 11:11:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so16950785e9.3
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 02:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769163107; x=1769767907; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uaLOyrVJfCvq6LoF1WuIHA8whsMEP0o7R3luDMTE13s=;
 b=PU/VXeA+oVwPznJABPb95jyaxrYvzLXZLGKSPt/6Q0e/M8WCnzGv15bYLCbIy/Apw3
 qYicQQVzCVDTvg0lpgQPEeWFoaTFxKbQUitaqthR1d21b7VwrEFH273bnHMGpperUnWE
 BwM9E+bmAhkR0KyGobNKyriOw8C2yEZotkKieJrsjc59GfMVVkfbS93yjImtgXs+do9T
 Y1HCbjAlaFH+YydO1XM9ukqqdqy/P8FPBU39ULgqsM3mCebubtw16kWHiLiTygSPJdW1
 W5NbI2LA8GTOkKALBXIB/mbP4mlCeTITrFe1v2Iq2sQPTdCUAS+9/apuJmMfldAHT3Ic
 sUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769163107; x=1769767907;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uaLOyrVJfCvq6LoF1WuIHA8whsMEP0o7R3luDMTE13s=;
 b=Z28iHSiGBauCSasgvez8yzhnXKxHwK3EpwHaje4gFeVn6GBu4bHm6JvnM2oL+u6NA3
 RQuK1uFTu95WJNn8/+b+l99kTHnZolq+aRF322TwBNMxXohDkGOH/iv6NACDtMifVJ6O
 Fg1q/OLJ37YA90MqyR/WwTjIsfysxZ6NZHdT87Ujyi9d2JTFSquVIQb9Hmb00lzr+/KG
 W/1QN778TIEtbZskDtHKJ1B5hJdMcKBDvzKkoUcKeB+Ub3lBvw24SACNYuuTlFDUbARm
 8h3JUwPdQbkjCNCDvL8x2LIu2mNITTwJyZvle8hscVmpqd95nlixRgXSWphMJFYtDPqQ
 6TmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1f3Cwzup67RODosZePiUBrori4vvwHSPqcr8Lidij3/pvjoj2aCecay5/9BJaBML7GsiCqG0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2e1VvggPRzpz1VM3TY7bMiH/Q3v/9ncRLB5MLDA5e6IaSDZhu
 xXcF1LFGzpchx+S31TNtc3snXCFkM3F9aBhLHjmVhNP19VsiP1cu+aHpaOUf6Qa3lx8=
X-Gm-Gg: AZuq6aLxfiZawp0U077kVSlMXiYGrkdvwD1xz9s3iY0q3iT5ayriANMTkdX4EAaGfAT
 ZJ8Gy2nrlfCrwF68pn5yM8JfUebmjtQf2gvGThx/Or9srSOTqvmHl2oDdZPvO7TOXBxW98973qm
 dgjmK3ITiKjttPKR/up4zdqF3XoSDEuGJqMHYKQQxdDFkqhlAhrxi052dX9ZJ7JZZjJzCdEDBJc
 6RHGU6SIuhiCzvwtXz+71613eOUA26Ms+osE/frNsnFCPVwup9pShPrddRZ6em4ByKDDwcM/DDA
 C73WjK0UshPfq5p3S+0lLp+pN9bXfi7RjBIZAiaOhHYJPPeEpwU9wduxqIX87RhtPa+GYH7xPOA
 vFtAjpydWZJxpI2ZKAAv3OYgUqXk9FYPzZq29qTdNBYak2gqZydtcM5WPskqwezEi5mzw2kuI8Q
 1SL6wm31O5F5MXQQBBkFDSLst7DLdBYHyMbB6qx13mwlHCdeVOXfuNHzOzMcRQ7ro=
X-Received: by 2002:a05:600c:1f84:b0:47a:814c:eea1 with SMTP id
 5b1f17b1804b1-4804c9cac70mr44736885e9.35.1769163106518; 
 Fri, 23 Jan 2026 02:11:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:7c4d:f1cc:300a:2e42?
 ([2a01:e0a:3d9:2080:7c4d:f1cc:300a:2e42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480470cf1acsm130673305e9.14.2026.01.23.02.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jan 2026 02:11:46 -0800 (PST)
Message-ID: <109c235b-f16f-4cc0-ab9c-aebad653867d@linaro.org>
Date: Fri, 23 Jan 2026 11:11:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/3] mach-snapdragon: of_fixup: Add OP-TEE DT fixup
 support
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org, jens.wiklander@linaro.org, 
 ilias.apalodimas@linaro.org, jorge.ramirez@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, tonyh@qti.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20260122085806.542149-1-sumit.garg@kernel.org>
 <20260122085806.542149-3-sumit.garg@kernel.org>
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
In-Reply-To: <20260122085806.542149-3-sumit.garg@kernel.org>
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

On 1/22/26 09:58, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for OP-TEE live tree DT fixup support which enables U-Boot
> OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
> the live tree fixup to be carried over to the OS for the OP-TEE driver
> in the OS to probe as well.
> 
> Note that this fixup only gets applied if OP-TEE support is detected via
> checking for OP-TEE message UID.
> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 35 +++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 5b6076ea8e5..3d19449f133 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -25,6 +25,7 @@
>   #include <fdt_support.h>
>   #include <linux/errno.h>
>   #include <stdlib.h>
> +#include <tee/optee.h>
>   #include <time.h>
>   
>   /* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
> @@ -164,6 +165,37 @@ static void fixup_power_domains(struct device_node *root)
>   	}
>   }
>   
> +static void add_optee_node(struct device_node *root)
> +{
> +	struct device_node *fw = NULL, *optee = NULL;
> +	int ret;
> +
> +	fw = of_find_node_by_path("/firmware");
> +	if (!fw) {
> +		log_err("Failed to find /firmware node\n");
> +		return;
> +	}
> +
> +	ret = of_add_subnode(fw, "optee", strlen("optee") + 1, &optee);
> +	if (ret) {
> +		log_err("Failed to add 'maximum-speed' property: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = of_write_prop(optee, "compatible", strlen("linaro,optee-tz") + 1,
> +			    "linaro,optee-tz");
> +	if (ret) {
> +		log_err("Failed to optee 'compatible' property: %d\n", ret);
> +		return;
> +	}
> +
> +	ret = of_write_prop(optee, "method", strlen("smc") + 1, "smc");
> +	if (ret) {
> +		log_err("Failed to optee 'method' property: %d\n", ret);
> +		return;
> +	}
> +}
> +
>   #define time_call(func, ...) \
>   	do { \
>   		u64 start = timer_get_us(); \
> @@ -178,6 +210,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>   	time_call(fixup_usb_nodes, root);
>   	time_call(fixup_power_domains, root);
>   
> +	if (is_optee_smc_api())
> +		time_call(add_optee_node, root);

Since is_optee_smc_api only returns false when CONFIG_OPTEE is disabled, the compiler should
drop this, but to help it optimize you should replace with:
	if (IS_ENABLED(CONFIG_OPTEE) && is_optee_smc_api())
		time_call(add_optee_node, root);

Thanks,
Neil

> +
>   	return 0;
>   }
>   

