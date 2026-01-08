Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E938DD1D47D
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 16:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6968384158;
	Thu,  8 Jan 2026 17:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dL5yW9rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C84841C2; Thu,  8 Jan 2026 17:19:37 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4833E84150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 17:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso27993305e9.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 08:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767889175; x=1768493975; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=rC58QxXwlIhAijtWnbmzy/paC7Utfmem4Q0cQcxtkPg=;
 b=dL5yW9rlJms9cD2F+WWrpcZzGw03MAaNDjg+oK4ckxWqZx8gRzb57GaDhTzbersjyo
 g/OrccZtzTNin5nkyMn5lMCNZd+sduycXiFP/YoGVxPsLTuEIloUv0g/9ejMkR5OmKHp
 TCH24yeF/zBF1D1jKuj4s8rJY7jUSqlfICvRg5f3hemMzFhYYtyTaFL07OPTPmOXbLEn
 hVNQF92ylbFZ+xUo2NE93eest0bAFd1y0OAoHFD9n+09awdP6Z/EbHAL68XF+Ic4U31v
 Heuzs1dD79d0mJZUnKNPCWz2TMtyfiiGX714lCzI9Gi3kQasx6gW5YgQwM2Pkt1CYpdJ
 gIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767889175; x=1768493975;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rC58QxXwlIhAijtWnbmzy/paC7Utfmem4Q0cQcxtkPg=;
 b=lqUbsbUVKSdO2t34AYvYY9fTwKlHpqDCByjYwlerDXETY6OFPxmK5K/bjAZ4i9MEMw
 PD71FP3WMprgTfsBdCdOqjwb23OHp8HLTyz1fI/JYAJWYjQy7Yw2xX3g3wm9+NXdarZ3
 ZkMTwYfjTT2Xw2grR6zXBEI/FV2l+tIsAOG0VAMgN6vDiC+O6K5LDnl/nbdqopRQ99he
 XjqsIlNusbG4BYkYbSkJPpdc54UHtGNhCKfw+jabwydNnHK3GdQCVBe5Ip9oVQdRP+Kt
 uNghBIR8sLcAqMQomFGsGwEOhpqJkIFiJtGokDNPxi1NMFCjVrc+UB0NLHFd6FUqEa/V
 sIWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjyVSix+Ra76X0NN0Yto588QP90Sh0VXAZJudbxIo2+TQllYlXUHmvF2TA1C1qutt/XNd12mc=@lists.denx.de
X-Gm-Message-State: AOJu0YwTQZ6fOrrCCgNbgQUEE2PaYZ3ZitIZFZcxCjjbnx8glCrfC3jw
 6jtXHLuTf5w6YcUl0Zkbds/kXo3XWRHqoClzJKbub3Mr6fiC0EE34EmqOFEvnzqJcWo=
X-Gm-Gg: AY/fxX5Rpaw/ULRGr8KhleM4vYHcjJxaAnwigVSgp0qbRLLytYOXc/hNp8u4Z4aHw77
 7xqbzuq7zKSNXD3hmSd5yMtw7vBc/nImo9cLfUU4fPUc65JIn6vbYk/cszNTrRsiym5LcS3TXdG
 iJ+kTVKznNmI3+UIFLOOfNqJKKDtPj4KkPX+ydsJ6dOh3om2kyAzCGiCDQxJp/McZOkgcCB25SZ
 gRnpB/sf26qLkJsKcrK4wxHoRqEuCj6sVGl1HEidDI2Rz/MuttwqS06nb4FtmIhD0uzKqPec6x9
 5RoqK20gQfANI0BXW/EwXUvgewg7YNihgYCBOLiw10NXYgYoV/Bom4CCjueYIaBG3wLOu07OBrL
 tTJBDlW6J+Ix1Y0LgQ3HfscTvSObE1ek18CKfxvCYXRwU9ev090zukBF05Vgogm7YdmghLamFiW
 D2snnnUmFhcIIoTAYbjyexlRY/HqZY8EBvEdonOezs7yjojlpGVI+g0Tz8nKgCyzY=
X-Google-Smtp-Source: AGHT+IGiTkjlX2BiJEJDnK6iTuggu3DA8li+kYx+o4uQZ14r0qQRNv2KAlecMv6fERr60S0Q3qOj2A==
X-Received: by 2002:a05:600c:8506:b0:477:9ce2:a0d8 with SMTP id
 5b1f17b1804b1-47d849bd201mr67774785e9.0.1767889174465; 
 Thu, 08 Jan 2026 08:19:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:2cb0:c864:18bd:9835?
 ([2a01:e0a:3d9:2080:2cb0:c864:18bd:9835])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695225sm160747185e9.4.2026.01.08.08.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 08:19:34 -0800 (PST)
Message-ID: <b60d5ee7-fa27-4dc1-8a09-964912ec5654@linaro.org>
Date: Thu, 8 Jan 2026 17:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] mach-snapdragon: of_fixup: Add OP-TEE DT fixup support
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: trini@konsulko.com, casey.connolly@linaro.org,
 jorge.ramirez@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 tonyh@qti.qualcomm.com, Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20251229114312.668068-1-sumit.garg@kernel.org>
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
In-Reply-To: <20251229114312.668068-1-sumit.garg@kernel.org>
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

On 12/29/25 12:43, Sumit Garg wrote:
> From: Sumit Garg <sumit.garg@oss.qualcomm.com>
> 
> Add support for OP-TEE live tree DT fixup support which enables U-Boot
> OP-TEE driver to be probed. As well as the EFI DT fixup protocol allows
> the live tree fixup to be carried over to the OS for the OP-TEE driver
> in the OS to probe as well.
> 
> Note that this fixup only gets applied if CONFIG_OPTEE gets enabled.

Can't the presence of OP-TEE be detected dynamically via scm calls ?

Thanks,
Neil

> 
> Signed-off-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 34 +++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index eec2c0c757e..29a99f73cf3 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -146,6 +146,37 @@ static void fixup_power_domains(struct device_node *root)
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
> @@ -160,6 +191,9 @@ static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
>   	time_call(fixup_usb_nodes, root);
>   	time_call(fixup_power_domains, root);
>   
> +	if (IS_ENABLED(CONFIG_OPTEE))
> +		time_call(add_optee_node, root);
> +
>   	return 0;
>   }
>   

