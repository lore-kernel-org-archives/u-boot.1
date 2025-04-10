Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C1BC369A4
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:45:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 248B2839E1;
	Thu, 10 Apr 2025 09:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mza+ktDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B30C8839F0; Thu, 10 Apr 2025 09:45:26 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF0A283995
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso3147305e9.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 00:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744271124; x=1744875924; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JBxhn0lhIET2Q+bX/mJaOnm0kFeoTbGG8/0psLbSCVY=;
 b=mza+ktDxBIVv4Coxf8Ruv4L3/q31sTiewxQUvwlSx24IhtJCKy/gqGKNkUFJqZaRbu
 IFUUan8FFoxwNosfSb8C9J8xUlybyOuaOyBMCmMZHdYYtFqoOk4i+kYkjquSeUzi9TVA
 dbOpehnFaGu0oueVfvHP9y47kvDhrpxa9NgnlROd1Y5LvRZJUbuPS7Rhk0n3hfeHzVXV
 MabKai8uaZocMW0eCsrNnRUz+/igSpMZ3FCp945lJUAzD20v6E2ZaW/KQ/gFL2om0v9t
 hXf6oE+dMiBWbLRpX09hgObNK4BS6ResG+rwySHY2ULxmufEvCnKqSqEvx4TERuQruH8
 TUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744271124; x=1744875924;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JBxhn0lhIET2Q+bX/mJaOnm0kFeoTbGG8/0psLbSCVY=;
 b=tIbOQZwHOC1FAPAhBWiJIwMNhih3+7SgcWdveU3Dovbz21G8f/HkurIronXOOqWiZE
 RYN/XkFUGAwe1R8v9/PmKBi9Vibe8POU2r5sKGXC1BS0bcRve+TUil0Mdsjx2gfL45S7
 xbNPJjCqRJur7laMeQRTlL5trSk4HOS2QdoFUjFZB8/JKT0NHVgW0s77ADrpChU4QBgF
 lfsSfvS5O1mR2RFFu+VjZUtft15cET2wQgvAVxkObq6UcKJxExjvOmrJU3xLEcqrjbgL
 LX6Hqj2z3BevjiY0YJ4CoklV/YElDboeYl/K87JDIigt5sfliDXhtaAr9Xe7qUuIxFF5
 Aamg==
X-Gm-Message-State: AOJu0YymNFDvE4APtGwvTG0o0+C6Sf+rAsQ2SaFZpRRy/40ocCaezF03
 JcR2dSAd6Br4yqcRbT++p+La/e45q4aD4QM4P/I7/UaqHeg29ciUGuN1zZy38yJW1WXyAXvXzWS
 j
X-Gm-Gg: ASbGncund0ZR9tRvjrXTRMP7OvfrmtUbF+WPUjGIGyuOOyA4PxZ9NrPIOwzoLi0vg7S
 RzDi+dW0qQL0TaSozw709OeeYpuwZGxh9+hx2Wafope+qXe2SEDT7NYLwwibhdWAh0TkL/DL4lU
 ST8ftpFGOtBStQu9HFodqXedeoBnbftPR3VJakVJw0trFMtSZ+O2xP37xrGKuDarT1zEySIZrXo
 bIqof3y0Xk5NJd1GETRi1ivgTYo2K6HW5Hq4jrqWrZPW8xwxmZnDu9U33vhKj4+qCM1M0gXdQOU
 BYfY928u0v3qYVUwOVe81mnhcyFMBBYnjYMJJ1QAfeGVJeL1MuAMOD4XPzOb0pxz0yjVrEsAxJi
 0ojE3d4gYnXCa8CO0Hw==
X-Google-Smtp-Source: AGHT+IHG3VdfNIy6ZvK/QTW2W1kCJD4Nc6vbHEVpgp1uaUBlKb5KQzKAYOwoIpljC8wn2G2K3bw/lg==
X-Received: by 2002:a05:600c:4e0a:b0:43d:16a0:d98d with SMTP id
 5b1f17b1804b1-43f2f0c349amr14038965e9.15.1744271124206; 
 Thu, 10 Apr 2025 00:45:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe?
 ([2a01:e0a:3d9:2080:1a13:cd5d:5261:ebfe])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20b2c355sm21680525e9.2.2025.04.10.00.45.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 00:45:23 -0700 (PDT)
Message-ID: <a5f80a99-8f15-41be-82ae-d71b8d96ffe5@linaro.org>
Date: Thu, 10 Apr 2025 09:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 4/6] clk/qcom: qcm2290: show clock name in set_rate()
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-4-76dfea80b07f@linaro.org>
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
In-Reply-To: <20250409-livetree-fixup-v1-4-76dfea80b07f@linaro.org>
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
> The device name is always clk_qcom... Not very useful.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/qcom/clock-qcm2290.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-qcm2290.c b/drivers/clk/qcom/clock-qcm2290.c
> index 1326b770c3ebd723120de4b6657aafac726023d6..fad104fb91aec8917de66b63dd546926c8856011 100644
> --- a/drivers/clk/qcom/clock-qcm2290.c
> +++ b/drivers/clk/qcom/clock-qcm2290.c
> @@ -87,9 +87,9 @@ static ulong qcm2290_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>   	const struct freq_tbl *freq;
>   
> -	debug("%s: clk %s rate %lu\n", __func__, clk->dev->name, rate);
> +	debug("%s: clk %s rate %lu\n", __func__, qcm2290_clks[clk->id].name, rate);
>   
>   	switch (clk->id) {
>   	case GCC_QUPV3_WRAP0_S4_CLK: /*UART2*/
>   		freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
