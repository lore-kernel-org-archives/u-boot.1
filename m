Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA07C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:56:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 409F382DBC;
	Fri, 20 Jun 2025 10:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wwLZv6GL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F63C82E28; Fri, 20 Jun 2025 10:56:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9512482D6F
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-450ccda1a6eso14255305e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409798; x=1751014598; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Im9oMgdVNXmNpAwKKEex+oubnbay24Ltk1SnGzjT3ZU=;
 b=wwLZv6GL8JOp0BqQmx3qOB5hSG1KiFSgyO7826UhzXrHjy+Dpvd9BLJLjRKnzwVUE1
 4JgWamAKdMpwmf07thPwFitArZ/HPyKuw8JDYxNaQ6fc3xa7YzdtzU33iPykaVxHzmmi
 meyUf4WYi6BO8pb6tFiwxMW2hQz0isyF0TWPvhPkIeJI30BVYDlfC5y7I8arGt171/dh
 KGN+qxlD8mBPsgoLLWbyoP4GVM/lTyKVvBCrXKhYu98vQjhYTW43pY+EUQdQZJBX0egS
 EhQgVJLjmZ+ebOkKxsPlERKxE+yDwxOosu3hFQ/TWhn6EjK50Bdtc2vy+dzMl91Nobsa
 ZzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409798; x=1751014598;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Im9oMgdVNXmNpAwKKEex+oubnbay24Ltk1SnGzjT3ZU=;
 b=QGsm6wxXvr5Q2C0xrIiKyprWwJDe72olYwIkobBx+ICEefL8tR9iHjozVd9yNNklhM
 rZFXuIfPcdw8ycTW0WMPdFMg5tDzdp+OGifqO9h3VxTLZneH+J5FcyejKnPsLtJN/Bgv
 HfzbkGI2B8wsKRpKTp71XppbOn+Eem7pVrcWYtIaEtjSefCcDH6HqoV26c9Y/P/o1a5y
 u2avHFPndGVi9NLWmHf9lXEDhJ8RT0UopmK56X4Ms2YzMBysBZfF+kd9CCDtFGeg9pa4
 59djYPSNvDZN2tiLBhPPJwG4zORr8fvUxQuGXUhPNBm/WB1piiNIzeI7sVvuAVVtBmew
 OdHA==
X-Gm-Message-State: AOJu0YwSwVnzLqyfmf7bxW6pTrG6CCZizDr4i7Cc3v+MftWbu+cROp41
 fgIjGGqKJS+UH3GumkQ+Ym2OIlwu4g99wHTt+VtCeTbqTuaksX6CkFm/ccpqe63oTr0=
X-Gm-Gg: ASbGncuj4stU+N4jbClEd6MxdJdh/+x0UDMw5slReMQ/jbaRxWQHBXJ0jHRZd+oqhil
 NfIZMDaN/Fy3mRcOa3qFSyfpnGqKCCg0fFvVk8OQwIcvL6gUOalzzihyNvcdVKhH996lkspe++k
 fw3MpAFhgS5lC8Hs179a0USglKogjNlHNKgDE4k2rDwpO/NHDxFmPZeZ9rTfuE9rs1p7WcJsWtV
 RIN1lz32DDkq0ZiorB8bnq8Bu2C3gGwDtS46yErJdIYzaiCP8ezrUi4V+NeD8QrKyi0EPJ/s3nk
 t9gJJCWSOSTthRtn/axfPFcRdaLLdnwk5vWdlCAI+V/3dZ5oB96GSzxD65fEG6OZN+5E8qIhgyi
 eJN8uZxL6fmkQj7li/vpxj0PqURF82Qm1n+7EAjg=
X-Google-Smtp-Source: AGHT+IF3SIMBrAbMaTEM74wD9dhMDS7z1ducWNmG+jvBySbAFtSti2Imvh3WzSkOI7XoaOIZrrr6QA==
X-Received: by 2002:a05:600c:4fc5:b0:453:2066:4a26 with SMTP id
 5b1f17b1804b1-453659ee9famr17537815e9.16.1750409798081; 
 Fri, 20 Jun 2025 01:56:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb692sm18550875e9.2.2025.06.20.01.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:56:37 -0700 (PDT)
Message-ID: <d801eac6-7aff-48ef-b571-d73c0c63807a@linaro.org>
Date: Fri, 20 Jun 2025 10:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 8/8] board/qualcomm: add debug config fragment for SM6350
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-8-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-8-3cc22aab7a7a@fairphone.com>
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

On 18/06/2025 16:25, Luca Weiss wrote:
> Add a fragment similar to others to enable earlycon.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   board/qualcomm/debug-sm6350.config | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/board/qualcomm/debug-sm6350.config b/board/qualcomm/debug-sm6350.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..1379ddeac93f1beb59bdbff4ae9a90b4f0a0af2a
> --- /dev/null
> +++ b/board/qualcomm/debug-sm6350.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x98c000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
