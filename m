Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E19C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 08:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97AC86D12;
	Mon, 13 Nov 2023 09:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rJftusbt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1AD186D4C; Mon, 13 Nov 2023 09:01:32 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0500186D3F
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 09:01:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so5371306e87.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 00:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699862490; x=1700467290; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FGwVVIf4OlriBWwNKMokuzSiY5LMsuYLfmWJyxfC844=;
 b=rJftusbtZCseCvC7GSBTo9naWNxJxP43DbBbnmkyzvwT62glZDzXnZ4JxSe03O1C/j
 6gjoXf1ftkhOqJZnDBMaA7a7dWKFahubQXXo8aXbfYsPUNO4VEb7A2kXr1kP7YjTGqYf
 hj4DVkjKf5r6RAZYpWPDLQYKrSb3KhQ8E/6KzQ2KABN9EHb+oI9ugy61XyO7rmGGHqo2
 lZmXVIOlY9MWECGF2QVb1eycVNyxKS68JR/iGx5z3FthwlVAjoX1h1vcdTFU+cEg8Wc8
 8vjciYsM72dneWBJUlf83OJh/xjRk0w7flV5LRyMHaJu3pe68lD9t33trUQ4iOQV5oQT
 vGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699862490; x=1700467290;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FGwVVIf4OlriBWwNKMokuzSiY5LMsuYLfmWJyxfC844=;
 b=fW/ROE+cXYMDzg/2gF2aU6sn1cdTIWHxAOektPEPp+STEP8KtIn+8ET9UJkBm54A+m
 e1buEDF0wV9uc1jR4f8B/ScP8MjNrUU7ODaoFPs4ezxcsnCbguiHnhToXQwtPjTdSaEM
 Ipc2kz+5eA244ygoZuStwvYERht86FYsTxMuCNBcWgT2+yeVLRZLmziFUAZ6W9vIjozs
 pT6O5vchUhkxEuAyMjFfhL/oOOJVglq/beSanqiQIqQ+HcMKHzx3W6HCcRjVh2bakkM1
 EWbzviH+osQSrgr0vE11ABKLNLKu8pswTSJr7MosJSBbx7tmURUc69Il03ZJ7XTV0G+O
 oetQ==
X-Gm-Message-State: AOJu0YydZsT3ZV3X9bPsWQT+ZxozqPE7ykdwIwXxVSGszTkNka4phd/Z
 UTtaqW5yV2nsUNEL4UoVgK8H5Q==
X-Google-Smtp-Source: AGHT+IHUFCX3JJIk/J9rRF+IfczEfnQAOfIgGfV9pGlesIPqLOOuvWVPiEgOumdShY4lDqGWH6ZC8A==
X-Received: by 2002:a05:6512:31c8:b0:4fe:279b:8a02 with SMTP id
 j8-20020a05651231c800b004fe279b8a02mr4217575lfe.67.1699862489839; 
 Mon, 13 Nov 2023 00:01:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1bb7:80e:7bf2:f66c?
 ([2a01:e0a:982:cbb0:1bb7:80e:7bf2:f66c])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c350900b004094d4292aesm7123754wmq.18.2023.11.13.00.01.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 00:01:29 -0800 (PST)
Message-ID: <7ef8c47d-d0d2-4655-95dd-8ddf4bb7c63b@linaro.org>
Date: Mon, 13 Nov 2023 09:01:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/9] meson: Use checkboard() instead of show_board_info()
Content-Language: en-US, fr
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: u-boot-amlogic@groups.io
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-3-sjg@chromium.org>
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
In-Reply-To: <20231113030001.240020-3-sjg@chromium.org>
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

On 13/11/2023 03:58, Simon Glass wrote:
> Boards can use a sysinfo driver if a particular model name is needed.
> Update this board to use checkboard() directly, rather than having a
> weak function laid on top of a weak function.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   arch/arm/mach-meson/board-info.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-meson/board-info.c b/arch/arm/mach-meson/board-info.c
> index 2421acd817e4..95a29da07229 100644
> --- a/arch/arm/mach-meson/board-info.c
> +++ b/arch/arm/mach-meson/board-info.c
> @@ -168,7 +168,7 @@ static unsigned int get_socinfo(void)
>   	return socinfo;
>   }
>   
> -int show_board_info(void)
> +int checkboard(void)
>   {
>   	unsigned int socinfo;
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
