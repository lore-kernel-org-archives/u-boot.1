Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CB8C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 08:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC3F688B68;
	Wed, 21 Aug 2024 10:02:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZKz/3iMv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DEA88B68; Wed, 21 Aug 2024 10:02:42 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2E3D88B4C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 10:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-429ec9f2155so45642995e9.2
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 01:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724227360; x=1724832160; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=s8JnGuSDEnY04ywLwpIBxOemHv7QyC8Fv47++SXjJCc=;
 b=ZKz/3iMvMzQRM/YF8J2oru21qDQLchJaFxi1B4ofQ8Cd17Q/eBzjW4pxXBcmwnzyO4
 cRWBNV5txd1Q+2yDqK5kYUpaNyHxREyCSAOeGYHQ308tjXZFvJpLhH7V6bZOGqXkYwr2
 sKnrm/spjkyl1VbIzCyQ3Fzp6rIrl9RHVN19TmpqMkufYgRP505JC4UcijIJZkYMsCmi
 3jipB4J3ku5jT2H3ldNbIwCzYXcaOgtx9qmkn81iteo1KhcsmhJsrEADZ8+j6Y2PFwk9
 EJO4Uwi5F5o8JF6qbgRVaXxcEyX8nGY+6+Jg2h8PjzhuOE1mP6lkLl0yFuR8RGvn0TBH
 t46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724227360; x=1724832160;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=s8JnGuSDEnY04ywLwpIBxOemHv7QyC8Fv47++SXjJCc=;
 b=VeyikrkZDmP5pS4x5Nei0RYJg8fnYpFGbo9b8/P22IbljWexeNJYrDtVc/SEq4Moii
 DttboFTRm5o2DzrkCIwhl/TXLjMohpsSmWdbpKKGts9H3VC95KadPy9NadBiqhRcsSuc
 8ViBqPuz56coE8ugAjqsHXo8Ner5zwIVWnDNpi2iBuzXFZJLQBfjzOo3tqbXw3CzZDBv
 GnokCBOyzoqRdnWH4HtRc0J60bbss/BSW5NJrez7Ucl1R8f37EybSiRLBRLwarWRFUhG
 ebEUPaW1p2NeX2XKxuPQIvtOvfpGCd3b5OnRebYSmVNxceGIGnjaGJUE/97VZKLgVgUj
 rWfw==
X-Gm-Message-State: AOJu0YyBQlzD7awjzDRBbiSlCvf5lALd2J5suGLa4rgoecn2Li5rrCAD
 C042y7npoPoZZvvMkRUrTWh/ejCjMdkjp23ZejKoVQ6EX2nYwyAKWEWVA9O32g4=
X-Google-Smtp-Source: AGHT+IE3QK5aDfV9NnPG86QfeNFltQdUQOAF0O1Z73IsfkMmQNrQjRCUDgHp4vdZM+dgVVqhORo0rQ==
X-Received: by 2002:a05:600c:4692:b0:428:31c:5a52 with SMTP id
 5b1f17b1804b1-42abf096e75mr12365075e9.29.1724227359332; 
 Wed, 21 Aug 2024 01:02:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7dbd:af7f:e8cc:2099?
 ([2a01:e0a:982:cbb0:7dbd:af7f:e8cc:2099])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abed91071sm16341275e9.1.2024.08.21.01.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 01:02:38 -0700 (PDT)
Message-ID: <46107fcd-8080-49cd-bcfb-ccbf813e353d@linaro.org>
Date: Wed, 21 Aug 2024 10:02:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] board/qualcomm: add debug config fragments for some SoCs
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240820230037.1859088-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240820230037.1859088-1-caleb.connolly@linaro.org>
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

On 21/08/2024 01:00, Caleb Connolly wrote:
> We already have some documentation describing how to enable debug UART
> for Qualcomm SoCs. However the UART address varies per-soc... Add some
> config fragments to enable debug UART for few well supported SoCs.
> 
> These can be used like:
> 
> $ make qcom_defconfig debug-sdm845.config
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   board/qualcomm/debug-sdm845.config | 5 +++++
>   board/qualcomm/debug-sm6115.config | 5 +++++
>   board/qualcomm/debug-sm8250.config | 5 +++++
>   3 files changed, 15 insertions(+)
>   create mode 100644 board/qualcomm/debug-sdm845.config
>   create mode 100644 board/qualcomm/debug-sm6115.config
>   create mode 100644 board/qualcomm/debug-sm8250.config
> 
> diff --git a/board/qualcomm/debug-sdm845.config b/board/qualcomm/debug-sdm845.config
> new file mode 100644
> index 000000000000..31ad6d02a3a7
> --- /dev/null
> +++ b/board/qualcomm/debug-sdm845.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xa84000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=7372800
> diff --git a/board/qualcomm/debug-sm6115.config b/board/qualcomm/debug-sm6115.config
> new file mode 100644
> index 000000000000..131c6e230de8
> --- /dev/null
> +++ b/board/qualcomm/debug-sm6115.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x4a90000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> diff --git a/board/qualcomm/debug-sm8250.config b/board/qualcomm/debug-sm8250.config
> new file mode 100644
> index 000000000000..4d3cc4cc97f4
> --- /dev/null
> +++ b/board/qualcomm/debug-sm8250.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xa90000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
