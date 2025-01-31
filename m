Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FD7C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 09:42:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6982D8213D;
	Fri, 31 Jan 2025 10:42:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bcKquKaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30F248213E; Fri, 31 Jan 2025 10:42:12 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11AEE80F70
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 10:42:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-438a3216fc2so17369775e9.1
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738316529; x=1738921329; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yERAbW46KHS71luTIMLlU08C4D4hh3Cmuq+XBHvQ3HU=;
 b=bcKquKaHUiyfu0tP4mBksZunTr3cX2jaClbAF1EJaXHOgSvb96hUvwZUk0k9f+pGf8
 9jxuBiQVDWvCYV3+wL/2gNPtPJfBXeJs2iEDHELA1NgWA/1UdoAX1xyLp422UHh1bbgu
 BdGfLArQqeWOoFvSsHvPZVFLptbTLoa+MIScJZCRZKEvpkIzjy6qa6snOqA+h67tzq7n
 ch4Tcmtzv3CBkDErFylOe/PdDq9NMkNYKpaGai9anQk+NS0jWyCNrl3ix8gGR/alSD08
 wV2ZU+qyes0VcgVsiOljiw3xwzIpLmhVjEUswxJbvo/kffw8W74ffeWEP8hZHIFiWEwh
 Rqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738316529; x=1738921329;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yERAbW46KHS71luTIMLlU08C4D4hh3Cmuq+XBHvQ3HU=;
 b=h/ZsKsPr9OeHuVULC+71EQ3KmWId0WtKhC76QDWrDAN2cQgdQr2j/Sgs4N2INOUGHR
 yvJg0Z13KE2ZZ47fPU9gEmCHZlN2fbWFtUYvk6XELJ8lg3szP+WJ2QBsuzNXN5f+2NfJ
 r4eHIkdMMbhpo/yPhSZQNeJOMKHLnzazENDksaMB/7L6c2mPzkQtNww/o8IWbkUUpcxc
 cwgoatYcYvSkildZveom+GnrM0MVqdCLJGDD7ym536SWMm5LejzyPA1PAmbbwa52eOx1
 rz/vkXRu6ZZTiHCMHMqVAy/A6AnEUFnkipGEJWMfX8jk4VbWzTP3ffSMOd1UcfiDuCQo
 Krkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQIA3mWkMy6X0RCjOfdX8yTlYM5APZFhG3vEgTTcsZB1ejzNGJJvh4QGTPm3uOEDrN52dpoA8=@lists.denx.de
X-Gm-Message-State: AOJu0YywNIITnpcBtVzKXQYWrVdKtJBB0hlj4ZDbe1/3zHVvyRDnu5LM
 1zIa6HqvGDj+ksTqR9fMhVy4vbjeTB2Gf8GLVUrHpKlP0ozZ5wza/5BZfFLApW0=
X-Gm-Gg: ASbGncveL2GbBgH0SNIry4rynKPiTAES9OI+P4I8IH3r6VrXQ8yMAshMBDlq4UQfUmT
 WnI0+aum3/1AGqW2vtzgF/5AXj3dbeaIS9JEBqLjayUy5QzisdEtWSJ7TUoC4w/e/REVFOka9S2
 k+pfRQ99iSl2r9utzF+KxbdQZxAVyEHGN7s9jToaxJvcbeS0mRRXHew/3NlZatqt3ITGxZbe2B5
 2uuQTeZoJ2fSnb3ZZ3nJcUFpEgFBJOps99t36OHnBn4Z41Qn2HlJBupJBdJhpgMp1rDkeDu2lij
 OgyciTzK+1cWSTLFprhzEd/dQNe0C21bSabXq2JhsLs2eRMBpIM1cv24i0BWGrCCJzDD
X-Google-Smtp-Source: AGHT+IHZjeXzQNGiVgC9Cwb/AdN/LuW9XHz0Q3tBpNRLiY/s4EFPR/6IxOwtg3ycP6gcpgCYFIMaxw==
X-Received: by 2002:a05:600c:46cb:b0:438:a20b:6a2a with SMTP id
 5b1f17b1804b1-438dc3c8676mr103243505e9.14.1738316529415; 
 Fri, 31 Jan 2025 01:42:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:384d:e7be:1f71:9414?
 ([2a01:e0a:982:cbb0:384d:e7be:1f71:9414])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1b61f1sm4256012f8f.68.2025.01.31.01.42.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 01:42:08 -0800 (PST)
Message-ID: <67dc34b7-1d5b-4fb4-89de-5fb4085d98bf@linaro.org>
Date: Fri, 31 Jan 2025 10:42:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] rng: msm: don't enable PRNG if it's already enabled
To: Sam Day <me@samcday.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250127-msm-rng-fixes-v1-0-00f5d2284314@samcday.com>
 <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
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
In-Reply-To: <20250127-msm-rng-fixes-v1-2-00f5d2284314@samcday.com>
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

On 27/01/2025 08:49, Sam Day wrote:
> msm_rng_enable is supposed to skip writing to LFSR_CFG + CONFIG
> registers in the PRNG_ block if PRNG_CONFIG_HW_ENABLE is already set.
> The logic to test for this was inverted.
> 
> Without this fix, the driver was causing SError aborts on my MSM8916
> device. Stephan Gerhold suggested this was probably because TZ has
> marked this as a protected register, since it would also be using it for
> RNG.
> 
> Fixes: 033ec636fcb ("rng: Add Qualcomm MSM PRNG driver")
> Signed-off-by: Sam Day <me@samcday.com>
> ---
>   drivers/rng/msm_rng.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
> index f790d3b60f99bfc04ecd9acdd21405a8c38c257a..01505509103f28f7c91dd47edb83c23359163c82 100644
> --- a/drivers/rng/msm_rng.c
> +++ b/drivers/rng/msm_rng.c
> @@ -76,7 +76,7 @@ static int msm_rng_enable(struct msm_rng_priv *priv, int enable)
>   	if (enable) {
>   		/* Enable PRNG only if it is not already enabled */
>   		val = readl_relaxed(priv->base + PRNG_CONFIG);
> -		if (val & PRNG_CONFIG_HW_ENABLE) {
> +		if (!(val & PRNG_CONFIG_HW_ENABLE)) {
>   			val = readl_relaxed(priv->base + PRNG_LFSR_CFG);
>   			val &= ~PRNG_LFSR_CFG_MASK;
>   			val |= PRNG_LFSR_CFG_CLOCKS;
> 

Good catch !

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
